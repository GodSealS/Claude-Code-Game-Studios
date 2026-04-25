# Cocos Creator — Animation Module

Last verified: 2026-04-25

## Core Types

| Type | Purpose |
|------|---------|
| `Animation` | Component that plays `AnimationClip`s on a `Node` |
| `AnimationClip` | Keyframe data asset; created in editor or runtime |
| `AnimationState` | Runtime playback state (speed, time, wrap mode) |
| `SkeletalAnimation` | Skinning/ skeletal mesh animation for 3D |
| `AnimationController` | State machine graph (Mecanim-like) |

## Common Operations

```typescript
import { Animation, animation } from 'cc';

// Play clip by name
const anim = this.getComponent(Animation);
anim.play('walk');

// Cross-fade (smooth transition)
anim.crossFade('run', 0.3); // 0.3s transition

// Animation events (editor-defined or runtime)
// In editor: add Event keyframe on clip timeline
// Runtime callback:
anim.on(Animation.EventType.FINISHED, this.onAnimFinished, this);

// AnimationController (state machine)
const ctrl = this.getComponent(animation.AnimationController);
ctrl.setValue('speed', 5.0); // Set parameter
```

## 3.8+ Changes

- `AnimationController` introduced for complex state machines
- `SkeletalAnimation` supports up to 4 bone influences per vertex
- Animation clips support embedded events more reliably

## Pitfalls

- WRONG: Calling `play()` every frame in `update()`
- RIGHT: Trigger state changes once, let engine interpolate
- WRONG: Animating `position` for UI elements
- RIGHT: Use `Tween` or `UITransform` animations for UI
