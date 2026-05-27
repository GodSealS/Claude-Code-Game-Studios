# VFX Creation Workflow

## Particle Effects

### 3D Particle System Creation

```json
// 1. Create particle node
{ "tool": "node_lifecycle", "arguments": { "action": "create", "name": "FireParticle", "nodeType": "3DNode", "parentUuid": "parent", "components": ["cc.ParticleSystem"] } }

// 2. Configure particle properties
{ "tool": "set_component_property", "arguments": {
  "action": "batchSet",
  "nodeUuid": "...",
  "componentType": "cc.ParticleSystem",
  "properties": {
    "duration": 2,
    "capacity": 30,
    "loop": true,
    "playOnAwake": true,
    "startLifetime": { "mode": "TwoConstants", "constantMin": 0.5, "constantMax": 1.5 },
    "startSpeed": { "mode": "Constant", "constant": 100 },
    "startSize": { "mode": "TwoConstants", "constantMin": 10, "constantMax": 30 },
    "startColor": { "mode": "Gradient", "gradient": {} },
    "gravityModifier": 0,
    "rateOverTime": { "mode": "Constant", "constant": 15 },
    "shape": { "shapeType": "Cone", "radius": 1, "angle": 15 }
  }
}}
```

### Particle System Parameter Quick Reference

| Category | Key Properties | Purpose |
|----------|---------------|---------|
| Basic | `duration`, `capacity`, `loop`, `playOnAwake` | Lifetime and looping |
| Lifetime | `startLifetime`, `startColor` | Particle lifespan and color variation |
| Motion | `startSpeed`, `gravityModifier`, `speedModifier` | Speed and gravity |
| Appearance | `startSize`, `rotation`, `texture` | Size and texture |
| Emission | `rateOverTime`, `rateOverDistance`, `bursts` | Emission rate and bursts |
| Shape | `shape.shapeType` (Box/Sphere/Cone/Circle) | Emission area |
| Rendering | `renderer.material`, `renderer.useGPU` | Material and GPU mode |

### Common Particle Effect Recipes

**Fire**:
- Shape: Cone, angle=15°
- startSpeed: 50–150, gravityModifier: -20
- startColor: red → orange → yellow gradient, startLifetime: 0.5–1.5
- startSize: 10–30, rateOverTime: 20

**Smoke**:
- Shape: Sphere, radius=3
- startSpeed: 10–30, gravityModifier: 10
- startColor: white → gray gradient (alpha↓), startLifetime: 2–4
- startSize: 20→60, rateOverTime: 5

**Sparkles / Magic**:
- Shape: Sphere, radius=1
- startSpeed: 0–20, gravityModifier: 0
- startColor: gold / blue, startLifetime: 1–2
- startSize: 5–15, rateOverTime: 10
- renderer.useGPU: true (for high particle counts)

**Explosion**:
- duration: 0.5, capacity: 50, loop: false
- bursts: [time=0, count=50]
- startSpeed: 200–400
- startLifetime: 0.3–1.0

**Trail**:
- Shape: Point
- velocityOverLifetime: linear decay
- startLifetime: 0.2–0.5
- rateOverDistance: 20

## Shader Effects

```json
// 1. Create material
{ "tool": "asset_operations", "arguments": { "action": "create", "assetType": "material", "path": "assets/materials/glow.mtl" } }

// 2. Associate Effect (.effect file created via file system, then refresh)
{ "tool": "asset_system", "arguments": { "action": "refresh" } }

// 3. Apply material to node
{ "tool": "set_component_property", "arguments": { "action": "set", "nodeUuid": "...", "componentType": "cc.MeshRenderer", "property": "material", "value": "uuid-of-glow-material" } }
```

**Common Shader effects**:
- **Dissolve**: noise texture + pixel discard
- **Outer glow**: sample offset + color overlay
- **Flow light**: UV offset + mask gradient
- **Distortion / Warp**: vertex shader UV perturbation
- **Fullscreen post-process**: RenderTexture + Blit material

## Frame-By-Frame Animation Effects

```json
// Create node with Sprite + Animation
{ "tool": "node_lifecycle", "arguments": { "action": "create", "name": "FrameAnim", "nodeType": "2DNode", "parentUuid": "parent", "components": ["cc.Sprite", "cc.Animation"] } }
// Use the Animation Editor to create SpriteFrame keyframe animations (played via script)
```

## Saving Effects as Prefabs

Save completed effects as prefabs for reuse:
```json
{ "tool": "prefab_lifecycle", "arguments": { "action": "create", "nodeUuid": "...", "path": "assets/prefabs/effects/FireEffect.prefab" } }
```
