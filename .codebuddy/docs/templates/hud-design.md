# HUD Design: [Game Name] / HUD 设计：[游戏名称]

> **Status**: Draft | In Review | Approved | Implemented / **状态**: 草案 | 评审中 | 已批准 | 已实现
> **Author**: [Name or agent — e.g., ui-designer] / **作者**: [姓名或代理 — 例如：ui-designer]
> **Last Updated**: [Date] / **最后更新**: [日期]
> **Game**: [Game name — this is a single document per game, not per element] / **游戏**: [游戏名称 — 这是每个游戏一份文档，而不是每个元素一份]
> **Platform Targets**: [All platforms this HUD must work on — e.g., PC, PS5, Xbox Series X, Steam Deck] / **目标平台**: [所有HUD必须在此工作的平台 — 例如：PC、PS5、Xbox Series X、Steam Deck]
> **Related GDDs**: [Every system that exposes information through the HUD — e.g., `design/gdd/combat.md`, `design/gdd/progression.md`, `design/gdd/quests.md`] / **相关GDD**: [每个通过HUD暴露信息的系统 — 例如：`design/gdd/combat.md`、`design/gdd/progression.md`、`design/gdd/quests.md`]
> **Accessibility Tier**: Basic | Standard | Comprehensive | Exemplary / **无障碍层级**: 基础 | 标准 | 全面 | 典范
> **Style Reference**: [Link to art bible HUD section if it exists — e.g., `design/gdd/art-bible.md § HUD Visual Language`] / **风格参考**: [美术圣经HUD章节的链接(如果存在) — 例如：`design/gdd/art-bible.md § HUD视觉语言`]

> **Note — Scope boundary**: This document specifies all elements that overlay the
> game world during active gameplay — health bars, ammo counters, minimaps, quest
> trackers, subtitles, damage numbers, and notification toasts. For menu screens,
> pause menus, inventory, and dialogs that the player navigates explicitly, use
> `ux-spec.md` instead. The test: if it appears while the player is directly
> controlling their character, it belongs here. / **注意 — 范围边界**: 本文档指定了在活跃游戏玩法期间覆盖游戏世界的所有元素——血条、弹药计数、小地图、任务追踪器、字幕、伤害数字和通知提示。对于玩家明确导航的菜单屏幕、暂停菜单、背包和对话框，请使用 `ux-spec.md`。测试方法：如果它在玩家直接控制角色时出现，它就属于这里。

---

<!-- 中文翻译 -->
## 1. HUD Philosophy / 1. HUD设计哲学

