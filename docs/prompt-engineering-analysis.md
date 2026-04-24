# CCGS 提示词工程分析 / Prompt Engineering Analysis

> 本文档对 Claude Code Game Studios 项目的提示词工程架构进行系统分析，旨在揭示每个组件的设计模式、技巧和理论依据，作为学习提示词工程的参考资源。

---

## 1. 项目概述 / Project Overview

Claude Code Game Studios (CCGS) 是一个**多代理协作系统**，通过 48+ 个专业化 AI 代理模拟独立游戏工作室的完整运作。其提示词工程的核心挑战在于：

- **规模**：54 个代理、72 个技能、11 个规则、38 个模板、12 个钩子
- **协调**：代理之间需要委派、升级、门控裁决，而非各自为政
- **一致性**：所有代理必须遵循统一的协作协议、编码标准和上下文管理策略
- **可控性**：用户驱动决策，AI 作为顾问而非自主执行者

> **学习要点**：大规模提示词工程的关键不是单个提示词的精妙，而是系统级的架构设计——如何让数十个提示词协同工作、共享上下文、避免冲突。

---

## 2. 五层架构 / Five-Layer Architecture

```
┌─────────────────────────────────────────────┐
│  Layer 1: CODEBUDDY.md (全局入口)            │
│  ↓ 注入系统上下文                            │
├─────────────────────────────────────────────┤
│  Layer 2: Agents (角色定义)  ×54             │
│  ↓ 委派、升级、协调                          │
├─────────────────────────────────────────────┤
│  Layer 3: Skills (工作流技能) ×72            │
│  ↓ 分阶段交互、门控检查                      │
├─────────────────────────────────────────────┤
│  Layer 4: Rules (路径作用域规则) ×11          │
│  ↓ 自动注入约束                              │
├─────────────────────────────────────────────┤
│  Layer 5: Hooks (自动化钩子) ×12             │
│  ↓ 事件触发校验                              │
└─────────────────────────────────────────────┘
```

> **学习要点**：分层架构让每层关注点分离。Agent 负责人格和行为，Skill 负责工作流编排，Rule 负责约束注入，Hook 负责自动化校验。这种分离使得修改一层不会影响其他层。

---

## 3. 组件深度分析 / Component Deep Dive

### 3.1 Agent 层：角色人格化设计

**设计模式**：YAML Frontmatter + 行为指令

```yaml
---
name: game-designer              # 身份标识
description: "..."               # 能力描述（用于路由匹配）
tools: Read, Glob, Grep, Write   # 工具权限白名单
model: Kimi-k2.5                 # 模型选择
maxTurns: 20                     # 对话轮次限制
disallowedTools: Bash            # 工具权限黑名单
skills: [design-review, balance-check]  # 可调用技能
memory: project                  # 上下文范围
---
```

#### 核心设计技巧

**技巧 1：角色人格化而非工具列表**

❌ 低效写法：
```
You are a game design assistant. You can help with game mechanics, balancing, and systems design.
```

✅ CCGS 写法：
```
You are the Game Designer for an indie game project. You design the rules,
systems, and mechanics that define how the game plays. Your designs must be
implementable, testable, and fun. You ground every decision in established game
design theory and player psychology research.
```

> **学习要点**：赋予代理身份感（"You are THE Game Designer"）而非功能描述。明确角色边界（"Your designs must be implementable, testable, and fun"）。嵌入理论框架（"game design theory and player psychology research"）。

**技巧 2：协作协议而非指令列表**

CCGS 的每个 Agent 都包含一个标准化的协作协议：

```
### Collaboration Protocol / 协作协议

**You are a collaborative consultant, not an autonomous executor.**
The user makes all creative decisions; you provide expert guidance.

#### Question-First Workflow / 提问优先工作流
1. Ask clarifying questions
2. Present 2-4 options with reasoning
3. Draft based on user's choice (incremental file writing)
4. Get approval before writing files
```

