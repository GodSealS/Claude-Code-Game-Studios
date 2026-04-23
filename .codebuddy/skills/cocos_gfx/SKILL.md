---
name: cocos_gfx
description: Cocos Creator graphics API abstraction layer expert. Triggers when users need to handle Device, Buffer, Texture, Shader, PipelineState, or need to understand WebGL/Vulkan/Metal backends, rendering pipeline abstraction, shader compilation. 当用户需要处理着色器、GPU缓冲区/纹理、图形后端适配、自定义渲染管线时触发此 Skill。
---

# GFX - Cocos Creator Graphics API Abstraction Layer

## Overview

The Cocos Creator GFX module (`cocos/gfx`) is an abstraction layer over low-level graphics APIs (WebGL, Vulkan, Metal), providing unified GPU resource management and rendering command interfaces.

## Domain Knowledge

### Core Design Patterns
- **abstraction-layer** — Shields differences between graphics APIs, providing a unified interface
- **rendering-api** — Encapsulates GPU rendering commands and resource lifecycle

### Key Concepts
- `Device` — Graphics device, factory and manager for GPU resources
- `Buffer` — GPU buffer (vertex, index, uniform)
- `Texture` — GPU texture (2D, Cube, 3D)
- `Shader` — Shader program (Vertex + Fragment)
- `PipelineState` — Pipeline state (blend, depth, rasterizer)

## Key APIs

### Classes
- `Device` — Graphics device (create resources, submit commands)
- `Buffer` — Buffer (upload vertex/index/uniform data)
- `Texture` — Texture (sampling, mipmap, multi-target rendering)
- `Shader` — Shader (compilation, uniform binding)
- `PipelineState` — Pipeline state (render state combination)

### Functions
- `createBuffer()` — Create a GPU buffer
- `createTexture()` — Create a GPU texture
- `createShader()` — Create a shader program

## Dependencies
- No external dependencies (base graphics layer)

## Code Examples

```typescript
import { Device, Buffer, Texture, Shader } from 'cc';

// Get graphics device
const device = director.root.device;

// Create vertex buffer
const vertexBuffer = device.createBuffer({
    usage: BufferUsage.VERTEX,
    memUsage: MemoryUsage.DEVICE,
    size: vertices.byteLength,
});
vertexBuffer.update(vertices);

// Create shader
const shader = device.createShader({
    stages: [
        { stage: ShaderStage.VERTEX, source: vertSource },
        { stage: ShaderStage.FRAGMENT, source: fragSource },
    ],
});
```

## Usage Guide

### When to Use This Skill
- Creating custom shaders and materials
- Managing GPU buffer and texture resources
- Implementing custom rendering pipeline passes
- Cross-platform graphics backend troubleshooting

### Best Practices
1. Create GPU resources through `Device` uniformly; do not call low-level APIs directly
2. Use `MemoryUsage` flags to distinguish device/host memory for buffers
3. Specify complete `TextureInfo` when creating textures (format, dimensions, mipmap)
4. Use the engine's Effect system for shaders rather than writing raw GLSL

### Common Tasks
- Create custom Effects and shaders
- Manage render targets (RenderTexture)
- Configure pipeline state (blend mode, depth test)
- GPU resource lifecycle management
