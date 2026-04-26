# Cocos Creator — 当前最佳实践

最后验证：2026-04-25

此文档中的实践可能与 LLM 训练数据不同。如有冲突，优先使用本文档。

## 架构模式（3.8+）

### 组件生命周期
```typescript
// 正确 — 在 onLoad() 中缓存所有查找
@property(Node)
playerNode: Node = null!;

private _rigidBody: RigidBody | null = null;

onLoad() {
    this._rigidBody = this.getComponent(RigidBody);
}

start() {
    // 依赖其他组件的初始化
}

update(dt: number) {
    // 使用缓存引用，绝不在 update() 中调用 getComponent()
}
```

### 数据驱动组件
```typescript
// 正确 — 使用 @property 暴露设计器可调参数
@property({ type: CCFloat, min: 0, max: 100, step: 1 })
moveSpeed: number = 10;

@property(Prefab)
projectilePrefab: Prefab = null!;
```

## 资源管理（3.8+）

### 优先使用 Asset Bundle 而非 resources
```typescript
// 正确 — 生产环境使用 Asset Bundle
assetManager.loadBundle('game_level_1', (err, bundle) => {
    if (err) { console.error(err); return; }
    bundle.load('prefabs/enemy', Prefab, (err, prefab) => {
        // 使用 prefab
    });
});
```

### 对象池
```typescript
// 正确 — 使用 NodePool 管理频繁实例化
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

## 渲染（3.8+）

### 自定义渲染管线
- 需要后处理（泛光、色彩校正、FXAA）的项目使用 CRP
- 简单 2D/3D 无需后处理时，内置前向管线即可
- 高端 3D（桌面/主机目标）可使用延迟渲染管线

### Draw Call 优化
- 非移动网格使用静态合批
- 重复几何体使用 GPU 实例化
- 2D UI 和精灵使用 Sprite Atlas
- Label 合批：静态文本使用 BitmapFont 替代系统字体

## 输入系统（3.8+）

```typescript
// 正确 — 使用 Input 类进行跨平台输入
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

## 物理（3.8+）

- 默认物理引擎：3D 使用 Bullet（ammo.js），2D 使用 Box2D
- 使用 `PhysicsSystem.instance.enable = true` 切换
- Raycast API：`PhysicsSystem.instance.raycastClosest()` / `raycastAll()`
- 玩法逻辑优先使用触发器事件（`onTriggerEnter`）而非碰撞事件

## 微信小游戏专项（3.8+）

- 构建面板中启用"压缩引擎内部属性"可节省约 160KB
- 超过 4MB 的游戏使用 Asset Bundle + 远程加载
- 设置 `Canvas` 分辨率策略为 `FIT_HEIGHT` 或 `FIT_WIDTH` 以适配
- 音频：优先 `AudioClip` 预加载；WebAudio 在小游戏中有局限

## 性能预算（推荐值）

| 目标平台 | Draw Calls | 纹理内存 | JS 堆内存 | 说明 |
|---------|-----------|---------|----------|------|
| 移动端 2D | < 100 | < 128MB | < 150MB | 积极使用图集 |
| 移动端 3D | < 200 | < 256MB | < 200MB | LOD、遮挡剔除 |
| 微信小游戏 | < 50 | < 64MB | < 100MB | 首包 < 4MB |
| Web | < 150 | < 256MB | < 200MB | 考虑设备分级 |
