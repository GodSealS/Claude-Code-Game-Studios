---
name: consistency-check
description: "Scan all GDDs against the entity registry to detect cross-document inconsistencies: same entity with different stats, same item with different values, same formula with different variables. Grep-first approach — reads registry then targets only conflicting GDD sections rather than full document reads. / 对照实体注册表扫描所有 GDD 以检测跨文档不一致：相同实体不同属性、相同物品不同数值、相同公式不同变量。Grep 优先方法 — 读取注册表后仅针对冲突的 GDD 章节而非全文读取。"
argument-hint: "[full | since-last-review | entity:<name> | item:<name>]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash
---

# Consistency Check
> **中文翻译**：# 一致性检查


Detects cross-document inconsistencies by comparing all GDDs against the entity registry (`design/registry/entities.yaml`). Uses a grep-first approach: reads the registry once, then targets only the GDD sections that mention registered names — no full document reads unless a conflict needs investigation.
> **中文翻译**：通过将所有 GDD 与实体注册表（“design/registry/entities.yaml”）进行比较来检测跨文档不一致。使用 grep-first 方法：读取注册表一次，然后仅针对提及注册名称的 GDD 部分 - 除非需要调查冲突，否则不会读取完整文档。


**This skill is the write-time safety net.** It catches what `/design-system`'s per-section checks may have missed and what `/review-all-gdds`'s holistic review catches too late.
> **中文翻译**：**这项技能是写入时的安全网。** 它可以捕获“/design-system”的每个部分检查可能遗漏的内容以及“/review-all-gdds”的整体审查为时已晚的内容。


**When to run:**
> **中文翻译**：**何时运行：**

- After writing each new GDD (before moving to the next system)
  > **中文翻译**：写入每个新的 GDD 后（移动到下一个系统之前）
- Before `/review-all-gdds` (so that skill starts with a clean baseline)
  > **中文翻译**：在 `/review-all-gdds` 之前（以便技能从干净的基线开始）
- Before `/create-architecture` (inconsistencies poison downstream ADRs)
  > **中文翻译**：在“/create-architecture”之前（不一致会毒害下游 ADR）
- On demand: `/consistency-check entity:[name]` to check one entity specifically
  > **中文翻译**：按需：“/consistency-check实体：[名称]”专门检查一个实体


**Output:** Conflict report + optional registry corrections
> **中文翻译**：**输出：** 冲突报告+可选的注册表更正


---

## Phase 1: Parse Arguments and Load Registry

**Modes:**
- No argument / `full` — check all registered entries against all GDDs
- `since-last-review` — check only GDDs modified since the last review report
- `entity:<name>` — check one specific entity across all GDDs
- `item:<name>` — check one specific item across all GDDs

**Load the registry:**

```
Read path="design/registry/entities.yaml"
```

If the file does not exist or has no entries:
> "Entity registry is empty. Run `/design-system` to write GDDs — the registry
> is populated automatically after each GDD is completed. Nothing to check yet."

Stop and exit.

Build four lookup tables from the registry:
- **entity_map**: `{ name → { source, attributes, referenced_by } }`
- **item_map**: `{ name → { source, value_gold, weight, ... } }`
- **formula_map**: `{ name → { source, variables, output_range } }`
- **constant_map**: `{ name → { source, value, unit } }`

Count total registered entries. Report:
```
Registry loaded: [N] entities, [N] items, [N] formulas, [N] constants
Scope: [full | since-last-review | entity:name]
```

---

## Phase 2: Locate In-Scope GDDs
> **中文翻译**：## 第 2 阶段：找到范围内的 GDD


```
Glob pattern="design/gdd/*.md"
```

Exclude: `game-concept.md`, `systems-index.md`, `game-pillars.md` — these are not system GDDs.
> **中文翻译**：排除：`game-concept.md`、`systems-index.md`、`game-pillars.md` — 这些不是系统 GDD。


For `since-last-review` mode:
> **中文翻译**：对于“自上次审核以来”模式：

```bash
git log --name-only --pretty=format: -- design/gdd/ | grep "\.md$" | sort -u
```
Limit to GDDs modified since the most recent `design/gdd/gdd-cross-review-*.md` file's creation date.
> **中文翻译**：限制自最近的 `design/gdd/gdd-cross-review-*.md` 文件创建日期以来修改的 GDD。


