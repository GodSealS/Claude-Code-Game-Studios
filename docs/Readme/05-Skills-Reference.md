# Skills 参考手册

本文档详细介绍 CodeBuddy Game Studios 架构中所有 72 个 Skill（斜杠命令）的功能、使用场景和参数。

---

## 快速索引

| 类别 | 数量 | Skills |
|------|------|--------|
| 入门与导航 | 5 | `/start`, `/help`, `/project-stage-detect`, `/setup-engine`, `/adopt` |
| 游戏设计 | 6 | `/brainstorm`, `/map-systems`, `/design-system`, `/quick-design`, `/review-all-gdds`, `/propagate-design-change` |
| UX 设计 | 2 | `/ux-design`, `/ux-review` |
| 架构 | 4 | `/create-architecture`, `/architecture-decision`, `/architecture-review`, `/create-control-manifest` |
| 故事与迭代 | 8 | `/create-epics`, `/create-stories`, `/dev-story`, `/sprint-plan`, `/sprint-status`, `/story-readiness`, `/story-done`, `/estimate` |
| 审查与分析 | 11 | `/design-review`, `/code-review`, `/balance-check`, `/asset-audit`, `/content-audit`, `/scope-check`, `/perf-profile`, `/tech-debt`, `/gate-check`, `/consistency-check`, `/reverse-document` |
| QA 与测试 | 9 | `/qa-plan`, `/smoke-check`, `/soak-test`, `/regression-suite`, `/test-setup`, `/test-helpers`, `/test-evidence-review`, `/test-flakiness`, `/skill-test` |
| 生产管理 | 6 | `/milestone-review`, `/retrospective`, `/bug-report`, `/bug-triage`, `/reverse-document`, `/playtest-report` |
| 发布 | 6 | `/release-checklist`, `/launch-checklist`, `/changelog`, `/patch-notes`, `/hotfix` |
| 创意与内容 | 3 | `/prototype`, `/onboard`, `/localize` |
| 团队协调 | 9 | `/team-combat`, `/team-narrative`, `/team-ui`, `/team-release`, `/team-polish`, `/team-audio`, `/team-level`, `/team-live-ops`, `/team-qa` |

---

## 入门与导航

### /start

**模型**: MiniMax-M2.7

**功能**: 首次入门引导，询问用户当前状态，推荐合适的工作流。

**参数**: 无

**使用场景**: 第一次使用项目时

**工作流程**:
1. 检测项目状态（引擎、概念、代码、原型）
2. 询问用户当前状态（A/B/C/D 选项）
3. 根据回答推荐下一步操作

---

### /help

**模型**: MiniMax-M2.7

**功能**: 上下文感知帮助，读取当前阶段和工件，显示所需的下一步。

**参数**: 无

**使用场景**: 不确定下一步该做什么时

---

### /project-stage-detect

**模型**: MiniMax-M2.7

**功能**: 完整项目审计，检测阶段，识别存在缺口，推荐下一步。

**参数**: 无

**输出**: 阶段报告，包含：
- 当前检测到的阶段
- 存在的工件清单
- 缺失的关键工件
- 推荐的下一步操作

---

### /setup-engine

**功能**: 配置引擎和版本，检测知识缺口，填充版本感知参考文档。

**参数**: `[engine] [version]`（可选）

**示例**:
```
/setup-engine              # 交互式选择
/setup-engine godot 4.6    # 指定引擎和版本
/setup-engine unity 2023.2 # 指定 Unity 版本
```

**输出**:
- 更新 `CODEBUDDY.md` 技术栈
- 创建 `.codebuddy/docs/technical-preferences.md`
- 填充 `docs/engine-reference/` 参考文档

---

### /adopt

**功能**: 现有项目迁移，检查 GDD/ADR/Story 的内部结构合规性，生成迁移计划。

**参数**: 无

**使用场景**: 已有项目，想采用本架构

---

## 游戏设计

### /brainstorm

**功能**: 引导式创意构思，使用专业方法（MDA、玩家心理学、动词优先设计）。

**参数**: `open` 或 `[提示]`

