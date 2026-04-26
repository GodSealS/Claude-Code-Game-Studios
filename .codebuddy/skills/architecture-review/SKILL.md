---
name: architecture-review
description: "Validates completeness and consistency of the project architecture against all GDDs. Builds a traceability matrix mapping every GDD technical requirement to ADRs, identifies coverage gaps, detects cross-ADR conflicts, verifies engine compatibility consistency across all decisions, and produces a PASS/CONCERNS/FAIL verdict. The architecture equivalent of /design-review. / 验证项目架构相对于所有 GDD 的完整性和一致性。构建可追溯性矩阵将每个 GDD 技术需求映射到 ADR，识别覆盖差距，检测跨 ADR 冲突，验证所有决策间的引擎兼容性一致性，并生成 PASS/CONCERNS/FAIL 裁决。架构层面的 /design-review 等价物。"
argument-hint: "[focus: full | coverage | consistency | engine | single-gdd path/to/gdd.md]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Task, AskUserQuestion
agent: technical-director
model: opus
---

# Architecture Review / 架构审查

The architecture review validates that the complete body of architectural decisions
covers all game design requirements, is internally consistent, and correctly targets
the project's pinned engine version. It is the quality gate between Technical Setup
and Pre-Production. / 架构审查验证完整的架构决策是否覆盖所有游戏设计需求、内部一致且正确针对项目固定的引擎版本。它是技术设置和预生产之间的质量门控。
> **中文翻译**：架构审查验证完整的架构决策是否覆盖所有游戏设计需求、内部一致且正确针对项目固定的引擎版本。它是技术设置和预生产之间的质量门控。

**Argument modes:** / **参数模式：**
> **中文翻译**：**参数模式：**

- **No argument / `full`**: Full review — all phases / **无参数 / `full`**：完整审查 — 所有阶段
- **`coverage`**: Traceability only — which GDD requirements have no ADR / **`coverage`**：仅可追溯性 — 哪些 GDD 需求没有 ADR
- **`consistency`**: Cross-ADR conflict detection only / **`consistency`**：仅跨 ADR 冲突检测
- **`engine`**: Engine compatibility audit only / **`engine`**：仅引擎兼容性审计
- **`single-gdd [path]`**: Review architecture coverage for one specific GDD / **`single-gdd [path]`**：审查一个特定 GDD 的架构覆盖
- **`rtm`**: Requirements Traceability Matrix — extends the standard matrix
  to include story file paths and test file paths; outputs
  `docs/architecture/requirements-traceability.md` with the full
  GDD requirement → ADR → Story → Test chain. Use in Production phase when
  stories and tests exist. / **`rtm`**：需求可追溯性矩阵 — 扩展标准矩阵以包含故事文件路径和测试文件路径；输出 `docs/architecture/requirements-traceability.md`，包含完整的 GDD 需求 → ADR → 故事 → 测试链。在生产阶段当故事和测试存在时使用。

---

## Phase 1: Load Everything / 第 1 阶段：加载所有内容

### Phase 1a — L0: Summary Scan (fast, low tokens) / 第 1a 阶段 — L0：摘要扫描（快速，低 token）

Before reading any full document, use Grep to extract `## Summary` sections
from all GDDs and ADRs: / 在读取任何完整文档之前，使用 Grep 从所有 GDD 和 ADR 中提取 `## Summary` 章节：
> **中文翻译**：在读取任何完整文档之前，使用 Grep 从所有 GDD 和 ADR 中提取 `## Summary` 章节：

```
Grep pattern="## Summary" glob="design/gdd/*.md" output_mode="content" -A 4
Grep pattern="## Summary" glob="docs/architecture/adr-*.md" output_mode="content" -A 3
```

For `single-gdd [path]` mode: use the target GDD's summary to identify which
ADRs reference the same system (Grep ADRs for the system name), then full-read
only those ADRs. Skip full-reading unrelated GDDs entirely. / 对于 `single-gdd [path]` 模式：使用目标 GDD 的摘要识别哪些 ADR 引用了同一系统（Grep ADR 中的系统名称），然后仅完整读取那些 ADR。完全跳过不相关的 GDD。
> **中文翻译**：对于 `single-gdd [path]` 模式：使用目标 GDD 的摘要识别哪些 ADR 引用了同一系统（Grep ADR 中的系统名称），然后仅完整读取那些 ADR。完全跳过不相关的 GDD。

For `engine` mode: only full-read ADRs — GDDs are not needed for engine checks. / 对于 `engine` 模式：仅完整读取 ADR — GDD 不需要用于引擎检查。
> **中文翻译**：对于 `engine` 模式：仅完整读取 ADR — GDD 不需要用于引擎检查。

For `coverage` or `full` mode: proceed to full-read everything below. / 对于 `coverage` 或 `full` 模式：继续完整读取以下所有内容。
> **中文翻译**：对于 `coverage` 或 `full` 模式：继续完整读取以下所有内容。

### Phase 1b — L1/L2: Full Document Load / 第 1b 阶段 — L1/L2：完整文档加载

Read all inputs appropriate to the mode: / 读取适合该模式的所有输入：
> **中文翻译**：读取适合该模式的所有输入：

### Design Documents / 设计文档
- All in-scope GDDs in `design/gdd/` — read every file completely / `design/gdd/` 中所有范围内的 GDD — 完整读取每个文件
- `design/gdd/systems-index.md` — the authoritative list of systems / 系统的权威列表

### Architecture Documents / 架构文档
- All in-scope ADRs in `docs/architecture/` — read every file completely / `docs/architecture/` 中所有范围内的 ADR — 完整读取每个文件
- `docs/architecture/architecture.md` if it exists / 如果存在

### Engine Reference / 引擎参考
- `docs/engine-reference/[engine]/VERSION.md`
- `docs/engine-reference/[engine]/breaking-changes.md`
- `docs/engine-reference/[engine]/deprecated-apis.md`
- All files in `docs/engine-reference/[engine]/modules/` / `docs/engine-reference/[engine]/modules/` 中的所有文件

