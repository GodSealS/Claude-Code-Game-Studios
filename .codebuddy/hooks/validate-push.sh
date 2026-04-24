#!/bin/bash
# CodeBuddy PreToolUse hook: Validates git push commands
# CodeBuddy PreToolUse钩子：验证git push命令
# Warns on pushes to protected branches
# 在推送到受保护分支时警告
# Exit 0 = allow, Exit 2 = block
# 退出0 = 允许，退出2 = 阻止
#
# Input schema (PreToolUse for Bash):
# 输入模式（Bash的PreToolUse）：
# { "tool_name": "Bash", "tool_input": { "command": "git push origin main" } }

INPUT=$(cat)

# Parse command -- use jq if available, fall back to grep
# 解析命令——如果可用则使用jq，否则回退到grep
if command -v jq >/dev/null 2>&1; then
    COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
else
    COMMAND=$(echo "$INPUT" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/"command"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi

# Only process git push commands
# 仅处理git push命令
if ! echo "$COMMAND" | grep -qE '^git[[:space:]]+push'; then
    exit 0
fi

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
MATCHED_BRANCH=""

# Check if pushing to a protected branch
# 检查是否推送到受保护分支
for branch in develop main master; do
    if [ "$CURRENT_BRANCH" = "$branch" ]; then
        MATCHED_BRANCH="$branch"
        break
    fi
    # Also check if pushing to a protected branch explicitly (quote branch name for safety)
    # 同时检查是否显式推送到受保护分支（为安全起见引用分支名称）
    if echo "$COMMAND" | grep -qE "[[:space:]]${branch}([[:space:]]|$)"; then
        MATCHED_BRANCH="$branch"
        break
    fi
done

if [ -n "$MATCHED_BRANCH" ]; then
    echo "Push to protected branch '$MATCHED_BRANCH' detected." >&2
    echo "Reminder: Ensure build passes, unit tests pass, and no S1/S2 bugs exist." >&2
    # Allow the push but warn -- uncomment below to block instead:
    # echo "BLOCKED: Run tests before pushing to $CURRENT_BRANCH" >&2
    # exit 2
fi

exit 0
