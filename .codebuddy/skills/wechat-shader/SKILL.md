---
name: /wechat-shader
description: Initialize WebGL shader pipeline for WeChat Mini Games, convert shaders from Unity/Unreal/Godot to WebGL GLSL, optimize for mobile performance, and manage render pipeline standards. / 初始化微信小游戏 WebGL 着色器管线，将 Unity/Unreal/Godot 着色器转换为 WebGL GLSL，针对移动端性能优化，并管理渲染管线标准。
agent: wechat-shader-specialist
---

# /wechat-shader

Initialize WebGL shader development for WeChat Mini Games, convert shaders from other engines, optimize for mobile performance, and establish render pipeline standards. / 为微信小游戏初始化 WebGL 着色器开发，转换其他引擎的着色器，针对移动端性能优化，并建立渲染管线标准。

## When to Use / 何时使用

- Setting up shader pipeline for a new WeChat Mini Game project / 为新微信小游戏项目设置着色器管线
- Converting Unity HLSL, Unreal Material, or Godot shaders to WebGL GLSL / 将 Unity HLSL、Unreal Material 或 Godot 着色器转换为 WebGL GLSL
- Creating custom post-processing effects / 创建自定义后期处理效果
- Optimizing shaders for mobile GPU performance / 为移动端 GPU 性能优化着色器
- Implementing WebGL 2.0 features when available / 在可用时实现 WebGL 2.0 功能
- Establishing render pipeline standards and performance budgets / 建立渲染管线标准和性能预算
- Managing shader variants and feature toggles / 管理着色器变体和功能开关

## What It Does / 功能

1. **Analyzes project requirements** — WebGL version, target devices, shader complexity, render budget / **分析项目需求** — WebGL 版本、目标设备、着色器复杂度、渲染预算
2. **Sets up shader pipeline** — Directory structure, shader loading system, uniform management, variant system / **设置着色器管线** — 目录结构、着色器加载系统、uniform 管理、变体系统
3. **Converts shaders** — Translates HLSL/Material/Godot to GLSL with proper mappings / **转换着色器** — 使用适当的映射将 HLSL/Material/Godot 转换为 GLSL
4. **Optimizes for mobile** — Precision hints, texture lookup reduction, branch elimination, LOD fallbacks / **为移动端优化** — 精度提示、纹理查找减少、分支消除、LOD 后备方案
5. **Creates boilerplate** — Vertex/fragment shader templates, WebGL context setup / **创建样板代码** — 顶点/片段着色器模板、WebGL 上下文设置
6. **Establishes render standards** — Performance budgets, shader complexity limits, fallback strategies / **建立渲染标准** — 性能预算、着色器复杂度限制、后备策略

## Usage / 用法

```
/wechat-shader convert [source-engine] [shader-file]
/wechat-shader setup [webgl-version]
/wechat-shader optimize [shader-file]
/wechat-shader budget [target-fps]
/wechat-shader variant [shader-name] [feature-flags]
```

<!-- 示例 -->
## Example

```
/wechat-shader setup webgl2
```

This will: / 这将：
- Create `shaders/` directory structure / 创建 `shaders/` 目录结构
- Set up shader loading and caching system / 设置着色器加载和缓存系统
- Create vertex/fragment shader templates / 创建顶点/片段着色器模板
- Add WebGL 2.0 context initialization / 添加 WebGL 2.0 上下文初始化
- Include mobile optimization patterns / 包含移动优化模式
- Set up render pipeline performance budgets / 设置渲染管线性能预算
- Create shader variant system with feature toggles / 创建带功能开关的着色器变体系统

<!-- 输出 -->
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

## Shader Conversion Support / 着色器转换支持

| Source Engine | Supported Shader Types | Key Translation Rules |
|--------------|------------------------|----------------------|
| Unity | HLSL, ShaderGraph (via generated HLSL) | `float4` → `vec4`, `mul(M,v)` → `M * v`, `sampler2D` → uniform, `_Time.y` → `u_time` |
| Unreal | HLSL Material expressions | WorldPositionOffset → vertex displacement, Custom expression → direct GLSL, PBR → simplified Blinn-Phong |
| Godot | Godot shading language | `shader_type` → stripped, `hint_albedo` → regular sampler, `VERTEX` → `a_position`, `TIME` → `u_time` |

> **中文翻译**：
> | 源引擎 | 支持的着色器类型 | 关键转换规则 |
> |--------|------------------|--------------|
> | Unity | HLSL, ShaderGraph（通过生成的 HLSL） | `float4` → `vec4`, `mul(M,v)` → `M * v`, `sampler2D` → uniform, `_Time.y` → `u_time` |
> | Unreal | HLSL Material 表达式 | WorldPositionOffset → 顶点位移，Custom expression → 直接 GLSL，PBR → 简化的 Blinn-Phong |
> | Godot | Godot 着色语言 | `shader_type` → 剥离，`hint_albedo` → 常规采样器，`VERTEX` → `a_position`, `TIME` → `u_time` |

## Render Pipeline Standards / 渲染管线标准

| Quality Tier | Max Fragment Instructions | Max Texture Lookups | Max Varyings | Recommended Features |
|-------------|--------------------------|--------------------:|-------------:|---------------------|
| Low | 32 | 4 | 8 | No post-processing, simple lighting |
| Medium | 64 | 8 | 12 | Basic post-processing, 1 light |
| High | 128 | 16 | 16 | Full post-processing, multi-light |

> **中文翻译**：
> | 质量等级 | 最大片段指令数 | 最大纹理查找数 | 最大 varying 数 | 推荐功能 |
> |----------|----------------|----------------|----------------|----------|
> | 低 | 32 | 4 | 8 | 无后期处理，简单光照 |
> | 中 | 64 | 8 | 12 | 基本后期处理，1 个光源 |
> | 高 | 128 | 16 | 16 | 完整后期处理，多光源 |

## Mobile Optimization Features / 移动优化功能

- Automatic precision qualifier insertion (mediump by default, highp only where needed) / 自动精度限定符插入（默认 mediump，仅在需要时使用 highp）
- Dependent texture read detection / 依赖纹理读取检测
- Branch-to-step conversion suggestions / 分支到步进转换建议
- Texture atlas UV packing helpers / 纹理图集 UV 打包辅助工具
- Shader LOD fallback system / 着色器 LOD 后备系统
- Dynamic quality tier selection based on device capability / 基于设备能力的动态质量等级选择
- Variant stripping for unused features / 为未使用功能剥离变体

## Shader Variant System / 着色器变体系统

```typescript
// Compile shader with specific features / 使用特定功能编译着色器
const variant = shaderManager.compileVariant('sprite', {
  ALPHA_TEST: true,
  CUSTOM_UV: false,
  EMISSION: true,
  PIXEL_SNAP: true
});
```

Features are defined as preprocessor macros, and only enabled variants are compiled and cached. / 功能被定义为预处理器宏，只有启用的变体才会被编译和缓存。
