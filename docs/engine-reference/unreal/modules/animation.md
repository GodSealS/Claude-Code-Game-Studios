# Unreal Engine 5.7 — Animation Module Reference / Unreal Engine动画模块


> **中文翻译**：本文档为Unreal Engine引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Knowledge Gap:** UE 5.7 animation authoring improvements, Control Rig 2.0

---

<!-- 概述 -->
## Overview

UE 5.7 animation systems:
- **Animation Blueprint**: State machine-based animation logic
- **Control Rig**: Runtime procedural animation (production-ready in UE5)
- **IK Rig + Retargeter**: Modern retargeting system
- **Sequencer**: Cinematic animation

---

<!-- 中文翻译 -->
## Animation Blueprint

<!-- 中文翻译 -->
### Create Animation Blueprint

1. Content Browser > Right Click > Animation > Animation Blueprint
2. Select parent class: `AnimInstance`
3. Select skeleton

<!-- 中文翻译 -->
### Animation State Machine

```cpp
// In Animation Blueprint Event Graph:
// - State Machine drives animation states (Idle, Walk, Run, Jump)
// - Blend Spaces for directional movement

// Access in C++:
UAnimInstance* AnimInstance = Mesh->GetAnimInstance();
AnimInstance->Montage_Play(AttackMontage);
```

---

<!-- 中文翻译 -->
## Play Animation Montages

<!-- 中文翻译 -->
### Animation Montage

```cpp
// Play montage
UAnimInstance* AnimInstance = GetMesh()->GetAnimInstance();
AnimInstance->Montage_Play(AttackMontage, 1.0f);

// Stop montage
AnimInstance->Montage_Stop(0.2f, AttackMontage);

// Check if montage is playing
bool bIsPlaying = AnimInstance->Montage_IsPlaying(AttackMontage);
```

<!-- 中文翻译 -->
### Montage Notify Events

```cpp
// Add notify event in Animation Montage (right-click timeline > Add Notify > New Notify)
// Implement in C++:

UCLASS()
class UMyAnimInstance : public UAnimInstance {
    GENERATED_BODY()

public:
    UFUNCTION()
    void AnimNotify_AttackHit() {
        // Called when notify is reached
        DealDamage();
    }
};
```

---

<!-- 中文翻译 -->
## Blend Spaces

<!-- 中文翻译 -->
### 1D Blend Space (Speed Blending)

```cpp
// Create: Content Browser > Animation > Blend Space 1D
// Horizontal Axis: Speed (0 = Idle, 1 = Walk, 2 = Run)
// Add animations at key points

// Use in Anim Blueprint:
// - Get speed from character
// - Feed into Blend Space
```

<!-- 中文翻译 -->
### 2D Blend Space (Directional Movement)

```cpp
// Create: Content Browser > Animation > Blend Space
// Horizontal Axis: Direction X (-1 to 1)
// Vertical Axis: Direction Y (-1 to 1)
// Place animations (Fwd, Back, Left, Right, diagonal)
```

---

<!-- 中文翻译 -->
## Control Rig (Procedural Animation)

<!-- 中文翻译 -->
### Create Control Rig

1. Content Browser > Animation > Control Rig
2. Select skeleton
3. Build rig hierarchy (bones, controls, IK)

<!-- 中文翻译 -->
### Use Control Rig in Animation Blueprint

```cpp
// Add "Control Rig" node to Anim Blueprint
// Assign Control Rig asset
// Procedurally modify bones at runtime
```

<!-- 中文翻译 -->
### Control Rig in C++

```cpp
// Get control rig component
UControlRig* ControlRig = /* Get from animation instance */;

// Set control value
ControlRig->SetControlValue<FVector>(TEXT("IK_Hand_R"), TargetLocation);
```

---

<!-- 中文翻译 -->
## IK Rig & Retargeting (UE5)

<!-- 中文翻译 -->
### Create IK Rig

1. Content Browser > Animation > IK Rig
2. Select skeleton
3. Add IK goals (hands, feet)
4. Set up solver chains

<!-- 中文翻译 -->
### Retarget Animations

1. Create IK Rig for source skeleton
2. Create IK Rig for target skeleton
3. Create IK Retargeter asset
4. Assign source and target IK Rigs
5. Batch retarget animations

<!-- 中文翻译 -->
### Retargeting in C++

```cpp
// Retargeting is primarily editor-based
// Animations are retargeted once, then used normally
```

---

