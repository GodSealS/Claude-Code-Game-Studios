# Agent Roster / 代理花名册

The following agents are available. Each has a dedicated definition file in
`.codebuddy/agents/`. Use the agent best suited to the task at hand. When a task
spans multiple domains, the coordinating agent (usually `producer` or the
domain lead) should delegate to specialists.

> **中文翻译**：以下代理可用。每个代理在 `.codebuddy/agents/` 中有专门的定义文件。请使用最适合当前任务的代理。当任务跨多个领域时，协调代理（通常是 `producer` 或领域主管）应委派给专家。

## Tier 1 -- Leadership Agents (GLM-5.1) / 第一层 -- 领导层代理 (GLM-5.1)
| Agent | Domain | When to Use |
|-------|--------|-------------|
| `creative-director` | High-level vision | Major creative decisions, pillar conflicts, tone/direction |
| `technical-director` | Technical vision | Architecture decisions, tech stack choices, performance strategy |
| `producer` | Production management | Sprint planning, milestone tracking, risk management, coordination |

> **中文翻译**：

| 代理 | 领域 | 何时使用 |
|------|------|----------|
| `creative-director` | 高层愿景 | 重大创意决策、支柱冲突、基调/方向 |
| `technical-director` | 技术愿景 | 架构决策、技术栈选择、性能策略 |
| `producer` | 制作管理 | 冲刺规划、里程碑跟踪、风险管理、协调 |

## Tier 2 -- Department Lead Agents (DeepSeek-V3.2) / 第二层 -- 部门主管代理 (DeepSeek-V3.2)
| Agent | Domain | When to Use |
|-------|--------|-------------|
| `game-designer` | Game design | Mechanics, systems, progression, economy, balancing |
| `lead-programmer` | Code architecture | System design, code review, API design, refactoring |
| `art-director` | Visual direction | Style guides, art bible, asset standards, UI/UX direction |
| `audio-director` | Audio direction | Music direction, sound palette, audio implementation strategy |
| `narrative-director` | Story and writing | Story arcs, world-building, character design, dialogue strategy |
| `qa-lead` | Quality assurance | Test strategy, bug triage, release readiness, regression planning |
| `release-manager` | Release pipeline | Build management, versioning, changelogs, deployment, rollbacks |
| `localization-lead` | Internationalization | String externalization, translation pipeline, locale testing |

> **中文翻译**：

| 代理 | 领域 | 何时使用 |
|------|------|----------|
| `game-designer` | 游戏设计 | 机制、系统、进度、经济、平衡 |
| `lead-programmer` | 代码架构 | 系统设计、代码审查、API设计、重构 |
| `art-director` | 视觉方向 | 风格指南、美术圣经、资产标准、UI/UX方向 |
| `audio-director` | 音频方向 | 音乐方向、音色调色板、音频实现策略 |
| `narrative-director` | 故事与写作 | 故事弧线、世界观构建、角色设计、对话策略 |
| `qa-lead` | 质量保证 | 测试策略、缺陷分类、发布就绪、回归规划 |
| `release-manager` | 发布管线 | 构建管理、版本管理、变更日志、部署、回滚 |
| `localization-lead` | 国际化 | 字符串外化、翻译管线、本地化测试 |

## Tier 3 -- Specialist Agents (Kimi-K2.5 or MiniMax-M2.7) / 第三层 -- 专家代理 (Kimi-K2.5 或 MiniMax-M2.7)
| Agent | Domain | Model | When to Use |
|-------|--------|-------|-------------|
| `systems-designer` | Systems design | DeepSeek-V3.2 | Specific mechanic implementation, formula design, loops |
| `level-designer` | Level design | Kimi-K2.5 | Level layouts, pacing, encounter design, flow |
| `economy-designer` | Economy/balance | DeepSeek-V3.2 | Resource economies, loot tables, progression curves |

| `gameplay-programmer` | Gameplay code | DeepSeek-V3.2 | Feature implementation, gameplay systems code |