> **学习要点**：先定义协作关系（"collaborative consultant, not autonomous executor"），再定义工作流步骤。这种模式确保 AI 不会越权行动，同时保持高效率。

**技巧 3：委派图（Delegation Map）**

每个 Agent 都有明确的委派关系：

```
### Delegation Map / 委派图

Delegates to:
- `systems-designer` for detailed subsystem design
- `level-designer` for spatial and encounter design
- `economy-designer` for economy balancing

Reports to: `creative-director` for vision alignment
Coordinates with: `lead-programmer` for feasibility
```

> **学习要点**：在提示词中定义组织结构。委派图让 AI 知道什么该做、什么该转交、向谁汇报。这模拟了真实工作室的层级关系。

**技巧 4：禁止事项（Must NOT Do）**

```
### What This Agent Must NOT Do / 此代理不得做的事

- Write implementation code (document specs for programmers)
- Make art or audio direction decisions
- Write final narrative content (collaborate with narrative-director)
- Make architecture or technology choices
- Approve scope changes without producer coordination
```

> **学习要点**：明确告诉 AI 不做什么，比告诉它做什么更重要。负面约束防止了角色越界和幻觉。

**技巧 5：理论框架嵌入**

CCGS 将专业理论直接写入 Agent 提示词：

- **MDA Framework** (Hunicke, LeBlanc, Zubek 2004) — 游戏设计分析框架
- **Self-Determination Theory** (Deci & Ryan 1985) — 玩家动机理论
- **Flow State** (Csikszentmihalyi 1990) — 心流体验理论
- **Bartle Taxonomy** — 玩家类型分类
- **Sirlin's "Playing to Win"** — 竞技平衡框架

> **学习要点**：在提示词中嵌入理论框架，让 AI 的输出有理论依据而非泛泛而谈。引用具体学者和年份增加权威性和可验证性。

---

### 3.2 Skill 层：工作流编排

**设计模式**：YAML Frontmatter + 分阶段交互指令

```yaml
---
name: brainstorm
description: "Guided game concept ideation..."
argument-hint: "[genre or theme hint, or 'open'] [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, WebSearch, Task, AskUserQuestion
---
```

#### 核心设计技巧

**技巧 6：分阶段交互而非一次性生成**

```
Phase 1: Creative Discovery    → 理解人，而非游戏
Phase 2: Concept Generation    → 3个不同方向的创意概念
Phase 3: Core Loop Design      → 核心循环的四层嵌套
Phase 4: Pillars and Boundaries → 支柱与反支柱
Phase 5: Player Type Validation → Bartle + Quantic Foundry
Phase 6: Scope and Feasibility  → 范围与可行性
```

> **学习要点**：将复杂任务分解为阶段，每阶段聚焦一个目标。阶段间用用户确认作为门控，防止 AI 跑偏。这种"分阶段 + 门控"模式是控制长工作流的核心技巧。

**技巧 7：AskUserQuestion 的 Explain → Capture 模式**

```
1. **Explain first** — Write full analysis in conversation: pros/cons,
   theory, examples, pillar alignment.
2. **Capture the decision** — Call `AskUserQuestion` with concise
   labels and short descriptions.
```

> **学习要点**：先在对话中展开分析（Explain），再用结构化工具捕获决策（Capture）。这确保用户在充分理解后做选择，而非面对一堆不理解的选项盲目点击。

**技巧 8：门控裁决（Gate Verdict）**

```
[GATE-ID]: APPROVE
或
[GATE-ID]: CONCERNS
或
[GATE-ID]: REJECT
```

> **学习要点**：门控裁决使用结构化的第一行令牌格式。这使得调用方可以通过简单解析第一行获取结果，无需理解全文。这是"机器可读 + 人类可读"的双重设计。

**技巧 9：Review Mode 三级控制**

```
- `solo` → 跳过所有门控检查（个人快速迭代）
- `lean` → 跳过非阶段门控（小团队敏捷开发）
- `full` → 执行所有门控检查（正式生产流程）
```

