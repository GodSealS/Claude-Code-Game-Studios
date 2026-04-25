---
name: team-ui
description: "Orchestrate the UI team through the full UX pipeline: from UX spec authoring through visual design, implementation, review, and polish. Integrates with /ux-design, /ux-review, and studio UX templates. / 编排 UI 团队完成完整 UX 管线：从 UX 规格编写到视觉设计、实现、审查和打磨。与 /ux-design、/ux-review 和工作室 UX 模板集成。"
argument-hint: "[UI feature description]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, AskUserQuestion, TodoWrite
---
When this skill is invoked, orchestrate the UI team through a structured pipeline.

> **中文翻译**：当调用此技能时，通过结构化管道编排 UI 团队。

**Decision Points:** At each phase transition, use `AskUserQuestion` to present
the user with the subagent's proposals as selectable options. Write the agent's
full analysis in conversation, then capture the decision with concise labels.
The user must approve before moving to the next phase.

> **中文翻译**：**决策点**：在每个阶段转换时，使用 `AskUserQuestion` 向用户呈现子代理的提案作为可选选项。在对话中写入代理的完整分析，然后用简洁的标签捕获决策。用户必须在进入下一阶段前批准。

## Team Composition / 团队组成
- **ux-designer** — User flows, wireframes, accessibility, input handling / 用户流程、线框图、无障碍、输入处理
- **ui-programmer** — UI framework, screens, widgets, data binding, implementation / UI 框架、屏幕、小部件、数据绑定、实现
- **art-director** — Visual style, layout polish, consistency with art bible / 视觉风格、布局打磨、与艺术圣经的一致性
- **engine UI specialist** — Validates UI implementation patterns against engine-specific best practices (read from `.codebuddy/docs/technical-preferences.md` Engine Specialists → UI Specialist) / 根据引擎特定最佳实践验证 UI 实现模式（从 `.codebuddy/docs/technical-preferences.md` Engine Specialists → UI Specialist 读取）
- **accessibility-specialist** — Audits accessibility compliance at Phase 4 / 在第 4 阶段审计无障碍合规性

**Templates used by this pipeline:**
- `ux-spec.md` — Standard screen/flow UX specification / 标准屏幕/流程 UX 规格
- `hud-design.md` — HUD-specific UX specification / HUD 特定 UX 规格
- `interaction-pattern-library.md` — Reusable interaction patterns / 可重用交互模式
- `accessibility-requirements.md` — Committed accessibility tier and requirements / 承诺的无障碍层级和要求

## How to Delegate / 如何委派

Use the Task tool to spawn each team member as a subagent:
- `subagent_type: ux-designer` — User flows, wireframes, accessibility, input handling / 用户流程、线框图、无障碍、输入处理
- `subagent_type: ui-programmer` — UI framework, screens, widgets, data binding / UI 框架、屏幕、小部件、数据绑定
- `subagent_type: art-director` — Visual style, layout polish, art bible consistency / 视觉风格、布局打磨、艺术圣经一致性
- `subagent_type: [UI engine specialist]` — Engine-specific UI pattern validation (e.g., unity-ui-specialist, ue-umg-specialist, godot-specialist) / 引擎特定 UI 模式验证（例如，unity-ui-specialist、ue-umg-specialist、godot-specialist）
- `subagent_type: accessibility-specialist` — Accessibility compliance audit / 无障碍合规性审计

Always provide full context in each agent's prompt (feature requirements, existing UI patterns, platform targets). Launch independent agents in parallel where the pipeline allows it (e.g., Phase 4 review agents can run simultaneously).

> **中文翻译**：始终在每个代理的提示中提供完整上下文（功能要求、现有 UI 模式、平台目标）。在管道允许的情况下并行启动独立代理（例如，第 4 阶段审查代理可以同时运行）。

## Pipeline / 管道

### Phase 1a: Context Gathering / 第 1a 阶段：上下文收集

Before designing anything, read and synthesize:
- `design/gdd/game-concept.md` — platform targets and intended audience / 平台目标和目标受众
- `design/player-journey.md` — player's state and context when they reach this screen / 玩家到达此屏幕时的状态和上下文
- All GDD UI Requirements sections relevant to this feature / 与此功能相关的所有 GDD UI 要求部分
- `design/ux/interaction-patterns.md` — existing patterns to reuse (not reinvent) / 要重用的现有模式（不要重新发明）
- `design/accessibility-requirements.md` — committed accessibility tier (e.g., Basic, Enhanced, Full) / 承诺的无障碍层级（例如，基本、增强、完整）

