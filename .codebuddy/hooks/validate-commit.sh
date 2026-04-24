#!/bin/bash
# CodeBuddy PreToolUse hook: Validates git commit commands
# CodeBuddy PreToolUse钩子：验证git commit命令
# Receives JSON on stdin with tool_input.command
# 通过标准输入接收包含tool_input.command的JSON
# Exit 0 = allow, Exit 2 = block (stderr shown to CodeBuddy)
# 退出0 = 允许，退出2 = 阻止（stderr显示给CodeBuddy）
#
# Input schema (PreToolUse for Bash):
# 输入模式（Bash的PreToolUse）：
# { "tool_name": "Bash", "tool_input": { "command": "git commit -m ..." } }

INPUT=$(cat)

# Parse command -- use jq if available, fall back to grep
# 解析命令——如果可用则使用jq，否则回退到grep
if command -v jq >/dev/null 2>&1; then
    COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
else
    COMMAND=$(echo "$INPUT" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/"command"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi

# Only process git commit commands
# 仅处理git commit命令
if ! echo "$COMMAND" | grep -qE '^git[[:space:]]+commit'; then
    exit 0
fi

# Get staged files
# 获取暂存文件
STAGED=$(git diff --cached --name-only 2>/dev/null)
if [ -z "$STAGED" ]; then
    exit 0
fi

WARNINGS=""

# Check design documents for required sections
# 检查设计文档的必需章节
DESIGN_FILES=$(echo "$STAGED" | grep -E '^design/gdd/')
if [ -n "$DESIGN_FILES" ]; then
    while IFS= read -r file; do
        if [[ "$file" == *.md ]] && [ -f "$file" ]; then
            for section in "Overview" "Player Fantasy" "Detailed" "Formulas" "Edge Cases" "Dependencies" "Tuning Knobs" "Acceptance Criteria"; do
                if ! grep -qi "$section" "$file"; then
                    WARNINGS="$WARNINGS\nDESIGN: $file missing required section: $section"
                fi
            done
        fi
    done <<< "$DESIGN_FILES"
fi

# Validate JSON data files -- block invalid JSON
# 验证JSON数据文件——阻止无效JSON
DATA_FILES=$(echo "$STAGED" | grep -E '^assets/data/.*\.json$')
if [ -n "$DATA_FILES" ]; then
    # Find a working Python command
    PYTHON_CMD=""
    for cmd in python python3 py; do
        if command -v "$cmd" >/dev/null 2>&1; then
            PYTHON_CMD="$cmd"
            break
        fi
    done

    while IFS= read -r file; do
        if [ -f "$file" ]; then
            if [ -n "$PYTHON_CMD" ]; then
                if ! "$PYTHON_CMD" -m json.tool "$file" > /dev/null 2>&1; then
                    echo "BLOCKED: $file is not valid JSON" >&2
                    exit 2
                fi
            else
                echo "WARNING: Cannot validate JSON (python not found): $file" >&2
            fi
        fi
    done <<< "$DATA_FILES"
fi

# Check for hardcoded gameplay values in gameplay code
# 检查游戏逻辑代码中的硬编码游戏值
# Uses grep -E (POSIX extended) instead of grep -P (Perl) for cross-platform compatibility
# 使用grep -E（POSIX扩展）而非grep -P（Perl）以确保跨平台兼容性
CODE_FILES=$(echo "$STAGED" | grep -E '^src/gameplay/')
if [ -n "$CODE_FILES" ]; then
    while IFS= read -r file; do
        if [ -f "$file" ]; then
            if grep -nE '(damage|health|speed|rate|chance|cost|duration)[[:space:]]*[:=][[:space:]]*[0-9]+' "$file" 2>/dev/null; then
                WARNINGS="$WARNINGS\nCODE: $file may contain hardcoded gameplay values. Use data files."
            fi
        fi
    done <<< "$CODE_FILES"
fi

# Check for TODO/FIXME without assignee -- uses grep -E instead of grep -P
# 检查无负责人的TODO/FIXME——使用grep -E而非grep -P
SRC_FILES=$(echo "$STAGED" | grep -E '^src/')
if [ -n "$SRC_FILES" ]; then
    while IFS= read -r file; do
        if [ -f "$file" ]; then
            if grep -nE '(TODO|FIXME|HACK)[^(]' "$file" 2>/dev/null; then
                WARNINGS="$WARNINGS\nSTYLE: $file has TODO/FIXME without owner tag. Use TODO(name) format."
            fi
        fi
    done <<< "$SRC_FILES"
fi

# Print warnings (non-blocking) and allow commit
# 打印警告（非阻塞）并允许提交
if [ -n "$WARNINGS" ]; then
    echo -e "=== Commit Validation Warnings ===$WARNINGS\n================================" >&2
fi

exit 0
