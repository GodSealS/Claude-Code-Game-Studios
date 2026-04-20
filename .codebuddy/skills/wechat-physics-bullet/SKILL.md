---
name: /wechat-physics-bullet
description: "Initialize Bullet (ammo.js) WASM physics engine for WeChat Mini Games, create 3D physics world, configure rigid bodies, soft bodies, and collision detection via the unified IPhysicsWorld interface."
agent: wechat-minigame-specialist
---

# /wechat-physics-bullet

Initialize and configure the Bullet physics engine (via ammo.js WASM) for 3D physics simulation in WeChat Mini Games. All physics interactions are abstracted through the unified `IPhysicsWorld` interface.

## When to Use

- Creating a 3D game that requires physics (3D platformers, vehicle physics, ragdoll)
- Setting up 3D collision detection and response
- Implementing rigid body and soft body dynamics
- Need a full-featured 3D physics solution (~1.5MB WASM)
- Following the unified physics interface pattern

## What It Does

1. **Loads ammo.js WASM module** — Fetches and initializes the compiled Bullet WebAssembly binary
2. **Creates IPhysicsWorld** — Instantiates `BulletPhysicsWorld` implementing the unified interface
3. **Configures physics world** — Sets up gravity, broadphase, solver, and collision configuration
4. **Provides body factory** — Creates static, dynamic, and kinematic bodies via `IPhysicsBody`
5. **Sets up constraint system** — Configures point-to-point, hinge, slider, and cone-twist constraints via `IPhysicsJoint`
6. **Soft body support** — Creates cloth, rope, and deformable objects

## Usage

```
/wechat-physics-bullet init [gravity-x] [gravity-y] [gravity-z]
/wechat-physics-bullet body [type] [x] [y] [z] [shape]
/wechat-physics-bullet softbody [type] [params]
/wechat-physics-bullet constraint [type] [body-a] [body-b]
```

## Example

```
/wechat-physics-bullet init 0 -9.8 0
```

This will:
- Load ammo.js WASM module from `libs/ammo.wasm`
- Create a `BulletPhysicsWorld` with gravity (0, -9.8, 0)
- Register the world with the physics factory
- Create TypeScript interface files for `IPhysicsWorld`, `IPhysicsBody`, `IPhysicsJoint`
- Add boilerplate for collision callback and debug rendering

## Output

Creates the following structure:

```
src/physics/
├── interfaces/
│   ├── IPhysicsWorld.ts       # Unified physics world interface
│   ├── IPhysicsBody.ts        # Unified physics body interface
│   ├── IPhysicsJoint.ts       # Unified physics joint interface
│   └── PhysicsTypes.ts        # Shared types (Vec3, BodyDef, ShapeDef, etc.)
├── bullet/
│   ├── BulletPhysicsWorld.ts  # Bullet implementation of IPhysicsWorld
│   ├── BulletPhysicsBody.ts   # Bullet implementation of IPhysicsBody
│   ├── BulletPhysicsJoint.ts  # Bullet implementation of IPhysicsJoint
│   ├── BulletSoftBody.ts      # Soft body creation and management
│   ├── BulletConstants.ts     # Bullet-specific constants and conversions
│   └── BulletInitializer.ts   # WASM loading and initialization
├── PhysicsFactory.ts          # Factory method: createPhysicsWorld()
└── index.ts                   # Public API exports
```

## Bullet Physics World Initialization

