---
name: dev-story
description: "Read a story file and implement it. Loads the full context (story, GDD requirement, ADR guidelines, control manifest), routes to the right programmer agent for the system and engine, implements the code and test, and confirms each acceptance criterion. The core implementation skill — run after /story-readiness, before /code-review and /story-done. / 读取故事文件并实现它。加载完整上下文（故事、GDD 需求、ADR 指导、控制清单），路由到适合系统和引擎的程序员代理，实现代码和测试，并确认每个验收标准。核心实现技能 — 在 /story-readiness 之后、/code-review 和 /story-done 之前运行。"
argument-hint: "[story-path]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Bash, Task, AskUserQuestion
---

# Dev Story
> **中文翻译**：# 开发故事


This skill bridges planning and code. It reads a story file in full, assembles all the context a programmer needs, routes to the correct specialist agent, and drives implementation to completion — including writing the test.
> **中文翻译**：这项技能连接了规划和代码。它完整​​读取故事文件，组合程序员所需的所有上下文，路由到正确的专家代理，并推动实现完成 - 包括编写测试。


**The loop for every story:**
> **中文翻译**：**每个故事的循环：**

```
/qa-plan sprint           ← define test requirements before sprint begins
/story-readiness [path]   ← validate before starting
/dev-story [path]         ← implement it  (this skill)
/code-review [files]      ← review it
/story-done [path]        ← verify and close it
```

**After all sprint stories are done:** run `/team-qa sprint` to execute the full QA cycle and get a sign-off verdict before advancing the project stage.
> **中文翻译**：**所有冲刺故事完成后：**运行“/team-qa sprint”来执行完整的质量保证周期，并在推进项目阶段之前获得签核裁决。


**Output:** Source code + test file in the project's `src/` and `tests/` directories.
> **中文翻译**：**输出：** 项目`src/`和`tests/`目录中的源代码+测试文件。


---

## Phase 1: Find the Story

**If a path is provided**: read that file directly.

**If no argument**: check `production/session-state/active.md` for the active
story. If found, confirm: "Continuing work on [story title] — is that correct?"
If not found, ask: "Which story are we implementing?" Glob
`production/epics/**/*.md` and list stories with Status: Ready.

---

## Phase 2: Load Full Context
> **中文翻译**：## 第 2 阶段：加载完整上下文


**Before loading any context, verify required files exist.** Extract the ADR path from the story's `ADR Governing Implementation` field, then check:
> **中文翻译**：**在加载任何上下文之前，验证所需的文件是否存在。** 从故事的“ADR Governing Implement”字段中提取 ADR 路径，然后检查：


| File | Path | If missing |
  <!-- 翻译: 文件 -->
  <!-- 翻译: 小路 -->
  <!-- 翻译: 如果丢失 -->
|------|------|------------|
| TR registry | `docs/architecture/tr-registry.yaml` | **STOP** — "TR registry not found. Run `/create-epics` to generate it." |
  <!-- 翻译: TR 注册表 -->
  <!-- 翻译: `docs/architecture/tr-registry.yaml` -->
  <!-- 翻译: **停止** — “未找到 TR 注册表。运行 `/create-epics` 来生成它。” -->
| Governing ADR | path from story's ADR field | **STOP** — "ADR file [path] not found. Run `/architecture-decision` to create it, or correct the filename in the story's ADR field." |
  <!-- 翻译: 管辖 ADR -->
  <!-- 翻译: 从故事的 ADR 字段开始的路径 -->
  <!-- 翻译: **停止** —“未找到 ADR 文件 [路径]。运行 `/architecture-decision` 创建它，或者更正故事 ADR 字段中的文件名。” -->
| Control manifest | `docs/architecture/control-manifest.md` | **WARN and continue** — "Control manifest not found — layer rules cannot be checked. Run `/create-control-manifest`." |
  <!-- 翻译: 控制清单 -->
  <!-- 翻译: `文档/架构/control-manifest.md` -->
  <!-- 翻译: **警告并继续** —“未找到控制清单 - 无法检查层规则。运行`/create-control-manifest`。” -->


