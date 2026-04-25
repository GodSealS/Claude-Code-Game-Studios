---
name: setup-engine
description: "Configure the project's game engine and version. Pins the engine in CODEBUDDY.md, detects knowledge gaps, and populates engine reference docs via WebSearch when the version is beyond the LLM's training data. / 配置项目的游戏引擎和版本。在 CODEBUDDY.md 中固定引擎，检测知识差距，当版本超出 LLM 训练数据时通过 WebSearch 填充引擎参考文档。"
argument-hint: "[engine] | [engine version] | refresh | upgrade [old-version] [new-version] | no args for guided selection"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, WebSearch, WebFetch, Task, AskUserQuestion
---

When this skill is invoked: / 当此技能被调用时：

## 1. Parse Arguments / 1. 解析参数

Four modes: / 四种模式：

- **Full spec**: `/setup-engine godot 4.6` — engine and version provided / **完整规格**：`/setup-engine godot 4.6` — 提供引擎和版本
- **Engine only**: `/setup-engine unity` — engine provided, version will be looked up / **仅引擎**：`/setup-engine unity` — 提供引擎，将查找版本
- **No args**: `/setup-engine` — fully guided mode (engine recommendation + version) / **无参数**：`/setup-engine` — 完全引导模式（引擎推荐 + 版本）
- **Refresh**: `/setup-engine refresh` — update reference docs (see Section 10) / **刷新**：`/setup-engine refresh` — 更新参考文档（见第 10 节）
- **Upgrade**: `/setup-engine upgrade [old-version] [new-version]` — migrate to a new engine version (see Section 11) / **升级**：`/setup-engine upgrade [旧版本] [新版本]` — 迁移到新的引擎版本（见第 11 节）

---

## 2. Guided Mode (No Arguments) / 2. 引导模式（无参数）

If no engine is specified, run an interactive engine selection process: / 如果未指定引擎，运行交互式引擎选择过程：

### Check for existing game concept / 检查现有游戏概念
- Read `design/gdd/game-concept.md` if it exists — extract genre, scope, platform
  targets, art style, team size, and any engine recommendation from `/brainstorm` / 如果存在则读取 `design/gdd/game-concept.md` — 提取类型、范围、平台目标、美术风格、团队规模，以及来自 `/brainstorm` 的任何引擎推荐
- If no concept exists, inform the user: / 如果概念不存在，通知用户：
  > "No game concept found. Consider running `/brainstorm` first to discover what
  > you want to build — it will also recommend an engine. Or tell me about your
  > game and I can help you pick."
  > **中文翻译**："未找到游戏概念。考虑先运行 `/brainstorm` 来发现你想构建什么——它也会推荐引擎。或者告诉我你的游戏，我可以帮你选择。"

### If the user wants to pick without a concept, ask in this order: / 如果用户想在没有概念的情况下选择，按此顺序询问：

**Question 1 — Prior experience** (ask this first, always, via `AskUserQuestion`): / **问题 1 — 先前经验**（始终首先通过 `AskUserQuestion` 询问）：
- Prompt: "Have you worked in any of these engines before?" / 提示："你以前使用过这些引擎中的任何一个吗？"
- Options: `Godot` / `Unity` / `Unreal Engine 5` / `Multiple — I'll explain` / `None of them` / 选项：`Godot` / `Unity` / `Unreal Engine 5` / `多个 — 我会解释` / `都没有`
- If they pick a specific engine → recommend that engine. Prior experience outweighs all other factors. Confirm with them and skip the matrix. / 如果他们选择了特定引擎 → 推荐该引擎。先前经验压倒所有其他因素。与他们确认并跳过矩阵。
- If "None" or "Multiple" → continue to the questions below. / 如果"都没有"或"多个" → 继续下面的问题。

**Questions 2-6 — Decision matrix inputs** (only if no prior engine experience): / **问题 2-6 — 决策矩阵输入**（仅当没有先前引擎经验时）：

**Question 2 — Target platform** (ask this second, always, via `AskUserQuestion` — platform eliminates or heavily weights engines before any other factor): / **问题 2 — 目标平台**（始终第二，通过 `AskUserQuestion` 询问 — 平台在其他任何因素之前消除或严重加权引擎）：
- Prompt: "What platforms are you targeting for this game?" / 提示："你的游戏面向哪些平台？"
- Options: `PC (Steam / Epic)` / `Mobile (iOS / Android)` / `Console` / `Web / Browser` / `Multiple platforms` / 选项：`PC (Steam / Epic)` / `移动端 (iOS / Android)` / `主机` / `Web / 浏览器` / `多个平台`
- Platform rules that feed directly into the recommendation: / 直接影响推荐的平台规则：
  - Mobile → Unity strongly preferred; Unreal is a poor fit; Godot is viable for simple mobile / 移动端 → Unity 强烈推荐；Unreal 不适合；Godot 适合简单移动端
  - Console → Unity or Unreal; Godot console support requires third-party publishers or significant extra work / 主机 → Unity 或 Unreal；Godot 主机支持需要第三方发布商或大量额外工作
  - Web → Godot exports cleanly to web; Unity WebGL is functional; Unreal has poor web support / Web → Godot 干净导出到 Web；Unity WebGL 功能正常；Unreal Web 支持差
  - PC only → all engines viable; other factors decide / 仅 PC → 所有引擎都可行；其他因素决定
  - Multiple → Unity is the most portable across PC/mobile/console / 多个平台 → Unity 在 PC/移动端/主机之间最具可移植性

