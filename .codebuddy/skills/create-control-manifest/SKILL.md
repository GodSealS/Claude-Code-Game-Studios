---
name: create-control-manifest
description: "After architecture is complete, produces a flat actionable rules sheet for programmers — what you must do, what you must never do, per system and per layer. Extracted from all Accepted ADRs, technical preferences, and engine reference docs. More immediately actionable than ADRs (which explain why). / 架构完成后，为程序员生成扁平化的可操作规则表 — 每个系统和每层必须做什么、绝不能做什么。从所有已接受 ADR、技术偏好和引擎参考文档中提取。比 ADR（解释原因）更直接可操作。"
argument-hint: "[update — regenerate from current ADRs]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Task
agent: technical-director
---

# Create Control Manifest / 创建控制清单

The Control Manifest is a flat, actionable rules sheet for programmers. It answers "what do I do?" and "what must I never do?" — organized by architectural layer, extracted from all Accepted ADRs, technical preferences, and engine reference docs. Where ADRs explain *why*, the manifest tells you *what*.
> **中文翻译**：控制清单是为程序员提供的一个扁平的、可操作的规则表。它回答"我该怎么办？"以及"我绝对不能做什么？" — 按架构层组织，从所有已接受的 ADR、技术偏好和引擎参考文档中提取。ADR 解释"为什么"，而清单告诉您"什么"。

**Output:** `docs/architecture/control-manifest.md`
> **中文翻译**：**输出：** `docs/architecture/control-manifest.md`

**When to run:** After `/architecture-review` passes and ADRs are in Accepted status. Re-run whenever new ADRs are accepted or existing ADRs are revised.
> **中文翻译**：**何时运行：** `/architecture-review` 通过且 ADR 处于"已接受"状态后。只要新的 ADR 被接受或现有的 ADR 被修改，就重新运行。

---

## 1. Load All Inputs / 1. 加载所有输入

<!-- 中文翻译 -->
### ADRs
- Glob `docs/architecture/adr-*.md` and read every file
- Filter to only Accepted ADRs (Status: Accepted) — skip Proposed, Deprecated,
  Superseded
- Note the ADR number and title for every rule sourced

> **中文翻译**：
> - 用 Glob 查找 `docs/architecture/adr-*.md` 并读取每个文件
> - 仅筛选已接受的 ADR（状态：已接受）— 跳过已提议、已弃用、已取代的
> - 记录每条规则来源的 ADR 编号和标题

### Technical Preferences / 技术偏好
- Read `.codebuddy/docs/technical-preferences.md`
- Extract: naming conventions, performance budgets, approved libraries/addons,
  forbidden patterns

> **中文翻译**：
> - 读取 `.codebuddy/docs/technical-preferences.md`
> - 提取：命名约定、性能预算、批准的库/插件、禁止的模式

### Engine Reference / 引擎参考
- Read `docs/engine-reference/[engine]/VERSION.md` for engine + version
- Read `docs/engine-reference/[engine]/deprecated-apis.md` — these become
  forbidden API entries
- Read `docs/engine-reference/[engine]/current-best-practices.md` if it exists

> **中文翻译**：
> - 读取 `docs/engine-reference/[engine]/VERSION.md` 获取引擎 + 版本
> - 读取 `docs/engine-reference/[engine]/deprecated-apis.md` — 这些成为禁止的 API 条目
> - 如果存在，读取 `docs/engine-reference/[engine]/current-best-practices.md`

Report: "Loaded [N] Accepted ADRs, engine: [name + version]."
> **中文翻译**：报告："已加载 [N] 个已接受的 ADR，引擎：[名称 + 版本]。"

---

## 2. Extract Rules from Each ADR / 2. 从每个 ADR 中提取规则

For each Accepted ADR, extract:
> **中文翻译**：对于每个已接受的 ADR，提取：

### Required Patterns (from "Implementation Guidelines" section) / 所需模式（来自"实施指南"部分）

- Every "must", "should", "required to", "always" statement
  > **中文翻译**：每一个"必须"、"应该"、"要求"、"总是"的陈述
