---
name: architecture-decision
description: "Creates an Architecture Decision Record (ADR) documenting a significant technical decision, its context, alternatives considered, and consequences. Every major technical choice should have an ADR. / 创建架构决策记录（ADR），记录重大技术决策、其上下文、考虑的替代方案和后果。每个重大技术选择都应有 ADR。"
argument-hint: "[title] [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Task, AskUserQuestion
---

When this skill is invoked:
> **中文翻译**：当此技能被调用时：

## 0. Parse Arguments — Detect Retrofit Mode / 解析参数 — 检测改造模式

Resolve the review mode (once, store for all gate spawns this run):
> **中文翻译**：解析审查模式（一次性，存储本次运行所有门生成的结果）：

1. If `--review [full|lean|solo]` was passed → use that
   > **中文翻译**：如果传入了 `--review [full|lean|solo]` → 使用该值
2. Else read `production/review-mode.txt` → use that value
   > **中文翻译**：否则读取 `production/review-mode.txt` → 使用该值
3. Else → default to `lean`
   > **中文翻译**：否则 → 默认为 `lean`

See `.codebuddy/docs/director-gates.md` for the full check pattern.
> **中文翻译**：完整检查模式参见 `.codebuddy/docs/director-gates.md`。

**If the argument starts with `retrofit` followed by a file path**
> **中文翻译**：**如果参数以 `retrofit` 开头后跟文件路径**

(e.g., `/architecture-decision retrofit docs/architecture/adr-0001-event-system.md`):
> **中文翻译**：（例如，`/architecture-decision retrofit docs/architecture/adr-0001-event-system.md`）：

Enter **retrofit mode**:
> **中文翻译**：进入**改造模式**：

1. Read the existing ADR file completely.
   > **中文翻译**：完整读取现有 ADR 文件。
2. Identify which template sections are present by scanning headings:
   > **中文翻译**：通过扫描标题识别存在哪些模板章节：
   - `## Status` — **BLOCKING if missing**: `/story-readiness` cannot check ADR acceptance
     > **中文翻译**：`## Status` — **缺失时阻塞**：`/story-readiness` 无法检查 ADR 验收
   - `## ADR Dependencies` — HIGH if missing: dependency ordering breaks
     > **中文翻译**：`## ADR Dependencies` — 缺失时为高优先级：依赖排序将失效
   - `## Engine Compatibility` — HIGH if missing: post-cutoff risk unknown
     > **中文翻译**：`## Engine Compatibility` — 缺失时为高优先级：截断后风险未知
   - `## GDD Requirements Addressed` — MEDIUM if missing: traceability lost
     > **中文翻译**：`## GDD Requirements Addressed` — 缺失时为中优先级：可追溯性丢失
3. Present to the user:
   > **中文翻译**：向用户展示：
   ```
   ## Retrofit: [ADR title]
   File: [path]

   Sections already present (will not be touched):
   ✓ Status: [current value, or "MISSING — will add"]
   ✓ [section]

   Missing sections to add:
   ✗ Status — BLOCKING (stories cannot validate ADR acceptance without this)
   ✗ ADR Dependencies — HIGH
   ✗ Engine Compatibility — HIGH
   ```
4. Ask: "Shall I add the [N] missing sections? I will not modify any existing content."
   > **中文翻译**：询问："是否添加 [N] 个缺失章节？我不会修改任何现有内容。"