| `engine-programmer` | Engine systems | DeepSeek-V3.2 | Core engine, rendering, physics, memory management |
| `ai-programmer` | AI systems | DeepSeek-V3.2 | Behavior trees, pathfinding, NPC logic, state machines |
| `network-programmer` | Networking | DeepSeek-V3.2 | Netcode, replication, lag compensation, matchmaking |
| `tools-programmer` | Dev tools | DeepSeek-V3.2 | Editor extensions, pipeline tools, debug utilities |
| `ui-programmer` | UI implementation | GLM-5v-Turbo | UI framework, screens, widgets, data binding |
| `technical-artist` | Tech art | GLM-5v-Turbo | Shaders, VFX, optimization, art pipeline tools |
| `sound-designer` | Sound design | MiniMax-M2.7 | SFX design docs, audio event lists, mixing notes |
| `writer` | Dialogue/lore | MiniMax-M2.7 | Dialogue writing, lore entries, item descriptions |
| `world-builder` | World/lore design | MiniMax-M2.7 | World rules, faction design, history, geography |
| `qa-tester` | Test execution | DeepSeek-V3.2 | Writing test cases, bug reports, test checklists |
| `performance-analyst` | Performance | GLM-5.1 | Profiling, optimization recs, memory analysis |
| `devops-engineer` | Build/deploy | GLM-5.1 | CI/CD, build scripts, version control workflow |
| `analytics-engineer` | Telemetry | DeepSeek-V3.2 | Event tracking, dashboards, A/B test design |
| `ux-designer` | UX flows | GLM-5.1 | User flows, wireframes, accessibility, input handling |
| `prototyper` | Rapid prototyping | DeepSeek-V3.2 | Throwaway prototypes, mechanic testing, feasibility validation |
| `security-engineer` | Security | DeepSeek-V3.2 | Anti-cheat, exploit prevention, save encryption, network security |
| `accessibility-specialist` | Accessibility | GLM-5v-Turbo | WCAG compliance, colorblind modes, remapping, text scaling |
| `live-ops-designer` | Live operations | DeepSeek-V3.2 | Seasons, events, battle passes, retention, live economy |
| `community-manager` | Community | GLM-5.0-Turbo | Patch notes, player feedback, crisis comms, community health |

> **中文翻译**：

| 代理 | 领域 | 模型 | 何时使用 |
|------|------|------|----------|
| `systems-designer` | 系统设计 | DeepSeek-V3.2 | 具体机制实现、公式设计、循环 |
| `level-designer` | 关卡设计 | Kimi-K2.5 | 关卡布局、节奏、遭遇设计、流程 |
| `economy-designer` | 经济/平衡 | DeepSeek-V3.2 | 资源经济、战利品表、进度曲线 |
| `gameplay-programmer` | 游戏逻辑代码 | DeepSeek-V3.2 | 功能实现、游戏系统代码 |
| `engine-programmer` | 引擎系统 | DeepSeek-V3.2 | 核心引擎、渲染、物理、内存管理 |
| `ai-programmer` | AI系统 | DeepSeek-V3.2 | 行为树、寻路、NPC逻辑、状态机 |
| `network-programmer` | 网络编程 | DeepSeek-V3.2 | 网络代码、复制、延迟补偿、匹配 |
| `tools-programmer` | 开发工具 | DeepSeek-V3.2 | 编辑器扩展、管线工具、调试工具 |
| `ui-programmer` | UI实现 | GLM-5v-Turbo | UI框架、界面、控件、数据绑定 |
| `technical-artist` | 技术美术 | GLM-5v-Turbo | 着色器、特效、优化、美术管线工具 |
| `sound-designer` | 音效设计 | MiniMax-M2.7 | 音效设计文档、音频事件列表、混音备注 |
| `writer` | 对话/背景 | MiniMax-M2.7 | 对话写作、背景条目、物品描述 |
| `world-builder` | 世界/背景设计 | MiniMax-M2.7 | 世界规则、阵营设计、历史、地理 |
| `qa-tester` | 测试执行 | DeepSeek-V3.2 | 编写测试用例、缺陷报告、测试清单 |
| `performance-analyst` | 性能分析 | GLM-5.1 | 性能分析、优化建议、内存分析 |
| `devops-engineer` | 构建/部署 | GLM-5.1 | CI/CD、构建脚本、版本控制工作流 |
| `analytics-engineer` | 遥测数据 | DeepSeek-V3.2 | 事件追踪、仪表板、A/B测试设计 |
| `ux-designer` | UX流程 | GLM-5.1 | 用户流程、线框图、无障碍、输入处理 |
| `prototyper` | 快速原型 | DeepSeek-V3.2 | 一次性原型、机制测试、可行性验证 |
| `security-engineer` | 安全 | DeepSeek-V3.2 | 反作弊、漏洞防护、存档加密、网络安全 |
| `accessibility-specialist` | 无障碍 | GLM-5v-Turbo | WCAG合规、色盲模式、按键重映射、文字缩放 |
| `live-ops-designer` | 在线运营 | DeepSeek-V3.2 | 赛季、活动、通行证、留存、在线经济 |
| `community-manager` | 社区 | GLM-5.0-Turbo | 补丁说明、玩家反馈、危机沟通、社区健康 |

