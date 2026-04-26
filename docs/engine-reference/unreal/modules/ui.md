# Unreal Engine 5.7 — UI Module Reference / Unreal EngineUI模块


> **中文翻译**：本文档为Unreal Engine引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Knowledge Gap:** UE 5.7 UMG and CommonUI improvements

---

<!-- 概述 -->
## Overview

UE 5.7 UI systems:
- **UMG (Unreal Motion Graphics)**: Visual widget-based UI (RECOMMENDED)
- **CommonUI**: Cross-platform input-aware UI framework (console/PC)
- **Slate**: Low-level C++ UI (engine/editor UI)

---

<!-- 中文翻译 -->
## UMG (Unreal Motion Graphics)

<!-- 中文翻译 -->
### Create Widget Blueprint

1. Content Browser > User Interface > Widget Blueprint
2. Open Widget Designer
3. Drag widgets from Palette: Button, Text, Image, ProgressBar, etc.

---

<!-- 中文翻译 -->
## Basic UMG Setup in C++

<!-- 中文翻译 -->
### Create and Display Widget

```cpp
#include "Blueprint/UserWidget.h"

UPROPERTY(EditAnywhere, Category = "UI")
TSubclassOf<UUserWidget> HealthBarWidgetClass;

void AMyCharacter::BeginPlay() {
    Super::BeginPlay();

    // Create widget
    UUserWidget* HealthBarWidget = CreateWidget<UUserWidget>(GetWorld(), HealthBarWidgetClass);

    // Add to viewport
    HealthBarWidget->AddToViewport();
}
```

<!-- 中文翻译 -->
### Remove Widget

```cpp
HealthBarWidget->RemoveFromParent();
```

---

<!-- 中文翻译 -->
## Access Widget Elements from C++

<!-- 中文翻译 -->
### Bind to Widget Elements

```cpp
UCLASS()
class UMyHealthWidget : public UUserWidget {
    GENERATED_BODY()

public:
    // ✅ Bind to widget elements (must match names in Widget Blueprint)
    UPROPERTY(meta = (BindWidget))
    TObjectPtr<UTextBlock> HealthText;

    UPROPERTY(meta = (BindWidget))
    TObjectPtr<UProgressBar> HealthBar;

    void UpdateHealth(int32 CurrentHealth, int32 MaxHealth) {
        HealthText->SetText(FText::FromString(FString::Printf(TEXT("%d / %d"), CurrentHealth, MaxHealth)));
        HealthBar->SetPercent((float)CurrentHealth / MaxHealth);
    }
};
```

---

<!-- 中文翻译 -->
## Common UMG Widgets

<!-- 中文翻译 -->
### Text Block

```cpp
UPROPERTY(meta = (BindWidget))
TObjectPtr<UTextBlock> ScoreText;

ScoreText->SetText(FText::FromString(TEXT("Score: 100")));
ScoreText->SetColorAndOpacity(FLinearColor::Green);
```

<!-- 中文翻译 -->
### Button

```cpp
UPROPERTY(meta = (BindWidget))
TObjectPtr<UButton> PlayButton;

void NativeConstruct() override {
    Super::NativeConstruct();

    // Bind button click
    PlayButton->OnClicked.AddDynamic(this, &UMyMenuWidget::OnPlayClicked);
}

UFUNCTION()
void OnPlayClicked() {
    UE_LOG(LogTemp, Warning, TEXT("Play clicked"));
}
```

<!-- 中文翻译 -->
### Image

```cpp
UPROPERTY(meta = (BindWidget))
TObjectPtr<UImage> PlayerAvatar;

PlayerAvatar->SetBrushFromTexture(AvatarTexture);
PlayerAvatar->SetColorAndOpacity(FLinearColor::White);
```

<!-- 中文翻译 -->
### Progress Bar

```cpp
UPROPERTY(meta = (BindWidget))
TObjectPtr<UProgressBar> HealthBar;

HealthBar->SetPercent(0.75f); // 75%
HealthBar->SetFillColorAndOpacity(FLinearColor::Red);
```

<!-- 中文翻译 -->
### Slider

```cpp
UPROPERTY(meta = (BindWidget))
TObjectPtr<USlider> VolumeSlider;

void NativeConstruct() override {
    Super::NativeConstruct();
    VolumeSlider->OnValueChanged.AddDynamic(this, &UMyWidget::OnVolumeChanged);
}

UFUNCTION()
void OnVolumeChanged(float Value) {
    // Value is 0.0 - 1.0
    UE_LOG(LogTemp, Warning, TEXT("Volume: %f"), Value);
}
```

<!-- 中文翻译 -->
### EditableTextBox (Input Field)

```cpp
UPROPERTY(meta = (BindWidget))
TObjectPtr<UEditableTextBox> PlayerNameInput;

void NativeConstruct() override {
    Super::NativeConstruct();
    PlayerNameInput->OnTextChanged.AddDynamic(this, &UMyWidget::OnNameChanged);
}

UFUNCTION()
void OnNameChanged(const FText& Text) {
    FString PlayerName = Text.ToString();
}
```

