---
name: ux-design
description: "Guided, section-by-section UX spec authoring for a screen, flow, or HUD. Reads game concept, player journey, and relevant GDDs to provide context-aware design guidance. Produces ux-spec.md (per screen/flow) or hud-design.md using the studio templates. / 引导式逐节 UX 规格编写，用于屏幕、流程或 HUD。读取游戏概念、玩家旅程和相关 GDD 以提供上下文感知的设计指导。使用工作室模板生成 ux-spec.md（每个屏幕/流程）或 hud-design.md。"
argument-hint: "[screen/flow name] or 'hud' or 'patterns'"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion, Task
agent: ux-designer
---

When this skill is invoked: / 当调用此技能时：

## 1. Parse Arguments & Determine Mode / 第 1 步：解析参数和确定模式

Three authoring modes exist based on the argument: / 基于参数有三种创作模式：

| Argument | Mode | Output file |
|----------|------|-------------|
| `hud` | HUD design | `design/ux/hud.md` |
| `patterns` | Interaction pattern library | `design/ux/interaction-patterns.md` |
| Any other value (e.g., `main-menu`, `inventory`) | UX spec for a screen or flow | `design/ux/[argument].md` |
| No argument | Ask the user | (see below) |

**If no argument is provided**, do not fail — ask instead. Use `AskUserQuestion`: / **如果未提供参数**，不要失败，而是询问。使用 `AskUserQuestion`：
- "What are we designing today?" / "我们今天要设计什么？"
  - Options: "A specific screen or flow (I'll name it)", "The game HUD", "The interaction pattern library", "I'm not sure — help me figure it out" / 选项："特定的屏幕或流程（我会命名）"、"游戏 HUD"、"交互模式库"、"我不确定 - 帮我搞清楚"

If the user selects "I'll name it" or types a screen name, normalize it to kebab-case / 如果用户选择"我会命名"或输入屏幕名称，将其规范化为 kebab-case
for the filename (e.g., "Main Menu" becomes `main-menu`). / 用于文件名（例如，"Main Menu" 变成 `main-menu`）

---

## 2. Gather Context (Read Phase) / 第 2 步：收集上下文（阅读阶段）

Read all relevant context **before** asking the user anything. The skill's value / 在询问用户任何问题之前，**先**阅读所有相关上下文。此技能的价值
comes from arriving informed. / 在于了解情况后开始工作

### 2a: Required Reads / 必需阅读

- **Game concept**: Read `design/gdd/game-concept.md` — if missing, warn: / **游戏概念**：阅读 `design/gdd/game-concept.md` — 如果缺失，警告：
  > "No game concept found. Run `/brainstorm` first to establish the game's / > "未找到游戏概念。请先运行 `/brainstorm` 来建立游戏的
  > foundation before designing UX." / > 基础，然后再进行 UX 设计"
  > Continue anyway if the user asks. / > 如果用户要求，无论如何继续

### 2b: Player Journey / 玩家旅程

Read `design/player-journey.md` if it exists. For each relevant section, extract: / 如果存在，阅读 `design/player-journey.md`。对于每个相关部分，提取：
- Which journey phase(s) does this screen appear in? / 此屏幕出现在哪个旅程阶段？
- What is the player's emotional state on arrival at this screen? / 玩家到达此屏幕时的情感状态是什么？
- What player need is this screen serving in the journey? / 此屏幕在旅程中满足玩家的什么需求？
- What critical moments (from the journey map) does this screen deliver? / 此屏幕提供哪些关键时刻（来自旅程地图）？

If the player journey file does not exist, note the gap and proceed: / 如果玩家旅程文件不存在，记录差距并继续：
> "No player journey map found at `design/player-journey.md`. Designing without it / > "在 `design/player-journey.md` 未找到玩家旅程地图。没有它进行设计
> means we'll be making assumptions about player context. Consider running a player / > 意味着我们将对玩家上下文做出假设。考虑在此规范草案完成后
> journey session after this spec is drafted." / > 运行一个玩家旅程会话"

### 2c: GDD UI Requirements / GDD UI 要求

Glob `design/gdd/*.md` and grep for `UI Requirements` sections. Read any GDD whose / Glob `design/gdd/*.md` 并 grep 查找 `UI Requirements` 部分。阅读任何
UI Requirements section references this screen by name or category. / UI Requirements 部分按名称或类别引用此屏幕的 GDD

These GDD UI Requirements are the **requirements input** to this spec. Collect them / 这些 GDD UI 要求是此规范的**需求输入**。将它们收集起来
as a list of constraints the spec must satisfy. / 作为规范必须满足的约束条件列表

If designing the HUD, read ALL GDD UI Requirements sections — the HUD aggregates / 如果设计 HUD，阅读所有 GDD UI 要求部分 — HUD 聚合了
requirements from every system. / 来自每个系统的要求

### 2d: Existing UX Specs / 现有 UX 规范

