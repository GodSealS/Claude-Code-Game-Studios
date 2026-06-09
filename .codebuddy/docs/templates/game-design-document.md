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

## Visual/Audio Requirements / 视觉/音频需求

[What visual and audio feedback does this mechanic need? / 这个机制需要什么视觉和音频反馈？]

| Event / 事件 | Visual Feedback / 视觉反馈 | Audio Feedback / 音频反馈 | Priority / 优先级 |
|-------|----------------|---------------|----------|

## Game Feel / 游戏手感

> **Why this section exists separately from Visual/Audio Requirements / 为什么此部分与视觉/音频需求分开**: Visual/Audio
> Requirements document WHAT feedback events occur (tables of events mapped to assets) / 视觉/音频需求记录发生哪些反馈事件（事件与资源映射表）。
> Game Feel documents HOW the mechanic feels to operate — the responsiveness, weight,
> snap, and kinesthetic quality of the interaction. These are design targets for timing,
> frame data, and physical sensation of control. Game feel must be specified at design
> time because it drives animation budgets, input handling architecture, and hitbox
> timing. Retrofitting feel targets after implementation is expensive and often requires
> fundamental rework. / 游戏手感记录机制操作时的感觉——响应性、重量感、干脆感和交互的运动质感。这些是时序、帧数据和操控物理感的设计目标。游戏手感必须在设计阶段指定，因为它驱动动画预算、输入处理架构和命中框时序。实现后返工手感目标成本高昂且通常需要根本性重构。

### Feel Reference / 手感参考

[Name a specific game, mechanic, or moment that captures the target feel. Be precise —
cite the exact mechanic, not just the game. Explain what quality you are borrowing.
Optionally include an anti-reference (what this should NOT feel like). / 列举一个能体现目标手感的具体游戏、机制或时刻。要精确——引用具体机制，而非仅提游戏名。解释你借鉴了哪种特质。可选择性地包含一个反参考（这不应该是什么感觉）。]

> Example: "Should feel like Dark Souls weapon swings — weighty, committed, and
> telegraphed, but satisfying on contact. NOT floaty like early Halo melee."
> 示例：“手感应如《黑暗之魂》的武器挥舞——有分量、有预备动作、有预兆，但命中时令人满足。不能像早期《光环》的近战那样轻飘。”

### Input Responsiveness / 输入响应性

[Maximum acceptable latency from player input to visible/audible response, per action. / 每个动作从玩家输入到可见/可听响应的最大可接受延迟。]

| Action / 动作 | Max Input-to-Response Latency (ms) / 最大输入到响应延迟(毫秒) | Frame Budget (at 60fps) / 帧预算(60fps下) | Notes / 备注 |
|--------|-----------------------------------|------------------------|-------|
| [Primary action] / [主要动作] | [e.g., 50ms] | [e.g., 3 frames] | |
| [Secondary action] / [次要动作] | | | |

### Animation Feel Targets / 动画手感目标

[Frame data targets for each animation in this mechanic. Startup = windup before the
action has any effect. Active = frames when the action is "happening" (hitbox live,
ability firing, etc.). Recovery = committed/vulnerable frames after the action resolves. / 此机制中每个动画的帧数据目标。启动帧 = 动作产生效果前的预备帧。活跃帧 = 动作“发生”时的帧（命中框生效、能力触发等）。恢复帧 = 动作解决后的硬直/易伤帧。]

| Animation / 动画 | Startup Frames / 启动帧 | Active Frames / 活跃帧 | Recovery Frames / 恢复帧 | Feel Goal / 手感目标 | Notes / 备注 |
|-----------|---------------|--------------|----------------|-----------|-------|
| [e.g., Light attack] / [例：轻攻击] | | | | [e.g., Snappy, low commitment] / [例：干脆，低投入] | |
| [e.g., Heavy attack] / [例：重攻击] | | | | [e.g., Weighty, high commitment] / [例：有分量，高投入] | |

### Impact Moments / 冲击时刻

[Defines the punctuation of the mechanic — the moments of peak feedback intensity that
make actions feel consequential. Every high-stakes event should have at least one entry. / 定义机制的标点时刻——那些峰值反馈强度让动作感觉后果严重的时刻。每个高风险事件都应至少有一个条目。]

| Impact Type / 冲击类型 | Duration (ms) / 持续时间(毫秒) | Effect Description / 效果描述 | Configurable? / 可配置? |
|-------------|--------------|-------------------|---------------|
| Hit-stop (freeze frames) / 命中停止（冻结帧） | [e.g., 80ms] | [Freeze both objects on contact] / [接触时冻结两个对象] | Yes / 是 |
| Screen shake / 屏幕震动 | [e.g., 150ms] | [Directional, decaying] / [方向性，衰减] | Yes / 是 |
| Camera impact / 相机冲击 | | | |
| Controller rumble / 手柄震动 | | | |
| Time-scale slowdown / 时间缩放减慢 | | | |

### Weight and Responsiveness Profile / 重量感与响应性概况

[A short prose description of the overall feel target. Answer the following: / 对整体手感目标的简短描述。回答以下问题：]

