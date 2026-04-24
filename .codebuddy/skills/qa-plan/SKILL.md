---
name: qa-plan
description: "Generate a QA test plan for a sprint or feature. Reads GDDs and story files, classifies stories by test type (Logic/Integration/Visual/UI), and produces a structured test plan covering automated tests required, manual test cases, smoke test scope, and playtest sign-off requirements. Run before sprint begins or when starting a major feature. / 为冲刺或功能生成 QA 测试计划。读取 GDD 和故事文件，按测试类型（逻辑/集成/视觉/UI）分类故事，生成覆盖自动化测试要求、手动测试用例、冒烟测试范围和试玩签署要求的结构化测试计划。在冲刺开始前或启动重大功能时运行。"
argument-hint: "[sprint | feature: system-name | story: path]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, AskUserQuestion
agent: qa-lead
---

# QA Plan / QA 计划

This skill generates a structured QA plan for a sprint, feature, or individual
story. It reads all in-scope story files and their referenced GDDs, classifies
each story by test type, and produces a plan that tells developers exactly what
to automate, what to verify manually, what the smoke test scope is, and when
to bring in a playtester.
> **中文翻译**：此技能为冲刺、功能或单个故事生成结构化的 QA 计划。它读取所有范围内的故事文件及其引用的 GDD，按测试类型分类每个故事，并生成一个计划，告诉开发者确切地需要自动化什么、手动验证什么、冒烟测试范围是什么，以及何时引入试玩测试员。

Run this before a sprint begins so the team knows upfront what testing work
is required. A test plan written after implementation is a post-mortem, not a
plan.
> **中文翻译**：在冲刺开始前运行此技能，以便团队预先了解需要什么测试工作。实现后编写的测试计划是事后分析，而不是计划。

**Output:** `production/qa/qa-plan-[sprint-slug]-[date].md`
> **中文翻译**：**输出**：`production/qa/qa-plan-[sprint-slug]-[date].md`

---

## Phase 1: Parse Scope / 阶段 1：解析范围

**Argument:** `$ARGUMENTS` (blank = ask user via AskUserQuestion)
> **中文翻译**：**参数**：`$ARGUMENTS`（空白 = 通过 AskUserQuestion 询问用户）

Determine scope from the argument:
> **中文翻译**：从参数确定范围：

- **`sprint`** — read the most recent file in `production/sprints/`, extract
  every story file path referenced. If `production/sprint-status.yaml` exists,
  use it as the primary story list and fall back to the sprint plan for story
  metadata. / **`sprint`** — 读取 `production/sprints/` 中最新的文件，提取引用的每个故事文件路径。如果 `production/sprint-status.yaml` 存在，将其作为主要故事列表，回退到冲刺计划获取故事元数据。
- **`feature: [system-name]`** — glob `production/epics/*/story-*.md`, filter
  to stories whose file path or title contains the system name. Also check the
  epic index file (`EPIC.md`) in that system's directory. / **`feature: [系统名称]`** — 匹配 `production/epics/*/story-*.md`，过滤文件路径或标题包含系统名称的故事。同时检查该系统目录中的史诗索引文件（`EPIC.md`）。
- **`story: [path]`** — validate that the path exists and load that single file. / **`story: [路径]`** — 验证路径存在并加载该单个文件。
- **No argument** — use `AskUserQuestion`: / **无参数** — 使用 `AskUserQuestion`：
  - "What is the scope for this QA plan?" / "此 QA 计划的范围是什么？"
  - Options: "Current sprint", "Specific feature (enter system name)",
    "Specific story (enter path)", "Full epic" / 选项："当前冲刺"、"特定功能（输入系统名称）"、"特定故事（输入路径）"、"完整史诗"

After resolving scope, report: "Building QA plan for [N] stories in [scope]."
> **中文翻译**：解析范围后，报告："正在为 [范围] 中的 [N] 个故事构建 QA 计划。"

If a story file path is referenced but the file does not exist, note it as
MISSING and continue with the remaining stories. Do not fail the entire plan
for one missing file.
> **中文翻译**：如果引用的故事文件路径不存在，将其标记为 MISSING 并继续处理剩余故事。不要因一个缺失文件而使整个计划失败。

