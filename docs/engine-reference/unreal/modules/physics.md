# Unreal Engine 5.7 — Physics Module Reference / Unreal Engine物理模块


> **中文翻译**：本文档为Unreal Engine引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Knowledge Gap:** UE 5.7 Chaos Physics improvements

---

<!-- 概述 -->
## Overview

UE 5 uses **Chaos Physics** (replaced PhysX in UE 4):
- Better performance
- Destruction support
- Vehicle physics improvements

---

<!-- 中文翻译 -->
## Rigid Body Physics

<!-- 中文翻译 -->
### Enable Physics on Static Mesh

```cpp
UStaticMeshComponent* MeshComp = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("Mesh"));
MeshComp->SetSimulatePhysics(true);
MeshComp->SetEnableGravity(true);
MeshComp->SetMassOverrideInKg(NAME_None, 50.0f); // 50 kg
```

<!-- 中文翻译 -->
### Apply Forces

```cpp
// Apply impulse (instant velocity change)
MeshComp->AddImpulse(FVector(0, 0, 1000), NAME_None, true);

// Apply force (continuous)
MeshComp->AddForce(FVector(0, 0, 500));

// Apply torque (rotation)
MeshComp->AddTorqueInRadians(FVector(0, 0, 100));
```

---

<!-- 中文翻译 -->
## Collision

<!-- 中文翻译 -->
### Collision Channels

```cpp
// Project Settings > Engine > Collision
// Define custom collision channels and responses

// Set collision in C++
MeshComp->SetCollisionEnabled(ECollisionEnabled::QueryAndPhysics);
MeshComp->SetCollisionObjectType(ECollisionChannel::ECC_Pawn);
MeshComp->SetCollisionResponseToAllChannels(ECR_Block);
MeshComp->SetCollisionResponseToChannel(ECC_Camera, ECR_Ignore);
```

<!-- 中文翻译 -->
### Collision Events

```cpp
// Enable collision events
MeshComp->SetNotifyRigidBodyCollision(true);

// Bind to OnComponentHit
MeshComp->OnComponentHit.AddDynamic(this, &AMyActor::OnHit);

UFUNCTION()
void AMyActor::OnHit(UPrimitiveComponent* HitComp, AActor* OtherActor,
    UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit) {
    UE_LOG(LogTemp, Warning, TEXT("Hit %s"), *OtherActor->GetName());
}
```

<!-- 中文翻译 -->
### Overlap Events

```cpp
// Enable overlap events
MeshComp->SetGenerateOverlapEvents(true);

// Bind to OnComponentBeginOverlap
MeshComp->OnComponentBeginOverlap.AddDynamic(this, &AMyActor::OnOverlapBegin);

UFUNCTION()
void AMyActor::OnOverlapBegin(UPrimitiveComponent* OverlappedComp, AActor* OtherActor,
    UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult) {
    UE_LOG(LogTemp, Warning, TEXT("Overlapped %s"), *OtherActor->GetName());
}
```

---

<!-- 中文翻译 -->
## Raycasting (Line Traces)

<!-- 中文翻译 -->
### Single Line Trace

```cpp
FHitResult HitResult;
FVector Start = GetActorLocation();
FVector End = Start + GetActorForwardVector() * 1000.0f;

FCollisionQueryParams QueryParams;
QueryParams.AddIgnoredActor(this);

// Perform trace
bool bHit = GetWorld()->LineTraceSingleByChannel(
    HitResult,
    Start,
    End,
    ECC_Visibility,
    QueryParams
);

if (bHit) {
    UE_LOG(LogTemp, Warning, TEXT("Hit: %s"), *HitResult.GetActor()->GetName());
    DrawDebugLine(GetWorld(), Start, HitResult.Location, FColor::Red, false, 2.0f);
}
```

<!-- 中文翻译 -->
### Multi Line Trace

```cpp
TArray<FHitResult> HitResults;
bool bHit = GetWorld()->LineTraceMultiByChannel(
    HitResults,
    Start,
    End,
    ECC_Visibility,
    QueryParams
);

for (const FHitResult& Hit : HitResults) {
    UE_LOG(LogTemp, Warning, TEXT("Hit: %s"), *Hit.GetActor()->GetName());
}
```

<!-- 中文翻译 -->
### Sweep (Thick Trace)