If the TR registry or governing ADR is missing, set the story status to **BLOCKED** in the session state and do not spawn any programmer agent.
> **中文翻译**：如果 TR 注册表或管理 ADR 丢失，请将会话状态中的故事状态设置为 **BLOCKED** 并且不生成任何程序员代理。


Read all of the following simultaneously — these are independent reads. Do not start implementation until all context is loaded:
> **中文翻译**：同时阅读以下所有内容——这些是独立的阅读。在加载所有上下文之前不要开始实施：


### The story file Extract and hold:
> **中文翻译**：### 故事文件解压并保存：

- **Story title, ID, layer, type** (Logic / Integration / Visual/Feel / UI / Config/Data)
  > **中文翻译**：**故事标题、ID、图层、类型**（逻辑/集成/视觉/感觉/UI/配置/数据）
- **TR-ID** — the GDD requirement identifier
  > **中文翻译**：**TR-ID** — GDD 要求标识符
- **Governing ADR** reference
  > **中文翻译**：**管理 ADR** 参考
- **Manifest Version** embedded in story header
  > **中文翻译**：**清单版本**嵌入故事标题中
- **Acceptance Criteria** — every checkbox item, verbatim
  > **中文翻译**：**验收标准** — 每个复选框项目逐字记录
- **Implementation Notes** — the ADR guidance section in the story
  > **中文翻译**：**实施说明** — 故事中的 ADR 指导部分
- **Out of Scope** boundaries
  > **中文翻译**：**超出范围**边界
- **Test Evidence** — the required test file path
  > **中文翻译**：**测试证据** — 所需的测试文件路径
- **Dependencies** — what must be DONE before this story
  > **中文翻译**：**依赖关系** — 在这个故事之前必须完成什么


### The TR registry Read `docs/architecture/tr-registry.yaml`. Look up the story's TR-ID. Read the current `requirement` text — this is the source of truth for what the GDD requires now. Do not rely on any inline text in the story file (may be stale).
> **中文翻译**：### TR 注册表 阅读 `docs/architecture/tr-registry.yaml`。 Look up the story's TR-ID.阅读当前的“要求”文本——这是 GDD 现在要求的事实来源。不要依赖故事文件中的任何内嵌文本（可能已过时）。


### The governing ADR Read `docs/architecture/[adr-file].md`. Extract:
> **中文翻译**：### 管理 ADR 阅读 `docs/architecture/[adr-file].md`。提炼：

- The full Decision section
  > **中文翻译**：完整的决策部分
- The Implementation Guidelines section (this is what the programmer follows)
  > **中文翻译**：实施指南部分（这是程序员遵循的）
- The Engine Compatibility section (post-cutoff APIs, known risks)
  > **中文翻译**：引擎兼容性部分（截止后 API、已知风险）
- The ADR Dependencies section
  > **中文翻译**：ADR 依赖性部分


### The control manifest Read `docs/architecture/control-manifest.md`. Extract the rules for this story's layer:
> **中文翻译**：### 控制清单 阅读 `docs/architecture/control-manifest.md`。提取该故事层的规则：

- Required patterns
  > **中文翻译**：所需图案
- Forbidden patterns
  > **中文翻译**：禁止的图案
- Performance guardrails
  > **中文翻译**：性能护栏


Check: does the story's embedded Manifest Version match the current manifest header date? If they differ, use `AskUserQuestion` before proceeding:
> **中文翻译**：检查：故事的嵌入清单版本是否与当前清单标题日期匹配？如果它们不同，请在继续之前使用“AskUserQuestion”：

- Prompt: "Story was written against manifest v[story-date]. Current manifest is v[current-date]. New rules may apply. How do you want to proceed?"
  > **中文翻译**：提示：“故事是根据清单 v[故事日期] 编写的。当前清单是 v[当前日期]。可能会应用新规则。您要如何继续？”
