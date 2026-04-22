# Game Studio Agent Architecture -- Quick Start Guide / 游戏工作室代理架构 -- 快速入门指南

## What Is This? / 这是什么？

This is a complete CodeBuddy agent architecture for game development. It
organizes 48 specialized AI agents into a studio hierarchy that mirrors
real game development teams, with defined responsibilities, delegation
rules, and coordination protocols. It includes engine-specialist agents
for Godot, Unity, and Unreal — each with dedicated sub-specialists for
major engine subsystems. All design agents and templates are grounded in
established game design theory (MDA Framework, Self-Determination Theory,
Flow State, Bartle Player Types). Use whichever engine set matches your project.

> **中文翻译**：这是一个完整的 CodeBuddy 游戏开发代理架构。它将 48 个专业 AI 代理组织成镜像真实游戏开发团队的工作室层级，具有明确的职责、委派规则和协调协议。它包含 Godot、Unity 和 Unreal 的引擎专家代理——每个都有专门负责主要引擎子系统的子专家。所有设计代理和模板都基于成熟的游戏设计理论（MDA 框架、自我决定理论、心流状态、Bartle 玩家类型）。使用与你的项目匹配的引擎组。

## How to Use / 如何使用

### 1. Understand the Hierarchy / 了解层级

There are three tiers of agents:

> **中文翻译**：代理分为三个层级：

- **Tier 1 (DeepSeek-V3.2/GLM-5.1)**: Directors who make high-level decisions
  - `creative-director` -- vision and creative conflict resolution
  - `technical-director` -- architecture and technology decisions
  - `producer` -- scheduling, coordination, and risk management

> **中文翻译**：**第一层 (DeepSeek-V3.2/GLM-5.1)**：做出高层决策的总监
> - `creative-director` -- 愿景和创意冲突解决
> - `technical-director` -- 架构和技术决策
> - `producer` -- 排期、协调和风险管理

- **Tier 2 (Kimi-K2.5/GLM-5.1)**: Department leads who own their domain
  - `game-designer`, `lead-programmer`, `art-director`, `audio-director`,
    `narrative-director`, `qa-lead`, `release-manager`, `localization-lead`

> **中文翻译**：**第二层 (Kimi-K2.5/GLM-5.1)**：负责各自领域的部门主管
> - `game-designer`、`lead-programmer`、`art-director`、`audio-director`、
>   `narrative-director`、`qa-lead`、`release-manager`、`localization-lead`

- **Tier 3 (GLM-5.0-Turbo / MiniMax-M2.7)**: Specialists who execute within their domain
  - Designers, programmers, artists, writers, testers, engineers

> **中文翻译**：**第三层 (GLM-5.0-Turbo / MiniMax-M2.7)**：在各自领域内执行的专家
> - 设计师、程序员、美术师、作家、测试员、工程师

### 2. Pick the Right Agent for the Job / 选择合适的代理

Ask yourself: "What department would handle this in a real studio?"

> **中文翻译**：问自己："在真实工作室中，哪个部门会处理这个？"

