# Unreal Engine 5.7 — Gameplay Camera System / Unreal EngineGameplay Camera System（游戏相机系统）插件


> **中文翻译**：本文档为Unreal Engine引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Status:** ⚠️ Experimental (introduced in UE 5.5)
**Plugin:** `GameplayCameras` (built-in, enable in Plugins)

---

<!-- 概述 -->
## Overview

**Gameplay Camera System** is a modular camera management framework introduced in UE 5.5.
It replaces traditional camera setups with a flexible, node-based system that handles
camera modes, blending, and context-aware camera behavior.

**Use Gameplay Cameras for:**
- Dynamic camera behavior (3rd person, aiming, vehicles, cinematic)
- Context-aware camera switching (combat, exploration, dialogue)
- Smooth camera blending between modes
- Procedural camera motion (camera shake, lag, offset)

**⚠️ Warning:** This plugin is experimental in UE 5.5-5.7. Expect API changes in future versions.

---

<!-- 核心概念 -->
## Core Concepts

<!-- 中文翻译 -->
### 1. **Camera Rig**
- Defines camera configuration (position, rotation, FOV, etc.)
- Modular node graph (similar to Material Editor)

<!-- 中文翻译 -->
### 2. **Camera Director**
- Manages which camera rig is active
- Handles blending between camera rigs

<!-- 中文翻译 -->
### 3. **Camera Nodes**
- Building blocks for camera behavior:
  - **Position Nodes**: Orbit, Follow, Fixed Position
  - **Rotation Nodes**: Look At, Match Actor Rotation
  - **Modifiers**: Camera Shake, Lag, Offset

---

<!-- 设置 -->
## Setup

<!-- 中文翻译 -->
### 1. Enable Plugin

`Edit > Plugins > Gameplay Cameras > Enabled > Restart`

<!-- 中文翻译 -->
### 2. Add Camera Component

```cpp
#include "GameplayCameras/Public/GameplayCameraComponent.h"

UCLASS()
class AMyCharacter : public ACharacter {
    GENERATED_BODY()

public:
    AMyCharacter() {
        // Create camera component
        CameraComponent = CreateDefaultSubobject<UGameplayCameraComponent>(TEXT("GameplayCamera"));
        CameraComponent->SetupAttachment(RootComponent);
    }

protected:
    UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "Camera")
    TObjectPtr<UGameplayCameraComponent> CameraComponent;
};
```

---

<!-- 中文翻译 -->
## Create Camera Rig

<!-- 中文翻译 -->
### 1. Create Camera Rig Asset

1. Content Browser > Gameplay > Gameplay Camera Rig
2. Open Camera Rig Editor (node-based graph)

<!-- 中文翻译 -->
### 2. Build Camera Rig (Example: Third Person)

**Node Setup:**
```
Actor Position (Character)
  ↓
Orbit Node (Orbit around character)
  ↓
Offset Node (Shoulder offset)
  ↓
Look At Node (Look at character)
  ↓
Camera Output
```

---

<!-- 中文翻译 -->
## Camera Nodes

<!-- 中文翻译 -->
### Position Nodes

<!-- 中文翻译 -->
#### Orbit Node (Third Person)
- Orbits around target actor
- Configure:
  - **Orbit Distance**: Distance from target (e.g., 300 units)
  - **Pitch Range**: Min/Max pitch angles
  - **Yaw Range**: Min/Max yaw angles

<!-- 中文翻译 -->
#### Follow Node (Smooth Follow)
- Follows target with lag
- Configure:
  - **Lag Speed**: How quickly camera catches up
  - **Offset**: Fixed offset from target

<!-- 中文翻译 -->
#### Fixed Position Node
- Static camera position in world space

---

<!-- 中文翻译 -->
### Rotation Nodes

<!-- 中文翻译 -->
#### Look At Node
- Points camera at target
- Configure:
  - **Target**: Actor or component to look at
  - **Offset**: Look-at offset (e.g., aim at head instead of feet)

<!-- 中文翻译 -->
#### Match Actor Rotation
- Matches target actor's rotation
- Useful for first-person or vehicle cameras

---

<!-- 中文翻译 -->
### Modifier Nodes

<!-- 中文翻译 -->
#### Camera Shake
- Adds procedural shake (e.g., footsteps, explosions)
- Configure:
  - **Shake Pattern**: Perlin noise, sine wave, custom
  - **Amplitude**: Shake strength

<!-- 中文翻译 -->
#### Camera Lag
- Smooth dampening of camera movement
- Configure:
  - **Lag Speed**: Damping factor (0 = instant, higher = more lag)

