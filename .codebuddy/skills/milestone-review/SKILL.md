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
# Milestone Review: [Milestone Name]

## Overview
- **Target Date**: [Date]
- **Current Date**: [Today]
- **Days Remaining**: [N]
- **Sprints Completed**: [X/Y]

## Feature Completeness

### Fully Complete
| Feature | Acceptance Criteria | Test Status |
|---------|-------------------|-------------|

### Partially Complete
| Feature | % Done | Remaining Work | Risk to Milestone |
|---------|--------|---------------|------------------|

### Not Started
| Feature | Priority | Can Cut? | Impact of Cutting |
|---------|----------|----------|------------------|

## Quality Metrics
- **Open S1 Bugs**: [N] -- [List]
- **Open S2 Bugs**: [N]
- **Open S3 Bugs**: [N]
- **Test Coverage**: [X%]
- **Performance**: [Within budget? Details]

## Code Health
- **TODO count**: [N across codebase]
- **FIXME count**: [N]
- **HACK count**: [N]
- **Technical debt items**: [List critical ones]

## Risk Assessment
| Risk | Status | Impact if Realized | Mitigation Status |
|------|--------|-------------------|------------------|

## Velocity Analysis
- **Planned vs Completed** (across all sprints): [X/Y tasks = Z%]
- **Trend**: [Improving / Stable / Declining]
- **Adjusted estimate for remaining work**: [Days needed at current velocity]

## Scope Recommendations
### Protect (Must ship with milestone)
- [Feature and why]

### At Risk (May need to cut or simplify)
- [Feature and risk]

### Cut Candidates (Can defer without compromising milestone)
- [Feature and impact of cutting]

## Go/No-Go Assessment

**Recommendation**: [GO / CONDITIONAL GO / NO-GO]

**Conditions** (if conditional):
- [Condition 1 that must be met]
- [Condition 2 that must be met]

**Rationale**: [Explanation of the recommendation]

## Action Items
| # | Action | Owner | Deadline |
|---|--------|-------|----------|
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