| I need to... | Use this agent |
|-------------|---------------|
| Design a new mechanic | `game-designer` |
| Write combat code | `gameplay-programmer` |
| Create a shader | `technical-artist` |
| Write dialogue | `writer` |
| Plan the next sprint | `producer` |
| Review code quality | `lead-programmer` |
| Write test cases | `qa-tester` |
| Design a level | `level-designer` |
| Fix a performance problem | `performance-analyst` |
| Set up CI/CD | `devops-engineer` |
| Design a loot table | `economy-designer` |
| Resolve a creative conflict | `creative-director` |
| Make an architecture decision | `technical-director` |
| Manage a release | `release-manager` |
| Prepare strings for translation | `localization-lead` |
| Test a mechanic idea quickly | `prototyper` |
| Review code for security issues | `security-engineer` |
| Check accessibility compliance | `accessibility-specialist` |
| Get Unreal Engine advice | `unreal-specialist` |
| Get Unity advice | `unity-specialist` |
| Get Godot advice | `godot-specialist` |
| Design GAS abilities/effects | `ue-gas-specialist` |
| Define BP/C++ boundaries | `ue-blueprint-specialist` |
| Implement UE replication | `ue-replication-specialist` |
| Build UMG/CommonUI widgets | `ue-umg-specialist` |
| Design DOTS/ECS architecture | `unity-dots-specialist` |
| Write Unity shaders/VFX | `unity-shader-specialist` |
| Manage Addressable assets | `unity-addressables-specialist` |
| Build UI Toolkit/UGUI screens | `unity-ui-specialist` |
| Write idiomatic GDScript | `godot-gdscript-specialist` |
| Create Godot shaders | `godot-shader-specialist` |
| Build GDExtension modules | `godot-gdextension-specialist` |
| Plan live events and seasons | `live-ops-designer` |
| Write patch notes for players | `community-manager` |
| Brainstorm a new game idea | Use `/brainstorm` skill |

> **中文翻译**：

| 我需要... | 使用此代理 |
|-----------|-----------|
| 设计新机制 | `game-designer` |
| 编写战斗代码 | `gameplay-programmer` |
| 创建着色器 | `technical-artist` |
| 编写对话 | `writer` |
| 规划下一个冲刺 | `producer` |
| 审查代码质量 | `lead-programmer` |
| 编写测试用例 | `qa-tester` |
| 设计关卡 | `level-designer` |
| 修复性能问题 | `performance-analyst` |
| 设置 CI/CD | `devops-engineer` |
| 设计掉落表 | `economy-designer` |
| 解决创意冲突 | `creative-director` |
| 做架构决策 | `technical-director` |
| 管理发布 | `release-manager` |
| 准备翻译字符串 | `localization-lead` |
| 快速测试机制想法 | `prototyper` |
| 审查代码安全问题 | `security-engineer` |
| 检查无障碍合规 | `accessibility-specialist` |
| 获取 Unreal Engine 建议 | `unreal-specialist` |
| 获取 Unity 建议 | `unity-specialist` |
| 获取 Godot 建议 | `godot-specialist` |
| 设计 GAS 能力/效果 | `ue-gas-specialist` |
| 定义 BP/C++ 边界 | `ue-blueprint-specialist` |
| 实现 UE 复制 | `ue-replication-specialist` |
| 构建 UMG/CommonUI 控件 | `ue-umg-specialist` |
| 设计 DOTS/ECS 架构 | `unity-dots-specialist` |
| 编写 Unity 着色器/VFX | `unity-shader-specialist` |
| 管理 Addressable 资产 | `unity-addressables-specialist` |
| 构建 UI Toolkit/UGUI 界面 | `unity-ui-specialist` |
| 编写惯用 GDScript | `godot-gdscript-specialist` |
| 创建 Godot 着色器 | `godot-shader-specialist` |
| 构建 GDExtension 模块 | `godot-gdextension-specialist` |
| 规划线上活动和赛季 | `live-ops-designer` |
| 为玩家编写补丁说明 | `community-manager` |
| 构思新游戏想法 | 使用 `/brainstorm` 技能 |

### 3. Use Slash Commands for Common Tasks / 使用斜杠命令完成常见任务

