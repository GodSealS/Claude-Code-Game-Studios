---
name: zoom-out
description: "Tell the agent to zoom out and give broader context or a higher-level perspective. Use when you are unfamiliar with a section of code and need to understand how it fits into the bigger picture."
argument-hint: "[path-to-file-or-module]"
user-invocable: true
allowed-tools: Read, Glob, Grep
---

I don't know this area of code well. Go up a layer of abstraction. Give me a
map of all the relevant modules and callers, using the project's domain
glossary vocabulary from `CLAUDE.md` or `CONTEXT.md` if they exist.

Read the file at the provided path (if any), then:

1. Identify the module's role in the broader system — what does it provide,
   what does it depend on?
2. Map the callers — who calls this module, and in what context?
3. Map the callees — what does this module depend on, and for what purpose?
4. Identify the architectural layer it belongs to (engine, gameplay, UI,
   tools, data).
5. Note any relevant ADRs that constrain this module's design.

Present a concise, structured overview:

```
## Zoom Out: [Module Name]

**Layer**: [engine / gameplay / UI / tools / data]

**Role in system**: [one-sentence description]

**Callers**:
- [caller A] — [purpose of the call]
- [caller B] — [purpose of the call]

**Dependencies**:
- [dependency A] — [what it provides]
- [dependency B] — [what it provides]

**Governing ADRs**:
- ADR-NNN: [brief summary of relevant constraint]

**Key observations**:
- [architectural note, coupling concern, or design intention]
```

This skill is read-only — no files are written.
