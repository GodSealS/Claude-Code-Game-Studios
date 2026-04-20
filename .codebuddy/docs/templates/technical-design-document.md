# 技术设计: [System Name / 系统名称]

## Document Status / 文档状态
- **Version / 版本**: 1.0
- **Last Updated / 最后更新**: [Date / 日期]
- **Author / 作者**: [Agent/Person / 代理/人员]
- **Reviewer / 审核人**: lead-programmer
- **Related ADR / 相关ADR**: [ADR-XXXX if applicable / 如适用]
- **Related Design Doc / 相关设计文档**: [Link to game design doc this implements / 链接到其实现的游戏设计文档]

## Engine API Surface / 引擎API表面

| Field / 字段 | Value / 值 |
|-------|-------|
| **Engine / 引擎** | [e.g. Godot 4.6 / Unity 6 / Unreal Engine 5.4 / 例如 Godot 4.6 / Unity 6 / Unreal Engine 5.4] |
| **APIs Depended On / 依赖的API** | [Specific classes/methods/nodes used, version-pinned — e.g. `CharacterBody3D.move_and_slide() (Godot 4.x)` / 使用的特定类/方法/节点，版本锁定 — 例如 `CharacterBody3D.move_and_slide() (Godot 4.x)`] |
| **References Consulted / 参考的文档** | [engine-reference docs read before writing this — e.g. `docs/engine-reference/godot/modules/physics.md` / 编写本文档前阅读的引擎参考文档 — 例如 `docs/engine-reference/godot/modules/physics.md`] |
| **Post-Cutoff Features Used / 使用的训练截止后特性** | [Features from engine versions beyond LLM training cutoff, or "None" / 来自LLM训练截止日期之后的引擎版本特性，或"无"] |
| **Unverified Assumptions / 未验证假设** | [API behaviours assumed but not yet tested against the target version, or "None" / 假设但尚未针对目标版本测试的API行为，或"无"] |
| **Engine Upgrade Risk / 引擎升级风险** | [LOW / MEDIUM / HIGH — how fragile is this design if the engine version changes? / 低 / 中 / 高 — 如果引擎版本更改，此设计的脆弱程度如何？] |

> **Rule / 规则**: If any **Unverified Assumptions** are listed, this document cannot be marked
> as Accepted until those assumptions are validated in the actual engine environment.
> 如果列出了任何**未验证假设**，在假设通过实际引擎环境验证之前，本文档不能被标记为已接受。

## Overview / 概述
[2-3 sentence summary of what this system does and why it exists / 2-3句话总结此系统的作用和存在原因]

## Requirements / 需求

### Functional Requirements / 功能需求
- [FR-1]: [Description / 描述]
- [FR-2]: [Description / 描述]

### Non-Functional Requirements / 非功能需求
- **Performance / 性能**: [Budget — e.g., "< 1ms per frame" / 预算 — 例如，"< 1ms每帧"]
- **Memory / 内存**: [Budget — e.g., "< 50MB at peak" / 预算 — 例如，"峰值< 50MB"]
- **Scalability / 可扩展性**: [Limits — e.g., "Support up to 1000 entities" / 限制 — 例如，"支持多达1000个实体"]
- **Thread Safety / 线程安全**: [Requirements / 需求]

## Architecture / 架构

### System Diagram / 系统图表
```
[ASCII diagram showing components and data flow / ASCII图显示组件和数据流]
```

### Component Breakdown / 组件分解
| Component / 组件 | Responsibility / 职责 | Owns / 拥有 |
| --------- | -------------- | ---- |
| [Name / 名称] | [What it does / 它的作用] | [What data it owns / 它拥有的数据] |

### Public API / 公共API
```
[Interface/API definition in pseudocode or target language / 伪代码或目标语言中的接口/API定义]
```

### Data Structures / 数据结构
```
[Key data structures with field descriptions / 带字段描述的关键数据结构]
```

### Data Flow / 数据流
[Step by step: how data moves through the system during a typical frame / 逐步说明：在典型帧中数据如何通过系统移动]

## Implementation Plan / 实施计划

### Phase 1: [Core Functionality / 核心功能]
- [ ] [Task 1 / 任务1]
- [ ] [Task 2 / 任务2]

### Phase 2: [Extended Features / 扩展功能]
- [ ] [Task 3 / 任务3]
- [ ] [Task 4 / 任务4]

### Phase 3: [Optimization/Polish / 优化/打磨]
- [ ] [Task 5 / 任务5]

## Dependencies / 依赖
| Depends On / 依赖 | For What / 用途 |
| ---------- | -------- |
| [System / 系统] | [Reason / 原因] |

| Depended On By / 被依赖 | For What / 用途 |
| -------------- | -------- |
| [System / 系统] | [Reason / 原因] |

## Testing Strategy / 测试策略
- **Unit Tests / 单元测试**: [What to test at unit level / 单元级别测试什么]
- **Integration Tests / 集成测试**: [Cross-system tests needed / 需要跨系统测试]
- **Performance Tests / 性能测试**: [Benchmarks to create / 要创建的基准]
- **Edge Cases / 边界情况**: [Specific scenarios to test / 要测试的特定场景]

## Known Limitations / 已知限制
[What this design intentionally does NOT support and why / 此设计故意不支持什么以及原因]

## Future Considerations / 未来考虑
[What might need to change if requirements evolve — but do NOT build for this now / 如果需求演变可能需要改变什么 — 但现在不要为此构建]
