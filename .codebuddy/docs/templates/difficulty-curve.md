# Difficulty Curve: [Game Title] / 难度曲线：[游戏名称]

> **Status**: Draft | In Review | Approved / 状态：草稿 | 审核中 | 已批准
> **Author**: [game-designer / systems-designer] / 作者：[game-designer / systems-designer]
> **Last Updated**: [Date] / 最后更新：[日期]
> **Links To**: `design/gdd/game-concept.md` / 链接至：`design/gdd/game-concept.md`
> **Relevant GDDs**: [e.g., `design/gdd/combat.md`, `design/gdd/progression.md`] / 相关GDD：[例如：`design/gdd/combat.md`, `design/gdd/progression.md`]

---

## Difficulty Philosophy / 难度哲学

[One paragraph establishing this game's relationship with difficulty. This is
not a mechanical description — it is a design value statement that all tuning
decisions must serve. / 一段确立游戏与难度关系的文字。这不是机械描述——这是所有调优决策必须遵循的设计价值观陈述。

The four common difficulty philosophies are: / 四种常见的难度哲学是：

1. **Masochistic challenge as the core fantasy**: Difficulty is the product.
   Overcoming it is the emotional reward. Reducing difficulty removes the
   point. (Dark Souls, Celeste at max assist off) / **受虐挑战作为核心幻想**：难度是产品。克服难度是情感奖励。降低难度就失去了意义。（黑魂，Celeste关闭最大辅助）
2. **Accessible entry, optional depth**: The base experience is completable by
   most players; depth and challenge are opt-in for those who want them.
   (Hades, Hollow Knight with accessibility modes) / **可访问的入口，可选的深度**：基础体验对大多数玩家是可完成的；深度和挑战是为那些想要的人提供的选项。（Hades，带无障碍模式的Hollow Knight）
3. **Difficulty serves narrative pacing**: Challenge rises and falls to match
   story beats. The player must feel capable during story resolution and
   threatened during story crisis. (The Last of Us, God of War) / **难度服务于叙事节奏**：挑战根据故事节拍起伏。玩家在故事解决时应有能力感，在故事危机时应有威胁感。（最后生还者，战神）
4. **Relaxed engagement**: Challenge is present but never the focus. Failure
   is gentle and infrequent. The experience prioritizes comfort and expression
   over obstacle. (Stardew Valley, Animal Crossing) / **放松的参与**：挑战存在但从不成为焦点。失败是温和且不频繁的。体验优先考虑舒适度和表达而非障碍。（星露谷物语，动物森友会）

State the philosophy explicitly, then add one sentence on what the player is
permitted to feel: are they allowed to feel frustrated? For how long before the
design must intervene? What is the acceptable cost of failure? / 明确陈述哲学，然后添加一句关于玩家允许感受的内容：他们是否允许感到沮丧？在设计必须干预前可持续多久？可接受的失败成本是多少？]

---

## Difficulty Axes / 难度维度

> **Guidance**: Most games have multiple independent dimensions of challenge.
> Identifying them explicitly prevents the mistake of tuning only one axis
> (usually execution difficulty) while leaving others unexamined. A game can
> feel "easy" on execution but overwhelming on decision complexity — players
> experience this as confusing, not engaging. / **指导**：大多数游戏有多个独立的挑战维度。明确识别它们可以防止仅调整一个维度（通常是执行难度）而忽略其他维度的错误。游戏在执行上可能感觉"简单"，但在决策复杂性上可能压倒性——玩家会感到困惑而非投入。
>
> For each axis, answer: can the player control or reduce this axis through
> choices, builds, or settings? If not, it is a forced challenge dimension —
> be very intentional about how it is used. / 对于每个维度，回答：玩家是否可以通过选择、构建或设置来控制或减少此维度？如果不能，这是强制挑战维度——对其使用方式要非常谨慎。