- **Weight / 重量感**: Does this feel heavy and deliberate, or light and reactive? / 这感觉是沉重而审慎的，还是轻盈而反应迅速的？
- **Player control / 玩家控制**: How much does the player feel in control at every moment?
  (High control = can course-correct mid-action; Low control = committed, momentum-based) / 玩家在每一刻感觉有多少控制权？（高控制 = 可在动作中修正；低控制 =  committed，基于动量）
- **Snap quality / 干脆感质量**: Does this feel crisp and binary, or smooth and analog? / 这感觉是干脆且二元的，还是平滑且模拟的？
- **Acceleration model / 加速模型**: Does movement/action start instantly (arcade feel) or
  ramp up from zero (simulation feel)? Same question for deceleration. / 移动/动作是瞬间开始的（街机感）还是从零加速的（模拟感）？减速同理。
- **Failure texture / 失败质感**: When the player makes an error, does the mechanic feel fair
  or punishing? What is the read on WHY they failed? / 当玩家犯错时，机制感觉是公平的还是惩罚性的？他们能读懂为什么失败吗？

### Feel Acceptance Criteria / 手感验收标准

[Specific, testable criteria a playtester can verify without measurement instruments.
These are subjective targets stated precisely enough to get consistent verdicts. / 具体的、可测试的标准，让试玩者无需测量仪器即可验证。这些主观目标需表述得足够精确，以获得一致的判断。]

- [ ] [e.g., "Combat feels impactful — playtesters comment on weight unprompted" / 例：“战斗感觉有冲击力——试玩者会主动评论重量感"]
- [ ] [e.g., "No reviewer uses the words 'floaty', 'slippery', or 'unresponsive'" / 例：“没有评测者使用‘轻飘’、‘滑溜’或‘无响应’等词"]
- [ ] [e.g., "Input latency is imperceptible at target 60fps framerate" / 例：“在目标60fps帧率下输入延迟不可感知"]
- [ ] [e.g., "Hit-stop reads as satisfying, not as lag or stutter" / 例：“命中停止读起来令人满意，而非卡顿或结巴"]

## UI Requirements / UI需求

[What information needs to be displayed to the player and when? / 需要向玩家显示什么信息以及何时显示？]

| Information / 信息 | Display Location / 显示位置 | Update Frequency / 更新频率 | Condition / 条件 |
|-------------|-----------------|-----------------|-----------|

## Cross-References / 交叉引用

[Declare every explicit dependency on another GDD's specific mechanic, value, or
rule. This table is machine-checked by `/review-all-gdds` Phase 2c — it replaces
implicit prose references with verifiable declarations. If you reference another
system's behaviour anywhere in this document, it must appear here. / 声明对另一个GDD特定机制、值或规则的每个显式依赖。此表由`/review-all-gdds`第2c阶段进行机器检查——它用可验证的声明替换隐式散文引用。如果你在本文档中引用另一个系统的行为，它必须出现在此处。]

| This Document References / 本文档引用 | Target GDD / 目标GDD | Specific Element Referenced / 引用的具体元素 | Nature / 性质 |
|--------------------------|-----------|----------------------------|--------|
| [e.g., "combo multiplier feeds score"] / [例：“连击乘数馈入分数”] | `design/gdd/score.md` | `combo_multiplier` output value / `combo_multiplier`输出值 | Data dependency / 数据依赖 |
| [e.g., "death triggers respawn"] / [例：“死亡触发重生”] | `design/gdd/respawn.md` | Death state transition / 死亡状态转换 | State trigger / 状态触发器 |
| [e.g., "stamina gates dodge"] / [例：“耐力门控闪避”] | `design/gdd/stamina.md` | Stamina depletion rule / 耐力消耗规则 | Rule dependency / 规则依赖 |

> **Note on "Nature" / “性质”说明**: use one of — `Data dependency` (we consume their output) / 使用之一——`数据依赖`（我们消费他们的输出）,
> `State trigger` (their state change triggers our behaviour) / `状态触发器`（他们的状态变化触发我们的行为）, `Rule dependency`
> (our rule assumes their rule is also true) / （我们的规则假设他们的规则也为真）, `Ownership handoff` (we hand off
> ownership of a value to them) / `所有权移交`（我们将一个值的所有权移交给他们）。

## Acceptance Criteria / 验收标准

[Testable criteria that confirm this mechanic is working as designed. / 可测试的标准，确认此机制按设计工作。]

- [ ] [Criterion 1: specific, measurable, testable] / [标准1：具体、可衡量、可测试]
- [ ] [Criterion 2] / [标准2]
- [ ] [Criterion 3] / [标准3]
- [ ] Performance: System update completes within [X]ms / 性能：系统更新在[X]毫秒内完成
- [ ] No hardcoded values in implementation / 实现中没有硬编码值

## Open Questions / 待解决问题

[Anything not yet decided. Each question should have an owner and deadline. / 任何尚未决定的事项。每个问题应有一个负责人和截止日期。]

| Question / 问题 | Owner / 负责人 | Deadline / 截止日期 | Resolution / 解决方案 |
|----------|-------|----------|-----------|
