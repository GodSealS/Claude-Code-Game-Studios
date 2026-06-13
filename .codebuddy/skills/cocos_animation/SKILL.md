---
name: cocos_animation
description: "Cocos Creator animation system expert. Triggers when users need to handle AnimationClip, AnimationState, SkeletonAnimation, animation state machines, skeletal animation, animation blending (crossFade), keyframe animation. 当用户需要处理动画剪辑、骨骼动画、动画状态机、动画混合等动画相关功能时触发此 Skill。"
user-invocable: false
allowed-tools: Read, Grep
argument-hint: ""
---

# Animation - Cocos Creator Animation System

> **READY**: Skill loaded — provides Cocos Creator animation system domain knowledge.

## Overview

The Cocos Creator animation module (`cocos/animation`) provides a complete animation system supporting skeletal animation, keyframe animation, state-machine-driven animation blending, animation layers, and event-driven callbacks.

## Domain Knowledge

### Core Design Patterns
- **component-based** — Animation functionality mounted on Nodes as Components
- **event-driven** — Animation callbacks driven by the event system
- **state-machine** — State machine for managing animation state transitions
- **layer-blending** — Multiple animation layers blended via weights for partial-body control

### Key Concepts
- `AnimationClip` — Animation clip, stores keyframe data
- `AnimationState` — Animation state, controls playback parameters for a single clip
- `Animation` — Animation component, manages multiple AnimationStates
- `SkeletonAnimation` — Skeletal animation component, handles bone skinning
- `Skeleton` — Bone hierarchy asset; each bone influences nearby mesh vertices via weight painting
- `AnimationGraph` — Visual state machine for defining animation transitions and conditions

## Key APIs

### Classes
- `AnimationClip` — Animation clip data container
- `AnimationState` — Animation state controller (speed, time, weight, wrapMode)
- `Animation` — Animation component (mounted on Node)
- `SkeletonAnimation` — Skeletal animation component
- `AnimationGraph` — Animation state machine graph

### Functions
- `play()` — Play a specified animation clip
- `stop()` — Stop the current animation
- `crossFade(name, duration)` — Cross-fade to target animation over duration (seconds)
- `getState(name)` — Get AnimationState by clip name for manual control
- `addClip(clip)` — Add an AnimationClip at runtime

## Dependencies
- Required modules: `core`, `scene-graph`
- Related: `cocos/3d` (SkeletonAnimation depends on skeleton/mesh from 3D rendering)

## Code Examples

### Basic animation playback and cross-fade
```typescript
import { Animation, AnimationClip, AnimationState } from 'cc';

// Get animation component
const animation = node.getComponent(Animation);

// Play animation
animation.play('walk');

// Cross-fade to new animation (smooth transition)
animation.crossFade('run', 0.3);

// Manual state control
const walkState = animation.getState('walk');
if (walkState) {
    walkState.speed = 1.5;   // 1.5x playback speed
    walkState.wrapMode = AnimationClip.WrapMode.Loop;
}
```

### State machine pattern (FSM)
```typescript
import { Animation, AnimationClip, Vec3 } from 'cc';

class CharacterAnimator {
    private animation: Animation;
    private currentState: string = '';

    constructor(anim: Animation) {
        this.animation = anim;
    }

    update(velocity: Vec3): void {
        const speed = velocity.length();
        let targetState: string;

        if (speed < 0.1) {
            targetState = 'Idle';
        } else if (speed < 5) {
            targetState = 'Walk';
        } else {
            targetState = 'Run';
        }

        if (targetState !== this.currentState) {
            this.animation.crossFade(targetState, 0.2);
            this.currentState = targetState;
        }
    }
}
```

### Skeletal animation setup
```typescript
import { SkeletonAnimation, Skeleton } from 'cc';

// Skeletal animation — for 3D characters with bone hierarchy
// Bones form a tree: root → spine → chest → arm → hand → fingers
// Each bone influences nearby mesh vertices via weight painting
const skelAnim = node.getComponent(SkeletonAnimation);
skelAnim.play('Idle');

// Cross-fade between skeletal clips
skelAnim.crossFade('Run', 0.25);

// Bone count guideline: ≤ 60 for mobile, ≤ 90 for desktop

// For skinned mesh rendering setup (MeshRenderer + skeleton),
// see cocos_3d Skill — it handles mesh asset loading and material binding.
```

