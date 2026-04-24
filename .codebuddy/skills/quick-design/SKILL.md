---
name: quick-design
description: "Lightweight design spec for small changes — tuning adjustments, minor mechanics, balance tweaks. Skips full GDD authoring when a system GDD already exists or the change is too small to warrant one. Produces a Quick Design Spec that embeds directly into story files. / 轻量级设计规格，用于小型变更 — 调优调整、次要机制、平衡微调。当系统 GDD 已存在或变更太小不需要时跳过完整 GDD 编写。生成直接嵌入故事文件的快速设计规格。"
argument-hint: "[brief description of the change]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit
---

# Quick Design / 快速设计

This is the **lightweight design path** for changes that don't need a full GDD.
Full GDD authoring via `/design-system` is the heavyweight path. Use this skill
for work under approximately 4 hours of implementation — tuning adjustments,
minor behavioral tweaks, small additions to existing systems, or standalone
features too small to warrant a full document.
> **中文翻译**：这是不需要完整 GDD 的变更的**轻量级设计路径**。通过 `/design-system` 的完整 GDD 编写是重量级路径。此技能用于大约 4 小时实现以下的工作 — 调优调整、次要行为微调、对现有系统的小型添加，或太小而不需要完整文档的独立功能。

**Output:** `design/quick-specs/[name]-[date].md`
> **中文翻译**：**输出**：`design/quick-specs/[name]-[date].md`

**When to run:** Anytime a change is too small for `/design-system` but too
meaningful to implement without a written rationale.
> **中文翻译**：**何时运行**：当变更对 `/design-system` 来说太小但对没有书面理由的实现来说太有意义时。

---

## 1. Classify the Change / 1. 分类变更

First, read the argument and determine which category this change falls into:
> **中文翻译**：首先，读取参数并确定此变更属于哪个类别：

- **Tuning** — changing numbers or balance values in an existing system with no
  behavioral change (most minimal path). Example: "increase jump height from 5
  to 6 units", "reduce enemy patrol speed by 10%". / **调优** — 在现有系统中更改数值或平衡值，无行为变更（最简路径）。示例："将跳跃高度从 5 增加到 6 单位"、"将敌人巡逻速度降低 10%"。
- **Tweak** — a small behavioral change to an existing system that introduces no
  new states, branches, or systems. Example: "make dash invincible on frame 1",
  "allow combo to cancel into roll". / **微调** — 对现有系统的小型行为变更，不引入新状态、分支或系统。示例："使冲刺在第 1 帧无敌"、"允许连招取消到翻滚"。
- **Addition** — adding a small mechanic to an existing system that may introduce
  1-2 new states or interactions. Example: "add a parry window to the block
  mechanic", "add a charge variant to the basic attack". / **添加** — 向现有系统添加小型机制，可能引入 1-2 个新状态或交互。示例："为格挡机制添加弹反窗口"、"为基础攻击添加蓄力变体"。
- **New Small System** — a standalone feature small enough that it has no
  existing GDD and is under approximately one week of implementation work.
  Example: "achievement popup system", "simple day/night visual cycle". / **新小型系统** — 足够小的独立功能，没有现有 GDD 且实现工作大约一周以内。示例："成就弹窗系统"、"简单的日夜视觉循环"。

If the change does NOT fit these categories — it introduces a new system with
significant cross-system dependencies, requires more than one week of
implementation, or fundamentally alters an existing system's core rules — stop
and redirect to `/design-system` instead.
> **中文翻译**：如果变更不符合这些类别 — 它引入了具有重要跨系统依赖的新系统、需要超过一周的实现，或根本性地改变了现有系统的核心规则 — 停止并重定向到 `/design-system`。

Present the classification to the user and confirm it is correct before
proceeding. If there is no argument, ask the user to describe the change.
> **中文翻译**：在继续之前向用户展示分类并确认其正确。如果没有参数，请用户描述变更。

---

## 2. Context Scan / 2. 上下文扫描

Before drafting anything, read the relevant context:
> **中文翻译**：在起草任何内容之前，读取相关上下文：

- Search `design/gdd/` for the GDD most relevant to this change. Read the
  sections that this change would affect. / 在 `design/gdd/` 中搜索与此变更最相关的 GDD。读取此变更会影响的章节。
- Check whether `design/gdd/systems-index.md` exists. If it does, read it to
  understand where this system sits in the dependency graph and what tier it
  belongs to. If it does not exist, note "No systems index found — skipping
  dependency tier check." and continue. / 检查 `design/gdd/systems-index.md` 是否存在。如果存在，读取它以了解此系统在依赖图中的位置和所属层级。如果不存在，注明"未找到系统索引 — 跳过依赖层级检查。"并继续。