```typescript
// src/physics/bullet/BulletInitializer.ts
import type { IPhysicsWorld } from '../interfaces/IPhysicsWorld';

interface AmmoModule {
  btDefaultCollisionConfiguration: new () => any;
  btCollisionDispatcher: new (config: any) => any;
  btDbvtBroadphase: new () => any;
  btSequentialImpulseConstraintSolver: new () => any;
  btDiscreteDynamicsWorld: new (dispatcher: any, broadphase: any, solver: any, config: any) => any;
  btVector3: new (x: number, y: number, z: number) => any;
  btTransform: new () => any;
  btQuaternion: new (x: number, y: number, z: number, w: number) => any;
  btBoxShape: new (halfExtents: any) => any;
  btSphereShape: new (radius: number) => any;
  btCylinderShape: new (halfExtents: any) => any;
  btCapsuleShape: new (radius: number, height: number) => any;
  btConeShape: new (radius: number, height: number) => any;
  btStaticPlaneShape: new (planeNormal: any, planeConstant: number) => any;
  btBvhTriangleMeshShape: new (mesh: any, useQuantizedAabb: boolean) => any;
  btRigidBody: new (constructionInfo: any) => any;
  btRigidBodyConstructionInfo: new (mass: number, motionState: any, shape: any, inertia: any) => any;
  btSoftBodyRigidBodyCollisionConfiguration: new () => any;
  btSoftRigidDynamicsWorld: new (dispatcher: any, broadphase: any, solver: any, config: any) => any;
  btSoftBodyHelpers: any;
  AABB: any;
}

let ammoModule: AmmoModule | null = null;

export async function initBullet(): Promise<AmmoModule> {
  if (ammoModule) return ammoModule;

  const Ammo = await import('../../libs/ammo.js');
  const module = await Ammo({
    locateFile: (path: string) => `libs/${path}`
  });

  ammoModule = module as unknown as AmmoModule;
  return ammoModule!;
}
```

## Bullet IPhysicsWorld Implementation

```typescript
// src/physics/bullet/BulletPhysicsWorld.ts
import type { IPhysicsWorld } from '../interfaces/IPhysicsWorld';
import type { IPhysicsBody } from '../interfaces/IPhysicsBody';
import type { IPhysicsJoint } from '../interfaces/IPhysicsJoint';
import type { BodyDef, JointDef, Vec3, RaycastHit } from '../interfaces/PhysicsTypes';
import { BulletPhysicsBody } from './BulletPhysicsBody';
import { BulletPhysicsJoint } from './BulletPhysicsJoint';

export class BulletPhysicsWorld implements IPhysicsWorld {
  private world: any;
  private bodies: Map<number, BulletPhysicsBody> = new Map();
  private joints: Map<number, BulletPhysicsJoint> = new Map();
  private nextId: number = 0;

  constructor(gravity: Vec3 = { x: 0, y: -9.8, z: 0 }) {
    const Ammo = this.getModule();

    // Standard Bullet world setup
    const collisionConfig = new Ammo.btDefaultCollisionConfiguration();
    const dispatcher = new Ammo.btCollisionDispatcher(collisionConfig);
    const broadphase = new Ammo.btDbvtBroadphase();
    const solver = new Ammo.btSequentialImpulseConstraintSolver();

    this.world = new Ammo.btDiscreteDynamicsWorld(
      dispatcher, broadphase, solver, collisionConfig
    );
    this.world.setGravity(new Ammo.btVector3(gravity.x, gravity.y, gravity.z));
  }

  createBody(def: BodyDef): IPhysicsBody {
    const Ammo = this.getModule();
    const id = this.nextId++;

    const body = BulletPhysicsBody.createFromDef(Ammo, def);
    this.world.addRigidBody(body.getRawBody());
    this.bodies.set(id, body);
    return body;
  }

  createJoint(def: JointDef): IPhysicsJoint {
    const Ammo = this.getModule();
    const joint = BulletPhysicsJoint.create(this.world, def, Ammo);
    const id = this.nextId++;
    this.joints.set(id, joint);
    return joint;
  }

  step(dt: number): void {
    // Bullet supports sub-stepping for stability
    const maxSubSteps = 4;
    const fixedTimeStep = 1 / 60;
    this.world.stepSimulation(dt, maxSubSteps, fixedTimeStep);
  }

  raycast(origin: Vec3, direction: Vec3, maxDistance: number): RaycastHit[] {
    const Ammo = this.getModule();
    const results: RaycastHit[] = [];

    const from = new Ammo.btVector3(origin.x, origin.y, origin.z);
    const to = new Ammo.btVector3(
      origin.x + direction.x * maxDistance,
      origin.y + direction.y * maxDistance,
      origin.z + direction.z * maxDistance
    );

    const rayCallback = new Ammo.ClosestRayResultCallback(from, to);
    this.world.rayTest(from, to, rayCallback);

    if (rayCallback.hasHit()) {
      const hitPoint = rayCallback.getHitPointWorld();
      const hitNormal = rayCallback.getHitNormalWorld();
      results.push({
        body: this.findBodyByCollisionObject(rayCallback.getCollisionObject()),
        point: { x: hitPoint.x(), y: hitPoint.y(), z: hitPoint.z() },
        normal: { x: hitNormal.x(), y: hitNormal.y(), z: hitNormal.z() },
        distance: from.distance(to) * rayCallback.getClosestHitFraction()
      });
    }

    Ammo.destroy(from);
    Ammo.destroy(to);
    Ammo.destroy(rayCallback);
    return results;
  }

  destroy(): void {
    const Ammo = this.getModule();
    this.bodies.forEach(body => body.destroy(Ammo));
    this.joints.forEach(joint => joint.destroy(Ammo));
    this.bodies.clear();
    this.joints.clear();
    Ammo.destroy(this.world);
    this.world = null;
  }

  private getModule(): any {
    return (globalThis as any).__ammoModule;
  }

  private findBodyByCollisionObject(collisionObject: any): IPhysicsBody | null {
    for (const [_, body] of this.bodies) {
      if (body.getRawBody() === collisionObject) return body;
    }
    return null;
  }
}
```