```cpp
FHitResult HitResult;
FCollisionShape Sphere = FCollisionShape::MakeSphere(50.0f);

bool bHit = GetWorld()->SweepSingleByChannel(
    HitResult,
    Start,
    End,
    FQuat::Identity,
    ECC_Visibility,
    Sphere,
    QueryParams
);
```

---

<!-- 中文翻译 -->
## Character Movement

<!-- 中文翻译 -->
### Character Movement Component

```cpp
// Built into ACharacter class
UCharacterMovementComponent* MoveComp = GetCharacterMovement();

// Configure movement
MoveComp->MaxWalkSpeed = 600.0f;
MoveComp->JumpZVelocity = 600.0f;
MoveComp->AirControl = 0.2f;
MoveComp->GravityScale = 1.0f;
MoveComp->bOrientRotationToMovement = true;
```

<!-- 中文翻译 -->
### Add Movement Input

```cpp
// In Character class
void AMyCharacter::MoveForward(float Value) {
    if (Value != 0.0f) {
        AddMovementInput(GetActorForwardVector(), Value);
    }
}

void AMyCharacter::MoveRight(float Value) {
    if (Value != 0.0f) {
        AddMovementInput(GetActorRightVector(), Value);
    }
}
```

---

<!-- 中文翻译 -->
## Physical Materials

<!-- 中文翻译 -->
### Create Physical Material

1. Content Browser > Right Click > Physics > Physical Material
2. Configure properties:
   - Friction: 0.0 - 1.0
   - Restitution (bounciness): 0.0 - 1.0

<!-- 中文翻译 -->
### Assign Physical Material

```cpp
// In static mesh editor: Physics > Phys Material Override
// Or in C++:
MeshComp->SetPhysMaterialOverride(PhysicalMaterial);
```

---

<!-- 中文翻译 -->
## Constraints (Physics Joints)

<!-- 中文翻译 -->
### Physics Constraint Component

```cpp
UPhysicsConstraintComponent* Constraint = CreateDefaultSubobject<UPhysicsConstraintComponent>(TEXT("Constraint"));
Constraint->SetConstrainedComponents(ComponentA, NAME_None, ComponentB, NAME_None);

// Configure constraint
Constraint->SetLinearXLimit(ELinearConstraintMotion::LCM_Limited, 100.0f);
Constraint->SetLinearYLimit(ELinearConstraintMotion::LCM_Locked, 0.0f);
Constraint->SetLinearZLimit(ELinearConstraintMotion::LCM_Free, 0.0f);

Constraint->SetAngularSwing1Limit(EAngularConstraintMotion::ACM_Limited, 45.0f);
```

---

<!-- 中文翻译 -->
## Destruction (Chaos Destruction)

<!-- 中文翻译 -->
### Enable Chaos Destruction

```cpp
// Plugin: Enable "Chaos" plugin
// Create Geometry Collection asset for destructible objects
```

<!-- 中文翻译 -->
### Destroy Geometry Collection

```cpp
// Fracture mesh in Chaos editor
// In game, apply damage:
UGeometryCollectionComponent* GeoComp = /* Get component */;
GeoComp->ApplyPhysicsField(/* Field parameters */);
```

---

<!-- 性能提示 -->
## Performance Tips

<!-- 中文翻译 -->
### Physics Optimization

```cpp
// Simplify collision shapes (use simple primitives)
MeshComp->SetCollisionEnabled(ECollisionEnabled::NoCollision); // Disable when not needed

// Use Physics Asset for skeletal meshes (simplified collision)
// Don't simulate physics for distant objects

// Reduce physics substeps:
// Project Settings > Engine > Physics > Max Substep Delta Time
```

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### Physics Debug Visualization

```cpp
// Console commands:
// show collision - Show collision shapes
// p.Chaos.DebugDraw.Enabled 1 - Show Chaos debug
// pxvis collision - Visualize collision

// Draw debug shapes:
DrawDebugSphere(GetWorld(), Location, Radius, 12, FColor::Green, false, 2.0f);
DrawDebugBox(GetWorld(), Location, Extent, FColor::Red, false, 2.0f);
```

---

<!-- 来源 -->
## Sources
- https://docs.unrealengine.com/5.7/en-US/physics-in-unreal-engine/
- https://docs.unrealengine.com/5.7/en-US/chaos-physics-overview-in-unreal-engine/
