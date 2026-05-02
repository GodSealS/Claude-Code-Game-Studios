# Agent Test Spec: wechat-minigame-specialist

## Agent Summary
Domain: WeChat Mini Game gameplay implementation, physics engine integration (Box2D/Bullet/JoltPhysics via unified IPhysicsWorld interface), WASM library embedding, and Spine/DragonBones skeletal animation runtimes.
Does NOT own: Architecture decisions (MVC vs ECS, engine choice) — defers to wechat-specialist, shader code (wechat-shader-specialist), UI design/implementation (wechat-ui-specialist), cloud functions (wechat-cloudbase-specialist).
Model tier: DeepSeek-V4-Flash (default for implementation specialists).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references gameplay implementation, physics engines, WASM, skeletal animation)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is DeepSeek-V4-Flash (default for specialists)
- [ ] Agent definition does not claim authority over architecture decisions or other domains
- [ ] Agent references the IPhysicsWorld unified interface for all physics engine interactions

---

## Test Cases

### Case 1: In-domain request — physics engine selection and configuration
**Input:** "We're building a 2D platformer. Which physics engine should we use and how do we configure it?"
**Expected behavior:**
- Recommends Box2D for 2D platformer (smaller WASM size ~500KB, 2D-specific features)
- Provides configuration example:
  ```typescript
  const config: PhysicsConfig = {
    engine: 'box2d',
    gravity: { x: 0, y: -10 },
    velocityIterations: 8,
    positionIterations: 3,
    continuousPhysics: true
  };
  ```
- Emphasizes using the IPhysicsWorld interface for all physics interactions
- Notes the need to load Box2D WASM as subpackage to stay under 4MB main limit
- Does NOT produce low-level Box2D API calls — all examples use the unified interface

### Case 2: Wrong-domain request — architecture decisions
**Input:** "Should we use MVC or ECS for this combat system?"
**Expected behavior:**
- Does NOT make architecture decision
- Clearly states: "Architecture decisions (MVC vs ECS) are handled by wechat-specialist"
- Redirects the request to wechat-specialist
- May provide context about combat system requirements for the architecture decision
- Does NOT implement either architecture pattern directly

### Case 3: WASM loading pattern for physics engine
**Input:** "How do we load the Box2D WASM module in our WeChat Mini Game?"
**Expected behavior:**
- Provides WeChat-specific WASM loading pattern using subpackage:
  ```typescript
  async function loadBox2DWASM(): Promise<any> {
    const fs = wx.getFileSystemManager();
    const subpackagePath = `${wx.env.USER_DATA_PATH}/subpackage/physics-wasm/box2d.wasm`;
    const wasmBuffer = fs.readFileSync(subpackagePath);
    const wasmModule = await WebAssembly.compile(wasmBuffer);
    const instance = await WebAssembly.instantiate(wasmModule, {
      env: { memory: new WebAssembly.Memory({ initial: 256 }) }
    });
    return instance.exports;
  }
  ```
- Explains subpackage configuration in `game.json`:
  ```json
  {
    "subpackages": [
      {
        "name": "physics-wasm",
        "root": "subpackages/physics-wasm/",
        "independent": false
      }
    ],
    "physicsEngine": "box2d"
  }
  ```
- Notes that WASM must be loaded before creating physics world
- Emphasizes subpackage strategy for staying under 4MB limit

### Case 4: Performance-critical physics loop
**Input:** "The physics simulation is causing frame drops when we have 100+ entities. How do we optimize it?"
**Expected behavior:**
- Provides optimization strategies for WeChat Mini Game environment:
  1. Fixed timestep physics: `const PHYSICS_STEP = 1 / 60;`
  2. Accumulator pattern to decouple physics from rendering frame rate
  3. Sleeping bodies: `body.setAwake(false)` for static objects
  4. Collision filtering using layers
  5. Object pooling for frequently created/destroyed physics bodies
- Includes code example:
  ```typescript
  class PhysicsSystem {
    private accumulator: number = 0;
    private readonly fixedDt: number = 1 / 60;
    
    update(dt: number, world: IPhysicsWorld): void {
      this.accumulator += dt;
      while (this.accumulator >= this.fixedDt) {
        world.step(this.fixedDt);
        this.accumulator -= this.fixedDt;
      }
    }
  }
  ```
- Notes WeChat-specific performance constraints (mobile devices, JavaScript execution)

