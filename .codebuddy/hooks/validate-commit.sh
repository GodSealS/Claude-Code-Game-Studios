#!/bin/bash
# CodeBuddy PreToolUse hook: Validates git commit commands
# CodeBuddy PreToolUse 钩子: 验证 git commit 命令
# Receives JSON on stdin with tool_input.command
# 接收标准输入上的 JSON，包含 tool_input.command
# Exit 0 = allow, Exit 2 = block (stderr shown to CodeBuddy)
# 退出 0 = 允许，退出 2 = 阻止（标准错误显示给 CodeBuddy）
#
# Input schema (PreToolUse for Bash):
# 输入模式 (PreToolUse for Bash):
# { "tool_name": "Bash", "tool_input": { "command": "git commit -m ..." } }

INPUT=$(cat)

# Parse command -- use jq if available, fall back to grep
# 解析命令 -- 如果可用则使用 jq，否则回退到 grep
if command -v jq >/dev/null 2>&1; then
    COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
else
    COMMAND=$(echo "$INPUT" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/"command"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi

# Only process git commit commands
# 仅处理 git commit 命令
if ! echo "$COMMAND" | grep -qE '^git[[:space:]]+commit'; then
    exit 0
fi

# Get staged files
# 获取已暂存文件
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
                    WARNINGS="$WARNINGS\nDESIGN / 设计: $file missing required section: $section"
                    WARNINGS="$WARNINGS\n缺少必需章节: $section"
                fi
            done
        fi
    done <<< "$DESIGN_FILES"
fi

# Validate JSON data files -- block invalid JSON
# 验证 JSON 数据文件 -- 阻止无效的 JSON
DATA_FILES=$(echo "$STAGED" | grep -E '^assets/data/.*\.json$')
if [ -n "$DATA_FILES" ]; then
    # Find a working Python command
    # 查找可用的 Python 命令
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
                    echo "BLOCKED / 已阻止: $file is not valid JSON / 不是有效的 JSON" >&2
                    exit 2
                fi
            else
                echo "WARNING / 警告: Cannot validate JSON (python not found): $file" >&2
            fi
        fi
    done <<< "$DATA_FILES"
fi

# Check for hardcoded gameplay values in gameplay code
# 检查游戏代码中的硬编码游戏值
# Uses grep -E (POSIX extended) instead of grep -P (Perl) for cross-platform compatibility
# 使用 grep -E (POSIX 扩展) 而非 grep -P (Perl) 以兼容跨平台
CODE_FILES=$(echo "$STAGED" | grep -E '^src/gameplay/')
if [ -n "$CODE_FILES" ]; then
    while IFS= read -r file; do
        if [ -f "$file" ]; then
            if grep -nE '(damage|health|speed|rate|chance|cost|duration)[[:space:]]*[:=][[:space:]]*[0-9]+' "$file" 2>/dev/null; then
                WARNINGS="$WARNINGS\nCODE / 代码: $file may contain hardcoded gameplay values. Use data files."
                WARNINGS="$WARNINGS\n可能包含硬编码的游戏值。请使用数据文件。"
            fi
        fi
    done <<< "$CODE_FILES"
fi

# Check for TODO/FIXME without assignee -- uses grep -E instead of grep -P
# 检查没有负责人的 TODO/FIXME -- 使用 grep -E 而非 grep -P
SRC_FILES=$(echo "$STAGED" | grep -E '^src/')
if [ -n "$SRC_FILES" ]; then
    while IFS= read -r file; do
        if [ -f "$file" ]; then
            if grep -nE '(TODO|FIXME|HACK)[^(]' "$file" 2>/dev/null; then
                WARNINGS="$WARNINGS\nSTYLE / 样式: $file has TODO/FIXME without owner tag. Use TODO(name) format."
                WARNINGS="$WARNINGS\n有 TODO/FIXME 但没有负责人标签。请使用 TODO(name) 格式。"
            fi
        fi
    done <<< "$SRC_FILES"
fi

# Print warnings (non-blocking) and allow commit
# 打印警告（非阻塞）并允许提交
if [ -n "$WARNINGS" ]; then
    echo -e "=== Commit Validation Warnings / 提交验证警告 ===$WARNINGS\n================================" >&2
fi

exit 0
