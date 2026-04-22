---
name: /wechat-physics-box2d
description: "Initialize Box2D WASM physics engine for WeChat Mini Games, create 2D physics world, configure rigid bodies, collisions, and joints via the unified IPhysicsWorld interface. / 初始化微信小游戏 Box2D WASM 物理引擎，创建 2D 物理世界，通过统一 IPhysicsWorld 接口配置刚体、碰撞和关节。"
agent: wechat-minigame-specialist
---

# /wechat-physics-box2d

Initialize and configure the Box2D physics engine (via WASM) for 2D physics simulation in WeChat Mini Games. All physics interactions are abstracted through the unified `IPhysicsWorld` interface.

## When to Use

- Creating a 2D game that requires physics (platformers, puzzle games, ragdoll)
- Setting up collision detection and response
- Implementing 2D rigid body dynamics
- Need a lightweight physics solution (~500KB WASM)
- Following the unified physics interface pattern

## What It Does

1. **Loads Box2D WASM module** — Fetches and initializes the compiled Box2D WebAssembly binary
2. **Creates IPhysicsWorld** — Instantiates `Box2DPhysicsWorld` implementing the unified interface
3. **Configures physics world** — Sets up gravity, iteration counts, and collision categories
4. **Provides body factory** — Creates static, dynamic, and kinematic bodies via `IPhysicsBody`
5. **Sets up joint system** — Configures distance, revolute, prismatic, and weld joints via `IPhysicsJoint`

## Usage

```
/wechat-physics-box2d init [gravity-x] [gravity-y]
/wechat-physics-box2d body [type] [x] [y] [shape]
/wechat-physics-box2d joint [type] [body-a] [body-b]
```

## Example

```
/wechat-physics-box2d init 0 -9.8
```

This will:
- Load Box2D WASM module from `libs/box2d.wasm`
- Create a `Box2DPhysicsWorld` with gravity (0, -9.8)
- Register the world with the physics factory
- Create TypeScript interface files for `IPhysicsWorld`, `IPhysicsBody`, `IPhysicsJoint`
- Add boilerplate for contact listener and collision filtering

## Output

Creates the following structure:

```
src/physics/
├── interfaces/
│   ├── IPhysicsWorld.ts       # Unified physics world interface
│   ├── IPhysicsBody.ts        # Unified physics body interface
│   ├── IPhysicsJoint.ts       # Unified physics joint interface
│   └── PhysicsTypes.ts        # Shared types (Vec2, BodyDef, ShapeDef, etc.)
├── box2d/
│   ├── Box2DPhysicsWorld.ts   # Box2D implementation of IPhysicsWorld
│   ├── Box2DPhysicsBody.ts    # Box2D implementation of IPhysicsBody
│   ├── Box2DPhysicsJoint.ts   # Box2D implementation of IPhysicsJoint
│   ├── Box2DConstants.ts      # Box2D-specific constants and conversions
│   └── Box2DInitializer.ts    # WASM loading and initialization
├── PhysicsFactory.ts          # Factory method: createPhysicsWorld()
└── index.ts                   # Public API exports
```

## Box2D Physics World Initialization

```typescript
// src/physics/box2d/Box2DInitializer.ts
import type { IPhysicsWorld } from '../interfaces/IPhysicsWorld';

interface Box2DModule {
  World: new (gravity: { x: number; y: number }) => any;
  Vec2: new (x: number, y: number) => any;
  BodyDef: new () => any;
  FixtureDef: new () => any;
  PolygonShape: new () => any;
  CircleShape: new () => any;
  EdgeShape: new () => any;
  ChainShape: new () => any;
  RevoluteJointDef: new () => any;
  DistanceJointDef: new () => any;
  PrismaticJointDef: new () => any;
  WeldJointDef: new () => any;
  DynamicBody: number;
  StaticBody: number;
  KinematicBody: number;
}

let box2DModule: Box2DModule | null = null;

export async function initBox2D(): Promise<Box2DModule> {
  if (box2DModule) return box2DModule;

  const response = await fetch('libs/box2d.wasm');
  const buffer = await response.arrayBuffer();
  const module = await WebAssembly.instantiate(buffer, {
    env: {
      memory: new WebAssembly.Memory({ initial: 256, maximum: 512 }),
      table: new WebAssembly.Table({ initial: 0, element: 'anyfunc' }),
    }
  });

  box2DModule = module.instance.exports as unknown as Box2DModule;
  return box2DModule!;
}
```

## Box2D IPhysicsWorld Implementation

