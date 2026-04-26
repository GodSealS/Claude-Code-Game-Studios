---
name: test-helpers
description: "Generate engine-specific test helper libraries for the project's test suite. Reads existing test patterns and produces tests/helpers/ with assertion utilities, factory functions, and mock objects tailored to the project's systems. Reduces boilerplate in new test files. / 为项目的测试套件生成引擎特定的测试辅助库。读取现有测试模式，生成包含断言工具、工厂函数和针对项目系统定制的模拟对象的 tests/helpers/。减少新测试文件中的样板代码。"
argument-hint: "[system-name | all | scaffold]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
---

# Test Helpers / 测试辅助工具

Writing test cases is faster and more consistent when common setup, teardown,
and assertion patterns are abstracted into helpers. This skill generates a
`tests/helpers/` library tailored to the project's actual engine, language,
and systems — so every developer writes less boilerplate and more assertions.

> **中文翻译**：当常见的设置、清理和断言模式被抽象为辅助工具时，编写测试用例会更快、更一致。此技能生成一个针对项目实际引擎、语言和系统定制的 `tests/helpers/` 库 — 让每个开发者少写样板代码，多写断言。

**Output:** `tests/helpers/` directory with engine-specific helper files

> **中文翻译**：**输出**：带有引擎特定辅助文件的 `tests/helpers/` 目录

**When to run:** / **何时运行：**
- After `/test-setup` scaffolds the framework (first time) / 在 `/test-setup` 搭建框架之后（首次）
- When multiple test files repeat the same setup boilerplate / 当多个测试文件重复相同的设置样板时
- When starting to write tests for a new system / 当开始为新的系统编写测试时

---

<!-- 中文翻译 -->
## 1. Parse Arguments

**Modes:** / **模式：**
- `/test-helpers [system-name]` — generate helpers for a specific system / 为特定系统生成辅助工具
  (e.g., `/test-helpers combat`) / 例如：`/test-helpers combat`
- `/test-helpers all` — generate helpers for all systems with test files / 为所有有测试文件的系统生成辅助工具
- `/test-helpers scaffold` — generate only the base helper library (no / 仅生成基础辅助库（无
  system-specific helpers); use this on first run / 系统特定辅助工具）；首次运行时使用此模式
- No argument — run `scaffold` if no helpers exist, else `all` / 无参数 — 如果没有辅助工具则运行 `scaffold`，否则运行 `all`

---

<!-- 中文翻译 -->
## 2. Detect Engine and Language

Read `.codebuddy/docs/technical-preferences.md` and extract: / 读取 `.codebuddy/docs/technical-preferences.md` 并提取：
- `Engine:` value / `Engine:` 值
- `Language:` value / `Language:` 值
- `Framework:` from the Testing section / 从测试部分获取 `Framework:`

If engine is not configured: "Engine not configured. Run `/setup-engine` first." / 如果引擎未配置："引擎未配置。先运行 `/setup-engine`。"

---

<!-- 中文翻译 -->
## 3. Load Existing Test Patterns

Scan the test directory for patterns already in use: / 扫描测试目录以查找已使用的模式：

```
Glob pattern="tests/**/*_test.*" (all test files) / 所有测试文件
```

For a representative sample (up to 5 files), read the test files and extract: / 对于代表性样本（最多 5 个文件），读取测试文件并提取：
- Setup patterns (how `before_each` / `setUp` / fixtures are written) / 设置模式（`before_each` / `setUp` / fixtures 的编写方式）
- Common assertion patterns (what is being asserted most often) / 常见断言模式（最常断言的内容）
- Object creation patterns (how game objects or scenes are instantiated in tests) / 对象创建模式（测试中游戏对象或场景如何实例化）
- Mock/stub patterns (how dependencies are replaced) / 模拟/存根模式（依赖项如何替换）

This ensures generated helpers match the project's existing style, not a / 这确保生成的辅助工具匹配项目的现有风格，而非
generic template. / 通用模板。

Also read: / 还读取：
- `design/gdd/systems-index.md` — to know which systems exist / 了解哪些系统存在
- In-scope GDD(s) — to understand what data types and values need testing / 范围内 GDD — 了解需要测试的数据类型和值
- `docs/architecture/tr-registry.yaml` — to map requirements to tested systems / 将需求映射到测试系统

