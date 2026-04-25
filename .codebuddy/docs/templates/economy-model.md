# Economy Model: [System Name] / 经济模型：[系统名称]

*Created: [Date] / 创建日期：[日期]*
*Owner: economy-designer / 负责人：economy-designer*
*Status: [Draft / Balanced / Live] / 状态：[草稿 / 平衡 / 已上线]*

---

## Overview / 概述

[What resources, currencies, and exchange systems does this economy cover?
What player behaviors does it incentivize? / 此经济模型涵盖哪些资源、货币和交换系统？它激励哪些玩家行为？]

---

## Currencies / 货币

| Currency / 货币 | Type / 类型 | Earn Rate / 获得率 | Sink Rate / 消耗率 | Cap / 上限 | Notes / 备注 |
| ---- | ---- | ---- | ---- | ---- | ---- |
| [Gold / 金币] | Soft / 软货币 | [per hour / 每小时] | [per hour / 每小时] | [max or none / 最大值或无限制] | [Primary transaction currency / 主要交易货币] |
| [Gems / 宝石] | Premium / 高级货币 | [per day F2P / F2P每日] | [varies / 可变] | [max / 最大值] | [Premium currency, purchasable / 高级货币，可购买] |
| [XP / 经验值] | Progression / 进度货币 | [per action / 每次行动] | [level-up cost / 升级成本] | [none / 无限制] | [Cannot be traded / 无法交易] |

### Currency Rules / 货币规则
- [Rule 1 — e.g., "Soft currency has no cap but inflation is controlled via sinks" / 规则1 — 例如："软货币无上限，但通过消耗控制通货膨胀"]
- [Rule 2 — e.g., "Premium currency cannot be converted back to real money" / 规则2 — 例如："高级货币无法转换回真实货币"]
- [Rule 3 / 规则3]

---

## Sources (Faucets) / 来源（源头）

| Source / 来源 | Currency / 货币 | Amount / 数量 | Frequency / 频率 | Conditions / 条件 |
| ---- | ---- | ---- | ---- | ---- |
| [Quest completion / 任务完成] | Gold / 金币 | [50-200] | [per quest / 每次任务] | [Scales with quest difficulty / 随任务难度缩放] |
| [Enemy drops / 敌人掉落] | Gold / 金币 | [1-10] | [per kill / 每次击杀] | [Modified by luck stat / 受幸运属性影响] |
| [Daily login / 每日登录] | Gems / 宝石 | [5] | [daily / 每日] | [Streak bonus: +1 per consecutive day / 连续登录奖励：每天+1] |
| [Achievement / 成就] | XP / 经验值 | [100-500] | [one-time / 一次性] | [Per achievement tier / 按成就等级] |

---

## Sinks (Drains) / 消耗（汇流）

| Sink / 消耗 | Currency / 货币 | Cost / 成本 | Frequency / 频率 | Purpose / 目的 |
| ---- | ---- | ---- | ---- | ---- |
| [Equipment purchase / 装备购买] | Gold / 金币 | [100-5000] | [as needed / 按需] | [Power progression / 实力进度] |
| [Repair costs / 修复成本] | Gold / 金币 | [10-100] | [per death / 每次死亡] | [Death penalty, gold drain / 死亡惩罚，金币消耗] |
| [Cosmetic shop / 装饰品商店] | Gems / 宝石 | [50-500] | [optional / 可选] | [Vanity, premium sink / 虚荣，高级消耗] |
| [Respec / 重置技能] | Gold / 金币 | [1000] | [rare / 罕见] | [Build experimentation tax / 构建实验税] |

---

## Balance Targets / 平衡目标

| Metric / 指标 | Target / 目标 | Rationale / 原理 |
| ---- | ---- | ---- |
| Time to first meaningful purchase / 首次有意义购买的时间 | [X minutes / X分钟] | [Player should feel spending power early / 玩家应早期感受到消费能力] |
| Hourly gold earn rate (mid-game) / 每小时金币获得率（中期游戏） | [X gold/hr / X金币/小时] | [Based on session length and purchase cadence / 基于会话时长和购买节奏] |
| Days to max level (F2P) / 达到最高等级的天数（F2P） | [X days / X天] | [Enough to retain, not so long it frustrates / 足以留存，不会过长以致沮丧] |
| Sink-to-source ratio / 消耗与来源比率 | [0.7-0.9] | [Slight surplus keeps players feeling wealthy / 轻微盈余让玩家感觉富有] |
| Premium currency F2P earn rate / 高级货币F2P获得率 | [X/week / X/周] | [Enough to buy something monthly, not everything / 足以每月购买某些物品，但不是全部] |

