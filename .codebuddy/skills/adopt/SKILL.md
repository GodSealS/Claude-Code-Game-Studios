---
name: adopt
description: "Brownfield onboarding — audits existing project artifacts for template format compliance (not just existence), classifies gaps by impact, and produces a numbered migration plan. Run this when joining an in-progress project or upgrading from an older template version. Distinct from /project-stage-detect (which checks what exists) — this checks whether what exists will actually work with the template's skills. / 棕地引导入门 — 审计现有项目工件的模板格式合规性（不仅是存在性），按影响分类差距，并生成编号的迁移计划。当加入进行中的项目或从旧版模板升级时运行。与 /project-stage-detect（检查什么存在）不同 — 这个检查现有内容是否能真正与模板的技能配合工作。"
argument-hint: "[focus: full | gdds | adrs | stories | infra]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, AskUserQuestion
agent: technical-director
---

# Adopt — Brownfield Template Adoption / 采用 — 棕地模板适配

This skill audits an existing project's artifacts for **format compliance** with
the template's skill pipeline, then produces a prioritised migration plan.
> **中文翻译**：此技能审计现有项目工件的**格式合规性**，检查其是否符合模板的技能管线，然后生成一个优先排序的迁移计划。

**This is not `/project-stage-detect`.**
`/project-stage-detect` answers: *what exists?*
`/adopt` answers: *will what exists actually work with the template's skills?*
> **中文翻译**：**这不是 `/project-stage-detect`。** `/project-stage-detect` 回答：*存在什么？* `/adopt` 回答：*存在的内容是否真的能与模板的技能配合工作？*

A project can have GDDs, ADRs, and stories — and every format-sensitive skill
will still fail silently or produce wrong results if those artifacts are in the
wrong internal format.
> **中文翻译**：一个项目可以有 GDD、ADR 和故事 — 但如果这些工件的内部格式不正确，每个格式敏感的技能仍然会静默失败或产生错误结果。

**Output:** `docs/adoption-plan-[date].md` — a persistent, checkable migration plan.
> **中文翻译**：**输出：** `docs/adoption-plan-[date].md` — 一个持久的、可检查的迁移计划。

**Argument modes:**
> **中文翻译**：**参数模式：**

**Audit mode:** `$ARGUMENTS[0]` (blank = `full`)
> **中文翻译**：**审计模式：** `$ARGUMENTS[0]`（空 = `full`）

- **No argument / `full`**: Complete audit — all artifact types / **无参数 / `full`**：完整审计 — 所有工件类型
- **`gdds`**: GDD format compliance only / **`gdds`**：仅 GDD 格式合规性
- **`adrs`**: ADR format compliance only / **`adrs`**：仅 ADR 格式合规性
- **`stories`**: Story format compliance only / **`stories`**：仅故事格式合规性
- **`infra`**: Infrastructure artifact gaps only (registry, manifest, sprint-status, stage.txt) / **`infra`**：仅基础设施工件差距（注册表、清单、冲刺状态、阶段文件）

---

## Phase 1: Detect Project State / 第 1 阶段：检测项目状态

Emit one line before reading: `"Scanning project artifacts..."` — this confirms the
skill is running during the silent read phase.
> **中文翻译**：在读取之前输出一行：`"Scanning project artifacts..."` — 这确认技能在静默读取阶段正在运行。

Then read silently before presenting anything else.
> **中文翻译**：在呈现任何其他内容之前静默读取。

### Existence check / 存在性检查
- `production/stage.txt` — if present, read it (authoritative phase) / `production/stage.txt` — 如果存在，读取它（权威阶段）
- `design/gdd/game-concept.md` — concept exists? / 游戏概念是否存在？
- `design/gdd/systems-index.md` — systems index exists? / 系统索引是否存在？
- Count GDD files: `design/gdd/*.md` (excluding game-concept.md and systems-index.md) / 计数 GDD 文件：`design/gdd/*.md`（排除 game-concept.md 和 systems-index.md）
- Count ADR files: `docs/architecture/adr-*.md` / 计数 ADR 文件
- Count story files: `production/epics/**/*.md` (excluding EPIC.md) / 计数故事文件
- `.codebuddy/docs/technical-preferences.md` — engine configured? / 引擎是否已配置？
- `docs/engine-reference/` — engine reference docs present? / 引擎参考文档是否存在？
- Glob `docs/adoption-plan-*.md` — note the filename of the most recent prior plan if any exist / Glob `docs/adoption-plan-*.md` — 如果存在，记录最近先前计划的文件名