- Options:
  > **中文翻译**：选项：
  - `[A] Update story manifest version and implement with current rules (Recommended)`
  > **中文翻译**：`[A] 更新故事清单版本并按照当前规则实施（推荐）`
  - `[B] Implement with old rules — I accept the risk of non-compliance`
  > **中文翻译**：“[B] 按照旧规则实施——我接受不遵守规定的风险”
  - `[C] Stop here — I want to review the manifest diff first`
  > **中文翻译**：`[C] 停在这里 - 我想先查看清单差异`


If [A]: edit the story file's `Manifest Version:` field to the current manifest date before spawning the programmer. Then read the manifest carefully for new rules. If [B]: read the manifest carefully for new rules anyway, and note the version mismatch in the Phase 6 summary under "Deviations". If [C]: stop. Do not spawn any agent. Let the user review and re-run `/dev-story`.
> **中文翻译**：如果 [A]：在生成程序员之前将故事文件的“清单版本：”字段编辑为当前清单日期。然后仔细阅读清单以了解新规则。如果 [B]：无论如何都要仔细阅读清单以了解新规则，并注意“偏差”下第 6 阶段摘要中的版本不匹配。如果[C]：停止。不要生成任何代理。让用户查看并重新运行“/dev-story”。


### Dependency validation
> **中文翻译**：### 依赖验证


After extracting the **Dependencies** list from the story file, validate each:
> **中文翻译**：从故事文件中提取 **依赖项** 列表后，验证每个：


1. Glob `production/epics/**/*.md` to find each dependency story file.
  > **中文翻译**：Glob ` Production/epics/**/*.md` 来查找每个依赖故事文件。
2. Read its `Status:` field.
  > **中文翻译**：阅读其“状态：”字段。
3. If any dependency has Status other than `Complete` or `Done`:
  > **中文翻译**：如果任何依赖项的状态不是“Complete”或“Done”：
   - Use `AskUserQuestion`:
  > **中文翻译**：使用“询问用户问题”：
     - Prompt: "Story '[current story]' depends on '[dependency title]' which is currently [status], not Complete. How do you want to proceed?"
  > **中文翻译**：提示：“故事‘[当前故事]’依赖于‘[依赖标题]’，当前为[状态]，而不是完成。您想如何继续？”
     - Options:
  > **中文翻译**：选项：
       - `[A] Proceed anyway — I accept the dependency risk`
  > **中文翻译**：“[A] 无论如何都要继续——我接受依赖风险”
       - `[B] Stop — I'll complete the dependency first`
  > **中文翻译**：`[B] 停止 - 我将首先完成依赖项`
       - `[C] The dependency is done but status wasn't updated — mark it Complete and continue`
  > **中文翻译**：`[C] 依赖关系已完成，但状态未更新 - 将其标记为完成并继续`
   - If [B]: set story status to **BLOCKED** in session state and stop. Do not spawn any programmer agent.
  > **中文翻译**：如果[B]：在会话状态中将故事状态设置为 **BLOCKED** 并停止。不要产生任何程序员代理。
   - If [C]: ask "May I update [dependency path] Status to Complete?" before continuing.
  > **中文翻译**：如果 [C]：询问“我可以将 [依赖路径] 状态更新为完成吗？”在继续之前。
   - If [A]: note in Phase 6 summary under "Deviations": "Implemented with incomplete dependency: [dependency title] — [status]."
  > **中文翻译**：如果 [A]：第 6 阶段摘要中“偏差”下的注释：“以不完全依赖项实现：[依赖项标题] — [状态]。”


If a dependency file cannot be found: warn "Dependency story not found: [path]. Verify the path or create the story file."
> **中文翻译**：如果找不到依赖项文件：警告“未找到依赖项故事：[路径]。验证路径或创建故事文件。”


---

