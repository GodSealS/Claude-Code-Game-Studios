# 核心文件功能索引

本文档按类别索引项目中提示词工程相关的关键文件，提供快速功能速查。

---

## 一、Skill 文件速查（`.codebuddy/skills/`）

### 1.1 入职与导航

| Skill | 文件路径 | 功能简述 |
|-------|----------|----------|
| `/start` | `start/SKILL.md` | 首次入职引导，检测项目状态并路由到正确工作流 |
| `/help` | `help/SKILL.md` | 上下文感知的"下一步该做什么"导航 |
| `/project-stage-detect` | `project-stage-detect/SKILL.md` | 全面项目审计，检测阶段、识别缺失、推荐下一步 |
| `/setup-engine` | `setup-engine/SKILL.md` | 配置引擎 + 版本，检测知识缺口，填充版本感知参考文档 |
| `/adopt` | `adopt/SKILL.md` | 存量项目格式审计，检查 GDD/ADR/Story 的内部结构合规性 |
| `/onboard` | `onboard/SKILL.md` | 为新贡献者或 Agent 生成情境化入职文档 |

### 1.2 游戏设计

| Skill | 文件路径 | 功能简述 |
|-------|----------|----------|
| `/brainstorm` | `brainstorm/SKILL.md` | 引导式创意构思（MDA、SDT、Bartle、动词优先） |
| `/map-systems` | `map-systems/SKILL.md` | 将游戏概念分解为系统，映射依赖关系，确定设计顺序 |
| `/design-system` | `design-system/SKILL.md` | 分章节引导编写单个游戏系统的 GDD |
| `/quick-design` | `quick-design/SKILL.md` | 轻量级设计规格，用于微调、优化和小幅增改 |
| `/review-all-gdds` | `review-all-gdds/SKILL.md` | 跨 GDD 一致性和游戏设计整体性审查 |
| `/propagate-design-change` | `propagate-design-change/SKILL.md` | GDD 修订时，扫描受影响 ADR 并生成影响报告 |
| `/art-bible` | `art-bible/SKILL.md` | 引导式视觉身份规范编写 |

### 1.3 用户体验与界面

| Skill | 文件路径 | 功能简述 |
|-------|----------|----------|
| `/ux-design` | `ux-design/SKILL.md` | 分章节引导编写 UX 规格（界面/流程/HUD/模式库） |
| `/ux-review` | `ux-review/SKILL.md` | 验证 UX 规格与 GDD 对齐、可访问性和模式合规性 |

### 1.4 架构

| Skill | 文件路径 | 功能简述 |
|-------|----------|----------|
| `/create-architecture` | `create-architecture/SKILL.md` | 引导编写主架构文档 |
| `/architecture-decision` | `architecture-decision/SKILL.md` | 创建架构决策记录（ADR） |
| `/architecture-review` | `architecture-review/SKILL.md` | 验证所有 ADR 的完整性、依赖顺序和 GDD 覆盖度 |
| `/create-control-manifest` | `create-control-manifest/SKILL.md` | 从已接受的 ADR 生成平面化程序员规则清单 |

### 1.5 故事与冲刺

| Skill | 文件路径 | 功能简述 |
|-------|----------|----------|
| `/create-epics` | `create-epics/SKILL.md` | 将 GDD + ADR 转化为 Epic（每架构模块一个） |
| `/create-stories` | `create-stories/SKILL.md` | 将单个 Epic 拆分为可实施的故事文件 |
| `/dev-story` | `dev-story/SKILL.md` | 读取故事并实现，路由到正确的程序员 Agent |
| `/sprint-plan` | `sprint-plan/SKILL.md` | 生成或更新冲刺计划，初始化 `sprint-status.yaml` |
| `/sprint-status` | `sprint-status/SKILL.md` | 快速 30 行冲刺快照（读取 `sprint-status.yaml`） |
| `/story-readiness` | `story-readiness/SKILL.md` | 验证故事是否具备实施条件（READY/NEEDS WORK/BLOCKED） |
| `/story-done` | `story-done/SKILL.md` | 8 阶段完成审查，更新故事文件并提示下一故事 |
| `/estimate` | `estimate/SKILL.md` | 结构化工作量估算（复杂度、依赖、风险） |

### 1.6 审查与分析