```typescript
// src/physics/box2d/Box2DPhysicsWorld.ts
import type { IPhysicsWorld } from '../interfaces/IPhysicsWorld';
import type { IPhysicsBody } from '../interfaces/IPhysicsBody';
import type { IPhysicsJoint } from '../interfaces/IPhysicsJoint';
import type { BodyDef, JointDef, Vec2, RaycastHit } from '../interfaces/PhysicsTypes';
import { Box2DPhysicsBody } from './Box2DPhysicsBody';
import { Box2DPhysicsJoint } from './Box2DPhysicsJoint';

export class Box2DPhysicsWorld implements IPhysicsWorld {
  private world: any;
  private bodies: Map<number, Box2DPhysicsBody> = new Map();
  private joints: Map<number, Box2DPhysicsJoint> = new Map();
  private nextId: number = 0;

  constructor(gravity: Vec2 = { x: 0, y: -9.8 }) {
    const b2 = this.getModule();
    this.world = new b2.World(new b2.Vec2(gravity.x, gravity.y));
  }

  createBody(def: BodyDef): IPhysicsBody {
    const b2 = this.getModule();
    const bodyDef = new b2.BodyDef();

    switch (def.type) {
      case 'static': bodyDef.type = b2.StaticBody; break;
      case 'dynamic': bodyDef.type = b2.DynamicBody; break;
      case 'kinematic': bodyDef.type = b2.KinematicBody; break;
    }

    bodyDef.position = new b2.Vec2(def.position.x, def.position.y);
    if (def.angle !== undefined) bodyDef.angle = def.angle;
    if (def.linearVelocity) {
      bodyDef.linearVelocity = new b2.Vec2(def.linearVelocity.x, def.linearVelocity.y);
    }
    if (def.angularVelocity !== undefined) bodyDef.angularVelocity = def.angularVelocity;

    const body = this.world.CreateBody(bodyDef);
    const id = this.nextId++;
    const physicsBody = new Box2DPhysicsBody(id, body, b2);
    this.bodies.set(id, physicsBody);
    return physicsBody;
  }

  createJoint(def: JointDef): IPhysicsJoint {
    const joint = Box2DPhysicsJoint.create(this.world, def, this.getModule());
    const id = this.nextId++;
    this.joints.set(id, joint);
    return joint;
  }

  step(dt: number): void {
    // Box2D recommends fixed timestep with velocity/position iterations
    const velocityIterations = 8;
    const positionIterations = 3;
    this.world.Step(dt, velocityIterations, positionIterations);
  }

  raycast(origin: Vec2, direction: Vec2, maxDistance: number): RaycastHit[] {
    const results: RaycastHit[] = [];
    // Box2D raycast implementation
    this.world.RayCast(
      (fixture: any, point: any, normal: any, fraction: number) => {
        results.push({
          body: this.findBodyByFixture(fixture),
          point: { x: point.x, y: point.y },
          normal: { x: normal.x, y: normal.y },
          distance: fraction * maxDistance
        });
        return fraction; // Continue raycast
      },
      new (this.getModule()).Vec2(origin.x, origin.y),
      new (this.getModule()).Vec2(
        origin.x + direction.x * maxDistance,
        origin.y + direction.y * maxDistance
      )
    );
    return results;
  }

  destroy(): void {
    this.bodies.clear();
    this.joints.clear();
    this.world = null;
  }

  private getModule(): any {
    // Returns cached Box2D module
    return (globalThis as any).__box2dModule;
  }

  private findBodyByFixture(fixture: any): IPhysicsBody | null {
    const body = fixture.GetBody();
    for (const [_, physicsBody] of this.bodies) {
      if (physicsBody.getRawBody() === body) return physicsBody;
    }
    return null;
  }
}
```

## Physics Factory Registration

```typescript
// src/physics/PhysicsFactory.ts
import type { IPhysicsWorld } from './interfaces/IPhysicsWorld';
import type { Vec2, PhysicsConfig } from './interfaces/PhysicsTypes';
import { Box2DPhysicsWorld } from './box2d/Box2DPhysicsWorld';

export function createPhysicsWorld(
  engine: 'box2d' | 'bullet' | 'jolt',
  config: PhysicsConfig
): IPhysicsWorld {
  const gravity: Vec2 = config.gravity || { x: 0, y: -9.8, z: 0 };

  switch (engine) {
    case 'box2d':
      return new Box2DPhysicsWorld({ x: gravity.x, y: gravity.y });
    case 'bullet':
      throw new Error('Bullet physics not initialized. Use /wechat-physics-bullet first.');
    case 'jolt':
      throw new Error('JoltPhysics not initialized. Use /wechat-physics-jolt first.');
    default:
      throw new Error(`Unknown physics engine: ${engine}`);
  }
}
```

## Configuration in game.json

```json
{
  "physicsEngine": "box2d",
  "physicsConfig": {
    "gravity": { "x": 0, "y": -9.8 },
    "velocityIterations": 8,
    "positionIterations": 3,
    "fixedTimeStep": 1 / 60
  }
}
```

## Performance Considerations

- Box2D WASM size: ~500KB — suitable for 4MB package limit
- Fixed timestep recommended (1/60s) with interpolation
- Use collision categories for filtering (max 16 categories in Box2D)
- Keep body count under 500 for mobile performance
- Use `SetAutoSleep(true)` for inactive bodies
- Destroy bodies outside viewport to save computation

## Box2D Feature Support

| Feature | Supported | Notes |
|---------|-----------|-------|
| Rigid Bodies (Static/Dynamic/Kinematic) | Yes | Full support |
| Circle Shape | Yes | Most efficient shape |
| Polygon Shape (Convex) | Yes | Max 8 vertices per polygon |
| Edge Shape | Yes | For terrain/boundaries |
| Chain Shape | Yes | For complex terrain |
| Distance Joint | Yes | |
| Revolute Joint | Yes | With motor and limits |
| Prismatic Joint | Yes | With motor and limits |
| Weld Joint | Yes | |
| Pulley Joint | No | Not in unified interface |
| Gear Joint | No | Not in unified interface |
| Contact Filtering | Yes | 16-bit category system |
| Raycast | Yes | |
| Continuous Collision (CCD) | Yes | For fast-moving bodies |
