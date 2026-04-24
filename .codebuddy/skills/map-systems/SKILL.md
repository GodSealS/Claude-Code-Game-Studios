---
name: map-systems
description: "Decompose a game concept into individual systems, map dependencies, prioritize design order, and create the systems index. / 将游戏概念分解为单独的系统，映射依赖关系，确定设计优先顺序，并创建系统索引。"
argument-hint: "[next | system-name] [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion, TodoWrite, Task
---

When this skill is invoked:

> **中文翻译**：当此技能被调用时：

## Parse Arguments / 解析参数

Two modes:

> **中文翻译**：两种模式：

- **No argument**: `/map-systems` — Run the full decomposition workflow (Phases 1-5)
  to create or update the systems index. / **无参数**：运行完整的分解工作流（阶段 1-5）以创建或更新系统索引。
- **`next`**: `/map-systems next` — Pick the highest-priority undesigned system
  from the index and hand off to `/design-system` (Phase 6). / **`next`**：从索引中选择优先级最高的未设计系统并移交给 `/design-system`（阶段 6）。

Also resolve the review mode (once, store for all gate spawns this run):

> **中文翻译**：同时解析审查模式（一次，存储本次运行的所有门控启动）：

1. If `--review [full|lean|solo]` was passed → use that / 如果传递了 `--review [full|lean|solo]` → 使用该值
2. Else read `production/review-mode.txt` → use that value / 否则读取 `production/review-mode.txt` → 使用该值
3. Else → default to `lean` / 否则 → 默认为 `lean`

See `.codebuddy/docs/director-gates.md` for the full check pattern.

> **中文翻译**：完整检查模式参见 `.codebuddy/docs/director-gates.md`。

---

## Phase 1: Read Concept (Required Context) / 阶段 1：读取概念（必需上下文）

Read the game concept and any existing design work. This provides the raw material
for systems decomposition.

> **中文翻译**：读取游戏概念和任何现有的设计工作。这为系统分解提供了原始材料。

**Required / 必需：**
- Read `design/gdd/game-concept.md` — **fail with a clear message if missing**: / 读取 `design/gdd/game-concept.md` — **如缺失则失败并给出清晰消息**：
  > "No game concept found at `design/gdd/game-concept.md`. Run `/brainstorm` first
  > to create one, then come back to decompose it into systems."
  >
  > **中文翻译**："在 `design/gdd/game-concept.md` 未找到游戏概念。请先运行 `/brainstorm` 创建一个，然后再回来将其分解为系统。"

