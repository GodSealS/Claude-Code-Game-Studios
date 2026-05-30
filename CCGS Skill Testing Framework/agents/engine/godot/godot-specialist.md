# Agent Test Spec: godot-specialist

## Agent Summary
Domain: Godot 4 engine authority. Handles ALL Godot domains directly — GDScript, C#, shaders, GDExtension — by loading domain skills via `UseSkill()`. No sub-agent delegation.
Model tier: DeepSeek-V4-Flash (default).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] `description:` field declares "Handles all Godot domains directly using domain skills"
- [ ] `tools:` list includes Read, Write, Edit, Bash, Glob, Grep, Task
- [ ] Model tier is DeepSeek-V4-Flash (default)
- [ ] `agentMode: agentic` — autonomous execution
- [ ] Agent definition includes a delegation map showing `UseSkill()` for all four domain skills (godot-gdscript, godot-csharp, godot-shader, godot-gdextension)
- [ ] Agent definition references `docs/engine-reference/godot/VERSION.md` as the authoritative API source
- [ ] Agent definition explicitly states "No sub-agent delegation needed"

---

## Test Cases

### Case 1: In-domain GDScript request — loads skill and produces code directly
**Input:** "When should I use signals vs. direct method calls in Godot?"
**Expected behavior:**
- Loads `UseSkill("godot-gdscript")` before responding
- Produces a pattern decision guide with rationale:
  - Signals: decoupled communication, parent-to-child ignorance, event-driven UI updates, one-to-many notification
  - Direct calls: tightly-coupled systems where the caller needs a return value, or performance-critical hot paths
- Provides concrete GDScript examples of each pattern directly (does NOT delegate to a sub-agent)
- Notes the "no upward signals" convention (child does not call parent methods directly — uses signals instead)

### Case 2: Wrong-engine redirect
**Input:** "Write a MonoBehaviour that runs on Start() and subscribes to a UnityEvent."
**Expected behavior:**
- Does NOT produce Unity MonoBehaviour code
- Clearly identifies that this is a Unity pattern, not a Godot pattern
- Provides the Godot equivalent: a Node script using `_ready()` instead of `Start()`, and Godot signals instead of UnityEvent
- Confirms the project is Godot-based and redirects the conceptual mapping

### Case 3: Post-cutoff API risk
**Input:** "Use the new Godot 4.5 @abstract annotation to define an abstract base class."
**Expected behavior:**
- Identifies that `@abstract` is a post-cutoff feature (introduced in Godot 4.5, after LLM knowledge cutoff)
- Flags the version risk: LLM knowledge of this annotation may be incomplete or incorrect
- Directs the user to verify against `docs/engine-reference/godot/VERSION.md` and the official 4.5 migration guide
- Provides best-effort guidance based on the migration notes in the version reference while clearly marking it as unverified
- If producing code, loads `UseSkill("godot-gdscript")` first

### Case 4: Language selection for a hot path — direct decision
**Input:** "The physics query loop runs every frame for 500 objects. Should we use GDScript or C# for this?"
**Expected behavior:**
- Provides a balanced analysis:
  - GDScript: simpler, team familiar, but slower for tight loops
  - C#: faster for CPU-intensive loops, requires .NET runtime, team needs C# knowledge
- Makes a recommendation direction with rationale (godot-specialist owns this decision directly)
- Notes that GDExtension (C++) is a third option for extreme performance cases
- Can load relevant skills (`UseSkill("godot-csharp")`, `UseSkill("godot-gdextension")`) for domain-specific cost analysis

### Case 5: Context pass — engine version 4.6
**Input:** Engine version context provided: Godot 4.6, Jolt as default physics. Request: "Set up a RigidBody3D for the player character."
**Expected behavior:**
- Reads the 4.6 context and applies the Jolt-default knowledge (from VERSION.md migration notes)
- Recommends RigidBody3D configuration choices that are Jolt-compatible (e.g., notes any GodotPhysics-specific settings that behave differently under Jolt)
- References the 4.6 migration note about Jolt becoming default rather than relying on LLM training data alone
- Flags any RigidBody3D properties that changed behavior between GodotPhysics and Jolt

### Case 6: C# domain — loads godot-csharp skill directly
**Input:** "Create an export property for enemy health in C# with validation that clamps it between 1 and 1000."
**Expected behavior:**
- Loads `UseSkill("godot-csharp")` before producing C# code
- Produces a C# property with `[Export]` attribute and backing field with getter/setter validation
- Does NOT produce GDScript or GDExtension code for this request
- Does NOT delegate to any sub-agent — handles directly with the loaded skill

### Case 7: Cross-domain request — loads multiple skills
**Input:** "Design a performance-critical terrain system: GDScript for the API, C++ GDExtension for generation, and a custom shader for rendering."
**Expected behavior:**
- Loads relevant skills sequentially: `UseSkill("godot-gdscript")`, `UseSkill("godot-gdextension")`, `UseSkill("godot-shader")`
- Produces a coherent architecture that spans all three domains
- Defines clear boundaries between GDScript orchestration, native generation, and shader rendering
- Does NOT delegate any part to sub-agents — godot-specialist handles everything directly via skills

---

## Protocol Compliance

- [ ] Stays within declared domain (Godot engine authority — all subsystems)
- [ ] Handles ALL Godot domains directly by loading appropriate skill via `UseSkill()`
- [ ] Does NOT delegate code authoring to sub-agents (no `godot-gdscript-specialist`, `godot-csharp-specialist`, etc.)
- [ ] Loads the correct skill before producing domain-specific code (gdscript→godot-gdscript, C#→godot-csharp, shaders→godot-shader, native→godot-gdextension)
- [ ] Returns structured findings (decision trees, pattern recommendations with rationale, direct code output)
- [ ] Treats `docs/engine-reference/godot/VERSION.md` as authoritative over LLM training data
- [ ] Flags post-cutoff API usage (4.4, 4.5, 4.6) with verification requirements
- [ ] Reports to `lead-programmer` / `technical-director` for architectural sign-off
- [ ] Uses the skill-based specialization table to select appropriate skill for each task domain

---

## Coverage Notes
- Signal vs. direct call guide (Case 1) should be written to `docs/architecture/` as a reusable pattern doc
- Post-cutoff flag (Case 3) confirms the agent does not confidently use APIs it cannot verify
- Engine version case (Case 5) verifies the agent applies migration notes from the version reference, not assumptions
- Cross-domain case (Case 7) verifies the agent can orchestrate multiple skills for a single complex task without delegating to sub-agents
- Case 6 verifies that code authoring is done directly (with skill loaded), not delegated
