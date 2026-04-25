# Rendering Module - API Reference

## Module Info
- **Path**: `cocos/rendering`
- **Language**: TypeScript
- **Files**: ~110 TS files

## Exported APIs

| Class | Description |
|-------|-------------|
| `Renderer` | Renderer, drives the rendering process |
| `Camera` | Camera component (view, projection, render target) |
| `Light` | Light base class |
| `Pipeline` | Rendering pipeline (Forward/Deferred) |

## Public Functions

| Function | Description |
|----------|-------------|
| `render()` | Execute one frame of rendering |
| `present()` | Submit rendering results |
| `resize(width, height)` | Respond to window size changes |

## Dependencies
- `gfx` — GPU resources and commands
- `core` — Component base class, Node

## Design Patterns

| Pattern | Use Case |
|---------|----------|
| pipeline-pattern | Forward/Deferred configurable rendering pipeline |
| render-pass | Each rendering pass executes a specific task |

## Naming Conventions
- Classes: PascalCase (e.g., `ForwardPipeline`)
- Functions: camelCase (e.g., `present`)
- Constants: UPPER_CASE
