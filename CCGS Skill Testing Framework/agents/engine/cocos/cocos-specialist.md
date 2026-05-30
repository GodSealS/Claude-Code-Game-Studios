# Agent Test Spec: cocos-specialist

## Agent Summary
Domain: Cocos Creator engine authority. Handles ALL Cocos subsystems — 2D, 3D, animation, core engine, physics (2D/3D), rendering, and UI — directly via Skills loaded with `UseSkill()`. No sub-agent delegation needed.
Model tier: DeepSeek-V4-Flash (Consolidated specialist — single agent with Skill-based domain routing).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] `description:` field references handling all Cocos subsystems via Skills, no sub-agent delegation
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep, Task
- [ ] Model tier is DeepSeek-V4-Flash (consolidated Cocos specialist)
- [ ] Agent definition references `docs/engine-reference/cocos/VERSION.md` as authoritative API source
- [ ] Delegation map shows Skill-based routing: `UseSkill("cocos_2d")`, `UseSkill("cocos_3d")`, etc. for domain tasks; escalates to `technical-director` / `lead-programmer` for architecture decisions
- [ ] No references to deprecated sub-expert agents (cocos_2d-expert, cocos_3d-expert, etc.)

---

## Test Cases

### Case 1: Architecture decision — component-based vs. inheritance
**Input:** "When should I use a component-based approach vs. inheritance in Cocos Creator?"
**Expected behavior:**
- Produces a pattern decision guide with rationale:
  - Component-based: flexible composition, reusable behaviors, easier to test and maintain, aligns with Cocos Creator's ECS-inspired architecture
  - Inheritance: deep specialization, tight coupling, suitable for core engine classes with stable hierarchy
- Provides concrete examples of each pattern in the project's context
- Loads `UseSkill("cocos_core")` for component system knowledge
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

### Case 4: Skill-based subsystem implementation
**Input:** "Implement a 2D sprite animation system with texture atlas support."
**Expected behavior:**
- Does NOT delegate to deprecated sub-expert agents
- Loads relevant Skills: `UseSkill("cocos_2d")` for sprite rendering and atlas management, `UseSkill("cocos_animation")` for animation system design
- Directly implements the solution using Skill-provided domain knowledge
- Coordinates across multiple loaded Skills when the task spans domains
- Produces complete TypeScript code following Cocos Creator best practices

### Case 5: Performance optimization — Skill-driven analysis
**Input:** "Our game has high draw calls in complex UI scenes. How should we optimize?"
**Expected behavior:**
- Loads `UseSkill("cocos_2d")` for UI rendering optimization strategies
- Loads `UseSkill("cocos_rendering")` if pipeline-level optimizations are needed
- Provides architectural guidance: Canvas batching, sprite atlasing, UI widget pooling
- Recommends profiling with Cocos Creator's built-in tools before optimization
- Directly provides implementation guidance without delegating to sub-experts

### Case 6: Cross-platform considerations — direct analysis
**Input:** "We need to support Web, iOS, and Android. What Cocos Creator features should we be cautious about?"
**Expected behavior:**
- Lists platform-specific limitations: WebGL 1.0 vs 2.0, mobile GPU capabilities, texture compression formats
- Loads `UseSkill("cocos_rendering")` for cross-platform GFX and pipeline analysis
- Recommends using Cocos Creator's cross-platform abstraction layer
- Notes the need for conditional compilation and feature detection
- Emphasizes testing on target platforms early

---

## Protocol Compliance

- [ ] Stays within declared domain (Cocos Creator engine authority)
- [ ] Loads appropriate Skills via `UseSkill()` for sub-system domain knowledge, then writes code directly
- [ ] Does NOT delegate to deprecated sub-expert agents (cocos_2d-expert, cocos_3d-expert, etc.)
- [ ] When encountering post‑cutoff API changes, flags the risk and directs to version reference
- [ ] Maintains architectural consistency across all Cocos Creator subsystems
- [ ] Follows the project's collaboration protocol (asks for approval before writing files)
