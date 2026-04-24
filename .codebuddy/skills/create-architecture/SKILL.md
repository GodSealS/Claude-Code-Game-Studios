---
name: create-architecture
description: "Guided, section-by-section authoring of the master architecture document for the game. Reads all GDDs, the systems index, existing ADRs, and the engine reference library to produce a complete architecture blueprint before any code is written. Engine-version-aware: flags knowledge gaps and validates decisions against the pinned engine version. / 引导式逐节编写游戏的主架构文档。读取所有 GDD、系统索引、现有 ADR 和引擎参考库，在编写任何代码前生成完整的架构蓝图。引擎版本感知：标记知识差距并针对固定引擎版本验证决策。"
argument-hint: "[focus-area: full | layers | data-flow | api-boundaries | adr-audit] [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Bash, AskUserQuestion, Task
agent: technical-director
---

# Create Architecture
> **中文翻译**：# 创建架构


This skill produces `docs/architecture/architecture.md` — the master architecture document that translates all approved GDDs into a concrete technical blueprint. It sits between design and implementation, and must exist before sprint planning begins.
> **中文翻译**：这项技能生成“docs/architecture/architecture.md”——将所有批准的 GDD 转化为具体技术蓝图的主架构文档。它位于设计和实现之间，并且必须在冲刺计划开始之前存在。


**Distinct from `/architecture-decision`**: ADRs record individual point decisions. This skill creates the whole-system blueprint that gives ADRs their context.
> **中文翻译**：**与“/architecture-decision”不同**：ADR 记录各个点的决策。这项技能创建了整个系统蓝图，为 ADR 提供了背景。


Resolve the review mode (once, store for all gate spawns this run):
> **中文翻译**：解决审查模式（一次，存储本次运行的所有门生成）：

1. If `--review [full|lean|solo]` was passed → use that
  > **中文翻译**：如果通过了 `--review [full|lean|solo]` → 使用它
2. Else read `production/review-mode.txt` → use that value
  > **中文翻译**：否则阅读 `product/review-mode.txt` → 使用该值
3. Else → default to `lean`
  > **中文翻译**：否则→默认为“精益”


See `.codebuddy/docs/director-gates.md` for the full check pattern.
> **中文翻译**：有关完整的检查模式，请参阅“.codebuddy/docs/director-gates.md”。


**Argument modes:**
> **中文翻译**：**论证模式：**

- **No argument / `full`**: Full guided walkthrough — all sections, start to finish
  > **中文翻译**：**无参数/“完整”**：完整的指导演练 - 所有部分，从头到尾
- **`layers`**: Focus on the system layer diagram only
  > **中文翻译**：**`layers`**：仅关注系统层图
- **`data-flow`**: Focus on data flow between modules only
  > **中文翻译**：**`data-flow`**：仅关注模块之间的数据流
- **`api-boundaries`**: Focus on API boundary definitions only
  > **中文翻译**：**`api-boundaries`**：仅关注 API 边界定义
- **`adr-audit`**: Audit existing ADRs for engine compatibility gaps only
  > **中文翻译**：**`adr-audit`**：仅审核现有 ADR 的引擎兼容性差距


---

## Phase 0: Load All Context

Before anything else, load the full project context in this order:

### 0a. Engine Context (Critical)

Read the engine reference library completely:

1. `docs/engine-reference/[engine]/VERSION.md`
   → Extract: engine name, version, LLM cutoff, post-cutoff risk levels
2. `docs/engine-reference/[engine]/breaking-changes.md`
   → Extract: all HIGH and MEDIUM risk changes
3. `docs/engine-reference/[engine]/deprecated-apis.md`
   → Extract: APIs to avoid
4. `docs/engine-reference/[engine]/current-best-practices.md`
   → Extract: post-cutoff best practices that differ from training data
5. All files in `docs/engine-reference/[engine]/modules/`
   → Extract: current API patterns per domain

If no engine is configured, stop and prompt:
> "No engine is configured. Run `/setup-engine` first. Architecture cannot be
> written without knowing which engine and version you are targeting."

### 0b. Design Context + Technical Requirements Extraction

Read all approved design documents and extract technical requirements from each:

1. `design/gdd/game-concept.md` — game pillars, genre, core loop
2. `design/gdd/systems-index.md` — all systems, dependencies, priority tiers
3. `.codebuddy/docs/technical-preferences.md` — naming conventions, performance budgets,
   allowed libraries, forbidden patterns
