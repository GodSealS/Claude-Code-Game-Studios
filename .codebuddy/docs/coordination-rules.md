# Agent Coordination Rules

1. **Vertical Delegation**: Leadership agents delegate to department leads, who
   delegate to specialists. Never skip a tier for complex decisions.
2. **Horizontal Consultation**: Agents at the same tier may consult each other
   but must not make binding decisions outside their domain.
3. **Conflict Resolution**: When two agents disagree, escalate to the shared
   parent. If no shared parent, escalate to `creative-director` for design
   conflicts or `technical-director` for technical conflicts.
4. **Change Propagation**: When a design change affects multiple domains, the
   `producer` agent coordinates the propagation.
5. **No Unilateral Cross-Domain Changes**: An agent must never modify files
   outside its designated directories without explicit delegation.

## Model Tier Assignment

Skills and agents declare their `model:` directly in YAML frontmatter. The tiers
below describe the **target capability** of each model and the kinds of work
assigned to it. This file does NOT enforce routing — `models.config.yaml`
(`/setup-engine`, `codesquad config`) is the runtime override mechanism.

| Tier   | Model                | Used for                                                                                  |
|--------|----------------------|-------------------------------------------------------------------------------------------|
| **Haiku**  | `Deepseek-V4-Flash`  | Read-only status checks, formatting, simple lookups — no creative judgment needed     |
| **Sonnet** | `Deepseek-V4-Pro`    | Implementation, design authoring, analysis of individual systems — default for most work |
| **Opus**   | `GLM-5.1`            | Multi-document synthesis, high-stakes phase gate verdicts, cross-system holistic review |
| **Opus-alt** | `Kimi-K2.6`        | Creative vision, narrative depth, world design — alternative Opus-tier choice          |

**Specialty models** (vision / audio / tool-use — substituted for a tier above when
the task requires that capability):

| Capability | Model             | Agents                                                |
|------------|-------------------|-------------------------------------------------------|
| Vision     | `GLM-5v-Turbo`    | `art-director`, `technical-artist`, `accessibility-specialist` |
| Audio      | `GLM-5.0-Turbo`   | `community-manager`, `sound-designer`                 |
| Tool/UI    | `MiniMax-M3`      | `world-builder`, `ui-programmer`, `tools-programmer`, `network-programmer`, `security-engineer` |

**Tiers in practice** (typical frontmatter distribution):

- `Deepseek-V4-Flash` — engine specialists (`unreal-specialist`, `unity-specialist`,
  `godot-specialist`, `cocos-specialist`), `economy-designer`, `qa-tester`,
  `analytics-engineer`, `prototyper`, `live-ops-designer`, `localization-lead`.
  Plus ~25 read-only / formatting skills (`/help`, `/sprint-status`,
  `/changelog`, `/playtest-report`, etc.).
- `Deepseek-V4-Pro` — code-writing specialists (`gameplay-programmer`,
  `engine-programmer`, `ai-programmer`, `qa-lead`, `writer`, `systems-designer`,
  `test-foo`), plus design/analysis skills (`/design-system`, `/design-review`,
  `/dev-story`, `/review-all-gdds`, `/gate-check`, `/architecture-decision`, etc.).
- `GLM-5.1` — Tier-1 directors and high-stakes decision agents
  (`technical-director`, `release-manager`, `lead-programmer`, `devops-engineer`,
  `performance-analyst`, `ux-designer`).
- `Kimi-K2.6` — Tier-1 + Tier-2 creative leads (`creative-director`, `producer`,
  `game-designer`, `narrative-director`, `level-designer`).

> **Note**: Do NOT write `model: haiku` / `model: sonnet` / `model: opus` in
> frontmatter. The project uses concrete model names (e.g. `Deepseek-V4-Flash`).
> When `codesquad init` copies AICore to a third-party tool, the
> `codebuddyAdapter.getDefaultModels()` returns `{}` — AICore's original model
> names are preserved unchanged. See `docs/model-mapping-design.md` for the
> cross-tool mapping rules.

## Subagents vs Agent Teams

This project uses two distinct multi-agent patterns:

### Subagents (current, always active)
Spawned via `Task` within a single Claude Code session. Used by all `team-*` skills
and orchestration skills. Subagents share the session's permission context, run
sequentially or in parallel within the session, and return results to the parent.

**When to spawn in parallel**: If two subagents' inputs are independent (neither
needs the other's output to begin), spawn both Task calls simultaneously rather
than waiting. Example: `/review-all-gdds` Phase 1 (consistency) and Phase 2
(design theory) are independent — spawn both at the same time.

### Agent Teams (experimental — opt-in)
Multiple independent Claude Code *sessions* running simultaneously, coordinated
via a shared task list. Each session has its own context window and token budget.
Requires `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` environment variable.

**Use agent teams when**:
- Work spans multiple subsystems that will not touch the same files
- Each workstream would take >30 minutes and benefits from true parallelism
- A senior agent (technical-director, producer) needs to coordinate 3+ specialist
  sessions working on different epics simultaneously

**Do not use agent teams when**:
- One session's output is required as input for another (use sequential subagents)
- The task fits in a single session's context (use subagents instead)
- Cost is a concern — each team member burns tokens independently

**Current status**: Not yet used in this project. Document usage here when first adopted.

## Parallel Task Protocol

When an orchestration skill spawns multiple independent agents:

1. Issue all independent Task calls before waiting for any result
2. Collect all results before proceeding to dependent phases
3. If any agent is BLOCKED, surface it immediately — do not silently skip
4. Always produce a partial report if some agents complete and others block
