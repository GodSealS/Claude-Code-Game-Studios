---
name: reverse-document
description: "Generate design or architecture documents from existing implementation. Works backwards from code/prototypes to create missing planning docs. / 从现有实现生成设计或架构文档。从代码/原型反向工作以创建缺失的规划文档。"
argument-hint: "<type> <path> (e.g., 'design src/gameplay/combat' or 'architecture src/core')"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash
# Read-only diagnostic skill — no specialist agent delegation needed
---

# Reverse Documentation / 反向文档化

This skill analyzes existing implementation (code, prototypes, systems) and generates
appropriate design or architecture documentation. Use this when:
- You built a feature without writing a design doc first
- You inherited a codebase without documentation
- You prototyped a mechanic and need to formalize it
- You need to document "why" behind existing code

> **中文翻译**：此技能分析现有实现（代码、原型、系统）并生成适当的设计或架构文档。在以下情况下使用：
> - 你构建了一个功能但没有先写设计文档
> - 你继承了一个没有文档的代码库
> - 你原型化了一个机制并需要将其正式化
> - 你需要记录现有代码背后的"为什么"

---

## Workflow / 工作流程

## Phase 1: Parse Arguments / 第 1 阶段：解析参数

**Format**: `/reverse-document <type> <path>`

**Type options**: / **类型选项**：
- `design` → Generate a game design document (GDD section) / 生成游戏设计文档（GDD 部分）
- `architecture` → Generate an Architecture Decision Record (ADR) / 生成架构决策记录（ADR）
- `concept` → Generate a concept document from prototype / 从原型生成概念文档

**Path**: Directory or file to analyze / **路径**：要分析的目录或文件
- `src/gameplay/combat/` → All combat-related code / 所有战斗相关代码
- `src/core/event-system.cpp` → Specific file / 特定文件
- `prototypes/stealth-mech/` → Prototype directory / 原型目录

**Examples**:
```bash
/reverse-document design src/gameplay/magic-system
/reverse-document architecture src/core/entity-component
/reverse-document concept prototypes/vehicle-combat
```

## Phase 2: Analyze Implementation / 第 2 阶段：分析实现

**Read and understand the code/prototype**: / **阅读并理解代码/原型**：

**For design docs (GDD):** / **对于设计文档（GDD）：**
- Identify mechanics, rules, formulas / 识别机制、规则、公式
- Extract gameplay values (damage, cooldowns, ranges) / 提取游戏数值（伤害、冷却、范围）
- Find state machines, ability systems, progression / 查找状态机、能力系统、进度
- Detect edge cases handled in code / 检测代码中处理的边界情况
- Map dependencies (what systems interact?) / 映射依赖关系（哪些系统交互？）

**For architecture docs (ADR):** / **对于架构文档（ADR）：**
- Identify patterns (ECS, singleton, observer, etc.) / 识别模式（ECS、单例、观察者等）
- Understand technical decisions (threading, serialization, etc.) / 理解技术决策（线程、序列化等）
- Map dependencies and coupling / 映射依赖和耦合
- Assess performance characteristics / 评估性能特征
- Find constraints and trade-offs / 发现约束和权衡

**For concept docs (prototype analysis):** / **对于概念文档（原型分析）：**
- Identify core mechanic / 识别核心机制
- Extract emergent gameplay patterns / 提取涌现的游戏模式
- Note what worked vs what didn't / 记录什么有效、什么无效
- Find technical feasibility insights / 发现技术可行性洞察
- Document player fantasy / feel / 记录玩家幻想/手感

## Phase 3: Ask Clarifying Questions / 第 3 阶段：提出澄清问题

**DO NOT** just describe the code. **ASK** about intent: / **不要**仅仅描述代码。**询问**意图：

**Design questions**: / **设计问题**：
- "I see a [resource] system that depletes during [activity]. Was this for:
  - Pacing (prevent spam)?
  - Resource management (strategic depth)?
  - Or something else?"
