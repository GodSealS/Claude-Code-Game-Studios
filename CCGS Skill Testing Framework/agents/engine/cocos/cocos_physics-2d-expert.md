# Agent Test Spec: cocos_physics-2d-expert

## Agent Summary
Domain: Cocos Creator 2D physics systems: Box2D integration, 2D rigid bodies, collision detection, platformer physics, and 2D physics optimization.
Does NOT own: 3D physics (cocos_physics-expert), 2D rendering (cocos_2d-expert), animation (cocos_animation-expert).
Model tier: DeepSeek-V3.2 (default).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references 2D physics, Box2D, platformer mechanics, collision detection)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is DeepSeek-V3.2 (default for specialists)
- [ ] Agent definition does not claim authority over 3D physics or rendering
- [ ] File scope includes only 2D physics-related files (under `cocos/physics-2d/` directory)

---

## Test Cases

### Case 1: In-domain request — appropriate output
**Input:** "Create a 2D platformer character controller with jumping and horizontal movement."
**Expected behavior:**
- Implements 2D rigid body with box collider for character
- Adds horizontal movement using velocity or force application
- Implements jump with ground detection via raycast or collision
- Handles slope climbing and edge cases
- Follows Cocos Creator's 2D physics component patterns

### Case 2: Wrong-domain redirect
**Input:** "Set up 3D collision detection for a complex mesh object."
**Expected behavior:**
- Does NOT produce 3D physics implementation code
- Clearly identifies that this is a 3D physics task
- Refers to cocos_physics-expert for 3D physics implementation
- May provide conceptual mapping if relevant (e.g., "2D physics uses simplified collision shapes")

### Case 3: Box2D integration
**Input:** "Configure Box2D physics world with custom gravity and collision matrix."
**Expected behavior:**
- Sets up `cc.physics.PhysicsWorld2D` configuration
- Defines collision categories and masks for different object types
- Configures gravity vector for 2D world
- Implements collision filtering rules
- Follows Cocos Creator's Box2D integration patterns

### Case 4: 2D collision events
**Input:** "Implement collision between player and collectible items to trigger pickup."
**Expected behavior:**
- Uses `onCollisionEnter2D` or similar callback for collision detection
- Implements collision filtering for player vs. collectible layers
- Handles item collection and removal from scene
- Provides visual/audio feedback for pickup
- Follows project's event-driven architecture

### Case 5: Platformer physics features
**Input:** "Add one-way platforms that player can jump through from below."
**Expected behavior:**
- Implements one-way collision using custom collision filtering
- Uses platform effector or manual collision enable/disable
- Handles edge cases (player standing on platform, jumping through)
- Provides example of multiple platform types
- Follows common platformer game design patterns

### Case 6: 2D physics optimization
**Input:** "Our 2D game has performance issues with many physics objects. How to optimize?"
**Expected behavior:**
- Recommends using static colliders for level geometry
- Suggests simplifying collision shapes (box/circle vs. polygon)
- Advises using `RigidBody2D` sleep mode for inactive objects
- Mentions using physics layers to reduce collision checks
- Provides profiling guidance with Cocos Creator's 2D physics debug tools

---

## Protocol Compliance

- [ ] Stays within declared domain (2D physics, Box2D integration, platformer mechanics)
- [ ] Does NOT write 3D physics, rendering, or animation code
- [ ] Follows existing code patterns (component-based, physics-integration)
- [ ] Maintains backward compatibility; does not break existing APIs
- [ ] New features include test cases
- [ ] Uses `cocos_physics-2d` Skill for domain knowledge reference