# ADR: [Decision Name] / 架构决策记录：[决策名称]

---
**Status**: Reverse-Documented
**Source**: `[path to implementation code]`
**Date**: [YYYY-MM-DD]
**Decision Makers**: [User name or "inferred from code"]
**Implementation Status**: [Deployed | Partial | Planned]
---

> **⚠️ 反向文档化通知** / **⚠️ Reverse-Documentation Notice**
>
> This Architecture Decision Record was created **after** the implementation already
> existed. It captures the current implementation approach and clarified rationale
> based on code analysis and user consultation. Some context may be reconstructed
> rather than contemporaneously documented. / 此架构决策记录是在实现**已经存在之后**创建的。它基于代码分析和用户咨询，捕捉了当前的实现方法和澄清的理由。一些背景可能是重建的，而不是同时记录的。

---

## Context / 背景

**Problem Statement**: [What problem did this implementation solve? / 问题陈述：这个实现解决了什么问题？]

**Background** (inferred from code): / **背景**（根据代码推断）：
- [Context 1 — why this problem needed solving] / [背景1——为什么需要解决此问题]
- [Context 2 — constraints at the time] / [背景2——当时的约束条件]
- [Context 3 — alternatives that were likely considered] / [背景3——可能考虑过的替代方案]

**System Scope**: [What parts of the codebase does this affect? / 系统范围：这影响代码库的哪些部分？]

**Stakeholders** / 利益相关者：
- [Role 1 / 角色1]: [Their concern or requirement / 他们的关注点或需求]
- [Role 2 / 角色2]: [Their concern or requirement / 他们的关注点或需求]

---

## Decision / 决策

**Approach Taken** (as implemented) / 采用的方法（已实现）：

[Describe the architectural approach found in the code] / [描述在代码中找到的架构方法]

**Key Implementation Details** / 关键实现细节：
- [Detail 1]: [How it works] / [细节1]：[工作原理]
- [Detail 2]: [Pattern or structure used] / [细节2]：[使用的模式或结构]
- [Detail 3]: [Notable design choice] / [细节3]：[值得注意的设计选择]

**Clarified Rationale** (from user) / 澄清的理由（来自用户）：
- [Reason 1 — why this approach was chosen] / [理由1——为什么选择此方法]
- [Reason 2 — what problem it solves] / [理由2——它解决了什么问题]
- [Reason 3 — what benefit it provides] / [理由3——它提供了什么好处]

**Code Locations** / 代码位置：
- `[file/path 1]`: [What's there / 内容说明]
- `[file/path 2]`: [What's there / 内容说明]

---

## Alternatives Considered / 考虑的替代方案

*(These may be inferred or clarified with user / 这些可能根据推断或与用户澄清确定)*

### Alternative 1: [Approach Name / 替代方案1名称]

**Description**: [What this alternative would have been / 描述：这个替代方案会是怎样的]

**Pros**:
- ✅ [Advantage 1]
- ✅ [Advantage 2]

**Cons**:
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]

**Why Not Chosen**: [Reason — from user clarification or inference] / **未选择的原因**：[原因——来自用户澄清或推断]

### Alternative 2: [Approach Name / 替代方案2名称]

**Description**: [What this alternative would have been / 描述：这个替代方案会是怎样的]

**Pros**:
- ✅ [Advantage 1]
- ✅ [Advantage 2]

**Cons**:
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]

**Why Not Chosen**: [Reason / 未选择的原因]

### Alternative 3: [Status Quo / No Change / 替代方案3：维持现状/无变更]

**Description**: [What "doing nothing" would mean] / **描述**：["什么都不做"意味着什么]

**Why Not Acceptable**: [Why the problem needed solving] / **为何不可接受**：[为什么需要解决此问题]

---

## Consequences / 后果

### Positive Consequences (Benefits Realized) / 积极后果（已实现的收益）

✅ **[Benefit 1]**: [How the implementation provides this] / **[收益1]**：[实现如何提供此收益]

✅ **[Benefit 2]**: [Impact] / **[收益2]**：[影响]

✅ **[Benefit 3]**: [Impact] / **[收益3]**：[影响]

### Negative Consequences (Trade-offs Accepted) / 消极后果（接受的权衡）

⚠️ **[Trade-off 1]**: [What was sacrificed or made harder] / **[权衡1]**：[牺牲了什么或使什么变得更困难]

⚠️ **[Trade-off 2]**: [Limitation or cost] / **[权衡2]**：[限制或成本]

⚠️ **[Trade-off 3]**: [Complexity or maintenance burden] / **[权衡3]**：[复杂性或维护负担]

### Neutral Consequences (Observations) / 中性后果（观察）

ℹ️ **[Observation 1]**: [Emergent property or side effect] / **[观察1]**：[涌现属性或副作用]

ℹ️ **[Observation 2]**: [Unexpected outcome] / **[观察2]**：[意外结果]

---

## Implementation Notes / 实现说明

**Patterns Used**: / **使用的模式**：
- [Pattern 1]: [Where and why] / [模式1]：[位置和原因]
- [Pattern 2]: [Where and why] / [模式2]：[位置和原因]

**Dependencies Introduced**: / **引入的依赖**：
- [Dependency 1]: [Why needed] / [依赖1]：[为什么需要]
- [Dependency 2]: [Why needed] / [依赖2]：[为什么需要]

**Performance Characteristics**: / **性能特征**：
- Time complexity: [O(n), etc.] / 时间复杂度：[O(n)等]
- Space complexity: [Memory usage] / 空间复杂度：[内存使用]
- Bottlenecks: [Known performance concerns] / 瓶颈：[已知的性能问题]

