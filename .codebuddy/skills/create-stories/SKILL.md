---
name: create-stories
description: "Break a single epic into implementable story files. Reads the epic, its GDD, governing ADRs, and control manifest. Each story embeds its GDD requirement TR-ID, ADR guidance, acceptance criteria, story type, and test evidence path. Run after /create-epics for each epic. / 将单个史诗分解为可实现的故事文件。读取史诗、其 GDD、管辖 ADR 和控制清单。每个故事嵌入其 GDD 需求 TR-ID、ADR 指导、验收标准、故事类型和测试证据路径。在每个史诗创建后运行。"
argument-hint: "[epic-slug | epic-path] [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Task, AskUserQuestion
agent: lead-programmer
---

# Create Stories / 创建故事

A story is a single implementable behaviour — small enough to complete in one focused session, self-contained, and fully traceable to a GDD requirement and an ADR decision. Stories are what developers pick up. Epics are what architects define.
> **中文翻译**：故事是单个可实现的行为 — 足够小，可以在一次集中会话中完成、独立且完全可追溯至 GDD 需求和 ADR 决策。故事是开发者接手的工作。史诗是架构师定义的范围。

**Run this skill per epic**, not per layer. Run it for Foundation epics first, then Core, and so on — matching the dependency order.
> **中文翻译**：**按史诗运行此技能**，而不是按层运行。首先为基础史诗运行，然后为核心运行，依此类推 — 匹配依赖顺序。

**Output:** `production/epics/[epic-slug]/story-NNN-[slug].md` files
> **中文翻译**：**输出：** `production/epics/[epic-slug]/story-NNN-[slug].md` 文件

**Previous step:** `/create-epics [system]` **Next step after stories exist:** `/story-readiness [story-path]` then `/dev-story [story-path]`
> **中文翻译**：**上一步：** `/create-epics [system]` **故事存在后的下一步：** `/story-readiness [story-path]` 然后 `/dev-story [story-path]`

---

## 1. Parse Argument / 1. 解析参数

Extract `--review [full|lean|solo]` if present and store as the review mode
override for this run. If not provided, read `production/review-mode.txt`
(default `full` if missing). This resolved mode applies to all gate spawns
in this skill — apply the check pattern from `.codebuddy/docs/director-gates.md`
before every gate invocation.
> **中文翻译**：如果存在，提取 `--review [full|lean|solo]` 并存储为本运行的审查模式覆盖。如果未提供，读取 `production/review-mode.txt`（如缺失则默认 `full`）。此解析模式适用于此技能中的所有门控生成 — 在每次门控调用之前应用 `.codebuddy/docs/director-gates.md` 中的检查模式。

- `/create-stories [epic-slug]` — e.g. `/create-stories combat`
- `/create-stories production/epics/combat/EPIC.md` — full path also accepted
- No argument — ask: "Which epic would you like to break into stories?"
  Glob `production/epics/*/EPIC.md` and list available epics with their status.

> **中文翻译**：
> - `/create-stories [epic-slug]` — 例如 `/create-stories combat`
> - `/create-stories production/epics/combat/EPIC.md` — 也接受完整路径
> - 无参数 — 询问："您想将哪个史诗分解为故事？"用 Glob 查找 `production/epics/*/EPIC.md` 并列出可用史诗及其状态。

---

## 2. Load Everything for This Epic / 2. 加载该史诗的所有内容

Read in full:
> **中文翻译**：全文阅读：

- `production/epics/[epic-slug]/EPIC.md` — epic overview, governing ADRs, GDD requirements table
  > **中文翻译**：`production/epics/[epic-slug]/EPIC.md` — 史诗概述、管辖 ADR、GDD 需求表
- The epic's GDD (`design/gdd/[filename].md`) — read all 8 sections, especially Acceptance Criteria, Formulas, and Edge Cases
  > **中文翻译**：史诗的 GDD（`design/gdd/[filename].md`）— 阅读所有 8 个部分，尤其是验收标准、公式和边缘情况
- All governing ADRs listed in the epic — read the Decision, Implementation Guidelines, Engine Compatibility, and Engine Notes sections
  > **中文翻译**：史诗中列出的所有管辖 ADR — 阅读决策、实施指南、引擎兼容性和引擎备注部分
- `docs/architecture/control-manifest.md` — extract rules for this epic's layer; note the Manifest Version date from the header
  > **中文翻译**：`docs/architecture/control-manifest.md` — 提取该史诗层的规则；注意标头中的清单版本日期
- `docs/architecture/tr-registry.yaml` — load all TR-IDs for this system
  > **中文翻译**：`docs/architecture/tr-registry.yaml` — 加载该系统的所有 TR-ID

