# Skill Authoring Standards

Reference for creating or improving skills that pass `/skill-test` checks.

## SKILL.md Template

```markdown
---
name: skill-name
description: "[What it does in one sentence]. Use when [specific triggers — keywords, user actions, file types]."
argument-hint: "[argument format or example]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, AskUserQuestion
---

# Skill Name

[One-paragraph overview of what this skill does and when to use it.]

## Phase 1: Parse Argument

[How to handle the argument-hint. If no argument, what to do.]

## Phase 2: [Phase Name]

[Step-by-step process with checklists for complex tasks.]

## Phase N: Verdict

[One-line verdict statement: PASS/FAIL/COMPLETE/BLOCKED/CONCERNS/READY]

## Recommended Next Steps

[/links to related skills for follow-up]
```

## Description Requirements

Every description must include **trigger keywords** so the agent can match it:

Good: "Disciplined debugging loop for hard bugs and performance regressions. Reproduce → minimise → hypothesise → instrument → fix → regression-test. Use when user says 'diagnose', 'debug this', reports a bug/crash/failure, or describes a performance regression."

Bad: "Helps with debugging."

## Required Frontmatter

| Field | Required | Notes |
|---|---|---|
| `name` | Yes | Lowercase-with-hyphens, matches directory name |
| `description` | Yes | Must include "Use when [trigger keywords]" |
| `argument-hint` | Yes | Non-empty if user-invocable |
| `user-invocable` | Yes | `true` for slash commands, `false` for auto-invoke |
| `allowed-tools` | Yes | List of tool permissions needed |

## Progressive Disclosure

If SKILL.md exceeds **100 lines**, split:
- `REFERENCE.md` — detailed reference
- `EXAMPLES.md` — usage examples
- `scripts/` — deterministic utility scripts

## Must-Pass Checks

Before declaring a skill complete, verify:

- [ ] Description includes triggers ("Use when...")
- [ ] 2+ phase headings exist
- [ ] Contains verdict keyword (PASS/FAIL/COMPLETE/BLOCKED/etc.)
- [ ] Contains "May I write" before Write/Edit tool use
- [ ] Contains "Recommended Next Steps" section
- [ ] argument-hint non-empty and matches the skill's Parse Argument section
- [ ] No time-sensitive info (dates, versions)
- [ ] Consistent terminology
- [ ] References go one level deep only (no nested sub-references)
