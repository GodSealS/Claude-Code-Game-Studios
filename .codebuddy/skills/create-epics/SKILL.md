---
name: create-epics
description: "Translate approved GDDs + architecture into epics — one epic per architectural module. Defines scope, governing ADRs, engine risk, and untraced requirements. Does NOT break into stories — run /create-stories [epic-slug] after each epic is created. / 将已批准的 GDD + 架构翻译为史诗 — 每个架构模块一个史诗。定义范围、管辖 ADR、引擎风险和未追溯需求。不分解为故事 — 每个史诗创建后运行 /create-stories [epic-slug]。"
argument-hint: "[system-name | layer: foundation|core|feature|presentation | all] [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Task, AskUserQuestion
agent: technical-director
---

# Create Epics / 创建史诗

An epic is a named, bounded body of work that maps to one architectural module. It defines **what** needs to be built and **who owns it architecturally**. It does not prescribe implementation steps — that is the job of stories.
> **中文翻译**：史诗是映射到一个架构模块的命名的、有界的工作体。它定义了**需要构建什么**以及**谁在架构上拥有它**。它没有规定实施步骤——这是故事的工作。

**Run this skill once per layer** as you approach that layer in development. Do not create Feature layer epics until Core is nearly complete — the design will have changed.
> **中文翻译**：**当您在开发过程中接近该层时，每层运行一次此技能。** 在核心接近完成之前，不要创建功能层史诗 — 设计将会改变。

**Output:** `production/epics/[epic-slug]/EPIC.md` + `production/epics/index.md`
> **中文翻译**：**输出：** `production/epics/[epic-slug]/EPIC.md` + `production/epics/index.md`

**Next step after each epic:** `/create-stories [epic-slug]`
> **中文翻译**：**每个史诗之后的下一步：** `/create-stories [epic-slug]`

**When to run:** After `/create-control-manifest` and `/architecture-review` pass.
> **中文翻译**：**何时运行：** 在 `/create-control-manifest` 和 `/architecture-review` 通过之后。

---

## 1. Parse Arguments / 1. 解析参数

Resolve the review mode (once, store for all gate spawns this run):
> **中文翻译**：解析审查模式（一次，存储本次运行的所有门控生成）：

1. If `--review [full|lean|solo]` was passed → use that
2. Else read `production/review-mode.txt` → use that value
3. Else → default to `lean`

See `.codebuddy/docs/director-gates.md` for the full check pattern.
> **中文翻译**：完整检查模式参见 `.codebuddy/docs/director-gates.md`。

**Modes / 模式：**
- `/create-epics all` — process all systems in layer order
- `/create-epics layer: foundation` — Foundation layer only
- `/create-epics layer: core` — Core layer only
- `/create-epics layer: feature` — Feature layer only
- `/create-epics layer: presentation` — Presentation layer only
- `/create-epics [system-name]` — one specific system
- No argument — ask: "Which layer or system would you like to create epics for?"

> **中文翻译**：
> - `/create-epics all` — 按层序处理所有系统
> - `/create-epics layer: foundation` — 仅基础层
> - `/create-epics layer: core` — 仅核心层
> - `/create-epics layer: feature` — 仅功能层
> - `/create-epics layer: presentation` — 仅表现层
> - `/create-epics [system-name]` — 一个特定系统
> - 无参数 — 询问："您想为哪个层或系统创建史诗？"

---

## 2. Load Inputs / 2. 加载输入

### Step 2a — Summary scan (fast) / 步骤 2a — 摘要扫描（快速）

Grep all GDDs for their `## Summary` sections before reading anything fully:
> **中文翻译**：在完整阅读任何内容之前，先用 Grep 查找所有 GDD 的 `## Summary` 部分：

```
Grep pattern="## Summary" glob="design/gdd/*.md" output_mode="content" -A 5
```

