---
name: tdd
description: "Test-driven development with red-green-refactor loop. Builds features or fixes bugs one vertical slice at a time. Use when user explicitly asks for TDD, mentions 'red-green-refactor', wants to write tests first, or requests a disciplined test-first workflow."
argument-hint: "[story-path | description of feature to build]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Bash, Task, AskUserQuestion
---

# Test-Driven Development (TDD)

A red-green-refactor discipline for building features or fixing bugs with
tight feedback. Each cycle writes one failing test, then the minimal code to
pass it, then refactors — never all tests first, never all code first.

**When to use:** /tdd is an alternative to /dev-story for implementers who
want test-first discipline. It works with any story, bug, or feature request.
After completion, route through the standard verification loop:
`/code-review` → `/story-done`.

---

## Phase 1: Gather Context

**If a story path is provided**: read the story file in full. Extract:
- Acceptance criteria (every checkbox item, verbatim)
- GDD requirement reference (TR-ID)
- Governing ADR reference
- Out of Scope boundaries
- Test Evidence path (the required test file location)
- Layer and type (Logic / Integration / Visual/Feel / UI / Config/Data)

**If a plain description is provided** (no story path): ask the user to
confirm the scope before proceeding:
- "You want TDD for: [parsed description]. Is that correct?"
- If yes, proceed with the description as the spec.
- If no, ask for clarification.

Read the project's domain glossary from `CODEBUDDY.md` or `CONTEXT.md` at the
project root if they exist. Use domain vocabulary in test names and interface
design.

Read `.codebuddy/docs/technical-preferences.md` for naming conventions and
performance budgets.

**Verdict check**: If the scope is undefined or the user's description is
vague, do not proceed. Ask for a clearer description or a story file path.

---

## Phase 2: Plan the First Cycle

Before writing any code:

- [ ] Confirm with user what the first test should validate — the simplest
  observable behavior (the "tracer bullet")
- [ ] Identify the public interface the test will exercise — design it for
  testability, not convenience
- [ ] Check ADRs in the area for interface and approach guidance
- [ ] Look for existing test helpers in `tests/helpers/` that can reduce
  boilerplate

Ask: "The first test will validate [behavior X] through interface [Y]. Does
that match your priority?"

**You can't test everything.** Focus testing effort on critical paths,
complex logic, and edge cases from the acceptance criteria. Not every
possible combination.

---

## Phase 3: Tracer Bullet (One Test)

Write ONE test that confirms ONE thing about the system:

```
RED:   Write test for first behavior → test fails
GREEN: Write minimal code to pass → test passes
```

- The test must use the public interface only (no internal mocks, no private
  method access)
- The test must describe observable behavior, not implementation structure
- The implementation must be the minimal code needed to pass this single test
- Do not anticipate future tests — write only what this test requires

**Test file location**: Use the Test Evidence path from the story (if one was
provided), or place under `tests/unit/[system]/` following the project
naming convention: `[system]_[feature]_test.[ext]`.

If the test passes without writing any implementation code, the test is not
testing real behavior — discard it and write a better one.

---

## Phase 4: Incremental Loop

For each remaining behavior (acceptance criterion or edge case):

```
RED:   Write next test → fails
GREEN: Minimal code to pass → passes
```

Rules:
- One test at a time — never batch tests
- Only enough code to pass the current test
- Do not anticipate future tests or requirements
- Each test stays focused on observable behavior through the public interface
- No random seeds, no time-dependent assertions, no external I/O

**Bad test signals**:
- Test breaks when you rename an internal function (testing implementation)
- Test passes when the behavior is clearly broken (testing the wrong thing)
- Test requires knowledge of internal data structures to write

**Good test signals**:
- Test reads like a specification: "[actor] can [action] with [condition]"
- Test survives a complete internal refactor
- Test uses only the module's public API

---

## Phase 5: Refactor

After all tests pass for the current cycle:

- [ ] Extract duplication (both in test and production code)
- [ ] Deepen modules: move complexity behind simple interfaces
- [ ] Apply SOLID principles where natural
- [ ] Run the full test suite after each refactor step

**Never refactor while RED.** Get to GREEN first. If refactoring breaks a
test, the break reveals coupling between test and implementation — either
the test is too coupled, or the refactor changed behavior.

---

## Phase 6: Verify

Before declaring done:

- [ ] Run the full test suite and confirm all tests pass
- [ ] Each acceptance criterion has at least one test covering it
- [ ] No tests depend on implementation details (will survive refactor)
- [ ] Tests use the domain vocabulary from the project glossary
- [ ] Edge cases from the acceptance criteria are covered
- [ ] All debug-only or throwaway code is removed

Report:

```
## TDD Complete: [Feature Name]

**Files changed**:
- `src/[path]` — created / modified ([brief description])
- `tests/[path]` — test file ([N] test functions)

**Acceptance criteria covered**:
- [x] [criterion] — test: [test_name]
- [x] [criterion] — test: [test_name]

**All tests pass**: YES / NO
**Refactor cycles**: [N]
```

---

## Phase 7: Handoff

Use `AskUserQuestion` to recommend next steps:

- **Prompt**: "TDD cycle complete. All [N] tests pass. How would you like to proceed?"
- **Options**:
  - `[A] Run /code-review [file1] [file2] — review implementation quality`
  - `[B] Run /story-done [story-path] — verify and close story (if story file exists)`
  - `[C] Continue TDD on additional behaviors — more edge cases or remaining criteria`
  - `[D] Stop here`

If the implementation was from a plain description (no story file), suggest
option A or D. If from a story file, suggest A then B.

---

## Collaborative Protocol

1. **Ask before writing** — confirm test file paths and implementation file
   paths before creating them
2. **One cycle at a time** — never batch tests or implementation
3. **Tests are part of the implementation** — do not defer test writing
4. **Red before green** — never write implementation code before the failing
   test exists
5. **The test defines done** — a feature is complete when all its tests pass
6. **Domain vocabulary** — use the project's glossary terms in test names and
   interface design, not generic terms

## Error Recovery

- **Test won't fail (passes immediately)**: The test is not testing real
  behavior. Add an assertion that captures the actual expected outcome. If
  the test still passes trivially, it may be testing the framework, not the
  code — rewrite it.
- **Can't find a seam for the test**: Some game code (rendering, physics,
  input) is hard to test in isolation. For these, write the test at the
  highest practical seam (state machine output, command queue, event log)
  rather than testing the rendering or physics directly.
- **Story references nonexistent test-helpers**: Run `/test-helpers
  [system-name]` to generate them, then resume.
