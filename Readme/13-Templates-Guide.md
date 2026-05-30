# Templates Guide / 模板指南

> A deep dive into the role, classification, and authoring of the 38 templates in `.codebuddy/docs/templates/`

> **中文翻译**：深入了解 `.codebuddy/docs/templates/` 下 38 个模板的角色、分类和编写方法。

---

## 1. What Are Templates? / 模板是什么？

在 CCGS 提示词工程架构中，**Templates（模板）** 是 Skills 和 Agents 的**输出格式契约（Output Format Contract）**。它们不是单纯的文档模板——每当你运行一个 Skill（如 `/brainstorm`、`/design-system`、`/create-architecture`），Agent 会读取对应的模板文件，并按照其中定义的章节结构、表格格式和验证标准来**生成结构化的输出文档**。

### 三层提示词架构

整个 CCGS 系统可以理解为三层结构：

```
┌─────────────────────────────────────────────────────┐
│  Skill (SKILL.md)   —  HOW to produce it            │
│  "按章节引导用户，逐步填写，交叉引用依赖..."         │
├─────────────────────────────────────────────────────┤
│  Template (模板文件)  —  WHAT the output looks like  │
│  "必须包含 8 个章节、每个公式有变量表、边界情况..."  │
├─────────────────────────────────────────────────────┤
│  Rule (rules/*.md)   —  CONSTRAINTS on the output   │
│  "design-docs.md: 必须包含 8 个章节、公式格式..."    │
└─────────────────────────────────────────────────────┘
```

**核心比喻**：
- **Skill** = 菜谱（教你**怎么做**这道菜）
- **Template** = 菜品的摆盘标准（最终**长什么样**）
- **Rule** = 食品安全规范（**不可违反**的约束）

### 模板在提示词中的作用

1. **结构化输出保证**：确保所有 Agent 产出的文档具有一致的格式，使得跨文档自动化检查（如 `/consistency-check`）成为可能。

2. **分层上下文加载（Tiered Context Loading）**：每个模板的 Summary 章节专门设计为"一句话摘要"，当 Skill 需要扫描 20 个 GDD 时，只加载摘要即可判断是否需要深读。

3. **人机双重可读**：模板同时包含用于 AI 解析的元数据字段（如 Cross-References 表格）和人类可读的说明文字，并采用中英双语。

4. **可追溯性（Traceability）**：模板中的 `GDD Requirements Addressed`、`ADR Dependencies`、`Cross-References` 等章节，使设计→架构→代码的追溯链完整可审计。

5. **设计理论内嵌**：核心模板将 MDA 框架、Flow State、Self-Determination Theory 等游戏设计理论**结构化地嵌入**到文档格式中，确保设计决策有理论依据。

---

## 2. Template Classification / 模板分类

38 个模板按照游戏开发流水线的阶段分为 8 大类：

### 2.1 概念与设计阶段（Concept & Design）—— 7 个

| 模板文件 | 对应 Skill | 产出物 | 在流水线中的位置 |
|----------|-----------|--------|------------------|
| `game-concept.md` | `/brainstorm` | 游戏概念文档 | **入口** — 所有设计的起点 |
| `game-pillars.md` | `/brainstorm`（子章节） | 游戏支柱定义 | 概念→系统分解之间 |
| `game-design-document.md` | `/design-system` | 单系统 GDD | **核心** — 每个系统一份 |
| `systems-index.md` | `/map-systems` | 系统枚举与依赖 | 概念→各系统 GDD 的桥梁 |
| `faction-design.md` | `/design-system`（变体） | 阵营设计文档 | 叙事向游戏特有 |
| `player-journey.md` | `/design-system`（变体） | 玩家旅程 | 线性叙事游戏 |
| `pitch-document.md` | `/brainstorm`（前期） | 推介文档 | 向发行商/团队推介 |

### 2.2 视觉与音频（Visual & Audio）—— 2 个

| 模板文件 | 对应 Skill | 产出物 | 在流水线中的位置 |
|----------|-----------|--------|------------------|
| `art-bible.md` | `/art-bible` | 美术圣经 | GDD 批准后、资产生产前 |
| `sound-bible.md` | `/sound-bible` | 音效圣经 | GDD 批准后 |

### 2.3 UX/UI 设计 —— 3 个

| 模板文件 | 对应 Skill | 产出物 | 在流水线中的位置 |
|----------|-----------|--------|------------------|
| `ux-spec.md` | `/ux-design screen` | 界面/交互流程规范 | GDD UI Requirements 章节之后 |
| `hud-design.md` | `/ux-design hud` | HUD 设计 | 与 ux-spec 协同 |
| `interaction-pattern-library.md` | `/ux-design pattern` | 交互模式库 | 项目级通用模式 |

