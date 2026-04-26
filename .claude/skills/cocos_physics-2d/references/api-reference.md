# Physics 2D Module - API Reference

## Module Info
- **Path**: `cocos/physics-2d`
- **Language**: TypeScript
- **Files**: ~99 TS files
- **Backend Engine**: Box2D

## Exported APIs

| Class | Description |
|-------|-------------|
| `RigidBody2D` | 2D rigid body component |
| `Collider2D` | 2D collider base class |
| `PhysicsWorld2D` | 2D physics world |

## Public Functions

| Function | Description |
|----------|-------------|
| `raycast2D(p1, p2)` | 2D raycast detection |
| `testPoint(point)` | Test if a point is inside a collider |

## Dependencies
- `core` — Component base class, Node

## Design Patterns

| Pattern | Use Case |
|---------|----------|
| component-based | RigidBody2D/Collider2D as Components |
| 2d-physics | Box2D backend drives 2D physics simulation |

## Naming Conventions
- Classes: PascalCase (e.g., `RigidBody2D`)
- Functions: camelCase (e.g., `raycast2D`)
- Constants: UPPER_CASE
