---
name: design-system
description: "Guided, section-by-section GDD authoring for a single game system. Gathers context from existing docs, walks through each required section collaboratively, cross-references dependencies, and writes incrementally to file. / 引导式逐节 GDD 编写，针对单个游戏系统。从现有文档收集上下文，协作地遍历每个必需章节，交叉引用依赖关系，并增量写入文件。"
argument-hint: "<system-name> [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Task, AskUserQuestion, TodoWrite
---

When this skill is invoked:
> **中文翻译**：当该技能被调用时：


## 1. Parse Arguments & Validate
> **中文翻译**：## 1. 解析参数并验证


Resolve the review mode (once, store for all gate spawns this run):
> **中文翻译**：解决审查模式（一次，存储本次运行的所有门生成）：

1. If `--review [full|lean|solo]` was passed → use that
  > **中文翻译**：如果通过了 `--review [full|lean|solo]` → 使用它
2. Else read `production/review-mode.txt` → use that value
  > **中文翻译**：否则阅读 `product/review-mode.txt` → 使用该值
3. Else → default to `lean`
  > **中文翻译**：否则→默认为“精益”


See `.codebuddy/docs/director-gates.md` for the full check pattern.
> **中文翻译**：有关完整的检查模式，请参阅“.codebuddy/docs/director-gates.md”。


A system name or retrofit path is **required**. If missing:
> **中文翻译**：系统名称或改造路径是**必需的**。如果丢失：


1. Check if `design/gdd/systems-index.md` exists.
  > **中文翻译**：检查“design/gdd/systems-index.md”是否存在。
2. If it exists: read it, find the highest-priority system with status "Not Started" or equivalent, and use `AskUserQuestion`:
  > **中文翻译**：如果存在：读取它，找到状态为“未启动”或同等状态的最高优先级系统，然后使用“AskUserQuestion”：
   - Prompt: "The next system in your design order is **[system-name]** ([priority] | [layer]). Start designing it?"
  > **中文翻译**：提示：“您的设计顺序中的下一个系统是**[系统名称]**（[优先级] | [层]）。开始设计它吗？”
   - Options: `[A] Yes — design [system-name]` / `[B] Pick a different system` / `[C] Stop here`
  > **中文翻译**：选项：“[A] 是 - 设计 [系统名称]”/“[B] 选择不同的系统”/“[C] 在此停止”
   - If [A]: proceed with that system name. If [B]: ask which system to design (plain text). If [C]: exit.
  > **中文翻译**：如果 [A]：继续使用该系统名称。如果[B]：询问设计哪个系统（纯文本）。如果[C]：退出。
3. If no systems index exists, fail with:
  > **中文翻译**：如果不存在系统索引，则失败并显示：

   > "Usage: `/design-system <system-name>` — e.g., `/design-system movement`    > Or to fill gaps in an existing GDD: `/design-system retrofit design/gdd/[system-name].md`    > No systems index found. Run `/map-systems` first to map your systems and get the design order."
> **中文翻译**：> “用法：`/design-system <system-name>` — 例如，`/design-system moving` > 或者填补现有 GDD 中的空白：`/design-system Retrofit design/gdd/[system-name].md` > 未找到系统索引。首先运行 `/map-systems` 来映射您的系统并获取设计顺序。”


**Detect retrofit mode:** If the argument starts with `retrofit` or the argument is a file path to an existing `.md` file in `design/gdd/`, enter **retrofit mode**:
> **中文翻译**：**检测改造模式：** 如果参数以“retrofit”开头或者参数是“design/gdd/”中现有“.md”文件的文件路径，则进入“改造模式”：


1. Read the existing GDD file.
  > **中文翻译**：读取现有的 GDD 文件。
2. Identify which of the 8 required sections are present (scan for section headings).
  > **中文翻译**：确定存在 8 个必需部分中的哪些（扫描部分标题）。

   Required sections: Overview, Player Fantasy, Detailed Design/Rules, Formulas,    Edge Cases, Dependencies, Tuning Knobs, Acceptance Criteria.
> **中文翻译**：所需部分：概述、玩家幻想、详细设计/规则、公式、边缘情况、依赖性、调节旋钮、验收标准。

3. Identify which sections contain only placeholder text (`[To be designed]` or
  > **中文翻译**：确定哪些部分仅包含占位符文本（“[待设计]”或

   equivalent — blank, a single line, or obviously incomplete).
> **中文翻译**：等效项 — 空白、单行或明显不完整）。

4. Present to the user before doing anything:
  > **中文翻译**：在执行任何操作之前向用户展示：

   ```
   ## Retrofit: [System Name]
   File: design/gdd/[filename].md

   Sections already written (will not be touched):
   ✓ [section name]
   ✓ [section name]

   Missing or incomplete sections (will be authored):
   ✗ [section name] — missing
   ✗ [section name] — placeholder only
   ```
5. Ask: "Shall I fill the [N] missing sections? I will not modify any existing content."
  > **中文翻译**：问：“我要填补[N]个缺失的部分吗？我不会修改任何现有内容。”
6. If yes: proceed to **Phase 2 (Gather Context)** as normal, but in **Phase 3**
  > **中文翻译**：如果是：照常进行**阶段 2（收集上下文）**，但进入 **阶段 3**

   skip creating the skeleton (file already exists) and in **Phase 4** skip    sections that are already complete. Only run the section cycle for missing/    incomplete sections.
> **中文翻译**：跳过创建骨架（文件已存在）并在 **第 4 阶段** 跳过已完成的部分。仅针对缺失/不完整的部分运行部分循环。

7. **Never overwrite existing section content.** Use Edit tool to replace only
  > **中文翻译**：**切勿覆盖现有部分内容。**仅使用编辑工具替换

   `[To be designed]` placeholders or empty section bodies.
> **中文翻译**：“[待设计]”占位符或空节主体。


If NOT in retrofit mode, normalize the system name to kebab-case for the filename (e.g., "combat system" becomes `combat-system`).
> **中文翻译**：如果不在改造模式下，请将系统名称标准化为文件名的短横线大小写（例如，“战斗系统”变为“战斗系统”）。


---

## 2. Gather Context (Read Phase)

Read all relevant context **before** asking the user anything. This is the skill's
primary advantage over ad-hoc design — it arrives informed.

### 2a: Required Reads

- **Game concept**: Read `design/gdd/game-concept.md` — fail if missing:
  > "No game concept found. Run `/brainstorm` first."
- **Systems index**: Read `design/gdd/systems-index.md` — fail if missing:
  > "No systems index found. Run `/map-systems` first to map your systems."
- **Target system**: Find the system in the index. If not listed, warn:
  > "[system-name] is not in the systems index. Would you like to add it, or
  > design it as an off-index system?"
- **Entity registry**: Read `design/registry/entities.yaml` if it exists.
  Extract all entries referenced by or relevant to this system (grep
  `referenced_by.*[system-name]` and `source.*[system-name]`). Hold these
  in context as **known facts** — values that other GDDs have already
  established and this GDD must not contradict.
