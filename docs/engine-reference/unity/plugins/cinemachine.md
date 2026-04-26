# Unity 6.3 — Cinemachine / UnityCinemachine（虚拟相机）插件


> **中文翻译**：本文档为Unity引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Status:** Production-Ready
**Package:** `com.unity.cinemachine` v3.0+ (Package Manager)

---

<!-- 概述 -->
## Overview

**Cinemachine** is Unity's virtual camera system that enables professional, dynamic camera
behavior without manual scripting. It's the industry standard for Unity camera work.

**Use Cinemachine for:**
- 3rd person follow cameras
- Cutscenes and cinematics
- Camera blending and transitions
- Dynamic camera framing
- Screen shake and camera effects

**⚠️ Knowledge Gap:** Cinemachine 3.0 (Unity 6) is a major rewrite from 2.x.
Many API names and components changed.

---

<!-- 安装 -->
## Installation

<!-- 中文翻译 -->
### Install via Package Manager

1. `Window > Package Manager`
2. Unity Registry > Search "Cinemachine"
3. Install `Cinemachine` (version 3.0+)

---

<!-- 核心概念 -->
## Core Concepts

<!-- 中文翻译 -->
### 1. **Virtual Cameras**
- Define camera behavior (position, rotation, lens)
- Multiple virtual cameras can exist; only one is "live" at a time

<!-- 中文翻译 -->
### 2. **Cinemachine Brain**
- Component on main Camera
- Blends between virtual cameras
- Applies virtual camera settings to Unity Camera

<!-- 中文翻译 -->
### 3. **Priorit**ies**
- Virtual cameras have priority values
- Highest priority camera is active
- Blends smoothly when priority changes

---

<!-- 中文翻译 -->
## Basic Setup

<!-- 中文翻译 -->
### 1. Add Cinemachine Brain to Main Camera

```csharp
// Automatically added when creating first virtual camera
// Or manually: Add Component > Cinemachine Brain
```

<!-- 中文翻译 -->
### 2. Create Virtual Camera

`GameObject > Cinemachine > Cinemachine Camera`

This creates a **CinemachineCamera** GameObject with default settings.

---

<!-- 中文翻译 -->
## Virtual Camera Components

<!-- 中文翻译 -->
### CinemachineCamera (Unity 6 / Cinemachine 3.0+)

```csharp
using Unity.Cinemachine;

public class CameraController : MonoBehaviour {
    public CinemachineCamera virtualCamera;

    void Start() {
        // Set priority (higher = active)
        virtualCamera.Priority = 10;

        // Set follow target
        virtualCamera.Follow = playerTransform;

        // Set look-at target
        virtualCamera.LookAt = playerTransform;
    }
}
```

---

<!-- 中文翻译 -->
## Follow Modes (Body Component)

<!-- 中文翻译 -->
### 3rd Person Follow (Orbital Follow)

```csharp
// In Inspector:
// CinemachineCamera > Body > 3rd Person Follow

// Configure:
// - Shoulder Offset: (0.5, 0, 0) for over-shoulder
// - Camera Distance: 5.0
// - Vertical Damping: 0.5 (smooth up/down)
```

<!-- 中文翻译 -->
### Framing Transposer (Smooth Follow)

```csharp
// CinemachineCamera > Body > Position Composer

// Configure:
// - Screen Position: Center (0.5, 0.5)
// - Dead Zone: Don't move camera if target within zone
// - Damping: Smooth following
```

<!-- 中文翻译 -->
### Hard Lock (Exact Follow)

```csharp
// CinemachineCamera > Body > Hard Lock to Target
// Camera exactly matches target position (no offset or damping)
```

---

<!-- 中文翻译 -->
## Aim Modes (Aim Component)

<!-- 中文翻译 -->
### Composer (Frame Target)

```csharp
// CinemachineCamera > Aim > Composer

// Configure:
// - Tracked Object Offset: Aim at target's head instead of feet
// - Screen Position: Where target appears on screen
// - Dead Zone: Don't rotate if target within zone
```

<!-- 中文翻译 -->
### Look At Target

```csharp
// CinemachineCamera > Aim > Rotate With Follow Target
// Camera rotation matches target rotation (e.g., first-person)
```

---

<!-- 中文翻译 -->
## Blending Between Cameras

<!-- 中文翻译 -->
### Priority-Based Blending

```csharp
public CinemachineCamera normalCamera; // Priority: 10
public CinemachineCamera aimCamera;    // Priority: 5

void StartAiming() {
    // Set aim camera to higher priority
    aimCamera.Priority = 15; // Now active
    // Brain automatically blends from normalCamera to aimCamera
}

void StopAiming() {
    aimCamera.Priority = 5; // Back to normal
}
```