## Engine-Specific Agents (use the set matching your engine) / 引擎专用代理（使用与你的引擎匹配的专家组）

### Engine Leads / 引擎主管

| Agent | Engine | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `unreal-specialist` | Unreal Engine 5 | DeepSeek-V3.2 | Blueprint vs C++, GAS overview, UE subsystems, Unreal optimization |
| `unity-specialist` | Unity | DeepSeek-V3.2 | MonoBehaviour vs DOTS, Addressables, URP/HDRP, Unity optimization |
| `godot-specialist` | Godot 4 | DeepSeek-V3.2 | GDScript patterns, node/scene architecture, signals, Godot optimization |
| `wechat-specialist` | WeChat Mini Game | DeepSeek-V3.2 | WeChat platform architecture (MVC/ECS), wx.* APIs, game loop optimization, state/resource management, audio systems, sub-specialist coordination |

> **中文翻译**：

| 代理 | 引擎 | 模型 | 何时使用 |
| ---- | ---- | ---- | ---- |
| `unreal-specialist` | Unreal Engine 5 | DeepSeek-V3.2 | 蓝图vs C++、GAS概览、UE子系统、Unreal优化 |
| `unity-specialist` | Unity | DeepSeek-V3.2 | MonoBehaviour vs DOTS、Addressables、URP/HDRP、Unity优化 |
| `godot-specialist` | Godot 4 | DeepSeek-V3.2 | GDScript模式、节点/场景架构、信号、Godot优化 |
| `wechat-specialist` | 微信小游戏 | DeepSeek-V3.2 | 微信平台架构(MVC/ECS)、wx.* API、游戏循环优化、状态/资源管理、音频系统、子专家协调 |

### Unreal Engine Sub-Specialists / Unreal Engine 子专家

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `ue-gas-specialist` | Gameplay Ability System | DeepSeek-V3.2 | Abilities, gameplay effects, attribute sets, tags, prediction |
| `ue-blueprint-specialist` | Blueprint Architecture | GLM-5v-Turbo | BP/C++ boundary, graph standards, naming, BP optimization |
| `ue-replication-specialist` | Networking/Replication | GLM-5.1 | Property replication, RPCs, prediction, relevancy, bandwidth |
| `ue-umg-specialist` | UMG/CommonUI | DeepSeek-V3.2 | Widget hierarchy, data binding, CommonUI input, UI performance |

> **中文翻译**：

| 代理 | 子系统 | 模型 | 何时使用 |
| ---- | ---- | ---- | ---- |
| `ue-gas-specialist` | 游戏能力系统(GAS) | DeepSeek-V3.2 | 能力、游戏效果、属性集、标签、预测 |
| `ue-blueprint-specialist` | 蓝图架构 | GLM-5v-Turbo | BP/C++边界、图表标准、命名、BP优化 |
| `ue-replication-specialist` | 网络/复制 | GLM-5.1 | 属性复制、RPC、预测、相关性、带宽 |
| `ue-umg-specialist` | UMG/CommonUI | DeepSeek-V3.2 | 控件层级、数据绑定、CommonUI输入、UI性能 |

### Unity Sub-Specialists / Unity 子专家

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `unity-dots-specialist` | DOTS/ECS | DeepSeek-V3.2 | Entity Component System, Jobs, Burst compiler, hybrid renderer |
| `unity-shader-specialist` | Shaders/VFX | GLM-5.1 | Shader Graph, VFX Graph, URP/HDRP customization, post-processing |
| `unity-addressables-specialist` | Asset Management | DeepSeek-V3.2 | Addressable groups, async loading, memory, content delivery |
| `unity-ui-specialist` | UI Toolkit/UGUI | GLM-5v-Turbo | UI Toolkit, UXML/USS, UGUI Canvas, data binding, cross-platform input |

> **中文翻译**：

| 代理 | 子系统 | 模型 | 何时使用 |
| ---- | ---- | ---- | ---- |
| `unity-dots-specialist` | DOTS/ECS | DeepSeek-V3.2 | 实体组件系统、Jobs、Burst编译器、混合渲染器 |
| `unity-shader-specialist` | 着色器/VFX | GLM-5.1 | Shader Graph、VFX Graph、URP/HDRP定制、后处理 |
| `unity-addressables-specialist` | 资产管理 | DeepSeek-V3.2 | Addressable组、异步加载、内存、内容分发 |
| `unity-ui-specialist` | UI Toolkit/UGUI | GLM-5v-Turbo | UI Toolkit、UXML/USS、UGUI Canvas、数据绑定、跨平台输入 |

