# Difficulty Curve: [Game Title / 游戏标题]

> **Status / 状态**: Draft | In Review | Approved / 草稿 | 审核中 | 已批准
> **Author / 作者**: [game-designer / systems-designer / 游戏设计师 / 系统设计师]
> **Last Updated / 最后更新**: [Date / 日期]
> **Links To / 链接至**: `design/gdd/game-concept.md`
> **Relevant GDDs / 相关GDD**: [e.g., `design/gdd/combat.md`, `design/gdd/progression.md` / 例如，`design/gdd/combat.md`、`design/gdd/progression.md`]

---

## Difficulty Philosophy / 难度理念

[One paragraph establishing this game's relationship with difficulty. This is
not a mechanical description — it is a design value statement that all tuning
decisions must serve.
一段话建立这个游戏与难度的关系。这不是机制描述 — 它是所有调整决策必须服务的设计价值声明。

The four common difficulty philosophies are / 四种常见的难度理念：

1. **Masochistic challenge as the core fantasy / 受虐挑战作为核心幻想**: Difficulty is the product.
   Overcoming it is the emotional reward. Reducing difficulty removes the
   point. (Dark Souls, Celeste at max assist off / 难度就是产品。克服它是情感奖励。降低难度消除了意义。（黑暗之魂、关闭最大辅助的Celeste）
2. **Accessible entry, optional depth / 无障碍入口，可选深度**: The base experience is completable by
   most players; depth and challenge are opt-in for those who want them.
   (Hades, Hollow Knight with accessibility modes / 大多数玩家可以完成基础体验；深度和挑战是为想要它们的人可选的。（Hades、带无障碍模式的空洞骑士）
3. **Difficulty serves narrative pacing / 难度服务叙事节奏**: Challenge rises and falls to match
   story beats. The player must feel capable during story resolution and
   threatened during story crisis. (The Last of Us, God of War / 挑战起伏以匹配故事节拍。玩家在故事解决期间必须感到有能力，在故事危机期间感到受威胁。（最后生还者、战神）
4. **Relaxed engagement / 轻松参与**: Challenge is present but never the focus. Failure
   is gentle and infrequent. The experience prioritizes comfort and expression
   over obstacle. (Stardew Valley, Animal Crossing / 挑战存在但从不聚焦。失败温和且罕见。体验优先考虑舒适和表达而非障碍。（星露谷物语、动物森友会）

State the philosophy explicitly, then add one sentence on what the player is
permitted to feel: are they allowed to feel frustrated? For how long before the
design must intervene? What is the acceptable cost of failure?
明确说明理念，然后添加一句话说明允许玩家感受什么：他们被允许感到沮丧吗？在设计必须干预之前多长时间？什么是可接受的失败成本？]

---

## Difficulty Axes / 难度轴

> **Guidance / 指导**: Most games have multiple independent dimensions of challenge.
> Identifying them explicitly prevents the mistake of tuning only one axis
> (usually execution difficulty) while leaving others unexamined. A game can
> feel "easy" on execution but overwhelming on decision complexity — players
> experience this as confusing, not engaging.
> 大多数游戏有多个独立的挑战维度。明确识别它们可以防止只调整一个轴（通常是执行难度）而忽略其他轴的错误。游戏在执行上可能感觉"容易"，但在决策复杂性上令人不知所措 — 玩家体验为困惑，而不是参与。
>
> For each axis, answer: can the player control or reduce this axis through
> choices, builds, or settings? If not, it is a forced challenge dimension —
> be very intentional about how it is used.
> 对于每个轴，回答：玩家能否通过选择、构建或设置来控制或降低此轴？如果不能，它是一个强制挑战维度 — 对其使用要非常有意。

| Axis / 轴 | Description / 描述 | Primary Systems / 主要系统 | Player Control? / 玩家控制？ |
|------|-------------|----------------|-----------------|
| **Execution difficulty / 执行难度** | [The precision and timing demands of core actions. e.g., "Dodging enemy attacks requires correct timing within a 200ms window." / 核心动作的精确度和时机要求。例如，"躲避敌人攻击需要在200ms窗口内正确时机。"] | [e.g., Combat / 例如，战斗, movement / 移动] | [Yes — practice reduces this / 是 — 练习可降低 / No — fixed mechanical threshold / 否 — 固定机制阈值] |
| **Knowledge difficulty / 知识难度** | [The cost of not knowing information. e.g., "Enemy weaknesses are not telegraphed; players who have not discovered them take significantly more damage." / 不知道信息的代价。例如，"敌人弱点未预告；未发现它们的玩家受到显著更多伤害。"] | [e.g., Enemy design / 例如，敌人设计, UI, lore / 背景] | [Yes — through in-game discovery / 是 — 通过游戏内发现 / No — requires external knowledge / 否 — 需要外部知识] |
| **Resource pressure / 资源压力** | [How scarce are the resources needed to progress? e.g., "Health consumables are limited; efficient play is required to sustain long dungeon runs." / 进度所需资源有多稀缺？例如，"生命消耗品有限；需要高效游戏来维持长地下城运行。"] | [e.g., Economy / 例如，经济, loot / 战利品, crafting / 制作] | [Yes — through build optimization / 是 — 通过构建优化 / Partially / 部分] |
| **Time pressure / 时间压力** | [Does the player have time to think, or does the game demand rapid decisions? e.g., "Enemy spawn timers and attack windows require real-time response." / 玩家有时间思考，还是游戏要求快速决策？例如，"敌人生成计时器和攻击窗口需要实时响应。"] | [e.g., Combat pacing / 例如，战斗节奏, timers / 计时器] | [Yes — through difficulty settings / 是 — 通过难度设置 / No — core to genre / 否 — 类型核心] |
| **Decision complexity / 决策复杂性** | [How many meaningful choices must the player evaluate simultaneously? e.g., "Build decisions interact across 4 systems; suboptimal combinations create compounding disadvantage." / 玩家必须同时评估多少有意义的选项？例如，"构建决策在4个系统中交互；次优组合产生复合劣势。"] | [e.g., Progression / 例如，进度, inventory / 物品栏, skills / 技能] | [Yes — through UI and tutorialization / 是 — 通过UI和教程 / No — inherent to strategy depth / 否 — 策略深度固有] |
| **[Add axis / 添加轴]** | [Description / 描述] | [Systems / 系统] | [Player control / 玩家控制] |

---

## Difficulty Curve Overview / 难度曲线概述

> **Guidance / 指导**: This table describes the intended challenge arc across the whole
> game. Difficulty levels use a 1-10 scale where 1 = no meaningful challenge,
> 10 = maximum challenge the game can produce. The scale is relative to THIS game's
> design intent — a 6/10 in a soulslike is not the same as a 6/10 in a cozy sim.
> 此表描述整个游戏的预期挑战弧线。难度等级使用1-10等级，其中1 = 无有意义挑战，10 = 游戏可产生的最大挑战。等级是相对于THIS游戏的设计意图 — soulslike中的6/10与休闲模拟中的6/10不同。
>
> "Primary challenge type" refers to the difficulty axis (from the table above)
> that is doing the most work in this phase. New systems introduced should list
> only systems introduced for the FIRST TIME — the cognitive load of learning
> a new system is itself a form of difficulty.
> "主要挑战类型"指的是在此阶段做最多工作的难度轴（来自上表）。新引入的系统应仅列出首次引入的系统 — 学习新系统的认知负荷本身就是一种难度。
>
> "Target player state" is the emotional state the designer intends. If the actual
> playtested state diverges from the intended state, this column is what needs
> to be achieved.
> "目标玩家状态"是设计师意图的情感状态。如果实际测试状态与意图状态偏离，这一列就是需要实现的目标。

| Phase / 阶段 | Duration / 持续时间 | Difficulty Level (1-10) / 难度等级 | Primary Challenge Type / 主要挑战类型 | New Systems Introduced / 引入的新系统 | Target Player State / 目标玩家状态 |
|-------|----------|------------------------|----------------------|----------------------|---------------------|
| [Prologue / Tutorial / 序章/教程] | [e.g., 0-15 min / 例如，0-15分钟] | [2/10] | [Knowledge / 知识] | [Core movement / 核心移动, basic interaction / 基础交互] | [Safe, curious, building confidence / 安全、好奇、建立信心] |
| [Early game / 早期游戏] | [e.g., 15 min - 2 hrs / 例如，15分钟-2小时] | [3-5/10] | [Execution / 执行] | [Combat / 战斗, inventory / 物品栏, first upgrade path / 首次升级路径] | [Learning, occasional failure, clear cause-effect / 学习、偶尔失败、清晰因果] |
