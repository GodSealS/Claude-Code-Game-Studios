---
name: cocos_physics
description: Cocos Creator 3D physics engine expert. Triggers when users need to handle RigidBody, Collider, PhysicsWorld, Joint, raycast, collision detection, rigid body dynamics, 3D physics simulation. 当用户需要处理刚体、碰撞体、射线检测、3D物理模拟等物理相关功能时触发此 Skill。
allowed-tools: Read, Grep
argument-hint: ""
user-invocable: false
---

# Physics - Cocos Creator 3D Physics Engine

> **READY**: Skill loaded — provides Cocos Creator 3D physics domain knowledge.

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
- `PhysicsSystem` — Global physics system singleton (gravity, fixedTimeStep, raycast)

## Key APIs

### Classes
- `RigidBody` — Rigid body (mass, velocity, force, damping)
- `Collider` — Collider (Box, Sphere, Cylinder, etc.)
- `PhysicsWorld` — Physics world (gravity, stepping, debugging)
- `Joint` — Joint (HingeJoint, FixedJoint, PointToPointJoint)

### Functions
- `PhysicsSystem.instance.raycast()` — Raycast detection, returns hit information
- `PhysicsSystem.instance.sweepTest()` — Sweep test, detects collisions along a path
- `PhysicsSystem.instance.overlapTest()` — Overlap test, checks if two objects intersect

## Dependencies
- Required modules: `core`
- Backend engine: Cannon.js

## Code Examples

### Rigid body and collision
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

### Joints — Hinge, Fixed, Point-to-Point
```typescript
import { HingeJoint, FixedJoint, PointToPointJoint, RigidBody } from 'cc';

// Hinge joint — door/swing mechanism
const hingeJoint = jointNode.addComponent(HingeJoint);
hingeJoint.connectedBody = otherRigidBody;
hingeJoint.anchor = new Vec3(0, 0, 0);       // Pivot point in local space
hingeJoint.axis = new Vec3(0, 1, 0);          // Rotation axis (Y = vertical hinge)
hingeJoint.enableLimit = true;
hingeJoint.minAngle = -90;                     // Min swing angle (degrees)
hingeJoint.maxAngle = 90;                      // Max swing angle (degrees)
hingeJoint.enableMotor = true;
hingeJoint.motorTargetVelocity = 30;            // Degrees per second
hingeJoint.maxMotorForce = 10;
hingeJoint.breakForce = 500;                   // Joint breaks if force exceeds

// Fixed joint — two bodies locked together
const fixedJoint = jointNode.addComponent(FixedJoint);
fixedJoint.connectedBody = otherRigidBody;
fixedJoint.breakForce = 1000;

// Point-to-Point (ball) joint
const pointJoint = jointNode.addComponent(PointToPointJoint);
pointJoint.connectedBody = otherRigidBody;
pointJoint.anchor = new Vec3(0, 1, 0);
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
6. Monitor physics performance via Cocos Creator's **built-in profiler** (F12 → Physics panel): check step time, active body count, collision pairs

### Common Tasks
- Add rigid body and collider components
- Implement character controller collision
- Configure physics collision matrix
- Raycast for object picking
- Create joint constraints (hinge doors, fixed connections, ball joints)

## Related Skills
- `cocos_physics-2d` — 2D Box2D physics for side-scrollers and platformers
- `cocos_core` — Component lifecycle, Node hierarchy for physics object management
- `cocos_3d` — Skinned mesh + physics interaction for ragdolls and hit detection
- `cocos_editor` — MCP editor operations for adding physics components visually

## Recommended Next Steps
1. Verify Cocos Creator version via `docs/engine-reference/cocos/VERSION.md`
2. For 2D physics needs, load `cocos_physics-2d` for Box2D integration
3. For physics-driven character controllers, consult `cocos_core` for lifecycle patterns
4. For physics debugging in the editor, use `cocos_editor` MCP validation tools