1. **What kind of game?** (2D, 3D, or both?) / **是什么类型的游戏？**（2D、3D 还是两者兼有？）
2. **Primary input method?** (keyboard/mouse, gamepad, touch, or mixed?) / **主要输入方式？**（键盘/鼠标、手柄、触摸还是混合？）
3. **Team size and experience?** (solo beginner, solo experienced, small team?) / **团队规模和经验？**（单人新手、单人经验丰富、小团队？）
4. **Any strong language preferences?** (GDScript, C#, C++, visual scripting?) / **有无强烈的语言偏好？**（GDScript、C#、C++、可视化脚本？）
5. **Budget for engine licensing?** (free only, or commercial licenses OK?) / **引擎许可预算？**（仅免费，还是允许商业许可？）

### Produce a recommendation / 生成推荐

Do NOT use a simple scoring matrix that eliminates engines. Instead, reason through the user's profile against the honest tradeoffs below, then present 1-2 recommendations with full context. Always end with the user choosing — never force a verdict. / **不要**使用消除引擎的简单评分矩阵。而是根据用户的配置文件与下面诚实的权衡进行推理，然后提供 1-2 个具有完整上下文的推荐。始终以用户选择结束 — 绝不强制执行裁决。

**Engine honest tradeoffs:** / **引擎诚实的权衡：**

**Godot 4** / **Godot 4**
- Genuine strengths: 2D (best in class), stylized/indie 3D, rapid iteration, free forever (MIT), open source, gentlest learning curve, best for solo devs who want full control / 真正优势：2D（同类最佳）、风格化/独立 3D、快速迭代、永久免费（MIT）、开源、最平缓的学习曲线、最适合想要完全控制的单人开发者
- Real limitations: 3D ecosystem is thin compared to Unity/Unreal (fewer tutorials, assets, community answers for 3D-specific problems); large open-world 3D is very hard and largely untested in Godot; console export requires third-party publishers or significant extra work; smaller professional job market / 真正限制：与 Unity/Unreal 相比 3D 生态系统薄弱（3D 特定问题的教程、资产、社区答案较少）；大型开放世界 3D 非常困难且在 Godot 中基本上未经测试；主机导出需要第三方发布商或大量额外工作；专业就业市场较小
- Licensing reality: Truly free with no revenue thresholds ever. MIT license means you own everything. / 许可现实：真正免费，无收入门槛。MIT 许可证意味着你拥有所有内容。
- Best fit: 2D games of any scope; stylized/atmospheric 3D; contained 3D worlds (not open-world); first game projects where learning curve matters; projects where budget is a hard constraint at any scale / 最佳适用：任何范围的 2D 游戏；风格化/氛围 3D；封闭 3D 世界（非开放世界）；学习曲线重要的第一个游戏项目；预算在任何规模下都是硬性约束的项目

**Unity** / **Unity**
- Genuine strengths: Industry standard for mid-scope 3D and mobile; massive asset store and tutorial ecosystem; C# is a professional language; best console certification support for indie; strong community for almost every genre / 真正优势：中等范围 3D 和移动端的行业标准；庞大的资产商店和教程生态系统；C# 是专业语言；最佳的主机独立游戏认证支持；几乎所有类型的强大社区
- Real limitations: Licensing controversy in 2023 damaged trust (runtime fee was proposed then walked back — the risk of policy changes remains real); C# has a steeper initial curve than GDScript; heavier editor than Godot for simple projects / 真正限制：2023 年的许可争议损害了信任（提出了运行时费用后又撤回 — 政策变更的风险仍然存在）；C# 比 GDScript 有更陡峭的初始学习曲线；对于简单项目比 Godot 编辑器更重
- Licensing reality: Free under $200K revenue AND 200K installs (Unity Personal/Plus). Only becomes costly if the game is genuinely successful — most indie games never hit this threshold. The 2023 controversy is worth knowing about but the actual current terms are reasonable for most indie developers. / 许可现实：收入低于 20 万美元且安装量低于 20 万时免费（Unity Personal/Plus）。只有当游戏真正成功时才会变得昂贵 — 大多数独立游戏从未达到此阈值。2023 年的争议值得了解，但实际的当前条款对大多数独立开发者来说是合理的。
- Best fit: Mobile games; mid-scope 3D; games targeting console; developers with C# background; projects needing large asset store; teams of 2-5 / 最佳适用：移动游戏；中等范围 3D；面向主机的游戏；有 C# 背景的开发者；需要大型资产商店的项目；2-5 人团队

**Unreal Engine 5** / **Unreal Engine 5**
- Genuine strengths: Best-in-class 3D visuals (Lumen, Nanite, Chaos physics); industry standard for AAA and photorealistic 3D; large open-world support is mature and production-tested; Blueprint visual scripting lowers C++ barrier; strong for games targeting high-end PC or console / 真正优势：同类最佳的 3D 视觉效果（Lumen、Nanite、Chaos 物理）；AAA 和照片级真实感 3D 的行业标准；大型开放世界支持成熟且经过生产测试；Blueprint 可视化脚本降低 C++ 门槛；针对高端 PC 或主机游戏能力强
- Real limitations: Steepest learning curve; heaviest editor (slow compile times, large project sizes); overkill for stylized/2D/small-scope games; C++ is genuinely hard; not suitable for mobile or web; 5% royalty past $1M gross revenue / 真正限制：最陡峭的学习曲线；最重的编辑器（编译时间长，项目大小大）；对于风格化/2D/小范围游戏是过度杀伤；C++ 确实困难；不适合移动端或 Web；超过 100 万美元总收入后 5% 版税
- Licensing reality: 5% royalty only applies AFTER $1M gross revenue per title. For a first game or any game that doesn't reach $1M, it costs nothing. This threshold is high enough that most indie developers will never pay it. / 许可现实：5% 版税仅适用于每个游戏总收入超过 100 万美元之后。对于第一款游戏或任何未达到 100 万美元的游戏，完全免费。此阈值足够高，大多数独立开发者永远不会支付。
- Best fit: AAA-quality 3D; large open-world games; photorealistic visuals; developers with C++ experience or willing to use Blueprint; games targeting high-end PC/console where visual fidelity is a core selling point / 最佳适用：AAA 质量 3D；大型开放世界游戏；照片级真实感视觉效果；有 C++ 经验或愿意使用 Blueprint 的开发者；面向高端 PC/主机的游戏，其中视觉保真度是核心卖点

**Genre-specific guidance** (factor this into the recommendation): / **类型特定指导**（将其纳入推荐）：
- 2D any style → Godot strongly preferred / 2D 任何风格 → Godot 强烈推荐
- 3D stylized / atmospheric / contained world → Godot viable, Unity solid alternative / 3D 风格化/氛围/封闭世界 → Godot 可行，Unity 是可靠的替代方案
- 3D open world (large, seamless) → Unity or Unreal; Godot is not production-proven for this / 3D 开放世界（大型，无缝）→ Unity 或 Unreal；Godot 未经生产验证
- 3D photorealistic / AAA-quality → Unreal / 3D 照片级真实感/AAA 质量 → Unreal
- Mobile-first → Unity strongly preferred / 移动优先 → Unity 强烈推荐
- Console-first → Unity or Unreal; Godot console support requires extra work / 主机优先 → Unity 或 Unreal；Godot 主机支持需要额外工作
- Horror / narrative / walking sim → any engine; match to art style and team experience / 恐怖/叙事/步行模拟 → 任何引擎；与美术风格和团队经验匹配
- Action RPG / Soulslike → Unity or Unreal for 3D; community support and assets matter here / 动作 RPG/Soulslike → Unity 或 Unreal（3D）；社区支持和资产在此重要
- Platformer 2D → Godot / 平台游戏 2D → Godot
- Strategy / top-down / RTS → Godot or Unity depending on 2D vs 3D / 策略/俯视角/RTS → Godot 或 Unity，取决于 2D 还是 3D

**Recommendation format:** / **推荐格式：**
1. Show a comparison table with the user's specific factors as rows / 展示一个比较表格，以用户的具体因素为行
2. Give a primary recommendation with honest reasoning / 提供主要推荐并附上诚实的推理
3. Name the best alternative and when to choose it instead / 命名最佳替代方案以及何时选择它
4. Explicitly state: "This is a starting point, not a verdict — you can always migrate engines, and many developers switch between projects." / 明确说明："这是一个起点，不是最终裁决 — 你总是可以迁移引擎，许多开发者在项目之间切换。"
5. Use `AskUserQuestion` to confirm: "Does this recommendation feel right, or would you like to explore a different engine?" / 使用 `AskUserQuestion` 确认："这个推荐感觉对吗，或者你想探索不同的引擎吗？"
   - Options: `[Primary engine] (Recommended)` / `[Alternative engine]` / `[Third engine]` / `Explore further` / `Type something` / 选项：`[主要引擎]（推荐）` / `[替代引擎]` / `[第三引擎]` / `进一步探索` / `输入内容`

**If the user picks "Explore further":** / **如果用户选择"进一步探索"：**
Use `AskUserQuestion` with concept-specific deep-dive topics. Always generate these options from the user's actual concept — do not use generic options. Always include at minimum: / 使用 `AskUserQuestion` 提出特定概念的深入主题。始终从用户的实际概念生成这些选项 — 不要使用通用选项。始终至少包括：
- The primary engine's specific limitations for this concept (e.g., "How far can Godot 3D actually go for [genre]?") / 主要引擎对此概念的具体限制（例如，"Godot 3D 对于 [类型] 能走多远？"）
- The alternative engine's specific tradeoffs for this concept / 替代引擎对此概念的具体权衡
- Language choice impact on this concept's technical challenges / 语言选择对此概念技术挑战的影响
- Any concept-specific technical concern (e.g., adaptive audio, open-world streaming, multiplayer netcode) / 任何特定概念的技术关注点（例如，自适应音频、开放世界流式传输、多人网络代码）

The user can select multiple topics. Answer each selected topic in depth before returning to the engine confirmation question. / 用户可以选择多个主题。在返回到引擎确认问题之前，深入回答每个选定的主题。

---

## 3. Look Up Current Version

Once the engine is chosen:

- If version was provided, use it
- If no version provided, use WebSearch to find the latest stable release:
  - Search: `"[engine] latest stable version [current year]"`
  - Confirm with the user: "The latest stable [engine] is [version]. Use this?"

---

## 4. Update CODEBUDDY.md Technology Stack

### Language Selection (Godot only)

If Godot was chosen, ask the user which language to use **before** showing the proposed Technology Stack:

> "Godot supports two primary languages:
>
>   **A) GDScript** — Python-like, Godot-native, fastest iteration. Best for beginners, solo devs, and teams coming from Python or Lua.
>   **B) C#** — .NET 8+, familiar to Unity developers, stronger IDE tooling (Rider / Visual Studio), slight performance advantage on heavy logic.
>   **C) Both** — GDScript for gameplay/UI scripting, C# for performance-critical systems. Advanced setup — requires .NET SDK alongside Godot.
>
> Which will this project primarily use?"