---

<!-- 中文翻译 -->
## 4. Generate Engine-Specific Helpers

<!-- 中文翻译 -->
### Godot 4 (GDUnit4 / GDScript)

**Base helper** (`tests/helpers/game_assertions.gd`): / **基础辅助工具** (`tests/helpers/game_assertions.gd`)：

```gdscript
## Game-specific assertion utilities for [Project Name] tests.
## Extends GdUnitAssertions with domain-specific helpers.
##
## Usage:
##   var assert = GameAssertions.new()
##   assert.health_in_range(entity, 0, entity.max_health)

class_name GameAssertions
extends RefCounted

## Assert a value is within the inclusive range [min_val, max_val].
## Use for any formula output that has defined bounds in a GDD.
static func assert_in_range(
    value: float,
    min_val: float,
    max_val: float,
    label: String = "value"
) -> void:
    assert(
        value >= min_val and value <= max_val,
        "%s %.2f is outside expected range [%.2f, %.2f]" % [label, value, min_val, max_val]
    )

## Assert a signal was emitted during a callable block.
## Usage: assert_signal_emitted(entity, "health_changed", func(): entity.take_damage(10))
static func assert_signal_emitted(
    obj: Object,
    signal_name: String,
    action: Callable
) -> void:
    var emitted := false
    obj.connect(signal_name, func(_args): emitted = true)
    action.call()
    assert(emitted, "Expected signal '%s' to be emitted, but it was not." % signal_name)

## Assert that a callable does NOT emit a signal.
static func assert_signal_not_emitted(
    obj: Object,
    signal_name: String,
    action: Callable
) -> void:
    var emitted := false
    obj.connect(signal_name, func(_args): emitted = true)
    action.call()
    assert(not emitted, "Expected signal '%s' NOT to be emitted, but it was." % signal_name)

## Assert a node exists at path within a parent.
static func assert_node_exists(parent: Node, path: NodePath) -> void:
    assert(
        parent.has_node(path),
        "Expected node at path '%s' to exist." % str(path)
    )
```

**Factory helper** (`tests/helpers/game_factory.gd`): / **工厂辅助工具** (`tests/helpers/game_factory.gd`)：

```gdscript
## Factory functions for creating test game objects.
## Returns minimal objects configured for unit testing (no scene tree required).
##
## Usage: var player = GameFactory.make_player(health: 100)

class_name GameFactory
extends RefCounted

## Create a minimal player-like object for testing.
## Override fields as needed.
static func make_player(health: int = 100) -> Node:
    var player = Node.new()
    player.set_meta("health", health)
    player.set_meta("max_health", health)
    return player
```

**Scene helper** (`tests/helpers/scene_runner_helper.gd`): / **场景辅助工具** (`tests/helpers/scene_runner_helper.gd`)：

```gdscript
## Utilities for scene-based integration tests.
## Wraps GdUnitSceneRunner for common patterns.

class_name SceneRunnerHelper
extends GdUnitTestSuite

## Load a scene and wait one frame for _ready() to complete.
func load_scene_and_wait(scene_path: String) -> Node:
    var scene = load(scene_path).instantiate()
    add_child(scene)
    await get_tree().process_frame
    return scene
```

---

<!-- 中文翻译 -->
### Unity (NUnit / C#)

**Base helper** (`tests/helpers/GameAssertions.cs`): / **基础辅助工具** (`tests/helpers/GameAssertions.cs`)：

```csharp
using NUnit.Framework;
using UnityEngine;

/// <summary>
/// Game-specific assertion utilities for [Project Name] tests.
/// Extends NUnit's Assert with domain-specific helpers.
/// </summary>
public static class GameAssertions
{
    /// <summary>
    /// Assert a value is within an inclusive range [min, max].
    /// Use for any formula output defined in GDD Formulas sections.
    /// </summary>
    public static void AssertInRange(float value, float min, float max, string label = "value")
    {
        Assert.That(value, Is.InRange(min, max),
            $"{label} ({value:F2}) is outside expected range [{min:F2}, {max:F2}]");
    }

    /// <summary>Assert a UnityEvent or C# event was raised during an action.</summary>
    public static void AssertEventRaised(ref bool wasCalled, System.Action action, string eventName)
    {
        wasCalled = false;
        action();
        Assert.IsTrue(wasCalled, $"Expected event '{eventName}' to be raised, but it was not.");
    }

    /// <summary>Assert a component exists on a GameObject.</summary>
    public static void AssertHasComponent<T>(GameObject obj) where T : Component
    {
        var component = obj.GetComponent<T>();
        Assert.IsNotNull(component,
            $"Expected GameObject '{obj.name}' to have component {typeof(T).Name}.");
    }
}
```