- Check `design/quick-specs/` for any prior quick specs that touched this
  system — avoid contradicting them. / 检查 `design/quick-specs/` 中是否有涉及此系统的先前快速规格 — 避免与之矛盾。
- If this is a Tuning change, also check `assets/data/` for the data file that
  holds the relevant values. / 如果是调优变更，还要检查 `assets/data/` 中保存相关值的数据文件。

Report what was found: "Found GDD at [path]. Relevant section: [section name].
No conflicting quick specs found." (or note any conflicts found.)
> **中文翻译**：报告发现的内容："在 [路径] 找到 GDD。相关章节：[章节名]。未发现冲突的快速规格。"（或注明发现的任何冲突。）

---

## 3. Draft the Quick Design Spec / 3. 起草快速设计规格

Use the appropriate spec format for the change category.
> **中文翻译**：根据变更类别使用适当的规格格式。

### For Tuning changes / 对于调优变更

Produce a single table:
> **中文翻译**：生成单个表格：

```markdown
# Quick Design Spec: [Title]

**Type**: Tuning
**System**: [System name]
**GDD Reference**: `design/gdd/[filename].md` — Tuning Knobs section
**Date**: [today]

## Change

| Parameter | Old Value | New Value | Rationale |
|-----------|-----------|-----------|-----------|
| [param]   | [old]     | [new]     | [why]     |

## Tuning Knob Mapping

Maps to GDD Tuning Knob: [knob name and its documented range].
New value is [within / at the edge of / outside] the documented range.
[If outside: explain why the range should be extended.]

## Acceptance Criteria

- [ ] [Parameter] reads [new value] from `assets/data/[file]`
- [ ] Behavior difference is observable in [specific context]
- [ ] No regression in [related behavior]
```

### For Tweak and Addition changes / 对于微调和添加变更

```markdown
# Quick Design Spec: [Title]

**Type**: [Tweak / Addition]
**System**: [System name]
**GDD Reference**: `design/gdd/[filename].md`
**Date**: [today]

## Change Summary

[1-2 sentences describing what changes and why.]

## Motivation

[Why is this change needed? What player experience problem does it solve?
Reference the relevant MDA aesthetic or player feedback if applicable.]

## Design Delta

Current GDD says (quoting `design/gdd/[filename].md`, [section]):

> [exact quote of the relevant rule or description]

This spec changes that to:

[New rule or description, written with the same precision as a GDD Detailed
Rules section. A programmer should be able to implement from this text alone.]

## New Rules / Values

[Full unambiguous statement of the replacement content. If this introduces
new states, list them. If it introduces new parameters, define their ranges.]

## Affected Systems

| System | Impact | Action Required |
|--------|--------|-----------------|
| [system] | [how it is affected] | [update GDD / update data file / no action] |

## Acceptance Criteria

- [ ] [Specific, testable criterion 1]
- [ ] [Specific, testable criterion 2]
- [ ] [Specific, testable criterion 3]
- [ ] No regression: [the original behavior this must not break]

## GDD Update Required?

[Yes / No]
[If yes: which file, which section, and what the update should say.]
```

### For New Small System changes / 对于新小型系统变更

Use a trimmed GDD structure. Include only the sections that are directly
necessary — skip Player Fantasy, full Formulas, and Edge Cases unless the
system specifically requires them.
> **中文翻译**：使用精简的 GDD 结构。仅包含直接必要的章节 — 跳过玩家幻想、完整公式和边缘情况，除非系统特别需要。

```markdown
# Quick Design Spec: [Title]

**Type**: New Small System
**Scope**: [1-2 sentence description of what this system does and doesn't do]
**Date**: [today]
**Estimated Implementation**: [hours]

## Overview

[One paragraph a new team member could understand. What does this system do,
when does it activate, and what does it produce?]

## Core Rules

[Unambiguous rules for the system. Use numbered lists for sequential behavior
and bullet lists for conditions. Be precise enough that a programmer can
implement without asking questions.]

## Tuning Knobs

| Knob | Default | Range | Category | Rationale |
|------|---------|-------|----------|-----------|
| [name] | [value] | [min–max] | [feel/curve/gate] | [why this default] |

All values must live in `assets/data/[appropriate-file].json`, not hardcoded.

## Acceptance Criteria

- [ ] [Functional criterion: does the right thing]
- [ ] [Functional criterion: handles the edge case]
- [ ] [Experiential criterion: feels right — what a playtest validates]
- [ ] [Regression criterion: does not break adjacent system]

## Systems Index

This system is not currently in `design/gdd/systems-index.md`.
[If it should be added: suggest which layer and priority tier.]
[If it is too small to track: state "This system is below systems-index
tracking threshold — quick spec is sufficient."]
```

