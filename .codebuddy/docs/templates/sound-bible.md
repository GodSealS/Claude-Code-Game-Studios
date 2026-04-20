# Sound Bible: [Project Name / 项目名称]

## Audio Vision / 音频愿景

### Sonic Identity / 声音识别
[Describe the overall audio personality of the game in 2-3 sentences. What does the game "sound like"? What emotions should the audio evoke? / 用2-3句话描述游戏的整体音频个性。游戏"听起来像什么"？音频应该唤起什么情感？]

### Audio Pillars / 音频支柱
1. **[Pillar 1 / 支柱1]**: [How this pillar manifests in audio / 此支柱如何在音频中体现]
2. **[Pillar 2 / 支柱2]**: [How this pillar manifests in audio / 此支柱如何在音频中体现]
3. **[Pillar 3 / 支柱3]**: [How this pillar manifests in audio / 此支柱如何在音频中体现]

### Reference Games / Media / 参考游戏/媒体
| Reference / 参考 | What to Take From It / 借鉴之处 | What to Avoid / 避免什么 |
| ---- | ---- | ---- |
| [Game/Film 1 / 游戏/电影1] | [Specific audio quality to emulate / 要模仿的特定音频品质] | [What doesn't fit our vision / 什么不符合我们的愿景] |
| [Game/Film 2 / 游戏/电影2] | [Specific audio quality to emulate / 要模仿的特定音频品质] | [What doesn't fit our vision / 什么不符合我们的愿景] |

---

## Music Direction / 音乐方向

### Style and Genre / 风格和流派
[Primary musical style, instrumentation palette, tempo ranges / 主要音乐风格、乐器配置、节奏范围]

### Instrumentation Palette / 乐器配置
- **Core instruments / 核心乐器**: [List the primary instruments/synths that define the sound / 定义声音的主要乐器/合成器列表]
- **Accent instruments / 点缀乐器**: [Used for emphasis, transitions, special moments / 用于强调、过渡、特殊时刻]
- **Avoid / 避免**: [Instruments or styles that do NOT fit the game / 不适合游戏的乐器或风格]

### Adaptive Music System / 自适应音乐系统
| Game State / 游戏状态 | Music Behavior / 音乐行为 | Transition / 过渡 |
| ---- | ---- | ---- |
| Exploration / 探索 | [Tempo, energy, instrumentation / 节奏、能量、乐器配置] | [How it transitions to next state / 如何过渡到下一个状态] |
| Combat / 战斗 | [Tempo, energy, instrumentation / 节奏、能量、乐器配置] | [Trigger condition and crossfade time / 触发条件和交叉淡化时间] |
| Stealth/Tension / 潜行/紧张 | [Tempo, energy, instrumentation / 节奏、能量、乐器配置] | [Trigger and transition / 触发和过渡] |
| Victory/Reward / 胜利/奖励 | [Stinger or transition behavior / 短促音效或过渡行为] | [Return to exploration / 返回探索] |
| Menu/UI / 菜单/UI | [Style for menus / 菜单风格] | [Fade on game start / 游戏开始时淡出] |

### Music Rules / 音乐规则
- [Rule about looping, e.g., "All exploration tracks must loop seamlessly after 2-4 minutes" / 关于循环的规则，例如，"所有探索曲目必须在2-4分钟后无缝循环"]
- [Rule about silence, e.g., "Allow 10-15 seconds of silence between exploration loops" / 关于静音的规则，例如，"在探索循环之间允许10-15秒静音"]
- [Rule about intensity, e.g., "Combat music must reach full intensity within 3 seconds of combat start" / 关于强度的规则，例如，"战斗音乐必须在战斗开始后3秒内达到全强度"]
- [Rule about transitions, e.g., "All music transitions use 1.5 second crossfades" / 关于过渡的规则，例如，"所有音乐过渡使用1.5秒交叉淡化"]

---

## Sound Effects / 音效

### SFX Palette / 音效配置
| Category / 类别 | Description / 描述 | Style Notes / 风格说明 |
| ---- | ---- | ---- |
| Player Actions / 玩家动作 | [Movement, attacks, abilities / 移动、攻击、能力] | [Punchy, responsive, front-of-mix / 有力、响应迅速、混音前列] |
| Enemy Actions / 敌人动作 | [Attacks, abilities, death / 攻击、能力、死亡] | [Distinct from player, slightly recessed / 与玩家不同，略微后缩] |
| UI / 界面 | [Button clicks, menu transitions, notifications / 按钮点击、菜单过渡、通知] | [Clean, subtle, never annoying on repeat / 干净、微妙、重复不烦人] |
| Environment / 环境 | [Ambient loops, weather, objects / 环境循环、天气、物体] | [Immersive, layered, spatial / 沉浸式、分层、空间感] |
| Feedback / 反馈 | [Damage taken, item pickup, level up / 受到伤害、拾取物品、升级] | [Clear, satisfying, non-fatiguing / 清晰、令人满意、不易疲劳] |

### Audio Feedback Priority / 音频反馈优先级
When multiple sounds compete, this priority determines what plays: / 当多个声音竞争时，此优先级决定播放什么：
1. Player damage / critical warnings (always audible) / 玩家伤害/关键警告（始终可听）
2. Player actions (attacks, abilities) / 玩家动作（攻击、能力）
3. Enemy actions (nearby enemies first) / 敌人动作（附近敌人优先）
4. UI feedback / UI反馈
5. Environment / ambient / 环境/环境音

### SFX Rules / 音效规则
- [Rule about repetition, e.g., "Every SFX with >3 plays/minute needs 3+ variations" / 关于重复的规则，例如，"每分钟播放>3次的每个音效需要3+变体"]
- [Rule about spatial audio, e.g., "All gameplay SFX must be 3D positioned, UI SFX are 2D" / 关于空间音频的规则，例如，"所有游戏音效必须是3D定位的，UI音效是2D的"]
- [Rule about ducking, e.g., "Player hit SFX ducks all other SFX by 3dB for 200ms" / 关于闪避的规则，例如，"玩家受击音效使所有其他音效闪避3dB，持续200ms"]
- [Rule about response time, e.g., "Action SFX must trigger within 1 frame of the action" / 关于响应时间的规则，例如，"动作音效必须在动作发生1帧内触发"]

---

## Mixing / 混音

### Mix Bus Structure / 混音总线结构
| Bus / 总线 | Content / 内容 | Target Level / 目标电平 |
| ---- | ---- | ---- |
| Master / 主控 | Everything / 所有内容 | 0 dB |
| Music / 音乐 | All music tracks / 所有音乐轨道 | [target dBFS / 目标 dBFS] |
| SFX / 音效 | All sound effects / 所有音效 | [target dBFS / 目标 dBFS] |
| Dialogue / 对话 | All voice/narration / 所有语音/旁白 | [target dBFS / 目标 dBFS] |
| UI | All interface sounds / 所有界面音效 | [target dBFS / 目标 dBFS] |
| Ambient / 环境 | Environment loops / 环境循环 | [target dBFS / 目标 dBFS] |

### Mixing Rules / 混音规则
- Dialogue always takes priority — duck music and SFX during dialogue / 对话始终优先 — 在对话期间闪避音乐和音效
- Music should be felt, not dominate — if players can't hear SFX over music, music is too loud / 音乐应该被感受，而不是主导 — 如果玩家听不到音乐上的音效，音乐就太响了
- Master output must never clip — use a limiter on the master bus / 主控输出绝不能削波 — 在主总线上使用限幅器
- All volumes must be adjustable by the player (per bus) / 所有音量必须可由玩家调节（按总线）
- Default mix should sound good on both speakers and headphones / 默认混音应该在扬声器和耳机上都听起来不错

### Dynamic Range / 动态范围
- [Specify loudness targets, e.g., "Target -14 LUFS integrated, -1 dBTP true peak" / 指定响度目标，例如，"目标 -14 LUFS 集成，-1 dBTP 真实峰值"]
- [Specify compression policy, e.g., "Light compression on SFX bus, no compression on music" / 指定压缩策略，例如，"音效总线轻度压缩，音乐无压缩"]

---

## Technical Specifications / 技术规格
