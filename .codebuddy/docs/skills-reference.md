# Available Skills (Slash Commands) / 可用技能（斜杠命令）

73 slash commands organized by phase. Type `/` in CodeBuddy to access any of them.

> **中文翻译**：73个斜杠命令按阶段组织。在CodeBuddy中输入 `/` 即可访问。

## Onboarding & Navigation / 引导入门与导航

| Command | Purpose |
|---------|---------|
| `/start` | First-time onboarding — asks where you are, then guides you to the right workflow |
| `/help` | Context-aware "what do I do next?" — reads current stage and surfaces the required next step |
| `/project-stage-detect` | Full project audit — detect phase, identify existence gaps, recommend next steps |
| `/setup-engine` | Configure engine + version, detect knowledge gaps, populate version-aware reference docs |
| `/setup-wechat-minigame` | Initialize WeChat Mini Game project with platform-specific configuration, boilerplate code, and directory structure |
| `/wechat-shader` | Initialize WebGL shader pipeline, convert Unity/Unreal/Godot shaders to WebGL GLSL, optimize for mobile, render pipeline standards |
| `/wechat-ui-design` | Design UI with Figma/Sketch, produce assets in Photoshop/Illustrator, build adaptive layouts in FairyGUI with data binding and screen management |
| `/wechat-physics-box2d` | Initialize Box2D WASM 2D physics engine, create physics world via unified IPhysicsWorld interface |
| `/wechat-physics-bullet` | Initialize Bullet (ammo.js) WASM 3D physics engine, create physics world with soft body support |
| `/wechat-physics-jolt` | Initialize JoltPhysics WASM high-performance 3D physics engine, deterministic simulation, built-in character controller |
| `/adopt` | Brownfield format audit — checks internal structure of existing GDDs/ADRs/stories, produces migration plan |

> **中文翻译**：

| 命令 | 用途 |
|------|------|
| `/start` | 首次引导入门 — 询问你当前状态，然后引导到正确的工作流 |
| `/help` | 上下文感知的"下一步做什么？" — 读取当前阶段并显示所需的下一步 |
| `/project-stage-detect` | 完整项目审计 — 检测阶段、识别存在差距、推荐下一步 |
| `/setup-engine` | 配置引擎+版本、检测知识差距、填充版本感知的参考文档 |
| `/setup-wechat-minigame` | 初始化微信小游戏项目，含平台特定配置、样板代码和目录结构 |
| `/wechat-shader` | 初始化WebGL着色器管线、将Unity/Unreal/Godot着色器转换为WebGL GLSL、移动端优化、渲染管线标准 |
| `/wechat-ui-design` | 用Figma/Sketch设计UI、用Photoshop/Illustrator制作资产、在FairyGUI中构建自适应布局与数据绑定和屏幕管理 |
| `/wechat-physics-box2d` | 初始化Box2D WASM 2D物理引擎、通过统一IPhysicsWorld接口创建物理世界 |
| `/wechat-physics-bullet` | 初始化Bullet(ammo.js) WASM 3D物理引擎、创建支持软体的物理世界 |
| `/wechat-physics-jolt` | 初始化JoltPhysics WASM高性能3D物理引擎、确定性模拟、内置角色控制器 |
| `/adopt` | 棕地格式审计 — 检查现有GDD/ADR/故事的内部结构，生成迁移计划 |

## Game Design / 游戏设计

| Command | Purpose |
|---------|---------|
| `/brainstorm` | Guided ideation using professional studio methods (MDA, SDT, Bartle, verb-first) |
| `/map-systems` | Decompose game concept into systems, map dependencies, prioritize design order |
| `/design-system` | Guided, section-by-section GDD authoring for a single game system |
| `/quick-design` | Lightweight design spec for small changes — tuning, tweaks, minor additions |
| `/review-all-gdds` | Cross-GDD consistency and game design holism review across all design docs |
| `/propagate-design-change` | When a GDD is revised, find affected ADRs and produce an impact report |

> **中文翻译**：