- Every specific pattern or approach mandated
  > **中文翻译**：强制规定的每种特定模式或方法

### Forbidden Approaches (from "Alternatives Considered" sections) / 禁止的方法（来自"考虑的替代方案"部分）

- Every alternative that was explicitly rejected — *why* it was rejected becomes
  > **中文翻译**：每一个被明确拒绝的替代方案——*为什么*它被拒绝变成
  the rule ("never use X because Y")
> **中文翻译**：规则（"永远不要因为 Y 而使用 X"）
- Any anti-patterns explicitly called out
  > **中文翻译**：任何明确指出的反模式

### Performance Guardrails (from "Performance Implications" section) / 性能护栏（来自"性能影响"部分）

- Budget constraints: "max N ms per frame for this system"
  > **中文翻译**：预算约束："该系统每帧最大 N 毫秒"
- Memory limits: "this system must not exceed N MB"
  > **中文翻译**：内存限制："该系统不得超过 N MB"

### Engine API Constraints (from "Engine Compatibility" section) / 引擎 API 约束（来自"引擎兼容性"部分）

- Post-cutoff APIs that require verification
  > **中文翻译**：截止后需要验证的 API
- Verified behaviours that differ from default LLM assumptions
  > **中文翻译**：与默认 LLM 假设不同的已验证行为
- API fields or methods that behave differently in the pinned engine version
  > **中文翻译**：在固定引擎版本中表现不同的 API 字段或方法

### Layer Classification / 层分类

Classify each rule by the architectural layer of the system it governs:
> **中文翻译**：按每个规则所管辖的系统的架构层对每个规则进行分类：

- **Foundation**: Scene management, event architecture, save/load, engine init
  > **中文翻译**：**基础**：场景管理、事件架构、保存/加载、引擎初始化
- **Core**: Core gameplay loops, main player systems, physics/collision
  > **中文翻译**：**核心**：核心游戏循环、主要玩家系统、物理/碰撞
- **Feature**: Secondary systems, secondary mechanics, AI
  > **中文翻译**：**功能**：二级系统、二级机制、人工智能
- **Presentation**: Rendering, audio, UI, VFX, shaders
  > **中文翻译**：**表现**：渲染、音频、UI、VFX、着色器

If an ADR spans multiple layers, duplicate the rule into each relevant layer.
> **中文翻译**：如果 ADR 跨越多个层，请将规则复制到每个相关层。

---

## 3. Add Global Rules / 3. 添加全局规则

Combine rules that apply to all layers:
> **中文翻译**：合并适用于所有层的规则：

### From technical-preferences.md / 来自 technical-preferences.md：
- Naming conventions (classes, variables, signals/events, files, constants)
- Performance budgets (target framerate, frame budget, draw call limits, memory ceiling)

> **中文翻译**：
> - 命名约定（类、变量、信号/事件、文件、常量）
> - 性能预算（目标帧率、帧预算、绘制调用限制、内存上限）

### From deprecated-apis.md / 来自 deprecated-apis.md：
- All deprecated APIs → Forbidden API entries
> **中文翻译**：所有已弃用的 API → 禁止的 API 条目

### From current-best-practices.md (if available) / 来自 current-best-practices.md（如果可用）：
- Engine-recommended patterns → Required entries
> **中文翻译**：引擎推荐的模式 → 所需条目

### From technical-preferences.md forbidden patterns / 来自 technical-preferences.md 禁止模式：
- Copy any "Forbidden Patterns" entries directly
> **中文翻译**：直接复制任何"禁止模式"条目

---

## 4. Present Rules Summary Before Writing / 4. 写入前展示规则摘要

Before writing the manifest, present a summary to the user:
> **中文翻译**：在编写清单之前，向用户提供摘要：

