# Level: [Level Name / 关卡名称]

## Quick Reference / 快速参考

- **Area/Region / 区域**: [Where in the game world / 游戏世界中的位置]
- **Type / 类型**: [Combat / Exploration / Puzzle / Hub / Boss / Mixed / 战斗 / 探索 / 解谜 / 中心 / Boss / 混合]
- **Estimated Play Time / 预计游戏时间**: [X-Y minutes / X-Y分钟]
- **Difficulty / 难度**: [1-10 relative scale / 1-10相对等级]
- **Prerequisite / 前提**: [What the player must have done to reach this level / 玩家必须完成什么才能到达此关卡]
- **Status / 状态**: [Concept | Layout | Graybox | Art Pass | Polish | Final / 概念 | 布局 | 灰盒 | 美术 | 打磨 | 最终]

## Narrative Context / 叙事背景

- **Story Moment / 故事时刻**: [Where in the narrative arc does this level occur / 此关卡发生在叙事弧的何处]
- **Narrative Purpose / 叙事目的**: [What story beat this level delivers / 此关卡传达什么故事节拍]
- **Emotional Target / 情感目标**: [What the player should feel during this level / 玩家在此关卡期间应该感受到什么]
- **Lore Discoveries / 背景发现**: [What world-building the player can find here / 玩家可以在这里找到什么世界观构建内容]

## Layout / 布局

### Overview Map / 概览地图

```
[ASCII diagram of the level layout. Use these symbols: / ASCII关卡布局图。使用以下符号：]
[S] = Start point / 起点
[E] = Exit/end point / 出口/终点
[C] = Combat encounter / 战斗遭遇
[P] = Puzzle / 解谜
[R] = Reward/loot / 奖励/战利品
[!] = Story beat / 故事节拍
[?] = Secret/optional / 秘密/可选
[>] = One-way passage / 单向通道
[=] = Two-way passage / 双向通道
[@] = NPC
[B] = Boss encounter / Boss遭遇
```

### Critical Path / 关键路径

[The mandatory route through the level, step by step. / 逐步说明通过关卡的必经之路。]

1. Player enters at [S] / 玩家从[S]进入
2. [Description of what happens along the path / 路径上发生的事情的描述]
3. Player exits at [E] / 玩家从[E]退出

### Optional Paths / 可选路径

| Path / 路径 | Access Requirement / 进入要求 | Reward / 奖励 | Discovery Hint / 发现提示 |
|------|-------------------|--------|---------------|

### Points of Interest / 兴趣点

| Location / 位置 | Type / 类型 | Description / 描述 | Purpose / 用途 |
|----------|------|-------------|---------|

## Encounters / 遭遇

### Combat Encounters / 战斗遭遇

| ID | Position / 位置 | Enemy Composition / 敌人构成 | Difficulty / 难度 | Arena Notes / 战场备注 |
|----|----------|------------------|-----------|-------------|
| E-01 | [Map ref / 地图参考] | [2x Grunt / 2个杂兵, 1x Ranged / 1个远程] | 3/10 | Open area, cover on flanks / 开阔区域，侧翼有掩体 |
| E-02 | [Map ref / 地图参考] | [1x Elite / 1个精英, 3x Grunt / 3个杂兵] | 5/10 | Narrow corridor, no retreat / 狭窄走廊，无法撤退 |

### Non-Combat Encounters / 非战斗遭遇

| ID | Position / 位置 | Type / 类型 | Description / 描述 | Solution Hint / 解决方案提示 |
|----|----------|------|-------------|---------------|

## Pacing Chart / 节奏图

```
Intensity / 强度
10 |                              *
 8 |                         *   * *
 6 |            *  *        * * *   *
 4 |     *  *  * ** *   *  *
 2 | * ** ** *        * * *          *
 0 |S-----------------------------------------E
     [Start / 开始]    [Mid / 中段]              [Climax / 高潮] [Exit / 出口]
```

[Describe the intended rhythm: where are the peaks, valleys, rest points? / 描述预期的节奏：高峰、低谷、休息点在哪里？]

## Audio Direction / 音频方向

| Zone/Moment / 区域/时刻 | Music Track / 音乐轨道 | Ambience / 环境音 | Key SFX / 关键音效 |
|-------------|------------|----------|---------|
| [Entry / 入口] | [Track / 轨道] | [Ambient sounds / 环境音效] | [Door opening / 开门] |
| [Combat / 战斗] | [Combat music / 战斗音乐] | [Muted ambience / 静音环境] | [Combat SFX / 战斗音效] |
| [Post-combat / 战后] | [Calm transition / 平静过渡] | [Return to ambience / 返回环境音] | |

## Visual Direction / 视觉方向

- **Lighting / 光照**: [Key, fill, ambient description / 主光、补光、环境光描述]
- **Color Palette / 调色板**: [Dominant colors and why / 主导颜色及原因]
- **Mood Board References / 情绪板参考**: [Description of visual references / 视觉参考的描述]
- **Landmarks / 地标**: [Visible navigation aids and their locations / 可见导航辅助及其位置]
- **Sight Lines / 视线**: [What the player should see from key positions / 玩家在关键位置应该看到什么]

## Collectibles and Secrets / 收集品和秘密

| Item / 物品 | Location / 位置 | Visibility / 可见性 | Hint / 提示 | Required For / 所需用于 |
|------|----------|-----------|------|-------------|

## Technical Notes / 技术说明

- **Estimated Object Count / 估计对象数量**: [N]
- **Streaming Zones / 流式传输区域**: [Where to break the level for streaming / 为流式传输分割关卡的位置]
- **Performance Concerns / 性能问题**: [Any known heavy areas / 任何已知的繁重区域]
- **Required Systems / 所需系统**: [What game systems are active in this level / 此关卡中激活的游戏系统]
