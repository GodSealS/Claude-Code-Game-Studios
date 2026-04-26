---
name: test-evidence-review
description: "Quality review of test files and manual evidence documents. Goes beyond existence checks — evaluates assertion coverage, edge case handling, naming conventions, and evidence completeness. Produces ADEQUATE/INCOMPLETE/MISSING verdict per story. Run before QA sign-off or on demand. / 测试文件和手动证据文档的质量审查。超越存在性检查 — 评估断言覆盖率、边界情况处理、命名约定和证据完整性。每个故事生成 ADEQUATE/INCOMPLETE/MISSING 裁决。在 QA 签署前或按需运行。"
argument-hint: "[story-path | sprint | system-name]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
---

# Test Evidence Review / 测试证据审查

`/smoke-check` verifies that test files **exist** and **pass**. This skill
goes further — it reviews the **quality** of those tests and evidence documents.
A test file that exists and passes may still leave critical behaviour uncovered.
A manual evidence doc that exists may lack the sign-offs required for closure.

> **中文翻译**：`/smoke-check` 验证测试文件**存在**且**通过**。此技能更进一步 — 它审查这些测试和证据文档的**质量**。一个存在且通过的测试文件仍可能遗漏关键行为。一个存在的手动证据文档可能缺少关闭所需的签署。

**Output:** Summary report (in conversation) + optional `production/qa/evidence-review-[date].md`

> **中文翻译**：**输出**：摘要报告（在对话中）+ 可选的 `production/qa/evidence-review-[date].md`

**When to run:** / **何时运行：**
- Before QA hand-off sign-off (`/team-qa` Phase 5) / QA 交接签署前（`/team-qa` 第 5 阶段）
- On any story where test quality is in question / 在测试质量有疑问的任何故事上
- As part of milestone review for Logic and Integration story quality audit / 作为里程碑审查的一部分，用于逻辑和集成故事质量审计

---

## 1. Parse Arguments / 第 1 步：解析参数

**Modes:** / **模式：**
- `/test-evidence-review [story-path]` — review a single story's evidence / 审查单个故事的证据
- `/test-evidence-review sprint` — review all stories in the current sprint / 审查当前冲刺中的所有故事
- `/test-evidence-review [system-name]` — review all stories in an epic/system / 审查史诗/系统中的所有故事
- No argument — ask which scope: "Single story", "Current sprint", "A system" / 无参数 — 询问范围："单个故事"、"当前冲刺"、"某个系统"

---

## 2. Load Stories in Scope / 第 2 步：加载范围内故事

Based on the argument: / 基于参数：

**Single story**: Read the story file directly. Extract: Story Type, Test / **单个故事**：直接读取故事文件。提取：故事类型、测试证据部分、故事标识、系统名称。
Evidence section, story slug, system name. / 

> **中文翻译**：**单个故事**：直接读取故事文件。提取：故事类型、测试证据部分、故事标识、系统名称。

**Sprint**: Read the most recently modified file in `production/sprints/`. / **冲刺**：读取 `production/sprints/` 中最近修改的文件。
Extract the list of story file paths from the sprint plan. Read each story file. / 从冲刺计划中提取故事文件路径列表。读取每个故事文件。

> **中文翻译**：**冲刺**：读取 `production/sprints/` 中最近修改的文件。从冲刺计划中提取故事文件路径列表。读取每个故事文件。

**System**: Glob `production/epics/[system-name]/story-*.md`. Read each. / **系统**：Glob `production/epics/[system-name]/story-*.md`。读取每个文件。

> **中文翻译**：**系统**：Glob `production/epics/[system-name]/story-*.md`。读取每个文件。

For each story, collect: / 对于每个故事，收集：

> **中文翻译**：对于每个故事，收集：
- `Type:` field (Logic / Integration / Visual/Feel / UI / Config/Data) / `Type:` 字段（逻辑 / 集成 / 视觉/感觉 / UI / 配置/数据）
- `## Test Evidence` section — the stated expected test file path or evidence doc / `## Test Evidence` 部分 — 声明的预期测试文件路径或证据文档
- Story slug (from file name) / 故事标识（从文件名）
- System name (from directory path) / 系统名称（从目录路径）
- Acceptance Criteria list (all checkbox items) / 验收标准列表（所有复选框项）

---

## 3. Locate Evidence Files / 第 3 步：定位证据文件

For each story, find the evidence: / 对于每个故事，查找证据：

> **中文翻译**：对于每个故事，查找证据：

