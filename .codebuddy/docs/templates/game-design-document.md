# [Mechanic/System Name] / [机制/系统名称]

> **Status**: Draft | In Review | Approved | Implemented / **状态**: 草稿 | 评审中 | 已批准 | 已实现
> **Author**: [Agent or person] / **作者**: [代理或人员]
> **Last Updated**: [Date] / **最后更新**: [日期]
> **Last Verified**: [Date — when this doc was last confirmed accurate against current design] / **最后验证**: [日期——当本文档最后确认与当前设计一致时]
> **Implements Pillar**: [Which game pillar this supports] / **实现的支柱**: [该文档支持的游戏支柱]

## Summary / 摘要

[2–3 sentences: what this system is, what it does for the player, and why it / [2-3句话：这个系统是什么，它为玩家做什么，以及为什么它
exists in this game. Written for tiered context loading — a skill scanning / 存在于这个游戏中。为分层上下文加载而编写——一个扫描
20 GDDs uses this section to decide whether to read further. No jargon.] / 20个GDD的技能使用此部分来决定是否继续阅读。避免使用术语。]

> **Quick reference** — Layer: `[Foundation | Core | Feature | Presentation]` · Priority: `[MVP | Vertical Slice | Alpha | Full Vision]` · Key deps: `[System names or "None"]` / > **快速参考** — 层级: `[基础 | 核心 | 功能 | 表现]` · 优先级: `[MVP | 垂直切片 | Alpha | 完整愿景]` · 关键依赖: `[系统名称或"无"]`

## Overview / 概述

[One paragraph that explains this mechanic to someone who knows nothing about / [一段话，向对该项目一无所知的人解释这个机制。它是什么，
the project. What is it, what does the player做什么，以及它为什么存在？] / 玩家做什么，以及它为什么存在？]

## Player Fantasy / 玩家幻想

[What should the player FEEL when engaging with this mechanic? What is the / [玩家参与这个机制时应该感受到什么？正在提供的是什么样的
emotional or power fantasy being served? This section guides all detail / 情感或力量幻想？此部分指导下面所有的细节决策。]
decisions below.]

<!-- 详细设计 -->
## Detailed Design / 详细设计

<!-- 中文翻译 -->
### Core Rules / 核心规则

[Precise, unambiguous rules. A programmer should be able to implement this
section without asking questions. Use numbered rules for sequential processes
and bullet points for properties.] / [精确、明确的规则。程序员应该能够在不提问的情况下实现此部分。对顺序过程使用编号规则，对属性使用项目符号。]

<!-- 中文翻译 -->
### States and Transitions / 状态和转换

[If this system has states (e.g., weapon states, status effects, phases),
document every state and every valid transition between states.] / [如果此系统有状态（例如，武器状态、状态效果、阶段），记录每个状态和每个有效状态转换。]

| State / 状态 | Entry Condition / 进入条件 | Exit Condition / 退出条件 | Behavior / 行为 |
|-------|----------------|----------------|----------|

<!-- 中文翻译 -->
### Interactions with Other Systems / 与其他系统的交互

[How does this system interact with combat? Inventory? Progression? UI?
For each interaction, specify the interface: what data flows in, what flows
out, and who is responsible for what.] / [此系统如何与战斗交互？库存？进度？UI？对于每个交互，指定接口：什么数据流入，什么数据流出，以及谁负责什么。]

<!-- 公式 -->
## Formulas / 公式

[Every mathematical formula used by this system. For each formula:] / [此系统使用的每个数学公式。对于每个公式：]

### [Formula Name] / [公式名称]

```
result = base_value * (1 + modifier_sum) * scaling_factor
```

| Variable / 变量 | Type / 类型 | Range / 范围 | Source / 来源 | Description / 描述 |
|----------|------|-------|--------|-------------|
| base_value | float | 1-100 | data file | The base amount before modifiers / 修改前的基础值 |
| modifier_sum | float | -0.9 to 5.0 | calculated | Sum of all active modifiers / 所有活动修改器之和 |
| scaling_factor | float | 0.5-2.0 | data file | Level-based scaling / 基于等级的缩放 |

