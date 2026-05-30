# Skill Test Spec: /cocos_3d

> **Category**: engine | **Priority**: high | **Type**: agent-private
> **Loaded by**: `cocos-specialist` via `UseSkill("cocos_3d")`
> **Spec written**: 2026-05-30

## Skill Summary

Cocos Creator 3D rendering expert. Agent-private domain knowledge skill — loaded exclusively by `cocos-specialist`. Provides reference and code patterns for MeshRenderer, SkinnedMeshRenderer, Model, 3D mesh rendering, skinned mesh, model loading, materials, and 3D performance optimization.

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

### Case 1: Happy Path — Load glTF model
**Fixture:**
- glTF model asset available in project
- Skill is loaded by `cocos-specialist` via `UseSkill("cocos_3d")`

**Expected behavior:**
1. Provides TypeScript pattern using `cc.resources.load` or asset bundle for glTF loading
2. Guides creating node hierarchy with `cc.MeshRenderer` component
3. Covers standard material application with basic properties
4. Handles async loading and error scenarios

**Assertions:**
- [ ] Skill provides 3D mesh/model domain knowledge as reference
- [ ] Code patterns follow Cocos Creator's asset loading patterns
- [ ] Error handling and async patterns are covered

### Case 2: Domain boundary awareness — [SKIP]
> **SKIP** — Routing and rejection are the **agent's** responsibility. The skill's `Domain Boundaries` section documents scope for informational purposes.

### Case 3: Skinned mesh animation
**Fixture:**
- FBX model with skeleton data imported

**Expected behavior:**
1. Guides setting up `cc.SkinnedMeshRenderer` component
2. Covers animation component for bone transformation playback
3. Describes animation blending between different clips
4. Notes memory and performance considerations for complex skeletons

**Assertions:**
- [ ] Skill provides skinned mesh domain knowledge
- [ ] Performance considerations for complex skeletons included
- [ ] Covers animation clip management patterns

### Case 4: Material and shader customization
**Fixture:**
- Need custom toon shading material

**Expected behavior:**
1. Guides creating custom material asset definition
2. References shader code patterns for toon shading effect
3. Covers uniform and attribute binding setup
4. Includes fallback to standard material for compilation failures

**Assertions:**
- [ ] Skill provides material/shader domain knowledge
- [ ] Cross-references `cocos_rendering` Skill for advanced shader topics
- [ ] Fallback patterns included for robustness

### Case 5: 3D performance optimization
**Fixture:**
- 3D scene with high GPU usage

**Expected behavior:**
1. Recommends LOD (Level of Detail) systems for distant objects
2. Suggests occlusion culling techniques
3. Advises mesh merging for static objects
4. Mentions frustum culling and render layer optimizations

**Assertions:**
- [ ] Skill provides 3D rendering optimization strategies
- [ ] References Cocos Creator's performance profiling tools
- [ ] Optimization guidance is specific to 3D rendering pipeline

### Case 6: Model asset pipeline
**Fixture:**
- Models exported from Blender to import into Cocos Creator

**Expected behavior:**
1. Describes export settings from Blender to glTF/FBX
2. Recommends texture compression formats for different platforms
3. Suggests mesh optimization (simplification, normal map baking)
4. Includes validation guidance for imported models

**Assertions:**
- [ ] Skill provides model import pipeline domain knowledge
- [ ] Platform-specific compression guidance included
- [ ] Cross-references asset management conventions

---

## Protocol Compliance

- [ ] `allowed-tools` is Read/Grep (read-only domain reference) — `"May I write"` N/A ✓
- [ ] Presents domain knowledge before code examples
- [ ] Ends with `Recommended Next Steps` section
- [ ] `Related Skills` section present for cross-domain awareness
