---
name: /wechat-physics-jolt
description: "Initialize JoltPhysics WASM physics engine for WeChat Mini Games, create high-performance 3D physics world, configure rigid bodies, constraints, and character controllers via the unified IPhysicsWorld interface."
agent: wechat-minigame-specialist
---

# /wechat-physics-jolt

Initialize and configure the JoltPhysics engine (via WASM) for high-performance 3D physics simulation in WeChat Mini Games. All physics interactions are abstracted through the unified `IPhysicsWorld` interface.

## When to Use

- Creating a 3D game requiring high-fidelity physics (vehicle simulation, character controllers, large-scale worlds)
- Need deterministic physics simulation for networked multiplayer
- Standard Bullet performance is insufficient for your scene complexity
- Need built-in character controller support
- Following the unified physics interface pattern

## What It Does

1. **Loads JoltPhysics WASM module** — Fetches and initializes the compiled JoltPhysics WebAssembly binary
2. **Creates IPhysicsWorld** — Instantiates `JoltPhysicsWorld` implementing the unified interface
3. **Configures physics world** — Sets up gravity, broadphase layers, object layers, and broadphase layer interface
4. **Provides body factory** — Creates static, dynamic, and kinematic bodies via `IPhysicsBody`
5. **Sets up constraint system** — Configures point, distance, hinge, slider, cone, and swing-twist constraints via `IPhysicsJoint`
6. **Character controller support** — Built-in character controller with slide, stair climbing

## Usage

```
/wechat-physics-jolt init [gravity-x] [gravity-y] [gravity-z]
/wechat-physics-jolt body [type] [x] [y] [z] [shape]
/wechat-physics-jolt constraint [type] [body-a] [body-b]
/wechat-physics-jolt character [position] [height] [radius]
```

## Example

```
/wechat-physics-jolt init 0 -9.8 0
```

This will:
- Load JoltPhysics WASM module from `libs/jolt.wasm`
- Create a `JoltPhysicsWorld` with gravity (0, -9.8, 0)
- Register the world with the physics factory
- Create TypeScript interface files for `IPhysicsWorld`, `IPhysicsBody`, `IPhysicsJoint`
- Add boilerplate for broadphase layer interface, object layer pair filter, and contact listener

## Output

Creates the following structure:

```
src/physics/
├── interfaces/
│   ├── IPhysicsWorld.ts       # Unified physics world interface
│   ├── IPhysicsBody.ts        # Unified physics body interface
│   ├── IPhysicsJoint.ts       # Unified physics joint interface
│   └── PhysicsTypes.ts        # Shared types (Vec3, BodyDef, ShapeDef, etc.)
├── jolt/
│   ├── JoltPhysicsWorld.ts    # JoltPhysics implementation of IPhysicsWorld
│   ├── JoltPhysicsBody.ts     # JoltPhysics implementation of IPhysicsBody
│   ├── JoltPhysicsJoint.ts    # JoltPhysics implementation of IPhysicsJoint
│   ├── JoltCharacterController.ts  # Built-in character controller
│   ├── JoltBroadPhase.ts      # Broadphase layer configuration
│   ├── JoltConstants.ts       # JoltPhysics-specific constants and conversions
│   └── JoltInitializer.ts     # WASM loading and initialization
├── PhysicsFactory.ts          # Factory method: createPhysicsWorld()
└── index.ts                   # Public API exports
```

## JoltPhysics World Initialization