### 2.4 架构设计（Architecture）—— 4 个

| 模板文件 | 对应 Skill | 产出物 | 在流水线中的位置 |
|----------|-----------|--------|------------------|
| `architecture-decision-record.md` | `/architecture-decision` | ADR | **核心** — 每个技术决策一份 |
| `technical-design-document.md` | `/create-architecture` | 系统技术设计 | GDD→代码实现之间 |
| `architecture-traceability.md` | `/architecture-review` | 可追溯性矩阵 | 架构审查时生成 |
| `architecture-doc-from-code.md` | `/reverse-document` | 逆向架构文档 | 已有代码需要补文档时 |

### 2.5 关卡与叙事（Level & Narrative）—— 2 个

| 模板文件 | 对应 Skill | 产出物 | 在流水线中的位置 |
|----------|-----------|--------|------------------|
| `level-design-document.md` | `/design-system`（关卡） | 关卡设计文档 | 系统设计之后 |
| `narrative-character-sheet.md` | `/design-system`（角色） | 角色设定表 | 叙事设计阶段 |

### 2.6 计划与生产（Planning & Production）—— 5 个

| 模板文件 | 对应 Skill | 产出物 | 在流水线中的位置 |
|----------|-----------|--------|------------------|
| `sprint-plan.md` | `/sprint-plan` | 冲刺计划 | **核心** — 生产执行基础 |
| `milestone-definition.md` | `/milestone-review` | 里程碑定义 | 项目级规划 |
| `project-stage-report.md` | `/project-stage-detect` | 阶段审计报告 | 项目审计时 |
| `release-checklist-template.md` | `/release-checklist` | 发布清单 | 发布前 |
| `release-notes.md` | `/changelog` | 发布说明 | 发布时 |

### 2.7 QA 与测试（QA & Testing）—— 4 个

| 模板文件 | 对应 Skill | 产出物 | 在流水线中的位置 |
|----------|-----------|--------|------------------|
| `test-plan.md` | `/qa-plan` | 测试计划 | **核心** — 每次冲刺 |
| `test-evidence.md` | `/test-evidence-review` | 测试证据 | Story Done 阶段 |
| `accessibility-requirements.md` | `/ux-review` | 无障碍需求清单 | UX 审查时 |
| `skill-test-spec.md` | `/skill-test` | Skill 测试规格 | 元测试 — 测试系统自身 |

### 2.8 分析与沟通（Analysis & Communication）—— 11 个

| 模板文件 | 对应 Skill | 产出物 | 在流水线中的位置 |
|----------|-----------|--------|------------------|
| `difficulty-curve.md` | `/balance-check` | 难度曲线分析 | 平衡审查时 |
| `economy-model.md` | `/balance-check` | 经济模型 | 经济平衡时 |
| `risk-register-entry.md` | `/sprint-plan` | 风险登记 | 每次冲刺规划 |
| `changelog-template.md` | `/changelog` | 变更日志 | 发布时 |
| `incident-response.md` | `/hotfix` | 事故响应记录 | 紧急修复时 |
| `post-mortem.md` | `/retrospective` | 事后分析 | 回顾时 |
| `concept-doc-from-prototype.md` | `/reverse-document` | 原型→概念文档 | 逆向工程 |
| `design-doc-from-implementation.md` | `/reverse-document` | 实现→设计文档 | 逆向工程 |
| `collaborative-protocols/` | — | 协作协议文档 | 项目配置 |

---

## 3. Core Templates / 核心模板

以下 7 个模板是整个系统的**骨架**——它们被最频繁地调用，也是其他模板的数据来源：

### 🥇 game-concept.md（游戏概念）

**为什么核心**：这是所有设计的**唯一入口**。`/brainstorm` 产出这个文档，之后的 `/map-systems`、`/design-system`、`/create-architecture` 都从这里派生。

**关键设计特点**：
- 内嵌 **MDA 框架**（Mechanics-Dynamics-Aesthetics）表格
- **Self-Determination Theory**（自主/胜任/归属）动机分析
- **Bartle 玩家类型** 受众定位
- **Flow State** 心流设计
- MVP 定义和范围阶梯（Scope Tiers）

### 🥇 game-design-document.md（游戏设计文档 / GDD）

**为什么核心**：每个游戏系统都生成一份 GDD，它是设计→实现的**唯一权威来源**。`/design-system` 使用此模板，`/code-review` 会对比 GDD 验证代码。

