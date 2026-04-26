# Unity 6.3 LTS — Deprecated APIs / 已弃用API


> **中文翻译**：本文档为Unity引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13

Quick lookup table for deprecated APIs and their replacements.
Format: **Don't use X** → **Use Y instead**

---

<!-- 中文翻译 -->
## Input

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| `Input.GetKey()` | `Keyboard.current[Key.X].isPressed` | New Input System |
| `Input.GetKeyDown()` | `Keyboard.current[Key.X].wasPressedThisFrame` | New Input System |
| `Input.GetMouseButton()` | `Mouse.current.leftButton.isPressed` | New Input System |
| `Input.GetAxis()` | `InputAction` callbacks | New Input System |
| `Input.mousePosition` | `Mouse.current.position.ReadValue()` | New Input System |

**Migration:** Install `com.unity.inputsystem` package.

---

<!-- UI -->
## UI

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| `Canvas` (UGUI) | `UIDocument` (UI Toolkit) | UI Toolkit is now production-ready |
| `Text` component | `TextMeshPro` or UI Toolkit `Label` | Better rendering, fewer draw calls |
| `Image` component | UI Toolkit `VisualElement` with background | More flexible styling |

**Migration:** UGUI still works, but UI Toolkit is recommended for new projects.

---

<!-- 中文翻译 -->
## DOTS/Entities

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| `ComponentSystem` | `ISystem` (unmanaged) | Entities 1.0+ complete rewrite |
| `JobComponentSystem` | `ISystem` with `IJobEntity` | Burst-compatible |
| `GameObjectEntity` | Pure ECS workflow | No GameObject conversion |
| `EntityManager.CreateEntity()` (old signature) | `EntityManager.CreateEntity(EntityArchetype)` | Explicit archetype |
| `ComponentDataFromEntity<T>` | `ComponentLookup<T>` | Entities 1.0+ rename |

**Migration:** See Entities package migration guide. Major refactor required.

---

<!-- 中文翻译 -->
## Rendering

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| `CommandBuffer.DrawMesh()` | RenderGraph API | URP/HDRP render passes |
| `OnPreRender()` / `OnPostRender()` | `RenderPipelineManager` callbacks | SRP compatibility |
| `Camera.SetReplacementShader()` | Custom render pass | Not supported in SRP |

---

<!-- 中文翻译 -->
## Physics

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| `Physics.RaycastAll()` | `Physics.RaycastNonAlloc()` | Avoid GC allocations |
| `Rigidbody.velocity` (direct write) | `Rigidbody.AddForce()` | Better physics stability |

---

<!-- 中文翻译 -->
## Asset Loading

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| `Resources.Load()` | Addressables | Better memory control, async loading |
| Synchronous asset loading | `Addressables.LoadAssetAsync()` | Non-blocking |

---

<!-- 中文翻译 -->
## Animation

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| Legacy Animation component | Animator Controller | Mecanim system |
| `Animation.Play()` | `Animator.Play()` | State machine control |

---

<!-- 中文翻译 -->
## Particles

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| Legacy Particle System | Visual Effect Graph | GPU-accelerated, more performant |

---

<!-- 中文翻译 -->
## Scripting

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| `WWW` class | `UnityWebRequest` | Modern async networking |
| `Application.LoadLevel()` | `SceneManager.LoadScene()` | Scene management |

---

<!-- 中文翻译 -->
## Platform-Specific

<!-- 中文翻译 -->
### WebGL
| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| WebGL 1.0 | WebGL 2.0 or WebGPU | Unity 6+ defaults to WebGPU |

---

<!-- 中文翻译 -->
## Quick Migration Patterns

<!-- 中文翻译 -->
### Input Example
```csharp
// ❌ Deprecated
if (Input.GetKeyDown(KeyCode.Space)) {
    Jump();
}

// ✅ New Input System
using UnityEngine.InputSystem;
if (Keyboard.current.spaceKey.wasPressedThisFrame) {
    Jump();
}
```

<!-- 中文翻译 -->
### Asset Loading Example
```csharp
// ❌ Deprecated
var prefab = Resources.Load<GameObject>("Enemies/Goblin");

// ✅ Addressables
var handle = Addressables.LoadAssetAsync<GameObject>("Enemies/Goblin");
await handle.Task;
var prefab = handle.Result;
```

<!-- 中文翻译 -->
### UI Example
```csharp
// ❌ Deprecated (UGUI)
GetComponent<Text>().text = "Score: 100";

// ✅ TextMeshPro
GetComponent<TextMeshProUGUI>().text = "Score: 100";

// ✅ UI Toolkit
rootVisualElement.Q<Label>("score-label").text = "Score: 100";
```

---

**Sources:**
- https://docs.unity3d.com/6000.0/Documentation/Manual/deprecated-features.html
- https://docs.unity3d.com/Packages/com.unity.inputsystem@1.11/manual/Migration.html
