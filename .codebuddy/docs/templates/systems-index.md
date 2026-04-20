# Systems Index: [Game Title / 游戏标题]

> **Status / 状态**: [Draft / Under Review / Approved / 草稿 / 审核中 / 已批准]
> **Created / 创建**: [Date / 日期]
> **Last Updated / 最后更新**: [Date / 日期]
> **Source Concept / 源概念**: design/gdd/game-concept.md

---

## Overview / 概述

[One paragraph explaining the game's mechanical scope. What kind of systems does
this game need? Reference the core loop and game pillars. This should help any
team member understand the "big picture" of what needs to be designed and built.
一段话解释游戏的机制范围。这个游戏需要什么类型的系统？参考核心循环和游戏支柱。这应该帮助任何团队成员理解需要设计和构建的"大局"。]

---

## Systems Enumeration / 系统枚举

| # | System Name / 系统名称 | Category / 类别 | Priority / 优先级 | Status / 状态 | Design Doc / 设计文档 | Depends On / 依赖 |
|---|-------------|----------|----------|--------|------------|------------|
| 1 | [e.g., Player Controller / 例如，玩家控制器] | Core / 核心 | MVP | [Not Started / In Design / In Review / Approved / Implemented / 未开始 / 设计中 / 审核中 / 已批准 / 已实现] | [design/gdd/player-controller.md or "—" / design/gdd/player-controller.md 或 "—"] | [e.g., Input System, Physics / 例如，输入系统、物理] |
| 2 | [e.g., Camera System / 例如，相机系统] | Core / 核心 | MVP | Not Started / 未开始 | — | Player Controller / 玩家控制器 |

[Add a row for every identified system. Use the categories and priority tiers
defined below. Mark systems that were inferred (not explicitly in the concept doc)
with "(inferred)" in the system name.
为每个识别出的系统添加一行。使用下面定义的类别和优先级层。在系统名称中用"(推断)"标记推断的系统（概念文档中未明确说明的）。]

---

## Categories / 类别

| Category / 类别 | Description / 描述 | Typical Systems / 典型系统 |
|----------|-------------|-----------------|
| **Core / 核心** | Foundation systems everything depends on / 所有内容依赖的基础系统 | Player controller / 玩家控制器, input / 输入, physics / 物理, camera / 相机, scene management / 场景管理, state machine / 状态机 |
| **Gameplay / 游戏玩法** | The systems that make the game fun / 使游戏有趣的系统 | Combat / 战斗, AI, stealth / 潜行, movement abilities / 移动能力, interaction / 交互 |
| **Progression / 进度** | How the player grows over time / 玩家如何随时间成长 | XP/leveling / 经验/升级, skill trees / 技能树, unlocks / 解锁, achievements / 成就, reputation / 声望 |
| **Economy / 经济** | Resource creation and consumption / 资源创建和消耗 | Currency / 货币, loot / 战利品, crafting / 制作, shops / 商店, item database / 物品数据库, drop tables / 掉落表 |
| **Persistence / 持久化** | Save state and continuity / 保存状态和连续性 | Save/load / 保存/加载, settings / 设置, cloud sync / 云同步, profile management / 配置文件管理 |
| **UI** | Player-facing information displays / 面向玩家的信息显示 | HUD, menus / 菜单, inventory screen / 物品栏界面, dialogue UI / 对话UI, map / 地图, notifications / 通知 |
| **Audio / 音频** | Sound and music systems / 声音和音乐系统 | Music manager / 音乐管理器, SFX bus / 音效总线, ambient audio / 环境音频, adaptive music / 自适应音乐, voice / 语音 |
| **Narrative / 叙事** | Story and dialogue delivery / 故事和对话传递 | Dialogue system / 对话系统, quest tracking / 任务追踪, cutscenes / 过场动画, journal / 日志, lore entries / 背景条目 |
| **Meta / 元** | Systems outside the core game loop / 核心游戏循环之外的系统 | Analytics / 分析, tutorials/onboarding / 教程/入门, accessibility options / 无障碍选项, photo mode / 拍照模式 |

[Not every game needs every category. Remove categories that don't apply.
Add custom categories if needed.
并非每个游戏都需要每个类别。删除不适用的类别。如需要添加自定义类别。]

---

## Priority Tiers / 优先级层

| Tier / 层 | Definition / 定义 | Target Milestone / 目标里程碑 | Design Urgency / 设计紧急度 |
|------|------------|------------------|----------------|
| **MVP** | Required for the core loop to function. Without these, you can't test "is this fun?" / 核心循环运行所需。没有这些，你无法测试"这有趣吗？" | First playable prototype / 首个可玩原型 | Design FIRST / 首先设计 |
| **Vertical Slice / 垂直切片** | Required for one complete, polished area. Demonstrates the full experience. / 一个完整、打磨区域所需。展示完整体验。 | Vertical slice / demo / 垂直切片/演示 | Design SECOND / 其次设计 |
| **Alpha** | All features present in rough form. Complete mechanical scope, placeholder content OK. / 所有功能以粗糙形式存在。完整机制范围，占位内容可接受。 | Alpha milestone / Alpha里程碑 | Design THIRD / 第三设计 |
| **Full Vision / 完整愿景** | Polish, edge cases, nice-to-haves, and content-complete features. / 打磨、边界情况、锦上添花和内容完整功能。 | Beta / Release / Beta/发布 | Design as needed / 按需设计 |

---

## Dependency Map / 依赖图

[Systems sorted by dependency order — design and build from top to bottom.
Systems at the top are foundations; systems at the bottom are wrappers.
按依赖顺序排序的系统 — 从上到下设计和构建。顶部的系统是基础；底部的系统是包装器。]

### Foundation Layer (no dependencies) / 基础层（无依赖）

1. [System / 系统] — [one-line rationale for why this is foundational / 一句话说明为什么这是基础]

### Core Layer (depends on foundation) / 核心层（依赖基础）

1. [System / 系统] — depends on / 依赖: [list / 列表]

### Feature Layer (depends on core) / 功能层（依赖核心）

1. [System / 系统] — depends on / 依赖: [list / 列表]

### Presentation Layer (depends on features) / 表现层（依赖功能）

1. [System / 系统] — depends on / 依赖: [list / 列表]

### Polish Layer (depends on everything) / 打磨层（依赖所有）

1. [System / 系统] — depends on / 依赖: [list / 列表]

---

## Recommended Design Order / 推荐设计顺序

[Combining dependency sort and priority tiers. Design these systems in this
order. Each system's GDD should be completed and reviewed before starting the
next, though independent systems at the same layer can be designed in parallel.
结合依赖排序和优先级层。按此顺序设计这些系统。每个系统的GDD应该在开始下一个之前完成和审核，尽管同一层的独立系统可以并行设计。]

| Order / 顺序 | System / 系统 | Priority / 优先级 | Layer / 层 | Agent(s) / 代理 | Est. Effort / 估计工作量 |
|-------|--------|----------|-------|----------|-------------|
| 1 | [First system to design / 要设计的第一个系统] | MVP | Foundation / 基础 | game-designer | [S/M/L] |
| 2 | [Second system / 第二个系统] | MVP | Foundation / 基础 | game-designer | [S/M/L] |

[Effort estimates / 工作量估计: S = 1 session / 1会话, M = 2-3 sessions / 2-3会话, L = 4+ sessions / 4+会话.
A "session" is one focused design conversation producing a complete GDD.
"会话"是产生完整GDD的一次集中设计对话。]
