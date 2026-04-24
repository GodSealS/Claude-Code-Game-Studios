---
name: retrospective
description: "Generates a sprint or milestone retrospective by analyzing completed work, velocity, blockers, and patterns. Produces actionable insights for the next iteration. / 通过分析已完成工作、速度、阻塞因素和模式生成冲刺或里程碑回顾。为下一次迭代产生可操作的洞察。"
argument-hint: "[sprint-N|milestone-name]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
context: |
  !git log --oneline --since="2 weeks ago" 2>/dev/null
---

## Phase 1: Parse Arguments / 第 1 阶段：解析参数

Determine whether this is a sprint retrospective (`sprint-N`) or a milestone retrospective (`milestone-name`).
> **中文翻译**：确定这是冲刺回顾（`sprint-N`）还是里程碑回顾（`milestone-name`）。

---

## Phase 1b: Check for Existing Retrospective / 第 1b 阶段：检查现有回顾

Before loading any data, glob for an existing retrospective file:
> **中文翻译**：在加载任何数据之前，搜索现有的回顾文件：

- For sprint retrospectives: `production/retrospectives/retro-[sprint-slug]-*.md` / 对于冲刺回顾
  (also check `production/sprints/sprint-[N]-retrospective.md` as an alternate location) / （同时检查 `production/sprints/sprint-[N]-retrospective.md` 作为备用位置）
- For milestone retrospectives: `production/retrospectives/retro-[milestone-name]-*.md` / 对于里程碑回顾

If a matching file is found, present the user with:
> **中文翻译**：如果找到匹配文件，向用户展示：

```
An existing retrospective was found: [filename] / 找到现有回顾：[文件名]

[A] Update existing retrospective — load it and add/revise sections / 更新现有回顾 — 加载并添加/修改章节
[B] Start fresh — generate a new retrospective, archiving the old one / 重新开始 — 生成新回顾，归档旧的
```

Wait for user selection before continuing. If updating, read the existing file and
carry its content forward into the generation phase, revising sections with new data.
> **中文翻译**：等待用户选择后继续。如果更新，读取现有文件并将其内容带入生成阶段，用新数据修改章节。

---

## Phase 2: Load Sprint or Milestone Data / 第 2 阶段：加载冲刺或里程碑数据

Read the sprint or milestone plan from the appropriate location:
> **中文翻译**：从适当的位置读取冲刺或里程碑计划：

- Sprint plans: `production/sprints/` / 冲刺计划
- Milestone definitions: `production/milestones/` / 里程碑定义

**If the file does not exist or is empty**, output:
> **中文翻译**：**如果文件不存在或为空**，输出：

> "No sprint data found for [sprint/milestone]. Run `/sprint-status` to generate
> sprint data first, or provide the sprint details manually."
>
> **中文翻译**："未找到 [冲刺/里程碑] 的冲刺数据。请先运行 `/sprint-status` 生成冲刺数据，或手动提供冲刺详情。"

Then use `AskUserQuestion` to present two options:
> **中文翻译**：然后使用 `AskUserQuestion` 展示两个选项：

- **[A] Provide data manually** — ask the user to paste or describe the sprint
  tasks, dates, and outcomes; use that as the source of truth for the retrospective. / **[A] 手动提供数据** — 请用户粘贴或描述冲刺任务、日期和结果；将其作为回顾的事实来源。
- **[B] Stop** — abort the skill. Verdict: **BLOCKED** — no sprint data available. / **[B] 停止** — 中止技能。裁决：**BLOCKED** — 无冲刺数据可用。

If the user chooses [A], collect the data and continue to Phase 3 using what they provide.
If the user chooses [B], stop here.
> **中文翻译**：如果用户选择 [A]，收集数据并使用提供的内容继续到阶段 3。如果用户选择 [B]，在此停止。

Extract: planned tasks, estimated effort, owners, and goals.
> **中文翻译**：提取：计划任务、估算工作量、负责人和目标。

Read the git log for the period covered by the sprint or milestone to understand what was actually committed and when.
> **中文翻译**：读取冲刺或里程碑覆盖期间的 git 日志，了解实际提交了什么以及何时提交。

---

## Phase 3: Analyze Completion and Trends / 第 3 阶段：分析完成情况和趋势

Scan for completed and incomplete tasks by comparing the plan against actual deliverables. Check for:
> **中文翻译**：通过比较计划与实际交付物，扫描已完成和未完成的任务。检查：

