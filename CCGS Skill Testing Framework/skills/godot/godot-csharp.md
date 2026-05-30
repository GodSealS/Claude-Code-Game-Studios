# Agent Test Spec: godot-csharp

## Agent Summary
Domain: C# patterns in Godot 4, .NET idioms applied to Godot, [Export] attribute usage, signal delegates, and async/await patterns.
Architecture: **Private skill** loaded by `godot-specialist` via `UseSkill("godot-csharp")`. Not a standalone agent.
Does NOT cover: GDScript code (godot-gdscript skill), GDExtension C/C++ bindings (godot-gdextension skill).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] Declared as a skill (`name: godot-csharp` in frontmatter) at `.codebuddy/skills/godot-csharp/SKILL.md`
- [ ] `description:` field matches: "Godot C# domain. partial class, [Export], [Signal] delegates, async ToSignal(), node access, .NET patterns."
- [ ] Skill file is only loaded by `godot-specialist` — no other agent definition references `UseSkill("godot-csharp")`
- [ ] Skill does NOT claim authority over GDScript or GDExtension code
- [ ] Skill includes version awareness section referencing `docs/engine-reference/godot/VERSION.md`
- [ ] Skill includes ripgrep file filtering guidance for GDScript files

---

## Test Cases

### Case 1: In-domain request — appropriate C# guidance
**Input:** "Create an export property for enemy health with validation that clamps it between 1 and 1000."
**Expected behavior:**
- Produces a C# property with `[Export]` attribute
- Uses a backing field with a property getter/setter that clamps the value in the setter
- Does NOT use a raw `[Export]` public field without validation
- Follows Godot 4 C# naming conventions (PascalCase for properties, fields private with underscore prefix)
- Includes XML doc comment on the property per coding standards

### Case 2: Out-of-domain request — stays within C# boundary
**Input:** "Rewrite this enemy health system in GDScript."
**Expected behavior:**
- Does NOT produce GDScript code or GDScript-specific guidance
- Explicitly states that GDScript domain knowledge belongs to the `godot-gdscript` skill
- Suggests the caller (godot-specialist) load `UseSkill("godot-gdscript")` instead
- May describe the C# interface so the GDScript skill knows the expected API shape

### Case 3: Async signal awaiting
**Input:** "Wait for an animation to finish before transitioning game state using C# async."
**Expected behavior:**
- Produces a proper `async Task` pattern using `ToSignal()` to await a Godot signal
- Uses `await ToSignal(animationPlayer, AnimationPlayer.SignalName.AnimationFinished)`
- Does NOT use `Thread.Sleep()` or `Task.Delay()` as a polling substitute
- Notes that the calling method must be `async` and that fire-and-forget `async void` is only acceptable for event handlers
- Handles cancellation or timeout if the animation could fail to fire

### Case 4: Threading model conflict
**Input:** "This C# code accesses a Godot Node from a background Task thread to update its position."
**Expected behavior:**
- Flags this as a race condition risk: Godot nodes are not thread-safe and must only be accessed from the main thread
- Does NOT approve or implement the multi-threaded node access pattern
- Provides the correct pattern: use `CallDeferred()`, `Callable.From().CallDeferred()`, or marshal back to the main thread via a thread-safe queue
- Explains the distinction between Godot's main thread requirement and .NET's thread-agnostic types

### Case 5: Context pass — Godot 4.6 API correctness
**Input:** Engine version context: Godot 4.6. Request: "Connect a signal using the new typed signal delegate pattern."
**Expected behavior:**
- Produces C# signal connection using the typed delegate pattern (`+=` operator on typed signal)
- Checks the 4.6 context to confirm no breaking changes to the signal delegate API in 4.4, 4.5, or 4.6
- Does NOT use the old string-based `Connect("signal_name", callable)` pattern (deprecated in Godot 4 C#)
- Produces guidance compatible with the project's pinned 4.6 version as documented in VERSION.md

---

## Protocol Compliance

- [ ] Stays within declared domain (C# in Godot 4 — patterns, exports, signals, async)
- [ ] When asked about GDScript: redirects to `godot-gdscript` skill, suggests loading `UseSkill("godot-gdscript")`
- [ ] When asked about GDExtension: redirects to `godot-gdextension` skill
- [ ] Returns C# code following Godot 4 conventions (not Unity MonoBehaviour patterns)
- [ ] Flags multi-threaded Godot node access as unsafe and provides the correct pattern
- [ ] Uses typed signal delegates — not deprecated string-based Connect() calls
- [ ] Checks engine version reference for API changes before producing code

---

## Coverage Notes
- Export property with validation (Case 1) should have a unit test verifying the clamp behavior
- Threading conflict (Case 4) is safety-critical: the skill must identify and fix this without prompting
- Async signal (Case 3) verifies the skill applies .NET idioms correctly within Godot's single-thread constraint
