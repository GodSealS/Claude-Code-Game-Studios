# Godot Rendering — Quick Reference / Godot渲染模块


> **中文翻译**：本文档为Godot引擎参考文档。所有代码示例和技术术语保持英文原文。

Last verified: 2026-02-12 | Engine: Godot 4.6

<!-- 自 ~4.3 以来的变化（LLM 训练截止） -->
## What Changed Since ~4.3 (LLM Cutoff)

<!-- 中文翻译 -->
### 4.6 Changes
- **D3D12 is the default rendering backend on Windows** (was Vulkan)
- **Glow processes before tonemapping** (was after) — uses screen blending mode
- **AgX tonemapper**: new white point and contrast controls
- **SSR overhauled**: better realism, visual stability, and performance

<!-- 中文翻译 -->
### 4.5 Changes
- **Shader Baker**: Pre-compiles shaders to reduce startup time
- **SMAA 1x**: New anti-aliasing option (sharper than FXAA, cheaper than TAA)
- **Stencil buffer support**: Enables selective geometry masking/portal effects
- **Bent normal maps**: Directional occlusion encoded in normal map textures
- **Specular occlusion**: Ambient occlusion now correctly affects reflections

<!-- 中文翻译 -->
### 4.4 Changes
- **`RenderingDevice.draw_list_begin`**: Many parameters removed; optional `breadcrumb` added
- **Shader texture types**: Changed from `Texture2D` to `Texture` base type
- **Particles `.restart()`**: Added optional `keep_seed` parameter

<!-- 中文翻译 -->
### 4.3 Changes (in training data)
- **Compositor node**: `Compositor` + `CompositorEffect` for post-processing chains

<!-- 当前 API 模式 -->
## Current API Patterns

<!-- 中文翻译 -->
### Post-Processing (4.3+)
```gdscript
# Use Compositor node — NOT manual viewport shader chains
# Add Compositor as child of WorldEnvironment or Camera3D
# Create CompositorEffect resources for each post-process step
```

<!-- 中文翻译 -->
### Anti-Aliasing Options (4.6)
```
Project Settings → Rendering → Anti Aliasing:
- MSAA 2D/3D: Hardware MSAA (quality but expensive)
- Screen Space AA: FXAA (fast, blurry) or SMAA (sharp, moderate cost)  # SMAA new in 4.5
- TAA: Temporal (best quality, ghosting on fast motion)
```

<!-- 中文翻译 -->
### Rendering Backend Selection (4.6)
```
Project Settings → Rendering → Renderer:
- Forward+ (default): Full featured, desktop-focused
- Mobile: Optimized for mobile/low-end, limited features
- Compatibility: OpenGL 3.3 / WebGL 2, broadest hardware support

Windows default backend: D3D12 (was Vulkan pre-4.6)
```

<!-- 常见错误 -->
## Common Mistakes
- Assuming Vulkan is the default backend on Windows (D3D12 since 4.6)
- Using manual viewport chains instead of Compositor for post-processing
- Using `Texture2D` in shader uniform types (use `Texture` since 4.4)
- Not using Shader Baker for projects with many shader variants
