# ADR-[NNNN]: [Title / 标题]

## Status / 状态

[Proposed / 已提议 | Accepted / 已接受 | Deprecated / 已弃用 | Superseded by ADR-XXXX / 被ADR-XXXX取代]

## Date / 日期

[YYYY-MM-DD — when this ADR was written / YYYY-MM-DD — 此ADR撰写的日期]

## Last Verified / 最后验证

[YYYY-MM-DD — when this ADR was last confirmed accurate against the current
[YYYY-MM-DD — 此ADR最后一次根据当前引擎版本和设计确认准确的日期。
engine version and design. Update this date when you re-read and confirm it
重新阅读并确认它仍然正确时更新此日期，
is still correct, even if nothing changed.]
即使没有变化。]

## Decision Makers / 决策者

[Who was involved in this decision / 谁参与了这个决策]

## Summary / 摘要

[2 sentences: what problem this ADR solves, and what was decided. Written for
[2句话：此ADR解决什么问题，以及做出了什么决定。为
tiered context loading — a skill scanning 20 ADRs uses this to decide whether
to read the full decision. Be specific: name the system, the problem, and the
分层上下文加载而写 — 扫描20个ADR的技能使用此来决定是否阅读完整决策。要具体：命名系统、问题和
chosen approach.]
选择的方法。]

## Engine Compatibility / 引擎兼容性

| Field / 字段 | Value / 值 |
|-------|-------|
| **Engine / 引擎** | [e.g. Godot 4.6 / Unity 6 / Unreal Engine 5.4 / 例如 Godot 4.6 / Unity 6 / Unreal Engine 5.4] |
| **Domain / 领域** | [Physics / 物理 / Rendering / 渲染 / UI / Audio / Navigation / 导航 / Animation / 动画 / Networking / 网络 / Core / 核心 / Input / 输入 / Scripting / 脚本] |
| **Knowledge Risk / 知识风险** | [LOW — in training data / 低 — 在训练数据中 / MEDIUM — near cutoff, verify / 中 — 接近截止点，验证 / HIGH — post-cutoff, must verify / 高 — 截止后，必须验证] |
| **References Consulted / 参考 consulted** | [e.g. `docs/engine-reference/godot/modules/physics.md`, `breaking-changes.md` / 例如 `docs/engine-reference/godot/modules/physics.md`, `breaking-changes.md`] |
| **Post-Cutoff APIs Used / 使用的截止后API** | [Specific APIs from post-cutoff engine versions this decision depends on, or "None" / 此决策依赖的截止后引擎版本的特定API，或"无"] |
| **Verification Required / 需要验证** | [Concrete behaviours to test against the target engine version before shipping, or "None" / 发货前针对目标引擎版本测试的具体行为，或"无"] |

> **Note / 注意**: If Knowledge Risk is MEDIUM or HIGH, this ADR must be re-validated if the
> project upgrades engine versions. Flag it as "Superseded" and write a new ADR.
> 如果知识风险是中或高，如果项目升级引擎版本，此ADR必须重新验证。将其标记为"已取代"并撰写新的ADR。

## ADR Dependencies / ADR依赖

