# Skill Test Spec: /cocos_2d

> **Category**: engine | **Priority**: high | **Type**: agent-private
> **Loaded by**: `cocos-specialist` via `UseSkill("cocos_2d")`
> **Spec written**: 2026-05-30

## Skill Summary

Cocos Creator 2D rendering expert. Agent-private domain knowledge skill — loaded exclusively by `cocos-specialist`. Provides reference and code patterns for Sprite, Label, Mask, Graphics, 2D sprite rendering, text rendering, mask effects, and 2D graphics drawing.

> **Agent-private semantics**: Routing/rejection is the *agent's* responsibility (cocos-specialist Delegation Map). The skill's job: provide accurate, complete domain knowledge for its topic.

---

## Static Assertions

Agent-private skills are read-only domain references. Required frontmatter: `name`, `description`, `allowed-tools`. Optional: `argument-hint`, `user-invocable`.

- [ ] Frontmatter has `name`, `description`, `allowed-tools` (3 required; `argument-hint`/`user-invocable` optional)
- [ ] 2+ phase headings found
- [ ] At least one verdict keyword present
- [ ] Allowed-tools is read-only (Read/Grep) or `"May I write"` present if Write/Edit
- [ ] Next-step handoff section present at end

---

## Test Cases

### Case 1: Happy Path — UI button with sprite states
**Fixture:**
- Project has sprite frame assets for normal/hover/pressed states
- Skill is loaded by `cocos-specialist` via `UseSkill("cocos_2d")`

**Expected behavior:**
1. Provides TypeScript component pattern extending `cc.Component`
2. Guides use of `cc.Sprite` component with sprite frame switching for states
3. Recommends `onTouchStart`, `onTouchEnd`, `onTouchCancel` event handlers
4. Directs use of `@property` decorator for serializable sprite frame references

**Assertions:**
- [ ] Skill provides 2D sprite/UI domain knowledge as reference, not raw implementation
- [ ] Code patterns follow Cocos Creator naming conventions
- [ ] Guidance includes proper import statements for `cc` modules
- [ ] References component-based architecture pattern

### Case 2: Domain boundary awareness — [SKIP]
> **SKIP** — Routing and rejection are the **agent's** responsibility (cocos-specialist Delegation Map). The skill's `Domain Boundaries` section documents scope for *informational* purposes only; the skill is never called out-of-domain because the agent routes before loading.

### Case 3: Performance optimization — draw call batching
**Fixture:**
- 2D game with many separate sprites causing high draw calls

**Expected behavior:**
1. Recommends sprite atlases and texture packing
2. Suggests enabling auto-batching where appropriate
3. Advises grouping static sprites under same node hierarchy
4. Mentions Cocos Creator's draw call profiler tool

**Assertions:**
- [ ] Skill provides optimization strategies specific to 2D rendering
- [ ] Guidance references Cocos Creator's built-in profiling tools
- [ ] Code examples follow existing project patterns

### Case 4: Text rendering with custom font
**Fixture:**
- Custom TTF font asset available in project

**Expected behavior:**
1. Guides creating `cc.Label` component with custom TTF font
2. Implements outline effect using `cc.LabelOutline` component or custom shader
3. Handles font loading and fallback scenarios
4. Includes multi-resolution adaptation guidance

**Assertions:**
- [ ] Skill provides font rendering domain knowledge
- [ ] Guidance covers edge cases (fallback fonts, multi-resolution)
- [ ] Follows project's asset pipeline conventions

### Case 5: Mask and clipping system
**Fixture:**
- Node hierarchy with parent mask and child sprite

**Expected behavior:**
1. Guides use of `cc.Mask` component with appropriate shape type
2. Describes correct parent-child relationship for masking
3. Covers dynamic resizing and animated mask scenarios
4. Notes performance considerations for complex masks

**Assertions:**
- [ ] Skill provides mask component domain knowledge
- [ ] Performance warnings included for complex mask scenarios
- [ ] Pattern covers both static and dynamic use cases

### Case 6: 2D graphics drawing
**Fixture:**
- Need to draw dynamic progress bar with rounded corners

**Expected behavior:**
1. Guides creating `cc.Graphics` component for vector drawing
2. Describes `roundRect` method for progress bar
3. Covers dynamic fill based on percentage value
4. Advises redraw frequency optimization

**Assertions:**
- [ ] Skill provides Graphics component domain knowledge
- [ ] Performance guidance on redraw frequency included
- [ ] Pattern supports dynamic value updates

---

## Protocol Compliance

- [ ] `allowed-tools` is Read/Grep (read-only domain reference) — `"May I write"` N/A ✓
- [ ] Presents domain knowledge before code examples
- [ ] Ends with `Recommended Next Steps` section
- [ ] `Related Skills` section present for cross-domain awareness