**ADR existence validation**: After reading the governing ADRs list from the epic, confirm each ADR file exists on disk. If any ADR file cannot be found, **stop immediately** before decomposing any story:
> **中文翻译**：**ADR 存在性验证**：从史诗中读取管辖 ADR 列表后，确认每个 ADR 文件存在于磁盘上。如果找不到任何 ADR 文件，在分解任何故事之前**立即停止**：

> "Epic references [ADR-NNNN: title] but `docs/architecture/[adr-file].md` was not found. > Check the filename in the epic's Governing ADRs list, or run `/architecture-decision` > to create it. Cannot create stories until all referenced ADR files are present."
> **中文翻译**：> "史诗引用了 [ADR-NNNN: 标题] 但未找到 `docs/architecture/[adr-file].md`。> 检查史诗的管辖 ADR 列表中的文件名，或运行 `/architecture-decision` > 来创建它。在所有引用的 ADR 文件都存在之前无法创建故事。"

Do not proceed to Step 3 until all referenced ADR files are confirmed present.
> **中文翻译**：在确认所有引用的 ADR 文件均存在之前，请勿继续执行步骤 3。

Report: "Loaded epic [name], GDD [filename], [N] governing ADRs (all confirmed present), control manifest v[date]."
> **中文翻译**：报告："已加载史诗 [名称]、GDD [文件名]、[N] 个管辖 ADR（均已确认存在）、控制清单 v[日期]。"

---

## 3. Classify Stories by Type / 3. 按类型分类故事

**Story Type Classification** — assign each story a type based on its acceptance criteria:
> **中文翻译**：**故事类型分类** — 根据验收标准为每个故事分配类型：

| Story Type | Assign when criteria reference... |
|---|---|
| **Logic** | Formulas, numerical thresholds, state transitions, AI decisions, calculations |
| **Integration** | Two or more systems interacting, signals crossing boundaries, save/load round-trips |
| **Visual/Feel** | Animation behaviour, VFX, "feels responsive", timing, screen shake, audio sync |
| **UI** | Menus, HUD elements, buttons, screens, dialogue boxes, tooltips |
| **Config/Data** | Balance tuning values, data file changes only — no new code logic |

> **中文翻译**：
> | 故事类型 | 当标准引用...时分配 |
> |---|---|
> | **逻辑** | 公式、数值阈值、状态转换、AI 决策、计算 |
> | **集成** | 两个或多个系统交互、信号跨越边界、保存/加载往返 |
> | **视觉/手感** | 动画行为、VFX、"感觉灵敏"、时机、屏幕震动、音频同步 |
> | **UI** | 菜单、HUD 元素、按钮、屏幕、对话框、工具提示 |
> | **配置/数据** | 平衡调优值、仅数据文件更改 — 无新代码逻辑 |

Mixed stories: assign the type that carries the highest implementation risk.
> **中文翻译**：混合故事：分配具有最高实施风险的类型。

The type determines what test evidence is required before `/story-done` can close the story.
> **中文翻译**：类型决定了 `/story-done` 关闭故事之前需要什么测试证据。

---

## 4. Decompose the GDD into Stories / 4. 将 GDD 分解为故事

For each GDD acceptance criterion:
> **中文翻译**：对于每个 GDD 验收标准：

1. Group related criteria that require the same core implementation
  > **中文翻译**：将需要相同核心实现的相关标准分组
2. Each group = one story
  > **中文翻译**：每组 = 一个故事
3. Order stories: foundational behaviour first, edge cases last, UI last
  > **中文翻译**：故事排序：基础行为优先，边缘情况最后，UI 最后

**Story sizing rule:** one story = one focused session (~2-4 hours). If a group of criteria would take longer, split into two stories.
> **中文翻译**：**故事大小规则：** 一个故事 = 一次集中会话（约 2-4 小时）。如果一组标准需要更长时间，则拆分为两个故事。

For each story, determine:
> **中文翻译**：对于每个故事，确定：

- **GDD requirement**: which acceptance criterion(ia) does this satisfy?
  > **中文翻译**：**GDD 需求**：这满足哪个验收标准？
- **TR-ID**: look up in `tr-registry.yaml`. Use the stable ID. If no match, use `TR-[system]-???` and warn.
  > **中文翻译**：**TR-ID**：在 `tr-registry.yaml` 中查找。使用稳定 ID。如果不匹配，使用 `TR-[system]-???` 并发出警告。
