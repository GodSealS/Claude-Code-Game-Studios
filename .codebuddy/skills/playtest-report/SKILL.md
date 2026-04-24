---
name: playtest-report
description: "Generates a structured playtest report template or analyzes existing playtest notes into a structured format. Use this to standardize playtest feedback collection and analysis. / 生成结构化试玩报告模板或分析现有试玩笔记为结构化格式。用于标准化试玩反馈收集和分析。"
argument-hint: "[new|analyze path-to-notes] [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Task, AskUserQuestion
---

## Phase 1: Parse Arguments / 阶段 1：解析参数

Resolve the review mode (once, store for all gate spawns this run):
> **中文翻译**：解析审查模式（一次解析，本次运行所有门控生成均使用）：

1. If `--review [full|lean|solo]` was passed → use that
2. Else read `production/review-mode.txt` → use that value
3. Else → default to `lean`

> **中文翻译**：
> 1. 如果传入了 `--review [full|lean|solo]` → 使用该值
> 2. 否则读取 `production/review-mode.txt` → 使用该值
> 3. 否则 → 默认为 `lean`

See `.codebuddy/docs/director-gates.md` for the full check pattern.
> **中文翻译**：完整检查模式参见 `.codebuddy/docs/director-gates.md`。

Determine the mode:
> **中文翻译**：确定模式：

- `new` → generate a blank playtest report template / 生成空白试玩报告模板
- `analyze [path]` → read raw notes and fill in the template with structured findings / 读取原始笔记并用结构化发现填充模板

---

## Phase 2A: New Template Mode / 阶段 2A：新建模板模式

Generate this template and output it to the user:
> **中文翻译**：生成此模板并输出给用户：

```markdown
# Playtest Report

## Session Info
- **Date**: [Date]
- **Build**: [Version/Commit]
- **Duration**: [Time played]
- **Tester**: [Name/ID]
- **Platform**: [PC/Console/Mobile]
- **Input Method**: [KB+M / Gamepad / Touch]
- **Session Type**: [First time / Returning / Targeted test]

## Test Focus
[What specific features or flows were being tested]

## First Impressions (First 5 minutes)
- **Understood the goal?** [Yes/No/Partially]
- **Understood the controls?** [Yes/No/Partially]
- **Emotional response**: [Engaged/Confused/Bored/Frustrated/Excited]
- **Notes**: [Observations]

## Gameplay Flow
### What worked well
- [Observation 1]

### Pain points
- [Issue 1 -- Severity: High/Medium/Low]

### Confusion points
- [Where the player was confused and why]

### Moments of delight
- [What surprised or pleased the player]

## Bugs Encountered
| # | Description | Severity | Reproducible |
|---|-------------|----------|-------------|

## Feature-Specific Feedback
### [Feature 1]
- **Understood purpose?** [Yes/No]
- **Found engaging?** [Yes/No]
- **Suggestions**: [Tester suggestions]

## Quantitative Data (if available)
- **Deaths**: [Count and locations]
- **Time per area**: [Breakdown]
- **Items used**: [What and when]
- **Features discovered vs missed**: [List]

## Overall Assessment
- **Would play again?** [Yes/No/Maybe]
- **Difficulty**: [Too Easy / Just Right / Too Hard]
- **Pacing**: [Too Slow / Good / Too Fast]
- **Session length preference**: [Shorter / Good / Longer]

## Top 3 Priorities from this session
1. [Most important finding]
2. [Second priority]
3. [Third priority]
```

---

## Phase 2B: Analyze Mode / 阶段 2B：分析模式

Read the raw notes at the provided path. Cross-reference with existing design documents. Fill in the template above with structured findings. Flag any playtest observations that conflict with design intent.
> **中文翻译**：读取提供路径的原始笔记。与现有设计文档进行交叉引用。用结构化发现填充上述模板。标记任何与设计意图冲突的试玩观察结果。

---

## Phase 3: Action Routing / 阶段 3：行动路由

Categorize all findings into four buckets:
> **中文翻译**：将所有发现分类到四个桶中：

