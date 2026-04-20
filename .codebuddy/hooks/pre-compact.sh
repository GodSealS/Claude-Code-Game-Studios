#!/bin/bash
# CodeBuddy PreCompact hook: Dump session state before context compression
# CodeBuddy PreCompact 钩子: 在上下文压缩前转储会话状态
# This output appears in the conversation right before compaction, ensuring
# 此输出在压缩前立即出现在对话中，确保
# critical state survives the summarization process.
# 关键状态在摘要过程中得以保留。

echo "=== SESSION STATE BEFORE COMPACTION / 压缩前会话状态 ==="
echo "Timestamp / 时间戳: $(date)"

# --- Active session state file ---
# 活跃的会话状态文件
STATE_FILE="production/session-state/active.md"
if [ -f "$STATE_FILE" ]; then
    echo ""
    echo "## Active Session State (from $STATE_FILE) / 活跃会话状态（来自 $STATE_FILE）"
    STATE_LINES=$(wc -l < "$STATE_FILE" 2>/dev/null | tr -d ' ')
    if [ "$STATE_LINES" -gt 100 ] 2>/dev/null; then
        head -n 100 "$STATE_FILE"
        echo "... (truncated / 已截断 — $STATE_LINES total lines / 总行数, showing first 100 / 显示前100行)"
    else
        cat "$STATE_FILE"
    fi
else
    echo ""
    echo "## No active session state file found / 未找到活跃会话状态文件"
    echo "Consider maintaining production/session-state/active.md for better recovery."
    echo "考虑维护 production/session-state/active.md 以获得更好的恢复能力。"
fi

# --- Files modified this session (unstaged + staged + untracked) ---
# 本次会话修改的文件（未暂存 + 已暂存 + 未跟踪）
echo ""
echo "## Files Modified (git working tree) / 修改的文件（git 工作树）"

CHANGED=$(git diff --name-only 2>/dev/null)
STAGED=$(git diff --staged --name-only 2>/dev/null)
UNTRACKED=$(git ls-files --others --exclude-standard 2>/dev/null)

if [ -n "$CHANGED" ]; then
    echo "Unstaged changes / 未暂存的更改:"
    echo "$CHANGED" | while read -r f; do echo "  - $f"; done
fi
if [ -n "$STAGED" ]; then
    echo "Staged changes / 已暂存的更改:"
    echo "$STAGED" | while read -r f; do echo "  - $f"; done
fi
if [ -n "$UNTRACKED" ]; then
    echo "New untracked files / 新的未跟踪文件:"
    echo "$UNTRACKED" | while read -r f; do echo "  - $f"; done
fi
if [ -z "$CHANGED" ] && [ -z "$STAGED" ] && [ -z "$UNTRACKED" ]; then
    echo "  (no uncommitted changes / 没有未提交的更改)"
fi

# --- Work-in-progress design docs ---
# 进行中的设计文档
echo ""
echo "## Design Docs — Work In Progress / 设计文档 — 进行中"

WIP_FOUND=false
for f in design/gdd/*.md; do
    [ -f "$f" ] || continue
    INCOMPLETE=$(grep -n -E "TODO|WIP|PLACEHOLDER|\[TO BE|\[TBD\]" "$f" 2>/dev/null)
    if [ -n "$INCOMPLETE" ]; then
        WIP_FOUND=true
        echo "  $f:"
        echo "$INCOMPLETE" | while read -r line; do echo "    $line"; done
    fi
done

if [ "$WIP_FOUND" = false ]; then
    echo "  (no WIP markers found in design docs / 在设计文档中未找到 WIP 标记)"
fi

# --- Log compaction event ---
# 记录压缩事件
SESSION_LOG_DIR="production/session-logs"
mkdir -p "$SESSION_LOG_DIR" 2>/dev/null
echo "Context compaction occurred at $(date). / 上下文压缩发生于 $(date)。" \
    >> "$SESSION_LOG_DIR/compaction-log.txt" 2>/dev/null

echo ""
echo "## Recovery Instructions / 恢复说明"
echo "After compaction, read $STATE_FILE to recover full working context."
echo "压缩后，读取 $STATE_FILE 以恢复完整工作上下文。"
echo "Then read any files listed above that are being actively worked on."
echo "然后读取上面列出的任何正在积极处理的文件。"
echo "=== END SESSION STATE / 会话状态结束 ==="

exit 0
