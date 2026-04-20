# Upgrading CodeBuddy Game Studios / 升级 CodeBuddy 游戏工作室

This guide covers upgrading your existing game project repo from one version
本指南介绍如何将您现有的游戏项目仓库从一个版本
of the template to the next.
升级到此模板的下一个版本。

**Find your current version** in your git log:
**在您的 git 日志中找到当前版本**：
```bash
git log --oneline | grep -i "release\|setup"
```
Or check `README.md` for the version badge.
或查看 `README.md` 中的版本徽章。

---

## Table of Contents / 目录

- [Upgrade Strategies / 升级策略](#upgrade-strategies)
- [v0.4.x → v1.0](#v04x--v10)
- [v0.4.0 → v0.4.1](#v040--v041)
- [v0.3.0 → v0.4.0](#v030--v040)
- [v0.2.0 → v0.3.0](#v020--v030)
- [v0.1.0 → v0.2.0](#v010--v020)

---

## Upgrade Strategies / 升级策略

There are three ways to pull in template updates. Choose based on how your
有三种方法可以拉取模板更新。根据您的仓库设置选择。
repo is set up.

### Strategy A — Git Remote Merge (recommended) / 策略 A — Git 远程合并（推荐）

Best when: you cloned the template and have your own commits on top of it.
最佳时机：您克隆了模板并在其上进行了自己的提交。

```bash
# Add the template as a remote (one-time setup) / 将模板添加为远程（一次性设置）
git remote add template https://github.com/Donchitos/Claude-Code-Game-Studios.git

# Fetch the new version / 获取新版本
git fetch template main

# Merge into your branch / 合并到您的分支
git merge template/main --allow-unrelated-histories
```

Git will flag conflicts only in files that both the template *and* you have
Git 将仅在模板和您都更改过的文件中标记冲突。
changed. Resolve each one — your game content goes in, structural improvements
解决每个冲突——您的游戏内容进入，结构改进随之而来。
come along for the ride. Then commit the merge.
然后提交合并。

**Tip:** The files most likely to conflict are `CLAUDE.md` and
**提示：**最可能冲突的文件是 `CLAUDE.md` 和
`.codebuddy/docs/technical-preferences.md`, because you've filled them in with
`.codebuddy/docs/technical-preferences.md`，因为您已用引擎和项目设置填写了它们。
your engine and project settings. Keep your content; accept the structural changes.
保留您的内容；接受结构更改。

---

### Strategy B — Cherry-pick specific commits / 策略 B — 挑选特定提交

Best when: you only want one specific feature (e.g., just the new skill, not
最佳时机：您只想要一个特定功能（例如，只要新技能，不要完整更新）。
the full update).

```bash
git remote add template https://github.com/Donchitos/Claude-Code-Game-Studios.git
git fetch template main

# Cherry-pick the specific commit(s) you want / 挑选您想要的特定提交
git cherry-pick <commit-sha>
```

Commit SHAs for each version are listed in the version sections below.
每个版本的提交 SHA 列在下面的版本章节中。

---

### Strategy C — Manual file copy / 策略 C — 手动文件复制

Best when: you didn't use git to set up the template (just downloaded a zip).
最佳时机：您没有使用 git 设置模板（只是下载了 zip）。

1. Download or clone the new version alongside your repo.
   在您的仓库旁边下载或克隆新版本。
2. Copy the files listed under **"Safe to overwrite"** directly.
   直接复制**"可安全覆盖"**下列出的文件。
3. For files under **"Merge carefully"**, open both versions side-by-side
   对于**"仔细合并"**下的文件，并排打开两个版本
   and manually merge the structural changes while keeping your content.
   并手动合并结构更改，同时保留您的内容。

---

## v0.4.1

**Released:** 2026-04-02 / **发布日期：**2026-04-02
**Key themes:** Art direction integration, asset specification pipeline / **核心主题：**美术指导集成、资源规范管线

### What Changed / 更改内容

| Category / 类别 | Changes / 更改 |
|----------|---------|
| **New skill / 新技能** | `/art-bible` — guided section-by-section visual identity authoring (9 sections). Mandatory art-director Task spawn per section. AD-ART-BIBLE sign-off gate. Required at Technical Setup phase. / 分章节引导式视觉识别编写（9 个章节）。每个章节强制生成 art-director 任务。AD-ART-BIBLE 签字关卡。技术设置阶段必需。 |
| **New skill / 新技能** | `/asset-spec` — per-asset visual spec and AI generation prompt generator. Reads art bible + GDD/level/character docs. Writes `design/assets/specs/` files and `design/assets/asset-manifest.md`. Full/lean/solo modes. / 每个资源的视觉规范和 AI 生成提示生成器。读取美术圣经 + GDD/关卡/角色文档。写入 `design/assets/specs/` 文件和 `design/assets/asset-manifest.md`。完整/精简/单独模式。 |
| **New director gates (3) / 新总监关卡 (3)** | `AD-CONCEPT-VISUAL` (brainstorm Phase 4), `AD-ART-BIBLE` (art bible sign-off), `AD-PHASE-GATE` (gate-check panel) / AD-概念视觉（头脑风暴第 4 阶段）、AD-美术圣经（美术圣经签字）、AD-阶段关卡（关卡检查面板） |
| **`/brainstorm` update** | Added `Task` to allowed-tools (was missing — blocked all director spawning). Art-director now spawns in parallel with creative-director after pillars lock. Visual Identity Anchor written to game-concept.md. / 添加 `Task` 到允许的工具（缺失——阻止了所有总监生成）。支柱锁定后，art-director 现在与 creative-director 并行生成。视觉识别锚点写入 game-concept.md。 |
| **`/gate-check` update** | Art-director added as 4th parallel director (AD-PHASE-GATE). Visual artifact checks: Visual Identity Anchor (Concept gate), art bible (Technical Setup gate), AD-ART-BIBLE sign-off + character visual profiles (Pre-Production gate). / Art-director 添加为第 4 个并行总监（AD-PHASE-GATE）。视觉工件检查：视觉识别锚点（概念关卡）、美术圣经（技术设置关卡）、AD-ART-BIBLE 签字 + 角色视觉档案（预生产关卡）。 |
| **`/team-level` update** | Art-director added to Step 1 parallel spawn (visual direction before layout). Level-designer now receives art-director targets as explicit constraints. Step 4 art-director role corrected to production-concepts only. / Art-director 添加到第 1 步并行生成（布局前的视觉指导）。关卡设计师现在接收 art-director 目标作为显式约束。第 4 步 art-director 角色更正为仅生产概念。 |
| **`/team-narrative` update** | Art-director added to Phase 2 parallel spawn (character visual design, environmental storytelling, cinematic tone). / Art-director 添加到第 2 阶段并行生成（角色视觉设计、环境叙事、电影色调）。 |
| **`/design-system` update** | Routing table expanded with art-director + technical-artist for Combat, UI, Dialogue, Animation/VFX, Character categories. Visual/Audio section now mandatory (with art-director Task spawn) for 7 system categories. / 路由表扩展，添加了 art-director + technical-artist 用于战斗、UI、对话、动画/VFX、角色类别。视觉/音频章节现在对 7 个系统类别是强制的（带有 art-director 任务生成）。 |
| **`workflow-catalog.yaml`** | `/art-bible` added to Technical Setup (required). `/asset-spec` added to Pre-Production (optional, repeatable). / `/art-bible` 添加到技术设置（必需）。`/asset-spec` 添加到预生产（可选，可重复）。 |

### Files: Safe to Overwrite / 文件：可安全覆盖

**New files to add:**
**要添加的新文件：**
```
.codebuddy/skills/art-bible/SKILL.md
.codebuddy/skills/asset-spec/SKILL.md
.codebuddy/docs/director-gates.md
```

**Existing files to overwrite (no user content):**
**要覆盖的现有文件（无用户内容）：**
```
.codebuddy/skills/brainstorm/SKILL.md
.codebuddy/skills/gate-check/SKILL.md
.codebuddy/skills/team-level/SKILL.md
.codebuddy/skills/team-narrative/SKILL.md
.codebuddy/skills/design-system/SKILL.md
.codebuddy/docs/workflow-catalog.yaml
README.md
UPGRADING.md
```

### Files: Merge Carefully / 文件：仔细合并

None — all changes are to infrastructure files with no user content.
无——所有更改都是针对无用户内容的基础设施文件。

---

## v0.4.x → v1.0

**Released:** 2026-03-29 / **发布日期：**2026-03-29
**Commit range:** `6c041ac..HEAD` / **提交范围：**
**Key themes:** Director gates system, gate intensity modes, Godot C# specialist / **核心主题：**总监关卡系统、关卡强度模式、Godot C# 专家

### What Changed / 更改内容

| Category / 类别 | Changes / 更改 |
|----------|---------|
| **New system / 新系统** | Director gates — named review checkpoints shared across all workflow skills. Defined in `.codebuddy/docs/director-gates.md` / 总监关卡 — 跨所有工作流技能共享的命名审查检查点。在 `.codebuddy/docs/director-gates.md` 中定义 |
| **New feature / 新功能** | Gate intensity modes: `full` (all director gates), `lean` (phase gates only), `solo` (no directors). Set globally via `production/review-mode.txt` during `/start`, or override per-run with `--review [mode]` on any gate-using skill / 关卡强度模式：完整（所有总监关卡）、精简（仅阶段关卡）、单独（无总监）。在 `/start` 期间通过 `production/review-mode.txt` 全局设置，或在任何使用关卡的技能上使用 `--review [mode]` 覆盖每次运行 |
| **New agent / 新代理** | `godot-csharp-specialist` — C# code quality in Godot 4 projects / Godot 4 项目中的 C# 代码质量 |
| **Skill updates (13) / 技能更新 (13)** | All gate-using skills now parse `--review [full\|lean\|solo]` and include it in their argument-hint: `brainstorm`, `map-systems`, `design-system`, `architecture-decision`, `create-architecture`, `create-epics`, `create-stories`, `sprint-plan`, `milestone-review`, `playtest-report`, `prototype`, `story-done`, `gate-check` / 所有使用关卡的技能现在解析 `--review [full\|lean\|solo]` 并将其包含在其参数提示中 |
| **`/start` update** | Added Phase 3b — sets review mode during onboarding, writes `production/review-mode.txt` / 添加阶段 3b — 在入门期间设置审查模式，写入 `production/review-mode.txt` |
| **`/setup-engine` update** | Language selection step for Godot (GDScript vs C#) / Godot 的语言选择步骤（GDScript vs C#） |
| **Docs / 文档** | `director-gates.md` — full gate catalog; `WORKFLOW-GUIDE.md` — Director Review Modes section; `README.md` — review intensity customization / 完整关卡目录；总监审查模式章节；审查强度自定义 |

---

### Files: Safe to Overwrite / 文件：可安全覆盖

**New files to add:**
**要添加的新文件：**
```
.codebuddy/agents/godot-csharp-specialist.md
.codebuddy/docs/director-gates.md
```

**Existing files to overwrite (no user content):**
**要覆盖的现有文件（无用户内容）：**
```
.codebuddy/skills/brainstorm/SKILL.md
.codebuddy/skills/map-systems/SKILL.md
.codebuddy/skills/design-system/SKILL.md
.codebuddy/skills/architecture-decision/SKILL.md
.codebuddy/skills/create-architecture/SKILL.md
.codebuddy/skills/create-epics/SKILL.md
.codebuddy/skills/create-stories/SKILL.md
.codebuddy/skills/sprint-plan/SKILL.md
.codebuddy/skills/milestone-review/SKILL.md
.codebuddy/skills/playtest-report/SKILL.md
.codebuddy/skills/prototype/SKILL.md
.codebuddy/skills/story-done/SKILL.md
.codebuddy/skills/gate-check/SKILL.md
.codebuddy/skills/start/SKILL.md
.codebuddy/skills/quick-design/SKILL.md
.codebuddy/skills/setup-engine/SKILL.md
README.md
docs/WORKFLOW-GUIDE.md
UPGRADING.md
```

---

### Files: Merge Carefully / 文件：仔细合并

No files require manual merging in this release. All changes are to infrastructure files with no user content.
此版本不需要手动合并文件。所有更改都是针对无用户内容的基础设施文件。

---

### New Features / 新功能

#### Director Gates System / 总监关卡系统

All major workflow skills now reference named gate checkpoints defined in
所有主要工作流技能现在引用在 `.codebuddy/docs/director-gates.md` 中定义的命名关卡检查点。
`.codebuddy/docs/director-gates.md`. Gates are identified by domain prefix and name
关卡由域前缀和名称标识
(e.g., `CD-CONCEPT`, `TD-ARCHITECTURE`, `LP-CODE-REVIEW`). Each gate defines
（例如，`CD-CONCEPT`、`TD-ARCHITECTURE`、`LP-CODE-REVIEW`）。每个关卡定义
which director to spawn, what inputs to pass, what verdicts mean, and how
要生成哪个总监、传递什么输入、裁决意味着什么，以及精简/单独模式如何影响它。
lean/solo modes affect it.

Skills spawn gates using `Task` with the gate ID and documented inputs, rather
技能使用 `Task` 和关卡 ID 及记录的输入生成关卡，而不是内联嵌入总监提示。
than embedding director prompts inline. This keeps skill bodies clean and makes
这使技能主体保持简洁，并使所有工作流阶段的关卡行为保持一致。
gate behavior consistent across all workflow phases.

#### Gate Intensity Modes / 关卡强度模式

Three modes let you control how much director review you get:
三种模式让您控制获得多少总监审查：

- **`full`** (default) — all director gates run at every review checkpoint / 所有总监关卡在每个审查检查点运行
- **`lean`** — per-skill director reviews are skipped; phase gates at `/gate-check` still run / 跳过每项技能的总监审查；`/gate-check` 的阶段关卡仍然运行
- **`solo`** — no director gates anywhere; `/gate-check` checks artifact existence only / 任何地方都没有总监关卡；`/gate-check` 仅检查工件存在

Set globally during `/start` (writes `production/review-mode.txt`). Override any
在 `/start` 期间全局设置（写入 `production/review-mode.txt`）。使用 `--review [mode]` 在任何使用关卡的技能上覆盖任何单个运行：
individual run with `--review [mode]` on any gate-using skill:

```
/design-system combat --review lean
/gate-check concept --review full
/brainstorm my-game-idea --review solo
```

---

### After Upgrading / 升级后

1. Run `/start` once to set your preferred review mode — or create `production/review-mode.txt` manually with `full`, `lean`, or `solo`.
   运行 `/start` 一次以设置您首选的审查模式 — 或使用 `full`、`lean` 或 `solo` 手动创建 `production/review-mode.txt`。
2. If you're mid-project, review `.codebuddy/docs/director-gates.md` to understand which gates apply to your current phase.
   如果您处于项目中期，请查看 `.codebuddy/docs/director-gates.md` 以了解哪些关卡适用于您当前阶段。
3. Run `/skill-test static all` to verify all skills pass structural checks.
   运行 `/skill-test static all` 以验证所有技能通过结构检查。

---

## v0.4.0 → v0.4.1

**Released:** 2026-03-26 / **发布日期：**2026-03-26
**Commit range:** `04ed5d5..HEAD` / **提交范围：**
**Key themes:** Genre-agnostic agents, new skills, skill fixes / **核心主题：**类型无关代理、新技能、技能修复

### What Changed / 更改内容

| Category / 类别 | Changes / 更改 |
|----------|---------|
| **New skills (1) / 新技能 (1)** | `/consistency-check` — cross-GDD entity consistency scanner / 跨 GDD 实体一致性扫描器 |
| **Skill fixes (all team-*) / 技能修复（所有 team-*）** | Added no-argument guards, formal `Verdict: COMPLETE / BLOCKED` keywords, per-step AskUserQuestion gates, adjacent area dependency checks (team-level), ethics enforcement (team-live-ops), NO-GO path with Phase skip (team-release) / 添加无参数守卫、正式 `Verdict: COMPLETE / BLOCKED` 关键字、每步 AskUserQuestion 关卡、相邻区域依赖检查、伦理执行、NO-GO 路径 |
| **Agent fixes (4) / 代理修复 (4)** | Genre-agnostic language in game-designer, systems-designer, economy-designer, live-ops-designer — removed RPG-specific terms / game-designer、systems-designer、economy-designer、live-ops-designer 中的类型无关语言 — 移除了 RPG 特定术语 |

---

### Files: Safe to Overwrite / 文件：可安全覆盖

**New files to add:**
**要添加的新文件：**
```
.codebuddy/skills/consistency-check/SKILL.md
```

**Existing files to overwrite (no user content):**
**要覆盖的现有文件（无用户内容）：**
```
.codebuddy/skills/team-combat/SKILL.md      ← no-arg guard, verdict keywords, gate improvements / 无参数守卫、裁决关键字、关卡改进
.codebuddy/skills/team-narrative/SKILL.md   ← no-arg guard, verdict keywords, gate improvements / 无参数守卫、裁决关键字、关卡改进
.codebuddy/skills/team-ui/SKILL.md          ← no-arg guard, verdict keywords, gate improvements / 无参数守卫、裁决关键字、关卡改进
.codebuddy/skills/team-release/SKILL.md     ← no-arg guard, verdict keywords, NO-GO path / 无参数守卫、裁决关键字、NO-GO 路径
.codebuddy/skills/team-polish/SKILL.md      ← no-arg guard, verdict keywords, gate improvements / 无参数守卫、裁决关键字、关卡改进
.codebuddy/skills/team-audio/SKILL.md       ← no-arg guard, verdict keywords, gate improvements / 无参数守卫、裁决关键字、关卡改进
.codebuddy/skills/team-level/SKILL.md       ← no-arg guard, verdict keywords, adjacent area checks / 无参数守卫、裁决关键字、相邻区域检查
.codebuddy/skills/team-live-ops/SKILL.md    ← no-arg guard, verdict keywords, ethics enforcement / 无参数守卫、裁决关键字、伦理执行
.codebuddy/skills/team-qa/SKILL.md          ← no-arg guard, verdict keywords, gate improvements / 无参数守卫、裁决关键字、关卡改进
.codebuddy/skills/map-systems/SKILL.md      ← verdict keywords / 裁决关键字
.codebuddy/skills/create-epics/SKILL.md     ← "May I write" protocol fix, verdict keywords / "我可以写" 协议修复、裁决关键字
.codebuddy/skills/create-stories/SKILL.md   ← verdict keywords / 裁决关键字
.codebuddy/agents/game-designer.md          ← genre-agnostic language / 类型无关语言
.codebuddy/agents/systems-designer.md       ← genre-agnostic language / 类型无关语言
.codebuddy/agents/economy-designer.md       ← genre-agnostic language / 类型无关语言
.codebuddy/agents/live-ops-designer.md      ← genre-agnostic language / 类型无关语言
```

---

### Files: Merge Carefully / 文件：仔细合并

No files require manual merging in this release. All changes are to infrastructure files with no user content.
此版本不需要手动合并文件。所有更改都是针对无用户内容的基础设施文件。

---

### After Upgrading / 升级后

1. Run `/skill-test catalog` to verify all skills are indexed.
   运行 `/skill-test catalog` 以验证所有技能都已索引。
2. Run `/skill-test lint [skill-name]` after any skill edits to check structural compliance.
   任何技能编辑后运行 `/skill-test lint [skill-name]` 以检查结构合规性。
3. If you've customized any team-* skills, review the updated versions — no-argument guard and `Verdict:` keywords are now required for all team-* skills.
   如果您自定义了任何 team-* 技能，请查看更新版本 — 无参数守卫和 `Verdict:` 关键字现在对所有 team-* 技能都是必需的。

---

## v0.3.0 → v0.4.0

**Released:** 2026-03-21 / **发布日期：**2026-03-21
**Commit range:** `b1cad29..HEAD` / **提交范围：**
**Key themes:** Full UX/UI pipeline, complete story lifecycle, brownfield adoption, comprehensive QA/testing framework, pipeline integrity, 29 new skills / **核心主题：**完整 UX/UI 管线、完整故事生命周期、棕地采用、综合 QA/测试框架、管线完整性、29 个新技能

### What Changed / 更改内容

| Category / 类别 | Changes / 更改 |
|----------|---------|
| **New skills (17) / 新技能 (17)** | `/ux-design`, `/ux-review`, `/help`, `/quick-design`, `/review-all-gdds`, `/story-readiness`, `/story-done`, `/sprint-status`, `/adopt`, `/create-architecture`, `/create-control-manifest`, `/create-epics`, `/create-stories`, `/dev-story`, `/propagate-design-change`, `/content-audit`, `/architecture-review` |
| **New skills QA (12) / 新 QA 技能 (12)** | `/qa-plan`, `/smoke-check`, `/soak-test`, `/regression-suite`, `/test-setup`, `/test-helpers`, `/test-evidence-review`, `/test-flakiness`, `/skill-test`, `/bug-triage`, `/team-live-ops`, `/team-qa` |
| **New hooks (4) / 新钩子 (4)** | `log-agent-stop.sh` — agent audit trail stop; `notify.sh` — Windows toast notifications; `post-compact.sh` — session recovery reminder after compaction; `validate-skill-change.sh` — advises `/skill-test` after skill edits / 代理审计跟踪停止；Windows toast 通知；压缩后的会话恢复提醒；技能编辑后建议 `/skill-test` |
| **New templates (8) / 新模板 (8)** | `ux-spec.md`, `hud-design.md`, `accessibility-requirements.md`, `interaction-pattern-library.md`, `player-journey.md`, `difficulty-curve.md`, and 2 adoption plan templates / 和 2 个采用计划模板 |
| **New infrastructure / 新基础设施** | `workflow-catalog.yaml` (7-phase pipeline, read by `/help`), `docs/architecture/tr-registry.yaml` (stable TR-IDs), `production/sprint-status.yaml` schema / 7 阶段管线、稳定的 TR-ID、sprint-status.yaml 模式 |
| **Skill updates / 技能更新** | `/gate-check` — 3 gates now require UX artifacts; Pre-Production gate requires vertical slice (HARD gate) / 3 个关卡现在需要 UX 工件；预生产关卡需要垂直切片（硬关卡） |
| **Skill updates / 技能更新** | `/sprint-plan` — writes `sprint-status.yaml`; `/sprint-status` reads it / 写入 sprint-status.yaml；读取它 |
| **Skill updates / 技能更新** | `/story-done` — 8-phase completion review, updates story file, surfaces next ready story / 8 阶段完成审查、更新故事文件、显示下一个就绪故事 |
| **Skill updates / 技能更新** | `/design-review` — removed architecture gap check (wrong stage) / 移除架构缺口检查（错误阶段） |
| **Skill updates / 技能更新** | `/team-ui` — full UX pipeline (ux-design → ux-review → team phases) / 完整 UX 管线 |
| **Agent updates / 代理更新** | 14 specialist agents — `memory: project` added / 14 个专业代理 — 添加 `memory: project` |
| **Agent updates / 代理更新** | `prototyper` — `isolation: worktree` (throwaway work in isolated git branch) / 隔离工作树（在隔离的 git 分支中可丢弃工作） |
| **Model routing / 模型路由** | Haiku/Sonnet/Opus tier assignments documented in coordination rules; skills declare their tier in frontmatter / Haiku/Sonnet/Opus 层级分配记录在协调规则中；技能在前言中声明其层级 |
| **Directory CLAUDE.md / 目录 CLAUDE.md** | Scaffolded `design/CLAUDE.md`, `src/CLAUDE.md`, `docs/CLAUDE.md` — path-scoped instructions for each directory / 为每个目录搭建的路径范围说明 |
| **Pipeline integrity / 管线完整性** | TR-ID stability, manifest versioning, ADR status gates, TR-ID reference not quote / TR-ID 稳定性、清单版本控制、ADR 状态关卡 |
| **GDD template / GDD 模板** | `## Game Feel` section added (input responsiveness, animation targets, impact moments) / 添加游戏感觉章节（输入响应、动画目标、冲击时刻） |

---

### Files: Safe to Overwrite / 文件：可安全覆盖

**New files to add:**
**要添加的新文件：**
```
.codebuddy/skills/ux-design/SKILL.md
.codebuddy/skills/ux-review/SKILL.md
.codebuddy/skills/help/SKILL.md
.codebuddy/skills/quick-design/SKILL.md
.codebuddy/skills/review-all-gdds/SKILL.md
.codebuddy/skills/story-readiness/SKILL.md
.codebuddy/skills/story-done/SKILL.md
.codebuddy/skills/sprint-status/SKILL.md
.codebuddy/skills/adopt/SKILL.md
.codebuddy/skills/create-architecture/SKILL.md
.codebuddy/skills/create-control-manifest/SKILL.md
.codebuddy/skills/create-epics/SKILL.md
.codebuddy/skills/create-stories/SKILL.md
.codebuddy/skills/dev-story/SKILL.md
.codebuddy/skills/propagate-design-change/SKILL.md
.codebuddy/skills/content-audit/SKILL.md
.codebuddy/skills/architecture-review/SKILL.md
.codebuddy/skills/qa-plan/SKILL.md
.codebuddy/skills/smoke-check/SKILL.md
.codebuddy/skills/soak-test/SKILL.md
.codebuddy/skills/regression-suite/SKILL.md
.codebuddy/skills/test-setup/SKILL.md
.codebuddy/skills/test-helpers/SKILL.md
.codebuddy/skills/test-evidence-review/SKILL.md
.codebuddy/skills/test-flakiness/SKILL.md
.codebuddy/skills/skill-test/SKILL.md
.codebuddy/skills/bug-triage/SKILL.md
.codebuddy/skills/team-live-ops/SKILL.md
.codebuddy/skills/team-qa/SKILL.md
.codebuddy/hooks/log-agent-stop.sh
.codebuddy/hooks/notify.sh
.codebuddy/hooks/post-compact.sh
.codebuddy/hooks/validate-skill-change.sh
.codebuddy/docs/workflow-catalog.yaml
.codebuddy/docs/templates/ux-spec.md
.codebuddy/docs/templates/hud-design.md
.codebuddy/docs/templates/accessibility-requirements.md
.codebuddy/docs/templates/interaction-pattern-library.md
.codebuddy/docs/templates/player-journey.md
.codebuddy/docs/templates/difficulty-curve.md
design/CLAUDE.md
src/CLAUDE.md
docs/CLAUDE.md
```

**Existing files to overwrite (no user content):**
**要覆盖的现有文件（无用户内容）：**
```
.codebuddy/skills/gate-check/SKILL.md
.codebuddy/skills/sprint-plan/SKILL.md
.codebuddy/skills/sprint-status/SKILL.md
.codebuddy/skills/design-review/SKILL.md
.codebuddy/skills/team-ui/SKILL.md
.codebuddy/skills/story-readiness/SKILL.md
.codebuddy/skills/story-done/SKILL.md
.codebuddy/docs/templates/game-design-document.md    ← adds Game Feel section / 添加游戏感觉章节
README.md
docs/WORKFLOW-GUIDE.md
UPGRADING.md
```

**Agent files to overwrite** (if you haven't written custom prompts into them):
**要覆盖的代理文件**（如果您没有在其中编写自定义提示）：
```
.codebuddy/agents/prototyper.md         ← adds isolation: worktree / 添加隔离：工作树
.codebuddy/agents/art-director.md       ← adds memory: project / 添加记忆：项目
.codebuddy/agents/audio-director.md     ← adds memory: project / 添加记忆：项目
.codebuddy/agents/economy-designer.md   ← adds memory: project / 添加记忆：项目
.codebuddy/agents/game-designer.md      ← adds memory: project / 添加记忆：项目
.codebuddy/agents/gameplay-programmer.md ← adds memory: project / 添加记忆：项目
.codebuddy/agents/lead-programmer.md    ← adds memory: project / 添加记忆：项目
.codebuddy/agents/level-designer.md     ← adds memory: project / 添加记忆：项目
.codebuddy/agents/narrative-director.md ← adds memory: project / 添加记忆：项目
.codebuddy/agents/systems-designer.md   ← adds memory: project / 添加记忆：项目
.codebuddy/agents/technical-artist.md   ← adds memory: project / 添加记忆：项目
.codebuddy/agents/ui-programmer.md      ← adds memory: project / 添加记忆：项目
.codebuddy/agents/ux-designer.md        ← adds memory: project / 添加记忆：项目
.codebuddy/agents/world-builder.md      ← adds memory: project / 添加记忆：项目
```

---

### Files: Merge Carefully / 文件：仔细合并

#### `.codebuddy/settings.json`

Four new hooks are registered in this version. If you haven't customized `settings.json`, overwriting is safe. Otherwise, add the following hook entries manually:
此版本注册了四个新钩子。如果您没有自定义 `settings.json`，覆盖是安全的。否则，手动添加以下钩子条目：

- `log-agent-stop.sh` — `SubagentStop` event (agent audit trail stop) / 代理审计跟踪停止
- `notify.sh` — `Notification` event (Windows toast notification) / Windows toast 通知
- `post-compact.sh` — `PostCompact` event (session recovery reminder) / 会话恢复提醒
- `validate-skill-change.sh` — `PostToolUse` event filtered to `.codebuddy/skills/` writes / 过滤到 `.codebuddy/skills/` 写入的 PostToolUse 事件

#### Customized agent files / 自定义代理文件

If you've added project-specific knowledge to agent `.md` files, do a diff and manually add the `memory: project` line to the YAML frontmatter where appropriate. Creative and technical director agents intentionally keep `memory: user` — only specialist agents get `memory: project`.
如果您已向代理 `.md` 文件添加了项目特定知识，请进行差异比较并手动在适当位置将 `memory: project` 行添加到 YAML 前言。创意总监和技术总监代理故意保持 `memory: user` — 只有专业代理获得 `memory: project`。

---

### New Features / 新功能

#### Complete Story Lifecycle / 完整故事生命周期

Stories now have a formal lifecycle enforced by two skills:
故事现在有两个技能强制执行的正式生命周期：

- **`/story-readiness`** — validates a story is implementation-ready before a developer picks it up. Checks Design (GDD req linked), Architecture (ADR accepted), Scope (criteria testable), and DoD (manifest version current). Verdict: READY / NEEDS WORK / BLOCKED. / 验证故事在开发人员接手之前是否已准备好实施。检查设计（GDD 需求链接）、架构（ADR 接受）、范围（标准可测试）和 DoD（清单版本当前）。裁决：就绪/需要工作/阻塞。
- **`/story-done`** — 8-phase completion review after implementation. Verifies each acceptance criterion, checks for GDD/ADR deviations, prompts code review, updates the story file to `Status: Complete`, and surfaces the next ready story. / 实施后的 8 阶段完成审查。验证每个验收标准、检查 GDD/ADR 偏差、提示代码审查、将故事文件更新为 `Status: Complete` 并显示下一个就绪故事。

Flow: `/story-readiness` → implement → `/story-done` → next story
流程：`/story-readiness` → 实施 → `/story-done` → 下一个故事

#### Full UX/UI Pipeline / 完整 UX/UI 管线

- **`/ux-design`** — guided section-by-section UX spec authoring. Three modes: screen/flow, HUD, or interaction pattern library. Reads GDD UI requirements and player journey. Output to `design/ux/`. / 分章节引导式 UX 规范编写。三种模式：屏幕/流程、HUD 或交互模式库。读取 GDD UI 需求和玩家旅程。输出到 `design/ux/`。
- **`/ux-review`** — validates UX specs against GDD alignment, accessibility tier, and pattern library. Verdict: APPROVED / NEEDS REVISION / MAJOR REVISION. / 根据 GDD 对齐、无障碍层级和模式库验证 UX 规范。裁决：批准/需要修订/重大修订。
- **`/team-ui` updated:** Phase 1 now runs `/ux-design` + `/ux-review` as a hard gate before visual design begins. / 第 1 阶段现在在视觉设计开始之前运行 `/ux-design` + `/ux-review` 作为硬关卡。

#### Brownfield Adoption / 棕地采用

**`/adopt`** onboards existing projects to the template format. Audits internal structure of GDDs, ADRs, stories, systems-index, and infra. Classifies gaps (BLOCKING/HIGH/MEDIUM/LOW). Builds an ordered migration plan. Never regenerates existing artifacts — only fills gaps.
**`/adopt`** 将现有项目纳入模板格式。审计 GDD、ADR、故事、系统索引和基础设施的内部结构。分类缺口（阻塞/高/中/低）。构建有序的迁移计划。从不重新生成现有工件 — 只填补缺口。

Argument modes: `full | gdds | adrs | stories | infra`
参数模式：`full | gdds | adrs | stories | infra`

Also: `/design-system retrofit [path]` and `/architecture-decision retrofit [path]` detect existing files and add only missing sections.
还有：`/design-system retrofit [path]` 和 `/architecture-decision retrofit [path]` 检测现有文件并仅添加缺失的章节。

#### Sprint Tracking YAML / 冲刺跟踪 YAML

`production/sprint-status.yaml` is now the authoritative story tracking format:
`production/sprint-status.yaml` 现在是权威的故事跟踪格式：
- Written by `/sprint-plan` (initializes all stories) and `/story-done` (sets status to `done`) / 由 `/sprint-plan`（初始化所有故事）和 `/story-done`（将状态设置为 `done`）写入
- Read by `/sprint-status` (fast snapshot) and `/help` (per-story status in production phase) / 由 `/sprint-status`（快速快照）和 `/help`（生产阶段每个故事的状态）读取
- Status values: `backlog | ready-for-dev | in-progress | review | done | blocked` / 状态值
- Falls back gracefully to markdown scanning if file doesn't exist / 如果文件不存在，优雅地回退到 markdown 扫描

#### `/help` — Context-Aware Next Step / `/help` — 上下文感知的下一步

`/help` reads your current stage and in-progress work, checks which artifacts are complete, and tells you exactly what to do next — one primary required step, plus optional opportunities. Distinct from `/start` (first-time only) and `/project-stage-detect` (full audit).
`/help` 读取您当前阶段和进行中的工作，检查哪些工件已完成，并准确告诉您下一步该做什么 — 一个主要必需步骤，加上可选机会。与 `/start`（仅首次）和 `/project-stage-detect`（完整审计）不同。

#### Comprehensive QA and Testing Framework / 综合 QA 和测试框架

Nine new QA/testing skills covering the full testing lifecycle:
九个新 QA/测试技能涵盖完整测试生命周期：

- **`/test-setup`** — scaffolds the test framework and CI/CD pipeline for your engine / 为您的引擎搭建测试框架和 CI/CD 管线
- **`/test-helpers`** — generates engine-specific test helper libraries (GDUnit4, NUnit, etc.) / 生成引擎特定的测试帮助库
- **`/qa-plan`** — generates a QA test plan for a sprint or feature, classifying stories by test type / 为冲刺或功能生成 QA 测试计划，按测试类型分类故事
- **`/smoke-check`** — runs the critical path smoke test gate before QA hand-off / 在 QA 交接之前运行关键路径冒烟测试关卡
- **`/soak-test`** — generates a soak test protocol for extended play sessions (stability, memory leaks) / 为延长游戏会话生成浸泡测试协议（稳定性、内存泄漏）
- **`/regression-suite`** — maps test coverage to GDD critical paths, identifies fixed bugs lacking regression tests / 将测试覆盖率映射到 GDD 关键路径，识别缺少回归测试的已修复错误
- **`/test-evidence-review`** — quality review of test files and manual evidence documents / 测试文件和手动证据文档的质量审查
- **`/test-flakiness`** — detects non-deterministic tests by reading CI run logs / 通过读取 CI 运行日志检测非确定性测试
- **`/skill-test`** — validates skill files for structural compliance and behavioral correctness (three modes: lint, spec, catalog) / 验证技能文件的结构合规性和行为正确性（三种模式：lint、spec、catalog）

Also new: **`/bug-triage`** re-evaluates all open bugs for priority, severity, and ownership.
还有新功能：**`/bug-triage`** 重新评估所有开放错误的优先级、严重性和所有权。

#### Skill Validator (`/skill-test`) / 技能验证器 (`/skill-test`)

`/skill-test` is a meta-skill for validating the harness itself. Run it after editing any skill file. Three modes:
`/skill-test` 是用于验证工具本身的元技能。编辑任何技能文件后运行它。三种模式：
- `lint` — validates YAML frontmatter and required fields / 验证 YAML 前言和必填字段
- `spec [skill-name]` — runs behavioral spec tests against a specific skill / 针对特定技能运行行为规范测试
- `catalog` — checks that all skills in `.codebuddy/skills/` are indexed in the catalog / 检查 `.codebuddy/skills/` 中的所有技能是否都在目录中索引

The new `validate-skill-change.sh` hook reminds you to run `/skill-test` automatically when a skill file is modified.
新的 `validate-skill-change.sh` 钩子在技能文件修改时自动提醒您运行 `/skill-test`。

#### Team Live-Ops and Team QA Orchestration / 团队运营和团队 QA 编排

- **`/team-live-ops`** — coordinates live-ops-designer + economy-designer + community-manager + analytics-engineer for post-launch content planning (seasonal events, battle pass, retention) / 协调运营设计师 + 经济设计师 + 社区经理 + 分析工程师进行发布后内容规划（季节性活动、战斗通行证、留存）
- **`/team-qa`** — orchestrates qa-lead + qa-tester + gameplay-programmer + producer through a full QA cycle: strategy, execution, coverage, and sign-off / 编排 QA 负责人 + QA 测试员 + 游戏玩法程序员 + 制作人完成完整 QA 周期：策略、执行、覆盖和签字

#### Model Tier Routing / 模型层级路由

Skills are now explicitly assigned to Haiku, Sonnet, or Opus tiers based on task complexity. Read-only status checks use Haiku; complex multi-document synthesis uses Opus; everything else defaults to Sonnet. Tier assignments are documented in `.codebuddy/docs/coordination-rules.md`.
技能现在根据任务复杂度明确分配给 Haiku、Sonnet 或 Opus 层级。只读状态检查使用 Haiku；复杂的多文档合成使用 Opus；其他所有默认使用 Sonnet。层级分配记录在 `.codebuddy/docs/coordination-rules.md` 中。

#### Directory CLAUDE.md Files / 目录 CLAUDE.md 文件

Three new directory-scoped CLAUDE.md files (`design/`, `src/`, `docs/`) provide path-specific instructions to agents working in those directories. These load automatically when Claude Code reads files in that directory.
三个新的目录范围 CLAUDE.md 文件（`design/`、`src/`、`docs/`）为在这些目录中工作的代理提供路径特定说明。当 Claude Code 读取该目录中的文件时，这些会自动加载。

---

### After Upgrading / 升级后

1. **Verify new hooks** are registered in `.codebuddy/settings.json` — check for all four: `log-agent-stop.sh`, `notify.sh`, `post-compact.sh`, `validate-skill-change.sh`.
   **验证新钩子**是否已在 `.codebuddy/settings.json` 中注册 — 检查全部四个。

2. **Test the audit trail** by spawning any subagent — both start and stop events should appear in `production/session-logs/`.
   **通过生成任何子代理测试审计跟踪** — 开始和停止事件都应出现在 `production/session-logs/` 中。

3. **Generate sprint-status.yaml** if you're in active production:
   **生成 sprint-status.yaml** 如果您处于活跃生产阶段：
   ```
   /sprint-plan status
   ```

4. **Run `/adopt`** if you have existing GDDs or ADRs that predate this template version — it will identify which sections need to be added without overwriting your content.
   **运行 `/adopt`** 如果您有早于此模板版本的现有 GDD 或 ADR — 它将识别需要添加哪些章节而不覆盖您的内容。

5. **Validate your skills** after any skill edits with `/skill-test` — the new `validate-skill-change.sh` hook will automatically remind you to do this.
   **验证您的技能** 任何技能编辑后使用 `/skill-test` — 新的 `validate-skill-change.sh` 钩子将自动提醒您执行此操作。

---

## v0.2.0 → v0.3.0

**Released:** 2026-03-09 / **发布日期：**2026-03-09
**Commit range:** `e289ce9..HEAD` / **提交范围：**
**Key themes:** `/design-system` GDD authoring, `/map-systems` rename, custom status line / **核心主题：**`/design-system` GDD 编写、`/map-systems` 重命名、自定义状态行

### Breaking Changes / 破坏性更改

#### `/design-systems` renamed to `/map-systems` / `/design-systems` 重命名为 `/map-systems`

The `/design-systems` skill was renamed to `/map-systems` for clarity
`/design-systems` 技能已重命名为 `/map-systems` 以提高清晰度
(decomposing = *mapping*, not *designing*).
（分解 = *映射*，不是*设计*）。

**Action required:** Update any documentation, notes, or scripts that invoke
**需要采取的行动：** 更新任何调用 `/design-systems` 的文档、笔记或脚本。
`/design-systems`. The new invocation is `/map-systems`.
新的调用是 `/map-systems`。

### What Changed / 更改内容

| Category / 类别 | Changes / 更改 |
|----------|---------|
| **New skills / 新技能** | `/design-system` (guided GDD authoring, section-by-section) / 引导式 GDD 编写，分章节 |
| **Renamed skills / 重命名技能** | `/design-systems` → `/map-systems` (breaking rename) / 破坏性重命名 |
| **New files / 新文件** | `.codebuddy/statusline.sh`, `.codebuddy/settings.json` statusline config / 状态行配置 |
| **Skill updates / 技能更新** | `/gate-check` — writes `production/stage.txt` on PASS, new phase definitions / 通过时写入 production/stage.txt，新阶段定义 |
| **Skill updates / 技能更新** | `brainstorm`, `start`, `design-review`, `project-stage-detect`, `setup-engine` — cross-reference fixes / 交叉引用修复 |
| **Bug fixes / 错误修复** | `log-agent.sh`, `validate-commit.sh` — hook execution fixed / 钩子执行修复 |
| **Docs / 文档** | `UPGRADING.md` added, `README.md` updated, `WORKFLOW-GUIDE.md` updated / 添加、更新 |

---

### Files: Safe to Overwrite / 文件：可安全覆盖

**New files to add:**
**要添加的新文件：**
```
.codebuddy/skills/design-system/SKILL.md
.codebuddy/statusline.sh
```

**Existing files to overwrite (no user content):**
**要覆盖的现有文件（无用户内容）：**
```
.codebuddy/skills/map-systems/SKILL.md      ← was design-systems/SKILL.md / 原为 design-systems/SKILL.md
.codebuddy/skills/gate-check/SKILL.md
.codebuddy/skills/brainstorm/SKILL.md
.codebuddy/skills/start/SKILL.md
.codebuddy/skills/design-review/SKILL.md
.codebuddy/skills/project-stage-detect/SKILL.md
.codebuddy/skills/setup-engine/SKILL.md
.codebuddy/hooks/log-agent.sh
.codebuddy/hooks/validate-commit.sh
README.md
docs/WORKFLOW-GUIDE.md
UPGRADING.md
```

**Delete (replaced by rename):**
**删除（被重命名替换）：**
```
.codebuddy/skills/design-systems/   ← entire directory; replaced by map-systems/ / 整个目录；被 map-systems/ 替换
```

---

### Files: Merge Carefully / 文件：仔细合并

#### `.codebuddy/settings.json`

The new version adds a `statusLine` configuration block pointing to
新版本添加了一个指向 `.codebuddy/statusline.sh` 的 `statusLine` 配置块。
`.codebuddy/statusline.sh`. If you haven't customized `settings.json`, overwriting
如果您没有自定义 `settings.json`，覆盖是安全的。
is safe. Otherwise, add this block manually:
否则，手动添加此块：

```json
"statusLine": {
  "script": ".codebuddy/statusline.sh"
}
```

---

### New Features / 新功能

#### Custom Status Line / 自定义状态行

`.codebuddy/statusline.sh` displays a 7-stage production pipeline breadcrumb in
`.codebuddy/statusline.sh` 在终端状态行中显示 7 阶段生产管线面包屑：
the terminal status line:

```
ctx: 42% | claude-sonnet-4-6 | Systems Design
```

In Production/Polish/Release stages, it also shows the active Epic/Feature/Task
在生产/打磨/发布阶段，如果存在 `<!-- STATUS -->` 块，它还显示来自 `production/session-state/active.md` 的活跃史诗/功能/任务：
from `production/session-state/active.md` if a `<!-- STATUS -->` block is present:

```
ctx: 42% | claude-sonnet-4-6 | Production | Combat System > Melee Combat > Hitboxes
```

The current stage is auto-detected from project artifacts, or can be pinned by
当前阶段从项目工件自动检测，或通过将阶段名称写入 `production/stage.txt` 固定。
writing a stage name to `production/stage.txt`.

#### `/gate-check` Stage Advancement / `/gate-check` 阶段推进

When a gate PASS verdict is confirmed, `/gate-check` now writes the new stage
当关卡通过裁决确认时，`/gate-check` 现在将新阶段名称写入 `production/stage.txt`。
name to `production/stage.txt`. This immediately updates the status line for all
这会立即更新所有未来会话的状态行，无需手动编辑文件。
future sessions without requiring manual file edits.

---

### After Upgrading / 升级后

1. **Delete the old skill directory:**
   **删除旧技能目录：**
   ```bash
   rm -rf .codebuddy/skills/design-systems/
   ```

2. **Test the status line** by starting a Claude Code session — you should see
   **通过启动 Claude Code 会话测试状态行** — 您应该在终端页脚看到阶段面包屑。
   the stage breadcrumb in the terminal footer.

3. **Verify hook execution** still works:
   **验证钩子执行**仍然有效：
   ```bash
   bash .codebuddy/hooks/detect-gaps.sh '{}' '{}'
   bash .codebuddy/hooks/session-start.sh '{}' '{}'
   ```

---

## v0.1.0 → v0.2.0

**Released:** 2026-02-21 / **发布日期：**2026-02-21
**Commit range:** `ad540fe..e289ce9` / **提交范围：**
**Key themes:** Context Resilience, AskUserQuestion integration, `/map-systems` skill / **核心主题：**上下文恢复能力、AskUserQuestion 集成、`/map-systems` 技能

### What Changed / 更改内容

| Category / 类别 | Changes / 更改 |
|----------|---------|
| **New skills / 新技能** | `/start` (onboarding), `/map-systems` (systems decomposition), `/design-system` (guided GDD authoring) / 入门、系统分解、引导式 GDD 编写 |
| **New hooks / 新钩子** | `session-start.sh` (recovery), `detect-gaps.sh` (gap detection) / 恢复、缺口检测 |
| **New templates / 新模板** | `systems-index.md`, 3 collaborative-protocol templates / 3 个协作协议模板 |
| **Context management / 上下文管理** | Major rewrite — file-backed state strategy added / 主要重写 — 添加文件支持的状态策略 |
| **Agent updates / 代理更新** | 14 design/creative agents — AskUserQuestion integration / 14 个设计/创意代理 — AskUserQuestion 集成 |
| **Skill updates / 技能更新** | All 7 `team-*` skills + `brainstorm` — AskUserQuestion at phase transitions / 所有 7 个 `team-*` 技能 + `brainstorm` — 阶段转换时的 AskUserQuestion |
| **CLAUDE.md** | Slimmed from ~159 to ~60 lines; 5 doc imports instead of 10 / 从约 159 行精简到约 60 行；5 个文档导入而不是 10 个 |
| **Hook updates / 钩子更新** | All 8 hooks — Windows compatibility fixes, new features / 所有 8 个钩子 — Windows 兼容性修复、新功能 |
| **Docs removed / 删除的文档** | `docs/IMPROVEMENTS-PROPOSAL.md`, `docs/MULTI-STAGE-DOCUMENT-WORKFLOW.md` / |

---

### Files: Safe to Overwrite / 文件：可安全覆盖

These are pure infrastructure — you have not customized them. Copy the new
这些是纯基础设施 — 您没有自定义它们。直接复制新版本，对您的项目内容没有风险。
versions directly with no risk to your project content.

**New files to add:**
**要添加的新文件：**
```
.codebuddy/skills/start/SKILL.md
.codebuddy/skills/map-systems/SKILL.md
.codebuddy/skills/design-system/SKILL.md
.codebuddy/docs/templates/systems-index.md
.codebuddy/docs/templates/collaborative-protocols/design-agent-protocol.md
.codebuddy/docs/templates/collaborative-protocols/implementation-agent-protocol.md
.codebuddy/docs/templates/collaborative-protocols/leadership-agent-protocol.md
.codebuddy/hooks/detect-gaps.sh
.codebuddy/hooks/session-start.sh
production/session-state/.gitkeep
docs/examples/README.md
.github/ISSUE_TEMPLATE/bug_report.md
.github/ISSUE_TEMPLATE/feature_request.md
.github/PULL_REQUEST_TEMPLATE.md
```

**Existing files to overwrite (no user content):**
**要覆盖的现有文件（无用户内容）：**
```
.codebuddy/skills/brainstorm/SKILL.md
.codebuddy/skills/design-review/SKILL.md
.codebuddy/skills/gate-check/SKILL.md
.codebuddy/skills/project-stage-detect/SKILL.md
.codebuddy/skills/setup-engine/SKILL.md
.codebuddy/skills/team-audio/SKILL.md
.codebuddy/skills/team-combat/SKILL.md
.codebuddy/skills/team-level/SKILL.md
.codebuddy/skills/team-narrative/SKILL.md
.codebuddy/skills/team-polish/SKILL.md
.codebuddy/skills/team-release/SKILL.md
.codebuddy/skills/team-ui/SKILL.md
.codebuddy/hooks/log-agent.sh
.codebuddy/hooks/pre-compact.sh
.codebuddy/hooks/session-stop.sh
.codebuddy/hooks/validate-assets.sh
.codebuddy/hooks/validate-commit.sh
.codebuddy/hooks/validate-push.sh
.codebuddy/rules/design-docs.md
.codebuddy/docs/hooks-reference.md
.codebuddy/docs/skills-reference.md
.codebuddy/docs/quick-start.md
.codebuddy/docs/directory-structure.md
.codebuddy/docs/context-management.md
docs/COLLABORATIVE-DESIGN-PRINCIPLE.md
docs/WORKFLOW-GUIDE.md
README.md
```

**Agent files to overwrite** (if you haven't written custom prompts into them):
**要覆盖的代理文件**（如果您没有在其中编写自定义提示）：
```
.codebuddy/agents/art-director.md
.codebuddy/agents/audio-director.md
.codebuddy/agents/creative-director.md
.codebuddy/agents/economy-designer.md
.codebuddy/agents/game-designer.md
.codebuddy/agents/level-designer.md
.codebuddy/agents/live-ops-designer.md
.codebuddy/agents/narrative-director.md
.codebuddy/agents/producer.md
.codebuddy/agents/systems-designer.md
.codebuddy/agents/technical-director.md
.codebuddy/agents/ux-designer.md
.codebuddy/agents/world-builder.md
.codebuddy/agents/writer.md
```

If you *have* customized agent prompts, see "Merge carefully" below.
如果您*已*自定义代理提示，请参阅下面的"仔细合并"。

---

### Files: Merge Carefully / 文件：仔细合并

These files contain both template structure and your project-specific content.
这些文件包含模板结构和您的项目特定内容。
Do **not** overwrite them — merge the changes manually.
**不要**覆盖它们 — 手动合并更改。

#### `CLAUDE.md`

The template version was slimmed from ~159 lines to ~60 lines. The key
模板版本从约 159 行精简到约 60 行。关键
structural change: 5 doc imports were removed because they're auto-loaded
结构更改：删除了 5 个文档导入，因为它们已由 Claude Code 自动加载
by Claude Code anyway (agent-roster, skills-reference, hooks-reference,
（agent-roster、skills-reference、hooks-reference、
rules-reference, review-workflow).
rules-reference、review-workflow）。

**What to keep from your version:**
**从您的版本中保留什么：**
- The `## Technology Stack` section (your engine/language choices) / 技术栈章节（您的引擎/语言选择）
- Any project-specific additions you made / 您所做的任何项目特定添加

**What to adopt from the new version:**
**从新版本采用什么：**
- Slimmer imports list (drop the 5 redundant `@` imports if present) / 更精简的导入列表（如果存在，删除 5 个冗余的 `@` 导入）
- Updated collaboration protocol wording / 更新的协作协议措辞

#### `.codebuddy/docs/technical-preferences.md`

If you ran `/setup-engine`, this file has your engine config, naming
如果您运行了 `/setup-engine`，此文件包含您的引擎配置、命名约定和性能预算。
conventions, and performance budgets. Keep all of it. The template version
保留所有内容。模板版本只是空占位符。
is just the empty placeholder.

#### `.codebuddy/docs/templates/game-concept.md`

Minor structural update — a `## Next Steps` section was added pointing to
次要结构更新 — 添加了一个指向 `/map-systems` 的 `## Next Steps` 章节。
`/map-systems`. Add that section to your copy if you want the updated
如果您想要更新的指导，请将那个章节添加到您的副本，但不是必需的。
guidance, but it's not required.

#### `.codebuddy/settings.json`

Check whether the new version adds any permission rules you want. The change
检查新版本是否添加了您想要的任何权限规则。更改
was minor (schema update). If you haven't customized your `settings.json`,
是次要的（模式更新）。如果您没有自定义 `settings.json`，
overwriting is safe.
覆盖是安全的。

#### Customized agent files / 自定义代理文件

If you've added project-specific knowledge or custom behavior to any agent
如果您已向任何代理 `.md` 文件添加了项目特定知识或自定义行为，
`.md` file, do a diff and manually add the new AskUserQuestion integration
请进行差异比较并手动添加新的 AskUserQuestion 集成章节，而不是覆盖。
sections rather than overwriting. The change in each agent is a standardized
每个代理中的更改是标准化的协作协议块，位于系统提示末尾。
collaborative protocol block at the end of the system prompt.

---

### Files: Delete / 文件：删除

These files were removed in v0.2.0. If present in your repo, you can safely
这些文件在 v0.2.0 中已删除。如果在您的仓库中存在，您可以安全地
delete them — they're replaced by better-organized alternatives.
删除它们 — 它们已被更好组织的替代方案替换。

```
docs/IMPROVEMENTS-PROPOSAL.md      → superseded by WORKFLOW-GUIDE.md / 被 WORKFLOW-GUIDE.md 取代
docs/MULTI-STAGE-DOCUMENT-WORKFLOW.md → content merged into context-management.md / 内容合并到 context-management.md
```

---

### After Upgrading / 升级后

1. **Run `/project-stage-detect`** to verify the system reads your project
   **运行 `/project-stage-detect`** 以验证系统使用新的检测逻辑正确读取您的项目。
   correctly with the new detection logic.

2. **Run `/start`** once if you haven't used it — it now correctly identifies
   **运行 `/start`** 一次如果您没有使用过它 — 它现在正确识别您的阶段并跳过您已完成的入门步骤。
   your stage and skips onboarding steps you've already done.

3. **Check `production/session-state/`** exists and is gitignored:
   **检查 `production/session-state/`** 是否存在并被 gitignored：
   ```bash
   ls production/session-state/
   cat .gitignore | grep session-state
   ```

4. **Test hook execution** — if you're on Windows, verify the new hooks run
   **测试钩子执行** — 如果您在 Windows 上，验证新钩子在 Git Bash 中无错误运行：
   without errors in Git Bash:
   ```bash
   bash .codebuddy/hooks/detect-gaps.sh '{}' '{}'
   bash .codebuddy/hooks/session-start.sh '{}' '{}'
   ```

---

*Each future version will have its own section in this file.*
*每个未来版本都将在此文件中有自己的章节。*
