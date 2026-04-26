# Unreal Engine 5.7 — Deprecated APIs / 已弃用API


> **中文翻译**：本文档为Unreal Engine引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13

Quick lookup table for deprecated APIs and their replacements.
Format: **Don't use X** → **Use Y instead**

---

<!-- 中文翻译 -->
## Input

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| `InputComponent->BindAction()` | Enhanced Input `BindAction()` | New input system |
| `InputComponent->BindAxis()` | Enhanced Input `BindAxis()` | New input system |
| `PlayerController->GetInputAxisValue()` | Enhanced Input Action Values | New input system |

**Migration:** Install Enhanced Input plugin, create Input Actions and Input Mapping Contexts.

---

<!-- 中文翻译 -->
## Rendering

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| Legacy material nodes | Substrate material nodes | Substrate is production-ready in 5.7 |
| Forward shading (default) | Deferred + Lumen | Lumen is default in UE5 |
| Old lighting workflow | Lumen Global Illumination | Real-time GI |

---

<!-- 中文翻译 -->
## World Building

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| UE4 World Composition | World Partition (UE5) | Streaming large worlds |
| Level Streaming Volumes | World Partition Data Layers | Better level streaming |

---

<!-- 中文翻译 -->
## Animation

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| Old animation retargeting | IK Rig + IK Retargeter | UE5 retargeting system |
| Legacy control rig | Control Rig 2.0 | Production-ready rigging |

---

<!-- 中文翻译 -->
## Gameplay

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| `UGameplayStatics::LoadStreamLevel()` | World Partition streaming | Use Data Layers |
| Hardcoded input bindings | Enhanced Input system | Rebindable, modular input |

---

<!-- 中文翻译 -->
## Niagara (VFX)

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| Cascade particle system | Niagara | Cascade is fully deprecated |

---

<!-- 中文翻译 -->
## Audio

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| Old audio mixer | MetaSounds | Procedural audio system |
| Sound Cue (for complex logic) | MetaSounds | More powerful, node-based |

---

<!-- 中文翻译 -->
## Networking

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| `DOREPLIFETIME()` (basic) | `DOREPLIFETIME_CONDITION()` | Conditional replication for optimization |

---

<!-- 中文翻译 -->
## C++ Scripting

| Deprecated | Replacement | Notes |
|------------|-------------|-------|
| `TSharedPtr<T>` for UObjects | `TObjectPtr<T>` | UE5 type-safe pointers |
| Manual RTTI checks | `Cast<T>()` / `IsA<T>()` | Type-safe casting |

---

<!-- 中文翻译 -->
## Quick Migration Patterns

<!-- 中文翻译 -->
### Input Example
```cpp
// ❌ Deprecated
void AMyCharacter::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent) {
    PlayerInputComponent->BindAction("Jump", IE_Pressed, this, &ACharacter::Jump);
}

// ✅ Enhanced Input
#include "EnhancedInputComponent.h"

void AMyCharacter::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent) {
    UEnhancedInputComponent* EIC = Cast<UEnhancedInputComponent>(PlayerInputComponent);
    if (EIC) {
        EIC->BindAction(JumpAction, ETriggerEvent::Started, this, &ACharacter::Jump);
    }
}
```

<!-- 中文翻译 -->
### Material Example
```cpp
// ❌ Deprecated: Legacy material
// Use standard material graph (still works but not recommended)

// ✅ Substrate Material
// Enable: Project Settings > Engine > Substrate > Enable Substrate
// Use Substrate nodes in material editor
```

<!-- 中文翻译 -->
### World Partition Example
```cpp
// ❌ Deprecated: Level streaming volumes
// Load/unload levels manually

// ✅ World Partition
// Enable: World Settings > Enable World Partition
// Use Data Layers for streaming
```

<!-- 中文翻译 -->
### Particle System Example
```cpp
// ❌ Deprecated: Cascade
UParticleSystemComponent* PSC = CreateDefaultSubobject<UParticleSystemComponent>(TEXT("Particles"));

// ✅ Niagara
UNiagaraComponent* NiagaraComp = CreateDefaultSubobject<UNiagaraComponent>(TEXT("Niagara"));
```

<!-- 中文翻译 -->
### Audio Example
```cpp
// ❌ Deprecated: Sound Cue for complex logic
// Use Sound Cue editor nodes

// ✅ MetaSounds
// Create MetaSound Source asset, use node-based audio
```

---

<!-- 中文翻译 -->
## Summary: UE 5.7 Tech Stack

| Feature | Use This (2026) | Avoid This (Legacy) |
|---------|------------------|----------------------|
| **Input** | Enhanced Input | Legacy Input Bindings |
| **Materials** | Substrate | Legacy Material System |
| **Lighting** | Lumen + Megalights | Lightmaps + Limited Lights |
| **Particles** | Niagara | Cascade |
| **Audio** | MetaSounds | Sound Cue (for logic) |
| **World Streaming** | World Partition | World Composition |
| **Animation Retarget** | IK Rig + Retargeter | Old Retargeting |
| **Geometry** | Nanite (high-poly) | Standard Static Mesh LODs |

---

**Sources:**
- https://docs.unrealengine.com/5.7/en-US/deprecated-and-removed-features/
- https://dev.epicgames.com/documentation/en-us/unreal-engine/unreal-engine-5-7-release-notes
