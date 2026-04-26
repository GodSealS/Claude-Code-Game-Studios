# Rendering Module - API Reference

<!-- 模块信息 -->
## Module Info
- **Path**: `cocos/rendering`
- **Language**: TypeScript
- **Files**: ~110 TS files

<!-- 导出 API -->
## Exported APIs

| Class | Description |
|-------|-------------|
| `Renderer` | Renderer, drives the rendering process |
| `Camera` | Camera component (view, projection, render target) |
| `Light` | Light base class |
| `Pipeline` | Rendering pipeline (Forward/Deferred) |

<!-- 公共函数 -->
## Public Functions

| Function | Description |
|----------|-------------|
| `render()` | Execute one frame of rendering |
| `present()` | Submit rendering results |
| `resize(width, height)` | Respond to window size changes |

<!-- 依赖 -->
## Dependencies
- `gfx` — GPU resources and commands
- `core` — Component base class, Node

<!-- 设计模式 -->
## Design Patterns

| Pattern | Use Case |
|---------|----------|
| pipeline-pattern | Forward/Deferred configurable rendering pipeline |
| render-pass | Each rendering pass executes a specific task |

<!-- 命名约定 -->
## Naming Conventions
- Classes: PascalCase (e.g., `ForwardPipeline`)
- Functions: camelCase (e.g., `present`)
- Constants: UPPER_CASE
