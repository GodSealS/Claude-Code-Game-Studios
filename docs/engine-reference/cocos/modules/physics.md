# Cocos Creator — Physics Module (3D) / Cocos Creator物理模块


> **中文翻译**：本文档为Cocos Creator引擎参考文档。所有代码示例和技术术语保持英文原文。

Last verified: 2026-04-25

<!-- 核心类型 -->
## Core Types

| Type | Purpose |
|------|---------|
| `RigidBody` | Physics-driven or kinematic body |
| `Collider` | Collision shape (Box, Sphere, Capsule, Mesh) |
| `ConstantForce` | Continuous force application |
| `PhysicsSystem` | Global physics singleton |

<!-- 中文翻译 -->
## Component Setup

```typescript
import { RigidBody, BoxCollider, PhysicsSystem, PhysicsGroup } from 'cc';

// Enable physics
PhysicsSystem.instance.enable = true;
PhysicsSystem.instance.gravity = new Vec3(0, -9.81, 0);
```

<!-- 常见操作 -->
## Common Operations

```typescript
const rb = this.getComponent(RigidBody);

// Apply forces
rb.applyForce(new Vec3(0, 10, 0)); // Continuous force
rb.applyImpulse(new Vec3(0, 5, 0)); // Instant impulse
rb.setLinearVelocity(new Vec3(0, 5, 0)); // Direct velocity

// Kinematic control
rb.type = ERigidBodyType.KINEMATIC;
rb.setWorldPosition(newPosition);
```

<!-- 中文翻译 -->
## Raycasting

```typescript
const out = PhysicsSystem.instance.raycastClosest(
    new Ray(origin, direction),
    maxDistance,
    PhysicsGroup.DEFAULT
);
if (out) {
    console.log(out.collider.node.name);
}
```

<!-- 中文翻译 -->
## Collision Events

```typescript
onLoad() {
    const collider = this.getComponent(Collider);
    collider.on('onTriggerEnter', this.onTriggerEnter, this);
    collider.on('onCollisionEnter', this.onCollisionEnter, this);
}

onTriggerEnter(event: ITriggerEvent) {
    // Trigger enter (no physics response)
}

onCollisionEnter(event: ICollisionEvent) {
    // Collision enter (with physics response)
}
```

<!-- 陷阱 -->
## Pitfalls

- WRONG: Modifying `position` directly on dynamic `RigidBody`
- RIGHT: Use `applyForce()`, `setLinearVelocity()`, or switch to kinematic
- WRONG: Raycasting every frame without layer masking
- RIGHT: Use `PhysicsGroup` to filter raycasts