5. If yes:
   > **中文翻译**：如果是：
   - For **Status**: ask the user — "What is the current status of this decision?"
     > **中文翻译**：对于 **Status**：询问用户 — "此决策的当前状态是什么？"
     Options: "Proposed", "Accepted", "Deprecated", "Superseded by ADR-XXXX"
     > **中文翻译**：选项："Proposed"、"Accepted"、"Deprecated"、"Superseded by ADR-XXXX"
   - For **ADR Dependencies**: ask — "Does this decision depend on any other ADR?
     > **中文翻译**：对于 **ADR Dependencies**：询问 — "此决策是否依赖于其他 ADR？
     Does it enable or block any other ADR or epic?" Accept "None" for each field.
     > **中文翻译**：它是否启用或阻塞其他 ADR 或史诗？" 每个字段接受 "None"。"
   - For **Engine Compatibility**: read the engine reference docs (same as Step 0 below)
     > **中文翻译**：对于 **Engine Compatibility**：读取引擎参考文档（与下方步骤 0 相同）
     and ask the user to confirm the domain. Then generate the table with verified data.
     > **中文翻译**：并请用户确认领域。然后使用验证数据生成表格。
   - For **GDD Requirements Addressed**: ask — "Which GDD systems motivated this decision?
     > **中文翻译**：对于 **GDD Requirements Addressed**：询问 — "哪些 GDD 系统推动了此决策？
     What specific requirement in each GDD does this ADR address?"
     > **中文翻译**：每个 GDD 中的哪个具体需求与此 ADR 相关？"
   - Append each missing section to the ADR file using the Edit tool.
     > **中文翻译**：使用 Edit 工具将每个缺失章节追加到 ADR 文件。
   - **Never modify any existing section.** Only append or fill absent sections.
     > **中文翻译**：**永远不要修改任何现有章节。** 仅追加或填充缺失章节。
6. After adding all missing sections, update the ADR's `## Date` field if it is absent.
   > **中文翻译**：添加所有缺失章节后，如果 ADR 的 `## Date` 字段缺失则更新它。
7. Suggest: "Run `/architecture-review` to re-validate coverage now that this ADR
   > **中文翻译**：建议："运行 `/architecture-review` 以重新验证覆盖率，既然此 ADR

   has its Status and Dependencies fields."
   > **中文翻译**：已具有 Status 和 Dependencies 字段。"

If NOT in retrofit mode, proceed to Step 0 below (normal ADR authoring).
> **中文翻译**：如果不在改造模式，则继续下方的步骤 0（正常 ADR 编写）。

**No-argument guard**: If no argument was provided (title is empty), ask before
running Phase 0:
> **中文翻译**：**无参数守卫**：如果未提供参数（标题为空），在运行阶段 0 之前询问：

> "What technical decision are you documenting? Please provide a short title
> (e.g., `event-system-architecture`, `physics-engine-choice`)."
> **中文翻译**："你正在记录什么技术决策？请提供一个简短标题（例如，`event-system-architecture`、`physics-engine-choice`）。"

Use the user's response as the title, then proceed to Step 0.
> **中文翻译**：使用用户的回复作为标题，然后继续步骤 0。

---

## 0. Load Engine Context (ALWAYS FIRST) / 加载引擎上下文（始终首先执行）

Before doing anything else, establish the engine environment:
> **中文翻译**：在做任何其他事情之前，建立引擎环境：

1. Read `docs/engine-reference/[engine]/VERSION.md` to get:
   > **中文翻译**：读取 `docs/engine-reference/[engine]/VERSION.md` 以获取：
   - Engine name and version
     > **中文翻译**：引擎名称和版本
   - LLM knowledge cutoff date
     > **中文翻译**：LLM 知识截断日期
   - Post-cutoff version risk levels (LOW / MEDIUM / HIGH)
     > **中文翻译**：截断后版本风险级别（LOW / MEDIUM / HIGH）

2. Identify the **domain** of this architecture decision from the title or
   user description. Common domains: Physics, Rendering, UI, Audio, Navigation,
   Animation, Networking, Core, Input, Scripting.
   > **中文翻译**：从标题或用户描述中识别此架构决策的**领域**。常见领域：Physics、Rendering、UI、Audio、Navigation、Animation、Networking、Core、Input、Scripting。

3. Read the corresponding module reference if it exists:
   `docs/engine-reference/[engine]/modules/[domain].md`
   > **中文翻译**：读取对应的模块参考文档（如果存在）：`docs/engine-reference/[engine]/modules/[domain].md`

4. Read `docs/engine-reference/[engine]/breaking-changes.md` — flag any
   changes in the relevant domain that post-date the LLM's training cutoff.
   > **中文翻译**：读取 `docs/engine-reference/[engine]/breaking-changes.md` — 标记相关领域中晚于 LLM 训练截断日期的任何变更。

5. Read `docs/engine-reference/[engine]/deprecated-apis.md` — flag any APIs
   in the relevant domain that should not be used.
   > **中文翻译**：读取 `docs/engine-reference/[engine]/deprecated-apis.md` — 标记相关领域中不应使用的任何 API。