---

## Phase 2: Load Inputs / 阶段 2：加载输入

For each in-scope story file, read the full file and extract:
> **中文翻译**：对于每个范围内的故事文件，读取完整文件并提取：

- **Story title** and story ID (from filename or header) / **故事标题**和故事 ID（来自文件名或标题）
- **Story Type** field (if present in the file header — e.g., `Type: Logic`) / **故事类型**字段（如果文件标题中存在 — 例如 `Type: Logic`）
- **Acceptance criteria** — the complete numbered/bulleted list / **验收标准** — 完整的编号/项目列表
- **Implementation files** — listed under "Files to Create / Modify" or similar / **实现文件** — 列在"Files to Create / Modify"或类似标题下
- **Engine notes** — any engine API warnings or version-specific notes / **引擎注意事项** — 任何引擎 API 警告或版本特定说明
- **GDD reference** — the GDD path(s) cited / **GDD 引用** — 引用的 GDD 路径
- **ADR reference** — the ADR(s) cited / **ADR 引用** — 引用的 ADR
- **Estimate** — hours or story points if present / **估算** — 小时数或故事点（如果存在）
- **Dependencies** — other stories this one depends on / **依赖** — 此故事依赖的其他故事

After reading stories, load supporting context once (not per story):
> **中文翻译**：读取故事后，一次性加载支持上下文（而非每个故事）：

- `design/gdd/systems-index.md` — to understand system priorities and which
  GDDs are approved / 以了解系统优先级和哪些 GDD 已批准
- For each unique GDD referenced across all stories: read only the
  **Acceptance Criteria** and **Formulas** sections. Do not load full GDD text —
  these two sections contain the testable requirements and the math to verify. / 对于所有故事中引用的每个唯一 GDD：仅读取**验收标准**和**公式**章节。不要加载完整 GDD 文本 — 这两个章节包含可测试的需求和需要验证的数学公式。
- `docs/architecture/control-manifest.md` — scan for forbidden patterns that
  automated tests should guard against (if the file exists) / 扫描自动化测试应防范的禁止模式（如果文件存在）

If no GDD is referenced in a story, note it as a gap but do not block the plan.
The story will be classified using acceptance criteria alone.
> **中文翻译**：如果故事中没有引用 GDD，将其标记为差距但不阻塞计划。故事将仅使用验收标准进行分类。

---

## Phase 3: Classify Each Story / 阶段 3：分类每个故事

For each story, assign a Story Type. If the story already has a `Type:` field
in its header, use that value and validate it against the criteria below. If the
field is missing or ambiguous, infer the type from the acceptance criteria.
> **中文翻译**：为每个故事分配故事类型。如果故事的标题中已有 `Type:` 字段，使用该值并根据以下标准验证。如果字段缺失或模糊，从验收标准推断类型。

| Story Type | Classification Indicators |
|---|---|
| **Logic** | Acceptance criteria reference calculations, formulas, numerical thresholds, state transitions, AI decisions, data validation, buff/debuff stacking, economy transactions, or any testable computation |
| **Integration** | Criteria involve two or more systems interacting, signals or events propagating across system boundaries, save/load round-trips, network sync, or persistence |
| **Visual/Feel** | Criteria reference animation behaviour, VFX, shader output, "feels responsive", perceived timing, screen shake, particle effects, audio sync, or visual feedback quality |
| **UI** | Criteria reference menus, HUD elements, buttons, screens, dialogue boxes, inventory panels, tooltips, or any player-facing interface element |
| **Config/Data** | Changes are limited to balance tuning values, data files, or configuration — no new code logic is involved |

> **中文翻译**：
> | 故事类型 | 分类指标 |
> |---|---|
> | **逻辑** | 验收标准涉及计算、公式、数值阈值、状态转换、AI 决策、数据验证、buff/debuff 叠加、经济交易或任何可测试的计算 |
> | **集成** | 标准涉及两个或更多系统交互、信号或事件跨系统边界传播、保存/加载往返、网络同步或持久化 |
> | **视觉/手感** | 标准涉及动画行为、VFX、着色器输出、"手感响应"、感知时序、屏幕震动、粒子效果、音频同步或视觉反馈质量 |
> | **UI** | 标准涉及菜单、HUD 元素、按钮、屏幕、对话框、库存面板、工具提示或任何面向玩家的界面元素 |
> | **配置/数据** | 变更仅限于平衡调优值、数据文件或配置 — 不涉及新的代码逻辑 |

