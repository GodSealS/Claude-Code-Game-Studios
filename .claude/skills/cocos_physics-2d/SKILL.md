---
name: cocos_physics-2d
description: Cocos Creator 2D physics engine expert. Triggers when users need to handle RigidBody2D, Collider2D, PhysicsWorld2D, 2D collision detection, Box2D integration, 2D rigid body dynamics. 当用户需要处理2D刚体、2D碰撞检测、Box2D集成等2D物理相关功能时触发此 Skill。
---

# Physics 2D - Cocos Creator 2D Physics Engine

## Overview

The Cocos Creator 2D physics module (`cocos/physics-2d`) provides 2D physics simulation based on Box2D, supporting rigid bodies, colliders, and joint systems.

## Domain Knowledge

### Core Design Patterns
- **component-based** — Physics components mounted on Nodes
- **2d-physics** — Box2D-driven 2D physics simulation

### Key Concepts
- `RigidBody2D` — 2D rigid body component
- `Collider2D` — 2D collider component (Box, Circle, Polygon)
- `PhysicsWorld2D` — 2D physics world

## Key APIs

### Classes
- `RigidBody2D` — 2D rigid body (type, linear velocity, angular velocity, damping)
- `Collider2D` — 2D collider (BoxCollider2D, CircleCollider2D, PolygonCollider2D)
- `PhysicsWorld2D` — 2D physics world (gravity, stepping)

### Functions
- `raycast2D()` — 2D raycast detection
- `testPoint()` — Test if a point is inside a collider

## Dependencies
- Required modules: `core`
- Backend engine: Box2D

## Code Examples

```typescript
import { RigidBody2D, BoxCollider2D, EPhysics2DDrawFlags } from 'cc';

// Add 2D rigid body
const rigidBody = node.addComponent(RigidBody2D);
rigidBody.type = ERigidBody2DType.Dynamic;

// Add 2D collider
const collider = node.addComponent(BoxCollider2D);
collider.size = new Size(100, 50);
collider.apply();

// Collision callback
collider.on('onCollisionEnter', (event) => {
    console.log('2D Collision:', event.otherCollider.node.name);
});

// 2D raycast
const results = PhysicsSystem2D.instance.raycast(p1, p2);
```

## Usage Guide

### When to Use This Skill
- Adding physics effects to 2D games
- Implementing 2D collision detection and collision events
- Configuring Box2D physics world parameters
- Implementing platformer physics interaction

### Best Practices
1. Prefer simple colliders in 2D physics (Box > Circle > Polygon)
2. Call `collider.apply()` after editing collider properties
3. Enable physics debug drawing during development (`EPhysics2DDrawFlags`)
4. Do not mix 2D and 3D physics on the same node

### Common Tasks
- Add 2D rigid bodies and colliders
- Implement platformer physics
- Configure 2D collision matrix
- 2D raycast detection
