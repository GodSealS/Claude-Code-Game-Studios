#!/bin/bash
# CodeBuddy Stop hook: Log session summary when session finishes
# CodeBuddy Stop钩子：在会话结束时记录会话摘要
# Records what was worked on for audit trail and sprint tracking
# 记录工作内容以供审计追踪和冲刺跟踪

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SESSION_LOG_DIR="production/session-logs"

mkdir -p "$SESSION_LOG_DIR" 2>/dev/null

# Log recent git activity from this session (check up to 8 hours for long sessions)
# 记录本次会话的最近git活动（长会话检查最长8小时）
RECENT_COMMITS=$(git log --oneline --since="8 hours ago" 2>/dev/null)
MODIFIED_FILES=$(git diff --name-only 2>/dev/null)

# --- Archive active session state on shutdown (do NOT delete) ---
# --- 在关闭时归档活动会话状态（请勿删除）---
# active.md persists across clean exits so multi-session recovery works.
# active.md在干净退出后持续存在，以便多会话恢复工作。
# It is only valid to delete active.md manually or when explicitly superseded.
# 仅在手动或明确被取代时删除active.md才有效。
STATE_FILE="production/session-state/active.md"
if [ -f "$STATE_FILE" ]; then
    {
        echo "## Archived Session State: $TIMESTAMP"
        cat "$STATE_FILE"
        echo "---"
        echo ""
    } >> "$SESSION_LOG_DIR/session-log.md" 2>/dev/null
fi

if [ -n "$RECENT_COMMITS" ] || [ -n "$MODIFIED_FILES" ]; then
    {
        echo "## Session End: $TIMESTAMP"
        if [ -n "$RECENT_COMMITS" ]; then
            echo "### Commits"
            echo "$RECENT_COMMITS"
        fi
        if [ -n "$MODIFIED_FILES" ]; then
            echo "### Uncommitted Changes"
            echo "$MODIFIED_FILES"
        fi
        echo "---"
        echo ""
    } >> "$SESSION_LOG_DIR/session-log.md" 2>/dev/null
fi

exit 0
