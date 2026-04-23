# Physics Module - API Reference

## Module Info
- **Path**: `cocos/physics`
- **Language**: TypeScript
- **Files**: ~128 TS files
- **Backend Engine**: Cannon.js

## Exported APIs

| Class | Description |
|-------|-------------|
| `RigidBody` | Rigid body component, controls physical motion (type, mass, velocity, force) |
| `Collider` | Collider component, defines collision shape |
| `PhysicsWorld` | Physics world, manages simulation stepping and global parameters |
| `Joint` | Joint component, constrains relative motion between rigid bodies |

## Public Functions

| Function | Description |
|----------|-------------|
| `raycast(ray, mask, maxDistance)` | Raycast detection, returns closest hit result |
| `sweepTest(shape, from, to)` | Sweep test, detects collisions along a movement path |
| `overlapTest(colliderA, colliderB)` | Overlap test, checks if two colliders intersect |

## Dependencies
- `core` — Component base class, Node

## Design Patterns

| Pattern | Use Case |
|---------|----------|
| component-based | RigidBody/Collider as Components |
| physics-integration | Cannon.js backend drives physics simulation |

## Naming Conventions
- Classes: PascalCase (e.g., `RigidBody`)
- Functions: camelCase (e.g., `raycast`)
- Constants: UPPER_CASE
