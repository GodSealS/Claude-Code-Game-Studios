---
name: estimate
description: "Estimates task effort by analyzing complexity, dependencies, historical velocity, and risk factors. Produces a structured estimate with confidence levels. / 通过分析复杂度、依赖关系、历史速度和风险因素估算任务工作量。生成带置信度的结构化估算。"
argument-hint: "[task-description]"
user-invocable: true
allowed-tools: Read, Glob, Grep
---

## Phase 1: Understand the Task / 第 1 阶段：理解任务

Read the task description from the argument. If the description is too vague to estimate meaningfully, ask for clarification before proceeding.
> **中文翻译**：从参数读取任务描述。如果描述过于模糊无法有意义地估算，在继续之前请求澄清。

Read CODEBUDDY.md for project context: tech stack, coding standards, architectural patterns, and any estimation guidelines.
> **中文翻译**：读取 CODEBUDDY.md 获取项目上下文：技术栈、编码标准、架构模式和任何估算指南。

Read relevant design documents from `design/gdd/` if the task relates to a documented feature or system.
> **中文翻译**：如果任务与已文档化的功能或系统相关，从 `design/gdd/` 读取相关设计文档。

---

## Phase 2: Scan Affected Code / 第 2 阶段：扫描受影响代码

Identify files and modules that would need to change:
> **中文翻译**：识别需要更改的文件和模块：

- Assess complexity (size, dependency count, cyclomatic complexity) / 评估复杂度（大小、依赖数量、圈复杂度）
- Identify integration points with other systems / 识别与其他系统的集成点
- Check for existing test coverage in the affected areas / 检查受影响区域的现有测试覆盖率
- Read past sprint data from `production/sprints/` for similar completed tasks and historical velocity / 从 `production/sprints/` 读取过去的冲刺数据，获取类似已完成任务和历史速度

---

## Phase 3: Analyze Complexity Factors / 第 3 阶段：分析复杂度因素

**Code Complexity:** / **代码复杂度：**
- Lines of code in affected files / 受影响文件的代码行数
- Number of dependencies and coupling level / 依赖数量和耦合级别
- Whether this touches core/engine code vs leaf/feature code / 是否涉及核心/引擎代码 vs 叶节点/功能代码
- Whether existing patterns can be followed or new patterns are needed / 是否可以遵循现有模式或需要新模式

**Scope:** / **范围：**
- Number of systems touched / 涉及的系统数量
- New code vs modification of existing code / 新代码 vs 修改现有代码
- Amount of new test coverage required / 所需的新测试覆盖量
- Data migration or configuration changes needed / 所需的数据迁移或配置更改

**Risk:** / **风险：**
- New technology or unfamiliar libraries / 新技术或不熟悉的库
- Unclear or ambiguous requirements / 不清楚或模糊的需求
- Dependencies on unfinished work / 对未完成工作的依赖
- Cross-system integration complexity / 跨系统集成复杂度
- Performance sensitivity / 性能敏感性

---

## Phase 4: Generate the Estimate / 第 4 阶段：生成估算

```markdown
## Task Estimate: [Task Name] / 任务估算：[任务名称]
Generated: [Date] / 生成日期：[日期]

### Task Description / 任务描述
[Restate the task clearly in 1-2 sentences] / [用1-2句话清楚重述任务]

### Complexity Assessment / 复杂度评估

| Factor | Assessment | Notes |
|--------|-----------|-------|
<!-- 翻译: 因素 | 评估 | 备注 -->
| Systems affected | [List] | [Core, gameplay, UI, etc.] |
<!-- 翻译: 受影响系统 | [列表] | [核心、游戏玩法、UI 等] -->
| Files likely modified | [Count] | [Key files listed below] |
<!-- 翻译: 可能修改的文件 | [数量] | [关键文件如下] -->
| New code vs modification | [Ratio] | |
<!-- 翻译: 新代码 vs 修改 | [比率] | -->
| Integration points | [Count] | [Which systems interact] |
<!-- 翻译: 集成点 | [数量] | [哪些系统交互] -->
| Test coverage needed | [Low / Medium / High] | |
<!-- 翻译: 所需测试覆盖 | [低/中/高] | -->
| Existing patterns available | [Yes / Partial / No] | |
<!-- 翻译: 现有模式可用 | [是/部分/否] | -->

**Key files likely affected:** / **可能受影响的关键文件：**
- `[path/to/file1]` -- [what changes here] / [此处更改什么]

### Effort Estimate / 工作量估算

| Scenario | Days | Assumption |
|----------|------|------------|
<!-- 翻译: 场景 | 天数 | 假设 -->
| Optimistic | [X] | Everything goes right, no surprises / 一切顺利，无意外 |
| Expected | [Y] | Normal pace, minor issues, one round of review / 正常速度，小问题，一轮审查 |
| Pessimistic | [Z] | Significant unknowns surface, blocked for a day / 重大未知浮现，阻塞一天 |

**Recommended budget: [Y days]** / **建议预算：[Y 天]**

### Confidence: [High / Medium / Low] / 置信度：[高/中/低]

[Explain which factors drive the confidence level for this specific task.] / [解释哪些因素驱动了此特定任务的置信度。]

### Risk Factors / 风险因素

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
<!-- 翻译: 风险 | 可能性 | 影响 | 缓解措施 -->

### Dependencies / 依赖关系

| Dependency | Status | Impact if Delayed |
|-----------|--------|-------------------|
<!-- 翻译: 依赖项 | 状态 | 延迟影响 -->

### Suggested Breakdown / 建议分解

| # | Sub-task | Estimate | Notes |
|---|----------|----------|-------|
<!-- 翻译: # | 子任务 | 估算 | 备注 -->
| 1 | [Research / spike] | [X days] | |
| 2 | [Core implementation] | [X days] | |
| 3 | [Testing and validation] | [X days] | |
| | **Total** | **[Y days]** | |

### Notes and Assumptions / 注释和假设
- [Key assumption that affects the estimate] / [影响估算的关键假设]
- [Any caveats about scope boundaries] / [关于范围边界的任何注意事项]
```

Output the estimate with a brief summary: recommended budget, confidence level, and the single biggest risk factor.
> **中文翻译**：输出估算及简要摘要：建议预算、置信度和最大的单一风险因素。

This skill is read-only — no files are written. Verdict: **COMPLETE** — estimate generated.
> **中文翻译**：此技能为只读 — 不写入任何文件。裁决：**完成** — 估算已生成。

---

## Phase 5: Next Steps / 第 5 阶段：后续步骤

- If confidence is Low: recommend a time-boxed spike (`/prototype`) before committing. / 如果置信度为低：建议在承诺之前进行限时探索（`/prototype`）。
- If the task is > 10 days: recommend breaking it into smaller stories via `/create-stories`. / 如果任务 > 10 天：建议通过 `/create-stories` 分解为更小的故事。
- To schedule the task: run `/sprint-plan update` to add it to the next sprint. / 要安排任务：运行 `/sprint-plan update` 将其添加到下一个冲刺。

### Guidelines / 指南

- Always give a range (optimistic / expected / pessimistic), never a single number / 始终给出范围（乐观/预期/悲观），绝不要单一数字
- The recommended budget should be the expected estimate, not the optimistic one / 建议预算应为预期估算，而非乐观估算
- Round to half-day increments — estimating in hours implies false precision for tasks longer than a day / 四舍五入到半天增量 — 对于超过一天的任务，以小时估算意味着虚假精度
- Do not pad estimates silently — call out risk explicitly so the team can decide / 不要静默填充估算 — 明确指出风险，让团队决定