### Project Standards / 项目标准
- `.codebuddy/docs/technical-preferences.md`

Report a count: "Loaded [N] GDDs, [M] ADRs, engine: [name + version]." / 报告计数："已加载 [N] 个 GDD，[M] 个 ADR，引擎：[名称 + 版本]。"
> **中文翻译**：报告计数："已加载 [N] 个 GDD，[M] 个 ADR，引擎：[名称 + 版本]。"

**Also read `docs/consistency-failures.md`** if it exists. Extract entries with
Domain matching the systems under review (Architecture, Engine, or any GDD domain
being covered). Surface recurring patterns as a "Known conflict-prone areas" note
at the top of the Phase 4 conflict detection output. / **还要读取 `docs/consistency-failures.md`**（如果存在）。提取领域与审查中的系统匹配的条目（Architecture、Engine 或任何被覆盖的 GDD 领域）。将重复出现的模式作为"已知冲突易发区域"注释呈现在第 4 阶段冲突检测输出的顶部。
> **中文翻译**：**还要读取 `docs/consistency-failures.md`**（如果存在）。提取领域与审查中的系统匹配的条目（Architecture、Engine 或任何被覆盖的 GDD 领域）。将重复出现的模式作为"已知冲突易发区域"注释呈现在第 4 阶段冲突检测输出的顶部。

---

## Phase 2: Extract Technical Requirements from Every GDD / 第 2 阶段：从每个 GDD 提取技术需求

### Pre-load the TR Registry / 预加载 TR 注册表

Before extracting any requirements, read `docs/architecture/tr-registry.yaml`
if it exists. Index existing entries by `id` and by normalized `requirement`
text (lowercase, trimmed). This prevents ID renumbering across review runs. / 在提取任何需求之前，读取 `docs/architecture/tr-registry.yaml`（如果存在）。按 `id` 和规范化的 `requirement` 文本（小写、去除空格）索引现有条目。这防止审查运行之间的 ID 重新编号。
> **中文翻译**：在提取任何需求之前，读取 `docs/architecture/tr-registry.yaml`（如果存在）。按 `id` 和规范化的 `requirement` 文本（小写、去除空格）索引现有条目。这防止审查运行之间的 ID 重新编号。

For each requirement you extract, the matching rule is: / 对于你提取的每个需求，匹配规则是：
> **中文翻译**：对于你提取的每个需求，匹配规则是：

1. **Exact/near match** to an existing registry entry for the same system →
   reuse that entry's TR-ID unchanged. Update the `requirement` text in the
   registry only if the GDD wording changed (same intent, clearer phrasing) —
   add a `revised: [date]` field. / **精确/近似匹配**同一系统的现有注册表条目 → 不变地复用该条目的 TR-ID。仅在 GDD 措辞改变时更新注册表中的 `requirement` 文本（相同意图，更清晰的措辞）— 添加 `revised: [date]` 字段。
2. **No match** → assign a new ID: next available `TR-[system]-NNN` for that
   system, starting from the highest existing sequence + 1. / **无匹配** → 分配新 ID：该系统的下一个可用 `TR-[system]-NNN`，从最高现有序号 + 1 开始。
3. **Ambiguous** (partial match, intent unclear) → ask the user: / **模糊**（部分匹配，意图不明确）→ 询问用户：
   > "Does '[new requirement text]' refer to the same requirement as
   > `TR-[system]-NNN: [existing text]'`, or is it a new requirement?" / > "'[新需求文本]' 是否与 `TR-[system]-NNN: [现有文本]'` 引用同一需求，还是一个新需求？"
   User answers: "Same requirement" (reuse ID) or "New requirement" (new ID). / 用户回答："同一需求"（复用 ID）或"新需求"（新 ID）。

For any requirement with `status: deprecated` in the registry — skip it.
It was removed from the GDD intentionally. / 对于注册表中 `status: deprecated` 的任何需求 — 跳过。它是有意从 GDD 中移除的。
> **中文翻译**：对于注册表中 `status: deprecated` 的任何需求 — 跳过。它是有意从 GDD 中移除的。

For each GDD, read it and extract all **technical requirements** — things the
architecture must provide for the system to work. A technical requirement is any
statement that implies a specific architectural decision. / 对于每个 GDD，读取它并提取所有**技术需求** — 架构必须为系统工作提供的东西。技术需求是任何暗示特定架构决策的陈述。
> **中文翻译**：对于每个 GDD，读取它并提取所有**技术需求** — 架构必须为系统工作提供的东西。技术需求是任何暗示特定架构决策的陈述。

Categories to extract: / 要提取的类别：
> **中文翻译**：要提取的类别：

| Category / 类别 | Example / 示例 |
|----------|---------|
| **Data structures** / **数据结构** | "Each entity has health, max health, status effects" → needs a component/data schema / "每个实体有生命值、最大生命值、状态效果" → 需要组件/数据架构 |
| **Performance constraints** / **性能约束** | "Collision detection must run at 60fps with 200 entities" → physics budget ADR / "碰撞检测必须在 200 个实体下以 60fps 运行" → 物理预算 ADR |
| **Engine capability** / **引擎能力** | "Inverse kinematics for character animation" → IK system ADR / "角色动画的逆运动学" → IK 系统 ADR |
| **Cross-system communication** / **跨系统通信** | "Damage system notifies UI and audio simultaneously" → event/signal architecture ADR / "伤害系统同时通知 UI 和音频" → 事件/信号架构 ADR |
| **State persistence** / **状态持久化** | "Player progress persists between sessions" → save system ADR / "玩家进度在会话间持久化" → 存档系统 ADR |
| **Threading/timing** / **线程/时序** | "AI decisions happen off the main thread" → concurrency ADR / "AI 决策在主线程之外进行" → 并发 ADR |
| **Platform requirements** / **平台需求** | "Supports keyboard, gamepad, touch" → input system ADR / "支持键盘、手柄、触摸" → 输入系统 ADR |

