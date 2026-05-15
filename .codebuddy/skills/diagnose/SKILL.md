---
name: diagnose
description: "Disciplined diagnosis loop for hard bugs and performance regressions. Reproduce the failure, hypothesise root causes, instrument to isolate, fix, and regression-test. Use when user says 'diagnose this', 'debug this', reports a stubborn bug, or describes a performance regression with unclear cause."
argument-hint: "[BUG-ID or description of the issue]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Bash, Task, AskUserQuestion
---

# Diagnose

A structured loop for hard bugs: Build a feedback loop → Reproduce →
Hypothesise → Instrument → Fix + Regression test → Cleanup.

**Do not skip phases.** Each phase constrains the next. Jumping to "fix"
without a repro loop or a hypothesis produces guesses, not fixes.

---

## Phase 1: Gather Context

Determine what to diagnose:

- **If BUG-ID provided**: read `production/qa/bugs/[BUG-ID].md`. Extract the
  reproduction steps, expected result, actual result, affected files, and any
  prior triage notes.
- **If plain description**: parse it for: what broke, when, how to reproduce,
  and what the expected behavior is. Search the codebase for related files.

Read the project's domain glossary from `CLAUDE.md` or `CONTEXT.md` at the
project root if they exist — clear mental model of the relevant modules
prevents misdirected debugging.

Check ADRs in the area you're touching — an ADR may explain why certain
patterns exist that look suspicious at first glance.

---

## Phase 2: Build a Feedback Loop

**This is the skill.** A fast, deterministic, agent-runnable pass/fail signal
for the bug is what makes debugging possible. Everything else is mechanical.
Spend disproportionate effort here.

### Ways to construct a loop — try in roughly this order:

1. **Failing test** at whatever seam reaches the bug (unit, integration, e2e)
2. **CLI invocation** with a fixture input, diffing output against known-good
3. **Headless script** that drives the game, asserts on state/logs
4. **Minimal harness** — a standalone script that exercises the bug code path
   in isolation with mocked dependencies
5. **Bisection** — if the bug appeared between two known states (commits,
   builds), automate "boot at state X, check, repeat" for `git bisect run`
6. **Differential loop** — run same input through old vs new and diff outputs

### Iterate on the loop:

Once you have a loop, ask:
- **Faster?** Cache setup, skip unrelated init, narrow the test scope.
- **Sharper signal?** Assert on the specific symptom, not "didn't crash".
- **More deterministic?** Pin RNG seed, isolate filesystem, freeze time.

A 30-second flaky loop is barely better than no loop. A 2-second deterministic
loop is a debugging superpower.

### Non-deterministic bugs:

The goal is not a clean repro but a **higher reproduction rate**. Loop the
trigger 100x, add stress, narrow timing windows. A 50%-flake bug is
debbugable; 1% is not — keep raising the rate until it's debuggable.

### When you genuinely cannot build a loop:

Stop and say so. List what you tried. Ask the user for: (a) access to the
reproduction environment, (b) a captured artifact (log dump, screen recording),
or (c) permission to add temporary instrumentation to production code.

**Do not proceed to Phase 3 without a loop you believe in.**

---

## Phase 3: Reproduce

Run the loop. Watch the bug appear. Confirm:

- [ ] The loop produces the **same** failure mode the user described — not a
  different failure that happens to be nearby
- [ ] The failure is reproducible across multiple runs (or reproducible at a
  high enough rate for non-deterministic bugs)
- [ ] You have captured the exact symptom (error message, wrong output, timing)
  so Phase 5 can verify the fix

If the loop shows a different failure than expected, re-read the bug
description and adjust the loop. Do not proceed to hypothesise on the wrong
bug.

**Verdict: FAIL** — bug not reproduced → Phase 3 cannot start. Return to
Phase 2 and refine the loop.

---

## Phase 4: Hypothesise

Generate **3-5 ranked hypotheses** before testing any. Single-hypothesis
generation anchors on the first plausible idea and misses the real cause.

Each hypothesis must be **falsifiable** — state the prediction it makes:

> "If [X] is the cause, then [changing Y] will make the bug disappear."

If you cannot state the prediction, the hypothesis is a guess — discard it
or sharpen it.

**Show the ranked list to the user.** They often have domain knowledge that
re-ranks instantly ("we just deployed a change to #3") or can rule out
hypotheses they already tested. If the user is available, wait for input. If
not, proceed with your ranking.

---

## Phase 5: Instrument