- **Governing ADR**: which ADR governs how to implement this?
  > **中文翻译**：**管辖 ADR**：哪个 ADR 管辖如何实施此内容？
  - `Status: Accepted` → embed normally
  > **中文翻译**：`状态：已接受` → 正常嵌入
  - `Status: Proposed` → set story `Status: Blocked` with note: "BLOCKED: ADR-NNNN is Proposed — run `/architecture-decision` to advance it"
  > **中文翻译**：`状态：已提议` → 设置故事 `状态：阻塞`，附注："阻塞：ADR-NNNN 已提议 — 运行 `/architecture-decision` 推进它"
- **Story Type**: from Step 3 classification
  > **中文翻译**：**故事类型**：来自第 3 步分类
- **Engine risk**: from the ADR's Knowledge Risk field
  > **中文翻译**：**引擎风险**：来自 ADR 的知识风险字段

---

## 4b. QA Lead Story Readiness Gate / 4b. QA 负责人故事就绪门控

**Review mode check** — apply before spawning QL-STORY-READY:
> **中文翻译**：**审查模式检查** — 在生成 QL-STORY-READY 之前应用：

- `solo` → skip. Note: "QL-STORY-READY skipped — Solo mode." Proceed to Step 5 (present stories for review).
- `lean` → skip (not a PHASE-GATE). Note: "QL-STORY-READY skipped — Lean mode." Proceed to Step 5 (present stories for review).
- `full` → spawn as normal.

> **中文翻译**：
> - `solo` → 跳过。备注："QL-STORY-READY 已跳过 — Solo 模式。"继续步骤 5（呈现故事供审查）。
> - `lean` → 跳过（不是阶段门控）。备注："QL-STORY-READY 已跳过 — Lean 模式。"继续步骤 5（呈现故事供审查）。
> - `full` → 正常生成。

After decomposing all stories (Step 4 complete) but before presenting them for write approval, spawn `qa-lead` via Task using gate **QL-STORY-READY** (`.codebuddy/docs/director-gates.md`).
> **中文翻译**：在分解所有故事（步骤 4 完成）之后，但在呈现它们以获取写入批准之前，通过 Task 使用门控 **QL-STORY-READY**（`.codebuddy/docs/director-gates.md`）生成 `qa-lead`。

Pass: the full story list with acceptance criteria, story types, and TR-IDs; the epic's GDD acceptance criteria for reference.
> **中文翻译**：传递：包含验收标准、故事类型和 TR-ID 的完整故事列表；史诗的 GDD 验收标准作为参考。

Present the QA lead's assessment. For each story flagged as GAPS or INADEQUATE, revise the acceptance criteria before proceeding — stories with untestable criteria cannot be implemented correctly. Once all stories reach ADEQUATE, proceed.
> **中文翻译**：呈现 QA 负责人的评估。对于每个标记为差距或不足的故事，在继续之前修改验收标准 — 具有不可测试标准的故事无法正确实施。一旦所有故事达到合格，继续进行。

**After ADEQUATE**: for every Logic and Integration story, ask the qa-lead to produce concrete test case specifications — one per acceptance criterion — in this format:
> **中文翻译**：**合格后**：对于每个逻辑和集成故事，要求 qa-lead 生成具体的测试用例规范 — 每个验收标准一个 — 格式如下：

```
Test: [criterion text]
  Given: [precondition]
  When: [action]
  Then: [expected result / assertion]
  Edge cases: [boundary values or failure states to test]
```

For Visual/Feel and UI stories, produce manual verification steps instead:
> **中文翻译**：对于视觉/手感和 UI 故事，改为生成手动验证步骤：

```
Manual check: [criterion text]
  Setup: [how to reach the state]
  Verify: [what to look for]
  Pass condition: [unambiguous pass description]
```

These test case specs are embedded directly into each story's `## QA Test Cases` section. The developer implements against these cases. The programmer does not write tests from scratch — QA has already defined what "done" looks like.
> **中文翻译**：这些测试用例规范直接嵌入到每个故事的 `## QA Test Cases` 部分。开发者根据这些用例进行实施。程序员不需要从零开始编写测试 — QA 已经定义了"完成"的样子。

---

## 5. Present Stories for Review / 5. 呈现故事供审查

Before writing any files, present the full story list:
> **中文翻译**：在编写任何文件之前，呈现完整的故事列表：

```
## Stories for Epic: [name]

Story 001: [title] — Logic — ADR-NNNN
  Covers: TR-[system]-001 ([1-line summary of requirement])
  Test required: tests/unit/[system]/[slug]_test.[ext]

Story 002: [title] — Integration — ADR-MMMM
  Covers: TR-[system]-002, TR-[system]-003
  Test required: tests/integration/[system]/[slug]_test.[ext]

Story 003: [title] — Visual/Feel — ADR-NNNN
  Covers: TR-[system]-004
  Evidence required: production/qa/evidence/[slug]-evidence.md

[N stories total: N Logic, N Integration, N Visual/Feel, N UI, N Config/Data]
```