For each GDD, produce a structured list: / 对于每个 GDD，生成一个结构化列表：
> **中文翻译**：对于每个 GDD，生成一个结构化列表：

```
GDD: [filename]
System: [system name]
Technical Requirements:
  TR-[GDD]-001: [requirement text] → Domain: [Physics/Rendering/etc]
  TR-[GDD]-002: [requirement text] → Domain: [...]
```

This becomes the **requirements baseline** — the complete set of what the
architecture must cover. / 这成为**需求基线** — 架构必须覆盖的完整集合。
> **中文翻译**：这成为**需求基线** — 架构必须覆盖的完整集合。

---

## Phase 3: Build the Traceability Matrix / 第 3 阶段：构建可追溯性矩阵

For each technical requirement extracted in Phase 2, search the ADRs: / 对于第 2 阶段提取的每个技术需求，搜索 ADR：
> **中文翻译**：对于第 2 阶段提取的每个技术需求，搜索 ADR：

1. Read every ADR's "GDD Requirements Addressed" section / 读取每个 ADR 的 "GDD Requirements Addressed" 章节
2. Check if it explicitly references the requirement or its GDD / 检查是否明确引用了该需求或其 GDD
3. Check if the ADR's decision text implicitly covers the requirement / 检查 ADR 的决策文本是否隐含覆盖了该需求
4. Mark coverage status: / 标记覆盖状态：

| Status / 状态 | Meaning / 含义 |
|--------|---------|
| ✅ **Covered** | An ADR explicitly addresses this requirement / ADR 明确解决了此需求 |
| ⚠️ **Partial** | An ADR partially covers this, or coverage is ambiguous / ADR 部分覆盖，或覆盖模糊 |
| ❌ **Gap** | No ADR addresses this requirement / 无 ADR 解决此需求 |

Build the full matrix: / 构建完整矩阵：
> **中文翻译**：构建完整矩阵：

```
## Traceability Matrix

| Requirement ID | GDD | System | Requirement | ADR Coverage | Status |
|---------------|-----|--------|-------------|--------------|--------|
| TR-combat-001 | combat.md | Combat | Hitbox detection < 1 frame | ADR-0003 | ✅ |
| TR-combat-002 | combat.md | Combat | Combo window timing | — | ❌ GAP |
| TR-inventory-001 | inventory.md | Inventory | Persistent item storage | ADR-0005 | ✅ |
```

Count the totals: X covered, Y partial, Z gaps. / 计算总数：X 已覆盖，Y 部分覆盖，Z 差距。
> **中文翻译**：计算总数：X 已覆盖，Y 部分覆盖，Z 差距。

---

## Phase 3b: Story and Test Linkage (RTM mode only) / 第 3b 阶段：故事和测试关联（仅 RTM 模式）

*Skip this phase unless the argument is `rtm` or `full` with stories present.* / *除非参数为 `rtm` 或 `full` 且存在故事，否则跳过此阶段。*
> **中文翻译**：*除非参数为 `rtm` 或 `full` 且存在故事，否则跳过此阶段。*

This phase extends the Phase 3 matrix to include the story that implements
each requirement and the test that verifies it — producing the full
Requirements Traceability Matrix (RTM). / 此阶段扩展第 3 阶段矩阵以包含实现每个需求的故事和验证它的测试 — 生成完整的需求可追溯性矩阵（RTM）。
> **中文翻译**：此阶段扩展第 3 阶段矩阵以包含实现每个需求的故事和验证它的测试 — 生成完整的需求可追溯性矩阵（RTM）。

### Step 3b-1 — Load stories / 步骤 3b-1 — 加载故事

Glob `production/epics/**/*.md` (excluding EPIC.md index files). For each
story file: / Glob `production/epics/**/*.md`（排除 EPIC.md 索引文件）。对于每个故事文件：
> **中文翻译**：Glob `production/epics/**/*.md`（排除 EPIC.md 索引文件）。对于每个故事文件：

- Extract `TR-ID` from the story's Context section / 从故事的上下文章节提取 `TR-ID`
- Extract story file path, title, Status / 提取故事文件路径、标题、状态
- Extract `## Test Evidence` section — the stated test file path / 提取 `## Test Evidence` 章节 — 声明的测试文件路径

### Step 3b-2 — Load test files / 步骤 3b-2 — 加载测试文件

Glob `tests/unit/**/*_test.*` and `tests/integration/**/*_test.*`.
Build an index: system → [test file paths]. / Glob `tests/unit/**/*_test.*` 和 `tests/integration/**/*_test.*`。构建索引：系统 → [测试文件路径]。
> **中文翻译**：Glob `tests/unit/**/*_test.*` 和 `tests/integration/**/*_test.*`。构建索引：系统 → [测试文件路径]。

For each test file path from Step 3b-1, confirm via Glob whether the file
actually exists. Note MISSING if the stated path does not exist. / 对于步骤 3b-1 中的每个测试文件路径，通过 Glob 确认文件是否实际存在。如果声明的路径不存在则标记 MISSING。
> **中文翻译**：对于步骤 3b-1 中的每个测试文件路径，通过 Glob 确认文件是否实际存在。如果声明的路径不存在则标记 MISSING。

### Step 3b-3 — Build the extended RTM / 步骤 3b-3 — 构建扩展 RTM

For each TR-ID in the Phase 3 matrix, add: / 对于第 3 阶段矩阵中的每个 TR-ID，添加：
> **中文翻译**：对于第 3 阶段矩阵中的每个 TR-ID，添加：