**If `design/ux/interaction-patterns.md` does not exist**, surface the gap immediately:
> "interaction-patterns.md does not exist — no existing patterns to reuse."

Then use `AskUserQuestion` with options:
- (a) Run `/ux-design patterns` first to establish the pattern library, then continue
- (b) Proceed without the pattern library — ui-programmer will treat all patterns created as new and add each to a new `design/ux/interaction-patterns.md` at completion

> **中文翻译**：**如果 `design/ux/interaction-patterns.md` 不存在**，立即呈现差距：
> > "interaction-patterns.md 不存在 — 没有现有模式可重用。"
> 
> 然后使用带选项的 `AskUserQuestion`：
> - (a) 先运行 `/ux-design patterns` 建立模式库，然后继续
> - (b) 在没有模式库的情况下继续 — ui-programmer 会将所有创建的模式视为新的，并在完成时将每个添加到新的 `design/ux/interaction-patterns.md` 中

Do NOT invent or assume patterns from the feature name or GDD alone. If the user chooses (b), explicitly instruct ui-programmer in Phase 3 to treat all patterns as new and document them in `design/ux/interaction-patterns.md` when implementation is complete. Note the pattern library status (created / absent / updated) in the final summary report.

> **中文翻译**：不要仅从功能名称或 GDD 发明或假设模式。如果用户选择 (b)，明确指示 Phase 3 中的 ui-programmer 将所有模式视为新的，并在实现完成时将其记录在 `design/ux/interaction-patterns.md` 中。在最终摘要报告中注明模式库状态（已创建/缺失/已更新）。

Summarize the context in a brief for the ux-designer: what the player is doing, what they need, what constraints apply, and which existing patterns are relevant.

> **中文翻译**：为 ux-designer 总结上下文简介：玩家在做什么、他们需要什么、适用哪些约束以及哪些现有模式相关。

### Phase 1b: UX Spec Authoring / 第 1b 阶段：UX 规格编写

Invoke `/ux-design [feature name]` skill OR delegate directly to ux-designer to produce `design/ux/[feature-name].md` following the `ux-spec.md` template.

> **中文翻译**：调用 `/ux-design [feature name]` 技能或直接委派给 ux-designer 以按照 `ux-spec.md` 模板生成 `design/ux/[feature-name].md`。

If designing the HUD, use the `hud-design.md` template instead of `ux-spec.md`.

> **中文翻译**：如果设计 HUD，使用 `hud-design.md` 模板而不是 `ux-spec.md`。

> **Notes on special cases:** / **关于特殊情况的说明：**
> - For HUD design specifically, invoke `/ux-design` with `argument: hud` (e.g., `/ux-design hud`). / 特别是 HUD 设计，使用 `argument: hud` 调用 `/ux-design`（例如，`/ux-design hud`）。
> - For the interaction pattern library, run `/ux-design patterns` once at project start and update it whenever new patterns are introduced during later phases. / 对于交互模式库，在项目开始时运行一次 `/ux-design patterns`，并在后续阶段引入新模式时随时更新。

Output: `design/ux/[feature-name].md` with all required spec sections filled. / 输出：填充了所有必需规格部分的 `design/ux/[feature-name].md`。

### Phase 1c: UX Review

After the spec is complete, invoke `/ux-review design/ux/[feature-name].md`.

**Gate**: Do not proceed to Phase 2 until the verdict is APPROVED. If the verdict is NEEDS REVISION, the ux-designer must address the flagged issues and re-run the review. The user may explicitly accept a NEEDS REVISION risk and proceed, but this must be a conscious decision — present the specific concerns via `AskUserQuestion` before asking whether to proceed.

### Phase 2: Visual Design

Delegate to **art-director**:
- Review the full UX spec (flows, wireframes, interaction patterns, accessibility notes) — not just the wireframe images
- Apply visual treatment from the art bible: colors, typography, spacing, animation style
- Check that visual design preserves accessibility compliance: verify color contrast ratios, and confirm color is never the only indicator of state (shape, text, or icon must reinforce it)
- Specify all asset requirements needed from the art pipeline: icons at specified sizes, background textures, fonts, decorative elements — with precise dimensions and format requirements
- Ensure consistency with existing implemented UI screens
- Output: visual design spec with style notes and asset manifest

### Phase 3: Implementation

