# Cocos Creator — Physics Module (3D)

Last verified: 2026-04-25

## Core Types

| Type | Purpose |
|------|---------|
| `RigidBody` | Physics-driven or kinematic body |
| `Collider` | Collision shape (Box, Sphere, Capsule, Mesh) |
| `ConstantForce` | Continuous force application |
| `PhysicsSystem` | Global physics singleton |

## Component Setup

```typescript
import { RigidBody, BoxCollider, PhysicsSystem, PhysicsGroup } from 'cc';

// Enable physics
PhysicsSystem.instance.enable = true;
PhysicsSystem.instance.gravity = new Vec3(0, -9.81, 0);
```

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

## Pitfalls

- WRONG: Modifying `position` directly on dynamic `RigidBody`
- RIGHT: Use `applyForce()`, `setLinearVelocity()`, or switch to kinematic
- WRONG: Raycasting every frame without layer masking
- RIGHT: Use `PhysicsGroup` to filter raycasts