- **Story**: the story file path(s) that reference this TR-ID (may be multiple) / **故事**：引用此 TR-ID 的故事文件路径（可能多个）
- **Test File**: the test file path stated in the story's Test Evidence section / **测试文件**：故事的 Test Evidence 章节中声明的测试文件路径
- **Test Status**: COVERED (test file exists) / MISSING (path stated but not
  found) / NONE (no test path stated, story type may be Visual/Feel/UI) /
  NO STORY (requirement has no story yet — pre-production gap) / **测试状态**：COVERED（测试文件存在）/ MISSING（路径已声明但未找到）/ NONE（无测试路径，故事类型可能是 Visual/Feel/UI）/ NO STORY（需求尚无故事 — 预生产差距）

Extended matrix format: / 扩展矩阵格式：
> **中文翻译**：扩展矩阵格式：

```
## Requirements Traceability Matrix (RTM)

| TR-ID | GDD | Requirement | ADR | Story | Test File | Test Status |
|-------|-----|-------------|-----|-------|-----------|-------------|
| TR-combat-001 | combat.md | Hitbox < 1 frame | ADR-0003 | story-001-hitbox.md | tests/unit/combat/hitbox_test.gd | COVERED |
| TR-combat-002 | combat.md | Combo window | — | story-002-combo.md | — | NONE (Visual/Feel) |
| TR-inventory-001 | inventory.md | Persistent storage | ADR-0005 | — | — | NO STORY |
```

RTM coverage summary: / RTM 覆盖摘要：
> **中文翻译**：RTM 覆盖摘要：

- COVERED: [N] — requirements with ADR + story + passing test / 有 ADR + 故事 + 通过测试的需求
- MISSING test: [N] — story exists but test file not found / 故事存在但测试文件未找到
- NO STORY: [N] — requirements with ADR but no story yet / 有 ADR 但尚无故事的需求
- NO ADR: [N] — requirements without architectural coverage (from Phase 3 gaps) / 无架构覆盖的需求（来自第 3 阶段差距）
- Full chain complete (COVERED): [N/total] ([%])

---

## Phase 4: Cross-ADR Conflict Detection / 第 4 阶段：跨 ADR 冲突检测

Compare every ADR against every other ADR to detect contradictions. A conflict
exists when: / 将每个 ADR 与其他每个 ADR 比较以检测矛盾。当以下情况时存在冲突：
> **中文翻译**：将每个 ADR 与其他每个 ADR 比较以检测矛盾。当以下情况时存在冲突：

- **Data ownership conflict**: Two ADRs claim exclusive ownership of the same data / **数据所有权冲突**：两个 ADR 声称独占拥有相同数据
- **Integration contract conflict**: ADR-A assumes System X has interface Y, but
  ADR-B defines System X with a different interface / **集成契约冲突**：ADR-A 假设系统 X 有接口 Y，但 ADR-B 用不同接口定义系统 X
- **Performance budget conflict**: ADR-A allocates N ms to physics, ADR-B allocates
  N ms to AI, together they exceed the total frame budget / **性能预算冲突**：ADR-A 分配 N ms 给物理，ADR-B 分配 N ms 给 AI，合计超过总帧预算
- **Dependency cycle**: ADR-A says System X initialises before Y; ADR-B says Y
  initialises before X / **依赖循环**：ADR-A 说系统 X 在 Y 之前初始化；ADR-B 说 Y 在 X 之前初始化
- **Architecture pattern conflict**: ADR-A uses event-driven communication for a
  subsystem; ADR-B uses direct function calls to the same subsystem / **架构模式冲突**：ADR-A 对子系统使用事件驱动通信；ADR-B 对同一子系统使用直接函数调用
- **State management conflict**: Two ADRs define authority over the same game state
  (e.g. both Combat ADR and Character ADR claim to own the health value) / **状态管理冲突**：两个 ADR 定义对同一游戏状态的权限（例如战斗 ADR 和角色 ADR 都声称拥有生命值）

For each conflict found: / 对于发现的每个冲突：
> **中文翻译**：对于发现的每个冲突：

```
## Conflict: [ADR-NNNN] vs [ADR-MMMM]
Type: [Data ownership / Integration / Performance / Dependency / Pattern / State]
ADR-NNNN claims: [...]
ADR-MMMM claims: [...]
Impact: [What breaks if both are implemented as written]
Resolution options:
  1. [Option A]
  2. [Option B]
```

### ADR Dependency Ordering / ADR 依赖排序

After conflict detection, analyse the dependency graph across all ADRs: / 冲突检测后，分析所有 ADR 的依赖图：
> **中文翻译**：冲突检测后，分析所有 ADR 的依赖图：

1. **Collect all `Depends On` fields** from every ADR's "ADR Dependencies" section / 从每个 ADR 的 "ADR Dependencies" 章节**收集所有 `Depends On` 字段**
2. **Topological sort**: Determine the correct implementation order — ADRs with no
   dependencies come first (Foundation), ADRs that depend on those come next, etc. / **拓扑排序**：确定正确的实现顺序 — 无依赖的 ADR 优先（基础层），依赖它们的 ADR 其次，以此类推
3. **Flag unresolved dependencies**: If ADR-A's "Depends On" field references an ADR
   that is still `Proposed` or does not exist, flag it: / **标记未解决的依赖**：如果 ADR-A 的 "Depends On" 字段引用的 ADR 仍为 `Proposed` 或不存在，标记它：
   ```
   ⚠️  ADR-0005 depends on ADR-0002 — but ADR-0002 is still Proposed.
       ADR-0005 cannot be safely implemented until ADR-0002 is Accepted.
   ```
4. **Cycle detection**: If ADR-A depends on ADR-B and ADR-B depends on ADR-A (directly
   or transitively), flag it as a `DEPENDENCY CYCLE`: / **循环检测**：如果 ADR-A 依赖 ADR-B 且 ADR-B 依赖 ADR-A（直接或传递），标记为 `DEPENDENCY CYCLE`：
   ```
   🔴 DEPENDENCY CYCLE: ADR-0003 → ADR-0006 → ADR-0003
      This cycle must be broken before either can be implemented.
   ```
