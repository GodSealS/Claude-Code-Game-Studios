---
name: handoff
description: "Compact the current conversation into a handoff document so another agent (or a future session) can pick up the work without re-reading the full history."
argument-hint: "What will the next session be used for?"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, AskUserQuestion
---

# Handoff

Write a handoff document summarising the current conversation so a fresh
agent can continue the work without re-reading the full session history.

Do not duplicate content already captured in other artifacts (stories, PRDs,
ADRs, issues, commits, diffs). Reference them by path or URL instead.

---

## Phase 1: Gather Context

Read the current session state from `production/session-state/active.md` if
it exists. Check what was most recently worked on.

If the user passed arguments, treat them as a description of what the next
session will focus on and tailor the doc accordingly.

---

## Phase 2: Write the Handoff Document

Use `AskUserQuestion` to confirm the save location:

- **Prompt**: "Where should I save the handoff document?"
- **Options**:
  - `[A] Yes — save production/session-state/handoff.md (overwrite if exists)`
  - `[B] Specify a different path`
  - `[C] Skip saving — show in conversation only`

If [B], ask for the path. If [C], present the handoff in conversation only.

Write the document:

```markdown
# Handoff: [Project Name] — [date]

## Current State

[What is the current situation — a sprint, feature, bug, or investigation]

## What Was Done

[What was accomplished in this session — reference artifacts by path]

- Feature/story: [path or ID]
- Code changes: [paths, or "none"]
- ADRs/decisions: [references, or "none"]

## What Remains

[What the next session needs to do — specific, actionable items]

- [ ] Task 1 — [details]
- [ ] Task 2 — [details]

## Recommended Skills

[Skills the next agent should consider using, and why]

- `/skill-name` — [reason]
- `/skill-name` — [reason]

## Artifacts

- Story: [path]
- Test: [path]
- Bug report / diagnosis: [path]
- Other: [path]

## Open Questions

[Any unresolved questions or decisions the next session needs to address]
```

---

## Phase 3: Confirm and Update Session State

If the document was saved, silently append to `production/session-state/active.md`:

```
## Session Extract — /handoff [date]
- Handoff saved: [path]
- Focus: [what the next session should tackle]
```

If `active.md` does not exist, create it with this block as the initial content.

Confirm: "Handoff document saved at [path]. Ready for the next session."

---

## Collaborative Protocol

1. **Do not re-capture** — reference existing artifacts instead of copying
   their content
2. **Actionable items only** — no vague "continue work" statements; each
   remaining task must be specific enough for a fresh agent to start
3. **Suggest skills** — recommend specific `/skill` commands the next session
   should run
4. **Ask before writing** — confirm the save path before creating the file

## Verdict

**COMPLETE** — handoff document [saved / presented].