### Godot Sub-Specialists / Godot 子专家

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `godot-gdscript-specialist` | GDScript | DeepSeek-V3.2 | Static typing, design patterns, signals, coroutines, GDScript performance |
| `godot-shader-specialist` | Shaders/Rendering | GLM-5v-Turbo | Godot shading language, visual shaders, particles, post-processing |
| `godot-gdextension-specialist` | GDExtension | DeepSeek-V3.2 | C++/Rust bindings, native performance, custom nodes, build systems |

> **中文翻译**：

| 代理 | 子系统 | 模型 | 何时使用 |
| ---- | ---- | ---- | ---- |
| `godot-gdscript-specialist` | GDScript | DeepSeek-V3.2 | 静态类型、设计模式、信号、协程、GDScript性能 |
| `godot-shader-specialist` | 着色器/渲染 | GLM-5v-Turbo | Godot着色语言、可视化着色器、粒子、后处理 |
| `godot-gdextension-specialist` | GDExtension | DeepSeek-V3.2 | C++/Rust绑定、原生性能、自定义节点、构建系统 |

---

### WeChat Mini Game (微信小游戏) Sub-Specialists / 微信小游戏子专家

| Agent | Domain | Model | Reports To | When to Use |
| ---- | ---- | ---- | ---- | ---- |
| `wechat-minigame-specialist` | Gameplay & Physics | DeepSeek-V3.2 | wechat-specialist | Platform APIs, 4MB package limit, physics engines (Box2D/Bullet/JoltPhysics via unified IPhysicsWorld interface), WASM integration, Spine/DragonBones animation runtimes |
| `wechat-shader-specialist` | WebGL Shaders | GLM-5v-Turbo | wechat-specialist | Custom shaders, WebGL 1.0/2.0, Unity/Unreal/Godot shader conversion to GLSL, post-processing effects, render pipeline standards |
| `wechat-ui-specialist` | UI/UX Design | GLM-5v-Turbo | wechat-specialist | Figma/Sketch prototyping, Photoshop/Illustrator asset production, FairyGUI layout with data binding, screen management, portrait-first design, WeChat design system compliance |
| `wechat-cloudbase-specialist` | Cloud Backend | DeepSeek-V3.2 | wechat-specialist | Serverless backend, database, cloud functions, storage, security rules, anti-cheat |

> **中文翻译**：

| 代理 | 领域 | 模型 | 汇报给 | 何时使用 |
| ---- | ---- | ---- | ---- | ---- |
| `wechat-minigame-specialist` | 游戏逻辑与物理 | DeepSeek-V3.2 | wechat-specialist | 平台API、4MB包体限制、物理引擎(Box2D/Bullet/JoltPhysics，通过统一IPhysicsWorld接口)、WASM集成、Spine/DragonBones动画运行时 |
| `wechat-shader-specialist` | WebGL着色器 | GLM-5v-Turbo | wechat-specialist | 自定义着色器、WebGL 1.0/2.0、Unity/Unreal/Godot着色器转GLSL、后处理效果、渲染管线标准 |
| `wechat-ui-specialist` | UI/UX设计 | GLM-5v-Turbo | wechat-specialist | Figma/Sketch原型、Photoshop/Illustrator资产制作、FairyGUI布局与数据绑定、屏幕管理、竖屏优先设计、微信设计系统合规 |
| `wechat-cloudbase-specialist` | 云端后端 | DeepSeek-V3.2 | wechat-specialist | 无服务器后端、数据库、云函数、存储、安全规则、反作弊 |

**Notes:** / **备注：**
- `wechat-specialist` is the Engine Lead for the WeChat platform, coordinating all sub-specialists
  > **中文翻译**：`wechat-specialist` 是微信平台的引擎主管，协调所有子专家
- WeChat Mini Game specialists use TypeScript (preferred) for all JavaScript code
  > **中文翻译**：微信小游戏专家对所有JavaScript代码使用TypeScript（首选）
- 4MB package size limit is strictly enforced
  > **中文翻译**：4MB包体大小限制严格执行
- Audio format: AAC preferred, MP3 fallback; avoid WAV and OGG
  > **中文翻译**：音频格式：首选AAC，MP3备选；避免WAV和OGG
- Cloud Base provides serverless backend with MongoDB-like database
  > **中文翻译**：云开发提供无服务器后端和类MongoDB数据库
- Real-name verification (实名制) and anti-addiction (防沉迷) compliance required for China market
  > **中文翻译**：中国市场需要实名制和防沉迷合规
