# Unreal Engine 5.7 — Rendering Module Reference / Unreal Engine渲染模块


> **中文翻译**：本文档为Unreal Engine引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Knowledge Gap:** UE 5.7 has Megalights, production-ready Substrate, and Lumen improvements

---

<!-- 概述 -->
## Overview

UE 5.7 rendering stack:
- **Lumen**: Real-time global illumination (default)
- **Nanite**: Virtualized geometry for millions of triangles
- **Megalights**: Support for millions of dynamic lights (NEW in 5.5+)
- **Substrate**: Production-ready modular material system (NEW in 5.7)

---

<!-- 中文翻译 -->
## Lumen (Global Illumination)

<!-- 中文翻译 -->
### Enable Lumen

```cpp
// Project Settings > Engine > Rendering > Dynamic Global Illumination Method = Lumen
// Real-time GI, no lightmap baking needed
```

<!-- 中文翻译 -->
### Lumen Quality Settings

```ini
; DefaultEngine.ini
[/Script/Engine.RendererSettings]
r.Lumen.DiffuseColorBoost=1.0
r.Lumen.ScreenProbeGather.RadianceCache.NumFramesToKeepCached=2
```

<!-- 中文翻译 -->
### Lumen in C++

```cpp
// Check if Lumen is enabled
bool bIsLumenEnabled = IConsoleManager::Get().FindConsoleVariable(TEXT("r.DynamicGlobalIlluminationMethod"))->GetInt() == 1;
```

---

<!-- 中文翻译 -->
## Nanite (Virtualized Geometry)

<!-- 中文翻译 -->
### Enable Nanite on Static Mesh

1. Static Mesh Editor
2. Details > Nanite Settings > Enable Nanite Support
3. Save mesh (auto-builds Nanite data)

<!-- 中文翻译 -->
### Nanite in C++

```cpp
// Spawn Nanite mesh
UStaticMeshComponent* MeshComp = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("Mesh"));
MeshComp->SetStaticMesh(NaniteMesh); // Automatically uses Nanite if enabled
```

<!-- 中文翻译 -->
### Nanite Limitations
- No vertex animation (skeletal meshes)
- No world position offset (WPO) in materials
- Best for static, high-poly geometry

---

<!-- 中文翻译 -->
## Megalights (UE 5.5+)

<!-- 中文翻译 -->
### Enable Megalights

```cpp
// Project Settings > Engine > Rendering > Megalights = Enabled
// Supports millions of dynamic lights with minimal performance cost
```

<!-- 中文翻译 -->
### Megalights Usage

```cpp
// Add point lights as usual
UPointLightComponent* Light = CreateDefaultSubobject<UPointLightComponent>(TEXT("Light"));
Light->SetIntensity(5000.0f);
Light->SetAttenuationRadius(500.0f);

// Megalights automatically handles thousands/millions of these
```

---

<!-- 中文翻译 -->
## Substrate Materials (Production-Ready in 5.7)

<!-- 中文翻译 -->
### Enable Substrate

```cpp
// Project Settings > Engine > Substrate > Enable Substrate
// Restart editor
```

<!-- 中文翻译 -->
### Substrate Material Nodes
- **Substrate Slab**: Physical material layer (diffuse, specular, etc.)
- **Substrate Blend**: Blend multiple layers
- **Substrate Thin Film**: Iridescence, soap bubbles
- **Substrate Hair**: Hair-specific shading

<!-- 中文翻译 -->
### Example Substrate Material Graph

```
Substrate Slab (Diffuse)
  └─ Base Color: Texture Sample
  └─ Roughness: Constant (0.5)
  └─ Metallic: Constant (0.0)
  └─ Connect to Material Output
```

---

<!-- 中文翻译 -->
## Materials (C++ API)

<!-- 中文翻译 -->
### Dynamic Material Instances

```cpp
// Create dynamic material instance
UMaterialInstanceDynamic* DynMat = UMaterialInstanceDynamic::Create(BaseMaterial, this);

// Set parameters
DynMat->SetVectorParameterValue(TEXT("BaseColor"), FLinearColor::Red);
DynMat->SetScalarParameterValue(TEXT("Metallic"), 0.8f);
DynMat->SetTextureParameterValue(TEXT("DiffuseTexture"), MyTexture);

// Apply to mesh
MeshComp->SetMaterial(0, DynMat);
```

---

<!-- 后处理 -->
## Post-Processing

<!-- 中文翻译 -->
### Post-Process Volume

```cpp
// Add to level
APostProcessVolume* PPV = GetWorld()->SpawnActor<APostProcessVolume>();
PPV->bUnbound = true; // Affect entire world

// Configure settings
PPV->Settings.bOverride_MotionBlurAmount = true;
PPV->Settings.MotionBlurAmount = 0.5f;

PPV->Settings.bOverride_BloomIntensity = true;
PPV->Settings.BloomIntensity = 1.0f;
```