Report the in-scope GDD list before scanning.
> **中文翻译**：扫描前报告范围内的 GDD 列表。


---

## Phase 3: Grep-First Conflict Scan

For each registered entry, grep every in-scope GDD for the entry's name.
Do NOT do full reads — extract only the matching lines and their immediate
context (-C 3 lines).

This is the core optimization: instead of reading 10 GDDs × 400 lines each
(4,000 lines), you grep 50 entity names × 10 GDDs (50 targeted searches,
each returning ~10 lines on a hit).

### 3a: Entity Scan

For each entity in entity_map:

```
Grep pattern="[entity_name]" glob="design/gdd/*.md" output_mode="content" -C 3
```

For each GDD hit, extract the values mentioned near the entity name:
- any numeric attributes (counts, costs, durations, ranges, rates)
- any categorical attributes (types, tiers, categories)
- any derived values (totals, outputs, results)
- any other attributes registered in entity_map

Compare extracted values against the registry entry.

**Conflict detection:**
- Registry says `[entity_name].[attribute] = [value_A]`. GDD says `[entity_name] has [value_B]`. → **CONFLICT**
- Registry says `[item_name].[attribute] = [value_A]`. GDD says `[item_name] is [value_B]`. → **CONFLICT**
- GDD mentions `[entity_name]` but doesn't specify the attribute. → **NOTE** (no conflict, just unverifiable)

### 3b: Item Scan

For each item in item_map, grep all GDDs for the item name. Extract:
- sell price / value / gold value
- weight
- stack rules (stackable / non-stackable)
- category

Compare against registry entry values.

### 3c: Formula Scan

For each formula in formula_map, grep all GDDs for the formula name. Extract:
- variable names mentioned near the formula
- output range or cap values mentioned

Compare against registry entry:
- Different variable names → **CONFLICT**
- Output range stated differently → **CONFLICT**

### 3d: Constant Scan

For each constant in constant_map, grep all GDDs for the constant name. Extract:
- Any numeric value mentioned near the constant name

Compare against registry value:
- Different number → **CONFLICT**

---

## Phase 4: Deep Investigation (Conflicts Only)
> **中文翻译**：## 第 4 阶段：深入调查（仅限冲突）


For each conflict found in Phase 3, do a targeted full-section read of the conflicting GDD to get precise context:
> **中文翻译**：对于第 3 阶段中发现的每个冲突，有针对性地完整阅读冲突的 GDD，以获得准确的上下文：


```
Read path="design/gdd/[conflicting_gdd].md"
```
(Or use Grep with wider context if the file is large)
> **中文翻译**：（或者如果文件很大，则使用具有更广泛上下文的 Grep）


Confirm the conflict with full context. Determine:
> **中文翻译**：通过完整的上下文确认冲突。决定：

1. **Which GDD is correct?** Check the `source:` field in the registry — the
  > **中文翻译**：**哪个 GDD 是正确的？** 检查注册表中的“来源：”字段 —

   source GDD is the authoritative owner. Any other GDD that contradicts it    is the one that needs updating.
> **中文翻译**：来源GDD是权威所有者。任何其他与其相矛盾的 GDD 都需要更新。

2. **Is the registry itself out of date?** If the source GDD was updated after
  > **中文翻译**：**注册表本身是否已过时？** 如果源 GDD 在之后更新

   the registry entry was written (check git log), the registry may be stale.
> **中文翻译**：注册表项已写入（检查 git 日志），注册表可能已过时。

3. **Is this a genuine design change?** If the conflict represents an intentional
  > **中文翻译**：**这是真正的设计变更吗？** 如果冲突代表有意为之

   design decision, the resolution is: update the source GDD, update the registry,    then fix all other GDDs.
> **中文翻译**：设计决策，解决方案是：更新源GDD，更新注册表，然后修复所有其他GDD。


For each conflict, classify:
> **中文翻译**：对于每个冲突，进行分类：

- **🔴 CONFLICT** — same named entity/item/formula/constant with different values
  > **中文翻译**：**🔴冲突** — 具有不同值的相同命名实体/项目/公式/常量

  in different GDDs. Must resolve before architecture begins.
> **中文翻译**：在不同的 GDD 中。必须在架构开始之前解决。

- **⚠️ STALE REGISTRY** — source GDD value changed but registry not updated.
  > **中文翻译**：**⚠️ STALE REGISTRY** — 源 GDD 值已更改，但注册表未更新。

  Registry needs updating; other GDDs may be correct already.
