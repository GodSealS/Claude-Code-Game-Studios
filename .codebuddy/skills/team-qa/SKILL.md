---
name: team-qa
description: "Orchestrate the QA team through a full testing cycle. Coordinates qa-lead (strategy + test plan) and qa-tester (test case writing + bug reporting) to produce a complete QA package for a sprint or feature. Covers: test plan generation, test case writing, smoke check gate, manual QA execution, and sign-off report. / 编排 QA 团队完成完整测试周期。协调 qa-lead（策略+测试计划）和 qa-tester（测试用例编写+缺陷报告）为冲刺或功能生成完整的 QA 包。覆盖：测试计划生成、测试用例编写、冒烟测试门控、手动 QA 执行和签署报告。"
argument-hint: "[sprint | feature: system-name]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Task, AskUserQuestion
agent: qa-lead
---

When this skill is invoked, orchestrate the QA team through a structured testing cycle.
> **中文翻译**：当此技能被调用时，通过结构化测试周期编排 QA 团队。

**Decision Points:** At each phase transition, use `AskUserQuestion` to present
the user with the subagent's proposals as selectable options. Write the agent's
full analysis in conversation, then capture the decision with concise labels.
The user must approve before moving to the next phase.
> **中文翻译**：**决策点：** 在每个阶段转换时，使用 `AskUserQuestion` 向用户展示子代理的提案作为可选选项。在对话中写入代理的完整分析，然后用简洁的标签捕获决策。用户必须在进入下一阶段之前批准。

## Team Composition / 团队组成

- **qa-lead** — QA strategy, test plan generation, story classification, sign-off report / QA 策略、测试计划生成、故事分类、签署报告
- **qa-tester** — Test case writing, bug report writing, manual QA documentation / 测试用例编写、缺陷报告编写、手动 QA 文档

## How to Delegate / 如何委托

Use the Task tool to spawn each team member as a subagent:
> **中文翻译**：使用 Task 工具将每个团队成员作为子代理派生：

- `subagent_type: qa-lead` — Strategy, planning, classification, sign-off / 策略、规划、分类、签署
- `subagent_type: qa-tester` — Test case writing and bug report writing / 测试用例编写和缺陷报告编写

Always provide full context in each agent's prompt (story file paths, QA plan path, scope constraints). Launch independent qa-tester tasks in parallel where possible (e.g., multiple stories in Phase 5 can be scaffolded simultaneously).
> **中文翻译**：始终在每个代理的提示中提供完整上下文（故事文件路径、QA 计划路径、范围约束）。在可能的情况下并行启动独立的 qa-tester 任务（如第 5 阶段的多个故事可同时搭建）。

## Pipeline / 管线

### Phase 1: Load Context / 第 1 阶段：加载上下文

Before doing anything else, gather the full scope: / 在开始之前，收集完整范围：

1. Detect the current sprint or feature scope from the argument: / 从参数检测当前冲刺或功能范围：
   - If argument is a sprint identifier (e.g., `sprint-03`): read all story files in `production/sprints/[sprint]/` / 如果参数是冲刺标识符（如 `sprint-03`）：读取 `production/sprints/[sprint]/` 中的所有故事文件
   - If argument is `feature: [system-name]`: glob story files tagged for that system / 如果参数是 `feature: [system-name]`：全局搜索标记为该系统的故事文件
   - If no argument: read `production/session-state/active.md` and `production/sprint-status.yaml` (if present) to infer the active sprint / 如果无参数：读取 `production/session-state/active.md` 和 `production/sprint-status.yaml`（如存在）推断当前冲刺

2. Read `production/stage.txt` to confirm the current project phase. / 读取 `production/stage.txt` 确认当前项目阶段。

3. Count stories found and report to the user: / 统计找到的故事并向用户报告：
   > "QA cycle starting for [sprint/feature]. Found [N] stories. Current stage: [stage]. Ready to begin QA strategy?"
   > **中文翻译**：> "QA 周期开始于 [冲刺/功能]。找到 [N] 个故事。当前阶段：[阶段]。准备开始 QA 策略吗？"

### Phase 2: QA Strategy (qa-lead) / 第 2 阶段：QA 策略（qa-lead）