| Skill | 文件路径 | 功能简述 |
|-------|----------|----------|
| `/design-review` | `design-review/SKILL.md` | 审查游戏设计文档的完整性和一致性 |
| `/code-review` | `code-review/SKILL.md` | 对文件或变更集进行架构级代码审查 |
| `/balance-check` | `balance-check/SKILL.md` | 分析游戏平衡数据、公式和配置，标记异常值 |
| `/asset-audit` | `asset-audit/SKILL.md` | 审计资产的命名规范、文件大小预算和流水线合规性 |
| `/content-audit` | `content-audit/SKILL.md` | 审计 GDD 规划的内容数量与实现内容数量 |
| `/scope-check` | `scope-check/SKILL.md` | 分析功能或冲刺范围与原始计划的偏差，标记范围蔓延 |
| `/perf-profile` | `perf-profile/SKILL.md` | 结构化性能剖析与瓶颈识别 |
| `/tech-debt` | `tech-debt/SKILL.md` | 扫描、跟踪、优先级排序和报告技术债务 |
| `/gate-check` | `gate-check/SKILL.md` | 验证进入下一开发阶段的准备度（PASS/CONCERNS/FAIL） |
| `/consistency-check` | `consistency-check/SKILL.md` | 扫描所有 GDD 与实体注册表，检测跨文档不一致 |

### 1.7 QA 与测试

| Skill | 文件路径 | 功能简述 |
|-------|----------|----------|
| `/qa-plan` | `qa-plan/SKILL.md` | 为冲刺或功能生成 QA 测试计划 |
| `/smoke-check` | `smoke-check/SKILL.md` | 在 QA 交接前运行关键路径冒烟测试 |
| `/soak-test` | `soak-test/SKILL.md` | 生成长时间游戏会话的浸泡测试协议 |
| `/regression-suite` | `regression-suite/SKILL.md` | 将测试覆盖映射到 GDD 关键路径，识别缺少回归测试的已修复缺陷 |
| `/test-setup` | `test-setup/SKILL.md` | 为项目引擎搭建测试框架和 CI/CD 流水线 |
| `/test-helpers` | `test-helpers/SKILL.md` | 生成引擎专用的测试辅助库 |
| `/test-evidence-review` | `test-evidence-review/SKILL.md` | 对测试文件和手动证据文档进行质量审查 |
| `/test-flakiness` | `test-flakiness/SKILL.md` | 从 CI 运行日志中检测非确定性（flaky）测试 |
| `/skill-test` | `skill-test/SKILL.md` | 验证 Skill 文件的结构合规性和行为正确性 |

### 1.8 生产与发布

| Skill | 文件路径 | 功能简述 |
|-------|----------|----------|
| `/milestone-review` | `milestone-review/SKILL.md` | 审查里程碑进度并生成状态报告 |
| `/retrospective` | `retrospective/SKILL.md` | 运行结构化的冲刺或里程碑回顾 |
| `/bug-report` | `bug-report/SKILL.md` | 创建结构化 Bug 报告或分析代码中的潜在缺陷 |
| `/bug-triage` | `bug-triage/SKILL.md` | 读取所有开放 Bug，重新评估优先级与严重性 |
| `/reverse-document` | `reverse-document/SKILL.md` | 从现有实现生成设计或架构文档 |
| `/playtest-report` | `playtest-report/SKILL.md` | 生成结构化的试玩报告或分析现有试玩记录 |
| `/release-checklist` | `release-checklist/SKILL.md` | 为当前构建生成并验证预发布清单 |
| `/launch-checklist` | `launch-checklist/SKILL.md` | 完整的发布准备度验证 |
| `/changelog` | `changelog/SKILL.md` | 从 Git 提交和冲刺数据自动生成变更日志 |
| `/patch-notes` | `patch-notes/SKILL.md` | 从 Git 历史和内部数据生成面向玩家的补丁说明 |
| `/hotfix` | `hotfix/SKILL.md` | 紧急修复工作流，带审计追踪，绕过正常冲刺流程 |

### 1.9 原型与内容

| Skill | 文件路径 | 功能简述 |
|-------|----------|----------|
| `/prototype` | `prototype/SKILL.md` | 快速可丢弃原型，验证核心机制（标准较宽松，隔离工作区） |
| `/localize` | `localize/SKILL.md` | 本地化工作流：字符串提取、验证、翻译准备度 |

### 1.10 团队编排