4. **Every GDD in `design/gdd/`** — for each, extract technical requirements:
   - Data structures implied by the game rules
   - Performance constraints stated or implied
   - Engine capabilities the system requires
   - Cross-system communication patterns (what talks to what, how)
   - State that must persist (save/load implications)
   - Threading or timing requirements

Build a **Technical Requirements Baseline** — a flat list of all extracted
requirements across all GDDs, numbered `TR-[gdd-slug]-[NNN]`. This is the
complete set of what the architecture must cover. Present it as:

```
## Technical Requirements Baseline
Extracted from [N] GDDs | [X] total requirements

| Req ID | GDD | System | Requirement | Domain |
|--------|-----|--------|-------------|--------|
| TR-combat-001 | combat.md | Combat | Hitbox detection per-frame | Physics |
| TR-combat-002 | combat.md | Combat | Combo state machine | Core |
| TR-inventory-001 | inventory.md | Inventory | Item persistence | Save/Load |
```

This baseline feeds into every subsequent phase. No GDD requirement should be
left without an architectural decision to support it by the end of this session.

### 0c. Existing Architecture Decisions

Read all files in `docs/architecture/` to understand what has already been decided.
List any ADRs found and their domains.

### 0d. Generate Knowledge Gap Inventory

Before proceeding, display a structured summary:

```
## Engine Knowledge Gap Inventory
Engine: [name + version]
LLM Training Covers: up to approximately [version]
Post-Cutoff Versions: [list]

### HIGH RISK Domains (must verify against engine reference before deciding)
- [Domain]: [Key changes]

### MEDIUM RISK Domains (verify key APIs)
- [Domain]: [Key changes]

### LOW RISK Domains (in training data, likely reliable)
- [Domain]: [no significant post-cutoff changes]

### Systems from GDD that touch HIGH/MEDIUM risk domains:
- [GDD system name] → [domain] → [risk level]
```

Ask: "This inventory identifies [N] systems in HIGH RISK engine domains. Shall I
continue building the architecture with these warnings flagged throughout?"

---

## Phase 1: System Layer Mapping
> **中文翻译**：## 第一阶段：系统层映射


Map every system from `systems-index.md` into an architecture layer. The standard game architecture layers are:
> **中文翻译**：将“systems-index.md”中的每个系统映射到架构层。标准游戏架构层是：


```
┌─────────────────────────────────────────────┐
│  PRESENTATION LAYER                         │  ← UI, HUD, menus, VFX, audio
├─────────────────────────────────────────────┤
│  FEATURE LAYER                              │  ← gameplay systems, AI, quests
├─────────────────────────────────────────────┤
│  CORE LAYER                                 │  ← physics, input, combat, movement
├─────────────────────────────────────────────┤
│  FOUNDATION LAYER                           │  ← engine integration, save/load,
│                                             │    scene management, event bus
├─────────────────────────────────────────────┤
│  PLATFORM LAYER                             │  ← OS, hardware, engine API surface
└─────────────────────────────────────────────┘
```

For each GDD system, ask:
> **中文翻译**：对于每个 GDD 系统，询问：

- Which layer does it belong to?
  > **中文翻译**：它属于哪一层？
- What are its module boundaries?
  > **中文翻译**：它的模块边界是什么？
- What does it own exclusively? (data, state, behaviour)
  > **中文翻译**：它独家拥有什么？ （数据、状态、行为）


Present the proposed layer assignment and ask for approval before proceeding to the next section. Write the approved layer map immediately to the skeleton file.
> **中文翻译**：在继续下一部分之前，提出建议的图层分配并请求批准。将批准的图层图立即写入骨架文件。


**Engine awareness check**: For each system assigned to the Core and Foundation layers, flag if it touches a HIGH or MEDIUM risk engine domain. Show the relevant engine reference excerpt inline.
> **中文翻译**：**引擎意识检查**：对于分配给核心层和基础层的每个系统，如果它涉及高风险或中风险引擎域，则进行标记。内嵌显示相关引擎参考摘录。


---

## Phase 2: Module Ownership Map

For each module defined in Phase 1, define ownership:

