# [System Name] — Design Document / [系统名称] — 设计文档

---
**Status**: Reverse-Documented / **状态**: 逆向文档化
**Source**: `[path to implementation code]` / **来源**: `[实现代码的路径]`
**Date**: [YYYY-MM-DD] / **日期**: [YYYY-MM-DD]
**Verified By**: [User name or "pending review"] / **验证者**: [用户名或"待审查"]
**Implementation Status**: [Fully implemented | Partially implemented | Needs extension] / **实现状态**: [完全实现 | 部分实现 | 需要扩展]
---

> **⚠️ Reverse-Documentation Notice** / **⚠️ 逆向文档化通知**
>
> This design document was created **after** the implementation already existed.
> It captures current behavior and clarified design intent based on code analysis
> and user consultation. Some sections may be incomplete where implementation is
> partial or design intent was unclear during reverse-engineering. / 本设计文档是在实现**已经存在之后**创建的。它捕捉当前行为，并基于代码分析和用户咨询澄清设计意图。在实现不完整或逆向工程中设计意图不明确的情况下，某些部分可能不完整。

---

<!-- 中文翻译 -->
## 1. Overview / 1. 概述

**Purpose**: [What problem does this system solve?] / **目的**: [这个系统解决什么问题？]

**Scope**: [What is included/excluded from this system?] / **范围**: [这个系统包含/排除什么？]

**Current Implementation**: [Brief description of what exists in code] / **当前实现**: [代码中存在什么的简要描述]

**Design Intent** (clarified): / **设计意图**（已澄清）：
- [Intent 1 — why this feature exists] / [意图1 — 为什么存在这个功能]
- [Intent 2 — what player experience it creates] / [意图2 — 它创造什么玩家体验]
- [Intent 3 — how it fits into overall game pillars] / [意图3 — 它如何融入整体游戏支柱]

---

<!-- 中文翻译 -->
## 2. Detailed Design / 2. 详细设计

<!-- 中文翻译 -->
### 2.1 Core Mechanics / 2.1 核心机制

[Describe the mechanics as implemented, organized clearly] / [描述按实现方式组织的机制，结构清晰]

**[Mechanic 1 Name]**: / **[机制1名称]**：
- **Description**: [What it does] / **描述**: [它做什么]
- **Implementation**: [How it works in code] / **实现**: [代码中如何运作]
- **Design Rationale**: [Why it exists — from user clarification] / **设计理由**: [为什么存在 — 来自用户澄清]
- **Player-Facing**: [How players experience this] / **玩家面向**: [玩家如何体验这个]

**[Mechanic 2 Name]**: / **[机制2名称]**：
- **Description**: [What it does] / **描述**: [它做什么]
- **Implementation**: [How it works] / **实现**: [如何运作]
- **Design Rationale**: [Why it exists] / **设计理由**: [为什么存在]
- **Player-Facing**: [Player experience] / **玩家面向**: [玩家体验]

<!-- 中文翻译 -->
### 2.2 Rules and Formulas / 2.2 规则与公式

**Formulas Discovered in Code**: / **代码中发现的公式**：

| Formula | Expression | Purpose | Verified? | 公式 | 表达式 | 用途 | 已验证? |
|---------|-----------|---------|-----------|------|--------|------|----------|
| [Formula 1] | `[mathematical expression]` | [What it calculates] | ✅ / ⚠️ needs tuning | [公式1] | `[数学表达式]` | [它计算什么] | ✅ / ⚠️ 需要调整 |
| [Formula 2] | `[expression]` | [Purpose] | ✅ / ⚠️ needs tuning | [公式2] | `[表达式]` | [用途] | ✅ / ⚠️ 需要调整 |

**Clarifications**: / **澄清**：
- [Formula X]: Originally [value/approach], user clarified intent is [corrected intent] / [公式X]: 原本为[值/方法]，用户澄清意图为[修正后的意图]
- [Formula Y]: Implemented as [X], but should be [Y] — flagged for update / [公式Y]: 实现为[X]，但应为[Y] — 标记需要更新

