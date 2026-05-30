# Agent Test Spec: godot-gdextension

## Agent Summary
Domain: GDExtension API, godot-cpp C++ bindings, godot-rust bindings, native library integration, and native performance optimization.
Architecture: **Private skill** loaded by `godot-specialist` via `UseSkill("godot-gdextension")`. Not a standalone agent.
Does NOT cover: GDScript code (godot-gdscript skill), shader code (godot-shader skill).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] Declared as a skill (`name: godot-gdextension` in frontmatter) at `.codebuddy/skills/godot-gdextension/SKILL.md`
- [ ] `description:` field matches: "GDExtension domain. C++/Rust bindings, native performance, custom nodes, build systems, ABI compatibility."
- [ ] Skill file is only loaded by `godot-specialist` — no other agent definition references `UseSkill("godot-gdextension")`
- [ ] Skill does NOT claim authority over GDScript or shader authoring
- [ ] Skill includes version awareness section referencing `docs/engine-reference/godot/VERSION.md`
- [ ] Skill includes ABI compatibility warning about minor version upgrades

---

## Test Cases

### Case 1: In-domain request — appropriate GDExtension guidance
**Input:** "Expose a C++ rigid-body physics simulation library to GDScript via GDExtension."
**Expected behavior:**
- Produces a GDExtension binding pattern using godot-cpp:
  - Class inheriting from `godot::Object` or an appropriate Godot base class
  - `GDCLASS` macro registration
  - `_bind_methods()` implementation exposing the physics API to GDScript
  - `GDExtension` entry point (`gdextension_init`) setup
- Notes the `.gdextension` manifest file format required
- Does NOT produce the GDScript usage code (that belongs to godot-gdscript skill)

### Case 2: Out-of-domain — stays within native boundary
**Input:** "Write the GDScript that calls the physics simulation from Case 1."
**Expected behavior:**
- Does NOT produce GDScript code
- Explicitly states that GDScript authoring belongs to `godot-gdscript` skill
- Redirects the request to `godot-gdscript` skill (godot-specialist should load `UseSkill("godot-gdscript")`)
- May describe the API surface the GDScript should call (method names, parameter types) as a handoff spec

### Case 3: ABI compatibility risk — minor version update
**Input:** "We're upgrading from Godot 4.5 to 4.6. Will our existing GDExtension still work?"
**Expected behavior:**
- Flags the ABI compatibility concern: GDExtension binaries may not be ABI-compatible across minor versions
- Directs to check the 4.5→4.6 migration guide for GDExtension API changes
- Recommends recompiling the extension against the 4.6 godot-cpp headers rather than assuming binary compatibility
- Notes that the `.gdextension` manifest may need a `compatibility_minimum` version update
- Provides the recompilation checklist

### Case 4: Memory management — RAII for Godot objects
**Input:** "How should we manage the lifecycle of Godot objects created inside C++ GDExtension code?"
**Expected behavior:**
- Produces the RAII-based lifecycle pattern for Godot objects in GDExtension:
  - `Ref<T>` for reference-counted objects (auto-released when Ref goes out of scope)
  - `memnew()` / `memdelete()` for non-reference-counted objects
  - Warning: do NOT use `new`/`delete` for Godot objects — undefined behavior
- Notes object ownership rules: who is responsible for freeing a node added to the scene tree
- Provides a concrete example managing a `CollisionShape3D` created in C++

### Case 5: Context pass — Godot 4.6 GDExtension API check
**Input:** Engine version context: Godot 4.6 (upgrading from 4.5). Request: "Check if any GDExtension APIs changed from 4.5 to 4.6."
**Expected behavior:**
- References the 4.5→4.6 migration guide from the VERSION.md verified sources list
- Reports on any documented GDExtension API changes in the 4.6 release
- If no breaking changes are documented for GDExtension in 4.6, states that explicitly with the caveat to verify against the official changelog
- Flags the D3D12 default on Windows (4.6 change) as potentially relevant for GDExtension rendering code
- Provides a checklist of what to verify after upgrading

---

## Protocol Compliance

- [ ] Stays within declared domain (GDExtension, godot-cpp, godot-rust, native bindings)
- [ ] Redirects GDScript authoring to `godot-gdscript` skill
- [ ] Redirects shader authoring to `godot-shader` skill
- [ ] Returns structured output (binding patterns, RAII examples, ABI checklists)
- [ ] Flags ABI compatibility risks on minor version upgrades — never assumes binary compatibility
- [ ] Uses Godot-specific memory management (`memnew`/`memdelete`, `Ref<T>`) not raw C++ new/delete
- [ ] Checks engine version reference for GDExtension API changes before confirming compatibility

---

## Coverage Notes
- Binding pattern (Case 1) should include a smoke test verifying the extension loads and the method is callable from GDScript
- ABI risk (Case 3) is a critical escalation path — the skill must not approve shipping an unverified extension binary
- Memory management (Case 4) verifies the skill applies Godot-specific patterns, not generic C++ RAII
