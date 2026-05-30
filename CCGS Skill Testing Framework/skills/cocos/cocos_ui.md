# Skill Test Spec: /cocos_ui

> **Category**: engine | **Priority**: high | **Type**: agent-private
> **Loaded by**: `cocos-specialist` via `UseSkill("cocos_ui")`
> **Spec written**: 2026-05-30

## Skill Summary

Cocos Creator UI system expert. Agent-private domain knowledge skill — loaded exclusively by `cocos-specialist`. Provides reference and code patterns for Button, EditBox, ScrollView, Toggle, Slider, ProgressBar, Layout, Widget, UI event system, multi-resolution adaptation, and MMORPG UI templates.

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

### Case 1: Happy Path — Interactive UI widgets
**Fixture:**
- Canvas node exists in scene
- Skill is loaded by `cocos-specialist` via `UseSkill("cocos_ui")`

**Expected behavior:**
1. Guides creation of `cc.Button`, `cc.Toggle`, `cc.Slider`, `cc.ProgressBar` components
2. Describes event binding patterns (`Button.clickEvents`, `Slider.slideEvents`)
3. Covers `@property` decorator for script-side event handler references
4. Follows Cocos Creator's UI component naming conventions

**Assertions:**
- [ ] Skill provides UI widget domain knowledge
- [ ] Event binding patterns are clearly explained
- [ ] Code patterns use component-based UI architecture
- [ ] Widget lifecycle (enable/disable/interactable) is covered

### Case 2: Layout and multi-resolution adaptation
**Fixture:**
- Need UI to work across different screen resolutions

**Expected behavior:**
1. Guides `cc.Layout` component for auto-arrangement (HORIZONTAL/VERTICAL/GRID)
2. Describes `cc.Widget` alignment for screen edges and centering
3. Covers design resolution vs. actual resolution concepts
4. Explains `Fit Height` / `Fit Width` strategies

**Assertions:**
- [ ] Skill provides layout/multi-resolution domain knowledge
- [ ] Widget alignment schemes are clearly documented
- [ ] Layout type selection guidance is practical

### Case 3: ScrollView with dynamic content
**Fixture:**
- Need scrollable list with dynamically generated items

**Expected behavior:**
1. Guides `cc.ScrollView` component setup (horizontal/vertical, inertia, elastic)
2. Describes content node with `cc.Layout` for auto-sizing
3. Covers dynamic item instantiation and pooling patterns
4. Notes performance considerations for long lists

**Assertions:**
- [ ] Skill provides ScrollView domain knowledge
- [ ] Dynamic content management patterns are covered
- [ ] Performance guidance (item pooling) is included

### Case 4: MMORPG UI template — UnitFrame
**Fixture:**
- Need player/enemy health and resource bars in MMORPG style

**Expected behavior:**
1. Guides UnitFrame UI template: health bar, resource bar, name, level
2. Describes `cc.ProgressBar` for health/mana display
3. Covers real-time update patterns from game state
4. Includes buff/debuff icon display patterns

**Assertions:**
- [ ] Skill provides MMORPG UI template domain knowledge
- [ ] UnitFrame pattern follows WoW-style conventions
- [ ] Real-time update patterns are covered

### Case 5: MMORPG UI template — ActionBar
**Fixture:**
- Need hotkey/action bar for abilities and items

**Expected behavior:**
1. Guides ActionBar template with button grid layout
2. Describes cooldown overlay using mask or progress bar
3. Covers keybinding display and drag-drop patterns
4. Includes ability context menu patterns

**Assertions:**
- [ ] Skill provides ActionBar template domain knowledge
- [ ] Cooldown display patterns are covered
- [ ] Layout follows MMORPG conventions

### Case 6: Modal dialog and popup management
**Fixture:**
- Need confirmation dialog that blocks background interaction

**Expected behavior:**
1. Guides modal dialog with overlay and centered panel
2. Describes `cc.BlockInputEvents` for background input blocking
3. Covers dialog lifecycle (show/hide/destroy) patterns
4. Includes dialog stacking/queuing patterns

**Assertions:**
- [ ] Skill provides dialog/popup domain knowledge
- [ ] Input blocking and focus management is covered
- [ ] Dialog life-cycle patterns are clear

---

## Protocol Compliance

- [ ] `allowed-tools` is Read/Grep (read-only domain reference) — `"May I write"` N/A ✓
- [ ] Presents domain knowledge before code examples
- [ ] Ends with `Recommended Next Steps` section
- [ ] `Related Skills` section present for cross-domain awareness