| Axis / 维度 | Description / 描述 | Primary Systems / 主要系统 | Player Control? / 玩家控制？ |
|------|-------------|----------------|-----------------|
| **Execution difficulty** / **执行难度** | [The precision and timing demands of core actions. e.g., "Dodging enemy attacks requires correct timing within a 200ms window." / 核心行动的精度和时间要求。例如："躲避敌人攻击需要在200ms窗口内的正确时机。"] | [e.g., Combat, movement / 例如：战斗、移动] | [Yes — practice reduces this / No — fixed mechanical threshold / 是——练习减少此维度 / 否——固定的机械阈值] |
| **Knowledge difficulty** / **知识难度** | [The cost of not knowing information. e.g., "Enemy weaknesses are not telegraphed; players who have not discovered them take significantly more damage." / 不知道信息的代价。例如："敌人弱点未提示；未发现的玩家会受到显著更多伤害。"] | [e.g., Enemy design, UI, lore / 例如：敌人设计、UI、设定] | [Yes — through in-game discovery / No — requires external knowledge / 是——通过游戏内发现 / 否——需要外部知识] |
| **Resource pressure** / **资源压力** | [How scarce are the resources needed to progress? e.g., "Health consumables are limited; efficient play is required to sustain long dungeon runs." / 进度所需资源有多稀缺？例如："生命消耗品有限；需要高效玩法来维持长地牢运行。"] | [e.g., Economy, loot, crafting / 例如：经济、战利品、制作] | [Yes — through build optimization / Partially / 是——通过构建优化 / 部分] |
| **Time pressure** / **时间压力** | [Does the player have time to think, or does the game demand rapid decisions? e.g., "Enemy spawn timers and attack windows require real-time response." / 玩家有时间思考吗？还是游戏要求快速决策？例如："敌人生成计时器和攻击窗口需要实时响应。"] | [e.g., Combat pacing, timers / 例如：战斗节奏、计时器] | [Yes — through difficulty settings / No — core to genre / 是——通过难度设置 / 否——类型的核心] |
| **Decision complexity** / **决策复杂度** | [How many meaningful choices must the player evaluate simultaneously? e.g., "Build decisions interact across 4 systems; suboptimal combinations create compounding disadvantage." / 玩家必须同时评估多少个有意义的选项？例如："构建决策在4个系统中交互；次优组合产生复合劣势。"] | [e.g., Progression, inventory, skills / 例如：进度、库存、技能] | [Yes — through UI and tutorialization / No — inherent to strategy depth / 是——通过UI和教程化 / 否——策略深度的固有属性] |
| **[Add axis]** / **[添加维度]** | [Description / 描述] | [Systems / 系统] | [Player control / 玩家控制] |

---

## Difficulty Curve Overview / 难度曲线概述

> **Guidance**: This table describes the intended challenge arc across the whole
> game. Difficulty levels use a 1-10 scale where 1 = no meaningful challenge,
> 10 = maximum challenge the game can produce. The scale is relative to THIS game's
> design intent — a 6/10 in a soulslike is not the same as a 6/10 in a cozy sim. / **指导**：此表描述整个游戏的预期挑战弧。难度等级使用1-10比例，其中1=无有意义挑战，10=游戏能产生的最大挑战。此比例相对于此游戏的设计意图——魂类游戏的6/10与温馨模拟游戏的6/10不同。
>
> "Primary challenge type" refers to the difficulty axis (from the table above) that is doing the most work in this phase. New systems introduced should list only systems introduced for the FIRST TIME — the cognitive load of learning a new system is itself a form of difficulty. / "主要挑战类型"指在此阶段起最大作用的难度维度（从上表）。引入的新系统应仅列出首次引入的系统——学习新系统的认知负荷本身就是一种难度形式。
>
> "Target player state" is the emotional state the designer intends. If the actual playtested state diverges from the intended state, this column is what needs to be achieved. / "目标玩家状态"是设计师意图的情感状态。如果实际游戏测试状态与预期状态不同，此列是需要实现的目标。

| Phase / 阶段 | Duration / 持续时间 | Difficulty Level (1-10) / 难度等级 (1-10) | Primary Challenge Type / 主要挑战类型 | New Systems Introduced / 引入的新系统 | Target Player State / 目标玩家状态 |
|-------|----------|------------------------|----------------------|----------------------|---------------------|
| [Prologue / Tutorial / 序幕 / 教程] | [e.g., 0-15 min / 例如：0-15分钟] | [2/10] | [Knowledge / 知识] | [Core movement, basic interaction / 核心移动、基本交互] | [Safe, curious, building confidence / 安全、好奇、建立信心] |
| [Early game / 早期游戏] | [e.g., 15 min - 2 hrs / 例如：15分钟-2小时] | [3-5/10] | [Execution / 执行] | [Combat, inventory, first upgrade path / 战斗、库存、首个升级路径] | [Learning, occasional failure, clear cause-effect / 学习、偶尔失败、清晰因果关系] |
| [Mid game - opening / 中期游戏 - 开放] | [e.g., 2-6 hrs / 例如：2-6小时] | [5-7/10] | [Decision complexity / 决策复杂度] | [Build choices, advanced enemies, crafting / 构建选择、高级敌人、制作] | [Engaged, strategizing, feeling growth / 投入、制定策略、感受成长] |
| [Mid game - depth / 中期游戏 - 深度] | [e.g., 6-15 hrs / 例如：6-15小时] | [6-8/10] | [Resource pressure / 资源压力] | [Elite enemies, optional hard content, endgame previews / 精英敌人、可选困难内容、终局预览] | [Challenged, invested, approaching mastery / 挑战、投入、接近精通] |
| [Late game / 后期游戏] | [e.g., 15-25 hrs / 例如：15-25小时] | [7-9/10] | [Execution + knowledge / 执行 + 知识] | [Endgame systems, NG+ or equivalent / 终局系统、NG+或等效] | [Mastery, confident in build identity, seeking peak challenge / 精通、对构建身份自信、寻求巅峰挑战] |
| [Optional / Endgame / 可选 / 终局] | [e.g., 25+ hrs / 例如：25+小时] | [8-10/10] | [All axes combined / 所有维度结合] | [Mastery challenges, achievement targets / 精通挑战、成就目标] | [Expert play, self-imposed goals, community comparison / 专家玩法、自我设定的目标、社区比较] |