## Physics Factory Registration

```typescript
// src/physics/PhysicsFactory.ts (updated with Bullet)
import type { IPhysicsWorld } from './interfaces/IPhysicsWorld';
import type { Vec3, PhysicsConfig } from './interfaces/PhysicsTypes';
import { Box2DPhysicsWorld } from './box2d/Box2DPhysicsWorld';
import { BulletPhysicsWorld } from './bullet/BulletPhysicsWorld';

export function createPhysicsWorld(
  engine: 'box2d' | 'bullet' | 'jolt',
  config: PhysicsConfig
): IPhysicsWorld {
  const gravity: Vec3 = config.gravity || { x: 0, y: -9.8, z: 0 };

  switch (engine) {
    case 'box2d':
      return new Box2DPhysicsWorld({ x: gravity.x, y: gravity.y });
    case 'bullet':
      return new BulletPhysicsWorld(gravity);
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
  "physicsEngine": "bullet",
  "physicsConfig": {
    "gravity": { "x": 0, "y": -9.8, "z": 0 },
    "maxSubSteps": 4,
    "fixedTimeStep": 1 / 60,
    "broadphase": "dbvt",
    "solver": "sequential_impulse"
  }
}
```

## Performance Considerations

- Bullet (ammo.js) WASM size: ~1.5MB — may require subpackaging for 4MB limit
- Use LOD collision shapes (simplified convex hulls for dynamic, trimesh only for static)
- Keep rigid body count under 200 for mobile performance
- Use `btDbvtBroadphase` for dynamic scenes, `btAxisSweep3` for static
- Call `setSleepingThresholds()` to enable body sleeping
- Destroy Ammo objects explicitly to prevent WASM memory leaks
- Use `Ammo.destroy()` for all temporary objects (vectors, transforms, etc.)

## Bullet Feature Support

| Feature | Supported | Notes |
|---------|-----------|-------|
| Rigid Bodies (Static/Dynamic/Kinematic) | Yes | Full support |
| Box Shape | Yes | |
| Sphere Shape | Yes | |
| Cylinder Shape | Yes | |
| Capsule Shape | Yes | Best for characters |
| Cone Shape | Yes | |
| Static Plane | Yes | For ground/terrain |
| Triangle Mesh (BVH) | Yes | Static only |
| Convex Hull | Yes | For complex dynamic shapes |
| Soft Body (Cloth/Rope) | Yes | Additional soft body world |
| Point-to-Point Constraint | Yes | |
| Hinge Constraint | Yes | With motor and limits |
| Slider Constraint | Yes | |
| Cone-Twist Constraint | Yes | For ragdoll joints |
| Raycast | Yes | Closest and all hits |
| Continuous Collision (CCD) | Yes | For fast-moving bodies |
| Vehicle Support | Yes | btRaycastVehicle |