For `layer:` or `[system-name]` modes: filter to only in-scope GDDs based on the Summary quick-reference. Skip full-reading anything out of scope.
> **中文翻译**：对于 `layer:` 或 `[system-name]` 模式：根据摘要快速参考仅筛选范围内的 GDD。跳过全文阅读任何超出范围的内容。

### Step 2b — Full document load (in-scope systems only) / 步骤 2b — 完整文档加载（仅限范围内的系统）

Using the Step 2a grep results, identify which systems are in scope. Read full documents **only for in-scope systems** — do not read GDDs or ADRs for out-of-scope systems or layers.
> **中文翻译**：使用步骤 2a grep 结果确定哪些系统在范围内。阅读完整文档**仅适用于范围内的系统** — 不要阅读范围外的系统或层的 GDD 或 ADR。

Read for in-scope systems:
> **中文翻译**：阅读范围内的系统：

- `design/gdd/systems-index.md` — authoritative system list, layers, priority
  > **中文翻译**：`design/gdd/systems-index.md` — 权威系统列表、层、优先级
- In-scope GDDs only (Approved or Designed status, filtered by Step 2a results)
  > **中文翻译**：仅限范围内的 GDD（已批准或设计状态，按步骤 2a 结果过滤）
- `docs/architecture/architecture.md` — module ownership and API boundaries
  > **中文翻译**：`docs/architecture/architecture.md` — 模块所有权和 API 边界
- Accepted ADRs **whose domains cover in-scope systems only** — read the "GDD Requirements Addressed", "Decision", and "Engine Compatibility" sections; skip ADRs for unrelated domains
  > **中文翻译**：已接受的 ADR **其领域仅涵盖范围内的系统** — 阅读"已解决的 GDD 要求"、"决策"和"引擎兼容性"部分；跳过不相关领域的 ADR
- `docs/architecture/control-manifest.md` — manifest version date from header
  > **中文翻译**：`docs/architecture/control-manifest.md` — 标头中的清单版本日期
- `docs/architecture/tr-registry.yaml` — for tracing requirements to ADR coverage
  > **中文翻译**：`docs/architecture/tr-registry.yaml` — 用于追踪需求到 ADR 覆盖范围
- `docs/engine-reference/[engine]/VERSION.md` — engine name, version, risk levels
  > **中文翻译**：`docs/engine-reference/[engine]/VERSION.md` — 引擎名称、版本、风险级别

Report: "Loaded [N] GDDs, [M] ADRs, engine: [name + version]."
> **中文翻译**：报告："已加载 [N] 个 GDD、[M] 个 ADR，引擎：[名称 + 版本]。"

---

## 3. Processing Order / 3. 处理顺序

Process in dependency-safe layer order:
> **中文翻译**：按依赖安全的层序处理：

1. **Foundation** (no dependencies)
2. **Core** (depends on Foundation)
3. **Feature** (depends on Core)
4. **Presentation** (depends on Feature + Core)

> **中文翻译**：
> 1. **基础**（无依赖）
> 2. **核心**（依赖基础）
> 3. **功能**（依赖核心）
> 4. **表现**（依赖功能 + 核心）

Within each layer, use the order from `systems-index.md`.
> **中文翻译**：在每个层内，使用 `systems-index.md` 中的顺序。

---

## 4. Define Each Epic / 4. 定义每个史诗

For each system, map it to an architectural module from `architecture.md`.
> **中文翻译**：对于每个系统，将其映射到 `architecture.md` 中的架构模块。

Check ADR coverage against the TR registry:
> **中文翻译**：根据 TR 注册表检查 ADR 覆盖范围：

- **Traced requirements**: TR-IDs that have an Accepted ADR covering them
  > **中文翻译**：**已追踪的需求**：有已接受 ADR 覆盖的 TR-ID
- **Untraced requirements**: TR-IDs with no ADR — warn before proceeding
  > **中文翻译**：**未追踪的需求**：没有 ADR 的 TR-ID — 在继续之前发出警告