Spawn `qa-lead` via Task to review all in-scope stories and produce a QA strategy. / 通过 Task 派生 `qa-lead` 审查所有范围内故事并生成 QA 策略。

Prompt the qa-lead to: / 提示 qa-lead：
- Read each story file / 读取每个故事文件
- Classify each story by type: **Logic** / **Integration** / **Visual/Feel** / **UI** / **Config/Data** / 按类型分类每个故事：**逻辑** / **集成** / **视觉/感觉** / **UI** / **配置/数据**
- Identify which stories require automated test evidence vs. manual QA / 识别哪些故事需要自动化测试证据 vs 手动 QA
- Flag any stories with missing acceptance criteria or missing test evidence that would block QA / 标记任何缺少验收标准或缺少测试证据会阻塞 QA 的故事
- Estimate manual QA effort (number of test sessions needed) / 估算手动 QA 工作量（需要的测试会话数）
- Check `tests/smoke/` for smoke test scenarios; for each, assess whether it can be verified given the current build. Produce a smoke check verdict: **PASS** / **PASS WITH WARNINGS [list]** / **FAIL [list of failures]** / 检查 `tests/smoke/` 中的冒烟测试场景；对每个场景，评估是否可以在当前构建下验证。产生冒烟检查裁决：**PASS** / **PASS WITH WARNINGS [列表]** / **FAIL [失败列表]**
- Produce a strategy summary table and smoke check result: / 生成策略摘要表和冒烟检查结果：

  | Story | Type | Automated Required | Manual Required | Blocker? |
  |-------|------|--------------------|-----------------|----------|

  **Smoke Check**: [PASS / PASS WITH WARNINGS / FAIL] — [details if not PASS] / **冒烟检查**：[PASS / PASS WITH WARNINGS / FAIL] — [若非 PASS 则详情]

If the smoke check result is **FAIL**, the qa-lead must list the failures prominently. QA cannot proceed past the strategy phase with a failed smoke check. / 如果冒烟检查结果为 **FAIL**，qa-lead 必须醒目列出失败项。QA 无法在冒烟检查失败的情况下通过策略阶段。

Present the qa-lead's full strategy to the user, then use `AskUserQuestion`: / 向用户展示 qa-lead 的完整策略，然后使用 `AskUserQuestion`：

```
question: "QA Strategy Review"
options:
  - "Looks good — proceed to test plan"
  - "Adjust story types before proceeding"
  - "Skip blocked stories and proceed with the rest"
  - "Smoke check failed — fix issues and re-run /team-qa"
  - "Cancel — resolve blockers first"
```
> **中文翻译**：
> 问题："QA 策略审查"
> 选项：
>   - "看起来不错 — 继续到测试计划"
>   - "继续前调整故事类型"
>   - "跳过被阻塞的故事，继续处理其余部分"
>   - "冒烟检查失败 — 修复问题并重新运行 /team-qa"
>   - "取消 — 先解决阻塞问题"

If smoke check **FAIL**: do not proceed to Phase 3. Surface the failures and stop. The user must fix them and re-run `/team-qa`. / 如果冒烟检查 **FAIL**：不要继续到第 3 阶段。展示失败项并停止。用户必须修复它们并重新运行 `/team-qa`。
If smoke check **PASS WITH WARNINGS**: note the warnings for the sign-off report and continue. / 如果冒烟检查 **PASS WITH WARNINGS**：记录警告用于签署报告并继续。
If blockers are present: list them explicitly. The user may choose to skip blocked stories or cancel the cycle.
> **中文翻译**：如果存在阻塞项：明确列出它们。用户可以选择跳过被阻塞的故事或取消周期。

### Phase 3: Test Plan Generation / 第 3 阶段：测试计划生成

Using the strategy from Phase 2, produce a structured test plan document.
> **中文翻译**：使用第 2 阶段的策略，生成结构化的测试计划文档。