Glob `design/ux/*.md` and note which screens already have specs. For screens that / Glob `design/ux/*.md` 并记录哪些屏幕已有规范。对于将链接到
will link to or from the current screen, read their navigation/flow sections to / 或从此当前屏幕链接的屏幕，阅读它们的导航/流程部分以
find the entry and exit points this spec must match. / 找到此规范必须匹配的入口和出口点

### 2e: Interaction Pattern Library / 交互模式库

If `design/ux/interaction-patterns.md` exists, read the pattern catalog index / 如果 `design/ux/interaction-patterns.md` 存在，阅读模式目录索引
(the list of pattern names and their one-line descriptions). Do not read full / （模式名称及其一行描述的列表）。不要阅读完整的
pattern details — just the catalog. This tells you which patterns already exist / 模式细节 — 只需目录。这告诉你哪些模式已经存在
so you can reference them rather than reinvent them. / 以便你可以引用它们而不是重新发明它们

### 2f: Art Bible / 艺术圣经

Check for `design/art/art-bible.md`. If found, read the visual direction / 检查 `design/art/art-bible.md`。如果找到，阅读视觉方向
section. UX layout must align with the aesthetic commitments already made. / 部分。UX 布局必须与已做出的美学承诺保持一致

### 2g: Accessibility Requirements / 可访问性要求

Check for `design/accessibility-requirements.md`. If found, read it. The spec / 检查 `design/accessibility-requirements.md`。如果找到，阅读它。规范
must satisfy the accessibility tier committed to there. / 必须满足那里承诺的可访问性层级

### 2h: Input Method (from Project Config) / 输入方法（来自项目配置）

Read `.codebuddy/docs/technical-preferences.md` and extract the `## Input & Platform` / 阅读 `.codebuddy/docs/technical-preferences.md` 并提取 `## Input & Platform`
section. Store these values for use throughout the skill — they drive the / 部分。存储这些值以在整个技能中使用 — 它们驱动
Interaction Map and inform accessibility requirements: / 交互地图并告知可访问性要求：

- **Input Methods** — e.g., Keyboard/Mouse, Gamepad, Touch, Mixed / **输入方法** — 例如，键盘/鼠标、游戏手柄、触摸、混合
- **Primary Input** — the dominant input for this game / **主要输入** — 此游戏的主要输入
- **Gamepad Support** — Full / Partial / None / **游戏手柄支持** — 完全 / 部分 / 无
- **Touch Support** — Full / Partial / None / **触摸支持** — 完全 / 部分 / 无
- **Target Platforms** — for safe zone and aspect ratio decisions / **目标平台** — 用于安全区域和宽高比决策

