# Agent Roster

The following agents are available. Each has a dedicated definition file in
`.codebuddy/agents/`. Use the agent best suited to the task at hand. When a task
spans multiple domains, the coordinating agent (usually `producer` or the
domain lead) should delegate to specialists.

<!-- 中文翻译 -->
## Tier 1 -- Leadership Agents (GLM-5.1)
| Agent | Domain | When to Use |
|-------|--------|-------------|
| `creative-director` | High-level vision | Major creative decisions, pillar conflicts, tone/direction |
| `technical-director` | Technical vision | Architecture decisions, tech stack choices, performance strategy |
| `producer` | Production management | Sprint planning, milestone tracking, risk management, coordination |

<!-- 中文翻译 -->
## Tier 2 -- Department Lead Agents (DeepSeek-V3.2)
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

<!-- 中文翻译 -->
## Tier 3 -- Specialist Agents (Kimi-K2.5 or MiniMax-M2.7)
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

<!-- 引擎专用代理（使用与你的引擎匹配的集合） -->
## Engine-Specific Agents (use the set matching your engine)

<!-- 中文翻译 -->
### Engine Leads

| Agent | Engine | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `unreal-specialist` | Unreal Engine 5 | DeepSeek-V3.2 | Blueprint vs C++, GAS overview, UE subsystems, Unreal optimization |
| `unity-specialist` | Unity | DeepSeek-V3.2 | MonoBehaviour vs DOTS, Addressables, URP/HDRP, Unity optimization |
| `godot-specialist` | Godot 4 | DeepSeek-V3.2 | GDScript patterns, node/scene architecture, signals, Godot optimization |
| `wechat-specialist` | WeChat Mini Game | DeepSeek-V3.2 | WeChat platform architecture (MVC/ECS), wx.* APIs, game loop optimization, state/resource management, audio systems, sub-specialist coordination |
| `cocos-specialist` | Cocos Creator | DeepSeek-V3.2 | Component system, scene graph, rendering pipeline, Cocos optimization |


<!-- 中文翻译 -->
### Unreal Engine Sub-Specialists

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `ue-gas-specialist` | Gameplay Ability System | DeepSeek-V3.2 | Abilities, gameplay effects, attribute sets, tags, prediction |
| `ue-blueprint-specialist` | Blueprint Architecture | GLM-5v-Turbo | BP/C++ boundary, graph standards, naming, BP optimization |
| `ue-replication-specialist` | Networking/Replication | GLM-5.1 | Property replication, RPCs, prediction, relevancy, bandwidth |
| `ue-umg-specialist` | UMG/CommonUI | DeepSeek-V3.2 | Widget hierarchy, data binding, CommonUI input, UI performance |

<!-- 中文翻译 -->
### Unity Sub-Specialists

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `unity-dots-specialist` | DOTS/ECS | DeepSeek-V3.2 | Entity Component System, Jobs, Burst compiler, hybrid renderer |
| `unity-shader-specialist` | Shaders/VFX | GLM-5.1 | Shader Graph, VFX Graph, URP/HDRP customization, post-processing |
| `unity-addressables-specialist` | Asset Management | DeepSeek-V3.2 | Addressable groups, async loading, memory, content delivery |
| `unity-ui-specialist` | UI Toolkit/UGUI | GLM-5v-Turbo | UI Toolkit, UXML/USS, UGUI Canvas, data binding, cross-platform input |

<!-- 中文翻译 -->
### Godot Sub-Specialists

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `godot-gdscript-specialist` | GDScript | DeepSeek-V3.2 | Static typing, design patterns, signals, coroutines, GDScript performance |
| `godot-shader-specialist` | Shaders/Rendering | GLM-5v-Turbo | Godot shading language, visual shaders, particles, post-processing |
| `godot-gdextension-specialist` | GDExtension | DeepSeek-V3.2 | C++/Rust bindings, native performance, custom nodes, build systems |

<!-- 中文翻译 -->
### Cocos Creator Sub-Specialists

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `cocos_2d-expert` | 2D Rendering | DeepSeek-V3.2 | Sprite, UI components, 2D graphics, text rendering, mask effects |
| `cocos_3d-expert` | 3D Rendering | DeepSeek-V3.2 | Mesh rendering, skinned animation, model management, LOD |
| `cocos_animation-expert` | Animation System | DeepSeek-V3.2 | Animation clips, skeletal animation, state machines, blending |
| `cocos_core-expert` | Core Engine | DeepSeek-V3.2 | Component system, scene graph, lifecycle management, event system |
| `cocos_gfx-expert` | Graphics API | DeepSeek-V3.2 | Shaders, GPU resources, cross-platform backends, rendering pipeline |
| `cocos_physics-expert` | 3D Physics | DeepSeek-V3.2 | Rigid bodies, collision detection, raycasting, joints |
| `cocos_physics-2d-expert` | 2D Physics | DeepSeek-V3.2 | Box2D integration, 2D collision detection, physics events |
| `cocos_rendering-expert` | Rendering Pipeline | DeepSeek-V3.2 | Camera system, lighting, shadows, post-processing, optimization |

---

### WeChat Mini Game (微信小游戏) Sub-Specialists

| Agent | Domain | Model | Reports To | When to Use |
| ---- | ---- | ---- | ---- | ---- |
| `wechat-minigame-specialist` | Gameplay & Physics | DeepSeek-V3.2 | wechat-specialist | Platform APIs, 4MB package limit, physics engines (Box2D/Bullet/JoltPhysics via unified IPhysicsWorld interface), WASM integration, Spine/DragonBones animation runtimes |
| `wechat-shader-specialist` | WebGL Shaders | GLM-5v-Turbo | wechat-specialist | Custom shaders, WebGL 1.0/2.0, Unity/Unreal/Godot shader conversion to GLSL, post-processing effects, render pipeline standards |
| `wechat-ui-specialist` | UI/UX Design | GLM-5v-Turbo | wechat-specialist | Figma/Sketch prototyping, Photoshop/Illustrator asset production, FairyGUI layout with data binding, screen management, portrait-first design, WeChat design system compliance |
| `wechat-cloudbase-specialist` | Cloud Backend | DeepSeek-V3.2 | wechat-specialist | Serverless backend, database, cloud functions, storage, security rules, anti-cheat |

**Notes:**
- `wechat-specialist` is the Engine Lead for the WeChat platform, coordinating all sub-specialists
- WeChat Mini Game specialists use TypeScript (preferred) for all JavaScript code
- 4MB package size limit is strictly enforced
- Audio format: AAC preferred, MP3 fallback; avoid WAV and OGG
- Cloud Base provides serverless backend with MongoDB-like database
- Real-name verification (实名制) and anti-addiction (防沉迷) compliance required for China market