| Command | What it does |
|---------|-------------|
| `/start` | First-time onboarding — asks where you are, guides you to the right workflow |
| `/help` | Context-aware "what do I do next?" — reads your current phase and artifacts |
| `/project-stage-detect` | Analyze project state, detect stage, identify gaps |
| `/setup-engine` | Configure engine + version, populate reference docs |
| `/adopt` | Brownfield audit and migration plan for existing projects |
| `/brainstorm` | Guided game concept ideation from scratch |
| `/map-systems` | Decompose concept into systems, map dependencies, guide per-system GDDs |
| `/design-system` | Guided, section-by-section GDD authoring for a single game system |
| `/quick-design` | Lightweight spec for small changes — tuning, tweaks, minor additions |
| `/review-all-gdds` | Cross-GDD consistency and game design theory review |
| `/propagate-design-change` | Find ADRs and stories affected by a GDD change |
| `/ux-design` | Author UX specs (screen/flow, HUD, interaction patterns) |
| `/ux-review` | Validate UX specs for accessibility and GDD alignment |
| `/create-architecture` | Master architecture document for the game |
| `/architecture-decision` | Creates an ADR |
| `/architecture-review` | Validate all ADRs, dependency ordering, GDD traceability |
| `/create-control-manifest` | Flat programmer rules sheet from Accepted ADRs |
| `/create-epics` | Translate GDDs + ADRs into epics (one per architectural module) |
| `/create-stories` | Break a single epic into implementable story files |
| `/dev-story` | Read a story and implement it — routes to the correct programmer agent |
| `/sprint-plan` | Creates or updates sprint plans |
| `/sprint-status` | Quick 30-line sprint snapshot |
| `/story-readiness` | Validate a story is implementation-ready before pickup |
| `/story-done` | End-of-story completion review — verifies acceptance criteria |
| `/estimate` | Produces structured effort estimates |
| `/design-review` | Reviews a design document |
| `/code-review` | Reviews code for quality and architecture |
| `/balance-check` | Analyzes game balance data |
| `/asset-audit` | Audits assets for compliance |
| `/content-audit` | GDD-specified content vs. implemented — find gaps |
| `/scope-check` | Detect scope creep against plan |
| `/perf-profile` | Performance profiling and bottleneck ID |
| `/tech-debt` | Scan, track, and prioritize tech debt |
| `/gate-check` | Validate phase readiness (PASS/CONCERNS/FAIL) |
| `/consistency-check` | Scan all GDDs for cross-document inconsistencies (conflicting stats, names, rules) |
| `/reverse-document` | Generate design/architecture docs from existing code |
| `/milestone-review` | Reviews milestone progress |
| `/retrospective` | Runs sprint/milestone retrospective |
| `/bug-report` | Structured bug report creation |
| `/playtest-report` | Creates or analyzes playtest feedback |
| `/onboard` | Generates onboarding docs for a role |
| `/release-checklist` | Validates pre-release checklist |
| `/launch-checklist` | Complete launch readiness validation |
| `/changelog` | Generates changelog from git history |
| `/patch-notes` | Generate player-facing patch notes |
| `/hotfix` | Emergency fix with audit trail |
| `/prototype` | Scaffolds a throwaway prototype |
| `/localize` | Localization scan, extract, validate |
| `/team-combat` | Orchestrate full combat team pipeline |
| `/team-narrative` | Orchestrate full narrative team pipeline |
| `/team-ui` | Orchestrate full UI team pipeline |
| `/team-release` | Orchestrate full release team pipeline |
| `/team-polish` | Orchestrate full polish team pipeline |
| `/team-audio` | Orchestrate full audio team pipeline |
| `/team-level` | Orchestrate full level creation pipeline |
| `/team-live-ops` | Orchestrate live-ops team for seasons, events, and post-launch content |
| `/team-qa` | Orchestrate full QA team cycle — test plan, test cases, smoke check, sign-off |
| `/qa-plan` | Generate a QA test plan for a sprint or feature |
| `/bug-triage` | Re-prioritize open bugs, assign to sprints, surface systemic trends |
| `/smoke-check` | Run critical path smoke test gate before QA hand-off (PASS/FAIL) |
| `/soak-test` | Generate a soak test protocol for extended play sessions |
| `/regression-suite` | Map coverage to GDD critical paths, flag gaps, maintain regression suite |
| `/test-setup` | Scaffold test framework + CI pipeline for the project's engine (run once) |
| `/test-helpers` | Generate engine-specific test helper libraries and factory functions |
| `/test-flakiness` | Detect flaky tests from CI history, flag for quarantine or fix |
| `/test-evidence-review` | Quality review of test files and manual evidence — ADEQUATE/INCOMPLETE/MISSING |
| `/skill-test` | Validate skill files for compliance and correctness (static / spec / audit) |

