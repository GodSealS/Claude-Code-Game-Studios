# Skill Test Spec: /cocos_physics-2d

> **Category**: engine | **Priority**: high | **Type**: agent-private
> **Loaded by**: `cocos-specialist` via `UseSkill("cocos_physics-2d")`
> **Spec written**: 2026-05-30

## Skill Summary

Cocos Creator 2D physics engine expert. Agent-private domain knowledge skill — loaded exclusively by `cocos-specialist`. Provides reference and code patterns for RigidBody2D, Collider2D, PhysicsWorld2D, 2D collision detection, Box2D integration, and 2D rigid body dynamics.

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

### Case 1: Happy Path — 2D platformer character controller
**Fixture:**
- 2D scene with platform geometry
- Skill is loaded by `cocos-specialist` via `UseSkill("cocos_physics-2d")`

**Expected behavior:**
1. Guides 2D rigid body with box collider for character
2. Describes horizontal movement using velocity or force application
3. Covers jump with ground detection via raycast or collision
4. Handles slope climbing and edge cases

**Assertions:**
- [ ] Skill provides 2D physics domain knowledge
- [ ] Character controller patterns follow Box2D integration
- [ ] Ground detection patterns are clearly explained
- [ ] Edge case handling (slopes) is included

### Case 2: Domain boundary awareness — [SKIP]
> **SKIP** — Routing and rejection are the **agent's** responsibility. The skill's `Domain Boundaries` section documents scope for informational purposes.

### Case 3: Box2D integration
**Fixture:**
- Need custom gravity and collision matrix for 2D world

**Expected behavior:**
1. Guides `cc.physics.PhysicsWorld2D` configuration
2. Describes collision categories and masks for object types
3. Covers gravity vector configuration for 2D world
4. Covers collision filtering rule patterns

**Assertions:**
- [ ] Skill provides Box2D integration domain knowledge
- [ ] Collision matrix configuration patterns are clear
- [ ] Follows Cocos Creator's Box2D integration conventions

### Case 4: 2D collision events
**Fixture:**
- Player and collectible items in 2D scene

**Expected behavior:**
1. Guides `onCollisionEnter2D` callback for collision detection
2. Describes collision filtering for player vs. collectible layers
3. Covers item collection and removal patterns
4. Provides visual/audio feedback guidance

**Assertions:**
- [ ] Skill provides 2D collision event domain knowledge
- [ ] Event-driven architecture patterns are covered
- [ ] Follows existing project conventions

### Case 5: Platformer physics features
**Fixture:**
- Need one-way platforms (passthrough from below)

**Expected behavior:**
1. Describes one-way collision using custom collision filtering
2. Guides platform effector or manual collision enable/disable
3. Covers edge cases (player standing vs. jumping through)
4. Provides patterns for multiple platform types

**Assertions:**
- [ ] Skill provides platformer-specific physics domain knowledge
- [ ] One-way platform implementation patterns are clear
- [ ] Edge case handling (jump-through vs. standing) is comprehensive

### Case 6: 2D physics optimization
**Fixture:**
- High object count causing 2D physics performance issues

**Expected behavior:**
1. Recommends static colliders for level geometry
2. Suggests simplified collision shapes (box/circle vs. polygon)
3. Advises `RigidBody2D` sleep mode for inactive objects
4. Mentions physics layers to reduce collision checks

**Assertions:**
- [ ] Skill provides 2D physics performance optimization strategies
- [ ] Sleep mode and layer optimization patterns are covered
- [ ] References Cocos Creator's 2D physics debug tools

---

## Protocol Compliance

- [ ] `allowed-tools` is Read/Grep (read-only domain reference) — `"May I write"` N/A ✓
- [ ] Presents domain knowledge before code examples
- [ ] Ends with `Recommended Next Steps` section
- [ ] `Related Skills` section present for cross-domain awareness