> **学习要点**：提供灵活的流程控制级别。同一个 Skill 在不同场景下可以简化或完整执行，无需修改提示词本身。

**技巧 10：增量文件写入（Incremental File Writing）**

```
3. **Draft based on user's choice (incremental file writing):**
   - Create the target file immediately with a skeleton (all section headers)
   - Draft one section at a time in conversation
   - Ask about ambiguities rather than assuming
   - Write each section to the file as soon as it's approved
   - Update `production/session-state/active.md` after each section
   - After writing a section, earlier discussion can be safely compacted
```

> **学习要点**：增量写入解决两大问题：(1) 上下文窗口有限——写完一节即可压缩历史；(2) 用户控制——每节审批而非全部写完再看。这是长文档生成的最佳实践。

---

### 3.3 Rule 层：路径作用域约束注入

**设计模式**：YAML Frontmatter（paths）+ 编码约束

```yaml
---
paths:
  - "src/gameplay/**"
---
```

#### 核心设计技巧

**技巧 11：路径作用域自动注入**

Rules 通过 `paths` 字段定义作用域。当 AI 操作匹配路径的文件时，对应的规则自动注入到上下文中。

```
paths: "src/gameplay/**" → 所有玩法代码自动受 gameplay-code 规则约束
paths: "src/engine/**"   → 所有引擎代码自动受 engine-code 规则约束
```

> **学习要点**：路径作用域让规则与代码上下文自动关联，无需手动引用。这比"在提示词中列出所有规则"更高效，因为只有相关规则被注入。

**技巧 12：约束用正确/错误示例强化**

```gdscript
// ✅ Correct (data-driven):
var damage: float = config.get_value("combat", "base_damage", 10.0)

// ❌ Incorrect (hardcoded):
var damage: float = 25.0   # VIOLATION: hardcoded gameplay value
```

> **学习要点**：规则约束通过对比示例强化，比纯文字描述更直观。正确示例展示了期望模式，错误示例标注了违规原因。

---

### 3.4 Template 层：文档驱动开发

**设计模式**：Markdown 模板 + 内嵌指引注释

#### 核心设计技巧

**技巧 13：模板内指引注释（Scaffolding Comments）**

```markdown
## Core Fantasy

[What power, experience, or feeling does the player get from this game?
What can they do here that they can't do anywhere else?

The core fantasy is the emotional promise. It's not a feature list — it's the
answer to "why would someone choose THIS game over anything else they could
be doing?"]

Examples of strong core fantasies:
- "You are a lone survivor building a new life in a hostile wilderness" (survival)
- "You command a civilization across millennia" (strategy)
```

> **学习要点**：模板不只是占位符——它包含填写指引、质量标准和示例。这种"教学型模板"确保即使新手也能产出专业质量的文档。

**技巧 14：设计测试（Design Test）**

```markdown
### Pillar 1: [Name]
[One sentence defining this non-negotiable design principle.]

*Design test*: [A concrete decision this pillar would resolve. "If we're
debating between X and Y, this pillar says we choose __."]
```

> **学习要点**：设计测试让抽象原则可验证。每个支柱必须能解决一个具体的决策——如果它不能，说明它太模糊了。这是"可证伪性"原则在提示词工程中的应用。

---

### 3.5 Hook 层：自动化校验

**设计模式**：Bash 脚本 + 事件触发

```bash
# .codebuddy/hooks/post/agent-stop.sh
# 在代理停止后自动执行
```

#### 核心设计技巧

**技巧 15：事件驱动校验**

Hooks 在特定事件（代理启动、代理停止、文件写入等）时自动触发，执行校验脚本。

> **学习要点**：Hooks 实现了"声明式约束 + 自动化执行"的组合。Rules 定义"什么应该遵守"，Hooks 校验"是否真的遵守了"。这种分层确保约束既可读又可执行。

---

## 4. 跨组件设计模式 / Cross-Component Patterns

### 4.1 协作协议统一

所有 Agent 共享相同的协作协议结构：

