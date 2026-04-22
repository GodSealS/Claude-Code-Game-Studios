# Director Gates — Shared Review Pattern / 总监门控 — 共享审查模式

This document defines the standard gate prompts for all director and lead reviews
across every workflow stage. Skills reference gate IDs from this document instead
of embedding full prompts inline — eliminating drift when prompts need updating.

> **中文翻译**：本文档定义了所有总监和主管审查在各个工作流阶段的标准门控提示词。技能通过引用本文档中的门控 ID，而非内嵌完整提示词——从而消除提示词更新时的漂移问题。

**Scope**: All 7 production stages (Concept → Release), all 3 Tier 1 directors,
all key Tier 2 leads. Any skill, team orchestrator, or workflow may invoke these gates.

> **中文翻译**：**范围**：全部7个生产阶段（概念 → 发布），全部3个第一层总监，所有关键第二层主管。任何技能、团队编排器或工作流都可以调用这些门控。

---

## How to Use This Document / 如何使用本文档

In any skill, replace an inline director prompt with a reference:

> **中文翻译**：在任何技能中，用引用替换内联的总监提示词：

```
Spawn `creative-director` via Task using gate **CD-PILLARS** from
`.codebuddy/docs/director-gates.md`.
```

Pass the context listed under that gate's **Context to pass** field, then handle
the verdict using the **Verdict handling** rules below.

> **中文翻译**：传递该门控 **需要传递的上下文** 字段中列出的上下文，然后使用下方的 **裁决处理** 规则处理裁决结果。

---

## Review Modes / 审查模式

Review intensity controls whether director gates run. It can be set globally
(persists across sessions) or overridden per skill run.

> **中文翻译**：审查强度控制总监门控是否运行。可以全局设置（跨会话持久化）或按技能运行覆盖。

**Global config**: `production/review-mode.txt` — one word: `full`, `lean`, or `solo`.
Set once during `/start`. Edit the file directly to change it at any time.

> **中文翻译**：**全局配置**：`production/review-mode.txt`——一个词：`full`、`lean` 或 `solo`。在 `/start` 期间设置一次。随时可直接编辑文件来更改。

**Per-run override**: any gate-using skill accepts `--review [full|lean|solo]` as an
argument. This overrides the global config for that run only.

> **中文翻译**：**单次运行覆盖**：任何使用门控的技能都接受 `--review [full|lean|solo]` 作为参数。这只覆盖该次运行的全局配置。

Examples:
```
/brainstorm space horror           → uses global mode
/brainstorm space horror --review full   → forces full mode this run
/architecture-decision --review solo     → skips all gates this run
```

> **中文翻译**：示例：
> `/brainstorm space horror` → 使用全局模式
> `/brainstorm space horror --review full` → 本次运行强制完整模式
> `/architecture-decision --review solo` → 本次运行跳过所有门控

| Mode | What runs | Best for |
|------|-----------|----------|
| `full` | All gates active — every workflow step reviewed | Teams, learning users, or when you want thorough director feedback at every step |
| `lean` | PHASE-GATEs only (`/gate-check`) — per-skill gates skipped | **Default** — solo devs and small teams; directors review at milestones only |
| `solo` | No director gates anywhere | Game jams, prototypes, maximum speed |

> **中文翻译**：

| 模式 | 运行内容 | 适用场景 |
|------|----------|----------|
| `full` | 所有门控激活——每个工作流步骤都被审查 | 团队、学习型用户，或当你希望在每一步都获得详细总监反馈时 |
| `lean` | 仅阶段门控（`/gate-check`）——跳过每技能门控 | **默认**——独立开发者和小团队；总监仅在里程碑时审查 |
| `solo` | 任何地方都不运行总监门控 | 游戏 jams、原型、最大速度 |

**Check pattern — apply before every gate spawn:**

> **中文翻译**：**检查模式——在每次门控生成前应用：**

```
Before spawning gate [GATE-ID]:
1. If skill was called with --review [mode], use that
2. Else read production/review-mode.txt
3. Else default to full

Apply the resolved mode:
- solo → skip all gates. Note: "[GATE-ID] skipped — Solo mode"
- lean → skip unless this is a PHASE-GATE (CD-PHASE-GATE, TD-PHASE-GATE, PR-PHASE-GATE)
         Note: "[GATE-ID] skipped — Lean mode"
- full → spawn as normal
```

> **中文翻译**：
> ```
> 在生成门控 [GATE-ID] 之前：
> 1. 如果技能以 --review [mode] 调用，使用该模式
> 2. 否则读取 production/review-mode.txt
> 3. 否则默认为 full
> 
> 应用解析后的模式：
> - solo → 跳过所有门控。注明："[GATE-ID] 已跳过——Solo 模式"
> - lean → 除非是阶段门控（CD-PHASE-GATE, TD-PHASE-GATE, PR-PHASE-GATE），否则跳过
>          注明："[GATE-ID] 已跳过——Lean 模式"
> - full → 正常生成
> ```

---

## Invocation Pattern (copy into any skill) / 调用模式（复制到任何技能中）

**MANDATORY: Resolve review mode before every gate spawn.** Never spawn a gate without checking. The resolved mode is determined once per skill run:
1. If skill was called with `--review [mode]`, use that
2. Else read `production/review-mode.txt`
3. Else default to `lean`

> **中文翻译**：**强制要求：在每次门控生成前解析审查模式。** 绝不在未检查的情况下生成门控。解析后的模式在每个技能运行中确定一次：
> 1. 如果技能以 `--review [mode]` 调用，使用该模式
> 2. 否则读取 `production/review-mode.txt`
> 3. 否则默认为 `lean`

Apply the resolved mode:
- `solo` → **skip all gates**. Note in output: `[GATE-ID] skipped — Solo mode`
- `lean` → **skip unless this is a PHASE-GATE** (CD-PHASE-GATE, TD-PHASE-GATE, PR-PHASE-GATE, AD-PHASE-GATE). Note: `[GATE-ID] skipped — Lean mode`
- `full` → spawn as normal

> **中文翻译**：应用解析后的模式：
> - `solo` → **跳过所有门控**。在输出中注明：`[GATE-ID] 已跳过——Solo 模式`
> - `lean` → **除非是阶段门控否则跳过**（CD-PHASE-GATE, TD-PHASE-GATE, PR-PHASE-GATE, AD-PHASE-GATE）。注明：`[GATE-ID] 已跳过——Lean 模式`
> - `full` → 正常生成

```
# Apply mode check, then:
# 应用模式检查，然后：
Spawn `[agent-name]` via Task:
- Gate: [GATE-ID] (see .codebuddy/docs/director-gates.md)
- Context: [fields listed under that gate]
- Await the verdict before proceeding.
```

> **中文翻译**：
> ```
> # 应用模式检查，然后：
> 通过 Task 生成 `[agent-name]`：
> - 门控：[GATE-ID]（参见 .codebuddy/docs/director-gates.md）
> - 上下文：[该门控下列出的字段]
> - 等待裁决后再继续。
> ```

For parallel spawning (multiple directors at the same gate point):

> **中文翻译**：对于并行生成（在同一门控点有多个总监）：

```
# Apply mode check for each gate first, then spawn all that survive:
# 先对每个门控应用模式检查，然后生成所有存活者：
Spawn all [N] agents simultaneously via Task — issue all Task calls before
waiting for any result. Collect all verdicts before proceeding.
```

> **中文翻译**：
> ```
> # 先对每个门控应用模式检查，然后生成所有存活者：
> 通过 Task 同时生成所有 [N] 个代理——在等待任何结果之前发出所有 Task 调用。
> 在继续之前收集所有裁决。
> ```

---

## Standard Verdict Format / 标准裁决格式

All gates return one of three verdicts. Skills must handle all three:

> **中文翻译**：所有门控返回三种裁决之一。技能必须处理所有三种：