<!-- 中文翻译 -->
### Post-Process in C++

```cpp
// Access camera post-process settings
APlayerController* PC = GetWorld()->GetFirstPlayerController();
if (APlayerCameraManager* CamManager = PC->PlayerCameraManager) {
    CamManager->PostProcessBlendWeight = 1.0f;
    CamManager->PostProcessSettings.BloomIntensity = 2.0f;
}
```

---

<!-- 中文翻译 -->
## Lighting

<!-- 中文翻译 -->
### Directional Light (Sun)

```cpp
ADirectionalLight* Sun = GetWorld()->SpawnActor<ADirectionalLight>();
Sun->SetActorRotation(FRotator(-45.f, 0.f, 0.f));
Sun->GetLightComponent()->SetIntensity(10.0f);
Sun->GetLightComponent()->bCastShadows = true;
```

<!-- 中文翻译 -->
### Point Light

```cpp
APointLight* Light = GetWorld()->SpawnActor<APointLight>();
Light->SetActorLocation(FVector(0, 0, 200));
Light->GetPointLightComponent()->SetIntensity(5000.0f);
Light->GetPointLightComponent()->SetAttenuationRadius(1000.0f);
Light->GetPointLightComponent()->SetLightColor(FLinearColor::Red);
```

<!-- 中文翻译 -->
### Spot Light

```cpp
ASpotLight* Spotlight = GetWorld()->SpawnActor<ASpotLight>();
Spotlight->GetSpotLightComponent()->SetInnerConeAngle(20.0f);
Spotlight->GetSpotLightComponent()->SetOuterConeAngle(40.0f);
```

---

<!-- 中文翻译 -->
## Render Targets (Render to Texture)

<!-- 中文翻译 -->
### Create Render Target

```cpp
// Create render target asset (2D texture)
UTextureRenderTarget2D* RenderTarget = NewObject<UTextureRenderTarget2D>();
RenderTarget->InitAutoFormat(512, 512); // 512x512 resolution
RenderTarget->UpdateResourceImmediate();

// Render scene to texture
UKismetRenderingLibrary::DrawMaterialToRenderTarget(
    GetWorld(),
    RenderTarget,
    MaterialToDraw
);
```

---

<!-- 中文翻译 -->
## Custom Render Passes (Advanced)

<!-- 中文翻译 -->
### Render Dependency Graph (RDG)

```cpp
// UE5 uses Render Dependency Graph for custom rendering
// Example: Custom post-process pass

#include "RenderGraphBuilder.h"

void RenderCustomPass(FRDGBuilder& GraphBuilder, const FViewInfo& View) {
    FRDGTextureRef SceneColor = /* Get scene color texture */;

    // Define pass parameters
    struct FPassParameters {
        FRDGTextureRef InputTexture;
    };

    FPassParameters* PassParams = GraphBuilder.AllocParameters<FPassParameters>();
    PassParams->InputTexture = SceneColor;

    // Add render pass
    GraphBuilder.AddPass(
        RDG_EVENT_NAME("CustomPass"),
        PassParams,
        ERDGPassFlags::Raster,
        [](FRHICommandList& RHICmdList, const FPassParameters* Params) {
            // Render commands
        }
    );
}
```

---

<!-- 性能 -->
## Performance

<!-- 中文翻译 -->
### Render Stats

```cpp
// Console commands for profiling:
// stat fps - Show FPS
// stat unit - Show frame time breakdown
// stat gpu - Show GPU timings
// profilegpu - Detailed GPU profile
```

<!-- 中文翻译 -->
### Scalability Settings

```cpp
// Get current scalability settings
UGameUserSettings* Settings = UGameUserSettings::GetGameUserSettings();
int32 ViewDistanceQuality = Settings->GetViewDistanceQuality(); // 0-4

// Set scalability
Settings->SetViewDistanceQuality(3); // High
Settings->SetShadowQuality(2); // Medium
Settings->ApplySettings(false);
```

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### Visualize Render Features

```
Console commands:
- r.Lumen.Visualize 1 - Show Lumen debug
- r.Nanite.Visualize 1 - Show Nanite triangles
- viewmode wireframe - Wireframe mode
- viewmode unlit - Disable lighting
- show collision - Show collision meshes
```

---

<!-- 来源 -->
## Sources
- https://docs.unrealengine.com/5.7/en-US/lumen-global-illumination-and-reflections-in-unreal-engine/
- https://docs.unrealengine.com/5.7/en-US/nanite-virtualized-geometry-in-unreal-engine/
- https://docs.unrealengine.com/5.7/en-US/substrate-materials-in-unreal-engine/