1. **角色定义** — "You are a collaborative consultant, not an autonomous executor."
2. **工作流步骤** — Ask → Options → Draft → Approve
3. **协作心态** — 6 条行为准则
4. **结构化决策 UI** — AskUserQuestion 的 Explain → Capture 模式

> **学习要点**：统一协议确保所有代理行为一致。用户无需为每个代理学习不同的交互模式。

### 4.2 上下文管理策略

```
CODEBUDDY.md          → 全局上下文（始终注入）
Agent definition      → 角色上下文（代理激活时注入）
Skill definition      → 工作流上下文（技能调用时注入）
Rule (path-matched)   → 约束上下文（路径匹配时注入）
Template (referenced) → 文档上下文（技能引用时注入）
Session state file    → 会话上下文（跨会话持久化）
```

> **学习要点**：上下文管理是大规模提示词工程的核心挑战。CCGS 通过分层注入和会话状态文件解决上下文窗口有限的问题。每层只在需要时注入，避免一次性加载所有内容。

### 4.3 委派与升级模式

```
升级路径：
gameplay-programmer → lead-programmer → technical-director
game-designer → creative-director
art-director → creative-director

委派路径：
creative-director → game-designer, art-director, audio-director, narrative-director
lead-programmer → gameplay-programmer, engine-programmer, ai-programmer
```

> **学习要点**：明确的升级和委派路径防止了"所有问题都涌向用户"的情况。低级问题由代理之间解决，只有战略级问题才升级到用户。

---

## 5. 提示词工程质量评估 / Quality Assessment

### 5.1 优势

| 维度 | 评分 | 说明 |
|------|------|------|
| 架构设计 | ⭐⭐⭐⭐⭐ | 五层架构清晰，关注点分离 |
| 角色定义 | ⭐⭐⭐⭐⭐ | 人格化 + 委派图 + 禁止事项 |
| 工作流编排 | ⭐⭐⭐⭐⭐ | 分阶段 + 门控 + 增量写入 |
| 理论嵌入 | ⭐⭐⭐⭐⭐ | MDA/SDT/Flow/Bartle 直接写入 |
| 上下文管理 | ⭐⭐⭐⭐ | 分层注入，但跨会话恢复有挑战 |
| 一致性 | ⭐⭐⭐⭐ | 协议统一，但部分文件格式不完全一致 |

### 5.2 可改进之处

1. **部分 Skill 翻译质量参差**：brainstorm SKILL.md 中的中文翻译有明显机翻痕迹（如 "精益" 应为 "精简"，"独奏" 应为 "单人"）
2. **Agent description 双语格式不完全统一**：部分使用 `"English / 中文"` 格式，部分未翻译
3. **Rule 文件的约束描述缺少双语**：除 gameplay-code 和 engine-code 外，其余规则文件未双语化
4. **Template 文件的指引注释未汉化**：内嵌的填写指引仍为纯英文

---

## 6. 提示词工程学习路径 / Learning Path

### 初学者

1. 阅读 `CODEBUDDY.md` — 理解全局入口的设计
2. 阅读 `.codebuddy/rules/gameplay-code.md` — 学习路径作用域规则
3. 阅读 `.codebuddy/docs/templates/game-concept.md` — 学习教学型模板

### 进阶者

4. 阅读 `.codebuddy/agents/game-designer.md` — 学习角色人格化设计
5. 阅读 `.codebuddy/agents/creative-director.md` — 学习委派图和升级路径
6. 阅读 `.codebuddy/skills/brainstorm/SKILL.md` — 学习分阶段工作流编排

### 高级者

7. 阅读 `.codebuddy/docs/coordination-rules.md` — 学习多代理协调机制
8. 阅读 `.codebuddy/docs/context-management.md` — 学习上下文管理策略
9. 对比不同 Agent 的协作协议变体 — 理解统一协议中的专业化适配

---

## 7. 术语对照 / Terminology Reference

详见 `.codebuddy/docs/glossary.md`
