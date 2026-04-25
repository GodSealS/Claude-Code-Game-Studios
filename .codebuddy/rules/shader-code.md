---
paths:
  - "assets/shaders/**"
---

# Shader Code Standards / 着色器代码标准

All shader files in `assets/shaders/` must follow these standards to maintain visual quality, performance, and cross-platform compatibility. / `assets/shaders/` 中的所有着色器文件必须遵循这些标准，以保持视觉质量、性能和跨平台兼容性。

## Naming Conventions / 命名约定

- File naming: `[type]_[category]_[name].[ext]` / 文件命名：`[类型]_[类别]_[名称].[扩展名]`
  - `spatial_env_water.gdshader` (Godot)
  - `SG_Env_Water` (Unity Shader Graph)
  - `M_Env_Water` (Unreal Material)
- Use descriptive names that indicate the material purpose / 使用描述性名称以表明材质用途
- Prefix with shader type: `spatial_`, `canvas_`, `particles_`, `post_` / 使用着色器类型前缀：`spatial_`、`canvas_`、`particles_`、`post_`

## Code Quality / 代码质量

- All uniforms/parameters must have descriptive names and appropriate hints / 所有 uniform/参数必须具有描述性名称和适当的提示
- Group related parameters (Godot: `group_uniforms`, Unity: `[Header]`, Unreal: Category) / 对相关参数进行分组（Godot：`group_uniforms`，Unity：`[Header]`，Unreal：Category）
- Comment non-obvious calculations (especially math-heavy sections) / 为非显而易见的计算添加注释（尤其是数学密集的部分）
- No magic numbers — use named constants or documented uniform values / 禁止魔术数字 — 使用命名常量或文档化的 uniform 值
- Include authorship and purpose comment at the top of each shader file / 在每个着色器文件顶部包含作者和用途注释

## Performance Requirements / 性能要求

- Document the target platform and complexity budget for each shader / 为每个着色器记录目标平台和复杂度预算
- Use appropriate precision: `half`/`mediump` on mobile where full precision isn't needed / 使用适当精度：在不需要全精度的移动端使用 `half`/`mediump`
- Minimize texture samples in fragment shaders / 最小化片元着色器中的纹理采样
- Avoid dynamic branching in fragment shaders — use `step()`, `mix()`, `smoothstep()` / 避免在片元着色器中使用动态分支 — 使用 `step()`、`mix()`、`smoothstep()`
- No texture reads inside loops / 循环中不得读取纹理
- Two-pass approach for blur effects (horizontal then vertical) / 模糊效果使用两遍方法（先水平后垂直）

## Cross-Platform / 跨平台

- Test shaders on minimum spec target hardware / 在最低规格目标硬件上测试着色器
- Provide fallback/simplified versions for lower quality tiers / 为较低质量层级提供回退/简化版本
- Document which render pipeline the shader targets (Forward/Deferred, URP/HDRP, Forward+/Mobile/Compatibility) / 记录着色器目标的渲染管线（Forward/Deferred、URP/HDRP、Forward+/Mobile/Compatibility）
- Do not mix shaders from different render pipelines in the same directory / 不要在同一目录中混合不同渲染管线的着色器

## Variant Management / 变体管理

- Minimize shader variants — each variant is a separate compiled shader / 最小化着色器变体 — 每个变体是单独编译的着色器
- Document all keywords/variants and their purpose / 记录所有关键字/变体及其用途
- Use feature stripping where possible to reduce build size / 尽可能使用功能裁剪以减少构建大小
- Log and monitor total variant count per shader / 记录并监控每个着色器的总变体数量