- **Design changes needed** — fun issues, player confusion, broken mechanics, observations that conflict with the GDD's intended experience / **需要设计变更** — 趣味性问题、玩家困惑、破损机制、与 GDD 预期体验冲突的观察
- **Balance adjustments** — numbers feel wrong, difficulty too spiked or too flat / **平衡调整** — 数值感觉不对、难度过高或过于平坦
- **Bug reports** — clear implementation defects that are reproducible / **缺陷报告** — 可复现的明确实现缺陷
- **Polish items** — not blocking progress, but friction or feel issues for later / **打磨项** — 不阻碍进度，但存在摩擦或手感问题，留待后续处理

Present the categorized list, then route:
> **中文翻译**：展示分类列表，然后路由：

- **Design changes:** "Run `/propagate-design-change [path]` on the affected design document to find downstream impacts before making changes." / **设计变更**："在受影响的设计文档上运行 `/propagate-design-change [path]`，在进行变更前查找下游影响。"
- **Balance adjustments:** "Run `/balance-check [system]` to verify the full balance picture before tuning values." / **平衡调整**："运行 `/balance-check [system]` 在调整数值前验证完整的平衡图景。"
- **Bugs:** "Use `/bug-report` to formally track these." / **缺陷**："使用 `/bug-report` 正式跟踪这些问题。"
- **Polish items:** "Add to the polish backlog in `production/` when the team reaches that phase." / **打磨项**："当团队进入该阶段时，添加到 `production/` 中的打磨待办列表。"

---

## Phase 3b: Creative Director Player Experience Review / 阶段 3b：创意总监玩家体验审查

**Review mode check** — apply before spawning CD-PLAYTEST:
> **中文翻译**：**审查模式检查** — 在生成 CD-PLAYTEST 之前应用：

- `solo` → skip. Note: "CD-PLAYTEST skipped — Solo mode." Proceed to Phase 4 (save the report). / `solo` → 跳过。备注："CD-PLAYTEST 已跳过 — Solo 模式。" 进入阶段 4（保存报告）。
- `lean` → skip (not a PHASE-GATE). Note: "CD-PLAYTEST skipped — Lean mode." Proceed to Phase 4 (save the report). / `lean` → 跳过（非阶段门控）。备注："CD-PLAYTEST 已跳过 — Lean 模式。" 进入阶段 4（保存报告）。
- `full` → spawn as normal. / `full` → 正常生成。

After categorising findings, spawn `creative-director` via Task using gate **CD-PLAYTEST** (`.codebuddy/docs/director-gates.md`).
> **中文翻译**：分类发现后，通过 Task 使用门控 **CD-PLAYTEST** 生成 `creative-director`（`.codebuddy/docs/director-gates.md`）。

Pass: the structured report content, game pillars and core fantasy (from `design/gdd/game-concept.md`), the specific hypothesis being tested.
> **中文翻译**：传递：结构化报告内容、游戏支柱和核心幻想（来自 `design/gdd/game-concept.md`）、正在测试的具体假设。

Present the creative director's assessment before saving the report. If CONCERNS or REJECT, add a `## Creative Director Assessment` section to the report capturing the verdict and feedback. If APPROVE, note the approval in the report.
> **中文翻译**：在保存报告前展示创意总监的评估。如果是 CONCERNS 或 REJECT，在报告中添加 `## Creative Director Assessment` 部分记录裁决和反馈。如果是 APPROVE，在报告中注明批准。

---

## Phase 4: Save Report / 阶段 4：保存报告

Ask: "May I write this playtest report to `production/qa/playtests/playtest-[date]-[tester].md`?"
> **中文翻译**：询问："我可以将此试玩报告写入 `production/qa/playtests/playtest-[date]-[tester].md` 吗？"

If yes, write the file, creating the directory if needed.
> **中文翻译**：如果是，写入文件，如需要则创建目录。

---

## Phase 5: Next Steps / 阶段 5：下一步

Verdict: **COMPLETE** — playtest report generated.
> **中文翻译**：裁决：**完成** — 试玩报告已生成。

- Act on the highest-priority finding category first. / 首先处理最高优先级的发现类别。
- After addressing design changes: re-run `/design-review` on the updated GDD. / 处理设计变更后：在更新的 GDD 上重新运行 `/design-review`。
- After fixing bugs: re-run `/bug-triage` to update priorities. / 修复缺陷后：重新运行 `/bug-triage` 更新优先级。