6. **Display a knowledge gap warning** before proceeding if the domain carries
   MEDIUM or HIGH risk:
   > **中文翻译**：**如果领域具有 MEDIUM 或 HIGH 风险，在继续之前显示知识差距警告**：

   ```
   ⚠️  ENGINE KNOWLEDGE GAP WARNING
   Engine: [name + version]
   Domain: [domain]
   Risk Level: HIGH — This version is post-LLM-cutoff.

   Key changes verified from engine-reference docs:
   - [Change 1 relevant to this domain]
   - [Change 2]

   This ADR will be cross-referenced against the engine reference library.
   Proceed with verified information only — do NOT rely solely on training data.
   ```

   If no engine has been configured yet, prompt: "No engine is configured.
   Run `/setup-engine` first, or tell me which engine you are using."
   > **中文翻译**：如果尚未配置引擎，提示："未配置引擎。请先运行 `/setup-engine`，或告诉我你使用的引擎。"

---

## 1. Determine the next ADR number / 确定下一个 ADR 编号

Scan `docs/architecture/` for existing ADRs to find the next number.
> **中文翻译**：扫描 `docs/architecture/` 中的现有 ADR 以查找下一个编号。

---

## 2. Gather context / 收集上下文

Read related code, existing ADRs, and relevant GDDs from `design/gdd/`.
> **中文翻译**：从 `design/gdd/` 读取相关代码、现有 ADR 和相关 GDD。

### 2a: Architecture Registry Check (BLOCKING gate) / 架构注册表检查（阻塞门控）

Read `docs/registry/architecture.yaml`. Extract entries relevant to this ADR's
domain and decision (grep by system name, domain keyword, or state being touched).
> **中文翻译**：读取 `docs/registry/architecture.yaml`。提取与此 ADR 领域和决策相关的条目（通过系统名称、领域关键词或被触及的状态进行 grep）。

Present any relevant stances to the user **before** the collaborative design
begins, as locked constraints:
> **中文翻译**：在协作设计开始**之前**向用户展示任何相关的立场，作为锁定约束：

```
## Existing Architectural Stances (must not contradict)

State Ownership:
  player_health → owned by health-system (ADR-0001)
  Interface: HealthComponent.current_health (read-only float)
  → If this ADR reads or writes player health, it must use this interface.

Interface Contracts:
  damage_delivery → signal pattern (ADR-0003)
  Signal: damage_dealt(amount, target, is_crit)
  → If this ADR delivers or receives damage events, it must use this signal.

Forbidden Patterns:
  ✗ autoload_singleton_coupling (ADR-0001)
  ✗ direct_cross_system_state_write (ADR-0000)
  → The proposed approach must not use these patterns.
```

If the user's proposed decision would contradict any registered stance, surface
the conflict immediately:
> **中文翻译**：如果用户提出的决策与任何已注册的立场矛盾，立即揭示冲突：

> "⚠️ Conflict: This ADR proposes [X], but ADR-[NNNN] established that [Y] is
> the accepted pattern for this purpose. Proceeding without resolving this will
> produce contradictory ADRs and inconsistent stories.
> Options: (1) Align with the existing stance, (2) Supersede ADR-[NNNN] with
> an explicit replacement, (3) Explain why this case is an exception."
> **中文翻译**："⚠️ 冲突：此 ADR 提议 [X]，但 ADR-[NNNN] 已确定 [Y] 为此目的的公认模式。不解决此冲突继续进行将产生矛盾的 ADR 和不一致的故事。选项：(1) 与现有立场保持一致，(2) 用明确的替代方案取代 ADR-[NNNN]，(3) 解释为什么此情况是例外。"

Do not proceed to Step 3 (collaborative design) until any conflict is resolved
or explicitly accepted as an intentional exception.
> **中文翻译**：在任何冲突得到解决或被明确接受为有意的例外之前，不要继续步骤 3（协作设计）。

---

## 3. Guide the decision collaboratively / 协作引导决策