<!-- 中文翻译 -->
### 2.3 State and Data / 2.3 状态与数据

**Data Structures** (from code): / **数据结构**（来自代码）：
- [Data structure 1]: `[fields/properties]` / [数据结构1]: `[字段/属性]`
- [Data structure 2]: `[fields/properties]` / [数据结构2]: `[字段/属性]`

**State Machines** (if applicable): / **状态机**（如适用）：
```
[State diagram or list of states and transitions] / [状态图或状态及转换列表]
```

**Persistence**: / **持久化**：
- Saved: [What is saved to player save file] / **已保存**: [保存到玩家存档文件的内容]
- Not saved: [What is session-only or recalculated] / **未保存**: [仅会话期间存在或重新计算的内容]

<!-- 中文翻译 -->
### 2.4 Integration Points / 2.4 集成点

**Dependencies** (systems this depends on): / **依赖项**（本系统依赖的系统）：
- [System 1]: [What it provides] / [系统1]: [它提供什么]
- [System 2]: [What it provides] / [系统2]: [它提供什么]

**Dependents** (systems that depend on this): / **被依赖项**（依赖本系统的系统）：
- [System 3]: [How it uses this system] / [系统3]: [它如何使用本系统]
- [System 4]: [How it uses this system] / [系统4]: [它如何使用本系统]

**API Surface** (public interface): / **API接口**（公共接口）：
- [Method/Function 1]: [Purpose] / [方法/函数1]: [用途]
- [Method/Function 2]: [Purpose] / [方法/函数2]: [用途]

---

<!-- 中文翻译 -->
## 3. Edge Cases / 3. 边界情况

