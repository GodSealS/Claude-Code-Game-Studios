# Agent Test Spec: cocos_3d-expert / Cocos Creator 3D渲染专家代理测试规范

> **中文翻译**：此文件为Cocos Creator 3D渲染专家代理的测试规范。所有测试断言和用例保持英文原文以确保可执行性。


## Agent Summary / 代理摘要
Domain: Cocos Creator 3D rendering systems: mesh rendering, skinned animation, model loading, materials, shaders, and 3D performance optimization.
Does NOT own: 2D rendering (cocos_2d-expert), animation systems (cocos_animation-expert), graphics API (cocos_gfx-expert).
Model tier: DeepSeek-V3.2 (default).
No gate IDs assigned.

---

## Static Assertions (Structural) / 静态断言（结构）

- [ ] `description:` field is present and domain-specific (references Cocos Creator 3D rendering, mesh, skinned animation, models)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is DeepSeek-V3.2 (default for specialists)
- [ ] Agent definition does not claim authority over 2D rendering or animation systems
- [ ] File scope includes only 3D-related files (under `cocos/3d/` directory)

---

## Test Cases / 测试用例

<!-- 用例 1：域内请求 — 适当输出 -->
### Case 1: In-domain request — appropriate output
**Input:** "Load a glTF model and attach it to a scene node with basic material."
**Expected behavior:**
- Produces TypeScript code using `cc.resources.load` or asset bundle for glTF loading
- Creates a node hierarchy with `cc.MeshRenderer` component
- Applies a standard material or custom material with basic properties
- Handles async loading and error scenarios
- Follows Cocos Creator's asset loading patterns

<!-- 用例 2：错误域重定向 -->
### Case 2: Wrong-domain redirect
**Input:** "Create a 2D sprite animation for a UI icon."
**Expected behavior:**
- Does NOT produce 2D sprite animation code
- Clearly identifies that this is a 2D rendering task
- Refers to cocos_2d-expert for sprite and UI rendering
- May provide conceptual mapping if relevant (e.g., "3D model animation uses skeletal systems")

<!-- 中文翻译 -->
### Case 3: Skinned mesh animation
**Input:** "Implement a character with skeletal animation using imported FBX model."
**Expected behavior:**
- Sets up `cc.SkinnedMeshRenderer` component for skinned mesh
- Configures animation component for bone transformation playback
- Handles animation blending between different clips
- Provides example of controlling animation speed and transitions
- Notes memory and performance considerations for complex skeletons

<!-- 中文翻译 -->
### Case 4: Material and shader customization
**Input:** "Create a custom material with a simple vertex/fragment shader for toon shading."
**Expected behavior:**
- Creates a custom material asset definition
- Writes GLSL shader code for toon shading effect
- Implements proper uniforms and attributes binding
- Follows Cocos Creator's material/shader pipeline
- Includes fallback to standard material if shader compilation fails

<!-- 中文翻译 -->
### Case 5: 3D performance optimization
**Input:** "Our 3D scene has high GPU usage. How to optimize draw calls and overdraw?"
**Expected behavior:**
- Recommends using LOD (Level of Detail) systems for distant objects
- Suggests occlusion culling techniques
- Advises mesh merging for static objects
- Mentions frustum culling and render layer optimizations
- Provides profiling guidance with Cocos Creator's performance tools

<!-- 中文翻译 -->
### Case 6: Model asset pipeline
**Input:** "Set up a pipeline for importing and optimizing 3D models from Blender."
**Expected behavior:**
- Describes export settings from Blender to glTF/FBX
- Recommends texture compression formats for different platforms
- Suggests mesh optimization tools (mesh simplification, normal map baking)
- Integrates with Cocos Creator's asset database
- Includes validation scripts for imported models

---

<!-- 协议合规性 -->
## Protocol Compliance

- [ ] Stays within declared domain (Cocos Creator 3D rendering, mesh, skinned animation, materials)
- [ ] Does NOT write 2D rendering, animation, or graphics API code
- [ ] Follows existing code patterns (component-based, mesh-rendering)
- [ ] Maintains backward compatibility; does not break existing APIs
- [ ] New features include test cases
- [ ] Uses `cocos_3d` Skill for domain knowledge reference