```
## Control Manifest Preview
Engine: [name + version]
ADRs covered: [list ADR numbers]
Total rules extracted:
  - Foundation layer: [N] required, [M] forbidden, [P] guardrails
  - Core layer: [N] required, [M] forbidden, [P] guardrails
  - Feature layer: ...
  - Presentation layer: ...
  - Global: [N] naming conventions, [M] forbidden APIs, [P] approved libraries
```

Ask: "Does this look complete? Any rules to add or remove before I write the manifest?"
> **中文翻译**：问："这看起来完整吗？在编写清单之前需要添加或删除任何规则吗？"

---

## 4b. Director Gate — Technical Review / 4b. 总监门控 — 技术审查

**Review mode check** — apply before spawning TD-MANIFEST:
> **中文翻译**：**审查模式检查** — 在生成 TD-MANIFEST 之前应用：

- `solo` → skip. Note: "TD-MANIFEST skipped — Solo mode." Proceed to Phase 5.
- `lean` → skip. Note: "TD-MANIFEST skipped — Lean mode." Proceed to Phase 5.
- `full` → spawn as normal.

> **中文翻译**：
> - `solo` → 跳过。备注："TD-MANIFEST 已跳过 — Solo 模式。"继续第 5 阶段。
> - `lean` → 跳过。备注："TD-MANIFEST 已跳过 — Lean 模式。"继续第 5 阶段。
> - `full` → 正常生成。

Spawn `technical-director` via Task using gate **TD-MANIFEST** (`.codebuddy/docs/director-gates.md`).
> **中文翻译**：通过 Task 使用门控 **TD-MANIFEST**（`.codebuddy/docs/director-gates.md`）生成 `technical-director`。

Pass: the Control Manifest Preview from Phase 4 (rule counts per layer, full extracted rule list), the list of ADRs covered, engine version, and any rules sourced from technical-preferences.md or engine reference docs.
> **中文翻译**：传递：第 4 阶段的控制清单预览（每层规则计数、完整提取的规则列表）、涵盖的 ADR 列表、引擎版本，以及来自 technical-preferences.md 或引擎参考文档的任何规则。

The technical-director reviews whether:
> **中文翻译**：技术总监审查是否：

- All mandatory ADR patterns are captured and accurately stated
- Forbidden approaches are complete and correctly attributed
- No rules were added that lack a source ADR or preference document
- Performance guardrails are consistent with the ADR constraints

> **中文翻译**：
> - 所有强制性 ADR 模式已被捕获并准确陈述
> - 禁止的方法完整且正确归属
> - 没有添加缺乏来源 ADR 或偏好文档的规则
> - 性能护栏与 ADR 约束一致

Apply the verdict:
> **中文翻译**：应用裁决：

- **APPROVE** → proceed to Phase 5
- **CONCERNS** → surface via `AskUserQuestion` with options: `Revise flagged rules` / `Accept and proceed` / `Discuss further`
- **REJECT** → do not write the manifest; fix the flagged rules and re-present the summary

> **中文翻译**：
> - **批准** → 继续第 5 阶段
> - **关注** → 通过 `AskUserQuestion` 呈现，选项为：`修改标记的规则` / `接受并继续` / `进一步讨论`
> - **拒绝** → 不编写清单；修复标记的规则并重新呈现摘要

---

## 5. Write the Control Manifest / 5. 编写控制清单

Ask: "May I write this to `docs/architecture/control-manifest.md`?"
> **中文翻译**：问："我可以将其写入 `docs/architecture/control-manifest.md` 吗？"

Format:
> **中文翻译**：格式：