Before asking anything, derive the skill's best guesses from the context already
gathered (GDDs read, engine reference loaded, existing ADRs scanned). Then present
a **confirm/adjust** prompt using `AskUserQuestion` — not open-ended questions.
> **中文翻译**：在提出任何问题之前，从已收集的上下文（已读 GDD、已加载引擎参考、已扫描现有 ADR）中推导技能的最佳猜测。然后使用 `AskUserQuestion` 呈现**确认/调整**提示 — 而不是开放式问题。

**Derive assumptions first:**
> **中文翻译**：**首先推导假设：**
- **Problem**: Infer from the title + GDD context what decision needs to be made
  > **中文翻译**：**问题**：从标题 + GDD 上下文推断需要做出什么决策
- **Alternatives**: Propose 2-3 concrete options from engine reference + GDD requirements
  > **中文翻译**：**替代方案**：从引擎参考 + GDD 需求提出 2-3 个具体选项
- **Dependencies**: Scan existing ADRs for upstream dependencies; assume None if unclear
  > **中文翻译**：**依赖**：扫描现有 ADR 查找上游依赖；如果不清楚则假设为 None
- **GDD linkage**: Extract which GDD systems the title directly relates to
  > **中文翻译**：**GDD 关联**：提取标题直接关联的 GDD 系统
- **Status**: Always `Proposed` for new ADRs — never ask the user what the status is
  > **中文翻译**：**状态**：新 ADR 始终为 `Proposed` — 永远不要询问用户状态

**Scope of assumptions tab**: Assumptions cover only: problem framing, alternative approaches, upstream dependencies, GDD linkage, and status. Schema design questions (e.g., "How should spawn timing work?", "Should data be inline or external?") are NOT assumptions — they are design decisions belonging to a separate step after the assumptions are confirmed. Do not include schema design questions in the assumptions AskUserQuestion widget.
> **中文翻译**：**假设标签页范围**：假设仅涵盖：问题框架、替代方案、上游依赖、GDD 关联和状态。架构设计问题（例如，"生成时机应该如何工作？"、"数据应该是内联还是外部？"）不是假设 — 它们是属于假设确认后单独步骤的设计决策。不要在假设 AskUserQuestion 组件中包含架构设计问题。

**After assumptions are confirmed**, if the ADR involves schema or data design choices, use a separate multi-tab `AskUserQuestion` to ask each design question independently before drafting.
> **中文翻译**：**假设确认后**，如果 ADR 涉及架构或数据设计选择，在起草之前使用单独的多标签 `AskUserQuestion` 独立询问每个设计问题。

**Present assumptions with `AskUserQuestion`:**
> **中文翻译**：**使用 `AskUserQuestion` 呈现假设：**

```
Here's what I'm assuming before drafting:

Problem: [one-sentence problem statement derived from context]
Alternatives I'll consider:
  A) [option derived from engine reference]
  B) [option derived from GDD requirements]
  C) [option from common patterns]
GDD systems driving this: [list derived from context]
Dependencies: [upstream ADRs if any, otherwise "None"]
Status: Proposed

[A] Proceed — draft with these assumptions
[B] Change the alternatives list
[C] Adjust the GDD linkage
[D] Add a performance budget constraint
[E] Something else needs changing first
```

Do not generate the ADR until the user confirms assumptions or provides corrections.
> **中文翻译**：在用户确认假设或提供修正之前，不要生成 ADR。

**After engine specialist and TD reviews return** (Step 4.5/4.6), if unresolved
decisions remain, present each one as a separate `AskUserQuestion` with the proposed
options as choices plus a free-text escape:
> **中文翻译**：**引擎专家和 TD 审查返回后**（步骤 4.5/4.6），如果仍有未解决的决策，将每个决策作为单独的 `AskUserQuestion` 呈现，提议选项作为选择加上自由文本输入：

```
Decision: [specific unresolved point]
[A] [option from specialist review]
[B] [alternative option]
[C] Different approach — I'll describe it
```

**ADR Dependencies** — derive from existing ADRs, then confirm:
> **中文翻译**：**ADR 依赖** — 从现有 ADR 推导，然后确认：
- Does this decision depend on any other ADR not yet Accepted?
  > **中文翻译**：此决策是否依赖于尚未被 Accepted 的其他 ADR？
- Does it unlock or unblock any other ADR or epic?
  > **中文翻译**：它是否解锁或解除阻塞其他 ADR 或史诗？
