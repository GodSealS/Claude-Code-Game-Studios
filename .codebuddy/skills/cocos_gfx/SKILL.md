---
name: cocos_gfx
description: Cocos Creator graphics API abstraction layer expert. Triggers when users need to handle Device, Buffer, Texture, Shader, PipelineState, or need to understand WebGL/Vulkan/Metal backends, rendering pipeline abstraction, shader compilation. 当用户需要处理着色器、GPU缓冲区/纹理、图形后端适配、自定义渲染管线时触发此 Skill。
---

# GFX - Cocos Creator Graphics API Abstraction Layer / 图形API抽象层

## Overview / 概述

The Cocos Creator GFX module (`cocos/gfx`) is an abstraction layer over low-level graphics APIs (WebGL, Vulkan, Metal), providing unified GPU resource management and rendering command interfaces.

> **中文翻译**：Cocos Creator GFX模块(`cocos/gfx`)是底层图形API（WebGL、Vulkan、Metal）的抽象层，提供统一的GPU资源管理和渲染命令接口。

## Domain Knowledge / 领域知识

### Core Design Patterns / 核心设计模式
- **abstraction-layer** — Shields differences between graphics APIs, providing a unified interface / 抽象层 — 屏蔽图形API差异，提供统一接口
- **rendering-api** — Encapsulates GPU rendering commands and resource lifecycle / 渲染API — 封装GPU渲染命令和资源生命周期

### Key Concepts / 关键概念
- `Device` — Graphics device, factory and manager for GPU resources / 图形设备，GPU资源的工厂和管理器
- `Buffer` — GPU buffer (vertex, index, uniform) / GPU缓冲区（顶点、索引、uniform）
- `Texture` — GPU texture (2D, Cube, 3D) / GPU纹理（2D、Cube、3D）
- `Shader` — Shader program (Vertex + Fragment) / 着色器程序（顶点+片元）
- `PipelineState` — Pipeline state (blend, depth, rasterizer) / 管线状态（混合、深度、光栅化）

## Key APIs / 关键API

### Classes / 类
- `Device` — Graphics device (create resources, submit commands) / 图形设备（创建资源、提交命令）
- `Buffer` — Buffer (upload vertex/index/uniform data) / 缓冲区（上传顶点/索引/uniform数据）
- `Texture` — Texture (sampling, mipmap, multi-target rendering) / 纹理（采样、mipmap、多目标渲染）
- `Shader` — Shader (compilation, uniform binding) / 着色器（编译、uniform绑定）
- `PipelineState` — Pipeline state (render state combination) / 管线状态（渲染状态组合）

### Functions / 函数
- `createBuffer()` — Create a GPU buffer / 创建GPU缓冲区
- `createTexture()` — Create a GPU texture / 创建GPU纹理
- `createShader()` — Create a shader program / 创建着色器程序

## Dependencies / 依赖
- No external dependencies (base graphics layer) / 无外部依赖（基础图形层）

## Code Examples / 代码示例

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

## Usage Guide / 使用指南

### When to Use This Skill / 何时使用此技能
- Creating custom shaders and materials / 创建自定义着色器和材质
- Managing GPU buffer and texture resources / 管理GPU缓冲区和纹理资源
- Implementing custom rendering pipeline passes / 实现自定义渲染管线Pass
- Cross-platform graphics backend troubleshooting / 跨平台图形后端故障排查

### Best Practices / 最佳实践
1. Create GPU resources through `Device` uniformly; do not call low-level APIs directly / 通过`Device`统一创建GPU资源，不要直接调用底层API
2. Use `MemoryUsage` flags to distinguish device/host memory for buffers / 使用`MemoryUsage`标志区分缓冲区的设备/主机内存
3. Specify complete `TextureInfo` when creating textures (format, dimensions, mipmap) / 创建纹理时指定完整的`TextureInfo`（格式、尺寸、mipmap）
4. Use the engine's Effect system for shaders rather than writing raw GLSL / 使用引擎的Effect系统编写着色器，而非编写原始GLSL

### Common Tasks / 常见任务
- Create custom Effects and shaders / 创建自定义Effect和着色器
- Manage render targets (RenderTexture) / 管理渲染目标（RenderTexture）
- Configure pipeline state (blend mode, depth test) / 配置管线状态（混合模式、深度测试）
- GPU resource lifecycle management / GPU资源生命周期管理