```markdown
# Control Manifest

> **Engine**: [name + version]
> **Last Updated**: [date]
> **Manifest Version**: [date]
> **ADRs Covered**: [ADR-NNNN, ADR-MMMM, ...]
> **Status**: [Active — regenerate with `/create-control-manifest update` when ADRs change]

`Manifest Version` is the date this manifest was generated. Story files embed
this date when created. `/story-readiness` compares a story's embedded version
to this field to detect stories written against stale rules. Always matches
`Last Updated` — they are the same date, serving different consumers.

This manifest is a programmer's quick-reference extracted from all Accepted ADRs,
technical preferences, and engine reference docs. For the reasoning behind each
rule, see the referenced ADR.

---

## Foundation Layer Rules

*Applies to: scene management, event architecture, save/load, engine initialisation*

### Required Patterns
- **[rule]** — source: [ADR-NNNN]
- **[rule]** — source: [ADR-NNNN]

### Forbidden Approaches
- **Never [anti-pattern]** — [brief reason] — source: [ADR-NNNN]

### Performance Guardrails
- **[system]**: max [N]ms/frame — source: [ADR-NNNN]

---

## Core Layer Rules

*Applies to: core gameplay loop, main player systems, physics, collision*

### Required Patterns
...

### Forbidden Approaches
...

### Performance Guardrails
...

---

## Feature Layer Rules

*Applies to: secondary mechanics, AI systems, secondary features*

### Required Patterns
...

### Forbidden Approaches
...

---

## Presentation Layer Rules

*Applies to: rendering, audio, UI, VFX, shaders, animations*

### Required Patterns
...

### Forbidden Approaches
...

---

## Global Rules (All Layers)

### Naming Conventions
| Element | Convention | Example |
|---------|-----------|---------|
| Classes | [from technical-preferences] | [example] |
| Variables | [from technical-preferences] | [example] |
| Signals/Events | [from technical-preferences] | [example] |
| Files | [from technical-preferences] | [example] |
| Constants | [from technical-preferences] | [example] |

### Performance Budgets
| Target | Value |
|--------|-------|
| Framerate | [from technical-preferences] |
| Frame budget | [from technical-preferences] |
| Draw calls | [from technical-preferences] |
| Memory ceiling | [from technical-preferences] |

### Approved Libraries / Addons
- [library] — approved for [purpose]

### Forbidden APIs ([engine version])
These APIs are deprecated or unverified for [engine + version]:
- `[api name]` — deprecated since [version] / unverified post-cutoff
- Source: `docs/engine-reference/[engine]/deprecated-apis.md`

### Cross-Cutting Constraints
- [constraint that applies everywhere, regardless of layer]
```

---

## 6. Suggest Next Steps / 6. 建议后续步骤

After writing the manifest:
> **中文翻译**：编写清单后：

- If epics/stories don't exist yet: "Run `/create-epics layer: foundation` then `/create-stories [epic-slug]` — programmers
  can now use this manifest when writing story implementation notes."
- If this is a regeneration (manifest already existed): "Updated. Recommend
  notifying the team of changed rules — especially any new Forbidden entries."

> **中文翻译**：
> - 如果史诗/故事尚不存在："运行 `/create-epics layer: foundation` 然后 `/create-stories [epic-slug]` — 程序员现在可以在编写故事实施说明时使用此清单。"
> - 如果这是重新生成（清单已存在）："已更新。建议通知团队已更改的规则 — 尤其是任何新的禁止条目。"

---

## Collaborative Protocol / 协作协议

1. **Load silently** — read all inputs before presenting anything
2. **Show the summary first** — let the user see the scope before writing
3. **Ask before writing** — always confirm before creating or overwriting the manifest. On write: Verdict: **COMPLETE** — control manifest written. On decline: Verdict: **BLOCKED** — user declined write.
4. **Source every rule** — never add a rule that doesn't trace to an ADR, a
   technical preference, or an engine reference doc
5. **No interpretation** — extract rules as stated in ADRs; do not paraphrase
   in ways that change meaning

> **中文翻译**：
> 1. **静默加载** — 在展示任何内容之前读取所有输入
> 2. **先展示摘要** — 让用户在写入之前看到范围
> 3. **写入前询问** — 在创建或覆盖清单之前始终确认。写入时：裁决：**完成** — 控制清单已写入。拒绝时：裁决：**阻塞** — 用户拒绝写入。
> 4. **为每条规则提供来源** — 永远不要添加无法追溯到 ADR、技术偏好或引擎参考文档的规则
> 5. **不进行解释** — 按 ADR 中的陈述提取规则；不要以改变含义的方式进行改写