- "The [mechanic] seems central. Is this a core pillar, or supporting feature?" / "[机制]似乎是核心。这是核心支柱还是辅助功能？"
- "[Value] scales exponentially with [factor]. Intentional design, or needs rebalancing?" / "[数值]随[因素]指数级缩放。是有意设计还是需要重新平衡？"

**Architecture questions**: / **架构问题**：
- "You're using a service locator pattern. Was this chosen for:
  - Testability (mock dependencies)?
  - Decoupling (reduce hard references)?
  - Or inherited from existing code?"
- "I see manual memory management instead of smart pointers. Performance requirement, or legacy?" / "我看到手动内存管理而非智能指针。是性能需求还是历史遗留？"

**Concept questions**: / **概念问题**：
- "The prototype emphasizes stealth over combat. Is that the intended pillar?" / "原型强调潜行而非战斗。这是预期的支柱吗？"
- "Players seem to exploit the grappling hook for speed. Feature or bug?" / "玩家似乎利用抓钩加速。是功能还是缺陷？"

## Phase 4: Present Findings / 第 4 阶段：呈现发现

Before drafting, show what you discovered: / 在起草之前，展示你的发现：

```
I've analyzed [path]/. Here's what I found:

MECHANICS IMPLEMENTED:
- [mechanic-a] with [property] (e.g. timing windows, cooldowns)
- [mechanic-b] (e.g. interaction between two states)
- [resource] system (depletes on [action], regens on [condition])
- [state] system (builds up, triggers [effect])

FORMULAS DISCOVERED:
- [Output] = [formula using discovered variables]
- [Secondary output] = [formula]

UNCLEAR INTENT AREAS:
1. [Resource] system — pacing or resource management?
2. [Mechanic] — core pillar or supporting feature?
3. [Value] scaling — intentional design or needs tuning?

Before I draft the design doc, could you clarify these points?
```

Wait for user to clarify intent before drafting. / 等待用户在起草前澄清意图。

## Phase 5: Draft Document Using Template / 第 5 阶段：使用模板起草文档

Based on type, use appropriate template: / 根据类型，使用适当的模板：

| Type | Template | Output Path |
|------|----------|-------------|
| / 类型 | 模板 | 输出路径 |
| `design` | `templates/design-doc-from-implementation.md` | `design/gdd/[system-name].md` |
| `architecture` | `templates/architecture-doc-from-code.md` | `docs/architecture/[decision-name].md` |
| `concept` | `templates/concept-doc-from-prototype.md` | `prototypes/[name]/CONCEPT.md` or `design/concepts/[name].md` |

**Draft structure**: / **草稿结构**：
- Capture **what exists** (mechanics, patterns, implementation) / 记录**已存在的内容**（机制、模式、实现）
- Document **why it exists** (intent clarified with user) / 记录**为何存在**（与用户澄清的意图）
- Identify **what's missing** (edge cases not handled, gaps in design) / 识别**缺失的内容**（未处理的边界情况、设计缺口）
- Flag **follow-up work** (balance tuning, missing features) / 标记**后续工作**（平衡调整、缺失功能）

## Phase 6: Show Draft and Request Approval / 第 6 阶段：展示草稿并请求批准

**Collaborative protocol**: / **协作协议**：
```
I've drafted the [system-name] design doc based on your code and clarifications.

[Show key sections: Overview, Mechanics, Formulas, Design Intent]

ADDITIONS I MADE:
- Documented [mechanic] as "[intent]" per your clarification
- Added edge cases not in code (e.g., what if [resource] hits 0 mid-[action]?)
- Flagged balance concern: [scaling type] scaling at [boundary condition]

SECTIONS MARKED AS INCOMPLETE:
- "[System] interaction with [other-system]" (not fully implemented yet)
- "[Variant or feature]" (only [subset] implemented so far)

May I write this to design/gdd/[system-name].md?
```

Wait for approval. User may request changes before writing. / 等待批准。用户可能在写入前请求更改。

## Phase 7: Write Document with Metadata / 第 7 阶段：写入带元数据的文档

When approved, write the file with special markers: / 批准后，写入带有特殊标记的文件：

