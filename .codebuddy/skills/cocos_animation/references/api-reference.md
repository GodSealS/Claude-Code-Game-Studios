# Animation Module - API Reference

<!-- 模块信息 -->
## Module Info
- **Path**: `cocos/animation`
- **Language**: TypeScript
- **Files**: ~150 TS files

<!-- 导出 API -->
## Exported APIs

| Class | Description |
|-------|-------------|
| `AnimationClip` | Animation clip, stores keyframe curve data |
| `AnimationState` | Animation state, wraps playback parameters (speed, loop, blend weight) |
| `Animation` | Animation component, manages a collection of AnimationStates |
| `SkeletonAnimation` | Skeletal animation component, handles bone skinning animation |

<!-- 公共函数 -->
## Public Functions

| Function | Description |
|----------|-------------|
| `playAnimation()` | Play an animation clip by name |
| `stopAnimation()` | Stop the currently playing animation |
| `crossFade()` | Cross-fade to a target animation |

<!-- 依赖 -->
## Dependencies
- `core` — Base component system, Node
- `scene-graph` — Scene node tree

<!-- 设计模式 -->
## Design Patterns

| Pattern | Use Case |
|---------|----------|
| component-based | Animation as a Component mounted on Node |
| event-driven | Animation play/finish/switch event notifications |
| state-machine | Animation FSM for managing complex animation transition logic |

<!-- 命名约定 -->
## Naming Conventions
- Classes: PascalCase (e.g., `AnimationClip`)
- Functions: camelCase (e.g., `playAnimation`)
- Constants: UPPER_CASE
