# Cocos Creator — Deprecated APIs

Last verified: 2026-04-25

If an agent suggests any API in the "Deprecated" column, it MUST be replaced
with the "Use Instead" column.

## Classes & Components

| Deprecated | Use Instead | Since | Notes |
|------------|-------------|-------|-------|
| `Animation` (legacy) | `Animation` (new component) + `AnimationClip` | 3.0 | Legacy animation component removed; use new Animation system |
| `AudioSource` (legacy) | `AudioSource` component in `cc.audio` | 3.0 | Audio system rebuilt in 3.0 |
| `ParticleSystem` (2.x style) | `ParticleSystem` (3.x component) | 3.0 | API surface changed significantly |
| `EditBox` (legacy) | `EditBox` component in `cc.ui` | 3.0 | UI system rebuilt |
| `CCClass` decorator pattern | `@ccclass` + `@property` decorators | 3.0 | TypeScript-first approach |

## Methods & Properties

| Deprecated | Use Instead | Since | Notes |
|------------|-------------|-------|-------|
| `node.runAction()` | `Tween` system | 3.0 | Action system removed; use `Tween` |
| `cc.director.loadScene()` | `director.loadScene()` with callbacks | 3.0 | Namespace `cc.` optional but preferred without |
| `component._enabled` | `component.enabled` | 3.0 | Private prefix removed |
| `Node.on()` string events | `Node.on()` with `EventTouch` / `EventKeyboard` types | 3.0 | Type-safe event types |
| `instantiate()` for prefabs | `instantiate()` (still valid) but prefer `Pool` for frequent spawns | 3.5 | Use `NodePool` or object pooling |
| `Scheduler.schedule()` | `scheduler.schedule()` via `director.getScheduler()` | 3.0 | API moved |
| `Texture2D` (legacy loading) | `assetManager.loadRemote()` / `resources.load()` | 3.0 | Asset Manager is the standard |
| `Loader` | `assetManager` | 3.0 | `Loader` completely removed |
| `dragonBones` | `sp.Skeleton` (Spine) or built-in animation | 3.4 | DragonBones support dropped |

## Patterns (Not Just APIs)

| Deprecated Pattern | Use Instead | Why |
|--------------------|-------------|-----|
| Using `cc.` namespace prefix everywhere | Direct imports (`import { Vec3 } from 'cc'`) | Tree-shaking, bundle size |
| `find()` in `update()` | Cached `@property` or `onLoad()` lookup | Performance |
| `getComponent()` in `update()` | Cached reference in `onLoad()` | Performance |
| `resources.load()` for dynamic assets | Asset bundles via `assetManager.loadBundle()` | Memory management, hot update |
| `setTimeout` / `setInterval` for game logic | `schedule()` / `Tween` / coroutines | Frame-rate independence, pause support |
| `touch` events without `EventTouch` | `EventTouch` with `getLocation()` | Cross-platform consistency |
| Inline JavaScript (`.js` files) | TypeScript (`.ts` files) | Type safety, tooling |
| Custom render pipeline via code | Custom Render Pipeline asset | Visual editing, stability |

## Cocos Creator 2.x → 3.x Migration Reminders

If the model suggests 2.x APIs, these are WRONG for 3.x projects:

| 2.x API | 3.x Equivalent |
|---------|----------------|
| `cc.instantiate()` | `instantiate()` (from 'cc') |
| `cc.director` | `director` (from 'cc') |
| `cc.Vec2` / `cc.Vec3` | `Vec2` / `Vec3` (from 'cc') |
| `cc.EventTouch` | `EventTouch` (from 'cc') |
| `cc.Component` | `Component` (from 'cc') |
| `cc._decorator` | `cc` decorator exports directly |
| `cc.sys` | `sys` (from 'cc') |
