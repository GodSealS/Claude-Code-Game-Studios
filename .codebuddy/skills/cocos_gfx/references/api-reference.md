# GFX Module - API Reference

<!-- 模块信息 -->
## Module Info
- **Path**: `cocos/gfx`
- **Language**: TypeScript
- **Files**: ~109 TS files
- **Supported Backends**: WebGL 2.0 / Vulkan / Metal

<!-- 导出 API -->
## Exported APIs

| Class | Description |
|-------|-------------|
| `Device` | Graphics device, GPU resource factory and command submission |
| `Buffer` | GPU buffer (Vertex/Index/Uniform/Storage) |
| `Texture` | GPU texture (2D/Cube/3D/Array) |
| `Shader` | Shader program (compilation, linking, uniforms) |
| `PipelineState` | Pipeline state (Blend/Depth/Rasterizer) |

<!-- 公共函数 -->
## Public Functions

| Function | Description |
|----------|-------------|
| `createBuffer(info)` | Create a GPU buffer |
| `createTexture(info)` | Create a GPU texture |
| `createShader(info)` | Create a shader program |

<!-- 依赖 -->
## Dependencies
- None (base graphics layer)

<!-- 设计模式 -->
## Design Patterns

| Pattern | Use Case |
|---------|----------|
| abstraction-layer | Shields WebGL/Vulkan/Metal differences |
| rendering-api | Encapsulates GPU commands and resource lifecycle |

<!-- 命名约定 -->
## Naming Conventions
- Classes: PascalCase (e.g., `PipelineState`)
- Functions: camelCase (e.g., `createBuffer`)
- Enums: PascalCase (e.g., `BufferUsage`)