If the section is unconfigured (`[TO BE CONFIGURED]`), ask once: / 如果该部分未配置（`[TO BE CONFIGURED]`），询问一次：
> "Input methods aren't configured yet. What does this game target?" / > "输入方法尚未配置。此游戏的目标是什么？"
> Options: "Keyboard/Mouse only", "Gamepad only", "Both (PC + Console)", "Touch (mobile)", "All of the above" / > 选项："仅键盘/鼠标"、"仅游戏手柄"、"两者都有（PC + 主机）"、"触摸（移动端）"、"以上所有"
>
> (Run `/setup-engine` to save this permanently so you won't be asked again.) / > （运行 `/setup-engine` 永久保存此设置，这样你就不会再被询问）

Store the answer for the rest of this session. Do **not** ask again per section / 存储答案用于此会话的其余部分。每个部分或每个屏幕**不要**再次询问
or per screen. / 

### 2i: Present Context Summary / 呈现上下文摘要

Before any design work, present a brief summary to the user: / 在任何设计工作之前，向用户呈现简要摘要：

> **Designing: [Screen/Flow Name]** / > **设计：[屏幕/流程名称]**
> - Mode: [UX Spec / HUD Design / Pattern Library] / > - 模式：[UX 规范 / HUD 设计 / 模式库]
> - Journey phase(s): [from player-journey.md, or "unknown — no journey map"] / > - 旅程阶段：[来自 player-journey.md，或"未知 — 无旅程地图"]
> - GDD requirements feeding this spec: [count and names, or "none found"] / > - 提供此规范的 GDD 要求：[计数和名称，或"未找到"]
> - Related screens already specced: [list, or "none yet"] / > - 已规范的关联屏幕：[列表，或"尚无"]
> - Known patterns available: [count, or "no pattern library yet"] / > - 可用的已知模式：[计数，或"尚无模式库"]
> - Accessibility tier: [from requirements doc, or "not yet defined"] / > - 可访问性层级：[来自要求文档，或"尚未定义"]
> - Input methods: [from technical-preferences.md, or "asked above"] / > - 输入方法：[来自 technical-preferences.md，或"上面询问过"]

Then ask: "Anything else I should read before we start, or shall we proceed?" / 然后询问："在我们开始之前，还有其他我应该阅读的内容吗，或者我们可以继续了吗？"

---

## 2b. Retrofit Mode Detection / 改造模式检测

Before creating a skeleton, check if the target output file already exists.
> **中文翻译**：在创建骨架之前，检查目标输出文件是否已存在。

Glob `design/ux/[filename].md` (where `[filename]` is the resolved output path from Phase 1).
> **中文翻译**：Glob `design/ux/[filename].md`（其中 `[filename]` 是第 1 步解析的输出路径）。

**If the file exists — retrofit mode:**
> **中文翻译**：**如果文件存在 — 改造模式：**
- Read the file in full
- For each expected section, check whether the body has real content (more than a `[To be designed]` placeholder) or is empty/placeholder
- Present a section status summary to the user: / 向用户呈现节状态摘要：

> "Found existing UX spec at `design/ux/[filename].md`. Here's what's already done:"
> > **中文翻译**：在 `design/ux/[filename].md` 找到现有 UX 规范。以下是已完成的：
> 
> > "| Section | Status |"
> > > **中文翻译**：| 节 | 状态 |
> > "|---------|--------|"
> > "| Overview & Context | [Complete / Empty / Placeholder] |"
> > > **中文翻译**：| 概览与上下文 | [完成 / 空 / 占位符] |
> > "| Player Journey Integration | ... |"
> > > **中文翻译**：| 玩家旅程集成 | ... |
> > "| Screen Layout & Information Architecture | ... |"
> > > **中文翻译**：| 屏幕布局与信息架构 | ... |
> > "| Interaction Model | ... |"
> > > **中文翻译**：| 交互模型 | ... |
> > "| Feedback & State Communication | ... |"
> > > **中文翻译**：| 反馈与状态通信 | ... |
> > "| Accessibility | ... |"
> > > **中文翻译**：| 可访问性 | ... |
> > "| Edge Cases & Error States | ... |"
> > > **中文翻译**：| 边界情况与错误状态 | ... |
> > "| Open Questions | ... |"
> > > **中文翻译**：| 开放问题 | ... |
> 
> > "I'll work on the [N] incomplete sections only — existing content will not be overwritten."
> > > **中文翻译**：我将只处理 [N] 个不完整的节 — 现有内容不会被覆盖。

- Skip Section 3 (skeleton creation) — the file already exists
- In Phase 4 (Section Authoring), only work on sections with Status: Empty or Placeholder
- Use `Edit` to fill placeholders in-place rather than creating a new skeleton

**If the file does not exist — fresh authoring mode:**
> **中文翻译**：**如果文件不存在 — 全新创作模式：**
Proceed to Phase 3 (Create File Skeleton) as normal.
> **中文翻译**：正常进入第 3 步（创建文件骨架）。

---

## 3. Create File Skeleton / 创建文件骨架

Once the user confirms, **immediately** create the output file with empty section
headers. This ensures incremental writes have a target and work survives interruptions.
> **中文翻译**：一旦用户确认，**立即**创建带有空节头的输出文件。这确保增量写入有目标，并且工作在中断后得以保存。

Ask: "May I create the skeleton file at `design/ux/[filename].md`?"
> **中文翻译**：询问："我可以在 `design/ux/[filename].md` 创建骨架文件吗？"

---

<!-- 中文翻译 -->
### Skeleton for UX Spec (screen or flow)

```markdown
# UX Spec: [Screen/Flow Name]

> **Status**: In Design
> **Author**: [user + ux-designer]
> **Last Updated**: [today's date]
> **Journey Phase(s)**: [from context]
> **Template**: UX Spec

---

## Purpose & Player Need

[To be designed]

---

## Player Context on Arrival

[To be designed]

---

## Navigation Position

[To be designed]

---

## Entry & Exit Points

[To be designed]

---

## Layout Specification

### Information Hierarchy

[To be designed]

### Layout Zones

[To be designed]

### Component Inventory

[To be designed]

### ASCII Wireframe

[To be designed]

---

## States & Variants

[To be designed]

---

## Interaction Map

[To be designed]

---

## Events Fired

[To be designed]

---

## Transitions & Animations

[To be designed]

---

## Data Requirements

[To be designed]

---

## Accessibility

[To be designed]

---

## Localization Considerations

[To be designed]

---

## Acceptance Criteria

[To be designed]

---

## Open Questions

[To be designed]
```

---

<!-- 中文翻译 -->
### Skeleton for HUD Design

```markdown
# HUD Design

> **Status**: In Design
> **Author**: [user + ux-designer]
> **Last Updated**: [today's date]
> **Template**: HUD Design

---

## HUD Philosophy

[To be designed]

---

## Information Architecture

### Full Information Inventory

[To be designed]

### Categorization

[To be designed]

---

## Layout Zones

[To be designed]

---

## HUD Elements

[To be designed]

---

## Dynamic Behaviors

[To be designed]

---

## Platform & Input Variants

[To be designed]

---

## Accessibility

[To be designed]

---

## Open Questions

[To be designed]
```

---

<!-- 中文翻译 -->
### Skeleton for Interaction Pattern Library

```markdown
# Interaction Pattern Library

> **Status**: In Design
> **Author**: [user + ux-designer]
> **Last Updated**: [today's date]
> **Template**: Interaction Pattern Library

---

## Overview

[To be designed]

---

## Pattern Catalog

[To be designed]

---

## Patterns

[Individual pattern entries added here as they are defined]

---

## Gaps & Patterns Needed

[To be designed]

---

## Open Questions

[To be designed]
```

---

After writing the skeleton, update `production/session-state/active.md` with:
- Task: Designing [screen/flow name] UX spec
- Current section: Starting (skeleton created)
- File: design/ux/[filename].md
> **中文翻译**：写入骨架后，更新 `production/session-state/active.md`：
> - 任务：设计 [屏幕/流程名称] UX 规格
> - 当前部分：开始（骨架已创建）
> - 文件：design/ux/[filename].md

---

## 4. Section-by-Section Authoring / 逐节创作

Walk through each section in order. For **each section**, follow this cycle: / 按顺序处理每个节。对于**每个节**，遵循此周期：

```
Context  ->  Questions  ->  Options  ->  Decision  ->  Draft  ->  Approval  ->  Write
上下文 -> 问题 -> 选项 -> 决策 -> 草稿 -> 批准 -> 写入
```

1. **Context**: State what this section needs to contain and surface any relevant
   constraints from context gathered in Phase 2. / **上下文**：说明此节需要包含什么内容，并呈现第 2 步收集的上下文中的任何相关约束。
2. **Questions**: Ask what is needed to draft this section. Use `AskUserQuestion`
   for constrained choices, conversational text for open-ended exploration. / **问题**：询问起草此节需要什么。对于受限选择使用 `AskUserQuestion`，对于开放式探索使用对话文本。
3. **Options**: Where design choices exist, present 2-4 approaches with pros/cons.
   Explain reasoning in conversation, then use `AskUserQuestion` to capture the decision. / **选项**：存在设计选择的地方，提供2-4种方法及其优缺点。在对话中解释推理，然后使用 `AskUserQuestion` 捕捉决策。
4. **Decision**: User picks an approach or provides custom direction. / **决策**：用户选择一种方法或提供自定义方向。
5. **Draft**: Write the section content in conversation for review. Flag provisional
   assumptions explicitly. / **草稿**：在对话中编写节内容以供审查。明确标记临时假设。
6. **Approval**: "Does this capture it? Any changes before I write it to the file?" / **批准**："这抓住了要点吗？在我写入文件之前有任何更改吗？"
7. **Write**: Use `Edit` to replace the `[To be designed]` placeholder with approved
   content. Confirm the write. / **写入**：使用 `Edit` 将 `[To be designed]` 占位符替换为批准的内容。确认写入。

After writing each section, update `production/session-state/active.md`. / 写入每个节后，更新 `production/session-state/active.md`。

---

<!-- 中文翻译 -->
### Section Guidance: UX Spec Mode

<!-- 中文翻译 -->
#### Section A: Purpose & Player Need

This section is the foundation. Every other decision flows from it.

**Questions to ask**:
- "What player goal does this screen serve? What is the player trying to DO here?"
- "What would go wrong if this screen didn't exist or was hard to use?"
- "Complete this sentence: 'The player arrives at this screen wanting to ___.' "

Cross-reference the player journey context gathered in Phase 2. The stated purpose
must align with the journey phase and emotional state.
> **中文翻译**：交叉引用第 2 步收集的玩家旅程上下文。声明的目的必须与旅程阶段和情感状态一致。

---

<!-- 中文翻译 -->
#### Section B: Player Context on Arrival

**Questions to ask**:
- "When in the game does a player first encounter this screen?"
- "What were they just doing immediately before reaching this screen?"
- "What emotional state should the design assume? (calm, stressed, curious, time-pressured)"
- "Do players arrive at this screen voluntarily, or are they sent here by the game?"

Offer to map this against the journey phases if the player journey doc exists.

---

<!-- 中文翻译 -->
#### Section B2: Navigation Position

Where does this screen sit in the game's navigation hierarchy? This is a one-paragraph orientation map — not a full flow diagram.

**Questions to ask**:
- "Is this screen accessed from the main menu, from pause, from within gameplay, or from another screen?"
- "Is it a top-level destination (always reachable) or a context-dependent one (only accessible in certain states)?"
- "Can the player reach this screen from more than one place in the game?"

Present as: "This screen lives at: [root] → [parent] → [this screen]" plus any alternate entry paths.

---

<!-- 中文翻译 -->
#### Section B3: Entry & Exit Points

Map every way the player can arrive at and leave this screen.

**Questions to ask**:
- "What are all the ways a player can reach this screen?" (List each trigger: button press, game event, redirect from another screen, etc.)
- "What can the player do to exit? What happens when they do?" (Back button, confirm action, timeout, game event)
- "Are there any exits that are one-way — where the player cannot return to this screen without starting over?"

Present as two tables:

| Entry Source | Trigger | Player carries this context |
|---|---|---|
| [screen/event] | [how] | [state/data they arrive with] |

| Exit Destination | Trigger | Notes |
|---|---|---|
| [screen/event] | [how] | [any irreversible state changes] |

---

<!-- 中文翻译 -->
#### Section C: Layout Specification

This is the largest and most interactive section. Work through it in sub-sections:

**Sub-section 1 — Information Hierarchy** (establish this before any layout):
- Ask the user to list every piece of information this screen must communicate.
- Then ask them to rank the items: "What is the single most important thing a player
  needs to see first? What is second? What can be discovered rather than immediately visible?"
- Present the resulting hierarchy for approval before moving to zones.

**Sub-section 2 — Layout Zones**:
- Based on the information hierarchy, propose rough screen zones (header, content
  area, action bar, sidebar, etc.).
- Offer 2-3 zone arrangements with rationale for each. Reference platform and
  input context gathered from game concept.
- Ask: "Do any of these match your mental image, or shall we build a custom arrangement?"

**Sub-section 3 — Component Inventory**:
- For each zone, list the UI components it contains. For each component, note:
  - Component type (button, list, card, stat display, input field, etc.)
  - Content it displays
  - Whether it is interactive
  - If it uses an existing pattern from the library (reference by pattern name)
  - If it introduces a new pattern (flag for later addition to the library)

**Sub-section 4 — ASCII Wireframe**:
- Offer to generate an ASCII wireframe based on the zone layout and component list.
- Use `AskUserQuestion`: "Want an ASCII wireframe as part of this spec?"
  - Options: "Yes, include one", "No, I'll attach a separate file"
- If yes, produce the wireframe in conversation first. Ask for feedback before
  writing it to file.

---

<!-- 中文翻译 -->
#### Section D: States & Variants

Guide the user to think beyond the happy path.

**Questions to ask** (work through these one at a time):
- "What does this screen look like the very first time a player sees it, when there
  is no data yet? (empty state)"
- "What happens when something goes wrong — an error, a failed action, a missing
  resource? (error state)"
- "Is there ever a loading wait on this screen? If so, what does it show? (loading state)"
- "Are there any player progression states that change what this screen shows? For
  example, locked content, premium content, or tutorial-mode overlays?"
- "Does this screen behave differently on any supported platform? (platform variant)"

Present the collected states as a table for approval:

| State / Variant | Trigger | What Changes |
|-----------------|---------|--------------|
| Default | Normal load | — |
| Empty | No data available | [content area description] |
| [etc.] | [trigger] | [changes] |

---

<!-- 中文翻译 -->
#### Section E: Interaction Map

For each interactive component identified in the Layout Specification, define:
- The action (tap, click, press, hold, scroll, drag)
- The platform input(s) that trigger it (mouse click, gamepad A, keyboard Enter)
- The immediate feedback (visual, audio, haptic)
- The outcome (navigation target, state change, data write)

Use the input methods loaded from `technical-preferences.md` in Phase 2h — do
not ask the user again. State them upfront: "Mapping interactions for:
[Input Methods from tech-prefs]. Covering [Gamepad Support] gamepad support."

Work through components one at a time rather than asking for all at once.
For navigation actions (going to another screen), verify the target matches
an existing UX spec or note it as a spec dependency.

---

<!-- 中文翻译 -->
#### Section E2: Events Fired

For every player action in the Interaction Map, document the corresponding event the game or analytics system should fire — or explicitly note "no event" if none applies.

**Questions to ask**:
- "For each action, should the game fire an analytics event, trigger a game-state change, or both?"
- "Are there any actions that should NOT fire an event — and is that a deliberate choice?"

Present as a table alongside the Interaction Map:

| Player Action | Event Fired | Payload / Data |
|---|---|---|
| [action] | [EventName] or none | [data passed with event] |

Flag any action that modifies persistent game state (save data, progress, economy) — these need explicit attention from the architecture team.

---

<!-- 中文翻译 -->
#### Section E3: Transitions & Animations

Specify how the screen enters and exits, and how it responds to state changes.

**Questions to ask**:
- "How does this screen appear? (fade in, slide from right, instant pop, scale from button)"
- "How does it dismiss? (fade out, slide back, cut)"
- "Are there any in-screen state transitions that need animation? (loading spinner, success state, error flash)"
- "Is there any animation that could cause motion sickness — and does the game have a reduced-motion option?"

Minimum required:
- Screen enter transition
- Screen exit transition
- At least one state-change animation if the screen has multiple states

---

<!-- 中文翻译 -->
#### Section F: Data Requirements

Cross-reference the GDD UI Requirements sections gathered in Phase 2.

For each piece of information the screen displays, ask:
- "Where does this data come from? Which system owns it?"
- "Does this screen need to write data back, or is it read-only?"
- "Is any of this data time-sensitive or real-time? (health bars, cooldown timers)"

Flag any case where the UI would need to own or manage game state as an architectural
concern. UX specs define what the UI needs; they do not dictate how the data is
delivered. That is an architecture decision.

Present the data requirements as a table:

| Data | Source System | Read / Write | Notes |
|------|--------------|--------------|-------|
| [item] | [system] | Read | — |
| [item] | [system] | Write | [concern if any] |

---

<!-- 中文翻译 -->
#### Section G: Accessibility

Cross-reference `design/accessibility-requirements.md` if it exists.

Walk through the ux-designer agent's standard checklist for this screen:
- Keyboard-only navigation path through all interactive elements
- Gamepad navigation order (if applicable)
- Text contrast and minimum readable font sizes
- Color-independent communication (no information conveyed by color alone)
- Screen reader considerations for any non-text elements
- Any motion or animation that needs a reduced-motion alternative

Use `AskUserQuestion` to surface any open questions on accessibility tier:
- "Has the accessibility tier been committed to for this project?"
  - Options: "Yes, read from requirements doc", "Not yet — let's flag it as a question", "Skip accessibility section for now"

---

<!-- 中文翻译 -->
#### Section H: Localization Considerations

Document constraints that affect how this screen behaves when text is translated.

**Questions to ask**:
- "Which text elements on this screen are the longest? What is the maximum character count that fits the layout?"
- "Are there any elements where text length is layout-critical — e.g., a button label that must stay on one line?"
- "Are there any elements that display numbers, dates, or currencies that need locale-specific formatting?"

Note: aim to flag any element where a 40% text expansion (common in translations from English to German or French) would break the layout. Mark those as HIGH PRIORITY for the localization engineer.

---

#### Section I: Acceptance Criteria / I 节：验收标准

Write at least 5 specific, testable criteria that a QA tester can verify without reading any other design document. These become the pass/fail conditions for `/story-done`.

**Format**: Use checkboxes. Each criterion must be verifiable by a human tester:

```
- [ ] Screen opens within [X]ms from [trigger]
- [ ] [Element] displays correctly at [minimum] and [maximum] values
- [ ] [Navigation action] correctly routes to [destination screen]
- [ ] Error state appears when [condition] and shows [specific message or icon]
- [ ] Keyboard/gamepad navigation reaches all interactive elements in logical order
- [ ] [Accessibility requirement] is met — e.g., "all interactive elements have focus indicators"
```

**Minimum required**:
- 1 performance criterion (load/open time)
- 1 navigation criterion (at least one entry or exit path verified)
- 1 error/empty state criterion
- 1 accessibility criterion (per committed tier)
- 1 criterion specific to this screen's core purpose

Ask the user to confirm: "Do these criteria cover what would actually make this screen 'done' for your QA process?"

---

<!-- 中文翻译 -->
### Section Guidance: HUD Design Mode

HUD design follows a different order from UX spec mode. Begin with philosophy;
do not touch layout until the information architecture is complete.

<!-- 中文翻译 -->
#### Section A: HUD Philosophy

Ask the user to describe the game's relationship with on-screen information in
1-2 sentences.

Offer framing examples to help:
- "Nearly HUD-free — atmosphere requires unobstructed immersion (e.g., Hollow Knight, Firewatch)"
- "Minimal but present — only critical information visible, everything else contextual (e.g., Dark Souls)"
- "Information-dense — all decision-relevant data always visible (e.g., Diablo IV, StarCraft II)"
- "Adaptive — HUD density responds to combat state, exploration mode, menus (e.g., God of War)"

This philosophy becomes the design constraint for every subsequent HUD decision.
If a proposed element conflicts with the stated philosophy, surface that conflict.

---

<!-- 中文翻译 -->
#### Section B: Information Architecture

Complete this before any layout work. Do not skip it.

**Step 1 — Full information inventory**:
Pull all information from GDD UI Requirements sections gathered in Phase 2.
Present the full list: "These are all the things your game systems say they need
to communicate to the player on screen."

**Step 2 — Categorization**:
For each item, ask the user to categorize it:

| Category | Description |
|----------|-------------|
| **Must Show** | Always visible, player needs it for core decisions |
| **Contextual** | Visible only when relevant (in combat, near interactable, etc.) |
| **On Demand** | Player must actively request it (toggle, hold button) |
| **Hidden** | Communicated through world/audio, never on-screen text |

Use `AskUserQuestion` to step through items in groups of 3-4, not all at once.
This is the most consequential design decision in the HUD — do not rush it.

**Conflict check**: If the information philosophy (Section A) says "nearly HUD-free"
but the Must Show list is growing long, surface the conflict explicitly:
> "The current Must Show list has [N] items. That may conflict with the HUD-free
> philosophy. Options: reduce the Must Show list, revise the philosophy, or define
> a hybrid approach where HUD is absent in exploration and present in combat."

---

<!-- 中文翻译 -->
#### Section C: Layout Zones

Only after the information architecture is approved, design layout zones.

Base layout on:
- Which items are Must Show (they drive the permanent zone decisions)
- Where player attention naturally goes during gameplay (center-screen for action games,
  corners for strategy games)
- Platform and aspect ratio targets

Offer 2-3 zone arrangements. Include rationale based on the HUD philosophy and the
categorization from Section B.

---

<!-- 中文翻译 -->
#### Section D: HUD Elements

For each element in the layout, specify:
- Element name and category (Must Show / Contextual / On Demand)
- Content displayed
- Visual form (bar, number, icon, counter, map)
- Update behavior (real-time, event-driven, player-queried)
- Contextual trigger (if not always visible)
- Animation behavior (does it pulse when low? Fade in? Slam in?)

Work element by element. Reference the interaction pattern library if relevant patterns
exist for status displays, resource bars, or cooldown indicators.

---

#### Sections E, F, G: Dynamic Behaviors, Platform Variants, Accessibility / E、F、G 节：动态行为、平台变体、无障碍

These follow the same structure as the UX spec equivalents. See UX Spec section
guidance for D (States/Variants), E (Interactions), and G (Accessibility).

For the HUD specifically, emphasize:
- Dynamic Behaviors: what causes the HUD to change density mid-gameplay?
- Platform Variants: does mobile/console require different element sizes or positions?

---

<!-- 中文翻译 -->
### Section Guidance: Interaction Pattern Library Mode

Pattern library authoring is additive and catalog-driven, not linear.

<!-- 中文翻译 -->
#### Phase 1: Catalog Existing Patterns

Glob `design/ux/*.md` (excluding `interaction-patterns.md`) and read the Component
Inventory and Interaction Map sections of each spec. Extract every interaction
pattern used.

Present the extracted list: "Based on existing UX specs, these patterns are already
in use in the game:"
- [Pattern name]: used in [screen], [screen]
- [etc.]

Ask: "Are there patterns you know exist but aren't in existing specs yet? List any
additional ones now."

---

<!-- 中文翻译 -->
#### Phase 2: Formalize Each Pattern

For each pattern (existing or new), document:

```markdown
### [Pattern Name]

**Category**: Navigation / Input / Feedback / Data Display / Modal / Overlay / [other]
**Used In**: [list of screens]

**Description**: [One paragraph explaining what this pattern is and when to use it]

**Specification**:
- [Component behavior]
- [Input mapping]
- [Visual/audio feedback]
- [Accessibility requirements for this pattern]

**When to Use**: [Conditions where this pattern is appropriate]
**When NOT to Use**: [Conditions where another pattern is more appropriate]

**Reference**: [Screenshot path or ASCII example, if available]
```

Work through patterns in groups. Offer: "Shall I draft the first batch based on what
I've found in the existing specs, or do you want to define them one by one?"

---

<!-- 中文翻译 -->
#### Phase 3: Identify Gaps

After cataloging known patterns, ask:
- "Are there screens or interactions planned that would need patterns not yet
  in this library?"
- "Are there any patterns in existing specs that feel inconsistent with each
  other and should be consolidated?"

Document gaps in the Gaps section for follow-up.

---

<!-- 中文翻译 -->
## 5. Cross-Reference Check

Before marking the spec as ready for review, run these checks:

**1. GDD requirement coverage**: Does every GDD UI Requirement that references
this screen have a corresponding element in this spec? Present any gaps.

**2. Pattern library alignment**: Are all interaction patterns used in this spec
referenced by name? If a new pattern was invented during this spec session, flag
it for addition to the pattern library:
> "This spec uses [pattern name], which isn't in the pattern library yet.
> Want to add it now, or flag it as a gap?"

**3. Navigation consistency**: Do the entry/exit points in this spec match the
navigation map in any related specs? Flag mismatches.

**4. Accessibility coverage**: Does the spec address the accessibility tier
committed to in `design/accessibility-requirements.md`? If not, flag open questions.

**5. Empty states**: Does every data-dependent element have an empty state defined?
Flag any that don't.

Present the check results:
> **Cross-Reference Check: [Screen Name]**
> - GDD requirements: [N of M covered / all covered]
> - New patterns to add to library: [list or "none"]
> - Navigation mismatches: [list or "none"]
> - Accessibility gaps: [list or "none"]
> - Missing empty states: [list or "none"]

---

<!-- 中文翻译 -->
## 6. Handoff

When all sections are approved and written:

<!-- 中文翻译 -->
### 6a: Update Session State

Update `production/session-state/active.md` with:
- Task: [screen-name] UX spec
- Status: Complete (or In Review)
- File: design/ux/[filename].md
- Sections: All written
- Next: [suggestion]

<!-- 中文翻译 -->
### 6b: Suggest Next Step

Before presenting options, state clearly:

> "This spec should be validated with `/ux-review` before it enters the
> implementation pipeline. The Pre-Production gate requires all key screen specs
> to have a review verdict."

Then use `AskUserQuestion`:
- "Run `/ux-review [filename]` now, or do something else first?"
  - Options:
    - "Run `/ux-review` now — validate this spec"
    - "Design another screen first, then review all specs together"
    - "Update the interaction pattern library with new patterns from this spec"
    - "Stop here for this session"

If the user picks "Design another screen first", add a note: "Reminder: run
`/ux-review` on all completed specs before running `/gate-check pre-production`."

<!-- 中文翻译 -->
### 6c: Cross-Link Related Specs

If other UX specs link to or from this screen, note which ones should reference
this spec. Do not edit those files without asking — just name them.

---

## 7. Recovery & Resume / 第 7 步：恢复与继续

If the session is interrupted (compaction, crash, new session):
> **中文翻译**：如果会话被中断（压缩、崩溃、新会话）：

1. Read `production/session-state/active.md` — it records the current screen
   and which sections are complete. / 读取 `production/session-state/active.md` — 它记录当前屏幕和哪些节已完成。
2. Read `design/ux/[filename].md` — sections with real content are done;
   sections with `[To be designed]` still need work. / 读取 `design/ux/[filename].md` — 有真实内容的节已完成；有 `[To be designed]` 的节仍需工作。
3. Resume from the next incomplete section — no need to re-discuss completed ones. / 从下一个不完整的节继续 — 无需重新讨论已完成的节。

This is why incremental writing matters: every approved section survives any
disruption. / 这就是增量写入重要的原因：每个批准的节都能在任何中断中幸存。

---

<!-- 中文翻译 -->
## 8. Specialist Agent Routing

This skill uses `ux-designer` as the primary agent (set in frontmatter). For
specific sub-topics, additional context or coordination may be needed:

| Topic | Coordinate with |
|-------|----------------|
| Visual aesthetics, color, layout feel | `art-director` — UX spec defines zones; art defines how they look |
| Implementation feasibility (engine constraints) | `ui-programmer` — before finalizing component inventory |
| Gameplay data requirements | `game-designer` — when data ownership is unclear |
| Narrative/lore visible in the UI | `narrative-director` — for flavor text, item names, lore panels |
| Accessibility tier decisions | Handled by this session — owned by ux-designer |

When delegating to another agent via the Task tool:
- Provide: screen name, game concept summary, the specific question needing expert input
- The agent returns analysis to this session
- This session presents the agent's output to the user
- The user decides; this session writes to file
- Agents do NOT write to files directly — this session owns all file writes

---

## Collaborative Protocol / 协作协议

This skill follows the collaborative design principle at every step: / 此技能在每个步骤都遵循协作设计原则：

1. **Question -> Options -> Decision -> Draft -> Approval** for every section / **问题 -> 选项 -> 决策 -> 草稿 -> 批准** 对于每个节
2. **AskUserQuestion** at every decision point (Explain -> Capture pattern): / **AskUserQuestion** 在每个决策点（解释 -> 捕捉模式）：
   - Phase 2: "Ready to start, or need more context?" / 第 2 步："准备开始，还是需要更多上下文？"
   - Phase 3: "May I create the skeleton?" / 第 3 步："我可以创建骨架吗？"
   - Phase 4 (each section): design questions, approach options, draft approval / 第 4 步（每个节）：设计问题、方法选项、草稿批准
   - Phase 5: "Run cross-reference check? What's next?" / 第 5 步："运行交叉引用检查吗？接下来是什么？"
3. **"May I write to [filepath]?"** before the skeleton and before each section write / **"我可以写入 [filepath] 吗？"** 在骨架和每个节写入之前
4. **Incremental writing**: Each section is written to file immediately after approval / **增量写入**：每个节在批准后立即写入文件
5. **Session state updates**: After every section write / **会话状态更新**：每个节写入后

**Aesthetic deference**: When layout or visual choices come down to personal taste,
present the options and ask. Do not select a layout because it is "standard" — always
confirm. The user is the creative director. / **美学尊重**：当布局或视觉选择归结为个人品味时，呈现选项并询问。不要因为"标准"而选择布局 — 总是确认。用户是创意总监。

**Conflict surfacing**: When a GDD requirement and the available screen real estate
conflict, surface the conflict and present resolution options. Never silently drop
a requirement. Never silently expand the layout without flagging it. / **冲突浮现**：当 GDD 要求与可用屏幕空间冲突时，浮现冲突并提供解决选项。永不静默丢弃要求。永不静默扩展布局而不标记。

**Never** auto-generate the full spec and present it as a fait accompli. / **永不**自动生成完整规范并呈现为既成事实。
**Never** write a section without user approval. / **永不**未经用户批准写入节。
**Never** contradict an existing approved UX spec without flagging the conflict. / **永不**矛盾现有批准的 UX 规范而不标记冲突。
**Always** show where decisions come from (GDD requirements, player journey, user choices). / **总是**展示决策来源（GDD 要求、玩家旅程、用户选择）。

Verdict: **COMPLETE** — UX spec written and approved section by section. / 裁决：**COMPLETE** — UX 规范逐节编写和批准。

---

## Recommended Next Steps / 推荐的后续步骤

- Run `/ux-review [filename]` to validate this spec before it enters the implementation pipeline
- Run `/ux-design [next-screen]` to continue designing remaining screens or flows
- Run `/gate-check pre-production` once all key screens have approved UX specs
