---
name: brainstorm
description: "Guided game concept ideation — from zero idea to a structured game concept document. Uses professional studio ideation techniques, player psychology frameworks, and structured creative exploration. / 引导式游戏概念构思 — 从零到结构化的游戏概念文档。使用专业工作室构思技术、玩家心理框架和结构化创意探索。"
argument-hint: "[genre or theme hint, or 'open'] [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, WebSearch, Task, AskUserQuestion
---

When this skill is invoked:
> **中文翻译**：当该技能被调用时：


1. **Parse the argument** for an optional genre/theme hint (e.g., `roguelike`,
  > **中文翻译**：**解析参数**以获得可选的流派/主题提示（例如，“roguelike”，

   `space survival`, `cozy farming`). If `open` or no argument, start from    scratch. Also resolve the review mode (once, store for all gate spawns this run):
> **中文翻译**：“太空生存”、“舒适农业”）。如果“open”或没有参数，则从头开始。还解决审查模式（一次，存储本次运行的所有门生成）：

   1. If `--review [full|lean|solo]` was passed → use that
  > **中文翻译**：如果通过了 `--review [full|lean|solo]` → 使用它
   2. Else read `production/review-mode.txt` → use that value
  > **中文翻译**：否则阅读 `product/review-mode.txt` → 使用该值
   3. Else → default to `lean`
  > **中文翻译**：否则→默认为“精益”


   See `.codebuddy/docs/director-gates.md` for the full check pattern.
> **中文翻译**：有关完整的检查模式，请参阅“.codebuddy/docs/director-gates.md”。