**关键设计特点**：
- **分层加载摘要**（Summary）— Skill 扫描 20 个 GDD 时先读摘要
- **状态机表格**（States and Transitions）
- **公式表格**（Formulas）— 每个变量有类型、范围、来源
- **边界情况表格**（Edge Cases）
- **跨文档引用声明**（Cross-References）— 机器可验证的依赖关系
- **Game Feel 规范**— 输入延迟、动画帧数据、打击感要素
- **验收标准**（Acceptance Criteria）

### 🥇 architecture-decision-record.md（架构决策记录 / ADR）

**为什么核心**：每个重大技术决策生成一份 ADR。`/architecture-review` 会验证 ADR 对 GDD 的完整覆盖。

**关键设计特点**：
- **引擎兼容性矩阵**（Engine Compatibility）— 知识风险标记（LOW/MEDIUM/HIGH）
- **ADR 依赖链**（Depends On / Enables / Blocks）
- **替代方案对比**（Alternatives Considered）— 每个替代方案有 Pros/Cons/Effort/Rejection Reason
- **性能影响评估**（Performance Implications）
- **GDD 需求追溯**（GDD Requirements Addressed）— 强制追溯链

### 🥇 systems-index.md（系统索引）

**为什么核心**：连接概念与实现的**桥梁**。`/map-systems` 将概念分解为系统，按依赖排序，决定设计优先级。

**关键设计特点**：
- 四层依赖图（Foundation → Core → Feature → Presentation → Polish）
- MVP/Vertical Slice/Alpha/Full Vision 优先级分层
- 循环依赖检测
- 高风险系统标记

### 🥇 sprint-plan.md（冲刺计划）

**为什么核心**：生产执行的**日常操作单元**。每个冲刺生成一份计划，链接到具体的 Story 文件。

**关键设计特点**：
- 容量规划（Capacity）— 编程/设计/美术/音频/QA
- Must Have / Should Have / Nice to Have 优先级分层
- 依赖和风险追踪
- 每日状态追踪
- Definition of Done 清单

### 🥇 test-plan.md（测试计划）

**为什么核心**：质量门控的**标准格式**。`/qa-plan` 生成，`/smoke-check` 和 `/story-done` 会读取验证。

**关键设计特点**：
- 按 Story 类型分流（Logic → 自动化 / Visual-Feel → 手动证据）
- 自动化测试具体要求（测试文件路径、边界情况、预估数量）
- 手动 QA 检查清单（每项可证伪）
- 冒烟测试范围定义
- 签字流程

### 🥇 skill-test-spec.md（Skill 测试规格）

**为什么核心**：**元层次的质控**——测试系统自身的 Skill 是否正确运行。`/skill-test` 使用此模板。

**关键设计特点**：
- 静态断言（结构性检查）— 不需要 fixture
- 动态测试用例（包含 fixture 定义和预期行为）
- 回归标记

---

## 4. Template Anatomy / 模板结构解剖

以 `game-design-document.md` 为例，说明模板的内部设计模式：

### 模式 1：分层摘要（Tiered Summary）

```markdown
## Summary / 摘要
[2-3 sentences: what this system is, what it does for the player...]
> **Quick reference** — Layer: `Foundation | Core | Feature | Presentation`
> · Priority: `MVP | Vertical Slice | Alpha | Full Vision` · Key deps: `[...]`
```

**目的**：允许 Skill 在扫描 20 个 GDD 时只读取 Summary 即可判断是否需要深读。

### 模式 2：机器可解析表格（Machine-Parseable Tables）

```markdown
| Variable | Type | Range | Source | Description |
|----------|------|-------|--------|-------------|
```

`/consistency-check` 通过解析这些表格来发现跨文档数值冲突。

### 模式 3：章节目的说明（Section Purpose）

```markdown
> **Why this section exists**: The HUD design philosophy is not decoration...
```

几乎每个重要章节都以一段**解释性文字**开头，说明此章节的设计理由——这是给 AI Agent 看的"元提示"，帮助 Agent 正确理解和填充内容。

### 模式 4：中英双语注释

所有模板都采用 `English / 中文` 双语格式。注释行同时提供中英文说明，确保中英文 Agent 都能正确理解。

### 模式 5：前置元数据（YAML-like Header）

```markdown
> **Status**: Draft | In Review | Approved | Implemented
> **Author**: [Agent or person]
> **Last Updated**: [Date]
> **Last Verified**: [Date]
```

状态机驱动文档生命周期，`/design-review` 和 `/story-done` 会更新这些字段。

---

## 5. How to Write a New Template / 如何编写新模板

