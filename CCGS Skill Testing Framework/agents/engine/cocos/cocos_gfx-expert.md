# Agent Test Spec: cocos_gfx-expert

## Agent Summary
Domain: Cocos Creator graphics API abstraction layer: GPU resource management, shader compilation, rendering backends (WebGL/Vulkan/Metal), cross-platform compatibility.
Does NOT own: 2D/3D rendering implementation (cocos_2d-expert, cocos_3d-expert), rendering pipeline (cocos_rendering-expert).
Model tier: DeepSeek-V3.2 (default).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references graphics API abstraction, GPU resources, cross-platform backends)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is DeepSeek-V3.2 (default for specialists)
- [ ] Agent definition does not claim authority over 2D/3D rendering implementation
- [ ] File scope includes only gfx-related files (under `cocos/gfx/` directory)

---

## Test Cases

### Case 1: In-domain request — appropriate output
**Input:** "Create a custom vertex buffer for particle system simulation on GPU."
**Expected behavior:**
- Produces TypeScript code using `cc.gfx.Device` API for buffer creation
- Defines vertex format with position, velocity, lifetime attributes
- Implements buffer update strategy (stream vs. static)
- Handles WebGL vs. native platform differences
- Includes proper resource cleanup and memory management

### Case 2: Wrong-domain redirect
**Input:** "Set up a UI button with sprite states for a main menu."
**Expected behavior:**
- Does NOT produce UI button implementation code
- Clearly identifies that this is a 2D UI rendering task
- Refers to cocos_2d-expert for UI component implementation
- May provide conceptual mapping if relevant (e.g., "GPU resources can be used for UI effects")

### Case 3: Shader compilation and management
**Input:** "Write a fragment shader for water surface simulation with reflection."
**Expected behavior:**
- Creates GLSL shader code following Cocos Creator's shader syntax
- Implements proper uniform and attribute declarations
- Includes fallback paths for WebGL 1.0 vs 2.0
- Provides shader compilation error handling
- Follows project's shader asset organization

### Case 4: Cross-platform graphics backend
**Input:** "We need to support Vulkan on desktop and WebGL on browser. How to handle feature differences?"
**Expected behavior:**
- Lists feature differences: compute shaders, texture formats, buffer storage
- Recommends using Cocos Creator's abstraction layer (`cc.gfx.Device`)
- Suggests feature detection and fallback paths
- Provides example of conditional code for different backends
- Notes performance characteristics of each backend

### Case 5: GPU resource optimization
**Input:** "Our game has memory spikes due to texture loading. How to implement texture streaming?"
**Expected behavior:**
- Describes texture streaming architecture using `cc.gfx.Texture` API
- Implements priority-based loading and unloading
- Suggests texture atlas packing to reduce state changes
- Recommends compression formats for different platforms (ASTC, ETC2, PVRTC)
- Provides memory budgeting guidelines

### Case 6: Custom rendering pipeline integration
**Input:** "Integrate a custom post-processing effect into the forward rendering pipeline."
**Expected behavior:**
- Creates a custom render pass using `cc.gfx.PipelineState`
- Implements shader and resource binding for the effect
- Integrates with Cocos Creator's render graph system
- Handles multiple camera rendering scenarios
- Provides performance impact analysis

---

## Protocol Compliance

- [ ] Stays within declared domain (graphics API abstraction, GPU resource management, cross-platform backends)
- [ ] Does NOT write 2D/3D rendering implementation or animation code
- [ ] Follows existing code patterns (abstraction-layer, rendering-api)
- [ ] Maintains backward compatibility; does not break existing APIs
- [ ] Cross-platform compatibility must be verified
- [ ] New features include test cases
- [ ] Uses `cocos_gfx` Skill for domain knowledge reference