```typescript
// src/physics/jolt/JoltInitializer.ts
import type { IPhysicsWorld } from '../interfaces/IPhysicsWorld';

interface JoltModule {
  JPH_PhysicsSystem: new () => any;
  JPH_BodyInterface: any;
  JPH_BodyCreationSettings: new (shape: any, position: any, rotation: any, motionType: number, layer: number) => any;
  JPH_BoxShape: new (halfExtents: any, convexRadius?: number) => any;
  JPH_SphereShape: new (radius: number) => any;
  JPH_CapsuleShape: new (halfHeight: number, radius: number) => any;
  JPH_CylinderShape: new (halfHeight: number, radius: number) => any;
  JPH_TaperedCapsuleShape: new (halfHeight: number, topRadius: number, bottomRadius: number) => any;
  JPH_StaticCompoundShape: new () => any;
  JPH_MutableCompoundShape: new () => any;
  JPH_Vec3: new (x: number, y: number, z: number) => any;
  JPH_Quat: new (x: number, y: number, z: number, w: number) => any;
  JPH_BodyID: any;
  EMotionType_Static: number;
  EMotionType_Kinematic: number;
  EMotionType_Dynamic: number;
}

let joltModule: JoltModule | null = null;

export async function initJolt(): Promise<JoltModule> {
  if (joltModule) return joltModule;

  const Jolt = await import('../../libs/jolt.js');
  const module = await Jolt({
    locateFile: (path: string) => `libs/${path}`
  });

  joltModule = module as unknown as JoltModule;
  return joltModule!;
}
```

## JoltPhysics IPhysicsWorld Implementation

```typescript
// src/physics/jolt/JoltPhysicsWorld.ts
import type { IPhysicsWorld } from '../interfaces/IPhysicsWorld';
import type { IPhysicsBody } from '../interfaces/IPhysicsBody';
import type { IPhysicsJoint } from '../interfaces/IPhysicsJoint';
import type { BodyDef, JointDef, Vec3, RaycastHit } from '../interfaces/PhysicsTypes';
import { JoltPhysicsBody } from './JoltPhysicsBody';
import { JoltPhysicsJoint } from './JoltPhysicsJoint';

export class JoltPhysicsWorld implements IPhysicsWorld {
  private physicsSystem: any;
  private bodyInterface: any;
  private bodies: Map<number, JoltPhysicsBody> = new Map();
  private joints: Map<number, JoltPhysicsJoint> = new Map();
  private nextId: number = 0;

  constructor(gravity: Vec3 = { x: 0, y: -9.8, z: 0 }) {
    const Jolt = this.getModule();

    // JoltPhysics system setup with broadphase layers
    this.physicsSystem = new Jolt.JPH_PhysicsSystem();
    this.physicsSystem.SetGravity(
      new Jolt.JPH_Vec3(gravity.x, gravity.y, gravity.z)
    );

    this.bodyInterface = this.physicsSystem.GetBodyInterface();
  }

  createBody(def: BodyDef): IPhysicsBody {
    const Jolt = this.getModule();
    const id = this.nextId++;

    const body = JoltPhysicsBody.createFromDef(Jolt, this.bodyInterface, def);
    this.bodies.set(id, body);
    return body;
  }

  createJoint(def: JointDef): IPhysicsJoint {
    const Jolt = this.getModule();
    const joint = JoltPhysicsJoint.create(
      this.physicsSystem, def, Jolt
    );
    const id = this.nextId++;
    this.joints.set(id, joint);
    return joint;
  }

  step(dt: number): void {
    // JoltPhysics supports fixed timestep with collision steps
    const collisionSteps = 1;
    const integrationSubSteps = 1;
    this.physicsSystem.Update(dt, collisionSteps, integrationSubSteps, null);
  }

  raycast(origin: Vec3, direction: Vec3, maxDistance: number): RaycastHit[] {
    const Jolt = this.getModule();
    const results: RaycastHit[] = [];

    const rayResult = new Jolt.RayCastResult();
    const from = new Jolt.JPH_Vec3(origin.x, origin.y, origin.z);
    const directionVec = new Jolt.JPH_Vec3(
      direction.x * maxDistance,
      direction.y * maxDistance,
      direction.z * maxDistance
    );

    const result = this.physicsSystem.GetNarrowPhaseQuery().CastRay(
      from, directionVec, rayResult
    );

    if (result) {
      const hitPoint = from.Add(
        directionVec.Mul(rayResult.GetFraction())
      );
      results.push({
        body: this.findBodyById(rayResult.GetBodyID()),
        point: { x: hitPoint.GetX(), y: hitPoint.GetY(), z: hitPoint.GetZ() },
        normal: { x: 0, y: 1, z: 0 }, // Jolt provides normal via different API
        distance: maxDistance * rayResult.GetFraction()
      });
    }

    return results;
  }

  destroy(): void {
    this.bodies.forEach(body => body.destroy(this.bodyInterface));
    this.joints.forEach(joint => joint.destroy(this.physicsSystem));
    this.bodies.clear();
    this.joints.clear();
    this.physicsSystem = null;
  }

  private getModule(): any {
    return (globalThis as any).__joltModule;
  }

  private findBodyById(bodyId: any): IPhysicsBody | null {
    for (const [_, body] of this.bodies) {
      if (body.getBodyId() === bodyId) return body;
    }
    return null;
  }
}
```

