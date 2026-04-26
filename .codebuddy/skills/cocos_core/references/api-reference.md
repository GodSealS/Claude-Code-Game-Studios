# Core Module - API Reference

<!-- 模块信息 -->
## Module Info
- **Path**: `cocos/core`
- **Language**: TypeScript
- **Files**: ~131 TS files

<!-- 导出 API -->
## Exported APIs

| Class | Description |
|-------|-------------|
| `Component` | Component base class, provides lifecycle callbacks |
| `Node` | Scene node, forms the scene tree |
| `Director` | Game director, manages main loop |
| `Game` | Game entry class |
| `Scene` | Scene root node |

<!-- 公共函数 -->
## Public Functions

| Function | Description |
|----------|-------------|
| `find(path)` | Find a node in the scene by path |
| `isValid(obj)` | Check if an object is valid (not destroyed) |
| `destroy(obj)` | Destroy an object and mark for recycling |

<!-- 依赖 -->
## Dependencies
- None (base module)

<!-- 设计模式 -->
## Design Patterns

| Pattern | Use Case |
|---------|----------|
| ecs-pattern | Node + Component Entity-Component architecture |
| object-pool | NodePool for reusing nodes and components |
| event-emitter | EventTarget / Eventify for event communication |

<!-- 命名约定 -->
## Naming Conventions
- Classes: PascalCase (e.g., `Component`)
- Functions: camelCase (e.g., `find`)
- Constants: UPPER_CASE

<!-- 中文翻译 -->
## Module Structure
```
core/
├── index.ts          # Public API exports
├── Component.ts      # Component base class
├── Node.ts           # Scene node
├── Director.ts       # Game director
├── Game.ts           # Game entry
├── Scene.ts          # Scene container
└── Eventify.ts       # Event system mixin
```
