---
name: story-readiness
description: "Validate that a story file is implementation-ready. Checks for embedded GDD requirements, ADR references, engine notes, clear acceptance criteria, and no open design questions. Produces READY / NEEDS WORK / BLOCKED verdict with specific gaps. Use when user says 'is this story ready', 'can I start on this story', 'is story X ready to implement'. / 验证故事文件是否可进入实现阶段。检查嵌入的 GDD 需求、ADR 引用、引擎说明、清晰的验收标准，且无开放设计问题。生成 READY / NEEDS WORK / BLOCKED 裁决及具体差距。当用户说'这个故事准备好了吗'、'我可以开始这个故事吗'时使用。"
argument-hint: "[story-file-path or 'all' or 'sprint']"
user-invocable: true
allowed-tools: Read, Glob, Grep, AskUserQuestion, Task
model: haiku
---

# Story Readiness / 故事就绪度

This skill validates that a story file contains everything a developer needs
to begin implementation — no mid-sprint design interruptions, no guessing,
no ambiguous acceptance criteria. Run it before assigning a story.

> **中文翻译**：此技能验证故事文件包含开发者开始实现所需的一切——无冲刺中设计中断、无需猜测、无模糊验收标准。在分配故事前运行。

**This skill is read-only.** It never edits story files. It reports findings
and asks whether the user wants help filling gaps.

> **中文翻译**：**此技能是只读的。** 它从不编辑故事文件。它报告发现并询问用户是否需要帮助填补差距。

---

## Phase 0: Resolve Review Mode / 第 0 阶段：解决审查模式

Resolve the review mode once at startup (store for all gate spawns this run):

> **中文翻译**：在启动时一次性解决审查模式（存储供本次运行所有门控派生使用）：

1. If skill was called with `--review [full|lean|solo]` → use that value / 如果技能以 `--review [full|lean|solo]` 调用 → 使用该值
2. Else read `production/review-mode.txt` → use that value / 否则读取 `production/review-mode.txt` → 使用该值
3. Else → default to `lean` / 否则 → 默认为 `lean`

See `.codebuddy/docs/director-gates.md` for the full check pattern and mode definitions.

> **中文翻译**：完整的检查模式和模式定义参见 `.codebuddy/docs/director-gates.md`。

---

## 1. Parse Arguments / 1. 解析参数

**Scope:** `$ARGUMENTS[0]` (blank = ask user via AskUserQuestion)

> **中文翻译**：**范围：** `$ARGUMENTS[0]`（空白 = 通过 AskUserQuestion 询问用户）

- **Specific path** (e.g., `/story-readiness production/epics/combat/story-001-basic-attack.md`):
  validate that single story file. / **指定路径**（如 `/story-readiness production/epics/combat/story-001-basic-attack.md`）：验证该单个故事文件。
- **`sprint`**: read the current sprint plan from `production/sprints/` (most
  recent file), extract every story path it references, validate each one. / **`sprint`**：从 `production/sprints/` 读取当前冲刺计划（最新文件），提取其引用的每个故事路径，逐一验证。
- **`all`**: glob `production/epics/**/*.md`, exclude `EPIC.md` index files,
  validate every story file found. / **`all`**：glob `production/epics/**/*.md`，排除 `EPIC.md` 索引文件，验证找到的每个故事文件。
- **No argument**: ask the user which scope to validate. / **无参数**：询问用户要验证的范围。

If no argument is given, use `AskUserQuestion`:

> **中文翻译**：如果未提供参数，使用 `AskUserQuestion`：

- "What would you like to validate?" / "您想验证什么？"
  - Options: "A specific story file", "All stories in the current sprint",
    "All stories in production/epics/", "Stories for a specific epic" / 选项："一个特定的故事文件"、"当前冲刺中的所有故事"、"production/epics/ 中的所有故事"、"特定史诗的故事"

Report the scope before proceeding: "Validating [N] story files."

> **中文翻译**：在继续之前报告范围："正在验证 [N] 个故事文件。"

---

## 2. Load Supporting Context / 2. 加载支撑上下文

Before checking any stories, load reference documents once (not per-story):

> **中文翻译**：在检查任何故事之前，一次性加载参考文档（而非每个故事重复加载）：

