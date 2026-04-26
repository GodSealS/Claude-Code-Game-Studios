# Unreal Engine 5.7 — Current Best Practices / 当前最佳实践


> **中文翻译**：本文档为Unreal Engine引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13

Modern UE5 patterns that may not be in the LLM's training data.
These are production-ready recommendations as of UE 5.7.

---

<!-- 项目设置 -->
## Project Setup

<!-- 中文翻译 -->
### Use UE 5.7 for New Projects
- Latest features: Megalights, production-ready Substrate and PCG
- Better performance and stability

<!-- 中文翻译 -->
### Choose the Right Rendering Features
- **Lumen**: Real-time global illumination (RECOMMENDED for most projects)
- **Nanite**: Virtualized geometry for high-poly meshes (RECOMMENDED for detailed environments)
- **Megalights**: Millions of dynamic lights (RECOMMENDED for complex lighting)
- **Substrate**: Modular material system (RECOMMENDED for new projects)

---

<!-- 中文翻译 -->
## C++ Coding

<!-- 中文翻译 -->
### Use Modern C++ Features (C++20 in UE5.7)

```cpp
// ✅ Use TObjectPtr<T> (UE5 type-safe pointers)
UPROPERTY()
TObjectPtr<UStaticMeshComponent> MeshComp;

// ✅ Structured bindings
if (auto [bSuccess, Value] = TryGetValue(); bSuccess) {
    // Use Value
}

// ✅ Concepts and constraints (C++20)
template<typename T>
concept Damageable = requires(T t, float damage) {
    { t.TakeDamage(damage) } -> std::same_as<void>;
};
```

<!-- 中文翻译 -->
### Use UPROPERTY() for Garbage Collection

```cpp
// ✅ UPROPERTY ensures GC doesn't delete this
UPROPERTY()
TObjectPtr<AActor> MyActor;

// ❌ Raw pointers can become dangling
AActor* MyActor; // Dangerous! May be garbage collected
```

<!-- 中文翻译 -->
### Use UFUNCTION() for Blueprint Exposure

```cpp
// ✅ Callable from Blueprint
UFUNCTION(BlueprintCallable, Category="Combat")
void TakeDamage(float Damage);

// ✅ Implementable in Blueprint
UFUNCTION(BlueprintImplementableEvent, Category="Combat")
void OnDeath();
```

---

<!-- 中文翻译 -->
## Blueprint Best Practices

<!-- 中文翻译 -->
### Use Blueprint vs C++

- **C++**: Core gameplay systems, performance-critical code, low-level engine interaction
- **Blueprint**: Rapid prototyping, content creation, data-driven logic, designer workflows

<!-- 中文翻译 -->
### Blueprint Performance Tips

```cpp
// ✅ Use Event Tick sparingly (expensive)
// Prefer timers or events

// ✅ Use Blueprint Nativization (Blueprints → C++)
// Project Settings > Packaging > Blueprint Nativization

// ✅ Cache frequently accessed components
// Don't call GetComponent every tick
```

---

<!-- 中文翻译 -->
## Rendering (UE 5.7)

<!-- 中文翻译 -->
### Use Lumen for Global Illumination

```cpp
// Enable: Project Settings > Engine > Rendering > Dynamic Global Illumination Method = Lumen
// Real-time GI, no lightmap baking needed (RECOMMENDED)
```

<!-- 中文翻译 -->
### Use Nanite for High-Poly Meshes

```cpp
// Enable on Static Mesh: Details > Nanite Settings > Enable Nanite Support
// Automatically LODs millions of triangles (RECOMMENDED for detailed meshes)
```

<!-- 中文翻译 -->
### Use Megalights for Complex Lighting (UE 5.5+)

```cpp
// Enable: Project Settings > Engine > Rendering > Megalights = Enabled
// Supports millions of dynamic lights with minimal cost
```

<!-- 中文翻译 -->
### Use Substrate Materials (Production-Ready in 5.7)

```cpp
// Enable: Project Settings > Engine > Substrate > Enable Substrate
// Modular, physically accurate materials (RECOMMENDED for new projects)
```

---

<!-- 中文翻译 -->
## Enhanced Input System

<!-- 中文翻译 -->
### Setup Enhanced Input

```cpp
// 1. Create Input Action (IA_Jump)
// 2. Create Input Mapping Context (IMC_Default)
// 3. Add mapping: IA_Jump → Space Bar

// C++ Setup:
#include "EnhancedInputComponent.h"
#include "EnhancedInputSubsystems.h"

void AMyCharacter::BeginPlay() {
    Super::BeginPlay();

    if (APlayerController* PC = Cast<APlayerController>(GetController())) {
        if (UEnhancedInputLocalPlayerSubsystem* Subsystem =
            ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>(PC->GetLocalPlayer())) {
            Subsystem->AddMappingContext(DefaultMappingContext, 0);
        }
    }
}

void AMyCharacter::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent) {
    UEnhancedInputComponent* EIC = Cast<UEnhancedInputComponent>(PlayerInputComponent);
    EIC->BindAction(JumpAction, ETriggerEvent::Started, this, &ACharacter::Jump);
    EIC->BindAction(MoveAction, ETriggerEvent::Triggered, this, &AMyCharacter::Move);
}

void AMyCharacter::Move(const FInputActionValue& Value) {
    FVector2D MoveVector = Value.Get<FVector2D>();
    AddMovementInput(GetActorForwardVector(), MoveVector.Y);
    AddMovementInput(GetActorRightVector(), MoveVector.X);
}
```