5. **Output recommended implementation order**: / **输出推荐实现顺序**：
   ```
   ### Recommended ADR Implementation Order (topologically sorted)
   Foundation (no dependencies):
     1. ADR-0001: [title]
     2. ADR-0003: [title]
   Depends on Foundation:
     3. ADR-0002: [title] (requires ADR-0001)
     4. ADR-0005: [title] (requires ADR-0003)
   Feature layer:
     5. ADR-0004: [title] (requires ADR-0002, ADR-0005)
   ```

---

## Phase 5: Engine Compatibility Cross-Check / 第 5 阶段：引擎兼容性交叉检查

Across all ADRs, check for engine consistency: / 在所有 ADR 中，检查引擎一致性：
> **中文翻译**：在所有 ADR 中，检查引擎一致性：

### Version Consistency / 版本一致性
- Do all ADRs that mention an engine version agree on the same version? / 所有提及引擎版本的 ADR 是否使用相同版本？
- If any ADR was written for an older engine version, flag it as potentially stale / 如果任何 ADR 是为较旧引擎版本编写的，标记为可能过时

### Post-Cutoff API Consistency / 截断后 API 一致性
- Collect all "Post-Cutoff APIs Used" fields from all ADRs / 收集所有 ADR 的 "Post-Cutoff APIs Used" 字段
- For each, verify against the relevant module reference doc / 对于每个字段，与相关模块参考文档验证
- Check that no two ADRs make contradictory assumptions about the same post-cutoff API / 检查没有两个 ADR 对同一截断后 API 做出矛盾假设

### Deprecated API Check / 已弃用 API 检查
- Grep all ADRs for API names listed in `deprecated-apis.md` / Grep 所有 ADR 查找 `deprecated-apis.md` 中列出的 API 名称
- Flag any ADR referencing a deprecated API / 标记任何引用已弃用 API 的 ADR

### Missing Engine Compatibility Sections / 缺失引擎兼容性章节
- List all ADRs that are missing the Engine Compatibility section entirely / 列出所有完全缺少 Engine Compatibility 章节的 ADR
- These are blind spots — their engine assumptions are unknown / 这些是盲点 — 其引擎假设未知

Output format: / 输出格式：
> **中文翻译**：输出格式：

```
### Engine Audit Results
Engine: [name + version]
ADRs with Engine Compatibility section: X / Y total

Deprecated API References:
  - ADR-0002: uses [deprecated API] — deprecated since [version]

Stale Version References:
  - ADR-0001: written for [older version] — current project version is [version]

Post-Cutoff API Conflicts:
  - ADR-0004 and ADR-0007 both use [API] with incompatible assumptions
```

---

### Engine Specialist Consultation / 引擎专家咨询

After completing the engine audit above, spawn the **primary engine specialist** via Task for a domain-expert second opinion: / 完成上述引擎审计后，通过 Task 生成**主引擎专家**以获取领域专家的第二意见：
> **中文翻译**：完成上述引擎审计后，通过 Task 生成**主引擎专家**以获取领域专家的第二意见：

- Read `.codebuddy/docs/technical-preferences.md` `Engine Specialists` section to get the primary specialist / 读取 `.codebuddy/docs/technical-preferences.md` 的 `Engine Specialists` 章节获取主专家
- If no engine is configured, skip this consultation / 如果未配置引擎，跳过此咨询
- Spawn `subagent_type: [primary specialist]` with: all ADRs that contain engine-specific decisions or `Post-Cutoff APIs Used` fields, the engine reference docs, and the Phase 5 audit findings. Ask them to: / 生成 `subagent_type: [主专家]`，包含：所有包含引擎特定决策或 `Post-Cutoff APIs Used` 字段的 ADR、引擎参考文档和第 5 阶段审计发现。要求他们：
  1. Confirm or challenge each audit finding — specialists may know of engine nuances not captured in the reference docs / 确认或质疑每个审计发现 — 专家可能知道参考文档中未捕获的引擎细节
  2. Identify engine-specific anti-patterns in the ADRs that the audit may have missed (e.g., using the wrong Godot node type, Unity component coupling, Unreal subsystem misuse) / 识别审计可能遗漏的 ADR 中引擎特定的反模式
  3. Flag ADRs that make assumptions about engine behaviour that differ from the actual pinned version / 标记对引擎行为做出与实际固定版本不同假设的 ADR

Incorporate additional findings under `### Engine Specialist Findings` in the Phase 5 output. These feed into the final verdict — specialist-identified issues carry the same weight as audit-identified issues. / 将额外发现纳入第 5 阶段输出的 `### Engine Specialist Findings`。这些将影响最终裁决 — 专家识别的问题与审计识别的问题具有相同权重。
> **中文翻译**：将额外发现纳入第 5 阶段输出的 `### Engine Specialist Findings`。这些将影响最终裁决 — 专家识别的问题与审计识别的问题具有相同权重。

---

## Phase 5b: Design Revision Flags (Architecture → GDD Feedback) / 第 5b 阶段：设计修订标记（架构 → GDD 反馈）

For each **HIGH RISK engine finding** from Phase 5, check whether any GDD makes an
assumption that the verified engine reality contradicts. / 对于第 5 阶段的每个**高风险引擎发现**，检查是否有 GDD 做出了与验证的引擎现实矛盾的假设。
> **中文翻译**：对于第 5 阶段的每个**高风险引擎发现**，检查是否有 GDD 做出了与验证的引擎现实矛盾的假设。

Specific cases to check: / 要检查的具体情况：
> **中文翻译**：要检查的具体情况：

1. **Post-cutoff API behaviour differs from training-data assumptions**: If an ADR
   records a verified API behaviour that differs from the default LLM assumption,
   check all GDDs that reference the related system. Look for design rules written
   around the old (assumed) behaviour. / **截断后 API 行为与训练数据假设不同**：如果 ADR 记录了与默认 LLM 假设不同的已验证 API 行为，检查引用相关系统的所有 GDD。查找围绕旧（假设）行为编写的设计规则。
