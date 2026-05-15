---
name: grill-with-docs
description: "Grilling session that challenges your plan against the existing domain model, sharpens terminology, and updates CONTEXT.md and ADRs inline as decisions crystallise. Use when you want to stress-test a plan, align on terminology, or document design decisions before implementing."
argument-hint: "[plan description or topic]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion
---

# Grill With Docs

<what-to-do>

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time, waiting for feedback on each question before continuing.

If a question can be answered by exploring the codebase, explore the codebase instead.

</what-to-do>

## Phase 1 — Explore Existing Documentation

Before starting the interview, check for existing documentation:

- `design/gdd/` — existing game design documents
- `design/pillars.md` — game pillars
- `CONTEXT.md` — domain glossary (create if not exists)

If a `CONTEXT.md` exists, read it to understand the project's shared vocabulary.

## Phase 2 — Domain Awareness

During the interview, also look for and maintain the project's domain language:

### Read existing docs

Check for `CONTEXT.md` at the project root. If it exists, use its vocabulary consistently throughout the session. If it does not exist, create it lazily when the first term is resolved.

### Challenge against the glossary

When the user uses a term that conflicts with existing language in `CONTEXT.md`, call it out immediately: "Your glossary defines 'cancellation' as X, but you seem to mean Y — which is it?"

### Sharpen fuzzy language

When the user uses vague or overloaded terms, propose a precise canonical term: "You're saying 'account' — do you mean the Customer or the User? Those are different things."

### Discuss concrete scenarios

When domain relationships are discussed, stress-test them with specific scenarios that probe edge cases and force precision about boundaries between concepts.

### Cross-reference with code

When the user states how something works, check whether the code agrees. If you find a contradiction, surface it.

## Phase 3 — Update CONTEXT.md Inline

When a term is resolved, update `CONTEXT.md` right there. Do not batch updates — capture them as they happen.

Format for each term:
```markdown
## [Term Name]
[One-sentence definition. Concrete and unambiguous.]

**Relationships**: [Related terms and how they connect]

**Avoid**: [Terms NOT to use for this concept]

**Constraints**: [Any invariants or rules this term carries]
```

`CONTEXT.md` should be totally devoid of implementation details. It is a glossary and nothing else.

When resolving the first term and no `CONTEXT.md` exists, ask: "May I create `CONTEXT.md` to capture this domain vocabulary?"

## Phase 4 — Offer ADRs Sparingly

Only offer to create an ADR when all three are true:

1. **Hard to reverse** — the cost of changing your mind later is meaningful
2. **Surprising without context** — a future reader will wonder "why did they do it this way?"
3. **The result of a real trade-off** — there were genuine alternatives and you picked one for specific reasons

If any of the three is missing, skip the ADR.

ADR format:
```markdown
# ADR-NNNN: [Title]

**Status**: Proposed

**Context**: [What prompted this decision? What constraints or requirements exist?]

**Decision**: [The specific direction chosen]

**Consequences**: [What becomes easier, what becomes harder, what must now change]

**Alternatives Considered**: [What else was considered and why it was rejected]
```

Ask: "May I write this ADR to `docs/architecture/adr-[slug].md`?" before creating any file.

## Phase 5 — Summary

When the session reaches a shared understanding:

- [ ] All design tree branches have been explored
- [ ] Key terms are captured in `CONTEXT.md`
- [ ] Any hard-to-reverse decisions have ADRs (or a note explaining why none is needed)
- [ ] The plan is stated clearly enough for implementation

Verdict: **COMPLETE** — shared understanding reached.

## Recommended Next Steps

- Run `/dev-story [story]` to implement based on the agreed plan
- Run `/create-stories [epic]` to break the plan into implementable stories
- Run `/architecture-decision` to formalize any remaining architectural decisions
