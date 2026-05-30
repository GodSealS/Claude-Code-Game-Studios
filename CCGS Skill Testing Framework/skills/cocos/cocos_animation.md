# Skill Test Spec: /cocos_animation

> **Category**: engine | **Priority**: high | **Type**: agent-private
> **Loaded by**: `cocos-specialist` via `UseSkill("cocos_animation")`
> **Spec written**: 2026-05-30

## Skill Summary

Cocos Creator animation system expert. Agent-private domain knowledge skill — loaded exclusively by `cocos-specialist`. Provides reference and code patterns for AnimationClip, AnimationState, SkeletonAnimation, animation state machines, skeletal animation, animation blending (crossFade), and keyframe animation.

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

### Case 1: Happy Path — Animation state machine
**Fixture:**
- 2D character with sprite animation clips for idle/walk/run
- Skill is loaded by `cocos-specialist` via `UseSkill("cocos_animation")`

**Expected behavior:**
1. Provides animation state machine pattern using `cc.AnimationState` or custom FSM
2. Defines transitions between idle, walk, run states based on velocity
3. Guides sprite animation clip usage for each state
4. Covers cross-fade blending between states

**Assertions:**
- [ ] Skill provides animation state machine domain knowledge
- [ ] Code patterns follow Cocos Creator's animation system conventions
- [ ] Cross-fade blending guidance included

### Case 2: Domain boundary awareness — [SKIP]
> **SKIP** — Routing and rejection are the **agent's** responsibility. The skill's `Domain Boundaries` section documents scope for informational purposes.

### Case 3: Skeletal animation setup
**Fixture:**
- 3D character model with bone hierarchy imported

**Expected behavior:**
1. Guides setting up `cc.SkeletonAnimation` component with bone hierarchy
2. Covers animation clip configuration for different actions
3. Describes bone weight painting and skinning setup concepts
4. Covers animation blending between skeletal clips

**Assertions:**
- [ ] Skill provides skeletal animation domain knowledge
- [ ] Bone hierarchy and skinning concepts are explained
- [ ] Cross-references `cocos_3d` for skinned mesh rendering setup

### Case 4: Animation blending techniques
**Fixture:**
- Need layer blending for upper body and lower body animations

**Expected behavior:**
1. Describes animation layer system for separate body parts
2. Covers blend weight concepts for each layer
3. Guides synchronization between layers
4. Provides pattern for dynamic weight adjustment based on gameplay

**Assertions:**
- [ ] Skill provides animation blending domain knowledge
- [ ] Layer system concepts are clearly explained
- [ ] Dynamic weight adjustment patterns included

### Case 5: Animation events and callbacks
**Fixture:**
- Need footstep sounds and attack hit frame events

**Expected behavior:**
1. Guides animation event callbacks using `cc.AnimationClip` event tracks
2. Describes event handler system for different event types
3. Covers sound playback and particle effect trigger patterns
4. Notes timing precision and frame-rate independence

**Assertions:**
- [ ] Skill provides animation event domain knowledge
- [ ] Event handler patterns follow Cocos Creator conventions
- [ ] Frame-rate independence considerations included

### Case 6: Animation performance optimization
**Fixture:**
- Many animated characters causing performance issues

**Expected behavior:**
1. Recommends animation LOD (Level of Detail)
2. Suggests GPU skinning for complex skeletal animations
3. Advises animation culling for off-screen characters
4. Mentions animation compression and sampling rate reduction

**Assertions:**
- [ ] Skill provides animation performance optimization strategies
- [ ] References Cocos Creator's animation debug tools
- [ ] LOD and culling strategies are specific to animation systems

---

## Protocol Compliance

- [ ] `allowed-tools` is Read/Grep (read-only domain reference) — `"May I write"` N/A ✓
- [ ] Presents domain knowledge before code examples
- [ ] Ends with `Recommended Next Steps` section
- [ ] `Related Skills` section present for cross-domain awareness