### Animation layer blending
```typescript
import { Animation } from 'cc';

const animation = node.getComponent(Animation);

// Layer 0 (base): lower body — walk/run
animation.play('Walk', 0);  // clipName, layer=0

// Layer 1 (upper): upper body — aim/shoot
animation.play('Aim', 1);   // clipName, layer=1

// Adjust layer weights for dynamic blending
const baseLayer = animation.getState('Walk');
const upperLayer = animation.getState('Aim');

if (baseLayer) baseLayer.weight = 1.0;   // full lower body
if (upperLayer) upperLayer.weight = 0.6;  // partial upper body override

// Dynamic weight: smooth transition for aiming
// Increase upper body weight when player starts aiming,
// decrease when returning to idle — creates natural blending.
```

### Animation events and frame-accurate callbacks
```typescript
import { Animation, AnimationClip } from 'cc';

const animation = node.getComponent(Animation);

// 1. Lifecycle events (component-level)
animation.on(Animation.EventType.PLAY, () => {
    console.log('Animation started');
});
animation.on(Animation.EventType.FINISHED, () => {
    console.log('Animation finished');
});
animation.on(Animation.EventType.PAUSE, () => {
    console.log('Animation paused');
});

// 2. Clip-level frame events (via AnimationClip event tracks)
// In the editor: add event keyframes on specific frames of the clip,
// e.g. "Footstep" event at frame 12, "AttackHit" at frame 24.
// Then listen for them:
animation.on('Footstep', () => {
    // Play footstep sound via AudioSource
    console.log('Footstep frame reached');
});
animation.on('AttackHit', () => {
    // Trigger attack VFX particles
    console.log('Attack hit frame reached');
});

// Frame-rate independence note:
// Animation events are evaluated per-frame, so on low-FPS devices
// events may skip frames. For time-critical logic (hit detection),
// use frame-number-relative checks and avoid relying on events for
// game-state mutations that require guarantees.
```

### Animation performance optimization
```typescript
// 1. Animation LOD — reduce update frequency at distance
function updateAnimationLOD(distance: number, animState: AnimationState): void {
    if (distance > 30) {
        animState.speed = 0;          // Pause animation for far characters
    } else if (distance > 15) {
        animState.speed = 0.5;        // Half-rate update at medium distance
    } else {
        animState.speed = 1.0;        // Full rate up close
    }
}

// 2. Off-screen culling — Cocos Creator auto-culls renderers,
// but animations still tick. Disable animation components when invisible.
function onVisibilityChanged(visible: boolean, animation: Animation): void {
    if (!visible) {
        animation.stop();  // Save CPU
    } else {
        animation.play(this.currentClip);
    }
}

// 3. Animation compression — reduce keyframe count in editor:
//    - AnimationClip → Compression → reduce sample rate
//    - Consider baking secondary animations (cloth, hair physics)

// 4. Debug tools: monitor animation performance via
//    Cocos Creator's built-in profiler (F12) → "Animation" panel
//    Check: animation tick time, active animation count per frame
```

## Usage Guide

### When to Use This Skill
- Creating or modifying animation components
- Implementing character animation state machines
- Handling skeletal animation and skinning
- Configuring animation layers and blend weights
- Optimizing animation performance (LOD, culling, compression)

### Best Practices
1. Use `crossFade()` for smooth animation transitions instead of abrupt switching
2. Build state machines for common animation states rather than manually managing playback logic
3. Use `SkeletonAnimation` for skeletal animation, `Animation` for keyframe animation
4. Handle animation event callbacks through the event-driven pattern
5. Use animation layers to separate upper/lower body blending — layer 0 for base, layer 1+ for additive
6. Implement animation LOD: reduce `speed` or stop animations for distant/off-screen characters
7. Monitor animation performance via the **built-in profiler** (F12 → Animation panel) — check active clip count and tick time
8. Avoid relying on per-frame animation events for game-state-critical logic on low-FPS devices

### Common Tasks
- Add character idle/walk/run animations with cross-fade transitions
- Implement animation state machines (FSM) driven by velocity/state
- Configure animation layers and blend weights for partial-body control
- Handle animation event callbacks (footsteps, attack frames)
- Optimize animation performance with LOD and culling

## Related Skills
- `cocos_core` — Component, Node, Scene, lifecycle management
- `cocos_3d` — MeshRenderer, SkinnedMeshRenderer, skeleton/mesh loading for skeletal animation
- `cocos_rendering` — GPU skinning, animation texture baking, custom animation shaders

## Recommended Next Steps
1. Verify Cocos Creator version via `docs/engine-reference/cocos/VERSION.md`
2. For 3D skeletal animation, load `cocos_3d` for skinned mesh and skeleton setup
3. For GPU skinning and animation texture baking, load `cocos_rendering`
4. For animation-driven VFX, consult the project's particle system and AudioSource patterns