- `design/gdd/systems-index.md` — to know which systems have approved GDDs / — 了解哪些系统已有批准的 GDD
- `docs/architecture/control-manifest.md` — to know which manifest rules exist
  (if the file does not exist, note it as missing once; do not re-flag per story)
  Also extract the `Manifest Version:` date from the header block if the file exists. / — 了解存在哪些控制清单规则（如果文件不存在，仅标记一次缺失；不要每个故事重复标记）如果文件存在，还需从头部块提取 `Manifest Version:` 日期。
- `docs/architecture/tr-registry.yaml` — index all entries by `id`. Used to
  validate TR-IDs in stories. If the file does not exist, note it once; TR-ID
  checks will auto-pass for all stories (registry predates stories, so missing
  registry means stories are from before TR tracking was introduced). / — 按 `id` 索引所有条目。用于验证故事中的 TR-ID。如果文件不存在，仅标记一次；TR-ID 检查将对所有故事自动通过（注册表先于故事存在，因此缺少注册表意味着故事来自引入 TR 追踪之前）。
- All ADR status fields — for each unique ADR referenced across the stories being
  checked, read the ADR file and note its `Status:` field. Cache these so you
  don't re-read the same ADR for every story. / 所有 ADR 状态字段 — 对于正在检查的故事中引用的每个唯一 ADR，读取 ADR 文件并记录其 `Status:` 字段。缓存这些信息以避免为每个故事重新读取同一 ADR。
- The current sprint file (if scope is `sprint`) — to identify Must Have /
  Should Have priority for escalation decisions / 当前冲刺文件（如果范围为 `sprint`）— 用于识别 Must Have / Should Have 优先级以供升级决策

---

## 3. Story Readiness Checklist / 3. 故事就绪度检查清单

For each story file, evaluate every item below. A story is READY only if all
items pass or are explicitly marked N/A with a stated reason.

> **中文翻译**：对于每个故事文件，评估以下每一项。只有当所有项通过或明确标记为 N/A 并说明理由时，故事才 READY。

### Design Completeness / 设计完整性

- [ ] **GDD requirement referenced**: The story includes a `design/gdd/` path
  and quotes or links a specific requirement, acceptance criterion, or rule from
  that GDD — not just the GDD filename. A link to the document without tracing
  to a specific requirement does not pass. / **已引用 GDD 需求**：故事包含 `design/gdd/` 路径并引用或链接该 GDD 中的具体需求、验收标准或规则——而不仅仅是 GDD 文件名。仅链接文档而未追溯到具体需求不通过。
- [ ] **Requirement is self-contained**: The acceptance criteria in the story
  are understandable without opening the GDD. A developer should not need to
  read a separate document to understand what DONE means. / **需求是自包含的**：故事中的验收标准无需打开 GDD 即可理解。开发者不需要阅读单独的文档来理解 DONE 的含义。
- [ ] **Acceptance criteria are testable**: Each criterion is a specific,
  observable condition — not "implement X" or "the system works correctly".
  Bad example: "Implement the jump mechanic." Good example: "Jump reaches
  max height of 5 units within 0.3 seconds when jump is held." / **验收标准可测试**：每个标准都是具体的、可观察的条件——不是"实现 X"或"系统正常工作"。错误示例："实现跳跃机制。"正确示例："按住跳跃键时在 0.3 秒内达到最大高度 5 个单位。"
- [ ] **No acceptance criteria require judgment calls**: Criteria like
  "feels responsive" or "looks good" are not testable without a defined
  benchmark. These must be replaced with specific observable conditions or
  playtest protocols. / **没有需要主观判断的验收标准**：如"感觉响应灵敏"或"看起来不错"等标准在没有定义基准的情况下不可测试。必须替换为具体的可观察条件或试玩协议。

### Architecture Completeness / 架构完整性

- [ ] **ADR referenced or N/A stated**: The story references at least one ADR,
  OR explicitly states "No ADR applies" with a brief reason.
  A story with no ADR reference and no explicit N/A note fails this check. / **已引用 ADR 或声明 N/A**：故事引用至少一个 ADR，或明确声明"无适用 ADR"并简述原因。没有 ADR 引用且无明确 N/A 注释的故事此项检查失败。