---

## Onboarding Ramp / 引导期坡度

> **Guidance**: The first hour deserves its own detailed breakdown because it
> does the most difficult design work: it must teach every foundational skill
> without feeling like a lesson, and it must create enough investment that the
> player commits to the journey ahead. Research on player retention shows that
> most players who leave a game do so in the first 30 minutes — not because
> the game is bad, but because onboarding failed to connect them. / **指导**：第一小时值得有自己的详细分析，因为它做最困难的设计工作：它必须教授每个基础技能而不感觉像课程，并且必须创造足够的投入使玩家承诺继续旅程。玩家留存研究表明，大多数离开游戏的玩家在前30分钟内这样做——不是因为游戏差，而是因为引导期未能连接他们。
>
> The scaffolding principle (Vygotsky's Zone of Proximal Development, adapted for game design): introduce each mechanic in isolation before combining it with others. A player cannot learn two skills simultaneously under pressure. / 脚手架原则（Vygotsky的最优发展区，改编为游戏设计）：在与其他机制结合之前单独介绍每个机制。玩家不能在压力下同时学习两个技能。

### What the Player Knows at Each Stage / 玩家在每个阶段知道什么

| Time / 时间 | What the Player Knows / 玩家知道什么 | What They Do Not Know Yet / 他们尚不知道什么 |
|------|-----------------------|--------------------------|
| [0 min / 0分钟] | [Literally nothing — treat this row as your most important UX audit. What can a player infer from the title screen alone? / 字面上什么都不知道——将此行视为最重要的UX审计。玩家仅从标题屏幕能推断什么？] | [Everything / 一切] |
| [5 min / 5分钟] | [Core movement verb, basic world reading / 核心移动动词、基本世界解读] | [All progression systems, all secondary mechanics / 所有进度系统、所有次要机制] |
| [15 min / 15分钟] | [Core interaction loop, first goal / 核心交互循环、首个目标] | [Build depth, advanced mechanics, danger severity / 构建深度、高级机制、危险严重性] |
| [30 min / 30分钟] | [Has made at least one strategic choice / 已做出至少一个战略选择] | [Whether that choice was optimal / 该选择是否最优] |
| [60 min / 60分钟] | [Has a working model of the core loop / 拥有核心循环的工作模型] | [Late-game depth, optional systems / 后期游戏深度、可选系统] |

### Mechanic Introduction Sequence / 机制引入序列

> The order mechanics are introduced is a design decision with real consequences.
> Introduce the most essential verb first. Introduce mechanics that modify other
> mechanics AFTER the base mechanic is internalized. Never introduce two new
> mechanics in the same encounter. / 机制引入顺序是具有实际后果的设计决策。首先引入最重要的动词。在基础机制内化后引入修改其他机制的机制。切勿在同一遭遇中引入两个新机制。

| Mechanic / 机制 | Introduced At / 引入时间 | Introduction Method / 引入方法 | Stakes at Introduction / 引入时的风险 |
|----------|--------------|--------------------|-----------------------|
| [Core movement / primary verb / 核心移动 / 主要动词] | [e.g., First 30 seconds / 例如：前30秒] | [Tutorial prompt / environmental design / NPC instruction / 教程提示 / 环境设计 / NPC指导] | [None — safe space to experiment / 无——安全实验空间] |
| [Primary interaction / action / 主要交互 / 行动] | [e.g., First 2 minutes / 例如：前2分钟] | [Method / 方法] | [Low — reversible, forgiving window / 低——可逆、宽容窗口] |
| [First resource mechanic / 首个资源机制] | [e.g., 5 min / 例如：5分钟] | [Method / 方法] | [Low — abundant at introduction / 低——引入时丰富] |
| [First strategic choice / 首个战略选择] | [e.g., 15 min / 例如：15分钟] | [Method / 方法] | [Low — choice can be changed or revisited / 低——选择可更改或重新考虑] |
| [First real failure risk / 首个真实失败风险] | [e.g., 20-30 min / 例如：20-30分钟] | [Method / 方法] | [Moderate — player should feel genuine threat but have fair tools to respond / 中等——玩家应感受真实威胁但拥有公平的应对工具] |
| [Add mechanic / 添加机制] | [Timing / 时间] | [Method / 方法] | [Stakes / 风险] |

### The First Failure / 首次失败

[Describe the intended design of the first moment the player can meaningfully
fail. This is one of the most important beats in the game. / 描述玩家首次能有意义失败的时刻的预期设计。这是游戏中最重要的节拍之一。

A well-designed first failure teaches rather than punishes. The player should
be able to immediately identify what they did wrong and what they would do
differently. If the cause of failure is ambiguous, the player blames the game. / 设计良好的首次失败是教导而非惩罚。玩家应能立即识别自己做错了什么以及会如何不同地做。如果失败原因模糊，玩家会责备游戏。

Answer: What causes the first failure? What does the player learn from it?
How quickly can they retry? What is the cost? Does the game provide any
feedback that bridges cause and effect? / 回答：什么导致首次失败？玩家从中学习什么？他们能多快重试？成本是什么？游戏是否提供连接因果的反馈？]

### When the Player First Feels Competent / 当玩家首次感到有能力时

[Identify the specific moment — not a vague window, but a specific beat —
where the player should shift from "learning" to "doing." This is the moment
of first competence: the first time their prediction about the game comes true,
or the first time they execute a plan and it works. / 识别具体时刻——不是模糊窗口，而是具体的节拍——玩家应从"学习"转向"执行"。这是首次能力的时刻：第一次他们对游戏的预测成真，或第一次执行计划并成功。

This moment must happen within the first hour. If it does not, the player
will not reach Phase 3 of the journey (First Mastery). Design this moment
deliberately — do not leave it to chance. / 此时刻必须在一小时内发生。如果不发生，玩家将无法达到旅程的第三阶段（首次精通）。刻意设计此时刻——不要留给机会。

What is the moment? What systems create it? What does the player do to
trigger it? How does the game communicate that they have succeeded? / 是什么时刻？什么系统创造它？玩家做什么来触发它？游戏如何传达他们已经成功？]

---

## Difficulty Spikes and Valleys / 难度尖峰和谷值

> **Guidance**: A healthy difficulty curve follows a sawtooth pattern
> (Csikszentmihalyi's flow model applied to macro-structure): tension builds
> through a sequence, then releases at a milestone, then re-engages at a
> slightly higher baseline. Flat difficulty creates boredom; uninterrupted
> escalation creates fatigue. / **指导**：健康的难度曲线遵循锯齿模式（Csikszentmihalyi的心流模型应用于宏观结构）：紧张通过序列建立，然后在里程碑释放，然后在稍高的基线重新参与。平坦难度创造无聊；不间断升级创造疲劳。
>
> Spikes are intentional peaks that test accumulated skills. Valleys are
> intentional troughs that give the player space to breathe, experiment, and
> feel powerful before the next escalation. Both are designed, not emergent. / 尖峰是测试累积技能的有意峰值。谷值是有意低谷，给玩家空间呼吸、实验，并在下一次升级前感受强大。两者都是设计的，不是突发的。
>
> "Recovery design" is critical: what happens immediately after a spike? The
> player should exit a hard moment feeling accomplished, not depleted. Give
> them a valley, a reward, or a narrative payoff. / "恢复设计"至关重要：尖峰后立即发生什么？玩家应退出困难时刻时感觉有成就感，而非耗尽感。给他们谷值、奖励或叙事回报。

| Name / 名称 | Location in Game / 在游戏中的位置 | Type / 类型 | Purpose / 目的 | Recovery Design / 恢复设计 |
|------|-----------------|------|---------|-----------------|
| [e.g., "The First Boss" / 例如："首个BOSS"] | [e.g., End of Area 1, ~1 hr / 例如：区域1末尾，约1小时] | [Spike / 尖峰] | [Tests all skills introduced in Area 1. Acts as a gate confirming the player is ready for increased complexity. / 测试区域1引入的所有技能。作为门，确认玩家为增加复杂性做好准备。] | [Post-boss: safe area, upgrade opportunity, story beat that provides emotional relief before Area 2 escalation begins. / 战后：安全区域、升级机会、在区域2升级开始前提供情感缓解的故事节拍。] |
| [e.g., "The Safe Zone" / 例如："安全区域"] | [e.g., Hub area between Areas 1 and 2, ~1.5 hrs / 例如：区域1和2之间的枢纽区域，约1.5小时] | [Valley / 谷值] | [Player feels powerful from boss win. Space to experiment with build options before stakes rise. / 玩家从BOSS胜利感受强大。在风险提高前实验构建选项的空间。] | [N/A — this IS the recovery from the preceding spike. / 不适用——这本身就是前一次尖峰的恢复。] |
| [e.g., "The Knowledge Wall" / 例如："知识墙"] | [e.g., Area 3 first encounter, ~4 hrs / 例如：区域3首次遭遇，约4小时] | [Spike — knowledge type / 尖峰——知识类型] | [Forces players to engage with a mechanic they may have been avoiding. Survival requires understanding it. / 强迫玩家参与他们可能一直在回避的机制。生存需要理解它。] | [Clear feedback on what killed them. Tutorial hint surfaces on third failure. Mechanic becomes standard after this point. / 关于什么杀死他们的清晰反馈。第三次失败时显示教程提示。此后机制成为标准。] |
| [e.g., "Pre-Climax Valley" / 例如："高潮前谷值"] | [e.g., Just before final act, ~20 hrs / 例如：最终幕之前，约20小时] | [Valley / 谷值] | [Emotional breathing room before the final escalation. Player reflects on how far they have come. / 最终升级前的情感喘息空间。玩家反思他们已经走了多远。] | [N/A — designed as relief before the finale's spike. / 不适用——设计为最终尖峰前的缓解。] |
| [Add spike/valley / 添加尖峰/谷值] | [Location / 位置] | [Type / 类型] | [Purpose / 目的] | [Recovery / 恢复] |

---

## Balancing Levers / 平衡杠杆

> **Guidance**: Balancing levers are the specific values and parameters that
> tune difficulty at each phase. Centralizing them here makes it possible to
> tune the whole-game difficulty curve without hunting through individual GDDs.
> For each lever, the GDD that owns it should be cross-referenced. / **指导**：平衡杠杆是在每个阶段调优难度的具体值和参数。在此集中它们使得无需搜索个别GDD就能调优整个游戏的难度曲线。对于每个杠杆，应交叉引用拥有它的GDD。
>
> "Current setting" is the design intent at the time of writing — implementation
> values live in `assets/data/`. The tuning range is the safe operating range:
> values outside this range reliably break the intended experience. / "当前设置"是撰写时的设计意图——实现值位于`assets/data/`中。调优范围是安全操作范围：超出此范围的值可靠地破坏预期体验。

| Lever / 杠杆 | Phase(s) / 阶段 | Effect / 效果 | Current Setting / 当前设置 | Tuning Range / 调优范围 | Notes / 备注 |
|-------|----------|--------|----------------|-------------|-------|
| [Enemy health multiplier / 敌人生命值乘数] | [All / 所有] | [Higher = longer fights = more resource pressure and execution time / 更高 = 更长战斗 = 更多资源压力和执行时间] | [1.0x] | [0.7x - 1.5x] | [Below 0.7x, fights end before player can read enemy patterns. Above 1.5x, attrition replaces skill. / 低于0.7x，战斗在玩家能解读敌人模式前结束。高于1.5x，消耗代替技能。] |
| [Enemy aggression timer / 敌人攻击计时器] | [Mid game onward / 中期游戏开始] | [Time between enemy attacks; lower = less time to react / 敌人攻击间隔；更低 = 更少反应时间] | [e.g., 2.0s / 例如：2.0秒] | [1.2s - 3.0s] | [Below 1.2s, reaction window is sub-human. Above 3.0s, encounters feel passive. / 低于1.2秒，反应窗口低于人类。高于3.0秒，遭遇感觉被动。] |
| [Resource drop rate / 资源掉落率] | [Early game / 早期游戏] | [Lower = more resource pressure = punishes inefficiency harder / 更低 = 更多资源压力 = 更严厉惩罚低效] | [e.g., 1.5x baseline / 例如：1.5倍基线] | [0.8x - 2.0x] | [Onboarding generosity; reduces in mid-game as player skill assumed. / 引导期慷慨；中期减少，因为假设玩家技能提高。] |
| [New mechanic introduction density / 新机制引入密度] | [First hour / 第一小时] | [How many new concepts per minute of play; too high = cognitive overload / 每分钟游戏多少新概念；太高 = 认知过载] | [e.g., 1 new mechanic per 8 min / 例如：每8分钟1个新机制] | [1 per 5 min (max) to 1 per 15 min (slow) / 每5分钟1个（最大）到每15分钟1个（慢）] | [Above 1 per 5 min in early game causes retention drop. Below 1 per 15 min causes boredom. / 早期游戏高于每5分钟1个导致留存下降。低于每15分钟1个导致无聊。] |
| [Failure cost / 失败成本] | [All / 所有] | [Time lost on failure; higher = more punishing = more tension / 失败时损失的时间；更高 = 更严厉 = 更紧张] | [e.g., 2 min setback / 例如：2分钟倒退] | [30s - 8 min / 30秒 - 8分钟] | [Must scale with encounter frequency. Frequent failures need fast recovery. / 必须随遭遇频率缩放。频繁失败需要快速恢复。] |
| [Add lever / 添加杠杆] | [Phase / 阶段] | [Effect / 效果] | [Setting / 设置] | [Range / 范围] | [Notes / 备注] |

---

## Player Skill Assumptions / 玩家技能假设

> **Guidance**: Every game implicitly assumes players develop a set of skills
> over the course of play. Making these assumptions explicit allows the team to
> verify that each skill is actually taught before it is tested, and that the
> gap between "introduced" and "tested hard" is long enough for internalization. / **指导**：每个游戏隐含假设玩家在游戏过程中发展一系列技能。使这些假设明确允许团队验证每个技能在实际测试前是否确实被教授，以及"引入"和"硬测试"之间的间隔是否足够内化。
>
> A skill introduced and tested in the same encounter is a surprise difficulty
> spike. A skill assumed but never formally introduced is an undocumented knowledge
> wall. Both are fixable — but only if they are documented. / 在同一遭遇中引入和测试的技能是意外的难度尖峰。假设但从未正式引入的技能是未记录的知识墙。两者都可修复——但仅当它们被记录时。
>
> "Taught by" refers to the mechanism: tutorial prompt, environmental design,
> safe practice opportunity, NPC instruction, or organic discovery. / "教授方式"指机制：教程提示、环境设计、安全练习机会、NPC指导或有机发现。
>
> "Tested by" refers to the first encounter that REQUIRES this skill to survive
> without taking significant damage or cost. / "测试方式"指首次需要此技能才能生存而不受显著伤害或成本的遭遇。

| Skill / 技能 | Introduced In / 引入位置 | Expected Mastered By / 预期精通时间 | Taught By / 教授方式 | First Hard Test / 首次硬测试 |
|-------|--------------|---------------------|-----------|-----------------|
| [Core movement / dodging / 核心移动 / 闪避] | [Tutorial area, 0-5 min / 教程区域，0-5分钟] | [End of Area 1, ~1 hr / 区域1末尾，约1小时] | [Safe practice zone with visible hazards / 带可见危险的安全练习区域] | [First Elite enemy, ~45 min / 首个精英敌人，约45分钟] |
| [Resource management / 资源管理] | [First shop encounter, ~10 min / 首次商店遭遇，约10分钟] | [Mid game, ~4 hrs / 中期游戏，约4小时] | [Resource scarcity in Area 2 forces planning / 区域2的资源稀缺强迫规划] | [Boss that requires consumables to survive efficiently / 需要消耗品才能高效生存的BOSS] |
| [Build decision-making / 构建决策] | [First upgrade choice, ~20 min / 首次升级选择，约20分钟] | [End of mid game, ~10 hrs / 中期游戏末尾，约10小时] | [Multiple playthroughs / community discussion / in-game build advisor / 多次通关 / 社区讨论 / 游戏内构建顾问] | [Endgame encounters that punish build incoherence / 惩罚构建不一致的终局遭遇] |
| [Enemy pattern reading / 敌人模式解读] | [Area 1 basic enemies / 区域1基础敌人] | [Area 3, ~4 hrs / 区域3，约4小时] | [Enemy telegraphs visible and consistent from introduction / 从引入就可见且一致的敌人提示] | [Elite enemy with 3+ distinct attack patterns / 带3+种不同攻击模式的精英敌人] |
| [Add skill / 添加技能] | [When introduced / 引入时间] | [When mastered / 精通时间] | [Taught by / 教授方式] | [First hard test / 首次硬测试] |

---

## Accessibility Considerations / 无障碍考虑

> **Guidance**: Accessibility in difficulty design is not about making the game
> easier — it is about ensuring players with different needs and skill profiles
> can reach the intended emotional experience. Be explicit about what CAN be
> adjusted and what CANNOT, and justify both. / **指导**：难度设计中的无障碍不是让游戏更容易——而是确保具有不同需求和技能配置的玩家能达到预期的情感体验。明确什么可以调整、什么不能调整，并证明两者。
>
> The principle from Self-Determination Theory: players need to feel competent.
> Accessibility options that help players feel competent without removing the
> feeling of agency are always worth including. Options that make competence
> meaningless undermine the core experience. / 自我决定理论的原则：玩家需要感到有能力。帮助玩家感到有能力而不移除自主感的无障碍选项总是值得包含。使能力变得无意义的选项破坏核心体验。

### What Can Be Adjusted / 什么可以调整

| Adjustment / 调整 | Method / 方法 | Effect on Experience / 对体验的影响 | Tradeoff / 权衡 |
|-----------|--------|---------------------|----------|
| [e.g., Enemy speed reduction / 例如：敌人速度降低] | [Difficulty setting / accessibility menu / 难度设置 / 无障碍菜单] | [Lowers execution difficulty without changing knowledge or decision requirements / 降低执行难度而不改变知识或决策要求] | [Reduces the tension of combat timing; acceptable for narrative players / 减少战斗计时的紧张感；对叙事玩家可接受] |
| [e.g., Extended input windows / 例如：延长输入窗口] | [Accessibility menu / 无障碍菜单] | [Allows players with motor impairments to achieve the same skill outcomes with more time / 允许运动障碍玩家用更多时间达到相同技能结果] | [Minimal — skill expression preserved, threshold relaxed / 最小——技能表达保持，阈值放宽] |
| [e.g., Hint frequency / 例如：提示频率] | [Settings toggle / 设置开关] | [Surfaces contextual guidance more or less aggressively based on player preference / 根据玩家偏好更激进或更保守地提供情境指导] | [Higher hints reduce knowledge difficulty; players who want to discover organically may feel over-guided / 更高提示减少知识难度；希望有机发现的玩家可能感觉过度指导] |
| [Add option / 添加选项] | [Method / 方法] | [Effect / 效果] | [Tradeoff / 权衡] |

### What Cannot Be Adjusted (and Why) / 什么不能调整（以及为什么）

| Fixed Element / 固定元素 | Why It Cannot Change / 为什么不能改变 | Design Reasoning / 设计推理 |
|--------------|---------------------|-----------------|
| [e.g., Permadeath in roguelike run / 例如：Roguelike运行的永久死亡] | [Removing it eliminates the resource pressure axis that all encounter balance is built around / 移除它消除了所有遭遇平衡构建所依赖的资源压力维度] | [The weight of each decision comes from permanence; without it, the core loop loses meaning / 每个决策的分量来自永久性；没有它，核心循环失去意义] |
| [e.g., Core narrative pacing / 例如：核心叙事节奏] | [Difficulty valleys are timed to story beats; adjustable pacing would decouple challenge from narrative intention / 难度谷值与故事节拍定时；可调节节奏会使挑战与叙事意图脱钩] | [Story and difficulty are designed as one arc, not two independent tracks / 故事和难度设计为一个弧，而非两个独立轨道] |
| [Add fixed element / 添加固定元素] | [Why / 为什么] | [Reasoning / 推理] |

---

## Cross-System Difficulty Interactions / 跨系统难度交互

> **Guidance**: When two systems operate simultaneously, their combined
> difficulty is often greater than the sum of their parts — or sometimes
> less. These interactions are frequently unintended and only surface during
> playtesting. Documenting anticipated interactions here creates a checklist
> for QA and playtest sessions. / **指导**：当两个系统同时操作时，它们的组合难度通常大于部分之和——有时更小。这些交互通常是无意的，仅在游戏测试期间显现。在此记录预期的交互为QA和游戏测试会话创建检查清单。
>
> "Is this intended?" Yes means the interaction is a designed feature.
> No means it should be mitigated. Partial means the interaction is
> acceptable in small doses but problematic if it becomes the dominant
> experience. / "这是预期的吗？"是意味着交互是设计的功能。否意味着应该缓解。部分意味着交互在小剂量时可接受，但如果成为主导体验则有问题。

| System A / 系统A | System B / 系统B | Combined Effect / 组合效果 | Intended? / 预期的？ |
|----------|----------|----------------|-----------|
| [Combat difficulty / 战斗难度] | [Resource scarcity / 资源稀缺] | [Resource-poor players face combat encounters with fewer options, compounding difficulty for players already struggling. Can create a death spiral where failing creates worse conditions. / 资源贫乏玩家面对战斗遭遇时选项更少，使已在挣扎的玩家难度复合。能创建失败创造更糟条件的死亡螺旋。] | [Partial — intended as stakes, not as a trap. Pity mechanics required to prevent unrecoverable states. / 部分——预期为风险，非陷阱。需要保底机制防止不可恢复状态。] |
| [Build complexity / 构建复杂度] | [Time pressure / 时间压力] | [Players who are still learning their build take longer to make decisions under time pressure, increasing cognitive load beyond the intended challenge of either system alone. / 仍在学习构建的玩家在时间压力下决策时间更长，增加认知负荷超过任一系统单独预期的挑战。] | [No — reduce decision complexity demand in high time-pressure encounters. / 否——在高时间压力遭遇中减少决策复杂度要求。] |
| [New mechanic introduction / 新机制引入] | [Resource pressure / 资源压力] | [Introducing a new system while the player is already under resource pressure forces them to learn and optimize simultaneously. / 在玩家已处于资源压力下时引入新系统迫使他们同时学习和优化。] | [No — new mechanics should be introduced in low-resource-pressure environments. / 否——新机制应在低资源压力环境中引入。] |
| [Enemy density / 敌人密度] | [Execution difficulty / 执行难度] | [High enemy counts with individually demanding enemies produce difficulty that scales exponentially, not linearly. / 高敌人数量与个体要求高的敌人产生指数而非线性缩放的难度。] | [Partial — intended for optional challenge content only; not acceptable on the critical path. / 部分——仅预期用于可选挑战内容；关键路径上不可接受。] |
| [Add System A / 添加系统A] | [Add System B / 添加系统B] | [Combined effect description / 组合效果描述] | [Yes / No / Partial / 是 / 否 / 部分] |

---

## Validation Checklist / 验证检查清单

> **Guidance**: These checkpoints structure playtesting sessions to verify
> the difficulty curve is achieving its intent. Each item should be checked
> with at least 3 playtester sessions before being marked complete. Note the
> playtester profile that revealed issues — difficulty problems are almost
> always player-profile-specific. / **指导**：这些检查点结构化游戏测试会话以验证难度曲线是否达到其意图。每个项目应在标记完成前用至少3个游戏测试者会话检查。记录揭示问题的游戏测试者配置——难度问题几乎总是玩家配置特定的。

### Onboarding (0-30 min) / 引导期 (0-30分钟)
- [ ] Players with no prior genre experience complete the tutorial area without external help / 无先前类型经验的玩家无需外部帮助完成教程区域
- [ ] Zero players cite confusion about what they are supposed to be doing in the first 5 minutes / 零玩家在前5分钟内引用对应该做什么的困惑
- [ ] At least one playtester spontaneously says "I want to see what's next" within 15 minutes / 至少一位游戏测试者在15分钟内自发说"我想看接下来是什么"
- [ ] First failure moment produces a visible learning response (player verbalizes what went wrong) / 首次失败时刻产生可见学习反应（玩家口头表达出错之处）

### Early Game (30 min - 2 hrs) / 早期游戏 (30分钟 - 2小时)
- [ ] Average player reaches the first competence moment within 60 minutes / 平均玩家在60分钟内达到首次能力时刻
- [ ] First major encounter (boss or equivalent) is passed within 3-5 attempts on average / 首次主要遭遇（BOSS或等效）在平均3-5次尝试内通过
- [ ] No player cites a mechanic introduced "too suddenly without warning" / 无玩家引用"过于突然无警告"引入的机制
- [ ] Players can describe their current goal without prompting / 玩家能在无提示下描述当前目标

### Mid Game (2-10 hrs) / 中期游戏 (2-10小时)
- [ ] Players discover at least one depth mechanic through organic play (without guide) / 玩家通过有机玩法（无指南）发现至少一个深度机制
- [ ] Playtest sessions report "I want to try a different build / strategy next run" / 游戏测试会话报告"下次运行我想尝试不同构建/策略"
- [ ] No single difficulty axis dominates player complaints — frustration is distributed / 无单一难度维度主导玩家抱怨——挫败感分布
- [ ] Players who fail a mid-game encounter correctly identify the cause without being told / 中期游戏遭遇失败的玩家正确识别原因而无需被告知

### Late Game (10+ hrs) / 后期游戏 (10+小时)
- [ ] Players report the final challenge feels like a culmination of everything they have learned / 玩家报告最终挑战感觉像他们所学一切的高潮
- [ ] Failure at late-game content does not feel unfair (even if it is hard) / 后期游戏内容的失败不感觉不公平（即使困难）
- [ ] Players who complete the main content express a reason to continue playing / 完成主要内容的玩家表达继续玩的原因

### Accessibility / 无障碍
- [ ] All listed accessibility options function without breaking encounter intent / 所有列出的无障碍选项功能正常而不破坏遭遇意图
- [ ] Players using accessibility settings report feeling competent, not patronized / 使用无障碍设置的玩家报告感觉有能力，而非被施舍
- [ ] Fixed difficulty elements are encountered and accepted without negative reception from accessibility playtesters / 固定难度元素被遇到并被接受，无障碍游戏测试者无负面接受

---

## Open Questions / 开放问题

| Question / 问题 | Owner / 负责人 | Deadline / 截止日期 | Resolution / 解决方案 |
|----------|-------|----------|-----------|
| [Is the onboarding ramp correctly calibrated for players without prior genre experience? / 引导期坡度是否正确校准为无先前类型经验的玩家？] | [game-designer / game-designer] | [Date / 日期] | [Unresolved — schedule genre-naive playtester sessions / 未解决——安排无类型经验游戏测试者会话] |
| [Does the first boss represent the correct difficulty spike or is it a wall? / 首个BOSS代表正确的难度尖峰还是墙壁？] | [game-designer, systems-designer / game-designer, systems-designer] | [Date / 日期] | [Unresolved — requires 5+ playtester sessions to establish average attempt count / 未解决——需要5+游戏测试者会话建立平均尝试次数] |
| [Do any cross-system interactions produce unrecoverable states? / 是否有跨系统交互产生不可恢复状态？] | [systems-designer / systems-designer] | [Date / 日期] | [Unresolved — requires targeted playtest with resource-constrained starting conditions / 未解决——需要资源受限起始条件的定向游戏测试] |
| [Add question / 添加问题] | [Owner / 负责人] | [Date / 日期] | [Resolution / 解决方案] |