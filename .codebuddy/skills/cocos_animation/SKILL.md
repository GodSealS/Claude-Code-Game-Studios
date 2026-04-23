---
name: cocos_animation
description: Cocos Creator animation system expert. Triggers when users need to handle AnimationClip, AnimationState, SkeletonAnimation, animation state machines, skeletal animation, animation blending (crossFade), keyframe animation. 当用户需要处理动画剪辑、骨骼动画、动画状态机、动画混合等动画相关功能时触发此 Skill。
---

# Animation - Cocos Creator Animation System

## Overview

The Cocos Creator animation module (`cocos/animation`) provides a complete animation system supporting skeletal animation, keyframe animation, and state-machine-driven animation blending.

## Domain Knowledge

### Core Design Patterns
- **component-based** — Animation functionality mounted on Nodes as Components
- **event-driven** — Animation callbacks driven by the event system
- **state-machine** — State machine for managing animation state transitions

### Key Concepts
- `AnimationClip` — Animation clip, stores keyframe data
- `AnimationState` — Animation state, controls playback parameters for a single clip
- `Animation` — Animation component, manages multiple AnimationStates
- `SkeletonAnimation` — Skeletal animation component, handles bone skinning

## Key APIs

### Classes
- `AnimationClip` — Animation clip data container
- `AnimationState` — Animation state controller
- `Animation` — Animation component (mounted on Node)
- `SkeletonAnimation` — Skeletal animation component

### Functions
- `playAnimation()` — Play a specified animation
- `stopAnimation()` — Stop the current animation
- `crossFade()` — Cross-fade between animations

## Dependencies
- Required modules: `core`, `scene-graph`

## Code Examples

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

## Usage Guide

### When to Use This Skill
- Creating or modifying animation components
- Implementing character animation state machines
- Handling skeletal animation and skinning
- Optimizing animation performance (animation batching, GPU skeletal animation)

### Best Practices
1. Use `crossFade()` for smooth animation transitions instead of abrupt switching
2. Build state machines for common animation states rather than manually managing playback logic
3. Use `SkeletonAnimation` for skeletal animation, `Animation` for keyframe animation
4. Handle animation event callbacks through the event-driven pattern

### Common Tasks
- Add character idle/walk/run animations
- Implement animation state machines (FSM)
- Configure animation blend trees
- Handle animation event callbacks