Present to user before writing anything:
> **中文翻译**：在编写任何内容之前向用户展示：

```
## Epic: [System Name]

**Layer**: [Foundation / Core / Feature / Presentation]
**GDD**: design/gdd/[filename].md
**Architecture Module**: [module name from architecture.md]
**Governing ADRs**: [ADR-NNNN, ADR-MMMM]
**Engine Risk**: [LOW / MEDIUM / HIGH — highest risk among governing ADRs]
**GDD Requirements Covered by ADRs**: [N / total]
**Untraced Requirements**: [list TR-IDs with no ADR, or "None"]
```

If there are untraced requirements: > "⚠️ [N] requirements in [system] have no ADR. The epic can be created, but > stories for these requirements will be marked Blocked until ADRs exist. > Run `/architecture-decision` first, or proceed with placeholders."
> **中文翻译**：如果存在未追踪的需求：> "⚠️ [系统] 中有 [N] 个需求没有 ADR。可以创建史诗，但 > 这些需求的故事将被标记为阻塞，直到 ADR 存在。> 先运行 `/architecture-decision`，或使用占位符继续。"

Ask: "Shall I create Epic: [name]?" Options: "Yes, create it", "Skip", "Pause — I need to write ADRs first"
> **中文翻译**：问："我要创建史诗：[名称] 吗？"选项："是的，创建它"、"跳过"、"暂停 — 我需要先写 ADR"

---

## 4b. Producer Epic Structure Gate / 4b. 制作人史诗结构门控

**Review mode check** — apply before spawning PR-EPIC:
> **中文翻译**：**审查模式检查** — 在生成 PR-EPIC 之前应用：

- `solo` → skip. Note: "PR-EPIC skipped — Solo mode." Proceed to Step 5 (write epic files).
- `lean` → skip (not a PHASE-GATE). Note: "PR-EPIC skipped — Lean mode." Proceed to Step 5 (write epic files).
- `full` → spawn as normal.

> **中文翻译**：
> - `solo` → 跳过。备注："PR-EPIC 已跳过 — Solo 模式。"继续步骤 5（写入史诗文件）。
> - `lean` → 跳过（不是阶段门控）。备注："PR-EPIC 已跳过 — Lean 模式。"继续步骤 5（写入史诗文件）。
> - `full` → 正常生成。

After all epics for the current layer are defined (Step 4 completed for all in-scope systems), and before writing any files, spawn `producer` via Task using gate **PR-EPIC** (`.codebuddy/docs/director-gates.md`).
> **中文翻译**：在当前层的所有史诗定义完成（步骤 4 对所有范围内系统完成）之后，且在写入任何文件之前，通过 Task 使用门控 **PR-EPIC**（`.codebuddy/docs/director-gates.md`）生成 `producer`。

Pass: the full epic structure summary (all epics, their scope summaries, governing ADR counts), the layer being processed, milestone timeline and team capacity.
> **中文翻译**：传递：完整的史诗结构摘要（所有史诗、其范围摘要、管辖 ADR 计数）、正在处理的层、里程碑时间线和团队容量。

Present the producer's assessment. If UNREALISTIC, offer to revise epic boundaries (split overscoped or merge underscoped epics) before writing. If CONCERNS, surface them and let the user decide. Do not write epic files until the producer gate resolves.
> **中文翻译**：呈现制作人的评估。如果不切实际，提供修改史诗边界的选项（拆分范围过大的或合并范围过小的史诗）后再写入。如果有关注点，呈现它们并让用户决定。在制作人门控解决之前不要写入史诗文件。

---

## 5. Write Epic Files / 5. 写入史诗文件

After approval, ask: "May I write the epic file to `production/epics/[epic-slug]/EPIC.md`?"
> **中文翻译**：审核通过后，询问："我可以将史诗文件写入 `production/epics/[epic-slug]/EPIC.md` 吗？"

After user confirms, write:
> **中文翻译**：用户确认后，写入：

