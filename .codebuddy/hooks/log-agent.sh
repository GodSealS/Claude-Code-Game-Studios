#!/bin/bash
# CodeBuddy SubagentStart hook: Log agent invocations for audit trail
# CodeBuddy SubagentStart钩子：记录代理调用以供审计追踪
# Tracks which agents are being used and when
# 跟踪哪些代理被使用及使用时间
#
# Input schema (SubagentStart) — per CodeBuddy hooks reference:
# 输入模式（SubagentStart）——根据CodeBuddy钩子参考：
# { "session_id": "...", "agent_id": "agent-abc123", "agent_type": "Explore", ... }
#
# The agent name is in `agent_type`, NOT `agent_name`. Reading `.agent_name`
# 代理名称在`agent_type`中，而非`agent_name`中。读取`.agent_name`
# returns null on every invocation, so the fallback "unknown" is always used
# 每次调用都返回null，因此总是使用回退值"unknown"
# and the audit trail captures nothing useful.
# 导致审计追踪无法捕获有用信息。

INPUT=$(cat)

# Parse agent name -- use jq if available, fall back to grep
# 解析代理名称——如果可用则使用jq，否则回退到grep
if command -v jq >/dev/null 2>&1; then
    AGENT_NAME=$(echo "$INPUT" | jq -r '.agent_type // "unknown"' 2>/dev/null)
else
    AGENT_NAME=$(echo "$INPUT" | grep -oE '"agent_type"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/"agent_type"[[:space:]]*:[[:space:]]*"//;s/"$//')
    [ -z "$AGENT_NAME" ] && AGENT_NAME="unknown"
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SESSION_LOG_DIR="production/session-logs"

mkdir -p "$SESSION_LOG_DIR" 2>/dev/null

echo "$TIMESTAMP | Agent invoked: $AGENT_NAME" >> "$SESSION_LOG_DIR/agent-audit.log" 2>/dev/null

exit 0
