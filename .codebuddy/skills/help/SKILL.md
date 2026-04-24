---
name: help
description: "Analyzes what is done and the users query and offers advice on what to do next. Use if user says what should I do next or what do I do now or I'm stuck or I don't know what to do / 分析已完成的工作和用户查询，提供下一步建议。当用户说"接下来该做什么"、"我卡住了"或"我不知道该做什么"时使用"
argument-hint: "[optional: what you just finished, e.g. 'finished design-review' or 'stuck on ADRs']"
user-invocable: true
allowed-tools: Read, Glob, Grep
context: |
  !echo "=== Live Project State ===" && echo "Stage: $(cat production/stage.txt 2>/dev/null | tr -d '[:space:]' || echo 'not set')" && echo "Latest sprint: $(ls -t production/sprints/*.md 2>/dev/null | head -1 || echo 'none')" && echo "Session state: $(head -5 production/session-state/active.md 2>/dev/null || echo 'none')"
model: haiku
---

# Studio Help — What Do I Do Next? / 工作室帮助 — 接下来该做什么？

This skill is read-only — it reports findings but writes no files.
> **中文翻译**：此技能为只读 — 它报告发现但不写入任何文件。

This skill figures out exactly where you are in the game development pipeline and
tells you what comes next. It is **lightweight** — not a full audit. For a full
gap analysis, use `/project-stage-detect`.
> **中文翻译**：此技能精确找出您在游戏开发管线中的位置，并告诉您下一步该做什么。它是**轻量级**的 — 不是完整审计。如需完整的差距分析，请使用 `/project-stage-detect`。

---

## Step 1: Read the Catalog / 步骤 1：读取目录

Read `.codebuddy/docs/workflow-catalog.yaml`. This is the authoritative list of all
phases, their steps (in order), whether each step is required or optional, and
the artifact globs that indicate completion.
> **中文翻译**：读取 `.codebuddy/docs/workflow-catalog.yaml`。这是所有阶段、其步骤（按顺序）、每个步骤是必需还是可选、以及指示完成的工件 glob 模式的权威列表。

---

## Step 1b: Find Skills Not in the Catalog / 步骤 1b：查找目录外的技能

After reading the catalog, Glob `.codebuddy/skills/*/SKILL.md` to get the full list
of installed skills. For each file, extract the `name:` field from its frontmatter.
> **中文翻译**：读取目录后，用 Glob 查找 `.codebuddy/skills/*/SKILL.md` 获取已安装技能的完整列表。对于每个文件，从其前置数据中提取 `name:` 字段。

Compare against the `command:` values in the catalog. Any skill whose name does
not appear as a catalog command is an **uncataloged skill** — still usable but not
part of the phase-gated workflow.
> **中文翻译**：与目录中的 `command:` 值比较。任何名称未作为目录命令出现的技能都是**未编目技能** — 仍可使用但不属于阶段门控工作流。

Collect these for the output in Step 7 — show them as a footer block: / 收集这些用于步骤 7 的输出 — 作为页脚块显示：

```
### Also installed (not in workflow) / 另外已安装（不在工作流中）
- `/skill-name` — [description from SKILL.md frontmatter] / [SKILL.md 前置数据中的描述]
- `/skill-name` — [description] / [描述]
```

Only show this block if at least one uncataloged skill exists. Limit to the 10
most relevant based on the user's current phase (QA skills in production, team
skills in production/polish, etc.).
> **中文翻译**：仅在至少存在一个未编目技能时显示此块。根据用户当前阶段限制为最相关的 10 个（生产阶段的 QA 技能、生产/打磨阶段的团队技能等）。

---

## Step 2: Determine Current Phase / 步骤 2：确定当前阶段

Check in this order: / 按此顺序检查：

1. **Read `production/stage.txt`** — if it exists and has content, this is the
   authoritative phase name. Map it to a catalog phase key:
   > **中文翻译**：**读取 `production/stage.txt`** — 如果存在且有内容，这是权威的阶段名称。将其映射到目录阶段键：
   - "Concept" → `concept` / "概念" → `concept`
   - "Systems Design" → `systems-design` / "系统设计" → `systems-design`
   - "Technical Setup" → `technical-setup` / "技术设置" → `technical-setup`
   - "Pre-Production" → `pre-production` / "预生产" → `pre-production`
   - "Production" → `production` / "生产" → `production`
   - "Polish" → `polish` / "打磨" → `polish`
   - "Release" → `release` / "发布" → `release`

2. **If stage.txt is missing**, infer phase from artifacts (most-advanced match wins):
   > **中文翻译**：**如果 stage.txt 缺失**，从工件推断阶段（最高级匹配优先）：
   - `src/` has 10+ source files → `production` / `src/` 有 10+ 个源文件 → `production`
   - `production/stories/*.md` exists → `pre-production` / `production/stories/*.md` 存在 → `pre-production`
   - `docs/architecture/adr-*.md` exists → `technical-setup` / `docs/architecture/adr-*.md` 存在 → `technical-setup`
   - `design/gdd/systems-index.md` exists → `systems-design` / `design/gdd/systems-index.md` 存在 → `systems-design`
   - `design/gdd/game-concept.md` exists → `concept` / `design/gdd/game-concept.md` 存在 → `concept`
   - Nothing → `concept` (fresh project) / 无 → `concept`（新项目）

