---
name: handoff
description: "Compact the current conversation into a handoff document for another agent to pick up. References existing artifacts (PRDs, plans, ADRs, commits) instead of duplicating them."
argument-hint: "What will the next session be used for? [optional description]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit
---

# Handoff

Write a handoff document summarising the current conversation so a fresh agent can continue the work.

## Phase 1 — Gather Context

Read `production/session-state/active.md` if it exists — capture current task, progress, blockers.

Read the conversation context and identify:
- Completed work (files changed, decisions made)
- Current task and its status
- Open questions or blockers
- Key architectural decisions made during this session

## Phase 2 — Write the Handoff

Save to `production/session-logs/handoff-YYYYMMDD-HHMM.md` (create directory if needed).

Include:
- **Context**: What was being worked on and why
- **Completed**: Files changed, decisions made, tests passed
- **Current state**: What's in progress, what's blocked
- **Next steps**: What the next agent should do, in priority order
- **Skills to use**: Suggest relevant slash commands (e.g., `/dev-story`, `/code-review`)
- **References**: Paths to PRDs, ADRs, issues, commits — do NOT duplicate content captured elsewhere

Do NOT duplicate content already captured in other artifacts. Reference them by path.

## Phase 3 — Update Session State

Append to `production/session-state/active.md`:
```
## Session Extract — /handoff [date]
- Handoff written to: production/session-logs/handoff-YYYYMMDD-HHMM.md
- Current task: [task description]
- Blockers: [None or description]
```

Ask: "May I write this handoff to `production/session-logs/handoff-YYYYMMDD-HHMM.md`?"

Verdict: **COMPLETE** — handoff document written.

## Recommended Next Steps

- Start a new session and the other agent can run `/help` or read the handoff directly
- Continue in this session: run `/dev-story` or `/code-review` on the next task
