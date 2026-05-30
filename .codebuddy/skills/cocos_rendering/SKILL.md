---
name: cocos_rendering
description: Cocos Creator rendering & GFX expert. Triggers for Effect shaders, materials, GPU resources (Device/Buffer/Texture/Shader/PipelineState), Forward/Deferred pipeline, camera, lighting, shadows, post-processing, custom render passes, and cross-platform (WebGL/Vulkan/Metal) rendering.
allowed-tools: Read, Grep
argument-hint: ""
user-invocable: false
---

# Rendering & GFX - Cocos Creator Full Rendering Stack

> **READY**: Skill loaded — provides Cocos Creator rendering & GFX domain knowledge.

## Overview

Covers the complete Cocos Creator rendering stack:
- `cocos/rendering` — pipeline, camera, lighting, shadows, post-processing
- `cocos/gfx` — GPU abstraction layer (WebGL, Vulkan, Metal), buffers, textures, shaders

## Domain Knowledge

### Core Design Patterns
- **pipeline-pattern** — Configurable rendering pipeline executed pass by pass
- **render-pass** — Each rendering pass handles a specific rendering task
- **abstraction-layer** — Shields differences between graphics APIs, providing unified interface

### Key Concepts — Rendering Layer
- `Renderer` — Drives the rendering process
- `Camera` — Viewpoint, projection, render target, culling, visibility layers
- `Light` — Directional, Point, Spot, Ambient
- `Pipeline` — Forward (default), Deferred
- `Shadows` — Shadow map, cascades, PCF filtering

### Key Concepts — GFX Layer
- `Device` — Graphics device, factory and manager for GPU resources
- `Buffer` — GPU buffer (vertex, index, uniform, storage)
- `Texture` — GPU texture (2D, Cube, 3D, RenderTarget)
- `Shader` — Shader program compilation, uniform/attribute reflection
- `PipelineState` — Blend, depth/stencil, rasterizer, input layout

## Key APIs

### Pipeline / Camera / Light
- `Camera` — `fov`, `near`, `far`, `clearFlags`, `visibility`, `projection`
- `DirectionalLight` — `intensity`, `color`, `shadowEnabled`, `shadowPcf`
- `PointLight` / `SpotLight` — `range`, `intensity`, `color`
- Forward vs Deferred pipeline selection

### GFX — GPU Resources
- `device.createBuffer()` — Vertex/index/uniform buffer
- `device.createTexture()` — 2D/Cube/3D/RenderTarget texture
- `device.createShader()` — Shader from GLSL stages
- `device.createPipelineState()` — Blend/depth/rasterizer state
- `device.createRenderPass()` — Custom render pass with attachments
- `device.createFramebuffer()` — Framebuffer wrapping render targets

## Shader Compilation Pipeline
```
GLSL Source (.effect / inline) → Effect Compiler → SPIR-V (Vulkan) / GLSL ES (WebGL)
     → Backend Compiler → Platform Shader
```

## Pipeline Selection
| Factor          | Forward                | Deferred               |
|-----------------|------------------------|------------------------|
| Light count     | < 8 per object         | Unlimited (G-Buffer)   |
| Transparency    | Native                 | Needs forward pass     |
| Anti-aliasing   | MSAA supported         | Post-process AA only   |
| Mobile          | Excellent              | Avoid                  |
| Memory          | Lower                  | Higher (G-Buffer)      |

## Cross-Platform Compatibility
| Feature         | WebGL 1.0             | WebGL 2.0             | Vulkan/Metal |
|-----------------|-----------------------|-----------------------|--------------|
| RGBA8           | ✓                     | ✓                     | ✓            |
| Uniform buffers | ✗ (emulated)          | ✓                     | ✓            |
| Storage buffers | ✗                     | ✗                     | ✓            |
| Compute shaders | ✗                     | ✗                     | ✓            |
| MRT             | Extension             | ✓                     | ✓            |
| BCn / ETC2/ASTC | ✗ / Extension         | ✗ / Extension         | ✓            |

## Code Examples

```typescript
import { Camera, DirectionalLight, director } from 'cc';

// Camera setup
const camera = node.getComponent(Camera);
camera.fov = 60;
camera.near = 0.1;
camera.far = 1000;
camera.visibility = Layers.Enum.DEFAULT;

// Directional light with shadows
const light = lightNode.addComponent(DirectionalLight);
light.shadowEnabled = true;

// GFX — Create shader from source
const device = director.root.device;
const shader = device.createShader({
    stages: [
        { stage: ShaderStage.VERTEX, source: vertSource },
        { stage: ShaderStage.FRAGMENT, source: fragSource },
    ],
});

// GFX — Render target
const rt = device.createTexture({
    textureType: TextureType.TEX2D,
    usage: TextureUsage.COLOR_ATTACHMENT | TextureUsage.SAMPLED,
    format: Format.RGBA8,
    width: 1024, height: 1024,
});
```

