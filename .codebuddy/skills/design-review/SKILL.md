---
name: design-review
description: "Reviews a game design document for completeness, internal consistency, implementability, and adherence to project design standards. Run this before handing a design document to programmers. / 审查游戏设计文档的完整性、内部一致性、可实现性和项目设计标准遵循情况。在将设计文档交给程序员之前运行此技能。"
argument-hint: "[path-to-design-doc] [--depth full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Task, AskUserQuestion
---

<!-- 中文翻译 -->
## Phase 0: Parse Arguments
> **中文翻译**：## 第 0 阶段：解析参数


Extract `--depth [full|lean|solo]` if present. Default is `full` when no flag is given.
> **中文翻译**：如果存在，则提取“--深度[full|lean|solo]”。当没有给出标志时，默认值为“full”。


**Note**: `--depth` controls the *analysis depth* of this skill (how many specialist agents are spawned). It is independent of the global review mode in `production/review-mode.txt`, which controls director gate spawning. These are two different concepts — `--depth` is about how thoroughly *this* skill analyses the document.
> **中文翻译**：**注意**：`--深度`控制该技能的*分析深度*（产生多少个专家代理）。它独立于“生产/审查模式.txt”中的全局​​审查模式，该模式控制导演门的产生。这是两个不同的概念——“--深度”是关于*此*技能分析文档的彻底程度。


- **`full`**: Complete review — all phases + specialist agent delegation (Phase 3b)
  > **中文翻译**：**`全面`**：完整审查 - 所有阶段 + 专家代理授权（阶段 3b）