| 命令 | 用途 |
|------|------|
| `/brainstorm` | 使用专业工作室方法的引导式创意发想（MDA、SDT、Bartle、动词优先） |
| `/map-systems` | 将游戏概念分解为系统、映射依赖、按优先级排序设计顺序 |
| `/design-system` | 引导式、逐章节的GDD编写（单个游戏系统） |
| `/quick-design` | 轻量级设计规格（小改动、调优、微调、小增补） |
| `/review-all-gdds` | 跨GDD一致性和游戏设计整体性审查（所有设计文档） |
| `/propagate-design-change` | 当GDD修订时，查找受影响的ADR并生成影响报告 |

## UX & Interface Design / UX与界面设计

| Command | Purpose |
|---------|---------|
| `/ux-design` | Guided section-by-section UX spec authoring (screen/flow, HUD, or pattern library) |
| `/ux-review` | Validate UX specs for GDD alignment, accessibility, and pattern compliance |

> **中文翻译**：

| 命令 | 用途 |
|------|------|
| `/ux-design` | 引导式逐章节UX规格编写（屏幕/流程、HUD或模式库） |
| `/ux-review` | 验证UX规格的GDD一致性、无障碍和模式合规性 |

## Architecture / 架构

| Command | Purpose |
|---------|---------|
| `/create-architecture` | Guided authoring of the master architecture document |
| `/architecture-decision` | Create an Architecture Decision Record (ADR) |
| `/architecture-review` | Validate all ADRs for completeness, dependency ordering, and GDD coverage |
| `/create-control-manifest` | Generate flat programmer rules sheet from accepted ADRs |

> **中文翻译**：

| 命令 | 用途 |
|------|------|
| `/create-architecture` | 引导式主架构文档编写 |
| `/architecture-decision` | 创建架构决策记录（ADR） |
| `/architecture-review` | 验证所有ADR的完整性、依赖排序和GDD覆盖 |
| `/create-control-manifest` | 从已接受的ADR生成扁平化程序员规则表 |

## Stories & Sprints / 故事与冲刺

| Command | Purpose |
|---------|---------|
| `/create-epics` | Translate GDDs + ADRs into epics — one per architectural module |
| `/create-stories` | Break a single epic into implementable story files |
| `/dev-story` | Read a story and implement it — routes to the correct programmer agent |
| `/sprint-plan` | Generate or update a sprint plan; initializes sprint-status.yaml |
| `/sprint-status` | Fast 30-line sprint snapshot (reads sprint-status.yaml) |
| `/story-readiness` | Validate a story is implementation-ready before pickup (READY/NEEDS WORK/BLOCKED) |
| `/story-done` | 8-phase completion review after implementation; updates story file, surfaces next story |
| `/estimate` | Structured effort estimate with complexity, dependencies, and risk breakdown |

> **中文翻译**：

| 命令 | 用途 |
|------|------|
| `/create-epics` | 将GDD+ADR转化为史诗 — 每个架构模块一个 |
| `/create-stories` | 将单个史诗拆分为可实现的故事文件 |
| `/dev-story` | 读取故事并实现 — 路由到正确的程序员代理 |
| `/sprint-plan` | 生成或更新冲刺计划；初始化sprint-status.yaml |
| `/sprint-status` | 快速30行冲刺快照（读取sprint-status.yaml） |
| `/story-readiness` | 验证故事在拾取前是否实现就绪（就绪/需要工作/阻塞） |
| `/story-done` | 实现8阶段完成审查；更新故事文件，显示下一个故事 |
| `/estimate` | 结构化工作量估算（复杂度、依赖、风险分解） |

## Reviews & Analysis / 审查与分析