> **中文翻译**：

| 命令 | 功能 |
|------|------|
| `/start` | 首次引导入门 — 询问你当前状态，引导到正确的工作流 |
| `/help` | 上下文感知的"下一步做什么？" — 读取当前阶段和产物 |
| `/project-stage-detect` | 分析项目状态、检测阶段、识别差距 |
| `/setup-engine` | 配置引擎+版本、填充参考文档 |
| `/adopt` | 棕地审计和现有项目迁移计划 |
| `/brainstorm` | 从零开始引导式游戏概念创意 |
| `/map-systems` | 将概念分解为系统、映射依赖、引导逐系统GDD |
| `/design-system` | 引导式、逐章节的GDD编写（单个游戏系统） |
| `/quick-design` | 轻量级规格（小改动 — 调优、微调、小增补） |
| `/review-all-gdds` | 跨GDD一致性和游戏设计理论审查 |
| `/propagate-design-change` | 查找GDD变更影响的ADR和故事 |
| `/ux-design` | 编写UX规格（屏幕/流程、HUD、交互模式） |
| `/ux-review` | 验证UX规格的无障碍和GDD一致性 |
| `/create-architecture` | 游戏主架构文档 |
| `/architecture-decision` | 创建ADR |
| `/architecture-review` | 验证所有ADR、依赖排序、GDD可追溯性 |
| `/create-control-manifest` | 从已接受ADR生成扁平化程序员规则表 |
| `/create-epics` | 将GDD+ADR转化为史诗（每个架构模块一个） |
| `/create-stories` | 将单个史诗拆分为可实现的故事文件 |
| `/dev-story` | 读取故事并实现 — 路由到正确的程序员代理 |
| `/sprint-plan` | 创建或更新冲刺计划 |
| `/sprint-status` | 快速30行冲刺快照 |
| `/story-readiness` | 验证故事在拾取前是否实现就绪 |
| `/story-done` | 实现后完成审查 — 验证验收标准 |
| `/estimate` | 产出结构化工作量估算 |
| `/design-review` | 审查设计文档 |
| `/code-review` | 审查代码质量和架构 |
| `/balance-check` | 分析游戏平衡数据 |
| `/asset-audit` | 审计资产合规性 |
| `/content-audit` | GDD指定内容 vs 已实现内容 — 查找差距 |
| `/scope-check` | 检测范围蔓延 |
| `/perf-profile` | 性能分析和瓶颈识别 |
| `/tech-debt` | 扫描、跟踪和优先排序技术债务 |
| `/gate-check` | 验证阶段就绪度（通过/关注/失败） |
| `/consistency-check` | 扫描所有GDD检测跨文档不一致 |
| `/reverse-document` | 从已有代码生成设计/架构文档 |
| `/milestone-review` | 审查里程碑进度 |
| `/retrospective` | 运行冲刺/里程碑回顾 |
| `/bug-report` | 创建结构化缺陷报告 |
| `/playtest-report` | 创建或分析试玩反馈 |
| `/onboard` | 为新贡献者生成引导入门文档 |
| `/release-checklist` | 验证预发布清单 |
| `/launch-checklist` | 完整上线就绪验证 |
| `/changelog` | 从git历史生成变更日志 |
| `/patch-notes` | 生成面向玩家的补丁说明 |
| `/hotfix` | 带审计追踪的紧急修复 |
| `/prototype` | 搭建一次性原型 |
| `/localize` | 本地化扫描、提取、验证 |
| `/team-combat` | 编排完整战斗团队管线 |
| `/team-narrative` | 编排完整叙事团队管线 |
| `/team-ui` | 编排完整UI团队管线 |
| `/team-release` | 编排完整发布团队管线 |
| `/team-polish` | 编排完整打磨团队管线 |
| `/team-audio` | 编排完整音频团队管线 |
| `/team-level` | 编排完整关卡创建管线 |
| `/team-live-ops` | 编排线上运营团队（赛季、活动、发布后内容） |
| `/team-qa` | 编排完整QA团队周期 |
| `/qa-plan` | 为冲刺或功能生成QA测试计划 |
| `/bug-triage` | 重新优先排序未关闭缺陷 |
| `/smoke-check` | QA交接前运行关键路径冒烟测试门控 |
| `/soak-test` | 生成长时间试玩的浸泡测试协议 |
| `/regression-suite` | 将覆盖映射到GDD关键路径、标记差距 |
| `/test-setup` | 搭建项目引擎的测试框架+CI管线（运行一次） |
| `/test-helpers` | 生成引擎特定的测试辅助库和工厂函数 |
| `/test-flakiness` | 从CI历史检测不稳定测试 |
| `/test-evidence-review` | 测试文件和手动证据质量审查 |
| `/skill-test` | 验证技能文件的合规性和正确性（静态/规格/审计）