**Logic stories**: Glob `tests/unit/[system]/[story-slug]_test.*` / **逻辑故事**：Glob `tests/unit/[system]/[story-slug]_test.*`
  - If not found, also try: Grep in `tests/unit/[system]/` for files / 如果未找到，还可尝试：在 `tests/unit/[system]/` 中使用 Grep 查找包含故事标识的文件
    containing the story slug / 

**Integration stories**: Glob `tests/integration/[system]/[story-slug]_test.*` / **集成故事**：Glob `tests/integration/[system]/[story-slug]_test.*`
  - Also check `production/session-logs/` for playtest records mentioning the story / 还检查 `production/session-logs/` 中提及故事的游玩测试记录

**Visual/Feel and UI stories**: Glob `production/qa/evidence/[story-slug]-evidence.*` / **视觉/感觉和 UI 故事**：Glob `production/qa/evidence/[story-slug]-evidence.*`

**Config/Data stories**: Glob `production/qa/smoke-*.md` (any smoke check report) / **配置/数据故事**：Glob `production/qa/smoke-*.md`（任何冒烟检查报告）

Note what was found (path) or not found (gap) for each story. / 注意每个故事找到的内容（路径）或未找到的内容（差距）。

> **中文翻译**：注意每个故事找到的内容（路径）或未找到的内容（差距）。

---

## 4. Review Automated Test Quality (Logic / Integration) / 第 4 步：审查自动化测试质量（逻辑 / 集成）

For each test file found, read it and evaluate: / 对于找到的每个测试文件，读取并评估：

> **中文翻译**：对于找到的每个测试文件，读取并评估：

### Assertion coverage / 断言覆盖率

Count the number of distinct assertions (lines containing assert, expect, / 计算不同断言的数量（包含 assert、expect、
check, verify, or engine-specific assertion patterns). Low assertion count is / check、verify 或引擎特定断言模式的行）。断言数量低是
a quality signal — a test that makes only 1 assertion per test function may / 质量信号 — 每个测试函数仅进行 1 个断言的测试可能
not cover the range of expected behaviour. / 未覆盖预期的行为范围。

Thresholds: / 阈值：
- **3+ assertions per test function** → normal / **每个测试函数 3+ 个断言** → 正常
- **1-2 assertions per test function** → note as potentially thin / **每个测试函数 1-2 个断言** → 标记为可能薄弱
- **0 assertions** (test exists but no asserts) → flag as BLOCKING — the / **0 个断言**（测试存在但无断言）→ 标记为 BLOCKING — 该
  test passes vacuously and proves nothing / 测试空洞地通过，什么也未证明

### Edge case coverage / 边界情况覆盖率

For each acceptance criterion in the story that contains a number, threshold, / 对于故事中包含数字、阈值或"当 X 发生时"条件的每个验收标准：
or "when X happens" conditional: check whether a test function name or / 检查测试函数名称或测试正文是否引用该特定情况。
test body references that specific case. / 

Heuristics: / 启发式方法：
- Grep test file for "zero", "max", "null", "empty", "min", "invalid", / 使用 grep 在测试文件中查找 "zero"、"max"、"null"、"empty"、"min"、"invalid"、
  "boundary", "edge" — presence of any is a positive signal / "boundary"、"edge" — 存在任何都是积极信号
- If the story has a Formulas section with specific bounds: check whether / 如果故事有具有特定边界的公式部分：检查
  tests exercise at minimum/maximum values / 测试是否在最小值/最大值上执行

### Naming quality / 命名质量

Test function names should describe: the scenario + the expected result. / 测试函数名称应描述：场景 + 预期结果。
Pattern: `test_[scenario]_[expected_outcome]` / 模式：`test_[scenario]_[expected_outcome]`

Flag functions named generically (`test_1`, `test_run`, `testBasic`) as / 标记通用命名的函数（`test_1`、`test_run`、`testBasic`）为
**naming issues** — they make failures harder to diagnose. / **命名问题** — 它们使故障更难诊断。

### Formula traceability / 公式可追溯性

For Logic stories where the GDD has a Formulas section: check that the test / 对于 GDD 有公式部分的逻辑故事：检查测试
file contains at least one test whose name or comment references the formula / 文件是否包含至少一个名称或注释引用公式名称或公式值的测试。
name or a formula value. A test that exercises a formula without mentioning / 执行公式但未提及公式名称的测试在公式更改时更难维护。
it by name is harder to maintain when the formula changes. / 

---

## 5. Review Manual Evidence Quality (Visual/Feel / UI) / 第 5 步：审查手动证据质量（视觉/感觉 / UI）

