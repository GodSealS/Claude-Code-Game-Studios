---
name: content-audit
description: "Audit GDD-specified content counts against implemented content. Identifies what's planned vs built. / 审计 GDD 指定的内容数量与已实现内容的对比。识别计划与已构建的内容。"
argument-hint: "[system-name | --summary | (no arg = full audit)]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
agent: producer
---

When this skill is invoked:
> **中文翻译**：当该技能被调用时：


Parse the argument:
> **中文翻译**：解析论证：

- No argument → full audit across all systems
  > **中文翻译**：没有争议 → 对所有系统进行全面审计
- `[system-name]` → audit that single system only
  > **中文翻译**：`[系统名称]` → 仅审核该单个系统
- `--summary` → summary table only, no file write
  > **中文翻译**：`--summary` → 仅汇总表，不写入文件


---

## Phase 1 — Context Gathering / 第 1 阶段 — 上下文收集

1. **Read `design/gdd/systems-index.md`** for the full list of systems, their
   categories, and MVP/priority tier.
   > **中文翻译**：**读取 `design/gdd/systems-index.md`** 获取完整的系统列表、其分类和 MVP/优先级层级。

2. **L0 pre-scan**: Before full-reading any GDDs, Grep all GDD files for
   `## Summary` sections plus common content-count keywords:
   > **中文翻译**：**L0 预扫描**：在完整阅读任何 GDD 之前，用 Grep 查找所有 GDD 文件的 `## Summary` 部分和常见内容计数关键词：
   ```
   Grep pattern="(## Summary|N enemies|N levels|N items|N abilities|enemy types|item types)" glob="design/gdd/*.md" output_mode="files_with_matches"
   ```
   For a single-system audit: skip this step and go straight to full-read.
   For a full audit: full-read only the GDDs that matched content-count keywords.
   GDDs with no content-count language (pure mechanics GDDs) are noted as
   "No auditable content counts" without a full read.
   > **中文翻译**：对于单系统审计：跳过此步骤，直接进行完整阅读。对于完整审计：仅完整阅读匹配了内容计数关键词的 GDD。没有内容计数语言的 GDD（纯机制 GDD）被标记为"无可审计的内容计数"，无需完整阅读。

3. **Full-read in-scope GDD files** (or the single system GDD if a system
   name was given).
   > **中文翻译**：**完整阅读范围内的 GDD 文件**（或如果给出了系统名称，则为该单个系统的 GDD）。

4. **For each GDD, extract explicit content counts or lists.** Look for patterns
   like:
   > **中文翻译**：**对于每个 GDD，提取明确的内容计数或列表。** 查找以下模式：
   - "N enemies" / "enemy types:" / list of named enemies / "N 个敌人"/ "敌人类型：" / 命名敌人列表
   - "N levels" / "N areas" / "N maps" / "N stages" / "N 个关卡"/ "N 个区域"/ "N 个地图"/ "N 个阶段"
   - "N items" / "N weapons" / "N equipment pieces" / "N 个物品"/ "N 个武器"/ "N 个装备件"
   - "N abilities" / "N skills" / "N spells" / "N 个能力"/ "N 个技能"/ "N 个法术"
   - "N dialogue scenes" / "N conversations" / "N cutscenes" / "N 个对话场景"/ "N 个对话"/ "N 个过场动画"
   - "N quests" / "N missions" / "N objectives" / "N 个任务"/ "N 个使命"/ "N 个目标"
   - Any explicit enumerated list (bullet list of named content pieces) / 任何明确的枚举列表（命名内容项的要点列表）

4. **Build a content inventory table** from the extracted data:
   > **中文翻译**：**从提取的数据构建内容清单表：**

   | System | Content Type | Specified Count/List | Source GDD |
   |--------|-------------|---------------------|------------|
   <!-- 翻译: 系统 | 内容类型 | 指定计数/列表 | 来源 GDD -->

   Note: If a GDD describes content qualitatively but gives no count, record
   "Unspecified" and flag it — unspecified counts are a design gap worth noting.
   > **中文翻译**：注意：如果 GDD 定性描述了内容但未给出计数，记录"未指定"并标记 — 未指定的计数是值得注意的设计差距。

---

<!-- 中文翻译 -->
## Phase 2 — Implementation Scan
> **中文翻译**：## 第 2 阶段 — 实施扫描


For each content type found in Phase 1, scan the relevant directories to count what has been implemented. Use Glob and Grep to locate files.
> **中文翻译**：对于第一阶段中找到的每种内容类型，扫描相关目录以计算已实施的内容。使用 Glob 和 Grep 来定位文件。


**Levels / Areas / Maps:**
> **中文翻译**：**关卡/区域/地图：**

- Glob `assets/**/*.tscn`, `assets/**/*.unity`, `assets/**/*.umap`
  > **中文翻译**：全局`assets/**/*.tscn`、`assets/**/*.unity`、`assets/**/*.umap`