**Mixed stories** (e.g., a story that adds both a formula and a UI display):
assign the primary type based on which acceptance criteria carry the highest
implementation risk, and note the secondary type. Mixed Logic+Integration or
Visual+UI combinations are the most common.
> **中文翻译**：**混合故事**（例如同时添加公式和 UI 显示的故事）：根据实现风险最高的验收标准分配主类型，并注明次要类型。逻辑+集成或视觉+UI 的混合组合最为常见。

After classifying all stories, produce a classification summary table in
conversation before proceeding to Phase 4. This gives the user visibility into
how tests will be allocated.
> **中文翻译**：分类所有故事后，在进入阶段 4 之前在对话中生成分类摘要表。这让用户可以看到测试将如何分配。

---

## Phase 4: Generate Test Plan / 阶段 4：生成测试计划

Assemble the full QA plan document. Use this structure:
> **中文翻译**：组装完整的 QA 计划文档。使用此结构：

````markdown
# QA Plan: [Sprint/Feature Name]
**Date**: [date]
**Generated by**: /qa-plan
**Scope**: [N stories across [N systems]]
**Engine**: [engine name from .codebuddy/docs/technical-preferences.md, or "Not configured"]
**Sprint File**: [path to sprint plan if applicable]

---

## Test Summary

| Story | Type | Automated Test Required | Manual Verification Required |
|-------|------|------------------------|------------------------------|
| [story title] | Logic | Unit test — `tests/unit/[system]/` | None |
| [story title] | Integration | Integration test — `tests/integration/[system]/` | Smoke check |
| [story title] | Visual/Feel | None (not automatable) | Screenshot + lead sign-off |
| [story title] | UI | Interaction walkthrough | Manual step-through |
| [story title] | Config/Data | Data validation test | Spot-check in-game values |

---

## Automated Tests Required

### [Story Title] — [Type]
**Test file path**: `tests/[unit|integration]/[system]/[story-slug]_test.[ext]`
**What to test**:
- [Specific formula or rule from the GDD Formulas section]
- [Each named state transition or decision branch]
- [Each side effect that should or should not occur]

**Edge cases to cover**:
- Zero/minimum input values (e.g., 0 damage, empty inventory)
- Maximum/boundary input values (e.g., max level, stat cap)
- Invalid or null input (e.g., missing target, dead entity)
- [Any edge case explicitly called out in the GDD Edge Cases section]

**Estimated test count**: ~[N] unit tests

[If no GDD formula reference was found for this story, note:]
*No formula found in referenced GDD — test cases must be derived from acceptance
criteria directly. Review the GDD Formulas section before writing tests.*

---

## Manual QA Checklist

### [Story Title] — [Type]
**Verification method**: [Screenshot + designer sign-off | Playtest session |
Manual step-through | Comparison against reference footage]
**Who must sign off**: [designer / lead-programmer / qa-lead / art-lead]
**Evidence to capture**: [screenshot of X | video clip of Y | written playtest
notes | side-by-side comparison]

Checklist:
- [ ] [Specific observable condition — concrete and falsifiable]
- [ ] [Another condition]
- [ ] [Every acceptance criterion translated into a manual check item]

*If any criterion uses subjective language ("feels", "looks", "seems"), it must
be supplemented with a specific benchmark or a playtest protocol note.*

---

## Smoke Test Scope

Critical paths to verify before any QA hand-off for this sprint:

