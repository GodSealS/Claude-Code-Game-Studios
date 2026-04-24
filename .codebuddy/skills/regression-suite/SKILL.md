---
name: regression-suite
description: "Map test coverage to GDD critical paths, identify fixed bugs without regression tests, flag coverage drift from new features, and maintain tests/regression-suite.md. Run after implementing a bug fix or before a release gate. / 将测试覆盖率映射到 GDD 关键路径，识别没有回归测试的已修复缺陷，标记新功能的覆盖漂移，并维护 tests/regression-suite.md。在实现缺陷修复后或发布门控前运行。"
argument-hint: "[update | audit | report]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit
---

# Regression Suite / 回归测试套件

This skill ensures that every bug fix is backed by a test that would have
caught the original bug — and that the regression suite stays current as the
game evolves. It also detects when new features have been added without
corresponding regression coverage.
> **中文翻译**：此技能确保每个缺陷修复都有能捕获原始缺陷的测试支持——并且回归测试套件随着游戏的演进保持最新。它还能检测何时添加了新功能但没有相应的回归覆盖。

A regression suite is not a new test category — it is a **curated list of
tests already in `tests/`** that collectively cover the game's critical paths
and known failure points. This skill maintains that list.
> **中文翻译**：回归测试套件不是一个新的测试类别——它是**`tests/` 中已有测试的精选列表**，共同覆盖游戏的关键路径和已知故障点。此技能维护该列表。

**Output:** `tests/regression-suite.md`
> **中文翻译**：**输出**：`tests/regression-suite.md`

**When to run:** / **何时运行：**
- After fixing a bug (confirm a regression test was written or identify gap) / 修复缺陷后（确认已编写回归测试或识别差距）
- Before a release gate (`/gate-check polish` requires regression suite exists) / 发布门控前（`/gate-check polish` 要求回归测试套件存在）
- As part of sprint close to detect coverage drift / 作为冲刺关闭的一部分以检测覆盖漂移

---

## 1. Parse Arguments / 1. 解析参数

**Modes:** / **模式：**
- `/regression-suite update` — scan new bug fixes this sprint and check
  for regression test presence; add new tests to the suite manifest / 扫描本次冲刺的新缺陷修复并检查回归测试是否存在；将新测试添加到套件清单
- `/regression-suite audit` — full audit of all GDD critical paths vs.
  existing test coverage; flag paths with no regression test / 完整审计所有 GDD 关键路径与现有测试覆盖的对比；标记没有回归测试的路径
- `/regression-suite report` — read-only status report (no writes); suitable
  for sprint reviews / 只读状态报告（不写入）；适用于冲刺回顾
- No argument — run `update` if a sprint is active, else `audit` / 无参数 — 如有活跃冲刺则运行 `update`，否则运行 `audit`

---

## 2. Load Context / 2. 加载上下文

### Step 2a — Load existing regression suite / 步骤 2a — 加载现有回归测试套件

Read `tests/regression-suite.md` if it exists. Extract:
> **中文翻译**：如存在则读取 `tests/regression-suite.md`。提取：

- Total registered regression tests / 已注册的回归测试总数
- Last updated date / 最后更新日期
- Any tests flagged as `STALE` or `QUARANTINED` / 任何标记为 `STALE` 或 `QUARANTINED` 的测试

If it does not exist: note "No regression suite found — will create one."
> **中文翻译**：如果不存在：注明"未找到回归测试套件 — 将创建一个。"

### Step 2b — Load test inventory / 步骤 2b — 加载测试清单

Glob all test files: / 搜索所有测试文件：
```
tests/unit/**/*_test.*
tests/integration/**/*_test.*
tests/regression/**/*
```

For each file, note the system (from directory path) and file name.
Do not read test file contents unless needed for name-to-test mapping.
> **中文翻译**：对于每个文件，记录系统（从目录路径）和文件名。除非需要名称到测试的映射，否则不读取测试文件内容。