<!-- 中文翻译 -->
### `production/epics/[epic-slug]/EPIC.md`

```markdown
# Epic: [System Name]

> **Layer**: [Foundation / Core / Feature / Presentation]
> **GDD**: design/gdd/[filename].md
> **Architecture Module**: [module name]
> **Status**: Ready
> **Stories**: Not yet created — run `/create-stories [epic-slug]`

## Overview

[1 paragraph describing what this epic implements, derived from the GDD Overview
and the architecture module's stated responsibilities]

## Governing ADRs

| ADR | Decision Summary | Engine Risk |
|-----|-----------------|-------------|
| ADR-NNNN: [title] | [1-line summary] | LOW/MEDIUM/HIGH |

## GDD Requirements

| TR-ID | Requirement | ADR Coverage |
|-------|-------------|--------------|
| TR-[system]-001 | [requirement text from registry] | ADR-NNNN ✅ |
| TR-[system]-002 | [requirement text] | ❌ No ADR |

## definition of Done

This epic is complete when:
- All stories are implemented, reviewed, and closed via `/story-done`
- All acceptance criteria from `design/gdd/[filename].md` are verified
- All Logic and Integration stories have passing test files in `tests/`
- All Visual/Feel and UI stories have evidence docs with sign-off in `production/qa/evidence/`

## Next Step

Run `/create-stories [epic-slug]` to break this epic into implementable stories.
```

### Update `production/epics/index.md` / 更新 `production/epics/index.md`

Create or update the master index:
> **中文翻译**：创建或更新主索引：

```markdown
# Epics Index

Last Updated: [date]
Engine: [name + version]

| Epic | Layer | System | GDD | Stories | Status |
|------|-------|--------|-----|---------|--------|
| [name] | Foundation | [system] | [file] | Not yet created | Ready |
```

---

## 6. Gate-Check Reminder / 6. 门控检查提醒

After writing all epics for the requested scope:
> **中文翻译**：为请求的范围写入所有史诗后：

- **Foundation + Core complete**: These are required for the Pre-Production →
  Production gate. Run `/gate-check production` to check readiness.
- **Reminder**: Epics define scope. Stories define implementation steps. Run
  `/create-stories [epic-slug]` for each epic before developers can pick up work.

> **中文翻译**：
> - **基础 + 核心完成**：这些是预生产 → 生产门控所必需的。运行 `/gate-check production` 检查就绪状态。
> - **提醒**：史诗定义范围。故事定义实施步骤。在开发者可以开始工作之前，为每个史诗运行 `/create-stories [epic-slug]`。

---

## Collaborative Protocol / 协作协议

1. **One epic at a time** — present each epic definition before asking to create it
  > **中文翻译**：**一次一个史诗** — 在要求创建之前呈现每个史诗定义
2. **Warn on gaps** — flag untraced requirements before proceeding
  > **中文翻译**：**警告差距** — 在继续之前标记未追踪的需求
3. **Ask before writing** — per-epic approval before writing any file
  > **中文翻译**：**写入前询问** — 在写入任何文件之前获得每个史诗的批准
4. **No invention** — all content comes from GDDs, ADRs, and architecture docs
  > **中文翻译**：**不发明** — 所有内容均来自 GDD、ADR 和架构文档
5. **Never create stories** — this skill stops at the epic level
  > **中文翻译**：**永远不要创建故事** — 此技能仅限于史诗级别

After all requested epics are processed:
> **中文翻译**：处理完所有请求的史诗后：

- **Verdict: COMPLETE** — [N] epic(s) written. Run `/create-stories [epic-slug]` per epic.
  > **中文翻译**：**裁决：完成** — 已写入 [N] 个史诗。每个史诗运行 `/create-stories [epic-slug]`。
- **Verdict: BLOCKED** — user declined all epics, or no eligible systems found.
  > **中文翻译**：**裁决：阻塞** — 用户拒绝了所有史诗，或找不到符合条件的系统。
