# Level: [Level Name] / 关卡：[关卡名称]

## Quick Reference / 快速参考

- **Area/Region**: [Where in the game world / 在游戏世界中的位置]
- **Type**: [Combat / Exploration / Puzzle / Hub / Boss / Mixed / 战斗 / 探索 / 解谜 / 枢纽 / BOSS / 混合]
- **Estimated Play Time**: [X-Y minutes / X-Y分钟]
- **Difficulty**: [1-10 relative scale / 1-10相对难度]
- **Prerequisite**: [What the player must have done to reach this level / 玩家解锁此关卡前必须完成的条件]
- **Status**: [Concept | Layout | Graybox | Art Pass | Polish | Final / 概念 | 布局 | 灰盒 | 美术通过 | 优化 | 最终]

## Narrative Context / 叙事背景

- **Story Moment**: [Where in the narrative arc does this level occur / 在叙事弧中的位置]
- **Narrative Purpose**: [What story beat this level delivers / 本关卡传达的叙事节拍]
- **Emotional Target**: [What the player should feel during this level / 玩家在此关卡中应有的情感体验]
- **Lore Discoveries**: [What world-building the player can find here / 玩家可在此发现的世界设定]

## Layout / 布局

### Overview Map / 概览地图

```
[ASCII diagram of the level layout. Use these symbols: / ASCII关卡布局图。使用以下符号：]
[S] = Start point / 起点
[E] = Exit/end point / 出口/终点
[C] = Combat encounter / 战斗遭遇
[P] = Puzzle / 谜题
[R] = Reward/loot / 奖励/战利品
[!] = Story beat / 故事节拍
[?] = Secret/optional / 秘密/可选内容
[>] = One-way passage / 单向通道
[=] = Two-way passage / 双向通道
[@] = NPC / NPC
[B] = Boss encounter / BOSS遭遇
```

### Critical Path / 关键路径

[The mandatory route through the level, step by step. / 穿越关卡的强制路线，逐步说明。]

1. Player enters at [S] / 玩家在[S]点进入
2. [Description of what happens along the path / 沿路径发生的事件描述]
3. Player exits at [E] / 玩家在[E]点退出

### Optional Paths / 可选路径

| Path / 路径 | Access Requirement / 访问条件 | Reward / 奖励 | Discovery Hint / 发现提示 |
|------|-------------------|--------|---------------|

### Points of Interest / 兴趣点

| Location / 位置 | Type / 类型 | Description / 描述 | Purpose / 目的 |
|----------|------|-------------|---------|

## Encounters / 遭遇

### Combat Encounters / 战斗遭遇

| ID | Position / 位置 | Enemy Composition / 敌人组成 | Difficulty / 难度 | Arena Notes / 竞技场备注 |
|----|----------|------------------|-----------|-------------|
| E-01 | [Map ref / 地图参考] | [2x Grunt, 1x Ranged / 2x杂兵, 1x远程] | 3/10 | Open area, cover on flanks / 开放区域，侧翼有掩护 |
| E-02 | [Map ref / 地图参考] | [1x Elite, 3x Grunt / 1x精英, 3x杂兵] | 5/10 | Narrow corridor, no retreat / 狭窄走廊，无法撤退 |

### Non-Combat Encounters / 非战斗遭遇

| ID | Position / 位置 | Type / 类型 | Description / 描述 | Solution Hint / 解决方案提示 |
|----|----------|------|-------------|---------------|

## Pacing Chart / 节奏图表

```
Intensity / 强度
10 |                              *
 8 |                         *   * *
 6 |            *  *        * * *   *
 4 |     *  *  * ** *   *  *
 2 | * ** ** *        * * *          *
 0 |S-----------------------------------------E
     [Start]    [Mid]              [Climax] [Exit] / [起点]    [中期]              [高潮] [出口]
```

[Describe the intended rhythm: where are the peaks, valleys, rest points? / 描述预期节奏：峰值、谷值、休息点在哪里？]

## Audio Direction / 音频指导

| Zone/Moment / 区域/时刻 | Music Track / 音乐曲目 | Ambience / 环境音效 | Key SFX / 关键音效 |
|-------------|------------|----------|---------|
| [Entry / 入口] | [Track / 曲目] | [Ambient sounds / 环境声音] | [Door opening / 开门声] |
| [Combat / 战斗] | [Combat music / 战斗音乐] | [Muted ambience / 弱化环境音] | [Combat SFX / 战斗音效] |
| [Post-combat / 战后] | [Calm transition / 平静过渡] | [Return to ambience / 回归环境音] | |

## Visual Direction / 视觉指导

- **Lighting**: [Key, fill, ambient description / 主光、补光、环境光描述]
- **Color Palette**: [Dominant colors and why / 主色调及其原因]
- **Mood Board References**: [Description of visual references / 视觉参考描述]
- **Landmarks**: [Visible navigation aids and their locations / 可见导航标志及其位置]
- **Sight Lines**: [What the player should see from key positions / 玩家从关键位置应看到的景象]

## Collectibles and Secrets / 收集品与秘密

| Item / 物品 | Location / 位置 | Visibility / 可见性 | Hint / 提示 | Required For / 所需条件 |
|------|----------|-----------|------|-------------|

## Technical Notes / 技术备注

- **Estimated Object Count**: [N / 数量]
- **Streaming Zones**: [Where to break the level for streaming / 为流式加载划分关卡的区域]
- **Performance Concerns**: [Any known heavy areas / 任何已知性能重载区域]
- **Required Systems**: [What game systems are active in this level / 此关卡中活跃的游戏系统]