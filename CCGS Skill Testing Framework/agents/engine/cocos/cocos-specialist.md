# Agent Test Spec: cocos-specialist

## Agent Summary
Domain: Cocos Creator-specific patterns, component-based architecture, scene node hierarchy, subsystem integration (rendering, animation, physics), and TypeScript best practices.
Does NOT own: actual implementation of specific subsystems (delegates to sub-experts).
Model tier: opus (Strategic choice for architectural oversight and multi-subsystem coordination).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references Cocos Creator architecture / component patterns / engine decisions)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep, Task
- [ ] Model tier is opus (Strategic choice for architectural oversight; NOT the code-authoring specialist default)
- [ ] Agent definition references `docs/engine-reference/cocos/VERSION.md` as the authoritative API source

---

## Test Cases

### Case 1: In-domain request — appropriate output
**Input:** "When should I use a component-based approach vs. inheritance in Cocos Creator?"
**Expected behavior:**
- Produces a pattern decision guide with rationale:
  - Component-based: flexible composition, reusable behaviors, easier to test and maintain, aligns with Cocos Creator's ECS-inspired architecture
  - Inheritance: deep specialization, tight coupling, suitable for core engine classes with stable hierarchy
- Provides concrete examples of each pattern in the project's context
- Does NOT produce raw code for both patterns — refers to cocos_core-expert for implementation details
- Notes Cocos Creator's preference for composition over inheritance for gameplay logic

### Case 2: Wrong-engine redirect
**Input:** "Write a MonoBehaviour that runs on Start() and subscribes to a UnityEvent."
**Expected behavior:**
- Does NOT produce Unity MonoBehaviour code
- Clearly identifies that this is a Unity pattern, not a Cocos Creator pattern
- Provides the Cocos Creator equivalent: a Component script using `onLoad()` instead of `Start()`, and Cocos Creator events/signals instead of UnityEvent
- Confirms the project is Cocos Creator-based and redirects the conceptual mapping

### Case 3: Post-cutoff API risk
**Input:** "Use the new Cocos Creator 3.8.2 @property decorator for serialization."
**Expected behavior:**
- Identifies that `@property` may be a post-cutoff feature (introduced in Cocos Creator 3.8.2, after LLM knowledge cutoff)
- Flags the version risk: LLM knowledge of this decorator may be incomplete or incorrect
- Directs the user to verify against `docs/engine-reference/cocos/VERSION.md` and the official Cocos Creator documentation
- Provides best-effort guidance based on known patterns while clearly marking it as unverified

### Case 4: Subsystem delegation
**Input:** "Implement a 2D sprite animation system with texture atlas support."
**Expected behavior:**
- Does NOT produce implementation code for sprite animation
- Recognizes this as a 2D rendering/animation task
- Refers to cocos_2d-expert for sprite rendering and atlas management
- Refers to cocos_animation-expert for animation system design
- Coordinates the delegation and ensures both sub-experts are aware of the dependency

### Case 5: Performance optimization guidance
**Input:** "Our game has high draw calls in complex UI scenes. How should we optimize?"
**Expected behavior:**
- Provides architectural guidance: use Canvas batching, sprite atlasing, UI widget pooling
- Refers to cocos_2d-expert for UI rendering optimization
- Refers to cocos_rendering-expert for pipeline-level optimizations
- Recommends profiling with Cocos Creator's built-in tools before optimization
- Does NOT provide low-level GPU optimization details (delegates to cocos_gfx-expert)

### Case 6: Cross-platform considerations
**Input:** "We need to support Web, iOS, and Android. What Cocos Creator features should we be cautious about?"
**Expected behavior:**
- Lists platform-specific limitations: WebGL 1.0 vs 2.0, mobile GPU capabilities, texture compression formats
- Recommends using Cocos Creator's cross-platform abstraction layer
- Refers to cocos_gfx-expert for graphics API compatibility
- Notes the need for conditional compilation and feature detection
- Emphasizes testing on target platforms early

---

## Protocol Compliance

- [ ] Stays within declared domain (Cocos Creator architecture decisions, component patterns, subsystem coordination)
- [ ] Does NOT write low‑level rendering, physics, or animation code (delegates to sub‑experts)
- [ ] When encountering post‑cutoff API changes, flags the risk and directs to version reference
- [ ] Maintains architectural consistency across all Cocos Creator subsystems
- [ ] Follows the project's collaboration protocol (asks for approval before writing files)