---

## Step 3: Read Session Context / 步骤 3：读取会话上下文

Read `production/session-state/active.md` if it exists. Extract: / 如果存在，读取 `production/session-state/active.md`。提取：
- What was most recently worked on / 最近在处理什么
- Any in-progress tasks or open questions / 任何进行中的任务或待解决问题
- Current epic/feature/task from STATUS block (if present) / STATUS 块中的当前史诗/功能/任务（如存在）

This tells you what the user just finished or is stuck on — use it to personalize
the output.
> **中文翻译**：这告诉您用户刚完成了什么或卡在了哪里 — 用它来个性化输出。

---

## Step 4: Check Step Completion for the Current Phase / 步骤 4：检查当前阶段的步骤完成情况

For each step in the current phase (from the catalog): / 对于当前阶段的每个步骤（来自目录）：

### Artifact-based checks / 基于工件的检查

If the step has `artifact.glob`: / 如果步骤有 `artifact.glob`：
- Use Glob to check if files matching the pattern exist / 使用 Glob 检查匹配模式的文件是否存在
- If `min_count` is specified, verify at least that many files match / 如果指定了 `min_count`，验证至少有那么多文件匹配
- If `artifact.pattern` is specified, use Grep to verify the pattern exists in the matched file / 如果指定了 `artifact.pattern`，使用 Grep 验证模式存在于匹配的文件中
- **Complete** = artifact condition is met / **完成** = 满足工件条件
- **Incomplete** = artifact is missing or pattern not found / **未完成** = 工件缺失或未找到模式

If the step has `artifact.note` (no glob): / 如果步骤有 `artifact.note`（无 glob）：
- Mark as **MANUAL** — cannot auto-detect, will ask user / 标记为 **手动** — 无法自动检测，将询问用户

If the step has no `artifact` field: / 如果步骤没有 `artifact` 字段：
- Mark as **UNKNOWN** — completion not trackable (e.g. repeatable implementation work) / 标记为 **未知** — 无法跟踪完成度（例如可重复的实施工作）

### Special case: production phase — read `sprint-status.yaml` / 特殊情况：生产阶段 — 读取 `sprint-status.yaml`

When the current phase is `production`, check for `production/sprint-status.yaml`
before doing any glob-based story checks. If it exists, read it directly: / 当当前阶段为 `production` 时，在进行任何基于 glob 的故事检查之前，检查 `production/sprint-status.yaml`。如果存在，直接读取：

- Stories with `status: in-progress` → surface as "currently active" / 状态为 `in-progress` 的故事 → 显示为"当前活跃"
- Stories with `status: ready-for-dev` → surface as "next up" / 状态为 `ready-for-dev` 的故事 → 显示为"下一个"
- Stories with `status: done` → count as complete / 状态为 `done` 的故事 → 计为完成
- Stories with `status: blocked` → surface as blocker with the `blocker` field / 状态为 `blocked` 的故事 → 以 `blocker` 字段显示为阻塞项

This gives precise per-story status without markdown scanning. Skip the glob
artifact check for the `implement` and `story-done` steps — the YAML is authoritative.
> **中文翻译**：这无需 markdown 扫描即可提供精确的每个故事状态。跳过 `implement` 和 `story-done` 步骤的 glob 工件检查 — YAML 是权威来源。

### Special case: `repeatable: true` (non-production) / 特殊情况：`repeatable: true`（非生产阶段）

For repeatable steps outside production (e.g. "System GDDs"), the artifact
check tells you whether *any* work has been done, not whether it's finished.
Label these differently — show what's been detected, then note it may be ongoing.
> **中文翻译**：对于生产阶段之外的可重复步骤（例如"系统 GDD"），工件检查告诉您是否已做了*任何*工作，而不是是否完成。以不同方式标记这些 — 显示已检测到的内容，然后注明可能正在进行中。

---

## Step 5: Find Position and Identify Next Steps / 步骤 5：找到位置并识别下一步

From the completion data, determine: / 从完成数据中，确定：

1. **Last confirmed complete step** — the furthest completed required step / **最后确认完成的步骤** — 最远的已完成必需步骤
2. **Current blocker** — the first incomplete *required* step (this is what the
   user must do next) / **当前阻塞项** — 第一个未完成的*必需*步骤（这是用户下一步必须做的）
3. **Optional opportunities** — incomplete *optional* steps that can be done
   before or alongside the blocker / **可选机会** — 可以在阻塞项之前或同时完成的未完成*可选*步骤
4. **Upcoming required steps** — required steps after the current blocker
   (show as "coming up" so user can plan ahead) / **即将到来的必需步骤** — 当前阻塞项之后的必需步骤（显示为"即将到来"以便用户提前规划）

If the user provided an argument (e.g. "just finished design-review"), use that
to advance past the step they named even if the artifact check is ambiguous.
> **中文翻译**：如果用户提供了参数（例如"刚完成 design-review"），使用它来推进他们命名的步骤，即使工件检查是模糊的。