For each evidence document found, read it and evaluate: / 对于找到的每个证据文档，读取并评估：

> **中文翻译**：对于找到的每个证据文档，读取并评估：

### Criterion linkage / 标准关联

The evidence doc should reference each acceptance criterion from the story. / 证据文档应引用故事中的每个验收标准。
Check: does the evidence doc contain each criterion (or a clear rephrasing)? / 检查：证据文档是否包含每个标准（或清晰的改写）？
Missing criteria mean a criterion was never verified. / 缺失标准意味着标准从未被验证。

### Sign-off completeness / 签署完整性

Check for three sign-off lines (or equivalent fields): / 检查三行签署（或等效字段）：
- Developer sign-off / 开发者签署
- Designer / art-lead sign-off (for Visual/Feel) / 设计师/美术主管签署（对于视觉/感觉）
- QA lead sign-off / QA 主管签署

If any are missing or blank: flag as INCOMPLETE — the story cannot be fully / 如果任何缺失或为空：标记为 INCOMPLETE — 故事无法在没有所有必需签署的情况下完全关闭。
closed without all required sign-offs. / 

### Screenshot / artefact completeness / 截图/工件完整性

For Visual/Feel stories: check whether screenshot file paths are referenced / 对于视觉/感觉故事：检查证据文档是否引用截图文件路径。
in the evidence doc. If referenced, Glob for them to confirm they exist. / 如果引用，使用 Glob 查找以确认它们存在。

For UI stories: check whether a walkthrough sequence (step-by-step interaction / 对于 UI 故事：检查是否存在演练序列（逐步交互日志）。
log) is present. / 

### Date coverage / 日期覆盖

Evidence doc should have a date. If the date is earlier than the story's / 证据文档应有日期。如果日期早于故事的最后主要更改
last major change (heuristic: compare against sprint start date from the sprint / （启发式：与冲刺计划中的冲刺开始日期比较），标记为 POTENTIALLY STALE —
plan), flag as POTENTIALLY STALE — the evidence may not cover the final / 证据可能未覆盖最终实现。
implementation. / 

---

## 6. Build the Review Report / 第 6 步：构建审查报告

For each story, assign a verdict: / 为每个故事分配裁决：

> **中文翻译**：为每个故事分配裁决：

| Verdict | Meaning | / 裁决 | 含义 |
|---------|---------|
| **ADEQUATE** | Test/evidence exists, passes quality checks, all criteria covered | / **充足** | 测试/证据存在，通过质量检查，覆盖所有标准 |
| **INCOMPLETE** | Test/evidence exists but has quality gaps (thin assertions, missing sign-offs) | / **不完整** | 测试/证据存在但存在质量差距（薄弱断言、缺失签署） |
| **MISSING** | No test or evidence found for a story type that requires it | / **缺失** | 对于需要它的故事类型未找到测试或证据 |

The overall sprint/system verdict is the worst story verdict present. / 整体冲刺/系统裁决是存在的最差故事裁决。

