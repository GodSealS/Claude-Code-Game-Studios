#!/bin/bash
# CodeBuddy PostToolUse hook: Validates asset files after Write/Edit
# CodeBuddy PostToolUse钩子：在Write/Edit操作后验证资产文件
# Checks naming conventions for files in assets/ directory
# 检查assets/目录中文件的命名规范
#
# Exit behavior:
# 退出行为：
#   exit 0 = success or advisory warnings only (non-blocking)
#   exit 0 = 成功或仅建议性警告（非阻塞）
#   exit 1 = blocking error (build-breaking issues: invalid JSON, missing required fields)
#   exit 1 = 阻塞性错误（导致构建失败的问题：无效JSON、缺少必需字段）
#
# Input schema (PostToolUse for Write/Edit):
# 输入模式（Write/Edit的PostToolUse）：
# { "tool_name": "Write", "tool_input": { "file_path": "assets/data/foo.json", "content": "..." } }

INPUT=$(cat)

# Parse file path -- use jq if available, fall back to grep
# 解析文件路径——如果可用则使用jq，否则回退到grep
if command -v jq >/dev/null 2>&1; then
    FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
else
    FILE_PATH=$(echo "$INPUT" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/"file_path"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi

# Normalize path separators (Windows backslash to forward slash)
# 规范化路径分隔符（将Windows反斜杠转换为正斜杠）
FILE_PATH=$(echo "$FILE_PATH" | sed 's|\\|/|g')

# Only check files in assets/
# 仅检查assets/目录中的文件
if ! echo "$FILE_PATH" | grep -qE '(^|/)assets/'; then
    exit 0
fi

FILENAME=$(basename "$FILE_PATH")
WARNINGS=""   # Style/convention issues -- exit 0 with advisory message
ERRORS=""     # Build-breaking issues -- exit 1 to block the operation

# ADVISORY: Check naming convention (lowercase with underscores only)
# [建议]：检查命名规范（仅允许小写字母和下划线）
# Naming issues are style violations -- warn but do not block
# 命名问题是风格违规——仅警告，不阻止
# Uses grep -E (POSIX) not grep -P (Perl) for Windows Git Bash compatibility
# 使用grep -E（POSIX）而非grep -P（Perl）以确保Windows Git Bash兼容性
if echo "$FILENAME" | grep -qE '[A-Z[:space:]-]'; then
    WARNINGS="$WARNINGS\n  NAMING: $FILE_PATH must be lowercase with underscores (got: $FILENAME)"
fi

# BLOCKING: Check JSON validity for data files
# [阻塞性]：检查数据文件的JSON有效性
# Invalid JSON will break runtime loading -- this is a build-breaking error
# 无效JSON将破坏运行时加载——这是导致构建失败的错误
if echo "$FILE_PATH" | grep -qE '(^|/)assets/data/.*\.json$'; then
    if [ -f "$FILE_PATH" ]; then
        # Find a working Python command
        PYTHON_CMD=""
        for cmd in python python3 py; do
            if command -v "$cmd" >/dev/null 2>&1; then
                PYTHON_CMD="$cmd"
                break
            fi
        done

        if [ -n "$PYTHON_CMD" ]; then
            if ! "$PYTHON_CMD" -m json.tool "$FILE_PATH" > /dev/null 2>&1; then
                ERRORS="$ERRORS\n  FORMAT: $FILE_PATH is not valid JSON — fix syntax errors before continuing"
            fi
        fi
    fi
fi

# Report warnings (advisory -- non-blocking)
# 报告警告（建议性——非阻塞）
if [ -n "$WARNINGS" ]; then
    echo -e "=== Asset Validation: Warnings ===$WARNINGS\n==================================\n(Warnings are advisory. Fix before final commit.)" >&2
fi

# Report errors and block if any build-breaking issues found
# 报告错误并在发现构建失败问题时阻止
if [ -n "$ERRORS" ]; then
    echo -e "=== Asset Validation: ERRORS (Blocking) ===$ERRORS\n===========================================\nFix these errors before proceeding." >&2
    exit 1
fi

exit 0