The test plan should cover:
> **中文翻译**：测试计划应涵盖：
- **Scope**: sprint/feature name, story count, dates / **范围**：冲刺/功能名称、故事数量、日期
- **Story Classification Table**: from Phase 2 strategy / **故事分类表**：来自第 2 阶段策略
- **Automated Test Requirements**: which stories need test files, expected paths in `tests/` / **自动化测试需求**：哪些故事需要测试文件、`tests/` 中的预期路径
- **Manual QA Scope**: which stories need manual walkthrough and what to validate / **手动 QA 范围**：哪些故事需要手动走查和验证什么
- **Out of Scope**: what is explicitly not being tested this cycle and why / **范围外**：本周期明确不测试什么及原因
- **Entry Criteria**: what must be true before QA can begin (smoke check pass, build stable) / **准入标准**：QA 开始前必须为真的条件（冒烟检查通过、构建稳定）
- **Exit Criteria**: what constitutes a completed QA cycle (all stories PASS or FAIL with bugs filed) / **退出标准**：什么构成完成的 QA 周期（所有故事通过或失败并提交缺陷）

Ask: "May I write the QA plan to `production/qa/qa-plan-[sprint]-[date].md`?"
> **中文翻译**：询问："我可以将 QA 计划写入 `production/qa/qa-plan-[sprint]-[date].md` 吗？"

Write only after receiving approval.
> **中文翻译**：仅在获得批准后写入。

### Phase 4: Test Case Writing (qa-tester) / 第 4 阶段：测试用例编写（qa-tester）

> **Smoke check** is performed as part of Phase 2 (QA Strategy). If the smoke check returned FAIL in Phase 2, the cycle was stopped there. This phase only runs when the Phase 2 smoke check was PASS or PASS WITH WARNINGS.
> **中文翻译**：**冒烟检查**作为第 2 阶段（QA 策略）的一部分执行。如果冒烟检查在第 2 阶段返回 FAIL，周期会在那里停止。此阶段仅在第 2 阶段冒烟检查为 PASS 或 PASS WITH WARNINGS 时运行。

For each story requiring manual QA (Visual/Feel, UI, Integration without automated tests):
> **中文翻译**：对于每个需要手动 QA 的故事（视觉/感觉、UI、无自动化测试的集成）：

Spawn `qa-tester` via Task for each story (run in parallel where possible), providing:
> **中文翻译**：通过 Task 为每个故事派生 `qa-tester`（尽可能并行运行），提供：
- The story file path / 故事文件路径
- The relevant section of the QA plan for that story / 该故事的 QA 计划相关部分
- The GDD acceptance criteria for the system being tested (if available) / 被测试系统的 GDD 验收标准（如有）
- Instructions to write detailed test cases covering all acceptance criteria / 编写覆盖所有验收标准的详细测试用例的说明

Each test case set should include:
> **中文翻译**：每个测试用例集应包括：
- **Preconditions**: game state required before testing begins / **前置条件**：测试开始前需要的游戏状态
- **Steps**: numbered, unambiguous actions / **步骤**：编号、明确的操作
- **Expected Result**: what should happen / **预期结果**：应该发生什么
- **Actual Result**: field left blank for the tester to fill in / **实际结果**：留空供测试人员填写
- **Pass/Fail**: field left blank / **通过/失败**：留空

Present the test cases to the user for review before execution. Group by story.
> **中文翻译**：在执行前向用户展示测试用例供审查。按故事分组。

Use `AskUserQuestion` per story group (batched 3-4 at a time):
> **中文翻译**：对每个故事组使用 `AskUserQuestion`（一次批处理 3-4 个）：

```
question: "Test cases ready for [Story Group]. Review before manual QA begins?"
options:
  - "Approved — begin manual QA for these stories"
  - "Revise test cases for [story name]"
  - "Skip manual QA for [story name] — not ready"
```
> **中文翻译**：
> 问题："[故事组] 的测试用例已准备好。在手动 QA 开始前审查？"
> 选项：
>   - "批准 — 开始这些故事的手动 QA"
>   - "修改 [故事名称] 的测试用例"
>   - "跳过 [故事名称] 的手动 QA — 尚未准备好"

### Phase 6: Manual QA Execution / 第 6 阶段：手动 QA 执行

Walk through each story in the approved manual QA list.
> **中文翻译**：遍历已批准手动 QA 列表中的每个故事。