```markdown
## Test Evidence Review / 测试证据审查

> **Date**: [date] / **日期**：[date]
> **Scope**: [single story path | Sprint [N] | [system name]] / **范围**：[单个故事路径 | 冲刺 [N] | [系统名称]]
> **Stories reviewed**: [N] / **审查故事数**：[N]
> **Overall verdict**: ADEQUATE / INCOMPLETE / MISSING / **整体裁决**：充足 / 不完整 / 缺失

---

### Story-by-Story Results / 逐故事结果

#### [Story Title] — [Type] — [ADEQUATE/INCOMPLETE/MISSING] / [故事标题] — [类型] — [充足/不完整/缺失]

**Test/evidence path**: `[path]` (found) / (not found) / **测试/证据路径**：`[路径]`（找到）/（未找到）

**Automated test quality** *(Logic/Integration only)*: / **自动化测试质量**（仅逻辑/集成）：
- Assertion coverage: [N per function on average] — [adequate / thin / none] / 断言覆盖率：[平均每个函数 N 个] — [充足 / 薄弱 / 无]
- Edge cases: [covered / partial / not found] / 边界情况：[覆盖 / 部分 / 未找到]
- Naming: [consistent / [N] generic names flagged] / 命名：[一致 / 标记了 [N] 个通用名称]
- Formula traceability: [yes / no — formula names not referenced in tests] / 公式可追溯性：[是 / 否 — 测试中未引用公式名称]

**Manual evidence quality** *(Visual/Feel/UI only)*: / **手动证据质量**（仅视觉/感觉/UI）：
- Criterion linkage: [N/M criteria referenced] / 标准关联：[引用 N/M 个标准]
- Sign-offs: [Developer ✓ | Designer ✗ | QA Lead ✗] / 签署：[开发者 ✓ | 设计师 ✗ | QA 主管 ✗]
- Artefacts: [screenshots present / missing / N/A] / 工件：[截图存在 / 缺失 / 不适用]
- Freshness: [dated [date] — current / potentially stale] / 新鲜度：[日期 [date] — 当前 / 可能过时]

**Issues**: / **问题**：
- BLOCKING: [description] *(prevents story-done)* / 阻碍：[描述]（阻止故事完成）
- ADVISORY: [description] *(should fix before release)* / 建议：[描述]（应在发布前修复）

---

### Summary / 摘要

| Story | Type | Verdict | Issues | / 故事 | 类型 | 裁决 | 问题 |
|-------|------|---------|--------|
| [title] | Logic | ADEQUATE | None | / [标题] | 逻辑 | 充足 | 无 |
| [title] | Integration | INCOMPLETE | Thin assertions (avg 1.2/function) | / [标题] | 集成 | 不完整 | 薄弱断言（平均每个函数 1.2 个） |
| [title] | Visual/Feel | INCOMPLETE | QA lead sign-off missing | / [标题] | 视觉/感觉 | 不完整 | QA 主管签署缺失 |
| [title] | Logic | MISSING | No test file found | / [标题] | 逻辑 | 缺失 | 未找到测试文件 |

**BLOCKING items** (must resolve before story can be closed): [N] / **阻碍项**（故事关闭前必须解决）：[N]
**ADVISORY items** (should address before release): [N] / **建议项**（发布前应处理）：[N]
```

---

## 7. Write Output (Optional) / 第 7 步：写入输出（可选）

Present the report in conversation. / 在对话中呈现报告。

> **中文翻译**：在对话中呈现报告。

Ask: "May I write this test evidence review to / 询问："我可以将此测试证据审查写入
`production/qa/evidence-review-[date].md`?" / `production/qa/evidence-review-[date].md` 吗？"

This is optional — the report is useful standalone. Write only if the user / 这是可选的 — 报告独立即可使用。仅当用户需要持久记录时才写入。
wants a persistent record. / 

> **中文翻译**：这是可选的 — 报告独立即可使用。仅当用户需要持久记录时才写入。

After the report: / 报告之后：

> **中文翻译**：报告之后：
- For BLOCKING items: "These must be resolved before `/story-done` can mark the / 对于阻碍项："这些必须在 `/story-done` 标记故事完成之前解决。你想现在处理其中任何一个吗？"
  story Complete. Would you like to address any of them now?" / 
- For thin assertions: "Consider running `/test-helpers [system]` to see / 对于薄弱断言："考虑运行 `/test-helpers [system]` 查看常见情况的脚手架断言模式。"
  scaffolded assertion patterns for common cases." / 
- For missing sign-offs: "Manual sign-off is required from [role]. Share / 对于缺失签署："需要来自 [角色] 的手动签署。与他们分享 `[证据路径]` 以完成签署。"
  `[evidence-path]` with them to complete sign-off." / 

Verdict: **COMPLETE** — evidence review finished. Use CONCERNS if BLOCKING items were found. / 裁决：**COMPLETE** — 证据审查完成。如果发现阻碍项则使用 CONCERNS。

> **中文翻译**：裁决：**COMPLETE** — 证据审查完成。如果发现阻碍项则使用 CONCERNS。

---

## Collaborative Protocol / 协作协议

- **Report quality issues, do not fix them** — this skill reads and evaluates; / **报告质量问题，不要修复它们** — 此技能读取和评估；
  it does not modify test files or evidence documents / 它不修改测试文件或证据文档
- **ADEQUATE means adequate for shipping, not perfect** — avoid nitpicking / **充足意味着足够发布，而非完美** — 避免对功能正常且足够全面的测试吹毛求疵
  tests that are functioning and comprehensive enough to give confidence / 
- **BLOCKING vs. ADVISORY distinction is important** — only flag BLOCKING when / **阻碍与建议的区别很重要** — 仅当差距导致故事标准真正未验证时才标记阻碍
  the gap leaves a story criterion genuinely unverified / 
- **Ask before writing** — the report file is optional; always confirm before writing / **写入前询问** — 报告文件是可选的；写入前始终确认