# Architecture Traceability Index / 架构可追溯性索引

<!-- Living document — updated by /architecture-review after each review run. / 活文档 — 每次架构评审后由 /architecture-review 更新
     Do not edit manually unless correcting an error. --> / 除非纠正错误，否则不要手动编辑。

<!-- 中文翻译 -->
## Document Status / 文档状态

- **Last Updated**: [YYYY-MM-DD] / **最后更新**: [YYYY-MM-DD]
- **Engine**: [e.g. Godot 4.6] / **引擎**: [例如 Godot 4.6]
- **GDDs Indexed**: [N] / **已索引的GDD**: [N]
- **ADRs Indexed**: [M] / **已索引的ADR**: [M]
- **Last Review**: [link to docs/architecture/architecture-review-[date].md] / **最后评审**: [链接到 docs/architecture/architecture-review-[date].md]

<!-- 中文翻译 -->
## Coverage Summary / 覆盖摘要

| Status | Count | Percentage | 状态 | 数量 | 百分比 |
|--------|-------|-----------|------|------|-------|
| ✅ Covered | [X] | [%] | ✅ 已覆盖 | [X] | [%] |
| ⚠️ Partial | [Y] | [%] | ⚠️ 部分覆盖 | [Y] | [%] |
| ❌ Gap | [Z] | [%] | ❌ 差距 | [Z] | [%] |
| **Total** | **[N]** | | **总计** | **[N]** | |

---

<!-- 可追溯性矩阵 -->
## Traceability Matrix / 可追溯性矩阵

<!-- One row per technical requirement extracted from a GDD. / 每行对应从GDD中提取的一个技术需求。
     A "technical requirement" is any GDD statement that implies a specific / "技术需求"是指任何暗示特定架构决策的GDD声明：
     architectural decision: data structures, performance constraints, engine / 数据结构、性能约束、所需引擎能力、跨系统通信、状态持久化。
     capabilities needed, cross-system communication, state persistence. -->

| Req ID | GDD | System | Requirement Summary | ADR(s) | Status | Notes | 需求ID | GDD | 系统 | 需求摘要 | ADR(s) | 状态 | 备注 |
|--------|-----|--------|---------------------|--------|--------|-------|------|-----|------|----------|--------|------|------|
| TR-[gdd]-001 | [filename] | [system name] | [one-line summary] | [ADR-NNNN] | ✅ | | TR-[gdd]-001 | [文件名] | [系统名称] | [单行摘要] | [ADR-NNNN] | ✅ | |
| TR-[gdd]-002 | [filename] | [system name] | [one-line summary] | — | ❌ GAP | Needs `/architecture-decision [title]` | TR-[gdd]-002 | [文件名] | [系统名称] | [单行摘要] | — | ❌ 差距 | 需要 `/architecture-decision [标题]` |

---

<!-- 中文翻译 -->
## Known Gaps / 已知差距

Requirements with no ADR coverage, prioritised by layer (Foundation first): / 没有ADR覆盖的需求，按层次优先级排序（基础层优先）：

<!-- 中文翻译 -->
### Foundation Layer Gaps (BLOCKING — must resolve before coding) / 基础层差距（阻塞性 — 必须在编码前解决）
- [ ] TR-[id]: [requirement] — GDD: [file] — Suggested ADR: "[title]" / TR-[id]: [需求] — GDD: [文件] — 建议的ADR: "[标题]"

<!-- 中文翻译 -->
### Core Layer Gaps (must resolve before relevant system is built) / 核心层差距（必须在相关系统构建前解决）
- [ ] TR-[id]: [requirement] — GDD: [file] — Suggested ADR: "[title]" / TR-[id]: [需求] — GDD: [文件] — 建议的ADR: "[标题]"

<!-- 中文翻译 -->
### Feature Layer Gaps (should resolve before feature sprint) / 功能层差距（应在功能冲刺前解决）
- [ ] TR-[id]: [requirement] — GDD: [file] — Suggested ADR: "[title]" / TR-[id]: [需求] — GDD: [文件] — 建议的ADR: "[标题]"

<!-- 展示层差距（可推迟到实现阶段） -->
### Presentation Layer Gaps (can defer to implementation) / 展示层差距（可推迟到实现阶段）
- [ ] TR-[id]: [requirement] — GDD: [file] — Suggested ADR: "[title]" / TR-[id]: [需求] — GDD: [文件] — 建议的ADR: "[标题]"

---

<!-- 中文翻译 -->
## Cross-ADR Conflicts / 跨ADR冲突

<!-- Pairs of ADRs that make contradictory claims. Must be resolved. --> / 做出矛盾主张的ADR对。必须解决。

| Conflict ID | ADR A | ADR B | Type | Status | 冲突ID | ADR A | ADR B | 类型 | 状态 |
|-------------|-------|-------|------|--------|------|-------|-------|------|------|
| CONFLICT-001 | ADR-NNNN | ADR-MMMM | Data ownership | 🔴 Unresolved | CONFLICT-001 | ADR-NNNN | ADR-MMMM | 数据所有权 | 🔴 未解决 |

---

<!-- ADR → GDD 覆盖（反向索引） -->
## ADR → GDD Coverage (Reverse Index) / ADR → GDD 覆盖（反向索引）

<!-- For each ADR, which GDD requirements does it address? --> / 对于每个ADR，它解决了哪些GDD需求？

| ADR | Title | GDD Requirements Addressed | Engine Risk | ADR | 标题 | 解决的GDD需求 | 引擎风险 |
|-----|-------|---------------------------|-------------|-----|------|---------------|----------|
| ADR-0001 | [title] | TR-combat-001, TR-combat-002 | HIGH | ADR-0001 | [标题] | TR-combat-001, TR-combat-002 | 高 |

---

<!-- 中文翻译 -->
## Superseded Requirements / 已取代的需求

<!-- Requirements that existed in a GDD when an ADR was written, but the GDD / 编写ADR时GDD中存在的要求，但GDD后来发生了变化。ADR可能需要更新。
     has since changed. The ADR may need updating. -->

| Req ID | GDD | Change | Affected ADR | Status | 需求ID | GDD | 变更 | 受影响的ADR | 状态 |
|--------|-----|--------|-------------|--------|------|-----|------|------------|------|
| TR-[id] | [file] | [what changed] | ADR-NNNN | 🔴 ADR needs update | TR-[id] | [文件] | [变更内容] | ADR-NNNN | 🔴 ADR需要更新 |

---

<!-- 中文翻译 -->
## How to Use This Document / 如何使用此文档

**When writing a new ADR**: Add it to the "ADR → GDD Coverage" table and mark / **编写新ADR时**：将其添加到"ADR → GDD覆盖"表中，并在矩阵中将其满足的需求标记为✅。
the requirements it satisfies as ✅ in the matrix.

**When approving a GDD change**: Scan the matrix for requirements from that GDD / **批准GDD变更时**：扫描矩阵中来自该GDD的需求，检查变更是否使任何现有ADR失效。如果是，则添加到"已取代的需求"。
and check whether the change invalidates any existing ADR. Add to "Superseded
Requirements" if so.

**When running `/architecture-review`**: The skill will update this document / **运行 `/architecture-review` 时**：该技能将自动使用当前状态更新此文档。
automatically with the current state.

**Gate check**: The Pre-Production gate requires this document to exist and to / **关卡检查**：预生产关卡要求此文档存在且基础层差距为零。
have zero Foundation Layer Gaps.
