# Cocos Creator — Navigation Module / Cocos Creator导航模块


> **中文翻译**：本文档为Cocos Creator引擎参考文档。所有代码示例和技术术语保持英文原文。

Last verified: 2026-04-25

<!-- 核心类型 -->
## Core Types

| Type | Purpose |
|------|---------|
| `NavMesh` | Navigation mesh asset for pathfinding |
| `NavMeshAgent` | Component for agents that navigate |
| `NavMeshObstacle` | Dynamic obstacles that cut navmesh |

<!-- 设置 -->
## Setup

1. Bake NavMesh in editor: Window → Navigation
2. Add `NavMeshAgent` to moving entities
3. Add `NavMeshObstacle` to dynamic barriers

<!-- 常见操作 -->
## Common Operations

```typescript
import { NavMeshAgent } from 'cc';

const agent = this.getComponent(NavMeshAgent);

// Set destination
agent.setDestination(targetPosition);

// Check remaining distance
if (agent.remainingDistance < 0.5) {
    // Reached destination
}

// Speed and steering
agent.speed = 5.0;
agent.acceleration = 8.0;
agent.angularSpeed = 120.0;
```

<!-- 中文翻译 -->
## 3.8+ Notes

- NavMesh baking improved for large scenes
- `NavMeshAgent` supports off-mesh links for jumps/teleporters

<!-- 陷阱 -->
## Pitfalls

- WRONG: Calling `setDestination()` every frame
- RIGHT: Set once when target changes; agent handles path following
- WRONG: Ignoring `agent.pathPending`
- RIGHT: Wait for path calculation before checking `remainingDistance`
