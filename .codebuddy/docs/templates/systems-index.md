# Systems Index: [Game Title] / 系统索引：[游戏名称]

> **Status**: [Draft / Under Review / Approved] / **状态**: [草稿 / 评审中 / 已批准]
> **Created**: [Date] / **创建**: [日期]
> **Last Updated**: [Date] / **最后更新**: [日期]
> **Source Concept**: design/gdd/game-concept.md / **来源概念**: design/gdd/game-concept.md

---

<!-- 概述 -->
## Overview / 概述

[One paragraph explaining the game's mechanical scope. What kind of systems does
this game need? Reference the core loop and game pillars. This should help any
team member understand the "big picture" of what needs to be designed and built.] / [一段话解释游戏的机制范围。这个游戏需要什么样的系统？参考核心循环和游戏支柱。这应该帮助任何团队成员理解需要设计和构建的"大局"。]

---

<!-- 中文翻译 -->
## Systems Enumeration / 系统枚举

| # / 序号 | System Name / 系统名称 | Category / 类别 | Priority / 优先级 | Status / 状态 | Design Doc / 设计文档 | Depends On / 依赖 |
|---|-------------|----------|----------|--------|------------|------------|
| 1 | [e.g., Player Controller] | Core | MVP | [Not Started / In Design / In Review / Approved / Implemented] | [design/gdd/player-controller.md or "—"] | [e.g., Input System, Physics] |
| 2 | [e.g., Camera System] | Core | MVP | Not Started | — | Player Controller |

[Add a row for every identified system. Use the categories and priority tiers
defined below. Mark systems that were inferred (not explicitly in the concept doc)
with "(inferred)" in the system name.] / [为每个已识别的系统添加一行。使用下面定义的类别和优先级层级。将推断出的系统（概念文档中未明确提及的）在系统名称中标"(inferred)"。]

---

<!-- 中文翻译 -->
## Categories / 类别

| Category | Description | Typical Systems |
|----------|-------------|-----------------|
| **Core** | Foundation systems everything depends on | Player controller, input, physics, camera, scene management, state machine |
| **Gameplay** | The systems that make the game fun | Combat, AI, stealth, movement abilities, interaction |
| **Progression** | How the player grows over time | XP/leveling, skill trees, unlocks, achievements, reputation |
| **Economy** | Resource creation and consumption | Currency, loot, crafting, shops, item database, drop tables |
| **Persistence** | Save state and continuity | Save/load, settings, cloud sync, profile management |
| **UI** | Player-facing information displays | HUD, menus, inventory screen, dialogue UI, map, notifications |
| **Audio** | Sound and music systems | Music manager, SFX bus, ambient audio, adaptive music, voice |
| **Narrative** | Story and dialogue delivery | Dialogue system, quest tracking, cutscenes, journal, lore entries |
| **Meta** | Systems outside the core game loop | Analytics, tutorials/onboarding, accessibility options, photo mode |

[Not every game needs every category. Remove categories that don't apply.
Add custom categories if needed.] / [并非每个游戏都需要每个类别。删除不适用的类别。如需添加自定义类别。]

---

<!-- 中文翻译 -->
## Priority Tiers / 优先级层级

| Tier | Definition | Target Milestone | Design Urgency |
|------|------------|------------------|----------------|
| **MVP** | Required for the core loop to function. Without these, you can't test "is this fun?" | First playable prototype | Design FIRST |
| **Vertical Slice** | Required for one complete, polished area. Demonstrates the full experience. | Vertical slice / demo | Design SECOND |
| **Alpha** | All features present in rough form. Complete mechanical scope, placeholder content OK. | Alpha milestone | Design THIRD |
| **Full Vision** | Polish, edge cases, nice-to-haves, and content-complete features. | Beta / Release | Design as needed |

---

<!-- 中文翻译 -->
## Dependency Map / 依赖图

[Systems sorted by dependency order — design and build from top to bottom.
Systems at the top are foundations; systems at the bottom are wrappers.] / [按依赖顺序排列的系统——从上到下设计和构建。顶层的系统是基础；底层的系统是封装。]

