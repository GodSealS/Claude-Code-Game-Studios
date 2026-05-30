---
name: cocos_physics-2d
description: Cocos Creator 2D physics engine expert. Triggers when users need to handle RigidBody2D, Collider2D, PhysicsWorld2D, 2D collision detection, Box2D integration, 2D rigid body dynamics. 当用户需要处理2D刚体、2D碰撞检测、Box2D集成等2D物理相关功能时触发此 Skill。
allowed-tools: Read, Grep
argument-hint: ""
user-invocable: false
---

# Physics 2D - Cocos Creator 2D Physics Engine

> **READY**: Skill loaded — provides Cocos Creator 2D physics domain knowledge.

## Overview

The Cocos Creator 2D physics module (`cocos/physics-2d`) provides 2D physics simulation based on Box2D, supporting rigid bodies, colliders, joint systems, collision filtering, and platformer mechanics.

## Domain Knowledge

### Core Design Patterns
- **component-based** — Physics components mounted on Nodes
- **2d-physics** — Box2D-driven 2D physics simulation
- **collision-filtering** — Category bits + mask bits for selective collision

### Key Concepts
- `RigidBody2D` — 2D rigid body component (Static, Dynamic, Kinematic, Animated)
- `Collider2D` — 2D collider component (Box, Circle, Polygon, Edge, Capsule)
- `PhysicsWorld2D` — 2D physics world (gravity vector, stepping, collision matrix)
- `Contact2DType` — BEGIN_CONTACT, END_CONTACT, PRE_SOLVE, POST_SOLVE

## Key APIs

### Classes
- `RigidBody2D` — 2D rigid body (type, linearVelocity, angularVelocity, damping, bullet, fixedRotation)
- `Collider2D` — 2D collider (BoxCollider2D, CircleCollider2D, PolygonCollider2D, EdgeCollider2D, CapsuleCollider2D)
- `PhysicsWorld2D` — 2D physics world (gravity, stepping)
- `Contact2DType` — Collision contact event types
- `EPhysics2DDrawFlags` — Debug draw flags for visualization

### Functions
- `PhysicsSystem2D.instance.raycast()` — 2D raycast detection (returns array of results)
- `PhysicsSystem2D.instance.testPoint()` — Test if a point is inside a collider
- `collider.group` / `collider.apply()` — Collision group + apply property changes

## Dependencies
- Required modules: `core`
- Backend engine: Box2D

## Code Examples

### Basic 2D physics setup
```typescript
import { RigidBody2D, BoxCollider2D, ERigidBody2DType, EPhysics2DDrawFlags } from 'cc';

// Add 2D rigid body
const rigidBody = node.addComponent(RigidBody2D);
rigidBody.type = ERigidBody2DType.Dynamic;

// Add 2D collider
const collider = node.addComponent(BoxCollider2D);
collider.size = new Size(100, 50);
collider.apply();

// Collision callback
collider.on(Contact2DType.BEGIN_CONTACT, (selfCollider, otherCollider, contact) => {
    console.log('2D Collision:', otherCollider.node.name);
});
```

### Platformer: ground detection and jump
```typescript
import { RigidBody2D, BoxCollider2D, ERigidBody2DType, Contact2DType, Vec2 } from 'cc';

class PlatformerCharacter {
    private rb: RigidBody2D;
    private isGrounded: boolean = false;
    private jumpForce: number = 500;
    private moveSpeed: number = 300;

    constructor(node: Node) {
        this.rb = node.getComponent(RigidBody2D);
        this.rb.type = ERigidBody2DType.Dynamic;
        this.rb.fixedRotation = true;  // No tipping over

        const collider = node.getComponent(BoxCollider2D);
        // Ground detection via collision enter/exit
        collider.on(Contact2DType.BEGIN_CONTACT, (self, other, contact) => {
            // Check if contact normal is pointing up (ground below feet)
            if (contact.getWorldManifold().normal.y > 0.5) {
                this.isGrounded = true;
            }
        });
        collider.on(Contact2DType.END_CONTACT, () => {
            this.isGrounded = false;
        });
    }

    move(horizontal: number): void {
        this.rb.linearVelocity = new Vec2(horizontal * this.moveSpeed, this.rb.linearVelocity.y);
    }

    jump(): void {
        if (!this.isGrounded) return;
        this.rb.applyLinearImpulse(new Vec2(0, this.jumpForce), this.rb.node.getWorldPosition(), true);
        this.isGrounded = false;
    }

    // Slope handling: increase gravity scale on slopes to prevent sliding
    update(dt: number): void {
        // Raycast downward for slope angle detection
        const origin = this.rb.node.getWorldPosition();
        const hit = PhysicsSystem2D.instance.raycast(
            new Vec2(origin.x, origin.y),
            new Vec2(origin.x, origin.y - 10)
        );
        if (hit && hit.length > 0) {
            this.isGrounded = true;
        }
    }
}
```

