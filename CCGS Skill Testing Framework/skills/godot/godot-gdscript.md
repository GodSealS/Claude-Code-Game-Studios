# Agent Test Spec: godot-gdscript

## Agent Summary
Domain: GDScript static typing, design patterns in GDScript, signal architecture, coroutine/await patterns, and GDScript performance.
Architecture: **Private skill** loaded by `godot-specialist` via `UseSkill("godot-gdscript")`. Not a standalone agent.
Does NOT cover: shader code (godot-shader skill), GDExtension bindings (godot-gdextension skill), C# code (godot-csharp skill).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] Declared as a skill (`name: godot-gdscript` in frontmatter) at `.codebuddy/skills/godot-gdscript/SKILL.md`
- [ ] `description:` field matches: "Godot GDScript domain. Static typing, signals, coroutines, design patterns, naming, performance."
- [ ] Skill file is only loaded by `godot-specialist` — no other agent definition references `UseSkill("godot-gdscript")`
- [ ] Skill does NOT claim authority over shader code, GDExtension, or C# code
- [ ] Skill includes version awareness section referencing `docs/engine-reference/godot/VERSION.md`
- [ ] Skill includes ripgrep file filtering guidance for GDScript files

---

## Test Cases

### Case 1: In-domain request — appropriate GDScript guidance
**Input:** "Review this GDScript file for type annotation coverage."
**Expected behavior:**
- Reads the provided GDScript file
- Flags every variable, parameter, and return type that is missing a static type annotation
- Produces a list of specific line-by-line findings: `var speed = 5.0` → `var speed: float = 5.0`
- Notes the performance and tooling benefits of static typing in Godot 4
- Does NOT rewrite the entire file unprompted — produces a findings list for the developer to apply

### Case 2: Out-of-domain request — stays within GDScript boundary
**Input:** "Write a vertex shader to distort the mesh in world space."
**Expected behavior:**
- Does NOT produce shader code in GDScript or in Godot's shading language
- Explicitly states that shader authoring belongs to `godot-shader` skill
- Redirects the request to `godot-shader` skill (godot-specialist should load `UseSkill("godot-shader")`)
- May note that the GDScript side (passing uniforms to a shader, setting shader parameters) is within its domain

### Case 3: Async loading with coroutines
**Input:** "Load a scene asynchronously and wait for it to finish before spawning it."
**Expected behavior:**
- Produces an `await` + `ResourceLoader.load_threaded_request` pattern for Godot 4
- Uses static typing throughout (`var scene: PackedScene`)
- Handles the completion check with `ResourceLoader.load_threaded_get_status()`
- Notes error handling for failed loads
- Does NOT use deprecated Godot 3 `yield()` syntax

### Case 4: Performance issue — typed array recommendation
**Input:** "The entity update loop is slow; it iterates an untyped Array of 1,000 nodes every frame."
**Expected behavior:**
- Identifies that an untyped `Array` foregoes compiler optimization in GDScript
- Recommends converting to a typed array (`Array[Node]` or the specific type) to enable JIT hints
- Notes that if this is still insufficient, escalates the hot path to C# migration recommendation (via godot-csharp skill)
- Produces the typed array refactor as the immediate fix
- Does NOT recommend migrating the entire codebase to C# without profiling evidence

### Case 5: Context pass — Godot 4.6 with post-cutoff features
**Input:** Engine version context provided: Godot 4.6. Request: "Create an abstract base class for all enemy types using @abstract."
**Expected behavior:**
- Identifies `@abstract` as a Godot 4.5+ feature (post-cutoff)
- Notes this in the output: feature introduced in 4.5, verified against VERSION.md migration notes
- Produces the GDScript class using `@abstract` with correct syntax as documented in migration notes
- Marks the output as requiring verification against the official 4.5 release notes due to post-cutoff status
- Uses static typing for all method signatures in the abstract class

---

## Protocol Compliance

- [ ] Stays within declared domain (GDScript — typing, patterns, signals, coroutines, performance)
- [ ] Redirects shader requests to `godot-shader` skill
- [ ] Redirects GDExtension requests to `godot-gdextension` skill
- [ ] Redirects C# requests to `godot-csharp` skill
- [ ] Returns structured GDScript output with full static typing
- [ ] Uses Godot 4 API only — no deprecated Godot 3 patterns (yield, connect with strings, etc.)
- [ ] Flags post-cutoff features (4.4, 4.5, 4.6) and marks them as requiring doc verification

---

## Coverage Notes
- Type annotation review (Case 1) output is suitable as a code review checklist
- Async loading (Case 3) should produce testable code verifiable with a unit test in `tests/unit/`
- Post-cutoff @abstract (Case 5) confirms the skill flags version uncertainty rather than silently using unverified APIs
