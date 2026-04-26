---
name: start
description: "First-time onboarding — asks where you are, then guides you to the right workflow. No assumptions. / 首次引导入门 — 询问你当前的状态，然后引导你到正确的工作流。不做任何假设。"
argument-hint: "[no arguments]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, AskUserQuestion
---

# Guided Onboarding / 引导式入门

This skill writes one file: `production/review-mode.txt` (review mode config set in Phase 3b).

This skill is the entry point for new users. It does NOT assume you have a game idea, an engine preference, or any prior experience. It asks first, then routes you to the right workflow.

> **中文翻译**：此技能写入一个文件：`production/review-mode.txt`（在阶段3b中设置的审查模式配置）。此技能是新用户的入口。它不假设你有游戏想法、引擎偏好或任何先前经验。它先询问，然后引导你到正确的工作流。

---

## Phase 1: Detect Project State / 第 1 阶段：检测项目状态

Before asking anything, silently gather context so you can tailor your guidance. Do NOT show these results unprompted — they inform your recommendations, not the conversation opener.

Check: / 检查：
- **Engine configured?** Read `.codebuddy/docs/technical-preferences.md`. If the Engine field contains `[TO BE CONFIGURED]`, the engine is not set. / **引擎已配置？** 读取 `.codebuddy/docs/technical-preferences.md`。如果引擎字段包含 `[TO BE CONFIGURED]`，则引擎未设置。
- **Game concept exists?** Check for `design/gdd/game-concept.md`. / **游戏概念存在？** 检查 `design/gdd/game-concept.md`。
- **Source code exists?** Glob for source files in `src/` (`*.gd`, `*.cs`, `*.cpp`, `*.h`, `*.rs`, `*.py`, `*.js`, `*.ts`). / **源代码存在？** 在 `src/` 中搜索源文件。
- **Prototypes exist?** Check for subdirectories in `prototypes/`. / **原型存在？** 检查 `prototypes/` 中的子目录。
- **Design docs exist?** Count markdown files in `design/gdd/`. / **设计文档存在？** 计算 `design/gdd/` 中的 Markdown 文件数。
- **Production artifacts?** Check for files in `production/sprints/` or `production/milestones/`. / **生产工件？** 检查 `production/sprints/` 或 `production/milestones/` 中的文件。

Store these findings internally to validate the user's self-assessment and tailor recommendations. / 在内部存储这些发现以验证用户的自我评估并定制建议。

---

## Phase 2: Ask Where the User Is / 第 2 阶段：询问用户所处阶段

This is the first thing the user sees. Use `AskUserQuestion` with these exact options so the user can click rather than type:

- **Prompt**: "Welcome to CodeBuddy Game Studios! Before I suggest anything, I'd like to understand where you're starting from. Where are you at with your game idea right now?"
- **Options**:
  - `A) No idea yet` — I don't have a game concept at all. I want to explore and figure out what to make.
  - `B) Vague idea` — I have a rough theme, feeling, or genre in mind (e.g., "something with space" or "a cozy farming game") but nothing concrete.
  - `C) Clear concept` — I know the core idea — genre, basic mechanics, maybe a pitch sentence — but haven't formalized it into documents yet.
  - `D) Existing work` — I already have design docs, prototypes, code, or significant planning done. I want to organize or continue the work.

Wait for the user's selection. Do not proceed until they respond.

---

## Phase 3: Route Based on Answer / 第 3 阶段：根据回答路由

<!-- 中文翻译 -->
#### If A: No idea yet

The user needs creative exploration before anything else.

