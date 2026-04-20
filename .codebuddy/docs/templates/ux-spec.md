# UX Specification: [Screen / Flow Name / 屏幕/流程名称]

> **Status / 状态**: Draft / 草稿 | In Review / 审核中 | Approved / 已批准 | Implemented / 已实现
> **Author / 作者**: [Name or agent — e.g., ui-designer / 名称或代理 — 例如，ui-designer]
> **Last Updated / 最后更新**: [Date / 日期]
> **Screen / Flow Name / 屏幕/流程名称**: [Short identifier used in code and tickets — e.g., `InventoryScreen`, `NewGameFlow` / 代码和票据中使用的短标识符 — 例如，`InventoryScreen`, `NewGameFlow`]
> **Platform Target / 平台目标**: [PC | Console / 主机 | Mobile / 移动 | All / 所有 — list all that this spec covers / 列出此规格涵盖的所有内容]
> **Related GDDs / 相关GDD**: [Links to the GDD sections that generated this UI requirement — e.g., `design/gdd/inventory.md § UI Requirements` / 链接到生成此UI需求的GDD章节]
> **Related ADRs / 相关ADR**: [Any architectural decisions that constrain this screen — e.g., `ADR-0012: UI Framework Selection` / 约束此屏幕的任何架构决策]
> **Related UX Specs / 相关UX规格**: [Sibling and parent screens — e.g., `ux-spec-pause-menu.md`, `ux-spec-settings.md` / 同级和父屏幕]
> **Accessibility Tier / 无障碍层级**: Basic / 基础 | Standard / 标准 | Comprehensive / 全面 | Exemplary / 示范性

> **Note — Scope boundary / 注意 — 范围边界**: This template covers discrete screens and flows (menus,
此模板涵盖离散的屏幕和流程（菜单、
dialogs, inventory, settings, cutscene UI, etc.). For persistent in-game overlays
对话框、库存、设置、过场UI等）。对于活跃游戏期间的持久游戏内覆盖层，
that exist during active gameplay, use `hud-design.md` instead. If a screen is a
请改用 `hud-design.md`。如果屏幕是
hybrid (e.g., a pause menu that overlays the game world), treat it as a screen spec
混合的（例如，覆盖游戏世界的暂停菜单），请将其视为屏幕规格，
and note the overlay relationship in Navigation Position.
并在导航位置中注意覆盖关系。

---

## 1. Purpose & Player Need / 目的与玩家需求

> **Why this section exists / 为什么此章节存在**: Every screen must justify its existence from the
每个屏幕必须从玩家的角度证明其存在的合理性。
player's perspective. Screens that are designed from a developer perspective ("display
从开发者角度设计的屏幕（"显示
the save data") produce cluttered, confusing interfaces. Screens designed from the
保存数据"）产生杂乱、混乱的界面。从玩家角度设计的屏幕
player's perspective ("let the player feel confident their progress is safe before they
（"让玩家在放下控制器之前感到他们的进度是安全的"）
put the controller down") produce purposeful, calm interfaces. Write this section before
产生有目的、平静的界面。在触摸任何布局决策之前撰写此章节 — 
touching any layout decisions — it is the filter through which every subsequent choice
它是评估每个后续选择的过滤器。
is evaluated.

**What player need does this screen serve? / 此屏幕服务什么玩家需求？**