Use `AskUserQuestion`:
> **中文翻译**：使用 `AskUserQuestion`：

- Prompt: "May I write these [N] stories to `production/epics/[epic-slug]/`?"
  > **中文翻译**：提示："我可以将这 [N] 个故事写入 `production/epics/[epic-slug]/` 吗？"
- Options: `[A] Yes — write all [N] stories` / `[B] Not yet — I want to review or adjust first`
  > **中文翻译**：选项：`[A] 是 — 写入所有 [N] 个故事` / `[B] 还不行 — 我想先审查或调整`

---

## 6. Write Story Files / 6. 写入故事文件

For each story, write `production/epics/[epic-slug]/story-[NNN]-[slug].md`:

```markdown
# Story [NNN]: [title]

> **Epic**: [epic name]
> **Status**: Ready
> **Layer**: [Foundation / Core / Feature / Presentation]
> **Type**: [Logic | Integration | Visual/Feel | UI | Config/Data]
> **Manifest Version**: [date from control-manifest.md header]

## Context

**GDD**: `design/gdd/[filename].md`
**Requirement**: `TR-[system]-NNN`
*(Requirement text lives in `docs/architecture/tr-registry.yaml` — read fresh at review time)*

**ADR Governing Implementation**: [ADR-NNNN: title]
**ADR Decision Summary**: [1-2 sentence summary of what the ADR decided]

**Engine**: [name + version] | **Risk**: [LOW / MEDIUM / HIGH]
**Engine Notes**: [from ADR Engine Compatibility section — post-cutoff APIs, verification required]

**Control Manifest Rules (this layer)**:
- Required: [relevant required pattern]
- Forbidden: [relevant forbidden pattern]
- Guardrail: [relevant performance guardrail]

---

## Acceptance Criteria / 验收标准

*From GDD `design/gdd/[filename].md`, scoped to this story:*
> **中文翻译**：*来自 GDD `design/gdd/[filename].md`，范围仅限于此故事：*

- [ ] [criterion 1 — directly from GDD]
  > **中文翻译**：[ ] [标准 1 — 直接来自 GDD]
- [ ] [criterion 2]
  > **中文翻译**：[ ] [标准 2]
- [ ] [performance criterion if applicable]
  > **中文翻译**：[ ] [性能标准（如适用）]

---

## Implementation Notes

*Derived from ADR-NNNN Implementation Guidelines:*

[Specific, actionable guidance from the ADR. Do not paraphrase in ways that
change meaning. This is what the programmer reads instead of the ADR.]

---

## Out of Scope / 超出范围

*Handled by neighbouring stories — do not implement here:*
> **中文翻译**：*由相邻的故事处理 — 不要在此实施：*

- [Story NNN+1]: [what it handles]
  > **中文翻译**：[故事 NNN+1]：[它处理什么]

---

## QA Test Cases

*Written by qa-lead at story creation. The developer implements against these — do not invent new test cases during implementation.*

**[For Logic / Integration stories — automated test specs]:**

- **AC-1**: [criterion text]
  - Given: [precondition]
  - When: [action]
  - Then: [assertion]
  - Edge cases: [boundary values / failure states]

**[For Visual/Feel / UI stories — manual verification steps]:**

- **AC-1**: [criterion text]
  - Setup: [how to reach the state]
  - Verify: [what to look for]
  - Pass condition: [unambiguous pass description]

---

## Test Evidence / 测试证据

**Story Type**: [type] **Required evidence**:
> **中文翻译**：**故事类型**：[类型] **所需证据**：

- Logic: `tests/unit/[system]/[story-slug]_test.[ext]` — must exist and pass
  > **中文翻译**：逻辑：`tests/unit/[system]/[story-slug]_test.[ext]` — 必须存在并通过
- Integration: `tests/integration/[system]/[story-slug]_test.[ext]` OR playtest doc
  > **中文翻译**：集成：`tests/integration/[system]/[story-slug]_test.[ext]` 或试玩文档
- Visual/Feel: `production/qa/evidence/[story-slug]-evidence.md` + sign-off
  > **中文翻译**：视觉/手感：`production/qa/evidence/[story-slug]-evidence.md` + 签核
- UI: `production/qa/evidence/[story-slug]-evidence.md` or interaction test
  > **中文翻译**：UI：`production/qa/evidence/[story-slug]-evidence.md` 或交互测试
- Config/Data: smoke check pass (`production/qa/smoke-*.md`)
  > **中文翻译**：配置/数据：冒烟检查通过（`production/qa/smoke-*.md`）

**Status**: [ ] Not yet created
> **中文翻译**：**状态**：[ ] 尚未创建

---

## Dependencies

- Depends on: [Story NNN-1 must be DONE, or "None"]
- Unlocks: [Story NNN+1, or "None"]
```