| Skill | 文件路径 | 协调的 Agent |
|-------|----------|--------------|
| `/team-combat` | `team-combat/SKILL.md` | game-designer + gameplay-programmer + ai-programmer + technical-artist + sound-designer + qa-tester |
| `/team-narrative` | `team-narrative/SKILL.md` | narrative-director + writer + world-builder + level-designer |
| `/team-ui` | `team-ui/SKILL.md` | ux-designer + ui-programmer + art-director + accessibility-specialist |
| `/team-release` | `team-release/SKILL.md` | release-manager + qa-lead + devops-engineer + producer |
| `/team-polish` | `team-polish/SKILL.md` | performance-analyst + technical-artist + sound-designer + qa-tester |
| `/team-audio` | `team-audio/SKILL.md` | audio-director + sound-designer + technical-artist + gameplay-programmer |
| `/team-level` | `team-level/SKILL.md` | level-designer + narrative-director + world-builder + art-director + systems-designer + qa-tester |
| `/team-live-ops` | `team-live-ops/SKILL.md` | live-ops-designer + economy-designer + community-manager + analytics-engineer |
| `/team-qa` | `team-qa/SKILL.md` | qa-lead + qa-tester + gameplay-programmer + producer |

---

## 二、Agent 文件速查（`.codebuddy/agents/`）

### 2.1 领导层

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `creative-director` | `creative-director.md` | 最高创意权威，裁决愿景、基调、美学方向，解决设计/艺术/叙事/音频冲突 |
| `technical-director` | `technical-director.md` | 技术总负责人，裁决技术冲突、引擎版本升级、插件决策 |
| `producer` | `producer.md` | 制作人，管理进度、资源分配和跨领域变更协调 |

### 2.2 部门负责人

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `game-designer` | `game-designer.md` | 游戏设计师，设计核心循环、进度系统、战斗机制、经济与玩家规则 |
| `lead-programmer` | `lead-programmer.md` | 主程序员，代码架构冲突裁决、技术债务管理 |
| `art-director` | `art-director.md` | 美术总监，风格指南、美术圣经、资产标准、UI/UX 视觉设计 |
| `audio-director` | `audio-director.md` | 音频总监，音乐方向、声音设计哲学、音频实现策略 |
| `narrative-director` | `narrative-director.md` | 叙事总监，故事方向、世界观一致性、角色发展 |
| `qa-lead` | `qa-lead.md` | QA 负责人，测试策略、质量标准、发布审批 |
| `release-manager` | `release-manager.md` | 发布经理，版本计划、发布流程、回滚策略 |

### 2.3 引擎专家

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `godot-specialist` | `godot-specialist.md` | Godot 引擎专家，GDScript/C#/GDExtension 决策、节点/场景架构、信号与资源管理 |
| `unity-specialist` | `unity-specialist.md` | Unity 引擎专家，C# 脚本、DOTS、Addressables、URP/HDRP |
| `unreal-specialist` | `unreal-specialist.md` | Unreal 引擎专家，Blueprint/C++、GAS、UMG、Replication |
| `cocos-specialist` | `cocos-specialist.md` | Cocos Creator 引擎专家，TypeScript/JavaScript、组件系统、渲染管线 |
| `wechat-specialist` | `wechat-specialist.md` | 微信小游戏专家，平台适配、云开发、性能优化、审核规范 |

### 2.4 子专家（Godot 生态）

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `godot-gdscript-specialist` | `godot-gdscript-specialist.md` | GDScript 架构、静态类型、信号、协程 |
| `godot-csharp-specialist` | `godot-csharp-specialist.md` | Godot C# 集成、.NET 特性、性能优化 |
| `godot-gdextension-specialist` | `godot-gdextension-specialist.md` | C++/Rust 原生绑定、GDExtension 模块、自定义节点 |
| `godot-shader-specialist` | `godot-shader-specialist.md` | Godot 着色语言、视觉着色器、粒子系统 |

### 2.5 子专家（Unity 生态）

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `unity-dots-specialist` | `unity-dots-specialist.md` | DOTS 架构、ECS、Job System、Burst Compiler |
| `unity-addressables-specialist` | `unity-addressables-specialist.md` | 可寻址资源系统、动态加载、热更新 |
| `unity-shader-specialist` | `unity-shader-specialist.md` | Shader Graph、HLSL、URP/HDRP 着色器 |
| `unity-ui-specialist` | `unity-ui-specialist.md` | UGUI、UI Toolkit、自适应布局 |

### 2.6 子专家（Unreal 生态）

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `ue-blueprint-specialist` | `ue-blueprint-specialist.md` | Blueprint 可视化脚本、蓝图通信、蓝图优化 |
| `ue-gas-specialist` | `ue-gas-specialist.md` | Gameplay Ability System、Gameplay Tags、Attribute Sets |
| `ue-replication-specialist` | `ue-replication-specialist.md` | 网络复制、RPC、Dedicated Server |
| `ue-umg-specialist` | `ue-umg-specialist.md` | UMG UI 框架、蓝图绑定、动态 UI |