- **`lean`**: All phases, no specialist agents — faster, single-session analysis
  > **中文翻译**：**`精益**：所有阶段，无需专业代理 - 更快的单会话分析
- **`solo`**: Phases 1-4 only, no delegation, no Phase 5 next-step prompt — use when called from within another skill
  > **中文翻译**：**`solo`**：仅第 1-4 阶段，无委托，无第 5 阶段下一步提示 - 从另一个技能中调用时使用


---

<!-- 中文翻译 -->
## Phase 1: Load Documents

Read the target design document in full. Read CODEBUDDY.md to understand project context and standards. Read related design documents referenced or implied by the target doc (check `design/gdd/` for related systems).

**Dependency graph validation:** For every system listed in the Dependencies section, use Glob to check whether its GDD file exists in `design/gdd/`. Flag any that don't exist yet — these are broken references that downstream authors will hit.

**Lore/narrative alignment:** If `design/gdd/game-concept.md` or any file in `design/narrative/` exists, read it. Note any mechanical choices in this GDD that contradict established world rules, tone, or design pillars. Pass this context to `game-designer` in Phase 3b.

**Prior review check:** Check whether `design/gdd/reviews/[doc-name]-review-log.md` exists. If it does, read the most recent entry — note what verdict was given and what blocking items were listed. This session is a re-review; track whether prior items were addressed.

---

<!-- 中文翻译 -->
## Phase 2: Completeness Check
> **中文翻译**：## 第 2 阶段：完整性检查


Evaluate against the Design Document Standard checklist:
> **中文翻译**：根据设计文档标准清单进行评估：


- [ ] Has Overview section (one-paragraph summary)
  > **中文翻译**：[ ] 有概述部分（一段摘要）
- [ ] Has Player Fantasy section (intended feeling)
  > **中文翻译**：[ ] 有玩家幻想部分（预期的感觉）
- [ ] Has Detailed Rules section (unambiguous mechanics)
  > **中文翻译**：[ ] 有详细规则部分（明确的机制）
- [ ] Has Formulas section (all math defined with variables)
  > **中文翻译**：[ ] 有公式部分（所有数学都用变量定义）
- [ ] Has Edge Cases section (unusual situations handled)
  > **中文翻译**：[ ] 有边缘情况部分（处理异常情况）
- [ ] Has Dependencies section (other systems listed)
  > **中文翻译**：[ ] 具有依赖项部分（列出了其他系统）
- [ ] Has Tuning Knobs section (configurable values identified)
  > **中文翻译**：[ ] 具有调音旋钮部分（已识别可配置值）
- [ ] Has Acceptance Criteria section (testable success conditions)
  > **中文翻译**：[ ] 具有验收标准部分（可测试的成功条件）


---

<!-- 中文翻译 -->
## Phase 3: Consistency and Implementability

**Internal consistency:**
- Do the formulas produce values that match the described behavior?
- Do edge cases contradict the main rules?
- Are dependencies bidirectional (does the other system know about this one)?

**Implementability:**
- Are the rules precise enough for a programmer to implement without guessing?
- Are there any "hand-wave" sections where details are missing?
- Are performance implications considered?

**Cross-system consistency:**
- Does this conflict with any existing mechanic?
- Does this create unintended interactions with other systems?
- Is this consistent with the game's established tone and pillars?

---

<!-- 中文翻译 -->
## Phase 3b: Adversarial Specialist Review (full mode only)
> **中文翻译**：## 第 3b 阶段：对抗性专家审查（仅限完整模式）


**Skip this phase in `lean` or `solo` mode.**
> **中文翻译**：**在“lean”或“solo”模式下跳过此阶段。**


**This phase is MANDATORY in full mode.** Do not skip it.
> **中文翻译**：**此阶段在完整模式下是强制性的。** 不要跳过它。


**Before spawning any agents**, print this notice: > "Full review: spawning specialist agents in parallel. This typically takes 8–15 minutes. Use `--review lean` for faster single-session analysis."
> **中文翻译**：**在生成任何代理之前**，打印此通知：>“全面审查：并行生成专家代理。这通常需要 8-15 分钟。使用 `--review Lean` 进行更快的单会话分析。”


<!-- 中文翻译 -->
### Step 1 — Identify all domains the GDD touches
> **中文翻译**：### 第 1 步 — 确定 GDD 涉及的所有领域


Read the GDD and identify every domain present. A GDD can touch multiple domains simultaneously — be thorough. Common signals:
> **中文翻译**：阅读 GDD 并识别存在的每个域。 GDD 可以同时触及多个领域——要彻底。常见信号：


| If the GDD contains... | Spawn these agents |
  <!-- 翻译: 如果 GDD 包含... -->
  <!-- 翻译: 产生这些代理 -->
|------------------------|-------------------|
| Costs, prices, drops, rewards, economy | `economy-designer` |
  <!-- 翻译: 成本、价格、掉落、奖励、经济 -->
  <!-- 翻译: “经济设计师” -->
| Combat stats, damage, health, DPS | `game-designer`, `systems-designer` |
  <!-- 翻译: 战斗统计、伤害、生命值、DPS -->
  <!-- 翻译: “游戏设计师”、“系统设计师” -->
| AI behaviour, pathfinding, targeting | `ai-programmer` |
  <!-- 翻译: AI 行为、寻路、瞄准 -->
  <!-- 翻译: `ai程序员` -->
| Level layout, spawning, wave structure | `level-designer` |
  <!-- 翻译: 关卡布局、产卵、波浪结构 -->
  <!-- 翻译: `关卡设计师` -->
| Player progression, XP, unlocks | `economy-designer`, `game-designer` |
  <!-- 翻译: 玩家进度、XP、解锁 -->
  <!-- 翻译: “经济设计师”、“游戏设计师” -->
| UI, HUD, menus, player-facing displays | `ux-designer`, `ui-programmer` |
  <!-- 翻译: UI、HUD、菜单、面向玩家的显示器 -->
  <!-- 翻译: `ux 设计师`、`ui 程序员` -->
| Dialogue, quests, story, lore | `narrative-director` |
  <!-- 翻译: 对话、任务、故事、传说 -->
  <!-- 翻译: 「叙事导演」 -->
| Animation, feel, timing, juice | `gameplay-programmer` |
  <!-- 翻译: 动画、感觉、时间、果汁 -->
  <!-- 翻译: `游戏程序员` -->
| Multiplayer, sync, replication | `network-programmer` |
  <!-- 翻译: 多人游戏、同步、复制 -->
  <!-- 翻译: `网络程序员` -->
| Audio cues, music triggers | `audio-director` |
  <!-- 翻译: 音频提示、音乐触发器 -->
  <!-- 翻译: `音频导演` -->
| Performance, draw calls, memory | `performance-analyst` |
  <!-- 翻译: 性能、绘制调用、内存 -->
  <!-- 翻译: “绩效分析师” -->
| Engine-specific patterns or APIs | Primary engine specialist (from `.codebuddy/docs/technical-preferences.md`) |
  <!-- 翻译: 特定于引擎的模式或 API -->
  <!-- 翻译: 主要引擎专家（来自“.codebuddy/docs/technical-preferences.md”） -->
| Acceptance criteria, test coverage | `qa-lead` |
  <!-- 翻译: 验收标准、测试覆盖率 -->
  <!-- 翻译: `qa 领导` -->
| Data schema, resource structure | `systems-designer` |
  <!-- 翻译: 数据模式、资源结构 -->
  <!-- 翻译: `系统设计师` -->
| Any gameplay system | `game-designer` (always) |
  <!-- 翻译: 任何游戏系统 -->
  <!-- 翻译: “游戏设计师”（始终） -->


**Always spawn `game-designer` and `systems-designer` as a baseline minimum.** Every GDD touches their domain.
> **中文翻译**：**始终将“游戏设计者”和“系统设计者”作为最低基线。**每个 GDD 都涉及其领域。


<!-- 中文翻译 -->
### Step 2 — Spawn all relevant specialists in parallel
> **中文翻译**：### 步骤 2 — 并行产生所有相关专家


**CRITICAL: Task in this skill spawns a SUBAGENT — a separate independent Claude session with its own context window. It is NOT task tracking. Do NOT simulate specialist perspectives internally. Do NOT reason through domain views yourself. You MUST issue actual Task calls. A simulated review is not a specialist review.**
> **中文翻译**：**关键：此技能中的任务会产生一个 SUBAGENT - 一个单独的独立 Claude 会话，具有自己的上下文窗口。这不是任务跟踪。不要在内部模拟专家的观点。不要自己通过域视图进行推理。您必须发出实际的任务调用。模拟审核不是专家审核。**


Issue all Task calls simultaneously. Do NOT spawn one at a time.
> **中文翻译**：同时发出所有任务调用。不要一次生成一个。


**Prompt each specialist adversarially:** > "Here is the GDD for [system] and the main review's structural findings so far. > Your job is NOT to validate this design — your job is to find problems. > Challenge the design choices from your domain expertise. What is wrong, > underspecified, likely to cause problems, or missing entirely? > Be specific and critical. Disagreement with the main review is welcome."
> **中文翻译**：**以对抗性的方式提示每位专家：** > “这是 [系统] 的 GDD 和迄今为止主要审查的结构发现。 > 您的工作不是验证此设计 - 您的工作是发现问题。 > 挑战您的领域专业知识的设计选择。出了什么问题， > 未明确说明，可能会导致问题，或完全遗漏？ > 具体而关键。欢迎与主要审查不同意见。”


**Additional instructions per agent type:**
> **中文翻译**：**每种代理类型的附加说明：**


- **`game-designer`**: Anchor your review to the Player Fantasy stated in Section B of this GDD. Does this design actually deliver that fantasy? Would a player feel the intended experience? Flag any rules that serve implementability but undermine the stated feeling.
  > **中文翻译**：**`游戏设计师`**：将您的评论锚定在本 GDD B 部分中所述的玩家幻想上。这个设计真的能实现那种幻想吗？玩家会感受到预期的体验吗？标记任何有助于实施但破坏所表达的感觉的规则。


- **`systems-designer`**: For every formula in the GDD, plug in boundary values (minimum and maximum plausible inputs). Report whether any outputs go degenerate — negative values, division by zero, infinity, or nonsensical results at the extremes.
  > **中文翻译**：**`系统设计器`**：对于 GDD 中的每个公式，插入边界值（最小和最大合理输入）。报告是否有任何输出退化——负值、除以零、无穷大或极端情况下的无意义结果。


- **`qa-lead`**: Review every acceptance criterion. Flag any that are not independently testable — phrases like "feels balanced", "works correctly", "performs well" are not ACs. Suggest concrete rewrites for any that fail this test.
  > **中文翻译**：**`qa-lead`**：审查每项验收标准。标记任何不可独立测试的内容——诸如“感觉平衡”、“工作正常”、“表现良好”之类的短语不是 AC。针对未通过此测试的任何内容提出具体重写建议。


<!-- 中文翻译 -->
### Step 3 — Senior lead review
> **中文翻译**：### 第 3 步 — 高级主管审核


After all specialists respond, spawn `creative-director` as the **senior reviewer**:
> **中文翻译**：在所有专家做出回应后，生成“创意总监”作为**高级审阅者**：

- Provide: the GDD, all specialist findings, any disagreements between them
  > **中文翻译**：提供：GDD、所有专家调查结果、他们之间的任何分歧
- Ask: "Synthesise these findings. What are the most important issues? Do you agree with the specialists? What is your overall verdict on this design?"
  > **中文翻译**：问：“综合这些发现。最重要的问题是什么？你同意专家的观点吗？你对这个设计的总体结论是什么？”
- The creative-director's synthesis becomes the **final verdict** in Phase 4.
  > **中文翻译**：创意总监的综合结果成为第四阶段的**最终裁决**。


<!-- 中文翻译 -->
### Step 4 — Surface disagreements
> **中文翻译**：### 步骤 4 — 表面分歧


If specialists disagree with each other or with the creative-director, do NOT silently pick one view. Present the disagreement explicitly in Phase 4 so the user can adjudicate.
> **中文翻译**：如果专家之间或与创意总监意见不一致，不要默默地选择一种观点。在第 4 阶段明确提出分歧，以便用户可以做出裁决。


Mark every finding with its source: `[game-designer]`, `[economy-designer]`, `[creative-director]` etc.
> **中文翻译**：标记每项发现的来源：“[游戏设计师]”、“[经济设计师]”、“[创意总监]”等。


---

<!-- 中文翻译 -->
## Phase 4: Output Review

```
## Design Review: [Document Title]
Specialists consulted: [list agents spawned]
Re-review: [Yes — prior verdict was X on YYYY-MM-DD / No — first review]

