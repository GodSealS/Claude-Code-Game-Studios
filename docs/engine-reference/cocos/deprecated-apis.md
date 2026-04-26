# Cocos Creator — 已废弃 API

最后验证：2026-04-25

如果 Agent 建议了"已废弃"列中的 API，必须替换为"替代方案"列。

## 类与组件

| 已废弃 | 替代方案 | 废弃版本 | 说明 |
|--------|----------|----------|------|
| `Animation`（旧版） | `Animation`（新组件）+ `AnimationClip` | 3.0 | 旧版动画组件已移除；使用新 Animation 系统 |
| `AudioSource`（旧版） | `AudioSource` 组件（`cc.audio`） | 3.0 | 音频系统在 3.0 中重建 |
| `ParticleSystem`（2.x 风格） | `ParticleSystem`（3.x 组件） | 3.0 | API 表面显著变化 |
| `EditBox`（旧版） | `EditBox` 组件（`cc.ui`） | 3.0 | UI 系统重建 |
| `CCClass` 装饰器模式 | `@ccclass` + `@property` 装饰器 | 3.0 | TypeScript 优先方式 |

## 方法与属性

| 已废弃 | 替代方案 | 废弃版本 | 说明 |
|--------|----------|----------|------|
| `node.runAction()` | `Tween` 系统 | 3.0 | Action 系统已移除；使用 `Tween` |
| `cc.director.loadScene()` | `director.loadScene()`（带回调） | 3.0 | 命名空间 `cc.` 可选但建议省略 |
| `component._enabled` | `component.enabled` | 3.0 | 私有前缀已移除 |
| `Node.on()` 字符串事件 | `Node.on()` + `EventTouch` / `EventKeyboard` 类型 | 3.0 | 类型安全事件类型 |
| `instantiate()` 创建预制体 | `instantiate()`（仍有效），但频繁生成优先用 `Pool` | 3.5 | 使用 `NodePool` 或对象池 |
| `Scheduler.schedule()` | `director.getScheduler().schedule()` | 3.0 | API 已迁移 |
| `Texture2D`（旧版加载） | `assetManager.loadRemote()` / `resources.load()` | 3.0 | Asset Manager 是标准方案 |
| `Loader` | `assetManager` | 3.0 | `Loader` 已完全移除 |
| `dragonBones` | `sp.Skeleton`（Spine）或内置动画 | 3.4 | DragonBones 支持已移除 |

## 模式（不仅是 API）

| 已废弃模式 | 替代方案 | 原因 |
|-----------|----------|------|
| 到处使用 `cc.` 命名空间前缀 | 直接导入（`import { Vec3 } from 'cc'`） | Tree-shaking、包体大小 |
| `update()` 中使用 `find()` | 缓存的 `@property` 或 `onLoad()` 中查找 | 性能 |
| `update()` 中使用 `getComponent()` | `onLoad()` 中缓存引用 | 性能 |
| `resources.load()` 加载动态资源 | Asset Bundle（`assetManager.loadBundle()`） | 内存管理、热更新 |
| 游戏逻辑使用 `setTimeout` / `setInterval` | `schedule()` / `Tween` / 协程 | 帧率无关、暂停支持 |
| 不使用 `EventTouch` 的 `touch` 事件 | `EventTouch` + `getLocation()` | 跨平台一致性 |
| 内联 JavaScript（`.js` 文件） | TypeScript（`.ts` 文件） | 类型安全、工具链 |
| 通过代码创建自定义渲染管线 | 自定义渲染管线资产 | 可视化编辑、稳定性 |

## Cocos Creator 2.x → 3.x 迁移提醒

如果模型建议了 2.x API，这些在 3.x 项目中是错误的：

| 2.x API | 3.x 对应 |
|---------|---------|
| `cc.instantiate()` | `instantiate()`（从 'cc' 导入） |
| `cc.director` | `director`（从 'cc' 导入） |
| `cc.Vec2` / `cc.Vec3` | `Vec2` / `Vec3`（从 'cc' 导入） |
| `cc.EventTouch` | `EventTouch`（从 'cc' 导入） |
| `cc.Component` | `Component`（从 'cc' 导入） |
| `cc._decorator` | `cc` 装饰器直接导出 |
| `cc.sys` | `sys`（从 'cc' 导入） |