| Verdict | Meaning | Default action |
|---------|---------|----------------|
| **APPROVE / READY** | No issues. Proceed. | Continue the workflow |
| **CONCERNS [list]** | Issues present but not blocking. | Surface to user via `AskUserQuestion` — options: `Revise flagged items` / `Accept and proceed` / `Discuss further` |
| **REJECT / NOT READY [blockers]** | Blocking issues. Do not proceed. | Surface blockers to user. Do not write files or advance stage until resolved. |

> **中文翻译**：

| 裁决 | 含义 | 默认操作 |
|------|------|----------|
| **APPROVE / READY** | 无问题。继续。 | 继续工作流 |
| **CONCERNS [列表]** | 存在问题但不阻塞。 | 通过 `AskUserQuestion` 呈现给用户——选项：`修改标记项` / `接受并继续` / `进一步讨论` |
| **REJECT / NOT READY [阻塞项]** | 阻塞性问题。不可继续。 | 将阻塞项呈现给用户。在解决前不要写入文件或推进阶段。 |

**Escalation rule**: When multiple directors are spawned in parallel, apply the
strictest verdict — one NOT READY overrides all READY verdicts.

> **中文翻译**：**升级规则**：当并行生成多个总监时，应用最严格的裁决——一个 NOT READY 覆盖所有 READY 裁决。

---

## Recording Gate Outcomes / 记录门控结果

After a gate resolves, record the verdict in the relevant document's status header:

> **中文翻译**：门控解决后，在相关文档的状态头中记录裁决：

```markdown
> **[Director] Review ([GATE-ID])**: APPROVED [date] / CONCERNS (accepted) [date] / REVISED [date]
```

> **中文翻译**：
> ```markdown
> > **[总监] 审查 ([GATE-ID])**：已批准 [日期] / 关注（已接受）[日期] / 已修订 [日期]
> ```

For phase gates, record in `docs/architecture/architecture.md` or
`production/session-state/active.md` as appropriate.

> **中文翻译**：对于阶段门控，根据情况记录在 `docs/architecture/architecture.md` 或 `production/session-state/active.md` 中。

---

## Tier 1 — Creative Director Gates / 第一层 — 创意总监门控

Agent: `creative-director` | Model tier: GLM-5v-Turbo | Domain: Vision, pillars, player experience

> **中文翻译**：代理：`creative-director` | 模型层级：GLM-5v-Turbo | 领域：愿景、支柱、玩家体验

---

### CD-PILLARS — Pillar Stress Test / 支柱压力测试

**Trigger**: After game pillars and anti-pillars are defined (brainstorm Phase 4,
or any time pillars are revised)

> **中文翻译**：**触发时机**：在游戏支柱和反支柱定义之后（brainstorm 第四阶段，或任何修订支柱的时候）

**Context to pass**:
- Full pillar set with names, definitions, and design tests
- Anti-pillars list
- Core fantasy statement
- Unique hook ("Like X, AND ALSO Y")

> **中文翻译**：**需要传递的上下文**：
- 完整支柱集，包含名称、定义和设计测试
- 反支柱列表
- 核心幻想陈述
- 独特卖点（"像X，而且还有Y"）

**Prompt**:
> "Review these game pillars. Are they falsifiable — could a real design decision
> actually fail this pillar? Do they create meaningful tension with each other? Do
> they differentiate this game from its closest comparables? Would they help resolve
> a design disagreement in practice, or are they too vague to be useful? Return
> specific feedback for each pillar and an overall verdict: APPROVE (strong), CONCERNS
> [list] (needs sharpening), or REJECT (weak — pillars do not carry weight)."

> **中文翻译**：**提示词**：
> "审查这些游戏支柱。它们是否可证伪——一个真实的设计决策能否实际违反这个支柱？它们之间是否创造了有意义的张力？它们是否将这款游戏与最接近的同类游戏区分开来？它们在实践中是否有助于解决设计分歧，还是太模糊而无法使用？对每个支柱返回具体反馈和总体裁决：APPROVE（强有力）、CONCERNS [列表]（需要强化）或 REJECT（弱——支柱没有分量）。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

### CD-GDD-ALIGN — GDD Pillar Alignment Check / GDD 支柱对齐检查

**Trigger**: After a system GDD is authored (design-system, quick-design, or any
workflow that produces a GDD)

> **中文翻译**：**触发时机**：在系统 GDD 编写之后（design-system、quick-design 或任何产出 GDD 的工作流）

**Context to pass**:
- GDD file path
- Game pillars (from `design/gdd/game-concept.md` or `design/gdd/game-pillars.md`)
- MDA aesthetics target for this game
- System's stated Player Fantasy section

> **中文翻译**：**需要传递的上下文**：
- GDD 文件路径
- 游戏支柱（来自 `design/gdd/game-concept.md` 或 `design/gdd/game-pillars.md`）
- 该游戏的 MDA 美学目标
- 系统声明的玩家幻想部分

**Prompt**:
> "Review this system GDD for pillar alignment. Does every section serve the stated
> pillars? Are there mechanics or rules that contradict or weaken a pillar? Does
> the Player Fantasy section match the game's core fantasy? Return APPROVE, CONCERNS
> [specific sections with issues], or REJECT [pillar violations that must be
> redesigned before this system is implementable]."

> **中文翻译**：**提示词**：
> "审查此系统 GDD 的支柱对齐情况。每个部分是否服务于声明的支柱？是否存在与支柱矛盾或削弱支柱的机制或规则？玩家幻想部分是否匹配游戏的核心幻想？返回 APPROVE、CONCERNS [有问题的具体部分] 或 REJECT [必须在系统可实现之前重新设计的支柱违规]。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

### CD-SYSTEMS — Systems Decomposition Vision Check / 系统分解愿景检查

**Trigger**: After the systems index is written by `/map-systems` — validates the
complete system set before GDD authoring begins

> **中文翻译**：**触发时机**：在 `/map-systems` 编写系统索引之后——在 GDD 编写开始前验证完整系统集

**Context to pass**:
- Systems index path (`design/gdd/systems-index.md`)
- Game pillars and core fantasy (from `design/gdd/game-concept.md`)
- Priority tier assignments (MVP / Vertical Slice / Alpha / Full Vision)
- Any high-risk or bottleneck systems identified in the dependency map

> **中文翻译**：**需要传递的上下文**：
- 系统索引路径（`design/gdd/systems-index.md`）
- 游戏支柱和核心幻想（来自 `design/gdd/game-concept.md`）
- 优先级层次分配（MVP / 垂直切片 / Alpha / 完整愿景）
- 依赖图中识别的任何高风险或瓶颈系统

**Prompt**:
> "Review this systems decomposition against the game's design pillars. Does the
> full set of MVP-tier systems collectively deliver the core fantasy? Are there
> systems whose mechanics don't serve any stated pillar — indicating they may be
> scope creep? Are there pillar-critical player experiences that have no system
> assigned to deliver them? Are any systems missing that the core loop requires?
> Return APPROVE (systems serve the vision), CONCERNS [specific gaps or
> misalignments with their pillar implications], or REJECT [fundamental gaps —
> the decomposition misses critical design intent and must be revised before GDD
> authoring begins]."

> **中文翻译**：**提示词**：
> "对照游戏设计支柱审查此系统分解。完整的 MVP 层系统是否共同交付了核心幻想？是否存在其机制不服务于任何声明的支柱的系统——表明它们可能是范围蔓延？是否存在对支柱至关重要的玩家体验没有分配系统来交付？核心循环是否缺少任何必需的系统？返回 APPROVE（系统服务于愿景）、CONCERNS [具体差距或与支柱含义的偏差] 或 REJECT [根本性差距——分解遗漏了关键设计意图，必须在 GDD 编写开始前修订]。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

### CD-NARRATIVE — Narrative Consistency Check / 叙事一致性检查

**Trigger**: After narrative GDDs, lore documents, dialogue specs, or world-building
documents are authored (team-narrative, design-system for story systems, writer
deliverables)

