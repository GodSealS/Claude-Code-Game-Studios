# Economy Model: [System Name / 系统名称]

*Created / 创建: [Date / 日期]*
*Owner / 负责人: economy-designer*
*Status / 状态: [Draft / Balanced / Live / 草稿 / 已平衡 / 已上线]*

---

## Overview / 概述

[What resources, currencies, and exchange systems does this economy cover?
What player behaviors does it incentivize?
此经济涵盖什么资源、货币和交换系统？它激励什么玩家行为？]

---

## Currencies / 货币

| Currency / 货币 | Type / 类型 | Earn Rate / 获取速率 | Sink Rate / 消耗速率 | Cap / 上限 | Notes / 备注 |
| ---- | ---- | ---- | ---- | ---- | ---- |
| [Gold / 金币] | Soft / 软 | [per hour / 每小时] | [per hour / 每小时] | [max or none / 最大或无] | [Primary transaction currency / 主要交易货币] |
| [Gems / 宝石] | Premium / 高级 | [per day F2P / 免费玩家每日] | [varies / 变化] | [max / 最大] | [Premium currency, purchasable / 高级货币，可购买] |
| [XP / 经验] | Progression / 进度 | [per action / 每次动作] | [level-up cost / 升级成本] | [none / 无] | [Cannot be traded / 不可交易] |

### Currency Rules / 货币规则
- [Rule 1 — e.g., "Soft currency has no cap but inflation is controlled via sinks" / 规则1 — 例如，"软货币没有上限但通胀通过消耗点控制"]
- [Rule 2 — e.g., "Premium currency cannot be converted back to real money" / 规则2 — 例如，"高级货币不能兑换回真实货币"]
- [Rule 3 / 规则3]

---

## Sources (Faucets) / 来源（水龙头）

| Source / 来源 | Currency / 货币 | Amount / 数量 | Frequency / 频率 | Conditions / 条件 |
| ---- | ---- | ---- | ---- | ---- |
| [Quest completion / 任务完成] | Gold / 金币 | [50-200] | [per quest / 每任务] | [Scales with quest difficulty / 随任务难度缩放] |
| [Enemy drops / 敌人掉落] | Gold / 金币 | [1-10] | [per kill / 每击杀] | [Modified by luck stat / 受幸运属性修改] |
| [Daily login / 每日登录] | Gems / 宝石 | [5] | [daily / 每日] | [Streak bonus: +1 per consecutive day / 连续奖励：连续每天+1] |
| [Achievement / 成就] | XP / 经验 | [100-500] | [one-time / 一次性] | [Per achievement tier / 每成就等级] |

---

## Sinks (Drains) / 消耗点（排水口）

| Sink / 消耗点 | Currency / 货币 | Cost / 成本 | Frequency / 频率 | Purpose / 用途 |
| ---- | ---- | ---- | ---- | ---- |
| [Equipment purchase / 装备购买] | Gold / 金币 | [100-5000] | [as needed / 按需] | [Power progression / 力量进度] |
| [Repair costs / 修理成本] | Gold / 金币 | [10-100] | [per death / 每次死亡] | [Death penalty, gold drain / 死亡惩罚，金币消耗] |
| [Cosmetic shop / 外观商店] | Gems / 宝石 | [50-500] | [optional / 可选] | [Vanity, premium sink / 虚荣，高级消耗] |
| [Respec / 洗点] | Gold / 金币 | [1000] | [rare / 稀有] | [Build experimentation tax / 构建实验税] |

---

## Balance Targets / 平衡目标

| Metric / 指标 | Target / 目标 | Rationale / 理由 |
| ---- | ---- | ---- |
| Time to first meaningful purchase / 首次有意义购买时间 | [X minutes / X分钟] | [Player should feel spending power early / 玩家应该早期感受到消费能力] |
| Hourly gold earn rate (mid-game) / 每小时金币获取速率（中局） | [X gold/hr / X金币/小时] | [Based on session length and purchase cadence / 基于会话长度和购买节奏] |
| Days to max level (F2P) / 达到最大等级天数（免费） | [X days / X天] | [Enough to retain, not so long it frustrates / 足以留存，不会长到令人沮丧] |
| Sink-to-source ratio / 消耗-来源比率 | [0.7-0.9] | [Slight surplus keeps players feeling wealthy / 轻微盈余让玩家感觉富有] |
| Premium currency F2P earn rate / 免费玩家高级货币获取速率 | [X/week / X/周] | [Enough to buy something monthly, not everything / 足以每月购买某物，不是所有东西] |

---

## Progression Curves / 进度曲线

### Level XP Requirements / 等级经验需求
| Level / 等级 | XP Required / 所需经验 | Cumulative XP / 累积经验 | Estimated Time / 估计时间 |
| ---- | ---- | ---- | ---- |
| 1→2 | [100] | [100] | [10 min / 10分钟] |
| 5→6 | [500] | [1,500] | [2 hrs / 2小时] |
| 10→11 | [1,500] | [7,500] | [8 hrs / 8小时] |
| 20→21 | [5,000] | [50,000] | [40 hrs / 40小时] |

*Formula / 公式*: `XP(n) = [formula, e.g., 100 * n^1.5 / 公式，例如，100 * n^1.5]`

### Item Price Scaling / 物品价格缩放
*Formula / 公式*: `Price(tier) = [formula, e.g., base_price * 2^(tier-1) / 公式，例如，base_price * 2^(tier-1)]`

---

## Loot Tables / 战利品表

### [Drop Source Name / 掉落来源名称]
| Item / 物品 | Rarity / 稀有度 | Drop Rate / 掉落率 | Pity Timer / 保底计时器 | Notes / 备注 |
| ---- | ---- | ---- | ---- | ---- |
| [Common item / 普通物品] | Common / 普通 | [60%] | [N/A] | [Always useful, never feels bad / 总是有用，从不感觉糟糕] |
| [Uncommon item / 精良物品] | Uncommon / 精良 | [25%] | [N/A] | [Noticeable upgrade / 明显升级] |
| [Rare item / 稀有物品] | Rare / 稀有 | [12%] | [10 drops / 10次掉落] | [Exciting, build-defining / 令人兴奋，定义构建] |
| [Legendary item / 传说物品] | Legendary / 传说 | [3%] | [30 drops / 30次掉落] | [Game-changing, celebration moment / 改变游戏，庆祝时刻] |

### Pity System / 保底系统
[Describe how the pity system works to prevent extreme bad luck streaks.
描述保底系统如何工作以防止极端坏运气连击。]

---

## Economy Health Metrics / 经济健康指标

| Metric / 指标 | Healthy Range / 健康范围 | Warning Threshold / 警告阈值 | Action if Breached /  breached时的行动 |
| ---- | ---- | ---- | ---- |