- [ ] **ADR is Accepted (not Proposed)**: For each referenced ADR, check its
  `Status:` field using the cached ADR statuses loaded in Section 2.
  - If `Status: Accepted` → pass. / 通过。
  - If `Status: Proposed` → **BLOCKED**: the ADR may change before it is accepted,
    and the story's implementation guidance could be wrong.
    Fix: `BLOCKED: ADR-NNNN is Proposed — wait for acceptance before implementing.` / → **BLOCKED**：ADR 可能在被接受前更改，故事的实现指导可能是错误的。修复：`BLOCKED: ADR-NNNN 为 Proposed — 等待接受后再实现。`
  - If the ADR file does not exist → **BLOCKED**: referenced ADR is missing. / → **BLOCKED**：引用的 ADR 缺失。
  - Auto-pass if story has an explicit "No ADR applies" N/A note. / 如果故事有明确的"无适用 ADR"N/A 注释则自动通过。
- [ ] **TR-ID is valid and active**: If the story contains a `TR-[system]-NNN`
  reference, look it up in the TR registry loaded in Section 2.
  - If the ID exists and `status: active` → pass. / → 通过。
  - If the ID exists and `status: deprecated` or `status: superseded-by: ...` →
    NEEDS WORK: the requirement was removed or replaced.
    Fix: update the story to reference the current requirement ID or remove if no longer applicable. / → NEEDS WORK：需求已被移除或替换。修复：更新故事以引用当前需求 ID，如不再适用则移除。
  - If the ID does not exist in the registry → NEEDS WORK: ID was not registered
    (story may predate registry, or registry needs an `/architecture-review` run). / → NEEDS WORK：ID 未注册（故事可能早于注册表，或注册表需要运行 `/architecture-review`）。
  - Auto-pass if the story has no TR-ID reference OR if the registry does not exist. / 如果故事没有 TR-ID 引用或注册表不存在则自动通过。
- [ ] **Manifest version is current**: If the story has a `Manifest Version:` date
  in its header AND `docs/architecture/control-manifest.md` exists:
  - If story version matches current manifest `Manifest Version:` → pass. / → 通过。
  - If story version is older than current manifest → NEEDS WORK: new rules may
    apply. Fix: review changed manifest rules, update story if any forbidden/required
    entries changed, then update the story's `Manifest Version:` to current. / → NEEDS WORK：可能有新规则适用。修复：审查已变更的控制清单规则，如有禁止/必需条目变更则更新故事，然后更新故事的 `Manifest Version:` 为当前版本。
  - Auto-pass if either the story has no `Manifest Version:` field OR the manifest
    does not exist. / 如果故事没有 `Manifest Version:` 字段或控制清单不存在则自动通过。
- [ ] **Engine notes present**: For any post-cutoff engine API this story
  is likely to touch, implementation notes or a verification requirement are
  included. If the story clearly does not touch engine APIs (e.g., it is a
  pure data/config change), "N/A — no engine API involved" is acceptable. / **引擎说明存在**：对于本故事可能涉及的任何截止日期后的引擎 API，包含实现说明或验证要求。如果故事明确不涉及引擎 API（如纯数据/配置更改），"N/A — 不涉及引擎 API"是可接受的。
- [ ] **Control manifest rules noted**: Relevant layer rules from the control
  manifest are referenced, OR "N/A — manifest not yet created" is stated.
  This item auto-passes if `docs/architecture/control-manifest.md` does not
  exist yet (do not penalize stories written before the manifest was created). / **已注明控制清单规则**：引用了控制清单中的相关层规则，或声明"N/A — 控制清单尚未创建"。如果 `docs/architecture/control-manifest.md` 尚不存在则此项自动通过（不惩罚在控制清单创建之前编写的故事）。

### Scope Clarity / 范围清晰度

- [ ] **Estimate present**: The story includes a size estimate (hours,
  points, or a t-shirt size). A story with no estimate cannot be planned. / **估算存在**：故事包含大小估算（小时、点数或 T 恤尺码）。没有估算的故事无法被规划。
- [ ] **In-scope / Out-of-scope boundary stated**: The story states what
  it does NOT include, either in an explicit Out of Scope section or in
  language that makes the boundary unambiguous. Without this, scope creep
  during implementation is likely. / **已声明范围内/范围外边界**：故事声明了它不包含的内容，无论是在明确的"范围外"部分中，还是以使边界无歧义的语言表述。没有这个，实现过程中范围蔓延的可能性很高。
- [ ] **Story dependencies listed**: If this story depends on other stories
  being DONE first, those story IDs are listed. If there are no dependencies,
  "None" is explicitly stated (not just omitted). / **已列出故事依赖**：如果此故事依赖于其他故事先完成，则列出这些故事 ID。如果没有依赖，明确声明"无"（而不仅仅是省略）。