1. Acknowledge that starting from zero is completely fine
2. Briefly explain what `/brainstorm` does (guided ideation using professional frameworks — MDA, player psychology, verb-first design). Mention that it has two modes: `/brainstorm open` for fully open exploration, or `/brainstorm [hint]` if they have even a vague theme (e.g., "space", "cozy", "horror").
3. Recommend running `/brainstorm open` as the next step, but invite them to use a hint if something comes to mind
4. Show the recommended path:
   **Concept phase:**
   - `/brainstorm open` — discover your game concept
   - `/setup-engine` — configure the engine (brainstorm will recommend one)
   - `/art-bible` — define visual identity (uses the Visual Identity Anchor brainstorm produces)
   - `/map-systems` — decompose the concept into systems
   - `/design-system` — author a GDD for each MVP system
   - `/review-all-gdds` — cross-system consistency check
   - `/gate-check` — validate readiness before architecture work
   **Architecture phase:**
   - `/create-architecture` — produce the master architecture blueprint and Required ADR list
   - `/architecture-decision (×N)` — record key technical decisions, following the Required ADR list
   - `/create-control-manifest` — compile decisions into an actionable rules sheet
   - `/architecture-review` — validate architecture coverage
   **Pre-Production phase:**
   - `/ux-design` — author UX specs for key screens (main menu, HUD, core interactions)
   - `/prototype` — build a throwaway prototype to validate the core mechanic
   - `/playtest-report (×1+)` — document each vertical slice playtest session
   - `/create-epics` — map systems to epics
   - `/create-stories` — break epics into implementable stories
   - `/sprint-plan` — plan the first sprint
   **Production phase:** → pick up stories with `/dev-story`

<!-- 中文翻译 -->
#### If B: Vague idea