<!-- 中文翻译 -->
### Foundation Layer (no dependencies) / 基础层（无依赖）

1. [System] — [one-line rationale for why this is foundational] / [系统] — [为什么这是基础的一行理由]

<!-- 中文翻译 -->
### Core Layer (depends on foundation) / 核心层（依赖基础层）

1. [System] — depends on: [list] / [系统] — 依赖：[列表]

<!-- 中文翻译 -->
### Feature Layer (depends on core) / 功能层（依赖核心层）

1. [System] — depends on: [list] / [系统] — 依赖：[列表]

<!-- 中文翻译 -->
### Presentation Layer (depends on features) / 表现层（依赖功能层）

1. [System] — depends on: [list] / [系统] — 依赖：[列表]

<!-- 中文翻译 -->
### Polish Layer (depends on everything) / 打磨层（依赖所有层）

1. [System] — depends on: [list] / [系统] — 依赖：[列表]

---

<!-- 中文翻译 -->
## Recommended Design Order / 推荐设计顺序

[Combining dependency sort and priority tiers. Design these systems in this
order. Each system's GDD should be completed and reviewed before starting the
next, though independent systems at the same layer can be designed in parallel.] / [结合依赖排序和优先级层级。按此顺序设计这些系统。每个系统的GDD应在开始下一个之前完成并审查，尽管同层的独立系统可以并行设计。]

| Order | System | Priority | Layer | Agent(s) | Est. Effort |
|-------|--------|----------|-------|----------|-------------|
| 1 | [First system to design] | MVP | Foundation | game-designer | [S/M/L] |
| 2 | [Second system] | MVP | Foundation | game-designer | [S/M/L] |

[Effort estimates: S = 1 session, M = 2-3 sessions, L = 4+ sessions.
A "session" is one focused design conversation producing a complete GDD.] / [工作量估算：S = 1次会话，M = 2-3次会话，L = 4+次会话。一次"会话"是一次专注的设计对话，产出一个完整的GDD。]

---

<!-- 中文翻译 -->
## Circular Dependencies / 循环依赖

[List any circular dependency chains found during analysis. These require
special architectural attention — either break the cycle with an interface,
or design the systems simultaneously.] / [列出分析中发现的任何循环依赖链。这些需要特别的架构关注——要么用接口打破循环，要么同时设计这些系统。]

- [None found] OR / - [未发现] 或
- [System A <-> System B: Description of the circular relationship and
  proposed resolution] / [系统A <-> 系统B：循环关系的描述和建议的解决方案]

---

<!-- 中文翻译 -->
## High-Risk Systems / 高风险系统

[Systems that are technically unproven, design-uncertain, or scope-dangerous.
These should be prototyped early regardless of priority tier.] / [技术未经验证、设计不确定或范围存在危险的系统。这些应尽早制作原型，无论优先级层级如何。]

| System | Risk Type | Risk Description | Mitigation |
|--------|-----------|-----------------|------------|
| [System] | [Technical / Design / Scope] | [What could go wrong] | [Prototype, research, or scope fallback] |

---

<!-- 中文翻译 -->
## Progress Tracker / 进度追踪

| Metric | Count |
|--------|-------|
| Total systems identified | [N] |
| Design docs started | [N] |
| Design docs reviewed | [N] |
| Design docs approved | [N] |
| MVP systems designed | [N/total MVP] |
| Vertical Slice systems designed | [N/total VS] |

---

<!-- 后续步骤 -->
## Next Steps / 后续步骤

- [ ] Review and approve this systems enumeration / 审查并批准此系统枚举
- [ ] Design MVP-tier systems first (use `/design-system [system-name]`) / 首先设计MVP层级系统（使用 `/design-system [系统名称]`）
- [ ] Run `/design-review` on each completed GDD / 对每个完成的GDD运行 `/design-review`
- [ ] Run `/gate-check pre-production` when MVP systems are designed / 当MVP系统设计完成时运行 `/gate-check pre-production`
- [ ] Prototype the highest-risk system early (`/prototype [system]`) / 尽早为最高风险系统制作原型（`/prototype [系统]`）