1. Game launches to main menu without crash
2. New game / new session can be started
3. [Primary mechanic introduced or changed this sprint]
4. [Any system with a regression risk from this sprint's changes]
5. Save / load cycle completes without data loss (if save system exists)
6. Performance is within budget on target hardware (no new frame spikes)

*Smoke tests are verified by the developer via `/smoke-check`. Reference this
list when running that skill.*

---

## Playtest Requirements

| Story | Playtest Goal | Min Sessions | Target Player Type |
|-------|--------------|--------------|-------------------|
| [story] | [What question must the session answer?] | [N] | [new player / experienced] |

**Sign-off requirement**: Playtest notes must be written to
`production/session-logs/playtest-[sprint]-[story-slug].md` and reviewed by
the [designer / qa-lead] before the story can be marked COMPLETE.

If no stories require playtest validation: *No playtest sessions required for
this sprint.*

---

## Definition of Done — This Sprint

A story is DONE when ALL of the following are true:

- [ ] All acceptance criteria verified — via automated test result OR documented
      manual evidence (screenshot, video, or playtest notes with sign-off)
- [ ] Test file exists at the specified path for all Logic and Integration stories
- [ ] Manual evidence document exists for all Visual/Feel and UI stories
- [ ] Smoke check passes (run `/smoke-check sprint` before QA hand-off)
- [ ] No regressions introduced
- [ ] Code reviewed (via `/code-review` or documented peer review)
- [ ] Story file updated to `Status: Complete` (via `/story-done`)
````

When generating content, use the actual story titles, GDD formula text, and
acceptance criteria extracted in Phase 2. Do not use placeholder text — every
test entry should reflect the real requirements of these specific stories.
> **中文翻译**：生成内容时，使用阶段 2 中提取的实际故事标题、GDD 公式文本和验收标准。不要使用占位符文本 — 每个测试条目应反映这些特定故事的真实需求。

---

## Phase 5: Write Output / 阶段 5：写入输出

Show the complete plan in conversation (or a summary if the plan is very long),
then ask:
> **中文翻译**：在对话中展示完整计划（如果计划很长则展示摘要），然后询问：

"May I write this QA plan to `production/qa/qa-plan-[sprint-slug]-[date].md`?"
> **中文翻译**："我可以将此 QA 计划写入 `production/qa/qa-plan-[sprint-slug]-[date].md` 吗？"

Write the plan exactly as generated — do not truncate.
> **中文翻译**：完全按生成的内容写入计划 — 不要截断。

After writing:
> **中文翻译**：写入后：

"QA plan written to `production/qa/qa-plan-[sprint-slug]-[date].md`.

Next steps:
- Share this plan with the team before sprint implementation begins
- Run `/smoke-check sprint` after all stories are implemented to gate QA hand-off
- For Logic/Integration stories, create the test files at the listed paths
  before marking stories done — `/story-done` checks for them"

> **中文翻译**：
> "QA 计划已写入 `production/qa/qa-plan-[sprint-slug]-[date].md`。
>
> 下一步：
> - 在冲刺实现开始前与团队分享此计划
> - 所有故事实现后运行 `/smoke-check sprint` 进行 QA 交接门控
> - 对于逻辑/集成故事，在标记故事完成前在列出的路径创建测试文件 — `/story-done` 会检查它们"

---

## Collaborative Protocol / 协作协议

- **Never write the plan without asking** — Phase 5 requires explicit approval. / **绝不未经询问就写入计划** — 阶段 5 需要明确批准。
- **Classify conservatively**: when a story is ambiguous between Logic and
  Integration, classify it as Integration — it requires both unit and
  integration tests. / **保守分类**：当故事在逻辑和集成之间模糊时，将其分类为集成 — 它需要单元测试和集成测试。
- **Do not invent test cases** beyond what acceptance criteria and GDD formulas
  support. If a formula is absent from the GDD, flag it rather than guessing. / **不要编造测试用例**超出验收标准和 GDD 公式支持的范围。如果 GDD 中缺少公式，标记它而不是猜测。
- **Playtest requirements are advisory**: the user decides whether a playtest
  is warranted for borderline Visual/Feel stories. Flag the case; do not mandate. / **试玩要求是建议性的**：用户决定边缘视觉/手感故事是否需要试玩。标记情况；不要强制。
- Use `AskUserQuestion` for scope selection when no argument is provided.
  Keep all other phases non-interactive — present findings, then ask once to
  approve the write. / 当没有提供参数时，使用 `AskUserQuestion` 进行范围选择。保持所有其他阶段非交互式 — 展示发现，然后一次询问批准写入。