### Open Questions / 开放问题

- [ ] **No unresolved design questions**: The story does not contain text
  flagged as "UNRESOLVED", "TBD", "TODO", "?", or equivalent markers in
  any acceptance criterion, implementation note, or rule statement. / **无未解决的设计问题**：故事的任何验收标准、实现说明或规则声明中不包含标记为"UNRESOLVED"、"TBD"、"TODO"、"?"或等效标记的文本。
- [ ] **Dependency stories are not in DRAFT**: For each story listed as a
  dependency, check if the file exists and does not have a DRAFT status. A
  story that depends on a DRAFT or missing story is BLOCKED, not just
  NEEDS WORK. / **依赖故事不在 DRAFT 状态**：对于列作依赖的每个故事，检查文件是否存在且不具有 DRAFT 状态。依赖于 DRAFT 或缺失故事的故事是 BLOCKED，而不仅仅是 NEEDS WORK。

### Asset References Check / 资产引用检查

- [ ] **Referenced assets exist**: Scan the story text for asset path patterns
  (paths containing `assets/`, or file extensions `.png`, `.jpg`, `.svg`,
  `.wav`, `.ogg`, `.mp3`, `.glb`, `.gltf`, `.tres`, `.tscn`, `.res`).
  - For each asset path found: use Glob to check whether the file exists. / 找到的每个资产路径：使用 Glob 检查文件是否存在。
  - If any referenced asset does not exist: **NEEDS WORK** — note the missing
    path(s). (The story references assets that have not been created yet.
    Either remove the reference, create a placeholder, or mark it as an
    explicit dependency on an asset creation story.) / 如果任何引用的资产不存在：**NEEDS WORK** — 记录缺失的路径。（故事引用了尚未创建的资产。要么移除引用、创建占位符，要么将其标记为对资产创建故事的显式依赖。）
  - If all referenced assets exist: note "Referenced assets verified:
    [count] found." / 如果所有引用的资产都存在：记录"引用资产已验证：找到 [count] 个。"
  - If no asset paths are referenced in the story: note "No asset references
    found in story — skipping asset check." This item auto-passes. / 如果故事中未引用任何资产路径：记录"故事中未找到资产引用 — 跳过资产检查。"此项自动通过。
  - This is an existence-only check. Do not validate file format or content. / 这仅是存在性检查。不验证文件格式或内容。

### Definition of Done / 完成定义

- [ ] **At least 3 testable acceptance criteria**: Fewer than 3 suggests
  the story is either trivially small (should it be a story?) or under-specified. / **至少 3 个可测试的验收标准**：少于 3 个意味着故事要么过于微小（它应该是一个故事吗？）要么规格不足。
- [ ] **Performance budget noted if applicable**: If this story touches any
  part of the gameplay loop, rendering, or physics, a performance budget or
  a "no performance impact expected — [reason]" note is present. / **如适用已注明性能预算**：如果此故事涉及游戏玩法循环、渲染或物理的任何部分，则存在性能预算或"预期无性能影响 — [原因]"的注释。
- [ ] **Story Type declared**: The story includes a `Type:` field in its header
  identifying the test category (Logic / Integration / Visual/Feel / UI / Config/Data).
  Without this, test evidence requirements cannot be enforced at story close.
  Fix: Add `Type: [Logic|Integration|Visual/Feel|UI|Config/Data]` to the story header. / **已声明故事类型**：故事头部包含 `Type:` 字段，标识测试类别（Logic / Integration / Visual/Feel / UI / Config/Data）。没有此字段，故事关闭时无法强制执行测试证据要求。修复：在故事头部添加 `Type: [Logic|Integration|Visual/Feel|UI|Config/Data]`。
- [ ] **Test evidence requirement is clear**: If the Story Type is set, the story
  includes a `## Test Evidence` section stating where evidence will be stored
  (test file path for Logic/Integration, or evidence doc path for Visual/Feel/UI).
  Fix: Add `## Test Evidence` with the expected evidence location for the story's type. / **测试证据要求明确**：如果设置了故事类型，故事包含 `## Test Evidence` 部分，说明证据将存储在哪里（Logic/Integration 的测试文件路径，或 Visual/Feel/UI 的证据文档路径）。修复：添加 `## Test Evidence` 并附上故事类型对应的预期证据位置。

---

## 4. Verdict Assignment / 4. 裁决分配