> **中文翻译**：**触发时机**：在叙事 GDD、背景设定文档、对话规格或世界构建文档编写之后（team-narrative、故事系统的 design-system、writer 交付物）

**Context to pass**:
- Document file path(s)
- Game pillars
- Narrative direction brief or tone guide (if exists at `design/narrative/`)
- Any existing lore that the new document references

> **中文翻译**：**需要传递的上下文**：
- 文档文件路径
- 游戏支柱
- 叙事方向简报或语调指南（如存在于 `design/narrative/`）
- 新文档引用的任何现有背景设定

**Prompt**:
> "Review this narrative content for consistency with the game's pillars and
> established world rules. Does the tone match the game's established voice? Are
> there contradictions with existing lore or world-building? Does the content serve
> the player experience pillar? Return APPROVE, CONCERNS [specific inconsistencies],
> or REJECT [contradictions that break world coherence]."

> **中文翻译**：**提示词**：
> "审查此叙事内容与游戏支柱和既定世界规则的一致性。语调是否匹配游戏既定的声音？是否与现有背景设定或世界构建存在矛盾？内容是否服务于玩家体验支柱？返回 APPROVE、CONCERNS [具体不一致处] 或 REJECT [破坏世界连贯性的矛盾]。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

### CD-PLAYTEST — Player Experience Validation / 玩家体验验证

**Trigger**: After playtest reports are generated (`/playtest-report`), or after
any session that produces player feedback

> **中文翻译**：**触发时机**：在生成试玩报告之后（`/playtest-report`），或在任何产生玩家反馈的会话之后

**Context to pass**:
- Playtest report file path
- Game pillars and core fantasy statement
- The specific hypothesis being tested

> **中文翻译**：**需要传递的上下文**：
- 试玩报告文件路径
- 游戏支柱和核心幻想陈述
- 正在测试的具体假设

**Prompt**:
> "Review this playtest report against the game's design pillars and core fantasy.
> Is the player experience matching the intended fantasy? Are there systematic issues
> that represent pillar drift — mechanics that feel fine in isolation but undermine
> the intended experience? Return APPROVE (core fantasy is landing), CONCERNS [gaps
> between intended and actual experience], or REJECT [core fantasy is not present —
> redesign needed before further playtesting]."

> **中文翻译**：**提示词**：
> "对照游戏设计支柱和核心幻想审查此试玩报告。玩家体验是否匹配预期幻想？是否存在代表支柱漂移的系统性问题——单独感觉良好但破坏预期体验的机制？返回 APPROVE（核心幻想正在实现）、CONCERNS [预期与实际体验之间的差距] 或 REJECT [核心幻想未出现——在进一步试玩前需要重新设计]。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

### CD-PHASE-GATE — Creative Readiness at Phase Transition / 阶段转换时的创意就绪度

**Trigger**: Always at `/gate-check` — spawn in parallel with TD-PHASE-GATE and PR-PHASE-GATE

> **中文翻译**：**触发时机**：总是在 `/gate-check` 时——与 TD-PHASE-GATE 和 PR-PHASE-GATE 并行生成

**Context to pass**:
- Target phase name
- List of all artifacts present (file paths)
- Game pillars and core fantasy

> **中文翻译**：**需要传递的上下文**：
- 目标阶段名称
- 所有现有产物列表（文件路径）
- 游戏支柱和核心幻想

**Prompt**:
> "Review the current project state for [target phase] gate readiness from a
> creative direction perspective. Are the game pillars faithfully represented in
> all design artifacts? Does the current state preserve the core fantasy? Are there
> any design decisions across GDDs or architecture that compromise the intended
> player experience? Return READY, CONCERNS [list], or NOT READY [blockers]."

> **中文翻译**：**提示词**：
> "从创意方向角度审查当前项目状态的 [目标阶段] 门控就绪度。游戏支柱是否在所有设计产物中忠实地体现？当前状态是否保留了核心幻想？在 GDD 或架构中是否存在损害预期玩家体验的设计决策？返回 READY、CONCERNS [列表] 或 NOT READY [阻塞项]。"

**Verdicts**: READY / CONCERNS / NOT READY

> **中文翻译**：**裁决**：READY / CONCERNS / NOT READY

---

## Tier 1 — Technical Director Gates / 第一层 — 技术总监门控

Agent: `technical-director` | Model tier: DeepSeek-V3.2 | Domain: Architecture, engine risk, performance

> **中文翻译**：代理：`technical-director` | 模型层级：DeepSeek-V3.2 | 领域：架构、引擎风险、性能

---

### TD-SYSTEM-BOUNDARY — System Boundary Architecture Review / 系统边界架构审查

**Trigger**: After `/map-systems` Phase 3 dependency mapping is agreed but before
GDD authoring begins — validates that the system structure is architecturally
sound before teams invest in writing GDDs against it

> **中文翻译**：**触发时机**：在 `/map-systems` 第三阶段依赖映射达成一致之后，但在 GDD 编写开始之前——验证系统结构在架构上是健全的，在团队投入编写 GDD 之前

**Context to pass**:
- Systems index path (or the dependency map summary if index not yet written)
- Layer assignments (Foundation / Core / Feature / Presentation / Polish)
- The full dependency graph (what each system depends on)
- Any bottleneck systems flagged (many dependents)
- Any circular dependencies found and their proposed resolutions

> **中文翻译**：**需要传递的上下文**：
- 系统索引路径（或如果索引尚未编写时的依赖映射摘要）
- 层分配（基础层 / 核心层 / 功能层 / 表现层 / 打磨层）
- 完整依赖图（每个系统依赖什么）
- 标记的任何瓶颈系统（有多个依赖方）
- 发现的任何循环依赖及其建议解决方案

**Prompt**:
> "Review this systems decomposition from an architectural perspective before GDD
> authoring begins. Are the system boundaries clean — does each system own a
> distinct concern with minimal overlap? Are there God Object risks (systems doing
> too much)? Does the dependency ordering create implementation-sequencing problems?
> Are there implicit shared-state problems in the proposed boundaries that will
> cause tight coupling when implemented? Are any Foundation-layer systems actually
> dependent on Feature-layer systems (inverted dependency)? Return APPROVE
> (boundaries are architecturally sound — proceed to GDD authoring), CONCERNS
> [specific boundary issues to address in the GDDs themselves], or REJECT
> [fundamental boundary problems — the system structure will cause architectural
> issues and must be restructured before any GDD is written]."

> **中文翻译**：**提示词**：
> "在 GDD 编写开始之前从架构角度审查此系统分解。系统边界是否清晰——每个系统是否拥有一个独特的关注点，且重叠最小？是否存在上帝对象风险（系统做了太多事情）？依赖排序是否造成实现顺序问题？建议的边界中是否存在隐式共享状态问题，在实现时会导致紧耦合？是否有任何基础层系统实际上依赖于功能层系统（倒置依赖）？返回 APPROVE（边界在架构上是健全的——继续 GDD 编写）、CONCERNS [在 GDD 中需要解决的具体边界问题] 或 REJECT [根本性边界问题——系统结构会导致架构问题，必须在编写任何 GDD 之前重构]。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

### TD-FEASIBILITY — Technical Feasibility Assessment / 技术可行性评估

**Trigger**: After biggest technical risks are identified during scope/feasibility
(brainstorm Phase 6, quick-design, or any early-stage concept with technical unknowns)

> **中文翻译**：**触发时机**：在范围/可行性阶段识别了最大技术风险之后（brainstorm 第六阶段、quick-design 或任何有技术未知数的早期概念）

**Context to pass**:
- Concept's core loop description
- Platform target
- Engine choice (or "undecided")
- List of identified technical risks

> **中文翻译**：**需要传递的上下文**：
- 概念的核心循环描述
- 平台目标
- 引擎选择（或"未决定"）
- 已识别的技术风险列表