**示例**:
```
/brainstorm open           # 完全开放式探索
/brainstorm "太空探索"      # 基于主题的探索
/brainstorm "恐怖生存"      # 基于类型的探索
```

**输出**: 游戏概念文档

---

### /map-systems

**功能**: 将游戏概念分解为系统，映射依赖关系，确定设计优先级顺序。

**参数**: 无

**输出**: `design/systems-index.md`

---

### /design-system

**功能**: 引导式分节 GDD 编写，用于单个游戏系统。

**参数**: `[system-name]`

**示例**:
```
/design-system combat
/design-system inventory
/design-system progression
```

**输出**: `design/gdd/[system-name].md`

**GDD 包含章节**:
1. 系统概述
2. 目标与体验
3. 机制详解
4. 数学公式和数值
5. 边界情况和错误处理
6. UI/UX 需求
7. 音频需求
8. 与其他系统的关系

---

### /quick-design

**功能**: 轻量级设计规范，用于小改动、调整、小的添加。

**参数**: `[描述]`

**使用场景**: 不需要完整 GDD 的小变更

---

### /review-all-gdds

**模型**: GLM-5.1

**功能**: 跨 GDD 一致性和游戏设计整体审查。

**参数**: 无

**检查内容**:
- 跨文档一致性
- 设计理论合规性
- 主导策略检测
- 经济平衡
- 认知负荷评估

---

### /propagate-design-change

**功能**: 当 GDD 被修改时，找到受影响的 ADR 并生成影响报告。

**参数**: `[gdd-file]`

**使用场景**: 修改设计文档后，了解影响范围

---

## UX 设计

### /ux-design

**功能**: 引导式分节 UX 规范编写（界面/流程、HUD 或模式库）。

**参数**: `[type]`

**类型**:
- `screen` - 单个界面
- `flow` - 用户流程
- `hud` - HUD 设计
- `pattern` - 交互模式库

---

### /ux-review

**功能**: 验证 UX 规范的 GDD 对齐性、无障碍性和模式合规性。

**参数**: `[ux-spec-file]`

---

## 架构

### /create-architecture

**功能**: 引导式主架构文档编写。

**参数**: 无

**输出**: 主架构文档

---

### /architecture-decision

**功能**: 创建架构决策记录（ADR）。

**参数**: 无（交互式）

**输出**: `docs/architecture/adr/[decision-name].md`

**ADR 包含**:
- 背景
- 决策
- 考虑的替代方案
- 后果
- 相关决策

---

### /architecture-review

**模型**: GLM-5.1

**功能**: 验证所有 ADR 的完整性、依赖排序和 GDD 覆盖。

**参数**: 无

---

### /create-control-manifest

**功能**: 从已接受的 ADR 生成程序员规则表。

**参数**: 无

**输出**: 控制清单（每个系统的"必须做/绝不能做"）

---

## 故事与迭代

### /create-epics

**功能**: 将 GDD 和 ADR 转换为史诗任务，每个架构模块一个史诗。

**参数**: 无

**输出**: `production/epics/` 目录

---

### /create-stories

**功能**: 将单个史诗分解为可实现的 Story 文件。

**参数**: `[epic-slug]`

**输出**: `production/stories/[epic]/` 目录

---

### /dev-story

**功能**: 读取 Story 并实现它，路由到合适的程序员 Agent。

**参数**: `[story-file]`

**工作流程**:
1. 验证准备度 (`/story-readiness`)
2. 路由到合适的程序员 Agent
3. 实现代码和测试
4. 验证验收标准

---

### /sprint-plan

**功能**: 生成或更新迭代计划，初始化 sprint-status.yaml。

**参数**: `new` 或 `[sprint-name]`

**示例**:
```
/sprint-plan new                    # 创建新迭代
/sprint-plan sprint-3               # 更新迭代 3
```

---

### /sprint-status

**模型**: MiniMax-M2.7

**功能**: 快速 30 行迭代状态快照。

**参数**: 无

**输出**: 当前迭代状态摘要

---

### /story-readiness

**模型**: MiniMax-M2.7

**功能**: 验证 Story 在接手前是否已准备好实现。