### Engine reference
Read `.codebuddy/docs/technical-preferences.md`:
- `Engine:` value — determines which programmer agents to use
- Naming conventions (class names, file names, signal/event names)
- Performance budgets (frame budget, memory ceiling)
- Forbidden patterns

---

## Phase 3: Route to the Right Programmer
> **中文翻译**：## 第三阶段：找到合适的程序员


Based on the story's **Layer**, **Type**, and **system name**, determine which specialist to spawn via Task.
> **中文翻译**：根据故事的**层**、**类型**和**系统名称**，确定通过任务生成哪个专家。


**Config/Data stories — skip agent spawning entirely:** If the story's Type is `Config/Data`, no programmer agent or engine specialist is needed. Jump directly to Phase 4 (Config/Data note). The implementation is a data file edit — no routing table evaluation, no engine specialist.
> **中文翻译**：**配置/数据故事 - 完全跳过代理生成：**如果故事的类型是“配置/数据”，则不需要程序员代理或引擎专家。直接跳转到第 4 阶段（配置/数据注释）。实施是数据文件编辑——没有路由表评估，没有引擎专家。


### Primary agent routing table
> **中文翻译**：### 主代理路由表


| Story context | Primary agent |
  <!-- 翻译: 故事背景 -->
  <!-- 翻译: 主代理 -->
|---|---|
| Foundation layer — any type | `engine-programmer` |
  <!-- 翻译: 基础层——任何类型 -->
  <!-- 翻译: `引擎程序员` -->
| Any layer — Type: UI | `ui-programmer` |
  <!-- 翻译: 任意层 — 类型：UI -->
  <!-- 翻译: `ui 程序员` -->
| Any layer — Type: Visual/Feel | `gameplay-programmer` (implements) |
  <!-- 翻译: 任何层 - 类型：视觉/感觉 -->
  <!-- 翻译: `游戏程序员`（实现） -->
| Core or Feature — gameplay mechanics | `gameplay-programmer` |
  <!-- 翻译: 核心或功能——游戏机制 -->
  <!-- 翻译: `游戏程序员` -->
| Core or Feature — AI behaviour, pathfinding | `ai-programmer` |
  <!-- 翻译: 核心或特征——人工智能行为、寻路 -->
  <!-- 翻译: `ai程序员` -->
| Core or Feature — networking, replication | `network-programmer` |
  <!-- 翻译: 核心或功能——网络、复制 -->
  <!-- 翻译: `网络程序员` -->
| Config/Data — no code | No agent needed (see Phase 4 Config note) |
  <!-- 翻译: 配置/数据 — 无代码 -->
  <!-- 翻译: 无需代理（请参阅第 4 阶段配置说明） -->


### Engine specialist — always spawn as secondary for code stories
> **中文翻译**：### 引擎专家 - 始终作为代码故事的辅助生成


Read the `Engine Specialists` section of `.codebuddy/docs/technical-preferences.md` to get the configured primary specialist. Spawn them alongside the primary agent when the story involves engine-specific APIs, patterns, or the ADR has HIGH engine risk.
> **中文翻译**：阅读“.codebuddy/docs/technical-preferences.md”的“Engine Specialists”部分以获取配置的主要专家。当故事涉及特定于引擎的 API、模式或 ADR 具有高引擎风险时，将它们与主要代理一起生成。


| Engine | Specialist agents available |
  <!-- 翻译: 引擎 -->
  <!-- 翻译: 提供专业代理 -->
|--------|----------------------------|
| Godot 4 | `godot-specialist`, `godot-gdscript-specialist`, `godot-shader-specialist` |
  <!-- 翻译: 戈多4 -->
  <!-- 翻译: `godot-专家`、`godot-gdscript-专家`、`godot-着色器专家` -->
| Unity | `unity-specialist`, `unity-ui-specialist`, `unity-shader-specialist` |
  <!-- 翻译: 统一 -->
  <!-- 翻译: `unity-专家`、`unity-ui-专家`、`unity-shader-专家` -->