### Case 5: Skeletal animation runtime integration
**Input:** "We want to use Spine animations for our character. How do we integrate the Spine runtime?"
**Expected behavior:**
- Provides Spine runtime integration pattern for WeChat Mini Games:
  ```typescript
  const initSpineRuntime = async (): Promise<any> => {
    const spine = await import('./libs/spine-canvas.js');
    return spine;
  };
  
  const loadSpineSkeleton = async (spine: any, atlasPath: string, jsonPath: string): Promise<any> => {
    const atlasText = await loadText(atlasPath);
    const atlas = new spine.TextureAtlas(atlasText, (path: string) => {
      return new spine.CanvasTexture(loadImage(path));
    });
    
    const skeletonJson = await loadJson(jsonPath);
    const atlasLoader = new spine.AtlasAttachmentLoader(atlas);
    const skeletonLoader = new spine.SkeletonJson(atlasLoader);
    const skeletonData = skeletonLoader.readSkeletonData(skeletonJson);
    
    return skeletonData;
  };
  ```
- Explains loading animation data as subpackage
- Notes performance considerations: texture atlases, LOD systems for distant characters
- Provides animation state machine pattern (blending, event handling)

### Case 6: Sprite sheet production workflow
**Input:** "We need to create sprite sheets for our UI assets. What's the best workflow?"
**Expected behavior:**
- Provides sprite sheet production workflow:
  1. Design assets at @2x resolution (750px width reference)
  2. Slice in Photoshop/Illustrator with naming convention: `component_state_size.png`
  3. Pack with TexturePacker using JSON configuration
  4. Optimize: WebP format, power-of-2 texture sizes
- Includes TexturePacker configuration example:
  ```json
  {
    "format": "RGBA8888",
    "size": { "w": 512, "h": 512 },
    "scale": 1,
    "frames": {
      "btn_primary_normal": {
        "frame": { "x": 0, "y": 0, "w": 200, "h": 80 },
        "rotated": false,
        "trimmed": false,
        "spriteSourceSize": { "x": 0, "y": 0, "w": 200, "h": 80 },
        "sourceSize": { "w": 200, "h": 80 }
      }
    }
  }
  ```
- Notes the importance of texture atlases for reducing draw calls in WeChat environment

### Case 7: Context pass — game dimension and performance requirements
**Input:** Project context provided: 3D action game, target high-end mobile devices. Request: "Set up the physics system."
**Expected behavior:**
- Recommends JoltPhysics for high-performance 3D (smaller WASM ~800KB, better performance)
- Provides JoltPhysics configuration example:
  ```typescript
  const config: PhysicsConfig = {
    engine: 'jolt',
    gravity: { x: 0, y: -10, z: 0 },
    velocityIterations: 6,
    positionIterations: 2,
    maxBodies: 2000,
    maxBodyPairs: 10000
  };
  ```
- Notes JoltPhysics has built-in character controller suitable for action games
- Emphasizes WASM loading as subpackage for 3D physics engine
- Considers high-end device capabilities in optimization recommendations

---

## Protocol Compliance

- [ ] Stays within declared domain (gameplay implementation, physics engines, WASM, skeletal animation)
- [ ] Redirects architecture decisions to wechat-specialist
- [ ] Redirects shader requests to wechat-shader-specialist
- [ ] Redirects UI requests to wechat-ui-specialist
- [ ] Redirects cloud function requests to wechat-cloudbase-specialist
- [ ] Always uses IPhysicsWorld interface for physics engine interactions, never engine-specific APIs
- [ ] Enforces subpackage strategy for WASM libraries to respect 4MB package limit
- [ ] Provides concrete, testable code examples for WeChat Mini Game environment
- [ ] Considers mobile device performance constraints in all recommendations

---

## Coverage Notes

- Physics engine selection (Case 1) should provide clear criteria: 2D vs 3D, performance requirements, package size impact
- WASM loading (Case 3) validates the agent understands WeChat-specific subpackage loading patterns
- Performance optimization (Case 4) confirms the agent prioritizes smooth frame rates on mobile devices
- Skeletal animation (Case 5) verifies integration of third-party runtime libraries in WeChat environment
- Sprite sheets (Case 6) covers asset production workflow, not just code implementation
- Context awareness (Case 7) demonstrates adaptation to game type and target hardware