[One paragraph. Name the real human need, not the system function. Consider: what would
[一段话。命名真正的人类需求，而非系统功能。考虑：玩家打开此屏幕时会说他们想要什么？
a player say they want when they open this screen? What would frustrate them if it did
如果它不起作用，什么会让他们沮丧？那种沮丧描述了需求。
not work? That frustration describes the need.

Example — bad / 示例 — 不好: "Displays the player's current items and equipment."
Example — good / 示例 — 好: "Lets the player understand what they're carrying and quickly decide what
to take into the next encounter, without breaking their mental model of the game world.
让玩家了解他们携带什么，并快速决定带什么进入下一次遭遇，而不打破他们对游戏世界的心理模型。
The inventory is the player's planning tool between moments of action."]
库存是玩家行动时刻之间的计划工具。"]

**The player goal / 玩家目标** (what the player wants to accomplish / 玩家想要完成什么):

[One sentence. Specific enough that you could write an acceptance criterion for it.
[一句话。足够具体，以便您可以为其编写验收标准。
Example: "Find the item they are looking for within three button presses and equip it
示例："在三次按钮按压内找到他们正在寻找的物品并装备它，
without navigating to a separate screen."]
无需导航到单独的屏幕。"]

**The game goal / 游戏目标** (what the game needs to communicate or capture / 游戏需要传达或捕捉什么):

[One sentence. This is what the system needs from this interaction. Example: "Record the
[一句话。这是系统从此交互中需要什么。示例："记录玩家的装备选择，
player's equipment choices and relay them to the combat system before the next encounter
并在下一次遭遇加载之前将其传递给战斗系统。"
loads." This section prevents UI that looks good but fails to serve the system it is
此章节防止看起来不错但未能服务其所属系统的UI。
part of.]

---

## 2. Player Context on Arrival / 到达时的玩家上下文

> **Why this section exists / 为什么此章节存在**: Screens do not exist in isolation. A player opening the
屏幕不是孤立存在的。在战斗中打开库存的玩家与清除地牢后打开它的玩家处于完全不同的认知和情感状态。
inventory mid-combat is in a completely different cognitive and emotional state than
相同的信息架构在一个上下文中可能感觉压抑复杂，而在另一个上下文中则感觉轻而易举。
a player opening it after clearing a dungeon. The same information architecture can
记录上下文，以便设计决策 — 首先显示什么、隐藏什么、动画什么、
feel oppressively complex in one context and trivially simple in another. Document the
简化什么 — 根据实际到达此屏幕的玩家进行校准，而不是抽象的用户。
context so that design decisions — what to show first, what to hide, what to animate,
what to simplify — are calibrated to the actual player arriving at this screen, not
an abstract user.

| Question / 问题 | Answer / 答案 |
|----------|--------|
| What was the player just doing? / 玩家刚才在做什么？ | [e.g., Completed a combat encounter / Pressed Esc from exploration / Triggered a story cutscene / 例如，完成了战斗遭遇 / 从探索中按下Esc / 触发了故事过场] |
| What is their emotional state? / 他们的情感状态是什么？ | [e.g., High tension — just narrowly survived / Calm — exploring between objectives / 例如，高度紧张 — 刚刚勉强幸存 / 平静 — 在目标之间探索] |
| What cognitive load are they carrying? / 他们携带什么认知负荷？ | [e.g., High — actively tracking enemy positions / Low — no active threats / 例如，高 — 积极跟踪敌人位置 / 低 — 没有活跃威胁] |
| What information do they already have? / 他们已经有了什么信息？ | [e.g., They know they just picked up an item but haven't seen its stats yet / 例如，他们知道他们刚刚捡起一个物品但还没有看到其属性] |
| What are they most likely trying to do? / 他们最可能试图做什么？ | [e.g., Check if the new item is better than their current weapon — primary use case / 例如，检查新物品是否比当前武器更好 — 主要用例] |
| What are they likely afraid of? / 他们可能害怕什么？ | [e.g., Missing something, making an irreversible mistake, losing track of where they were / 例如，错过某事、犯下不可逆转的错误、失去他们所在位置的跟踪] |

**Emotional design target for this screen / 此屏幕的情感设计目标**:

[One sentence describing the feeling the player should have while using this screen.
[一句话描述玩家在使用此屏幕时应该有的感觉。
Example: "Confident and in control — the player should feel like they have complete
示例："自信且掌控 — 玩家应该感觉他们有完整的信息和对其选择的完全权威，
information and complete authority over their choices, with no ambiguity about outcomes."]
对结果没有歧义。"]

---

## 3. Navigation Position / 导航位置

> **Why this section exists / 为什么此章节存在**: A screen that does not know where it sits in the
不知道自己在导航层次结构中位置的屏幕无法定义其进入/退出过渡、
navigation hierarchy cannot define its entry/exit transitions, its back-button
后退按钮行为或其与游戏暂停状态的关系。导航位置还
behavior, or its relationship to the game's pause state. Navigation position also
早期揭示架构问题 — 如果此屏幕可以从八个不同的地方到达，
reveals architectural problems early — if this screen is reachable from eight
那是一个应该在设计中解决的复杂性标志，而不是实现中。
different places, that is a complexity flag that should be resolved in design, not
implementation.

**Screen hierarchy / 屏幕层次结构** (use indentation to show parent-child relationships / 使用缩进显示父子关系):

```
[Root — e.g., Main Menu / 根 — 例如，主菜单]
  └── [Parent Screen — e.g., Settings / 父屏幕 — 例如，设置]
        └── [This Screen — e.g., Audio Settings / 此屏幕 — 例如，音频设置]
              ├── [Child Screen — e.g., Advanced Audio Options / 子屏幕 — 例如，高级音频选项]
              └── [Child Screen — e.g., Speaker Test Dialog / 子屏幕 — 例如，扬声器测试对话框]
```

**Modal behavior / 模态行为**: [Modal (blocks everything behind it, requires explicit dismiss) / 模态（阻止后面的一切，需要明确关闭） | Non-modal (game continues behind it) / 非模态（游戏在其后继续） | Overlay (renders over game world, game paused) / 覆盖层（在游戏世界上渲染，游戏暂停） | Overlay-live (renders over game world, game continues) / 覆盖层-实时（在游戏世界上渲染，游戏继续）]

> If this screen is modal: document the dismiss behavior. Can it be dismissed by pressing
> 如果此屏幕是模态的：记录关闭行为。可以通过按下Back/B关闭吗？
> Back/B? By pressing Escape? By clicking outside it? Can it be dismissed at all, or
> 通过按下Escape？通过点击外部？可以关闭吗，还是
> must the player complete it? Undismissable modals are high-friction — justify them.
> 玩家必须完成它？不可关闭的模态是高摩擦的 — 为它们辩护。

**Reachability — all entry points / 可达性 — 所有进入点**:

| Entry Point / 进入点 | Triggered By / 触发者 | Notes / 备注 |
|-------------|-------------|-------|
| [e.g., Main Menu → Play / 例如，主菜单 → 游玩] | [Player selects "New Game" / 玩家选择"新游戏"] | [Primary entry point / 主要进入点] |
| [e.g., Pause Menu → Resume / 例如，暂停菜单 → 继续] | [Player presses Start from any gameplay state / 玩家从任何游戏状态按下Start] | [Secondary entry / 次要进入] |
| [e.g., Game event / 例如，游戏事件] | [Tutorial system forces open first time only / 教程系统仅在第一次强制打开] | [Systemic entry — must not break if player dismisses / 系统性进入 — 如果玩家关闭则不得破坏] |

---

## 4. Entry & Exit Points / 进入和退出点

[Continues with the rest of the UX spec template...]