### 2.7 子专家（Cocos 生态）

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `cocos_2d-expert` | `cocos_2d-expert.md` | 2D 渲染、精灵、文本、遮罩、UI 组件 |
| `cocos_3d-expert` | `cocos_3d-expert.md` | 3D 网格渲染、蒙皮网格、模型加载 |
| `cocos_animation-expert` | `cocos_animation-expert.md` | 动画剪辑、骨骼动画、动画状态机、动画混合 |
| `cocos_core-expert` | `cocos_core-expert.md` | 组件、节点、场景图、生命周期、事件系统 |
| `cocos_gfx-expert` | `cocos_gfx-expert.md` | 着色器、GPU 缓冲区/纹理、自定义渲染管线 |
| `cocos_physics-expert` | `cocos_physics-expert.md` | 3D 刚体、碰撞体、射线检测、物理模拟 |
| `cocos_physics-2d-expert` | `cocos_physics-2d-expert.md` | 2D 刚体、碰撞检测、Box2D 集成 |
| `cocos_rendering-expert` | `cocos_rendering-expert.md` | 渲染管线、相机、光照、阴影、后处理 |

### 2.8 子专家（微信生态）

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `wechat-minigame-specialist` | `wechat-minigame-specialist.md` | 小游戏框架、Canvas 渲染、性能优化、包体控制 |
| `wechat-cloudbase-specialist` | `wechat-cloudbase-specialist.md` | 云开发（云函数、数据库、存储、托管） |
| `wechat-shader-specialist` | `wechat-shader-specialist.md` | WebGL 着色器、GLSL、移动端优化 |
| `wechat-ui-specialist` | `wechat-ui-specialist.md` | 小游戏 UI 适配、FairyGUI、屏幕管理 |

### 2.9 职能专家

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `gameplay-programmer` | `gameplay-programmer.md` | 玩法框架（状态机、能力系统、输入处理） |
| `ai-programmer` | `ai-programmer.md` | 行为树、状态机、寻路、感知系统、NPC 行为 |
| `ui-programmer` | `ui-programmer.md` | UI 实现、交互逻辑、HUD、菜单系统 |
| `network-programmer` | `network-programmer.md` | 网络架构、同步策略、预测与回滚、服务器逻辑 |
| `engine-programmer` | `engine-programmer.md` | 核心引擎系统（渲染、物理、内存、资源加载） |
| `technical-artist` | `technical-artist.md` | 着色器、VFX、渲染优化、美术流水线 |
| `world-builder` | `world-builder.md` | 关卡搭建、场景构图、白盒、环境叙事 |
| `level-designer` | `level-designer.md` | 关卡设计、流程规划、难度曲线、教学关 |
| `systems-designer` | `systems-designer.md` | 经济系统、进度系统、战利品、技能树 |
| `economy-designer` | `economy-designer.md` | 资源经济、战利品表、进度曲线、市场设计 |
| `live-ops-designer` | `live-ops-designer.md` | 运营活动、限时模式、内容日历、数据分析 |
| `writer` | `writer.md` | 对话、剧情文本、世界观文档、任务描述 |
| `sound-designer` | `sound-designer.md` | 音效设计、音频实现、Wwise/FMOD 集成 |
| `accessibility-specialist` | `accessibility-specialist.md` | 无障碍标准、色盲模式、文本缩放、输入重映射 |
| `performance-analyst` | `performance-analyst.md` | 性能剖析、瓶颈识别、优化建议、预算管理 |
| `security-engineer` | `security-engineer.md` | 安全审计、反作弊、数据验证、网络加密 |
| `analytics-engineer` | `analytics-engineer.md` | 遥测系统、玩家行为追踪、A/B 测试、数据管道 |
| `devops-engineer` | `devops-engineer.md` | CI/CD、构建脚本、分支策略、自动化测试流水线 |
| `localization-lead` | `localization-lead.md` | 本地化流程、翻译管理、文化敏感性审查、RTL 支持 |
| `community-manager` | `community-manager.md` | 补丁说明、社交媒体、社区更新、玩家反馈收集 |
| `ux-designer` | `ux-designer.md` | 用户体验设计、交互流程、可用性测试 |
| `prototyper` | `prototyper.md` | 快速原型、机制验证、概念验证、迭代实验 |
| `qa-tester` | `qa-tester.md` | 手动测试、Bug 复现、测试用例执行、回归验证 |
| `tools-programmer` | `tools-programmer.md` | 编辑器工具、流水线工具、自动化脚本、内部工具 |

