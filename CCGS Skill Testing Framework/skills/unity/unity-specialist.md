# Agent Test Spec: unity-specialist

## Agent Summary
Domain: Unity engine authority. Handles ALL Unity subdomains directly — shaders/VFX, DOTS/ECS, Addressables, and UI — by loading the appropriate private Skill via `UseSkill()`. No sub-agent delegation.
Does NOT own: game design decisions, cross-engine architecture, server/CDN infrastructure.
Model tier: DeepSeek-V4-Flash.
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references Unity engine authority / Skill-based domain handling)
- [ ] `tools:` list includes Read, Glob, Grep, Write, Edit, Bash, Task
- [ ] Model tier is DeepSeek-V4-Flash
- [ ] Agent definition contains a Skill routing table mapping task domains to `UseSkill()` calls (unity-shader, unity-dots, unity-addressables, unity-ui)
- [ ] Agent definition explicitly states "NO sub-agent delegation — load skill and self-execute"
- [ ] Delegation map lists 4 private skills (unity-shader, unity-dots, unity-addressables, unity-ui) as "Handles directly via Skills"
- [ ] Skill table in "Skill-Based Specialization" section maps each domain to the correct `UseSkill()` call

---

## Test Cases

### Case 1: In-domain request — appropriate output
**Input:** "Should I use MonoBehaviour or ScriptableObject for storing enemy configuration data?"
**Expected behavior:**
- Produces a pattern decision tree covering:
  - MonoBehaviour: for runtime behavior, needs to be attached to a GameObject, has Update() lifecycle
  - ScriptableObject: for pure data/configuration, exists as an asset, shared across instances, no scene dependency
- Recommends ScriptableObject for enemy configuration data (stateless, reusable, designer-friendly)
- Notes that MonoBehaviour can reference the ScriptableObject for runtime use
- Provides a concrete example of what the ScriptableObject class definition looks like (does not produce full code — refers to engine-programmer or gameplay-programmer for implementation)

### Case 2: Wrong-engine redirect
**Input:** "Set up a Node scene tree with signals for this enemy system."
**Expected behavior:**
- Does NOT produce Godot Node/signal code
- Identifies this as a Godot pattern
- States that in Unity the equivalent is GameObject hierarchy + UnityEvent or C# events
- Maps the concepts: Godot Node → Unity MonoBehaviour, Godot Signal → C# event / UnityEvent
- Confirms the project is Unity-based before proceeding

### Case 3: Unity version API flag
**Input:** "Use the new Unity 6 GPU resident drawer for batch rendering."
**Expected behavior:**
- Identifies the Unity 6 feature (GPU Resident Drawer)
- Flags that this API may not be available in earlier Unity versions
- Asks for or checks the project's Unity version before providing implementation guidance
- Directs to verify against official Unity 6 documentation
- Does NOT assume the project is on Unity 6 without confirmation

### Case 4: Skill loading — DOTS/ECS deep dive
**Input:** "The combat system uses MonoBehaviour for state management, but we want to add a DOTS-based projectile system. Can they coexist?"
**Expected behavior:**
- Recognizes this as a hybrid architecture scenario
- Explains the hybrid approach: MonoBehaviour can interface with DOTS via SystemAPI, IComponentData, and managed components
- Notes the performance and complexity trade-offs of mixing the two patterns
- Recommends escalating the architecture decision to `lead-programmer` or `technical-director`
- Loads `unity-dots` skill via `UseSkill("unity-dots")` to provide DOTS-side implementation details
- Explicitly warns against 'ScriptableObject variables' for state management in a DOTS hybrid environment due to thread-safety concerns, recommending a clean data-copy bridge instead.

### Case 5: Skill loading — UI system selection
**Input:** Project context: Unity 2022.3 LTS. Request: "Implement a dynamic inventory UI with real-time item updates."
**Expected behavior:**
- Identifies this as a UI domain task requiring deep UI Toolkit knowledge
- Loads `unity-ui` skill via `UseSkill("unity-ui")` to handle the implementation
- The loaded skill provides UXML structure, USS styling, and data binding patterns
- Applies Unity 2022.3 LTS context (uses runtime binding system available in 2022.3)
- Does NOT delegate to a non-existent sub-agent — handles directly via the loaded skill

### Case 6: Context pass — Unity version
**Input:** Project context provided: Unity 2023.3 LTS. Request: "Configure the new Input System for this project."
**Expected behavior:**
- Applies Unity 2023.3 LTS context: uses the New Input System (com.unity.inputsystem) package
- Does NOT produce legacy Input Manager code (`Input.GetKeyDown()`, `Input.GetAxis()`)
- Notes any 2023.3-specific Input System behaviors or package version constraints
- References the project version to confirm Burst/Jobs compatibility if the Input System interacts with DOTS

---

## Protocol Compliance

- [ ] Stays within declared domain (Unity architecture decisions, pattern selection, subsystem routing)
- [ ] Redirects Godot patterns to appropriate Godot specialists or flags them as wrong-engine
- [ ] Loads `unity-shader` skill via `UseSkill("unity-shader")` for shader/VFX/rendering pipeline work
- [ ] Loads `unity-dots` skill via `UseSkill("unity-dots")` for DOTS/ECS/Jobs/Burst work
- [ ] Loads `unity-addressables` skill via `UseSkill("unity-addressables")` for asset loading/content delivery work
- [ ] Loads `unity-ui` skill via `UseSkill("unity-ui")` for UI Toolkit/UGUI work
- [ ] Never delegates to non-existent engine sub-agents — handles all Unity domains directly via Skills
- [ ] Flags Unity version-gated APIs and requires version confirmation before suggesting them
- [ ] Returns structured pattern decision guides, not freeform opinions

---

## Coverage Notes
- MonoBehaviour vs. ScriptableObject (Case 1) should be documented as an ADR if it results in a project-level decision
- Version flag (Case 3) confirms the agent does not assume the latest Unity version without context
- Skill loading (Case 4 + Case 5) verifies the agent correctly loads private skills via `UseSkill()` instead of delegating to sub-agents
- The 4 private skills (unity-shader, unity-dots, unity-addressables, unity-ui) must only be triggerable by unity-specialist — other agents must NOT have access to these skills
