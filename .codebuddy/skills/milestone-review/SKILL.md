---
name: milestone-review
description: "Generates a comprehensive milestone progress review including feature completeness, quality metrics, risk assessment, and go/no-go recommendation. Use at milestone checkpoints or when evaluating readiness for a milestone deadline. / 生成全面的里程碑进度审查，包括功能完整性、质量指标、风险评估和继续/停止建议。在里程碑检查点或评估里程碑截止日期准备度时使用。"
argument-hint: "[milestone-name|current] [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Task, AskUserQuestion
---

## Phase 0: Parse Arguments / 阶段 0：解析参数

Extract the milestone name (`current` or a specific name) and resolve the review mode (once, store for all gate spawns this run):

> **中文翻译**：提取里程碑名称（`current` 或特定名称）并解析审查模式（一次，存储本次运行的所有门控启动）：

1. If `--review [full|lean|solo]` was passed → use that / 如果传递了 `--review [full|lean|solo]` → 使用该值
2. Else read `production/review-mode.txt` → use that value / 否则读取 `production/review-mode.txt` → 使用该值
3. Else → default to `lean` / 否则 → 默认为 `lean`

See `.codebuddy/docs/director-gates.md` for the full check pattern.

> **中文翻译**：完整检查模式参见 `.codebuddy/docs/director-gates.md`。

---

## Phase 1: Load Milestone Data / 阶段 1：加载里程碑数据

Read the milestone definition from `production/milestones/`. If the argument is `current`, use the most recently modified milestone file.

> **中文翻译**：从 `production/milestones/` 读取里程碑定义。如果参数为 `current`，使用最近修改的里程碑文件。

Read all sprint reports for sprints within this milestone from `production/sprints/`.

> **中文翻译**：从 `production/sprints/` 读取此里程碑内所有冲刺的冲刺报告。

---

## Phase 2: Scan Codebase Health / 阶段 2：扫描代码库健康状况

- Scan for `TODO`, `FIXME`, `HACK` markers that indicate incomplete work / 扫描指示未完成工作的 `TODO`、`FIXME`、`HACK` 标记
- Check the risk register at `production/risk-register/` / 检查 `production/risk-register/` 中的风险登记册

---

## Phase 3: Generate the Milestone Review / 阶段 3：生成里程碑审查

```markdown
# Milestone Review: [Milestone Name] / # 里程碑审查：[里程碑名称]

## Overview / ## 概述
- **Target Date**: [Date] / **目标日期**：[日期]
- **Current Date**: [Today] / **当前日期**：[今天]
- **Days Remaining**: [N] / **剩余天数**：[N]
- **Sprints Completed**: [X/Y] / **完成的冲刺**：[X/Y]

## Feature Completeness / ## 功能完整性

### Fully Complete / ### 完全完成
| Feature | Acceptance Criteria | Test Status | / **功能** | **验收标准** | **测试状态** |
|---------|-------------------|-------------|
| [Feature] | [Criteria met?] | [Pass/Fail] |

### Partially Complete / ### 部分完成
| Feature | % Done | Remaining Work | Risk to Milestone | / **功能** | **完成%** | **剩余工作** | **对里程碑的风险** |
|---------|--------|---------------|------------------|
| [Feature] | [%] | [Work description] | [High/Medium/Low] |

### Not Started / ### 未开始
| Feature | Priority | Can Cut? | Impact of Cutting | / **功能** | **优先级** | **可削减？** | **削减影响** |
|---------|----------|----------|------------------|
| [Feature] | [High/Medium/Low] | [Yes/No] | [Impact description] |

## Quality Metrics / ## 质量指标
- **Open S1 Bugs**: [N] -- [List] / **未解决的 S1 错误**：[N] -- [列表]
- **Open S2 Bugs**: [N] / **未解决的 S2 错误**：[N]
- **Open S3 Bugs**: [N] / **未解决的 S3 错误**：[N]
- **Test Coverage**: [X%] / **测试覆盖率**：[X%]
- **Performance**: [Within budget? Details] / **性能**：[在预算内？详情]

## Code Health / ## 代码健康状况
- **TODO count**: [N across codebase] / **TODO 数量**：[整个代码库中的 N]
- **FIXME count**: [N] / **FIXME 数量**：[N]
- **HACK count**: [N] / **HACK 数量**：[N]
- **Technical debt items**: [List critical ones] / **技术债务项目**：[列出关键项目]

## Risk Assessment / ## 风险评估
| Risk | Status | Impact if Realized | Mitigation Status | / **风险** | **状态** | **实现时的影响** | **缓解状态** |
|------|--------|-------------------|------------------|
| [Risk description] | [Active/Monitored/Resolved] | [High/Medium/Low] | [In progress/Complete/Future] |

## Velocity Analysis / ## 速度分析
- **Planned vs Completed** (across all sprints): [X/Y tasks = Z%] / **计划与完成**（所有冲刺中）：[X/Y 任务 = Z%]
- **Trend**: [Improving / Stable / Declining] / **趋势**：[改善/稳定/下降]
- **Adjusted estimate for remaining work**: [Days needed at current velocity] / **剩余工作的调整估算**：[以当前速度所需的天数]

## Scope Recommendations / ## 范围建议
### Protect (Must ship with milestone) / ### 保护（必须随里程碑发布）
- [Feature and why] / [功能及原因]

### At Risk (May need to cut or simplify) / ### 有风险（可能需要削减或简化）
- [Feature and risk] / [功能及风险]

### Cut Candidates (Can defer without compromising milestone) / ### 削减候选（可以推迟而不损害里程碑）
- [Feature and impact of cutting] / [功能及削减影响]

## Go/No-Go Assessment / ## 继续/停止评估

**Recommendation**: [GO / CONDITIONAL GO / NO-GO] / **建议**：[继续/有条件继续/停止]

**Conditions** (if conditional): / **条件**（如果有条件）：
- [Condition 1 that must be met] / [必须满足的条件 1]
- [Condition 2 that must be met] / [必须满足的条件 2]

**Rationale**: [Explanation of the recommendation] / **理由**：[建议的解释]

## Action Items / ## 行动项
| # | Action | Owner | Deadline | / **#** | **行动** | **负责人** | **截止日期** |
|---|--------|-------|----------|
| 1 | [Action description] | [Owner] | [Date] |
```