**Prompt**:
> "Review these technical risks for a [genre] game targeting [platform] using
> [engine or 'undecided engine']. Flag any HIGH risk items that could invalidate
> the concept as described, any risks that are engine-specific and should influence
> the engine choice, and any risks that are commonly underestimated by solo
> developers. Return VIABLE (risks are manageable), CONCERNS [list with mitigation
> suggestions], or HIGH RISK [blockers that require concept or scope revision]."

> **中文翻译**：**提示词**：
> "审查这些技术风险，针对一款 [类型] 游戏，目标平台 [平台]，使用 [引擎或'未决定引擎']。标记任何可能使所述概念失效的高风险项、任何特定于引擎且应影响引擎选择的风险，以及任何常被独立开发者低估的风险。返回 VIABLE（风险可控）、CONCERNS [列表及缓解建议] 或 HIGH RISK [需要概念或范围修订的阻塞项]。"

**Verdicts**: VIABLE / CONCERNS / HIGH RISK

> **中文翻译**：**裁决**：VIABLE / CONCERNS / HIGH RISK

---

### TD-ARCHITECTURE — Architecture Sign-Off / 架构签署

**Trigger**: After the master architecture document is drafted (`/create-architecture`
Phase 7), and after any major architecture revision

> **中文翻译**：**触发时机**：在主架构文档起草之后（`/create-architecture` 第七阶段），以及在任何重大架构修订之后

**Context to pass**:
- Architecture document path (`docs/architecture/architecture.md`)
- Technical requirements baseline (TR-IDs and count)
- ADR list with statuses
- Engine knowledge gap inventory

> **中文翻译**：**需要传递的上下文**：
- 架构文档路径（`docs/architecture/architecture.md`）
- 技术需求基线（TR-ID 和数量）
- ADR 列表及状态
- 引擎知识差距清单

**Prompt**:
> "Review this master architecture document for technical soundness. Check: (1) Is
> every technical requirement from the baseline covered by an architectural decision?
> (2) Are all HIGH risk engine domains explicitly addressed or flagged as open
> questions? (3) Are the API boundaries clean, minimal, and implementable? (4) Are
> Foundation layer ADR gaps resolved before implementation begins? Return APPROVE,
> CONCERNS [list], or REJECT [blockers that must be resolved before coding starts]."

> **中文翻译**：**提示词**：
> "审查此主架构文档的技术健全性。检查：（1）基线中的每个技术需求是否都有架构决策覆盖？（2）所有高风险引擎领域是否被明确处理或标记为开放问题？（3）API 边界是否清晰、最小且可实现？（4）基础层 ADR 差距是否在实现开始前已解决？返回 APPROVE、CONCERNS [列表] 或 REJECT [必须在编码开始前解决的阻塞项]。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

### TD-ADR — Architecture Decision Review / 架构决策审查

**Trigger**: After an individual ADR is authored (`/architecture-decision`), before
it is marked Accepted

> **中文翻译**：**触发时机**：在单个 ADR 编写之后（`/architecture-decision`），在标记为已接受之前

**Context to pass**:
- ADR file path
- Engine version and knowledge gap risk level for the domain
- Related ADRs (if any)

> **中文翻译**：**需要传递的上下文**：
- ADR 文件路径
- 引擎版本和该领域的知识差距风险级别
- 相关 ADR（如有）

**Prompt**:
> "Review this Architecture Decision Record. Does it have a clear problem statement
> and rationale? Are the rejected alternatives genuinely considered? Does the
> Consequences section acknowledge the trade-offs honestly? Is the engine version
> stamped? Are post-cutoff API risks flagged? Does it link to the GDD requirements
> it covers? Return APPROVE, CONCERNS [specific gaps], or REJECT [the decision is
> underspecified or makes unsound technical assumptions]."

> **中文翻译**：**提示词**：
> "审查此架构决策记录。它是否有清晰的问题陈述和理由？被拒绝的替代方案是否被真正考虑？后果部分是否诚实地承认了权衡？引擎版本是否已标记？截止日期后的 API 风险是否被标记？它是否链接到它覆盖的 GDD 需求？返回 APPROVE、CONCERNS [具体差距] 或 REJECT [决策不够具体或做出了不健全的技术假设]。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

### TD-ENGINE-RISK — Engine Version Risk Review / 引擎版本风险审查

**Trigger**: When making architecture decisions that touch post-cutoff engine APIs,
or before finalizing any engine-specific implementation approach

> **中文翻译**：**触发时机**：在做出涉及截止日期后引擎 API 的架构决策时，或在最终确定任何引擎特定实现方案之前

**Context to pass**:
- The specific API or feature being used
- Engine version and LLM knowledge cutoff (from `docs/engine-reference/[engine]/VERSION.md`)
- Relevant excerpt from breaking-changes or deprecated-apis docs

> **中文翻译**：**需要传递的上下文**：
- 正在使用的具体 API 或功能
- 引擎版本和 LLM 知识截止日期（来自 `docs/engine-reference/[engine]/VERSION.md`）
- 重大变更或弃用 API 文档的相关摘录

**Prompt**:
> "Review this engine API usage against the version reference. Is this API present
> in [engine version]? Has its signature, behaviour, or namespace changed since the
> LLM knowledge cutoff? Are there known deprecations or post-cutoff alternatives?
> Return APPROVE (safe to use as described), CONCERNS [verify before implementing],
> or REJECT [API has changed — provide corrected approach]."

> **中文翻译**：**提示词**：
> "对照版本参考审查此引擎 API 用法。此 API 是否存在于 [引擎版本] 中？自 LLM 知识截止日期以来，其签名、行为或命名空间是否发生了变化？是否有已知的弃用或截止日期后的替代方案？返回 APPROVE（可按描述安全使用）、CONCERNS [实现前需验证] 或 REJECT [API 已变更——提供修正方案]。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

### TD-PHASE-GATE — Technical Readiness at Phase Transition / 阶段转换时的技术就绪度

**Trigger**: Always at `/gate-check` — spawn in parallel with CD-PHASE-GATE and PR-PHASE-GATE

> **中文翻译**：**触发时机**：总是在 `/gate-check` 时——与 CD-PHASE-GATE 和 PR-PHASE-GATE 并行生成

**Context to pass**:
- Target phase name
- Architecture document path (if exists)
- Engine reference path
- ADR list

> **中文翻译**：**需要传递的上下文**：
- 目标阶段名称
- 架构文档路径（如存在）
- 引擎参考路径
- ADR 列表

**Prompt**:
> "Review the current project state for [target phase] gate readiness from a
> technical direction perspective. Is the architecture sound for this phase? Are
> all high-risk engine domains addressed? Are performance budgets realistic and
> documented? Are Foundation-layer decisions complete enough to begin implementation?
> Return READY, CONCERNS [list], or NOT READY [blockers]."

> **中文翻译**：**提示词**：
> "从技术方向角度审查当前项目状态的 [目标阶段] 门控就绪度。此阶段的架构是否健全？所有高风险引擎领域是否已处理？性能预算是否现实且有文档记录？基础层决策是否足够完整以开始实现？返回 READY、CONCERNS [列表] 或 NOT READY [阻塞项]。"

**Verdicts**: READY / CONCERNS / NOT READY

> **中文翻译**：**裁决**：READY / CONCERNS / NOT READY

---

## Tier 1 — Producer Gates / 第一层 — 制作人门控

Agent: `producer` | Model tier: Kimi-K2.5 | Domain: Scope, timeline, dependencies, production risk

> **中文翻译**：代理：`producer` | 模型层级：Kimi-K2.5 | 领域：范围、时间线、依赖、生产风险

---

### PR-SCOPE — Scope and Timeline Validation / 范围与时间线验证

**Trigger**: After scope tiers are defined (brainstorm Phase 6, quick-design, or
any workflow that produces an MVP definition and timeline estimate)

> **中文翻译**：**触发时机**：在范围层级定义之后（brainstorm 第六阶段、quick-design 或任何产出 MVP 定义和时间线估算的工作流）