> **中文翻译**：注册表需要更新；其他 GDD 可能已经是正确的。

- **ℹ️ UNVERIFIABLE** — entity mentioned but no comparable attribute stated.
  > **中文翻译**：**ℹ️ 无法验证** — 提到了实体，但没有说明可比较的属性。

  Not a conflict; just noting the reference.
> **中文翻译**：不是冲突；只是注意参考。


---

## Phase 5: Output Report

```
## Consistency Check Report
Date: [date]
Registry entries checked: [N entities, N items, N formulas, N constants]
GDDs scanned: [N] ([list names])

---

### Conflicts Found (must resolve before architecture)
> **中文翻译**：### 发现冲突（必须在架构之前解决）


🔴 [Entity/Item/Formula/Constant Name]    Registry (source: [gdd]): [attribute] = [value]    Conflict in [other_gdd].md: [attribute] = [different_value]    → Resolution needed: [which doc to change and to what]
> **中文翻译**：🔴 [实体/项目/公式/常量名称] 注册表（来源：[gdd]）：[属性] = [值] [other_gdd].md 中的冲突：[属性] = [不同_值] → 需要解决方案：[要更改哪个文档以及更改什么]


---

### Stale Registry Entries (registry behind the GDD)

⚠️ [Entry Name]
   Registry says: [value] (written [date])
   Source GDD now says: [new value]
   → Update registry entry to match source GDD, then check referenced_by docs.

---

### Unverifiable References (no conflict, informational)
> **中文翻译**：### 无法验证的引用（无冲突，仅供参考）


ℹ️ [gdd].md mentions [entity_name] but states no comparable attributes.    No conflict detected. No action required.
> **中文翻译**：ℹ️ [gdd].md 提到 [entity_name] 但没有说明可比较的属性。    未检测到冲突。无需采取任何行动。


---

### Clean Entries (no issues found)

✅ [N] registry entries verified across all GDDs with no conflicts.

---

Verdict: PASS | CONFLICTS FOUND
> **中文翻译**：结论：通过 |发现冲突

```

**Verdict:**
- **PASS** — no conflicts. Registry and GDDs agree on all checked values.
- **CONFLICTS FOUND** — one or more conflicts detected. List resolution steps.

---

## Phase 6: Registry Corrections

If stale registry entries were found, ask:
> "May I update `design/registry/entities.yaml` to fix the [N] stale entries?"

For each stale entry:
- Update the `value` / attribute field
- Set `revised:` to today's date
- Add a YAML comment with the old value: `# was: [old_value] before [date]`

If new entries were found in GDDs that are not in the registry, ask:
> "Found [N] entities/items mentioned in GDDs that aren't in the registry yet.
> May I add them to `design/registry/entities.yaml`?"

Only add entries that appear in more than one GDD (true cross-system facts).

**Never delete registry entries.** Set `status: deprecated` if an entry is removed
from all GDDs.

After writing: Verdict: **COMPLETE** — consistency check finished.
If conflicts remain unresolved: Verdict: **BLOCKED** — [N] conflicts need manual resolution before architecture begins.

### 6b: Append to Reflexion Log

If any 🔴 CONFLICT entries were found (regardless of whether they were resolved),
append an entry to `docs/consistency-failures.md` for each conflict:

```markdown
### [YYYY-MM-DD] — /consistency-check — 🔴 CONFLICT
**Domain**: [system domain(s) involved]
**Documents involved**: [source GDD] vs [conflicting GDD]
**What happened**: [specific conflict — entity name, attribute, differing values]
**Resolution**: [how it was fixed, or "Unresolved — manual action needed"]
**Pattern**: [generalised lesson, e.g. "Item values defined in combat GDD were not
referenced in economy GDD before authoring — always check entities.yaml first"]
```

Only append if `docs/consistency-failures.md` exists. If the file is missing,
skip this step silently — do not create the file from this skill.

---

## Next Steps

- **If PASS**: Run `/review-all-gdds` for holistic design-theory review, or
  `/create-architecture` if all MVP GDDs are complete.
- **If CONFLICTS FOUND**: Fix the flagged GDDs, then re-run
  `/consistency-check` to confirm resolution.
- **If STALE REGISTRY**: Update the registry (Phase 6), then re-run to verify.
- Run `/consistency-check` after writing each new GDD to catch issues early,
  not at architecture time.