- Does it block any specific epic from starting?
  > **中文翻译**：它是否阻塞任何特定史诗的开始？

Record answers in the **ADR Dependencies** section. Write "None" for each field if no constraints apply.
> **中文翻译**：将答案记录在 **ADR Dependencies** 章节中。如果没有约束，每个字段写 "None"。

---

## 4. Generate the ADR / 生成 ADR

Following this format:
> **中文翻译**：按照以下格式：

```markdown
# ADR-[NNNN]: [Title]

## Status
[Proposed | Accepted | Deprecated | Superseded by ADR-XXXX]

## Date
[Date of decision]

## Engine Compatibility

| Field | Value |
|-------|-------|
| **Engine** | [e.g. Godot 4.6] |
| **Domain** | [Physics / Rendering / UI / Audio / Navigation / Animation / Networking / Core / Input] |
| **Knowledge Risk** | [LOW / MEDIUM / HIGH — from VERSION.md] |
| **References Consulted** | [List engine-reference docs read, e.g. `docs/engine-reference/godot/modules/physics.md`] |
| **Post-Cutoff APIs Used** | [Any APIs from post-LLM-cutoff versions this decision depends on, or "None"] |
| **Verification Required** | [Specific behaviours to test before shipping, or "None"] |

## ADR Dependencies

| Field | Value |
|-------|-------|
| **Depends On** | [ADR-NNNN (must be Accepted before this can be implemented), or "None"] |
| **Enables** | [ADR-NNNN (this ADR unlocks that decision), or "None"] |
| **Blocks** | [Epic/Story name — cannot start until this ADR is Accepted, or "None"] |
| **Ordering Note** | [Any sequencing constraint that isn't captured above] |

## Context

### Problem Statement
[What problem are we solving? Why does this decision need to be made now?]

### Constraints
- [Technical constraints]
- [Timeline constraints]
- [Resource constraints]
- [Compatibility requirements]

### Requirements
- [Must support X]
- [Must perform within Y budget]
- [Must integrate with Z]

## Decision

[The specific technical decision made, described in enough detail for someone
to implement it.]

### Architecture Diagram
[ASCII diagram or description of the system architecture this creates]

### Key Interfaces
[API contracts or interface definitions this decision creates]

## Alternatives Considered

### Alternative 1: [Name]
- **Description**: [How this would work]
- **Pros**: [Advantages]
- **Cons**: [Disadvantages]
- **Rejection Reason**: [Why this was not chosen]

### Alternative 2: [Name]
- **Description**: [How this would work]
- **Pros**: [Advantages]
- **Cons**: [Disadvantages]
- **Rejection Reason**: [Why this was not chosen]

## Consequences

### Positive
- [Good outcomes of this decision]

### Negative
- [Trade-offs and costs accepted]

### Risks
- [Things that could go wrong]
- [Mitigation for each risk]

## GDD Requirements Addressed

| GDD System | Requirement | How This ADR Addresses It |
|------------|-------------|--------------------------|
| [system-name].md | [specific rule, formula, or performance constraint from that GDD] | [how this decision satisfies it] |

## Performance Implications
- **CPU**: [Expected impact]
- **Memory**: [Expected impact]
- **Load Time**: [Expected impact]
- **Network**: [Expected impact, if applicable]

## Migration Plan
[If this changes existing code, how do we get from here to there?]

## Validation Criteria
[How will we know this decision was correct? What metrics or tests?]

## Related Decisions
- [Links to related ADRs]
- [Links to related design documents]
```