2. **Check for existing concept work**:
  > **中文翻译**：**检查现有的概念工作**：
   - Read `design/gdd/game-concept.md` if it exists (resume, don't restart)
  > **中文翻译**：读取“design/gdd/game-concept.md”（如果存在）（继续，不要重新启动）
   - Read `design/gdd/game-pillars.md` if it exists (build on established pillars)
  > **中文翻译**：阅读“design/gdd/game-pillars.md”（如果存在）（建立在既定的支柱上）


3. **Run through ideation phases** interactively, asking the user questions at
  > **中文翻译**：**以交互方式运行构思阶段**，在以下位置询问用户问题

   each phase. Do NOT generate everything silently — the goal is **collaborative    exploration** where the AI acts as a creative facilitator, not a replacement    for the human's vision.
> **中文翻译**：每个阶段。不要默默地生成一切——目标是**协作探索**，其中人工智能充当创造性的促进者，而不是人类视觉的替代品。


   **Use `AskUserQuestion`** at key decision points throughout brainstorming:
> **中文翻译**：**在整个头脑风暴过程中的关键决策点使用“AskUserQuestion”：

   - Constrained taste questions (genre preferences, scope, team size)
  > **中文翻译**：受限品味问题（类型偏好、范围、团队规模）
   - Concept selection ("Which 2-3 concepts resonate?") after presenting options
  > **中文翻译**：提出选项后概念选择（“哪 2-3 个概念引起共鸣？”）
   - Direction choices ("Develop further, explore more, or prototype?")
  > **中文翻译**：方向选择（“进一步开发、探索更多，还是原型？”）
   - Pillar ranking after concepts are refined
  > **中文翻译**：概念细化后的支柱排名

   Write full creative analysis in conversation text first, then use    `AskUserQuestion` to capture the decision with concise labels.
> **中文翻译**：首先在对话文本中编写完整的创意分析，然后使用“AskUserQuestion”以简洁的标签捕获决策。


   Professional studio brainstorming principles to follow:
> **中文翻译**：专业工作室头脑风暴应遵循的原则：

   - Withhold judgment — no idea is bad during exploration
  > **中文翻译**：保留判断——在探索过程中没有什么想法是坏的
   - Encourage unusual ideas — outside-the-box thinking sparks better concepts
  > **中文翻译**：鼓励不寻常的想法——打破常规的思维激发更好的概念
   - Build on each other — "yes, and..." responses, not "but..."
  > **中文翻译**：相互借鉴——回答“是的，并且……”，而不是“但是……”
   - Use constraints as creative fuel — limitations often produce the best ideas
  > **中文翻译**：使用限制作为创意燃料——限制往往会产生最好的想法
   - Time-box each phase — keep momentum, don't over-deliberate early
  > **中文翻译**：每个阶段都有时间限制——保持动力，不要过早过度考虑


---

<!-- 中文翻译 -->
### Phase 1: Creative Discovery

Start by understanding the person, not the game. Ask these questions
conversationally (not as a checklist):

**Emotional anchors**:
- What's a moment in a game that genuinely moved you, thrilled you, or made
  you lose track of time? What specifically created that feeling?
- Is there a fantasy or power trip you've always wanted in a game but never
  quite found?

**Taste profile**:
- What 3 games have you spent the most time with? What kept you coming back?
  *(Ask this as plain text — the user must be able to type specific game names freely.
  Do NOT put this in an AskUserQuestion with preset options.)*
- Are there genres you love? Genres you avoid? Why?
- Do you prefer games that challenge you, relax you, tell you stories,
  or let you express yourself? *(Use `AskUserQuestion` for this — constrained choice.)*

**Practical constraints** (shape the sandbox before brainstorming).
Bundle these into a single multi-tab `AskUserQuestion` with these exact tab labels:
- Tab "Experience" — "What kind of experience do you most want players to have?" (Challenge & Mastery / Story & Discovery / Expression & Creativity / Relaxation & Flow)
- Tab "Timeline" — "What's your realistic development timeline?" (Weeks / Months / 1-2 years / Multi-year)
- Tab "Dev level" — "Where are you in your dev journey?" (First game / Shipped before / Professional background)

Use exactly these tab names — do not rename or duplicate them.

**Synthesize** the answers into a **Creative Brief** — a 3-5 sentence
summary of the person's emotional goals, taste profile, and constraints.
Read the brief back and confirm it captures their intent.

---

<!-- 中文翻译 -->
### Phase 2: Concept Generation
> **中文翻译**：### 第 2 阶段：概念生成


Using the creative brief as a foundation, generate **3 distinct concepts** that each take a different creative direction. Use these ideation techniques:
> **中文翻译**：以创意简报为基础，生成 **3 个不同的概念**，每个概念都有不同的创意方向。使用这些构思技巧：


**Technique 1: Verb-First Design** Start with the core player verb (build, fight, explore, solve, survive, create, manage, discover) and build outward from there. The verb IS the game.
> **中文翻译**：**技术 1：动词优先设计** 从核心玩家动词（构建、战斗、探索、解决、生存、创建、管理、发现）开始，并从那里向外构建。动词就是游戏。


**Technique 2: Mashup Method** Combine two unexpected elements: [Genre A] + [Theme B]. The tension between the two creates the unique hook. (e.g., "farming sim + cosmic horror", "roguelike + dating sim", "city builder + real-time combat")
> **中文翻译**：**技巧二：混搭法** 结合两个意想不到的元素：【流派A】+【主题B】。两者之间的张力创造了独特的钩子。 （例如，“农业模拟 + 宇宙恐怖”、“Roguelike + 约会模拟”、“城市建设 + 实时战斗”）


**Technique 3: Experience-First Design (MDA Backward)** Start from the desired player emotion (aesthetic goal from MDA framework: sensation, fantasy, narrative, challenge, fellowship, discovery, expression, submission) and work backward to the dynamics and mechanics that produce it.
> **中文翻译**：**技术3：体验优先设计（MDA逆向）** 从期望的玩家情感（MDA框架的审美目标：感觉、幻想、叙事、挑战、友谊、发现、表达、提交）开始，逆向产生它的动力和机制。


For each concept, present:
> **中文翻译**：对于每个概念，呈现：

- **Working Title**
  > **中文翻译**：**工作名称**
- **Elevator Pitch** (1-2 sentences — must pass the "10-second test")
  > **中文翻译**：**电梯推介**（1-2 句话 — 必须通过“10 秒测试”）
- **Core Verb** (the single most common player action)
  > **中文翻译**：**核心动词**（最常见的玩家动作）
- **Core Fantasy** (the emotional promise)
  > **中文翻译**：**核心幻想**（情感承诺）
- **Unique Hook** (passes the "and also" test: "Like X, AND ALSO Y")
  > **中文翻译**：**独特的 Hook**（通过“并且还”测试：“Like X, AND ALSO Y”）
- **Primary MDA Aesthetic** (which emotion dominates?)
  > **中文翻译**：**主要 MDA 审美**（哪种情绪占主导地位？）
- **Estimated Scope** (small / medium / large)
  > **中文翻译**：**估计范围**（小/中/大）
- **Why It Could Work** (1 sentence on market/audience fit)
  > **中文翻译**：**为什么它可行**（关于市场/受众契合度的 1 句话）
- **Biggest Risk** (1 sentence on the hardest unanswered question)
  > **中文翻译**：**最大的风险**（关于最难回答的问题的 1 句话）


Present all three. Then use `AskUserQuestion` to capture the selection.
> **中文翻译**：呈现所有三个。然后使用“AskUserQuestion”来捕获选择。


**CRITICAL**: This MUST be a plain list call — no tabs, no form fields. Use exactly this structure:
> **中文翻译**：**关键**：这必须是一个简单的列表调用 - 没有选项卡，没有表单字段。完全使用这个结构：


```
AskUserQuestion(
  prompt: "Which concept resonates with you? You can pick one, combine elements, or ask for fresh directions.",
  options: [
    "Concept 1 — [Title]",
    "Concept 2 — [Title]",
    "Concept 3 — [Title]",
    "Combine elements across concepts",
    "Generate fresh directions"
  ]
)
```

Do NOT use a `tabs` field here. The `tabs` form is for multi-field input only — using it here causes an "Invalid tool parameters" error. This is a plain `prompt` + `options` call.
> **中文翻译**：不要在此处使用“制表符”字段。 `tabs` 表单仅用于多字段输入 - 此处使用它会导致“工具参数无效”错误。这是一个简单的“提示”+“选项”调用。


Never pressure toward a choice — let them sit with it.
> **中文翻译**：永远不要对选择施加压力——让他们接受它。


---

<!-- 中文翻译 -->
### Phase 3: Core Loop Design

For the chosen concept, use structured questioning to build the core loop.
The core loop is the beating heart of the game — if it isn't fun in
isolation, no amount of content or polish will save the game.

**30-Second Loop** (moment-to-moment):

Ask these as `AskUserQuestion` calls — derive the options from the chosen concept, don't hardcode them:

1. **Core action feel** — prompt: "What's the primary feel of the core action?" Generate 3-4 options that fit the concept's genre and tone, plus a free-text escape (`I'll describe it`).

2. **Key design dimension** — identify the most important design variable for this specific concept (e.g., world reactivity, pacing, player agency) and ask about it. Generate options that match the concept. Always include a free-text escape.

After capturing answers, analyze: Is this action intrinsically satisfying? What makes it feel good? (Audio feedback, visual juice, timing satisfaction, tactical depth?)

**5-Minute Loop** (short-term goals):
- What structures the moment-to-moment play into cycles?
- Where does "one more turn" / "one more run" psychology kick in?
- What choices does the player make at this level?

**Session Loop** (30-120 minutes):
- What does a complete session look like?
- Where are the natural stopping points?
- What's the "hook" that makes them think about the game when not playing?

**Progression Loop** (days/weeks):
- How does the player grow? (Power? Knowledge? Options? Story?)
- What's the long-term goal? When is the game "done"?

**Player Motivation Analysis** (based on Self-Determination Theory):
- **Autonomy**: How much meaningful choice does the player have?
- **Competence**: How does the player feel their skill growing?
- **Relatedness**: How does the player feel connected (to characters,
  other players, or the world)?

---

<!-- 中文翻译 -->
### Phase 4: Pillars and Boundaries
> **中文翻译**：### 第四阶段：支柱和边界


Game pillars are used by real AAA studios (God of War, Hades, The Last of Us) to keep hundreds of team members making decisions that all point the same direction. Even for solo developers, pillars prevent scope creep and keep the vision sharp.
> **中文翻译**：真正的 AAA 工作室（《战神》、《哈迪斯》、《最后生还者》）使用游戏支柱来让数百名团队成员做出指向同一方向的决策。即使对于独立开发人员来说，支柱也能防止范围蔓延并保持敏锐的视野。


Collaboratively define **3-5 pillars**:
> **中文翻译**：协作定义 **3-5 个支柱**：

- Each pillar has a **name** and **one-sentence definition**
  > **中文翻译**：每个支柱都有一个**名称**和**一句话定义**
- Each pillar has a **design test**: "If we're debating between X and Y,
  > **中文翻译**：每个支柱都有一个**设计测试**：“如果我们在 X 和 Y 之间进行辩论，

  this pillar says we choose __"
> **中文翻译**：这个支柱说我们选择__”

- Pillars should feel like they create tension with each other — if all
  > **中文翻译**：支柱应该感觉彼此之间产生了紧张感——如果有的话

  pillars point the same way, they're not doing enough work
> **中文翻译**：支柱指向同一个方向，他们没有做足够的工作


Then define **3+ anti-pillars** (what this game is NOT):
> **中文翻译**：然后定义 **3+ 反支柱**（这个游戏不是）：

- Anti-pillars prevent the most common form of scope creep: "wouldn't it
  > **中文翻译**：反支柱可以防止最常见形式的范围蔓延：“不是吗？

  be cool if..." features that don't serve the core vision
> **中文翻译**：如果……就很酷”的功能不服务于核心愿景

- Frame as: "We will NOT do [thing] because it would compromise [pillar]"
  > **中文翻译**：框架为：“我们不会做[事情]，因为它会损害[支柱]”


**Pillar confirmation**: After presenting the full pillar set, use `AskUserQuestion`:
> **中文翻译**：**支柱确认**：呈现完整的支柱集后，使用“AskUserQuestion”：

- Prompt: "Do these pillars feel right for your game?"
  > **中文翻译**：提示：“这些支柱适合你的游戏吗？”
- Options: `[A] Lock these in` / `[B] Rename or reframe one` / `[C] Swap a pillar out` / `[D] Something else`
  > **中文翻译**：选项：“[A] 锁定这些”/“[B] 重命名或重新构建一个”/“[C] 交换支柱”/“[D] 其他东西”


If the user selects B, C, or D, make the revision, then use `AskUserQuestion` again:
> **中文翻译**：如果用户选择 B、C 或 D，请进行修改，然后再次使用 `AskUserQuestion`：

- Prompt: "Pillars updated. Ready to lock these in?"
  > **中文翻译**：提示：“支柱已更新。准备好锁定它们了吗？”
- Options: `[A] Lock these in` / `[B] Revise another pillar` / `[C] Something else`
  > **中文翻译**：选项：“[A]锁定这些内容”/“[B]修改另一个支柱”/“[C]其他东西”


Repeat until the user selects [A] Lock these in.
> **中文翻译**：重复此操作，直到用户选择 [A] 锁定这些内容。


**Review mode check** — apply before spawning CD-PILLARS and AD-CONCEPT-VISUAL:
> **中文翻译**：**查看模式检查** — 在生成 CD-PILLARS 和 AD-CONCEPT-VISUAL 之前应用：

- `solo` → skip both. Note: "CD-PILLARS skipped — Solo mode. AD-CONCEPT-VISUAL skipped — Solo mode." Proceed to Phase 5.
  > **中文翻译**：`solo` → 跳过两者。注意：“CD-PILLARS 已跳过 — 独奏模式。AD-CONCEPT-VISUAL 已跳过 — 独奏模式。”进入第 5 阶段。
- `lean` → skip both (not PHASE-GATEs). Note: "CD-PILLARS skipped — Lean mode. AD-CONCEPT-VISUAL skipped — Lean mode." Proceed to Phase 5.
  > **中文翻译**：`lean` → 跳过两者（不是相位门）。注意：“跳过 CD-PILLARS — 精益模式。跳过 AD-CONCEPT-VISUAL — 精益模式。”进入第 5 阶段。
- `full` → spawn as normal.
  > **中文翻译**：`full` → 正常生成。


**After pillars and anti-pillars are agreed, spawn BOTH `creative-director` AND `art-director` via Task in parallel before moving to Phase 5. Issue both Task calls simultaneously — do not wait for one before starting the other.**
> **中文翻译**：**在支柱和反支柱达成一致后，在进入第 5 阶段之前通过任务并行生成“创意总监”和“艺术总监”。同时发出两个任务调用 - 不要等待一个任务再启动另一个任务。**


- **`creative-director`** — gate **CD-PILLARS** (`.codebuddy/docs/director-gates.md`)
  > **中文翻译**：**`创意总监`** — 门 **CD-PILLARS** (`.codebuddy/docs/director-gates.md`)

  Pass: full pillar set with design tests, anti-pillars, core fantasy, unique hook.
> **中文翻译**：通过：完整的柱子集，设计测试，反柱子，核心幻想，独特的钩子。


- **`art-director`** — gate **AD-CONCEPT-VISUAL** (`.codebuddy/docs/director-gates.md`)
  > **中文翻译**：**`art-director`** — 门 **AD-CONCEPT-VISUAL** (`.codebuddy/docs/director-gates.md`)

  Pass: game concept elevator pitch, full pillar set with design tests, target platform (if known), any reference games or visual touchstones the user mentioned.
> **中文翻译**：通过：游戏概念电梯推介、包含设计测试的完整支柱、目标平台（如果已知）、用户提到的任何参考游戏或视觉试金石。


Collect both verdicts, then present them together using a two-tab `AskUserQuestion`:
> **中文翻译**：收集两个结论，然后使用两个选项卡“AskUserQuestion”将它们一起呈现：

- Tab **"Pillars"**: present creative-director feedback. Options mirror the standard CD-PILLARS handling — `Lock in as-is` / `Revise [specific pillar]` / `Discuss further`.
  > **中文翻译**：选项卡**“支柱”**：呈现创意总监的反馈。选项反映了标准 CD-PILLARS 处理 - “按原样锁定”/“修订[特定支柱]”/“进一步讨论”。
- Tab **"Visual anchor"**: present the art-director's 2-3 named visual direction options. Options: each named direction (one per option) + `Combine elements across directions` + `Describe my own direction`.
  > **中文翻译**：选项卡**“视觉锚点”**：呈现艺术总监的 2-3 个指定视觉方向选项。选项：每个指定方向（每个选项一个）+“跨方向组合元素”+“描述我自己的方向”。


The user's selected visual anchor (the named direction or their custom description) is stored as the **Visual Identity Anchor** — it will be written into the game-concept document and becomes the foundation of the art bible.
> **中文翻译**：用户选择的视觉锚点（命名方向或自定义描述）被存储为**视觉识别锚点** - 它将被写入游戏概念文档并成为艺术圣经的基础。


If the creative-director returns CONCERNS or REJECT on pillars, resolve pillar issues before asking for the visual anchor selection — visual direction should flow from confirmed pillars.
> **中文翻译**：如果创意总监对支柱返回“担忧”或“拒绝”，请在要求选择视觉锚点之前解决支柱问题——视觉方向应来自已确认的支柱。


---

<!-- 中文翻译 -->
### Phase 5: Player Type Validation

Using the Bartle taxonomy and Quantic Foundry motivation model, validate
who this game is actually for:

- **Primary player type**: Who will LOVE this game? (Achievers, Explorers,
  Socializers, Competitors, Creators, Storytellers)
- **Secondary appeal**: Who else might enjoy it?
- **Who is this NOT for**: Being clear about who won't like this game is as
  important as knowing who will
- **Market validation**: Are there successful games that serve a similar
  player type? What can we learn from their audience size?

---

<!-- 中文翻译 -->
### Phase 6: Scope and Feasibility
> **中文翻译**：### 第 6 阶段：范围和可行性


Ground the concept in reality:
> **中文翻译**：将概念落实到现实中：


- **Target platform**: Use `AskUserQuestion` — "What platforms are you targeting for this game?"
  > **中文翻译**：**目标平台**：使用 `AskUserQuestion` — “您针对此游戏定位哪些平台？”

  Options: `PC (Steam / Epic)` / `Mobile (iOS / Android)` / `Console` / `Web / Browser` / `Multiple platforms`   Record the answer — it directly shapes the engine recommendation and will be passed to `/setup-engine`.   Note platform implications if relevant (e.g., mobile means Unity is strongly preferred; console means Godot has limitations; web means Godot exports cleanly).
> **中文翻译**：选项：`PC（Steam / Epic）`/`移动（iOS / Android）`/`控制台`/`Web /浏览器`/`多平台`记录答案 - 它直接决定引擎推荐并将传递到`/setup-engine`。   如果相关，请注意平台影响（例如，移动设备意味着 Unity 是首选；控制台意味着 Godot 有限制；Web 意味着 Godot 可以干净地导出）。


- **Engine experience**: Use `AskUserQuestion` — "Do you already have an engine you work in?"
  > **中文翻译**：**引擎体验**：使用“AskUserQuestion”——“您已经有一个正在使用的引擎了吗？”

  Options: `Godot` / `Unity` / `Unreal Engine 5` / `No preference — help me decide`
> **中文翻译**：选项：“Godot”/“Unity”/“虚幻引擎 5”/“无偏好 — 帮我决定”

  - If they pick an engine → record it as their preference and move on. Do NOT second-guess it.
  > **中文翻译**：如果他们选择了一个引擎→将其记录为他们的偏好并继续前进。不要事后猜测。
  - If "No preference" → tell them: "Run `/setup-engine` after this session — it will walk you through the full decision based on your concept and platform target." Do not make a recommendation here.
  > **中文翻译**：如果“没有偏好”→告诉他们：“在本次会议之后运行`/setup-engine`——它将引导您根据您的概念和平台目标做出完整的决定。”不要在这里提出建议。
- **Art pipeline**: What's the art style and how labor-intensive is it?
  > **中文翻译**：**艺术管道**：艺术风格是什么，劳动强度如何？
- **Content scope**: Estimate level/area count, item count, gameplay hours
  > **中文翻译**：**内容范围**：估计关卡/区域数量、物品数量、游戏时间
- **MVP definition**: What's the absolute minimum build that tests "is the
  > **中文翻译**：**MVP 定义**：测试的绝对最小构建是什么“是

  core loop fun?"
> **中文翻译**：核心循环有趣吗？”

- **Biggest risks**: Technical risks, design risks, market risks
  > **中文翻译**：**最大风险**：技术风险、设计风险、市场风险
- **Scope tiers**: What's the full vision vs. what ships if time runs out?
  > **中文翻译**：**范围等级**：完整的愿景与时间耗尽后的船舶是什么？


**Review mode check** — apply before spawning TD-FEASIBILITY:
> **中文翻译**：**审查模式检查** — 在生成之前应用 TD 可行性：

- `solo` → skip. Note: "TD-FEASIBILITY skipped — Solo mode." Proceed directly to scope tier definition.
  > **中文翻译**：`独奏` → 跳过。注意：“TD-FEASIBILITY 已跳过 — 单人模式。”直接进入范围层定义。
- `lean` → skip (not a PHASE-GATE). Note: "TD-FEASIBILITY skipped — Lean mode." Proceed directly to scope tier definition.
  > **中文翻译**：`lean` → 跳过（不是相位门）。注意：“TD-FEASIBILITY 已跳过 — 精益模式。”直接进入范围层定义。
- `full` → spawn as normal.
  > **中文翻译**：`full` → 正常生成。


**After identifying biggest technical risks, spawn `technical-director` via Task using gate TD-FEASIBILITY (`.codebuddy/docs/director-gates.md`) before scope tiers are defined.**
> **中文翻译**：**确定最大的技术风险后，在定义范围层之前，使用门 TD-FEASIBILITY (`.codebuddy/docs/director-gates.md`) 通过任务生成“technical-director”。**


Pass: core loop description, platform target, engine choice (or "undecided"), list of identified technical risks.
> **中文翻译**：通过：核心循环描述、平台目标、引擎选择（或“未定”）、已识别的技术风险列表。


Present the assessment to the user. If HIGH RISK, offer to revisit scope before finalising. If CONCERNS, note them and continue.
> **中文翻译**：向用户呈现评估。如果风险较高，请在最终确定之前重新审视范围。如果有疑虑，请记下并继续。


**Review mode check** — apply before spawning PR-SCOPE:
> **中文翻译**：**审查模式检查** — 在生成 PR-SCOPE 之前应用：

- `solo` → skip. Note: "PR-SCOPE skipped — Solo mode." Proceed to document generation.
  > **中文翻译**：`独奏` → 跳过。注意：“PR-SCOPE 已跳过 — 独奏模式。”继续生成文档。
- `lean` → skip (not a PHASE-GATE). Note: "PR-SCOPE skipped — Lean mode." Proceed to document generation.
  > **中文翻译**：`lean` → 跳过（不是相位门）。注意：“PR-SCOPE 已跳过 — 精益模式。”继续生成文档。
- `full` → spawn as normal.
  > **中文翻译**：`full` → 正常生成。


**After scope tiers are defined, spawn `producer` via Task using gate PR-SCOPE (`.codebuddy/docs/director-gates.md`).**
> **中文翻译**：**定义范围层后，使用门 PR-SCOPE (`.codebuddy/docs/director-gates.md`) 通过任务生成“生产者”。**


Pass: full vision scope, MVP definition, timeline estimate, team size.
> **中文翻译**：通过：完整的愿景范围、MVP 定义、时间表估计、团队规模。


Present the assessment to the user. If UNREALISTIC, offer to adjust the MVP definition or scope tiers before writing the document.
> **中文翻译**：向用户呈现评估。如果不现实，请在编写文档之前提出调整 MVP 定义或范围层。


---

4. **Generate the game concept document** using the template at
   `.codebuddy/docs/templates/game-concept.md`. Fill in ALL sections from the
   brainstorm conversation, including the MDA analysis, player motivation
   profile, and flow state design sections.

   **Include a Visual Identity Anchor section** in the game concept document with:
   - The selected visual direction name
   - The one-line visual rule
   - The 2-3 supporting visual principles with their design tests
   - The color philosophy summary

   This section is the seed of the art bible — it captures the "everything must
   move" decision before it can be forgotten between sessions.

5. Use `AskUserQuestion` for write approval:
- Prompt: "Game concept is ready. May I write it to `design/gdd/game-concept.md`?"
- Options: `[A] Yes — write it` / `[B] Not yet — revise a section first`

If [B]: ask which section to revise using `AskUserQuestion` with options: `Elevator Pitch` / `Core Fantasy & Unique Hook` / `Pillars` / `Core Loop` / `MVP Definition` / `Scope Tiers` / `Risks` / `Something else — I'll describe`

After revising, show the updated section as a diff or clear before/after, then use `AskUserQuestion` — "Ready to write the updated concept document?"
Options: `[A] Yes — write it` / `[B] Revise another section`
Repeat until the user selects [A].

If yes, generate the document using the template at `.codebuddy/docs/templates/game-concept.md`, fill in ALL sections from the brainstorm conversation, and write the file, creating directories as needed.

**Scope consistency rule**: The "Estimated Scope" field in the Core Identity table must match the full-vision timeline from the Scope Tiers section — not just say "Large (9+ months)". Write it as "Large (X–Y months, solo)" or "Large (X–Y months, team of N)" so the summary table is accurate.

6. **Suggest next steps** (in this order — this is the professional studio
   pre-production pipeline). List ALL steps — do not abbreviate or truncate:
   1. "Run `/setup-engine` to configure the engine and populate version-aware reference docs"
   2. "Run `/art-bible` to create the visual identity specification — do this BEFORE writing GDDs. The art bible gates asset production and shapes technical architecture decisions (rendering, VFX, UI systems)."
   3. "Use `/design-review design/gdd/game-concept.md` to validate concept completeness before going downstream"
   4. "Discuss vision with the `creative-director` agent for pillar refinement"
   5. "Decompose the concept into individual systems with `/map-systems` — maps dependencies, assigns priorities, and creates the systems index"
   5. "Author per-system GDDs with `/design-system` — guided, section-by-section GDD writing for each system identified in step 4"
   6. "Plan the technical architecture with `/create-architecture` — produces the master architecture blueprint and Required ADR list"
   7. "Record key architectural decisions with `/architecture-decision (×N)` — write one ADR per decision in the Required ADR list from `/create-architecture`"
   8. "Validate readiness to advance with `/gate-check` — phase gate before committing to production"
   9. "Prototype the riskiest system with `/prototype [core-mechanic]` — validate the core loop before full implementation"
   10. "Run `/playtest-report` after the prototype to validate the core hypothesis"
   11. "If validated, plan the first sprint with `/sprint-plan new`"

7. **Output a summary** with the chosen concept's elevator pitch, pillars,
   primary player type, engine recommendation, biggest risk, and file path.

Verdict: **COMPLETE** — game concept created and handed off for next steps.

---

<!-- 上下文窗口感知 -->
## Context Window Awareness
> **中文翻译**：## 上下文窗口感知


This is a multi-phase skill. If context reaches or exceeds 70% during any phase, append this notice to the current response before continuing:
> **中文翻译**：这是一个多阶段技能。如果上下文在任何阶段达到或超过 70%，请在继续之前将此通知附加到当前响应中：


> **Context is approaching the limit (≥70%).** The game concept document is saved > to `design/gdd/game-concept.md`. Open a fresh CodeBuddy session to continue > if needed — progress is not lost.
> **中文翻译**：> **上下文已接近极限（≥70%）。** 游戏概念文档已保存 > 至 `design/gdd/game-concept.md`。打开新的 CodeBuddy 会话以继续 > 如果需要 — 进度不会丢失。


---

<!-- 推荐后续步骤 -->
## Recommended Next Steps

After the game concept is written, follow the pre-production pipeline in order:
1. `/setup-engine` — configure the engine and populate version-aware reference docs
2. `/art-bible` — establish visual identity before writing any GDDs
3. `/map-systems` — decompose the concept into individual systems with dependencies
4. `/design-system [first-system]` — author per-system GDDs in dependency order
5. `/create-architecture` — produce the master architecture blueprint
6. `/gate-check pre-production` — validate readiness before committing to production
