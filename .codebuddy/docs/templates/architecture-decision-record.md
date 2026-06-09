# ADR-[NNNN]: [Title] / 架构决策记录-[NNNN]：[标题]

## Status / 状态

[Proposed | Accepted | Deprecated | Superseded by ADR-XXXX] / [提议 | 已接受 | 已弃用 | 被ADR-XXXX取代]

## Date / 日期

[YYYY-MM-DD — when this ADR was written] / [YYYY-MM-DD — 当此ADR被编写时]

## Last Verified / 最后验证

[YYYY-MM-DD — when this ADR was last confirmed accurate against the current / [YYYY-MM-DD — 当此ADR最后被确认与当前引擎版本和设计一致时。
engine version and design. Update this date when you re-read and confirm it / 当您重新阅读并确认它仍然正确时，请更新此日期，
is still correct, even if nothing changed.] / 即使没有任何变化。]

## Decision Makers / 决策者

[Who was involved in this decision] / [谁参与了此决策]

## Summary / 摘要

[2 sentences: what problem this ADR solves, and what was decided. Written for / [2句话：此ADR解决了什么问题，以及决定了什么。为
tiered context loading — a skill scanning 20 ADRs uses this to decide whether / 分层上下文加载而编写——一个扫描20个ADR的技能使用此来
to read the full decision. Be specific: name the system, the problem, and the / 决定是否阅读完整决策。要具体：命名系统、问题以及
chosen approach.] / 选择的方法。]

## Engine Compatibility / 引擎兼容性

| Field / 字段 | Value / 值 |
|-------|-------|
| **Engine** | [e.g. Godot 4.6 / Unity 6 / Unreal Engine 5.4] |
| **Domain** | [Physics / Rendering / UI / Audio / Navigation / Animation / Networking / Core / Input / Scripting] |
| **Knowledge Risk** | [LOW — in training data / MEDIUM — near cutoff, verify / HIGH — post-cutoff, must verify] |
| **References Consulted** | [e.g. `docs/engine-reference/godot/modules/physics.md`, `breaking-changes.md`] |
| **Post-Cutoff APIs Used** | [Specific APIs from post-cutoff engine versions this decision depends on, or "None"] |
| **Verification Required** | [Concrete behaviours to test against the target engine version before shipping, or "None"] |

> **Note**: If Knowledge Risk is MEDIUM or HIGH, this ADR must be re-validated if the / > **注意**: 如果知识风险为中或高，如果项目升级引擎版本，必须重新验证此ADR。
> project upgrades engine versions. Flag it as "Superseded" and write a new ADR. / 将其标记为"被取代"并编写新的ADR。

<!-- ADR 依赖 -->
## ADR Dependencies

