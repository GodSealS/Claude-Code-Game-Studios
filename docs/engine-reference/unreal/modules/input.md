# Unreal Engine 5.7 — Input Module Reference / Unreal Engine输入模块


> **中文翻译**：本文档为Unreal Engine引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Knowledge Gap:** UE 5.7 uses Enhanced Input as default (legacy input deprecated)

---

<!-- 概述 -->
## Overview

UE 5.7 input systems:
- **Enhanced Input** (RECOMMENDED, default in UE5): Modular, rebindable, context-based
- **Legacy Input**: Deprecated, avoid for new projects

---

<!-- 中文翻译 -->
## Enhanced Input System

<!-- 中文翻译 -->
### Setup Enhanced Input

1. **Enable Plugin**: `Edit > Plugins > Enhanced Input` (enabled by default in UE5)
2. **Project Settings**: `Engine > Input > Default Classes > Default Player Input Class = EnhancedPlayerInput`

---

<!-- 中文翻译 -->
### Create Input Actions

1. Content Browser > Input > Input Action
2. Name it (e.g., `IA_Jump`, `IA_Move`)
3. Configure:
   - **Value Type**: Digital (bool), Axis1D (float), Axis2D (Vector2D), Axis3D (Vector)

Example Input Actions:
- `IA_Jump`: Digital (bool)
- `IA_Move`: Axis2D (Vector2D)
- `IA_Look`: Axis2D (Vector2D)
- `IA_Fire`: Digital (bool)

---

<!-- 中文翻译 -->
### Create Input Mapping Context

1. Content Browser > Input > Input Mapping Context
2. Name it (e.g., `IMC_Default`)
3. Add mappings:
   - `IA_Jump` → Space Bar
   - `IA_Move` → W/A/S/D keys (combine X/Y)
   - `IA_Look` → Mouse XY
   - `IA_Fire` → Left Mouse Button

---

<!-- 中文翻译 -->
### Bind Input in C++

```cpp
#include "EnhancedInputComponent.h"
#include "EnhancedInputSubsystems.h"
#include "InputActionValue.h"

class AMyCharacter : public ACharacter {
public:
    // Input Actions (assign in Blueprint)
    UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Input")
    TObjectPtr<UInputAction> MoveAction;

    UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Input")
    TObjectPtr<UInputAction> LookAction;

    UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Input")
    TObjectPtr<UInputAction> JumpAction;

    UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Input")
    TObjectPtr<UInputMappingContext> DefaultMappingContext;

protected:
    virtual void BeginPlay() override {
        Super::BeginPlay();

        // Add Input Mapping Context
        if (APlayerController* PC = Cast<APlayerController>(Controller)) {
            if (UEnhancedInputLocalPlayerSubsystem* Subsystem =
                ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>(PC->GetLocalPlayer())) {
                Subsystem->AddMappingContext(DefaultMappingContext, 0);
            }
        }
    }

    virtual void SetupPlayerInputComponent(UInputComponent* PlayerInputComponent) override {
        Super::SetupPlayerInputComponent(PlayerInputComponent);

        UEnhancedInputComponent* EIC = Cast<UEnhancedInputComponent>(PlayerInputComponent);
        if (EIC) {
            // Bind actions
            EIC->BindAction(JumpAction, ETriggerEvent::Started, this, &ACharacter::Jump);
            EIC->BindAction(JumpAction, ETriggerEvent::Completed, this, &ACharacter::StopJumping);

            EIC->BindAction(MoveAction, ETriggerEvent::Triggered, this, &AMyCharacter::Move);
            EIC->BindAction(LookAction, ETriggerEvent::Triggered, this, &AMyCharacter::Look);
        }
    }

    void Move(const FInputActionValue& Value) {
        FVector2D MoveVector = Value.Get<FVector2D>();

        if (Controller) {
            AddMovementInput(GetActorForwardVector(), MoveVector.Y);
            AddMovementInput(GetActorRightVector(), MoveVector.X);
        }
    }

    void Look(const FInputActionValue& Value) {
        FVector2D LookVector = Value.Get<FVector2D>();

        if (Controller) {
            AddControllerYawInput(LookVector.X);
            AddControllerPitchInput(LookVector.Y);
        }
    }
};
```

---

<!-- 中文翻译 -->
## Input Triggers

<!-- 中文翻译 -->
### Trigger Types

Input Actions can have triggers to control when they fire:
- **Pressed**: When input starts
- **Released**: When input ends
- **Hold**: Hold for duration
- **Tap**: Quick press
- **Pulse**: Repeated firing while held