### Step 2c — Load GDD critical paths / 步骤 2c — 加载 GDD 关键路径

For `audit` mode: read `design/gdd/systems-index.md` to get all systems.
For each MVP-tier system, read its GDD and extract:
> **中文翻译**：对于 `audit` 模式：读取 `design/gdd/systems-index.md` 获取所有系统。对于每个 MVP 层级的系统，读取其 GDD 并提取：

- Acceptance Criteria (these define the critical paths) / 验收标准（定义关键路径）
- Formulas section (formulas must have regression tests) / 公式章节（公式必须有回归测试）
- Edge Cases section (known edge cases should have regression tests) / 边缘情况章节（已知边缘情况应有回归测试）

For `update` mode: skip full GDD scan. Instead read the current sprint plan
and story files to find stories with Status: Complete this sprint.
> **中文翻译**：对于 `update` 模式：跳过完整 GDD 扫描。改为读取当前冲刺计划和故事文件，查找本次冲刺状态为 Complete 的故事。

### Step 2d — Load closed bugs / 步骤 2d — 加载已关闭缺陷

Glob `production/qa/bugs/*.md` and filter for bugs with a `Status: Closed`
or `Status: Fixed` field. Note:
> **中文翻译**：搜索 `production/qa/bugs/*.md` 并过滤 `Status: Closed` 或 `Status: Fixed` 的缺陷。记录：

- Which story or system the bug was in / 缺陷所在的故事或系统
- Whether a regression test was mentioned in the fix description / 修复描述中是否提到回归测试

---

## 3. Map Coverage — Critical Paths / 3. 映射覆盖 — 关键路径

For `audit` mode only:
> **中文翻译**：仅限 `audit` 模式：

For each GDD acceptance criterion, determine whether a test exists:
> **中文翻译**：对于每个 GDD 验收标准，确定是否存在测试：

1. Grep `tests/unit/[system]/` and `tests/integration/[system]/` for file names
   and function names related to the criterion's key noun/verb / 在 `tests/unit/[system]/` 和 `tests/integration/[system]/` 中搜索与标准关键名词/动词相关的文件名和函数名
2. Assign coverage: / 分配覆盖状态：

| Status | Meaning |
|--------|---------|
| **COVERED** | A test file exists that targets this criterion's logic |
| **PARTIAL** | A test exists but doesn't cover all cases (e.g. happy path only) |
| **MISSING** | No test found for this critical path |
| **EXEMPT** | Visual/Feel or UI criterion — not automatable by design |

> **中文翻译**：
> | 状态 | 含义 |
> |--------|---------|
> | **已覆盖** | 存在针对此标准逻辑的测试文件 |
> | **部分覆盖** | 测试存在但未覆盖所有情况（例如仅正常路径） |
> | **缺失** | 未找到此关键路径的测试 |
> | **豁免** | 视觉/手感或 UI 标准 — 按设计不可自动化 |

3. Elevate MISSING items that correspond to formulas or state machines to
   **HIGH PRIORITY** gap — these are the most likely regression sources.
   > **中文翻译**：将对应公式或状态机的缺失项提升为**高优先级**差距 — 这些是最可能的回归来源。

---

## 4. Map Coverage — Fixed Bugs / 4. 映射覆盖 — 已修复缺陷

For each closed bug:
> **中文翻译**：对于每个已关闭的缺陷：

1. Extract the system slug from the bug's metadata / 从缺陷元数据中提取系统标识
2. Grep `tests/unit/[system]/` and `tests/integration/[system]/` for a test
   that references the bug ID or the specific failure scenario / 在测试目录中搜索引用缺陷 ID 或特定故障场景的测试
3. Assign: / 分配：
   - **HAS REGRESSION TEST** — a test was found that would catch this bug / **有回归测试** — 找到了能捕获此缺陷的测试
   - **MISSING REGRESSION TEST** — bug was fixed but no test guards against recurrence / **缺少回归测试** — 缺陷已修复但没有测试防止复发

