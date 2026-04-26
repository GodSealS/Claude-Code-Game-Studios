# Unreal Engine 5.7 — Audio Module Reference / Unreal Engine音频模块


> **中文翻译**：本文档为Unreal Engine引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Knowledge Gap:** UE 5.7 MetaSounds production-ready

---

<!-- 概述 -->
## Overview

UE 5.7 audio systems:
- **MetaSounds**: Node-based procedural audio (RECOMMENDED, production-ready)
- **Sound Cues**: Legacy node-based audio (use for simple cases)
- **Audio Component**: Play sounds on actors

---

<!-- 中文翻译 -->
## Basic Audio Playback

<!-- 中文翻译 -->
### Play Sound at Location

```cpp
#include "Kismet/GameplayStatics.h"

// ✅ Play 2D sound (no spatialization)
UGameplayStatics::PlaySound2D(GetWorld(), ExplosionSound);

// ✅ Play sound at location (3D spatial audio)
UGameplayStatics::PlaySoundAtLocation(GetWorld(), ExplosionSound, GetActorLocation());

// ✅ With volume and pitch
UGameplayStatics::PlaySoundAtLocation(GetWorld(), ExplosionSound, GetActorLocation(), 0.7f, 1.2f);
```

---

<!-- 中文翻译 -->
## Audio Component

<!-- 中文翻译 -->
### Audio Component (Persistent Sound)

```cpp
// Create audio component
UAudioComponent* AudioComp = CreateDefaultSubobject<UAudioComponent>(TEXT("Audio"));
AudioComp->SetupAttachment(RootComponent);
AudioComp->SetSound(LoopingAmbience);

// Play/Stop
AudioComp->Play();
AudioComp->Stop();

// Fade in/out
AudioComp->FadeIn(2.0f); // 2 seconds
AudioComp->FadeOut(1.5f, 0.0f); // 1.5s to volume 0

// Adjust volume/pitch
AudioComp->SetVolumeMultiplier(0.5f);
AudioComp->SetPitchMultiplier(1.2f);
```

---

<!-- 中文翻译 -->
## 3D Spatial Audio

<!-- 中文翻译 -->
### Attenuation Settings

```cpp
// Create Sound Attenuation asset:
// Content Browser > Sounds > Sound Attenuation

// Configure:
// - Attenuation Shape: Sphere, Capsule, Box, Cone
// - Falloff Distance: Distance where sound becomes inaudible
// - Attenuation Function: Linear, Logarithmic, Inverse, etc.

// Assign in C++:
AudioComp->AttenuationSettings = AttenuationAsset;
```

<!-- 中文翻译 -->
### Attenuation Override in Code

```cpp
FSoundAttenuationSettings AttenuationOverride;
AttenuationOverride.AttenuationShape = EAttenuationShape::Sphere;
AttenuationOverride.FalloffDistance = 1000.0f;
AttenuationOverride.AttenuationShapeExtents = FVector(1000.0f);

AudioComp->AttenuationOverrides = AttenuationOverride;
AudioComp->bOverrideAttenuation = true;
```

---

<!-- 中文翻译 -->
## MetaSounds (Procedural Audio)

<!-- 中文翻译 -->
### Create MetaSound Source

1. Content Browser > Sounds > MetaSound Source
2. Open MetaSound editor
3. Build node graph:
   - **Inputs**: Triggers, parameters
   - **Generators**: Oscillators, noise, samples
   - **Modulators**: Envelopes, LFOs
   - **Effects**: Filters, reverb, delay
   - **Output**: Audio output

<!-- 中文翻译 -->
### Play MetaSound

```cpp
// Play MetaSound like any sound
UGameplayStatics::PlaySound2D(GetWorld(), MetaSoundSource);

// Or with Audio Component
AudioComp->SetSound(MetaSoundSource);
AudioComp->Play();
```

<!-- 中文翻译 -->
### Set MetaSound Parameters

```cpp
// Define parameter in MetaSound (Input node with exposed parameter)
// Set parameter in C++:
AudioComp->SetFloatParameter(FName("Volume"), 0.8f);
AudioComp->SetIntParameter(FName("OctaveShift"), 2);
AudioComp->SetBoolParameter(FName("EnableReverb"), true);
```

---

<!-- 中文翻译 -->
## Sound Cues (Legacy)