### Infer phase (if no stage.txt) / 推断阶段（如果没有 stage.txt）
Use the same heuristic as `/project-stage-detect`:
> **中文翻译**：使用与 `/project-stage-detect` 相同的启发式方法：

- 10+ source files in `src/` → Production / `src/` 中有 10+ 源文件 → 生产阶段
- Stories in `production/epics/` → Pre-Production / `production/epics/` 中有故事 → 预生产阶段
- ADRs exist → Technical Setup / ADR 存在 → 技术设置阶段
- systems-index.md exists → Systems Design / systems-index.md 存在 → 系统设计阶段
- game-concept.md exists → Concept / game-concept.md 存在 → 概念阶段
- Nothing → Fresh (not a brownfield project — suggest `/start`) / 无 → 全新项目（不是棕地项目 — 建议运行 `/start`）

If the project appears fresh (no artifacts at all), use `AskUserQuestion`:
> **中文翻译**：如果项目看起来是全新的（没有任何工件），使用 `AskUserQuestion`：

- "This looks like a fresh project — no existing artifacts found. `/adopt` is for
  projects with work to migrate. What would you like to do?"
  > **中文翻译**："这看起来是一个全新项目 — 未找到现有工件。`/adopt` 适用于有工作要迁移的项目。你想做什么？"
  - "Run `/start` — begin guided first-time onboarding" / "运行 `/start` — 开始引导式首次入门"
  - "My artifacts are in a non-standard location — help me find them" / "我的工件在非标准位置 — 帮我找到它们"
  - "Cancel" / "取消"

Then stop — do not proceed with the audit regardless of which option the user picks
(each option leads to a different skill or manual investigation).
> **中文翻译**：然后停止 — 无论用户选择哪个选项，都不要继续审计（每个选项都指向不同的技能或手动调查）。

Report: "Detected phase: [phase]. Found: [N] GDDs, [M] ADRs, [P] stories."
> **中文翻译**：报告："检测到阶段：[阶段]。找到：[N] 个 GDD，[M] 个 ADR，[P] 个故事。"

---

## Phase 2: Format Audit / 第 2 阶段：格式审计

For each artifact type in scope (based on argument mode), check not just that
the file exists but that it contains the internal structure the template requires.
> **中文翻译**：对于范围内的每种工件类型（基于参数模式），不仅检查文件是否存在，还要检查其是否包含模板所需的内部结构。

### 2a: GDD Format Audit / 2a: GDD 格式审计

For each GDD file found, check for the 8 required sections by scanning headings:
> **中文翻译**：对于找到的每个 GDD 文件，通过扫描标题检查 8 个必需章节：

| Required Section | Heading pattern to look for |
|---|---|
| Overview | `## Overview` |
| Player Fantasy | `## Player Fantasy` |
| Detailed Rules / Design | `## Detailed` or `## Core Rules` or `## Detailed Design` |
| Formulas | `## Formulas` or `## Formula` |
| Edge Cases | `## Edge Cases` |
| Dependencies | `## Dependencies` or `## Depends` |
| Tuning Knobs | `## Tuning` |
| Acceptance Criteria | `## Acceptance` |

For each GDD, record:
> **中文翻译**：对于每个 GDD，记录：

- Which sections are present / 哪些章节存在
- Which sections are missing / 哪些章节缺失
- Whether it has any content in present sections or just placeholder text
  (`[To be designed]` or equivalent) / 已有章节中是否有实际内容或仅是占位符文本（`[To be designed]` 或类似内容）