Assign one of three verdicts per story:

> **中文翻译**：为每个故事分配以下三种裁决之一：

**READY** — All checklist items pass or have explicit N/A justifications.
The story can be assigned immediately.

> **中文翻译**：**READY** — 所有检查清单项通过或有明确的 N/A 理由。故事可立即分配。

**NEEDS WORK** — One or more checklist items fail, but all dependency stories
exist and are not DRAFT. The story can be fixed before assignment.

> **中文翻译**：**NEEDS WORK** — 一个或多个检查清单项失败，但所有依赖故事存在且不在 DRAFT 状态。故事可在分配前修复。

**BLOCKED** — One or more dependency stories are missing or in DRAFT state,
OR a critical design question (flagged UNRESOLVED in a criterion or rule) has
no owner. The story cannot be assigned until the blocker is resolved. Note:
a story that is BLOCKED may also have NEEDS WORK items — list both.

> **中文翻译**：**BLOCKED** — 一个或多个依赖故事缺失或处于 DRAFT 状态，或关键设计问题（在标准或规则中标记为 UNRESOLVED）无负责人。在阻塞问题解决前故事无法分配。注意：BLOCKED 的故事可能同时有 NEEDS WORK 项 — 两者都列出。

---

## 5. Output Format / 5. 输出格式

### Single story output / 单故事输出

```
## Story Readiness: [story title]
File: [path]
Verdict: [READY / NEEDS WORK / BLOCKED]

### Passing Checks (N/[total])
[list passing items briefly]

### Gaps
- [Checklist item]: [exact description of what is missing or wrong]
  Fix: [specific text needed to resolve this gap]

### Blockers (if BLOCKED)
- [What is blocking]: [story ID or design question that must resolve first]
```

### Multiple story aggregate output / 多故事汇总输出

```
## Story Readiness Summary — [scope] — [date]

Ready:      [N] stories
Needs Work: [N] stories
Blocked:    [N] stories

### Ready Stories
- [story title] ([path])

### Needs Work
- [story title]: [primary gap — one line]
- [story title]: [primary gap — one line]

### Blocked Stories
- [story title]: Blocked by [story ID / design question]

---
[Full detail for each non-ready story follows, using the single-story format]
```

### Sprint escalation / 冲刺升级

If the scope is `sprint` and any Must Have stories are NEEDS WORK or BLOCKED,
add a prominent warning at the top of the output:

> **中文翻译**：如果范围为 `sprint` 且有任何 Must Have 故事为 NEEDS WORK 或 BLOCKED，在输出顶部添加醒目警告：

```
WARNING: [N] Must Have stories are not implementation-ready.
[List them with their primary gap or blocker.]
Resolve these before the sprint begins or replan with `/sprint-plan update`.
```

---

## 6. Collaborative Protocol / 6. 协作协议

This skill is read-only. It never proposes edits or asks to write files.

> **中文翻译**：此技能是只读的。它从不提议编辑或请求写入文件。

After reporting findings, offer:

> **中文翻译**：报告发现后，提供以下选项：

"Would you like help filling in the gaps for any of these stories? I can
draft the missing sections for your approval."

> **中文翻译**："您需要帮助填补这些故事的差距吗？我可以为您起草缺失的部分供您审批。"

If the user says yes for a specific story, draft only the missing sections
in conversation. Do not use Write or Edit tools — the user (or
`/create-stories`) handles writing.

> **中文翻译**：如果用户对某个故事说"是"，仅在对话中起草缺失的部分。不要使用 Write 或 Edit 工具 — 用户（或 `/create-stories`）负责写入。

**Redirect rules:** / **重定向规则：**
- If a story file does not exist at all: "This story file is missing entirely.
  Run `/create-epics [layer]` then `/create-stories [epic-slug]` to generate stories from the GDD and ADR." / 如果故事文件完全不存在："此故事文件完全缺失。运行 `/create-epics [layer]` 然后 `/create-stories [epic-slug]` 从 GDD 和 ADR 生成故事。"
- If a story has no GDD reference and the work appears small: "This story has
  no GDD reference. If the change is small (under ~4 hours), run
  `/quick-design [description]` to create a Quick Design Spec, then reference
  that spec in the story." / 如果故事没有 GDD 引用且工作看起来很小："此故事没有 GDD 引用。如果变更很小（约 4 小时以内），运行 `/quick-design [描述]` 创建快速设计规格，然后在故事中引用该规格。"
