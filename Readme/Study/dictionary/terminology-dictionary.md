# 术语中英文对照与功能解释

本文档收录 CodeBuddy 提示词工程体系中的核心术语，按功能域分类，便于快速查阅。

---

## 一、框架核心概念

| 英文术语 | 中文术语 | 功能解释 |
|----------|----------|----------|
| **Skill** | 技能 | 定义在 `.codebuddy/skills/<name>/SKILL.md` 中，是用户可通过斜杠命令（`/`）调用的功能单元。每个 Skill 描述一个完整的工作流，包含前置条件、执行阶段、输出模板和下一步建议。 |
| **Agent** | 智能体 | 定义在 `.codebuddy/agents/<name>.md` 中，是具备特定领域专长的虚拟协作者。Agent 拥有角色定义、核心职责、协作协议、最佳实践和委托地图。 |
| **Rule** | 规则 | 定义在 `.codebuddy/rules/<name>.md` 中，按文件路径（Glob 模式）匹配，为对应目录的代码或文档提供规范性约束。 |
| **Hook** | 钩子 | 定义在 `.codebuddy/hooks/` 中的 Shell 脚本，在特定会话事件（如启动、提交前）自动执行，用于环境检查、状态恢复等。 |
| **Frontmatter** | 前置元数据 | Markdown 文件顶部的 YAML 元数据块（由 `---` 包裹），用于声明 Skill、Agent、Rule 的配置属性，如 `name`、`description`、`allowed-tools`、`model` 等。 |

---

## 二、角色与协作概念

| 英文术语 | 中文术语 | 功能解释 |
|----------|----------|----------|
| **Subagent** | 子智能体 | 通过 `Task` 工具在当前会话内派生的 Agent，用于并行或串行处理子任务，共享会话权限上下文。 |
| **Agent Team** | 智能体团队 | 多个独立的 Claude Code 会话同时运行，通过共享任务列表协调（实验性功能，需设置环境变量）。 |
| **Delegation Map** | 委托地图 | Agent 文档中专门定义的章节，明确该 Agent 的汇报对象（Reports to）、委托对象（Delegates to）、升级目标（Escalation targets）和协作对象（Coordinates with）。 |
| **Orchestration** | 编排 | 由一个主 Skill 或 Agent 协调多个 Subagent 共同完成复杂任务的过程，如 `/team-combat` 同时激活战斗相关的多个 Agent。 |
| **Vertical Delegation** | 垂直委托 | 领导层 Agent 向部门负责人委托，部门负责人再向专家委托，不得跨层级跳过。 |
| **Horizontal Consultation** | 平级协商 | 同一层级的 Agent 可相互咨询，但无权在对方领域内做出 binding 决策。 |

---

## 三、文档与流程概念

| 英文术语 | 中文术语 | 功能解释 |
|----------|----------|----------|
| **GDD** | 游戏设计文档 | Game Design Document，存放于 `design/gdd/`，描述游戏的核心机制、系统、进度、经济等设计内容。 |
| **ADR** | 架构决策记录 | Architecture Decision Record，记录重大技术决策的背景、备选方案与后果，通常存放于 `docs/architecture/`。 |
| **Epic** | 史诗 | 大型功能模块，由架构文档映射而来，一个 Epic 对应一个架构模块，包含多个 Story。 |
| **Story** | 故事 | 可实施的开发任务单元，由 Epic 拆分而来，包含验收标准、GDD 需求追溯 ID 和测试证据路径。 |
| **Sprint** | 冲刺 | 固定周期的开发迭代，通常包含计划、执行、评审、回顾四个环节。 |
| **Gate Check** | 阶段门控 | 验证项目是否具备进入下一开发阶段的条件，输出 PASS / CONCERNS / FAIL 裁决。 |
| **Review Mode** | 审查模式 | 生产阶段的配置项（`production/review-mode.txt`），控制 Director 级 Agent 的审查频率：Full（每步审查）、Lean（仅阶段门控审查）、Solo（无审查）。 |

---

## 四、技术与工具概念