### Collision matrix and world configuration
```typescript
import { PhysicsSystem2D, RigidBody2D } from 'cc';

// Configure 2D physics world
const physics = PhysicsSystem2D.instance;
physics.gravity = new Vec2(0, -980);  // Custom gravity

// Collision groups: define categories
const GROUP_PLAYER = 1 << 0;   // 0x0001
const GROUP_ENEMY = 1 << 1;    // 0x0002
const GROUP_GROUND = 1 << 2;   // 0x0004
const GROUP_PICKUP = 1 << 3;   // 0x0008

// Player collider: collides with ground + enemy + pickup
playerCollider.group = GROUP_PLAYER;
playerCollider.apply();  // Must call after group change

// Enemy collider: collides with ground + player
enemyCollider.group = GROUP_ENEMY;

// Ground: only collides with everything (default)
groundCollider.group = GROUP_GROUND;

// Pickup: only collides with player (trigger-style)
pickupCollider.group = GROUP_PICKUP;
pickupCollider.sensor = true;  // No physical response, only events
```

### One-way platforms (pass-through from below)
```typescript
import { RigidBody2D, BoxCollider2D, Contact2DType, Vec2 } from 'cc';

// One-way platform: player falls through from below, lands from above
class OneWayPlatform {
    private platformCollider: BoxCollider2D;

    setup(platformNode: Node): void {
        this.platformCollider = platformNode.getComponent(BoxCollider2D);

        this.platformCollider.on(Contact2DType.PRE_SOLVE, (self, other, contact) => {
            const otherRB = other.node.getComponent(RigidBody2D);
            if (!otherRB) return;

            // Check if player is below the platform (trying to jump through)
            const playerY = other.node.getWorldPosition().y;
            const platformTop = self.node.getWorldPosition().y + (self.node.getComponent(UITransform)?.height ?? 0) / 2;

            // If player is below platform top, disable this contact (pass through)
            if (playerY < platformTop) {
                contact.disabled = true;
            }
            // If player is above and falling (vy < 0), allow landing
            // Edge case: player standing on platform → normal collision
        });
    }
}
```

### Physics debug visualization
```typescript
import { PhysicsSystem2D, EPhysics2DDrawFlags } from 'cc';

// Enable debug drawing during development
PhysicsSystem2D.instance.debugDrawFlags =
    EPhysics2DDrawFlags.Shape |             // Show collider shapes
    EPhysics2DDrawFlags.Joint |             // Show joints
    EPhysics2DDrawFlags.Pair |              // Show contact pairs
    EPhysics2DDrawFlags.CenterOfMass |      // Show CoM points
    EPhysicsSystem2D.instance.debugDrawFlags = EPhysics2DDrawFlags.Aabb;  // Show bounding boxes
```

## Usage Guide

### When to Use This Skill
- Adding physics effects to 2D games
- Implementing 2D collision detection and collision events
- Configuring Box2D physics world parameters
- Implementing platformer physics interaction (ground detection, jump, slopes)
- Setting up collision filtering (categories + masks)
- Creating one-way platforms and passthrough mechanics

### Best Practices
1. Prefer simple colliders in 2D physics (Box > Circle > Polygon); Polygon only for complex shapes
2. Call `collider.apply()` after editing collider properties (group, sensor, size)
3. Enable physics debug drawing during development (`EPhysics2DDrawFlags`)
4. Do not mix 2D and 3D physics on the same node
5. Set `fixedRotation = true` on player rigidbodies to prevent tipping
6. Use `bullet = true` on fast-moving RigidBody2D to prevent tunneling
7. Set `allowSleep = true` on static/resting bodies to reduce physics overhead
8. Use collision groups/layers to minimize unnecessary collision checks

### Common Tasks
- Add 2D rigid bodies and colliders
- Implement platformer physics with ground detection and jump
- Configure 2D collision matrix via group bits
- 2D raycast detection
- Create one-way platforms
- Debug physics visually with EPhysics2DDrawFlags

## Related Skills
- `cocos_physics` — 3D physics for Cannon.js-driven simulation
- `cocos_core` — Component lifecycle, Node hierarchy for physics object management
- `cocos_2d` — 2D rendering and sprite integration with physics bodies

## Recommended Next Steps
1. Verify Cocos Creator version via `docs/engine-reference/cocos/VERSION.md`
2. For 3D physics needs, load `cocos_physics` for Cannon.js integration
3. For character rendering (sprites, animations), load `cocos_2d` and `cocos_animation`
4. Enable `EPhysics2DDrawFlags` during development for visual collision debugging