- If a story's scope has grown beyond its original sizing: "This story appears
  to have expanded in scope. Consider splitting it or escalating to the producer
  before implementation begins." / 如果故事的范围已超出其原始规模："此故事似乎范围已扩大。考虑拆分或在实现开始前升级给制作人。"

---

## 7. Next-Story Handoff / 7. 下一故事交接

After completing a single-story readiness check (not `all` or `sprint` scope):

> **中文翻译**：完成单故事就绪度检查后（非 `all` 或 `sprint` 范围）：

1. Read the current sprint file from `production/sprints/` (most recent). / 从 `production/sprints/` 读取当前冲刺文件（最新的）。
2. Find stories that are: / 查找满足以下条件的故事：
   - Status: READY or NOT STARTED / 状态：READY 或 NOT STARTED
   - Not the story just checked / 不是刚检查的故事
   - Not blocked by incomplete dependencies / 未被未完成的依赖阻塞
   - In the Must Have or Should Have tier / 属于 Must Have 或 Should Have 层级

If any are found, surface up to 3:

> **中文翻译**：如果找到任何故事，展示最多 3 个：

```
### Other Ready Stories in This Sprint

1. [Story name] — [1-line description] — Est: [X hrs]
2. [Story name] — [1-line description] — Est: [X hrs]

Run `/story-readiness [path]` to validate before starting.
```

If no sprint file exists or no other ready stories are found, skip this section silently.

> **中文翻译**：如果不存在冲刺文件或未找到其他就绪故事，静默跳过此部分。

---

## Phase 8: Director Gate — Story Readiness Review / 第 8 阶段：总监门控 — 故事就绪度审查

Apply the review mode resolved in Phase 0 before spawning QL-STORY-READY:

> **中文翻译**：在派生 QL-STORY-READY 之前，应用第 0 阶段解决的审查模式：

- `solo` → skip. Note: "QL-STORY-READY skipped — Solo mode." Proceed to close.
- `lean` → skip. Note: "QL-STORY-READY skipped — Lean mode." Proceed to close.
- `full` → spawn as normal.

> **中文翻译**：`solo` → 跳过。注意："QL-STORY-READY 已跳过 — Solo 模式。"继续关闭。`lean` → 跳过。注意："QL-STORY-READY 已跳过 — Lean 模式。"继续关闭。`full` → 正常派生。

Spawn `qa-lead` via Task using gate **QL-STORY-READY** (`.codebuddy/docs/director-gates.md`).

> **中文翻译**：通过 Task 使用门控 **QL-STORY-READY** 派生 `qa-lead`（`.codebuddy/docs/director-gates.md`）。

Pass the following context: / 传递以下上下文：
- Story title / 故事标题
- Acceptance criteria list (all items from the story's acceptance criteria section) / 验收标准列表（故事验收标准部分的所有项）
- Dependency status (all dependencies listed and their current state: exist / DRAFT / missing) / 依赖状态（所有列出的依赖及其当前状态：exist / DRAFT / missing）
- Overall verdict (READY / NEEDS WORK / BLOCKED) from Phase 4 / 第 4 阶段的整体裁决（READY / NEEDS WORK / BLOCKED）

Handle the verdict per standard rules in `director-gates.md`: / 按照 `director-gates.md` 中的标准规则处理裁决：
- **ADEQUATE** → story is cleared. Proceed to close. / → 故事已通过。继续关闭。
- **GAPS [list]** → surface the specific gaps to the user via `AskUserQuestion`:
  options: `Update story with suggested gaps` / `Accept and proceed anyway` / `Discuss further`. / → 通过 `AskUserQuestion` 向用户展示具体差距：选项：`按建议差距更新故事` / `接受并继续` / `进一步讨论`。
- **INADEQUATE** → surface the specific gaps; ask user whether to update the story or proceed anyway. / → 向用户展示具体差距；询问用户是更新故事还是继续。

---

## Recommended Next Steps / 推荐的下一步

- Run `/dev-story [story-path]` to begin implementation once the story is READY / 故事 READY 后运行 `/dev-story [story-path]` 开始实现
- Run `/story-readiness sprint` to check all stories in the current sprint at once / 运行 `/story-readiness sprint` 一次性检查当前冲刺中的所有故事
- Run `/create-stories [epic-slug]` if a story file is missing entirely / 如果故事文件完全缺失则运行 `/create-stories [epic-slug]`