### Completeness: [X/8 sections present]
[List missing sections]

### Dependency Graph
[List each declared dependency and whether its GDD file exists on disk]
- ✓ enemy-definition-data.md — exists
- ✗ loot-system.md — NOT FOUND (file does not exist yet)

### Required Before Implementation
[Numbered list — blocking issues only. Each item tagged with source agent.]

### Recommended Revisions
[Numbered list — important but not blocking. Source-tagged.]

### Specialist Disagreements
[Any cases where agents disagreed with each other or with the main review.
Present both sides — do not silently resolve.]

### Nice-to-Have
[Minor improvements, low priority.]

### Senior Verdict [creative-director]
[Creative director's synthesis and overall assessment.]

### Scope Signal
Estimate implementation scope based on: dependency count, formula count,
systems touched, and whether new ADRs are required.
- **S** — single system, no formulas, no new ADRs, <3 dependencies
- **M** — moderate complexity, 1-2 formulas, 3-6 dependencies
- **L** — multi-system integration, 3+ formulas, may require new ADR
- **XL** — cross-cutting concern, 5+ dependencies, multiple new ADRs likely
Label clearly: "Rough scope signal: M (producer should verify before sprint planning)"

### Verdict: [APPROVED / NEEDS REVISION / MAJOR REVISION NEEDED]
```

This skill is read-only — no files are written during Phase 4.

---

<!-- 中文翻译 -->
## Phase 5: Next Steps
> **中文翻译**：## 第 5 阶段：后续步骤


Use `AskUserQuestion` for ALL closing interactions. Never plain text.
> **中文翻译**：对所有结束交互使用“AskUserQuestion”。绝不是纯文本。


**First widget — what to do next:**
> **中文翻译**：**第一个小部件 - 接下来做什么：**


If APPROVED (first-pass, no revision needed), proceed directly to the systems-index widget, review-log widget, then the final closing widget. Do not show a separate "what to do" widget — the final closing widget covers next steps.
> **中文翻译**：如果已批准（第一次通过，无需修改），则直接进入系统索引小部件、审查日志小部件，然后是最终关闭小部件。不要显示单独的“做什么”小部件 - 最终的关闭小部件涵盖后续步骤。


If NEEDS REVISION or MAJOR REVISION NEEDED, options:
> **中文翻译**：如果需要修订或需要重大修订，选项：

- `[A] Revise the GDD now — address blocking items together`
  > **中文翻译**：“[A] 立即修改 GDD — 一起解决阻塞项目”
- `[B] Stop here — revise in a separate session`
  > **中文翻译**：“[B] 到此为止——在单独的会话中进行修改”
- `[C] Accept as-is and move on (only if all items are advisory)`
  > **中文翻译**：`[C] 按原样接受并继续（仅当所有项目都是建议性的时）`


**If user selects [A] — Revise now:**
> **中文翻译**：**如果用户选择 [A] — 立即修改：**


Work through all blocking items, asking for design decisions only where you cannot resolve the issue from the GDD and existing docs alone. Group all design-decision questions into a single multi-tab `AskUserQuestion` before making any edits — do not interrupt mid-revision for each blocker individually.
> **中文翻译**：解决所有阻塞项目，仅在无法仅通过 GDD 和现有文档解决问题时才要求设计决策。在进行任何编辑之前，将所有设计决策问题分组到一个多选项卡“AskUserQuestion”中 - 不要单独中断每个阻止程序的中间修改。


After all revisions are complete, show a summary table (blocker → fix applied) and use `AskUserQuestion` for a **post-revision closing widget**:
> **中文翻译**：所有修订完成后，显示一个汇总表（阻止程序→已应用修复）并使用“AskUserQuestion”作为**修订后关闭小部件**：


- Prompt: "Revisions complete — [N] blockers resolved. What next?"
  > **中文翻译**：提示：“修订完成 - [N] 个阻碍已解决。接下来做什么？”
- Note current context usage: if context is above ~50%, add: "(Recommended: /clear before re-review — this session has used X% context. A full re-review runs 5 agents and needs clean context.)"
  > **中文翻译**：注意当前上下文使用情况：如果上下文高于 ~50%，请添加：“（建议：在重新审核之前 /clear — 此会话已使用 X% 上下文。完整的重新审核运行 5 个代理并需要干净的上下文。）”
- Options:
  > **中文翻译**：选项：
  - `[A] Re-review in a new session — run /design-review [doc-path] after /clear`
  > **中文翻译**：`[A] 在新会话中重新审查 - 在 /clear 之后运行 /design-review [doc-path]`
  - `[B] Accept revisions and mark Approved — update systems index, skip re-review`
  > **中文翻译**：`[B] 接受修订并标记为已批准 — 更新系统索引，跳过重新审核`
  - `[C] Move to next system — /design-system [next-system] (#N in design order)`
  > **中文翻译**：`[C] 移至下一个系统 — /design-system [next-system]（设计顺序中的 #N）`
  - `[D] Stop here`
  > **中文翻译**：`[D] 停在这里`


Never end the revision flow with plain text. Always close with this widget.
> **中文翻译**：切勿以纯文本结束修订流程。始终关闭此小部件。


**Second widget — systems index update (always show this separately):**
> **中文翻译**：**第二个小部件 - 系统索引更新（始终单独显示）：**


Use a second `AskUserQuestion`:
> **中文翻译**：使用第二个“AskUserQuestion”：

- Prompt: "May I update `design/gdd/systems-index.md` to mark [system] as [In Review / Approved]?"
  > **中文翻译**：提示：“我可以更新`design/gdd/systems-index.md`以将[系统]标记为[正在审核/已批准]吗？”
- Options: `[A] Yes — update it` / `[B] No — leave it as-is`
  > **中文翻译**：选项：“[A] 是 - 更新它”/“[B] 否 - 保持原样”


**Third widget — review log (always offer):**
> **中文翻译**：**第三个小部件 - 审查日志（始终提供）：**


Use a third `AskUserQuestion`:
> **中文翻译**：使用第三个“AskUserQuestion”：

- Prompt: "May I append this review summary to `design/gdd/reviews/[doc-name]-review-log.md`? This creates a revision history so future re-reviews can track what changed."
  > **中文翻译**：提示：“我可以将此审核摘要附加到 `design/gdd/reviews/[doc-name]-review-log.md` 中吗？这会创建修订历史记录，以便将来的重新审核可以跟踪更改的内容。”
- Options: `[A] Yes — append to review log` / `[B] No — skip`
  > **中文翻译**：选项：“[A] 是 - 附加到审核日志”/“[B] 否 - 跳过”


If yes, append an entry in this format:
> **中文翻译**：如果是，请附加以下格式的条目：

```
## Review — [YYYY-MM-DD] — Verdict: [APPROVED / NEEDS REVISION / MAJOR REVISION NEEDED]
Scope signal: [S/M/L/XL]
Specialists: [list]
Blocking items: [count] | Recommended: [count]
Summary: [2-3 sentence summary of key findings from creative-director verdict]
Prior verdict resolved: [Yes / No / First review]
```

---

**Final closing widget — always show after all file writes complete:**

Once the systems-index and review-log widgets are answered, check project state and show one final `AskUserQuestion`:

Before building options, read:
- `design/gdd/systems-index.md` — find any system with Status: In Review or NEEDS REVISION (other than the one just reviewed)
- Count `.md` files in `design/gdd/` (excluding game-concept.md, systems-index.md) to determine if `/review-all-gdds` is worth offering (≥2 GDDs)
- Find the next system with Status: Not Started in design order

Build the option list dynamically — only include options that are genuinely next:
- `[_] Run /design-review [other-gdd-path] — [system name] is still [In Review / NEEDS REVISION]` (include if another GDD needs review)
- `[_] Run /consistency-check — verify this GDD's values don't conflict with existing GDDs` (always include if ≥1 other GDD exists)
- `[_] Run /review-all-gdds — holistic design-theory review across all designed systems` (include if ≥2 GDDs exist)
- `[_] Run /design-system [next-system] — next in design order` (always include, name the actual system)
- `[_] Stop here`

Assign letters A, B, C… only to included options. Mark the most pipeline-advancing option as `(recommended)`.

Never end the skill with plain text after file writes. Always close with this widget.
