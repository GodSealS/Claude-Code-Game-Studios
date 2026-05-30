# Skill Test Spec: /cocos_physics

> **Category**: engine | **Priority**: high | **Type**: agent-private
> **Loaded by**: `cocos-specialist` via `UseSkill("cocos_physics")`
> **Spec written**: 2026-05-30

## Skill Summary

Cocos Creator 3D physics engine expert. Agent-private domain knowledge skill — loaded exclusively by `cocos-specialist`. Provides reference and code patterns for RigidBody, Collider, PhysicsWorld, Joint, raycast, collision detection, rigid body dynamics, and 3D physics simulation.

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

### Case 1: Happy Path — Dynamic rigid body ball
**Fixture:**
- 3D scene with physical ground plane
- Skill is loaded by `cocos-specialist` via `UseSkill("cocos_physics")`

**Expected behavior:**
1. Provides TypeScript component with `cc.RigidBody` configuration pattern
2. Describes mass, restitution, friction, and linear damping properties
3. Guides sphere collider setup with appropriate radius
4. Covers physics material assignment

**Assertions:**
- [ ] Skill provides 3D physics domain knowledge
- [ ] RigidBody property semantics are clearly explained
- [ ] Code patterns follow Cocos Creator's physics component conventions

### Case 2: Domain boundary awareness — [SKIP]
> **SKIP** — Routing and rejection are the **agent's** responsibility. The skill's `Domain Boundaries` section documents scope for informational purposes.

### Case 3: Collision detection and response
**Fixture:**
- Player and enemy entities in 3D scene

**Expected behavior:**
1. Describes collision callback using `onCollisionEnter` pattern
2. Guides collision filtering using collision groups/masks
3. Covers damage calculation and health reduction patterns
4. Provides collision debugging visualization guidance

**Assertions:**
- [ ] Skill provides collision detection domain knowledge
- [ ] Collision filtering patterns are clearly explained
- [ ] Debug visualization guidance is included

### Case 4: Raycasting for interaction
**Fixture:**
- 3D scene with selectable objects

**Expected behavior:**
1. Guides `cc.physics.raycast` API usage with camera view direction
2. Describes mouse/touch screen to world space conversion
3. Covers multiple hits and closest object selection
4. Includes fallback for no-hit scenarios

**Assertions:**
- [ ] Skill provides raycast domain knowledge
- [ ] Screen-to-world conversion patterns are covered
- [ ] Edge case handling (no hit) is included

### Case 5: Joint constraints
**Fixture:**
- Need hinge joint for door mechanism

**Expected behavior:**
1. Guides hinge joint configuration with anchor points and axes
2. Describes joint limits (min/max angle) for door swing range
3. Covers motor control for automatic door opening
4. Notes joint breaking under excessive force

**Assertions:**
- [ ] Skill provides joint constraint domain knowledge
- [ ] Joint limit and motor control patterns are covered
- [ ] Breaking force considerations are included

### Case 6: Physics performance optimization
**Fixture:**
- Many dynamic objects causing simulation slowdown

**Expected behavior:**
1. Recommends static vs. dynamic vs. kinematic body type selection
2. Suggests collision shape simplification (primitives > mesh colliders)
3. Advises sleep management for inactive bodies
4. Mentions broad-phase optimization techniques

**Assertions:**
- [ ] Skill provides physics performance optimization strategies
- [ ] Body type selection guidance is clear
- [ ] References Cocos Creator's physics debug tools

---

## Protocol Compliance

- [ ] `allowed-tools` is Read/Grep (read-only domain reference) — `"May I write"` N/A ✓
- [ ] Presents domain knowledge before code examples
- [ ] Ends with `Recommended Next Steps` section
- [ ] `Related Skills` section present for cross-domain awareness