## Usage Guide

### When to Use
- Effect shader and material creation
- GPU buffer/texture resource management
- Forward/Deferred pipeline configuration
- Camera setup (FOV, projection, culling, layers)
- Lighting (Directional, Point, Spot) and shadow mapping
- Post-processing effects (bloom, tonemapping, color grading)
- Custom render pass and framebuffer setup
- Cross-platform shader/rendering troubleshooting

### Best Practices
1. Prefer Forward pipeline on mobile; Deferred only on high-end desktop
2. Use `visibility` layers to control camera rendering, reduce unnecessary draws
3. Only enable shadows on necessary objects; control shadow map resolution (512-2048)
4. Combine post-processing into fewer passes to reduce fullscreen draws
5. Create GPU resources through `Device` uniformly; do not call low-level APIs directly
6. Pre-compile all shader variants at init — never compile on hot path
7. Use buffer pools (ring buffer / triple buffering) for per-frame uniform updates
8. Check `device.capabilities` before assuming GPU features (compute, MRT, instancing)

### Common Tasks
- Write Effect shaders and configure materials
- Set up Forward or Deferred rendering pipeline
- Configure multi-camera and rendering layers
- Set up directional/point/spot lights with shadows
- Implement bloom, tonemapping, color grading post-processing
- Create custom render passes with RenderTexture
- Manage GPU resource lifecycle
- Optimize draw calls, overdraw, and shader complexity

## Post-Processing Pipeline

```typescript
import { Camera, director } from 'cc';

// Bloom + Tone mapping + Vignette (via Effect assets and Blit material)
// 1. Create bloom Effect asset (.effect file) → post-process pass
// 2. Create tone mapping Effect asset → ACES / Reinhard / Filmic pass
// 3. Create vignette Effect asset → edge darken pass

const camera = node.getComponent(Camera);

// Post-processing via RenderTexture + Blit:
// - Render scene to HDR RenderTexture
// - Apply bloom pass (threshold-based luminance extraction → gaussian blur → composite)
// - Apply tone mapping pass (HDR → LDR)
// - Apply vignette pass (multiply screen with radial gradient)
// - Blit final result to screen

// Bloom parameters:
const bloomSettings = {
    threshold: 0.8,       // Minimum luminance to bloom
    intensity: 1.2,        // Bloom brightness multiplier
    iterations: 4,         // Gaussian blur iterations (higher = smoother, slower)
    radius: 2.0            // Blur sample radius
};

// Tone mapping modes:
// - ACES (cinematic, recommended default) — natural contrast, filmic look
// - Reinhard — simple, prone to desaturation
// - Linear — no mapping, raw HDR
```

## Cascaded Shadow Mapping

```typescript
import { DirectionalLight, Camera } from 'cc';

// Directional light with cascaded shadows (CSM)
const light = lightNode.getComponent(DirectionalLight);
light.shadowEnabled = true;
// Configure in DirectionalLight component:
light.shadowPcf = 2;                    // PCF filter samples (0-4, higher = softer)
light.shadowBias = 0.001;               // Depth bias to prevent shadow acne
light.shadowNormalBias = 0.02;          // Normal offset bias
light.shadowMapSize = 1024;             // Shadow map resolution per cascade

// Cascaded shadow splits (distance-based quality levels):
// - Near cascade (< 20m): high quality, tight frustum
// - Mid cascade (20-60m): medium quality
// - Far cascade (> 60m): low quality, wide frustum
// Control via DirectionalLight.shadowDistance + camera far plane
// Note: CSM auto-splits based on camera frustum; adjust near/far plane to balance quality
// Trade-off: more cascades = higher memory (N × shadowMapSize²) but better quality
```

## Related Skills
- `cocos_core` — Component lifecycle, Node hierarchy, Game/Director
- `cocos_3d` — MeshRenderer, SkinnedMeshRenderer, model rendering pipeline
- `cocos_2d` — Sprite, Label, 2D rendering and batching
- `cocos_editor` — MCP editor build pipeline, platform-specific build settings

## Recommended Next Steps
1. Verify Cocos Creator version via `docs/engine-reference/cocos/VERSION.md`
2. Check `device.capabilities` before using compute shaders, MRT, or SSBO
3. For 3D model rendering integration, load `cocos_3d` for mesh/material binding
4. For UI layer rendering, load `cocos_2d` for sprite batching and Canvas setup
5. For build-time platform configuration, use `cocos_editor` MCP tools