### 4. Use Templates for New Documents / 使用模板创建新文档

Templates are in `.codebuddy/docs/templates/`:

> **中文翻译**：模板位于 `.codebuddy/docs/templates/`：

- `game-design-document.md` -- for new mechanics and systems
- `architecture-decision-record.md` -- for technical decisions
- `architecture-traceability.md` -- maps GDD requirements to ADRs to story IDs
- `risk-register-entry.md` -- for new risks
- `narrative-character-sheet.md` -- for new characters
- `test-plan.md` -- for feature test plans
- `sprint-plan.md` -- for sprint planning
- `milestone-definition.md` -- for new milestones
- `level-design-document.md` -- for new levels
- `game-pillars.md` -- for core design pillars
- `art-bible.md` -- for visual style reference
- `technical-design-document.md` -- for per-system technical designs
- `post-mortem.md` -- for project/milestone retrospectives
- `sound-bible.md` -- for audio style reference
- `release-checklist-template.md` -- for platform release checklists
- `changelog-template.md` -- for player-facing patch notes
- `release-notes.md` -- for player-facing release notes
- `incident-response.md` -- for live incident response playbooks
- `game-concept.md` -- for initial game concepts (MDA, SDT, Flow, Bartle)
- `pitch-document.md` -- for pitching the game to stakeholders
- `economy-model.md` -- for virtual economy design (sink/faucet model)
- `faction-design.md` -- for faction identity, lore, and gameplay role
- `systems-index.md` -- for systems decomposition and dependency mapping
- `project-stage-report.md` -- for project stage detection output
- `design-doc-from-implementation.md` -- for reverse-documenting existing code into GDDs
- `architecture-doc-from-code.md` -- for reverse-documenting code into architecture docs
- `concept-doc-from-prototype.md` -- for reverse-documenting prototypes into concept docs
- `ux-spec.md` -- for per-screen UX specifications (layout zones, states, events)
- `hud-design.md` -- for whole-game HUD philosophy, zones, and element specs
- `accessibility-requirements.md` -- for project-wide accessibility tier and feature matrix
- `interaction-pattern-library.md` -- for standard UI controls and game-specific patterns
- `player-journey.md` -- for 6-phase emotional arc and retention hooks by time scale
- `difficulty-curve.md` -- for difficulty axes, onboarding ramp, and cross-system interactions
- `test-evidence.md` -- template for recording manual test evidence (screenshots, walkthrough notes)