**Context to pass**:
- Full vision scope description
- MVP definition
- Timeline estimate
- Team size (solo / small team / etc.)
- Scope tiers (what ships if time runs out)

> **中文翻译**：**需要传递的上下文**：
- 完整愿景范围描述
- MVP 定义
- 时间线估算
- 团队规模（独立 / 小团队 / 等）
- 范围层级（如果时间耗尽发布什么）

**Prompt**:
> "Review this scope estimate. Is the MVP achievable in the stated timeline for
> the stated team size? Are the scope tiers correctly ordered by risk — does each
> tier deliver a shippable product if work stops there? What is the most likely
> cut point under time pressure, and is it a graceful fallback or a broken product?
> Return REALISTIC (scope matches capacity), OPTIMISTIC [specific adjustments
> recommended], or UNREALISTIC [blockers — timeline or MVP must be revised]."

> **中文翻译**：**提示词**：
> "审查此范围估算。在声明的团队规模下，MVP 是否可以在声明的时间线内实现？范围层级是否按风险正确排序——如果工作在每个层级停止，是否都能交付可发布的产品？在时间压力下最可能的切割点是什么，是优雅的降级还是残缺的产品？返回 REALISTIC（范围与能力匹配）、OPTIMISTIC [建议的具体调整] 或 UNREALISTIC [阻塞项——时间线或 MVP 必须修订]。"

**Verdicts**: REALISTIC / OPTIMISTIC / UNREALISTIC

> **中文翻译**：**裁决**：REALISTIC / OPTIMISTIC / UNREALISTIC

---

### PR-SPRINT — Sprint Feasibility Review / 冲刺可行性审查

**Trigger**: Before finalising a sprint plan (`/sprint-plan`), and after any
mid-sprint scope change

> **中文翻译**：**触发时机**：在最终确定冲刺计划之前（`/sprint-plan`），以及在任何冲刺中期范围变更之后

**Context to pass**:
- Proposed sprint story list (titles, estimates, dependencies)
- Team capacity (hours available)
- Current sprint backlog debt (if any)
- Milestone constraints

> **中文翻译**：**需要传递的上下文**：
- 建议的冲刺故事列表（标题、估算、依赖）
- 团队产能（可用小时数）
- 当前冲刺积压债务（如有）
- 里程碑约束

**Prompt**:
> "Review this sprint plan for feasibility. Is the story load realistic for the
> available capacity? Are stories correctly ordered by dependency? Are there hidden
> dependencies between stories that could block the sprint mid-way? Are any stories
> underestimated given their technical complexity? Return REALISTIC (plan is
> achievable), CONCERNS [specific risks], or UNREALISTIC [sprint must be
> descoped — identify which stories to defer]."

> **中文翻译**：**提示词**：
> "审查此冲刺计划的可行性。故事负载对于可用产能是否现实？故事是否按依赖关系正确排序？故事之间是否存在可能中途阻塞冲刺的隐藏依赖？是否有任何故事鉴于其技术复杂性被低估？返回 REALISTIC（计划可实现）、CONCERNS [具体风险] 或 UNREALISTIC [冲刺必须缩减范围——识别哪些故事应推迟]。"

**Verdicts**: REALISTIC / CONCERNS / UNREALISTIC

> **中文翻译**：**裁决**：REALISTIC / CONCERNS / UNREALISTIC

---

### PR-MILESTONE — Milestone Risk Assessment / 里程碑风险评估

**Trigger**: At milestone review (`/milestone-review`), at mid-sprint retrospectives,
or when a scope change is proposed that affects the milestone

> **中文翻译**：**触发时机**：在里程碑审查时（`/milestone-review`）、冲刺中期回顾时，或当提出影响里程碑的范围变更时

**Context to pass**:
- Milestone definition and target date
- Current completion percentage
- Blocked stories count
- Sprint velocity data (if available)

> **中文翻译**：**需要传递的上下文**：
- 里程碑定义和目标日期
- 当前完成百分比
- 阻塞故事数量
- 冲刺速度数据（如有）

**Prompt**:
> "Review this milestone status. Based on current velocity and blocked story count,
> will this milestone hit its target date? What are the top 3 production risks
> between now and the milestone? Are there scope items that should be cut to protect
> the milestone date vs. items that are non-negotiable? Return ON TRACK, AT RISK
> [specific mitigations], or OFF TRACK [date must slip or scope must cut — provide
> both options]."

> **中文翻译**：**提示词**：
> "审查此里程碑状态。基于当前速度和阻塞故事数量，此里程碑能否达到目标日期？从现在到里程碑之间前3大生产风险是什么？是否应削减某些范围项以保护里程碑日期，而非不可协商的项？返回 ON TRACK、AT RISK [具体缓解措施] 或 OFF TRACK [日期必须推迟或范围必须削减——提供两种选项]。"

**Verdicts**: ON TRACK / AT RISK / OFF TRACK

> **中文翻译**：**裁决**：ON TRACK / AT RISK / OFF TRACK

---

### PR-EPIC — Epic Structure Feasibility Review / 史诗结构可行性审查

**Trigger**: After epics are defined by `/create-epics`, before stories are
broken out — validates the epic structure is producible before `/create-stories`
is invoked

> **中文翻译**：**触发时机**：在 `/create-epics` 定义史诗之后，在拆分故事之前——在调用 `/create-stories` 之前验证史诗结构是可生产的

**Context to pass**:
- Epic definition file paths (all epics just created)
- Epic index path (`production/epics/index.md`)
- Milestone timeline and target dates
- Team capacity (solo / small team / size)
- Layer being epiced (Foundation / Core / Feature / etc.)

> **中文翻译**：**需要传递的上下文**：
- 史诗定义文件路径（刚创建的所有史诗）
- 史诗索引路径（`production/epics/index.md`）
- 里程碑时间线和目标日期
- 团队产能（独立 / 小团队 / 规模）
- 正在做史诗的层（基础层 / 核心层 / 功能层 / 等）

**Prompt**:
> "Review this epic structure for production feasibility before story breakdown
> begins. Are the epic boundaries scoped appropriately — could each epic realistically
> complete before a milestone deadline? Are epics correctly ordered by system
> dependency — does any epic require another epic's output before it can start?
> Are any epics underscoped (too small, should merge) or overscoped (too large,
> should split into 2-3 focused epics)? Are the Foundation-layer epics scoped to
> allow Core-layer epics to begin at the start of the next sprint after Foundation
> completes? Return REALISTIC (epic structure is producible), CONCERNS [specific
> structural adjustments before stories are written], or UNREALISTIC [epics must
> be split, merged, or reordered — story breakdown cannot begin until resolved]."

> **中文翻译**：**提示词**：
> "在故事拆分开始之前审查此史诗结构的生产可行性。史诗边界是否范围适当——每个史诗是否能在里程碑截止日期前实际完成？史诗是否按系统依赖正确排序——是否有史诗在开始前需要另一个史诗的输出？是否有任何史诗范围过小（应合并）或范围过大（应拆分为2-3个专注的史诗）？基础层史诗的范围是否允许核心层史诗在基础层完成后的下一个冲刺开始时启动？返回 REALISTIC（史诗结构可生产）、CONCERNS [编写故事前需要的具体结构调整] 或 UNREALISTIC [史诗必须拆分、合并或重新排序——在解决之前无法开始故事拆分]。"

**Verdicts**: REALISTIC / CONCERNS / UNREALISTIC

> **中文翻译**：**裁决**：REALISTIC / CONCERNS / UNREALISTIC

---

### PR-PHASE-GATE — Production Readiness at Phase Transition / 阶段转换时的生产就绪度

**Trigger**: Always at `/gate-check` — spawn in parallel with CD-PHASE-GATE and TD-PHASE-GATE

> **中文翻译**：**触发时机**：总是在 `/gate-check` 时——与 CD-PHASE-GATE 和 TD-PHASE-GATE 并行生成

**Context to pass**:
- Target phase name
- Sprint and milestone artifacts present
- Team size and capacity
- Current blocked story count