4.5. **Engine Specialist Validation** — Before saving, spawn the **primary engine specialist** via Task to validate the drafted ADR:
> **中文翻译**：4.5. **引擎专家验证** — 在保存之前，通过 Task 生成**主引擎专家**来验证起草的 ADR：

   - Read `.codebuddy/docs/technical-preferences.md` `Engine Specialists` section to get the primary specialist
     > **中文翻译**：读取 `.codebuddy/docs/technical-preferences.md` 的 `Engine Specialists` 部分获取主专家
   - If no engine is configured (`[TO BE CONFIGURED]`), skip this step
     > **中文翻译**：如果未配置引擎（`[TO BE CONFIGURED]`），跳过此步骤
   - Spawn `subagent_type: [primary specialist]` with: the ADR's Engine Compatibility section, Decision section, Key Interfaces, and the engine reference docs path. Ask them to:
     > **中文翻译**：生成 `subagent_type: [主专家]`，包含：ADR 的引擎兼容性章节、决策章节、关键接口和引擎参考文档路径。要求他们：
     1. Confirm the proposed approach is idiomatic for the pinned engine version
        > **中文翻译**：确认提议的方法对于固定的引擎版本是惯用的
     2. Flag any APIs or patterns that are deprecated or changed post-training-cutoff
        > **中文翻译**：标记任何已弃用或在训练截断后更改的 API 或模式
     3. Identify engine-specific risks or gotchas not captured in the current ADR draft
        > **中文翻译**：识别当前 ADR 草稿中未捕获的引擎特定风险或陷阱
   - If the specialist identifies a **blocking issue** (wrong API, deprecated approach, engine version incompatibility): revise the Decision and Engine Compatibility sections accordingly, then confirm the changes with the user before proceeding
     > **中文翻译**：如果专家识别出**阻塞问题**（错误的 API、已弃用的方法、引擎版本不兼容）：相应地修订决策和引擎兼容性章节，然后在继续之前与用户确认更改
   - If the specialist finds **minor notes** only: incorporate them into the ADR's Risks subsection
     > **中文翻译**：如果专家仅发现**次要备注**：将它们纳入 ADR 的风险子章节

**Review mode check** — apply before spawning TD-ADR:
> **中文翻译**：**审查模式检查** — 在生成 TD-ADR 之前应用：
- `solo` → skip. Note: "TD-ADR skipped — Solo mode." Proceed to Step 4.7 (GDD sync check).
  > **中文翻译**：`solo` → 跳过。注意："TD-ADR 已跳过 — Solo 模式。" 继续步骤 4.7（GDD 同步检查）。
- `lean` → skip (not a PHASE-GATE). Note: "TD-ADR skipped — Lean mode." Proceed to Step 4.7 (GDD sync check).
  > **中文翻译**：`lean` → 跳过（不是阶段门控）。注意："TD-ADR 已跳过 — Lean 模式。" 继续步骤 4.7（GDD 同步检查）。
- `full` → spawn as normal.
  > **中文翻译**：`full` → 正常生成。

4.6. **Technical Director Strategic Review** — After the engine specialist validation, spawn `technical-director` via Task using gate **TD-ADR** (`.codebuddy/docs/director-gates.md`):
> **中文翻译**：4.6. **技术总监战略审查** — 引擎专家验证后，使用门控 **TD-ADR**（`.codebuddy/docs/director-gates.md`）通过 Task 生成 `technical-director`：

   - Pass: the ADR file path (or draft content), engine version, domain, any existing ADRs in the same domain
     > **中文翻译**：传递：ADR 文件路径（或草稿内容）、引擎版本、领域、同领域的任何现有 ADR
   - The TD validates architectural coherence (is this decision consistent with the whole system?) — distinct from the engine specialist's API-level check
     > **中文翻译**：TD 验证架构一致性（此决策是否与整个系统一致？）— 不同于引擎专家的 API 级别检查
   - If CONCERNS or REJECT: revise the Decision or Alternatives sections accordingly before proceeding
     > **中文翻译**：如果是 CONCERNS 或 REJECT：在继续之前相应地修订决策或替代方案章节

4.7. **GDD Sync Check** — Before presenting the write approval, scan all GDDs
referenced in the "GDD Requirements Addressed" section for naming inconsistencies
with the ADR's Key Interfaces and Decision sections (renamed signals, API methods,
or data types). If any are found, surface them as a **prominent warning block**
immediately before the write approval — not as a footnote:
> **中文翻译**：4.7. **GDD 同步检查** — 在呈现写入批准之前，扫描 "GDD Requirements Addressed" 章节中引用的所有 GDD，查找与 ADR 的关键接口和决策章节的命名不一致（重命名的信号、API 方法或数据类型）。如果发现任何不一致，在写入批准之前立即将其作为**醒目警告块**呈现 — 而不是作为脚注：

