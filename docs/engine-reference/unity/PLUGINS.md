# Unity 6.3 LTS — Optional Packages & Systems / Unity可选插件和系统


> **中文翻译**：本文档为Unity引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13

This document indexes **optional packages and systems** available in Unity 6.3 LTS.
These are NOT part of the core engine but are commonly used for specific game types.

---

<!-- 中文翻译 -->
## How to Use This Guide

**✅ Detailed Documentation Available** - See `plugins/` directory for comprehensive guides
**🟡 Brief Overview Only** - Links to official docs, use WebSearch for details
**⚠️ Preview** - May have breaking changes in future versions
**📦 Package Required** - Install via Package Manager

---

<!-- 中文翻译 -->
## Production-Ready Packages (Detailed Docs Available)

<!-- 中文翻译 -->
### ✅ Cinemachine
- **Purpose:** Virtual camera system (dynamic cameras, cutscenes, camera blending)
- **When to use:** 3rd person games, cinematics, complex camera behavior
- **Knowledge Gap:** Cinemachine 3.0+ (Unity 6) has major API changes vs 2.x
- **Status:** Production-Ready
- **Package:** `com.unity.cinemachine` (Package Manager)
- **Detailed Docs:** [plugins/cinemachine.md](plugins/cinemachine.md)
- **Official:** https://docs.unity3d.com/Packages/com.unity.cinemachine@3.0/manual/index.html

---

<!-- 中文翻译 -->
### ✅ Addressables
- **Purpose:** Advanced asset management (async loading, remote content, memory control)
- **When to use:** Large projects, DLC, remote content delivery
- **Knowledge Gap:** Unity 6 improvements, better performance
- **Status:** Production-Ready
- **Package:** `com.unity.addressables` (Package Manager)
- **Detailed Docs:** [plugins/addressables.md](plugins/addressables.md)
- **Official:** https://docs.unity3d.com/Packages/com.unity.addressables@2.0/manual/index.html

---

<!-- 中文翻译 -->
### ✅ DOTS / Entities (ECS)
- **Purpose:** Data-Oriented Technology Stack (high-performance ECS for massive scale)
- **When to use:** Games with 1000s of entities, RTS, simulations
- **Knowledge Gap:** Entities 1.3+ (Unity 6) is production-ready, major rewrite from 0.x
- **Status:** Production-Ready (as of Unity 6.3 LTS)
- **Package:** `com.unity.entities` (Package Manager)
- **Detailed Docs:** [plugins/dots-entities.md](plugins/dots-entities.md)
- **Official:** https://docs.unity3d.com/Packages/com.unity.entities@1.3/manual/index.html

---

<!-- 中文翻译 -->
## Other Production-Ready Packages (Brief Overview)

<!-- 中文翻译 -->
### 🟡 Input System (Already Covered)
- **Purpose:** Modern input handling (rebindable, cross-platform)
- **Status:** Production-Ready (default in Unity 6)
- **Package:** `com.unity.inputsystem`
- **Docs:** See [modules/input.md](../modules/input.md)
- **Official:** https://docs.unity3d.com/Packages/com.unity.inputsystem@1.11/manual/index.html

---

<!-- 中文翻译 -->
### 🟡 UI Toolkit (Already Covered)
- **Purpose:** Modern runtime UI (HTML/CSS-like, performant)
- **Status:** Production-Ready (Unity 6)
- **Package:** Built-in
- **Docs:** See [modules/ui.md](../modules/ui.md)
- **Official:** https://docs.unity3d.com/Packages/com.unity.ui@2.0/manual/index.html

---

<!-- 中文翻译 -->
### 🟡 Visual Effect Graph (VFX Graph)
- **Purpose:** GPU-accelerated particle system (millions of particles)
- **When to use:** Large-scale VFX, fire, smoke, magic, explosions
- **Status:** Production-Ready
- **Package:** `com.unity.visualeffectgraph` (URP/HDRP only)
- **Official:** https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.0/manual/index.html

---

<!-- 中文翻译 -->
### 🟡 Shader Graph
- **Purpose:** Visual shader editor (node-based shader creation)
- **When to use:** Custom shaders without HLSL coding
- **Status:** Production-Ready
- **Package:** `com.unity.shadergraph` (URP/HDRP)
- **Official:** https://docs.unity3d.com/Packages/com.unity.shadergraph@17.0/manual/index.html

---

<!-- 中文翻译 -->
### 🟡 Timeline
- **Purpose:** Cinematic sequencing (cutscenes, scripted events)
- **When to use:** Story-driven games, cinematics, scripted sequences
- **Status:** Production-Ready
- **Package:** `com.unity.timeline` (built-in)
- **Official:** https://docs.unity3d.com/Packages/com.unity.timeline@1.8/manual/index.html

---

<!-- 中文翻译 -->
### 🟡 Animation Rigging
- **Purpose:** Runtime IK, procedural animation
- **When to use:** Foot IK, aim offsets, procedural limb placement
- **Status:** Production-Ready (Unity 6)
- **Package:** `com.unity.animation.rigging`
- **Official:** https://docs.unity3d.com/Packages/com.unity.animation.rigging@1.3/manual/index.html

---

