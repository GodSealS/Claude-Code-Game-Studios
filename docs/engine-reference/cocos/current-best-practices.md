# Cocos Creator — Current Best Practices

Last verified: 2026-04-25

Practices listed here may differ from the LLM's training data. Prefer these
over suggestions from the model if they conflict.

## Architecture Patterns (3.8+)

### Component Lifecycle
```typescript
// CORRECT — cache all lookups in onLoad()
@property(Node)
playerNode: Node = null!;

private _rigidBody: RigidBody | null = null;

onLoad() {
    this._rigidBody = this.getComponent(RigidBody);
}

start() {
    // Initialization that depends on other components
}

update(dt: number) {
    // Use cached references, never call getComponent() here
}
```

### Data-Driven Components
```typescript
// CORRECT — use @property for designer-tunable values
@property({ type: CCFloat, min: 0, max: 100, step: 1 })
moveSpeed: number = 10;

@property(Prefab)
projectilePrefab: Prefab = null!;
```

## Asset Management (3.8+)

### Asset Bundles Over resources
```typescript
// CORRECT — use asset bundles for production
assetManager.loadBundle('game_level_1', (err, bundle) => {
    if (err) { console.error(err); return; }
    bundle.load('prefabs/enemy', Prefab, (err, prefab) => {
        // Use prefab
    });
});
```

### Object Pooling
```typescript
// CORRECT — use NodePool for frequent instantiation
private _bulletPool: NodePool = new NodePool();

private createBullet(): Node {
    if (this._bulletPool.size() > 0) {
        return this._bulletPool.get()!;
    }
    return instantiate(this.bulletPrefab);
}

private recycleBullet(bullet: Node) {
    this._bulletPool.put(bullet);
}
```

## Rendering (3.8+)

### Custom Render Pipeline
- Use CRP for any project needing post-processing (bloom, color grading, FXAA)
- Built-in Forward pipeline is fine for simple 2D/3D without post-processing
- Deferred pipeline available for high-end 3D (desktop/console targets)

### Draw Call Optimization
- Use static batching for non-moving meshes
- GPU instancing for repeated geometry
- Sprite atlases for 2D UI and sprites
- Label batching: use BitmapFont instead of system font for static text

## Input System (3.8+)

```typescript
// CORRECT — use Input class for cross-platform input
import { input, Input } from 'cc';

onLoad() {
    input.on(Input.EventType.TOUCH_START, this.onTouchStart, this);
    input.on(Input.EventType.KEY_DOWN, this.onKeyDown, this);
}

onDestroy() {
    input.off(Input.EventType.TOUCH_START, this.onTouchStart, this);
    input.off(Input.EventType.KEY_DOWN, this.onKeyDown, this);
}
```

## Physics (3.8+)

- Default physics: Bullet (ammo.js) for 3D, Box2D for 2D
- Use `PhysicsSystem.instance.enable = true` to toggle
- Raycast API: `PhysicsSystem.instance.raycastClosest()` / `raycastAll()`
- Prefer trigger events (`onTriggerEnter`) over collision for gameplay logic

## WeChat Mini Game Specific (3.8+)

- Enable "Compress Engine Internal Properties" in Build Panel for ~160KB savings
- Use asset bundles + remote loading for games > 4MB
- Set `Canvas` resolution policy to `FIT_HEIGHT` or `FIT_WIDTH` for adaptability
- Audio: prefer `AudioClip` preloading; WebAudio has limitations on Mini Game

## Performance Budgets (Recommended)

| Target | Draw Calls | Texture Memory | JS Heap | Notes |
|--------|-----------|----------------|---------|-------|
| Mobile 2D | < 100 | < 128MB | < 150MB | Use atlases aggressively |
| Mobile 3D | < 200 | < 256MB | < 200MB | LOD, occlusion culling |
| WeChat Mini Game | < 50 | < 64MB | < 100MB | Bundle size < 4MB initial |
| Web | < 150 | < 256MB | < 200MB | Consider device tiers |
