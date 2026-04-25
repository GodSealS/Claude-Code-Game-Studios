# Accessibility Requirements: [Game Title] / 无障碍要求：[游戏名称]

> **Status**: Draft | Committed | Audited | Certified / **状态**：草稿 | 已承诺 | 已审核 | 已认证
> **Author**: [ux-designer / producer] / **作者**：[ux-designer / producer]
> **Last Updated**: [Date] / **最后更新**：[日期]
> **Accessibility Tier Target**: [Basic / Standard / Comprehensive / Exemplary] / **无障碍层级目标**：[基础 | 标准 | 全面 | 典范]
> **Platform(s)**: [PC / Xbox / PlayStation 5 / Nintendo Switch / iOS / Android] / **平台**：[PC / Xbox / PlayStation 5 / Nintendo Switch / iOS / Android]
> **External Standards Targeted**: / **目标外部标准**：
> - WCAG 2.1 Level [A / AA / AAA] / WCAG 2.1 级别 [A / AA / AAA]
> - AbleGamers CVAA Guidelines / AbleGamers CVAA 指南
> - Xbox Accessibility Guidelines (XAG) [Yes / No / Partial] / Xbox 无障碍指南 (XAG) [是 / 否 / 部分]
> - PlayStation Accessibility (Sony Guidelines) [Yes / No / Partial] / PlayStation 无障碍 (索尼指南) [是 / 否 / 部分]
> - Apple / Google Accessibility Guidelines [Yes / No / N/A — mobile only] / Apple / Google 无障碍指南 [是 / 否 / 不适用 — 仅移动端]
> **Accessibility Consultant**: [Name and organization, or "None engaged"] / **无障碍顾问**：[姓名和组织，或"未聘请"]
> **Linked Documents**: `design/gdd/systems-index.md`, `docs/ux/interaction-pattern-library.md` / **链接文档**：`design/gdd/systems-index.md`, `docs/ux/interaction-pattern-library.md`

> **Why this document exists**: Per-screen accessibility annotations belong in
> UX specs. This document captures the project-wide accessibility commitments, / **为什么存在此文档**：按屏幕的无障碍注释属于UX规范。此文档捕获项目范围的无障碍承诺、
> the feature matrix across all systems, the test plan, and the audit history. / 所有系统的功能矩阵、测试计划和审核历史。
> It is created once during Technical Setup by the UX designer and producer, / 它在技术设置期间由UX设计师和制作人创建一次，
> then updated as features are added and audits are completed. If a feature / 然后在添加功能和完成审核时更新。如果一个功能
> conflicts with a commitment made here, this document wins — change the feature, / 与此处做出的承诺冲突，以此文档为准——更改功能，
> not the commitment, unless the producer approves a formal revision. / 而不是承诺，除非制作人批准正式修订。
>
> **When to update**: After each `/gate-check` pass, after any accessibility / **何时更新**：每次`/gate-check`通过后，任何无障碍
> audit, and whenever a new game system is added to `systems-index.md`. / 审核后，以及每当新游戏系统添加到`systems-index.md`时。

---

## Accessibility Tier Definition / 无障碍层级定义

> **Why define tiers**: Accessibility is not binary. Defining four tiers gives / **为什么定义层级**：无障碍不是二元的。定义四个层级给予
> the team a shared vocabulary, forces an explicit commitment at the start of / 团队共同词汇，在开始生产时强制明确的承诺，
> production, and prevents scope creep in both directions ("we'll add it later" / 并防止范围在两个方向上蔓延（"我们稍后添加"
> and "we have to support everything"). The tiers below are this project's / 和"我们必须支持一切"）。下面的层级是此项目的
> definitions — the industry uses similar but not identical language. Commit to / 定义——行业使用类似但不完全相同的语言。承诺
> a tier with specific feature targets, not just the tier name. / 一个具有具体功能目标的层级，而不仅仅是层级名称。

### Tier Definitions / 层级定义

| Tier / 层级 | Core Commitment / 核心承诺 | Typical Effort / 典型工作量 |
|------|----------------|----------------|
| **Basic** / **基础** | Critical player-facing text is readable at standard resolution. No feature requires color discrimination alone. Volume controls exist for music, SFX, and voice independently. The game is completable without photosensitivity risk. / 面向玩家的关键文本在标准分辨率下可读。没有功能仅需要颜色区分。音乐、音效和语音有独立的音量控制。游戏可在无光敏性风险的情况下完成。 | Low — primarily design constraints / 低 — 主要是设计约束 |
| **Standard** / **标准** | All of Basic, plus: full input remapping on all platforms, subtitle support with speaker identification, adjustable text size, at least one colorblind mode, and no timed input that cannot be extended or toggled. / 基础的所有内容，加上：所有平台上的完整输入重映射、带说话者标识的字幕支持、可调整的文本大小、至少一种色盲模式，以及没有无法扩展或切换的定时输入。 | Medium — requires dedicated implementation work / 中 — 需要专门的实现工作 |
| **Comprehensive** / **全面** | All of Standard, plus: screen reader support for menus, mono audio option, difficulty assist modes, HUD element repositioning, reduced motion mode, and visual indicators for all gameplay-critical audio. / 标准的所有内容，加上：菜单的屏幕阅读器支持、单声道音频选项、难度辅助模式、HUD元素重新定位、减少运动模式，以及所有游戏关键音频的视觉指示器。 | High — requires platform API integration and significant UI architecture / 高 — 需要平台API集成和重要的UI架构 |
| **Exemplary** / **典范** | All of Comprehensive, plus: full subtitle customization (font, size, color, background, position), high contrast mode, cognitive load assist tools, tactile/haptic alternatives for all audio-only cues, and external third-party accessibility audit. / 全面的所有内容，加上：完整的字幕自定义（字体、大小、颜色、背景、位置）、高对比度模式、认知负荷辅助工具、所有纯音频提示的触觉/震动替代方案，以及外部第三方无障碍审核。 | Very High — requires dedicated accessibility budget and specialist consultation / 非常高 — 需要专门的无障碍预算和专家咨询 |

### This Project's Commitment / 此项目的承诺

**Target Tier**: [Standard] / **目标层级**：[标准]

