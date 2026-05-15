---
name: diagnose
description: "Disciplined debugging loop for hard bugs and performance regressions. Reproduce → minimise → hypothesise → instrument → fix → regression-test. Use when user says 'diagnose', 'debug this', reports a bug/crash/failure, or describes a performance regression."
argument-hint: "[bug description or reproduction steps]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, AskUserQuestion
---

# Diagnose

A discipline for hard bugs. Skip phases only when explicitly justified.

When exploring the codebase, use the project's domain glossary (`CONTEXT.md` if it exists) to get a clear mental model of the relevant modules, and check ADRs in the area you're touching.

## Phase 1 — Build a Feedback Loop

**This is the skill.** Everything else is mechanical. If you have a fast, deterministic, agent-runnable pass/fail signal for the bug, you will find the cause. If you don't, no amount of staring at code will save you.

Spend disproportionate effort here. **Be aggressive. Be creative. Refuse to give up.**

### Ways to construct one — try in roughly this order

1. **Failing test** at whatever seam reaches the bug — unit, integration, e2e.
2. **Curl / HTTP script** against a running dev server.
3. **CLI invocation** with a fixture input, diffing stdout against a known-good snapshot.
4. **Headless browser script** (Playwright / Puppeteer) — drives UI, asserts on DOM/console/network.
5. **Replay a captured trace.** Save a real payload / event log to disk; replay through the code path.
6. **Throwaway harness.** Minimal subset of the system exercising just the bug code path.
7. **Property / fuzz loop.** For "sometimes wrong output", run 1000 random inputs.
8. **Bisection harness.** If bug appeared between two known states, automate "boot at state X, check" for `git bisect run`.
9. **Differential loop.** Same input through old vs new version, diff outputs.
10. **HITL bash script.** Last resort. Use `scripts/hitl-loop.template.sh` so the loop is structured.

**Iterate on the loop itself:** Can I make it faster? Sharper signal? More deterministic? A 30-second flaky loop is barely better than no loop. A 2-second deterministic loop is a debugging superpower.

**Non-deterministic bugs:** Aim for a **higher reproduction rate**. Loop the trigger 100×, parallelise, add stress. A 50%-flake bug is debuggable; 1% is not.

**When you genuinely cannot build a loop:** Stop and say so. List what you tried. Ask the user for access to the reproducing environment, a captured artifact, or permission to add temporary production instrumentation.

Do not proceed to Phase 2 until you have a loop you believe in.

## Phase 2 — Reproduce

Run the loop. Confirm:

- [ ] The loop produces the failure mode the **user** described — not a different nearby failure
- [ ] The failure is reproducible across multiple runs (or at a high enough rate for non-deterministic bugs)
- [ ] You have captured the exact symptom (error message, wrong output, slow timing)

Do not proceed until the bug reproduces.

## Phase 3 — Hypothesise

Generate **3–5 ranked hypotheses** before testing any. Single-hypothesis generation anchors on the first plausible idea.

Each hypothesis must be **falsifiable**: state the prediction it makes.

> Format: "If <X> is the cause, then <changing Y> will make the bug disappear / <changing Z> will make it worse."

**Show the ranked list to the user before testing.** AskUserQuestion with options:
- `[A] Proceed with ranking — test hypothesis 1`
- `[B] Re-rank — I have additional domain knowledge`
- `[C] I've already ruled some out — I'll tell you which`

If you cannot state the prediction, the hypothesis is a vibe — discard or sharpen it.

## Phase 4 — Instrument

Each probe must map to a specific prediction from Phase 3. **Change one variable at a time.**

Tool preference:
1. **Debugger / REPL inspection** — one breakpoint beats ten logs
2. **Targeted logs** at boundaries that distinguish hypotheses
3. Never "log everything and grep"

**Tag every debug log** with a unique prefix, e.g. `[DEBUG-a4f2]`. Cleanup becomes a single grep.

**Perf branch.** For performance regressions, logs are usually wrong. Establish a baseline measurement first, then bisect.

## Phase 5 — Fix + Regression Test

Write the regression test **before the fix** — but only if there is a **correct seam** for it.

If a correct seam exists:
1. Turn the minimised repro into a failing test at that seam
2. Watch it fail
3. Apply the fix
4. Watch it pass
5. Re-run the Phase 1 feedback loop against the original (un-minimised) scenario

If no correct seam exists, **that itself is the finding.** Note it and flag for architecture improvement.

## Phase 6 — Cleanup + Post-Mortem

Required before declaring done:

- [ ] Original repro no longer reproduces (re-run Phase 1 loop)
- [ ] Regression test passes (or absence of seam is documented)
- [ ] All `[DEBUG-...]` instrumentation removed
- [ ] Throwaway prototypes deleted or moved to a clearly-marked debug location
- [ ] The correct hypothesis is stated in the commit/PR message

**Then ask: what would have prevented this bug?** If the answer involves architectural change (no good test seam, tangled callers), recommend running `/tech-debt` or an architecture review.

Verdict: **COMPLETE** — bug diagnosed, fixed, and regression-tested.

## Recommended Next Steps

- If the root cause was architectural: Run `/tech-debt scan` or `/code-review` on the affected files
- If this is a recurring pattern: Run `/bug-triage` to surface systemic trends
- If the fix touched gameplay code: Run `/story-done` on any affected stories
