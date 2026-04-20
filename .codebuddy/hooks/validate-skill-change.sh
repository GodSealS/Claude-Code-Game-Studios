#!/bin/bash
# CodeBuddy PostToolUse hook: Advises running skill-test after skill file changes
# CodeBuddy PostToolUse 钩子: 建议在技能文件更改后运行 skill-test
# Fires when any file inside .codebuddy/skills/ is written or edited.
# 当 .codebuddy/skills/ 中的任何文件被写入或编辑时触发。
#
# Exit behavior:
# 退出行为:
#   exit 0 = advisory only (non-blocking)
#   exit 0 = 仅建议（非阻塞）
#
# Input schema (PostToolUse for Write|Edit):
# 输入模式 (PostToolUse for Write|Edit):
# { "tool_name": "Write", "tool_input": { "file_path": "...", "content": "..." } }

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

# Only act on files inside .codebuddy/skills/
# 仅对 .codebuddy/skills/ 内的文件执行操作
if ! echo "$FILE_PATH" | grep -qE '(^|/)\.codebuddy/skills/'; then
    exit 0
fi

# Extract skill name from path (.codebuddy/skills/[skill-name]/SKILL.md)
# 从路径提取技能名称 (.codebuddy/skills/[skill-name]/SKILL.md)
SKILL_NAME=$(echo "$FILE_PATH" | grep -oE '\.codebuddy/skills/[^/]+' | sed 's|\.codebuddy/skills/||')

if [ -z "$SKILL_NAME" ]; then
    exit 0
fi

echo "=== Skill Modified / 技能已修改: $SKILL_NAME ===" >&2
echo "Run /skill-test static $SKILL_NAME to validate structural compliance." >&2
echo "运行 /skill-test static $SKILL_NAME 以验证结构合规性。" >&2
echo "====================================" >&2

exit 0