<!-- 中文翻译 -->
### 🟡 ProBuilder
- **Purpose:** In-editor 3D modeling (level prototyping, greyboxing)
- **When to use:** Rapid prototyping, level blockout
- **Status:** Production-Ready
- **Package:** `com.unity.probuilder`
- **Official:** https://docs.unity3d.com/Packages/com.unity.probuilder@6.0/manual/index.html

---

<!-- 中文翻译 -->
### 🟡 Netcode for GameObjects
- **Purpose:** Official Unity multiplayer networking
- **When to use:** Multiplayer games (client-server architecture)
- **Status:** Production-Ready
- **Package:** `com.unity.netcode.gameobjects`
- **Official:** https://docs-multiplayer.unity3d.com/netcode/current/about/

---

<!-- 中文翻译 -->
### 🟡 Burst Compiler
- **Purpose:** LLVM-based compiler for C# Jobs (massive performance boost)
- **When to use:** Performance-critical code, DOTS, Jobs System
- **Status:** Production-Ready
- **Package:** `com.unity.burst` (auto-installed with DOTS)
- **Official:** https://docs.unity3d.com/Packages/com.unity.burst@1.8/manual/index.html

---

<!-- 中文翻译 -->
### 🟡 Jobs System
- **Purpose:** Multi-threaded job scheduling (CPU parallelism)
- **When to use:** Performance optimization, parallel processing
- **Status:** Production-Ready
- **Package:** Built-in
- **Official:** https://docs.unity3d.com/Manual/JobSystem.html

---

<!-- 中文翻译 -->
### 🟡 Mathematics
- **Purpose:** SIMD math library (optimized for Burst)
- **When to use:** DOTS, high-performance math
- **Status:** Production-Ready
- **Package:** `com.unity.mathematics`
- **Official:** https://docs.unity3d.com/Packages/com.unity.mathematics@1.3/manual/index.html

---

<!-- 中文翻译 -->
### 🟡 ML-Agents (Machine Learning)
- **Purpose:** Train AI with reinforcement learning
- **When to use:** Advanced AI training, procedural behavior
- **Status:** Production-Ready
- **Package:** `com.unity.ml-agents`
- **Official:** https://github.com/Unity-Technologies/ml-agents

---

<!-- 中文翻译 -->
### 🟡 Recorder
- **Purpose:** Capture gameplay footage, screenshots, animation clips
- **When to use:** Trailers, replays, debug recording
- **Status:** Production-Ready
- **Package:** `com.unity.recorder`
- **Official:** https://docs.unity3d.com/Packages/com.unity.recorder@5.0/manual/index.html

---

<!-- 中文翻译 -->
## Preview/Experimental Packages (Use with Caution)

<!-- 中文翻译 -->
### ⚠️ Splines
- **Purpose:** Runtime spline creation and editing
- **When to use:** Roads, paths, procedural content
- **Status:** Production-Ready (Unity 6)
- **Package:** `com.unity.splines`
- **Official:** https://docs.unity3d.com/Packages/com.unity.splines@2.6/manual/index.html

---

<!-- 中文翻译 -->
### ⚠️ Muse (AI Assistant)
- **Purpose:** AI-powered asset creation (textures, sprites, animations)
- **Status:** Preview (Unity 6)
- **Package:** `com.unity.muse.*`
- **Official:** https://unity.com/products/muse

---

<!-- 中文翻译 -->
### ⚠️ Sentis (Neural Network Inference)
- **Purpose:** Run neural networks in Unity (AI inference)
- **Status:** Preview
- **Package:** `com.unity.sentis`
- **Official:** https://docs.unity3d.com/Packages/com.unity.sentis@2.0/manual/index.html

---

<!-- 中文翻译 -->
## Deprecated Packages (Avoid for New Projects)

<!-- 中文翻译 -->
### ❌ UGUI (Canvas UI)
- **Deprecated:** Still supported, but UI Toolkit recommended
- **Use Instead:** UI Toolkit

---

<!-- 中文翻译 -->
### ❌ Legacy Particle System
- **Deprecated:** Use Visual Effect Graph (VFX Graph)
- **Use Instead:** VFX Graph

---

<!-- 中文翻译 -->
### ❌ Legacy Animation
- **Deprecated:** Use Animator (Mecanim)
- **Use Instead:** Animator Controller

---

<!-- 中文翻译 -->
## On-Demand WebSearch Strategy

For packages NOT listed above, use the following approach when users ask:

1. **WebSearch** for latest documentation: `"Unity 6.3 [package name]"`
2. Verify if package is:
   - Post-cutoff (beyond May 2025 training data)
   - Preview vs Production-Ready
   - Still supported in Unity 6.3 LTS
3. Optionally cache findings in `plugins/[package-name].md` for future reference

---

<!-- 中文翻译 -->
## Quick Decision Guide

**I need virtual cameras** → **Cinemachine**
**I need async asset loading / DLC** → **Addressables**
**I need 1000s of entities (RTS, sim)** → **DOTS/Entities**
**I need modern input** → **Input System** (see modules/input.md)
**I need GPU particles** → **Visual Effect Graph**
**I need visual shaders** → **Shader Graph**
**I need cinematics** → **Timeline**
**I need runtime IK** → **Animation Rigging**
**I need level prototyping** → **ProBuilder**
**I need multiplayer** → **Netcode for GameObjects**

---

**Last Updated:** 2026-02-13
**Engine Version:** Unity 6.3 LTS
**LLM Knowledge Cutoff:** May 2025