> **中文翻译**：**需要传递的上下文**：
- 目标阶段名称
- 现有冲刺和里程碑产物
- 团队规模和产能
- 当前阻塞故事数量

**Prompt**:
> "Review the current project state for [target phase] gate readiness from a
> production perspective. Is the scope realistic for the stated timeline and team
> size? Are dependencies properly ordered so the team can actually execute in
> sequence? Are there milestone or sprint risks that could derail the phase within
> the first two sprints? Return READY, CONCERNS [list], or NOT READY [blockers]."

> **中文翻译**：**提示词**：
> "从生产角度审查当前项目状态的 [目标阶段] 门控就绪度。范围对于声明的团队规模和时间线是否现实？依赖是否正确排序以便团队可以按序执行？是否存在可能在前两个冲刺内使阶段脱轨的里程碑或冲刺风险？返回 READY、CONCERNS [列表] 或 NOT READY [阻塞项]。"

**Verdicts**: READY / CONCERNS / NOT READY

> **中文翻译**：**裁决**：READY / CONCERNS / NOT READY

---

## Tier 1 — Art Director Gates / 第一层 — 美术总监门控

Agent: `art-director` | Model tier: MiniMax-M2.7 | Domain: Visual identity, art bible, visual production readiness

> **中文翻译**：代理：`art-director` | 模型层级：MiniMax-M2.7 | 领域：视觉标识、美术圣经、视觉生产就绪度

---

### AD-CONCEPT-VISUAL — Visual Identity Anchor / 视觉标识锚点

**Trigger**: After game pillars are locked (brainstorm Phase 4), in parallel with CD-PILLARS

> **中文翻译**：**触发时机**：在游戏支柱锁定之后（brainstorm 第四阶段），与 CD-PILLARS 并行

**Context to pass**:
- Game concept (elevator pitch, core fantasy, unique hook)
- Full pillar set with names, definitions, and design tests
- Target platform (if known)
- Any reference games or visual touchstones mentioned by the user

> **中文翻译**：**需要传递的上下文**：
- 游戏概念（电梯演讲、核心幻想、独特卖点）
- 完整支柱集，包含名称、定义和设计测试
- 目标平台（如已知）
- 用户提到的任何参考游戏或视觉参考点

**Prompt**:
> "Based on these game pillars and core concept, propose 2-3 distinct visual identity
> directions. For each direction provide: (1) a one-line visual rule that could guide
> all visual decisions (e.g., 'everything must move', 'beauty is in the decay'), (2)
> mood and atmosphere targets, (3) shape language (sharp/rounded/organic/geometric
> emphasis), (4) color philosophy (palette direction, what colors mean in this world).
> Be specific — avoid generic descriptions. One direction should directly serve the
> primary design pillar. Name each direction. Recommend which best serves the stated
> pillars and explain why."

> **中文翻译**：**提示词**：
> "基于这些游戏支柱和核心概念，提出2-3个不同的视觉标识方向。每个方向提供：（1）一条可以指导所有视觉决策的视觉规则（例如，'一切都必须动起来'、'美在腐朽中'），（2）情绪和氛围目标，（3）形状语言（锐利/圆润/有机/几何强调），（4）色彩哲学（调色板方向，颜色在这个世界中意味着什么）。要具体——避免通用描述。一个方向应直接服务于主要设计支柱。为每个方向命名。推荐哪个最符合声明的支柱并解释原因。"