<!-- 中文翻译 -->
## Animation Notify States

<!-- 中文翻译 -->
### Custom Notify State (Duration-Based Events)

```cpp
UCLASS()
class UAnimNotifyState_Invulnerable : public UAnimNotifyState {
    GENERATED_BODY()

public:
    virtual void NotifyBegin(USkeletalMeshComponent* MeshComp, UAnimSequenceBase* Animation, float TotalDuration, const FAnimNotifyEventReference& EventReference) override {
        // Start invulnerability
        AMyCharacter* Character = Cast<AMyCharacter>(MeshComp->GetOwner());
        Character->bIsInvulnerable = true;
    }

    virtual void NotifyEnd(USkeletalMeshComponent* MeshComp, UAnimSequenceBase* Animation, const FAnimNotifyEventReference& EventReference) override {
        // End invulnerability
        AMyCharacter* Character = Cast<AMyCharacter>(MeshComp->GetOwner());
        Character->bIsInvulnerable = false;
    }
};
```

---

<!-- 中文翻译 -->
## Skeletal Mesh & Sockets

<!-- 中文翻译 -->
### Attach Objects to Sockets

```cpp
// Create socket in Skeletal Mesh Editor (Skeleton Tree > Add Socket)

// Attach component to socket
UStaticMeshComponent* Weapon = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("Weapon"));
Weapon->SetupAttachment(GetMesh(), TEXT("hand_r_socket"));
```

---

<!-- 中文翻译 -->
## Animation Curves

<!-- 中文翻译 -->
### Use Animation Curves

```cpp
// Add curve to animation:
// Animation Editor > Curves > Add Curve

// Read curve value in Anim Blueprint or C++:
UAnimInstance* AnimInstance = GetMesh()->GetAnimInstance();
float CurveValue = AnimInstance->GetCurveValue(TEXT("MyCurve"));
```

---

<!-- 中文翻译 -->
## Root Motion

<!-- 中文翻译 -->
### Enable Root Motion

```cpp
// In Animation Sequence: Asset Details > Root Motion > Enable Root Motion

// In Character class:
GetCharacterMovement()->bAllowPhysicsRotationDuringAnimRootMotion = true;
```

---

<!-- 中文翻译 -->
## Animation Layers (Linked Anim Graphs)

<!-- 中文翻译 -->
### Use Linked Anim Layers

```cpp
// Create separate Anim Blueprints for layers (e.g., upper body, lower body)
// Link in main Anim Blueprint: Add "Linked Anim Graph" node

// Dynamically switch layers:
UAnimInstance* AnimInstance = GetMesh()->GetAnimInstance();
AnimInstance->LinkAnimClassLayers(NewLayerClass);
```

---

<!-- 中文翻译 -->
## Sequencer (Cinematic Animation)

<!-- 中文翻译 -->
### Create Sequence

1. Content Browser > Cinematics > Level Sequence
2. Add tracks: Camera, Character, Animation, etc.

<!-- 中文翻译 -->
### Play Sequence from C++

```cpp
#include "LevelSequenceActor.h"
#include "LevelSequencePlayer.h"

ALevelSequenceActor* SequenceActor = /* Spawn or find in level */;
SequenceActor->GetSequencePlayer()->Play();
```

---

<!-- 性能提示 -->
## Performance Tips

<!-- 中文翻译 -->
### Animation Optimization

```cpp
// LOD (Level of Detail) for skeletal meshes
// Reduce bone count for distant characters

// Anim Blueprint optimization:
// - Use "Anim Node Relevancy" (skip updates when not visible)
// - Disable updates when off-screen:
GetMesh()->VisibilityBasedAnimTickOption = EVisibilityBasedAnimTickOption::OnlyTickPoseWhenRendered;
```

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### Animation Debug Visualization

```cpp
// Console commands:
// showdebug animation - Show animation state info
// a.VisualizeSkeletalMeshBones 1 - Show skeleton bones

// Draw debug bones:
DrawDebugCoordinateSystem(GetWorld(), BoneLocation, BoneRotation, 50.0f, false, -1.0f, 0, 2.0f);
```

---

<!-- 来源 -->
## Sources
- https://docs.unrealengine.com/5.7/en-US/animation-in-unreal-engine/
- https://docs.unrealengine.com/5.7/en-US/control-rig-in-unreal-engine/
- https://docs.unrealengine.com/5.7/en-US/ik-rig-in-unreal-engine/
