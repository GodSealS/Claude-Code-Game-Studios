# HUD Design: [Game Name / 游戏名称]

> **Status / 状态**: Draft | In Review | Approved | Implemented / 草稿 | 审核中 | 已批准 | 已实现
> **Author / 作者**: [Name or agent — e.g., ui-designer / 名称或代理 — 例如，ui-designer]
> **Last Updated / 最后更新**: [Date / 日期]
> **Game / 游戏**: [Game name — this is a single document per game, not per element / 游戏名称 — 这是每个游戏一个文档，不是每个元素]
> **Platform Targets / 目标平台**: [All platforms this HUD must work on — e.g., PC, PS5, Xbox Series X, Steam Deck / 此HUD必须工作的所有平台 — 例如，PC、PS5、Xbox Series X、Steam Deck]
> **Related GDDs / 相关GDD**: [Every system that exposes information through the HUD — e.g., `design/gdd/combat.md`, `design/gdd/progression.md`, `design/gdd/quests.md` / 通过HUD暴露信息的每个系统 — 例如，`design/gdd/combat.md`、`design/gdd/progression.md`、`design/gdd/quests.md`]
> **Accessibility Tier / 无障碍层级**: Basic | Standard | Comprehensive | Exemplary / 基础 | 标准 | 全面 | 典范
> **Style Reference / 风格参考**: [Link to art bible HUD section if it exists — e.g., `design/gdd/art-bible.md § HUD Visual Language` / 如存在，链接到美术圣经HUD部分 — 例如，`design/gdd/art-bible.md § HUD视觉语言`]

> **Note — Scope boundary / 备注 — 范围边界**: This document specifies all elements that overlay the
> game world during active gameplay — health bars, ammo counters, minimaps, quest
> trackers, subtitles, damage numbers, and notification toasts. For menu screens,
> pause menus, inventory, and dialogs that the player navigates explicitly, use
> `ux-spec.md` instead. The test: if it appears while the player is directly
> controlling their character, it belongs here.
> 本文档指定在游戏过程中覆盖游戏世界的所有元素 — 血条、弹药计数器、小地图、任务追踪器、字幕、伤害数字和通知提示。对于菜单界面、暂停菜单、物品栏和玩家明确导航的对话框，请改用`ux-spec.md`。测试：如果在玩家直接控制角色时出现，它就属于这里。

---

## 1. HUD Philosophy / HUD理念