Also check: does each GDD have a `**Status**:` field in its header block?
Valid values: `In Design`, `Designed`, `In Review`, `Approved`, `Needs Revision`.
> **中文翻译**：还要检查：每个 GDD 的标题块中是否有 `**Status**:` 字段？有效值：`In Design`、`Designed`、`In Review`、`Approved`、`Needs Revision`。

### 2b: ADR Format Audit / 2b: ADR 格式审计

For each ADR file found, check for these critical sections:
> **中文翻译**：对于找到的每个 ADR 文件，检查这些关键章节：

| Section | Impact if missing |
|---|---|
| `## Status` | **BLOCKING** — `/story-readiness` ADR status check silently passes everything / **阻塞** — `/story-readiness` ADR 状态检查会静默通过所有内容 |
| `## ADR Dependencies` | HIGH — dependency ordering in `/architecture-review` breaks / 高 — `/architecture-review` 中的依赖排序将失效 |
| `## Engine Compatibility` | HIGH — post-cutoff API risk is unknown / 高 — 截断后 API 风险未知 |
| `## GDD Requirements Addressed` | MEDIUM — traceability matrix loses coverage / 中 — 可追溯性矩阵丢失覆盖 |
| `## Performance Implications` | LOW — not pipeline-critical / 低 — 非管线关键 |

For each ADR, record: which sections present, which missing, current Status value
if the Status section exists.
> **中文翻译**：对于每个 ADR，记录：哪些章节存在、哪些缺失、如果 Status 章节存在则记录当前 Status 值。

### 2c: systems-index.md Format Audit / 2c: systems-index.md 格式审计

If `design/gdd/systems-index.md` exists:
> **中文翻译**：如果 `design/gdd/systems-index.md` 存在：

1. **Parenthetical status values** — Grep for any Status cell containing
   parentheses: `"Needs Revision ("`, `"In Progress ("`, etc.
   These break exact-string matching in `/gate-check`, `/create-stories`,
   and `/architecture-review`. **BLOCKING.**
   > **中文翻译**：**括号状态值** — Grep 搜索任何包含括号的 Status 单元格：`"Needs Revision ("`、`"In Progress ("` 等。这些会破坏 `/gate-check`、`/create-stories` 和 `/architecture-review` 中的精确字符串匹配。**阻塞。**

2. **Valid status values** — check that Status column values are only from:
   `Not Started`, `In Progress`, `In Review`, `Designed`, `Approved`, `Needs Revision`
   Flag any unrecognised values.
   > **中文翻译**：**有效状态值** — 检查 Status 列值是否仅来自：`Not Started`、`In Progress`、`In Review`、`Designed`、`Approved`、`Needs Revision`。标记任何无法识别的值。

3. **Column structure** — check that the table has at minimum: System name,
   Layer, Priority, Status columns. Missing columns degrade skill functionality.
   > **中文翻译**：**列结构** — 检查表格至少包含：系统名称、层级、优先级、状态列。缺少列会降低技能功能。

### 2d: Story Format Audit / 2d: 故事格式审计

For each story file found:
> **中文翻译**：对于找到的每个故事文件：

- **`Manifest Version:` field** — present in story header? (LOW — auto-passes if absent) / **`Manifest Version:` 字段** — 故事标题中是否存在？（低 — 缺失时自动通过）
- **TR-ID reference** — does story contain `TR-[a-z]+-[0-9]+` pattern? (MEDIUM — no staleness tracking) / **TR-ID 引用** — 故事是否包含 `TR-[a-z]+-[0-9]+` 模式？（中 — 无过时跟踪）
- **ADR reference** — does story reference at least one ADR? (check for `ADR-` pattern) / **ADR 引用** — 故事是否引用至少一个 ADR？（检查 `ADR-` 模式）
- **Status field** — present and readable? / **Status 字段** — 是否存在且可读？
- **Acceptance criteria** — does the story have a checkbox list (`- [ ]`)? / **验收标准** — 故事是否有复选框列表（`- [ ]`）？

### 2e: Infrastructure Audit / 2e: 基础设施审计

