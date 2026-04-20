#!/usr/bin/env bash
# post-compact.sh — fires after conversation compaction
# post-compact.sh — 在对话压缩后触发
# Reminds CodeBuddy to restore session state from the file-backed checkpoint.
# 提醒 CodeBuddy 从文件支持的检查点恢复会话状态。

ACTIVE="production/session-state/active.md"

echo "=== Context Restored After Compaction / 压缩后恢复上下文 ==="

if [ -f "$ACTIVE" ]; then
  SIZE=$(wc -l < "$ACTIVE" 2>/dev/null || echo "?")
  echo "Session state file exists / 会话状态文件存在: $ACTIVE ($SIZE lines / 行)"
  echo "IMPORTANT / 重要: Read this file now to restore your working context."
  echo "立即读取此文件以恢复您的工作上下文。"
  echo "It contains: current task, decisions made, files in progress, open questions."
  echo "它包含：当前任务、已做出的决策、正在进行的文件、未解决的问题。"
else
  echo "No session state file found at $ACTIVE"
  echo "在 $ACTIVE 未找到会话状态文件"
  echo "If you were mid-task, check production/session-logs/ for the last session audit."
  echo "如果您正在执行任务中，请检查 production/session-logs/ 获取上次会话审计。"
fi

echo "========================================="
