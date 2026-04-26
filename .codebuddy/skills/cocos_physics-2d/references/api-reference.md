# Physics 2D Module - API Reference

<!-- 模块信息 -->
## Module Info
- **Path**: `cocos/physics-2d`
- **Language**: TypeScript
- **Files**: ~99 TS files
- **Backend Engine**: Box2D

<!-- 导出 API -->
## Exported APIs

| Class | Description |
|-------|-------------|
| `RigidBody2D` | 2D rigid body component |
| `Collider2D` | 2D collider base class |
| `PhysicsWorld2D` | 2D physics world |

<!-- 公共函数 -->
## Public Functions

| Function | Description |
|----------|-------------|
| `raycast2D(p1, p2)` | 2D raycast detection |
| `testPoint(point)` | Test if a point is inside a collider |

<!-- 依赖 -->
## Dependencies
- `core` — Component base class, Node

<!-- 设计模式 -->
## Design Patterns

| Pattern | Use Case |
|---------|----------|
| component-based | RigidBody2D/Collider2D as Components |
| 2d-physics | Box2D backend drives 2D physics simulation |

<!-- 命名约定 -->
## Naming Conventions
- Classes: PascalCase (e.g., `RigidBody2D`)
- Functions: camelCase (e.g., `raycast2D`)
- Constants: UPPER_CASE