```
⚠️ GDD SYNC REQUIRED
[gdd-filename].md uses names this ADR has renamed:
  [old_name] → [new_name_from_adr]
  [old_name_2] → [new_name_2_from_adr]
The GDD must be updated before or alongside writing this ADR to prevent
developers reading the GDD from implementing the wrong interface.
```

If no inconsistencies: skip this block silently.
> **中文翻译**：如果没有不一致：静默跳过此块。

5. **Write approval** — Use `AskUserQuestion`:
> **中文翻译**：5. **写入批准** — 使用 `AskUserQuestion`：

If GDD sync issues were found:
> **中文翻译**：如果发现 GDD 同步问题：
- "ADR draft is complete. How would you like to proceed?"
  > **中文翻译**："ADR 草稿已完成。您想如何处理？"
  - [A] Write ADR + update GDD in the same pass
    > **中文翻译**：[A] 写入 ADR + 同步更新 GDD
  - [B] Write ADR only — I'll update the GDD manually
    > **中文翻译**：[B] 仅写入 ADR — 我将手动更新 GDD
  - [C] Not yet — I need to review further
    > **中文翻译**：[C] 暂不 — 我需要进一步审查

If no GDD sync issues:
> **中文翻译**：如果没有 GDD 同步问题：
- "ADR draft is complete. May I write it?"
  > **中文翻译**："ADR 草稿已完成。可以写入吗？"
  - [A] Write ADR to `docs/architecture/adr-[NNNN]-[slug].md`
    > **中文翻译**：[A] 将 ADR 写入 `docs/architecture/adr-[NNNN]-[slug].md`
  - [B] Not yet — I need to review further
    > **中文翻译**：[B] 暂不 — 我需要进一步审查

If yes to any write option, write the file, creating the directory if needed.
For option [A] with GDD update: also update the GDD file(s) to use the new names.
> **中文翻译**：如果选择任何写入选项，写入文件，如需要则创建目录。对于选项 [A] 含 GDD 更新：同时更新 GDD 文件以使用新名称。

6. **Update Architecture Registry** / 更新架构注册表

Scan the written ADR for new architectural stances that should be registered:
> **中文翻译**：扫描已写入的 ADR 中应注册的新架构立场：
- State it claims ownership of
  > **中文翻译**：它声明拥有的状态
- Interface contracts it defines (signal signatures, method APIs)
  > **中文翻译**：它定义的接口契约（信号签名、方法 API）
- Performance budget it claims
  > **中文翻译**：它声明的性能预算
- API choices it makes explicitly
  > **中文翻译**：它明确做出的 API 选择
- Patterns it bans (Consequences → Negative or explicit "do not use X")
  > **中文翻译**：它禁止的模式（后果 → 负面或明确的"不要使用 X"）

Present candidates:
> **中文翻译**：呈现候选条目：
```
Registry candidates from this ADR:
  NEW state ownership:      player_stamina → stamina-system
  NEW interface contract:   stamina_depleted signal
  NEW performance budget:   stamina-system: 0.5ms/frame
  NEW forbidden pattern:    polling stamina each frame (use signal instead)
  EXISTING (referenced_by update only): player_health → already registered ✅
```

**Registry append logic**: When writing to `docs/registry/architecture.yaml`, do NOT assume sections are empty. The file may already have entries from previous ADRs written in this session. Before each Edit call:
> **中文翻译**：**注册表追加逻辑**：写入 `docs/registry/architecture.yaml` 时，不要假设章节为空。文件可能已有本次会话中之前写入的 ADR 条目。每次 Edit 调用之前：
1. Read the current state of `docs/registry/architecture.yaml`
   > **中文翻译**：读取 `docs/registry/architecture.yaml` 的当前状态
2. Find the correct section (state_ownership, interfaces, forbidden_patterns, api_decisions)
   > **中文翻译**：找到正确的章节（state_ownership、interfaces、forbidden_patterns、api_decisions）
3. Append the new entry AFTER the last existing entry in that section — do not try to replace a `[]` placeholder that may no longer exist
   > **中文翻译**：在该章节的最后一个现有条目之后追加新条目 — 不要尝试替换可能已不存在的 `[]` 占位符