- Tasks completed as planned / 按计划完成的任务
- Tasks completed but modified from the plan / 已完成但与计划不同的任务
- Tasks carried over (not completed) / 延期的任务（未完成）
- Tasks added mid-sprint (unplanned work) / 冲刺中间添加的任务（计划外工作）
- Tasks removed or descoped / 已移除或缩减范围的任务

Scan the codebase for TODO/FIXME trends:
> **中文翻译**：扫描代码库中的 TODO/FIXME 趋势：

- Count current TODO/FIXME/HACK comments / 计算当前 TODO/FIXME/HACK 注释
- Compare to previous sprint counts if available (check previous retrospectives) / 与上一个冲刺计数比较（如有）（检查之前的回顾）
- Note whether technical debt is growing or shrinking / 注意技术债务是增长还是减少

Read previous retrospectives (if any) from `production/sprints/` or `production/milestones/` to check:
> **中文翻译**：从 `production/sprints/` 或 `production/milestones/` 读取之前的回顾（如有）以检查：

- Were previous action items addressed? / 之前的行动项是否已处理？
- Are the same problems recurring? / 相同的问题是否反复出现？
- How has velocity trended? / 速度趋势如何？

---

## Phase 4: Generate the Retrospective / 第 4 阶段：生成回顾

```markdown
## Retrospective: [Sprint N / Milestone Name] / 回顾：[冲刺 N / 里程碑名称]
Period: [Start Date] -- [End Date] / 时期：[开始日期] -- [结束日期]
Generated: [Date] / 生成时间：[日期]

### Metrics / 指标

| Metric | Planned | Actual | Delta |
|--------|---------|--------|-------|
<!-- 翻译: 指标 | 计划 | 实际 | 差异 -->
| Tasks | [X] | [Y] | [+/- Z] |
| Completion Rate | -- | [Z%] | -- |
| Story Points / Effort Days | [X] | [Y] | [+/- Z] |
| Bugs Found | -- | [N] | -- |
| Bugs Fixed | -- | [N] | -- |
| Unplanned Tasks Added | -- | [N] | -- |
| Commits | -- | [N] | -- |

### Velocity Trend / 速度趋势

| Sprint | Planned | Completed | Rate |
|--------|---------|-----------|------|
<!-- 翻译: 冲刺 | 计划 | 已完成 | 完成率 -->
| [N-2] | [X] | [Y] | [Z%] |
| [N-1] | [X] | [Y] | [Z%] |
| [N] (current) | [X] | [Y] | [Z%] |

**Trend**: [Increasing / Stable / Decreasing] / **趋势**：[上升 / 稳定 / 下降]
[One sentence explaining the trend] / [一句话解释趋势]

### What Went Well / 做得好的方面
- [Observation backed by specific data or examples] / [有具体数据或示例支持的观察]
- [Another positive observation] / [另一个积极的观察]
- [Recognize specific contributions or decisions that paid off] / [认可产生回报的具体贡献或决策]

### What Went Poorly / 做得不好的方面
- [Specific issue with measurable impact -- e.g., "Feature X took 5 days
  instead of estimated 2, blocking tasks Y and Z"] / [有可衡量影响的具体问题 — 例如"功能 X 花了 5 天而不是估算的 2 天，阻塞了任务 Y 和 Z"]
- [Another issue with impact] / [另一个有影响的问题]
- [Do not assign blame -- focus on systemic causes] / [不要归咎于个人 — 关注系统性原因]

### Blockers Encountered / 遇到的阻塞因素

| Blocker | Duration | Resolution | Prevention |
|---------|----------|------------|------------|
<!-- 翻译: 阻塞因素 | 持续时间 | 解决方案 | 预防措施 -->

### Estimation Accuracy / 估算准确性

| Task | Estimated | Actual | Variance | Likely Cause |
|------|-----------|--------|----------|--------------|
<!-- 翻译: 任务 | 估算 | 实际 | 偏差 | 可能原因 -->
| [Most overestimated task] | [X] | [Y] | [+Z] | [Why] |
| [Most underestimated task] | [X] | [Y] | [-Z] | [Why] |

**Overall estimation accuracy**: [X%] of tasks within +/- 20% of estimate
**整体估算准确性**：[X%] 的任务在估算的 +/- 20% 范围内

[Analysis: Are we consistently over- or under-estimating? For which types of
tasks? What adjustment should we apply?]
[分析：我们是一致性地高估还是低估？对于哪些类型的任务？应该应用什么调整？]

### Carryover Analysis / 延期分析

| Task | Original Sprint | Times Carried | Reason | Action |
|------|----------------|---------------|--------|--------|
<!-- 翻译: 任务 | 原始冲刺 | 延期次数 | 原因 | 行动 -->

### Technical Debt Status / 技术债务状态
- Current TODO count: [N] (previous: [N]) / 当前 TODO 计数：[N]（之前：[N]）
- Current FIXME count: [N] (previous: [N]) / 当前 FIXME 计数：[N]（之前：[N]）
- Current HACK count: [N] (previous: [N]) / 当前 HACK 计数：[N]（之前：[N]）
- Trend: [Growing / Stable / Shrinking] / 趋势：[增长 / 稳定 / 减少]
- [Note any areas of concern] / [注意任何关注领域]

### Previous Action Items Follow-Up / 之前行动项跟进

| Action Item (from Sprint N-1) | Status | Notes |
|-------------------------------|--------|-------|
<!-- 翻译: 行动项（来自冲刺 N-1）| 状态 | 备注 -->
| [Previous action] | [Done / In Progress / Not Started] | [Context] |

### Action Items for Next Iteration / 下次迭代的行动项

| # | Action | Owner | Priority | Deadline |
|---|--------|-------|----------|----------|
<!-- 翻译: # | 行动 | 负责人 | 优先级 | 截止日期 -->

### Process Improvements / 流程改进
- [Specific change to how we work, with expected benefit] / [工作方式的具体变更及预期收益]
- [Another improvement -- keep it to 2-3 actionable items, not a wish list] / [另一项改进 — 保持 2-3 个可操作的项，而非愿望清单]

### Summary / 摘要
[2-3 sentence overall assessment: Was this a good sprint/milestone? What is
the single most important thing to change going forward?]
[2-3 句整体评估：这是一个好的冲刺/里程碑吗？未来最需要改变的一件事是什么？]
```

