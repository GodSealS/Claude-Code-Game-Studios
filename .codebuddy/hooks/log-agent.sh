#!/bin/bash
# CodeBuddy SubagentStart hook: Log agent invocations for audit trail
# CodeBuddy 子代理启动钩子: 记录代理调用以用于审计追踪
# Tracks which agents are being used and when
# 追踪哪些代理正在被使用以及何时使用
#
# Input schema (SubagentStart) — per CodeBuddy hooks reference:
# 输入模式 (SubagentStart) — 根据 CodeBuddy 钩子参考:
# { "session_id": "...", "agent_id": "agent-abc123", "agent_type": "Explore", ... }
#
# The agent name is in `agent_type`, NOT `agent_name`. Reading `.agent_name`
# 代理名称在 `agent_type` 中，而非 `agent_name`。读取 `.agent_name`
# returns null on every invocation, so the fallback "unknown" is always used
# 在每次调用时返回 null，因此总是使用回退值 "unknown"
# and the audit trail captures nothing useful.
# 导致审计追踪没有捕获任何有用的信息。

INPUT=$(cat)

# Parse agent name -- use jq if available, fall back to grep
# 解析代理名称 -- 如果可用则使用 jq，否则回退到 grep
if command -v jq >/dev/null 2>&1; then
    AGENT_NAME=$(echo "$INPUT" | jq -r '.agent_type // "unknown"' 2>/dev/null)
else
    AGENT_NAME=$(echo "$INPUT" | grep -oE '"agent_type"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/"agent_type"[[:space:]]*:[[:space:]]*"//;s/"$//')
    [ -z "$AGENT_NAME" ] && AGENT_NAME="unknown"
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SESSION_LOG_DIR="production/session-logs"

mkdir -p "$SESSION_LOG_DIR" 2>/dev/null

echo "$TIMESTAMP | Agent invoked / 代理调用: $AGENT_NAME" >> "$SESSION_LOG_DIR/agent-audit.log" 2>/dev/null

exit 0