- **Owns**: what data and state this module is solely responsible for
- **Exposes**: what other modules may read or call
- **Consumes**: what it reads from other modules
- **Engine APIs used**: which specific engine classes/nodes/signals this module
  calls directly (with version and risk level noted)

Format as a table per layer, then as an ASCII dependency diagram.

**Engine awareness check**: For every engine API listed, verify against the
relevant module reference doc. If an API is post-cutoff, flag it:

```
⚠️  [ClassName.method()] — Godot 4.6 (post-cutoff, HIGH risk)
    Verified against: docs/engine-reference/godot/modules/[domain].md
    Behaviour confirmed: [yes / NEEDS VERIFICATION]
```

Get user approval on the ownership map before writing.

---

## Phase 3: Data Flow
> **中文翻译**：## 第 3 阶段：数据流


Define how data moves between modules during key game scenarios. Cover at minimum:
> **中文翻译**：定义在关键游戏场景期间数据如何在模块之间移动。至少覆盖：


1. **Frame update path**: Input → Core systems → State → Rendering
  > **中文翻译**：**帧更新路径**：输入→核心系统→状态→渲染
2. **Event/signal path**: How systems communicate without tight coupling
  > **中文翻译**：**事件/信号路径**：系统如何在没有紧密耦合的情况下进行通信
3. **Save/load path**: What state is serialised, which module owns serialisation
  > **中文翻译**：**保存/加载路径**：序列化什么状态，哪个模块拥有序列化
4. **Initialisation order**: Which modules must boot before others
  > **中文翻译**：**初始化顺序**：哪些模块必须先于其他模块启动


Use ASCII sequence diagrams where helpful. For each data flow:
> **中文翻译**：如果有帮助，请使用 ASCII 序列图。对于每个数据流：

- Name the data being transferred
  > **中文翻译**：命名正在传输的数据
- Identify the producer and consumer
  > **中文翻译**：识别生产者和消费者
- State whether this is synchronous call, signal/event, or shared state
  > **中文翻译**：说明这是同步调用、信号/事件还是共享状态
- Flag any data flows that cross thread boundaries
  > **中文翻译**：标记任何跨越线程边界的数据流


Get user approval per scenario before writing.
> **中文翻译**：在编写之前获得每个场景的用户批准。


---

## Phase 4: API Boundaries

Define the public contracts between modules. For each boundary:

- What is the interface a module exposes to the rest of the system?
- What are the entry points (functions/signals/properties)?
- What invariants must callers respect?
- What must the module guarantee to callers?

Write in pseudocode or the project's actual language (from technical preferences).
These become the contracts programmers implement against.

**Engine awareness check**: If any interface uses engine-specific types (e.g.
`Node`, `Resource`, `Signal` in Godot), flag the version and verify the type
exists and has not changed signature in the target engine version.

---

## Phase 5: ADR Audit + Traceability Check
> **中文翻译**：## 第 5 阶段：ADR 审核 + 可追溯性检查


Review all existing ADRs from Phase 0c against both the architecture built in Phases 1-4 AND the Technical Requirements Baseline from Phase 0b.
> **中文翻译**：对照阶段 1-4 中构建的架构和阶段 0b 的技术要求基线，审查阶段 0c 的所有现有 ADR。


### ADR Quality Check
> **中文翻译**：### ADR 质量检查


For each ADR:
> **中文翻译**：对于每个 ADR：

- [ ] Does it have an Engine Compatibility section?
  > **中文翻译**：[ ] 有引擎兼容性部分吗？
- [ ] Is the engine version recorded?
  > **中文翻译**：[ ] 是否记录了引擎版本？
- [ ] Are post-cutoff APIs flagged?
  > **中文翻译**：[ ] 截止后 API 是否被标记？
- [ ] Does it have a "GDD Requirements Addressed" section?
  > **中文翻译**：[ ] 是否有“满足 GDD 要求”部分？
- [ ] Does it conflict with the layer/ownership decisions made in this session?
  > **中文翻译**：[ ] 它与本次会议中做出的层/所有权决策是否冲突？
- [ ] Is it still valid for the pinned engine version?
  > **中文翻译**：[ ] 对于固定的引擎版本仍然有效吗？


