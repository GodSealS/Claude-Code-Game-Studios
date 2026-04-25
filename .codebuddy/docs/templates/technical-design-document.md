# Technical Design: [System Name] / 技术设计：[系统名称]

## Document Status / 文档状态
- **Version**: 1.0 / **版本**：1.0
- **Last Updated**: [Date] / **最后更新**：[日期]
- **Author**: [Agent/Person] / **作者**：[代理/人员]
- **Reviewer**: lead-programmer / **审阅者**：lead-programmer
- **Related ADR**: [ADR-XXXX if applicable] / **相关ADR**：[ADR-XXXX（如果适用）]
- **Related Design Doc**: [Link to game design doc this implements] / **相关设计文档**：[此系统实现的游戏设计文档链接]

## Engine API Surface / 引擎API表面

| Field / 字段 | Value / 值 |
|-------|-------|
| **Engine** / **引擎** | [e.g. Godot 4.6 / Unity 6 / Unreal Engine 5.4] / [例如 Godot 4.6 / Unity 6 / Unreal Engine 5.4] |
| **APIs Depended On** / **依赖的API** | [Specific classes/methods/nodes used, version-pinned — e.g. `CharacterBody3D.move_and_slide() (Godot 4.x)`] / [使用的特定类/方法/节点，版本固定——例如 `CharacterBody3D.move_and_slide() (Godot 4.x)`] |
| **References Consulted** / **参考的文档** | [engine-reference docs read before writing this — e.g. `docs/engine-reference/godot/modules/physics.md`] / [编写前阅读的引擎参考文档——例如 `docs/engine-reference/godot/modules/physics.md`] |
| **Post-Cutoff Features Used** / **使用的截止日期后特性** | [Features from engine versions beyond LLM training cutoff, or "None"] / [超过LLM训练截止日期的引擎版本特性，或"无"] |
| **Unverified Assumptions** / **未验证的假设** | [API behaviours assumed but not yet tested against the target version, or "None"] / [假设但尚未针对目标版本测试的API行为，或"无"] |
| **Engine Upgrade Risk** / **引擎升级风险** | [LOW / MEDIUM / HIGH — how fragile is this design if the engine version changes?] / [低 / 中 / 高 —— 如果引擎版本改变，此设计的脆弱性如何？] |

> **Rule**: If any **Unverified Assumptions** are listed, this document cannot be marked
> as Accepted until those assumptions are validated in the actual engine environment. / 
> **规则**：如果列出了任何**未验证的假设**，在在实际引擎环境中验证这些假设之前，此文档不能标记为已接受。

## Overview / 概述
[2-3 sentence summary of what this system does and why it exists / 
2-3句话总结这个系统做什么以及为什么存在]

## Requirements / 需求

### Functional Requirements / 功能需求
- [FR-1]: [Description] / [FR-1]：[描述]
- [FR-2]: [Description] / [FR-2]：[描述]

### Non-Functional Requirements / 非功能需求
- **Performance**: [Budget — e.g., "< 1ms per frame"] / **性能**：[预算 —— 例如，"< 1ms 每帧"]
- **Memory**: [Budget — e.g., "< 50MB at peak"] / **内存**：[预算 —— 例如，"< 50MB 峰值"]
- **Scalability**: [Limits — e.g., "Support up to 1000 entities"] / **可扩展性**：[限制 —— 例如，"支持最多1000个实体"]
- **Thread Safety**: [Requirements] / **线程安全**：[需求]

## Architecture / 架构

### System Diagram / 系统图
```
[ASCII diagram showing components and data flow / 
ASCII图显示组件和数据流]
```

### Component Breakdown / 组件分解
| Component / 组件 | Responsibility / 职责 | Owns / 拥有 |
| --------- | -------------- | ---- |
| [Name] / [名称] | [What it does] / [它做什么] | [What data it owns] / [它拥有什么数据] |

### Public API / 公共API
```
[Interface/API definition in pseudocode or target language / 
用伪代码或目标语言定义的接口/API]
```

### Data Structures / 数据结构
```
[Key data structures with field descriptions / 
带字段描述的关键数据结构]
```

### Data Flow / 数据流
[Step by step: how data moves through the system during a typical frame / 
逐步说明：在典型帧中数据如何通过系统移动]

## Implementation Plan / 实施计划

### Phase 1: [Core Functionality] / 阶段1：[核心功能]
- [ ] [Task 1] / [ ] [任务1]
- [ ] [Task 2] / [ ] [任务2]

### Phase 2: [Extended Features] / 阶段2：[扩展特性]
- [ ] [Task 3] / [ ] [任务3]
- [ ] [Task 4] / [ ] [任务4]

### Phase 3: [Optimization/Polish] / 阶段3：[优化/打磨]
- [ ] [Task 5] / [ ] [任务5]

## Dependencies / 依赖关系

| Depends On / 依赖于 | For What / 为了什么 |
| ---------- | -------- |
| [System] / [系统] | [Reason] / [原因] |

| Depended On By / 被依赖 | For What / 为了什么 |
| -------------- | -------- |
| [System] / [系统] | [Reason] / [原因] |

## Testing Strategy / 测试策略
- **Unit Tests**: [What to test at unit level] / **单元测试**：[单元级别测试什么]
- **Integration Tests**: [Cross-system tests needed] / **集成测试**：[需要的跨系统测试]
- **Performance Tests**: [Benchmarks to create] / **性能测试**：[要创建的基准测试]
- **Edge Cases**: [Specific scenarios to test] / **边界情况**：[要测试的特定场景]

## Known Limitations / 已知限制
[What this design intentionally does NOT support and why / 
此设计有意不支持什么以及为什么]

## Future Considerations / 未来考虑
[What might need to change if requirements evolve — but do NOT build for this now / 
如果需求演变可能需要改变什么——但现在不要为此构建]