**Thread Safety**: / **线程安全**：
- [Thread safety approach — single-threaded, mutex-protected, lock-free, etc.] / [线程安全方法——单线程、互斥锁保护、无锁等]

**Testing Strategy**: / **测试策略**：
- [How this is tested — unit tests, integration tests, etc.] / [如何测试——单元测试、集成测试等]
- Coverage: [Estimated or measured] / 覆盖率：[估计或测量]

---

## Validation / 验证

**How We Know This Works**: / **我们如何知道这有效**：
- ✅ [Evidence 1 — e.g., "6 months in production without issues"] / ✅ [证据1——例如，"生产环境运行6个月无问题"]
- ✅ [Evidence 2 — e.g., "handles 10k entities at 60 FPS"] / ✅ [证据2——例如，"以60 FPS处理10k实体"]
- ⚠️ [Evidence 3 — e.g., "works but needs monitoring"] / ⚠️ [证据3——例如，"有效但需要监控"]

**Known Issues** (discovered during analysis): / **已知问题**（分析期间发现）：
- ⚠️ [Issue 1]: [Problem and potential fix] / ⚠️ [问题1]：[问题和潜在修复]
- ⚠️ [Issue 2]: [Problem and potential fix] / ⚠️ [问题2]：[问题和潜在修复]

**Risks**: / **风险**：
- [Risk 1]: [Potential problem if X happens] / [风险1]：[如果X发生时的潜在问题]
- [Risk 2]: [Scalability concern] / [风险2]：[可扩展性担忧]

---

## Open Questions / 未决问题

**Unresolved During Reverse-Documentation**: / **反向文档化期间未解决的问题**：
1. **[Question 1]**: [What's unclear about the decision or implementation?] / **[问题1]**：[关于决策或实现有什么不清楚的？]
   - Needs clarification from: [Who] / - 需要澄清来自：[谁]
   - Impact if unresolved: [Consequence] / - 如果未解决的后果：[后果]

2. **[Question 2]**: [What needs to be decided for future work?] / **[问题2]**：[未来工作需要决定什么？]

---

## Follow-Up Work / 后续工作

**Immediate**: / **立即**：
- [ ] [Task 1 — e.g., "Add missing unit tests"] / [ ] [任务1——例如，"添加缺失的单元测试"]
- [ ] [Task 2 — e.g., "Document edge case handling"] / [ ] [任务2——例如，"记录边界情况处理"]

**Short-Term**: / **短期**：
- [ ] [Task 3 — e.g., "Refactor X for clarity"] / [ ] [任务3——例如，"重构X以提高清晰度"]
- [ ] [Task 4 — e.g., "Add performance monitoring"] / [ ] [任务4——例如，"添加性能监控"]

**Long-Term**: / **长期**：
- [ ] [Task 5 — e.g., "Revisit decision when Y is available"] / [ ] [任务5——例如，"当Y可用时重新审视决策"]

---

## Related Decisions / 相关决策

**Depends On** (ADRs this builds upon): / **依赖**（此决策基于的ADRs）：
- [ADR-XXX]: [Related decision] / [ADR-XXX]：[相关决策]

**Influences** (ADRs affected by this): / **影响**（受此影响的ADRs）：
- [ADR-YYY]: [How this impacts it] / [ADR-YYY]：[如何影响它]

**Supersedes**: / **取代**：
- [ADR-ZZZ]: [Old decision this replaces, if any] / [ADR-ZZZ]：[此决策取代的旧决策，如果有]

**Superseded By**: / **被取代**：
- [None yet | ADR-WWW if this decision is later replaced] / [尚无 | 如果此决策后来被取代则为ADR-WWW]

---

## References / 参考

**Code Locations**: / **代码位置**：
- `[path/file 1]`: [Primary implementation] / `[路径/文件1]`：[主要实现]
- `[path/file 2]`: [Related code] / `[路径/文件2]`：[相关代码]

**External Resources**: / **外部资源**：
- [Article/Book]: [Relevant pattern or technique reference] / [文章/书籍]：[相关模式或技术参考]
- [Documentation]: [Engine or library docs consulted] / [文档]：[查阅的引擎或库文档]

**Design Documents**: / **设计文档**：
- [GDD Section]: [If this implements a design] / [GDD部分]：[如果这实现了设计]

---

## Version History / 版本历史

| Date | Author | Changes |
|------|--------|---------|
| [Date] | Claude (reverse-doc) | Initial reverse-documentation from `[source path]` |
| [Date] | [User] | Clarified rationale for [X] |

---

## Status Legend / 状态图例

- **Proposed**: Under discussion, not implemented / - **提议**：讨论中，未实现
- **Accepted**: Decided, implementation in progress / - **已接受**：已决定，实施中
- **Deprecated**: No longer recommended, but may exist in code / - **已弃用**：不再推荐，但可能存在于代码中
- **Superseded**: Replaced by another decision / - **被取代**：被另一个决策取代
- **Reverse-Documented**: Created after implementation (this document) / - **反向文档化**：实现后创建（本文档）

---

**Current Status**: **Reverse-Documented**

---

*This ADR was generated by `/reverse-document architecture [path]`*

---

## Appendix: Code Snippets / 附录：代码片段

**Key Implementation Pattern**: / **关键实现模式**：

```[language]
[Code snippet showing the core pattern or decision]
```

**Rationale**: [Why this code structure embodies the decision] / **理由**：[为什么此代码结构体现了决策]

**Alternative Approach** (not chosen): / **替代方法**（未选择）：

```[language]
[Code snippet showing what the alternative would look like]
```

**Why Not**: [Why the implemented approach was preferred] / **为何不选**：[为什么偏好实现的方法]