- Glob `src/**/*.tscn`, `src/**/*.unity`
  > **中文翻译**：全局 `src/**/*.tscn`、`src/**/*.unity`
- Look for scene files in subdirectories named `levels/`, `areas/`, `maps/`,
  > **中文翻译**：在名为“levels/”、“areas/”、“maps/”的子目录中查找场景文件

  `worlds/`, `stages/`
> **中文翻译**：`世界/`、`阶段/`

- Count unique files that appear to be level/scene definitions (not UI scenes)
  > **中文翻译**：计算看似关卡/场景定义（而非 UI 场景）的唯一文件


**Enemies / Characters / NPCs:**
> **中文翻译**：**敌人/角色/NPC：**

- Glob `assets/data/**/enemies/**`, `assets/data/**/characters/**`
  > **中文翻译**：全局 `assets/data/**/enemies/**`, `assets/data/**/characters/**`
- Glob `src/**/enemies/**`, `src/**/characters/**`
  > **中文翻译**：全局 `src/**/enemies/**`、`src/**/characters/**`
- Look for `.json`, `.tres`, `.asset`, `.yaml` data files defining entity stats
  > **中文翻译**：查找定义实体统计信息的“.json”、“.tres”、“.asset”、“.yaml”数据文件
- Look for scene/prefab files in character subdirectories
  > **中文翻译**：在角色子目录中查找场景/预制文件


**Items / Equipment / Loot:**
> **中文翻译**：**物品/设备/战利品：**

- Glob `assets/data/**/items/**`, `assets/data/**/equipment/**`,
  > **中文翻译**：Glob`资产/数据/**/项目/**`，`资产/数据/**/设备/**`，

  `assets/data/**/loot/**`
> **中文翻译**：`资产/数据/**/战利品/**`

- Look for `.json`, `.tres`, `.asset` data files
  > **中文翻译**：查找 `.json`、`.tres`、`.asset` 数据文件


**Abilities / Skills / Spells:**
> **中文翻译**：**能力/技能/法术：**

- Glob `assets/data/**/abilities/**`, `assets/data/**/skills/**`,
  > **中文翻译**：Glob`资产/数据/**/能力/**`，`资产/数据/**/技能/**`，

  `assets/data/**/spells/**`
> **中文翻译**：`资产/数据/**/法术/**`

- Look for `.json`, `.tres`, `.asset` data files
  > **中文翻译**：查找 `.json`、`.tres`、`.asset` 数据文件


**Dialogue / Conversations / Cutscenes:**
> **中文翻译**：**对话/对话/过场动画：**

- Glob `assets/**/*.dialogue`, `assets/**/*.csv`, `assets/**/*.ink`
  > **中文翻译**：Glob `assets/**/*.dialogue`、`assets/**/*.csv`、`assets/**/*.ink`
- Grep for dialogue data files in `assets/data/`
  > **中文翻译**：Grep 查找 `assets/data/` 中的对话数据文件


**Quests / Missions:**
> **中文翻译**：**任务/任务：**

- Glob `assets/data/**/quests/**`, `assets/data/**/missions/**`
  > **中文翻译**：全局`资产/数据/**/任务/**`，`资产/数据/**/任务/**`
- Look for `.json`, `.yaml` definition files
  > **中文翻译**：查找 `.json`、`.yaml` 定义文件


**Engine-specific notes (acknowledge in the report):**
> **中文翻译**：**发动机特定注释（在报告中确认）：**

- Counts are approximations — the skill cannot perfectly parse every engine
  > **中文翻译**：计数是近似值——该技能无法完美解析每个引擎

  format or distinguish editor-only files from shipped content
> **中文翻译**：格式化仅限编辑器的文件或将其与附带的内容区分开

- Scene files may include both gameplay content and system/UI scenes; the scan
  > **中文翻译**：场景文件可能包括游戏内容和系统/UI场景；扫描

  counts all matches and notes this caveat
> **中文翻译**：计算所有匹配并记录此警告


---

## Phase 3 — Gap Report / 第 3 阶段 — 差距报告

Produce the gap table: / 生成差距表：

```
| System | Content Type | Specified | Found | Gap | Status |
|--------|-------------|-----------|-------|-----|--------|
```
<!-- 翻译: 系统 | 内容类型 | 指定 | 已找到 | 差距 | 状态 -->

**Status categories:** / **状态分类：**
- `COMPLETE` — Found ≥ Specified (100%+) / `完成` — 已找到 ≥ 已指定（100%+）
- `IN PROGRESS` — Found is 50–99% of Specified / `进行中` — 已找到为指定的 50–99%
- `EARLY` — Found is 1–49% of Specified / `早期` — 已找到为指定的 1–49%
- `NOT STARTED` — Found is 0 / `未开始` — 已找到为 0

