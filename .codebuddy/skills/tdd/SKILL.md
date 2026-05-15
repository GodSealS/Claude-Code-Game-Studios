---
name: tdd
description: "Test-driven development with a red-green-refactor loop — builds features one vertical slice at a time. Use when user wants to implement using TDD, mentions 'red-green-refactor', wants integration tests, or asks for test-first development."
argument-hint: "[feature description or story path]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion
---

# Test-Driven Development

## Philosophy

**Core principle**: Tests should verify behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't.

**Good tests** are integration-style: they exercise real code paths through public APIs. They describe _what_ the system does, not _how_ it does it. A good test reads like a specification — "user can checkout with valid cart" tells you exactly what capability exists.

**Bad tests** are coupled to implementation. They mock internal collaborators, test private methods, or verify through external means. The warning sign: your test breaks when you refactor, but behavior hasn't changed.

See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for mocking guidelines.

## Phase 1 — Planning

Before writing any code:

- [ ] Confirm with user what interface changes are needed
- [ ] Confirm which behaviors to test (prioritize — you can't test everything)
- [ ] Identify opportunities for deep modules (small interface, large implementation)
- [ ] Design interfaces for testability
- [ ] List the behaviors to test (not implementation steps)

Ask: "What should the public interface look like? Which behaviors are most important to test?"

## Phase 2 — Tracer Bullet (First Vertical Slice)

Write ONE test that confirms ONE thing about the system:

```
RED:   Write test for first behavior → test fails
GREEN: Write minimal code to pass → test passes
```

This is your tracer bullet — proves the path works end-to-end.

Do NOT write all tests first, then all implementation. This is the **horizontal slicing** anti-pattern:

```
WRONG (horizontal):
  RED:   test1, test2, test3, test4, test5
  GREEN: impl1, impl2, impl3, impl4, impl5

RIGHT (vertical):
  RED→GREEN: test1→impl1
  RED→GREEN: test2→impl2
  RED→GREEN: test3→impl3
  ...
```

## Phase 3 — Incremental Loop

For each remaining behavior:

```
RED:   Write next test → fails
GREEN: Minimal code to pass → passes
```

Rules:
- One test at a time
- Only enough code to pass current test
- Don't anticipate future tests
- Keep tests focused on observable behavior

## Phase 4 — Refactor

After all tests pass, look for refactor candidates:

- [ ] Extract duplication
- [ ] Deepen modules (move complexity behind simple interfaces)
- [ ] Apply SOLID principles where natural
- [ ] Run tests after each refactor step

**Never refactor while RED.** Get to GREEN first.

## Checklist Per Cycle

```
[ ] Test describes behavior, not implementation
[ ] Test uses public interface only
[ ] Test would survive internal refactor
[ ] Code is minimal for this test
[ ] No speculative features added
[ ] Tests pass before moving to next cycle
```

## Verdict

At the end of the TDD loop:
- [ ] All planned behaviors have tests
- [ ] All tests pass
- [ ] Code has been refactored to meet project standards

Verdict: **COMPLETE** — feature implemented with TDD.

## Recommended Next Steps

- Run `/code-review` on the new files for architecture review
- Run `/story-done` if this was a story implementation
- Run `/test-evidence-review` to validate test quality