> **中文翻译**：
> - `game-design-document.md` -- 新机制和系统
> - `architecture-decision-record.md` -- 技术决策
> - `architecture-traceability.md` -- 将GDD需求映射到ADR和故事ID
> - `risk-register-entry.md` -- 新风险
> - `narrative-character-sheet.md` -- 新角色
> - `test-plan.md` -- 功能测试计划
> - `sprint-plan.md` -- 冲刺规划
> - `milestone-definition.md` -- 新里程碑
> - `level-design-document.md` -- 新关卡
> - `game-pillars.md` -- 核心设计支柱
> - `art-bible.md` -- 视觉风格参考
> - `technical-design-document.md` -- 逐系统技术设计
> - `post-mortem.md` -- 项目/里程碑回顾
> - `sound-bible.md` -- 音频风格参考
> - `release-checklist-template.md` -- 平台发布清单
> - `changelog-template.md` -- 面向玩家的补丁说明
> - `release-notes.md` -- 面向玩家的发布说明
> - `incident-response.md` -- 线上事件响应手册
> - `game-concept.md` -- 初始游戏概念（MDA、SDT、心流、Bartle）
> - `pitch-document.md` -- 向利益相关者推介游戏
> - `economy-model.md` -- 虚拟经济设计（汇入/汇出模型）
> - `faction-design.md` -- 阵营身份、背景和游戏角色
> - `systems-index.md` -- 系统分解和依赖映射
> - `project-stage-report.md` -- 项目阶段检测输出
> - `design-doc-from-implementation.md` -- 从已有代码逆向文档化为GDD
> - `architecture-doc-from-code.md` -- 从代码逆向文档化为架构文档
> - `concept-doc-from-prototype.md` -- 从原型逆向文档化为概念文档
> - `ux-spec.md` -- 逐屏幕UX规格（布局区域、状态、事件）
> - `hud-design.md` -- 全局HUD哲学、区域和元素规格
> - `accessibility-requirements.md` -- 项目级无障碍层级和功能矩阵
> - `interaction-pattern-library.md` -- 标准UI控件和游戏特定模式
> - `player-journey.md` -- 6阶段情感弧线和按时间尺度的留存钩子
> - `difficulty-curve.md` -- 难度轴、入门坡度和跨系统交互
> - `test-evidence.md` -- 记录手动测试证据的模板（截图、走查笔记）

Also in `.codebuddy/docs/templates/collaborative-protocols/` (used by agents, not typically edited directly):

> **中文翻译**：还有 `.codebuddy/docs/templates/collaborative-protocols/`（由代理使用，通常不直接编辑）：

- `design-agent-protocol.md` -- question-options-draft-approval cycle for design agents
- `implementation-agent-protocol.md` -- story pickup through /story-done cycle for programming agents
- `leadership-agent-protocol.md` -- cross-department delegation and escalation for director-tier agents

> **中文翻译**：
> - `design-agent-protocol.md` -- 设计代理的问题-选项-草案-审批循环
> - `implementation-agent-protocol.md` -- 编程代理的故事拾取到 /story-done 循环
> - `leadership-agent-protocol.md` -- 总监层级代理的跨部门委派和升级

### 5. Follow the Coordination Rules / 遵循协调规则

1. Work flows down the hierarchy: Directors -> Leads -> Specialists
2. Conflicts escalate up the hierarchy
3. Cross-department work is coordinated by the `producer`
4. Agents do not modify files outside their domain without delegation
5. All decisions are documented

> **中文翻译**：
> 1. 工作沿层级向下流动：总监 -> 主管 -> 专家
> 2. 冲突沿层级向上升级
> 3. 跨部门工作由 `producer` 协调
> 4. 代理不得在未经委派的情况下修改其领域外的文件
> 5. 所有决策必须文档化

## First Steps for a New Project / 新项目首次步骤

**Don't know where to begin?** Run `/start`. It asks where you are and routes
you to the right workflow. No assumptions about your game, engine, or experience level.

