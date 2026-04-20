#!/bin/bash
# CodeBuddy PostToolUse hook: Validates asset files after Write/Edit
# CodeBuddy PostToolUse 钩子: 在写入/编辑后验证资源文件
# Checks naming conventions for files in assets/ directory
# 检查 assets/ 目录中文件的命名约定
#
# Exit behavior:
# 退出行为:
#   exit 0 = success or advisory warnings only (non-blocking)
#   exit 0 = 成功或仅警告（非阻塞）
#   exit 1 = blocking error (build-breaking issues: invalid JSON, missing required fields)
#   exit 1 = 阻塞错误（构建中断问题：无效 JSON、缺少必填字段）
#
# Input schema (PostToolUse for Write/Edit):
# 输入模式 (PostToolUse for Write/Edit):
# { "tool_name": "Write", "tool_input": { "file_path": "assets/data/foo.json", "content": "..." } }

INPUT=$(cat)

# Parse file path -- use jq if available, fall back to grep
# 解析文件路径 -- 如果可用则使用 jq，否则回退到 grep
if command -v jq >/dev/null 2>&1; then
    FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
else
    FILE_PATH=$(echo "$INPUT" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/"file_path"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi

# Normalize path separators (Windows backslash to forward slash)
# 规范化路径分隔符（Windows 反斜杠转换为正斜杠）
FILE_PATH=$(echo "$FILE_PATH" | sed 's|\\|/|g')

# Only check files in assets/
# 仅检查 assets/ 中的文件
if ! echo "$FILE_PATH" | grep -qE '(^|/)assets/'; then
    exit 0
fi

FILENAME=$(basename "$FILE_PATH")
WARNINGS=""   # Style/convention issues -- exit 0 with advisory message
              # 样式/约定问题 -- 以建议消息退出 0
ERRORS=""     # Build-breaking issues -- exit 1 to block the operation
              # 构建中断问题 -- 退出 1 以阻止操作

# ADVISORY: Check naming convention (lowercase with underscores only)
# 建议: 检查命名约定（仅小写和下划线）
# Naming issues are style violations -- warn but do not block
# 命名问题是样式违规 -- 警告但不阻止
# Uses grep -E (POSIX) not grep -P (Perl) for Windows Git Bash compatibility
# 使用 grep -E (POSIX) 而非 grep -P (Perl) 以兼容 Windows Git Bash
if echo "$FILENAME" | grep -qE '[A-Z[:space:]-]'; then
    WARNINGS="$WARNINGS\n  NAMING / 命名: $FILE_PATH must be lowercase with underscores (got: $FILENAME)"
    WARNINGS="$WARNINGS\n  必须使用小写和下划线（得到: $FILENAME）"
fi

# BLOCKING: Check JSON validity for data files
# 阻塞: 检查数据文件的 JSON 有效性
# Invalid JSON will break runtime loading -- this is a build-breaking error
# 无效的 JSON 将破坏运行时加载 -- 这是构建中断错误
if echo "$FILE_PATH" | grep -qE '(^|/)assets/data/.*\.json$'; then
    if [ -f "$FILE_PATH" ]; then
        # Find a working Python command
        # 查找可用的 Python 命令
        PYTHON_CMD=""
        for cmd in python python3 py; do
            if command -v "$cmd" >/dev/null 2>&1; then
                PYTHON_CMD="$cmd"
                break
            fi
        done

        if [ -n "$PYTHON_CMD" ]; then
            if ! "$PYTHON_CMD" -m json.tool "$FILE_PATH" > /dev/null 2>&1; then
                ERRORS="$ERRORS\n  FORMAT / 格式: $FILE_PATH is not valid JSON — fix syntax errors before continuing"
                ERRORS="$ERRORS\n  不是有效的 JSON — 在继续前修复语法错误"
            fi
        fi
    fi
fi

# Report warnings (advisory -- non-blocking)
# 报告警告（建议 -- 非阻塞）
if [ -n "$WARNINGS" ]; then
    echo -e "=== Asset Validation: Warnings / 资源验证：警告 ===$WARNINGS\n==================================\n(Warnings are advisory. Fix before final commit. / 警告是建议性的。在最终提交前修复。)" >&2
fi

# Report errors and block if any build-breaking issues found
# 报告错误并在发现任何构建中断问题时阻止
if [ -n "$ERRORS" ]; then
    echo -e "=== Asset Validation: ERRORS (Blocking) / 资源验证：错误（阻塞） ===$ERRORS\n===========================================\nFix these errors before proceeding. / 在继续前修复这些错误。" >&2
    exit 1
fi

exit 0