<!-- 中文翻译 -->
### Add Trigger in Editor

1. Open Input Action asset
2. Triggers > Add > Select trigger type (e.g., `Hold`)
3. Configure (e.g., Hold Time = 0.5s)

---

<!-- 中文翻译 -->
## Input Modifiers

<!-- 中文翻译 -->
### Modifier Types

Modifiers transform input values:
- **Negate**: Flip sign (-1 ↔ 1)
- **Dead Zone**: Ignore small inputs
- **Scalar**: Multiply by value
- **Smooth**: Smoothing over time

<!-- 中文翻译 -->
### Add Modifier in Editor

1. Open Input Action asset
2. Modifiers > Add > Select modifier (e.g., `Negate`)
3. Configure

---

<!-- 中文翻译 -->
## Input Mapping Contexts (Context Switching)

<!-- 中文翻译 -->
### Multiple Contexts

```cpp
// Define contexts
UPROPERTY(EditAnywhere, Category = "Input")
TObjectPtr<UInputMappingContext> DefaultContext;

UPROPERTY(EditAnywhere, Category = "Input")
TObjectPtr<UInputMappingContext> VehicleContext;

// Switch context
void EnterVehicle() {
    if (APlayerController* PC = Cast<APlayerController>(Controller)) {
        if (UEnhancedInputLocalPlayerSubsystem* Subsystem =
            ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>(PC->GetLocalPlayer())) {
            Subsystem->RemoveMappingContext(DefaultContext);
            Subsystem->AddMappingContext(VehicleContext, 0);
        }
    }
}
```

---

<!-- 中文翻译 -->
## Legacy Input (Deprecated)

<!-- 中文翻译 -->
### Legacy Input Bindings

```cpp
// ❌ DEPRECATED: Do not use for new projects

void AMyCharacter::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent) {
    // Legacy action binding
    PlayerInputComponent->BindAction("Jump", IE_Pressed, this, &ACharacter::Jump);

    // Legacy axis binding
    PlayerInputComponent->BindAxis("MoveForward", this, &AMyCharacter::MoveForward);
}

void MoveForward(float Value) {
    AddMovementInput(GetActorForwardVector(), Value);
}
```

**Migration:** Use Enhanced Input instead.

---

<!-- 中文翻译 -->
## Gamepad Input

<!-- 中文翻译 -->
### Gamepad with Enhanced Input

```cpp
// Input Mapping Context:
// - IA_Move → Gamepad Left Thumbstick
// - IA_Look → Gamepad Right Thumbstick
// - IA_Jump → Gamepad Face Button Bottom (A/Cross)

// No code changes needed, just add gamepad mappings to Input Mapping Context
```

---

<!-- 中文翻译 -->
## Touch Input (Mobile)

<!-- 中文翻译 -->
### Touch Input with Enhanced Input

```cpp
// Input Mapping Context:
// - IA_Move → Touch (virtual thumbstick)
// - IA_Look → Touch (swipe)

// Use Touch Interface asset for virtual controls
```

---

<!-- 中文翻译 -->
## Rebinding Input at Runtime

<!-- 中文翻译 -->
### Change Key Mapping

```cpp
#include "PlayerMappableInputConfig.h"

// Get subsystem
UEnhancedInputLocalPlayerSubsystem* Subsystem = /* Get subsystem */;

// Get player mappable keys
FPlayerMappableKeySlot KeySlot = FPlayerMappableKeySlot(/*..*/);
FKey NewKey = EKeys::F; // Rebind to F key

// Apply new mapping
Subsystem->AddPlayerMappedKey(/*..*/);
```

---

<!-- 中文翻译 -->
## Input Debugging

<!-- 中文翻译 -->
### Debug Input

```cpp
// Console commands:
// showdebug input - Show input debug info

// Log input values:
UE_LOG(LogTemp, Warning, TEXT("Move Input: %s"), *MoveVector.ToString());
```

---

<!-- 常见模式 -->
## Common Patterns

<!-- 中文翻译 -->
### Check if Key Pressed (Quick & Dirty)

```cpp
// For debugging only (not recommended for gameplay)
if (GetWorld()->GetFirstPlayerController()->IsInputKeyDown(EKeys::SpaceBar)) {
    // Space bar is down
}
```

---

<!-- 来源 -->
## Sources
- https://docs.unrealengine.com/5.7/en-US/enhanced-input-in-unreal-engine/
- https://docs.unrealengine.com/5.7/en-US/enhanced-input-action-and-input-mapping-context-in-unreal-engine/