> **Why this section exists / 为什么本节存在**: The HUD design philosophy is not decoration — it is a
> design constraint that every subsequent decision is measured against. Without a
> philosophy, individual elements get added on request ("the quest tracker wants a
> bigger icon") without any principled way to push back. With a philosophy, there is
> a shared, explicit standard. More importantly, the philosophy prevents the HUD from
> slowly growing to cover the game world while each individual addition seemed
> reasonable in isolation. Write this before specifying any elements.
> HUD设计理念不是装饰 — 它是每个后续决策都要衡量的设计约束。没有理念，个别元素会根据请求添加（"任务追踪器想要更大的图标"）而没有任何原则性的方式来回绝。有了理念，就有了共享的、明确的标准。更重要的是，理念防止HUD慢慢增长覆盖游戏世界，而每个单独添加在孤立时看起来合理。在指定任何元素之前先写这个。

**What is this game's relationship with on-screen information? / 这个游戏与屏幕信息的关系是什么？**

[One paragraph. This is a design statement, not a description of features. Consider
the game's genre, pacing, and player fantasy. A stealth game's HUD philosophy might
be: "The world is the interface. If the player has to look away from the environment
to survive, the HUD has failed." A tactics game might say: "Complete situational
awareness is the game. The HUD is not an overlay — it is the battlefield."
一段话。这是设计声明，不是特性描述。考虑游戏的类型、节奏和玩家幻想。潜行游戏的HUD理念可能是："世界就是界面。如果玩家必须将视线从环境移开才能生存，HUD就失败了。"战术游戏可能会说："完全的情境感知就是游戏。HUD不是覆盖层 — 它是战场。"

Reference comparable games if helpful, but describe your specific stance:
如有帮助，参考可比游戏，但描述你的具体立场：
Example — diegetic-first action RPG / 示例 — 叙事优先动作RPG: "We treat screen information as a concession,
not a feature. Every HUD element must earn its pixel space by answering the question:
would the player make demonstrably worse decisions without this information visible?
If the answer is 'they'd adapt,' we put it in the environment instead."
"我们将屏幕信息视为让步，而不是特性。每个HUD元素必须通过回答这个问题来赢得它的像素空间：如果没有这些可见信息，玩家会做出明显更差的决策吗？如果答案是'他们会适应'，我们就把它放在环境中。"]

**Visibility principle / 可见性原则** — when in doubt, show or hide? / 有疑问时，显示还是隐藏？

[State the default resolution for ambiguous cases. Options:
- Default to HIDE / 默认隐藏: information is available on demand (e.g., Dark Souls — no quest tracker, no minimap, stats are in a menu / 信息按需获取（例如，黑暗之魂 — 无任务追踪器、无小地图、状态在菜单中）
- Default to SHOW / 默认显示: players prefer to be informed; cluttered is better than uncertain / 玩家更喜欢被告知；杂乱比不确定好
- Default to CONTEXTUAL / 默认情境化: information appears when it becomes relevant and fades when it does not / 信息在相关时出现，不相关时消失
Most games benefit from contextual defaults. State your game's default clearly so every element decision is consistent.
大多数游戏受益于情境化默认。清楚地说明游戏的默认设置，以便每个元素决策保持一致。]

**The Rule of Necessity for this game / 本游戏的必要性规则**:

[Complete this sentence / 完成这句话: "A HUD element earns its place when ______________."

Example / 示例: "...the player would have to stop playing to find the same information
elsewhere, or would make meaningfully worse decisions without it."
"...玩家必须停止游戏才能在其他地方找到相同信息，或者没有它会做出明显更差的决策。"

Example / 示例: "...removing it in playtesting causes measurable frustration or confusion
in more than 25% of testers within the first hour of play."
"...在测试中移除它会导致超过25%的测试者在游戏第一小时内产生可衡量的挫败感或困惑。"

This rule is the veto power over feature requests to add HUD elements. Document it
so it can be cited in design reviews.
此规则是反对添加HUD元素特性请求的否决权。将其记录下来以便在设计审查中引用。]

---

## 2. Information Architecture / 信息架构

> **Why this section exists / 为什么本节存在**: Before specifying any HUD element's visual design,
> position, or behavior, you must answer a more fundamental question: should this
> information be on the HUD at all? This section is a forcing function — it requires
> you to categorize EVERY piece of information the game world generates and make an
> explicit, intentional decision about how each is presented. "We'll figure that out
> later" is how games end up with 18 elements competing for the player's peripheral
> vision. This table is the master inventory of game information, not just HUD information.
> 在指定任何HUD元素的视觉设计、位置或行为之前，你必须回答一个更基本的问题：这些信息应该出现在HUD上吗？本节是一个强制功能 — 它要求你对游戏世界生成的每一条信息进行分类，并对每个信息的呈现方式做出明确的、有意的决定。"我们稍后会解决这个问题"是游戏最终有18个元素竞争玩家周边视野的方式。此表是游戏信息的主清单，而不仅仅是HUD信息。

| Information Type / 信息类型 | Always Show / 始终显示 | Contextual (show when relevant) / 情境化（相关时显示） | On Demand (menu/button) / 按需（菜单/按钮） | Hidden (environmental / diegetic) / 隐藏（环境/叙事） | Reasoning / 理由 |
|-----------------|-------------|--------------------------------|------------------------|----------------------------------|-----------|
| [Health / Vitality / 生命/活力] | [X if action game — player needs constant awareness / X如果是动作游戏 — 玩家需要持续意识] | [X if exploration game — show only when injured / X如果是探索游戏 — 仅在受伤时显示] | [ ] | [ ] | [Example / 示例: always visible because health decisions (retreat, heal) must be instant in combat / 始终可见，因为生命决策（撤退、治疗）在战斗中必须即时] |