| 英文术语 | 中文术语 | 功能解释 |
|----------|----------|----------|
| **Slash Command** | 斜杠命令 | 用户输入的 `/skill-name` 形式的命令，CodeBuddy 解析后加载对应的 SKILL.md 并执行。 |
| **Model Tier** | 模型层级 | Skill 和 Agent 的模型分配策略：Haiku（轻量，只读/格式化）、Sonnet（默认，实现/设计）、Opus（高级，多文档综合/高 stakes 裁决）。 |
| **Allowed Tools** | 允许工具 | Skill frontmatter 中声明该 Skill 可调用的工具白名单，超出范围的调用会被拒绝。 |
| **Context Compaction** | 上下文压缩 | 在上下文窗口接近上限时，将历史对话压缩为摘要，保留关键决策和文件引用，释放 token 空间。 |
| **File-Backed State** | 文件持久化状态 | 将关键决策、进度和状态写入磁盘文件（如 `production/session-state/active.md`），而非仅依赖会话内存，确保崩溃后可恢复。 |
| **Proactive Compaction** | 主动压缩 | 在上下文使用率达到 60%-70% 时主动触发压缩，而非等到触顶才处理。 |
| **Incremental File Writing** | 增量文件写入 | 创建多章节文档时，先写骨架（所有标题），再逐节讨论、逐节写入文件，保持上下文窗口只容纳当前章节。 |

---

## 五、质量与验证概念

| 英文术语 | 中文术语 | 功能解释 |
|----------|----------|----------|
| **Skill Test** | 技能测试 | 验证 Skill 文件结构合规性与行为正确性的流程，通常检查 frontmatter 完整性、阶段逻辑和工具权限。 |
| **Consistency Check** | 一致性检查 | 扫描所有 GDD，通过实体注册表检测跨文档不一致（如同一实体属性冲突、同名物品数值不同）。 |
| **Content Audit** | 内容审计 | 对比 GDD 中规划的内容数量与实际实现的内容数量，识别遗漏。 |
| **Regression Suite** | 回归测试套件 | 将测试覆盖范围映射到 GDD 的关键路径，识别已修复但缺少回归测试的缺陷。 |
| **Test Evidence** | 测试证据 | Story 完成时提供的测试通过证明，可以是自动化测试报告或手动测试记录。 |
| **Flakiness** |  flaky 测试 | 非确定性的测试，即多次运行结果不一致的测试，通常由时序、随机性或环境差异引起。 |

---

## 六、多平台相关术语

| 英文术语 | 中文术语 | 功能解释 |
|----------|----------|----------|
| **GDScript** | GDScript | Godot 引擎原生的 Python 风格脚本语言，静态类型，信号驱动。 |
| **GDExtension** | GDExtension | Godot 4 的 C/C++/Rust 原生扩展接口，用于高性能模块开发。 |
| **DOTS** | DOTS | Unity 的 Data-Oriented Technology Stack，面向数据的技术栈。 |
| **Addressables** | Addressables | Unity 的可寻址资源系统，用于动态加载和更新资源。 |
| **GAS** | GAS | Gameplay Ability System，Unreal Engine 的能力系统框架，常用于 RPG 和 MOBA。 |
| **UMG** | UMG | Unreal Motion Graphics，Unreal 的 UI 框架。 |
| **WASM** | WASM | WebAssembly，微信小游戏和 Web 平台常用的编译目标，用于运行物理引擎等原生模块。 |
| **Box2D** | Box2D | 2D 物理引擎，微信小游戏可通过 WASM 引入。 |
| **Bullet** | Bullet | 3D 物理引擎（ammo.js 为 JS/WASM 封装），微信小游戏支持。 |
| **Jolt** | Jolt | 高性能 3D 物理引擎，支持确定性模拟和内置角色控制器，微信小游戏支持。 |
| **FairyGUI** | FairyGUI | 跨平台 UI 编辑器，常用于 Cocos 和微信小游戏的 UI 制作。 |

---

## 七、缩写速查表

| 缩写 | 全称 | 中文 |
|------|------|------|
| **AI** | Artificial Intelligence | 人工智能（此处特指游戏 AI） |
| **API** | Application Programming Interface | 应用程序接口 |
| **CI/CD** | Continuous Integration / Continuous Deployment | 持续集成/持续部署 |
| **ECS** | Entity-Component-System | 实体-组件-系统架构 |
| **HUD** | Heads-Up Display | 平视显示器（游戏界面） |
| **LOD** | Level of Detail | 细节层次 |
| **MVP** | Minimum Viable Product | 最小可行产品 |
| **QA** | Quality Assurance | 质量保证 |
| **RTL** | Right-to-Left | 从右到左（用于阿拉伯语/希伯来语等本地化） |
| **SDT** | Self-Determination Theory | 自我决定理论（游戏设计心理学框架） |
| **MDA** | Mechanics-Dynamics-Aesthetics | 机制-动态-美学（游戏设计框架） |
| **VO** | Voice Over | 配音 |
| **VFX** | Visual Effects | 视觉特效 |
