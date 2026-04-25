---
name: balance-check
description: "Analyzes game balance data files, formulas, and configuration to identify outliers, broken progressions, degenerate strategies, and economy imbalances. Use after modifying any balance-related data or design. Use when user says 'balance report', 'check game balance', 'run a balance check'. / 分析游戏平衡数据文件、公式和配置，识别异常值、破坏性进度、退化策略和经济失衡。修改任何平衡相关数据或设计后使用。当用户说'平衡报告'、'检查游戏平衡'、'运行平衡检查'时使用。"
argument-hint: "[system-name|path-to-data-file]"
user-invocable: true
allowed-tools: Read, Glob, Grep
agent: economy-designer
---

## Phase 1: Identify Balance Domain / 第 1 阶段：确定平衡域


Determine the balance domain from `$ARGUMENTS[0]`:
> **中文翻译**：从“$ARGUMENTS[0]”确定余额域：


- **Combat** → weapon/ability DPS, time-to-kill, damage type interactions
  > **中文翻译**：**战斗** → 武器/能力 DPS、击杀时间、伤害类型交互
- **Economy** → resource faucets/sinks, acquisition rates, item pricing
  > **中文翻译**：**经济** → 资源水龙头/水槽、获取率、物品定价
- **Progression** → XP/power curves, dead zones, power spikes
  > **中文翻译**：**进展** → XP/功率曲线、死区、功率峰值
- **Loot** → rarity distribution, pity timers, inventory pressure
  > **中文翻译**：**战利品** → 稀有度分布、怜悯计时器、库存压力
- **File path given** → load that file directly and infer domain from content
  > **中文翻译**：**给定文件路径** → 直接加载该文件并从内容推断域


If no argument, ask the user which system to check.
> **中文翻译**：如果没有参数，询问用户要检查哪个系统。


---

## Phase 2: Read Data Files / 第 2 阶段：读取数据文件

Read relevant files from `assets/data/` and `design/balance/` for the identified domain.
> **中文翻译**：从 `assets/data/` 和 `design/balance/` 中读取已确定域的相关文件。

Note every file read — they will appear in the Data Sources section of the report.
> **中文翻译**：记录读取的每个文件 — 它们将出现在报告的数据来源部分。

---

## Phase 3: Read Design Document / 第 3 阶段：阅读设计文档


Read the GDD for the system from `design/gdd/` to understand intended design targets, tuning knobs, and expected value ranges. This is the baseline for "correct" behaviour.
> **中文翻译**：从“design/gdd/”中阅读系统的 GDD，以了解预期的设计目标、​​调整旋钮和预期值范围。这是“正确”行为的基线。


---

## Phase 4: Perform Analysis / 第 4 阶段：执行分析

Run domain-specific checks:
> **中文翻译**：运行特定领域的检查：

**Combat balance:** / **战斗平衡：**
- Calculate DPS for all weapons/abilities at each power tier / 计算每个战力等级所有武器/能力的 DPS
- Check time-to-kill at each tier / 检查每个等级的击杀时间
- Identify any options that dominate all others (strictly better) / 识别任何统治所有其他选项的选择（严格更优）
- Check if defensive options can create unkillable states / 检查防御选项是否能创造不可击杀状态
- Verify damage type/resistance interactions are balanced / 验证伤害类型/抗性交互是否平衡

**Economy balance:** / **经济平衡：**
- Map all resource faucets and sinks with flow rates / 映射所有资源产出与消耗及其流率
- Project resource accumulation over time / 预测资源随时间的积累
- Check for infinite resource loops / 检查无限资源循环
- Verify gold sinks scale with gold generation / 验证金币消耗与金币产出的缩放关系
- Check if any items are never worth purchasing / 检查是否有物品永远不值得购买

**Progression balance:** / **进度平衡：**
- Plot the XP curve and power curve / 绘制经验曲线和战力曲线
- Check for dead zones (no meaningful progression for too long) / 检查死区（太长时间无有意义的进度）
- Check for power spikes (sudden jumps in capability) / 检查战力峰值（能力的突然跳跃）
- Verify content gates align with expected player power / 验证内容门槛与预期玩家战力对齐
- Check if skip/grind strategies break intended pacing / 检查跳过/刷怪策略是否破坏预期节奏

**Loot balance:** / **战利品平衡：**
- Calculate expected time to acquire each rarity tier / 计算获取每个稀有度等级的预期时间
- Check pity timer math / 检查保底机制数学
- Verify no loot is strictly useless at any stage / 验证任何阶段没有完全无用的战利品
- Check inventory pressure vs acquisition rate / 检查库存压力与获取率

---

## Phase 5: Output the Analysis / 第 5 阶段：输出分析


```
## Balance Check: [System Name]

### Data Sources Analyzed
- [List of files read]

### Health Summary: [HEALTHY / CONCERNS / CRITICAL ISSUES]

### Outliers Detected
| Item/Value | Expected Range | Actual | Issue |
|-----------|---------------|--------|-------|

### Degenerate Strategies Found
- [Strategy description and why it is problematic]

### Progression Analysis
[Graph description or table showing progression curve health]

### Recommendations
| Priority | Issue | Suggested Fix | Impact |
|----------|-------|--------------|--------|

### Values That Need Attention
[Specific values with suggested adjustments and rationale]
```

---

## Phase 6: Fix & Verify Cycle / 第 6 阶段：修复与验证循环

After presenting the report, ask:
> **中文翻译**：展示报告后，询问：

> "Would you like to fix any of these balance issues now?"
> **中文翻译**："您想现在修复这些平衡问题吗？"

If yes: / 如果是：
- Ask which issue to address first (refer to the Recommendations table by priority row) / 询问首先解决哪个问题（按优先级行参考建议表）
- Guide the user to update the relevant data file in `assets/data/` or formula in `design/balance/` / 指导用户更新 `assets/data/` 中的相关数据文件或 `design/balance/` 中的公式
- After each fix, offer to re-run the relevant balance checks to verify no new outliers were introduced / 每次修复后，提议重新运行相关平衡检查以验证没有引入新的异常值
- If the fix changes a tuning knob defined in a GDD or referenced by an ADR, remind the user: / 如果修复更改了 GDD 中定义或 ADR 引用的调整旋钮，提醒用户：
  > "This value is defined in a design document. Run `/propagate-design-change [path]` on the affected GDD to find downstream impacts before committing."
  > **中文翻译**："此值在设计文档中定义。在提交之前，对受影响的 GDD 运行 `/propagate-design-change [path]` 以查找下游影响。"

If no: / 如果否：
- Summarize open issues and suggest saving the report to `design/balance/balance-check-[system]-[date].md` for later / 总结未解决的问题，建议将报告保存到 `design/balance/balance-check-[system]-[date].md` 以备后用

End with: / 结尾：
> "Re-run `/balance-check` after fixes to verify."
> **中文翻译**："修复后重新运行 `/balance-check` 以验证。"