Batch stories into groups of 3-4 and use `AskUserQuestion` for each:
> **中文翻译**：将故事分批为每组 3-4 个，对每个使用 `AskUserQuestion`：

```
question: "Manual QA — [Story Title]\n[brief description of what to test]"
options:
  - "PASS — all acceptance criteria verified"
  - "PASS WITH NOTES — minor issues found (describe after)"
  - "FAIL — criteria not met (describe after)"
  - "BLOCKED — cannot test yet (reason)"
```
> **中文翻译**：
> 问题："手动 QA — [故事标题]\n[要测试内容的简要描述]"
> 选项：
>   - "通过 — 所有验收标准已验证"
>   - "带备注通过 — 发现小问题（稍后描述）"
>   - "失败 — 标准未满足（稍后描述）"
>   - "阻塞 — 尚无法测试（原因）"

After each FAIL result: use `AskUserQuestion` to collect the failure description, then spawn `qa-tester` via Task to write a formal bug report in `production/qa/bugs/`.
> **中文翻译**：每次 FAIL 结果后：使用 `AskUserQuestion` 收集失败描述，然后通过 Task 派生 `qa-tester` 在 `production/qa/bugs/` 中编写正式缺陷报告。

Bug report naming: `BUG-[NNN]-[short-slug].md` (increment NNN from existing bugs in the directory).
> **中文翻译**：缺陷报告命名：`BUG-[NNN]-[short-slug].md`（从目录中现有缺陷递增 NNN）。

After collecting all results, summarize:
> **中文翻译**：收集所有结果后，总结：
- Stories PASS: [count] / 故事通过：[数量]
- Stories PASS WITH NOTES: [count] / 故事带备注通过：[数量]
- Stories FAIL: [count] — bugs filed: [IDs] / 故事失败：[数量] — 已提交缺陷：[ID]
- Stories BLOCKED: [count] / 故事阻塞：[数量]

### Phase 7: QA Sign-Off Report / 第 7 阶段：QA 签署报告

Spawn `qa-lead` via Task to produce the sign-off report using all results from Phases 4–6.
> **中文翻译**：通过 Task 派生 `qa-lead` 使用第 4-6 阶段的所有结果生成签署报告。

The sign-off report format:
> **中文翻译**：签署报告格式：

```markdown
## QA Sign-Off Report: [Sprint/Feature]
**Date**: [date]
**QA Lead sign-off**: [pending]

### Test Coverage Summary
| Story | Type | Auto Test | Manual QA | Result |
|-------|------|-----------|-----------|--------|
| [title] | Logic | PASS | — | PASS |
| [title] | Visual | — | PASS | PASS |

### Bugs Found
| ID | Story | Severity | Status |
|----|-------|----------|--------|
| BUG-001 | [story] | S2 | Open |

### Verdict: APPROVED / APPROVED WITH CONDITIONS / NOT APPROVED

**Conditions** (if any): [list what must be fixed before the build advances]

### Next Step
[guidance based on verdict]
```
> **中文翻译**：
> ## QA 签署报告：[冲刺/功能]
> **日期**：[日期]
> **QA 负责人签署**：[待定]
>
> ### 测试覆盖摘要
> | 故事 | 类型 | 自动测试 | 手动 QA | 结果 |
> |------|------|----------|---------|------|
> | [标题] | 逻辑 | 通过 | — | 通过 |
> | [标题] | 视觉 | — | 通过 | 通过 |
>
> ### 发现的缺陷
> | ID | 故事 | 严重性 | 状态 |
> |----|------|--------|------|
> | BUG-001 | [故事] | S2 | 开放 |
>
> ### 裁决：批准 / 有条件批准 / 未批准
>
> **条件**（如有）：[构建推进前必须修复的列表]
>
> ### 下一步
> [基于裁决的指导]

Verdict rules:
> **中文翻译**：裁决规则：
- **APPROVED**: All stories PASS or PASS WITH NOTES; no S1/S2 bugs open / **批准**：所有故事通过或带备注通过；无 S1/S2 缺陷开放
- **APPROVED WITH CONDITIONS**: S3/S4 bugs open, or PASS WITH NOTES issues documented; no S1/S2 bugs / **有条件批准**：S3/S4 缺陷开放，或带备注通过的问题已记录；无 S1/S2 缺陷
- **NOT APPROVED**: Any S1/S2 bugs open; or stories FAIL without documented workaround / **未批准**：任何 S1/S2 缺陷开放；或故事失败且无记录解决方法