**Handled in Code**: / **代码中已处理**：
- ✅ [Edge case 1]: [How it's handled] / ✅ [边界情况1]: [如何处理]
- ✅ [Edge case 2]: [How it's handled] / ✅ [边界情况2]: [如何处理]

**Not Yet Handled** (discovered during analysis): / **尚未处理**（分析中发现）：
- ⚠️ [Edge case 3]: [What happens? Needs implementation] / ⚠️ [边界情况3]: [会发生什么？需要实现]
- ⚠️ [Edge case 4]: [What happens? Needs implementation] / ⚠️ [边界情况4]: [会发生什么？需要实现]

**Unclear** (need user clarification): / **不明确**（需要用户澄清）：
- ❓ [Edge case 5]: [What should happen? Pending decision] / ❓ [边界情况5]: [应该发生什么？待决定]

---

<!-- 中文翻译 -->
## 4. Dependencies / 4. 依赖

**Technical Dependencies**: / **技术依赖**：
- [Dependency 1]: [Why needed] / [依赖1]: [为何需要]
- [Dependency 2]: [Why needed] / [依赖2]: [为何需要]

**Design Dependencies** (other design docs): / **设计依赖**（其他设计文档）：
- [System X Design]: [How they interact] / [系统X设计]: [它们如何交互]
- [System Y Design]: [How they interact] / [系统Y设计]: [它们如何交互]

**Content Dependencies**: / **内容依赖**：
- [Asset type]: [What's needed] / [资产类型]: [需要什么]
- [Data files]: [Required config/balance data] / [数据文件]: [需要的配置/平衡数据]

---

<!-- 中文翻译 -->
## 5. Balance and Tuning / 5. 平衡与调优

**Current Values** (as implemented): / **当前值**（按实现）：

| Parameter | Current Value | Rationale | Needs Tuning? | 参数 | 当前值 | 理由 | 需要调优? |
|-----------|--------------|-----------|---------------|------|--------|------|-----------|
| [Param 1] | [value] | [Why this value] | ✅ / ⚠️ / ❌ | [参数1] | [值] | [为什么是这个值] | ✅ / ⚠️ / ❌ |
| [Param 2] | [value] | [Why this value] | ✅ / ⚠️ / ❌ | [参数2] | [值] | [为什么是这个值] | ✅ / ⚠️ / ❌ |

**Balance Concerns Identified**: / **已识别的平衡问题**：
- ⚠️ [Concern 1]: [What's wrong, suggested fix] / ⚠️ [问题1]: [什么不对，建议修复]
- ⚠️ [Concern 2]: [What's wrong, suggested fix] / ⚠️ [问题2]: [什么不对，建议修复]

**Recommended Balance Pass**: / **推荐的平衡通行**：
- Run `/balance-check` on [specific aspect] / 对[特定方面]运行 `/balance-check`
- Playtest with focus on [specific scenario] / 以[特定场景]为重点进行游戏测试

---

<!-- 中文翻译 -->
## 6. Acceptance Criteria / 6. 验收标准

**What Exists** (implemented): / **已存在**（已实现）：
- ✅ [Criterion 1] / ✅ [标准1]
- ✅ [Criterion 2] / ✅ [标准2]
- ⚠️ [Criterion 3] — partially implemented / ⚠️ [标准3] — 部分实现

**What's Missing** (not yet implemented): / **缺失**（尚未实现）：
- ❌ [Criterion 4] — flagged for future work / ❌ [标准4] — 标记为未来工作
- ❌ [Criterion 5] — flagged for future work / ❌ [标准5] — 标记为未来工作

**Definition of Done** (when is this system "complete"?): / **完成定义**（此系统何时"完成"？）：
- [ ] [Requirement 1] / [需求1]
- [ ] [Requirement 2] / [需求2]
- [ ] [Requirement 3] / [需求3]

---

<!-- 中文翻译 -->
## 7. Open Questions and Follow-Up Work / 7. 待解决问题与后续工作

<!-- 中文翻译 -->
### Questions Needing User Decision / 需要用户决策的问题
1. **[Question 1]**: [What needs to be decided?] / **[问题1]**: [需要决定什么？]
   - Option A: [Approach A] / 选项A: [方案A]
   - Option B: [Approach B] / 选项B: [方案B]

2. **[Question 2]**: [What needs to be decided?] / **[问题2]**: [需要决定什么？]

<!-- 中文翻译 -->
### Flagged Follow-Up Work / 标记的后续工作
- [ ] **Update [Formula X]**: Change from exponential to linear (per user clarification) / **更新[公式X]**: 从指数改为线性（根据用户澄清）
- [ ] **Implement [Edge Case Y]**: Handle scenario not in current code / **实现[边界情况Y]**: 处理当前代码中未包含的场景
- [ ] **Create ADR**: Document why [architectural decision] was chosen / **创建ADR**: 记录为什么选择了[架构决策]
- [ ] **Balance pass**: Run `/balance-check` on progression curve / **平衡通行**: 在进度曲线上运行 `/balance-check`
- [ ] **Extend design doc**: When [related feature] is implemented, update this doc / **扩展设计文档**: 当[相关功能]实现时，更新此文档

---

<!-- 中文翻译 -->
## 8. Version History / 8. 版本历史

| Date | Author | Changes |
|------|--------|---------|
| [Date] | Claude (reverse-doc) | Initial reverse-documentation from `[source path]` |
| [Date] | [User] | Clarified design intent, corrected [X] |

---

**Next Steps**: / **后续步骤**：
1. [Priority 1 task based on gaps identified] / [基于已识别差距的优先级1任务]
2. [Priority 2 task] / [优先级2任务]
3. [Priority 3 task] / [优先级3任务]

**Related Skills**: / **相关技能**：
- `/balance-check` — Validate formulas and progression / 验证公式和进度
- `/architecture-decision` — Document technical decisions / 记录技术决策
- `/code-review` — Ensure code matches clarified design / 确保代码符合已澄清的设计

---

*This document was generated by `/reverse-document design [path]`* / *此文档由 `/reverse-document design [路径]` 生成*
