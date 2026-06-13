# Agent Roster

The following agents are available. Each has a dedicated definition file in
`.codebuddy/agents/`. Use the agent best suited to the task at hand. When a task
spans multiple domains, the coordinating agent (usually `producer` or the
domain lead) should delegate to specialists.

Engine specialists use **Skills** (via `UseSkill()`) for subsystem knowledge instead of spawning sub-agents.

## Tier 1 -- Leadership Agents (GLM-5.1)
| Agent | Domain | When to Use |
|-------|--------|-------------|
| `creative-director` | High-level vision | Major creative decisions, pillar conflicts, tone/direction |
| `technical-director` | Technical vision | Architecture decisions, tech stack choices, performance strategy |
| `producer` | Production management | Sprint planning, milestone tracking, risk management, coordination |

## Tier 2 -- Department Lead Agents (Deepseek-V4-Flash)
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

## Tier 3 -- Specialist Agents (Kimi-K2.6 or MiniMax-M3)
| Agent | Domain | Model | When to Use |
|-------|--------|-------|-------------|
| `systems-designer` | Systems design | Deepseek-V4-Flash | Specific mechanic implementation, formula design, loops |
| `level-designer` | Level design | Kimi-K2.6 | Level layouts, pacing, encounter design, flow |
| `economy-designer` | Economy/balance | Deepseek-V4-Flash | Resource economies, loot tables, progression curves |
| `gameplay-programmer` | Gameplay code | Deepseek-V4-Flash | Feature implementation, gameplay systems code |
| `engine-programmer` | Engine systems | Deepseek-V4-Flash | Core engine, rendering, physics, memory management |
| `ai-programmer` | AI systems | Deepseek-V4-Flash | Behavior trees, pathfinding, NPC logic, state machines |
| `network-programmer` | Networking | Deepseek-V4-Flash | Netcode, replication, lag compensation, matchmaking |
| `tools-programmer` | Dev tools | Deepseek-V4-Flash | Editor extensions, pipeline tools, debug utilities |
| `ui-programmer` | UI implementation | GLM-5v-Turbo | UI framework, screens, widgets, data binding |
| `technical-artist` | Tech art | GLM-5v-Turbo | Shaders, VFX, optimization, art pipeline tools |
| `sound-designer` | Sound design | MiniMax-M2.7 | SFX design docs, audio event lists, mixing notes |
| `writer` | Dialogue/lore | MiniMax-M2.7 | Dialogue writing, lore entries, item descriptions |
| `world-builder` | World/lore design | MiniMax-M2.7 | World rules, faction design, history, geography |
| `qa-tester` | Test execution | Deepseek-V4-Flash | Writing test cases, bug reports, test checklists |
| `performance-analyst` | Performance | GLM-5.1 | Profiling, optimization recs, memory analysis |
| `devops-engineer` | Build/deploy | GLM-5.1 | CI/CD, build scripts, version control workflow |
| `analytics-engineer` | Telemetry | Deepseek-V4-Flash | Event tracking, dashboards, A/B test design |
| `ux-designer` | UX flows | GLM-5.1 | User flows, wireframes, accessibility, input handling |
| `prototyper` | Rapid prototyping | Deepseek-V4-Flash | Throwaway prototypes, mechanic testing, feasibility validation |
| `security-engineer` | Security | Deepseek-V4-Flash | Anti-cheat, exploit prevention, save encryption, network security |
| `accessibility-specialist` | Accessibility | GLM-5v-Turbo | WCAG compliance, colorblind modes, remapping, text scaling |
| `live-ops-designer` | Live operations | Deepseek-V4-Flash | Seasons, events, battle passes, retention, live economy |
| `community-manager` | Community | GLM-5.0-Turbo | Patch notes, player feedback, crisis comms, community health |

## Engine-Specific Agents (use the set matching your engine)

### Engine Leads (self-contained — uses Skills for subsystem knowledge)

| Agent | Engine | Skills Loaded |
| ---- | ---- | ---- |
| `unreal-specialist` | Unreal Engine 5 | `ue-gas`, `ue-blueprint`, `ue-replication`, `ue-umg` |
| `unity-specialist` | Unity | `unity-shader`, `unity-dots`, `unity-addressables`, `unity-ui` |
| `godot-specialist` | Godot 4 | `godot-gdscript`, `godot-csharp`, `godot-shader`, `godot-gdextension` |
| `cocos-specialist` | Cocos Creator | `cocos_2d`, `cocos_3d`, `cocos_animation`, `cocos_core`, `cocos_rendering`, `cocos_physics`, `cocos_physics-2d` |

---