```markdown
---
status: reverse-documented
source: [path/]
date: [today]
verified-by: [User name]
---

# [System Name] Design

> **Note**: This document was reverse-engineered from the existing implementation.
> It captures current behavior and clarified design intent. Some sections may be
> incomplete where implementation is partial or intent was unclear.

[Rest of document...]
```

## Phase 8: Flag Follow-Up Work / 第 8 阶段：标记后续工作

After writing, suggest next steps: / 写入后，建议下一步：

```
✅ Written to design/gdd/combat-system.md

FOLLOW-UP RECOMMENDED:
1. Run /balance-check on combat formulas (exponential scaling concern)
2. Create ADR for stamina system architecture decision
3. Implement missing edge cases:
   - Stamina depletion mid-combo behavior
   - Stagger state during dodge
4. Extend design doc when weapon variety is implemented

Would you like me to tackle any of these now?
```

---

## Template Selection Logic / 模板选择逻辑

| If analyzing... | Use template... | Because... |
| / 如果分析... | 使用模板... | 因为... |
|----------------|-----------------|------------|
| `src/gameplay/*` | design-doc-from-implementation.md | Gameplay mechanics → GDD |
| `src/core/*`, `src/ai/*` | architecture-doc-from-code.md | Core systems → ADR |
| `prototypes/*` | concept-doc-from-prototype.md | Experiments → concept doc |
| `src/networking/*` | architecture-doc-from-code.md | Technical systems → ADR |
| `src/ui/*` | design-doc-from-implementation.md | UI/UX → design spec |

---

## Example Session: Reverse-Document a System / 示例会话：反向文档化一个系统

```
User: /reverse-document design src/gameplay/[system]

Agent: I'll analyze your [system] implementation to create a design doc.
       [Reads code, discovers mechanics, formulas]

Agent: I've analyzed src/gameplay/[system]/. Here's what I found:
       [Shows mechanics, formulas, unclear areas]

       Before drafting, could you clarify:
       1. [Resource] system intent?
       2. Is [mechanic] a core pillar?
       3. [Value] scaling — intentional or needs tuning?

User: 1. [Resource] is for pacing, prevent [unwanted behavior]
      2. [Mechanic] is core — I want [design intent]
      3. Yeah, exponential is too much, should be linear

Agent: Perfect, that clarifies the vision. Let me draft the design doc.
       [Shows draft with clarified intent]

       May I write this to design/gdd/[system-name].md?

User: Yes, write it.

Agent: ✅ Written to design/gdd/[system-name].md
       ✅ Marked as [REVERSE-DOCUMENTED]
       ✅ Flagged [value] scaling for rebalancing

       Next steps:
       - Update [formula] to [corrected scaling]
       - Run /balance-check to validate [curve]
       - Document [mechanic] as core pillar in game-pillars.md
```

---

## Collaborative Protocol / 协作协议

This skill follows the collaborative design principle: / 此技能遵循协作设计原则：

1. **Analyze First**: Read code, understand implementation / **先分析**：阅读代码，理解实现
2. **Question Intent**: Ask about "why", not just "what" / **质疑意图**：询问"为什么"，而不仅是"是什么"
3. **Present Findings**: Show discoveries, highlight unclear areas / **呈现发现**：展示发现，突出不明确的区域
4. **User Clarifies**: Separate intent from accidents / **用户澄清**：区分意图与偶然
5. **Draft Document**: Create doc based on reality + intent / **起草文档**：基于现实+意图创建文档
6. **Show Draft**: Display key sections, explain additions / **展示草稿**：显示关键部分，解释添加内容
7. **Get Approval**: "May I write to [filepath]?" On approval: Verdict: **COMPLETE** — document generated. On decline: Verdict: **BLOCKED** — user declined write. / **获得批准**："我可以写入到[文件路径]吗？" 批准时：裁决：**COMPLETE** — 文档已生成。拒绝时：裁决：**BLOCKED** — 用户拒绝写入。
8. **Flag Follow-Up**: Suggest related work, don't auto-execute / **标记后续工作**：建议相关工作，不自动执行

**Never assume intent. Always ask before documenting "why".** / **绝不假设意图。在记录"为什么"之前始终先询问。**
