# Systems Index: [Game Title] / 系统索引：[游戏名称]

> **Status**: [Draft / Under Review / Approved] / **状态**: [草稿 / 评审中 / 已批准]
> **Created**: [Date] / **创建**: [日期]
> **Last Updated**: [Date] / **最后更新**: [日期]
> **Source Concept**: design/gdd/game-concept.md / **来源概念**: design/gdd/game-concept.md

---

<!-- 概述 -->
## Overview

[One paragraph explaining the game's mechanical scope. What kind of systems does
this game need? Reference the core loop and game pillars. This should help any
team member understand the "big picture" of what needs to be designed and built.]

---

<!-- 中文翻译 -->
## Systems Enumeration

| # / 序号 | System Name / 系统名称 | Category / 类别 | Priority / 优先级 | Status / 状态 | Design Doc / 设计文档 | Depends On / 依赖 |
|---|-------------|----------|----------|--------|------------|------------|
| 1 | [e.g., Player Controller] | Core | MVP | [Not Started / In Design / In Review / Approved / Implemented] | [design/gdd/player-controller.md or "—"] | [e.g., Input System, Physics] |
| 2 | [e.g., Camera System] | Core | MVP | Not Started | — | Player Controller |

[Add a row for every identified system. Use the categories and priority tiers
defined below. Mark systems that were inferred (not explicitly in the concept doc)
with "(inferred)" in the system name.]

---

<!-- 中文翻译 -->
## Categories

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
Add custom categories if needed.]

---

<!-- 中文翻译 -->
## Priority Tiers

| Tier | Definition | Target Milestone | Design Urgency |
|------|------------|------------------|----------------|
| **MVP** | Required for the core loop to function. Without these, you can't test "is this fun?" | First playable prototype | Design FIRST |
| **Vertical Slice** | Required for one complete, polished area. Demonstrates the full experience. | Vertical slice / demo | Design SECOND |
| **Alpha** | All features present in rough form. Complete mechanical scope, placeholder content OK. | Alpha milestone | Design THIRD |
| **Full Vision** | Polish, edge cases, nice-to-haves, and content-complete features. | Beta / Release | Design as needed |

---

<!-- 中文翻译 -->
## Dependency Map

[Systems sorted by dependency order — design and build from top to bottom.
Systems at the top are foundations; systems at the bottom are wrappers.]

<!-- 中文翻译 -->
### Foundation Layer (no dependencies)

1. [System] — [one-line rationale for why this is foundational]

<!-- 中文翻译 -->
### Core Layer (depends on foundation)

1. [System] — depends on: [list]

<!-- 中文翻译 -->
### Feature Layer (depends on core)

1. [System] — depends on: [list]

<!-- 中文翻译 -->
### Presentation Layer (depends on features)

1. [System] — depends on: [list]

<!-- 中文翻译 -->
### Polish Layer (depends on everything)

1. [System] — depends on: [list]

---

<!-- 中文翻译 -->
## Recommended Design Order

[Combining dependency sort and priority tiers. Design these systems in this
order. Each system's GDD should be completed and reviewed before starting the
next, though independent systems at the same layer can be designed in parallel.]

| Order | System | Priority | Layer | Agent(s) | Est. Effort |
|-------|--------|----------|-------|----------|-------------|
| 1 | [First system to design] | MVP | Foundation | game-designer | [S/M/L] |
| 2 | [Second system] | MVP | Foundation | game-designer | [S/M/L] |

[Effort estimates: S = 1 session, M = 2-3 sessions, L = 4+ sessions.
A "session" is one focused design conversation producing a complete GDD.]

---

<!-- 中文翻译 -->
## Circular Dependencies

[List any circular dependency chains found during analysis. These require
special architectural attention — either break the cycle with an interface,
or design the systems simultaneously.]

- [None found] OR
- [System A <-> System B: Description of the circular relationship and
  proposed resolution]

---

<!-- 中文翻译 -->
## High-Risk Systems

[Systems that are technically unproven, design-uncertain, or scope-dangerous.
These should be prototyped early regardless of priority tier.]

| System | Risk Type | Risk Description | Mitigation |
|--------|-----------|-----------------|------------|
| [System] | [Technical / Design / Scope] | [What could go wrong] | [Prototype, research, or scope fallback] |

---

<!-- 中文翻译 -->
## Progress Tracker

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
## Next Steps

- [ ] Review and approve this systems enumeration
- [ ] Design MVP-tier systems first (use `/design-system [system-name]`)
- [ ] Run `/design-review` on each completed GDD
- [ ] Run `/gate-check pre-production` when MVP systems are designed
- [ ] Prototype the highest-risk system early (`/prototype [system]`)