**Factory helper** (`tests/helpers/GameFactory.cs`): / **工厂辅助工具** (`tests/helpers/GameFactory.cs`)：

```csharp
using UnityEngine;

/// <summary>
/// Factory methods for creating minimal test objects without loading scenes.
/// </summary>
public static class GameFactory
{
    /// <summary>Create a minimal GameObject with a named component for testing.</summary>
    public static GameObject MakeGameObject(string name = "TestObject")
    {
        var go = new GameObject(name);
        return go;
    }

    /// <summary>
    /// Create a ScriptableObject of type T for data-driven tests.
    /// Dispose with Object.DestroyImmediate after test.
    /// </summary>
    public static T MakeScriptableObject<T>() where T : ScriptableObject
    {
        return ScriptableObject.CreateInstance<T>();
    }
}
```

---

<!-- 中文翻译 -->
### Unreal Engine (C++)

**Base helper** (`tests/helpers/GameTestHelpers.h`): / **基础辅助工具** (`tests/helpers/GameTestHelpers.h`)：

```cpp
#pragma once

#include "CoreMinimal.h"
#include "Misc/AutomationTest.h"

/**
 * Game-specific assertion macros and helpers for [Project Name] automation tests.
 * Include in any test file that needs domain-specific assertions.
 *
 * Usage:
 *   GAME_TEST_ASSERT_IN_RANGE(TestName, DamageValue, 10.0f, 50.0f, TEXT("Damage"));
 */

// Assert a float value is within inclusive range [Min, Max]
#define GAME_TEST_ASSERT_IN_RANGE(TestName, Value, Min, Max, Label) \
    TestTrue( \
        FString::Printf(TEXT("%s (%.2f) in range [%.2f, %.2f]"), Label, Value, Min, Max), \
        (Value) >= (Min) && (Value) <= (Max) \
    )

// Assert a UObject pointer is valid (not null, not garbage collected)
#define GAME_TEST_ASSERT_VALID(TestName, Ptr, Label) \
    TestTrue( \
        FString::Printf(TEXT("%s is valid"), Label), \
        IsValid(Ptr) \
    )

// Assert an Actor is in the world (spawned successfully)
#define GAME_TEST_ASSERT_SPAWNED(TestName, ActorPtr, ClassName) \
    TestNotNull( \
        FString::Printf(TEXT("Spawned actor of class %s"), TEXT(#ClassName)), \
        ActorPtr \
    )

/**
 * Helper to create a minimal test world.
 * Remember to call World->DestroyWorld(false) in teardown.
 */
namespace GameTestHelpers
{
    inline UWorld* CreateTestWorld(const FString& WorldName = TEXT("TestWorld"))
    {
        UWorld* World = UWorld::CreateWorld(EWorldType::Game, false);
        FWorldContext& WorldContext = GEngine->CreateNewWorldContext(EWorldType::Game);
        WorldContext.SetCurrentWorld(World);
        return World;
    }
}
```

---

<!-- 中文翻译 -->
## 5. Generate System-Specific Helpers

For `[system-name]` or `all` modes, generate a helper per system: / 对于 `[system-name]` 或 `all` 模式，为每个系统生成一个辅助工具：

Read the system's GDD to extract: / 读取系统的 GDD 以提取：
- Data types (entity types, component names) / 数据类型（实体类型、组件名称）
- Formula variables and their bounds / 公式变量及其边界
- Common test scenarios mentioned in Edge Cases / 边界情况部分提到的常见测试场景

Generate `tests/helpers/[system]_factory.[ext]` with factory functions / 生成 `tests/helpers/[system]_factory.[ext]` 包含
specific to that system's objects. / 针对该系统对象的工厂函数。