**Verdicts**: CONCEPTS (multiple valid options — user selects) / STRONG (one direction clearly dominant) / CONCERNS (pillars don't provide enough direction to differentiate visual identity yet)

> **中文翻译**：**裁决**：CONCEPTS（多个有效选项——用户选择）/ STRONG（一个方向明显占主导）/ CONCERNS（支柱没有提供足够方向来区分视觉标识）

---

### AD-ART-BIBLE — Art Bible Sign-Off / 美术圣经签署

**Trigger**: After the art bible is drafted (`/art-bible`), before asset production begins

> **中文翻译**：**触发时机**：在美术圣经起草之后（`/art-bible`），在资产生产开始之前

**Context to pass**:
- Art bible path (`design/art/art-bible.md`)
- Game pillars and core fantasy
- Platform and performance constraints (from `.codebuddy/docs/technical-preferences.md` if configured)
- Visual identity anchor chosen during brainstorm (from `design/gdd/game-concept.md`)

> **中文翻译**：**需要传递的上下文**：
- 美术圣经路径（`design/art/art-bible.md`）
- 游戏支柱和核心幻想
- 平台和性能约束（来自 `.codebuddy/docs/technical-preferences.md`，如已配置）
- brainstorm 期间选择的视觉标识锚点（来自 `design/gdd/game-concept.md`）

**Prompt**:
> "Review this art bible for completeness and internal consistency. Does the color
> system match the mood targets? Does the shape language follow from the visual
> identity statement? Are the asset standards achievable within the platform
> constraints? Does the character design direction give artists enough to work from
> without over-specifying? Are there contradictions between sections? Would an
> outsourcing team be able to produce assets from this document without additional
> briefing? Return APPROVE (art bible is production-ready), CONCERNS [specific
> sections needing clarification], or REJECT [fundamental inconsistencies that must
> be resolved before asset production begins]."

> **中文翻译**：**提示词**：
> "审查此美术圣经的完整性和内部一致性。色彩系统是否匹配情绪目标？形状语言是否遵循视觉标识陈述？资产标准是否在平台约束内可实现？角色设计方向是否给了美术师足够的工作依据而不过度规定？各部分之间是否存在矛盾？外包团队能否仅凭此文档生产资产而无需额外简报？返回 APPROVE（美术圣经已达到生产就绪状态）、CONCERNS [需要澄清的具体部分] 或 REJECT [必须在资产生产开始前解决的根本性不一致]。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

### AD-PHASE-GATE — Visual Readiness at Phase Transition / 阶段转换时的视觉就绪度

**Trigger**: Always at `/gate-check` — spawn in parallel with CD-PHASE-GATE, TD-PHASE-GATE, and PR-PHASE-GATE

> **中文翻译**：**触发时机**：总是在 `/gate-check` 时——与 CD-PHASE-GATE、TD-PHASE-GATE 和 PR-PHASE-GATE 并行生成

**Context to pass**:
- Target phase name
- List of all art/visual artifacts present (file paths)
- Visual identity anchor from `design/gdd/game-concept.md` (if present)
- Art bible path if it exists (`design/art/art-bible.md`)

> **中文翻译**：**需要传递的上下文**：
- 目标阶段名称
- 所有现有美术/视觉产物列表（文件路径）
- 来自 `design/gdd/game-concept.md` 的视觉标识锚点（如存在）
- 美术圣经路径（如存在 `design/art/art-bible.md`）

**Prompt**:
> "Review the current project state for [target phase] gate readiness from a visual
> direction perspective. Is the visual identity established and documented at the
> level this phase requires? Are the right visual artifacts in place? Would visual
> teams be able to begin their work without visual direction gaps that cause costly
> rework later? Are there visual decisions that are being deferred past their latest
> responsible moment? Return READY, CONCERNS [specific visual direction gaps that
> could cause production rework], or NOT READY [visual blockers that must exist
> before this phase can succeed — specify what artifact is missing and why it
> matters at this stage]."

> **中文翻译**：**提示词**：
> "从视觉方向角度审查当前项目状态的 [目标阶段] 门控就绪度。视觉标识是否已建立并记录到此阶段所需的水平？是否具备正确的视觉产物？视觉团队能否在无视觉方向缺口的情况下开始工作（这些缺口可能导致后期昂贵的返工）？是否有视觉决策被推迟到了最迟负责时刻之后？返回 READY、CONCERNS [可能导致生产返工的具体视觉方向缺口] 或 NOT READY [此阶段成功之前必须存在的视觉阻塞项——说明缺少什么产物以及为什么在此阶段很重要]。"

**Verdicts**: READY / CONCERNS / NOT READY

> **中文翻译**：**裁决**：READY / CONCERNS / NOT READY

---

## Tier 2 — Lead Gates / 第二层 — 主管门控

These gates are invoked by orchestration skills and senior skills when a domain
specialist's feasibility sign-off is needed. Tier 2 leads use GLM-5.1 (default).

> **中文翻译**：这些门控在需要领域专家的可行性签署时，由编排技能和高级技能调用。第二层主管使用 GLM-5.1（默认）。

---

### LP-FEASIBILITY — Lead Programmer Implementation Feasibility / 主管程序员实现可行性

**Trigger**: After the master architecture document is written (`/create-architecture`
Phase 7b), or when a new architectural pattern is proposed

> **中文翻译**：**触发时机**：在主架构文档编写之后（`/create-architecture` 第七阶段b），或当提出新的架构模式时

**Context to pass**:
- Architecture document path
- Technical requirements baseline summary
- ADR list with statuses

> **中文翻译**：**需要传递的上下文**：
- 架构文档路径
- 技术需求基线摘要
- ADR 列表及状态

**Prompt**:
> "Review this architecture for implementation feasibility. Flag: (a) any decisions
> that would be difficult or impossible to implement with the stated engine and
> language, (b) any missing interface definitions that programmers would need to
> invent themselves, (c) any patterns that create avoidable technical debt or
> that contradict standard [engine] idioms. Return FEASIBLE, CONCERNS [list], or
> INFEASIBLE [blockers that make this architecture unimplementable as written]."

> **中文翻译**：**提示词**：
> "审查此架构的实现可行性。标记：（a）任何用声明的引擎和语言难以或无法实现的决策，（b）任何程序员需要自行发明的缺失接口定义，（c）任何造成可避免技术债务或与标准 [引擎] 习惯用法矛盾的模式。返回 FEASIBLE、CONCERNS [列表] 或 INFEASIBLE [使此架构按所写无法实现的阻塞项]。"

**Verdicts**: FEASIBLE / CONCERNS / INFEASIBLE

> **中文翻译**：**裁决**：FEASIBLE / CONCERNS / INFEASIBLE

---

### LP-CODE-REVIEW — Lead Programmer Code Review / 主管程序员代码审查

**Trigger**: After a dev story is implemented (`/dev-story`, `/story-done`), or
as part of `/code-review`

> **中文翻译**：**触发时机**：在开发故事实现之后（`/dev-story`、`/story-done`），或作为 `/code-review` 的一部分

**Context to pass**:
- Implementation file paths
- Story file path (for acceptance criteria)
- Relevant GDD section
- ADR that governs this system

> **中文翻译**：**需要传递的上下文**：
- 实现文件路径
- 故事文件路径（用于验收标准）
- 相关 GDD 部分
- 管辖此系统的 ADR

**Prompt**:
> "Review this implementation against the story acceptance criteria and governing
> ADR. Does the code match the architecture boundary definitions? Are there
> violations of the coding standards or forbidden patterns? Is the public API
> testable and documented? Are there any correctness issues against the GDD rules?
> Return APPROVE, CONCERNS [specific issues], or REJECT [must be revised before merge]."

> **中文翻译**：**提示词**：
> "对照故事验收标准和管理 ADR 审查此实现。代码是否匹配架构边界定义？是否存在违反编码标准或禁止模式的情况？公共 API 是否可测试且有文档？是否存在对 GDD 规则的正确性问题？返回 APPROVE、CONCERNS [具体问题] 或 REJECT [合并前必须修订]。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

### QL-STORY-READY — QA Lead Story Readiness Check / QA 主管故事就绪度检查

**Trigger**: Before a story is accepted into a sprint — invoked by `/create-stories`,
`/story-readiness`, and `/sprint-plan` during story selection

> **中文翻译**：**触发时机**：在故事被接受进入冲刺之前——由 `/create-stories`、`/story-readiness` 和 `/sprint-plan` 在故事选择时调用

**Context to pass**:
- Story file path
- Story type (Logic / Integration / Visual/Feel / UI / Config/Data)
- Acceptance criteria list (verbatim from the story)
- The GDD requirement (TR-ID and text) the story covers

> **中文翻译**：**需要传递的上下文**：
- 故事文件路径
- 故事类型（逻辑 / 集成 / 视觉感受 / UI / 配置数据）
- 验收标准列表（原文摘自故事）
- 故事覆盖的 GDD 需求（TR-ID 和文本）

**Prompt**:
> "Review this story's acceptance criteria for testability before it enters the
> sprint. Are all criteria specific enough that a developer would know unambiguously
> when they are done? For Logic-type stories: can every criterion be verified with
> an automated test? For Integration stories: is each criterion observable in a
> controlled test environment? Flag criteria that are too vague to implement
> against, and flag criteria that require a full game build to test (mark these
> DEFERRED, not BLOCKED). Return ADEQUATE (criteria are implementable as written),
> GAPS [specific criteria needing refinement], or INADEQUATE [criteria are too
> vague — story must be revised before sprint inclusion]."

> **中文翻译**：**提示词**：
> "在故事进入冲刺之前审查其验收标准的可测试性。所有标准是否足够具体，使开发者能明确知道何时完成？对于逻辑类型故事：每个标准是否可以用自动化测试验证？对于集成故事：每个标准是否在受控测试环境中可观察？标记太模糊而无法实现的标准，以及需要完整游戏构建才能测试的标准（标记为 DEFERRED，而非 BLOCKED）。返回 ADEQUATE（标准可按所写实现）、GAPS [需要细化的具体标准] 或 INADEQUATE [标准太模糊——故事在纳入冲刺前必须修订]。"

**Verdicts**: ADEQUATE / GAPS / INADEQUATE

> **中文翻译**：**裁决**：ADEQUATE / GAPS / INADEQUATE

---

### QL-TEST-COVERAGE — QA Lead Test Coverage Review / QA 主管测试覆盖审查

**Trigger**: After implementation stories are complete, before marking an epic
done, or at `/gate-check` Production → Polish

> **中文翻译**：**触发时机**：在实现故事完成后、标记史诗完成前，或在 `/gate-check` 生产 → 打磨时

**Context to pass**:
- List of implemented stories with story types (Logic / Integration / Visual / UI / Config)
- Test file paths in `tests/`
- GDD acceptance criteria for the system

> **中文翻译**：**需要传递的上下文**：
- 已实现故事列表及故事类型（逻辑 / 集成 / 视觉 / UI / 配置）
- `tests/` 中的测试文件路径
- 系统的 GDD 验收标准

**Prompt**:
> "Review the test coverage for these implementation stories. Are all Logic stories
> covered by passing unit tests? Are Integration stories covered by integration
> tests or documented playtests? Are the GDD acceptance criteria each mapped to at
> least one test? Are there untested edge cases from the GDD Edge Cases section?
> Return ADEQUATE (coverage meets standards), GAPS [specific missing tests], or
> INADEQUATE [critical logic is untested — do not advance]."

> **中文翻译**：**提示词**：
> "审查这些实现故事的测试覆盖。所有逻辑故事是否被通过的单位测试覆盖？集成故事是否被集成测试或文档化试玩覆盖？GDD 验收标准是否每个都映射到至少一个测试？GDD 边界情况部分是否有未测试的边界情况？返回 ADEQUATE（覆盖达到标准）、GAPS [具体缺失测试] 或 INADEQUATE [关键逻辑未测试——不要推进]。"

**Verdicts**: ADEQUATE / GAPS / INADEQUATE

> **中文翻译**：**裁决**：ADEQUATE / GAPS / INADEQUATE

---

### ND-CONSISTENCY — Narrative Director Consistency Check / 叙事总监一致性检查

**Trigger**: After writer deliverables (dialogue, lore, item descriptions) are
authored, or when a design decision has narrative implications

> **中文翻译**：**触发时机**：在编写者交付物（对话、背景设定、物品描述）编写之后，或当设计决策有叙事影响时

**Context to pass**:
- Document or content file path(s)
- Narrative bible or tone guide path (if exists)
- Relevant world-building rules
- Character or faction profiles affected

> **中文翻译**：**需要传递的上下文**：
- 文档或内容文件路径
- 叙事圣经或语调指南路径（如存在）
- 相关世界构建规则
- 受影响的角色或阵营档案

**Prompt**:
> "Review this narrative content for internal consistency and adherence to
> established world rules. Are character voices consistent with their established
> profiles? Does the lore contradict any established facts? Is the tone consistent
> with the game's narrative direction? Return APPROVE, CONCERNS [specific
> inconsistencies to fix], or REJECT [contradictions that break the narrative
> foundation]."