Each probe must map to a specific prediction from Phase 4. **Change one
variable at a time.**

Tool preference:
1. **Debugger / REPL inspection** if the environment supports it
2. **Targeted logs** at the boundaries that distinguish between hypotheses
3. Never "log everything and grep"

**Tag every debug log** with a unique prefix, e.g. `[DEBUG-a4f2]`. Cleanup
at the end becomes a single grep of the prefix. Untagged logs survive; tagged
logs die.

**For performance regressions**: logs are usually wrong. Instead, establish a
baseline measurement (timing harness, profiler), then bisect. Measure first,
fix second.

If instrumenting the live code is not possible, build a throwaway harness
that isolates the suspected code path. Mark it clearly as `DIAGNOSE -
THROWAWAY` in the file header.

---

## Phase 6: Fix + Regression Test

Write the regression test **before the fix** — but only at a correct seam.

A correct seam is one where the test exercises the **real bug pattern** as it
occurs at the call site. If the only available seam is too shallow (unit test
that can't replicate the full chain that triggered the bug), a regression test
there gives false confidence.

**If no correct seam exists**, note it. The codebase architecture is
preventing the bug from being locked down. This is a finding, not a failure.

If a correct seam exists:
1. Turn the minimised repro into a failing test at that seam
2. Watch it fail
3. Apply the fix
4. Watch it pass
5. Re-run the Phase 2 feedback loop against the original (un-minimised)
   scenario to confirm the fix works in context

Write the test following the project's test naming convention:
`tests/unit/[system]/[system]_[feature]_test.[ext]`.

---

## Phase 7: Cleanup

Required before declaring done:

- [ ] Original repro no longer reproduces (re-run the Phase 2 loop)
- [ ] Regression test passes (or absence of seam is documented)
- [ ] All `[DEBUG-...]` instrumentation removed (grep the prefix)
- [ ] Throwaway harnesses deleted or moved to a clearly-marked temp location
- [ ] The proven hypothesis is stated in the commit / PR message — so the next
  debugger learns what was found

Then ask: **"What would have prevented this bug?"** If the answer involves
architectural change (no good test seam, tangled callers, hidden coupling),
note it. This is valuable input for future architecture reviews.

---

## Phase 8: Document and Hand Off

Ask: "May I write the diagnosis record to `production/qa/bugs/[BUG-ID]-diagnosis.md`?"

If yes, write the record:

```markdown
# Diagnosis: [BUG-ID or description]

**Date**: [date]
**Root cause**: [one sentence — the hypothesis that proved correct]
**Feedback loop**: [what loop was built — test, script, harness]
**Hypotheses tested**: [N]
**Fix**: [one-line summary of what was changed]
**Regression test**: [path, or "No correct seam found"]
**Systemic prevention**: [architectural change that would prevent recurrence,
or "None — one-off bug"]
```

If no BUG-ID was provided (diagnosis from description), skip the write and
present the findings in conversation.

Use `AskUserQuestion` for next steps:

- **Prompt**: "Diagnosis complete. Bug is fixed and regression test [exists /
  not applicable]. How would you like to proceed?"
- **Options**:
  - `[A] Run /bug-report close [BUG-ID] — file closure record (if BUG-ID was provided)`
  - `[B] Run /code-review [files] — review the fix and regression test quality`
  - `[C] Run /test-evidence-review — verify test coverage for the affected system`
  - `[D] Stop here`

---

## Collaborative Protocol

1. **Build feedback first** — do not skip to hypotheses without a repro loop
2. **Falsifiable hypotheses only** — if you can't state the prediction, it's
   a guess, not a hypothesis
3. **One variable at a time** — change one thing, measure, then change the
   next
4. **Tag and sweep** — all debug instrumentation gets a unique prefix; remove
   them all before declaring done
4. **Fix after proving** — write the regression test before the fix, not after
5. **Ask before writing** — confirm before writing diagnosis records or fixing
   files outside the investigation scope

## Error Recovery

- **Loop can't be built**: Document what was tried. Hand off to the user with
  specific asks (access, artifacts, manual test steps).
- **Hypothesis proves wrong after instrumenting**: Return to Phase 4, cross
  off the disproven hypothesis, rank the remaining ones, and re-instrument.
- **Fix breaks other tests**: The regression test was testing at the wrong
  seam, or the fix introduces new coupling. Revisit the fix approach.
- **Bug is in a non-code artifact** (asset, config, data file): Skip the
  regression test requirement. Document what was changed and why.