| Command | Purpose |
|---------|---------|
| `/design-review` | Review a game design document for completeness and consistency |
| `/code-review` | Architectural code review for a file or changeset |
| `/balance-check` | Analyze game balance data, formulas, and config — flag outliers |
| `/asset-audit` | Audit assets for naming conventions, file size budgets, and pipeline compliance |
| `/content-audit` | Audit GDD-specified content counts against implemented content |
| `/scope-check` | Analyze feature or sprint scope against original plan, flag scope creep |
| `/perf-profile` | Structured performance profiling with bottleneck identification |
| `/tech-debt` | Scan, track, prioritize, and report on technical debt |
| `/gate-check` | Validate readiness to advance between development phases (PASS/CONCERNS/FAIL) |
| `/consistency-check` | Scan all GDDs against the entity registry to detect cross-document inconsistencies (stats, names, rules that contradict each other) |

> **中文翻译**：

| 命令 | 用途 |
|------|------|
| `/design-review` | 审查游戏设计文档的完整性和一致性 |
| `/code-review` | 文件或变更集的架构级代码审查 |
| `/balance-check` | 分析游戏平衡数据、公式和配置 — 标记异常值 |
| `/asset-audit` | 审计资产的命名约定、文件大小预算和管线合规性 |
| `/content-audit` | 审计GDD指定的内容数量与已实现内容的差距 |
| `/scope-check` | 对照原始计划分析功能或冲刺范围，标记范围蔓延 |
| `/perf-profile` | 结构化性能分析和瓶颈识别 |
| `/tech-debt` | 扫描、跟踪、优先排序和报告技术债务 |
| `/gate-check` | 验证开发阶段间推进的就绪度（通过/关注/失败） |
| `/consistency-check` | 对照实体注册表扫描所有GDD，检测跨文档不一致（互相矛盾的属性、名称、规则） |

## QA & Testing / QA与测试

| Command | Purpose |
|---------|---------|
| `/qa-plan` | Generate a QA test plan for a sprint or feature |
| `/smoke-check` | Run critical path smoke test gate before QA hand-off |
| `/soak-test` | Generate a soak test protocol for extended play sessions |
| `/regression-suite` | Map test coverage to GDD critical paths, identify fixed bugs without regression tests |
| `/test-setup` | Scaffold the test framework and CI/CD pipeline for the project's engine |
| `/test-helpers` | Generate engine-specific test helper libraries for the test suite |
| `/test-evidence-review` | Quality review of test files and manual evidence documents |
| `/test-flakiness` | Detect non-deterministic (flaky) tests from CI run logs |
| `/skill-test` | Validate skill files for structural compliance and behavioral correctness |

> **中文翻译**：

| 命令 | 用途 |
|------|------|
| `/qa-plan` | 为冲刺或功能生成QA测试计划 |
| `/smoke-check` | 在QA交接前运行关键路径冒烟测试门控 |
| `/soak-test` | 为长时间试玩会话生成浸泡测试协议 |
| `/regression-suite` | 将测试覆盖映射到GDD关键路径、识别缺少回归测试的已修复缺陷 |
| `/test-setup` | 为项目引擎搭建测试框架和CI/CD管线 |
| `/test-helpers` | 为测试套件生成引擎特定的测试辅助库 |
| `/test-evidence-review` | 测试文件和手动证据文档的质量审查 |
| `/test-flakiness` | 从CI运行日志检测非确定性（不稳定）测试 |
| `/skill-test` | 验证技能文件的结构合规性和行为正确性 |

## Production / 制作

| Command | Purpose |
|---------|---------|
| `/milestone-review` | Review milestone progress and generate status report |
| `/retrospective` | Run a structured sprint or milestone retrospective |
| `/bug-report` | Create a structured bug report |
| `/bug-triage` | Read all open bugs, re-evaluate priority vs. severity, assign owner and label |
| `/reverse-document` | Generate design or architecture docs from existing implementation |
| `/playtest-report` | Generate a structured playtest report or analyze existing playtest notes |

> **中文翻译**：

| 命令 | 用途 |
|------|------|
| `/milestone-review` | 审查里程碑进度并生成状态报告 |
| `/retrospective` | 运行结构化的冲刺或里程碑回顾 |
| `/bug-report` | 创建结构化缺陷报告 |
| `/bug-triage` | 读取所有未关闭缺陷、重新评估优先级vs严重性、分配负责人和标签 |
| `/reverse-document` | 从已有实现生成设计或架构文档 |
| `/playtest-report` | 生成结构化试玩报告或分析现有试玩笔记 |

