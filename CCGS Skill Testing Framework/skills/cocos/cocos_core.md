# Skill Test Spec: /cocos_core

> **Category**: engine | **Priority**: high | **Type**: agent-private
> **Loaded by**: `cocos-specialist` via `UseSkill("cocos_core")`
> **Spec written**: 2026-05-30

## Skill Summary

Cocos Creator core engine expert. Agent-private domain knowledge skill — loaded exclusively by `cocos-specialist`. Provides reference and code patterns for Component, Node, Director, Game, Scene, ECS architecture, scene graph, lifecycle management, event system, and object pool.

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

### Case 1: Happy Path — Component lifecycle logging
**Fixture:**
- Empty Cocos Creator project
- Skill is loaded by `cocos-specialist` via `UseSkill("cocos_core")`

**Expected behavior:**
1. Provides TypeScript component pattern extending `cc.Component`
2. Describes all lifecycle methods with semantics (onLoad, start, update, onDestroy)
3. Guides `@property` decorator usage for configurable parameters
4. Follows Cocos Creator's component naming conventions

**Assertions:**
- [ ] Skill provides component lifecycle domain knowledge
- [ ] Code patterns use `@ccclass` and `@property` decorators
- [ ] Lifecycle method semantics are clearly explained
- [ ] Proper import statements are referenced

### Case 2: Domain boundary awareness — [SKIP]
> **SKIP** — Routing and rejection are the **agent's** responsibility. The skill's `Domain Boundaries` section documents scope for informational purposes.

### Case 3: Event communication system
**Fixture:**
- Game systems need decoupled communication

**Expected behavior:**
1. Provides event emitter pattern using `cc.EventTarget` or custom implementation
2. Describes typed event system with TypeScript interfaces
3. Covers publisher/subscriber patterns
4. Includes guidance on event cleanup to prevent memory leaks

**Assertions:**
- [ ] Skill provides event system domain knowledge
- [ ] TypeScript type safety patterns are included
- [ ] Memory leak prevention guidance is present
- [ ] Follows project's utility function patterns

### Case 4: Object pooling for performance
**Fixture:**
- Bullet entities created/destroyed frequently

**Expected behavior:**
1. Provides generic object pool pattern
2. Covers allocation, recycling, and cleanup of pooled objects
3. Guides integration with Cocos Creator's node lifecycle
4. Includes capacity management and growth strategy patterns

**Assertions:**
- [ ] Skill provides object pool domain knowledge
- [ ] `NodePool` API usage is referenced
- [ ] Capacity management strategies are covered
- [ ] Follows existing project patterns

### Case 5: Scene graph management
**Fixture:**
- Need utility for finding nodes by path or component type

**Expected behavior:**
1. Describes utility functions using `cc.find`, `cc.director.getScene()`
2. Covers efficient node search patterns
3. Handles async scene loading scenarios
4. Provides TypeScript type safety guidance for returned nodes

**Assertions:**
- [ ] Skill provides scene graph navigation domain knowledge
- [ ] Async scene loading edge cases are addressed
- [ ] Type safety patterns are included

### Case 6: Game state management
**Fixture:**
- Need FSM for game states (menu, playing, paused, gameover)

**Expected behavior:**
1. Describes state machine pattern with states and transitions
2. Covers state enter/exit callback patterns
3. Guides integration with Cocos Creator's lifecycle (pause/resume)
4. Provides example with UI visibility and input handling

**Assertions:**
- [ ] Skill provides state management domain knowledge
- [ ] Integration with Cocos Creator lifecycle is covered
- [ ] Follows project's state management conventions

---

## Protocol Compliance

- [ ] `allowed-tools` is Read/Grep (read-only domain reference) — `"May I write"` N/A ✓
- [ ] Presents domain knowledge before code examples
- [ ] Ends with `Recommended Next Steps` section
- [ ] `Related Skills` section present for cross-domain awareness
