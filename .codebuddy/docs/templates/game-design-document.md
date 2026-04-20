# [Mechanic/System Name / 机制/系统名称]

> **Status / 状态**: Draft / 草稿 | In Review / 审核中 | Approved / 已批准 | Implemented / 已实现
> **Author / 作者**: [Agent or person / 代理或人员]
> **Last Updated / 最后更新**: [Date / 日期]
> **Last Verified / 最后验证**: [Date — when this doc was last confirmed accurate against current design / 日期 — 本文档最后一次根据当前设计确认准确的日期]
> **Implements Pillar / 实现支柱**: [Which game pillar this supports / 此机制支持的游戏支柱]

## Summary / 摘要

[2–3 sentences: what this system is, what it does for the player, and why it
[2-3句话：这个系统是什么，它为玩家做什么，以及为什么
exists in this game. Written for tiered context loading — a skill scanning
存在于这个游戏中。为分层上下文加载而写 — 扫描
20 GDDs uses this section to decide whether to read further. No jargon.]
20个GDD的技能使用此章节来决定是否继续阅读。没有术语。]

> **Quick reference / 快速参考** — Layer: `[Foundation / 基础 | Core / 核心 | Feature / 特性 | Presentation / 表现]` · Priority: `[MVP | Vertical Slice / 垂直切片 | Alpha / Alpha版 | Full Vision / 完整愿景]` · Key deps: `[System names or "None" / 系统名称或"无"]`

## Overview / 概述

[One paragraph that explains this mechanic to someone who knows nothing about
[一段话向对此项目一无所知的人解释这个机制。
the project. What is it, what does the player do, and why does it exist?]
它是什么，玩家做什么，以及为什么它存在？]

## Player Fantasy / 玩家幻想

[What should the player FEEL when engaging with this mechanic? What is the
[玩家在使用这个机制时应该感受到什么？
emotional or power fantasy being served? This section guides all detail
正在满足的情感或力量幻想是什么？此章节指导下面的所有细节
decisions below.]
决策。]

## Detailed Design / 详细设计

### Core Rules / 核心规则

[Precise, unambiguous rules. A programmer should be able to implement this
[精确、明确的规则。程序员应该能够根据此章节实现
section without asking questions. Use numbered rules for sequential processes
无需提问。对顺序过程使用编号规则，
and bullet points for properties.]
对属性使用项目符号。]

### States and Transitions / 状态和转换

[If this system has states (e.g., weapon states, status effects, phases),
[如果此系统有状态（例如，武器状态、状态效果、阶段），
document every state and every valid transition between states.]
记录每个状态以及状态之间的每个有效转换。]

| State / 状态 | Entry Condition / 进入条件 | Exit Condition / 退出条件 | Behavior / 行为 |
|-------|----------------|----------------|----------|

### Interactions with Other Systems / 与其他系统的交互

[How does this system interact with combat? Inventory? Progression? UI?
[此系统如何与战斗、库存、进度、UI交互？
For each interaction, specify the interface: what data flows in, what flows
对于每个交互，指定接口：什么数据流入，什么流出，
out, and who is responsible for what.]
以及谁负责什么。]

## Formulas / 公式

[Every mathematical formula used by this system. For each formula:]
[此系统使用的每个数学公式。对于每个公式：]

### [Formula Name / 公式名称]

```
result = base_value * (1 + modifier_sum) * scaling_factor
```

| Variable / 变量 | Type / 类型 | Range / 范围 | Source / 来源 | Description / 描述 |
|----------|------|-------|--------|-------------|
| base_value | float | 1-100 | data file / 数据文件 | The base amount before modifiers / 修饰符之前的基础数量 |
| modifier_sum | float | -0.9 to 5.0 | calculated / 计算 | Sum of all active modifiers / 所有活跃修饰符的总和 |
| scaling_factor | float | 0.5-2.0 | data file / 数据文件 | Level-based scaling / 基于等级的缩放 |

**Expected output range / 预期输出范围**: [min] to [max]
**Edge case / 边界情况**: When modifier_sum < -0.9, clamp to -0.9 to prevent negative results. / 当 modifier_sum < -0.9 时，钳制到 -0.9 以防止负结果。

## Edge Cases / 边界情况

[Explicitly document what happens in unusual situations. Each edge case
[明确记录异常情况下的发生。每个边界情况
should have a clear resolution.]
应该有明确的解决方案。]

| Scenario / 场景 | Expected Behavior / 预期行为 | Rationale / 理由 |
|----------|------------------|-----------|
| [What if X is zero? / 如果X为零怎么办？] | [This happens / 这会发生] | [Because of this reason / 因为这个原因] |
| [What if both effects trigger? / 如果两个效果都触发怎么办？] | [Priority rule / 优先级规则] | [Design reasoning / 设计理由] |

## Dependencies / 依赖

[List every system this mechanic depends on or that depends on this mechanic.]
[列出此机制依赖的或依赖此机制的每个系统。]

| System / 系统 | Direction / 方向 | Nature of Dependency / 依赖性质 |
|--------|-----------|---------------------|
| [Combat / 战斗] | This depends on Combat / 此依赖战斗 | Needs damage calculation results / 需要伤害计算结果 |
| [Inventory / 库存] | Inventory depends on this / 库存依赖此 | Provides item effect data / 提供物品效果数据 |