Record the choice. It determines the CODEBUDDY.md template, naming conventions, specialist routing, and which agent is spawned for code files throughout the project.

---

Read `CODEBUDDY.md` and show the user the proposed Technology Stack changes.
Ask: "May I write these engine settings to `CODEBUDDY.md`?"

Wait for confirmation before making any edits.

Update the Technology Stack section, replacing the `[CHOOSE]` placeholders with the actual values:

**For Godot** — use the template matching the language chosen above. See **Appendix A** at the bottom of this skill for all three variants (GDScript, C#, Both).

**For Unity:**
```markdown
- **Engine**: Unity [version]
- **Language**: C#
- **Build System**: Unity Build Pipeline
- **Asset Pipeline**: Unity Asset Import Pipeline + Addressables
```

**For Unreal:**
```markdown
- **Engine**: Unreal Engine [version]
- **Language**: C++ (primary), Blueprint (gameplay prototyping)
- **Build System**: Unreal Build Tool (UBT)
- **Asset Pipeline**: Unreal Content Pipeline
```

---

## 5. Populate Technical Preferences

After updating CODEBUDDY.md, create or update `.codebuddy/docs/technical-preferences.md` with
engine-appropriate defaults. Read the existing template first, then fill in:

### Engine & Language Section
- Fill from the engine choice made in step 4

### Naming Conventions (engine defaults)

**For Godot** — see **Appendix A** for GDScript, C#, and Both variants.

**For Unity (C#):**
- Classes: PascalCase (e.g., `PlayerController`)
- Public fields/properties: PascalCase (e.g., `MoveSpeed`)
- Private fields: _camelCase (e.g., `_moveSpeed`)
- Methods: PascalCase (e.g., `TakeDamage()`)
- Files: PascalCase matching class (e.g., `PlayerController.cs`)
- Constants: PascalCase or UPPER_SNAKE_CASE

**For Unreal (C++):**
- Classes: Prefixed PascalCase (`A` for Actor, `U` for UObject, `F` for struct)
- Variables: PascalCase (e.g., `MoveSpeed`)
- Functions: PascalCase (e.g., `TakeDamage()`)
- Booleans: `b` prefix (e.g., `bIsAlive`)
- Files: Match class without prefix (e.g., `PlayerController.h`)

### Input & Platform Section

Populate `## Input & Platform` using the answers gathered in Section 2 (or extracted
from the game concept). Derive the values using this mapping:

| Platform target | Gamepad Support | Touch Support |
|-----------------|-----------------|---------------|
| PC only | Partial (recommended) | None |
| Console | Full | None |
| Mobile | None | Full |
| PC + Console | Full | None |
| PC + Mobile | Partial | Full |
| Web | Partial | Partial |

For **Primary Input**, use the dominant input for the game genre:
- Action/RPG/platformer targeting console → Gamepad
- Strategy/point-and-click/RTS → Keyboard/Mouse
- Mobile game → Touch
- Cross-platform → ask the user

Present the derived values and ask the user to confirm or adjust before writing.

Example filled section:
```markdown
## Input & Platform
- **Target Platforms**: PC, Console
- **Input Methods**: Keyboard/Mouse, Gamepad
- **Primary Input**: Gamepad
- **Gamepad Support**: Full
- **Touch Support**: None
- **Platform Notes**: All UI must support d-pad navigation. No hover-only interactions.
```

### Remaining Sections
- **Performance Budgets**: Use `AskUserQuestion`:
  - Prompt: "Should I set default performance budgets now, or leave them for later?"
  - Options: `[A] Set defaults now (60fps, 16.6ms frame budget, engine-appropriate draw call limit)` / `[B] Leave as [TO BE CONFIGURED] — I'll set these when I know my target hardware`
  - If [A]: populate with the suggested defaults. If [B]: leave as placeholder.
- **Testing**: Suggest engine-appropriate framework (GUT for Godot, NUnit for Unity, etc.) — ask before adding.
- **Forbidden Patterns**: Leave as placeholder — do NOT pre-populate.
- **Allowed Libraries**: Leave as placeholder — do NOT pre-populate dependencies the project does not currently need. Only add a library here when it is actively being integrated, not speculatively.

> **Guardrail**: Never add speculative dependencies to Allowed Libraries. For example, do NOT add GodotSteam unless Steam integration is actively beginning in this session. Post-launch integrations should be added to Allowed Libraries when that work begins, not during engine setup.

### Engine Specialists Routing

Also populate the `## Engine Specialists` section in `technical-preferences.md` with the correct routing for the chosen engine:

**For Godot** — see **Appendix A** for the routing table matching the language chosen.

**For Unity:**
```markdown
## Engine Specialists
- **Primary**: unity-specialist
- **Language/Code Specialist**: unity-specialist (C# review — primary covers it)
- **Shader Specialist**: unity-shader-specialist (Shader Graph, HLSL, URP/HDRP materials)
- **UI Specialist**: unity-ui-specialist (UI Toolkit UXML/USS, UGUI Canvas, runtime UI)
- **Additional Specialists**: unity-dots-specialist (ECS, Jobs system, Burst compiler), unity-addressables-specialist (asset loading, memory management, content catalogs)
- **Routing Notes**: Invoke primary for architecture and general C# code review. Invoke DOTS specialist for any ECS/Jobs/Burst code. Invoke shader specialist for rendering and visual effects. Invoke UI specialist for all interface implementation. Invoke Addressables specialist for asset management systems.

### File Extension Routing

| File Extension / Type | Specialist to Spawn |
|-----------------------|---------------------|
| Game code (.cs files) | unity-specialist |
| Shader / material files (.shader, .shadergraph, .mat) | unity-shader-specialist |
| UI / screen files (.uxml, .uss, Canvas prefabs) | unity-ui-specialist |
| Scene / prefab / level files (.unity, .prefab) | unity-specialist |
| Native extension / plugin files (.dll, native plugins) | unity-specialist |
| General architecture review | unity-specialist |
```

**For Unreal:**
```markdown
## Engine Specialists
- **Primary**: unreal-specialist
- **Language/Code Specialist**: ue-blueprint-specialist (Blueprint graphs) or unreal-specialist (C++)
- **Shader Specialist**: unreal-specialist (no dedicated shader specialist — primary covers materials)
- **UI Specialist**: ue-umg-specialist (UMG widgets, CommonUI, input routing, widget styling)
- **Additional Specialists**: ue-gas-specialist (Gameplay Ability System, attributes, gameplay effects), ue-replication-specialist (property replication, RPCs, client prediction, netcode)
- **Routing Notes**: Invoke primary for C++ architecture and broad engine decisions. Invoke Blueprint specialist for Blueprint graph architecture and BP/C++ boundary design. Invoke GAS specialist for all ability and attribute code. Invoke replication specialist for any multiplayer or networked systems. Invoke UMG specialist for all UI implementation.

### File Extension Routing

| File Extension / Type | Specialist to Spawn |
|-----------------------|---------------------|
| Game code (.cpp, .h files) | unreal-specialist |
| Shader / material files (.usf, .ush, Material assets) | unreal-specialist |
| UI / screen files (.umg, UMG Widget Blueprints) | ue-umg-specialist |
| Scene / prefab / level files (.umap, .uasset) | unreal-specialist |
| Native extension / plugin files (Plugin .uplugin, modules) | unreal-specialist |
| Blueprint graphs (.uasset BP classes) | ue-blueprint-specialist |
| General architecture review | unreal-specialist |
```

### Collaborative Step
Present the filled-in preferences to the user. For Godot, include the chosen language and note where the full naming conventions and routing tables live:
> "Here are the default technical preferences for [engine] ([language if Godot]). The naming conventions and specialist routing are in Appendix A of this skill — I'll apply the [GDScript/C#/Both] variant. Want to customize any of these, or shall I save the defaults?"

For all other engines, present the defaults directly without referencing the appendix.

Wait for approval before writing the file.

---

## 6. Determine Knowledge Gap

Check whether the engine version is likely beyond the LLM's training data.

**Known approximate coverage** (update this as models change):
- LLM knowledge cutoff: **May 2025**
- Godot: training data likely covers up to ~4.3
- Unity: training data likely covers up to ~2023.x / early 6000.x
- Unreal: training data likely covers up to ~5.3 / early 5.4

Compare the user's chosen version against these baselines:

- **Within training data** → `LOW RISK` — reference docs optional but recommended
- **Near the edge** → `MEDIUM RISK` — reference docs recommended
- **Beyond training data** → `HIGH RISK` — reference docs required

Inform the user which category they're in and why.

---

## 7. Populate Engine Reference Docs

### If WITHIN training data (LOW RISK):

Create a minimal `docs/engine-reference/<engine>/VERSION.md`:

```markdown
# [Engine] — Version Reference

| Field | Value |
|-------|-------|
| **Engine Version** | [version] |
| **Project Pinned** | [today's date] |
| **LLM Knowledge Cutoff** | May 2025 |
| **Risk Level** | LOW — version is within LLM training data |

## Note

This engine version is within the LLM's training data. Engine reference
docs are optional but can be added later if agents suggest incorrect APIs.

Run `/setup-engine refresh` to populate full reference docs at any time.
```

Do NOT create breaking-changes.md, deprecated-apis.md, etc. — they would
add context cost with minimal value.

### If BEYOND training data (MEDIUM or HIGH RISK):

Create the full reference doc set by searching the web:

1. **Search for the official migration/upgrade guide**:
   - `"[engine] [old version] to [new version] migration guide"`
   - `"[engine] [version] breaking changes"`
   - `"[engine] [version] changelog"`
   - `"[engine] [version] deprecated API"`

2. **Fetch and extract** from official documentation:
   - Breaking changes between each version from the training cutoff to current
   - Deprecated APIs with replacements
   - New features and best practices

Ask: "May I create the engine reference docs under `docs/engine-reference/<engine>/`?"

Wait for confirmation before writing any files.

3. **Create the full reference directory**:
   ```
   docs/engine-reference/<engine>/
   ├── VERSION.md              # Version pin + knowledge gap analysis
   ├── breaking-changes.md     # Version-by-version breaking changes
   ├── deprecated-apis.md      # "Don't use X → Use Y" tables
   ├── current-best-practices.md  # New practices since training cutoff
   └── modules/                # Per-subsystem references (create as needed)
   ```

4. **Populate each file** using real data from the web searches, following
   the format established in existing reference docs. Every file must have
   a "Last verified: [date]" header.

5. **For module files**: Only create modules for subsystems where significant
   changes occurred. Don't create empty or minimal module files.

---

## 8. Update CODEBUDDY.md Import

Ask: "May I update the `@` import in `CODEBUDDY.md` to point to the new engine reference?"

Wait for confirmation, then update the `@` import under "Engine Version Reference" to point to the
correct engine:

```markdown
## Engine Version Reference

@docs/engine-reference/<engine>/VERSION.md
```

If the previous import pointed to a different engine (e.g., switching from
Godot to Unity), update it.

---

## 9. Update Agent Instructions

Ask: "May I add a Version Awareness section to the engine specialist agent files?" before making any edits.

For the chosen engine's specialist agents, verify they have a
"Version Awareness" section. If not, add one following the pattern in
the existing Godot specialist agents.

The section should instruct the agent to:
1. Read `docs/engine-reference/<engine>/VERSION.md`
2. Check deprecated APIs before suggesting code
3. Check breaking changes for relevant version transitions
4. Use WebSearch to verify uncertain APIs

---

## 10. Refresh Subcommand

If invoked as `/setup-engine refresh`:

1. Read the existing `docs/engine-reference/<engine>/VERSION.md` to get
   the current engine and version
2. Use WebSearch to check for:
   - New engine releases since last verification
   - Updated migration guides
   - Newly deprecated APIs
3. Update all reference docs with new findings
4. Update "Last verified" dates on all modified files
5. Report what changed

---

## 11. Upgrade Subcommand

If invoked as `/setup-engine upgrade [old-version] [new-version]`:

### Step 1 — Read Current Version State

Read `docs/engine-reference/<engine>/VERSION.md` to confirm the current pinned
version, risk level, and any migration note URLs already recorded. If
`old-version` was not provided as an argument, use the pinned version from this
file.

### Step 2 — Fetch Migration Guide

Use WebSearch and WebFetch to locate the official migration guide between
`old-version` and `new-version`:

- Search: `"[engine] [old-version] to [new-version] migration guide"`
- Search: `"[engine] [new-version] breaking changes changelog"`
- Fetch the migration guide URL from VERSION.md if one is already recorded,
  or use the URL found via search.

Extract: renamed APIs, removed APIs, changed defaults, behavior changes, and
any "must migrate" items.

### Step 3 — Pre-Upgrade Audit

Scan `src/` for code that uses APIs known to be deprecated or changed in the
target version:

- Use Grep to search for deprecated API names extracted from the migration
  guide (e.g., old function names, removed node types, changed property names)
- List each file that matches, with the specific API reference found

Present the audit results as a table:

```
Pre-Upgrade Audit: [engine] [old-version] → [new-version]
==========================================================

Files requiring changes:
  File                              | Deprecated API Found       | Effort
  --------------------------------- | -------------------------- | ------
  src/gameplay/player_movement.gd   | old_api_name               | Low
  src/ui/hud.gd                     | removed_node_type          | Medium

Breaking changes to watch for:
  - [change description from migration guide]
  - [change description from migration guide]

Recommended migration order (dependency-sorted):
  1. [system/layer with fewest dependencies first]
  2. [next system]
  ...
```

If no deprecated APIs are found in `src/`, report: "No deprecated API usage
found in src/ — upgrade may be low-risk."

### Step 4 — Confirm Before Updating

Ask the user before making any changes:

> "Pre-upgrade audit complete. Found [N] files using deprecated APIs.
> Proceed with upgrading VERSION.md to [new-version]?
> (This will update the pinned version and add migration notes — it does NOT
> change any source files. Source migration is done manually or via stories.)"

Wait for explicit confirmation before continuing.

### Step 5 — Update VERSION.md

After confirmation:

1. Update `docs/engine-reference/<engine>/VERSION.md`:
   - `Engine Version` → `[new-version]`
   - `Project Pinned` → today's date
   - `Last Docs Verified` → today's date
   - Re-evaluate and update the `Risk Level` and `Post-Cutoff Version Timeline`
     table if the new version falls beyond the LLM knowledge cutoff
   - Add a `## Migration Notes — [old-version] → [new-version]` section
     containing: migration guide URL, key breaking changes, deprecated APIs
     found in this project, and recommended migration order from the audit

2. If `breaking-changes.md` or `deprecated-apis.md` exist in the engine
   reference directory, append the new version's changes to those files.

### Step 6 — Post-Upgrade Reminder

After updating VERSION.md, output:

```
VERSION.md updated: [engine] [old-version] → [new-version]

Next steps:
1. Migrate deprecated API usages in the [N] files listed above
2. Run /setup-engine refresh after upgrading the actual engine binary to
   verify no new deprecations were missed
3. Run /architecture-review — the engine upgrade may invalidate ADRs that
   reference specific APIs or engine capabilities
4. If any ADRs are invalidated, run /propagate-design-change to update
   downstream stories
```

---

## 12. Output Summary

After setup is complete, output:

```
Engine Setup Complete
=====================
Engine:          [name] [version]
Language:        [GDScript | C# | GDScript + C# | C# | C++ + Blueprint]
Knowledge Risk:  [LOW/MEDIUM/HIGH]
Reference Docs:  [created/skipped]
CODEBUDDY.md:    [updated]
Tech Prefs:      [created/updated]
Agent Config:    [verified]

Next Steps:
1. Review docs/engine-reference/<engine>/VERSION.md
2. [If from /brainstorm] Run /map-systems to decompose your concept into individual systems
3. [If from /brainstorm] Run /design-system to author per-system GDDs (guided, section-by-section)
4. [If from /brainstorm] Run /prototype [core-mechanic] to test the core loop
5. [If fresh start] Run /brainstorm to discover your game concept
6. Create your first milestone: /sprint-plan new
```

---

Verdict: **COMPLETE** — engine configured and reference docs populated.

## Guardrails

- NEVER guess an engine version — always verify via WebSearch or user confirmation
- NEVER overwrite existing reference docs without asking — append or update
- If reference docs already exist for a different engine, ask before replacing
- Always show the user what you're about to change before making CODEBUDDY.md edits
- If WebSearch returns ambiguous results, show the user and let them decide
- When the user chose **GDScript**: copy the GDScript CLAUDE.md template from Appendix A1 exactly. NEVER add "C++ via GDExtension" to the Language field. GDScript projects may use GDExtension, but it is not a primary project language. The `godot-gdextension-specialist` in the routing table is available for when native extensions are needed — it does not make C++ a project language.

---

## Appendix A — Godot Language Configuration

All Godot-specific variants for language-dependent configuration. Referenced from Sections 4 and 5 — only relevant when Godot is the chosen engine. Use the subsection matching the language chosen in Section 4.

---

### A1. CODEBUDDY.md Technology Stack Templates

**GDScript:**
```markdown
- **Engine**: Godot [version]
- **Language**: GDScript
- **Build System**: SCons (engine), Godot Export Templates
- **Asset Pipeline**: Godot Import System + custom resource pipeline
```

> **Guardrail**: When using this GDScript template, write the Language field as exactly "`GDScript`" — no additions. Do NOT append "C++ via GDExtension" or any other language. The C# template below includes GDExtension because C# projects commonly wrap native code; GDScript projects do not.

**C#:**
```markdown
- **Engine**: Godot [version]
- **Language**: C# (.NET 8+, primary), C++ via GDExtension (native plugins only)
- **Build System**: .NET SDK + Godot Export Templates
- **Asset Pipeline**: Godot Import System + custom resource pipeline
```

**Both — GDScript + C#:**
```markdown
- **Engine**: Godot [version]
- **Language**: GDScript (gameplay/UI scripting), C# (performance-critical systems), C++ via GDExtension (native only)
- **Build System**: .NET SDK + Godot Export Templates
- **Asset Pipeline**: Godot Import System + custom resource pipeline
```

---

### A2. Naming Conventions

**GDScript:**
- Classes: PascalCase (e.g., `PlayerController`)
- Variables/functions: snake_case (e.g., `move_speed`)
- Signals: snake_case past tense (e.g., `health_changed`)
- Files: snake_case matching class (e.g., `player_controller.gd`)
- Scenes: PascalCase matching root node (e.g., `PlayerController.tscn`)
- Constants: UPPER_SNAKE_CASE (e.g., `MAX_HEALTH`)

**C#:**
- Classes: PascalCase (`PlayerController`) — must also be `partial`
- Public properties/fields: PascalCase (`MoveSpeed`, `JumpVelocity`)
- Private fields: `_camelCase` (`_currentHealth`, `_isGrounded`)
- Methods: PascalCase (`TakeDamage()`, `GetCurrentHealth()`)
- Signal delegates: PascalCase + `EventHandler` suffix (`HealthChangedEventHandler`)
- Files: PascalCase matching class (`PlayerController.cs`)
- Scenes: PascalCase matching root node (`PlayerController.tscn`)
- Constants: PascalCase (`MaxHealth`, `DefaultMoveSpeed`)

**Both — GDScript + C#:**
Use GDScript conventions for `.gd` files and C# conventions for `.cs` files. Mixed-language files do not exist — the boundary is per-file. When in doubt about which language a new system should use, ask the user and record the decision in `technical-preferences.md`.

---

### A3. Engine Specialists Routing

**GDScript:**
```markdown
## Engine Specialists
- **Primary**: godot-specialist
- **Language/Code Specialist**: godot-gdscript-specialist (all .gd files)
- **Shader Specialist**: godot-shader-specialist (.gdshader files, VisualShader resources)
- **UI Specialist**: godot-specialist (no dedicated UI specialist — primary covers all UI)
- **Additional Specialists**: godot-gdextension-specialist (GDExtension / native C++ bindings only)
- **Routing Notes**: Invoke primary for architecture decisions, ADR validation, and cross-cutting code review. Invoke GDScript specialist for code quality, signal architecture, static typing enforcement, and GDScript idioms. Invoke shader specialist for material design and shader code. Invoke GDExtension specialist only when native extensions are involved.

### File Extension Routing

| File Extension / Type | Specialist to Spawn |
|-----------------------|---------------------|
| Game code (.gd files) | godot-gdscript-specialist |
| Shader / material files (.gdshader, VisualShader) | godot-shader-specialist |
| UI / screen files (Control nodes, CanvasLayer) | godot-specialist |
| Scene / prefab / level files (.tscn, .tres) | godot-specialist |
| Native extension / plugin files (.gdextension, C++) | godot-gdextension-specialist |
| General architecture review | godot-specialist |
```

**C#:**
```markdown
## Engine Specialists
- **Primary**: godot-specialist
- **Language/Code Specialist**: godot-csharp-specialist (all .cs files)
- **Shader Specialist**: godot-shader-specialist (.gdshader files, VisualShader resources)
- **UI Specialist**: godot-specialist (no dedicated UI specialist — primary covers all UI)
- **Additional Specialists**: godot-gdextension-specialist (GDExtension / native C++ bindings only)
- **Routing Notes**: Invoke primary for architecture decisions, ADR validation, and cross-cutting code review. Invoke C# specialist for code quality, [Signal] delegate patterns, [Export] attributes, .csproj management, and C#-specific Godot idioms. Invoke shader specialist for material design and shader code. Invoke GDExtension specialist only when native C++ plugins are involved.

### File Extension Routing

| File Extension / Type | Specialist to Spawn |
|-----------------------|---------------------|
| Game code (.cs files) | godot-csharp-specialist |
| Shader / material files (.gdshader, VisualShader) | godot-shader-specialist |
| UI / screen files (Control nodes, CanvasLayer) | godot-specialist |
| Scene / prefab / level files (.tscn, .tres) | godot-specialist |
| Project config (.csproj, NuGet) | godot-csharp-specialist |
| Native extension / plugin files (.gdextension, C++) | godot-gdextension-specialist |
| General architecture review | godot-specialist |
```

**Both — GDScript + C#:**
```markdown
## Engine Specialists
- **Primary**: godot-specialist
- **GDScript Specialist**: godot-gdscript-specialist (.gd files — gameplay/UI scripts)
- **C# Specialist**: godot-csharp-specialist (.cs files — performance-critical systems)
- **Shader Specialist**: godot-shader-specialist (.gdshader files, VisualShader resources)
- **UI Specialist**: godot-specialist (no dedicated UI specialist — primary covers all UI)
- **Additional Specialists**: godot-gdextension-specialist (GDExtension / native C++ bindings only)
- **Routing Notes**: Invoke primary for cross-language architecture decisions and which systems belong in which language. Invoke GDScript specialist for .gd files. Invoke C# specialist for .cs files and .csproj management. Prefer signals over direct cross-language method calls at the boundary.

### File Extension Routing

| File Extension / Type | Specialist to Spawn |
|-----------------------|---------------------|
| Game code (.gd files) | godot-gdscript-specialist |
| Game code (.cs files) | godot-csharp-specialist |
| Cross-language boundary decisions | godot-specialist |
| Shader / material files (.gdshader, VisualShader) | godot-shader-specialist |
| UI / screen files (Control nodes, CanvasLayer) | godot-specialist |
| Scene / prefab / level files (.tscn, .tres) | godot-specialist |
| Project config (.csproj, NuGet) | godot-csharp-specialist |
| Native extension / plugin files (.gdextension, C++) | godot-gdextension-specialist |
| General architecture review | godot-specialist |
```