### 5.1 前置决策：这个模板该存在吗？

在创建新模板之前，先问自己：

1. **有没有已存在的模板可以复用或扩展？** 优先扩展现有模板而非新建。
2. **是否有 Skill 需要这个输出格式？** 每个模板必须有至少一个 Skill 使用它。
3. **输出是否机器可验证？** 如果输出不需要被 `/consistency-check` 或 `/architecture-review` 自动化检查，可能只需要一个自由格式文档。

### 5.2 模板编写步骤

#### Step 1：确定模板类型和阶段

对照上文的 8 大分类，确定模板属于哪个流水线阶段。这决定了它应该"看到"哪些上游文档的数据。

#### Step 2：设计分层摘要

```markdown
## Summary / 摘要

[2-3 sentences describing the document's purpose and what decision/design it captures.
Written for tiered context loading. Be specific enough that a Skill scanning 20 of
these can decide whether to read further.]

> **Quick reference** — Type: `[Concept | Design | Architecture | Test | ...]`
> · Stage: `[Concept | Pre-Production | Production | QA | Release]`
> · Key deps: `[upstream documents this depends on]`
```

#### Step 3：设计状态机和元数据头

```markdown
> **Status**: Draft | In Review | Approved | Implemented | Deprecated
> **Author**: [name or agent]
> **Last Updated**: [YYYY-MM-DD]
> **Last Verified**: [YYYY-MM-DD]
```

确保状态流转有明确的触发条件（通常由对应的 Skill 更新）。

#### Step 4：设计可追溯字段

如果你的模板会被下游文档引用，必须包含可追溯字段：

```markdown
## [上游文档类型] Requirements Addressed / 需求追溯

| Source Document | Section | Requirement | How This Satisfies It |
|----------------|---------|-------------|----------------------|
```

如果你的模板引用了上游文档，必须包含 Cross-References 或 Dependencies 表格。

#### Step 5：编写章节目的说明（Section Purpose）

每个非自明的章节都应该以 `> **Why this section exists**:` 开头，说明设计理由。这是给 AI Agent 的上下文——帮助它正确理解和填充：

```markdown
> **Why this section exists**: The Game Feel section is separated from Visual/Audio
> Requirements because it documents HOW the mechanic feels (responsiveness, weight,
> snap) rather than WHAT feedback events occur. These are design targets for timing
> and frame data, and must be specified at design time because they drive animation
> budgets and input handling architecture.
```

#### Step 6：使用标准化的表格格式

遵循已有模板的表格约定：

- 每个表格包含英文标题行 + 中文注释行
- 变量表至少包含：名称、类型、范围、来源、描述
- 风险表至少包含：风险描述、概率、影响、缓解措施
- 状态表至少包含：状态名、进入条件、退出条件、行为

#### Step 7：添加中英双语

保持与现有模板一致的双语格式。建议方式：
- 长段落：先英文，后面跟 ` / ` 分隔符后跟中文
- 表格：英文列 + 中文列，或同一单元格用 `/` 分隔
- 注释：`[English instruction] / [中文说明]`

#### Step 8：添加示例数据

用 `[placeholder]` 格式提供填表示例，帮助 Agent 理解预期格式：

```markdown
| Scenario | Expected Behavior | Rationale |
|----------|------------------|-----------|
| [What if X is zero?] | [This happens] | [Because of this reason] |
```

### 5.3 模板质量检查清单

写完新模板后，逐项检查：

- [ ] 有 2-3 句话的分层摘要
- [ ] 有元数据头（Status / Author / Last Updated）
- [ ] 有可追溯字段（上游引用 或 下游追溯声明）
- [ ] 重要章节有 "Why this section exists" 说明
- [ ] 表格格式与现有模板一致
- [ ] 中英双语注释完整
- [ ] 状态机的每个状态有明确的转换条件
- [ ] 占位符（`[...]`）使用统一格式
- [ ] 至少有一个 Skill 会使用此模板
- [ ] 编写了对应的 `skill-test-spec.md` 条目
- [ ] 在 `systems-index.md` 对应类别中注册

---

## 6. Template Dependency Graph / 模板依赖关系图

模板之间的数据流向：