## Tuning Knobs / 调整参数

[Every value that should be adjustable for balancing. Include the current
[每个应该可调整以进行平衡的值。包括当前
value, the safe range, and what happens at the extremes.]
值、安全范围以及极端情况下的发生。]

| Parameter / 参数 | Current Value / 当前值 | Safe Range / 安全范围 | Effect of Increase / 增加的效果 | Effect of Decrease / 减少的效果 |
|-----------|--------------|------------|-------------------|-------------------|

## Visual/Audio Requirements / 视觉/音频需求

[What visual and audio feedback does this mechanic need?]
[此机制需要什么视觉和音频反馈？]

| Event / 事件 | Visual Feedback / 视觉反馈 | Audio Feedback / 音频反馈 | Priority / 优先级 |
|-------|----------------|---------------|----------|

## Game Feel / 游戏感觉

> **Why this section exists separately from Visual/Audio Requirements / 为什么此章节与视觉/音频需求分开**: Visual/Audio
> Requirements document WHAT feedback events occur (tables of events mapped to assets).
> 需求记录什么反馈事件发生（映射到资源的事件表）。
> Game Feel documents HOW the mechanic feels to operate — the responsiveness, weight,
> 游戏感觉记录机制操作的感觉 — 响应性、重量感、
> snap, and kinesthetic quality of the interaction. These are design targets for timing,
> 干脆感和互动的动觉质量。这些是时机的设计目标，
> frame data, and physical sensation of control. Game feel must be specified at design
> 帧数据和控制的身体感觉。游戏感觉必须在设计时指定，
> time because it drives animation budgets, input handling architecture, and hitbox
> 因为它驱动动画预算、输入处理架构和命中框
> timing. Retrofitting feel targets after implementation is expensive and often requires
> 时机。实现后改装感觉目标是昂贵的，通常需要
> fundamental rework. / 根本性返工。

### Feel Reference / 感觉参考

[Name a specific game, mechanic, or moment that captures the target feel. Be precise —
[命名一个捕捉目标感觉的具体游戏、机制或时刻。要精确 —
cite the exact mechanic, not just the game. Explain what quality you are borrowing.
引用确切的机制，而不仅仅是游戏。解释您借用的品质。
Optionally include an anti-reference (what this should NOT feel like).]
可选地包括反参考（这不应该是的感觉）。]

> Example / 示例: "Should feel like Dark Souls weapon swings — weighty, committed, and
> telegraphed, but satisfying on contact. NOT floaty like early Halo melee."
> "应该感觉像黑暗之魂的武器挥动 — 有重量、坚定且
> 预告明显，但接触时令人满意。不像早期光环的近战那样漂浮。"

### Input Responsiveness / 输入响应

[Maximum acceptable latency from player input to visible/audible response, per action.]
[每次动作从玩家输入到可见/可听响应的最大可接受延迟。]

| Action / 动作 | Max Input-to-Response Latency (ms) / 最大输入到响应延迟(毫秒) | Frame Budget (at 60fps) / 帧预算(60fps) | Notes / 备注 |
|--------|-----------------------------------|------------------------|-------|
| [Primary action / 主要动作] | [e.g., 50ms / 例如50ms] | [e.g., 3 frames / 例如3帧] | |
| [Secondary action / 次要动作] | | | |

### Animation Feel Targets / 动画感觉目标

[Frame data targets for each animation in this mechanic. Startup = windup before the
[此机制中每个动画的帧数据目标。Startup = 动作有任何效果之前的准备时间。
action has any effect. Active = frames when the action is "happening" (hitbox live,
Active = 动作"发生"时的帧（命中框生效、
ability firing, etc.). Recovery = committed/vulnerable frames after the action resolves.]
能力发射等）。Recovery = 动作解决后的承诺/脆弱帧。]

| Animation / 动画 | Startup Frames / 启动帧 | Active Frames / 活跃帧 | Recovery Frames / 恢复帧 | Feel Goal / 感觉目标 | Notes / 备注 |
|-----------|---------------|--------------|----------------|-----------|-------|
| [e.g., Light attack / 例如，轻攻击] | | | | [e.g., Snappy, low commitment / 例如，干脆，低承诺] | |
| [e.g., Heavy attack / 例如，重攻击] | | | | [e.g., Weighty, high commitment / 例如，有重量，高承诺] | |

### Impact Moments / 冲击时刻

[Defines the punctuation of the mechanic — the moments of peak feedback intensity that
[定义机制的标点 — 峰值反馈强度的时刻，
make actions feel consequential. Every high-stakes event should have at least one entry.]
使动作感觉有意义。每个高风险事件应该至少有一个条目。]

| Impact Type / 冲击类型 | Duration (ms) / 持续时间(毫秒) | Effect Description / 效果描述 | Configurable? / 可配置？ |
|-------------|--------------|-------------------|---------------|
| Hit-stop (freeze frames) / 命中停止（冻结帧） | [e.g., 80ms / 例如80ms] | [Freeze both objects on contact / 接触时冻结两个对象] | Yes / 是 |
