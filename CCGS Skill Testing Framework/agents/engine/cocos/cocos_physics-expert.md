# Agent Test Spec: cocos_physics-expert

## Agent Summary
Domain: Cocos Creator 3D physics systems: rigid body dynamics, collision detection, joints, raycasting, and physics simulation optimization.
Does NOT own: 2D physics (cocos_physics-2d-expert), 3D rendering (cocos_3d-expert), animation (cocos_animation-expert).
Model tier: sonnet (default for specialists).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references 3D physics, rigid bodies, collision detection, joints)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is sonnet (default for specialists)
- [ ] Agent definition does not claim authority over 2D physics or rendering
- [ ] File scope includes only physics-related files (under `cocos/physics/` directory)

---

## Test Cases

### Case 1: In-domain request — appropriate output
**Input:** "Create a dynamic rigid body for a ball that bounces with restitution and friction."
**Expected behavior:**
- Produces TypeScript component with `cc.RigidBody` configuration
- Sets mass, restitution, friction, and linear damping properties
- Implements collision shape (sphere collider) with appropriate radius
- Handles physics material assignment
- Follows Cocos Creator's physics component patterns

### Case 2: Wrong-domain redirect
**Input:** "Implement 2D platformer physics with character controller and slope handling."
**Expected behavior:**
- Does NOT produce 2D physics implementation code
- Clearly identifies that this is a 2D physics task
- Refers to cocos_physics-2d-expert for 2D physics and platformer mechanics
- May provide conceptual mapping if relevant (e.g., "3D physics uses different coordinate system")

### Case 3: Collision detection and response
**Input:** "Set up collision events between player and enemy to trigger damage."
**Expected behavior:**
- Implements collision callback using `onCollisionEnter` or similar event
- Creates collision filtering using collision groups/masks
- Handles damage calculation and health reduction
- Provides example of collision debugging visualization
- Follows project's event-driven architecture

### Case 4: Raycasting for interaction
**Input:** "Implement raycast from camera to select objects in 3D world."
**Expected behavior:**
- Uses `cc.physics.raycast` API with camera view direction
- Implements mouse/touch screen to world space conversion
- Handles multiple hits and closest object selection
- Provides visual feedback for selected objects
- Includes fallback for no-hit scenarios

### Case 5: Joint constraints
**Input:** "Create a hinge joint between two rigid bodies for door opening mechanism."
**Expected behavior:**
- Configures hinge joint with anchor points and axes
- Sets joint limits (min/max angle) for door swing range
- Implements motor control for automatic door opening
- Handles joint breaking under excessive force
- Follows Cocos Creator's joint component patterns

### Case 6: Physics performance optimization
**Input:** "Our physics simulation is slowing down with many dynamic objects. How to optimize?"
**Expected behavior:**
- Recommends using static vs. dynamic vs. kinematic body types appropriately
- Suggests collision shape simplification (primitive shapes vs. mesh colliders)
- Advises sleep management for inactive bodies
- Mentions broad-phase optimization techniques
- Provides profiling guidance with Cocos Creator's physics debug tools

---

## Protocol Compliance

- [ ] Stays within declared domain (3D physics, rigid bodies, collision detection, joints)
- [ ] Does NOT write 2D physics, rendering, or animation code
- [ ] Follows existing code patterns (component-based, physics-integration)
- [ ] Maintains backward compatibility; does not break existing APIs
- [ ] New features include test cases
1- [ ] Uses `cocos_physics` Skill for domain knowledge reference