| Field / 字段 | Value / 值 |
|-------|-------|
| **Depends On / 依赖于** | [ADR-NNNN (must be Accepted before this can be implemented), or "None" / ADR-NNNN（必须先接受才能实施），或"无"] |
| **Enables / 启用** | [ADR-NNNN (this ADR unlocks that decision), or "None" / ADR-NNNN（此ADR解锁该决策），或"无"] |
| **Blocks / 阻塞** | [Epic/Story name — cannot start until this ADR is Accepted, or "None" / 史诗/故事名称 — 直到此ADR被接受才能开始，或"无"] |
| **Ordering Note / 排序说明** | [Any sequencing constraint that isn't captured above / 上面未捕获的任何排序约束] |

## Context / 上下文

### Problem Statement / 问题陈述

[What problem are we solving? Why must this decision be made now? What is the
[我们在解决什么问题？为什么现在必须做出这个决定？
cost of not deciding?]
不决策的成本是什么？]

### Current State / 当前状态

[How does the system work today? What is wrong with the current approach?]
[系统今天如何工作？当前方法有什么问题？]

### Constraints / 约束

- [Technical constraints -- engine limitations, platform requirements / 技术约束 — 引擎限制、平台要求]
- [Timeline constraints -- deadline pressures, dependencies / 时间线约束 — 截止日期压力、依赖]
- [Resource constraints -- team size, expertise available / 资源约束 — 团队规模、可用专业知识]
- [Compatibility requirements -- must work with existing systems / 兼容性要求 — 必须与现有系统一起工作]

### Requirements / 需求

- [Functional requirement 1 / 功能需求1]
- [Functional requirement 2 / 功能需求2]
- [Performance requirement -- specific, measurable / 性能需求 — 具体的、可衡量的]
- [Scalability requirement / 可扩展性需求]

## Decision / 决策

[The specific technical decision, described in enough detail for someone to
[具体的技术决策，描述足够详细，以便某人无需进一步澄清即可实现。
implement it without further clarification.]

### Architecture / 架构

```
[ASCII diagram showing the system architecture this decision creates.
[ASCII图显示此决策创建的系统架构。
Show components, data flow direction, and key interfaces.]
显示组件、数据流方向和关键接口。]
```

### Key Interfaces / 关键接口

```
[Pseudocode or language-specific interface definitions that this decision
[此决策创建的伪代码或语言特定接口定义。
creates. These become the contracts that implementers must respect.]
这些成为实现者必须尊重的契约。]
```

### Implementation Guidelines / 实现指南

[Specific guidance for the programmer implementing this decision.]
[为程序员实现此决策的具体指导。]

## Alternatives Considered / 考虑的替代方案

### Alternative 1: [Name / 名称]

- **Description / 描述**: [How this approach would work / 此方法如何工作]
- **Pros / 优点**: [What is good about this approach / 此方法的优点]
- **Cons / 缺点**: [What is bad about this approach / 此方法的缺点]
- **Estimated Effort / 估计工作量**: [Relative effort compared to chosen approach / 与所选方法相比的相对工作量]
- **Rejection Reason / 拒绝原因**: [Why this was not chosen / 为什么未选择此方案]

### Alternative 2: [Name / 名称]

[Same structure as above / 与上述相同结构]

## Consequences / 后果

### Positive / 积极的

- [Good outcomes of this decision / 此决策的良好结果]

### Negative / 消极的

- [Trade-offs and costs we are accepting / 我们正在接受的权衡和成本]

### Neutral / 中性的

- [Changes that are neither good nor bad, just different / 既不好也不坏的变化，只是不同]

## Risks / 风险

| Risk / 风险 | Probability / 概率 | Impact / 影响 | Mitigation / 缓解 |
|------|------------|--------|-----------|

## Performance Implications / 性能影响

| Metric / 指标 | Before / 之前 | Expected After / 预期之后 | Budget / 预算 |
|--------|--------|---------------|--------|
| CPU (frame time) / CPU（帧时间） | [X]ms | [Y]ms | [Z]ms |
| Memory / 内存 | [X]MB | [Y]MB | [Z]MB |
| Load Time / 加载时间 | [X]s | [Y]s | [Z]s |
| Network (if applicable) / 网络（如适用） | [X]KB/s | [Y]KB/s | [Z]KB/s |

## Migration Plan / 迁移计划

[If this changes existing systems, the step-by-step plan to migrate.]
[如果这改变了现有系统，迁移的分步计划。]

1. [Step 1 -- what changes, what breaks, how to verify / 步骤1 — 什么变化、什么中断、如何验证]
2. [Step 2 / 步骤2]
3. [Step 3 / 步骤3]

**Rollback plan / 回滚计划**: [How to revert if this decision proves wrong / 如果此决策证明错误，如何回滚]