<!-- 中文翻译 -->
#### Offset Node
- Static offset from calculated position
- Useful for shoulder camera offset

---

<!-- 中文翻译 -->
## Camera Director (Switching Between Rigs)

<!-- 中文翻译 -->
### Assign Camera Rig

```cpp
#include "GameplayCameras/Public/GameplayCameraComponent.h"

void AMyCharacter::SetCameraMode(UGameplayCameraRig* NewRig) {
    if (CameraComponent) {
        CameraComponent->SetCameraRig(NewRig);
    }
}
```

<!-- 中文翻译 -->
### Blend Between Camera Rigs

```cpp
// Blend to aiming camera over 0.5 seconds
CameraComponent->BlendToCameraRig(AimingCameraRig, 0.5f);
```

---

<!-- 中文翻译 -->
## Example: Third Person + Aiming

<!-- 中文翻译 -->
### 1. Create Two Camera Rigs

**Third Person Rig:**
```
Actor Position → Orbit (distance: 300) → Look At → Output
```

**Aiming Rig:**
```
Actor Position → Orbit (distance: 150) → Offset (shoulder) → Look At → Output
```

<!-- 中文翻译 -->
### 2. Switch on Aim

```cpp
UPROPERTY(EditAnywhere, Category = "Camera")
TObjectPtr<UGameplayCameraRig> ThirdPersonRig;

UPROPERTY(EditAnywhere, Category = "Camera")
TObjectPtr<UGameplayCameraRig> AimingRig;

void StartAiming() {
    CameraComponent->BlendToCameraRig(AimingRig, 0.3f); // Blend over 0.3s
}

void StopAiming() {
    CameraComponent->BlendToCameraRig(ThirdPersonRig, 0.3f);
}
```

---

<!-- 常见模式 -->
## Common Patterns

<!-- 中文翻译 -->
### Over-the-Shoulder Camera

```
Actor Position
  ↓
Orbit Node (distance: 250, yaw offset: 30°)
  ↓
Offset Node (X: 0, Y: 50, Z: 50) // Shoulder offset
  ↓
Look At Node (target: Character head)
  ↓
Output
```

---

<!-- 中文翻译 -->
### Vehicle Camera

```
Vehicle Position
  ↓
Follow Node (lag: 0.2)
  ↓
Offset Node (behind vehicle: X: -400, Z: 150)
  ↓
Look At Node (target: Vehicle)
  ↓
Output
```

---

<!-- 中文翻译 -->
### First Person Camera

```
Character Head Socket
  ↓
Match Actor Rotation
  ↓
Output
```

---

<!-- 中文翻译 -->
## Camera Shake

<!-- 中文翻译 -->
### Trigger Camera Shake

```cpp
#include "GameplayCameras/Public/GameplayCameraShake.h"

void TriggerExplosionShake() {
    if (APlayerController* PC = GetWorld()->GetFirstPlayerController()) {
        if (UGameplayCameraComponent* CameraComp = PC->FindComponentByClass<UGameplayCameraComponent>()) {
            CameraComp->PlayCameraShake(ExplosionShakeClass, 1.0f);
        }
    }
}
```

---

<!-- 性能提示 -->
## Performance Tips

- Limit camera shake frequency (don't trigger every frame)
- Use camera lag sparingly (expensive for high lag values)
- Cache camera rig references (don't search every frame)

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### Camera Debug Visualization

```cpp
// Console commands:
// GameplayCameras.Debug 1 - Show active camera rig info
// showdebug camera - Show camera debug info
```

---

<!-- 中文翻译 -->
## Migration from Legacy Cameras

<!-- 中文翻译 -->
### Old Spring Arm + Camera Component

```cpp
// ❌ OLD: Spring Arm Component
USpringArmComponent* SpringArm;
UCameraComponent* Camera;

// ✅ NEW: Gameplay Camera Component
UGameplayCameraComponent* CameraComponent;
// Build orbit + look-at rig in Camera Rig asset
```

---

<!-- 中文翻译 -->
## Limitations (Experimental Status)

- **API Instability**: Expect breaking changes in UE 5.8+
- **Limited Documentation**: Official docs still evolving
- **Blueprint Support**: Primarily C++ focused (Blueprint support improving)
- **Production Risk**: Test thoroughly before shipping

---

<!-- 来源 -->
## Sources
- https://docs.unrealengine.com/5.7/en-US/gameplay-cameras-in-unreal-engine/
- UE 5.5+ Release Notes
- **Note:** This system is experimental. Always check latest official docs for API changes.
