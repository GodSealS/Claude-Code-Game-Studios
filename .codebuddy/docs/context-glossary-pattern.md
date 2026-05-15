# CONTEXT.md — Domain Glossary Pattern

`CONTEXT.md` at the project root is the **shared domain language** for the entire
project. Every agent should read it at the start of a session and use its vocabulary
consistently throughout.

## Why It Exists

Without a shared glossary, agents use 20 words where 1 will do. They invent
inconsistent terms for the same concept across sessions. `CONTEXT.md` solves this
by giving every agent a precise, project-specific vocabulary.

## What It Contains

```markdown
## [Term Name]
[One-sentence definition. Concrete and unambiguous.]

**Relationships**: [Related terms and how they connect]

**Avoid**: [Terms NOT to use for this concept]

**Constraints**: [Any invariants or rules this term carries]

## [Next Term]
...
```

`CONTEXT.md` is **purely a glossary** — no implementation details, no specs,
no scratch notes.

## How Agents Use It

1. **Read on session start** — `CONTEXT.md` is the first doc an agent reads
2. **Use the vocabulary** — in file names, function names, comments, and conversation
3. **Update when terms are resolved** — during grill sessions, design discussions,
   or architecture decisions, update `CONTEXT.md` inline as terms are sharpened
4. **Challenge inconsistencies** — when someone uses a term that conflicts with
   the glossary, call it out immediately

## How It's Created

- Created lazily by `/grill-with-docs` when the first domain term is resolved
- Can also be created manually by running `creative-director` or `game-designer`
  agents to capture the project's core concepts

## Agents That Reference CONTEXT.md

| Agent / Skill | How it uses CONTEXT.md |
|---|---|
| `/grill-with-docs` | Creates and updates it during alignment sessions |
| `/code-review` | Uses vocabulary when identifying module boundaries |
| `/dev-story` | Uses vocabulary in code, function, and variable names |
| `game-designer` | Uses vocabulary in GDD section titles and formula variables |
| `lead-programmer` | Uses vocabulary in API design and module naming |

## Principles

- `CONTEXT.md` must be **totally devoid of implementation details**. It does not
  describe how something is built — only what it IS and how it relates to other concepts.
- Terms should be **concrete and unambiguous**. If a term has more than one valid
  meaning, split it into multiple terms.
- **Fuzzy language is the enemy** — when you catch yourself or the user using
  vague language, propose a precise canonical term and add it to `CONTEXT.md`.