<!-- 中文翻译 -->
### Create Sound Cue

1. Content Browser > Sounds > Sound Cue
2. Open Sound Cue editor
3. Add nodes: Random, Modulator, Mixer, etc.

<!-- 中文翻译 -->
### Use Sound Cue

```cpp
// Play like any sound
UGameplayStatics::PlaySound2D(GetWorld(), SoundCue);
```

---

<!-- 中文翻译 -->
## Sound Classes & Sound Mixes

<!-- 中文翻译 -->
### Sound Class (Volume Groups)

```cpp
// Create Sound Class: Content Browser > Sounds > Sound Class
// Hierarchy: Master > Music, SFX, Dialogue

// Assign to sound asset:
// Sound Wave > Sound Class = SFX

// Set volume in C++:
UAudioSettings* AudioSettings = GetMutableDefault<UAudioSettings>();
// Configure via Sound Class hierarchy
```

<!-- 中文翻译 -->
### Sound Mix (Dynamic Mixing)

```cpp
// Create Sound Mix asset
// Define adjustments: Lower music during dialogue, etc.

// Push sound mix
UGameplayStatics::PushSoundMixModifier(GetWorld(), DuckedMusicMix);

// Pop sound mix
UGameplayStatics::PopSoundMixModifier(GetWorld(), DuckedMusicMix);
```

---

<!-- 中文翻译 -->
## Audio Occlusion & Reverb

<!-- 中文翻译 -->
### Audio Occlusion (Walls Block Sound)

```cpp
// Enable in Audio Component:
AudioComp->bEnableOcclusion = true;

// Requires geometry with collision
```

<!-- 中文翻译 -->
### Reverb Volumes

```cpp
// Add Audio Volume to level (Volumes > Audio Volume)
// Configure reverb settings in Details panel
// Audio component automatically picks up reverb when inside volume
```

---

<!-- 常见模式 -->
## Common Patterns

<!-- 中文翻译 -->
### Footstep Sounds (Random Variation)

```cpp
// Use Sound Cue with Random node, or:
UPROPERTY(EditAnywhere, Category = "Audio")
TArray<TObjectPtr<USoundBase>> FootstepSounds;

void PlayFootstep() {
    int32 Index = FMath::RandRange(0, FootstepSounds.Num() - 1);
    UGameplayStatics::PlaySoundAtLocation(GetWorld(), FootstepSounds[Index], GetActorLocation());
}
```

<!-- 中文翻译 -->
### Music Crossfade

```cpp
UAudioComponent* MusicA;
UAudioComponent* MusicB;

void CrossfadeMusic(float Duration) {
    MusicA->FadeOut(Duration, 0.0f);
    MusicB->FadeIn(Duration);
}
```

<!-- 中文翻译 -->
### Check if Sound is Playing

```cpp
if (AudioComp->IsPlaying()) {
    // Sound is playing
}
```

---

<!-- 中文翻译 -->
## Audio Concurrency

<!-- 中文翻译 -->
### Limit Concurrent Sounds

```cpp
// Create Sound Concurrency asset:
// Content Browser > Sounds > Sound Concurrency

// Configure:
// - Max Count: Maximum instances of this sound
// - Resolution Rule: Stop Oldest, Stop Quietest, etc.

// Assign to sound:
// Sound Wave > Concurrency Settings
```

---

<!-- 性能提示 -->
## Performance Tips

<!-- 中文翻译 -->
### Audio Optimization

```cpp
// Compression settings (Sound Wave asset):
// - Compression Quality: 40 (balance quality/size)
// - Streaming: Enable for large files (music)

// Reduce audio mixing cost:
// - Limit concurrent sounds via Sound Concurrency
// - Use simple attenuation shapes

// Disable audio for distant actors:
if (Distance > MaxAudibleDistance) {
    AudioComp->Stop();
}
```

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### Audio Debug Commands

```cpp
// Console commands:
// au.Debug.Sounds 1 - Show active sounds
// au.3dVisualize.Enabled 1 - Visualize 3D audio
// stat soundwaves - Show sound statistics
// stat soundmixes - Show active sound mixes
```

---

<!-- 来源 -->
## Sources
- https://docs.unrealengine.com/5.7/en-US/audio-in-unreal-engine/
- https://docs.unrealengine.com/5.7/en-US/metasounds-in-unreal-engine/
