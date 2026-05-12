# Coding Standards

- All game code must include doc comments on public APIs
- Every system must have a corresponding architecture decision record in `docs/architecture/`
- Gameplay values must be data-driven (external config), never hardcoded
- All public methods must be unit-testable (dependency injection over singletons)
- Commits must reference the relevant design document or task ID
- **Verification-driven development**: Write tests first when adding gameplay systems.
  For UI changes, verify with screenshots. Compare expected output to actual output
  before marking work complete. Every implementation should have a way to prove it works.

# Design Document Standards

- All design docs use Markdown
- Each mechanic has a dedicated document in `design/gdd/`
- Documents must include these 8 required sections:
  1. **Overview** -- one-paragraph summary
  2. **Player Fantasy** -- intended feeling and experience
  3. **Detailed Rules** -- unambiguous mechanics
  4. **Formulas** -- all math defined with variables
  5. **Edge Cases** -- unusual situations handled
  6. **Dependencies** -- other systems listed
  7. **Tuning Knobs** -- configurable values identified
  8. **Acceptance Criteria** -- testable success conditions
- Balance values must link to their source formula or rationale

# Testing Standards

## Test Evidence by Story Type

All stories must have appropriate test evidence before they can be marked Done:

| Story Type | Required Evidence | Location | Gate Level |
|---|---|---|---|
| **Logic** (formulas, AI, state machines) | Automated unit test — must pass | `tests/unit/[system]/` | BLOCKING |
| **Integration** (multi-system) | Integration test OR documented playtest | `tests/integration/[system]/` | BLOCKING |
| **Visual/Feel** (animation, VFX, feel) | Screenshot + lead sign-off | `production/qa/evidence/` | ADVISORY |
| **UI** (menus, HUD, screens) | Manual walkthrough doc OR interaction test | `production/qa/evidence/` | ADVISORY |
| **Config/Data** (balance tuning) | Smoke check pass | `production/qa/smoke-[date].md` | ADVISORY |

## Automated Test Rules

- **Naming**: `[system]_[feature]_test.[ext]` for files; `test_[scenario]_[expected]` for functions
- **Determinism**: Tests must produce the same result every run — no random seeds, no time-dependent assertions
- **Isolation**: Each test sets up and tears down its own state; tests must not depend on execution order
- **No hardcoded data**: Test fixtures use constant files or factory functions, not inline magic numbers
  (exception: boundary value tests where the exact number IS the point)
- **Independence**: Unit tests do not call external APIs, databases, or file I/O — use dependency injection

## What NOT to Automate

- Visual fidelity (shader output, VFX appearance, animation curves)
- "Feel" qualities (input responsiveness, perceived weight, timing)
- Platform-specific rendering (test on target hardware, not headlessly)
- Full gameplay sessions (covered by playtesting, not automation)

## CI/CD Rules

- Automated test suite runs on every push to main and every PR
- No merge if tests fail — tests are a blocking gate in CI
- Never disable or skip failing tests to make CI pass — fix the underlying issue
- Engine-specific CI commands:
  - **Godot**: `godot --headless --script tests/gdunit4_runner.gd`
  - **Unity**: `game-ci/unity-test-runner@v4` (GitHub Actions)
  - **Unreal**: headless runner with `-nullrhi` flag
  - **Cocos Creator**: `npx jest --config jest.config.ts` or Cocos Creator test runner

## Design Patterns / 设计模式

All code must follow appropriate Gang of Four (GoF) design patterns. See below for tier definitions.

### Tier 1 — Mandatory (强制)
These patterns **MUST** be used when the scenario matches:

1. **Observer Pattern** — for all event systems, UI updates, and decoupled communication
2. **Strategy Pattern** — for interchangeable algorithms and polymorphic behavior
3. **State Pattern** — for state machines and objects with complex state-dependent behavior
4. **Factory Method Pattern** — for object creation with polymorphic behavior
5. **Template Method Pattern** — for invariant algorithm structure with variant steps

### Tier 2 — Recommended (推荐)
These patterns **SHOULD** be used when applicable:

1. **Singleton** — only for true singletons (avoid for game state)
2. **Command Pattern** — for undo/redo, input handling, task queues
3. **Composite Pattern** — for tree structures (UI hierarchies, scene graphs)
4. **Decorator Pattern** — for adding responsibilities dynamically
5. **Facade Pattern** — for simplifying complex subsystems
6. **Proxy Pattern** — for lazy initialization, access control, logging
7. **Iterator Pattern** — for collection traversal
8. **Mediator Pattern** — for reducing coupling between components

### Tier 3 — Optional (可选)
Consider these for specific use cases:

- **Abstract Factory** — for families of related objects
- **Builder** — for complex object construction
- **Prototype** — for cloning expensive-to-create objects
- **Bridge** — for decoupling abstraction from implementation
- **Flyweight** — for large numbers of similar objects
- **Adapter** — for bridging incompatible interfaces
- **Chain of Responsibility** — for request handling pipelines
- **Interpreter** — for domain-specific language interpretation
- **Memento** — for checkpoint/undo systems
- **Visitor** — for operations on object structures

### Pattern Selection Guidelines / 模式选择指南

1. **Don't force patterns** — use them only when they naturally fit the problem
2. **Document pattern usage** — comment which pattern is used and why
3. **Be consistent** — if a pattern is used in one system, similar systems should use it too
4. **Prefer composition over inheritance** — already in coding standards
5. **lead-programmer must approve** any new pattern introduction or deviation from standard usage

### Pattern Documentation Format / 模式文档格式

```csharp
// Pattern: Observer
// Reason: Decouple UI updates from game state changes
// Used in: HealthSystem, ScoreManager
public class HealthChangedEvent : IEvent { ... }
```

### Enforcement / 执行

- `lead-programmer` must review pattern usage during code review
- Pattern violations must be flagged in /code-review
- Document any deliberate decision to NOT use a pattern in the relevant ADR