| Artifact | Path | Impact if missing |
|---|---|---|
| TR registry | `docs/architecture/tr-registry.yaml` | HIGH — no stable requirement IDs / 高 — 无稳定需求 ID |
| Control manifest | `docs/architecture/control-manifest.md` | HIGH — no layer rules for stories / 高 — 故事无层级规则 |
| Manifest version stamp | In manifest header: `Manifest Version:` | MEDIUM — staleness checks blind / 中 — 过时检查盲区 |
| Sprint status | `production/sprint-status.yaml` | MEDIUM — `/sprint-status` falls back to markdown / 中 — `/sprint-status` 回退到 markdown |
| Stage file | `production/stage.txt` | MEDIUM — phase auto-detect unreliable / 中 — 阶段自动检测不可靠 |
| Engine reference | `docs/engine-reference/[engine]/VERSION.md` | HIGH — ADR engine checks blind / 高 — ADR 引擎检查盲区 |
| Architecture traceability | `docs/architecture/architecture-traceability.md` | MEDIUM — no persistent matrix / 中 — 无持久矩阵 |

### 2f: Technical Preferences Audit / 2f: 技术偏好审计

Read `.codebuddy/docs/technical-preferences.md`. Check each field for `[TO BE CONFIGURED]`:
> **中文翻译**：读取 `.codebuddy/docs/technical-preferences.md`。检查每个字段是否为 `[TO BE CONFIGURED]`：

- Engine, Language, Rendering, Physics → HIGH if unconfigured (ADR skills fail) / Engine、Language、Rendering、Physics → 未配置时为高（ADR 技能将失败）
- Naming conventions → MEDIUM / 命名约定 → 中
- Performance budgets → MEDIUM / 性能预算 → 中
- Forbidden Patterns, Allowed Libraries → LOW (starts empty by design) / 禁止模式、允许库 → 低（设计上初始为空）

---

## Phase 3: Classify and Prioritise Gaps / 第 3 阶段：分类和优先排序差距

Organise every gap found across all audits into four severity tiers:
> **中文翻译**：将所有审计中发现的差距组织为四个严重级别：

**BLOCKING** — Will cause template skills to silently produce wrong results *right now*.
Examples: ADR missing Status field, systems-index parenthetical status values,
engine not configured when ADRs exist.
> **中文翻译**：**阻塞** — 会导致模板技能*立即*静默产生错误结果。示例：ADR 缺少 Status 字段、systems-index 中有括号状态值、存在 ADR 但引擎未配置。

