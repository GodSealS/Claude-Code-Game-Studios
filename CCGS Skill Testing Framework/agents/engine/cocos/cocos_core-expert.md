# Agent Test Spec: cocos_core-expert

## Agent Summary
Domain: Cocos Creator core engine systems: component architecture, scene graph, lifecycle management, event communication, object pooling, and core framework patterns.
Does NOT own: 2D/3D rendering (cocos_2d-expert, cocos_3d-expert), animation (cocos_animation-expert), physics (cocos_physics-expert).
Model tier: DeepSeek-V4-Flash (default).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references core engine, component system, scene graph, lifecycle)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is DeepSeek-V4-Flash (default for specialists)
- [ ] Agent definition does not claim authority over rendering or physics implementation
- [ ] File scope includes only core-related files (under `cocos/core/` directory)

---

## Test Cases

### Case 1: In-domain request — appropriate output
**Input:** "Create a custom component that logs lifecycle events (onLoad, start, update, onDestroy)."
**Expected behavior:**
- Produces TypeScript component extending `cc.Component`
- Implements all lifecycle methods with console logging
- Uses `@property` decorator for configurable parameters
- Follows Cocos Creator's component naming conventions
- Includes proper import statements and documentation

### Case 2: Wrong-domain redirect
**Input:** "Implement a 3D mesh rendering system with material switching."
**Expected behavior:**
- Does NOT produce 3D mesh rendering code
- Clearly identifies that this is a 3D rendering task
- Refers to cocos_3d-expert for mesh rendering implementation
- May provide conceptual mapping if relevant (e.g., "components can be attached to render nodes")

### Case 3: Event communication system
**Input:** "Set up an event system for decoupled communication between game systems."
**Expected behavior:**
- Creates an event emitter class using `cc.EventTarget` or custom implementation
- Implements typed event system with TypeScript interfaces
- Provides publisher/subscriber patterns
- Includes example usage for score updates or game state changes
- Handles event cleanup to prevent memory leaks

### Case 4: Object pooling for performance
**Input:** "Create an object pool for bullet entities to reduce instantiation overhead."
**Expected behavior:**
- Implements generic or typed object pool class
- Manages allocation, recycling, and cleanup of pooled objects
- Integrates with Cocos Creator's node lifecycle
- Provides usage example for bullet spawning/recycling
- Includes capacity management and growth strategies

### Case 5: Scene graph management
**Input:** "Implement a utility for finding nodes by path or component type in the scene hierarchy."
**Expected behavior:**
- Creates utility functions using `cc.find`, `cc.director.getScene()`, etc.
- Implements efficient node search algorithms
- Handles async scene loading scenarios
- Provides TypeScript type safety for returned nodes
- Follows project's utility function patterns

### Case 6: Game state management
**Input:** "Design a finite state machine for game states (menu, playing, paused, gameover)."
**Expected behavior:**
- Creates state machine class with states and transitions
- Implements state enter/exit callbacks
- Integrates with Cocos Creator's lifecycle (pause/resume)
- Provides example usage with UI visibility and input handling
- Follows project's state management conventions

---

## Protocol Compliance

- [ ] Stays within declared domain (core engine, component system, scene graph, lifecycle)
- [ ] Does NOT write rendering, animation, or physics implementation code
- [ ] Follows existing code patterns (ecs-pattern, object-pool, event-emitter)
- [ ] Maintains backward compatibility; does not break existing APIs
- [ ] New features include test cases
- [ ] Uses `cocos_core` Skill for domain knowledge reference