4. If the section has entries already, use the closing content of the last entry as the `old_string` anchor, and append the new entry after it
   > **中文翻译**：如果章节已有条目，使用最后一个条目的结尾内容作为 `old_string` 锚点，并在其后追加新条目

**BLOCKING — do not write to `docs/registry/architecture.yaml` without explicit user approval.**
> **中文翻译**：**阻塞 — 未经用户明确批准，不要写入 `docs/registry/architecture.yaml`。**

Ask using `AskUserQuestion`:
> **中文翻译**：使用 `AskUserQuestion` 询问：
- "May I update `docs/registry/architecture.yaml` with these [N] new stances?"
  > **中文翻译**："我可以更新 `docs/registry/architecture.yaml` 中的 [N] 个新立场吗？"
  - Options: "Yes — update the registry", "Not yet — I want to review the candidates", "Skip registry update"
    > **中文翻译**：选项："是 — 更新注册表"、"暂不 — 我想审查候选条目"、"跳过注册表更新"

Only proceed if the user selects yes. If yes: append new entries. Never modify existing entries — if a stance is
changing, set the old entry to `status: superseded_by: ADR-[NNNN]` and add the new entry.
> **中文翻译**：仅在用户选择是时继续。如果是：追加新条目。永远不要修改现有条目 — 如果立场发生变更，将旧条目设为 `status: superseded_by: ADR-[NNNN]` 并添加新条目。

---

## 7. Closing Next Steps / 结束后续步骤

After the ADR is written (and registry optionally updated), close with `AskUserQuestion`.
> **中文翻译**：ADR 写入后（以及注册表可选更新），以 `AskUserQuestion` 结束。

Before generating the widget:
> **中文翻译**：在生成组件之前：
1. Read `docs/registry/architecture.yaml` — check if any priority ADRs are still unwritten (look for ADRs flagged in technical-preferences.md or systems-index.md as prerequisites)
   > **中文翻译**：读取 `docs/registry/architecture.yaml` — 检查是否有优先 ADR 仍未编写（查找在 technical-preferences.md 或 systems-index.md 中标记为先决条件的 ADR）
2. Check if all prerequisite ADRs are now written. If yes, include a "Start writing GDDs" option.
   > **中文翻译**：检查所有先决 ADR 是否已编写。如果是，包含"开始编写 GDD"选项。
3. List ALL remaining priority ADRs as individual options — not just the next one or two.
   > **中文翻译**：列出所有剩余优先 ADR 作为单独选项 — 不仅仅是下一两个。

Widget format:
> **中文翻译**：组件格式：
```
ADR-[NNNN] written and registry updated. What would you like to do next?
[1] Write [next-priority-adr-name] — [brief description from prerequisites list]
[2] Write [another-priority-adr] — [brief description]  (include ALL remaining ones)
[N] Start writing GDDs — run `/design-system [first-undesigned-system]` (only show if all prerequisite ADRs are written)
[N+1] Stop here for this session
```

If there are no remaining priority ADRs and no undesigned GDD systems, offer only "Stop here" and suggest running `/architecture-review` in a fresh session.
> **中文翻译**：如果没有剩余的优先 ADR 且没有未设计的 GDD 系统，仅提供"在此停止"并建议在新会话中运行 `/architecture-review`。

**Always include this fixed notice in the closing output (do NOT omit it):**
> **中文翻译**：**始终在结束输出中包含此固定通知（不要省略）：**

> To validate ADR coverage against your GDDs, open a **fresh CodeBuddy session**
> and run `/architecture-review`.
>
> **Never run `/architecture-review` in the same session as `/architecture-decision`.**
> The reviewing agent must be independent of the authoring context to give an unbiased
> assessment. Running it here would invalidate the review.
> **中文翻译**：要验证 ADR 覆盖率是否与 GDD 匹配，打开**新的 CodeBuddy 会话**并运行 `/architecture-review`。**永远不要在与 `/architecture-decision` 相同的会话中运行 `/architecture-review`。** 审查代理必须独立于编写上下文以给出无偏评估。在此运行会使审查无效。

Update any stories that were `Status: Blocked` pending this ADR to `Status: Ready`.
> **中文翻译**：将所有因等待此 ADR 而为 `Status: Blocked` 的故事更新为 `Status: Ready`。