Before implementation begins, spawn the **engine UI specialist** (from `.codebuddy/docs/technical-preferences.md` Engine Specialists → UI Specialist) to review the UX spec and visual design spec for engine-specific implementation guidance:
- Which engine UI framework should be used for this screen? (e.g., UI Toolkit vs UGUI in Unity, Control nodes vs CanvasLayer in Godot, UMG vs CommonUI in Unreal)
- Any engine-specific gotchas for the proposed layout or interaction patterns?
- Recommended widget/node structure for the engine?
- Output: engine UI implementation notes to hand off to ui-programmer before they begin

If no engine is configured, skip this step.

Delegate to **ui-programmer**:
- Implement the UI following the UX spec and visual design spec
- **Use patterns from `design/ux/interaction-patterns.md`** — do not reinvent patterns that are already specified. If a pattern almost fits but needs modification, note the deviation and flag it for ux-designer review.
- **UI NEVER owns or modifies game state** — display only; emit events for all player actions
- All text through the localization system — no hardcoded player-facing strings
- Support both input methods (keyboard/mouse AND gamepad)
- Implement accessibility features per the committed tier in `design/accessibility-requirements.md`
- Wire up data binding to game state
- **If any new interaction pattern is created during implementation** (i.e., something not already in the pattern library), add it to `design/ux/interaction-patterns.md` before marking implementation complete
- Output: implemented UI feature

### Phase 4: Review (parallel)

Delegate in parallel:
- **ux-designer**: Verify implementation matches wireframes and interaction spec. Test keyboard-only and gamepad-only navigation. Check accessibility features function correctly.
- **art-director**: Verify visual consistency with art bible. Check at minimum and maximum supported resolutions.
- **accessibility-specialist**: Verify compliance against the committed accessibility tier documented in `design/accessibility-requirements.md`. Flag any violations as blockers.

All three review streams must report before proceeding to Phase 5.

### Phase 5: Polish

- Address all review feedback
- Verify animations are skippable and respect the player's motion reduction preferences
- Confirm UI sounds trigger through the audio event system (no direct audio calls)
- Test at all supported resolutions and aspect ratios
- **Verify `design/ux/interaction-patterns.md` is up to date** — if any new patterns were introduced during this feature's implementation, confirm they have been added to the library
- **Confirm all HUD elements respect the visual budget** defined in `design/ux/hud.md` (element count, screen region allocations, maximum opacity values)

## Quick Reference — When to Use Which Skill / 快速参考 — 何时使用哪个技能

- `/ux-design` — Author a new UX spec for a screen, flow, or HUD from scratch / 从头开始编写屏幕、流程或 HUD 的新 UX 规格
- `/ux-review` — Validate a completed UX spec before implementation / 在实现前验证完成的 UX 规格
- `/team-ui [feature]` — Full pipeline from concept through polish (calls `/ux-design` and `/ux-review` internally) / 从概念到打磨的完整管道（内部调用 `/ux-design` 和 `/ux-review`）
- `/quick-design` — Small UI changes that don't need a full new UX spec / 不需要全新 UX 规格的小型 UI 更改

## Error Recovery Protocol

If any spawned agent (via Task) returns BLOCKED, errors, or cannot complete:

1. **Surface immediately**: Report "[AgentName]: BLOCKED — [reason]" to the user before continuing to dependent phases
2. **Assess dependencies**: Check whether the blocked agent's output is required by subsequent phases. If yes, do not proceed past that dependency point without user input.
3. **Offer options** via AskUserQuestion with choices:
   - Skip this agent and note the gap in the final report
   - Retry with narrower scope
   - Stop here and resolve the blocker first
4. **Always produce a partial report** — output whatever was completed. Never discard work because one agent blocked.

Common blockers:
- Input file missing (story not found, GDD absent) → redirect to the skill that creates it
- ADR status is Proposed → do not implement; run `/architecture-decision` first
- Scope too large → split into two stories via `/create-stories`
- Conflicting instructions between ADR and story → surface the conflict, do not guess

## File Write Protocol

All file writes (UX specs, interaction pattern library updates, implementation files) are
delegated to sub-agents and sub-skills (`/ux-design`, `ui-programmer`). Each enforces the
"May I write to [path]?" protocol. This orchestrator does not write files directly.

## Output

A summary report covering: UX spec status, UX review verdict, visual design status, implementation status, accessibility compliance, input method support, interaction pattern library update status, and any outstanding issues.

Verdict: **COMPLETE** — UI feature delivered through full pipeline (UX spec → visual → implementation → review → polish).
Verdict: **BLOCKED** — pipeline halted; surface the blocker and its phase before stopping.

## Next Steps

- Run `/ux-review` on the final spec if not yet approved.
- Run `/code-review` on the UI implementation before closing stories.
- Run `/team-polish` if visual or audio polish pass is needed.