| ADR | Engine Compat | Version | GDD Linkage | Conflicts | Valid |
  <!-- 翻译: 美国存托凭证 -->
  <!-- 翻译: 发动机兼容性 -->
  <!-- 翻译: 版本 -->
  <!-- 翻译: GDD联动 -->
  <!-- 翻译: 冲突 -->
  <!-- 翻译: 有效的 -->
|-----|--------------|---------|-------------|-----------|-------|
| ADR-0001: [title] | ✅/❌ | ✅/❌ | ✅/❌ | None/[conflict] | ✅/⚠️ |
  <!-- 翻译: ADR-0001：[标题] -->
  <!-- 翻译: 无/[冲突] -->


### Traceability Coverage Check
> **中文翻译**：### 可追溯性覆盖范围检查


Map every requirement from the Technical Requirements Baseline to existing ADRs. For each requirement, check if any ADR's "GDD Requirements Addressed" section or decision text covers it:
> **中文翻译**：将技术要求基线中的每项要求映射到现有 ADR。对于每项要求，检查任何 ADR 的“GDD 要求已解决”部分或决策文本是否涵盖该要求：


| Req ID | Requirement | ADR Coverage | Status |
  <!-- 翻译: 请求 ID -->
  <!-- 翻译: 要求 -->
  <!-- 翻译: ADR 覆盖范围 -->
  <!-- 翻译: 地位 -->
|--------|-------------|--------------|--------|
| TR-combat-001 | Hitbox detection per-frame | ADR-0003 | ✅ |
  <!-- 翻译: TR-战斗-001 -->
  <!-- 翻译: 每帧的 Hitbox 检测 -->
  <!-- 翻译: ADR-0003 -->
| TR-combat-002 | Combo state machine | — | ❌ GAP |
  <!-- 翻译: TR-战斗-002 -->
  <!-- 翻译: 组合状态机 -->
  <!-- 翻译: ❌ 差距 -->


Count: X covered, Y gaps. For each gap, it becomes a **Required New ADR**.
> **中文翻译**：计数：X 已覆盖，Y 是间隙。对于每个差距，它都成为**必需的新 ADR**。


### Required New ADRs
> **中文翻译**：### 需要新的 ADR


List all decisions made during this architecture session (Phases 1-4) that do not yet have a corresponding ADR, PLUS all uncovered Technical Requirements. Group by layer — Foundation first:
> **中文翻译**：列出本架构会议（第 1-4 阶段）期间做出的尚未有相应 ADR 的所有决策，以及所有未涵盖的技术要求。逐层分组——基础优先：


**Foundation Layer (must create before any coding):**
> **中文翻译**：**基础层（必须在任何编码之前创建）：**

- `/architecture-decision [title]` → covers: TR-[id], TR-[id]
  > **中文翻译**：`/architecture-decision [title]` → 涵盖：TR-[id]、TR-[id]


**Core Layer:**
> **中文翻译**：**核心层：**

- `/architecture-decision [title]` → covers: TR-[id]
  > **中文翻译**：`/architecture-decision [title]` → 涵盖：TR-[id]


---

## Phase 6: Missing ADR List

Based on the full architecture, produce a complete list of ADRs that should exist
but don't yet. Group by priority:

**Must have before coding starts (Foundation & Core decisions):**
- [e.g. "Scene management and scene loading strategy"]
- [e.g. "Event bus vs direct signal architecture"]

**Should have before the relevant system is built:**
- [e.g. "Inventory serialisation format"]

**Can defer to implementation:**
- [e.g. "Specific shader technique for water"]

---

## Phase 7: Write the Master Architecture Document
> **中文翻译**：## 第 7 阶段：编写主架构文档


Once all sections are approved, write the complete document to `docs/architecture/architecture.md`.
> **中文翻译**：所有部分获得批准后，将完整的文档写入“docs/architecture/architecture.md”。


Ask: "May I write the master architecture document to `docs/architecture/architecture.md`?"
> **中文翻译**：问：“我可以将主架构文档写入`docs/architecture/architecture.md`吗？”


The document structure:
> **中文翻译**：文档结构：