---

## Progression Curves / 进度曲线

### Level XP Requirements / 等级经验值需求
| Level / 等级 | XP Required / 所需经验值 | Cumulative XP / 累计经验值 | Estimated Time / 预计时间 |
| ---- | ---- | ---- | ---- |
| 1→2 | [100] | [100] | [10 min / 10分钟] |
| 5→6 | [500] | [1,500] | [2 hrs / 2小时] |
| 10→11 | [1,500] | [7,500] | [8 hrs / 8小时] |
| 20→21 | [5,000] | [50,000] | [40 hrs / 40小时] |

*Formula*: `XP(n) = [formula, e.g., 100 * n^1.5] / 公式：XP(n) = [公式，例如：100 * n^1.5]`

### Item Price Scaling / 物品价格缩放
*Formula*: `Price(tier) = [formula, e.g., base_price * 2^(tier-1)] / 公式：价格(等级) = [公式，例如：基础价格 * 2^(等级-1)]`

---

## Loot Tables / 掉落表

### [Drop Source Name] / [掉落源名称]
| Item / 物品 | Rarity / 稀有度 | Drop Rate / 掉落率 | Pity Timer / 保底计时器 | Notes / 备注 |
| ---- | ---- | ---- | ---- | ---- |
| [Common item / 普通物品] | Common / 普通 | [60%] | [N/A] | [Always useful, never feels bad / 总是有用，从不感觉差] |
| [Uncommon item / 罕见物品] | Uncommon / 罕见 | [25%] | [N/A] | [Noticeable upgrade / 明显升级] |
| [Rare item / 稀有物品] | Rare / 稀有 | [12%] | [10 drops / 10次掉落] | [Exciting, build-defining / 令人兴奋，构建定义] |
| [Legendary item / 传说物品] | Legendary / 传说 | [3%] | [30 drops / 30次掉落] | [Game-changing, celebration moment / 改变游戏，庆祝时刻] |

### Pity System / 保底系统
[Describe how the pity system works to prevent extreme bad luck streaks. / 描述保底系统如何工作以防止极端厄运连击。]

---

## Economy Health Metrics / 经济健康指标

| Metric / 指标 | Healthy Range / 健康范围 | Warning Threshold / 警告阈值 | Action if Breached / 超出时采取的措施 |
| ---- | ---- | ---- | ---- |
| Average player gold / 玩家平均金币 | [X-Y at level Z / 在等级Z时X-Y] | [>Y or <X / >Y或<X] | [Adjust faucets/sinks / 调整来源/消耗] |
| Gold Gini coefficient / 金币基尼系数 | [<0.4] | [>0.5] | [Wealth too concentrated / 财富过于集中] |
| % players hitting currency cap / 达到货币上限的玩家百分比 | [<5%] | [>10%] | [Raise cap or add sinks / 提高上限或增加消耗] |
| Premium conversion rate / 高级货币转化率 | [2-5%] | [<1% or >10% / <1%或>10%] | [Rebalance F2P earn rate / 重新平衡F2P获得率] |
| Average time between purchases / 购买间平均时间 | [X minutes / X分钟] | [>Y minutes / >Y分钟] | [Nothing worth buying / 没有值得购买的东西] |

---

## Ethical Guardrails / 道德护栏

- [No pay-to-win: premium currency cannot buy gameplay power advantages / 无付费赢：高级货币无法购买游戏实力优势]
- [Pity timers on all random drops: guaranteed outcome within X attempts / 所有随机掉落的保底计时器：X次尝试内保证结果]
- [Transparent drop rates displayed to players / 向玩家显示透明的掉落率]
- [Spending limits for minor accounts / 未成年人账户消费限制]
- [No artificial scarcity pressure (FOMO timers) on essential items / 对必要物品无人为稀缺压力（FOMO计时器）]

---

## Simulation Results / 模拟结果

[Include results from economy simulations if available: player wealth
distribution over time, sink effectiveness, inflation rate, etc. / 如果可用，包含经济模拟结果：玩家财富随时间分布、消耗效率、通货膨胀率等。]

---

## Dependencies / 依赖关系

- Depends on: [combat balance, quest design, crafting system / 依赖于：战斗平衡、任务设计、制作系统]
- Affects: [difficulty curve, player retention, monetization / 影响：难度曲线、玩家留存、变现]
- Must coordinate with: `game-designer`, `live-ops-designer`, `analytics-engineer` / 必须协调：`game-designer`, `live-ops-designer`, `analytics-engineer`