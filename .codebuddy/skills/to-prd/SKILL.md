---
name: to-prd
description: "Turn the current conversation context into a PRD (Product Requirements Document). Synthesises what has already been discussed into a structured document with user stories, implementation and testing decisions, and out-of-scope boundaries. Use when the conversation has explored a feature enough to write it up, or when user says 'write this up as a PRD'."
argument-hint: "[optional reference to the feature being specified]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, AskUserQuestion
---

# To PRD

This skill takes the current conversation context and produces a structured
PRD. Do NOT interview the user — just synthesise what you already know from
the conversation and codebase exploration.

---

## Phase 1: Explore the Codebase

If you have not already explored the relevant parts of the codebase, do so
now to understand current state. Use the project's domain glossary vocabulary
throughout the PRD, and respect any ADRs in the area.

Check what relevant artifacts already exist:
- Story files in `production/epics/`
- GDDs in `design/gdd/`
- ADRs in `docs/architecture/`
- The TR registry in `docs/architecture/tr-registry.yaml`

If a story or design doc already captures parts of this feature, reference
them rather than duplicating. The PRD fills gaps that existing docs do not
cover.

---

## Phase 2: Sketch the Module Boundary

Sketch the major modules that will need to be built or modified. Look for
opportunities to extract deep modules — those that encapsulate a lot of
functionality behind a simple, testable interface.

Present the module sketch to the user:

```
Proposed modules:
1. [Module name] — [purpose, key interface, test seam]
2. [Module name] — [purpose, key interface, test seam]
```

Ask: "Does this module breakdown match your expectations? Which modules
should have tests written for them?"

---

## Phase 3: Write the PRD

Write the PRD and present it to the user using the template below. Do not
publish to an issue tracker — this project uses story files and GDDs for
work tracking. The PRD output lives in conversation or is saved to
`design/prd/` on request.

```markdown
## Problem Statement

What need, problem, or opportunity this PRD addresses. From the user's
perspective.

## Solution

The proposed solution, from the user's perspective.

## User Stories

A numbered list of user stories in the format:

1. As a [actor], I want to [feature], so that [benefit].

Cover all aspects of the feature. Each story should be independently
testable.

## Implementation Decisions

Key decisions about:
- Modules to build or modify
- Interface boundaries
- Technical clarifications
- Architectural patterns
- Schema or data changes
- API contracts

Do NOT include specific file paths or code snippets — they go stale fast.

Exception: if a prototype produced a snippet that encodes a decision more
precisely than prose can (state machine, type shape, reducer), inline it
within the relevant decision and note that it came from a prototype.

## Testing Decisions

- What makes a good test for this feature (behaviour through public
  interfaces, not implementation details)
- Which modules will be tested
- Prior art — similar tests in the existing test suite

## Out of Scope

What this PRD explicitly does NOT cover. This prevents scope creep during
implementation.

## Further Notes

Any additional context, risks, or open questions.
```

---

## Phase 4: Ask for Action

Use `AskUserQuestion`:

- **Prompt**: "PRD drafted based on our conversation. How would you like to handle this?"
- **Options**:
  - `[A] Save to design/prd/[feature-name].md and convert to stories`
  - `[B] Save to design/prd/[feature-name].md for later reference`
  - `[C] Use as-is in conversation — no file needed`
  - `[D] Edit specific sections before saving`

If [A] or [B]: Ask "May I write this to `design/prd/[feature-name].md`?"
If [A] after saving: "The PRD is ready for story creation. Run
`/create-stories [epic-slug]` to break it into implementable stories, or
manually reference it in story files via path."

If [D]: walk through each requested edit, then offer to save.

---

## Collaborative Protocol

1. **No interview** — synthesise from what you already know, do not ask
   exploratory questions
2. **Reference existing docs** — do not duplicate what stories, GDDs, or
   ADRs already capture
3. **No code snippets** — save them for prototype notes or ADRs
4. **User stories are testable** — each must describe observable behaviour
   from a user perspective
5. **Ask before writing** — confirm file paths before saving

## Verdict

**COMPLETE** — PRD [drafted / saved at path].
