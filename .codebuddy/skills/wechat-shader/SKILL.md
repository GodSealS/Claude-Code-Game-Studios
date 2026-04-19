---
name: /wechat-shader
description: Initialize WebGL shader pipeline for WeChat Mini Games, convert shaders from Unity/Unreal/Godot to WebGL GLSL, and optimize for mobile performance.
agent: wechat-shader-specialist
---

# /wechat-shader

Initialize WebGL shader development for WeChat Mini Games, convert shaders from other engines, and optimize for mobile performance.

## When to Use

- Setting up shader pipeline for a new WeChat Mini Game project
- Converting Unity HLSL, Unreal Material, or Godot shaders to WebGL GLSL
- Creating custom post-processing effects
- Optimizing shaders for mobile GPU performance
- Implementing WebGL 2.0 features when available

## What It Does

1. **Analyzes project requirements** — WebGL version, target devices, shader complexity
2. **Sets up shader pipeline** — Directory structure, shader loading system, uniform management
3. **Converts shaders** — Translates HLSL/Material/Godot to GLSL with proper mappings
4. **Optimizes for mobile** — Precision hints, texture lookup reduction, branch elimination
5. **Creates boilerplate** — Vertex/fragment shader templates, WebGL context setup

## Usage

```
/wechat-shader convert [source-engine] [shader-file]
/wechat-shader setup [webgl-version]
/wechat-shader optimize [shader-file]
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

## Output

Creates the following structure:

```
shaders/
├── lib/
│   ├── shader-loader.js      # Shader compilation and program linking
│   ├── uniform-manager.js    # Uniform location caching
│   └── buffer-manager.js     # VAO/VBO management
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
└── utils/
    └── precision.glsl        # Precision helpers for mobile
```

## Shader Conversion Support

| Source Engine | Supported Shader Types |
|--------------|------------------------|
| Unity | HLSL, ShaderGraph (via generated HLSL) |
| Unreal | HLSL Material expressions |
| Godot | GDScript shader language |

## Mobile Optimization Features

- Automatic precision qualifier insertion
- Dependent texture read detection
- Branch-to-step conversion suggestions
- Texture atlas UV packing helpers