> **中文翻译**：**不知道从哪里开始？** 运行 `/start`。它会询问你当前状态并引导你到正确的工作流。不会对你的游戏、引擎或经验水平做任何假设。

If you already know what you need, jump directly to the relevant path:

> **中文翻译**：如果你已经知道需要什么，直接跳到相关路径：

### Path A: "I have no idea what to build" / 路径 A："我不知道要做什么"

1. **Run `/start`** (or `/brainstorm open`) — guided creative exploration:
   what excites you, what you've played, your constraints
   - Generates 3 concepts, helps you pick one, defines core loop and pillars
   - Produces a game concept document and recommends an engine
2. **Set up the engine** — Run `/setup-engine` (uses the brainstorm recommendation)
   - Configures CODEBUDDY.md, detects knowledge gaps, populates reference docs
   - Creates `.codebuddy/docs/technical-preferences.md` with naming conventions,
     performance budgets, and engine-specific defaults
   - If the engine version is newer than the LLM's training data, it fetches
     current docs from the web so agents suggest correct APIs
3. **Validate the concept** — Run `/design-review design/gdd/game-concept.md`
4. **Decompose into systems** — Run `/map-systems` to map all systems and dependencies
5. **Design each system** — Run `/design-system [system-name]` (or `/map-systems next`)
   to write GDDs in dependency order
6. **Test the core loop** — Run `/prototype [core-mechanic]`
7. **Playtest it** — Run `/playtest-report` to validate the hypothesis
8. **Plan the first sprint** — Run `/sprint-plan new`
9. Start building

> **中文翻译**：
> 1. **运行 `/start`**（或 `/brainstorm open`）— 引导式创意探索：什么让你兴奋、你玩过什么、你的约束
>    - 生成3个概念，帮你选择一个，定义核心循环和支柱
>    - 产出游戏概念文档并推荐引擎
> 2. **设置引擎** — 运行 `/setup-engine`（使用brainstorm推荐）
>    - 配置 CODEBUDDY.md，检测知识差距，填充参考文档
>    - 创建 `.codebuddy/docs/technical-preferences.md`，包含命名约定、性能预算和引擎特定默认值
>    - 如果引擎版本比LLM训练数据新，会从网上获取最新文档以便代理建议正确的API
> 3. **验证概念** — 运行 `/design-review design/gdd/game-concept.md`
> 4. **分解为系统** — 运行 `/map-systems` 映射所有系统和依赖
> 5. **设计每个系统** — 运行 `/design-system [系统名]`（或 `/map-systems next`）按依赖顺序编写GDD
> 6. **测试核心循环** — 运行 `/prototype [核心机制]`
> 7. **试玩验证** — 运行 `/playtest-report` 验证假设
> 8. **规划第一个冲刺** — 运行 `/sprint-plan new`
> 9. 开始构建

### Path B: "I know what I want to build" / 路径 B："我知道要做什么"

If you already have a game concept and engine choice:

> **中文翻译**：如果你已经有游戏概念和引擎选择：

1. **Set up the engine** — Run `/setup-engine [engine] [version]`
   (e.g., `/setup-engine godot 4.6`) — also creates technical preferences
2. **Write the Game Pillars** — delegate to `creative-director`
3. **Decompose into systems** — Run `/map-systems` to enumerate systems and dependencies
4. **Design each system** — Run `/design-system [system-name]` for GDDs in dependency order
5. **Create the initial ADR** — Run `/architecture-decision`
6. **Create the first milestone** in `production/milestones/`
7. **Plan the first sprint** — Run `/sprint-plan new`
8. Start building

> **中文翻译**：
> 1. **设置引擎** — 运行 `/setup-engine [引擎] [版本]`（如 `/setup-engine godot 4.6`）— 也会创建技术偏好
> 2. **编写游戏支柱** — 委派给 `creative-director`
> 3. **分解为系统** — 运行 `/map-systems` 枚举系统和依赖
> 4. **设计每个系统** — 运行 `/design-system [系统名]` 按依赖顺序编写GDD
> 5. **创建初始ADR** — 运行 `/architecture-decision`
> 6. **创建第一个里程碑** 在 `production/milestones/` 中
> 7. **规划第一个冲刺** — 运行 `/sprint-plan new`
> 8. 开始构建