2. **Known engine limitations in ADRs**: If an ADR records a known engine limitation
   (e.g. "Jolt ignores HingeJoint3D damp", "D3D12 is now the default backend"), check
   GDDs that design mechanics around the affected feature. / **ADR 中的已知引擎限制**：如果 ADR 记录了已知引擎限制，检查围绕受影响功能设计机制的 GDD。
3. **Deprecated API conflicts**: If Phase 5 flagged a deprecated API used in an ADR,
   check whether any GDD contains mechanics that assume the deprecated API's behaviour. / **已弃用 API 冲突**：如果第 5 阶段标记了 ADR 中使用的已弃用 API，检查是否有 GDD 包含假设该已弃用 API 行为的机制。

For each conflict found, record it in the GDD Revision Flags table: / 对于发现的每个冲突，记录在 GDD 修订标记表中：
> **中文翻译**：对于发现的每个冲突，记录在 GDD 修订标记表中：

```
### GDD Revision Flags (Architecture → Design Feedback)
These GDD assumptions conflict with verified engine behaviour or accepted ADRs.
The GDD should be revised before its system enters implementation.

| GDD | Assumption | Reality (from ADR/engine-reference) | Action |
|-----|-----------|--------------------------------------|--------|
| combat.md | "Use HingeJoint3D damp for weapon recoil" | Jolt ignores damp — ADR-0003 | Revise GDD |
```

If no revision flags are found, write: "No GDD revision flags — all GDD assumptions
are consistent with verified engine behaviour." / 如果未找到修订标记，写入："无 GDD 修订标记 — 所有 GDD 假设与验证的引擎行为一致。"
> **中文翻译**：如果未找到修订标记，写入："无 GDD 修订标记 — 所有 GDD 假设与验证的引擎行为一致。"

Ask: "Should I flag these GDDs for revision in the systems index?" / 询问："我应该在系统索引中标记这些 GDD 以供修订吗？"
> **中文翻译**：询问："我应该在系统索引中标记这些 GDD 以供修订吗？"

- If yes: update the relevant systems' Status field to "Needs Revision"
  and add a short inline note in the adjacent Notes/Description column explaining the conflict.
  Ask for approval before writing. / 如果是：更新相关系统的 Status 字段为 "Needs Revision"，并在相邻的 Notes/Description 列添加简短的内联注释解释冲突。写入前请求批准。
  (Do NOT use parentheticals like "Needs Revision (Architecture Feedback)" — other skills
  match the exact string "Needs Revision" and parentheticals break that match.) / （不要使用括号如 "Needs Revision (Architecture Feedback)" — 其他技能匹配精确字符串 "Needs Revision"，括号会破坏该匹配。）

---

## Phase 6: Architecture Document Coverage / 第 6 阶段：架构文档覆盖

If `docs/architecture/architecture.md` exists, validate it against GDDs: / 如果 `docs/architecture/architecture.md` 存在，对照 GDD 验证它：
> **中文翻译**：如果 `docs/architecture/architecture.md` 存在，对照 GDD 验证它：

- Does every system from `systems-index.md` appear in the architecture layers? / `systems-index.md` 中的每个系统是否出现在架构层中？
- Does the data flow section cover all cross-system communication defined in GDDs? / 数据流章节是否覆盖了 GDD 中定义的所有跨系统通信？
- Do the API boundaries support all integration requirements from GDDs? / API 边界是否支持 GDD 中的所有集成需求？
- Are there systems in the architecture doc that have no corresponding GDD
  (orphaned architecture)? / 架构文档中是否有无对应 GDD 的系统（孤立架构）？

---

## Phase 7: Output the Review Report / 第 7 阶段：输出审查报告

```
## Architecture Review Report
Date: [date]
Engine: [name + version]
GDDs Reviewed: [N]
ADRs Reviewed: [M]

---

### Traceability Summary
Total requirements: [N]
✅ Covered: [X]
⚠️ Partial: [Y]
❌ Gaps: [Z]

### Coverage Gaps (no ADR exists)
For each gap:
  ❌ TR-[id]: [GDD] → [system] → [requirement]
     Suggested ADR: "/architecture-decision [suggested title]"
     Domain: [Physics/Rendering/etc]
     Engine Risk: [LOW/MEDIUM/HIGH]

### Cross-ADR Conflicts
[List all conflicts from Phase 4]

### ADR Dependency Order
[Topologically sorted implementation order from Phase 4 — dependency ordering section]
[Unresolved dependencies and cycles if any]

### GDD Revision Flags
[GDD assumptions that conflict with verified engine behaviour — from Phase 5b]
[Or: "None — all GDD assumptions consistent with verified engine behaviour"]

### Engine Compatibility Issues
[List all engine issues from Phase 5]

### Architecture Document Coverage
[List missing systems and orphaned architecture from Phase 6]

---

### Verdict: [PASS / CONCERNS / FAIL]

PASS: All requirements covered, no conflicts, engine consistent
CONCERNS: Some gaps or partial coverage, but no blocking conflicts
FAIL: Critical gaps (Foundation/Core layer requirements uncovered),
      or blocking cross-ADR conflicts detected

### Blocking Issues (must resolve before PASS)
[List items that must be resolved — FAIL verdict only]

### Required ADRs
[Prioritised list of ADRs to create, most foundational first]
```

---

## Phase 8: Write and Update Traceability Index / 第 8 阶段：写入和更新可追溯性索引

Use `AskUserQuestion` for the write approval: / 使用 `AskUserQuestion` 获取写入批准：
> **中文翻译**：使用 `AskUserQuestion` 获取写入批准：