---

<!-- 中文翻译 -->
## UMG Animations

<!-- 中文翻译 -->
### Play Animation

```cpp
UPROPERTY(Transient, meta = (BindWidgetAnim))
TObjectPtr<UWidgetAnimation> FadeInAnimation;

void ShowUI() {
    PlayAnimation(FadeInAnimation);
}
```

<!-- 中文翻译 -->
### Stop Animation

```cpp
StopAnimation(FadeInAnimation);
```

---

<!-- 中文翻译 -->
## Canvas Panel (Layout)

<!-- 中文翻译 -->
### Canvas Panel (Absolute Positioning)

```cpp
// Use in Widget Blueprint for absolute positioning
// Anchor widgets to corners/edges for responsive UI
```

<!-- 中文翻译 -->
### Vertical Box (Stack Vertically)

```cpp
// Auto-stacks children vertically
```

<!-- 中文翻译 -->
### Horizontal Box (Stack Horizontally)

```cpp
// Auto-stacks children horizontally
```

<!-- 中文翻译 -->
### Grid Panel (Grid Layout)

```cpp
// Arranges children in a grid
```

---

<!-- 中文翻译 -->
## World Space UI (3D UI)

<!-- 中文翻译 -->
### Widget Component (3D UI in World)

```cpp
#include "Components/WidgetComponent.h"

UWidgetComponent* HealthBarWidget = CreateDefaultSubobject<UWidgetComponent>(TEXT("HealthBar"));
HealthBarWidget->SetupAttachment(RootComponent);
HealthBarWidget->SetWidgetClass(HealthBarWidgetClass);
HealthBarWidget->SetWidgetSpace(EWidgetSpace::World); // 3D world space
HealthBarWidget->SetDrawSize(FVector2D(200, 50));
```

---

<!-- 中文翻译 -->
## Input Handling in UMG

<!-- 中文翻译 -->
### Override Keyboard Input

```cpp
UCLASS()
class UMyWidget : public UUserWidget {
    GENERATED_BODY()

public:
    virtual FReply NativeOnKeyDown(const FGeometry& InGeometry, const FKeyEvent& InKeyEvent) override {
        if (InKeyEvent.GetKey() == EKeys::Escape) {
            // Handle Escape key
            CloseMenu();
            return FReply::Handled();
        }
        return Super::NativeOnKeyDown(InGeometry, InKeyEvent);
    }
};
```

---

<!-- 中文翻译 -->
## CommonUI (Cross-Platform Input)

<!-- 中文翻译 -->
### Enable CommonUI Plugin

```cpp
// Enable: Edit > Plugins > CommonUI
// Restart editor
```

<!-- 中文翻译 -->
### Use CommonUI Widgets

```cpp
// CommonUI widgets:
// - CommonActivatableWidget: Base for screens/menus
// - CommonButtonBase: Input-aware button (gamepad + mouse)
// - CommonTextBlock: Text with styling
```

<!-- 中文翻译 -->
### CommonActivatableWidget Example

```cpp
UCLASS()
class UMyMenuWidget : public UCommonActivatableWidget {
    GENERATED_BODY()

public:
    virtual void NativeOnActivated() override {
        Super::NativeOnActivated();
        // Menu activated (shown)
    }

    virtual void NativeOnDeactivated() override {
        Super::NativeOnDeactivated();
        // Menu deactivated (hidden)
    }
};
```

---

<!-- 中文翻译 -->
## HUD Class (Alternative to UMG)

<!-- 中文翻译 -->
### Create HUD

```cpp
UCLASS()
class AMyHUD : public AHUD {
    GENERATED_BODY()

public:
    virtual void DrawHUD() override {
        Super::DrawHUD();

        // Draw text
        DrawText(TEXT("Score: 100"), FLinearColor::White, 50, 50);

        // Draw texture
        DrawTexture(CrosshairTexture, Canvas->SizeX / 2, Canvas->SizeY / 2, 32, 32);
    }
};
```

---

<!-- 性能提示 -->
## Performance Tips

<!-- 中文翻译 -->
### Optimize UMG

```cpp
// Invalidation boxes: Only redraw when content changes
// Add "Invalidation Box" widget to Widget Blueprint

// Disable tick if not needed
bIsFocusable = false;
SetVisibility(ESlateVisibility::Collapsed); // Collapsed = not rendered
```

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### UI Debug Commands

```cpp
// Console commands:
// widget.debug - Show widget hierarchy
// Slate.ShowDebugOutlines 1 - Show widget bounds
// stat slate - Show Slate performance
```

---

<!-- 来源 -->
## Sources
- https://docs.unrealengine.com/5.7/en-US/umg-ui-designer-for-unreal-engine/
- https://docs.unrealengine.com/5.7/en-US/commonui-plugin-for-advanced-user-interfaces-in-unreal-engine/