**Rationale**: [Write 3-5 sentences justifying the tier choice. Do not simply / **理由**：[写3-5句话证明层级选择的合理性。不要简单
state the tier — explain the reasoning. Consider: What is the game's genre and / 陈述层级——解释推理。考虑：游戏的类型是什么以及
how does it map to common accessibility barriers (e.g., fast-twitch games have / 它如何映射到常见的无障碍障碍（例如，快速反应游戏有
motor barriers; reading-heavy games have visual barriers)? Who is the target / 运动障碍；阅读量大的游戏有视觉障碍）？谁是目标
player and what does the research say about disability prevalence in that group? / 玩家，关于该群体残疾流行率的研究怎么说？
What are the platform requirements (Xbox requires XAG compliance for ID@Xbox)? / 平台要求是什么（Xbox要求ID@Xbox符合XAG）？
What is the team's capacity? What would dropping one tier cost the player base, / 团队的容量如何？降低一个层级会对玩家群体造成什么成本，
in concrete terms? / 具体来说？

Example: "This is a narrative RPG with turn-based combat targeted at players / 示例："这是一个叙事RPG游戏，具有回合制战斗，针对
25-45. The turn-based structure eliminates the most severe motor barriers common / 25-45岁的玩家。回合制结构消除了动作游戏中
in action games, but the reading-heavy design creates significant visual and / 最常见的严重运动障碍，但阅读量大的设计造成了显著的视觉和
cognitive barriers. Standard tier addresses all of these. Exemplary tier is not / 认知障碍。标准层级解决了所有这些。典范层级
achievable without a dedicated accessibility engineer. Xbox ID@Xbox program / 没有专门的无障碍工程师无法实现。Xbox ID@Xbox项目
requires XAG compliance for Game Pass consideration, which Standard meets. / 要求符合XAG才能考虑进入Game Pass，标准层级符合。
Dropping to Basic would exclude players who rely on colorblind modes or input / 降低到基础层级将排除依赖色盲模式或输入
remapping, estimated at 8-12% of the target audience based on AbleGamers data."] / 重映射的玩家，根据AbleGamers数据估计占目标受众的8-12%。”]

**Features explicitly in scope (beyond tier baseline)**: / **明确在范围内的功能（超出层级基线）**：
- [e.g., "Full subtitle customization — elevated from Comprehensive because our / [例如，"完整的字幕自定义——从全面提升，因为我们的
  game is dialogue-heavy and subtitles are a primary channel"] / 游戏对话密集且字幕是主要通道"]
- [e.g., "One-hand mode for controller — we have hold inputs critical to combat"] / [例如，"控制器单手模式——我们有对战斗关键的长按输入"]

**Features explicitly out of scope**: / **明确不在范围内的功能**：
- [e.g., "Screen reader for in-game world (not menus) — requires engine work / [例如，"游戏世界（非菜单）的屏幕阅读器——需要引擎工作
  beyond current capacity. Documented in Known Intentional Limitations."] / 超出当前容量。记录在已知故意限制中。"]

---

## Visual Accessibility / 视觉无障碍

> **Why this section comes first**: Visual impairments affect the largest / **为什么此部分首先**：视觉障碍影响使用无障碍功能的
> proportion of players who use accessibility features. Color vision deficiency / 玩家中最大的比例。色觉缺陷
> alone affects approximately 8% of men and 0.5% of women. Text legibility at / 单独影响大约8%的男性和0.5%的女性。在
> TV viewing distance is frequently the single largest accessibility failure / 电视观看距离下的文本可读性通常是已发布游戏中
> in shipped games. Document every visual feature before implementation begins, / 最大的无障碍失败。在开始实现之前记录每个视觉功能，
> because retrofitting minimum text sizes or color decisions after assets are / 因为在资产锁定后改造最小文本大小或颜色决策是昂贵的。
> locked is expensive.

| Feature / 功能 | Target Tier / 目标层级 | Scope / 范围 | Status / 状态 | Implementation Notes / 实现说明 |
|---------|-------------|-------|--------|---------------------|
| Minimum text size — menu UI / 最小文本大小 — 菜单界面 | Standard / 标准 | All menu screens / 所有菜单屏幕 | Not Started / 未开始 | 24px minimum at 1080p. At 4K, scale proportionally. Reference: WCAG 2.1 SC 1.4.4 requires text resizable to 200% without loss of content. / 1080p下最小24px。4K下按比例缩放。参考：WCAG 2.1 SC 1.4.4要求文本可调整到200%而不丢失内容。 |
| Minimum text size — subtitles / 最小文本大小 — 字幕 | Standard / 标准 | All voiced/captioned content / 所有语音/字幕内容 | Not Started / 未开始 | 32px minimum at 1080p. Players viewing on TV at 3m are the constraint. / 1080p下最小32px。在3米距离电视观看的玩家是限制因素。 |
| Minimum text size — HUD / 最小文本大小 — HUD | Standard / 标准 | In-game HUD / 游戏内HUD | Not Started / 未开始 | 20px minimum for critical information (health, ammo, objective). Non-critical HUD elements may be smaller. / 关键信息（健康、弹药、目标）最小20px。非关键HUD元素可以更小。 |
| Text contrast — UI text on backgrounds / 文本对比度 — 背景上的界面文本 | Standard / 标准 | All UI text / 所有界面文本 | Not Started / 未开始 | Minimum 4.5:1 ratio for body text (WCAG AA). 3:1 for large text (18px+ or 14px bold). Test with automated contrast checker on final color values. / 正文文本最小4.5:1比率（WCAG AA）。大文本（18px+或14px粗体）3:1。对最终颜色值使用自动对比度检查器测试。 |
| Text contrast — subtitles / 文本对比度 — 字幕 | Standard / 标准 | Subtitle display / 字幕显示 | Not Started / 未开始 | Minimum 7:1 ratio (WCAG AAA) for subtitles — players read them quickly and cannot control background. Use drop shadow or opaque background box by default. / 字幕最小7:1比率（WCAG AAA）—玩家快速阅读且无法控制背景。默认使用投影或不透明背景框。 |
| Colorblind mode — Protanopia / 色盲模式 — 红色盲 | Standard / 标准 | All color-coded gameplay / 所有颜色编码的游戏玩法 | Not Started / 未开始 | Red-green — affects ~6% of men. Primary concern: health bars, enemy indicators, map markers. Shift red signals to orange/yellow; shift green signals to teal. / 红绿色盲 — 影响约6%的男性。主要关注：血条、敌人指示器、地图标记。将红色信号转移到橙/黄色；将绿色信号转移到蓝绿色。 |
| Colorblind mode — Deuteranopia / 色盲模式 — 绿色盲 | Standard / 标准 | All color-coded gameplay / 所有颜色编码的游戏玩法 | Not Started / 未开始 | Green-red — affects ~1% of men. Similar to Protanopia in practical impact. Often the same palette adjustment covers both. Verify with Coblis or Colour Blindness Simulator. / 绿红色盲 — 影响约1%的男性。实际影响类似红色盲。通常相同的调色板调整涵盖两者。使用Coblis或色盲模拟器验证。 |
| Colorblind mode — Tritanopia / 色盲模式 — 蓝色盲 | Standard / 标准 | All color-coded gameplay / 所有颜色编码的游戏玩法 | Not Started / 未开始 | Blue-yellow — rarer (~0.001%). Shift blue UI elements to purple; shift yellow to orange. / 蓝黄色盲 — 更罕见（约0.001%）。将蓝色界面元素转移到紫色；将黄色转移到橙色。 |
| Color-as-only-indicator audit / 颜色作为唯一指示器审核 | Basic / 基础 | All UI and gameplay / 所有界面和游戏玩法 | Not Started / 未开始 | List every place color is the SOLE differentiator in the table below. Each must have a non-color backup (icon, shape, pattern, text label) before shipping. / 在下表中列出颜色是唯一区分器的每个地方。在发布前每个必须有非颜色备份（图标、形状、图案、文本标签）。 |
| UI scaling / 界面缩放 | Standard / 标准 | All UI elements / 所有界面元素 | Not Started / 未开始 | Range: 75% to 150%. Default: 100%. Scaling must not break layout — test all screens at min and max. HUD scaling should be independent from menu scaling. / 范围：75%至150%。默认：100%。缩放不能破坏布局——在所有屏幕的最小和最大值测试。HUD缩放应独立于菜单缩放。 |
| High contrast mode / 高对比度模式 | Comprehensive / 全面 | Menus (minimum); HUD (preferred) / 菜单（最小）；HUD（首选） | Not Started / 未开始 | Replace all semi-transparent backgrounds with fully opaque. Replace mid-tone UI colors with black/white/system-high-contrast colors. All interactive elements outlined. / 将所有半透明背景替换为完全不透明。将中间色调界面颜色替换为黑/白/系统高对比度颜色。所有交互元素都有轮廓。 |
| Brightness/gamma controls / 亮度/伽马控制 | Basic / 基础 | Global / 全局 | Not Started / 未开始 | Exposed in graphics settings. Include a reference calibration image (a gradient or symbol barely visible at correct calibration). Range: -50% to +50% from default. / 在图形设置中公开。包含参考校准图像（在正确校准下几乎不可见的渐变或符号）。范围：从默认值的-50%到+50%。 |
| Screen flash / strobe warning / 屏幕闪烁/频闪警告 | Basic / 基础 | All cutscenes, VFX / 所有过场动画、视觉特效 | Not Started / 未开始 | (1) Pre-launch warning screen with photosensitivity seizure notice. (2) Audit all flash-heavy VFX against Harding FPA standard (no more than 3 flashes per second above luminance threshold). (3) Optional: flash reduction mode that lowers flash amplitude by 80%. / (1) 预启动警告屏幕带有光敏性癫痫发作通知。(2) 根据Harding FPA标准审核所有闪光密集的视觉特效（每秒不超过3次超过亮度阈值的闪光）。(3) 可选：将闪光幅度降低80%的闪光减少模式。 |
| Motion/animation reduction mode / 运动/动画减少模式 | Standard / 标准 | All UI transitions, camera shake, VFX / 所有界面过渡、相机抖动、视觉特效 | Not Started / 未开始 | Reduce or eliminate: screen shake, camera bob, motion blur, parallax scrolling in menus, looping background animations. Cannot fully eliminate: player movement animation (would break readability). Toggle in accessibility settings. / 减少或消除：屏幕抖动、相机晃动、运动模糊、菜单中的视差滚动、循环背景动画。不能完全消除：玩家移动动画（会破坏可读性）。在无障碍设置中切换。 |
| Subtitles — on/off / 字幕 — 开/关 | Basic / 基础 | All voiced content / 所有语音内容 | Not Started / 未开始 | Default: OFF (industry standard — many players prefer immersion). Prominently offered at first launch. / 默认：关闭（行业标准 — 许多玩家偏好沉浸感）。在首次启动时显着提供。 |
| Subtitles — speaker identification / 字幕 — 说话者标识 | Standard / 标准 | All voiced content / 所有语音内容 | Not Started / 未开始 | Speaker name displayed before dialogue line. Color-coded by speaker IF colors differ by more than hue alone (test for colorblind compatibility). / 说话者名称显示在对话行之前。按说话者颜色编码如果颜色差异不仅仅是色调（测试色盲兼容性）。 |
| Subtitles — style customization / 字幕 — 样式自定义 | Comprehensive / 全面 | Subtitle display / 字幕显示 | Not Started / 未开始 | Font size (4 sizes minimum), background opacity (0–100%), text color (white / yellow / custom), position (bottom / top / player-relative). / 字体大小（最小4种大小）、背景不透明度（0–100%）、文本颜色（白色/黄色/自定义）、位置（底部/顶部/相对玩家）。 |
| Subtitles — sound effect captions / 字幕 — 音效字幕 | Comprehensive / 全面 | Gameplay-critical SFX / 游戏玩法关键音效 | Not Started / 未开始 | See Auditory Accessibility section for which SFX qualify. Format: [SOUND DESCRIPTION] in brackets, distinct from dialogue. / 查看听觉无障碍部分了解哪些音效符合条件。格式：[声音描述]用括号，与对话区分。 |

### Color-as-Only-Indicator Audit / 颜色作为唯一指示器审核

> Fill in every gameplay or UI element where color is currently the sole / 填写每个颜色当前是唯一区分器的
> differentiator. Resolve each before shipping. A resolved entry has a non-color / 游戏玩法或界面元素。在发布前解决每个问题。一个已解决的条目有非颜色
> backup that works in all three colorblind modes above. / 备份，在上述三种色盲模式下都有效。

| Location / 位置 | Color Signal / 颜色信号 | What It Communicates / 传达什么 | Non-Color Backup / 非颜色备份 | Status / 状态 |
|----------|-------------|---------------------|-----------------|--------|
| [Health bar] / [血条] | [Red = low health] / [红色 = 低生命值] | [Player is near death] / [玩家接近死亡] | [Bar also shows numeric value and flashes] / [条也显示数值并闪烁] | [Not Started] / [未开始] |
| [Minimap markers] / [小地图标记] | [Red = enemy, green = ally] / [红色 = 敌人，绿色 = 盟友] | [Unit allegiance] / [单位忠诚度] | [Enemy markers are triangles; ally markers are circles] / [敌人标记是三角形；盟友标记是圆形] | [Not Started] / [未开始] |
| [Inventory item rarity] / [库存物品稀有度] | [Color-coded border (grey/blue/purple/gold)] / [颜色编码边框（灰/蓝/紫/金）] | [Item quality tier] / [物品质量层级] | [Rarity name shown on hover/focus; icon star count] / [悬停/焦点时显示稀有度名称；图标星数] | [Not Started] / [未开始] |
| [Add row for each color-coded element] / [为每个颜色编码元素添加行] | | | | |

---

## Motor Accessibility / 运动无障碍

> **Why motor accessibility matters for games**: Games are more motor-demanding / **为什么运动无障碍对游戏重要**：游戏比大多数软件需要更多的运动能力。
> than most software. A web form requires precise clicks; a game may require / 一个网页表单需要精确点击；一个游戏可能需要
> rapid simultaneous button combinations held for specific durations. Motor / 快速同时的按钮组合按住特定持续时间。运动
> impairments span a wide range — from tremor (affecting precision) to / 障碍范围很广——从震颤（影响精度）到
> hemiplegia (one functional hand) to RSI (affecting hold duration). The AbleGamers / 偏瘫（一只功能手）到RSI（影响按住持续时间）。AbleGamers
> Able Assistance program estimates 35 million gamers in the US have a disability / Able Assistance项目估计美国有3500万玩家有残疾
> affecting their ability to play. Many of the features below cost very little / 影响他们的游戏能力。下面的许多功能如果在开始时规划成本非常低，
> to implement if planned from the start, and are extremely expensive to add post-launch. / 而在发布后添加极其昂贵。

| Feature / 功能 | Target Tier / 目标层级 | Scope / 范围 | Status / 状态 | Implementation Notes / 实现说明 |
|---------|-------------|-------|--------|---------------------|
| Full input remapping / 完整输入重映射 | Standard / 标准 | All gameplay inputs, all platforms / 所有游戏玩法输入，所有平台 | Not Started / 未开始 | Every input bound by default must be rebindable. Remapping applies to keyboard, mouse, controller, and any supported peripheral independently. No two actions may be bound to the same input simultaneously (warn on conflict). Persist remapping to player profile. / 默认绑定的每个输入必须可重新绑定。重映射独立应用于键盘、鼠标、控制器和任何支持的外设。没有两个动作可以同时绑定到同一输入（冲突时警告）。将重映射保存到玩家配置文件中。 |
| Input method switching / 输入方法切换 | Standard / 标准 | PC | Not Started / 未开始 | Player must be able to switch between keyboard/mouse and gamepad at any moment without restarting. UI must update prompts dynamically (show correct button icons for active input method). / 玩家必须能够随时在键盘/鼠标和手柄之间切换而不需要重启。界面必须动态更新提示（显示活动输入方法的正确按钮图标）。 |
| One-hand mode / 单手模式 | [Tier] / [层级] | [Identify which features require two simultaneous hands] / [识别哪些功能需要两只手同时操作] | Not Started / 未开始 | Audit every multi-input action. For each: can it be executed with a single hand? If not, provide a toggle alternative or hold-to-toggle version. Specify here which features have a one-hand path and which do not. / 审核每个多输入动作。对每个：可以用单手执行吗？如果不能，提供切换替代方案或按住切换版本。在此处指定哪些功能有单手路径，哪些没有。 |
| Hold-to-press alternatives / 长按按压替代方案 | Standard / 标准 | All hold inputs / 所有长按输入 | Not Started / 未开始 | Every "hold [button] to [action]" must offer a toggle alternative. Toggle mode: first press activates, second press deactivates. Example: "Hold to sprint" becomes optional "toggle sprint" mode. List all hold inputs in the game here. / 每个"按住[按钮]以[动作]"必须提供切换替代方案。切换模式：第一次按下激活，第二次按下停用。示例："按住冲刺"变为可选的"切换冲刺"模式。在此列出游戏中所有长按输入。 |
| Rapid input alternatives / 快速输入替代方案 | Standard / 标准 | Any button mashing / rapid input sequences / 任何按钮猛按/快速输入序列 | Not Started / 未开始 | Any input requiring more than 3 presses per second sustained must offer a single-press toggle alternative. Example: Hades' "Hold to dash repeatedly" solves this elegantly. / 任何需要每秒持续超过3次按下的输入必须提供单次按压切换替代方案。示例：《黑帝斯》的"按住反复冲刺"优雅地解决了这个问题。 |
| Input timing adjustments / 输入定时调整 | Standard / 标准 | QTEs, timed button presses, rhythm inputs / QTE、定时按钮按压、节奏输入 | Not Started / 未开始 | Provide a timing window multiplier in accessibility settings. Minimum range: 0.5x to 3.0x. Default: 1.0x. At 3.0x, a 500ms window becomes 1500ms. Document every timed input in this game and test at all multiplier values. / 在无障碍设置中提供定时窗口乘数。最小范围：0.5倍至3.0倍。默认：1.0倍。在3.0倍时，500ms窗口变为1500ms。记录此游戏中每个定时输入并在所有乘数值下测试。 |
| Aim assist / 瞄准辅助 | Standard / 标准 | All ranged combat / targeting / 所有远程战斗/瞄准 | Not Started / 未开始 | Not just on/off — provide granularity: Assist Strength (0–100%), Assist Radius, Aim Magnetism (snap-to-target), and Aim Slowdown (near-target deceleration) as separate sliders. Default values should be tuned to feel helpful, not intrusive. / 不仅是开/关——提供粒度：辅助强度（0–100%）、辅助半径、瞄准磁力（吸附到目标）和瞄准减速（接近目标减速）作为单独的滑块。默认值应调整为感觉有帮助，而不是侵入性。 |
| Auto-sprint / movement assists / 自动冲刺/移动辅助 | Standard / 标准 | Movement systems / 移动系统 | Not Started / 未开始 | "Hold to sprint" toggle (covered above). Additionally: auto-run option (hold direction, player continues without input). Specify any movement input that is held continuously in normal gameplay. / "按住冲刺"切换（上文已覆盖）。此外：自动奔跑选项（按住方向，玩家继续前进无需输入）。指定在正常游戏玩法中持续按住任何移动输入。 |
| Platforming / traversal assists / 平台跳跃/穿越辅助 | [Tier] / [层级] | [If game has platforming] / [如果游戏有平台跳跃] | Not Started / 未开始 | Evaluate whether auto-grab (generous ledge detection), coyote time extension, and jump height adjustment are appropriate for this game's design. If platforming is not a game system, mark N/A. / 评估自动抓取（宽松的边缘检测）、Coyote时间延长和跳跃高度调整是否适合此游戏设计。如果平台跳跃不是游戏系统，标记为不适用。 |
| HUD element repositioning / HUD元素重新定位 | Comprehensive / 全面 | All HUD elements / 所有HUD元素 | Not Started / 未开始 | Allow players to move health bars, minimaps, and quest trackers to their preferred screen position. Particularly important for players using head-tracking or eye-gaze hardware who may have reduced peripheral vision coverage. / 允许玩家将血条、小地图和任务追踪器移动到他们偏好的屏幕位置。对于使用头部追踪或眼球凝视硬件的玩家特别重要，他们可能外围视觉覆盖减少。 |

---

## Cognitive Accessibility / 认知无障碍

> **Why cognitive accessibility is often under-specced**: Cognitive accessibility / **为什么认知无障碍经常规范不足**：认知无障碍
> affects players with ADHD, dyslexia, autism spectrum conditions, acquired brain / 影响有ADHD、阅读障碍、自闭症谱系状况、获得性脑损伤
> injuries, and anxiety disorders — a larger combined population than many studios / 和焦虑障碍的玩家——比许多工作室
> realize. It also benefits all players in high-stress moments. The most common / 意识到的更大的综合人群。它在高压力时刻也使所有玩家受益。最常见的
> failures are: no pause anywhere, tutorial information that can only be seen once, / 失败是：无处暂停、只能看到一次的教程信息，
> and systems that require tracking too many simultaneous states. Games like / 以及需要跟踪太多同时状态的系统。像
> Hades and Celeste have demonstrated that cognitive assist options (god mode, / 《黑帝斯》和《蔚蓝》已经证明认知辅助选项（上帝模式、
> persistent reminders, extended text display) do not harm the experience for / 持久提醒、扩展文本显示）不损害不使用的玩家的体验。
> players who don't use them.

| Feature / 功能 | Target Tier / 目标层级 | Scope / 范围 | Status / 状态 | Implementation Notes / 实现说明 |
|---------|-------------|-------|--------|---------------------|
| Difficulty options / 难度选项 | Standard / 标准 | All gameplay difficulty parameters / 所有游戏玩法难度参数 | Not Started / 未开始 | Separate granular sliders where possible (damage dealt, damage received, enemy aggression, enemy speed) rather than a single Easy/Normal/Hard label. Document which parameters are adjustable and which are fixed. Fixed parameters require a design justification. / 尽可能分离的粒度滑块（造成伤害、受到伤害、敌人攻击性、敌人速度）而不是单个简单/正常/困难标签。记录哪些参数可调，哪些是固定的。固定参数需要设计理由。 |
| Pause anywhere / 随处暂停 | Basic / 基础 | All gameplay states / 所有游戏玩法状态 | Not Started / 未开始 | Players must be able to pause during any gameplay state, including cutscenes, dialogue, and tutorial sequences. Document any state where pausing is currently prevented and the design justification for that restriction. Any restriction is a risk. / 玩家必须能够在任何游戏玩法状态期间暂停，包括过场动画、对话和教程序列。记录当前阻止暂停的任何状态以及该限制的设计理由。任何限制都是风险。 |
| Tutorial persistence / 教程持久性 | Standard / 标准 | All tutorials and help text / 所有教程和帮助文本 | Not Started / 未开始 | After dismissing a tutorial prompt, the player must be able to retrieve it from a Help section in the menu. Do not rely on players absorbing tutorials on first encounter — AbleGamers research shows many players dismiss prompts on reflex. / 在关闭教程提示后，玩家必须能够从菜单的帮助部分检索它。不要依赖玩家在第一次遇到时吸收教程——AbleGamers研究表明许多玩家反射性地关闭提示。 |
| Quest / objective clarity / 任务/目标清晰度 | Standard / 标准 | Quest and objective systems / 任务和目标系统 | Not Started / 未开始 | The current active objective must be accessible within 2 button presses at all times during gameplay. Display the full objective text on demand, not just a truncated marker. Avoid objectives that require inference ("investigate the northern region" — where exactly?). / 当前活动目标必须始终在游戏玩法期间2次按钮按压内可访问。按需显示完整的目标文本，而不仅仅是截断的标记。避免需要推理的目标（"调查北部地区"——具体在哪里？）。 |
| Visual indicators for audio-only information / 纯音频信息的视觉指示器 | Standard / 标准 | All SFX that carry gameplay information / 所有携带游戏玩法信息的音效 | Not Started / 未开始 | Audit every sound effect that communicates gameplay-critical state. For each: is there a visual equivalent? Directional audio (off-screen enemy) needs a screen-edge indicator. Critical warnings (boss phase transition, trap trigger) need visual cues. See Auditory Accessibility for full list. / 审核每个传达游戏玩法关键状态的声音效果。对每个：有视觉等价物吗？方向性音频（屏幕外敌人）需要屏幕边缘指示器。关键警告（Boss阶段转换、陷阱触发）需要视觉提示。查看听觉无障碍以获取完整列表。 |
| Reading time for UI / 界面阅读时间 | Standard / 标准 | All auto-dismissing dialogs / 所有自动关闭对话框 | Not Started / 未开始 | No dialog, notification, or tooltip that contains actionable information may auto-dismiss in less than 5 seconds. Preferred: do not auto-dismiss at all — require player confirmation. Document every auto-dismissing element here and its current duration. / 包含可操作信息的任何对话框、通知或工具提示不得在少于5秒内自动关闭。首选：完全不自动关闭——需要玩家确认。在此记录每个自动关闭元素及其当前持续时间。 |
| Cognitive load documentation / 认知负荷文档 | Comprehensive / 全面 | Per game system / 每个游戏系统 | Not Started / 未开始 | For each system in systems-index.md, document the maximum number of things it asks the player to simultaneously track. Flag any system where the number exceeds 4. This is not a hard rule but a review trigger — high cognitive load systems need compensating UI clarity. See Per-Feature Accessibility Matrix below. / 对于systems-index.md中的每个系统，记录它要求玩家同时跟踪的最大数量。标记任何数量超过4的系统。这不是硬性规则而是审查触发器——高认知负荷系统需要补偿界面清晰度。查看下面的按功能无障碍矩阵。 |
| Navigation assists / 导航辅助 | Standard / 标准 | World navigation / 世界导航 | Not Started / 未开始 | Fast travel (to previously visited locations), waypoint system for current objective, optional objective indicator always visible. Document which of these apply to this game's design and which are intentionally omitted. / 快速旅行（到之前访问过的位置）、当前目标的路点系统、始终可见的可选目标指示器。记录哪些适用于此游戏设计，哪些是有意省略的。 |

---

## Auditory Accessibility / 听觉无障碍

> **Why auditory accessibility matters even for players without hearing loss**: / **为什么听觉无障碍对无听力损失的玩家也重要**：
> 7% of players are deaf or hard of hearing. Additionally, a large portion of / 7%的玩家是聋人或听力障碍。此外，很大一部分
> players regularly play in environments where audio is reduced or absent (commute, / 玩家经常在音频减少或缺失的环境中玩（通勤、
> shared household, infant sleeping). Any gameplay-critical information delivered / 共享家庭、婴儿睡觉）。任何仅通过音频传递的
> only through audio is a design failure even before accessibility is considered. / 游戏玩法关键信息甚至在不考虑无障碍之前就是设计失败。
> The guiding principle: every sound that changes what the player should DO next / 指导原则：每个改变玩家下一步应该做什么的声音
> must have a visual equivalent. / 必须有视觉等价物。

| Feature / 功能 | Target Tier / 目标层级 | Scope / 范围 | Status / 状态 | Implementation Notes / 实现说明 |
|---------|-------------|-------|--------|---------------------|
| Subtitles for all spoken dialogue / 所有口语对话的字幕 | Basic / 基础 | All voiced content / 所有语音内容 | Not Started / 未开始 | 100% coverage — no exceptions. Include narration, in-engine dialogue, radio/environmental dialogue heard from a distance. Test subtitle sync against voice acting timing. / 100%覆盖——无例外。包括旁白、引擎内对话、从远处听到的无线电/环境对话。根据配音时间测试字幕同步。 |
| Closed captions for gameplay-critical SFX / 游戏玩法关键音效的闭合字幕 | Comprehensive / 全面 | Identified SFX list (below) / 识别的音效列表（下面） | Not Started / 未开始 | Not all SFX need captions — only those that communicate state the player cannot infer visually. See the SFX audit table below. / 并非所有音效都需要字幕——只有那些传达玩家无法视觉推断的状态的音效。查看下面的音效审核表。 |
| Mono audio option / 单声道音频选项 | Comprehensive / 全面 | Global audio output / 全局音频输出 | Not Started / 未开始 | Folds stereo/spatial audio to mono. Preserves volume balance between channels rather than summing to full volume on both sides. Essential for players with single-sided deafness. / 将立体声/空间音频折叠到单声道。保持通道间的音量平衡，而不是在两侧求和到全音量。对于单侧耳聋玩家至关重要。 |
| Independent volume controls / 独立音量控制 | Basic / 基础 | Music / SFX / Voice / UI audio buses / 音乐/音效/语音/界面音频总线 | Not Started / 未开始 | Four independent sliders minimum. Persist to player profile. Range: 0–100%, default 80%. Expose in both main settings and the pause menu. / 至少四个独立滑块。保存到玩家配置文件。范围：0–100%，默认80%。在主设置和暂停菜单中都公开。 |
| Visual representations for directional audio / 方向性音频的视觉表示 | Comprehensive / 全面 | All off-screen threats and audio events / 所有屏幕外威胁和音频事件 | Not Started / 未开始 | Screen-edge indicator pointing toward the audio source. Opacity scales with audio volume (closer = more opaque). Two variants: threat indicators (red) and information indicators (neutral). Example: The Last of Us Part II uses screen-edge indicators for off-screen enemy positions. / 指向音频源的屏幕边缘指示器。不透明度随音频音量缩放（越近越不透明）。两种变体：威胁指示器（红色）和信息指示器（中性）。示例：《最后生还者 第二部》使用屏幕边缘指示器表示屏幕外敌人位置。 |
| Hearing aid compatibility mode / 助听器兼容模式 | Standard / 标准 | High-frequency audio cues / 高频音频提示 | Not Started / 未开始 | Audit all audio cues for frequency range. Any cue that communicates critical information only through high-frequency sound (above 4kHz) must have a low-frequency or visual equivalent. Hearing aids often filter high frequencies. / 审核所有音频提示的频率范围。任何仅通过高频声音（高于4kHz）传达关键信息的提示必须有低频或视觉等价物。助听器通常过滤高频。 |

### Gameplay-Critical SFX Audit / 游戏玩法关键音效审核

> Identify every sound effect that communicates state the player needs to act on. / 识别每个传达玩家需要采取行动状态的声音效果。
> Each entry in this table requires either a confirmed visual backup or a caption. / 此表中的每个条目需要确认的视觉备份或字幕。

| Sound Effect / 音效 | What It Communicates / 传达什么 | Visual Backup / 视觉备份 | Caption Required / 需要字幕 | Status / 状态 |
|-------------|---------------------|--------------|-----------------|--------|
| [Enemy attack windup sound] / [敌人攻击准备声音] | [Incoming damage — player should dodge] / [即将受到的伤害 — 玩家应该躲避] | [Enemy animation telegraph visible from all camera angles] / [从所有相机角度可见的敌人动画预兆] | [No — visual is sufficient] / [否 — 视觉已足够] | [Not Started] / [未开始] |
| [Trap trigger click] / [陷阱触发点击声] | [Trap is about to fire] / [陷阱即将触发] | [Not always visible depending on camera angle] / [不总是可见，取决于相机角度] | [Yes — "[CLICK]" caption with directional indicator] / [是 — 带有方向指示器的"[CLICK]"字幕] | [Not Started] / [未开始] |
| [Low health heartbeat] / [低生命值心跳声] | [Player health critical] / [玩家生命值关键] | [Health bar also shows critical state visually] / [血条也视觉显示关键状态] | [No — visual is sufficient] / [否 — 视觉已足够] | [Not Started] / [未开始] |
| [Quest completion chime] / [任务完成提示音] | [Objective completed] / [目标完成] | [Quest tracker updates visually] / [任务追踪器视觉更新] | [No — visual is sufficient] / [否 — 视觉已足够] | [Not Started] / [未开始] |
| [Add each SFX that changes what the player should do] / [添加每个改变玩家应该做什么的音效] | | | | |

---

## Platform Accessibility API Integration / 平台无障碍API集成

> **Why this section exists**: Each platform provides native accessibility APIs / **为什么存在此部分**：每个平台提供原生无障碍API，
> that, when used, allow OS-level features (system screen readers, display / 使用时允许操作系统级功能（系统屏幕阅读器、显示
> accommodations, motor accessibility services) to work with your game. Ignoring / 调节、运动无障碍服务）与您的游戏一起工作。忽略
> these APIs does not break the game, but it means players who rely on OS-level / 这些API不会破坏游戏，但意味着依赖操作系统级
> accessibility tools get no benefit from them inside your game. Xbox in particular / 无障碍工具的玩家在您的游戏中得不到任何好处。特别是Xbox
> requires XAG compliance for certification. Verify platform requirements before / 要求符合XAG才能认证。在承诺层级之前验证平台要求——
> committing to a tier — platform requirements set a floor, not a ceiling. / 平台要求设定了底线，而不是天花板。

| Platform / 平台 | API / Standard / API / 标准 | Features Planned / 计划的功能 | Status / 状态 | Notes / 说明 |
|----------|---------------|-----------------|--------|-------|
| Xbox (GDK) | Xbox Game Core Accessibility / XAG / Xbox游戏核心无障碍 / XAG | [Input remapping via Xbox Ease of Access, high contrast support, narrator integration for menus] / [通过Xbox易用性输入重映射、高对比度支持、菜单叙述器集成] | Not Started / 未开始 | XAG compliance is required for ID@Xbox Game Pass consideration. Review XAG checklist at https://docs.microsoft.com/gaming/accessibility/guidelines / ID@Xbox Game Pass考虑需要符合XAG。在https://docs.microsoft.com/gaming/accessibility/guidelines查看XAG检查清单 |
| PlayStation 5 | Sony Accessibility Guidelines / AccessibilityNode API / 索尼无障碍指南 / AccessibilityNode API | [Screen reader passthrough for menus, mono audio, high contrast] / [菜单的屏幕阅读器透传、单声道音频、高对比度] | Not Started / 未开始 | PS5 natively supports system-level audio description and mono audio if the game exposes AccessibilityNode data on UI elements. / 如果游戏在界面元素上公开AccessibilityNode数据，PS5原生支持系统级音频描述和单声道音频。 |
| Steam (PC) | Steam Accessibility Features / SDL / Steam无障碍功能 / SDL | [Controller input remapping via Steam Input, subtitle support] / [通过Steam Input的控制器输入重映射、字幕支持] | Not Started / 未开始 | Steam Input allows system-level remapping independent of in-game remapping. In-game remapping still required for keyboard/mouse. / Steam Input允许独立于游戏内重映射的系统级重映射。键盘/鼠标仍需要游戏内重映射。 |
| iOS | UIAccessibility / VoiceOver | [VoiceOver support for menus if mobile port planned] / [如果计划移动端移植，菜单的VoiceOver支持] | N/A / 不适用 | Only required if mobile release is in scope. / 仅当移动端发布在范围内时需要。 |
| Android | AccessibilityService / TalkBack | [TalkBack support for menus if mobile port planned] / [如果计划移动端移植，菜单的TalkBack支持] | N/A / 不适用 | Only required if mobile release is in scope. / 仅当移动端发布在范围内时需要。 |
| PC (Screen Reader) | JAWS / NVDA / Windows Narrator | [Menu navigation announcements] / [菜单导航通告] | Not Started / 未开始 | Requires UI elements to expose accessible names and roles via platform UI layer. Godot 4.5+ AccessKit integration covers this for supported control types. Verify against engine-reference/godot/ docs. / 需要界面元素通过平台界面层公开可访问名称和角色。Godot 4.5+ AccessKit集成涵盖了支持的控件类型。对照engine-reference/godot/文档验证。 |

---

## Per-Feature Accessibility Matrix / 按功能无障碍矩阵

> **Why this matrix exists**: Accessibility is not a list of settings — it is a / **为什么存在此矩阵**：无障碍不是设置列表——它是
> property of every game system. This matrix creates the "accessibility impact" / 每个游戏系统的属性。此矩阵创建游戏的"无障碍影响"
> view of the game: which systems have which barriers, and whether those barriers / 视图：哪些系统有哪些障碍，以及这些障碍
> are addressed. When a new system is added to systems-index.md, a row must be / 是否得到解决。当新系统添加到systems-index.md时，必须添加一行
> added here. If a system has an unaddressed accessibility concern, it cannot be / 到这里。如果系统有未解决的无障碍问题，不能
> marked Approved in the systems index. / 在系统索引中标记为已批准。

| System / 系统 | Visual Concerns / 视觉问题 | Motor Concerns / 运动问题 | Cognitive Concerns / 认知问题 | Auditory Concerns / 听觉问题 | Addressed / 已解决 | Notes / 说明 |
|--------|----------------|---------------|-------------------|------------------|-----------|-------|
| [Combat System] / [战斗系统] | [Enemy health bars are color-coded; attack animations may cause motion sickness] / [敌人血条颜色编码；攻击动画可能导致晕动症] | [Rapid input required for combos; hold inputs for guard] / [连击需要快速输入；防御需要长按输入] | [Track enemy patterns + cooldowns + player resources simultaneously] / [同时跟踪敌人模式+冷却时间+玩家资源] | [Audio cues for off-screen attacks; critical damage warning sounds] / [屏幕外攻击的音频提示；关键伤害警告声音] | [Partial] / [部分] | [Colorblind palette applied; hold-to-block toggle needed] / [已应用色盲调色板；需要按住防御切换] |
| [Inventory / Equipment] / [库存/装备] | [Item rarity conveyed by border color] / [物品稀有度通过边框颜色传达] | [No motor concerns — turn-based] / [无运动问题 — 回合制] | [Item stats comparison requires reading multiple values] / [物品属性比较需要阅读多个数值] | [None — no critical audio in this system] / [无 — 此系统无关键音频] | [Partial] / [部分] | [Non-color rarity indicators in progress] / [非颜色稀有度指示器进行中] |
| [Dialogue System] / [对话系统] | [Subtitle display depends on contrast settings] / [字幕显示取决于对比度设置] | [No motor concerns] / [无运动问题] | [Long dialogue trees with time pressure on dialogue choices] / [对话树长，对话选择有时间压力] | [All dialogue must be subtitled] / [所有对话必须有字幕] | [Not Started] / [未开始] | [Timed dialogue choices must support extended timer option] / [定时对话选择必须支持扩展计时器选项] |
| [Navigation / World Map] / [导航/世界地图] | [Map marker colors] / [地图标记颜色] | [No motor concerns] / [无运动问题] | [Quest objective clarity; waypoint visibility] / [任务目标清晰度；路点可见性] | [Audio pings for objectives have no visual equivalent] / [目标的音频提示无视觉等价物] | [Not Started] / [未开始] | |
| [Add system from systems-index.md] / [从systems-index.md添加系统] | | | | | | |

---

## Accessibility Test Plan / 无障碍测试计划

> **Why testing accessibility separately from QA**: Standard QA tests whether / **为什么单独测试无障碍与QA不同**：标准QA测试
> features work. Accessibility testing tests whether features work for players / 功能是否工作。无障碍测试测试功能对于
> who use them. These are different tests. A subtitle system can pass QA (it / 使用它们的玩家是否工作。这些是不同的测试。一个字幕系统可以通过QA（它
> displays text) and fail accessibility testing (the text is unreadable at TV / 显示文本）但无法通过无障碍测试（文本在电视距离下
> distance by a player with low vision). Plan for three test types: automated / 对于低视力玩家不可读）。计划三种测试类型：自动化
> (contrast ratios, text sizes), manual internal (team members simulating / （对比度比率、文本大小）、手动内部（团队成员模拟
> impairments using accessibility simulators), and user testing (players who / 使用无障碍模拟器障碍）和用户测试（实际使用这些功能的玩家）。
> actually use these features).

| Feature / 功能 | Test Method / 测试方法 | Test Cases / 测试用例 | Pass Criteria / 通过标准 | Responsible / 负责人 | Status / 状态 |
|---------|------------|------------|--------------|-------------|--------|
| Text contrast ratios / 文本对比度比率 | Automated — contrast analyzer tool on all UI screenshots / 自动化 — 所有界面截图的对比度分析器工具 | All text/background combinations at all game states / 所有游戏状态下所有文本/背景组合 | All body text ≥ 4.5:1; all large text ≥ 3:1; subtitle backgrounds ≥ 7:1 / 所有正文文本 ≥ 4.5:1；所有大文本 ≥ 3:1；字幕背景 ≥ 7:1 | ux-designer / ux-designer | Not Started / 未开始 |
| Colorblind modes / 色盲模式 | Manual — Coblis simulator on all game screenshots with modes enabled / 手动 — 启用模式的所有游戏屏幕截图的Coblis模拟器 | Gameplay screenshots in exploration, combat, inventory in each mode / 每种模式下探索、战斗、库存的游戏玩法截图 | No essential information is lost in any mode; player can complete all objectives without color discrimination / 在任何模式下没有丢失重要信息；玩家可以在没有颜色区分的情况下完成所有目标 | ux-designer / ux-designer | Not Started / 未开始 |
| Input remapping / 输入重映射 | Manual — remap all inputs to non-default bindings, complete tutorial and first level / 手动 — 将所有输入重新绑定到非默认绑定，完成教程和第一关 | All default inputs rebound; gameplay functions correctly; no binding conflict possible / 所有默认输入重新绑定；游戏玩法功能正确；无绑定冲突可能 | All actions accessible after remapping; conflict prevention works; bindings persist across restart / 重映射后所有动作可访问；冲突预防有效；绑定在重启后持久保存 | qa-tester / qa-tester | Not Started / 未开始 |
| Subtitle accuracy / 字幕准确性 | Manual — verify against voice script, check all lines / 手动 — 对照语音脚本验证，检查所有台词 | All voiced content; subtitle timing; speaker identification / 所有语音内容；字幕定时；说话者标识 | 100% of voiced lines subtitled; speaker identified for all multi-character scenes; no subtitle display for more than 3 seconds after line ends / 100%语音行有字幕；所有多角色场景识别说话者；台词结束后字幕显示不超过3秒 | qa-tester / qa-tester | Not Started / 未开始 |
| Hold input toggles / 长按输入切换 | Manual — enable all toggle alternatives, complete all combat and traversal sequences / 手动 — 启用所有切换替代方案，完成所有战斗和穿越序列 | All hold inputs in toggle mode / 切换模式下的所有长按输入 | All hold actions completable in toggle mode; no gameplay state requires sustained hold when toggle is enabled / 切换模式下所有长按动作可完成；启用切换时没有游戏玩法状态需要持续按住 | qa-tester / qa-tester | Not Started / 未开始 |
| Reduced motion mode / 减少运动模式 | Manual — enable mode, navigate all menus and complete first hour of gameplay / 手动 — 启用模式，导航所有菜单并完成游戏第一小时 | All menu transitions; all HUD animations; all camera shake events / 所有菜单过渡；所有HUD动画；所有相机抖动事件 | No looping animations in menus; no camera shake above threshold; all screen transitions are cross-fade or cut / 菜单中无循环动画；无超过阈值的相机抖动；所有屏幕过渡是交叉淡入淡出或剪切 | ux-designer / ux-designer | Not Started / 未开始 |
| Platform screen reader (menu) / 平台屏幕阅读器（菜单） | Manual — enable OS screen reader, navigate all menus / 手动 — 启用操作系统屏幕阅读器，导航所有菜单 | Main menu, settings, pause menu, inventory, map / 主菜单、设置、暂停菜单、库存、地图 | All interactive menu elements have screen reader announcements; navigation order is logical; no element unreachable by keyboard/D-pad / 所有交互式菜单元素有屏幕阅读器通告；导航顺序逻辑合理；没有键盘/D-pad无法到达的元素 | ux-designer / ux-designer | Not Started / 未开始 |
| User testing — colorblind / 用户测试 — 色盲 | User testing with colorblind participants / 与色盲参与者的用户测试 | Full game session with each colorblind mode / 每种色盲模式的完整游戏会话 | Participants complete all content without requesting color clarification; no session-stopping confusion / 参与者完成所有内容而不请求颜色澄清；无会话停止的混淆 | producer / producer | Not Started / 未开始 |
| User testing — motor impairment / 用户测试 — 运动障碍 | User testing with participants using one hand or adaptive controllers / 与使用单手或自适应控制器的参与者的用户测试 | Full game session with toggle and extended timing modes enabled / 启用切换和扩展定时模式的完整游戏会话 | Participants complete all MVP content within tolerance of able-bodied completion time / 参与者在健全完成时间容差内完成所有MVP内容 | producer / producer | Not Started / 未开始 |

---

## Known Intentional Limitations / 已知故意限制

> **Why document what is NOT included**: Omissions left undocumented become / **为什么记录不包含什么**：未记录的遗漏
> surprises at certification or in community feedback. Documenting a limitation / 在认证或社区反馈中成为惊喜。记录限制
> with a rationale demonstrates that it was a deliberate choice, not an oversight. / 及其理由表明这是深思熟虑的选择，而不是疏忽。
> It also identifies which players are not served and what the mitigation is. / 它还识别哪些玩家未被服务以及缓解措施是什么。
> Every entry here is a risk — assess it honestly. / 此处的每个条目都是风险——诚实地评估它。

| Feature / 功能 | Tier Required / 需要层级 | Why Not Included / 为什么不包含 | Risk / Impact / 风险/影响 | Mitigation / 缓解措施 |
|---------|--------------|-----------------|--------------|------------|
| [Screen reader support for in-game world (NPCs, objects, environmental text)] / [游戏世界（NPC、对象、环境文本）的屏幕阅读器支持] | Exemplary / 典范 | Engine (Godot 4.6) AccessKit integration covers menus only; extending to the game world requires a custom spatial audio description system beyond current scope / 引擎（Godot 4.6）AccessKit集成仅覆盖菜单；扩展到游戏世界需要超出当前范围的自定义空间音频描述系统 | Affects blind and low-vision players who can navigate menus but cannot independently explore the game world / 影响可以导航菜单但不能独立探索游戏世界的盲人和低视力玩家 | Ensure all critical world information is duplicated in accessible menu systems (quest log, map); evaluate for post-launch DLC / 确保所有关键世界信息在无障碍菜单系统（任务日志、地图）中复制；评估用于发布后DLC |
| [Full subtitle customization (font/color/background)] / [完整字幕自定义（字体/颜色/背景）] | Comprehensive / 全面 | Scope reduction — targeting Standard tier. Custom font rendering in Godot requires additional asset pipeline work / 范围缩减 — 目标标准层级。Godot中的自定义字体渲染需要额外的资产管道工作 | Affects deaf and hard-of-hearing players with specific legibility needs; particularly affects players with dyslexia who use custom fonts / 影响有特定可读性需求的聋人和听力障碍玩家；特别影响使用自定义字体的阅读障碍玩家 | Provide two preset subtitle styles (default and high-readability) as a partial mitigation; log for post-launch update / 提供两种预设字幕样式（默认和高可读性）作为部分缓解；记录用于发布后更新 |
| [Tactile/haptic alternatives for all audio cues] / [所有音频提示的触觉/震动替代方案] | Exemplary / 典范 | Platform rumble API integration for non-Xbox platforms is out of scope for v1.0 / 非Xbox平台的平台震动API集成超出v1.0范围 | Affects deaf players relying on haptic feedback; PC players with non-Xbox controllers get no haptic response / 影响依赖触觉反馈的聋人玩家；使用非Xbox控制器的PC玩家没有触觉响应 | Xbox controller haptic integration is in scope; evaluate PlayStation DualSense haptic API for a post-launch patch / Xbox控制器触觉集成在范围内；评估PlayStation DualSense触觉API用于发布后补丁 |
| [Add any other intentionally excluded accessibility feature] / [添加任何其他故意排除的无障碍功能] | | | | |

---

## Audit History / 审核历史

> **Why track audit history**: Accessibility is not certified once and done. / **为什么跟踪审核历史**：无障碍不是一次认证就完成。
> Platform requirements change. New features may introduce new barriers. Legal / 平台要求变化。新功能可能引入新障碍。法律
> standards evolve. An audit history demonstrates due diligence and helps identify / 标准发展。审核历史展示尽职调查并帮助识别
> regressions between audits. / 审核间的回归。

| Date / 日期 | Auditor / 审核员 | Type / 类型 | Scope / 范围 | Findings Summary / 发现摘要 | Status / 状态 |
|------|---------|------|-------|-----------------|--------|
| [Date] / [日期] | [Internal — ux-designer] / [内部 — ux-designer] | Internal review / 内部审查 | [Pre-submission checklist against committed tier] / [针对承诺层级的提交前检查清单] | [e.g., "12 items verified, 3 open issues: subtitle contrast below target in 2 scenes, color-only indicator on minimap not resolved"] / [例如，"12个项目已验证，3个未解决问题：2个场景中字幕对比度低于目标，小地图上颜色唯一指示器未解决"] | [In Progress] / [进行中] |
| [Date] / [日期] | [External — AbleGamers Player Panel] / [外部 — AbleGamers玩家面板] | User testing / 用户测试 | [Motor accessibility — one-hand mode and timing adjustments] / [运动无障碍 — 单手模式和定时调整] | [e.g., "Toggle modes functional. Timed QTE window at 3x still failed for one participant — recommend 5x option."] / [例如，"切换模式功能正常。3倍定时QTE窗口仍有一个参与者失败 — 推荐5倍选项。"] | [Findings addressed] / [发现已解决] |
| [Add row for each audit] / [为每个审核添加行] | | | | | |

---

## External Resources / 外部资源

| Resource / 资源 | URL | Relevance / 相关性 |
|----------|-----|-----------|
| WCAG 2.1 (Web Content Accessibility Guidelines) / WCAG 2.1（网页内容无障碍指南） | https://www.w3.org/TR/WCAG21/ | Foundational accessibility standard — contrast ratios, text sizing, input requirements / 基础无障碍标准 — 对比度比率、文本大小、输入要求 |
| Game Accessibility Guidelines / 游戏无障碍指南 | https://gameaccessibilityguidelines.com | Comprehensive game-specific checklist organized by category and cost / 全面的游戏特定检查清单，按类别和成本组织 |
| AbleGamers Player Panel / AbleGamers玩家面板 | https://ablegamers.org/player-panel/ | User testing service and consulting with disabled gamers / 用户测试服务和与残疾玩家咨询 |
| Xbox Accessibility Guidelines (XAG) / Xbox无障碍指南 (XAG) | https://docs.microsoft.com/gaming/accessibility/guidelines | Required reading for Xbox certification; well-structured feature checklist / Xbox认证必读；结构良好的功能检查清单 |
| PlayStation Accessibility Guidelines / PlayStation无障碍指南 | https://www.playstation.com/en-us/accessibility/ | Sony platform requirements; also contains well-written design guidance / 索尼平台要求；也包含编写良好的设计指南 |
| Colour Blindness Simulator (Coblis) / 色盲模拟器 (Coblis) | https://www.color-blindness.com/coblis-color-blindness-simulator/ | Free tool for simulating colorblind modes on screenshots / 模拟截图上色盲模式的免费工具 |
| Accessible Games Database / 无障碍游戏数据库 | https://accessible.games | Research and examples of accessible game design decisions / 无障碍游戏设计决策的研究和示例 |
| CVAA (21st Century Communications and Video Accessibility Act) / CVAA（21世纪通信和视频无障碍法案） | https://www.fcc.gov/consumers/guides/21st-century-communications-and-video-accessibility-act-cvaa | US legal requirement for games with communication features (voice chat, messaging) / 美国对有通信功能（语音聊天、消息）的游戏的法律要求 |

---

## Open Questions / 开放问题

| Question / 问题 | Owner / 负责人 | Deadline / 截止日期 | Resolution / 解决方案 |
|----------|-------|----------|-----------|
| [Does Godot 4.6 AccessKit support dynamic accessibility node updates for HUD elements, or only static menus?] / [Godot 4.6 AccessKit支持HUD元素的动态无障碍节点更新，还是仅支持静态菜单？] | [ux-designer] / [ux-designer] | [Before Technical Setup gate] / [技术设置门限前] | [Unresolved — check engine-reference/godot/ docs] / [未解决 — 检查engine-reference/godot/文档] |
| [What is the Xbox ID@Xbox minimum XAG compliance requirement for our release window?] / [对于我们的发布窗口，Xbox ID@Xbox最低XAG合规要求是什么？] | [producer] / [producer] | [Before Pre-Production gate] / [预制作门限前] | [Unresolved] / [未解决] |
| [Will the dialogue system support timed choice extensions without a full architecture change?] / [对话系统是否支持定时选择扩展而不需要完整的架构更改？] | [lead-programmer] / [lead-programmer] | [During Technical Design] / [技术设计期间] | [Unresolved] / [未解决] |
| [Add question] / [添加问题] | [Owner] / [负责人] | [Deadline] / [截止日期] | [Resolution] / [解决方案] |