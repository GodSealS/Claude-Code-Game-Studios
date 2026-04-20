---
name: /wechat-shader
description: Initialize WebGL shader pipeline for WeChat Mini Games, convert shaders from Unity/Unreal/Godot to WebGL GLSL, optimize for mobile performance, and manage render pipeline standards.
agent: wechat-shader-specialist
---

# /wechat-shader

Initialize WebGL shader development for WeChat Mini Games, convert shaders from other engines, optimize for mobile performance, and establish render pipeline standards.

## When to Use

- Setting up shader pipeline for a new WeChat Mini Game project
- Converting Unity HLSL, Unreal Material, or Godot shaders to WebGL GLSL
- Creating custom post-processing effects
- Optimizing shaders for mobile GPU performance
- Implementing WebGL 2.0 features when available
- Establishing render pipeline standards and performance budgets
- Managing shader variants and feature toggles

## What It Does

1. **Analyzes project requirements** — WebGL version, target devices, shader complexity, render budget
2. **Sets up shader pipeline** — Directory structure, shader loading system, uniform management, variant system
3. **Converts shaders** — Translates HLSL/Material/Godot to GLSL with proper mappings
4. **Optimizes for mobile** — Precision hints, texture lookup reduction, branch elimination, LOD fallbacks
5. **Creates boilerplate** — Vertex/fragment shader templates, WebGL context setup
6. **Establishes render standards** — Performance budgets, shader complexity limits, fallback strategies

## Usage

```
/wechat-shader convert [source-engine] [shader-file]
/wechat-shader setup [webgl-version]
/wechat-shader optimize [shader-file]
/wechat-shader budget [target-fps]
/wechat-shader variant [shader-name] [feature-flags]
```

## Example

```
/wechat-shader setup webgl2
```

This will:
- Create `shaders/` directory structure
- Set up shader loading and caching system
- Create vertex/fragment shader templates
- Add WebGL 2.0 context initialization
- Include mobile optimization patterns
- Set up render pipeline performance budgets
- Create shader variant system with feature toggles

## Output

Creates the following structure:

```
shaders/
├── lib/
│   ├── shader-loader.ts      # Shader compilation and program linking
│   ├── uniform-manager.ts    # Uniform location caching
│   ├── buffer-manager.ts     # VAO/VBO management
│   └── variant-manager.ts    # Shader variant compilation and selection
├── core/
│   ├── sprite.vert           # 2D sprite vertex shader
│   ├── sprite.frag           # 2D sprite fragment shader
│   ├── post-process.vert     # Fullscreen quad vertex shader
│   └── post-process.frag     # Post-processing fragment shader
├── effects/
│   ├── blur.frag             # Gaussian blur
│   ├── outline.frag          # Outline effect
│   ├── glow.frag             # Glow/bloom effect
│   └── dissolve.frag         # Dissolve transition
├── fallbacks/
│   ├── sprite-low.frag       # Low-quality fallback for weak GPUs
│   └── effect-simple.frag    # Simplified effect fallback
└── utils/
    ├── precision.glsl        # Precision helpers for mobile
    └── quality.glsl          # Quality tier macros
```

## Shader Conversion Support

| Source Engine | Supported Shader Types | Key Translation Rules |
|--------------|------------------------|----------------------|
| Unity | HLSL, ShaderGraph (via generated HLSL) | `float4` → `vec4`, `mul(M,v)` → `M * v`, `sampler2D` → uniform, `_Time.y` → `u_time` |
| Unreal | HLSL Material expressions | WorldPositionOffset → vertex displacement, Custom expression → direct GLSL, PBR → simplified Blinn-Phong |
| Godot | Godot shading language | `shader_type` → stripped, `hint_albedo` → regular sampler, `VERTEX` → `a_position`, `TIME` → `u_time` |

## Render Pipeline Standards

| Quality Tier | Max Fragment Instructions | Max Texture Lookups | Max Varyings | Recommended Features |
|-------------|--------------------------|--------------------:|-------------:|---------------------|
| Low | 32 | 4 | 8 | No post-processing, simple lighting |
| Medium | 64 | 8 | 12 | Basic post-processing, 1 light |
| High | 128 | 16 | 16 | Full post-processing, multi-light |

## Mobile Optimization Features

- Automatic precision qualifier insertion (mediump by default, highp only where needed)
- Dependent texture read detection
- Branch-to-step conversion suggestions
- Texture atlas UV packing helpers
- Shader LOD fallback system
- Dynamic quality tier selection based on device capability
- Variant stripping for unused features

## Shader Variant System

```typescript
// Compile shader with specific features
const variant = shaderManager.compileVariant('sprite', {
  ALPHA_TEST: true,
  CUSTOM_UV: false,
  EMISSION: true,
  PIXEL_SNAP: true
});
```

Features are defined as preprocessor macros, and only enabled variants are compiled and cached.