| Field / 字段 | Value / 值 |
|-------|-------|
| **Depends On** | [ADR-NNNN (must be Accepted before this can be implemented), or "None"] |
| **Enables** | [ADR-NNNN (this ADR unlocks that decision), or "None"] |
| **Blocks** | [Epic/Story name — cannot start until this ADR is Accepted, or "None"] |
| **Ordering Note** | [Any sequencing constraint that isn't captured above] |

<!-- 上下文 -->
## Context

<!-- 中文翻译 -->
### Problem Statement

[What problem are we solving? Why must this decision be made now? What is the
cost of not deciding?] / [我们要解决什么问题？为什么必须现在做出这个决定？不决定的代价是什么？]

<!-- 中文翻译 -->
### Current State

[How does the system work today? What is wrong with the current approach?] / [当前系统如何工作？当前方法有什么问题？]

<!-- 约束 -->
### Constraints

- [Technical constraints -- engine limitations, platform requirements] / [技术约束——引擎限制、平台需求]
- [Timeline constraints -- deadline pressures, dependencies] / [时间线约束——截止日期压力、依赖关系]
- [Resource constraints -- team size, expertise available] / [资源约束——团队规模、可用专业知识]
- [Compatibility requirements -- must work with existing systems] / [兼容性要求——必须与现有系统协同工作]

<!-- 要求 -->
### Requirements

- [Functional requirement 1] / [功能需求1]
- [Functional requirement 2] / [功能需求2]
- [Performance requirement -- specific, measurable] / [性能需求——具体、可衡量]
- [Scalability requirement] / [可扩展性需求]

<!-- 决策 -->
## Decision

[The specific technical decision, described in enough detail for someone to
implement it without further clarification.] / [具体的技术决策，描述足够详细，以便其他人无需进一步澄清即可实施。]

<!-- 架构 -->
### Architecture / 架构

```
[ASCII diagram showing the system architecture this decision creates.
Show components, data flow direction, and key interfaces.]
[ASCII 图，展示此决策创建的系统架构。
显示组件、数据流方向和关键接口。]
```

### Key Interfaces / 关键接口

```
[Pseudocode or language-specific interface definitions that this decision
creates. These become the contracts that implementers must respect.]
[此决策创建的伪代码或语言特定接口定义。
这些成为实现者必须遵守的契约。]
```

<!-- 中文翻译 -->
### Implementation Guidelines

[Specific guidance for the programmer implementing this decision.] / [为实施此决策的程序员提供的具体指导。]

<!-- 考虑的替代方案 -->
## Alternatives Considered

### Alternative 1: [Name] / [方案1: [名称]]

- **Description**: [How this approach would work] / [描述：此方法将如何工作]
- **Pros**: [What is good about this approach] / [优点：此方法的好处]
- **Cons**: [What is bad about this approach] / [缺点：此方法的坏处]
- **Estimated Effort**: [Relative effort compared to chosen approach] / [预估工作量：与所选方法相比的相对工作量]
- **Rejection Reason**: [Why this was not chosen] / [拒绝原因：为何未选择此方案]

### Alternative 2: [Name] / [方案2: [名称]]

[Same structure as above] / [与上述结构相同]

<!-- 后果 -->
## Consequences

<!-- 中文翻译 -->
### Positive / 积极影响

- [Good outcomes of this decision] / [此决策的好结果]

<!-- 中文翻译 -->
### Negative / 消极影响

- [Trade-offs and costs we are accepting] / [我们接受的权衡和成本]

<!-- 中文翻译 -->
### Neutral / 中性影响

- [Changes that are neither good nor bad, just different] / [既不好也不坏，只是不同的变化]

<!-- 风险 -->
## Risks

| Risk | Probability | Impact | Mitigation |
|------|------------|--------|-----------|

<!-- 性能影响 -->
## Performance Implications

| Metric | Before | Expected After | Budget |
|--------|--------|---------------|--------|
| CPU (frame time) | [X]ms | [Y]ms | [Z]ms |
| Memory | [X]MB | [Y]MB | [Z]MB |
| Load Time | [X]s | [Y]s | [Z]s |
| Network (if applicable) | [X]KB/s | [Y]KB/s | [Z]KB/s |

<!-- 迁移计划 -->
## Migration Plan / 迁移计划

[If this changes existing systems, the step-by-step plan to migrate.] / [如果这改变了现有系统，分步迁移计划。]

1. [Step 1 -- what changes, what breaks, how to verify] / [步骤1——改变什么，破坏什么，如何验证]
2. [Step 2] / [步骤2]
3. [Step 3] / [步骤3]

**Rollback plan**: [How to revert if this decision proves wrong] / **回滚计划**：[如果此决策被证明是错误的，如何恢复]

<!-- 验证标准 -->
## Validation Criteria / 验证标准

[How we will know this decision was correct after implementation.] / [实施后我们如何知道此决策是正确的。]

- [ ] [Measurable criterion 1] / [可衡量的标准1]
- [ ] [Measurable criterion 2] / [可衡量的标准2]
- [ ] [Performance criterion] / [性能标准]

<!-- 满足的 GDD 需求 -->
## GDD Requirements Addressed

<!-- This section is MANDATORY. Every ADR must trace back to at least one GDD
     requirement, or explicitly state it is a foundational decision with no GDD
     dependency. Traceability is audited by /architecture-review. -->

| GDD Document | System | Requirement | How This ADR Satisfies It |
|-------------|--------|-------------|--------------------------|
| [e.g. `design/gdd/combat.md`] | [e.g. Combat] | [e.g. "Hitbox detection must resolve within 1 frame"] | [e.g. "Jolt physics collision queries run synchronously in _physics_process"] |

> If this is a foundational decision with no direct GDD dependency, write:
> "Foundational — no GDD requirement. Enables: [list what GDD systems this
> decision unlocks or constrains]"
> 如果这是一个基础性决策，没有直接依赖 GDD，则写入：
> "基础性 — 无 GDD 需求。支持：[列出此决策解锁或约束的 GDD 系统]"

<!-- 中文翻译 -->
## Related / 相关

- [Link to related ADRs — note if supersedes, contradicts, or depends on] / [相关ADR链接——注明是否取代、矛盾或依赖]
- [Link to relevant code files once implemented] / [实施后相关代码文件链接]