## Release / 发布

| Command | Purpose |
|---------|---------|
| `/release-checklist` | Generate and validate a pre-release checklist for the current build |
| `/launch-checklist` | Complete launch readiness validation across all departments |
| `/changelog` | Auto-generate changelog from git commits and sprint data |
| `/patch-notes` | Generate player-facing patch notes from git history and internal data |
| `/hotfix` | Emergency fix workflow with audit trail, bypassing normal sprint process |

> **中文翻译**：

| 命令 | 用途 |
|------|------|
| `/release-checklist` | 为当前构建生成并验证预发布清单 |
| `/launch-checklist` | 跨所有部门的完整上线就绪验证 |
| `/changelog` | 从git提交和冲刺数据自动生成变更日志 |
| `/patch-notes` | 从git历史和内部数据生成面向玩家的补丁说明 |
| `/hotfix` | 带审计追踪的紧急修复工作流，绕过正常冲刺流程 |

## Creative & Content / 创意与内容

| Command | Purpose |
|---------|---------|
| `/prototype` | Rapid throwaway prototype to validate a mechanic (relaxed standards, isolated worktree) |
| `/onboard` | Generate contextual onboarding document for a new contributor or agent |
| `/localize` | Localization workflow: string extraction, validation, translation readiness |

> **中文翻译**：

| 命令 | 用途 |
|------|------|
| `/prototype` | 快速一次性原型验证机制（宽松标准、隔离工作树） |
| `/onboard` | 为新贡献者或代理生成上下文化的引导入门文档 |
| `/localize` | 本地化工作流：字符串提取、验证、翻译就绪 |

## Team Orchestration / 团队编排

Coordinate multiple agents on a single feature area:

> **中文翻译**：在单个功能区域协调多个代理：

| Command | Coordinates |
|---------|-------------|
| `/team-combat` | game-designer + gameplay-programmer + ai-programmer + technical-artist + sound-designer + qa-tester |
| `/team-narrative` | narrative-director + writer + world-builder + level-designer |
| `/team-ui` | ux-designer + ui-programmer + art-director + accessibility-specialist |
| `/team-release` | release-manager + qa-lead + devops-engineer + producer |
| `/team-polish` | performance-analyst + technical-artist + sound-designer + qa-tester |
| `/team-audio` | audio-director + sound-designer + technical-artist + gameplay-programmer |
| `/team-level` | level-designer + narrative-director + world-builder + art-director + systems-designer + qa-tester |
| `/team-live-ops` | live-ops-designer + economy-designer + community-manager + analytics-engineer |
| `/team-qa` | qa-lead + qa-tester + gameplay-programmer + producer |

> **中文翻译**：

| 命令 | 协调 |
|------|------|
| `/team-combat` | 游戏设计师 + 游戏逻辑程序员 + AI程序员 + 技术美术 + 音效设计师 + QA测试员 |
| `/team-narrative` | 叙事总监 + 作家 + 世界构建师 + 关卡设计师 |
| `/team-ui` | UX设计师 + UI程序员 + 美术总监 + 无障碍专家 |
| `/team-release` | 发布经理 + QA主管 + 运维工程师 + 制作人 |
| `/team-polish` | 性能分析师 + 技术美术 + 音效设计师 + QA测试员 |
| `/team-audio` | 音频总监 + 音效设计师 + 技术美术 + 游戏逻辑程序员 |
| `/team-level` | 关卡设计师 + 叙事总监 + 世界构建师 + 美术总监 + 系统设计师 + QA测试员 |
| `/team-live-ops` | 在线运营设计师 + 经济设计师 + 社区经理 + 数据分析工程师 |
| `/team-qa` | QA主管 + QA测试员 + 游戏逻辑程序员 + 制作人 |