**参数**: `[story-file]`

**返回值**: `READY` / `NEEDS WORK` / `BLOCKED`

---

### /story-done

**功能**: 实现后的 8 阶段完成审查，更新 Story 文件，显示下一个 Story。

**参数**: `[story-file]`

**工作流程**:
1. 代码审查
2. 测试验证
3. 文档更新
4. 验收标准验证

---

### /estimate

**功能**: 结构化工作量估算，包含复杂度、依赖和风险分解。

**参数**: `[task-description]`

**输出**: 估算报告，包含：
- 故事点估算
- 复杂度分析
- 依赖识别
- 风险评估

---

## 审查与分析

### /design-review

**功能**: 审查游戏设计文档的完整性和一致性。

**参数**: `[design-doc]`

---

### /code-review

**功能**: 代码架构审查。

**参数**: `[file-or-pattern]`

---

### /balance-check

**功能**: 分析游戏平衡数据、公式和配置，标记异常值。

**参数**: `[data-file]`（可选）

---

### /asset-audit

**功能**: 审查资源的命名规范、文件大小预算和管道合规性。

**参数**: `[asset-path]`（可选）

---

### /content-audit

**功能**: 审计 GDD 指定的内容计数与已实现内容的对比。

**参数**: 无

---

### /scope-check

**模型**: MiniMax-M2.7

**功能**: 分析功能或迭代范围与原始计划的对比，标记范围蔓延。

**参数**: `[feature-or-sprint]`

---

### /perf-profile

**功能**: 结构化性能分析和瓶颈识别。

**参数**: `[target]`（可选）

---

### /tech-debt

**功能**: 扫描、跟踪、优先排序和报告技术债务。

**参数**: `[action]`

**操作**:
- `scan` - 扫描技术债务
- `report` - 生成报告
- `prioritize` - 优先排序

---

### /gate-check

**模型**: GLM-5.1

**功能**: 验证阶段准备度，决定是否可以进入下一阶段。

**参数**: `[phase]`

**阶段**:
- `concept` - 概念阶段
- `pre-production` - 预制作
- `production-alpha` - 制作 Alpha
- `production-beta` - 制作 Beta
- `polish` - 打磨
- `release` - 发布

**返回值**: `PASS` / `CONCERNS` / `FAIL`

---

### /consistency-check

**功能**: 扫描所有 GDD，检测跨文档不一致（冲突的数值、名称、规则）。

**参数**: 无

---

### /reverse-document

**功能**: 从现有实现生成设计或架构文档。

**参数**: `[source-path]`

**使用场景**: 已有代码，需要补文档

---

## QA 与测试

### /qa-plan

**功能**: 为迭代或功能生成 QA 测试计划。

**参数**: `[sprint-or-feature]`

**输出**: 测试计划文档

---

### /smoke-check

**功能**: 在 QA 交接前运行关键路径冒烟测试门。

**参数**: 无

**返回值**: `PASS` / `FAIL`

---

### /soak-test

**功能**: 为长时间游戏会话生成浸泡测试协议。

**参数**: 无

---

### /regression-suite

**功能**: 将测试覆盖映射到 GDD 关键路径，识别已修复但无回归测试的 Bug。

**参数**: 无

---

### /test-setup

**功能**: 为项目引擎搭建测试框架和 CI/CD 管道。

**参数**: 无

**一次性运行**: 项目初始化时

---

### /test-helpers

**功能**: 为测试套件生成引擎特定的测试辅助库。

**参数**: 无

---

### /test-evidence-review

**功能**: 测试文件和手动证据的质量审查。

**参数**: `[evidence-path]`

**返回值**: `ADEQUATE` / `INCOMPLETE` / `MISSING`

---

### /test-flakiness

**功能**: 从 CI 运行日志检测非确定性（不稳定）测试。

**参数**: `[log-path]`（可选）

---

### /skill-test

**功能**: 验证 Skill 文件的结构合规性和行为正确性。

**参数**: `[skill-path]`（可选，默认全部）

---

## 生产管理

### /milestone-review

**功能**: 审查里程碑进度并生成状态报告。