For MISSING REGRESSION TEST items:
> **中文翻译**：对于缺少回归测试的项目：

- Flag them as regression gaps / 将其标记为回归差距
- Suggest the test file path: `tests/unit/[system]/[bug-slug]_regression_test.[ext]` / 建议测试文件路径
- Note: "Without this test, this bug can silently return in a future sprint." / 注意："没有此测试，此缺陷可能在未来的冲刺中悄然回归。"

---

## 5. Detect Coverage Drift / 5. 检测覆盖漂移

Coverage drift occurs when the game grows but the regression suite doesn't.
> **中文翻译**：当游戏增长但回归测试套件没有时，就会发生覆盖漂移。

Check for drift indicators:
> **中文翻译**：检查漂移指标：

- Stories completed this sprint with no corresponding test files in `tests/` / 本次冲刺完成的故事在 `tests/` 中没有对应的测试文件
- New systems added to `systems-index.md` since the last regression-suite update / 自上次回归测试套件更新以来添加到 `systems-index.md` 的新系统
- GDD sections added or revised since the regression suite was last updated / 自回归测试套件上次更新以来添加或修订的 GDD 章节
  (use Grep on GDD file modification hints if available, or ask the user) / （如有可用，使用 Grep 查找 GDD 文件修改提示，或询问用户）
- `tests/regression-suite.md` last-updated date vs. current date — if gap >
  2 sprints, flag as likely stale / `tests/regression-suite.md` 的最后更新日期 vs. 当前日期 — 如果差距 > 2 个冲刺，标记为可能过时

---

## 6. Generate Report and Suite Manifest / 6. 生成报告和套件清单

### Report format (in conversation) / 报告格式（对话中）

```
## Regression Suite Status / 回归测试套件状态

**Mode**: [update | audit | report] / **模式**：[更新 | 审计 | 报告]
**Existing registered tests**: [N] / **已注册测试**：[N]
**Test files scanned**: [N] / **扫描的测试文件**：[N]

### Critical Path Coverage (audit mode only) / 关键路径覆盖（仅审计模式）
| System | Total ACs | Covered | Partial | Missing | Exempt |
|--------|-----------|---------|---------|---------|--------|
<!-- 翻译: 系统 | 总验收标准 | 已覆盖 | 部分覆盖 | 缺失 | 豁免 -->

**Coverage rate (non-exempt)**: [N]% / **覆盖率（非豁免）**：[N]%

### Bug Regression Coverage / 缺陷回归覆盖
| Bug ID | System | Severity | Has Regression Test? |
|--------|--------|----------|----------------------|
<!-- 翻译: 缺陷ID | 系统 | 严重性 | 有回归测试？ -->

**Bugs without regression tests**: [N] / **没有回归测试的缺陷**：[N]

### Coverage Drift Indicators / 覆盖漂移指标
[List new systems or stories with no test coverage, or "None detected."] / [列出没有测试覆盖的新系统或故事，或"未检测到"。]

### Recommended New Regression Tests / 推荐的新回归测试
| Priority | System | Suggested Test File | Covers |
|----------|--------|---------------------|--------|
<!-- 翻译: 优先级 | 系统 | 建议的测试文件 | 覆盖 -->
```

### Suite manifest format (`tests/regression-suite.md`) / 套件清单格式

The manifest is a curated index — not the tests themselves, but a registry
of which tests should always pass before a release:
> **中文翻译**：清单是一个精选索引——不是测试本身，而是哪些测试在发布前应始终通过的注册表：