## Physics Factory Registration

```typescript
// src/physics/PhysicsFactory.ts (updated with Jolt)
import type { IPhysicsWorld } from './interfaces/IPhysicsWorld';
import type { Vec3, PhysicsConfig } from './interfaces/PhysicsTypes';
import { Box2DPhysicsWorld } from './box2d/Box2DPhysicsWorld';
import { BulletPhysicsWorld } from './bullet/BulletPhysicsWorld';
import { JoltPhysicsWorld } from './jolt/JoltPhysicsWorld';

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
      return new JoltPhysicsWorld(gravity);
    default:
      throw new Error(`Unknown physics engine: ${engine}`);
  }
}
```

## Configuration in game.json

```json
{
  "physicsEngine": "jolt",
  "physicsConfig": {
    "gravity": { "x": 0, "y": -9.8, "z": 0 },
    "collisionSteps": 1,
    "integrationSubSteps": 1,
    "broadPhaseLayerCount": 16,
    "objectLayerCount": 16,
    "maxBodies": 1024,
    "maxBodyPairs": 2048,
    "maxContactConstraints": 1024
  }
}
```

## Performance Considerations

- JoltPhysics WASM size: ~800KB — good balance of features vs. package size
- Deterministic simulation — ideal for networked multiplayer with lockstep
- Built-in character controller eliminates need for custom implementation
- Use broadphase layers for efficient collision filtering (recommended: 16 layers)
- Keep body count under 1024 for mobile performance
- Use `integrationSubSteps` for stability (1 is usually sufficient)
- Destroy Jolt bodies explicitly via `BodyInterface.RemoveBody()` to prevent memory leaks
- JoltPhysics is multithreaded-capable but WASM currently runs single-threaded

## JoltPhysics Feature Support

| Feature | Supported | Notes |
|---------|-----------|-------|
| Rigid Bodies (Static/Dynamic/Kinematic) | Yes | Full support |
| Box Shape | Yes | |
| Sphere Shape | Yes | |
| Capsule Shape | Yes | Best for characters |
| Cylinder Shape | Yes | |
| Tapered Capsule Shape | Yes | Unique to Jolt |
| Compound Shape (Static) | Yes | |
| Compound Shape (Mutable) | Yes | Can add/remove children at runtime |
| Convex Hull | Yes | Via triangle mesh decomposition |
| Point Constraint | Yes | |
| Distance Constraint | Yes | |
| Hinge Constraint | Yes | With motor and limits |
| Slider Constraint | Yes | |
| Cone Constraint | Yes | |
| Swing-Twist Constraint | Yes | For ragdoll joints |
| Character Controller | Yes | Built-in, with slide and stair climbing |
| Raycast | Yes | Closest and all hits |
| Shape Cast | Yes | Sweep test |
| Continuous Collision (CCD) | Yes | For fast-moving bodies |
| Deterministic Simulation | Yes | Bit-exact across platforms |
| Vehicle Support | No | Use custom implementation with constraints |
