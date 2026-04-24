---
name: skill-improve
description: "Improve a skill using a test-fix-retest loop. Runs static checks, proposes targeted fixes, rewrites the skill, re-tests, and keeps or reverts based on score change. / 使用测试-修复-重测循环改进技能。运行静态检查，提出针对性修复，重写技能，重新测试，并根据分数变化决定保留或回滚。"
argument-hint: "[skill-name]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Bash
---

# Skill Improve / 技能改进

Runs an improvement loop on a single skill:
test → fix → retest → keep or revert.

> **中文翻译**：对单个技能运行改进循环：测试 → 修复 → 重测 → 保留或回滚。

---

## Phase 1: Parse Argument / 第 1 阶段：解析参数

Read the skill name from the first argument. If missing, output usage and stop:

```
Usage: /skill-improve [skill-name]
Example: /skill-improve tech-debt
```

Verify `.codebuddy/skills/[name]/SKILL.md` exists. If not, stop with:
"Skill '[name]' not found."

---

## Phase 2: Baseline Test / 第 2 阶段：基线测试

Run `/skill-test static [name]` and record the baseline score:
- Count of FAILs
- Count of WARNs
- Which specific checks failed (Check 1–7)

Display to the user:
```
Static baseline:   [N] failures, [M] warnings
Failing: Check 4 (no ask-before-write), Check 5 (no handoff)
```

If baseline is 0 FAILs and 0 WARNs, note it and proceed to Phase 2b.

### Phase 2b: Category Baseline / 阶段 2b：类别基线

Look up the skill's `category:` field in `CCGS Skill Testing Framework/catalog.yaml`.

If no `category:` field is found, display:
"Category: not yet assigned — skipping category checks."
and skip to Phase 3.

If category is found, run `/skill-test category [name]` and record the category baseline:
- Count of FAILs
- Count of WARNs
- Which specific category rubric metrics failed

Display to the user:
```
Category baseline: [N] failures, [M] warnings  ([category] rubric)
```

If BOTH static and category baselines are 0 FAILs and 0 WARNs, stop:
"This skill already passes all static and category checks. No improvements needed."

---

## Phase 3: Diagnose / 第 3 阶段：诊断

Read the full skill file at `.codebuddy/skills/[name]/SKILL.md`.

For each failing or warning **static** check, identify the exact gap:

- **Check 1 fail** → which frontmatter field is missing
- **Check 2 fail** → how many phases found vs. minimum required
- **Check 3 fail** → no verdict keywords anywhere in the skill body
- **Check 4 fail** → Write or Edit in allowed-tools but no ask-before-write language
- **Check 5 warn** → no follow-up or next-step section at the end
- **Check 6 warn** → `context: fork` set but fewer than 5 phases found
- **Check 7 warn** → argument-hint is empty or doesn't match documented modes

For each failing or warning **category** check (if category was assigned in Phase 2b),
identify the exact gap in the skill's text. For example:
- If G2 fails (gate mode, full directors not spawned): skill body never references all 4
  PHASE-GATE director prompts
- If A2 fails (authoring, no per-section May-I-write): skill asks once at the end, not
  before each section write
- If T3 fails (team, BLOCKED not surfaced): skill doesn't halt dependent work on blocked agent

Show the full combined diagnosis to the user before proposing any changes.

---

## Phase 4: Propose Fix / 第 4 阶段：提出修复

Write a targeted fix for each failure and warning. Show the proposed changes
as clearly marked before/after blocks. Only change what is failing — do not
rewrite sections that are passing.

> **中文翻译**：为每个失败和警告编写针对性修复。将建议的更改显示为明确标记的前后对比块。仅更改失败的部分——不要重写通过的部分。

Ask: "May I write this improved version to `.codebuddy/skills/[name]/SKILL.md`?"

If the user says no, stop here.

---

## Phase 5: Write and Retest / 第 5 阶段：写入并重测

Record the current content of the skill file (for revert if needed).

Write the improved skill to `.codebuddy/skills/[name]/SKILL.md`.

Re-run `/skill-test static [name]` and record the new static score.
If a category was assigned, also re-run `/skill-test category [name]` and record the new category score.

Display the comparison:
```
Static:   Before [N] failures, [M] warnings  →  After [N'] failures, [M'] warnings
Category: Before [N] failures, [M] warnings  →  After [N'] failures, [M'] warnings  (if applicable)
Combined change: improved / no change / worse
```

---

## Phase 6: Verdict / 第 6 阶段：裁决

Count the combined failure total: static FAILs + category FAILs + static WARNs + category WARNs. / 计算合并失败总数：静态 FAIL + 类别 FAIL + 静态 WARN + 类别 WARN。

**If combined score improved (combined failure count is lower than baseline):** / **如果合并分数改善（合并失败计数低于基线）：**
Report: "Score improved. Changes kept." / 报告："分数改善。更改已保留。"
Show a summary of what was fixed in each dimension. / 显示每个维度修复内容的摘要。

**If combined score is the same or worse:** / **如果合并分数相同或更差：**
Report: "Combined score did not improve." / 报告："合并分数未改善。"
Show what changed and why it may not have helped. / 显示更改内容及为何可能没有帮助。
Ask: "May I revert `.codebuddy/skills/[name]/SKILL.md` using git checkout?" / 询问："我可以使用 git checkout 回滚 `.codebuddy/skills/[name]/SKILL.md` 吗？"
If yes: run `git checkout -- .codebuddy/skills/[name]/SKILL.md` / 如果是：运行 `git checkout -- .codebuddy/skills/[name]/SKILL.md`

---

## Phase 7: Next Steps / 第 7 阶段：下一步

- Run `/skill-test static all` to find the next skill with failures. / 运行 `/skill-test static all` 查找下一个有失败的技能。
- Run `/skill-improve [next-name]` to continue the loop on another skill. / 运行 `/skill-improve [next-name]` 继续改进另一个技能。
- Run `/skill-test audit` to see overall coverage progress. / 运行 `/skill-test audit` 查看整体覆盖进度。
