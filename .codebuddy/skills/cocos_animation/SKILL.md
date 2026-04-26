---
name: cocos_animation
description: Cocos Creator animation system expert. Triggers when users need to handle AnimationClip, AnimationState, SkeletonAnimation, animation state machines, skeletal animation, animation blending (crossFade), keyframe animation. 当用户需要处理动画剪辑、骨骼动画、动画状态机、动画混合等动画相关功能时触发此 Skill。
---

# Animation - Cocos Creator Animation System / 动画系统

## Overview / 概述

The Cocos Creator animation module (`cocos/animation`) provides a complete animation system supporting skeletal animation, keyframe animation, and state-machine-driven animation blending.

> **中文翻译**：Cocos Creator动画模块(`cocos/animation`)提供完整的动画系统，支持骨骼动画、关键帧动画和状态机驱动的动画混合。

## Domain Knowledge / 领域知识

### Core Design Patterns / 核心设计模式
- **component-based** — Animation functionality mounted on Nodes as Components / 基于组件 — 动画功能以组件形式挂载在节点上
- **event-driven** — Animation callbacks driven by the event system / 事件驱动 — 动画回调由事件系统驱动
- **state-machine** — State machine for managing animation state transitions / 状态机 — 管理动画状态转换的状态机

### Key Concepts / 关键概念
- `AnimationClip` — Animation clip, stores keyframe data / 动画剪辑，存储关键帧数据
- `AnimationState` — Animation state, controls playback parameters for a single clip / 动画状态，控制单个剪辑的播放参数
- `Animation` — Animation component, manages multiple AnimationStates / 动画组件，管理多个动画状态
- `SkeletonAnimation` — Skeletal animation component, handles bone skinning / 骨骼动画组件，处理骨骼蒙皮

## Key APIs / 关键API

### Classes / 类
- `AnimationClip` — Animation clip data container / 动画剪辑数据容器
- `AnimationState` — Animation state controller / 动画状态控制器
- `Animation` — Animation component (mounted on Node) / 动画组件（挂载在节点上）
- `SkeletonAnimation` — Skeletal animation component / 骨骼动画组件

### Functions / 函数
- `playAnimation()` — Play a specified animation / 播放指定动画
- `stopAnimation()` — Stop the current animation / 停止当前动画
- `crossFade()` — Cross-fade between animations / 动画之间交叉淡入淡出

## Dependencies / 依赖
- Required modules: `core`, `scene-graph` / 必需模块：`core`、`scene-graph`

## Code Examples / 代码示例

```typescript
import { Animation, AnimationClip, AnimationState } from 'cc';

// Get animation component
const animation = node.getComponent(Animation);

// Play animation
animation.play('walk');

// Cross-fade to new animation
animation.crossFade('run', 0.3);

// Listen for animation events
animation.on(Animation.EventType.FINISHED, () => {
    console.log('Animation finished');
});
```

## Usage Guide / 使用指南

### When to Use This Skill / 何时使用此技能
- Creating or modifying animation components / 创建或修改动画组件
- Implementing character animation state machines / 实现角色动画状态机
- Handling skeletal animation and skinning / 处理骨骼动画和蒙皮
- Optimizing animation performance (animation batching, GPU skeletal animation) / 优化动画性能（动画批处理、GPU骨骼动画）

### Best Practices / 最佳实践
1. Use `crossFade()` for smooth animation transitions instead of abrupt switching / 使用`crossFade()`实现平滑动画过渡，而非突然切换
2. Build state machines for common animation states rather than manually managing playback logic / 为常用动画状态构建状态机，而非手动管理播放逻辑
3. Use `SkeletonAnimation` for skeletal animation, `Animation` for keyframe animation / 骨骼动画使用`SkeletonAnimation`，关键帧动画使用`Animation`
4. Handle animation event callbacks through the event-driven pattern / 通过事件驱动模式处理动画事件回调

### Common Tasks / 常见任务
- Add character idle/walk/run animations / 添加角色待机/行走/奔跑动画
- Implement animation state machines (FSM) / 实现动画状态机（FSM）
- Configure animation blend trees / 配置动画混合树
- Handle animation event callbacks / 处理动画事件回调