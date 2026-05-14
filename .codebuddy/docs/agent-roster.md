# Agent Roster

The following agents are available. Each has a dedicated definition file in
`.codebuddy/agents/`. Use the agent best suited to the task at hand. When a task
spans multiple domains, the coordinating agent (usually `producer` or the
domain lead) should delegate to specialists.

## Tier 1 -- Leadership Agents (GLM-5.1)
| Agent | Domain | When to Use |
|-------|--------|-------------|
| `creative-director` | High-level vision | Major creative decisions, pillar conflicts, tone/direction |
| `technical-director` | Technical vision | Architecture decisions, tech stack choices, performance strategy |
| `producer` | Production management | Sprint planning, milestone tracking, risk management, coordination |

## Tier 2 -- Department Lead Agents (DeepSeek-V4-Flash)
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

## Tier 3 -- Specialist Agents (Kimi-k2.6 or MiniMax-M2.7)
| Agent | Domain | Model | When to Use |
|-------|--------|-------|-------------|
| `systems-designer` | Systems design | DeepSeek-V4-Flash | Specific mechanic implementation, formula design, loops |
| `level-designer` | Level design | Kimi-k2.6 | Level layouts, pacing, encounter design, flow |
| `economy-designer` | Economy/balance | DeepSeek-V4-Flash | Resource economies, loot tables, progression curves |
| `gameplay-programmer` | Gameplay code | DeepSeek-V4-Flash | Feature implementation, gameplay systems code |
| `engine-programmer` | Engine systems | DeepSeek-V4-Flash | Core engine, rendering, physics, memory management |
| `ai-programmer` | AI systems | DeepSeek-V4-Flash | Behavior trees, pathfinding, NPC logic, state machines |
| `network-programmer` | Networking | DeepSeek-V4-Flash | Netcode, replication, lag compensation, matchmaking |
| `tools-programmer` | Dev tools | DeepSeek-V4-Flash | Editor extensions, pipeline tools, debug utilities |
| `ui-programmer` | UI implementation | GLM-5v-Turbo | UI framework, screens, widgets, data binding |
| `technical-artist` | Tech art | GLM-5v-Turbo | Shaders, VFX, optimization, art pipeline tools |
| `sound-designer` | Sound design | MiniMax-M2.7 | SFX design docs, audio event lists, mixing notes |
| `writer` | Dialogue/lore | MiniMax-M2.7 | Dialogue writing, lore entries, item descriptions |
| `world-builder` | World/lore design | MiniMax-M2.7 | World rules, faction design, history, geography |
| `qa-tester` | Test execution | DeepSeek-V4-Flash | Writing test cases, bug reports, test checklists |
| `performance-analyst` | Performance | GLM-5.1 | Profiling, optimization recs, memory analysis |
| `devops-engineer` | Build/deploy | GLM-5.1 | CI/CD, build scripts, version control workflow |
| `analytics-engineer` | Telemetry | DeepSeek-V4-Flash | Event tracking, dashboards, A/B test design |
| `ux-designer` | UX flows | GLM-5.1 | User flows, wireframes, accessibility, input handling |
| `prototyper` | Rapid prototyping | DeepSeek-V4-Flash | Throwaway prototypes, mechanic testing, feasibility validation |
| `security-engineer` | Security | DeepSeek-V4-Flash | Anti-cheat, exploit prevention, save encryption, network security |
| `accessibility-specialist` | Accessibility | GLM-5v-Turbo | WCAG compliance, colorblind modes, remapping, text scaling |
| `live-ops-designer` | Live operations | DeepSeek-V4-Flash | Seasons, events, battle passes, retention, live economy |
| `community-manager` | Community | GLM-5.0-Turbo | Patch notes, player feedback, crisis comms, community health |

## Engine-Specific Agents (use the set matching your engine)

### Engine Leads

| Agent | Engine | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `unreal-specialist` | Unreal Engine 5 | DeepSeek-V4-Flash | Blueprint vs C++, GAS overview, UE subsystems, Unreal optimization |
| `unity-specialist` | Unity | DeepSeek-V4-Flash | MonoBehaviour vs DOTS, Addressables, URP/HDRP, Unity optimization |
| `godot-specialist` | Godot 4 | DeepSeek-V4-Flash | GDScript patterns, node/scene architecture, signals, Godot optimization |
| `cocos-specialist` | Cocos Creator | DeepSeek-V4-Flash | TypeScript, Node/UINode, component system, Cocos optimization  |


### Unreal Engine Sub-Specialists

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `ue-gas-specialist` | Gameplay Ability System | DeepSeek-V4-Flash | Abilities, gameplay effects, attribute sets, tags, prediction |
| `ue-blueprint-specialist` | Blueprint Architecture | GLM-5v-Turbo | BP/C++ boundary, graph standards, naming, BP optimization |
| `ue-replication-specialist` | Networking/Replication | GLM-5.1 | Property replication, RPCs, prediction, relevancy, bandwidth |
| `ue-umg-specialist` | UMG/CommonUI | DeepSeek-V4-Flash | Widget hierarchy, data binding, CommonUI input, UI performance |

### Unity Sub-Specialists

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `unity-dots-specialist` | DOTS/ECS | DeepSeek-V4-Flash | Entity Component System, Jobs, Burst compiler, hybrid renderer |
| `unity-shader-specialist` | Shaders/VFX | GLM-5.1 | Shader Graph, VFX Graph, URP/HDRP customization, post-processing |
| `unity-addressables-specialist` | Asset Management | DeepSeek-V4-Flash | Addressable groups, async loading, memory, content delivery |
| `unity-ui-specialist` | UI Toolkit/UGUI | GLM-5v-Turbo | UI Toolkit, UXML/USS, UGUI Canvas, data binding, cross-platform input |

### Godot Sub-Specialists

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `godot-gdscript-specialist` | GDScript | DeepSeek-V4-Flash | Static typing, design patterns, signals, coroutines, GDScript performance |
| `godot-csharp-specialist` | C# / .NET | DeepSeek-V4-Flash | .NET patterns, [Signal] delegates, async, nullable types, type-safe node access |
| `godot-shader-specialist` | Shaders/Rendering | GLM-5v-Turbo | Godot shading language, visual shaders, particles, post-processing |
| `godot-gdextension-specialist` | GDExtension | DeepSeek-V4-Flash | C++/Rust bindings, native performance, custom nodes, build systems |

### Cocos Creator Sub-Specialists

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `cocos_2d-expert` | 2D Rendering | DeepSeek-V4-Flash | Sprite, UI components, 2D graphics, text rendering, mask effects |
| `cocos_3d-expert` | 3D Rendering | DeepSeek-V4-Flash | Mesh rendering, skinned animation, model management, LOD |
| `cocos_animation-expert` | Animation System | DeepSeek-V4-Flash | Animation clips, skeletal animation, state machines, blending |
| `cocos_core-expert` | Core Engine | DeepSeek-V4-Flash | Component system, scene graph, lifecycle management, event system |
| `cocos_gfx-expert` | Graphics API | DeepSeek-V4-Flash | Shaders, GPU resources, cross-platform backends, rendering pipeline |
| `cocos_physics-expert` | 3D Physics | DeepSeek-V4-Flash | Rigid bodies, collision detection, raycasting, joints |
| `cocos_physics-2d-expert` | 2D Physics | DeepSeek-V4-Flash | Box2D integration, 2D collision detection, physics events |
| `cocos_rendering-expert` | Rendering Pipeline | DeepSeek-V4-Flash | Camera system, lighting, shadows, post-processing, optimization |

---