- "Review complete. What would you like to write?" / "审查完成。你想写入什么？"
  - [A] Write all three files (review report + traceability index + TR registry) / [A] 写入所有三个文件（审查报告 + 可追溯性索引 + TR 注册表）
  - [B] Write review report only — `docs/architecture/architecture-review-[date].md` / [B] 仅写入审查报告
  - [C] Don't write anything yet — I need to review the findings first / [C] 暂不写入 — 我需要先审查发现

### RTM Output (rtm mode only) / RTM 输出（仅 rtm 模式）

For `rtm` mode, additionally ask: "May I write the full Requirements Traceability
Matrix to `docs/architecture/requirements-traceability.md`?" / 对于 `rtm` 模式，另外询问："我可以将完整的需求可追溯性矩阵写入 `docs/architecture/requirements-traceability.md` 吗？"
> **中文翻译**：对于 `rtm` 模式，另外询问："我可以将完整的需求可追溯性矩阵写入 `docs/architecture/requirements-traceability.md` 吗？"

RTM file format: / RTM 文件格式：
> **中文翻译**：RTM 文件格式：

```markdown
# Requirements Traceability Matrix (RTM)

> Last Updated: [date]
> Mode: /architecture-review rtm
> Coverage: [N]% full chain complete (GDD → ADR → Story → Test)

## How to read this matrix

| Column / 列 | Meaning / 含义 |
|--------|---------|
| TR-ID | Stable requirement ID from tr-registry.yaml |
| GDD | Source design document / 来源设计文档 |
| ADR | Architectural decision governing implementation / 管辖实现的架构决策 |
| Story | Story file that implements this requirement / 实现此需求的故事文件 |
| Test File | Automated test file path / 自动化测试文件路径 |
| Test Status | COVERED / MISSING / NONE / NO STORY |

## Full Traceability Matrix

| TR-ID | GDD | Requirement / 需求 | ADR | Story / 故事 | Test File / 测试文件 | Status / 状态 |
|-------|-----|-------------|-----|-------|-----------|--------|
[Full matrix rows from Phase 3b]

## Coverage Summary / 覆盖摘要

| Status / 状态 | Count / 计数 | % / 百分比 |
|--------|-------|---|
| COVERED — full chain complete / 完整链完成 | [N] | [%] |
| MISSING test — story exists, no test / 测试缺失 — 故事存在，无测试 | [N] | [%] |
| NO STORY — ADR exists, not yet implemented / 无故事 — ADR 存在，尚未实现 | [N] | [%] |
| NO ADR — architectural gap / 无 ADR — 架构差距 | [N] | [%] |
| **Total requirements** / **总需求** | **[N]** | **100%** |

## Uncovered Requirements (Priority Fix List) / 未覆盖需求（优先级修复列表）

Requirements where the full chain is broken, prioritised by layer: / 完整链断裂的需求，按层优先级排序：

### Foundation layer gaps / 基础层差距
[list with suggested action per gap] / [每个差距的建议操作列表]

### Core layer gaps / 核心层差距
[list] / [列表]

### Feature / Presentation layer gaps / 功能/表现层差距
[list — lower priority] / [列表 — 较低优先级]

## History / 历史

| Date / 日期 | Full Chain % / 完整链百分比 | Notes / 备注 |
|------|-------------|-------|
| [date] | [%] | Initial RTM / 初始 RTM |
```

### TR Registry Update / TR 注册表更新

Also ask: "May I update `docs/architecture/tr-registry.yaml` with new requirement
IDs from this review?" / 另外询问："我可以使用本次审查的新需求 ID 更新 `docs/architecture/tr-registry.yaml` 吗？"
> **中文翻译**：另外询问："我可以使用本次审查的新需求 ID 更新 `docs/architecture/tr-registry.yaml` 吗？"

If yes: / 如果是：
> **中文翻译**：如果是：

- **Append** any new TR-IDs that weren't in the registry before this review / **追加**本次审查之前不在注册表中的任何新 TR-ID
- **Update** `requirement` text and `revised` date for any entries whose GDD
  wording changed (ID stays the same) / **更新** GDD 措辞已更改的条目的 `requirement` 文本和 `revised` 日期（ID 不变）
- **Mark** `status: deprecated` for any registry entries whose GDD requirement
  no longer exists (confirm with user before marking deprecated) / **标记** GDD 需求不再存在的注册表条目为 `status: deprecated`（标记前与用户确认）
- **Never** renumber or delete existing entries / **永远不要**重新编号或删除现有条目
- Update the `last_updated` and `version` fields at the top / 更新顶部的 `last_updated` 和 `version` 字段

This ensures all future story files can reference stable TR-IDs that persist
across every subsequent architecture review. / 这确保所有未来的故事文件可以引用在每次后续架构审查中持久存在的稳定 TR-ID。
> **中文翻译**：这确保所有未来的故事文件可以引用在每次后续架构审查中持久存在的稳定 TR-ID。

### Reflexion Log Update / 反思日志更新

After writing the review report, append any 🔴 CONFLICT entries found in Phase 4
to `docs/consistency-failures.md` (if the file exists): / 写入审查报告后，将第 4 阶段发现的任何 🔴 CONFLICT 条目追加到 `docs/consistency-failures.md`（如果文件存在）：
> **中文翻译**：写入审查报告后，将第 4 阶段发现的任何 🔴 CONFLICT 条目追加到 `docs/consistency-failures.md`（如果文件存在）：

```markdown
### [YYYY-MM-DD] — /architecture-review — 🔴 CONFLICT
**Domain**: Architecture / [specific domain e.g. State Ownership, Performance]
**Documents involved**: [ADR-NNNN] vs [ADR-MMMM]
**What happened**: [specific conflict — what each ADR claims]
**Resolution**: [how it was or should be resolved]
**Pattern**: [generalised lesson for future ADR authors in this domain]
```