---

<!-- 中文翻译 -->
## Gameplay Ability System (GAS)

<!-- 中文翻译 -->
### Use GAS for Complex Gameplay

```cpp
// ✅ Use GAS for: Abilities, buffs, damage calculation, cooldowns
// Modular, scalable, multiplayer-ready

// Install: Enable "Gameplay Abilities" plugin

// Example Ability:
UCLASS()
class UGA_Fireball : public UGameplayAbility {
    GENERATED_BODY()

public:
    virtual void ActivateAbility(...) override {
        // Ability logic
        SpawnFireball();
        CommitAbility(); // Commit cost/cooldown
    }
};
```

---

<!-- 中文翻译 -->
## World Partition (Large Worlds)

<!-- 中文翻译 -->
### Use World Partition for Open Worlds

```cpp
// Enable: World Settings > Enable World Partition
// Automatically streams world cells based on player location

// Data Layers: Organize content (e.g., "Gameplay", "Audio", "Lighting")
// Runtime Data Layers: Load/unload at runtime
```

---

<!-- 中文翻译 -->
## Niagara (VFX)

<!-- 中文翻译 -->
### Use Niagara (Not Cascade)

```cpp
// Create: Content Browser > Right Click > FX > Niagara System
// GPU-accelerated, node-based particle system (RECOMMENDED)

// Spawn particles:
UNiagaraComponent* NiagaraComp = UNiagaraFunctionLibrary::SpawnSystemAtLocation(
    GetWorld(),
    ExplosionSystem,
    GetActorLocation()
);
```

---

<!-- 中文翻译 -->
## MetaSounds (Audio)

<!-- 中文翻译 -->
### Use MetaSounds for Procedural Audio

```cpp
// Create: Content Browser > Right Click > Sounds > MetaSound Source
// Node-based audio, replaces Sound Cue for complex logic (RECOMMENDED)

// Play MetaSound:
UAudioComponent* AudioComp = UGameplayStatics::SpawnSound2D(
    GetWorld(),
    MetaSoundSource
);
```

---

<!-- 中文翻译 -->
## Replication (Multiplayer)

<!-- 中文翻译 -->
### Server-Authoritative Pattern

```cpp
// ✅ Client sends input, server validates and replicates
UFUNCTION(Server, Reliable)
void Server_Move(FVector Direction);

void AMyCharacter::Server_Move_Implementation(FVector Direction) {
    // Server validates and applies movement
    AddMovementInput(Direction);
}

// ✅ Replicate important state
UPROPERTY(Replicated)
int32 Health;

void AMyCharacter::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const {
    Super::GetLifetimeReplicatedProps(OutLifetimeProps);
    DOREPLIFETIME(AMyCharacter, Health);
}
```

---

<!-- 性能优化 -->
## Performance Optimization

<!-- 中文翻译 -->
### Use Object Pooling

```cpp
// ✅ Reuse objects instead of Spawn/Destroy
TArray<AActor*> ProjectilePool;

AActor* GetPooledProjectile() {
    for (AActor* Proj : ProjectilePool) {
        if (!Proj->IsActive()) {
            Proj->SetActive(true);
            return Proj;
        }
    }
    // Pool exhausted, spawn new
    return SpawnNewProjectile();
}
```

<!-- 中文翻译 -->
### Use Instanced Static Meshes

```cpp
// ✅ Hierarchical Instanced Static Mesh Component (HISM)
// Render thousands of identical meshes in one draw call
UHierarchicalInstancedStaticMeshComponent* HISM = CreateDefaultSubobject<UHierarchicalInstancedStaticMeshComponent>(TEXT("Trees"));
for (int i = 0; i < 1000; i++) {
    HISM->AddInstance(FTransform(RandomLocation));
}
```

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### Use Logging

```cpp
// ✅ Structured logging
UE_LOG(LogTemp, Warning, TEXT("Player health: %d"), Health);

// Custom log category
DECLARE_LOG_CATEGORY_EXTERN(LogMyGame, Log, All);
DEFINE_LOG_CATEGORY(LogMyGame);
UE_LOG(LogMyGame, Error, TEXT("Critical error!"));
```

<!-- 中文翻译 -->
### Use Visual Logger

```cpp
// ✅ Visual debugging
#include "VisualLogger/VisualLogger.h"

UE_VLOG_SEGMENT(this, LogTemp, Log, StartPos, EndPos, FColor::Red, TEXT("Raycast"));
UE_VLOG_LOCATION(this, LogTemp, Log, TargetLocation, 50.f, FColor::Green, TEXT("Target"));
```

---

<!-- 中文翻译 -->
## Summary: UE 5.7 Recommended Stack

| Feature | Use This (2026) | Notes |
|---------|------------------|-------|
| **Lighting** | Lumen + Megalights | Real-time GI, millions of lights |
| **Geometry** | Nanite | High-poly meshes, automatic LOD |
| **Materials** | Substrate | Modular, physically accurate |
| **Input** | Enhanced Input | Rebindable, modular |
| **VFX** | Niagara | GPU-accelerated |
| **Audio** | MetaSounds | Procedural audio |
| **World Streaming** | World Partition | Large open worlds |
| **Gameplay** | Gameplay Ability System | Complex abilities, buffs |

---

**Sources:**
- https://docs.unrealengine.com/5.7/en-US/
- https://dev.epicgames.com/documentation/en-us/unreal-engine/unreal-engine-5-7-release-notes