Example pattern for a `combat` system (Godot/GDScript): / `combat` 系统的示例模式（Godot/GDScript）：

```gdscript
## Factory and assertion helpers for Combat system tests.
## Generated by /test-helpers combat on [date].
## Based on: design/gdd/combat.md

class_name CombatTestFactory
extends RefCounted

const DAMAGE_MIN := 0
const DAMAGE_MAX := 999  # From GDD: damage formula upper bound / 来自 GDD：伤害公式上限

## Create a minimal attacker object for damage formula tests.
static func make_attacker(attack: float = 10.0, crit_chance: float = 0.0) -> Node:
    var attacker = Node.new()
    attacker.set_meta("attack", attack)
    attacker.set_meta("crit_chance", crit_chance)
    return attacker

## Create a minimal target object for damage receive tests.
static func make_target(defense: float = 0.0, health: float = 100.0) -> Node:
    var target = Node.new()
    target.set_meta("defense", defense)
    target.set_meta("health", health)
    target.set_meta("max_health", health)
    return target

## Assert damage output is within GDD-specified bounds.
static func assert_damage_in_bounds(damage: float) -> void:
    GameAssertions.assert_in_range(damage, DAMAGE_MIN, DAMAGE_MAX, "damage")
```

---

<!-- 中文翻译 -->
## 6. Write Output

Present a summary of what will be created: / 呈现将创建内容的摘要：

```
## Test Helpers to Create / 要创建的测试辅助工具

Base helpers (engine: [engine]): / 基础辅助工具（引擎：[engine]）：
- tests/helpers/game_assertions.[ext]
- tests/helpers/game_factory.[ext]
[engine-specific extras] / 引擎特定额外内容

System helpers ([mode]): / 系统辅助工具（[mode]）：
- tests/helpers/[system]_factory.[ext]  ← from [system] GDD / 来自 [system] GDD
```

Ask: "May I write these helper files to `tests/helpers/`?" / 询问："我可以将这些辅助工具文件写入 `tests/helpers/` 吗？"

**Never overwrite existing files.** If a file already exists, report: / **绝不覆盖现有文件。** 如果文件已存在，报告：
"Skipping `[path]` — already exists. Remove the file manually if you want it / "跳过 `[path]` — 已存在。如果想要重新生成，请手动删除文件。"
regenerated." / "

After writing: Verdict: **COMPLETE** — helper files created. / 写入后：裁决：**COMPLETE** — 辅助工具文件已创建。

"Helper files created. To use them in a test: / "辅助工具文件已创建。要在测试中使用它们：
- Godot: `class_name` is auto-imported — no explicit import needed / `class_name` 自动导入 — 无需显式导入
- Unity: Add `using` directive or reference the test assembly / 添加 `using` 指令或引用测试程序集
- Unreal: `#include \"tests/helpers/GameTestHelpers.h\"`" / 包含头文件

---

## Collaborative Protocol / 协作协议

- **Never overwrite existing helpers** — they may contain hand-written / **绝不覆盖现有辅助工具** — 它们可能包含手动编写的
  customisations. Only generate new files that don't exist yet / 自定义内容。仅生成尚不存在的新文件
- **Generated code is a starting point** — the generated factory functions use / **生成的代码是起点** — 生成的工厂函数使用
  metadata patterns for simplicity; adapt to the actual class structure once / 元数据模式以简化；一旦代码存在就适应实际的类结构
  the code exists / 
- **Helpers should reflect the GDD** — bounds and constants in helpers should / **辅助工具应反映 GDD** — 辅助工具中的边界和常量应
  trace to GDD Formulas sections, not invented values / 追溯到 GDD 公式部分，而非发明的值
- **Ask before writing** — always confirm before creating files in `tests/` / **写入前询问** — 始终在 `tests/` 中创建文件前确认

## Next Steps / 下一步

- Run `/test-setup` if the test framework has not been scaffolded yet. / 如果测试框架尚未搭建，运行 `/test-setup`。
- Use `/dev-story` to implement stories — helpers reduce boilerplate in new test files. / 使用 `/dev-story` 实现故事 — 辅助工具减少新测试文件中的样板代码。
- Run `/skill-test` to validate other skills that may need helper coverage. / 运行 `/skill-test` 验证可能需要辅助工具覆盖的其他技能。
