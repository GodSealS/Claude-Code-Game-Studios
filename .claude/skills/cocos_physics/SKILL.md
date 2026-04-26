---
name: cocos_physics
description: Cocos Creator 3D physics engine expert. Triggers when users need to handle RigidBody, Collider, PhysicsWorld, Joint, raycast, collision detection, rigid body dynamics, 3D physics simulation. 当用户需要处理刚体、碰撞体、射线检测、3D物理模拟等物理相关功能时触发此 Skill。
---

# Physics - Cocos Creator 3D Physics Engine

## Overview

The Cocos Creator 3D physics module (`cocos/physics`) provides 3D physics simulation based on Cannon.js, supporting rigid body dynamics, collision detection, and joint systems.

## Domain Knowledge

### Core Design Patterns
- **component-based** — Physics components (RigidBody, Collider) mounted on Nodes
- **physics-integration** — Physics simulation driven by the Cannon.js backend

### Key Concepts
- `RigidBody` — Rigid body component, controls physical motion properties
- `Collider` — Collider component, defines collision shapes
- `PhysicsWorld` — Physics world, manages all physics objects and simulation stepping
- `Joint` — Joint component, constrains relative motion between two rigid bodies

## Key APIs

### Classes
- `RigidBody` — Rigid body (mass, velocity, force, damping)
- `Collider` — Collider (Box, Sphere, Cylinder, etc.)
- `PhysicsWorld` — Physics world (gravity, stepping, debugging)
- `Joint` — Joint (Hinge, Distance, Spring, etc.)

### Functions
- `raycast()` — Raycast detection, returns hit information
- `sweepTest()` — Sweep test, detects collisions along a path
- `overlapTest()` — Overlap test, checks if two objects intersect

## Dependencies
- Required modules: `core`
- Backend engine: Cannon.js

## Code Examples

```typescript
import { RigidBody, BoxCollider, PhysicsSystem } from 'cc';

// Add rigid body
const rigidBody = node.addComponent(RigidBody);
rigidBody.type = RigidBody.Type.DYNAMIC;
rigidBody.mass = 1.0;

// Add collider
const collider = node.addComponent(BoxCollider);
collider.size = new Vec3(1, 1, 1);
collider.on('onCollisionEnter', (event) => {
    console.log('Collision detected:', event.otherCollider.node.name);
});

// Raycast
const ray = new Ray(origin, direction);
const hitResult = PhysicsSystem.instance.raycast(ray);
if (hitResult) {
    console.log('Hit:', hitResult.node.name, hitResult.distance);
}
```

## Usage Guide

### When to Use This Skill
- Adding 3D rigid bodies and colliders
- Implementing character collision detection and physics interaction
- Configuring physics world parameters (gravity, step size)
- Using raycasts for click-picking
- Creating joint constraints (hinges, springs, etc.)

### Best Practices
1. Use `RigidBody.Type.STATIC` for static objects to avoid unnecessary physics computation
2. Prefer simple collider shapes (Box > Sphere > Mesh)
3. Avoid heavy computation in physics callbacks; only set flags, process in `update`
4. Use `mask` for raycast filtering to reduce detection scope
5. Adjust physics step size (fixedDeltaTime) to balance precision and performance

### Common Tasks
- Add rigid body and collider components
- Implement character controller collision
- Configure physics collision matrix
- Raycast for object picking
- Create joint constraints