---

## 三、Rule 文件速查（`.codebuddy/rules/`）

| Rule | 文件路径 | 作用路径 | 核心约束 |
|------|----------|----------|----------|
| `ai-code` | `ai-code.md` | `src/ai/**` | AI 更新预算 2ms/帧、参数可数据化配置、可视化调试、意图预告、行为树优先、状态机日志 |
| `engine-code` | `engine-code.md` | `src/engine/**` | 引擎层代码规范（内存管理、渲染 API 使用、多线程安全） |
| `gameplay-code` | `gameplay-code.md` | `src/gameplay/**` | 玩法代码规范（状态机模式、输入处理、帧率无关逻辑） |
| `ui-code` | `ui-code.md` | `src/ui/**` | UI 代码规范（响应式布局、控件复用、动画性能、输入焦点管理） |
| `shader-code` | `shader-code.md` | `src/shaders/**` | 着色器规范（精度控制、平台宏、Uniform 命名、Overdraw 优化） |
| `network-code` | `network-code.md` | `src/network/**` | 网络代码规范（序列化、验证、延迟隐藏、断线重连） |
| `test-standards` | `test-standards.md` | 全局 | 测试标准（命名、覆盖率、Mock 策略、断言风格） |
| `design-docs` | `design-docs.md` | `design/**` | 设计文档规范（章节结构、术语一致性、可追溯性） |
| `data-files` | `data-files.md` | `assets/data/**` | 数据文件规范（格式、验证、版本、本地化键） |
| `narrative` | `narrative.md` | `design/narrative/**` | 叙事文档规范（角色一致性、时间线、对话格式、分支标记） |
| `prototype-code` | `prototype-code.md` | `prototypes/**` | 原型代码规范（标准较宽松，允许临时方案和硬编码） |

---

## 四、关键配置与参考文档

| 文件 | 路径 | 功能 |
|------|------|------|
| `CODEBUDDY.md` | 根目录 | 项目主配置，含技术栈、项目结构、协作协议 |
| `directory-structure.md` | `.codebuddy/docs/directory-structure.md` | 目录结构规范 |
| `coordination-rules.md` | `.codebuddy/docs/coordination-rules.md` | Agent 协调规则与模型层级分配 |
| `context-management.md` | `.codebuddy/docs/context-management.md` | 上下文管理策略（文件持久化、主动压缩、恢复） |
| `skills-reference.md` | `.codebuddy/docs/skills-reference.md` | Skill 速查表（73 个斜杠命令按阶段分类） |
| `agent-roster.md` | `.codebuddy/docs/agent-roster.md` | Agent 名册与协调地图 |
| `agent-coordination-map.md` | `.codebuddy/docs/agent-coordination-map.md` | Agent 协作关系的可视化地图 |
| `coding-standards.md` | `.codebuddy/docs/coding-standards.md` | 编码标准（语言无关） |
| `technical-preferences.md` | `.codebuddy/docs/technical-preferences.md` | 技术偏好与引擎配置（含引擎版本） |
| `rules-reference.md` | `.codebuddy/docs/rules-reference.md` | Rule 参考说明 |
| `review-workflow.md` | `.codebuddy/docs/review-workflow.md` | 审查工作流说明 |
| `director-gates.md` | `.codebuddy/docs/director-gates.md` | Director 级审查的关卡与标准 |
| `setup-requirements.md` | `.codebuddy/docs/setup-requirements.md` | 环境 setup 要求 |
| `quick-start.md` | `.codebuddy/docs/quick-start.md` | 快速开始指南 |
| `templates/` | `.codebuddy/docs/templates/` | 38 个文档模板（GDD、ADR、Story、Epic 等） |
| `templates/collaborative-protocols/` | `.codebuddy/docs/templates/collaborative-protocols/` | 3 个协作协议模板：design-agent-protocol.md、implementation-agent-protocol.md、leadership-agent-protocol.md |
| `hooks-reference.md` | `.codebuddy/docs/hooks-reference.md` | 钩子参考说明（汇总所有活跃钩子的速查表） |
| `hooks-reference/` | `.codebuddy/docs/hooks-reference/` | 6 个钩子的详细文档：hook-input-schemas.md、pre-commit-code-quality.md、pre-commit-design-check.md、pre-push-test-gate.md、post-merge-asset-validation.md、post-sprint-retrospective.md |