---

## Step 6: Check for In-Progress Work / 步骤 6：检查进行中的工作

If `active.md` shows an active task or epic: / 如果 `active.md` 显示有活跃的任务或史诗：
- Surface it prominently at the top: "It looks like you were working on [X]" / 在顶部突出显示："看起来您之前在处理 [X]"
- Suggest continuing it or confirm if it's done / 建议继续或确认是否已完成

---

## Step 7: Present Output / 步骤 7：呈现输出

Keep it **short and direct**. This is a quick orientation, not a report.
> **中文翻译**：保持**简短直接**。这是一个快速定位，不是报告。

```
## Where You Are: [Phase Label] / 您的位置：[阶段标签]

**In progress:** [from active.md, if any] / **进行中：** [来自 active.md，如有]

### ✓ Done / ✓ 已完成
- [completed step name] / [已完成步骤名称]
- [completed step name] / [已完成步骤名称]

### → Next up (REQUIRED) / → 下一步（必需）
**[Step name]** — [description] / **[步骤名称]** — [描述]
Command: `[/command]` / 命令：`[/command]`

### ~ Also available (OPTIONAL) / ~ 也可用（可选）
- **[Step name]** — [description] → `/command` / **[步骤名称]** — [描述] → `/command`
- **[Step name]** — [description] → `/command` / **[步骤名称]** — [描述] → `/command`

### Coming up after that / 之后即将到来
- [Next required step name] (`/command`) / [下一个必需步骤名称] (`/command`)
- [Next required step name] (`/command`) / [下一个必需步骤名称] (`/command`)

---
Approaching **[next phase]** gate → run `/gate-check` when ready. / 接近 **[下一阶段]** 门控 → 准备好时运行 `/gate-check`。
```

**Formatting rules:** / **格式规则：**
- `✓` for confirmed complete / `✓` 表示确认完成
- `→` for the current required next step (only one — the first blocker) / `→` 表示当前必需的下一步（只有一个 — 第一个阻塞项）
- `~` for optional steps available now / `~` 表示当前可用的可选步骤
- Show commands inline as backtick code / 将命令以内联反引号代码显示
- If a step has no command (e.g. "Implement Stories"), explain what to do instead of showing a slash command / 如果步骤没有命令（例如"实施故事"），解释该做什么而不是显示斜杠命令
- For MANUAL steps, ask the user: "I can't tell if [step] is done — has it been completed?" / 对于手动步骤，询问用户："我无法判断 [步骤] 是否完成 — 它已完成了吗？"

Verdict: **COMPLETE** — next steps identified. / 裁决：**完成** — 已识别下一步。

---

## Step 8: Gate Warning (if close) / 步骤 8：门控警告（如果接近）

After the current phase's steps, check if the user is likely approaching a gate: / 在当前阶段的步骤之后，检查用户是否可能接近门控：
- If all required steps in the current phase are complete (or nearly complete),
  add: "You're close to the **[Current] → [Next]** gate. Run `/gate-check` when ready." / 如果当前阶段的所有必需步骤已完成（或接近完成），添加："您接近 **[当前] → [下一]** 门控。准备好时运行 `/gate-check`。"
- If multiple required steps remain, skip the gate warning — it's not relevant yet. / 如果仍有多个必需步骤未完成，跳过门控警告 — 还不相关。

---

## Step 9: Escalation Paths / 步骤 9：升级路径

After the recommendations, if the user seems stuck or confused, add: / 在建议之后，如果用户似乎卡住或困惑，添加：

```
---
Need more detail? / 需要更多细节？
- `/project-stage-detect` — full gap analysis with all missing artifacts listed / 完整差距分析，列出所有缺失工件
- `/gate-check` — formal readiness check for your next phase / 下一阶段的正式就绪检查
- `/start` — re-orient from scratch / 从头重新定位
```

Only show this if the user's input suggested confusion (e.g. "I don't know", "stuck",
"lost", "not sure"). Don't show it for simple "what's next?" queries.
> **中文翻译**：仅在用户输入暗示困惑时显示（例如"我不知道"、"卡住了"、"迷茫"、"不确定"）。不要为简单的"下一步？"查询显示。

---

## Collaborative Protocol / 协作协议

- **Never auto-run the next skill.** Recommend it, let the user invoke it. / **永远不要自动运行下一个技能。** 推荐它，让用户调用。
- **Ask about MANUAL steps** rather than assuming complete or incomplete. / **询问手动步骤**而不是假设完成或未完成。
- **Match the user's tone** — if they sound stressed ("I'm totally lost"), be
  reassuring and give one action, not a list of six. / **匹配用户的语气** — 如果他们听起来有压力（"我完全迷失了"），给予安慰并提供一个行动，而不是六个的列表。
- **One primary recommendation** — the user should leave knowing exactly one thing
  to do next. Optional steps and "coming up" are secondary context. / **一个主要建议** — 用户离开时应该确切知道下一步要做的一件事。可选步骤和"即将到来"是次要上下文。
