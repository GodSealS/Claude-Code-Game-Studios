---
name: scope-check
description: "Analyze a feature or sprint for scope creep by comparing current scope against the original plan. Flags additions, quantifies bloat, and recommends cuts. Use when user says 'any scope creep', 'scope review', 'are we staying in scope'. / 通过比较当前范围与原始计划来分析功能或冲刺的范围蔓延。标记新增内容，量化膨胀，并建议削减。当用户说'有范围蔓延吗'、'范围审查'、'我们在范围内吗'时使用。"
argument-hint: "[feature-name or sprint-N]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash
model: haiku
---

# Scope Check / 范围检查

<!-- 此技能是只读的 -->
This skill is read-only — it reports findings but writes no files.

<!-- 比较原始计划与当前状态 -->
Compares original planned scope against current state to detect, quantify, and triage
scope creep.

> **中文翻译**：此技能是只读的——它报告发现但不写入文件。比较原始计划范围与当前状态，以检测、量化和分类范围蔓延。

**Argument:** `$ARGUMENTS[0]` — feature name, sprint number, or milestone name. / **参数：** `$ARGUMENTS[0]` — 功能名称、冲刺编号或里程碑名称。

---

## Phase 1: Find the Original Plan / 第 1 阶段：查找原始计划

Locate the baseline scope document for the given argument: / 为给定参数定位基准范围文档：

- **Feature name** → read `design/gdd/[feature].md` or matching file in `design/` / **功能名称** → 读取 `design/gdd/[feature].md` 或 `design/` 中的匹配文件
- **Sprint number** (e.g., `sprint-3`) → read `production/sprints/sprint-03.md` or similar / **冲刺编号**（如 `sprint-3`）→ 读取 `production/sprints/sprint-03.md` 或类似文件
- **Milestone** → read `production/milestones/[name].md` / **里程碑** → 读取 `production/milestones/[name].md`

If the document is not found, report the missing file and stop. Do not proceed without
a baseline to compare against.

> **中文翻译**：如果文档未找到，报告缺失的文件并停止。没有基准比较对象不要继续。

---

## Phase 2: Read the Current State / 第 2 阶段：读取当前状态

Check what has actually been implemented or is in progress: / 检查实际已实现或正在进行的内容：

- Scan the codebase for files related to the feature/sprint / 扫描代码库中与功能/冲刺相关的文件
- Read git log for commits related to this work (`git log --oneline --since=[start-date]`) / 读取与此工作相关的 git 日志
- Check for TODO/FIXME comments that indicate unfinished scope additions / 检查指示未完成范围添加的 TODO/FIXME 注释
- Check active sprint plan if the feature is mid-sprint / 如果功能在冲刺中，检查活跃冲刺计划

---

## Phase 3: Compare Original vs Current Scope / 第 3 阶段：比较原始范围与当前范围

Produce the comparison report:

```markdown
## Scope Check: [Feature/Sprint Name]
Generated: [Date]

### Original Scope / 原始范围
[List of items from the original plan]

### Current Scope / 当前范围
[List of items currently implemented or in progress]

### Scope Additions (not in original plan) / 范围新增（不在原始计划中）
| Addition | Source | When | Justified? | Effort |
|----------|--------|------|------------|--------|
| / 新增项 | 来源 | 时间 | 是否合理？ | 工作量 |
| [item] | [commit/person] | [date] | [Yes/No/Unclear] | [S/M/L] |

### Scope Removals (in original but dropped) / 范围移除（在原始计划中但已删除）
| Removed Item | Reason | Impact |
|-------------|--------|--------|
| / 移除项 | 原因 | 影响 |
| [item] | [why removed] | [what's affected] |

### Bloat Score / 膨胀评分
- Original items: [N]
- Current items: [N]
- Items added: [N] (+[X]%)
- Items removed: [N]
- Net scope change: [+/-N] ([X]%)

### Risk Assessment / 风险评估
- **Schedule Risk**: [Low/Medium/High] — [explanation]
- **Quality Risk**: [Low/Medium/High] — [explanation]
- **Integration Risk**: [Low/Medium/High] — [explanation]

### Recommendations / 建议
1. **Cut**: [Items that should be removed to stay on schedule] / **削减**：为保持进度应移除的项目
2. **Defer**: [Items that can move to a future sprint/version] / **推迟**：可移至未来冲刺/版本的项目
3. **Keep**: [Additions that are genuinely necessary] / **保留**：确实必要的新增项
4. **Flag**: [Items that need a decision from producer/creative-director] / **标记**：需要制作人/创意总监决策的项目
```

---

## Phase 4: Verdict / 第 4 阶段：裁决

Assign a canonical verdict based on net scope change: / 根据净范围变化分配标准裁决：

| Net Change | Verdict | Meaning |
|-----------|---------|---------|
| / 净变化 | 裁决 | 含义 |
| ≤10% | **PASS** | On Track — within acceptable variance |
| 10–25% | **CONCERNS** | Minor Creep — manageable with targeted cuts |
| 25–50% | **FAIL** | Significant Creep — must cut or formally extend timeline |
| >50% | **FAIL** | Out of Control — stop, re-plan, escalate to producer |

Output the verdict prominently:

```
**Scope Verdict: [PASS / CONCERNS / FAIL]**
Net change: [+X%] — [On Track / Minor Creep / Significant Creep / Out of Control]
```

---

## Phase 5: Next Steps / 第 5 阶段：下一步

After presenting the report, offer concrete follow-up: / 呈现报告后，提供具体后续行动：

- **PASS** → no action required. Suggest re-running before next milestone. / **通过** → 无需行动。建议在下一个里程碑前重新运行。
- **CONCERNS** → offer to identify the 2–3 additions with best cut ratio. Reference `/sprint-plan update` to formally re-scope. / **关注** → 提议识别2-3个最佳削减比的新增项。参考 `/sprint-plan update` 进行正式重新范围界定。
- **FAIL** → recommend escalating to producer. Reference `/sprint-plan update` for re-planning or `/estimate` to re-baseline timeline. / **失败** → 建议升级给制作人。参考 `/sprint-plan update` 重新规划或 `/estimate` 重新设定时间线基线。

Always end with: / 始终以以下内容结束：
> "Run `/scope-check [name]` again after cuts are made to verify the verdict improves."

---

### Rules / 规则

- Scope creep is additions without corresponding cuts or timeline extensions / 范围蔓延是缺少相应削减或时间线延长的新增项
- Not all additions are bad — some are discovered requirements. But they must be acknowledged and accounted for / 并非所有新增都不好——有些是发现的需求。但必须被承认和考虑
- When recommending cuts, prioritize preserving the core player experience over nice-to-haves / 在建议削减时，优先保留核心玩家体验而非锦上添花的功能
- Always quantify scope changes — "it feels bigger" is not actionable, "+35% items" is / 始终量化范围变化——"感觉变大了"不可操作，"+35%项目"才是