---

## Phase 5: Save Retrospective / 第 5 阶段：保存回顾

Present the retrospective and top findings to the user (completion rate, velocity trend, top blocker, most important action item).
> **中文翻译**：向用户展示回顾和主要发现（完成率、速度趋势、最大阻塞因素、最重要的行动项）。

Ask: "May I write this to `production/sprints/sprint-[N]-retrospective.md`?" (or the milestone path if applicable)
> **中文翻译**：询问："我可以将其写入 `production/sprints/sprint-[N]-retrospective.md` 吗？"（或里程碑路径，如适用）

If yes, write the file, creating the directory if needed. Verdict: **COMPLETE** — retrospective saved.
> **中文翻译**：如果同意，写入文件，如需要则创建目录。裁决：**COMPLETE** — 回顾已保存。

If no, stop here. Verdict: **BLOCKED** — user declined write.
> **中文翻译**：如果拒绝，在此停止。裁决：**BLOCKED** — 用户拒绝写入。

---

## Phase 6: Next Steps / 第 6 阶段：后续步骤

- Run `/sprint-plan` to incorporate the action items and velocity data into the next sprint. / 运行 `/sprint-plan` 将行动项和速度数据纳入下一个冲刺。
- If this was a milestone retrospective, run `/gate-check` to formally assess readiness for the next phase. / 如果这是里程碑回顾，运行 `/gate-check` 正式评估下一阶段的准备度。

### Guidelines / 指南

- Be honest and specific. Vague retrospectives ("communication could be better") produce vague improvements. Use data and examples. / 诚实且具体。模糊的回顾（"沟通可以更好"）产生模糊的改进。使用数据和示例。
- Focus on systemic issues, not individual blame. / 关注系统性问题，而非个人归咎。
- Limit action items to 3-5. More than that dilutes focus. / 将行动项限制在 3-5 个。更多会分散注意力。
- Every action item must have an owner and a deadline. / 每个行动项必须有负责人和截止日期。
- Check whether previous action items were completed. Recurring unaddressed items are a process smell. / 检查之前的行动项是否已完成。反复未处理的项目是流程异味。
- If this is a milestone retrospective, also evaluate whether the milestone goals were achieved and what that means for the overall project timeline. / 如果这是里程碑回顾，还要评估里程碑目标是否实现以及对整体项目时间线的影响。
