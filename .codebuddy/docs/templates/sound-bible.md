# Sound Bible: [Project Name] / 音效圣经：[项目名称]

## Audio Vision / 音频愿景

### Sonic Identity / 声音识别
[Describe the overall audio personality of the game in 2-3 sentences. What does the game "sound like"? What emotions should the audio evoke? / 
用2-3句话描述游戏的整体音频个性。游戏听起来怎么样？音频应该唤起什么情感？]

### Audio Pillars / 音频支柱
1. **[Pillar 1]**: [How this pillar manifests in audio] / **[支柱1]**：[这个支柱如何体现在音频中]
2. **[Pillar 2]**: [How this pillar manifests in audio] / **[支柱2]**：[这个支柱如何体现在音频中]
3. **[Pillar 3]**: [How this pillar manifests in audio] / **[支柱3]**：[这个支柱如何体现在音频中]

### Reference Games / Media / 参考游戏/媒体
| Reference / 参考 | What to Take From It / 借鉴之处 | What to Avoid / 避免之处 |
| ---- | ---- | ---- |
| [Game/Film 1] | [Specific audio quality to emulate] / [要模仿的具体音频质量] | [What doesn't fit our vision] / [不符合我们愿景之处] |
| [Game/Film 2] | [Specific audio quality to emulate] / [要模仿的具体音频质量] | [What doesn't fit our vision] / [不符合我们愿景之处] |

---

## Music Direction / 音乐方向

### Style and Genre / 风格和流派
[Primary musical style, instrumentation palette, tempo ranges / 
主要音乐风格、乐器调色板、节奏范围]

### Instrumentation Palette / 乐器调色板
- **Core instruments**: [List the primary instruments/synths that define the sound] / **核心乐器**：[定义声音的主要乐器/合成器列表]
- **Accent instruments**: [Used for emphasis, transitions, special moments] / **强调乐器**：[用于强调、过渡、特殊时刻]
- **Avoid**: [Instruments or styles that do NOT fit the game] / **避免**：[不适合游戏的乐器或风格]

### Adaptive Music System / 自适应音乐系统
| Game State / 游戏状态 | Music Behavior / 音乐行为 | Transition / 过渡 |
| ---- | ---- | ---- |
| Exploration / 探索 | [Tempo, energy, instrumentation] / [节奏、能量、乐器] | [How it transitions to next state] / [如何过渡到下一个状态] |
| Combat / 战斗 | [Tempo, energy, instrumentation] / [节奏、能量、乐器] | [Trigger condition and crossfade time] / [触发条件和交叉淡入淡出时间] |
| Stealth/Tension / 潜行/紧张 | [Tempo, energy, instrumentation] / [节奏、能量、乐器] | [Trigger and transition] / [触发和过渡] |
| Victory/Reward / 胜利/奖励 | [Stinger or transition behavior] / [尾音或过渡行为] | [Return to exploration] / [返回探索] |
| Menu/UI / 菜单/界面 | [Style for menus] / [菜单样式] | [Fade on game start] / [游戏开始时淡出] |

### Music Rules / 音乐规则
- [Rule about looping, e.g., "All exploration tracks must loop seamlessly after 2-4 minutes"] / [关于循环的规则，例如，"所有探索轨道必须在2-4分钟后无缝循环"]
- [Rule about silence, e.g., "Allow 10-15 seconds of silence between exploration loops"] / [关于静默的规则，例如，"探索循环之间允许10-15秒的静默"]
- [Rule about intensity, e.g., "Combat music must reach full intensity within 3 seconds of combat start"] / [关于强度的规则，例如，"战斗音乐必须在战斗开始后3秒内达到全强度"]
- [Rule about transitions, e.g., "All music transitions use 1.5 second crossfades"] / [关于过渡的规则，例如，"所有音乐过渡使用1.5秒交叉淡入淡出"]

---

## Sound Effects / 音效

### SFX Palette / 音效调色板
| Category / 类别 | Description / 描述 | Style Notes / 风格说明 |
| ---- | ---- | ---- |
| Player Actions / 玩家动作 | [Movement, attacks, abilities] / [移动、攻击、能力] | [Punchy, responsive, front-of-mix] / [有力、响应快、混音前置] |
| Enemy Actions / 敌人动作 | [Attacks, abilities, death] / [攻击、能力、死亡] | [Distinct from player, slightly recessed] / [与玩家区分，略微靠后] |
| UI / 界面 | [Button clicks, menu transitions, notifications] / [按钮点击、菜单过渡、通知] | [Clean, subtle, never annoying on repeat] / [干净、微妙、重复不恼人] |
| Environment / 环境 | [Ambient loops, weather, objects] / [环境循环、天气、物体] | [Immersive, layered, spatial] / [沉浸式、分层、空间化] |
| Feedback / 反馈 | [Damage taken, item pickup, level up] / [受到伤害、物品拾取、升级] | [Clear, satisfying, non-fatiguing] / [清晰、令人满意、不易疲劳] |

### Audio Feedback Priority / 音频反馈优先级
When multiple sounds compete, this priority determines what plays: / 当多个声音竞争时，此优先级决定播放什么：
1. Player damage / critical warnings (always audible) / 玩家伤害/关键警告（始终可听）
2. Player actions (attacks, abilities) / 玩家动作（攻击、能力）
3. Enemy actions (nearby enemies first) / 敌人动作（先处理附近的敌人）
4. UI feedback / 界面反馈
5. Environment / ambient / 环境/环境音

### SFX Rules / 音效规则
- [Rule about repetition, e.g., "Every SFX with >3 plays/minute needs 3+ variations"] / [关于重复的规则，例如，"每分钟播放超过3次的每个音效需要3+个变体"]
- [Rule about spatial audio, e.g., "All gameplay SFX must be 3D positioned, UI SFX are 2D"] / [关于空间音频的规则，例如，"所有游戏玩法音效必须是3D定位，界面音效是2D"]
- [Rule about ducking, e.g., "Player hit SFX ducks all other SFX by 3dB for 200ms"] / [关于闪避的规则，例如，"玩家击中音效使所有其他音效闪避3dB，持续200毫秒"]
- [Rule about response time, e.g., "Action SFX must trigger within 1 frame of the action"] / [关于响应时间的规则，例如，"动作音效必须在动作后1帧内触发"]

---

## Mixing / 混音

### Mix Bus Structure / 混音总线结构
| Bus / 总线 | Content / 内容 | Target Level / 目标电平 |
| ---- | ---- | ---- |
| Master / 主总线 | Everything / 所有内容 | 0 dB |
| Music / 音乐 | All music tracks / 所有音乐轨道 | [target dBFS] / [目标dBFS] |
| SFX / 音效 | All sound effects / 所有音效 | [target dBFS] / [目标dBFS] |
| Dialogue / 对话 | All voice/narration / 所有语音/旁白 | [target dBFS] / [目标dBFS] |
| UI / 界面 | All interface sounds / 所有界面声音 | [target dBFS] / [目标dBFS] |
| Ambient / 环境 | Environment loops / 环境循环 | [target dBFS] / [目标dBFS] |

### Mixing Rules / 混音规则
- Dialogue always takes priority — duck music and SFX during dialogue / 对话始终优先——对话期间闪避音乐和音效
- Music should be felt, not dominate — if players can't hear SFX over music, music is too loud / 音乐应该被感受到，而不是主导——如果玩家在音乐中听不到音效，音乐就太响了
- Master output must never clip — use a limiter on the master bus / 主输出绝不能削波——在主总线上使用限制器
- All volumes must be adjustable by the player (per bus) / 所有音量必须可由玩家调整（按总线）
- Default mix should sound good on both speakers and headphones / 默认混音在扬声器和耳机上听起来都应该好

### Dynamic Range / 动态范围
- [Specify loudness targets, e.g., "Target -14 LUFS integrated, -1 dBTP true peak"] / [指定响度目标，例如，"目标-14 LUFS 集成，-1 dBTP 真峰值"]
- [Specify compression policy, e.g., "Light compression on SFX bus, no compression on music"] / [指定压缩策略，例如，"音效总线轻压缩，音乐不压缩"]

---

## Technical Specifications / 技术规格

### Format Requirements / 格式要求
| Type / 类型 | Format / 格式 | Sample Rate / 采样率 | Bit Depth / 位深度 | Notes / 说明 |
| ---- | ---- | ---- | ---- | ---- |
| Music / 音乐 | [OGG/WAV] | [44.1/48 kHz] | [16/24 bit] | [Streaming from disk] / [从磁盘流式传输] |
| SFX / 音效 | [WAV/OGG] | [44.1/48 kHz] | [16 bit] | [Loaded into memory] / [加载到内存] |
| Ambient / 环境 | [OGG] | [44.1 kHz] | [16 bit] | [Streaming, loopable] / [流式传输，可循环] |
| Dialogue / 对话 | [OGG/WAV] | [44.1 kHz] | [16 bit] | [Streaming] / [流式传输] |

### Naming Convention / 命名约定
`[category]_[subcategory]_[name]_[variation].ext`
- Example: `sfx_weapon_sword_swing_01.wav` / 示例：`sfx_weapon_sword_swing_01.wav`
- Example: `music_exploration_forest_loop.ogg` / 示例：`music_exploration_forest_loop.ogg`
- Example: `amb_environment_cave_drip_loop.ogg` / 示例：`amb_environment_cave_drip_loop.ogg`

### Memory Budget / 内存预算
- Total audio memory: [target, e.g., 128 MB] / 总音频内存：[目标，例如，128 MB]
- SFX pool: [target] / 音效池：[目标]
- Music streaming buffer: [target] / 音乐流缓冲区：[目标]
- Voice streaming buffer: [target] / 语音流缓冲区：[目标]

---

## Accessibility / 无障碍性

- All critical audio cues must have visual alternatives (subtitles, screen flash, icon) / 所有关键音频提示必须有视觉替代（字幕、屏幕闪烁、图标）
- Mono audio option for hearing-impaired players / 为听力受损玩家提供单声道音频选项
- Separate volume controls for all buses / 所有总线分开的音量控制
- Option to disable sudden loud sounds / 禁用突然响亮声音的选项
- Subtitle support for all dialogue with speaker identification / 所有对话的字幕支持，带说话者标识