| Unreal Engine | `unreal-specialist`, `ue-gas-specialist`, `ue-blueprint-specialist`, `ue-umg-specialist`, `ue-replication-specialist` |
  <!-- 翻译: 虚幻引擎 -->
  <!-- 翻译: `unreal-specialist`、`ue-gas-specialist`、`ue-blueprint-specialist`、`ue-umg-specialist`、`ue-replication-specialist` -->


**When engine risk is HIGH** (from the ADR or VERSION.md): always spawn the engine specialist, even for non-engine-facing stories. High risk means the ADR records assumptions about post-cutoff engine APIs that need expert verification.
> **中文翻译**：**当引擎风险较高时**（来自 ADR 或 VERSION.md）：始终生成引擎专家，即使对于非面向引擎的故事也是如此。高风险意味着 ADR 记录了有关需要专家验证的停产后发动机 API 的假设。


---

## Phase 4: Implement

Spawn the chosen programmer agent(s) via Task with the full context package:

Provide the agent with:
1. The complete story file content
2. The current GDD requirement text (from TR registry)
3. The ADR Decision + Implementation Guidelines (verbatim — do not summarise)
4. The control manifest rules for this layer
5. The engine naming conventions and performance budgets
6. Any engine-specific notes from the ADR Engine Compatibility section
7. The test file path that must be created
8. Explicit instruction: **implement this story and write the test**

The agent should:
- Create or modify files in `src/` following the ADR guidelines
- Respect all Required and Forbidden patterns from the control manifest
- Stay within the story's Out of Scope boundaries (do not touch unrelated files)
- Write clean, doc-commented public APIs

### Config/Data stories (no agent needed)

For Type: Config/Data stories, no programmer agent is required. The implementation
is editing a data file. Read the story's acceptance criteria and make the specified
changes to the data file directly. Note which values were changed and what they
changed from/to.

### Visual/Feel stories

Spawn `gameplay-programmer` to implement the code/animation calls. Note that
Visual/Feel acceptance criteria cannot be auto-verified — the "does it feel right?"
check happens in `/story-done` via manual confirmation.

---

## Phase 5: Write the Test
> **中文翻译**：## 第 5 阶段：编写测试


For **Logic** and **Integration** stories, the test must be written as part of this implementation — not deferred to later.
> **中文翻译**：对于**逻辑**和**集成**故事，测试必须作为此实现的一部分编写——而不是推迟到以后。


Remind the programmer agent:
> **中文翻译**：提醒程序员代理：


> "The test file for this story is required at: `[path from Test Evidence section]`. > The story cannot be closed via `/story-done` without it. Write the test > alongside the implementation, not after."
> **中文翻译**：> “这个故事的测试文件需要位于：`[测试证据部分的路径]`。 > 如果没有它，故事就无法通过 `/story-done` 关闭。> 在实现旁边编写测试，而不是在实现之后。”


Test requirements (from coding-standards.md):
> **中文翻译**：测试要求（来自coding-standards.md）：

- File name: `[system]_[feature]_test.[ext]`
  > **中文翻译**：文件名：`[系统]_[功能]_test.[ext]`
- Function names: `test_[scenario]_[expected_outcome]`
  > **中文翻译**：函数名称：`test_[场景]_[预期结果]`
- Each acceptance criterion must have at least one test function covering it
  > **中文翻译**：每个验收标准必须至少有一个测试函数覆盖它
- No random seeds, no time-dependent assertions, no external I/O
  > **中文翻译**：无随机种子、无时间相关断言、无外部 I/O
- Test the formula bounds from the GDD Formulas section
  > **中文翻译**：测试 GDD 公式部分的公式范围


For **Visual/Feel** and **UI** stories: no automated test. Remind the agent to note in the implementation summary what manual evidence will be needed: "Evidence doc required at `production/qa/evidence/[slug]-evidence.md`."
> **中文翻译**：对于**视觉/感觉**和**UI**故事：没有自动化测试。提醒代理在实施摘要中注明需要哪些手动证据：“`products/qa/evidence/[slug]-evidence.md` 需要证据文档。”