- **Reflexion log**: Read `docs/consistency-failures.md` if it exists.
  Extract entries whose Domain matches this system's category. These are
  recurring conflict patterns — present them under "Past failure patterns"
  in the Phase 2d context summary so the user knows where mistakes have
  occurred before in this domain.

### 2b: Dependency Reads

From the systems index, identify:
- **Upstream dependencies**: Systems this one depends on. Read their GDDs if they
  exist (these contain decisions this system must respect).
- **Downstream dependents**: Systems that depend on this one. Read their GDDs if
  they exist (these contain expectations this system must satisfy).

For each dependency GDD that exists, extract and hold in context:
- Key interfaces (what data flows between the systems)
- Formulas that reference this system's outputs
- Edge cases that assume this system's behavior
- Tuning knobs that feed into this system

### 2c: Optional Reads

- **Game pillars**: Read `design/gdd/game-pillars.md` if it exists
- **Existing GDD**: Read `design/gdd/[system-name].md` if it exists (resume, don't
  restart from scratch)
- **Related GDDs**: Glob `design/gdd/*.md` and read any that are thematically related
  (e.g., if designing a system that overlaps with another in scope, read the related GDD
  even if it's not a formal dependency)

### 2d: Present Context Summary

Before starting design work, present a brief summary to the user:

> **Designing: [System Name]**
> - Priority: [from index] | Layer: [from index]
> - Depends on: [list, noting which have GDDs vs. undesigned]
> - Depended on by: [list, noting which have GDDs vs. undesigned]
> - Existing decisions to respect: [key constraints from dependency GDDs]
> - Pillar alignment: [which pillar(s) this system primarily serves]
> - **Known cross-system facts (from registry):**
>   - [entity_name]: [attribute]=[value], [attribute]=[value] (owned by [source GDD])
>   - [item_name]: [attribute]=[value], [attribute]=[value] (owned by [source GDD])
>   - [formula_name]: variables=[list], output=[min–max] (owned by [source GDD])
>   - [constant_name]: [value] [unit] (owned by [source GDD])
>   *(These values are locked — if this GDD needs different values, surface
>   the conflict before writing. Do not silently use different numbers.)*
>
> If no registry entries are relevant: omit the "Known cross-system facts" section.

If any upstream dependencies are undesigned, warn:
> "[dependency] doesn't have a GDD yet. We'll need to make assumptions about
> its interface. Consider designing it first, or we can define the expected
> contract and flag it as provisional."

### 2e: Technical Feasibility Pre-Check

Before asking the user to begin designing, load engine context and surface any
constraints or knowledge gaps that will shape the design.

**Step 1 — Determine the engine domain for this system:**
Map the system's category (from systems-index.md) to an engine domain:

| System Category | Engine Domain |
|----------------|--------------|
| Combat, physics, collision | Physics |
| Rendering, visual effects, shaders | Rendering |
| UI, HUD, menus | UI |
| Audio, sound, music | Audio |
| AI, pathfinding, behavior trees | Navigation / Scripting |
| Animation, IK, rigs | Animation |
| Networking, multiplayer, sync | Networking |
| Input, controls, keybinding | Input |
| Save/load, persistence, data | Core |
| Dialogue, quests, narrative | Scripting |

**Step 2 — Read engine context (if available):**
- Read `.codebuddy/docs/technical-preferences.md` to identify the engine and version
- If engine is configured, read `docs/engine-reference/[engine]/VERSION.md`
- Read `docs/engine-reference/[engine]/modules/[domain].md` if it exists
- Read `docs/engine-reference/[engine]/breaking-changes.md` for domain-relevant entries
- Glob `docs/architecture/adr-*.md` and read any ADRs whose domain matches
  (check the Engine Compatibility table's "Domain" field)

**Step 3 — Present the Feasibility Brief:**

If engine reference docs exist, present before starting design:

```
## Technical Feasibility Brief: [System Name]
Engine: [name + version]
Domain: [domain]

### Known Engine Capabilities (verified for [version])
- [capability relevant to this system]
- [capability 2]

### Engine Constraints That Will Shape This Design
- [constraint from engine-reference or existing ADR]

### Knowledge Gaps (verify before committing to these)
- [post-cutoff feature this design might rely on — mark HIGH/MEDIUM risk]

### Existing ADRs That Constrain This System
- ADR-XXXX: [decision summary] — means [implication for this GDD]
  (or "None yet")
```

If no engine reference docs exist (engine not yet configured), show a short note:
> "No engine configured yet — skipping technical feasibility check. Run
> `/setup-engine` before moving to architecture if you haven't already."

**Step 4 — Ask before proceeding:**

Use `AskUserQuestion`:
- "Any constraints to add before we begin, or shall we proceed with these noted?"
  - Options: "Proceed with these noted", "Add a constraint first", "I need to check the engine docs — pause here"

---

Use `AskUserQuestion`:
> **中文翻译**：使用“询问用户问题”：

- "Ready to start designing [system-name]?"
  > **中文翻译**：“准备好开始设计[系统名称]吗？”
  - Options: "Yes, let's go", "Show me more context first", "Design a dependency first"
  > **中文翻译**：选项：“是的，我们开始吧”、“首先向我展示更多上下文”、“首先设计依赖项”


---

## 3. Create File Skeleton

Once the user confirms, **immediately** create the GDD file with empty section
headers. This ensures incremental writes have a target.

Use the template structure from `.codebuddy/docs/templates/game-design-document.md`:

```markdown
# [System Name]

> **Status**: In Design
> **Author**: [user + agents]
> **Last Updated**: [today's date]
> **Implements Pillar**: [from context]

## Overview

[To be designed]

## Player Fantasy

[To be designed]

## Detailed Design

### Core Rules

[To be designed]

### States and Transitions

[To be designed]

### Interactions with Other Systems

[To be designed]

## Formulas

[To be designed]

## Edge Cases

[To be designed]

## Dependencies

[To be designed]

## Tuning Knobs

[To be designed]

## Visual/Audio Requirements

[To be designed]

## UI Requirements

[To be designed]

## Acceptance Criteria

[To be designed]

## Open Questions

[To be designed]
```

Ask: "May I create the skeleton file at `design/gdd/[system-name].md`?"

After writing, update `production/session-state/active.md`:
- Use Glob to check if the file exists.
- If it **does not exist**: use the **Write** tool to create it. Never attempt Edit on a file that may not exist.
- If it **already exists**: use the **Edit** tool to update the relevant fields.

File content:
- Task: Designing [system-name] GDD
- Current section: Starting (skeleton created)
- File: design/gdd/[system-name].md

---

## 4. Section-by-Section Design
> **中文翻译**：## 4. 分段设计


Walk through each section in order. For **each section**, follow this cycle:
> **中文翻译**：按顺序浏览每个部分。对于**每个部分**，请遵循以下循环：


### The Section Cycle
> **中文翻译**：### 节循环


```
Context  ->  Questions  ->  Options  ->  Decision  ->  Draft  ->  Approval  ->  Write
```

1. **Context**: State what this section needs to contain, and surface any relevant
  > **中文翻译**：**上下文**：说明本节需要包含的内容，并显示任何相关内容

   decisions from dependency GDDs that constrain it.
> **中文翻译**：来自约束它的依赖 GDD 的决策。


2. **Questions**: Ask clarifying questions specific to this section. Use
  > **中文翻译**：**问题**：提出针对本节的澄清问题。使用

   `AskUserQuestion` for constrained questions, conversational text for open-ended    exploration.
> **中文翻译**：“AskUserQuestion”用于受限问题，对话文本用于开放式探索。


3. **Options**: Where the section involves design choices (not just documentation),
  > **中文翻译**：**选项**：该部分涉及设计选择（不仅仅是文档），

   present 2-4 approaches with pros/cons. Explain reasoning in conversation text,    then use `AskUserQuestion` to capture the decision.
> **中文翻译**：提出 2-4 种方法，各有利弊。在对话文本中解释推理，然后使用“AskUserQuestion”来捕获决策。


4. **Decision**: User picks an approach or provides custom direction.
  > **中文翻译**：**决策**：用户选择一种方法或提供自定义方向。


5. **Draft**: Write the section content in conversation text for review. Flag any
  > **中文翻译**：**草稿**：将对话文本中的部分内容写下来以供审阅。标记任何

   provisional assumptions about undesigned dependencies.
> **中文翻译**：关于未设计的依赖关系的临时假设。


6. **Approval**: Immediately after the draft — in the SAME response — use
  > **中文翻译**：**批准**：草稿后立即 - 在同一响应中 - 使用

   `AskUserQuestion`. **NEVER use plain text. NEVER skip this step.**
> **中文翻译**：“询问用户问题”。 **切勿使用纯文本。切勿跳过此步骤。**

   - Prompt: "Approve the [Section Name] section?"
  > **中文翻译**：提示：“批准[部分名称]部分？”
   - Options: `[A] Approve — write it to file` / `[B] Make changes — describe what to fix` / `[C] Start over`
  > **中文翻译**：选项：“[A] 批准 - 将其写入文件”/“[B] 进行更改 - 描述要修复的内容”/“[C] 重新开始”


   **The draft and the approval widget MUST appear together in one response.    If the draft appears without the widget, the user is left at a blank prompt    with no path forward — this is a protocol violation.**
> **中文翻译**：**草稿和批准小部件必须一起出现在一个响应中。    如果草稿在没有小部件的情况下出现，用户将看到空白提示，没有前进的路径 - 这是违反协议的行为。 **


7. **Write**: Use the Edit tool to replace the placeholder with the approved content.
  > **中文翻译**：**写入**：使用编辑工具将占位符替换为批准的内容。

   **CRITICAL**: Always include the section heading in the `old_string` to ensure    uniqueness — never match `[To be designed]` alone, as multiple sections use the    same placeholder and the Edit tool requires a unique match. Use this pattern:
> **中文翻译**：**关键**：始终在“old_string”中包含节标题以确保唯一性 - 切勿单独匹配“[待设计]”，因为多个节使用相同的占位符，并且编辑工具需要唯一匹配。使用这个模式：

   ```
   old_string: "## [Section Name]\n\n[To be designed]"
   new_string: "## [Section Name]\n\n[approved content]"
   ```
   Confirm the write.
> **中文翻译**：确认写入。


8. **Registry conflict check** (Sections C and D only — Detailed Design and Formulas):
  > **中文翻译**：**注册表冲突检查**（仅限 C 和 D 部分 - 详细设计和公式）：

   After writing, scan the section content for entity names, item names, formula    names, and numeric constants that appear in the registry. For each match:
> **中文翻译**：写入后，扫描该节内容以查找注册表中出现的实体名称、项目名称、公式名称和数字常量。对于每场比赛：

   - Compare the value just written against the registry entry.
  > **中文翻译**：将刚刚写入的值与注册表项进行比较。
   - If they differ: **surface the conflict immediately** before starting the next
  > **中文翻译**：如果它们不同：**在开始下一个冲突之前立即提出冲突**

     section. Do not continue silently.      > "Registry conflict: [name] is registered in [source GDD] as [registry_value].      > This section just wrote [new_value]. Which is correct?"
> **中文翻译**：部分。不要继续沉默。      > “注册表冲突：[名称] 在 [源 GDD] 中注册为 [registry_value]。 > 本节刚刚写了 [new_value]。哪个是正确的？”

   - If new (not in registry): flag it as a candidate for registry registration
  > **中文翻译**：如果是新的（不在注册表中）：将其标记为注册表注册的候选者

     (will be handled in Phase 5).
> **中文翻译**：（将在第五阶段处理）。


After writing each section, update `production/session-state/active.md` with the completed section name. Use Glob to check if the file exists — use Write to create it if absent, Edit to update it if present.
> **中文翻译**：编写每个部分后，使用完整的部分名称更新“Production/session-state/active.md”。使用 Glob 检查文件是否存在 - 如果不存在则使用 Write 创建它，如果存在则使用 E​​dit 更新它。


### Section-Specific Guidance
> **中文翻译**：### 特定部分的指导


Each section has unique design considerations and may benefit from specialist agents:
> **中文翻译**：每个部分都有独特的设计考虑，并可能受益于专业代理：


---

### Section A: Overview

**Goal**: One paragraph a stranger could read and understand.

**Derive recommended options before building the widget**: Read the system's category and layer from the systems index (already in context from Phase 2), then determine the recommended option for each tab:
- **Framing tab**: Foundation/Infrastructure layer → `[A]` recommended. Player-facing categories (Combat, UI, Dialogue, Character, Animation, Visual Effects, Audio) → `[C] Both` recommended.
- **ADR ref tab**: Glob `docs/architecture/adr-*.md` and grep for the system name in the GDD Requirements section of any ADR. If a matching ADR is found → `[A] Yes — cite the ADR` recommended. If none found → `[B] No` recommended.
- **Fantasy tab**: Foundation/Infrastructure layer → `[B] No` recommended. All other categories → `[A] Yes` recommended.

Append `(Recommended)` to the appropriate option text in each tab.

**Framing questions (ask BEFORE drafting)**: Use `AskUserQuestion` with a multi-tab widget:
- Tab "Framing" — "How should the overview frame this system?" Options: `[A] As a data/infrastructure layer (technical framing)` / `[B] Through its player-facing effect (design framing)` / `[C] Both — describe the data layer and its player impact`
- Tab "ADR ref" — "Should the overview reference the existing ADR for this system?" Options: `[A] Yes — cite the ADR for implementation details` / `[B] No — keep the GDD at pure design level`
- Tab "Fantasy" — "Does this system have a player fantasy worth stating?" Options: `[A] Yes — players feel it directly` / `[B] No — pure infrastructure, players feel what it enables`

Use the user's answers to shape the draft. Do NOT answer these questions yourself and auto-draft.

**Questions to ask**:
- What is this system in one sentence?
- How does a player interact with it? (active/passive/automatic)
- Why does this system exist — what would the game lose without it?

**Cross-reference**: Check that the description aligns with how the systems index
describes it. Flag discrepancies.

**Design vs. implementation boundary**: Overview questions must stay at the behavior
level — what the system *does*, not *how it is built*. If implementation questions
arise during the Overview (e.g., "Should this use an Autoload singleton or a signal
bus?"), note them as "→ becomes an ADR" and move on. Implementation patterns belong
in `/architecture-decision`, not the GDD. The GDD describes behavior; the ADR
describes the technical approach used to achieve it.

---

### Section B: Player Fantasy
> **中文翻译**：### B 部分：玩家幻想


**Goal**: The emotional target — what the player should *feel*.
> **中文翻译**：**目标**：情感目标——玩家应该“感受”什么。


**Derive recommended option before building the widget**: Read the system's category and layer from Phase 2 context:
> **中文翻译**：**在构建小部件之前导出推荐选项**：从阶段 2 上下文中读取系统的类别和层：

- Player-facing categories (Combat, UI, Dialogue, Character, Animation, Audio, Level/World) → `[A] Direct` recommended
  > **中文翻译**：面向玩家的类别（战斗、UI、对话、角色、动画、音频、关卡/世界）→ 推荐“[A] Direct”
- Foundation/Infrastructure layer → `[B] Indirect` recommended
  > **中文翻译**：基础/基础设施层 → 建议使用“[B]间接”
- Mixed categories (Camera/input, Economy, AI with visible player effects) → `[C] Both` recommended
  > **中文翻译**：混合类别（相机/输入、经济、具有可见玩家效果的 AI）→ 推荐“[C] 两者”


Append `(Recommended)` to the appropriate option text.
> **中文翻译**：将“（推荐）”附加到适当的选项文本。


**Framing question (ask BEFORE drafting)**: Use `AskUserQuestion`:
> **中文翻译**：**框架问题（起草前询问）**：使用 `AskUserQuestion`：

- Prompt: "Is this system something the player engages with directly, or infrastructure they experience indirectly?"
  > **中文翻译**：提示：“这个系统是玩家直接接触的系统，还是他们间接体验的基础设施？”
- Options: `[A] Direct — player actively uses or feels this system` / `[B] Indirect — player experiences the effects, not the system` / `[C] Both — has a direct interaction layer and infrastructure beneath it`
  > **中文翻译**：选项：“[A]直接——玩家主动使用或感受到这个系统”/“[B]间接——玩家体验效果，而不是系统”/“[C]两者——有一个直接的交互层和其下的基础设施”


Use the answer to frame the Player Fantasy section appropriately. Do NOT assume the answer.
> **中文翻译**：使用答案来适当地构建玩家幻想部分。不要假设答案。


**Questions to ask**:
> **中文翻译**：**要问的问题**：

- What emotion or power fantasy does this serve?
  > **中文翻译**：这服务于什么情感或权力幻想？
- What reference games nail this feeling? What specifically creates it?
  > **中文翻译**：有哪些参考游戏可以体现这种感觉？具体是什么创造了它？
- Is this a "system you love engaging with" or "infrastructure you don't notice"?
  > **中文翻译**：这是一个“你喜欢参与的系统”还是“你没有注意到的基础设施”？


**Cross-reference**: Must align with the game pillars. If the system serves a pillar, quote the relevant pillar text.
> **中文翻译**：**交叉参考**：必须与游戏支柱保持一致。如果系统服务于支柱，请引用相关支柱文本。


**Agent delegation (MANDATORY)**: After the framing answer is given but before drafting, spawn `creative-director` via Task:
> **中文翻译**：**代理委托（强制）**：在给出框架答案之后但在起草之前，通过任务生成“creative-director”：

- Provide: system name, framing answer (direct/indirect/both), game pillars, any reference games the user mentioned, the game concept summary
  > **中文翻译**：提供：系统名称、框架答案（直接/间接/两者）、游戏支柱、用户提到的任何参考游戏、游戏概念摘要
- Ask: "Shape the Player Fantasy for this system. What emotion or power fantasy should it serve? What player moment should we anchor to? What tone and language fits the game's established feeling? Be specific — give me 2-3 candidate framings."
  > **中文翻译**：问：“为这个系统塑造玩家幻想。它应该服务于什么样的情感或权力幻想？我们应该锚定玩家的哪个时刻？什么基调和语言适合游戏既定的感觉？具体一点——给我 2-3 个候选框架。”
- Collect the creative-director's framings and present them to the user alongside the draft.
  > **中文翻译**：收集创意总监的框架并将其与草稿一起呈现给用户。


**Do NOT draft Section B without first consulting `creative-director`.** The framing answer tells us *what kind* of fantasy it is; the creative-director shapes *how it's described* — tone, language, the specific player moment to anchor to.
> **中文翻译**：**在没有先咨询“创意总监”的情况下，请勿起草 B 部分。** 框架答案告诉我们它是什么类型的幻想；创意总监塑造*如何描述*——语气、语言、要锚定的特定玩家时刻。


---

### Section C: Detailed Design (Core Rules, States, Interactions)

**Goal**: Unambiguous specification a programmer could implement without questions.

This is usually the largest section. Break it into sub-sections:

1. **Core Rules**: The fundamental mechanics. Use numbered rules for sequential
   processes, bullets for properties.
2. **States and Transitions**: If the system has states, map every state and
   every valid transition. Use a table.
3. **Interactions with Other Systems**: For each dependency (upstream and downstream),
   specify what data flows in, what flows out, and who owns the interface.

**Questions to ask**:
- Walk me through a typical use of this system, step by step
- What are the decision points the player faces?
- What can the player NOT do? (Constraints are as important as capabilities)

**Agent delegation (MANDATORY)**: Before drafting Section C, spawn specialist agents via Task in parallel:
- Look up the system category in the routing table (Section 6 of this skill)
- Spawn the Primary Agent AND Supporting Agent(s) listed for this category
- Provide each agent: system name, game concept summary, pillar set, dependency GDD excerpts, the specific section being worked on
- Collect their findings before drafting
- Surface any disagreements between agents to the user via `AskUserQuestion`
- Draft only after receiving specialist input

**Do NOT draft Section C without first consulting the appropriate specialists.** A `systems-designer` reviewing rules and mechanics will catch design gaps the main session cannot.

**Cross-reference**: For each interaction listed, verify it matches what the
dependency GDD specifies. If a dependency defines a value or formula and this
system expects something different, flag the conflict.

---

### Section D: Formulas
> **中文翻译**：### D 部分：公式


**Goal**: Every mathematical formula, with variables defined, ranges specified, and edge cases noted.
> **中文翻译**：**目标**：每个数学公式，定义变量，指定范围，并记录边缘情况。


**Completion Steering — always begin each formula with this exact structure:**
> **中文翻译**：**完成指导 - 始终以以下精确结构开始每个公式：**


```
The [formula_name] formula is defined as:

`[formula_name] = [expression]`

**Variables:**
| Variable | Symbol | Type | Range | Description |
|----------|--------|------|-------|-------------|
| [name] | [sym] | float/int | [min–max] | [what it represents] |

**Output Range:** [min] to [max] under normal play; [behaviour at extremes]
**Example:** [worked example with real numbers]
```

Do NOT write `[Formula TBD]` or describe a formula in prose without the variable table. A formula without defined variables cannot be implemented without guesswork.
> **中文翻译**：不要在没有变量表的情况下写“[公式待定]”或用散文描述公式。没有定义变量的公式无法在没有猜测的情况下实现。


**Questions to ask**:
> **中文翻译**：**要问的问题**：

- What are the core calculations this system performs?
  > **中文翻译**：该系统执行哪些核心计算？
- Should scaling be linear, logarithmic, or stepped?
  > **中文翻译**：缩放应该是线性的、对数的还是阶梯式的？
- What should the output ranges be at early/mid/late game?
  > **中文翻译**：游戏前期/中期/后期的输出范围应该是多少？


**Agent delegation (MANDATORY)**: Before proposing any formulas or balance values, spawn specialist agents via Task in parallel:
> **中文翻译**：**代理委托（强制）**：在提出任何公式或平衡值之前，通过任务并行生成专家代理：

- **Always spawn `systems-designer`**: provide Core Rules from Section C, tuning goals from user, balance context from dependency GDDs. Ask them to propose formulas with variable tables and output ranges.
  > **中文翻译**：**始终产生“系统设计者”**：提供 C 部分的核心规则，调整用户的目标，平衡依赖 GDD 的上下文。要求他们提出带有变量表和输出范围的公式。
- **For economy/cost systems, also spawn `economy-designer`**: provide placement costs, upgrade cost intent, and progression goals. Ask them to validate cost curves and ratios.
  > **中文翻译**：**对于经济/成本系统，还产生“经济设计师”**：提供安置成本、升级成本意图和进展目标。要求他们验证成本曲线和比率。
- Present the specialists' proposals to the user for review via `AskUserQuestion`
  > **中文翻译**：通过“AskUserQuestion”向用户提出专家的建议以供审核
- The user decides; the main session writes to file
  > **中文翻译**：用户决定；主会话写入文件
- **Do NOT invent formula values or balance numbers without specialist input.** A user without balance design expertise cannot evaluate raw numbers — they need the specialists' reasoning.
  > **中文翻译**：**未经专家输入，请勿发明公式值或天平数字。** 没有天平设计专业知识的用户无法评估原始数字 - 他们需要专家的推理。


**Cross-reference**: If a dependency GDD defines a formula whose output feeds into this system, reference it explicitly. Don't reinvent — connect.
> **中文翻译**：**交叉引用**：如果依赖项 GDD 定义了一个公式，其输出馈入该系统，请显式引用它。不要重新发明——连接。


---

### Section E: Edge Cases

**Goal**: Explicitly handle unusual situations so they don't become bugs.

**Completion Steering — format each edge case as:**
- **If [condition]**: [exact outcome]. [rationale if non-obvious]

Example (adapt terminology to the game's domain):
- **If [resource] reaches 0 while [protective condition] is active**: hold at minimum until condition ends, then apply consequence.
- **If two [triggers/events] fire simultaneously**: resolve in [defined priority order]; ties use [defined tiebreak rule].

Do NOT write vague entries like "handle appropriately" — each must name the exact
condition and the exact resolution. An edge case without a resolution is an open
design question, not a specification.

**Questions to ask**:
- What happens at zero? At maximum? At out-of-range values?
- What happens when two rules apply at the same time?
- What happens if a player finds an unintended interaction? (Identify degenerate strategies)

**Agent delegation (MANDATORY)**: Spawn `systems-designer` via Task before finalising edge cases. Provide: the completed Sections C and D, and ask them to identify edge cases from the formula and rule space that the main session may have missed. For narrative systems, also spawn `narrative-director`. Present their findings and ask the user which to include.

**Cross-reference**: Check edge cases against dependency GDDs. If a dependency
defines a floor, cap, or resolution rule that this system could violate, flag it.

---

### Section F: Dependencies
> **中文翻译**：### F 部分：依赖关系


**Goal**: Map every system connection with direction and nature.
> **中文翻译**：**目标**：绘制每个系统连接的方向和性质。


This section is partially pre-filled from the context gathering phase. Present the known dependencies from the systems index and ask:
> **中文翻译**：本节部分是在上下文收集阶段预先填充的。显示系统索引中的已知依赖关系并询问：

- Are there dependencies I'm missing?
  > **中文翻译**：我缺少依赖项吗？
- For each dependency, what's the specific data interface?
  > **中文翻译**：对于每个依赖项，具体的数据接口是什么？
- Which dependencies are hard (system cannot function without it) vs. soft
  > **中文翻译**：哪些依赖项是硬依赖项（没有它系统就无法运行）与软依赖项

  (enhanced by it but works without it)?
> **中文翻译**：（由它增强但没有它也能工作）？


**Cross-reference**: This section must be bidirectionally consistent. If this system lists "depends on Combat", then the Combat GDD should list "depended on by [this system]". Flag any one-directional dependencies for correction.
> **中文翻译**：**交叉引用**：此部分必须双向一致。如果该系统列出“取决于 Combat”，则 Combat GDD 应列出“取决于 [此系统]”。标记任何单向依赖性以进行更正。


---

### Section G: Tuning Knobs

**Goal**: Every designer-adjustable value, with safe ranges and extreme behaviors.

**Questions to ask**:
- What values should designers be able to tweak without code changes?
- For each knob, what breaks if it's set too high? Too low?
- Which knobs interact with each other? (Changing A makes B irrelevant)

**Agent delegation**: If formulas are complex, delegate to `systems-designer`
to derive tuning knobs from the formula variables.

**Cross-reference**: If a dependency GDD lists tuning knobs that affect this system,
reference them here. Don't create duplicate knobs — point to the source of truth.

---

### Section H: Acceptance Criteria
> **中文翻译**：### H 部分：验收标准


**Goal**: Testable conditions that prove the system works as designed.
> **中文翻译**：**目标**：证明系统按设计工作的可测试条件。


**Completion Steering — format each criterion as Given-When-Then:**
> **中文翻译**：**完成指导 - 将每个标准格式化为“Given-When-Then”：**

- **GIVEN** [initial state], **WHEN** [action or trigger], **THEN** [measurable outcome]
  > **中文翻译**：**给定** [初始状态]，**何时** [操作或触发]，**那么** [可衡量的结果]


Example (adapt terminology to the game's domain):
> **中文翻译**：示例（根据游戏领域调整术语）：

- **GIVEN** [initial state], **WHEN** [player action or system trigger], **THEN** [specific measurable outcome].
  > **中文翻译**：**给定** [初始状态]，**何时** [玩家操作或系统触发]，**那么** [具体可测量结果]。
- **GIVEN** [a constraint is active], **WHEN** [player attempts an action], **THEN** [feedback shown and action result].
  > **中文翻译**：**GIVEN** [约束处于活动状态]，**WHEN** [玩家尝试执行操作]，**THEN** [显示反馈和操作结果]。


Include at least: one criterion per core rule from Section C, and one per formula from Section D. Do NOT write "the system works as designed" — every criterion must be independently verifiable by a QA tester without reading the GDD.
> **中文翻译**：至少包括：C 部分中的每个核心规则一个标准，D 部分中的每个公式一个标准。不要写“系统按设计运行”——每个标准都必须由 QA 测试人员独立验证，而无需阅读 GDD。


**Agent delegation (MANDATORY)**: Spawn `qa-lead` via Task before finalising acceptance criteria. Provide: the completed GDD sections C, D, E, and ask them to validate that the criteria are independently testable and cover all core rules and formulas. Surface any gaps or untestable criteria to the user.
> **中文翻译**：**代理委托（强制）**：在最终确定验收标准之前通过任务生成“qa-lead”。提供：已完成的 GDD C、D、E 部分，并要求他们验证标准是否可独立测试并涵盖所有核心规则和公式。向用户展示任何差距或无法测试的标准。


**Questions to ask**:
> **中文翻译**：**要问的问题**：

- What's the minimum set of tests that prove this works?
  > **中文翻译**：证明此方法有效的最少测试集是什么？
- What performance budget does this system get? (frame time, memory)
  > **中文翻译**：该系统可以获得多少性能预算？ （帧时间、内存）
- What would a QA tester check first?
  > **中文翻译**：QA 测试人员首先会检查什么？


**Cross-reference**: Include criteria that verify cross-system interactions work, not just this system in isolation.
> **中文翻译**：**交叉引用**：包括验证跨系统交互工作的标准，而不仅仅是这个孤立的系统。


---

### Optional Sections: Visual/Audio, UI Requirements, Open Questions

These sections are included in the template. Visual/Audio is **REQUIRED** for visual system categories — not optional. Determine the requirement level before asking:

**Visual/Audio is REQUIRED (mandatory — do not offer to skip) for these system categories:**
- Combat, damage, health
- UI systems (HUD, menus)
- Animation, character movement
- Visual effects, particles, shaders
- Character systems
- Dialogue, quests, lore
- Level/world systems

For required systems: **spawn `art-director` via Task** before drafting this section. Provide: system name, game concept, game pillars, art bible sections 1–4 if they exist. Ask them to specify: (1) VFX and visual feedback requirements for this system's events, (2) any animation or visual style constraints, (3) which art bible principles most directly apply to this system. Present their output; do NOT leave this section as `[To be designed]` for visual systems.

For **all other system categories** (Foundation/Infrastructure, Economy, AI/pathfinding, Camera/input), offer the optional sections after the required sections:

Use `AskUserQuestion`:
- "The 8 required sections are complete. Do you want to also define Visual/Audio
  requirements, UI requirements, or capture open questions?"
  - Options: "Yes, all three", "Just open questions", "Skip — I'll add these later"

For **Visual/Audio** (non-required systems): Coordinate with `art-director` and `audio-director` if detail is needed. Often a brief note suffices at the GDD stage.

> **Asset Spec Flag**: After the Visual/Audio section is written with real content, output this notice:
> "📌 **Asset Spec** — Visual/Audio requirements are defined. After the art bible is approved, run `/asset-spec system:[system-name]` to produce per-asset visual descriptions, dimensions, and generation prompts from this section."

For **UI Requirements**: Coordinate with `ux-designer` for complex UI systems.
After writing this section, check whether it contains real content (not just
`[To be designed]` or a note that this system has no UI). If it does have real
UI requirements, output this flag immediately:

> **📌 UX Flag — [System Name]**: This system has UI requirements. In Phase 4
> (Pre-Production), run `/ux-design` to create a UX spec for each screen or
> HUD element this system contributes to **before** writing epics. Stories that
> reference UI should cite `design/ux/[screen].md`, not the GDD directly.
>
> Note this in the systems index for this system if you update it.

For **Open Questions**: Capture anything that came up during design that wasn't
fully resolved. Each question should have an owner and target resolution date.

---

## 5. Post-Design Validation
> **中文翻译**：## 5. 设计后验证


After all sections are written:
> **中文翻译**：写完所有部分后：


### 5a: Self-Check
> **中文翻译**：### 5a：自检


Read back the complete GDD from file (not from conversation memory — the file is the source of truth). Verify:
> **中文翻译**：从文件中读回完整的 GDD（不是从对话内存中——文件是事实的来源）。核实：

- All 8 required sections have real content (not placeholders)
  > **中文翻译**：所有 8 个必填部分都有真实内容（不是占位符）
- Formulas reference defined variables
  > **中文翻译**：公式引用定义的变量
- Edge cases have resolutions
  > **中文翻译**：边缘情况有解决方案
- Dependencies are listed with interfaces
  > **中文翻译**：依赖项与接口一起列出
- Acceptance criteria are testable
  > **中文翻译**：验收标准是可测试的


### 5a-bis: Creative Director Pillar Review
> **中文翻译**：### 5a-bis：创意总监支柱回顾


**Review mode check** — apply before spawning CD-GDD-ALIGN:
> **中文翻译**：**查看模式检查** — 在生成 CD-GDD-ALIGN 之前应用：

- `solo` → skip. Note: "CD-GDD-ALIGN skipped — Solo mode." Proceed to Step 5b.
  > **中文翻译**：`独奏` → 跳过。注意：“CD-GDD-ALIGN 已跳过 — 独奏模式。”继续步骤 5b。
- `lean` → skip (not a PHASE-GATE). Note: "CD-GDD-ALIGN skipped — Lean mode." Proceed to Step 5b.
  > **中文翻译**：`lean` → 跳过（不是相位门）。注意：“跳过 CD-GDD-ALIGN — 精益模式。”继续步骤 5b。
- `full` → spawn as normal.
  > **中文翻译**：`full` → 正常生成。


Before finalizing the GDD, spawn `creative-director` via Task using gate **CD-GDD-ALIGN** (`.codebuddy/docs/director-gates.md`).
> **中文翻译**：在最终确定 GDD 之前，使用门 **CD-GDD-ALIGN** (`.codebuddy/docs/director-gates.md`) 通过任务生成 `creative-director`。


Pass: completed GDD file path, game pillars (from `design/gdd/game-concept.md` or `design/gdd/game-pillars.md`), MDA aesthetics target.
> **中文翻译**：Pass：完成的GDD文件路径、游戏支柱（来自`design/gdd/game-concept.md`或`design/gdd/game-pillars.md`）、MDA美学目标。


Handle verdict per the standard rules in `director-gates.md`. After resolution, record the verdict in the GDD Status header: `> **Creative Director Review (CD-GDD-ALIGN)**: APPROVED [date] / CONCERNS (accepted) [date] / REVISED [date]`
> **中文翻译**：根据“director-gates.md”中的标准规则处理判决。解决后，将结论记录在 GDD 状态标题中：`> **创意总监审核 (CD-GDD-ALIGN)**：已批准 [日期] / 疑虑（已接受）[日期] / 已修订 [日期]`


---

### 5b: Update Entity Registry

Scan the completed GDD for cross-system facts that should be registered:
- Named entities (enemies, NPCs, bosses) with stats or drops
- Named items with values, weights, or categories
- Named formulas with defined variables and output ranges
- Named constants referenced by value in more than one place

For each candidate, check if it already exists in `design/registry/entities.yaml`:
```
Grep pattern="  - name: [candidate_name]" path="design/registry/entities.yaml"
```

Present a summary:
```
Registry candidates from this GDD:
  NEW (not yet registered):
    - [entity_name] [entity]: [attribute]=[value], [attribute]=[value]
    - [item_name] [item]: [attribute]=[value], [attribute]=[value]
    - [formula_name] [formula]: variables=[list], output=[min–max]
  ALREADY REGISTERED (referenced_by will be updated):
    - [constant_name] [constant]: value=[N] ← matches registry ✅
```

Ask: "May I update `design/registry/entities.yaml` with these [N] new entries
and update `referenced_by` for the existing entries?"

If yes: append new entries and update `referenced_by` arrays. Never modify
existing `value` / attribute fields without surfacing it as a conflict first.

### 5c: Offer Design Review

Present a completion summary:

> **GDD Complete: [System Name]**
> - Sections written: [list]
> - Provisional assumptions: [list any assumptions about undesigned dependencies]
> - Cross-system conflicts found: [list or "none"]

> **To validate this GDD, open a fresh CodeBuddy session and run:**
> `/design-review design/gdd/[system-name].md`
>
> **Never run `/design-review` in the same session as `/design-system`.** The reviewing
> agent must be independent of the authoring context. Running it here would inherit
> the full design history, making independent critique impossible.

**NEVER offer to run `/design-review` inline.** Always direct the user to a fresh window.

### 5d: Update Systems Index

After the GDD is complete (and optionally reviewed):

- Read the systems index
- Update the target system's row:
  - If design-review was run and verdict is APPROVED: Status → "Approved"
  - If design-review was run and verdict is NEEDS REVISION: Status → "In Review"
  - If design-review was skipped: Status → "Designed" (pending review)
  - If the user chose "I'll review it myself first": Status → "Designed"
  - Design Doc: link to `design/gdd/[system-name].md`
- Update the Progress Tracker counts

Ask: "May I update the systems index at `design/gdd/systems-index.md`?"

### 5d: Update Session State

Update `production/session-state/active.md` with:
- Task: [system-name] GDD
- Status: Complete (or In Review if design-review was run)
- File: design/gdd/[system-name].md
- Sections: All 8 written
- Next: [suggest next system from design order]

### 5e: Suggest Next Steps

Use `AskUserQuestion`:
- "What's next?"
  - Options:
    - "Run `/consistency-check` — verify this GDD's values don't conflict with existing GDDs (recommended before designing the next system)"
    - "Design next system ([next-in-order])" — if undesigned systems remain
    - "Fix review findings" — if design-review flagged issues
    - "Stop here for this session"
    - "Run `/gate-check`" — if enough MVP systems are designed

---

## 6. Specialist Agent Routing
> **中文翻译**：## 6. 专业代理路由


This skill delegates to specialist agents for domain expertise. The main session orchestrates the overall flow; agents provide expert content.
> **中文翻译**：该技能委托给专业代理以获取领域专业知识。主会议协调整个流程；代理提供专家内容。


| System Category | Primary Agent | Supporting Agent(s) |
  <!-- 翻译: 系统类别 -->
  <!-- 翻译: 主要代理 -->
  <!-- 翻译: 支持代理 -->
|----------------|---------------|---------------------|
| **Foundation/Infrastructure** (event bus, save/load, scene mgmt, service locator) | `systems-designer` | `gameplay-programmer` (feasibility), `engine-programmer` (engine integration) |
  <!-- 翻译: **基础/基础设施**（事件总线、保存/加载、场景管理、服务定位器） -->
  <!-- 翻译: `系统设计师` -->
  <!-- 翻译: `gameplay-programmer`（可行性），`engine-programmer`（引擎集成） -->
| Combat, damage, health | `game-designer` | `systems-designer` (formulas), `ai-programmer` (enemy AI), `art-director` (hit feedback visual direction, VFX intent) |
  <!-- 翻译: 战斗、伤害、健康 -->
  <!-- 翻译: `游戏设计师` -->
  <!-- 翻译: “系统设计师”（公式）、“人工智能程序员”（敌人人工智能）、“艺术总监”（点击反馈视觉方向、VFX 意图） -->
| Economy, loot, crafting | `economy-designer` | `systems-designer` (curves), `game-designer` (loops) |
  <!-- 翻译: 经济、战利品、制作 -->
  <!-- 翻译: “经济设计师” -->
  <!-- 翻译: “系统设计器”（曲线）、“游戏设计器”（循环） -->
| Progression, XP, skills | `game-designer` | `systems-designer` (curves), `economy-designer` (sinks) |
  <!-- 翻译: 进度、XP、技能 -->
  <!-- 翻译: `游戏设计师` -->
  <!-- 翻译: “系统设计师”（曲线）、“经济设计师”（下沉） -->
| Dialogue, quests, lore | `game-designer` | `narrative-director` (story), `writer` (content), `art-director` (character visual profiles, cinematic tone) |
  <!-- 翻译: 对话、任务、传说 -->
  <!-- 翻译: `游戏设计师` -->
  <!-- 翻译: “叙事导演”（故事）、“作家”（内容）、“艺术总监”（人物视觉轮廓、电影基调） -->
| UI systems (HUD, menus) | `game-designer` | `ux-designer` (flows), `ui-programmer` (feasibility), `art-director` (visual style direction), `technical-artist` (render/shader constraints) |
  <!-- 翻译: UI系统（HUD、菜单） -->
  <!-- 翻译: `游戏设计师` -->
  <!-- 翻译: `ux-designer`（流程）、`ui-programmer`（可行性）、`art-director`（视觉风格方向）、`technical-artist`（渲染/着色器约束） -->
| Audio systems | `game-designer` | `audio-director` (direction), `sound-designer` (specs) |
  <!-- 翻译: 音频系统 -->
  <!-- 翻译: `游戏设计师` -->
  <!-- 翻译: “音频导演”（方向）、“声音设计师”（规格） -->
| AI, pathfinding, behavior | `game-designer` | `ai-programmer` (implementation), `systems-designer` (scoring) |
  <!-- 翻译: 人工智能、寻路、行为 -->
  <!-- 翻译: `游戏设计师` -->
  <!-- 翻译: “人工智能程序员”（实现）、“系统设计师”（评分） -->
| Level/world systems | `game-designer` | `level-designer` (spatial), `world-builder` (lore) |
  <!-- 翻译: 关卡/世界系统 -->
  <!-- 翻译: `游戏设计师` -->
  <!-- 翻译: “关卡设计师”（空间）、“世界建造者”（传说） -->
| Camera, input, controls | `game-designer` | `ux-designer` (feel), `gameplay-programmer` (feasibility) |
  <!-- 翻译: 摄像头、输入、控件 -->
  <!-- 翻译: `游戏设计师` -->
  <!-- 翻译: `ux-designer`（感觉），`gameplay-programmer`（可行性） -->
| Animation, character movement | `game-designer` | `art-director` (animation style, pose language), `technical-artist` (rig/blend constraints), `gameplay-programmer` (feel) |
  <!-- 翻译: 动画、角色动作 -->
  <!-- 翻译: `游戏设计师` -->
  <!-- 翻译: “艺术总监”（动画风格、姿势语言）、“技术艺术家”（装备/混合约束）、“游戏程序员”（感觉） -->
| Visual effects, particles, shaders | `game-designer` | `art-director` (VFX visual direction), `technical-artist` (performance budget, shader complexity), `systems-designer` (trigger/state integration) |
  <!-- 翻译: 视觉效果、粒子、着色器 -->
  <!-- 翻译: `游戏设计师` -->
  <!-- 翻译: “艺术总监”（VFX 视觉方向）、“技术艺术家”（性能预算、着色器复杂性）、“系统设计师”（触发/状态集成） -->
| Character systems (stats, archetypes) | `game-designer` | `art-director` (character visual archetype), `narrative-director` (character arc alignment), `systems-designer` (stat formulas) |
  <!-- 翻译: 角色系统（统计数据、原型） -->
  <!-- 翻译: `游戏设计师` -->
  <!-- 翻译: “艺术总监”（角色视觉原型）、“叙事总监”（角色弧线对齐）、“系统设计师”（统计公式） -->


**When delegating via Task tool**:
> **中文翻译**：**通过任务工具委派时**：

- Provide: system name, game concept summary, dependency GDD excerpts, the specific
  > **中文翻译**：提供：系统名称、游戏概念概要、依赖GDD摘录、具体

  section being worked on, and what question needs expert input
> **中文翻译**：正在研究的部分，以及哪些问题需要专家的意见

- The agent returns analysis/proposals to the main session
  > **中文翻译**：代理将分析/建议返回到主会话
- The main session presents the agent's output to the user via `AskUserQuestion`
  > **中文翻译**：主会话通过“AskUserQuestion”向用户呈现代理的输出
- The user decides; the main session writes to file
  > **中文翻译**：用户决定；主会话写入文件
- Agents do NOT write to files directly — the main session owns all file writes
  > **中文翻译**：代理不直接写入文件 - 主会话拥有所有文件写入


---

## 7. Recovery & Resume

If the session is interrupted (compaction, crash, new session):

1. Read `production/session-state/active.md` — it records the current system and
   which sections are complete
2. Read `design/gdd/[system-name].md` — sections with real content are done;
   sections with `[To be designed]` still need work
3. Resume from the next incomplete section — no need to re-discuss completed ones

This is why incremental writing matters: every approved section survives any
disruption.

---

## Collaborative Protocol
> **中文翻译**：## 协作协议


This skill follows the collaborative design principle at every step:
> **中文翻译**：该技能的每一步都遵循协作设计原则：


1. **Question -> Options -> Decision -> Draft -> Approval** for every section
  > **中文翻译**：**问题 -> 选项 -> 决定 -> 草案 -> 批准** 每个部分
2. **AskUserQuestion** at every decision point (Explain -> Capture pattern):
  > **中文翻译**：**在每个决策点询问用户问题**（解释 -> 捕获模式）：
   - Phase 2: "Ready to start, or need more context?"
  > **中文翻译**：第 2 阶段：“准备好开始，还是需要更多背景信息？”
   - Phase 3: "May I create the skeleton?"
  > **中文翻译**：第三阶段：“我可以创建骨架吗？”
   - Phase 4 (each section): Design questions, approach options, draft approval
  > **中文翻译**：第 4 阶段（每个部分）：设计问题、方法选项、草案批准
   - Phase 5: "Run design review? Update systems index? What's next?"
  > **中文翻译**：阶段 5：“运行设计评审？更新系统索引？下一步是什么？”
3. **"May I write to [filepath]?"** before the skeleton and before each section write
  > **中文翻译**：**“我可以写入[文件路径]吗？”** 在框架之前和每个部分写入之前
4. **Incremental writing**: Each section is written to file immediately after approval
  > **中文翻译**：**增量写入**：每个部分在批准后立即写入归档
5. **Session state updates**: After every section write
  > **中文翻译**：**会话状态更新**：在每个部分写入之后
6. **Cross-referencing**: Every section checks existing GDDs for conflicts
  > **中文翻译**：**交叉引用**：每个部分都会检查现有 GDD 是否存在冲突
7. **Specialist routing**: Complex sections get expert agent input, presented to
  > **中文翻译**：**专家路由**：复杂的部分获得专家代理的输入，呈现给

   the user for decision — never written silently
> **中文翻译**：用户做出决定——从不默写


**Never** auto-generate the full GDD and present it as a fait accompli. **Never** write a section without user approval. **Never** contradict an existing approved GDD without flagging the conflict. **Always** show where decisions come from (dependency GDDs, pillars, user choices).
> **中文翻译**：**永远不要**自动生成完整的 GDD 并将其呈现为既成事实。 **切勿**在未经用户批准的情况下编写部分。 **切勿**在未标记冲突的情况下与现有批准的 GDD 相矛盾。 **始终**显示决策的来源（依赖 GDD、支柱、用户选择）。


## Context Window Awareness
> **中文翻译**：## 上下文窗口感知


This is a long-running skill. After writing each section, check if the status line shows context at or above 70%. If so, append this notice to the response:
> **中文翻译**：这是一个长期运行的技能。编写每个部分后，检查状态行显示的上下文是否等于或高于 70%。如果是这样，请将此通知附加到响应中：


> **Context is approaching the limit (≥70%).** Your progress is saved — all approved > sections are written to `design/gdd/[system-name].md`. When you're ready to continue, > open a fresh Claude Code session and run `/design-system [system-name]` — it will > detect which sections are complete and resume from the next one.
> **中文翻译**：> **上下文接近极限（≥70%）。** 您的进度已保存 - 所有批准的 > 部分都写入 `design/gdd/[system-name].md`。当您准备好继续时，> 打开一个新的 Claude Code 会话并运行 `/design-system [system-name]` — 它将 > 检测哪些部分已完成并从下一个部分继续。


---

## Recommended Next Steps

- Run `/design-review design/gdd/[system-name].md` in a **fresh session** to validate the completed GDD independently
- Run `/consistency-check` to verify this GDD's values don't conflict with other GDDs
- Run `/map-systems next` to move to the next highest-priority undesigned system
- Run `/gate-check pre-production` when all MVP GDDs are authored and reviewed
