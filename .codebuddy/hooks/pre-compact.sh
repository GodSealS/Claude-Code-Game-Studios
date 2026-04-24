#!/bin/bash
# CodeBuddy PreCompact hook: Dump session state before context compression
# CodeBuddy PreCompact钩子：在上下文压缩前转储会话状态
# This output appears in the conversation right before compaction, ensuring
# 此输出出现在压缩前的对话中，确保
# critical state survives the summarization process.
# 关键状态在摘要过程中得以保留。

echo "=== SESSION STATE BEFORE COMPACTION ==="
echo "Timestamp: $(date)"

# --- Active session state file ---
# --- 活动会话状态文件 ---
STATE_FILE="production/session-state/active.md"
if [ -f "$STATE_FILE" ]; then
    echo ""
    echo "## Active Session State (from $STATE_FILE)"
    STATE_LINES=$(wc -l < "$STATE_FILE" 2>/dev/null | tr -d ' ')
    if [ "$STATE_LINES" -gt 100 ] 2>/dev/null; then
        head -n 100 "$STATE_FILE"
        echo "... (truncated — $STATE_LINES total lines, showing first 100)"
    else
        cat "$STATE_FILE"
    fi
else
    echo ""
    echo "## No active session state file found"
    echo "Consider maintaining production/session-state/active.md for better recovery."
fi

# --- Files modified this session (unstaged + staged + untracked) ---
# --- 本次会话中修改的文件（未暂存 + 已暂存 + 未跟踪）---
echo ""
echo "## Files Modified (git working tree)"
echo "## 文件修改情况（git工作树）"

CHANGED=$(git diff --name-only 2>/dev/null)
STAGED=$(git diff --staged --name-only 2>/dev/null)
UNTRACKED=$(git ls-files --others --exclude-standard 2>/dev/null)

if [ -n "$CHANGED" ]; then
    echo "Unstaged changes:"
    echo "$CHANGED" | while read -r f; do echo "  - $f"; done
fi
if [ -n "$STAGED" ]; then
    echo "Staged changes:"
    echo "$STAGED" | while read -r f; do echo "  - $f"; done
fi
if [ -n "$UNTRACKED" ]; then
    echo "New untracked files:"
    echo "$UNTRACKED" | while read -r f; do echo "  - $f"; done
fi
if [ -z "$CHANGED" ] && [ -z "$STAGED" ] && [ -z "$UNTRACKED" ]; then
    echo "  (no uncommitted changes)"
fi

# --- Work-in-progress design docs ---
# --- 进行中的设计文档 ---
echo ""
echo "## Design Docs — Work In Progress"
echo "## 设计文档 — 进行中"

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
    echo "  (no WIP markers found in design docs)"
fi

# --- Log compaction event ---
# --- 记录压缩事件 ---
SESSION_LOG_DIR="production/session-logs"
mkdir -p "$SESSION_LOG_DIR" 2>/dev/null
echo "Context compaction occurred at $(date)." \
    >> "$SESSION_LOG_DIR/compaction-log.txt" 2>/dev/null

echo ""
echo "## Recovery Instructions"
echo "After compaction, read $STATE_FILE to recover full working context."
echo "Then read any files listed above that are being actively worked on."
echo "=== END SESSION STATE ==="

exit 0