<!-- 中文翻译 -->
### Custom Blend Times

```csharp
// Create Custom Blends Asset:
// Assets > Create > Cinemachine > Cinemachine Blender Settings

// In Cinemachine Brain:
// - Custom Blends = your asset
// - Configure blend times per camera pair
```

---

<!-- 中文翻译 -->
## Camera Shake

<!-- 中文翻译 -->
### Impulse Source (Trigger Shake)

```csharp
using Unity.Cinemachine;

public class ExplosionShake : MonoBehaviour {
    public CinemachineImpulseSource impulseSource;

    void Explode() {
        // Trigger camera shake
        impulseSource.GenerateImpulse();
    }
}
```

<!-- 中文翻译 -->
### Impulse Listener (Receive Shake)

```csharp
// Add to CinemachineCamera:
// Add Component > CinemachineImpulseListener

// Impulse listener automatically receives shake from nearby Impulse Sources
```

---

<!-- 中文翻译 -->
## Freelook Camera (Third Person with Mouse Look)

<!-- 中文翻译 -->
### Cinemachine Free Look

```csharp
// GameObject > Cinemachine > Cinemachine Free Look

// Creates 3 rigs (Top, Middle, Bottom) that blend based on vertical input
// Configure:
// - Orbit Radius: Distance from target
// - Height Offset: Camera height at each rig
// - X/Y Axis: Mouse or joystick input
```

---

<!-- 中文翻译 -->
## State-Driven Camera (Anim ator-Based)

<!-- 中文翻译 -->
### Cinemachine State-Driven Camera

```csharp
// GameObject > Cinemachine > Cinemachine State-Driven Camera

// Configure:
// - Animated Target: Character with Animator
// - Layer: Animator layer to track
// - State: Assign camera per animation state (Idle, Run, Jump, etc.)

// Camera automatically switches based on animation state
```

---

<!-- 中文翻译 -->
## Dolly Tracks (Cutscenes)

<!-- 中文翻译 -->
### Cinemachine Dolly Track

```csharp
// 1. Create Spline: GameObject > Cinemachine > Cinemachine Spline

// 2. Create Dolly Camera:
//    GameObject > Cinemachine > Cinemachine Camera
//    Body > Spline Dolly
//    Assign Spline

// 3. Animate dolly position on spline (Timeline or script)
```

---

<!-- 常见模式 -->
## Common Patterns

<!-- 中文翻译 -->
### Third-Person Follow Camera

```csharp
// CinemachineCamera
// - Follow: Player Transform
// - Body: 3rd Person Follow (shoulder offset, distance: 5)
// - Aim: Composer (frame player at center)
```

---

<!-- 中文翻译 -->
### Aiming Camera (Zoom In)

```csharp
// Normal Camera (Priority 10):
//   - Distance: 5.0

// Aim Camera (Priority 5):
//   - Distance: 2.0
//   - FOV: Narrower

// Script:
void StartAiming() {
    aimCamera.Priority = 15; // Blend to aim camera
}
```

---

<!-- 中文翻译 -->
### Cutscene Camera Sequence

```csharp
// Use Timeline:
// 1. Create Timeline (Assets > Create > Timeline)
// 2. Add Cinemachine Track
// 3. Add virtual cameras as clips
// 4. Timeline automatically blends between cameras
```

---

<!-- 中文翻译 -->
## Migration from Cinemachine 2.x (Unity 2021)

<!-- 中文翻译 -->
### API Changes (Unity 6 / Cinemachine 3.0)

```csharp
// ❌ OLD (Cinemachine 2.x):
CinemachineVirtualCamera vcam;
vcam.m_Follow = target;

// ✅ NEW (Cinemachine 3.0+):
CinemachineCamera vcam;
vcam.Follow = target; // Cleaner API
```

**Major Changes:**
- `CinemachineVirtualCamera` → `CinemachineCamera`
- `m_Follow`, `m_LookAt` → `Follow`, `LookAt` (no "m_" prefix)
- Components renamed for clarity
- Better performance

---

<!-- 性能提示 -->
## Performance Tips

- Limit active virtual cameras (only activate when needed)
- Use lower-priority cameras instead of destroying/creating
- Disable virtual cameras when far from player

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### Cinemachine Debug

```csharp
// Window > Analysis > Cinemachine Debugger
// Shows active camera, blend info, shot quality
```

---

<!-- 来源 -->
## Sources
- https://docs.unity3d.com/Packages/com.unity.cinemachine@3.0/manual/index.html
- https://learn.unity.com/tutorial/cinemachine
