# Skill Test Spec: /cocos_rendering

> **Category**: engine | **Priority**: high | **Type**: agent-private
> **Loaded by**: `cocos-specialist` via `UseSkill("cocos_rendering")`
> **Spec written**: 2026-05-30

## Skill Summary

Cocos Creator rendering & GFX expert. Agent-private domain knowledge skill — loaded exclusively by `cocos-specialist`. Provides reference and code patterns for Effect shaders, materials, GPU resources (Device/Buffer/Texture/Shader/PipelineState), Forward/Deferred pipeline, camera, lighting, shadows, post-processing, custom render passes, and cross-platform (WebGL/Vulkan/Metal) rendering. Consolidates former `cocos_gfx-expert` agent domain.

> **Agent-private semantics**: Routing/rejection is the *agent's* responsibility (cocos-specialist Delegation Map). The skill's job: provide accurate, complete domain knowledge for its topic.

---

## Static Assertions

Agent-private skills are read-only domain references. Required frontmatter: `name`, `description`, `allowed-tools`. Optional: `argument-hint`, `user-invocable`.

- [ ] Frontmatter has `name`, `description`, `allowed-tools` (3 required; `argument-hint`/`user-invocable` optional)
- [ ] 2+ phase headings found
- [ ] At least one verdict keyword present
- [ ] Allowed-tools is read-only (Read/Grep) or `"May I write"` present if Write/Edit
- [ ] Next-step handoff section present at end

---

## Test Cases

### Case 1: Happy Path — Dual camera setup
**Fixture:**
- Scene needing orthographic UI camera + perspective gameplay camera
- Skill is loaded by `cocos-specialist` via `UseSkill("cocos_rendering")`

**Expected behavior:**
1. Describes camera hierarchy with clear rendering layers separation
2. Guides orthographic camera for UI (depth, near/far planes)
3. Covers perspective camera for 3D (FOV, aspect ratio)
4. Covers camera switching or blending patterns

**Assertions:**
- [ ] Skill provides camera/pipeline domain knowledge
- [ ] Rendering layer separation concepts are clearly explained
- [ ] Code patterns follow Cocos Creator's camera component conventions

### Case 2: Domain boundary awareness — [SKIP]
> **SKIP** — Routing and rejection are the **agent's** responsibility. The skill's `Domain Boundaries` section documents scope for informational purposes.

### Case 3: Lighting and shadow system
**Fixture:**
- Outdoor scene needing cascaded shadow mapping

**Expected behavior:**
1. Guides directional light component with shadow properties
2. Describes cascaded shadow map splits for near/far quality
3. Covers shadow resolution, bias, and filtering parameters
4. Covers light baking vs. real-time lighting trade-offs

**Assertions:**
- [ ] Skill provides lighting/shadow domain knowledge
- [ ] Cascaded shadow mapping concepts are clear
- [ ] Performance trade-off guidance is included

### Case 4: Post-processing effects
**Fixture:**
- Main camera needs bloom, tone mapping, and vignette

**Expected behavior:**
1. Guides post-processing pipeline using `cc.PostProcess` or similar
2. Describes bloom with threshold, intensity, and iteration controls
3. Covers tone mapping (ACES, Reinhard) for HDR rendering
4. Covers vignette effect with adjustable parameters

**Assertions:**
- [ ] Skill provides post-processing domain knowledge
- [ ] HDR tone mapping concepts are covered
- [ ] Follows existing post-processing architecture patterns

### Case 5: Render pipeline configuration
**Fixture:**
- Need to switch forward/deferred based on platform capabilities

**Expected behavior:**
1. Guides pipeline detection for WebGL 2.0 vs WebGL 1.0 vs native
2. Describes forward pipeline for mobile/WebGL 1.0
3. Covers deferred pipeline for desktop/WebGL 2.0
4. Covers material compatibility and fallback mechanisms

**Assertions:**
- [ ] Skill provides render pipeline domain knowledge
- [ ] Platform-specific pipeline selection is clear
- [ ] Fallback mechanisms for unsupported features are covered

### Case 6: Cross-platform graphics backend (merged from GFX)
**Fixture:**
- Need to support Vulkan desktop + WebGL browser

**Expected behavior:**
1. Lists feature differences: compute shaders, texture formats, buffer storage
2. Recommends Cocos Creator's `cc.gfx.Device` abstraction layer
3. Suggests feature detection and fallback paths
4. Notes performance characteristics of each backend

**Assertions:**
- [ ] Skill provides cross-platform GFX domain knowledge
- [ ] Feature detection and fallback patterns are covered
- [ ] Platform-specific performance notes are included

### Case 7: Custom render pass / GPU resources (merged from GFX)
**Fixture:**
- Custom post-processing effect integrated into forward pipeline

**Expected behavior:**
1. Guides custom render pass using `cc.gfx.PipelineState`
2. Describes shader and resource binding for the effect
3. Covers integration with Cocos Creator's render graph system
4. Handles multiple camera rendering scenarios

**Assertions:**
- [ ] Skill provides GPU resource / render pass domain knowledge
- [ ] PipelineState and render graph integration concepts are clear
- [ ] Multi-camera handling is covered

### Case 8: Rendering performance optimization
**Fixture:**
- High GPU usage and low frame rate on mobile

**Expected behavior:**
1. Recommends reducing draw calls through batching and instancing
2. Suggests texture compression and mipmapping
3. Advises LOD systems for complex models
4. Mentions reducing overdraw through depth testing and occlusion culling

**Assertions:**
- [ ] Skill provides rendering performance optimization strategies
- [ ] Mobile-specific optimization guidance is included
- [ ] References Cocos Creator's rendering debug tools

---

## Protocol Compliance

- [ ] `allowed-tools` is Read/Grep (read-only domain reference) — `"May I write"` N/A ✓
- [ ] Presents domain knowledge before code examples
- [ ] Ends with `Recommended Next Steps` section
- [ ] `Related Skills` section present for cross-domain awareness
- [ ] Cross-platform compatibility guidance always included for GFX-level topics