**参数**: `[milestone-name]`（可选）

---

### /retrospective

**功能**: 运行结构化迭代或里程碑回顾。

**参数**: `[sprint-or-milestone]`（可选）

---

### /bug-report

**功能**: 创建结构化 Bug 报告。

**参数**: 无（交互式）

**输出**: `production/bugs/[bug-id].md`

---

### /bug-triage

**功能**: 读取所有打开的 Bug，重新评估优先级 vs 严重性，分配所有者和标签。

**参数**: 无

---

### /playtest-report

**功能**: 生成结构化游戏测试报告或分析现有测试笔记。

**参数**: `[notes-file]`（可选）

---

## 发布

### /release-checklist

**功能**: 为当前构建生成和验证发布前清单。

**参数**: 无

---

### /launch-checklist

**功能**: 跨所有部门的完整上线准备验证。

**参数**: 无

---

### /changelog

**功能**: 从 Git 历史记录和迭代数据自动生成变更日志。

**参数**: `[version]`（可选）

---

### /patch-notes

**功能**: 从 Git 历史和内部数据生成面向玩家的补丁说明。

**参数**: `[version]`（可选）

---

### /hotfix

**功能**: 带审计追踪的紧急修复工作流，绕过正常迭代流程。

**参数**: `[bug-id]`

---

## 创意与内容

### /prototype

**功能**: 快速可丢弃原型，用于验证机制（宽松标准，隔离工作树）。

**参数**: `[mechanic-name]`

**输出**: `prototypes/[mechanic-name]/` 目录

---

### /onboard

**功能**: 为新贡献者或 Agent 生成上下文感知的入门文档。

**参数**: `[role]`

---

### /localize

**功能**: 本地化工作流：字符串提取、验证、翻译准备。

**参数**: `[action]`

**操作**:
- `extract` - 提取字符串
- `validate` - 验证翻译就绪性
- `report` - 生成状态报告

---

## 团队协调

### /team-combat

**协调角色**:
- game-designer
- gameplay-programmer
- ai-programmer
- technical-artist
- sound-designer
- qa-tester

**功能**: 协调完整的战斗团队管道

---

### /team-narrative

**协调角色**:
- narrative-director
- writer
- world-builder
- level-designer

**功能**: 协调完整的叙事团队管道

---

### /team-ui

**协调角色**:
- ux-designer
- ui-programmer
- art-director
- accessibility-specialist

**功能**: 协调完整的 UI 团队管道

---

### /team-release

**协调角色**:
- release-manager
- qa-lead
- devops-engineer
- producer

**功能**: 协调完整的发布团队管道

---

### /team-polish

**协调角色**:
- performance-analyst
- technical-artist
- sound-designer
- qa-tester

**功能**: 协调完整的打磨团队管道

---

### /team-audio

**协调角色**:
- audio-director
- sound-designer
- technical-artist
- gameplay-programmer

**功能**: 协调完整的音频团队管道

---

### /team-level

**协调角色**:
- level-designer
- narrative-director
- world-builder
- art-director
- systems-designer
- qa-tester

**功能**: 协调完整的关卡创建团队管道

---

### /team-live-ops

**协调角色**:
- live-ops-designer
- economy-designer
- community-manager
- analytics-engineer

**功能**: 协调运营团队处理赛季、活动和上线后内容

---

### /team-qa

**协调角色**:
- qa-lead
- qa-tester
- gameplay-programmer
- producer

**功能**: 协调完整的 QA 团队周期 — 测试计划、测试用例、冒烟测试、签字

---

## 使用建议

### 常见工作流组合

**新项目启动**:
```
/start → /brainstorm → /setup-engine → /map-systems → /design-system
```

**功能开发**:
```
/create-epics → /create-stories → /dev-story → /story-done
```

**发布准备**:
```
/qa-plan → /team-qa → /smoke-check → /release-checklist → /team-release
```

**迭代管理**:
```
/sprint-plan → /dev-story (多次) → /sprint-status → /retrospective
```

---

> **提示**: 所有 Skill 都可以通过输入 `/` 在 CodeBuddy 中查看和调用。