Next step guidance by verdict:
> **中文翻译**：按裁决的下一步指导：
- APPROVED: "Build is ready for the next phase. Run `/gate-check` to validate advancement." / 批准："构建已准备好进入下一阶段。运行 `/gate-check` 验证推进。"
- APPROVED WITH CONDITIONS: "Resolve conditions before advancing. S3/S4 bugs may be deferred to polish." / 有条件批准："推进前解决条件。S3/S4 缺陷可推迟到打磨阶段。"
- NOT APPROVED: "Resolve S1/S2 bugs and re-run `/team-qa` or targeted manual QA before advancing." / 未批准："推进前解决 S1/S2 缺陷并重新运行 `/team-qa` 或有针对性的手动 QA。"

Ask: "May I write this QA sign-off report to `production/qa/qa-signoff-[sprint]-[date].md`?"
> **中文翻译**：询问："我可以将此 QA 签署报告写入 `production/qa/qa-signoff-[sprint]-[date].md` 吗？"

Write only after receiving approval.
> **中文翻译**：仅在获得批准后写入。

## Error Recovery Protocol / 错误恢复协议

If any spawned agent (via Task) returns BLOCKED, errors, or cannot complete:
> **中文翻译**：如果任何派生的代理（通过 Task）返回 BLOCKED、错误或无法完成：

1. **Surface immediately**: Report "[AgentName]: BLOCKED — [reason]" to the user before continuing to dependent phases
> **中文翻译**：1. **立即报告**：在继续依赖阶段之前向用户报告"[代理名]：BLOCKED — [原因]"
2. **Assess dependencies**: Check whether the blocked agent's output is required by subsequent phases. If yes, do not proceed past that dependency point without user input.
> **中文翻译**：2. **评估依赖**：检查被阻塞代理的输出是否为后续阶段所需。如果是，未经用户输入不要超过该依赖点。
3. **Offer options** via AskUserQuestion with choices:
> **中文翻译**：3. 通过 AskUserQuestion **提供选项**：
   - Skip this agent and note the gap in the final report / 跳过此代理并在最终报告中记录差距
   - Retry with narrower scope / 以更窄的范围重试
   - Stop here and resolve the blocker first / 在此停止并先解决阻塞问题
4. **Always produce a partial report** — output whatever was completed. Never discard work because one agent blocked.
> **中文翻译**：4. **始终生成部分报告** — 输出已完成的内容。绝不因一个代理阻塞而丢弃工作。

Common blockers:
> **中文翻译**：常见阻塞：
- Input file missing (story not found, GDD absent) → redirect to the skill that creates it / 输入文件缺失（故事未找到、GDD 缺失）→ 重定向到创建它的技能
- ADR status is Proposed → do not implement; run `/architecture-decision` first / ADR 状态为 Proposed → 不要实现；先运行 `/architecture-decision`
- Scope too large → split into two stories via `/create-stories` / 范围太大 → 通过 `/create-stories` 拆分为两个故事
- Conflicting instructions between ADR and story → surface the conflict, do not guess / ADR 和故事之间指令冲突 → 展示冲突，不要猜测

## Output / 输出

A summary covering: stories in scope, smoke check result, manual QA results, bugs filed (with IDs and severities), and the final APPROVED / APPROVED WITH CONDITIONS / NOT APPROVED verdict.
> **中文翻译**：摘要涵盖：范围内故事、冒烟检查结果、手动 QA 结果、已提交缺陷（含 ID 和严重性）以及最终 批准/有条件批准/未批准 裁决。

Verdict: **COMPLETE** — QA cycle finished.
> **中文翻译**：裁决：**COMPLETE** — QA 周期完成。
Verdict: **BLOCKED** — smoke check failed or critical blocker prevented cycle completion; partial report produced.
> **中文翻译**：裁决：**BLOCKED** — 冒烟检查失败或关键阻塞阻止周期完成；生成了部分报告。