1. Ask them to share their vague idea — even a few words is enough
2. Validate the idea as a starting point (don't judge or redirect)
3. Recommend running `/brainstorm [their hint]` to develop it
4. Show the recommended path:
   **Concept phase:**
   - `/brainstorm [hint]` — develop the idea into a full concept
   - `/setup-engine` — configure the engine
   - `/art-bible` — define visual identity (uses the Visual Identity Anchor brainstorm produces)
   - `/map-systems` — decompose the concept into systems
   - `/design-system` — author a GDD for each MVP system
   - `/review-all-gdds` — cross-system consistency check
   - `/gate-check` — validate readiness before architecture work
   **Architecture phase:**
   - `/create-architecture` — produce the master architecture blueprint and Required ADR list
   - `/architecture-decision (×N)` — record key technical decisions, following the Required ADR list
   - `/create-control-manifest` — compile decisions into an actionable rules sheet
   - `/architecture-review` — validate architecture coverage
   **Pre-Production phase:**
   - `/ux-design` — author UX specs for key screens (main menu, HUD, core interactions)
   - `/prototype` — build a throwaway prototype to validate the core mechanic
   - `/playtest-report (×1+)` — document each vertical slice playtest session
   - `/create-epics` — map systems to epics
   - `/create-stories` — break epics into implementable stories
   - `/sprint-plan` — plan the first sprint
   **Production phase:** → pick up stories with `/dev-story`

<!-- 中文翻译 -->
#### If C: Clear concept

1. Ask them to describe their concept in one sentence — genre and core mechanic. Use plain text, not AskUserQuestion (it's an open response).
2. Acknowledge the concept, then use `AskUserQuestion` to offer two paths:
   - **Prompt**: "How would you like to proceed?"
   - **Options**:
     - `Formalize it first` — Run `/brainstorm [concept]` to structure it into a proper game concept document
     - `Jump straight in` — Go to `/setup-engine` now and write the GDD manually afterward
3. Show the recommended path:
   **Concept phase:**
   - `/brainstorm` or `/setup-engine` — (their pick from step 2)
   - `/art-bible` — define visual identity (after brainstorm if run, or after concept doc exists)
   - `/design-review` — validate the concept doc
   - `/map-systems` — decompose the concept into individual systems
   - `/design-system` — author a GDD for each MVP system
   - `/review-all-gdds` — cross-system consistency check
   - `/gate-check` — validate readiness before architecture work
   **Architecture phase:**
   - `/create-architecture` — produce the master architecture blueprint and Required ADR list
   - `/architecture-decision (×N)` — record key technical decisions, following the Required ADR list
   - `/create-control-manifest` — compile decisions into an actionable rules sheet
   - `/architecture-review` — validate architecture coverage
   **Pre-Production phase:**
   - `/ux-design` — author UX specs for key screens (main menu, HUD, core interactions)
   - `/prototype` — build a throwaway prototype to validate the core mechanic
   - `/playtest-report (×1+)` — document each vertical slice playtest session
   - `/create-epics` — map systems to epics
   - `/create-stories` — break epics into implementable stories
   - `/sprint-plan` — plan the first sprint
   **Production phase:** → pick up stories with `/dev-story`

<!-- 中文翻译 -->
#### If D: Existing work

1. Share what you found in Phase 1:
   - "I can see you have [X source files / Y design docs / Z prototypes]..."
   - "Your engine is [configured as X / not yet configured]..."

2. **Sub-case D1 — Early stage** (engine not configured or only a game concept exists):
   - Recommend `/setup-engine` first if engine not configured
   - Then `/project-stage-detect` for a gap inventory

   **Sub-case D2 — GDDs, ADRs, or stories already exist:**
   - Explain: "Having files isn't the same as the template's skills being able to use them. GDDs might be missing required sections. `/adopt` checks this specifically."
   - Recommend:
     1. `/project-stage-detect` — understand what phase and what's missing entirely
     2. `/adopt` — audit whether existing artifacts are in the right internal format

3. Show the recommended path for D2:
   - `/project-stage-detect` — phase detection + existence gaps
   - `/adopt` — format compliance audit + migration plan
   - `/setup-engine` — if engine not configured
   - `/design-system retrofit [path]` — fill missing GDD sections
   - `/architecture-decision retrofit [path]` — add missing ADR sections
   - `/architecture-review` — bootstrap the TR requirement registry
   - `/gate-check` — validate readiness for next phase

---

## Phase 3b: Set Review Mode / 阶段 3b：设置审查模式

Check if `production/review-mode.txt` already exists.

**If it exists**: Read it and show the current mode — "Review mode is set to `[current]`." — then proceed to Phase 4. Do not ask again.

**If it does not exist**: Use `AskUserQuestion`:

- **Prompt**: "One setup choice: how much design review would you want as you work through the workflow?"
- **Options**:
  - `Full` — Director specialists review at each key workflow step. Best for teams, learning the workflow, or when you want thorough feedback on every decision.
  - `Lean (recommended)` — Directors only at phase gate transitions (/gate-check). Skips per-skill reviews. Balanced approach for solo devs and small teams.
  - `Solo` — No director reviews at all. Maximum speed. Best for game jams, prototypes, or if the reviews feel like overhead.

Write the choice to `production/review-mode.txt` immediately after the user
selects — no separate "May I write?" needed, as the write is a direct
consequence of the selection:
- `Full` → write `full`
- `Lean (recommended)` → write `lean`
- `Solo` → write `solo`

Create the `production/` directory if it does not exist.

---

## Phase 4: Confirm Before Proceeding / 第 4 阶段：继续前确认

After presenting the recommended path, use `AskUserQuestion` to ask the user which step they'd like to take first. Never auto-run the next skill.

- **Prompt**: "Would you like to start with [recommended first step]?"
- **Options**:
  - `Yes, let's start with [recommended first step]`
  - `I'd like to do something else first`

---

## Phase 5: Hand Off / 第 5 阶段：交接

When the user confirms their next step, respond with a single short line: "Type `[skill command]` to begin." Nothing else. Do not re-explain the skill or add encouragement. The `/start` skill's job is done.

Verdict: **COMPLETE** — user oriented and handed off to next step.

---

## Edge Cases / 边界情况

- **User picks D but project is empty**: Gently redirect — "It looks like the project is a fresh template with no artifacts yet. Would Path A or B be a better fit?"
- **User picks A but project has code**: Mention what you found — "I noticed there's already code in `src/`. Did you mean to pick D (existing work)?"
- **User is returning (engine configured, concept exists)**: Skip onboarding entirely — "It looks like you're already set up! Your engine is [X] and you have a game concept at `design/gdd/game-concept.md`. Review mode: `[read from production/review-mode.txt, or 'lean (default)' if missing]`. Want to pick up where you left off? Try `/sprint-plan` or just tell me what you'd like to work on."
- **User doesn't fit any option**: Let them describe their situation in their own words and adapt.

---

## Collaborative Protocol / 协作协议

1. **Ask first** — never assume the user's state or intent / **先询问** — 绝不假设用户的状态或意图
2. **Present options** — give clear paths, not mandates / **呈现选项** — 给出清晰路径，而非命令
3. **User decides** — they pick the direction / **用户决定** — 他们选择方向
4. **No auto-execution** — recommend the next skill, don't run it without asking / **不自动执行** — 推荐下一个技能，不未经询问就运行
5. **Adapt** — if the user's situation doesn't fit a template, listen and adjust / **适应** — 如果用户的情况不符合模板，倾听并调整