**Expected output range**: [min] to [max] / **预期输出范围**：[最小值]到[最大值]
**Edge case**: When modifier_sum < -0.9, clamp to -0.9 to prevent negative results. / **边界情况**：当modifier_sum < -0.9时，限制为-0.9以防止负结果。

<!-- 边界情况 -->
## Edge Cases / 边界情况

[Explicitly document what happens in unusual situations. Each edge case
should have a clear resolution.] / [明确记录异常情况下发生的情况。每个边界情况应有明确解决方案。]

| Scenario / 场景 | Expected Behavior / 预期行为 | Rationale / 理由 |
|----------|------------------|-----------|
| [What if X is zero?] | [This happens] | [Because of this reason] / [因为此原因] |
| [What if both effects trigger?] | [Priority rule] | [Design reasoning] / [设计推理] |

<!-- 依赖 -->
## Dependencies / 依赖

[List every system this mechanic depends on or that depends on this mechanic.] / [列出此机制依赖的每个系统或依赖此机制的每个系统。]

| System / 系统 | Direction / 方向 | Nature of Dependency / 依赖性质 |
|--------|-----------|---------------------|
| [Combat] | This depends on Combat / 此依赖战斗 | Needs damage calculation results / 需要伤害计算结果 |
| [Inventory] | Inventory depends on this / 库存依赖此 | Provides item effect data / 提供物品效果数据 |

<!-- 调节旋钮 -->
## Tuning Knobs / 调节旋钮

[Every value that should be adjustable for balancing. Include the current
value, the safe range, and what happens at the extremes.] / [每个应可调节以平衡的值。包括当前值、安全范围以及在极端情况下的影响。]

| Parameter / 参数 | Current Value / 当前值 | Safe Range / 安全范围 | Effect of Increase / 增加的影响 | Effect of Decrease / 减少的影响 |
|-----------|--------------|------------|-------------------|-------------------|

<!-- 中文翻译 -->
## Visual/Audio Requirements

[What visual and audio feedback does this mechanic need?]

| Event | Visual Feedback | Audio Feedback | Priority |
|-------|----------------|---------------|----------|

<!-- 中文翻译 -->
## Game Feel

> **Why this section exists separately from Visual/Audio Requirements**: Visual/Audio
> Requirements document WHAT feedback events occur (tables of events mapped to assets).
> Game Feel documents HOW the mechanic feels to operate — the responsiveness, weight,
> snap, and kinesthetic quality of the interaction. These are design targets for timing,
> frame data, and physical sensation of control. Game feel must be specified at design
> time because it drives animation budgets, input handling architecture, and hitbox
> timing. Retrofitting feel targets after implementation is expensive and often requires
> fundamental rework.

<!-- 中文翻译 -->
### Feel Reference

[Name a specific game, mechanic, or moment that captures the target feel. Be precise —
cite the exact mechanic, not just the game. Explain what quality you are borrowing.
Optionally include an anti-reference (what this should NOT feel like).]

> Example: "Should feel like Dark Souls weapon swings — weighty, committed, and
> telegraphed, but satisfying on contact. NOT floaty like early Halo melee."

<!-- 中文翻译 -->
### Input Responsiveness

[Maximum acceptable latency from player input to visible/audible response, per action.]

| Action | Max Input-to-Response Latency (ms) | Frame Budget (at 60fps) | Notes |
|--------|-----------------------------------|------------------------|-------|
| [Primary action] | [e.g., 50ms] | [e.g., 3 frames] | |
| [Secondary action] | | | |

<!-- 中文翻译 -->
### Animation Feel Targets

[Frame data targets for each animation in this mechanic. Startup = windup before the
action has any effect. Active = frames when the action is "happening" (hitbox live,
ability firing, etc.). Recovery = committed/vulnerable frames after the action resolves.]