> **Why this section exists**: The HUD design philosophy is not decoration — it is a
> design constraint that every subsequent decision is measured against. Without a
> philosophy, individual elements get added on request ("the quest tracker wants a
> bigger icon") without any principled way to push back. With a philosophy, there is
> a shared, explicit standard. More importantly, the philosophy prevents the HUD from
> slowly growing to cover the game world while each individual addition seemed
> reasonable in isolation. Write this before specifying any elements. / **为什么存在此章节**: HUD设计哲学不是装饰——它是每个后续决策都要参照的设计约束。没有哲学，各个元素会被应请求添加（"任务追踪器想要更大的图标"），而没有任何原则性的方式拒绝。有了哲学，就有了共享的、明确的标准。更重要的是，哲学防止HUD慢慢增长到覆盖整个游戏世界，而每一次单独添加在孤立看时似乎都合情合理。在指定任何元素之前先写这个。

**What is this game's relationship with on-screen information?** / **这个游戏与屏幕信息的关系是什么？**

[One paragraph. This is a design statement, not a description of features. Consider
the game's genre, pacing, and player fantasy. / [一段话。这是设计陈述，而非功能描述。考虑游戏的类型、节奏和玩家幻想。

Reference comparable games if helpful, but describe your specific stance: / 如有帮助可参考类似游戏，但描述你具体的立场：
Example — diegetic-first action RPG: "We treat screen information as a concession,
not a feature. Every HUD element must earn its pixel space by answering the question:
would the player make demonstrably worse decisions without this information visible?
If the answer is 'they'd adapt,' we put it in the environment instead." / 示例——内叙优先动作RPG："我们将屏幕信息视为一种让步，而非功能。每个HUD元素必须通过回答问题来赢得其像素空间：没有这些信息可见，玩家是否会做出明显更差的决策？如果答案是'他们会适应'，我们就把信息放在环境中。"]

**Visibility principle** — when in doubt, show or hide? / **可见性原则** — 有疑问时，显示还是隐藏？

[State the default resolution for ambiguous cases. Options:
- Default to HIDE: information is available on demand (e.g., Dark Souls — no quest tracker, no minimap, stats are in a menu)
- Default to SHOW: players prefer to be informed; cluttered is better than uncertain
- Default to CONTEXTUAL: information appears when it becomes relevant and fades when it does not
Most games benefit from contextual defaults. State your game's default clearly so every element decision is consistent.] / [陈述模糊情况下的默认解决方案。选项：
- 默认隐藏：信息按需提供（例如：黑暗之魂——没有任务追踪、没有小地图、数据在菜单中）
- 默认显示：玩家偏好掌握信息；杂乱总比不确定好
- 默认上下文：信息在相关时出现，不相关时淡出
大多数游戏受益于上下文默认。清晰地陈述游戏的默认值，使每个元素的决策都保持一致。]

**The Rule of Necessity for this game**: / **必要性规则**:

[Complete this sentence: "A HUD element earns its place when ______________." / [完成这句话："一个HUD元素赢得其位置，当______________。"

This rule is the veto power over feature requests to add HUD elements. Document it
so it can be cited in design reviews.] / 这条规则是添加HUD元素的功能请求的否决权。记录下来，以便可以在设计评审中引用。]

---

<!-- 中文翻译 -->
## 2. Information Architecture / 2. 信息架构

> **Why this section exists**: Before specifying any HUD element's visual design,
> position, or behavior, you must answer a more fundamental question: should this
> information be on the HUD at all? This section is a forcing function — it requires
> you to categorize EVERY piece of information the game world generates and make an
> explicit, intentional decision about how each is presented. "We'll figure that out
> later" is how games end up with 18 elements competing for the player's peripheral
> vision. This table is the master inventory of game information, not just HUD information. / **为什么存在此章节**: 在指定HUD元素之前，你必须回答一个更根本的问题：这些信息应该出现在HUD上吗？本章节是一个强制功能——要求你对游戏世界产生的每一份信息进行分类，并对每份信息的呈现方式做出明确、有意的决定。

| Information Type / 信息类型 | Always Show / 始终显示 | Contextual (show when relevant) / 情境显示（相关时显示） | On Demand (menu/button) / 按需显示（菜单/按钮） | Hidden (environmental / diegetic) / 隐藏（环境化/叙事化） | Reasoning / 理由 |
|---------------------|-------------|--------------------------------|------------------------|----------------------------------|-----------|
| [Health / Vitality / 生命值/活力] | [X if action game — player needs constant awareness / 若为动作游戏则显示X——玩家需要持续感知] | [X if exploration game — show only when injured / 若为探索游戏则显示X——仅在受伤时显示] | [ ] | [ ] | [Example: always visible because health decisions (retreat, heal) must be instant in combat / 示例：始终可见，因为生命值决策（撤退、治疗）必须在战斗中即时做出] |
| [Primary resource (mana / stamina / ammo) / 主要资源（法力/体力/弹药）] | [ ] | [X — show when resource is being consumed or is critically low / X——在资源被消耗或严重不足时显示] | [ ] | [ ] | [Example: contextual because stable resource levels are not decision-relevant / 示例：情境显示，因为稳定的资源水平与决策无关] |
| [Secondary resource (currency / materials) / 次要资源（货币/材料）] | [ ] | [ ] | [X — check in inventory / X——在库存中查看] | [ ] | [Example: on-demand because resource totals don't affect immediate gameplay decisions / 示例：按需显示，因为资源总量不影响即时游戏决策] |
| [Minimap / Compass / 小地图/指南针] | [X] | [ ] | [ ] | [ ] | [Example: always visible because navigation decisions are constant during exploration / 示例：始终可见，因为探索过程中导航决策是持续的] |
| [Quest objective / 任务目标] | [ ] | [X — show when objective changes or player is near it / X——当目标改变或玩家接近时显示] | [ ] | [ ] | [Example: contextual — player knows their objective; only remind at key moments / 示例：情境显示——玩家知道自己的目标；仅在关键时刻提醒] |
| [Enemy health bar / 敌人血条] | [ ] | [X — show only during combat encounters / X——仅在战斗遭遇期间显示] | [ ] | [ ] | [Example: contextual because enemy health is irrelevant outside combat / 示例：情境显示，因为敌人生命值在战斗外无关紧要] |
| [Status effects (buffs/debuffs) / 状态效果（增益/减益）] | [ ] | [X — show when active / X——激活时显示] | [ ] | [ ] | [Example: contextual because status effects only affect decisions when present / 示例：情境显示，因为状态效果仅在存在时影响决策] |
| [Dialogue subtitles / 对话字幕] | [X when dialogue is playing / 对话播放时显示X] | [ ] | [ ] | [ ] | [Example: always show while dialogue is active — accessibility requirement / 示例：对话激活时始终显示——无障碍需求] |
| [Combo / streak counter / 连击/连击计数器] | [ ] | [X — show while combo is active, hide on reset / X——连击激活时显示，重置时隐藏] | [ ] | [ ] | [Example: contextual because it communicates active performance, not baseline state / 示例：情境显示，因为它传达的是活跃表现，而非基线状态] |
| [Timer / 计时器] | [ ] | [X — show only in timed sequences / X——仅在计时序列中显示] | [ ] | [ ] | [Example: contextual because timers only exist in specific encounter types / 示例：情境显示，因为计时器仅存在于特定遭遇类型中] |
| [Tutorial prompts / 教程提示] | [ ] | [X — show for first-time situations only / X——仅首次出现时显示] | [ ] | [ ] | [Example: contextual and one-time; never repeat to experienced players / 示例：情境显示且一次性；绝不向有经验的玩家重复] |
| [Score / points / 分数/点数] | [ ] | [X — show in score-relevant modes only / X——仅在分数相关模式中显示] | [ ] | [ ] | [Example: contextual by game mode; hidden in modes where score is irrelevant / 示例：按游戏模式情境显示；在分数无关的模式中隐藏] |
| [XP / level progress / 经验值/等级进度] | [ ] | [ ] | [X — available via character screen / X——通过角色界面查看] | [ ] | [Example: on-demand because progression does not affect in-moment gameplay decisions / 示例：按需显示，因为进度不影响即时游戏决策] |
| [Waypoint / objective marker / 路点/目标标记] | [ ] | [X — show when player is navigating to objective / X——当玩家导航至目标时显示] | [ ] | [ ] | [Example: contextual — suppress during cutscenes, cinematic moments, and free exploration / 示例：情境显示——在过场动画、电影化时刻和自由探索期间抑制] |

---

<!-- 中文翻译 -->
## 3. Layout Zones / 3. 布局区域

> **Why this section exists**: The game world is the primary content — the HUD is a
> frame around it. Before placing any element, divide the screen into named zones
> with explicit positions and safe zone margins. This section prevents two failure
> modes: (1) elements placed ad-hoc until the screen is cluttered, and (2) elements
> that overlap platform-required safe zones and get rejected in certification.
> Every element in Section 4 must be assigned to a zone defined here. / **为什么存在此章节**: 游戏世界是主要内容——HUD是它的框架。在放置任何元素之前，将屏幕划分为带有明确位置和安全区边距的命名区域。本章节防止两种失败模式：(1) 临时放置元素直到屏幕杂乱，以及(2) 元素重叠平台要求的安全区而被认证拒绝。

### 3.1 Zone Diagram / 3.1 区域示意图

```
[Draw your HUD layout zones. Customize this to match your game's actual layout.
 Axes represent approximate screen percentage. Adjust zone names and sizes. / 绘制你的HUD布局区域。自定义此图以匹配你游戏的实际布局。坐标轴代表大致的屏幕百分比。调整区域名称和大小。]

 0%                                             100%
 ┌──────────────────────────────────────────────────┐  0%
 │  [SAFE MARGIN — 10% from edge on all sides]      │
 │  ┌────────────────────────────────────────────┐  │
 │  │ [TOP-LEFT]              [TOP-CENTER]  [TOP-RIGHT] │  ~15%
 │  │  Health, resource       Quest name    Ammo, magazine │
 │  │                                              │  │
 │  │                                              │  │
 │  │               [CENTER-SCREEN]               │  │  ~50%
 │  │                Crosshair / reticle           │  │
 │  │               (minimize HUD here)            │  │
 │  │                                              │  │
 │  │                                              │  │
 │  │ [BOTTOM-LEFT]     [BOTTOM-CENTER]   [BOTTOM-RIGHT] │  ~85%
 │  │  Minimap          Subtitles          Notifications │
 │  │  Ability icons    Tutorial prompts             │  │
 │  └────────────────────────────────────────────┘  │
 │                                                  │
 └──────────────────────────────────────────────────┘  100%
```

> Rule for zone placement: the center 40% of the screen (both horizontally and
> vertically) is the player's primary focus area. Keep this zone as clear as
> possible at all times. HUD elements that appear in the center zone — crosshairs,
> interaction prompts, hit markers — must be minimal, high-contrast, and brief. / 区域放置规则：屏幕中心40%（水平和垂直方向）是玩家的主要关注区域。始终尽可能保持此区域清晰。出现在中心区域的HUD元素——十字准线、交互提示、命中标记——必须极简、高对比度且短暂。

### 3.2 Zone Specification Table / 3.2 区域规格表

| Zone Name / 区域名称 | Screen Position / 屏幕位置 | Safe Zone Compliant / 安全区域合规 | Primary Elements / 主要元素 | Max Simultaneous Elements / 最大同时显示元素数 | Notes / 备注 |
|-----------|----------------|---------------------|-----------------|--------------------------|-------|
| [Top Left / 左上] | [Top-left corner, within safe margin / 左上角，在安全边距内] | [Yes — 10% from top, 10% from left / 是——距顶部10%，距左侧10%] | [Health bar, stamina bar, shield bar / 生命条、体力条、护盾条] | [3] | [Vital status — player's own resources. Priority zone for player state. / 生命状态——玩家自己的资源。玩家状态的优先区域。] |
| [Top Center / 顶部中央] | [Top edge, centered horizontally / 顶部边缘，水平居中] | [Yes — 10% from top / 是——距顶部10%] | [Quest objective, area name (on enter) / 任务目标、区域名称（进入时）] | [1 — only one message at a time / 1——每次仅一条消息] | [Use for narrative context, not mechanical information. Keep text minimal. / 用于叙事上下文，而非机械信息。保持文本简洁。] |
| [Top Right / 右上] | [Top-right corner, within safe margin / 右上角，在安全边距内] | [Yes — 10% from top, 10% from right / 是——距顶部10%，距右侧10%] | [Ammo count, ability cooldowns / 弹药计数、技能冷却] | [2] | [Weapon/ability state. Most relevant during active combat. / 武器/技能状态。在主动战斗期间最相关。] |
| [Center / 中心] | [Screen center ±15% / 屏幕中心±15%] | [N/A — not a margin zone / 不适用——非边距区域] | [Crosshair, interaction prompt, hit marker / 十字准线、交互提示、命中标记] | [1 active at a time / 每次1个活跃] | [CRITICAL: Nothing persistent here. Only momentary indicators. / 关键：此处无持久内容。仅瞬时指示器。] |
| [Bottom Left / 左下] | [Bottom-left corner, within safe margin / 左下角，在安全边距内] | [Yes — 10% from bottom, 10% from left / 是——距底部10%，距左侧10%] | [Minimap, ability icons / 小地图、技能图标] | [2] | [Navigation and ability readout. Small, non-intrusive. / 导航和技能读数。小巧，非侵入式。] |
| [Bottom Center / 底部中央] | [Bottom edge, centered horizontally / 底部边缘，水平居中] | [Yes — 10% from bottom / 是——距底部10%] | [Subtitles, tutorial prompts / 字幕、教程提示] | [2 — subtitle + tutorial may coexist / 2——字幕+教程可共存] | [Highest-priority accessibility zone. Never place other elements here. / 最高优先级的无障碍区域。切勿在此放置其他元素。] |
| [Bottom Right / 右下] | [Bottom-right corner, within safe margin / 右下角，在安全边距内] | [Yes — 10% from bottom, 10% from right / 是——距底部10%，距右侧10%] | [Notification toasts, pick-up feedback / 通知弹窗、拾取反馈] | [3 stacked / 3个堆叠] | [Transient notifications. Stack vertically. Oldest disappears first. / 瞬时通知。垂直堆叠。最早的先消失。] |

**Safe zone margins by platform / 各平台安全区域边距**:

| Platform / 平台 | Top / 顶部 | Bottom / 底部 | Left / 左侧 | Right / 右侧 | Notes / 备注 |
|----------|-----|--------|------|-------|-------|
| [PC — windowed / PC——窗口化] | [0% — no safe zone required / 0%——无需安全区域] | [0%] | [0%] | [0%] | [But respect minimum resolution — elements must not crowd at 1280x720 / 但需尊重最低分辨率——元素在1280x720下不得拥挤] |
| [PC — fullscreen / PC——全屏] | [3%] | [3%] | [3%] | [3%] | [Slight margin for 4K TV-connected PCs / 为连接4K电视的PC保留轻微边距] |
| [Console — TV / 主机——电视] | [10%] | [10%] | [10%] | [10%] | [Action-safe zone for broadcast-spec TVs. Some TVs overscan beyond this. / 广播规格电视的动作安全区域。某些电视会过扫描超出此范围。] |
| [Steam Deck / Steam Deck] | [5%] | [5%] | [5%] | [5%] | [Small screen; safe zone is smaller but crowding risk is higher / 小屏幕；安全区域更小但拥挤风险更高] |
| [Mobile — portrait / 移动端——竖屏] | [15% top / 顶部15%] | [10% bottom / 底部10%] | [5%] | [5%] | [15% top avoids notch/camera cutout on most devices / 顶部15%可避免大多数设备的刘海/摄像头切口] |
| [Mobile — landscape / 移动端——横屏] | [5%] | [5%] | [15% left / 左侧15%] | [15% right / 右侧15%] | [Thumb placement on landscape — side zones are obscured by hands / 横屏时拇指放置——侧边区域被手遮挡] |

---

<!-- 中文翻译 -->
## 4. HUD Element Specifications / 4. HUD元素规格

> **Why this section exists**: Each HUD element needs its own specification to be
> built correctly. Ad-hoc implementation of HUD elements produces inconsistent
> sizing, mismatched update frequencies, missing urgency states, and accessibility
> failures. This section is the implementation brief for every element — fill it
> completely before any element moves into development. / **为什么存在此章节**: 每个HUD元素需要自己的规格才能正确构建。临时实现HUD元素会产生不一致的尺寸、不匹配的更新频率、缺失的紧急状态和无障碍失败。本章节是每个元素的实现摘要——在元素进入开发之前完整填写。

### 4.1 Element Overview Table / 4.1 元素概览表

> One row per HUD element. This is the master inventory for implementation planning. / 每个HUD元素一行。这是实现规划的主清单。

| Element Name / 元素名称 | Zone / 区域 | Always Visible / 始终可见 | Visibility Trigger / 可见性触发器 | Data Source / 数据源 | Update Frequency / 更新频率 | Max Size (% screen W) / 最大尺寸（屏幕宽度百分比） | Min Readable Size / 最小可读尺寸 | Overlap Priority / 重叠优先级 | Accessibility Alt / 无障碍替代 |
| Element Name / 元素名称 | Zone / 区域 | Always Visible / 始终可见 | Visibility Trigger / 可见性触发器 | Data Source / 数据源 | Update Frequency / 更新频率 | Max Size (% screen W) / 最大尺寸（屏幕宽度百分比） | Min Readable Size / 最小可读尺寸 | Overlap Priority / 重叠优先级 | Accessibility Alt / 无障碍替代 |
|-------------|------|---------------|-------------------|-------------|-----------------|----------------------|------------------|-----------------|------------------|
| [Health Bar / 生命条] | [Top Left / 左上] | [Yes / 是] | [N/A] | [PlayerStats / 玩家状态] | [On value change / 值变化时] | [20%] | [120px wide / 120像素宽] | [1 — highest / 1——最高] | [Numerical text label showing current/max: "80/100" / 显示当前/最大值的数字文本标签：“80/100”] |
| [Stamina Bar / 体力条] | [Top Left / 左上] | [No — context / 否——情境] | [Show when consuming stamina; hide 3s after full / 消耗体力时显示；满值3秒后隐藏] | [PlayerStats / 玩家状态] | [Realtime during use / 使用时实时] | [15%] | [80px wide / 80像素宽] | [2] | [Numerical label, or hide if full (accessible assumption) / 数字标签，或满值时隐藏（无障碍假设）] |
| [Shield Indicator / 护盾指示器] | [Top Left / 左上] | [No — context / 否——情境] | [Show when shield is active or recently hit / 护盾激活或最近受击时显示] | [PlayerStats / 玩家状态] | [On value change / 值变化时] | [20%] | [120px wide / 120像素宽] | [3] | [Numerical label. Must not use color alone — add shield icon. / 数字标签。不得仅使用颜色——添加护盾图标。] |
| [Ammo Counter / 弹药计数器] | [Top Right / 右上] | [No — context / 否——情境] | [Show when weapon is equipped; hide when unarmed / 装备武器时显示；解除武装时隐藏] | [WeaponSystem / 武器系统] | [On fire / on reload / 开火/装填时] | [10%] | ["88/888" readable at game's min resolution / 在游戏最低分辨率下可读] | [4] | [Text-only fallback: "32 / 120" / 仅文本回退：“32 / 120”] |
| [Minimap / 小地图] | [Bottom Left / 左下] | [Yes / 是] | [N/A — but suppressed in cinematic mode / 不适用——但在电影模式下抑制] | [NavigationSystem / 导航系统] | [Realtime / 实时] | [18%] | [150x150px] | [5] | [Cardinal direction compass strip as fallback; must be toggleable / 基点方向罗盘条作为回退；必须可切换] |
| [Quest Objective / 任务目标] | [Top Center / 顶部中央] | [No — context / 否——情境] | [Show on objective change; show when near objective location; hide after 5s / 目标变化时显示；接近目标位置时显示；5秒后隐藏] | [QuestSystem / 任务系统] | [On event / 事件触发] | [30%] | [Legible at body text size / 正文尺寸下可读] | [6] | [Read aloud on objective change via screen reader / 目标变化时通过屏幕阅读器朗读] |
| [Crosshair / 十字准线] | [Center / 中心] | [No — context / 否——情境] | [Show when ranged weapon equipped; hide in melee or unarmed / 装备远程武器时显示；近战或徒手时隐藏] | [WeaponSystem / AimSystem / 武器系统/瞄准系统] | [Realtime / 实时] | [3%] | [12px diameter minimum / 最小直径12像素] | [1 — center zone priority / 1——中心区域优先] | [Reduce motion: static crosshair only. Option to enlarge. / 减少动作：仅静态十字准线。可放大选项。] |
| [Interaction Prompt / 交互提示] | [Center / 中心] | [No — context / 否——情境] | [Show when player is within interaction range of an interactive object / 玩家在可交互对象的交互范围内时显示] | [InteractionSystem / 交互系统] | [On enter/exit interaction range / 进入/离开交互范围时] | [15%] | [24px icon + readable text / 24像素图标+可读文本] | [2 — center zone / 2——中心区域] | [Text description of interaction always present, not icon-only / 始终存在交互的文本描述，非仅图标] |
| [Subtitles / 字幕] | [Bottom Center / 底部中央] | [No — always on when dialogue plays, if setting enabled / 否——对话播放时始终开启（若设置启用）] | [Show during any voiced line or ambient dialogue / 任何语音 line 或环境对话期间显示] | [DialogueSystem / 对话系统] | [Per dialogue line / 每行对话] | [60%] | [Minimum 24px font / 最小24像素字体] | [1 — highest in zone / 1——区域内最高] | [This IS the accessibility feature — see Section 8 for subtitle spec / 这即是无障碍功能——字幕规格见第8节] |
| [Damage Numbers / 伤害数字] | [World-space / anchored to entity / 世界空间/锚定到实体] | [No — context / 否——情境] | [Show on any damage event; duration 800ms / 任何伤害事件时显示；持续800毫秒] | [CombatSystem / 战斗系统] | [On event / 事件触发] | [5% per number / 每个数字5%] | [18px minimum / 最小18像素] | [3] | [Option to disable; numbers can overwhelm for photosensitive players / 可禁用选项；数字可能让光敏性玩家不堪重负] |
| [Status Effect Icons / 状态效果图标] | [Top Left — below health bar / 左上——生命条下方] | [No — context / 否——情境] | [Show when any status effect is active on player / 玩家有任何活跃状态效果时显示] | [StatusSystem / 状态系统] | [On effect add/remove / 效果添加/移除时] | [3% per icon / 每个图标3%] | [24px per icon / 每个图标24像素] | [3] | [Icon + text label on hover/focus. Never icon-only. / 悬停/聚焦时图标+文本标签。绝不仅图标。] |
| [Notification Toast / 通知弹窗] | [Bottom Right / 右下] | [No — event-driven / 否——事件驱动] | [On loot, XP gain, achievement, quest update / 拾取、经验获取、成就、任务更新时] | [Multiple — see Section 6 / 多个——见第6节] | [On event / 事件触发] | [25%] | [Legible at body text size / 正文尺寸下可读] | [7 — lowest / 7——最低] | [Queued; never overlapping. Read by screen reader if subtitle mode on. / 排队；绝不重叠。若字幕模式开启则由屏幕阅读器朗读。] |

<!-- 中文翻译 -->
### 4.2 Element Detail Blocks

> For each element in the table above, write a detail block. Copy and complete
> one block per element.

---

**Health Bar**

- Visual description: [Horizontal fill bar. Left-to-right fill direction. Segmented at 25/50/75% to aid reading at a glance. Background: dark semi-transparent (40% opacity). Fill color: context-dependent — see Urgency States.]
- Data displayed: [Current HP as fill percentage. Numerical value displayed as text below bar at all times: "80 / 100".]
- Update behavior: [Bar fill decreases or increases smoothly using a lerp over 150ms per change. Large damage (>25% single hit) triggers a brief flash (1 frame white, then drain).]
- Urgency states:
  - Normal (>50% HP): [Green fill, no special behavior]
  - Caution (25–50% HP): [Yellow fill, low warning pulse every 4 seconds]
  - Critical (<25% HP): [Red fill, persistent slow pulse (1 Hz), vignette appears at screen edges]
  - Zero (0% HP): [Bar empties and turns grey; death state begins]
- Interaction: [Display only. Not interactive. Player cannot click, hover, or focus this element as an action target.]
- Player customization: [Opacity adjustable (see Section 7 Tuning Knobs). Can be repositioned to any corner by player in accessibility settings.]

---

**Minimap**

- Visual description: [Circular mask, radius = 75px at reference resolution 1920x1080. Player icon at center. North always up unless player has unlocked "Rotate minimap" setting. Range = configurable, default 80 world units radius.]
- Data displayed: [Player position, nearby enemies (if detection perk unlocked), quest markers within range, points of interest icons, traversal obstacles (walls, drops).]
- Update behavior: [Realtime. Updates every frame. Enemy icons fade in/out as they enter/leave detection range over 300ms.]
- Urgency states: [None for the map itself. Enemy icons turn red when they are in combat-alert state.]
- Interaction: [Not interactive in-game. Press dedicated Map button to open the full map screen (separate UX spec).]
- Player customization: [Size: S/M/L (70/90/110px radius). Opacity: 30–100%. Rotation: locked-north or player-relative. Can be disabled entirely (compass strip shows as fallback).]

---

**[Repeat this block for every element in Section 4.1]**

---

<!-- 中文翻译 -->
## 5. HUD States by Gameplay Context / 5. 按游戏上下文划分的HUD状态

> **Why this section exists**: The HUD is not a static overlay — it is a dynamic
> system that must adapt to what the player is doing. A HUD designed only for
> standard gameplay will look wrong in cutscenes, feel cluttered in exploration,
> and occlude critical information in boss fights. This section defines the
> transformations the HUD undergoes in each gameplay context. / **为什么存在此章节**: HUD不是静态叠加层——它是一个必须适应玩家正在做什么的动态系统。仅针对标准游戏玩法设计的HUD在过场动画中会看起来不对，在探索中会感觉杂乱，在Boss战中会遮挡关键信息。本章节定义HUD在每个游戏玩法上下文中经历的变化。

| Context | Elements Shown | Elements Hidden | Elements Modified | Transition Into This State |
|---------|---------------|-----------------|------------------|---------------------------|
| [Exploration — no threats] | [Minimap, Quest Objective (faded, 60%), Subtitles (if active)] | [Ammo Counter, Crosshair, Damage Numbers, Status Effects (if none active)] | [Health Bar fades to 40% opacity — visible but not dominant] | [Fade transition, 500ms, when no enemies detected for 10s] |
| [Combat — active threat] | [Health Bar (full opacity), Stamina Bar (when used), Ammo Counter, Crosshair, Damage Numbers, Status Effects, Enemy Health Bars] | [Quest Objective (temporarily hidden), Notification Toasts (paused queue)] | [Minimap scales down 15% and raises opacity to 100%] | [Immediate snap in on first enemy detection — no fade. Combat readiness requires instant info.] |
| [Dialogue / Cutscene] | [Subtitles, Dialogue speaker name] | [All gameplay HUD elements: health, ammo, minimap, crosshair, damage numbers] | [N/A] | [All gameplay elements fade out over 300ms when cutscene flag is set] |
| [Cinematic (scripted camera sequence)] | [Subtitles only] | [Everything else including speaker name] | [Letterbox bars appear (if applicable to this game's style)] | [Immediate on cinematic flag; letterbox slides in from top/bottom over 400ms] |
| [Inventory / Menu open] | [None — inventory renders full-screen or as overlay] | [All HUD elements] | [Game world visible but paused behind inventory screen] | [All HUD elements hide over 150ms as menu opens] |
| [Death / Respawn pending] | [Death screen overlay — separate spec] | [All gameplay HUD elements] | [Screen desaturates and darkens over 800ms] | [Death state begins when HP reaches 0 — HUD elements fade over 600ms] |
| [Loading / Transition] | [Loading indicator, tip text] | [All gameplay HUD elements] | [N/A] | [Instant on level transition trigger] |
| [Tutorial — new mechanic] | [Standard context HUD + Tutorial Prompt overlay] | [Nothing additional hidden] | [Tutorial prompt dims background subtly to draw attention to prompt] | [Tutorial system fires ShowTutorial event; prompt fades in over 200ms] |
| [Boss Encounter] | [Boss health bar appears (large, bottom of screen or top center), all combat elements] | [Quest Objective] | [Boss bar renders in a distinct visual style — must not be confused with player health] | [Boss health bar slides in on boss encounter trigger over 400ms] |

---

<!-- 中文翻译 -->
## 6. Information Hierarchy / 6. 信息层级

> **Why this section exists**: Not all HUD information is equally important. When
> screen space is limited, when the player is under high stress, or when elements
> compete for the same zone, there must be a principled priority order that governs
> which elements survive and which get suppressed. / **为什么存在此章节**: 并非所有HUD信息都同等重要。当屏幕空间有限、玩家处于高压状态或元素竞争同一区域时，必须有一个原则性的优先级顺序来决定哪些元素保留、哪些被压制。

| Element | Priority Tier | Reasoning | What Replaces It If Hidden |
|---------|--------------|-----------|---------------------------|
| [Subtitles] | [MUST KEEP — never hide during dialogue / 必须保留] | [Accessibility requirement / 无障碍要求] | [N/A] |
| [Health Bar] | [MUST KEEP — while player can be damaged / 必须保留—可受伤时] | [Without health visibility, survival decisions impossible / 无血量可见则生存决策不可能] | [Auditory cues / 听觉提示] |
| [Crosshair] | [MUST KEEP — while aiming / 必须保留—瞄准时] | [Precision requirement / 精确度需求] | [Dot-only mode / 仅点模式] |
| [Interaction Prompt] | [MUST KEEP — in interaction range / 必须保留—交互范围内] | [Interactive objects invisible without it / 交互对象不可见] | [Environmental cues / 环境提示] |
| [Ammo Counter] | [SHOULD KEEP / 应当保留] | [Low ammo decisions require awareness / 低弹药决策需要感知] | [Auditory "click" / 听觉"咔哒"声] |
| [Minimap] | [SHOULD KEEP / 应当保留] | [Navigation needs spatial awareness / 导航需要空间感知] | [Compass strip / 指南针条] |
| [Status Effects] | [SHOULD KEEP — while active / 应当保留—激活时] | [Invisible debuffs feel unfair / 不可见减益感觉不公平] | [Character anim / 角色动画] |
| [Quest Objective] | [CAN HIDE / 可隐藏] | [Player remembers / 玩家记得] | [Context / 上下文] |
| [Damage Numbers] | [CAN HIDE / 可隐藏] | [Feedback, not decision-critical / 反馈，非关键决策] | [Hit sounds / 打击声] |
| [Notification Toasts] | [CAN HIDE in combat / 战斗中可隐藏] | [Noise in combat / 战斗中的噪音] | [Queue post-combat / 战斗后队列] |
| [Combo Counter] | [HIDE when inactive / 不活跃时隐藏] | [Stale info misleading / 过时信息误导] | [N/A] |

---

<!-- 中文翻译 -->
## 7. Visual Budget / 7. 视觉预算

> **Why this section exists**: Without explicit budget constraints, HUD elements
> accumulate until the game world is nearly invisible. These numbers are hard limits,
> not guidelines. / **为什么存在此章节**: 没有明确的预算约束，HUD元素会积累到游戏世界几乎不可见的程度。这些数字是硬性限制，不是指导方针。

| Budget Constraint | Limit | 预算约束 | 限制 |
|------------------|-------|------|------|
| Max simultaneous HUD elements | [8] | 最大同时HUD元素 | [8] |
| Max % screen HUD (exploration) | [12%] | 最大屏幕HUD占比（探索） | [12%] |
| Max % screen HUD (combat) | [22%] | 最大屏幕HUD占比（战斗） | [22%] |
| Max % center screen zone | [5%] | 最大中心屏幕区域占比 | [5%] |
| Min contrast ratio | [4.5:1 (WCAG AA)] | 最小对比度 | [4.5:1] |
| Max HUD panel opacity | [65%] | 最大HUD面板不透明度 | [65%] |
| Min element size | [40px icons, 18px text] | 最小元素尺寸 | [40px图标, 18px文本] |

> **How to apply these budgets**: For every new HUD element, state (1) which budget it affects, (2) the new total, and (3) what gets reduced. "It's a small icon" is not an analysis. / **如何应用这些预算**: 每新增一个HUD元素，说明(1)影响哪个预算项，(2)新的总计，(3)什么会被缩减。"这只是一个小图标"不是分析。

---

<!-- 中文翻译 -->
## 8. Feedback & Notification Systems / 8. 反馈与通知系统

> **Why this section exists**: Notifications are the most frequently-added and
> worst-controlled part of most HUDs. Without explicit rules about notification
> priority, stacking limits, and queue behavior, the notification zone becomes a
> firehose of overlapping toasts that players learn to ignore entirely. / **为什么存在此章节**: 通知是大多数HUD中添加最频繁、控制最差的部​分。没有关于通知优先级、叠加限制和队列行为的明确规则，通知区域就变成玩家学会完全忽略的重叠提示洪流。

**Notification queue rules**: / **通知队列规则**：
1. Combat-aware queue: Low priority notifications are queued during combat, then flushed post-combat with max 3 items. / 战斗感知队列：低优先级通知在战斗中排队，战后释放最多3条。
2. Merge rule: identical notifications within 500ms merge into one ("Item Pickup x3"). / 合并规则：500ms内的相同通知合并为一条。
3. Critical notifications (health warning, hazard) are never queued or merged. / 关键通知（血量警告、危险）永不排队或合并。

---

<!-- 中文翻译 -->
## 9. Platform Adaptation / 9. 平台适配

> **Why this section exists**: A HUD designed at 1920x1080 on a monitor may be
> illegible on a 55-inch TV at 4K, broken at 1280x720 on Steam Deck, or hidden
> behind a notch on mobile. Platform adaptation is not optional post-ship work. / **为什么存在此章节**: 在1920x1080显示器上设计的HUD可能在4K 55英寸电视上看不清，在Steam Deck 1280x720上破碎，或在移动端被刘海遮挡。平台适配不是可选的发布后工作。

**HUD repositionability requirement**: Players must be able to reposition Health bar, Minimap, and Ability bar using an in-game HUD layout editor. / **HUD可重定位要求**: 玩家必须能使用游戏内HUD布局编辑器重定位血条、小地图和技能栏。

---

<!-- 中文翻译 -->
## 10. Accessibility — HUD Specific / 10. 无障碍 — HUD专项

> **Why this section exists**: HUD accessibility failures are the most visible
> accessibility failures in games. Color-blind failures, illegible text at minimum
> scale, and inability to disable distracting animations are among the top
> accessibility complaints in game reviews. / **为什么存在此章节**: HUD无障碍失败是游戏中最显眼的无障碍失败。色盲失败、最小比例下文字不可读、无法禁用令人分心的动画是游戏评测中最常见的无障碍投诉。

<!-- 中文翻译 -->
### 10.1 Colorblind Modes

| Element | Color-Only Information Risk | Colorblind Mode Fix |
|---------|----------------------------|---------------------|
| [Health bar fill] | [Red = low health uses red/green distinction] | [Add icon pulse + vignette as non-color indicators. Red fill is supplemental, not sole indicator.] |
| [Damage numbers] | [Red = taken, green = healed] | [Add minus (-) prefix for damage, plus (+) for healing. Symbols, not color.] |
| [Enemy health bars] | [If colored by faction or threat level] | [Add text label or icon badge for faction/threat level. Never color-only.] |
| [Status effect icons] | [If icon tint communicates status type] | [All status icons must have distinct shapes, not just distinct colors. Shape encodes meaning; color is secondary.] |
| [Minimap icons] | [If player vs. enemy vs. objective distinguished by color] | [Distinct icon shapes: circle = player, triangle = enemy, star = objective. Color supplements shape.] |

<!-- 中文翻译 -->
### 10.2 Text Scaling

[Describe what happens when the player sets the UI text scale to 150% (the maximum required for your Accessibility Tier). Which elements reflow? Which elements clip? Which elements are architecturally blocked from scaling (e.g., fixed-size canvases)?

Example: "Health bar numerical label grows with text scale — bar expands slightly to accommodate. Quest objective text wraps at 150% scale — verify Top Center zone can accommodate two-line objectives. Damage numbers do not scale (they are world-space, not screen-space) — this is an accepted limitation documented here."]

**Text scaling test matrix**:

| Element | 100% (baseline) | 125% | 150% | Overflow behavior |
|---------|----------------|------|------|-------------------|
| [Health bar label] | [Pass] | [Pass] | [TBD] | [Bar expands; does not overlap stamina bar] |
| [Quest objective text] | [Pass] | [TBD] | [TBD] | [Wraps to second line; zone height expands] |
| [Notification toast text] | [Pass] | [TBD] | [TBD] | [Toast width expands to max 35% screen width, then wraps] |
| [Subtitle text] | [Pass] | [TBD] | [TBD] | [Dedicated subtitle zone — must accommodate scale] |

<!-- 中文翻译 -->
### 10.3 Motion Sensitivity

| Animation / Motion Element | Severity | Disabled by Reduced Motion Setting? | Replacement Behavior |
|---------------------------|----------|-------------------------------------|---------------------|
| [Health bar low-HP pulse] | [Mild] | [Yes] | [Solid fill, no pulse. Vignette remains as it is less likely to trigger sensitivity.] |
| [Screen edge vignette] | [Moderate] | [Optional — separate toggle] | [Replace with static darkened corners at 30% opacity] |
| [Damage numbers float upward] | [Mild] | [Yes] | [Instant appear/disappear in place, no float] |
| [Notification toast slide-in] | [Mild] | [Yes] | [Instant appear at final position] |
| [Level up center animation] | [High] | [Yes — required] | [Static level up card, no scale animation, no particle effects] |
| [Combo counter scale pulse] | [Mild] | [Yes] | [Number increments without scale animation] |

<!-- 中文翻译 -->
### 10.4 Subtitles Specification

> Subtitles are the highest-impact accessibility feature in the HUD. Specify them
> with the same rigor as the rest of the HUD. Do not leave subtitle behavior to
> implementation discretion.

- **Default setting**: [ON or OFF — document your game's default and the rationale. Industry standard is ON by default.]
- **Position**: Bottom Center zone, centered horizontally, above the bottom safe zone margin
- **Max characters per line**: [42 characters — the readable limit for subtitle lines at minimum text size on TV viewing distance]
- **Max simultaneous lines**: [2 lines before scrolling — do not display more than 2 lines at once]
- **Speaker identification**: [Speaker name displayed in color or above subtitle text — never rely on color alone; add colon prefix: "ARIA: The door is locked."]
- **Background**: [Semi-transparent black panel, 70% opacity, behind all subtitle text — ensures contrast against any game world background]
- **Font size minimum**: [24px at 1080p reference — scales with text scale setting]
- **Line break behavior**: [Break at natural language pause points — before conjunctions, after commas, never mid-word]
- **Subtitle persistence**: [Each subtitle line holds for the duration of the spoken line plus 300ms after it ends — never disappear while audio is still playing]
- **Non-dialogue captions**: [Document whether ambient sounds, music descriptions, and sound effects are captioned — e.g., "[tense music]", "[explosion in the distance]" — and where these appear if different from dialogue subtitles]

<!-- 中文翻译 -->
### 10.5 HUD Opacity and Visibility Controls

The following player-adjustable settings must be available from the Accessibility menu:

| Setting | Range | Default | Effect |
|---------|-------|---------|--------|
| [HUD Opacity — Global] | [0% (HUD hidden) to 100%] | [100%] | [Scales all HUD element opacities simultaneously] |
| [HUD Text Scale] | [75% to 150%] | [100%] | [Scales all HUD text elements; layout adapts] |
| [Damage Number Visibility] | [On / Off] | [On] | [Enables or disables all floating damage numbers] |
| [Minimap Visibility] | [On / Off / Compass Only] | [On] | [Compass strip shown as fallback when minimap off] |
| [Notification Verbosity] | [All / Important Only / Off] | [All] | [All = all toasts; Important Only = quest + level up; Off = no toasts] |
| [Motion Reduction] | [On / Off] | [Off] | [When On, replaces all animated HUD transitions with instant state changes] |
| [High Contrast Mode] | [On / Off] | [Off] | [Applies high contrast visual theme to all HUD elements — see art bible for HC variants] |

---

<!-- 中文翻译 -->
## 11. Tuning Knobs / 11. 调优参数

> **Why this section exists**: HUD behavior should be data-driven to the same degree
> as gameplay systems. Values that are hardcoded are values that require an engineer
> to change. Values that are in config can be tuned by a designer or adjusted for
> player preferences. / **为什么存在此章节**: HUD行为应该和游戏玩法系统一样是数据驱动的。硬编码值需要工程师来更改，配置值可由设计师调优或根据玩家偏好调整。

| Parameter | Current Value | Range | Effect of Increase | Effect of Decrease | Player Adjustable? | Notes |
|-----------|-------------|-------|-------------------|-------------------|-------------------|-------|
| [Notification display duration (default)] | [2000ms] | [500ms – 5000ms] | [Toasts persist longer — less likely to be missed, more screen clutter] | [Toasts disappear faster — cleaner, higher miss risk] | [No — but player can adjust verbosity level] | [Per-type overrides in Section 8 take precedence] |
| [Notification queue max size] | [8] | [3 – 15] | [More messages preserved but queue takes longer to clear] | [Older messages dropped earlier] | [No] | [Expand if playtesting reveals important messages being lost] |
| [Health bar low-HP pulse frequency] | [1 Hz] | [0.5 – 2 Hz] | [More urgent feeling — can become fatiguing] | [Calmer — may fail to communicate urgency] | [No — but Reduced Motion disables it] | [Linked to accessibility setting] |
| [Combat HUD reveal duration] | [0ms (instant)] | [0 – 300ms] | [Softer reveal — feels less jarring] | [Instant — highest responsiveness] | [No] | [Keep at 0ms — combat information must be instant] |
| [Exploration HUD fade-out delay] | [10000ms (10s after last threat)] | [3000 – 30000ms] | [HUD fades sooner — cleaner exploration] | [HUD stays longer — more reassurance] | [No] | [Tune based on playtest; 10s is a starting estimate] |
| [Minimap range (world units visible)] | [80] | [40 – 200] | [More map context visible] | [Tighter local view] | [Yes — Small/Medium/Large preset] | [Exposed as S/M/L, not raw unit value] |
| [Minimap size (px radius at 1080p)] | [75] | [50 – 120] | [Larger map, more screen space consumed] | [Smaller, less intrusive] | [Yes — S/M/L preset] | [Three sizes exposed to player] |
| [Damage number duration (ms)] | [800] | [400 – 1500] | [Numbers linger longer — easier to read, more cluttered] | [Numbers clear faster — cleaner, harder to parse] | [No] | [Tune based on visual noise in dense combat] |
| [Global HUD opacity] | [100%] | [0 – 100%] | [Fully visible] | [Fully hidden] | [Yes — opacity slider in Accessibility settings] | [0% = full HUD off; some players prefer this] |

---

<!-- 中文翻译 -->
## 12. Acceptance Criteria / 12. 验收标准

> **Why this section exists**: These criteria are the certification checklist for the
> HUD. Every item must pass before the HUD can be marked Approved. / **为什么存在此章节**: 这些标准是HUD的认证清单。每一项必须通过后HUD才能被标记为已批准。QA必须能独立验证每一项。

**Layout & Visibility** / **布局与可见性**
- [ ] All HUD elements are within platform safe zone margins on all target platforms / 所有HUD元素在所有目标平台上都处于安全区边距内
- [ ] No two HUD elements overlap in any documented gameplay context / 任何记录的玩法场景中都没有HUD元素重叠
- [ ] HUD occupies less than [12]% of screen area in exploration context / HUD在探索场景中占用少于[12]%的屏幕区域
- [ ] HUD occupies less than [22]% of screen area in combat context / HUD在战斗场景中占用少于[22]%的屏幕区域
- [ ] All HUD elements are visible and legible at minimum supported resolution / 所有HUD元素在最低支持分辨率下可见且可读

**Accessibility** / **无障碍**
- [ ] All HUD text meets 4.5:1 contrast ratio / 所有HUD文本达到4.5:1对比度
- [ ] No HUD element uses color as the ONLY differentiator / 没有HUD元素仅使用颜色作为区分
- [ ] Subtitles appear for all voiced lines when enabled / 字幕在所有语音内容上启用时正确显示
- [ ] Reduced Motion setting disables all specified animations / 减少动画设置禁用所有指定的动画
- [ ] Text Scale 150% does not cause overflow or overlap / 文本缩放150%不导致溢出或重叠

**Notifications** / **通知**
- [ ] Same-type notifications within 500ms merge / 500ms内同类型通知合并
- [ ] Low-priority notifications queued during combat / 低优先级通知在战斗中排队
- [ ] Critical warnings appear immediately / 关键警告立即出现
- [ ] Max [3] notification toasts visible simultaneously / 最多[3]条通知提示同时可见

**Platform** / **平台**
- [ ] All elements respect 10% safe zone on console / 所有元素遵守主机10%安全区
- [ ] HUD displays correctly at 1280x720 (Steam Deck) / HUD在1280x720正确显示
- [ ] HUD elements are repositionable and settings persist / HUD元素可重定位且设置持久化

---

<!-- 中文翻译 -->
## 13. Open Questions / 13. 待解决问题

> Track unresolved design questions here. All questions must be resolved before
> the HUD design document can be marked Approved. / 在此追踪未解决的设计问题。所有问题必须在HUD设计文档标记为已批准之前解决。

| Question | Owner | Deadline | Resolution | 问题 | 负责人 | 截止日期 | 解决方案 |
|----------|-------|----------|-----------|------|--------|----------|----------|
| [Should the minimap show enemy positions by default?] | [systems-designer + ui-designer] | [Sprint 5, Day 2] | [Pending] | [小地图应默认显示敌人位置吗？] | [系统设计师 + UI设计师] | [冲刺5, 第2天] | [待定] |
| [Do bosses have a distinct health bar treatment?] | [game-designer] | [Sprint 5, Day 1] | [Pending] | [Boss有独特的血条处理吗？] | [游戏设计师] | [冲刺5, 第1天] | [待定] |
| [Damage numbers: diegetic (world-space) or screen-space?] | [ui-designer + lead-programmer] | [Sprint 4, Day 5] | [Pending] | [伤害数字: 内叙式(世界空间)还是屏幕空间?] | [UI设计师 + 主程] | [冲刺4, 第5天] | [待定] |
| [Does the game support both portrait and landscape?] | [producer] | [Sprint 3, Day 3] | [Pending] | [游戏支持竖屏和横屏两种方向吗?] | [制作人] | [冲刺3, 第3天] | [待定] |