### Path C: "I know the game but not the engine" / 路径 C："我知道游戏但不知道选什么引擎"

If you have a concept but don't know which engine fits:

> **中文翻译**：如果你有概念但不知道哪个引擎合适：

1. **Run `/setup-engine`** with no arguments — it will ask about your game's
   needs (2D/3D, platforms, team size, language preferences) and recommend
   an engine based on your answers
2. Follow Path B from step 2 onward

> **中文翻译**：
> 1. **运行 `/setup-engine`** 不带参数 — 它会询问你的游戏需求（2D/3D、平台、团队规模、语言偏好）并根据你的回答推荐引擎
> 2. 从路径B的第2步继续

### Path D: "I have an existing project" / 路径 D："我已有现有项目"

If you have design docs, prototypes, or code already:

> **中文翻译**：如果你已有设计文档、原型或代码：

1. **Run `/start`** (or `/project-stage-detect`) — analyzes what exists,
   identifies gaps, and recommends next steps
2. **Run `/adopt`** if you have existing GDDs, ADRs, or stories — audits
   internal format compliance and builds a numbered migration plan to fill gaps
   without overwriting your existing work
3. **Configure engine if needed** — Run `/setup-engine` if not yet configured
4. **Validate phase readiness** — Run `/gate-check` to see where you stand
5. **Plan the next sprint** — Run `/sprint-plan new`

> **中文翻译**：
> 1. **运行 `/start`**（或 `/project-stage-detect`）— 分析已有内容、识别差距、推荐下一步
> 2. **运行 `/adopt`** 如果你已有GDD、ADR或故事 — 审计内部格式合规性并生成编号的迁移计划来填补差距，不会覆盖已有工作
> 3. **按需配置引擎** — 如未配置则运行 `/setup-engine`
> 4. **验证阶段就绪度** — 运行 `/gate-check` 查看当前状态
> 5. **规划下一个冲刺** — 运行 `/sprint-plan new`

## File Structure Reference / 文件结构参考

```
CODEBUDDY.md                       -- Master config (read this first, ~60 lines) / 主配置（先读此文件，约60行）
.codebuddy/
  settings.json                    -- CodeBuddy hooks and project settings / CodeBuddy钩子和项目设置
  agents/                          -- 48 agent definitions (YAML frontmatter) / 48个代理定义（YAML前置元数据）
  skills/                          -- 68 slash command definitions (YAML frontmatter) / 68个斜杠命令定义（YAML前置元数据）
  hooks/                           -- 12 hook scripts (.sh) wired by settings.json / 12个钩子脚本(.sh)，由settings.json连接
  rules/                           -- 11 path-specific rule files / 11个路径特定规则文件
  docs/
    quick-start.md                 -- This file / 本文件
    technical-preferences.md       -- Project-specific standards (populated by /setup-engine) / 项目特定标准（由/setup-engine填充）
    coding-standards.md            -- Coding and design doc standards / 编码和设计文档标准
    coordination-rules.md          -- Agent coordination rules / 代理协调规则
    context-management.md          -- Context budgets and compaction instructions / 上下文预算和压缩指令
    directory-structure.md         -- Project directory layout / 项目目录布局
    workflow-catalog.yaml          -- 7-phase pipeline definition (read by /help) / 7阶段管线定义（由/help读取）
    setup-requirements.md          -- System prerequisites (Git Bash, jq, Python) / 系统先决条件（Git Bash、jq、Python）
    settings-local-template.md     -- Personal settings.local.json guide / 个人settings.local.json指南
    templates/                     -- 37 document templates / 37个文档模板
```