For **Config/Data** stories: no test file. A smoke check will serve as evidence.
> **中文翻译**：对于 **配置/数据** 故事：没有测试文件。烟雾检查将作为证据。


---

## Phase 6: Collect and Summarise

After the programmer agent(s) complete, collect:

- Files created or modified (with paths)
- Test file created (path and number of test functions written)
- Any deviations from the story's Out of Scope boundary (flag these)
- Any questions or blockers the agent surfaced
- Any engine-specific risks the specialist flagged

Present a concise implementation summary:

```
## Implementation Complete: [Story Title]

**Files changed**:
- `src/[path]` — created / modified ([brief description])
- `tests/[path]` — test file ([N] test functions)

**Acceptance criteria covered**:
- [x] [criterion] — implemented in [file:function]
- [x] [criterion] — covered by test [test_name]
- [ ] [criterion] — DEFERRED: requires playtest (Visual/Feel)

**Deviations from scope**: [None] or [list files touched outside story boundary]
**Engine risks flagged**: [None] or [specialist finding]
**Blockers**: [None] or [describe]

Ready for: `/code-review [file1] [file2]` then `/story-done [story-path]`
```

---

## Phase 7: Update Session State
> **中文翻译**：## 第 7 阶段：更新会话状态


Silently append to `production/session-state/active.md`:
> **中文翻译**：静默附加到 `product/session-state/active.md`：


```
## Session Extract — /dev-story [date]
- Story: [story-path] — [story title]
- Files changed: [comma-separated list]
- Test written: [path, or "None — Visual/Feel/Config story"]
- Blockers: [None, or description]
- Next: /code-review [files] then /story-done [story-path]
```

Create `active.md` if it does not exist. Confirm: "Session state updated."
> **中文翻译**：如果`active.md`不存在，则创建它。确认：“会话状态已更新。”


---

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
- Manifest version mismatch → show diff to user, ask whether to proceed with old rules or update story first

## Collaborative Protocol

- **File writes are delegated** — all source code, test files, and evidence docs are written by sub-agents spawned via Task. Each sub-agent enforces the "May I write to [path]?" protocol individually. This orchestrator does not write files directly.
- **Load before implementing** — do not start coding until all context is loaded
  (story, TR-ID, ADR, manifest, engine prefs). Incomplete context produces code
  that drifts from design.
- **The ADR is the law** — implementation must follow the ADR's Implementation
  Guidelines. If the guidelines conflict with what seems "better," flag it in the
  summary rather than silently deviating.
- **Stay in scope** — the Out of Scope section is a contract. If implementing
  the story requires touching an out-of-scope file, stop and surface it:
  "Implementing [criterion] requires modifying [file], which is out of scope.
  Shall I proceed or create a separate story?"
- **Test is not optional for Logic/Integration** — do not mark implementation
  complete without the test file existing
- **Visual/Feel criteria are deferred, not skipped** — mark them as DEFERRED
  in the summary; they will be manually verified in `/story-done`
- **Ask before large structural decisions** — if the story requires an
  architectural pattern not covered by the ADR, surface it before implementing:
  "The ADR doesn't specify how to handle [case]. My plan is [X]. Proceed?"

---

## Recommended Next Steps
> **中文翻译**：## 建议的后续步骤


- Run `/code-review [file1] [file2]` to review the implementation before closing the story
  > **中文翻译**：在关闭故事之前运行“/code-review [file1] [file2]”来检查实现
- Run `/story-done [story-path]` to verify acceptance criteria and mark the story complete
  > **中文翻译**：运行“/story-done [story-path]”来验证验收标准并将故事标记为完成
- After all sprint stories are done: run `/team-qa sprint` for the full QA cycle before advancing the project stage
  > **中文翻译**：所有冲刺故事完成后：在推进项目阶段之前，运行“/team-qa sprint”进行整个 QA 周期

