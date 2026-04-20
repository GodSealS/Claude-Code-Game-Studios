#!/bin/bash
# CodeBuddy Stop hook: Log session summary when session finishes
# CodeBuddy 停止钩子: 会话结束时记录会话摘要
# Records what was worked on for audit trail and sprint tracking
# 记录完成的工作以用于审计追踪和冲刺跟踪

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SESSION_LOG_DIR="production/session-logs"

mkdir -p "$SESSION_LOG_DIR" 2>/dev/null

# Log recent git activity from this session (check up to 8 hours for long sessions)
# 记录本次会话的最近 git 活动（检查长达 8 小时的长会话）
RECENT_COMMITS=$(git log --oneline --since="8 hours ago" 2>/dev/null)
MODIFIED_FILES=$(git diff --name-only 2>/dev/null)

# --- Archive active session state on shutdown (do NOT delete) ---
# 关机时归档活跃会话状态（不要删除）
# active.md persists across clean exits so multi-session recovery works.
# active.md 在干净退出时持续存在，因此多会话恢复有效。
# It is only valid to delete active.md manually or when explicitly superseded.
# 只有在手动删除或显式替代时，删除 active.md 才有效。
STATE_FILE="production/session-state/active.md"
if [ -f "$STATE_FILE" ]; then
    {
        echo "## Archived Session State / 归档会话状态: $TIMESTAMP"
        cat "$STATE_FILE"
        echo "---"
        echo ""
    } >> "$SESSION_LOG_DIR/session-log.md" 2>/dev/null
fi

if [ -n "$RECENT_COMMITS" ] || [ -n "$MODIFIED_FILES" ]; then
    {
        echo "## Session End / 会话结束: $TIMESTAMP"
        if [ -n "$RECENT_COMMITS" ]; then
            echo "### Commits / 提交"
            echo "$RECENT_COMMITS"
        fi
        if [ -n "$MODIFIED_FILES" ]; then
            echo "### Uncommitted Changes / 未提交的更改"
            echo "$MODIFIED_FILES"
        fi
        echo "---"
        echo ""
    } >> "$SESSION_LOG_DIR/session-log.md" 2>/dev/null
fi

exit 0