```
game-concept.md
    ├── game-pillars.md
    ├── systems-index.md
    │       └── game-design-document.md (×N 个系统)
    │               ├── art-bible.md
    │               ├── sound-bible.md
    │               ├── ux-spec.md
    │               ├── hud-design.md
    │               ├── level-design-document.md
    │               ├── narrative-character-sheet.md
    │               ├── faction-design.md
    │               ├── player-journey.md
    │               │
    │               └── architecture-decision-record.md (×N 个决策)
    │                       └── architecture-traceability.md
    │
    └── pitch-document.md

sprint-plan.md  ← (读取 systems-index + ADRs)
    ├── milestone-definition.md
    ├── risk-register-entry.md
    └── test-plan.md
            ├── test-evidence.md
            └── skill-test-spec.md

release-checklist-template.md ← (读取 sprint-plan + test-plan)
    └── release-notes.md
        └── changelog-template.md
```

**关键洞察**：`game-concept.md` → `systems-index.md` → `game-design-document.md` → `architecture-decision-record.md` 是**核心数据链**，承载了游戏从概念到代码的完整映射。

---

## 7. Templates vs. Other Components / 模板与其他组件的关系

| 对比维度 | Templates | Skills | Rules | Hooks |
|----------|-----------|--------|-------|-------|
| **角色** | 输出格式契约 | 工作流指令 | 路径特定约束 | 事件触发脚本 |
| **修改频率** | 低（架构级变更） | 中（功能迭代） | 低 | 低 |
| **谁读取** | Agent（生成时）、Agent（验证时）、人类 | Agent（执行时） | Agent（编辑路径文件时） | 系统（事件触发时） |
| **示例** | `game-design-document.md` | `SKILL.md` | `design-docs.md` | `validate-commit.sh` |
| **修改影响** | 影响所有产出物的格式 | 影响单个工作流行为 | 影响路径下所有文件的编辑 | 影响单个事件的响应 |

---

## 8. Learning Path / 学习路径

### 初学者（理解模板的作用）

1. 阅读 `game-concept.md` — 理解 MDA/Flow/SDT 理论如何嵌入模板
2. 阅读 `game-design-document.md` — 理解"分层加载"和"机器可解析"
3. 运行一次 `/brainstorm`，观察 Agent 如何按模板生成输出

### 进阶（编写简单模板）

1. 以 `risk-register-entry.md` 为参考——它是较小的模板，结构清晰
2. 为新类型的文档编写模板
3. 编写对应的 `skill-test-spec` 验证模板的结构合规性

### 高级（设计复杂模板）

1. 研究 `architecture-decision-record.md` 的完整结构——引擎兼容性、ADR 依赖链、替代方案对比
2. 理解模板间的数据依赖关系
3. 设计跨模板的追溯链（Traceability Matrix）

---

## 9. FAQ / 常见问题

**Q: 模板和 Skill 中写的指令有什么区别？**
A: Skill 是"怎么做"（过程），模板是"产出什么"（结果）。Skill 描述的是引导用户填写的过程（先问 A，再问 B，交叉引用 C），模板定义的是最终产出的文档结构。

**Q: 模板中的中英双语是必需的吗？**
A: 强烈建议。CCGS 架构中，Agent 定义和 Skill 都使用中英双语，模板作为输出格式也应保持这一约定，确保中英文 Agent 都能正确理解和生成。

**Q: 我可以修改现有模板吗？**
A: 可以，但需谨慎。模板修改会影响所有使用该模板的 Skill 的输出格式。修改后应运行 `/skill-test` 验证相关 Skill 的兼容性。

**Q: 如何知道某个模板是否被某个 Skill 使用？**
A: 查看 `SKILL.md` 文件，通常 Skill 会声明其使用的模板路径。也可以在 `skill-test-spec.md` 中找到对应的测试条目。

---

## 10. Quick Reference / 速查表

| 我要... | 应使用/修改的模板 | 相关 Skill |
|---------|------------------|------------|
| 设计游戏概念 | `game-concept.md` | `/brainstorm` |
| 设计单个系统 | `game-design-document.md` | `/design-system` |
| 做技术决策 | `architecture-decision-record.md` | `/architecture-decision` |
| 分解系统 | `systems-index.md` | `/map-systems` |
| 规划冲刺 | `sprint-plan.md` | `/sprint-plan` |
| 生成测试计划 | `test-plan.md` | `/qa-plan` |
| 发布前检查 | `release-checklist-template.md` | `/release-checklist` |
| 从原型逆向出概念 | `concept-doc-from-prototype.md` | `/reverse-document` |
| 测试 Skill 本身 | `skill-test-spec.md` | `/skill-test` |

---

> **提示**: 本文档应作为 Readme 目录的第 13 号文档，与现有的 01-12 号文档配套使用。建议在阅读完 [05-Skills-Reference.md](./05-Skills-Reference.md) 和 [06-Hooks-and-Rules.md](./06-Hooks-and-Rules.md) 后阅读本文档，以建立对三层提示词架构的完整理解。