**Priority flags:** / **优先级标记：**
Flag a system as `HIGH PRIORITY` in the report if: / 如果满足以下条件，在报告中将系统标记为 `高优先级`：
- Status is `NOT STARTED` or `EARLY`, AND / 状态为 `未开始` 或 `早期`，且
- The system is tagged MVP or Vertical Slice in the systems index, OR / 系统在系统索引中被标记为 MVP 或垂直切片，或
- The systems index shows the system is blocking downstream systems / 系统索引显示该系统阻塞下游系统

**Summary line:** / **摘要行：**
- Total content items specified (sum of all Specified column values) / 指定的内容项总数（所有指定列值的总和）
- Total content items found (sum of all Found column values) / 已找到的内容项总数（所有已找到列值的总和）
- Overall gap percentage: `(Specified - Found) / Specified * 100` / 总体差距百分比：`(指定 - 已找到) / 指定 * 100`

---

<!-- 中文翻译 -->
## Phase 4 — Output
> **中文翻译**：## 第 4 阶段 — 输出


<!-- 中文翻译 -->
### Full audit and single-system modes
> **中文翻译**：### 完整审核和单系统模式


Present the gap table and summary to the user. Ask: "May I write the full report to `docs/content-audit-[YYYY-MM-DD].md`?"
> **中文翻译**：向用户呈现差距表和摘要。问：“我可以将完整的报告写入`docs/content-audit-[YYYY-MM-DD].md`吗？”


If yes, write the file:
> **中文翻译**：如果是，则写入文件：


```markdown
# Content Audit — [Date]

## Summary
- **Total specified**: [N] content items across [M] systems
- **Total found**: [N]
- **Gap**: [N] items ([X%] unimplemented)
- **Scope**: [Full audit | System: name]

> Note: Counts are approximations based on file scanning.
> The audit cannot distinguish shipped content from editor/test assets.
> Manual verification is recommended for any HIGH PRIORITY gaps.

## Gap Table

| System | Content Type | Specified | Found | Gap | Status |
|--------|-------------|-----------|-------|-----|--------|

## HIGH PRIORITY Gaps

[List systems flagged HIGH PRIORITY with rationale]

## Per-System Breakdown

### [System Name]
- **GDD**: `design/gdd/[file].md`
- **Content types audited**: [list]
- **Notes**: [any caveats about scan accuracy for this system]

## Recommendation

Focus implementation effort on:
1. [Highest-gap HIGH PRIORITY system]
2. [Second system]
3. [Third system]

## Unspecified Content Counts

The following GDDs describe content without giving explicit counts.
Consider adding counts to improve auditability:
[List of GDDs and content types with "Unspecified"]
```

After writing the report, ask:
> **中文翻译**：写完报告后，问：


> "Would you like to create backlog stories for any of the content gaps?"
> **中文翻译**：>“您想为任何内容差距创建积压故事吗？”


If yes: for each system the user selects, suggest a story title and point them to `/create-stories [epic-slug]` or `/quick-design` depending on the size of the gap.
> **中文翻译**：如果是：对于用户选择的每个系统，建议一个故事标题，并根据差距的大小将他们指向“/create-stories [epic-slug]”或“/quick-design”。


<!-- 中文翻译 -->
### --summary mode
> **中文翻译**：### --摘要模式


Print the Gap Table and Summary directly to conversation. Do not write a file. End with: "Run `/content-audit` without `--summary` to write the full report."
> **中文翻译**：直接将差距表和摘要打印到对话中。不要写入文件。结尾为：“运行不带 `--summary` 的 `/content-audit` 来编写完整的报告。”


---

## Phase 5 — Next Steps / 第 5 阶段 — 后续步骤

After the audit, recommend the highest-value follow-up actions:
> **中文翻译**：审计后，推荐最高价值的后续行动：

- If any system is `NOT STARTED` and MVP-tagged → "Run `/design-system [name]` to
  add missing content counts to the GDD before implementation begins."
  > **中文翻译**：如果任何系统为 `未开始` 且标记为 MVP → "运行 `/design-system [name]` 在实现开始之前向 GDD 添加缺失的内容计数。"
- If total gap is >50% → "Run `/sprint-plan` to allocate content work across upcoming sprints."
  > **中文翻译**：如果总差距 >50% → "运行 `/sprint-plan` 在即将到来的冲刺中分配内容工作。"
- If backlog stories are needed → "Run `/create-stories [epic-slug]` for each HIGH PRIORITY gap."
  > **中文翻译**：如果需要待办故事 → "为每个高优先级差距运行 `/create-stories [epic-slug]`。"
- If `--summary` was used → "Run `/content-audit` (no flag) to write the full report to `docs/`."
  > **中文翻译**：如果使用了 `--summary` → "运行 `/content-audit`（不带标志）将完整报告写入 `docs/`。"

Verdict: **COMPLETE** — content audit finished.
> **中文翻译**：裁决：**完成** — 内容审计已完成。
