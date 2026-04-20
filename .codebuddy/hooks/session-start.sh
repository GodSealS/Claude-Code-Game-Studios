#!/bin/bash
# CodeBuddy SessionStart hook: Load project context at session start
# CodeBuddy SessionStart 钩子: 在会话开始时加载项目上下文
# Outputs context information that CodeBuddy sees when a session begins
# 输出 CodeBuddy 在会话开始时看到的上下文信息
#
# Input schema (SessionStart): No stdin input
# 输入模式 (SessionStart): 没有标准输入

echo "=== CodeBuddy Game Studios — Session Context / 会话上下文 ==="

# Current branch
# 当前分支
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ -n "$BRANCH" ]; then
    echo "Branch / 分支: $BRANCH"

    # Recent commits
    # 最近提交
    echo ""
    echo "Recent commits / 最近提交:"
    git log --oneline -5 2>/dev/null | while read -r line; do
        echo "  $line"
    done
fi

# Current sprint (find most recent sprint file)
# 当前冲刺（查找最近的冲刺文件）
LATEST_SPRINT=$(ls -t production/sprints/sprint-*.md 2>/dev/null | head -1)
if [ -n "$LATEST_SPRINT" ]; then
    echo ""
    echo "Active sprint / 活跃冲刺: $(basename "$LATEST_SPRINT" .md)"
fi

# Current milestone
# 当前里程碑
LATEST_MILESTONE=$(ls -t production/milestones/*.md 2>/dev/null | head -1)
if [ -n "$LATEST_MILESTONE" ]; then
    echo "Active milestone / 活跃里程碑: $(basename "$LATEST_MILESTONE" .md)"
fi

# Open bug count
# 打开的错误计数
BUG_COUNT=0
for dir in tests/playtest production; do
    if [ -d "$dir" ]; then
        count=$(find "$dir" -name "BUG-*.md" 2>/dev/null | wc -l)
        BUG_COUNT=$((BUG_COUNT + count))
    fi
done
if [ "$BUG_COUNT" -gt 0 ]; then
    echo "Open bugs / 打开的错误: $BUG_COUNT"
fi

# Code health quick check
# 代码健康快速检查
if [ -d "src" ]; then
    TODO_COUNT=$(grep -r "TODO" src/ 2>/dev/null | wc -l)
    FIXME_COUNT=$(grep -r "FIXME" src/ 2>/dev/null | wc -l)
    if [ "$TODO_COUNT" -gt 0 ] || [ "$FIXME_COUNT" -gt 0 ]; then
        echo ""
        echo "Code health / 代码健康: ${TODO_COUNT} TODOs, ${FIXME_COUNT} FIXMEs in src/"
    fi
fi

# --- Active session state recovery ---
# 活跃会话状态恢复
STATE_FILE="production/session-state/active.md"
if [ -f "$STATE_FILE" ]; then
    echo ""
    echo "=== ACTIVE SESSION STATE DETECTED / 检测到活跃会话状态 ==="
    echo "A previous session left state at: $STATE_FILE"
    echo "之前的会话在以下位置留下了状态: $STATE_FILE"
    echo "Read this file to recover context and continue where you left off."
    echo "读取此文件以恢复上下文并继续您离开的地方。"
    echo ""
    echo "Quick summary / 快速摘要:"
    head -20 "$STATE_FILE" 2>/dev/null
    TOTAL_LINES=$(wc -l < "$STATE_FILE" 2>/dev/null)
    if [ "$TOTAL_LINES" -gt 20 ]; then
        echo "  ... ($TOTAL_LINES total lines / 总行数 — read the full file to continue / 读取完整文件以继续)"
    fi
    echo "=== END SESSION STATE PREVIEW / 会话状态预览结束 ==="
fi

echo "==================================="
exit 0