**HIGH** — Will cause stories to be generated with missing safety checks, or
infrastructure bootstrapping will fail.
Examples: ADRs missing Engine Compatibility, GDDs missing Acceptance Criteria
(stories can't be generated from them), tr-registry.yaml missing.
> **中文翻译**：**高** — 会导致生成的故事缺少安全检查，或基础设施引导将失败。示例：ADR 缺少 Engine Compatibility、GDD 缺少 Acceptance Criteria（无法从中生成故事）、tr-registry.yaml 缺失。

**MEDIUM** — Degrades quality and pipeline tracking but does not break functionality.
Examples: GDDs missing Tuning Knobs or Formulas sections, stories missing TR-IDs,
sprint-status.yaml missing.
> **中文翻译**：**中** — 降低质量和管线跟踪但不破坏功能。示例：GDD 缺少 Tuning Knobs 或 Formulas 章节、故事缺少 TR-ID、sprint-status.yaml 缺失。

**LOW** — Retroactive improvements that are nice-to-have but not urgent.
Examples: Stories missing Manifest Version stamps, GDDs missing Open Questions section.
> **中文翻译**：**低** — 可有可无的追溯性改进，不紧急。示例：故事缺少 Manifest Version 标记、GDD 缺少 Open Questions 章节。

Count totals per tier. If zero BLOCKING and zero HIGH gaps: report that the project
is template-compatible and only advisory improvements remain.
> **中文翻译**：按级别计算总数。如果零个阻塞和零个高级别差距：报告项目与模板兼容，仅剩建议性改进。

---

## Phase 4: Build the Migration Plan / 第 4 阶段：构建迁移计划

Compose a numbered, ordered action plan. Ordering rules:
> **中文翻译**：编写一个编号的、有序的行动计划。排序规则：

1. BLOCKING gaps first (must fix before any pipeline skill runs reliably) / 阻塞差距优先（必须在任何管线技能可靠运行之前修复）
2. HIGH gaps next, infrastructure before GDD/ADR content (bootstrapping needs correct formats) / 高级别差距其次，基础设施在 GDD/ADR 内容之前（引导需要正确格式）
3. MEDIUM gaps ordered: GDD gaps before ADR gaps before story gaps (stories depend on GDDs and ADRs) / 中级别差距排序：GDD 差距在 ADR 差距之前在故事差距之前（故事依赖于 GDD 和 ADR）
4. LOW gaps last / 低级别差距最后

For each gap, produce a plan entry with:
> **中文翻译**：对于每个差距，生成一个计划条目，包含：

- A clear problem statement (one sentence, no jargon) / 一个清晰的问题陈述（一句话，不用行话）
- The exact command to fix it, if a skill handles it / 修复它的确切命令，如果有技能处理
- Manual steps if it requires direct editing / 如果需要直接编辑的手动步骤
- A time estimate (rough: 5 min / 30 min / 1 session) / 时间估算（粗略：5 分钟 / 30 分钟 / 1 个会话）
- A checkbox `- [ ]` for tracking / 用于跟踪的复选框 `- [ ]`

**Special case — systems-index parenthetical status values:**
This is always the first item if present. Show the exact values that need changing
and the exact replacement text. Offer to fix this immediately before writing the plan.
> **中文翻译**：**特殊情况 — systems-index 中的括号状态值：** 如果存在，这始终是第一个条目。显示需要更改的确切值和确切的替换文本。提供在写入计划之前立即修复此问题。

**Special case — ADRs missing Status field:**
For each affected ADR, the fix is:
`/architecture-decision retrofit docs/architecture/adr-[NNNN]-[slug].md`
List each ADR as a separate checkable item.
> **中文翻译**：**特殊情况 — ADR 缺少 Status 字段：** 对于每个受影响的 ADR，修复方法是：`/architecture-decision retrofit docs/architecture/adr-[NNNN]-[slug].md` 将每个 ADR 列为单独的可勾选项。

**Special case — GDDs missing sections:**
For each affected GDD, list which sections are missing and the fix:
`/design-system retrofit design/gdd/[filename].md`
> **中文翻译**：**特殊情况 — GDD 缺少章节：** 对于每个受影响的 GDD，列出缺失的章节和修复方法：`/design-system retrofit design/gdd/[filename].md`

**Infrastructure bootstrap ordering** — always present in this sequence:
> **中文翻译**：**基础设施引导排序** — 始终按以下顺序呈现：

1. Fix ADR formats first (registry depends on reading ADR Status fields) / 首先修复 ADR 格式（注册表依赖读取 ADR Status 字段）
2. Run `/architecture-review` → bootstraps `tr-registry.yaml` / 运行 `/architecture-review` → 引导 `tr-registry.yaml`
3. Run `/create-control-manifest` → creates manifest with version stamp / 运行 `/create-control-manifest` → 创建带版本标记的清单
4. Run `/sprint-plan update` → creates `sprint-status.yaml` / 运行 `/sprint-plan update` → 创建 `sprint-status.yaml`
5. Run `/gate-check [phase]` → writes `stage.txt` authoritatively / 运行 `/gate-check [phase]` → 权威地写入 `stage.txt`

**Existing stories** — note explicitly:
> **中文翻译**：**现有故事** — 明确注明：

> "Existing stories continue to work with all template skills — all new format
> checks auto-pass when the fields are absent. They won't benefit from TR-ID
> staleness tracking or manifest version checks until they're regenerated. This
> is intentional: do not regenerate stories that are already in progress."
> **中文翻译**："现有故事继续与所有模板技能配合工作 — 当字段缺失时，所有新格式检查自动通过。它们在重新生成之前不会受益于 TR-ID 过时跟踪或清单版本检查。这是有意为之的：不要重新生成已在进行中的故事。"

---

## Phase 5: Present Summary and Ask to Write / 第 5 阶段：呈现摘要并请求写入

Present a compact summary before writing:
> **中文翻译**：在写入之前呈现一个简洁的摘要：

```
## Adoption Audit Summary
Phase detected: [phase]
Engine: [configured / NOT CONFIGURED]
GDDs audited: [N] ([X] fully compliant, [Y] with gaps)
ADRs audited: [N] ([X] fully compliant, [Y] with gaps)
Stories audited: [N]

Gap counts:
  BLOCKING: [N] — template skills will malfunction without these fixes
  HIGH:     [N] — unsafe to run /create-stories or /story-readiness
  MEDIUM:   [N] — quality degradation
  LOW:      [N] — optional improvements

Estimated remediation: [X blocking items × ~Y min each = roughly Z hours]
```

Before asking to write, show a **Gap Preview**:
> **中文翻译**：在请求写入之前，显示**差距预览**：

- List every BLOCKING gap as a one-line bullet describing the actual problem
  (e.g. `systems-index.md: 3 rows have parenthetical status values`,
  `adr-0002.md: missing ## Status section`). No counts — show the actual items.
  > **中文翻译**：将每个阻塞差距列为一行描述实际问题的要点（例如 `systems-index.md: 3 rows have parenthetical status values`、`adr-0002.md: missing ## Status section`）。不是计数 — 显示实际条目。
- Show HIGH / MEDIUM / LOW as counts only (e.g. `HIGH: 4, MEDIUM: 2, LOW: 1`).
  > **中文翻译**：高级别/中级别/低级别仅显示计数（例如 `HIGH: 4, MEDIUM: 2, LOW: 1`）。

This gives the user enough context to judge scope before committing to writing the file.
> **中文翻译**：这给用户足够的上下文在提交写入文件之前判断范围。

If a prior adoption plan was detected in Phase 1, add a note:
> **中文翻译**：如果在第 1 阶段检测到先前的采用计划，添加一条注释：

> "A previous plan exists at `docs/adoption-plan-[prior-date].md`. The new plan will
> reflect current project state — it does not diff against the prior run."
> **中文翻译**："先前计划存在于 `docs/adoption-plan-[prior-date].md`。新计划将反映当前项目状态 — 它不会与先前运行进行差异比较。"

Use `AskUserQuestion`:
> **中文翻译**：使用 `AskUserQuestion`：

- "Ready to write the migration plan?" / "准备好写入迁移计划了吗？"
  - "Yes — write `docs/adoption-plan-[date].md`" / "是 — 写入 `docs/adoption-plan-[date].md`"
  - "Show me the full plan preview first (don't write yet)" / "先显示完整计划预览（暂不写入）"
  - "Cancel — I'll handle migration manually" / "取消 — 我将手动处理迁移"

If the user picks "Show me the full plan preview", output the complete plan as a
fenced markdown block. Then ask again with the same three options.
> **中文翻译**：如果用户选择"先显示完整计划预览"，将完整计划输出为围栏 markdown 块。然后用相同的三个选项再次询问。

---

## Phase 6: Write the Adoption Plan / 第 6 阶段：写入采用计划

If approved, write `docs/adoption-plan-[date].md` with this structure:
> **中文翻译**：如果批准，按以下结构写入 `docs/adoption-plan-[date].md`：

```markdown
# Adoption Plan

> **Generated**: [date]
> **Project phase**: [phase]
> **Engine**: [name + version, or "Not configured"]
> **Template version**: v1.0+

Work through these steps in order. Check off each item as you complete it.
Re-run `/adopt` anytime to check remaining gaps.

---

## Step 1: Fix Blocking Gaps

[One sub-section per blocking gap with problem, fix command, time estimate, checkbox]

---

## Step 2: Fix High-Priority Gaps

[One sub-section per high gap]

---

## Step 3: Bootstrap Infrastructure

### 3a. Register existing requirements (creates tr-registry.yaml)
Run `/architecture-review` — even if ADRs already exist, this run bootstraps
the TR registry from your existing GDDs and ADRs.
**Time**: 1 session (review can be long for large codebases)
- [ ] tr-registry.yaml created

### 3b. Create control manifest
Run `/create-control-manifest`
**Time**: 30 min
- [ ] docs/architecture/control-manifest.md created

### 3c. Create sprint tracking file
Run `/sprint-plan update`
**Time**: 5 min (if sprint plan already exists as markdown)
- [ ] production/sprint-status.yaml created

### 3d. Set authoritative project stage
Run `/gate-check [current-phase]`
**Time**: 5 min
- [ ] production/stage.txt written

---

## Step 4: Medium-Priority Gaps

[One sub-section per medium gap]

---

## Step 5: Optional Improvements

[One sub-section per low gap]

---

## What to Expect from Existing Stories

Existing stories continue to work with all template skills. New format checks
(TR-ID validation, manifest version staleness) auto-pass when the fields are
absent — so nothing breaks. They won't benefit from staleness tracking until
regenerated. Do not regenerate stories that are in progress or done.

---

## Re-run

Run `/adopt` again after completing Step 3 to verify all blocking and high gaps
are resolved. The new run will reflect the current state of the project.
```

---

## Phase 6b: Set Review Mode / 第 6b 阶段：设置审查模式

After writing the adoption plan (or if the user cancels writing), check whether
`production/review-mode.txt` exists.
> **中文翻译**：写入采用计划后（或用户取消写入），检查 `production/review-mode.txt` 是否存在。

**If it exists**: Read it and note the current mode — "Review mode is already set to `[current]`." — skip the prompt.
> **中文翻译**：**如果存在**：读取并记录当前模式 — "审查模式已设置为 `[当前值]`。" — 跳过提示。

**If it does not exist**: Use `AskUserQuestion`:
> **中文翻译**：**如果不存在**：使用 `AskUserQuestion`：

- **Prompt**: "One more setup step: how much design review would you like as you work through the workflow?" / **提示**："还有一个设置步骤：在完成工作流程时，您希望进行多少设计审查？"
- **Options**: / **选项**：
  - `Full` — Director specialists review at each key workflow step. Best for teams, learning the workflow, or when you want thorough feedback on every decision. / `Full` — 导演专家在每个关键工作流步骤审查。适用于团队、学习工作流或希望对每个决策获得全面反馈的情况。
  - `Lean (recommended)` — Directors only at phase gate transitions (/gate-check). Skips per-skill reviews. Balanced for solo devs and small teams. / `Lean（推荐）` — 导演仅在阶段门控转换时审查（/gate-check）。跳过按技能审查。适合独立开发者和小团队的平衡方案。
  - `Solo` — No director reviews at all. Maximum speed. Best for game jams, prototypes, or if reviews feel like overhead. / `Solo` — 完全无导演审查。最快速度。适合游戏 jams、原型或审查感觉是负担的情况。

Write the choice to `production/review-mode.txt` immediately after selection — no separate "May I write?" needed:
> **中文翻译**：选择后立即将选择写入 `production/review-mode.txt` — 无需单独的"我可以写入吗？"：

- `Full` → write `full`
- `Lean (recommended)` → write `lean`
- `Solo` → write `solo`

Create the `production/` directory if it does not exist.
> **中文翻译**：如果 `production/` 目录不存在则创建它。

---

## Phase 7: Offer First Action / 第 7 阶段：提供首个行动

After writing the plan, don't stop there. Pick the single highest-priority gap
and offer to handle it immediately using `AskUserQuestion`. Choose the first
branch that applies:
> **中文翻译**：写入计划后不要就此停止。选择最高优先级的差距并使用 `AskUserQuestion` 提供立即处理。选择第一个适用的分支：

**If there are parenthetical status values in systems-index.md:**
> **中文翻译**：**如果 systems-index.md 中有括号状态值：**

Use `AskUserQuestion`:
- "The most urgent fix is `systems-index.md` — [N] rows have parenthetical status
  values (e.g. `Needs Revision (see notes)`) that break /gate-check,
  /create-stories, and /architecture-review right now. I can fix these in-place."
  > **中文翻译**："最紧急的修复是 `systems-index.md` — [N] 行有括号状态值（例如 `Needs Revision (see notes)`），这些值会立即破坏 /gate-check、/create-stories 和 /architecture-review。我可以就地修复。"
  - "Fix it now — edit systems-index.md" / "现在修复 — 编辑 systems-index.md"
  - "I'll fix it myself" / "我自己修复"
  - "Done — leave me with the plan" / "完成 — 把计划留给我"

**If ADRs are missing `## Status` (and no parenthetical issue):**
> **中文翻译**：**如果 ADR 缺少 `## Status`（且无括号问题）：**

Use `AskUserQuestion`:
- "The most urgent fix is adding `## Status` to [N] ADR(s): [list filenames].
  Without it, /story-readiness silently passes all ADR checks. Start with
  [first affected filename]?"
  > **中文翻译**："最紧急的修复是为 [N] 个 ADR 添加 `## Status`：[列出文件名]。没有它，/story-readiness 会静默通过所有 ADR 检查。从 [第一个受影响的文件名] 开始？"
  - "Yes — retrofit [first affected filename] now" / "是 — 现在改造 [第一个受影响的文件名]"
  - "Retrofit all [N] ADRs one by one" / "逐个改造所有 [N] 个 ADR"
  - "I'll handle ADRs myself" / "我自己处理 ADR"

**If GDDs are missing Acceptance Criteria (and no blocking issues above):**
> **中文翻译**：**如果 GDD 缺少 Acceptance Criteria（且以上无阻塞问题）：**

Use `AskUserQuestion`:
- "The most urgent gap is missing Acceptance Criteria in [N] GDD(s):
  [list filenames]. Without them, /create-stories can't generate stories.
  Start with [highest-priority GDD filename]?"
  > **中文翻译**："最紧急的差距是 [N] 个 GDD 中缺少 Acceptance Criteria：[列出文件名]。没有它们，/create-stories 无法生成故事。从 [最高优先级的 GDD 文件名] 开始？"
  - "Yes — add Acceptance Criteria to [GDD filename] now" / "是 — 现在向 [GDD 文件名] 添加 Acceptance Criteria"
  - "Do all [N] GDDs one by one" / "逐个处理所有 [N] 个 GDD"
  - "I'll handle GDDs myself" / "我自己处理 GDD"

**If no BLOCKING or HIGH gaps exist:**
> **中文翻译**：**如果不存在阻塞或高级别差距：**

Use `AskUserQuestion`:
- "No blocking gaps — this project is template-compatible. What next?"
  > **中文翻译**："无阻塞差距 — 此项目与模板兼容。下一步？"
  - "Walk me through the medium-priority improvements" / "带我了解中级优先级改进"
  - "Run /project-stage-detect for a broader health check" / "运行 /project-stage-detect 进行更广泛的健康检查"
  - "Done — I'll work through the plan at my own pace" / "完成 — 我将按自己的节奏执行计划"

---

## Collaborative Protocol / 协作协议

1. **Read silently** — complete the full audit before presenting anything / **静默读取** — 在呈现任何内容之前完成完整审计
2. **Show the summary first** — let the user see scope before asking to write / **先显示摘要** — 让用户在请求写入之前看到范围
3. **Ask before writing** — always confirm before creating the adoption plan file / **写入前询问** — 在创建采用计划文件之前始终确认
4. **Offer, don't force** — the plan is advisory; the user decides what to fix and when / **提供而非强迫** — 计划是建议性的；用户决定修复什么和何时修复
5. **One action at a time** — after handing off the plan, offer one specific next step,
   not a list of six things to do simultaneously / **一次一个行动** — 交接计划后，提供一个具体的下一步，而不是六件同时要做的事情列表
6. **Never regenerate existing artifacts** — only fill gaps in what exists;
   do not rewrite GDDs, ADRs, or stories that already have content / **永远不要重新生成现有工件** — 仅填充已存在内容中的差距；不要重写已有内容的 GDD、ADR 或故事