**Optional (read if they exist) / 可选（如存在则读取）：**
- Read `design/gdd/game-pillars.md` — pillars constrain priority and scope / 读取 `design/gdd/game-pillars.md` — 支柱约束优先级和范围
- Read `design/gdd/systems-index.md` — if exists, **resume** from where it left off
  (update, don't recreate from scratch) / 读取 `design/gdd/systems-index.md` — 如存在，**从上次停止处恢复**（更新而非从头创建）
- Glob `design/gdd/*.md` — check which system GDDs already exist / 搜索 `design/gdd/*.md` — 检查哪些系统 GDD 已存在

**If the systems index already exists / 如果系统索引已存在：**
- Read it and present current status to the user / 读取并向用户呈现当前状态
- Use `AskUserQuestion` to ask: / 使用 `AskUserQuestion` 询问：
  "The systems index already exists with [N] systems ([M] designed, [K] not started).
  What would you like to do?"
  - Options: "Update the index with new systems", "Design the next undesigned system",
    "Review and revise priorities" / 选项："用新系统更新索引"、"设计下一个未设计的系统"、"审查并修改优先级"

---

## Phase 2: Systems Enumeration (Collaborative) / 阶段 2：系统枚举（协作）

Extract and identify all systems the game needs. This is the creative core of the
skill — it requires human judgment because concept docs rarely enumerate every
system explicitly.

> **中文翻译**：提取并识别游戏需要的所有系统。这是此技能的创意核心——它需要人类判断，因为概念文档很少明确枚举每个系统。

### Step 2a: Extract Explicit Systems / 步骤 2a：提取显式系统

Scan the game concept for directly mentioned systems and mechanics:

> **中文翻译**：扫描游戏概念中直接提到的系统和机制：

- Core Mechanics section (most explicit) / 核心机制部分（最明确的）
- Core Loop section (implies what systems drive each loop tier) / 核心循环部分（暗示哪些系统驱动每个循环层级）
- Technical Considerations section (networking, procedural generation, etc.) / 技术考量部分（网络、程序化生成等）
- MVP Definition section (required features = required systems) / MVP 定义部分（所需功能 = 所需系统）

### Step 2b: Identify Implicit Systems / 步骤 2b：识别隐式系统

For each explicit system, identify the **hidden systems** it implies. Games always
need more systems than the concept doc mentions. Use this inference pattern:

> **中文翻译**：对于每个显式系统，识别其暗示的**隐藏系统**。游戏总是需要比概念文档提到的更多的系统。使用此推理模式：

- "Inventory" implies: item database, equipment slots, weight/capacity rules,
  inventory UI, item serialization for save/load / "背包"意味着：物品数据库、装备槽位、重量/容量规则、背包 UI、存档/读档的物品序列化
- "Combat" implies: damage calculation, health system, hit detection, status effects,
  enemy AI, combat UI (health bars, damage numbers), death/respawn / "战斗"意味着：伤害计算、生命系统、碰撞检测、状态效果、敌人 AI、战斗 UI（血条、伤害数字）、死亡/重生
- "Open world" implies: streaming/chunking, LOD system, fast travel, map/minimap,
  point of interest tracking, world state persistence / "开放世界"意味着：流式加载/分块、LOD 系统、快速旅行、地图/小地图、兴趣点追踪、世界状态持久化
- "Multiplayer" implies: networking layer, lobby/matchmaking, state synchronization,
  anti-cheat, network UI (ping, player list) / "多人游戏"意味着：网络层、大厅/匹配、状态同步、反作弊、网络 UI（延迟、玩家列表）
- "Crafting" implies: recipe database, ingredient gathering, crafting UI,
  success/failure mechanics, recipe discovery/learning / "制作"意味着：配方数据库、材料采集、制作 UI、成功/失败机制、配方发现/学习
- "Dialogue" implies: dialogue tree system, dialogue UI, choice tracking, NPC
  state management, localization hooks / "对话"意味着：对话树系统、对话 UI、选择追踪、NPC 状态管理、本地化钩子
- "Progression" implies: XP system, level-up mechanics, skill tree, unlock
  tracking, progression UI, progression save data / "进度"意味着：经验系统、升级机制、技能树、解锁追踪、进度 UI、进度存档数据

Explain in conversation text why each implicit system is needed (with examples).

> **中文翻译**：在对话文本中解释每个隐式系统为何需要（附示例）。

### Step 2c: User Review / 步骤 2c：用户审查

Present the enumeration organized by category. For each system, show:

> **中文翻译**：按类别呈现枚举。对于每个系统，显示：

- Name / 名称
- Category / 类别
- Brief description (1 sentence) / 简要描述（1 句话）
- Whether it was explicit (from concept) or implicit (inferred) / 是显式的（来自概念）还是隐式的（推断的）

Then use `AskUserQuestion` to capture feedback:

> **中文翻译**：然后使用 `AskUserQuestion` 收集反馈：

- "Are there systems missing from this list?" / "此列表中有遗漏的系统吗？"
- "Should any of these be combined or split?" / "是否有系统应该合并或拆分？"
- "Are there systems listed that this game does NOT need?" / "是否有列出的系统是这个游戏不需要的？"

Iterate until the user approves the enumeration.

> **中文翻译**：迭代直到用户批准枚举。

---

## Phase 3: Dependency Mapping (Collaborative) / 阶段 3：依赖映射（协作）

For each system, determine what it depends on. A system "depends on" another if
it cannot function without that other system existing first.

> **中文翻译**：对于每个系统，确定它依赖于什么。一个系统"依赖于"另一个系统，如果它不能在另一个系统不存在的情况下运行。

### Step 3a: Map Dependencies / 步骤 3a：映射依赖

For each system, list its dependencies. Use these dependency heuristics:

> **中文翻译**：对于每个系统，列出其依赖。使用这些依赖启发式规则：

- **Input/output dependencies**: System A produces data System B needs / **输入/输出依赖**：系统 A 产生系统 B 需要的数据
- **Structural dependencies**: System A provides the framework System B plugs into / **结构依赖**：系统 A 提供系统 B 插入的框架
- **UI dependencies**: Every gameplay system has a corresponding UI system that
  depends on it (but UI is designed after the gameplay system) / **UI 依赖**：每个游戏玩法系统都有对应的 UI 系统依赖于它（但 UI 在游戏玩法系统之后设计）

### Step 3b: Sort by Dependency Order / 步骤 3b：按依赖顺序排序

Arrange systems into layers:

> **中文翻译**：将系统排列为层级：

1. **Foundation / 基础层**: Systems with zero dependencies (designed and built first) / 零依赖的系统（首先设计和构建）
2. **Core / 核心层**: Systems depending only on Foundation systems / 仅依赖于基础层系统的系统
3. **Feature / 功能层**: Systems depending on Core systems / 依赖于核心层系统的系统
4. **Presentation / 表现层**: UI and feedback systems that wrap gameplay systems / 包装游戏玩法系统的 UI 和反馈系统
5. **Polish / 打磨层**: Meta-systems, tutorials, analytics, accessibility / 元系统、教程、分析、无障碍

### Step 3c: Detect Circular Dependencies / 步骤 3c：检测循环依赖

Check for cycles in the dependency graph. If found:

> **中文翻译**：检查依赖图中的循环。如发现：

- Highlight them to the user / 向用户突出显示
- Propose resolutions (interface abstraction, simultaneous design, breaking the
  cycle by defining a contract between the two systems) / 提出解决方案（接口抽象、同时设计、通过定义两个系统之间的契约打破循环）

### Step 3d: Present to User / 步骤 3d：呈现给用户

Show the dependency map as a layered list. Highlight:

> **中文翻译**：以分层列表显示依赖图。突出显示：

- Any circular dependencies / 任何循环依赖
- Any "bottleneck" systems (many others depend on them — these are high-risk) / 任何"瓶颈"系统（许多其他系统依赖它们——这些是高风险的）
- Any systems with no dependents (leaf nodes — lower risk, can be designed late) / 任何没有依赖者的系统（叶节点——风险较低，可以晚设计）

Use `AskUserQuestion` to ask: "Does this dependency ordering look right? Any
dependencies I'm missing or that should be removed?"

> **中文翻译**：使用 `AskUserQuestion` 询问："此依赖顺序看起来正确吗？有没有遗漏或应该移除的依赖？"

**Review mode check** — apply before spawning TD-SYSTEM-BOUNDARY:

> **中文翻译**：**审查模式检查** — 在启动 TD-SYSTEM-BOUNDARY 之前应用：

- `solo` → skip. Note: "TD-SYSTEM-BOUNDARY skipped — Solo mode." Proceed to priority assignment. / → 跳过。注意："TD-SYSTEM-BOUNDARY 已跳过——Solo 模式。" 继续优先级分配。
- `lean` → skip (not a PHASE-GATE). Note: "TD-SYSTEM-BOUNDARY skipped — Lean mode." Proceed to priority assignment. / → 跳过（非阶段门控）。注意："TD-SYSTEM-BOUNDARY 已跳过——Lean 模式。" 继续优先级分配。
- `full` → spawn as normal. / → 正常启动。

**After dependency mapping is approved, spawn `technical-director` via Task using gate TD-SYSTEM-BOUNDARY (`.codebuddy/docs/director-gates.md`) before proceeding to priority assignment.**

> **中文翻译**：**依赖映射获批后，在进入优先级分配之前，通过 Task 使用门控 TD-SYSTEM-BOUNDARY 启动 `technical-director`。**

Pass: the dependency map summary, layer assignments, bottleneck systems list, any circular dependency resolutions.

> **中文翻译**：传递：依赖图摘要、层级分配、瓶颈系统列表、任何循环依赖解决方案。

Present the assessment. If REJECT, revise the system boundaries with the user before moving to priority assignment. If CONCERNS, note them inline in the systems index and continue.

> **中文翻译**：呈现评估。如果 REJECT，在进入优先级分配之前与用户修订系统边界。如果 CONCERNS，在系统索引中内联记录并继续。

---

## Phase 4: Priority Assignment (Collaborative) / 阶段 4：优先级分配（协作）

Assign each system to a priority tier based on what milestone it's needed for.

> **中文翻译**：根据系统在哪个里程碑需要，将每个系统分配到优先级层级。

### Step 4a: Auto-Assign Based on Concept / 步骤 4a：基于概念自动分配

Use these heuristics for initial assignment:

> **中文翻译**：使用这些启发式规则进行初始分配：

- **MVP**: Systems mentioned in the concept's "Required for MVP" section, plus their
  Foundation-layer dependencies / 概念"MPV 必需"部分提到的系统，加上它们的基础层依赖
- **Vertical Slice / 垂直切片**: Systems needed for a complete experience in one area / 在一个区域中实现完整体验所需的系统
- **Alpha**: All remaining gameplay systems / 所有剩余的游戏玩法系统
- **Full Vision / 完整愿景**: Polish, meta, and nice-to-have systems / 打磨、元系统和可选系统

### Step 4b: User Review / 步骤 4b：用户审查

Present the priority assignments in a table. For each tier, explain why systems
were placed there.

> **中文翻译**：以表格形式呈现优先级分配。对于每个层级，解释系统被放置在那里的原因。

Use `AskUserQuestion` to ask: "Do these priority assignments match your vision?
Which systems should be higher or lower priority?"

> **中文翻译**：使用 `AskUserQuestion` 询问："这些优先级分配符合您的愿景吗？哪些系统应该更高或更低优先级？"

Explain reasoning in conversation: "I placed [system] in MVP because the core loop
requires it — without [system], the 30-second loop can't function."

> **中文翻译**：在对话中解释原因："我将 [系统] 放在 MVP 中，因为核心循环需要它——没有 [系统]，30 秒循环无法运行。"

**"Why" column guidance / "原因"列指南**: When explaining why each system was placed in a priority tier, mix technical necessity with player-experience reasoning. Do not use purely technical justifications like "Combat needs damage math" — connect to player experience where relevant. Examples of good "Why" entries:

> **中文翻译**：当解释每个系统为何被放在某个优先级层级时，混合技术必要性和玩家体验推理。不要使用纯技术理由如"战斗需要伤害计算"——在相关处联系玩家体验。好的"原因"条目示例：

- "Required for the core loop — without it, placement decisions have no consequence (Pillar 2: Placement is the Puzzle)" / "核心循环所需——没有它，放置决策没有后果（支柱 2：放置即谜题）"
- "Ballista's punch-through identity is established here — this stat definition is what makes it feel different from Archer" / "弩炮的穿透特性在此建立——此属性定义是使其与弓箭手不同的原因"
- "Foundation for all economy decisions — players must understand upgrade costs to make meaningful placement choices" / "所有经济决策的基础——玩家必须了解升级成本才能做出有意义的放置选择"

Pure technical necessity ("X depends on Y") is insufficient alone when the system directly shapes player experience.

> **中文翻译**：当系统直接影响玩家体验时，纯技术必要性（"X 依赖于 Y"）本身是不够的。

**Review mode check** — apply before spawning PR-SCOPE:

> **中文翻译**：**审查模式检查** — 在启动 PR-SCOPE 之前应用：

- `solo` → skip. Note: "PR-SCOPE skipped — Solo mode." Proceed to writing the systems index. / → 跳过。注意："PR-SCOPE 已跳过——Solo 模式。" 继续写入系统索引。
- `lean` → skip (not a PHASE-GATE). Note: "PR-SCOPE skipped — Lean mode." Proceed to writing the systems index. / → 跳过（非阶段门控）。注意："PR-SCOPE 已跳过——Lean 模式。" 继续写入系统索引。
- `full` → spawn as normal. / → 正常启动。

**After priorities are approved, spawn `producer` via Task using gate PR-SCOPE (`.codebuddy/docs/director-gates.md`) before writing the index.**

> **中文翻译**：**优先级获批后，在写入索引之前，通过 Task 使用门控 PR-SCOPE 启动 `producer`。**

Pass: total system count per milestone tier, estimated implementation volume per tier (system count × average complexity), team size, stated project timeline.

> **中文翻译**：传递：每个里程碑层级的系统总数、每个层级的预估实现量（系统数 × 平均复杂度）、团队规模、声明的项目时间线。

Present the assessment. If UNREALISTIC, offer to revise priority tier assignments before writing the index. If CONCERNS, note them and continue.

> **中文翻译**：呈现评估。如果 UNREALISTIC，提供在写入索引前修订优先级层级分配。如果 CONCERNS，记录并继续。

### Step 4c: Determine Design Order / 步骤 4c：确定设计顺序

Combine dependency sort + priority tier to produce the final design order:

> **中文翻译**：结合依赖排序 + 优先级层级生成最终设计顺序：

1. MVP Foundation systems first / MVP 基础层系统优先
2. MVP Core systems second / MVP 核心层系统第二
3. MVP Feature systems third / MVP 功能层系统第三
4. Vertical Slice Foundation/Core systems / 垂直切片基础/核心层系统
5. ...and so on / ……以此类推

This is the order the team should write GDDs in.

> **中文翻译**：这是团队应该编写 GDD 的顺序。

---

## Phase 5: Create Systems Index (Write) / 阶段 5：创建系统索引（写入）

### Step 5a: Draft the Document / 步骤 5a：起草文档

Using the template at `.codebuddy/docs/templates/systems-index.md`, populate the
systems index with all data from Phases 2-4:

> **中文翻译**：使用 `.codebuddy/docs/templates/systems-index.md` 的模板，用阶段 2-4 的所有数据填充系统索引：

- Fill the enumeration table / 填充枚举表
- Fill the dependency map / 填充依赖图
- Fill the recommended design order / 填充推荐设计顺序
- Fill the high-risk systems / 填充高风险系统
- Fill progress tracker (all systems "Not Started" initially, unless GDDs already exist) / 填充进度追踪器（初始所有系统为"未开始"，除非 GDD 已存在）

### Step 5b: Approval / 步骤 5b：批准

Present a summary of the document:

> **中文翻译**：呈现文档摘要：

- Total systems count by category / 按类别的系统总数
- MVP system count / MVP 系统数
- First 3 systems in the design order / 设计顺序中的前 3 个系统
- Any high-risk items / 任何高风险项目

Ask: "May I write the systems index to `design/gdd/systems-index.md`?"

> **中文翻译**：询问："我可以将系统索引写入 `design/gdd/systems-index.md` 吗？"

Wait for approval. Write the file only after "yes."

> **中文翻译**：等待批准。仅在"是"后写入文件。

**Review mode check** — apply before spawning CD-SYSTEMS:

> **中文翻译**：**审查模式检查** — 在启动 CD-SYSTEMS 之前应用：

- `solo` → skip. Note: "CD-SYSTEMS skipped — Solo mode." Proceed to Phase 7 next steps. / → 跳过。注意："CD-SYSTEMS 已跳过——Solo 模式。" 继续阶段 7 的后续步骤。
- `lean` → skip (not a PHASE-GATE). Note: "CD-SYSTEMS skipped — Lean mode." Proceed to Phase 7 next steps. / → 跳过（非阶段门控）。注意："CD-SYSTEMS 已跳过——Lean 模式。" 继续阶段 7 的后续步骤。
- `full` → spawn as normal. / → 正常启动。

**After the systems index is written, spawn `creative-director` via Task using gate CD-SYSTEMS (`.codebuddy/docs/director-gates.md`).**

> **中文翻译**：**系统索引写入后，通过 Task 使用门控 CD-SYSTEMS 启动 `creative-director`。**

Pass: systems index path, game pillars and core fantasy (from `design/gdd/game-concept.md`), MVP priority tier system list.

> **中文翻译**：传递：系统索引路径、游戏支柱和核心幻想（来自 `design/gdd/game-concept.md`）、MVP 优先级层级系统列表。

Present the assessment. If REJECT, revise the system set with the user before GDD authoring begins. If CONCERNS, record them in the systems index as a `> **Creative Director Note**` at the top of the relevant tier section.

> **中文翻译**：呈现评估。如果 REJECT，在 GDD 编写开始前与用户修订系统集。如果 CONCERNS，在系统索引中相关层级部分的顶部记录为 `> **Creative Director Note**`。

### Step 5c: Update Session State / 步骤 5c：更新会话状态

After writing, create `production/session-state/active.md` if it does not exist, then update it with:
- Task: Systems decomposition / 任务：系统分解
- Status: Systems index created / 状态：系统索引已创建
- File: design/gdd/systems-index.md / 文件：design/gdd/systems-index.md
- Next: Design individual system GDDs / 下一步：设计单个系统 GDD

**Verdict: COMPLETE** — systems index written to `design/gdd/systems-index.md`.
If the user declined: **Verdict: BLOCKED** — user did not approve the write.

> **中文翻译**：**裁决：COMPLETE** — 系统索引已写入 `design/gdd/systems-index.md`。如果用户拒绝：**裁决：BLOCKED** — 用户未批准写入。

---

## Phase 6: Design Individual Systems (Handoff to /design-system) / 阶段 6：设计单个系统（移交给 /design-system）

This phase is entered when:
- The user says "yes" to designing systems after creating the index / 用户在创建索引后说"是"要设计系统
- The user invokes `/map-systems [system-name]` / 用户调用 `/map-systems [system-name]`
- The user invokes `/map-systems next` / 用户调用 `/map-systems next`

> **中文翻译**：此阶段在以下情况进入：

### Step 6a: Select the System / 步骤 6a：选择系统

- If a system name was provided, find it in the systems index / 如果提供了系统名称，在系统索引中查找
- If `next` was used, pick the highest-priority undesigned system (by design order) / 如果使用了 `next`，选择优先级最高的未设计系统（按设计顺序）
- If the user just finished the index, ask: / 如果用户刚完成索引，询问：
  "Would you like to start designing individual systems now? The first system in
  the design order is [name]. Or would you prefer to stop here and come back later?"
  / "您想现在开始设计单个系统吗？设计顺序中的第一个系统是 [名称]。还是您想在这里停下来稍后再来？"

Use `AskUserQuestion` for: "Start designing [system-name] now, pick a different
system, or stop here?"

> **中文翻译**：使用 `AskUserQuestion` 询问："现在开始设计 [系统名称]，选择不同的系统，还是在这里停下？"

### Step 6b: Hand Off to /design-system / 步骤 6b：移交给 /design-system

Once a system is selected, invoke the `/design-system [system-name]` skill.

> **中文翻译**：系统选定后，调用 `/design-system [system-name]` 技能。

The `/design-system` skill handles the full GDD authoring process:
- Gathers context from game concept, systems index, and dependency GDDs / 从游戏概念、系统索引和依赖 GDD 收集上下文
- Creates a file skeleton immediately / 立即创建文件骨架
- Walks through all 8 required sections one at a time (collaborative, incremental) / 一次遍历所有 8 个必需章节（协作、增量）
- Cross-references existing docs to prevent contradictions / 交叉引用现有文档以防止矛盾
- Routes to specialist agents for domain expertise / 路由到专业代理获取领域专长
- Writes each section to file as soon as it's approved / 每个章节批准后立即写入文件
- Runs `/design-review` when complete / 完成时运行 `/design-review`
- Updates the systems index / 更新系统索引

**Do not duplicate the /design-system workflow here.** This skill owns the systems
*index*; `/design-system` owns individual system *GDDs*.

> **中文翻译**：**不要在这里重复 /design-system 工作流。** 此技能拥有系统*索引*；`/design-system` 拥有单个系统 *GDD*。

### Step 6c: Loop or Stop / 步骤 6c：循环或停止

After `/design-system` completes, use `AskUserQuestion`:
- "Continue to the next system ([next system name])?" / "继续下一个系统（[下一个系统名称]）？"
- "Pick a different system?" / "选择不同的系统？"
- "Stop here for this session?" / "本次会话在这里停下？"

If continuing, return to Step 6a.

> **中文翻译**：如果继续，返回步骤 6a。

---

## Phase 7: Suggest Next Steps / 阶段 7：建议后续步骤

After the systems index is created (or after designing some systems), present next actions using `AskUserQuestion`:

> **中文翻译**：系统索引创建后（或设计了一些系统后），使用 `AskUserQuestion` 呈现下一步行动：

- "Systems index is written. What would you like to do next?" / "系统索引已写入。您接下来想做什么？"
  - [A] Start designing GDDs — run `/design-system [first-system-in-order]` / 开始设计 GDD——运行 `/design-system [设计顺序中的第一个系统]`
  - [B] Ask a director to review the index first — ask `creative-director` or `technical-director` to validate the system set before committing to 10+ GDD sessions / 先让总监审查索引——请 `creative-director` 或 `technical-director` 在投入 10+ 个 GDD 会话之前验证系统集
  - [C] Stop here for this session / 本次会话在这里停下

**The director review option ([B]) is worth highlighting**: having a Creative Director or Technical Director review the completed systems index before starting GDD authoring catches scope issues, missing systems, and boundary problems before they're locked in across many documents. It is optional but recommended for new projects.

> **中文翻译**：**总监审查选项（[B]）值得强调**：在开始 GDD 编写之前让创意总监或技术总监审查已完成的系统索引，可以在许多文档锁定之前捕获范围问题、遗漏系统和边界问题。这是可选的，但对新项目推荐。

After any individual GDD is completed:

> **中文翻译**：任何单个 GDD 完成后：

- "Run `/design-review design/gdd/[system].md` in a fresh session to validate quality" / "在新会话中运行 `/design-review design/gdd/[system].md` 以验证质量"
- "Run `/gate-check systems-design` when all MVP GDDs are complete" / "所有 MVP GDD 完成后运行 `/gate-check systems-design`"

---

## Collaborative Protocol / 协作协议

This skill follows the collaborative design principle at every phase:

> **中文翻译**：此技能在每个阶段都遵循协作设计原则：

1. **Question -> Options -> Decision -> Draft -> Approval** at every step / 每一步都是 **提问 -> 选项 -> 决策 -> 草案 -> 批准**
2. **AskUserQuestion** at every decision point (Explain -> Capture pattern): / 每个决策点使用 **AskUserQuestion**（解释 -> 捕获模式）：
   - Phase 2: "Missing systems? Combine or split?" / 阶段 2："遗漏系统？合并或拆分？"
   - Phase 3: "Dependency ordering correct?" / 阶段 3："依赖顺序正确？"
   - Phase 4: "Priority assignments match your vision?" / 阶段 4："优先级分配符合您的愿景？"
   - Phase 5: "May I write the systems index?" / 阶段 5："我可以写入系统索引吗？"
   - Phase 6: "Start designing, pick different, or stop?" then hand off to `/design-system` / 阶段 6："开始设计、选择不同、还是停下？"然后移交给 `/design-system`
3. **"May I write to [filepath]?"** before every file write / 每次文件写入前 **"我可以写入到 [文件路径] 吗？"**
4. **Incremental writing**: Update the systems index after each system is designed / **增量写入**：每个系统设计后更新系统索引
5. **Handoff**: Individual GDD authoring is owned by `/design-system`, which handles
   incremental section writing, cross-referencing, design review, and index updates / **移交**：单个 GDD 编写由 `/design-system` 负责，它处理增量章节写入、交叉引用、设计审查和索引更新
6. **Session state updates**: Write to `production/session-state/active.md` after
   each milestone (index created, system designed, priorities changed) / **会话状态更新**：每个里程碑后写入 `production/session-state/active.md`（索引创建、系统设计、优先级更改）

**Never** auto-generate the full systems list and write it without review.
**Never** start designing a system without user confirmation.
**Always** show the enumeration, dependencies, and priorities for user validation.

> **中文翻译**：**切勿**在未经审查的情况下自动生成完整系统列表并写入。**切勿**在未经用户确认的情况下开始设计系统。**始终**展示枚举、依赖和优先级供用户验证。

## Context Window Awareness / 上下文窗口感知

If context reaches or exceeds 70% at any point, append this notice:

> **中文翻译**：如果上下文在任何时候达到或超过 70%，附加此通知：

> **Context is approaching the limit (≥70%).** The systems index is saved to
> `design/gdd/systems-index.md`. Open a fresh CodeBuddy session to continue
> designing individual GDDs — run `/map-systems next` to pick up where you left off.
>
> **中文翻译**：**上下文即将达到限制（≥70%）。** 系统索引已保存到 `design/gdd/systems-index.md`。打开新的 CodeBuddy 会话继续设计单个 GDD——运行 `/map-systems next` 从上次停止处继续。

---

## Recommended Next Steps / 推荐后续步骤

- Run `/design-system [first-system-in-order]` to author the first GDD (use design order from the index) / 运行 `/design-system [设计顺序中的第一个系统]` 编写第一个 GDD
- Run `/map-systems next` to always pick the highest-priority undesigned system automatically / 运行 `/map-systems next` 自动选择优先级最高的未设计系统
- Run `/design-review design/gdd/[system].md` in a fresh session after each GDD is authored / 每个 GDD 编写后在新的会话中运行 `/design-review design/gdd/[system].md`
- Run `/gate-check pre-production` when all MVP GDDs are authored and reviewed / 所有 MVP GDD 编写和审查完成后运行 `/gate-check pre-production`