Only append CONFLICT entries — do not log GAP entries (missing ADRs are expected
before the architecture is complete). Do not create the file if missing — only
append when it already exists. / 仅追加 CONFLICT 条目 — 不要记录 GAP 条目（架构完成前缺少 ADR 是正常的）。如果文件不存在则不要创建 — 仅在已存在时追加。
> **中文翻译**：仅追加 CONFLICT 条目 — 不要记录 GAP 条目（架构完成前缺少 ADR 是正常的）。如果文件不存在则不要创建 — 仅在已存在时追加。

### Session State Update / 会话状态更新

After writing all approved files, silently append to
`production/session-state/active.md`: / 写入所有批准的文件后，静默追加到 `production/session-state/active.md`：
> **中文翻译**：写入所有批准的文件后，静默追加到 `production/session-state/active.md`：

    <!-- 中文翻译 -->
    ## Session Extract — /architecture-review [date]
    - Verdict: [PASS / CONCERNS / FAIL]
    - Requirements: [N] total — [X] covered, [Y] partial, [Z] gaps
    - New TR-IDs registered: [N, or "None"]
    - GDD revision flags: [comma-separated GDD names, or "None"]
    - Top ADR gaps: [top 3 gap titles from the report, or "None"]
    - Report: docs/architecture/architecture-review-[date].md

If `active.md` does not exist, create it with this block as the initial content.
Confirm in conversation: "Session state updated." / 如果 `active.md` 不存在，使用此块作为初始内容创建它。在对话中确认："会话状态已更新。"
> **中文翻译**：如果 `active.md` 不存在，使用此块作为初始内容创建它。在对话中确认："会话状态已更新。"

The traceability index format: / 可追溯性索引格式：
> **中文翻译**：可追溯性索引格式：

```markdown
# Architecture Traceability Index
Last Updated: [date]
Engine: [name + version]

## Coverage Summary / 覆盖摘要
- Total requirements: [N]
- Covered: [X] ([%])
- Partial: [Y]
- Gaps: [Z]

## Full Matrix / 完整矩阵
[Complete traceability matrix from Phase 3]

## Known Gaps / 已知差距
[All ❌ items with suggested ADRs]

## Superseded Requirements / 已替代需求
[Requirements whose GDD was changed after the ADR was written]
```

---

## Phase 9: Handoff / 第 9 阶段：交接

After completing the review and writing approved files, present: / 完成审查并写入批准的文件后，呈现：
> **中文翻译**：完成审查并写入批准的文件后，呈现：

1. **Immediate actions**: List the top 3 ADRs to create (highest-impact gaps first,
   Foundation layer before Feature layer) / **即时行动**：列出要创建的前 3 个 ADR（最高影响差距优先，基础层在功能层之前）
2. **Gate guidance**: "When all blocking issues are resolved, run `/gate-check
   pre-production` to advance" / **门控指导**："当所有阻塞问题解决后，运行 `/gate-check pre-production` 以推进"
3. **Rerun trigger**: "Re-run `/architecture-review` after each new ADR is written
   to verify coverage improves" / **重新运行触发**："每次写入新 ADR 后重新运行 `/architecture-review` 以验证覆盖率提升"

Then close with `AskUserQuestion`: / 然后以 `AskUserQuestion` 结束：
> **中文翻译**：然后以 `AskUserQuestion` 结束：

- "Architecture review complete. What would you like to do next?" / "架构审查完成。你想接下来做什么？"
  - [A] Write a missing ADR — open a fresh session and run `/architecture-decision [system]` / [A] 编写缺失的 ADR — 打开新会话并运行 `/architecture-decision [system]`
  - [B] Run `/gate-check pre-production` — if all blocking gaps are resolved / [B] 运行 `/gate-check pre-production` — 如果所有阻塞差距已解决
  - [C] Stop here for this session / [C] 此会话到此为止

---

## Error Recovery Protocol / 错误恢复协议

If any spawned agent returns BLOCKED, errors, or fails to complete: / 如果任何生成的代理返回 BLOCKED、错误或无法完成：
> **中文翻译**：如果任何生成的代理返回 BLOCKED、错误或无法完成：

1. **Surface immediately**: Report "[AgentName]: BLOCKED — [reason]" before continuing / **立即呈现**：在继续之前报告"[代理名称]：BLOCKED — [原因]"
2. **Assess dependencies**: If the blocked agent's output is required by a later phase, do not proceed past that phase without user input / **评估依赖**：如果被阻塞代理的输出是后续阶段所需的，在没有用户输入的情况下不要继续通过该阶段
3. **Offer options** via AskUserQuestion with three choices: / 通过 AskUserQuestion **提供选项**，三个选择：
   - Skip this agent and note the gap in the final report / 跳过此代理并在最终报告中注明差距
   - Retry with narrower scope (fewer GDDs, single-system focus) / 用更窄的范围重试
   - Stop here and resolve the blocker first / 在此停止并先解决阻塞
4. **Always produce a partial report** — output whatever was completed so work is not lost / **始终生成部分报告** — 输出已完成的内容以免工作丢失

---

## Collaborative Protocol / 协作协议

1. **Read silently** — do not narrate every file read / **静默读取** — 不要叙述每个文件读取
2. **Show the matrix** — present the full traceability matrix before asking for
   anything; let the user see the state / **显示矩阵** — 在请求任何内容之前呈现完整可追溯性矩阵；让用户看到状态
3. **Don't guess** — if a requirement is ambiguous, ask: "Is [X] a technical
   requirement or a design preference?" / **不要猜测** — 如果需求模糊，询问："[X] 是技术需求还是设计偏好？"
4. **Ask before writing** — always confirm before writing the report file / **写入前询问** — 在写入报告文件之前始终确认
5. **Non-blocking** — the verdict is advisory; the user decides whether to continue
   despite CONCERNS or even FAIL findings / **非阻塞** — 裁决是建议性的；用户决定是否在 CONCERNS 甚至 FAIL 结果下继续