> **中文翻译**：**提示词**：
> "审查此叙事内容的内部一致性和对既定世界规则的遵守。角色声音是否与既定档案一致？背景设定是否与既定事实矛盾？语调是否与游戏的叙事方向一致？返回 APPROVE、CONCERNS [需要修复的具体不一致处] 或 REJECT [破坏叙事基础的矛盾]。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

### AD-VISUAL — Art Director Visual Consistency Review / 美术总监视觉一致性审查

**Trigger**: After art direction decisions are made, when new asset types are
introduced, or when a tech art decision affects visual style

> **中文翻译**：**触发时机**：在美术方向决策做出之后、当引入新资产类型时，或当技术美术决策影响视觉风格时

**Context to pass**:
- Art bible path (if exists at `design/art-bible.md`)
- The specific asset type, style decision, or visual direction being reviewed
- Reference images or style descriptions
- Platform and performance constraints

> **中文翻译**：**需要传递的上下文**：
- 美术圣经路径（如存在于 `design/art-bible.md`）
- 正在审查的具体资产类型、风格决策或视觉方向
- 参考图像或风格描述
- 平台和性能约束

**Prompt**:
> "Review this visual direction decision for consistency with the established art
> style and production constraints. Does it match the art bible? Is it achievable
> within the platform's performance budget? Are there asset pipeline implications
> that create technical risk? Return APPROVE, CONCERNS [specific adjustments], or
> REJECT [style violation or production risk that must be resolved first]."

> **中文翻译**：**提示词**：
> "审查此视觉方向决策与既定美术风格和生产约束的一致性。它是否匹配美术圣经？在平台性能预算内是否可实现？是否存在造成技术风险的资产管线影响？返回 APPROVE、CONCERNS [具体调整] 或 REJECT [必须先解决的风格违规或生产风险]。"

**Verdicts**: APPROVE / CONCERNS / REJECT

> **中文翻译**：**裁决**：APPROVE / CONCERNS / REJECT

---

## Parallel Gate Protocol / 并行门控协议

When a workflow requires multiple directors at the same checkpoint (most common
at `/gate-check`), spawn all agents simultaneously:

> **中文翻译**：当工作流在同一检查点需要多个总监时（最常见于 `/gate-check`），同时生成所有代理：

```
Spawn in parallel (issue all Task calls before waiting for any result):
1. creative-director  → gate CD-PHASE-GATE
2. technical-director → gate TD-PHASE-GATE
3. producer           → gate PR-PHASE-GATE
4. art-director       → gate AD-PHASE-GATE

Collect all four verdicts, then apply escalation rules:
- Any NOT READY / REJECT → overall verdict minimum FAIL
- Any CONCERNS → overall verdict minimum CONCERNS
- All READY / APPROVE → eligible for PASS (still subject to artifact checks)
```

> **中文翻译**：
> ```
> 并行生成（在等待任何结果之前发出所有 Task 调用）：
> 1. creative-director  → 门控 CD-PHASE-GATE
> 2. technical-director → 门控 TD-PHASE-GATE
> 3. producer           → 门控 PR-PHASE-GATE
> 4. art-director       → 门控 AD-PHASE-GATE
> 
> 收集所有四个裁决，然后应用升级规则：
> - 任何 NOT READY / REJECT → 总体裁决最低为 FAIL
> - 任何 CONCERNS → 总体裁决最低为 CONCERNS
> - 全部 READY / APPROVE → 符合 PASS 条件（仍需产物检查）
> ```

---

## Adding New Gates / 添加新门控

When a new gate is needed for a new skill or workflow:

> **中文翻译**：当新技能或工作流需要新门控时：

1. Assign a gate ID: `[DIRECTOR-PREFIX]-[DESCRIPTIVE-SLUG]`
   - Prefixes: `CD-` `TD-` `PR-` `LP-` `QL-` `ND-` `AD-`
   - Add new prefixes for new agents: `AudioDirector` → `AU-`, `UX` → `UX-`
2. Add the gate under the appropriate director section with all five fields:
   Trigger, Context to pass, Prompt, Verdicts, and any special handling notes
3. Reference it in skills by ID only — never copy the prompt text into the skill

> **中文翻译**：
> 1. 分配门控 ID：`[总监前缀]-[描述性Slug]`
>    - 前缀：`CD-` `TD-` `PR-` `LP-` `QL-` `ND-` `AD-`
>    - 为新代理添加新前缀：`AudioDirector` → `AU-`，`UX` → `UX-`
> 2. 在适当的总监部分下添加门控，包含所有五个字段：触发时机、需要传递的上下文、提示词、裁决和任何特殊处理说明
> 3. 在技能中仅通过 ID 引用——绝不将提示词文本复制到技能中

---

## Gate Coverage by Stage / 各阶段门控覆盖

| Stage | Required Gates | Optional Gates |
|-------|---------------|----------------|
| **Concept** | CD-PILLARS, AD-CONCEPT-VISUAL | TD-FEASIBILITY, PR-SCOPE |
| **Systems Design** | TD-SYSTEM-BOUNDARY, CD-SYSTEMS, PR-SCOPE, CD-GDD-ALIGN (per GDD) | ND-CONSISTENCY, AD-VISUAL |
| **Technical Setup** | TD-ARCHITECTURE, TD-ADR (per ADR), LP-FEASIBILITY, AD-ART-BIBLE | TD-ENGINE-RISK |
| **Pre-Production** | PR-EPIC, QL-STORY-READY (per story), PR-SPRINT, all four PHASE-GATEs (via gate-check) | CD-PLAYTEST |
| **Production** | LP-CODE-REVIEW (per story), QL-STORY-READY, PR-SPRINT (per sprint) | PR-MILESTONE, QL-TEST-COVERAGE, AD-VISUAL |
| **Polish** | QL-TEST-COVERAGE, CD-PLAYTEST, PR-MILESTONE | AD-VISUAL |
| **Release** | All four PHASE-GATEs (via gate-check) | QL-TEST-COVERAGE |

> **中文翻译**：

| 阶段 | 必需门控 | 可选门控 |
|------|----------|----------|
| **概念** | CD-PILLARS, AD-CONCEPT-VISUAL | TD-FEASIBILITY, PR-SCOPE |
| **系统设计** | TD-SYSTEM-BOUNDARY, CD-SYSTEMS, PR-SCOPE, CD-GDD-ALIGN（每个GDD） | ND-CONSISTENCY, AD-VISUAL |
| **技术设置** | TD-ARCHITECTURE, TD-ADR（每个ADR）, LP-FEASIBILITY, AD-ART-BIBLE | TD-ENGINE-RISK |
| **预生产** | PR-EPIC, QL-STORY-READY（每个故事）, PR-SPRINT, 所有四个阶段门控（通过gate-check） | CD-PLAYTEST |
| **生产** | LP-CODE-REVIEW（每个故事）, QL-STORY-READY, PR-SPRINT（每个冲刺） | PR-MILESTONE, QL-TEST-COVERAGE, AD-VISUAL |
| **打磨** | QL-TEST-COVERAGE, CD-PLAYTEST, PR-MILESTONE | AD-VISUAL |
| **发布** | 所有四个阶段门控（通过gate-check） | QL-TEST-COVERAGE |