---

## 4. Approval and Filing / 4. 批准和归档

Present the draft to the user in full. Then ask:
> **中文翻译**：向用户完整展示草案。然后询问：

"May I write this Quick Design Spec to
`design/quick-specs/[kebab-case-title]-[YYYY-MM-DD].md`?"
> **中文翻译**："我可以将此快速设计规格写入 `design/quick-specs/[kebab-case-title]-[YYYY-MM-DD].md` 吗？"

Use today's date in the filename. The title should be a kebab-case description
of the change (e.g., `jump-height-tuning-2026-03-10`,
`parry-window-addition-2026-03-10`).
> **中文翻译**：在文件名中使用今天的日期。标题应为变更的 kebab-case 描述（例如 `jump-height-tuning-2026-03-10`、`parry-window-addition-2026-03-10`）。

If yes, create the `design/quick-specs/` directory if it does not exist, then
write the file.
> **中文翻译**：如果是，如果 `design/quick-specs/` 目录不存在则创建，然后写入文件。

If a GDD update is required (flagged in the spec), ask separately after
writing the quick spec:
> **中文翻译**：如果需要 GDD 更新（在规格中标记），在写入快速规格后单独询问：

"This spec modifies rules in [System Name]. May I update
`design/gdd/[filename].md` — specifically the [section name] section?"
> **中文翻译**："此规格修改了 [系统名称] 中的规则。我可以更新 `design/gdd/[filename].md` — 特别是 [章节名] 部分吗？"

Show the exact text that would be changed (old vs. new) before asking. Do not
make GDD edits without explicit approval.
> **中文翻译**：在询问前展示将被更改的确切文本（旧 vs. 新）。未经明确批准不要进行 GDD 编辑。

---

## 5. Handoff / 5. 交接

After writing the file, output:
> **中文翻译**：写入文件后，输出：

```
Quick Design Spec written to: design/quick-specs/[filename].md
Type: [Tuning / Tweak / Addition / New Small System]
System: [system name]
GDD update: [Required — pending approval / Applied / Not required]

Next step: This spec is ready for `/story-readiness` validation before
implementation. Reference this spec in the story's GDD Reference field.
```

> **中文翻译**：
> ```
> 快速设计规格已写入：design/quick-specs/[filename].md
> 类型：[调优 / 微调 / 添加 / 新小型系统]
> 系统：[系统名称]
> GDD 更新：[需要 — 待批准 / 已应用 / 不需要]
>
> 下一步：此规格已准备好在实现前进行 `/story-readiness` 验证。在故事的 GDD 引用字段中引用此规格。
> ```

### Pipeline Notes / 管线说明

Verdict: **COMPLETE** — quick design spec written and ready for implementation.
> **中文翻译**：裁决：**完成** — 快速设计规格已编写并准备好实现。

Quick Design Specs **bypass** `/design-review` and `/review-all-gdds` by
design. They are for small, low-risk, well-scoped changes where the cost of
the full review pipeline exceeds the risk of the change itself.
> **中文翻译**：快速设计规格按设计**绕过** `/design-review` 和 `/review-all-gdds`。它们用于小型、低风险、范围明确的变更，其中完整审查管线的成本超过变更本身的风险。

Redirect to the full pipeline if any of the following are true:
> **中文翻译**：如果以下任一条件为真，重定向到完整管线：

- The change adds a new system that belongs in the systems index / 变更添加了属于系统索引的新系统
- The change significantly alters cross-system behavior or a system's
  contracts with other systems / 变更显著改变跨系统行为或系统与其他系统的契约
- The change introduces new player-facing mechanics that affect the
  game's MDA aesthetic balance / 变更引入影响游戏 MDA 美学平衡的面向玩家的新机制
- Implementation is likely to exceed one week of work / 实现可能超过一周的工作量

In those cases: "This change has grown beyond quick-spec scope. I recommend
using `/design-system` to author a full GDD for this."
> **中文翻译**：在这些情况下："此变更已超出快速规格的范围。我建议使用 `/design-system` 为此编写完整 GDD。"

---

## Recommended Next Steps / 推荐的下一步

- Run `/story-readiness [story-path]` to validate the story before implementation begins — reference this spec in the story's GDD Reference field / 运行 `/story-readiness [故事路径]` 在实现开始前验证故事 — 在故事的 GDD 引用字段中引用此规格
- Run `/dev-story [story-path]` to implement once the story passes readiness checks / 一旦故事通过就绪检查，运行 `/dev-story [故事路径]` 进行实现
- If the change is larger than expected, run `/design-system [system-name]` to author a full GDD instead / 如果变更比预期大，运行 `/design-system [系统名称]` 编写完整 GDD