---

## Phase 3b: Producer Risk Assessment / 阶段 3b：制作人风险评估

**Review mode check** — apply before spawning PR-MILESTONE:

> **中文翻译**：**审查模式检查** — 在启动 PR-MILESTONE 之前应用：

- `solo` → skip. Note: "PR-MILESTONE skipped — Solo mode." Present the Go/No-Go section without a producer verdict. / → 跳过。注意："PR-MILESTONE 已跳过——Solo 模式。" 呈现 Go/No-Go 部分，不含制作人裁决。
- `lean` → skip (not a PHASE-GATE). Note: "PR-MILESTONE skipped — Lean mode." Present the Go/No-Go section without a producer verdict. / → 跳过（非阶段门控）。注意："PR-MILESTONE 已跳过——Lean 模式。" 呈现 Go/No-Go 部分，不含制作人裁决。
- `full` → spawn as normal. / → 正常启动。

Before generating the Go/No-Go recommendation, spawn `producer` via Task using gate **PR-MILESTONE** (`.codebuddy/docs/director-gates.md`).

> **中文翻译**：在生成 Go/No-Go 建议之前，通过 Task 使用门控 **PR-MILESTONE** 启动 `producer`。

Pass: milestone name and target date, current completion percentage, blocked story count, velocity data from sprint reports (if available), list of cut candidates.

> **中文翻译**：传递：里程碑名称和目标日期、当前完成百分比、受阻故事数量、冲刺报告中的速度数据（如有）、削减候选列表。

Present the producer's assessment inline within the Go/No-Go section. The producer's verdict (ON TRACK / AT RISK / OFF TRACK) informs the overall recommendation — do not issue a GO against an OFF TRACK producer verdict without explicit user acknowledgement.

> **中文翻译**：在 Go/No-Go 部分内联呈现制作人的评估。制作人的裁决（ON TRACK / AT RISK / OFF TRACK）影响整体建议——未经用户明确确认，不要在 OFF TRACK 制作人裁决下发布 GO。

---

## Phase 4: Save Review / 阶段 4：保存审查

Present the review to the user.

> **中文翻译**：将审查呈现给用户。

Ask: "May I write this to `production/milestones/[milestone-name]-review.md`?"

> **中文翻译**：询问："我可以将此写入 `production/milestones/[milestone-name]-review.md` 吗？"

If yes, write the file, creating the directory if needed. Verdict: **COMPLETE** — milestone review saved.

> **中文翻译**：如果同意，写入文件，如需要则创建目录。裁决：**COMPLETE** — 里程碑审查已保存。

If no, stop here. Verdict: **BLOCKED** — user declined write.

> **中文翻译**：如果拒绝，在此停止。裁决：**BLOCKED** — 用户拒绝写入。

---

## Phase 5: Next Steps / 阶段 5：后续步骤

- Run `/gate-check` for a formal phase gate verdict if this milestone marks a development phase boundary. / 如果此里程碑标志开发阶段边界，运行 `/gate-check` 获取正式阶段门控裁决。
- Run `/sprint-plan` to adjust the next sprint based on the scope recommendations above. / 运行 `/sprint-plan` 根据上述范围建议调整下一个冲刺。