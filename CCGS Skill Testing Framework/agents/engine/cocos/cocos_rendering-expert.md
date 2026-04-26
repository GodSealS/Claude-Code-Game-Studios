# Agent Test Spec: cocos_rendering-expert

## Agent Summary
Domain: Cocos Creator rendering pipeline: camera systems, lighting, shadows, post-processing effects, render pipeline configuration, and rendering performance optimization.
Does NOT own: 2D/3D rendering implementation (cocos_2d-expert, cocos_3d-expert), graphics API (cocos_gfx-expert), animation (cocos_animation-expert).
Model tier: sonnet (default for specialists).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references rendering pipeline, camera, lighting, shadows, post-processing)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is sonnet (default for specialists)
- [ ] Agent definition does not claim authority over rendering implementation or graphics API
- [ ] File scope includes only rendering-related files (under `cocos/rendering/` directory)

---

## Test Cases

### Case 1: In-domain request — appropriate output
**Input:** "Configure a camera with orthographic projection for 2D UI rendering and a perspective camera for 3D gameplay."
**Expected behavior:**
- Creates camera hierarchy with clear rendering layers separation
- Configures orthographic camera for UI (depth, near/far planes)
- Configures perspective camera for 3D (FOV, aspect ratio)
- Implements camera switching or blending between modes
- Follows Cocos Creator's camera component patterns

### Case 2: Wrong-domain redirect
**Input:** "Write a custom vertex shader for particle effects."
**Expected behavior:**
- Does NOT produce shader implementation code
- Clearly identifies that this is a graphics API/shader task
- Refers to cocos_gfx-expert for shader development
- May provide conceptual mapping if relevant (e.g., "rendering pipeline configures how shaders are used")

### Case 3: Lighting and shadow system
**Input:** "Set up directional light with cascaded shadow mapping for outdoor scene."
**Expected behavior:**
- Configures directional light component with shadow properties
- Implements cascaded shadow map splits for near/far quality distribution
- Sets up shadow resolution, bias, and filtering parameters
- Handles light baking vs. real-time lighting trade-offs
- Follows Cocos Creator's lighting system patterns

### Case 4: Post-processing effects
**Input:** "Add bloom, tone mapping, and vignette effects to the main camera."
**Expected behavior:**
- Creates post-processing pipeline using `cc.PostProcess` or similar system
- Implements bloom effect with threshold, intensity, and iteration controls
- Configures tone mapping (ACES, Reinhard, etc.) for HDR rendering
- Adds vignette effect with adjustable strength and roundness
- Follows project's post-processing architecture

### Case 5: Render pipeline configuration
**Input:** "Switch between forward and deferred rendering pipelines based on platform capabilities."
**Expected behavior:**
- Implements pipeline detection for WebGL 2.0 vs WebGL 1.0 vs native
- Creates forward pipeline configuration for mobile/WebGL 1.0
- Creates deferred pipeline configuration for desktop/WebGL 2.0
- Handles material compatibility between pipelines
- Provides fallback mechanisms for unsupported features

### Case 6: Rendering performance optimization
**Input:** "Our game has high GPU usage and low frame rate on mobile. How to optimize rendering?"
**Expected behavior:**
- Recommends reducing draw calls through batching and instancing
- Suggests texture compression and mipmapping
- Advises LOD (Level of Detail) systems for complex models
- Mentions reducing overdraw through depth testing and occlusion culling
- Provides profiling guidance with Cocos Creator's rendering debug tools

---

## Protocol Compliance

- [ ] Stays within declared domain (rendering pipeline, camera, lighting, shadows, post-processing)
- [ ] Does NOT write 2D/3D rendering implementation or shader code
- [ ] Follows existing code patterns (pipeline-pattern, render-pass)
- [ ] Maintains backward compatibility; does not break existing APIs
- [ ] Performance optimizations must provide comparison data
- [ ] New features include test cases
- [ ] Uses `cocos_rendering` Skill for domain knowledge reference