### Also update `production/epics/[epic-slug]/EPIC.md` / 同时更新 `production/epics/[epic-slug]/EPIC.md`

Replace the "Stories: Not yet created" line with a populated table:
> **中文翻译**：将"Stories: Not yet created"行替换为填充的表格：

```markdown
## Stories

| # | Story | Type | Status | ADR |
|---|-------|------|--------|-----|
| 001 | [title] | Logic | Ready | ADR-NNNN |
| 002 | [title] | Integration | Ready | ADR-MMMM |
```

---

## 7. After Writing / 7. 写入后

Use `AskUserQuestion` to close with context-aware next steps:
> **中文翻译**：使用 `AskUserQuestion` 以上下文感知的后续步骤结束：

Check:
> **中文翻译**：检查：

- Are there other epics in `production/epics/` without stories yet? List them.
  > **中文翻译**：`production/epics/` 中还有其他没有故事的史诗吗？列出它们。
- Is this the last epic? If so, include `/sprint-plan` as an option.
  > **中文翻译**：这是最后一个史诗吗？如果是，将 `/sprint-plan` 作为选项包含。

Widget:
> **中文翻译**：小部件：

- Prompt: "[N] stories written to `production/epics/[epic-slug]/`. What next?"
  > **中文翻译**：提示："[N] 个故事已写入 `production/epics/[epic-slug]/`。下一步？"
- Options (include all that apply):
  > **中文翻译**：选项（包含所有适用的）：
  - `[A] Start implementing — run /story-readiness [first-story-path]` (Recommended)
  > **中文翻译**：`[A] 开始实施 — 运行 /story-readiness [first-story-path]`（推荐）
  - `[B] Create stories for [next-epic-slug] — run /create-stories [slug]` (only if other epics have no stories yet)
  > **中文翻译**：`[B] 为 [next-epic-slug] 创建故事 — 运行 /create-stories [slug]`（仅当其他史诗尚无故事时）
  - `[C] Plan the sprint — run /sprint-plan` (only if all epics have stories)
  > **中文翻译**：`[C] 计划冲刺 — 运行 /sprint-plan`（仅当所有史诗都有故事时）
  - `[D] Stop here for this session`
  > **中文翻译**：`[D] 此会话到此结束`

Note in output: "Work through stories in order — each story's `Depends on:` field tells you what must be DONE before you can start it."
> **中文翻译**：输出中注明："按顺序完成故事 — 每个故事的 `Depends on:` 字段告诉你在开始之前必须完成什么。"

---

## Collaborative Protocol / 协作协议

1. **Read before presenting** — load all inputs silently before showing the story list
2. **Ask once** — present all stories for the epic in one summary, not one at a time
3. **Warn on blocked stories** — flag any story with a Proposed ADR before writing
4. **Ask before writing** — get approval for the full story set before writing files
5. **No invention** — acceptance criteria come from GDDs, implementation notes from ADRs, rules from the manifest
6. **Never start implementation** — this skill stops at the story file level

> **中文翻译**：
> 1. **呈现前先阅读** — 在展示故事列表之前静默加载所有输入
> 2. **一次询问** — 在一个摘要中呈现史诗的所有故事，而不是一次一个
> 3. **警告阻塞的故事** — 在写入之前标记任何具有已提议 ADR 的故事
> 4. **写入前询问** — 在写入文件之前获得完整故事集的批准
> 5. **不发明** — 验收标准来自 GDD、实施说明来自 ADR、规则来自清单
> 6. **永远不要开始实施** — 此技能仅限于故事文件级别

After writing (or declining):
> **中文翻译**：写入后（或拒绝后）：

- **Verdict: COMPLETE** — [N] stories written to `production/epics/[epic-slug]/`. Run `/story-readiness` → `/dev-story` to begin implementation.
- **Verdict: BLOCKED** — user declined. No story files written.

> **中文翻译**：
> - **裁决：完成** — [N] 个故事已写入 `production/epics/[epic-slug]/`。运行 `/story-readiness` → `/dev-story` 开始实施。
> - **裁决：阻塞** — 用户拒绝。未写入任何故事文件。