```markdown
# [Game Name] — Master Architecture

## Document Status
- Version: [N]
- Last Updated: [date]
- Engine: [name + version]
- GDDs Covered: [list]
- ADRs Referenced: [list]

## Engine Knowledge Gap Summary
[Condensed from Phase 0d inventory — HIGH/MEDIUM risk domains and their implications]

## System Layer Map
[From Phase 1]

## Module Ownership
[From Phase 2]

## Data Flow
[From Phase 3]

## API Boundaries
[From Phase 4]

## ADR Audit
[From Phase 5]

## Required ADRs
[From Phase 6]

## Architecture Principles
[3-5 key principles that govern all technical decisions for this project,
derived from the game concept, GDDs, and technical preferences]

## Open Questions
[Decisions deferred — must be resolved before the relevant layer is built]
```

---

## Phase 7b: Technical Director Sign-Off + Lead Programmer Feasibility Review

After writing the master architecture document, perform an explicit sign-off before handoff.

**Step 1 — Technical Director self-review** (this skill runs as technical-director):

Apply gate **TD-ARCHITECTURE** (`.codebuddy/docs/director-gates.md`) as a self-review. Check all four criteria from that gate definition against the completed document.

**Review mode check** — apply before spawning LP-FEASIBILITY:
- `solo` → skip. Note: "LP-FEASIBILITY skipped — Solo mode." Proceed to Phase 8 handoff.
- `lean` → skip (not a PHASE-GATE). Note: "LP-FEASIBILITY skipped — Lean mode." Proceed to Phase 8 handoff.
- `full` → spawn as normal.

**Step 2 — Spawn `lead-programmer` via Task using gate LP-FEASIBILITY (`.codebuddy/docs/director-gates.md`):**

Pass: architecture document path, technical requirements baseline summary, ADR list.

**Step 3 — Present both assessments to the user:**

Show the Technical Director assessment and Lead Programmer verdict side by side.

Use `AskUserQuestion` — "Technical Director and Lead Programmer have reviewed the architecture. How would you like to proceed?"
Options: `Accept — proceed to handoff` / `Revise flagged items first` / `Discuss specific concerns`

**Step 4 — Record sign-off in the architecture document:**

Update the Document Status section:
```
- Technical Director Sign-Off: [date] — APPROVED / APPROVED WITH CONDITIONS
- Lead Programmer Feasibility: FEASIBLE / CONCERNS ACCEPTED / REVISED
```

Ask: "May I update the Document Status section in `docs/architecture/architecture.md` with the sign-off?"

---

## Phase 8: Handoff
> **中文翻译**：## 第 8 阶段：移交


After writing the document, provide a clear handoff:
> **中文翻译**：编写文档后，提供清晰的交接：


1. **Run these ADRs next** (from Phase 6, prioritised): list the top 3
  > **中文翻译**：**接下来运行这些 ADR**（从第 6 阶段开始，优先）：列出前 3 个
2. **Gate check**: "The master architecture document is complete. Run `/gate-check
  > **中文翻译**：**gate check**: "主架构文档已完成。运行`/gate-check

   pre-production` when all required ADRs are also written."
> **中文翻译**：预生产`，所有必需的 ADR 也已编写完毕。”

3. **Update session state**: Write a summary to `production/session-state/active.md`
  > **中文翻译**：**更新会话状态**：将摘要写入 `product/session-state/active.md`


---

## Collaborative Protocol

This skill follows the collaborative design principle at every phase:

1. **Load context silently** — do not narrate file reads
2. **Present findings** — show the knowledge gap inventory and layer proposals
3. **Ask before deciding** — present options for each architectural choice
4. **Get approval before writing** — each phase section is written only after
   user approves the content
5. **Incremental writing** — write each approved section immediately; do not
   accumulate everything and write at the end. This survives session crashes.

Never make a binding architectural decision without user input. If the user is
unsure, present 2-4 options with pros/cons before asking them to decide.

---

## Recommended Next Steps
> **中文翻译**：## 建议的后续步骤


- Run `/architecture-decision [title]` for each required ADR listed in Phase 6 — Foundation layer ADRs first
  > **中文翻译**：为第 6 阶段列出的每个必需的 ADR 运行“/architecture-decision [title]”——首先是基础层 ADR
- Run `/create-control-manifest` once the required ADRs are written to produce the layer rules manifest
  > **中文翻译**：写入所需的 ADR 以生成层规则清单后，运行“/create-control-manifest”
- Run `/gate-check pre-production` when all required ADRs are written and the architecture is signed off
  > **中文翻译**：当所有必需的 ADR 都已写入并且架构已签署时，运行“/gate-check pre-production”