| Animation | Startup Frames | Active Frames | Recovery Frames | Feel Goal | Notes |
|-----------|---------------|--------------|----------------|-----------|-------|
| [e.g., Light attack] | | | | [e.g., Snappy, low commitment] | |
| [e.g., Heavy attack] | | | | [e.g., Weighty, high commitment] | |

<!-- 中文翻译 -->
### Impact Moments

[Defines the punctuation of the mechanic — the moments of peak feedback intensity that
make actions feel consequential. Every high-stakes event should have at least one entry.]

| Impact Type | Duration (ms) | Effect Description | Configurable? |
|-------------|--------------|-------------------|---------------|
| Hit-stop (freeze frames) | [e.g., 80ms] | [Freeze both objects on contact] | Yes |
| Screen shake | [e.g., 150ms] | [Directional, decaying] | Yes |
| Camera impact | | | |
| Controller rumble | | | |
| Time-scale slowdown | | | |

<!-- 中文翻译 -->
### Weight and Responsiveness Profile

[A short prose description of the overall feel target. Answer the following:]

- **Weight**: Does this feel heavy and deliberate, or light and reactive?
- **Player control**: How much does the player feel in control at every moment?
  (High control = can course-correct mid-action; Low control = committed, momentum-based)
- **Snap quality**: Does this feel crisp and binary, or smooth and analog?
- **Acceleration model**: Does movement/action start instantly (arcade feel) or
  ramp up from zero (simulation feel)? Same question for deceleration.
- **Failure texture**: When the player makes an error, does the mechanic feel fair
  or punishing? What is the read on WHY they failed?

<!-- 中文翻译 -->
### Feel Acceptance Criteria

[Specific, testable criteria a playtester can verify without measurement instruments.
These are subjective targets stated precisely enough to get consistent verdicts.]

- [ ] [e.g., "Combat feels impactful — playtesters comment on weight unprompted"]
- [ ] [e.g., "No reviewer uses the words 'floaty', 'slippery', or 'unresponsive'"]
- [ ] [e.g., "Input latency is imperceptible at target 60fps framerate"]
- [ ] [e.g., "Hit-stop reads as satisfying, not as lag or stutter"]

<!-- 中文翻译 -->
## UI Requirements

[What information needs to be displayed to the player and when?]

| Information | Display Location | Update Frequency | Condition |
|-------------|-----------------|-----------------|-----------|

<!-- 中文翻译 -->
## Cross-References

[Declare every explicit dependency on another GDD's specific mechanic, value, or
rule. This table is machine-checked by `/review-all-gdds` Phase 2c — it replaces
implicit prose references with verifiable declarations. If you reference another
system's behaviour anywhere in this document, it must appear here.]

| This Document References | Target GDD | Specific Element Referenced | Nature |
|--------------------------|-----------|----------------------------|--------|
| [e.g., "combo multiplier feeds score"] | `design/gdd/score.md` | `combo_multiplier` output value | Data dependency |
| [e.g., "death triggers respawn"] | `design/gdd/respawn.md` | Death state transition | State trigger |
| [e.g., "stamina gates dodge"] | `design/gdd/stamina.md` | Stamina depletion rule | Rule dependency |

> **Note on "Nature"**: use one of — `Data dependency` (we consume their output),
> `State trigger` (their state change triggers our behaviour), `Rule dependency`
> (our rule assumes their rule is also true), `Ownership handoff` (we hand off
> ownership of a value to them).

<!-- 验收标准 -->
## Acceptance Criteria

[Testable criteria that confirm this mechanic is working as designed.]

- [ ] [Criterion 1: specific, measurable, testable]
- [ ] [Criterion 2]
- [ ] [Criterion 3]
- [ ] Performance: System update completes within [X]ms
- [ ] No hardcoded values in implementation

<!-- 待解决问题 -->
## Open Questions

[Anything not yet decided. Each question should have an owner and deadline.]

| Question | Owner | Deadline | Resolution |
|----------|-------|----------|-----------|