```markdown
# Regression Suite Manifest / 回归测试套件清单

> Last Updated: [date] / 最后更新：[日期]
> Total registered tests: [N] / 已注册测试总数：[N]
> Coverage: [N]% of GDD critical paths / 覆盖率：GDD 关键路径的 [N]%

## How to run / 如何运行

[Engine-specific command to run all regression tests] / [引擎特定的运行所有回归测试的命令]

## Registered Regression Tests / 已注册的回归测试

### [System Name] / [系统名称]

| Test File | Test Function (if known) | Covers | Added |
|-----------|--------------------------|--------|-------|
<!-- 翻译: 测试文件 | 测试函数（如已知）| 覆盖 | 添加日期 -->

## Known Gaps / 已知差距

Tests that should exist but don't yet: / 应存在但尚未编写的测试：

| Priority | System | Suggested Path | Covers | Reason Not Yet Written |
|----------|--------|----------------|--------|------------------------|
<!-- 翻译: 优先级 | 系统 | 建议路径 | 覆盖 | 尚未编写的原因 -->

## Quarantined Tests / 隔离测试

Tests that are flaky or disabled (do not run in CI): / 不稳定或禁用的测试（不在 CI 中运行）：

| Test File | Function | Reason | Quarantined Since |
|-----------|----------|--------|-------------------|
<!-- 翻译: 测试文件 | 函数 | 原因 | 隔离日期 -->
| (none) | | | |
```

---

## 7. Write Output / 7. 写入输出

Ask: "May I write/update `tests/regression-suite.md` with the current
regression suite manifest?"
> **中文翻译**：询问："我可以将当前回归测试套件清单写入/更新 `tests/regression-suite.md` 吗？"

For `update` mode: append new entries; never remove existing entries
(use `Edit` with targeted insertions).
> **中文翻译**：对于 `update` 模式：追加新条目；不要删除现有条目（使用 `Edit` 进行定向插入）。

For `audit` mode: rewrite the full manifest with updated coverage data.
> **中文翻译**：对于 `audit` 模式：用更新的覆盖数据重写完整清单。

For `report` mode: do not write anything.
> **中文翻译**：对于 `report` 模式：不写入任何内容。

After writing (if approved):
> **中文翻译**：写入后（如果批准）：

- For each HIGH priority gap: "Consider creating the missing regression test
  before the next sprint. Run `/test-helpers` to scaffold the test file." / 对于每个高优先级差距："考虑在下一个冲刺前创建缺失的回归测试。运行 `/test-helpers` 搭建测试文件。"
- If bug regression gaps > 0: "These bugs can silently return without regression
  tests. The next sprint should include a story to write the missing tests." / 如果缺陷回归差距 > 0："这些缺陷在没有回归测试的情况下可能悄然回归。下一个冲刺应包含编写缺失测试的故事。"
- If coverage drift detected: "Regression suite may be drifting. Consider
  running `/regression-suite audit` at the next sprint boundary." / 如果检测到覆盖漂移："回归测试套件可能在漂移。考虑在下一个冲刺边界运行 `/regression-suite audit`。"

Verdict: **COMPLETE** — regression suite updated. (If user declined write: Verdict: **BLOCKED**.)
> **中文翻译**：裁决：**COMPLETE** — 回归测试套件已更新。（如果用户拒绝写入：裁决：**BLOCKED**。）

---

## Collaborative Protocol / 协作协议

- **Never remove existing regression tests from the manifest** without
  explicit user approval — removing a test that was deliberately written is a
  regression risk itself / **绝不未经用户明确批准从清单中删除现有回归测试** — 删除有意编写的测试本身就是回归风险
- **Gaps are advisory, not blocking** — surface them clearly but do not prevent
  other work from proceeding (except at release gate where regression suite is required) / **差距是建议性的，而非阻塞性的** — 清晰展示但不阻止其他工作进展（发布门控要求回归测试套件的情况除外）
- **Quarantine is not deletion** — tests with intermittent failures should be
  quarantined (noted in manifest) but not removed; they should be fixed by
  `/test-flakiness` / **隔离不是删除** — 间歇性失败的测试应被隔离（在清单中注明）而非删除；它们应由 `/test-flakiness` 修复
- **Ask before writing** — always confirm before creating or updating the manifest / **写入前询问** — 在创建或更新清单前始终确认
