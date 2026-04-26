# Unreal Engine 5.7 — PCG (Procedural Content Generation) / Unreal EnginePCG（程序化内容生成）插件


> **中文翻译**：本文档为Unreal Engine引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Status:** Production-Ready (as of UE 5.7)
**Plugin:** `PCG` (built-in, enable in Plugins)

---

<!-- 概述 -->
## Overview

**Procedural Content Generation (PCG)** is Unreal's node-based framework for generating
procedural content at massive scale. It's designed for populating large open worlds with
foliage, rocks, props, buildings, and other environmental detail.

**Use PCG for:**
- Procedural foliage placement (trees, grass, rocks)
- Biome-based environment generation
- Road/path generation
- Building/structure placement
- World detail population (props, clutter)

**DON'T use PCG for:**
- Gameplay logic (use Blueprints/C++)
- One-off manual placement (use editor tools)

**⚠️ Note:** PCG was experimental in UE 5.0-5.6, became production-ready in UE 5.7.

---

<!-- 核心概念 -->
## Core Concepts

<!-- 中文翻译 -->
### 1. **PCG Graph**
- Node-based graph (similar to Material Editor)
- Defines generation rules

<!-- 中文翻译 -->
### 2. **PCG Component**
- Placed in level, executes PCG Graph
- Generates content in defined volume

<!-- 中文翻译 -->
### 3. **PCG Data**
- Point data (positions, rotations, scales)
- Spline data (paths, roads, rivers)
- Volume data (density, biome masks)

<!-- 中文翻译 -->
### 4. **Nodes**
- **Samplers**: Generate points (Grid, Poisson, Surface)
- **Filters**: Remove points based on rules (Density, Tag, Bounds)
- **Modifiers**: Transform points (Offset, Rotate, Scale)
- **Spawners**: Instantiate meshes/actors at points

---

<!-- 设置 -->
## Setup

<!-- 中文翻译 -->
### 1. Enable Plugin

`Edit > Plugins > PCG > Enabled > Restart`

<!-- 中文翻译 -->
### 2. Create PCG Volume

1. Place Actors > Volumes > PCG Volume
2. Scale volume to desired generation area

<!-- 中文翻译 -->
### 3. Create PCG Graph

1. Content Browser > PCG > PCG Graph
2. Open PCG Graph Editor

---

<!-- 中文翻译 -->
## Basic Workflow

<!-- 中文翻译 -->
### Example: Forest Generation

<!-- 中文翻译 -->
#### 1. Create PCG Graph

**Node Setup:**
```
Input (Volume)
  ↓
Surface Sampler (sample volume surface, points per m²: 0.5)
  ↓
Density Filter (use texture mask or noise)
  ↓
Static Mesh Spawner (tree meshes)
  ↓
Output
```

<!-- 中文翻译 -->
#### 2. Assign Graph to Volume

1. Select PCG Volume
2. Details Panel > PCG Component > Graph = Your PCG Graph
3. Click "Generate" button

---

<!-- 中文翻译 -->
## Key Node Types

<!-- 中文翻译 -->
### Samplers (Point Generation)

<!-- 中文翻译 -->
#### Grid Sampler
- Regular grid of points
- Configure:
  - **Grid Size**: Distance between points
  - **Offset**: Random offset per point

<!-- 中文翻译 -->
#### Poisson Disk Sampler
- Random points with minimum distance
- Configure:
  - **Points Per m²**: Density
  - **Min Distance**: Spacing between points

<!-- 中文翻译 -->
#### Surface Sampler
- Points on mesh surfaces or landscape
- Configure:
  - **Points Per m²**: Density
  - **Surface Only**: Only surface, not volume

---

<!-- 中文翻译 -->
### Filters (Point Removal)

<!-- 中文翻译 -->
#### Density Filter
- Remove points based on density value
- Input: Texture or noise
- Use for: Biome masks, clearings, paths

<!-- 中文翻译 -->
#### Tag Filter
- Filter points by tag
- Use for: Conditional spawning

<!-- 中文翻译 -->
#### Bounds Filter
- Keep only points within bounds
- Use for: Limiting generation to specific areas

---

<!-- 中文翻译 -->
### Modifiers (Point Transformation)

<!-- 中文翻译 -->
#### Rotate
- Randomize point rotation
- Configure:
  - **Min/Max Rotation**: Rotation range per axis

<!-- 中文翻译 -->
#### Scale
- Randomize point scale
- Configure:
  - **Min/Max Scale**: Scale range

<!-- 中文翻译 -->
#### Project to Ground
- Snap points to landscape surface

---

<!-- 中文翻译 -->
### Spawners (Mesh/Actor Instantiation)

<!-- 中文翻译 -->
#### Static Mesh Spawner
- Spawn static meshes at points
- Configure:
  - **Mesh List**: Array of meshes (random selection)
  - **Culling Distance**: LOD/culling settings

<!-- 中文翻译 -->
#### Actor Spawner
- Spawn Blueprint actors at points
- Use for: Gameplay actors, interactive objects

---

<!-- 中文翻译 -->
## Data Sources

<!-- 中文翻译 -->
### Landscape
- Use landscape as input for sampling
- Automatically projects to landscape height

<!-- 中文翻译 -->
### Splines
- Generate content along splines (roads, rivers, paths)
- Example: Trees along path

<!-- 中文翻译 -->
### Textures
- Use textures as density masks
- Paint biomes, clearings, areas

---

<!-- 中文翻译 -->
## Biome Example (Mixed Forest)

<!-- 中文翻译 -->
### Graph Setup

```
Input (Landscape)
  ↓
Surface Sampler (density: 1.0)
  ↓
┌─────────────────┬─────────────────┐
│ Tree Biome      │ Rock Biome      │
│ (density > 0.5) │ (density < 0.5) │
├─────────────────┼─────────────────┤
│ Tree Spawner    │ Rock Spawner    │
└─────────────────┴─────────────────┘
  ↓
Merge
  ↓
Output
```

---

<!-- 中文翻译 -->
## Spline-Based Generation (Road with Trees)

<!-- 中文翻译 -->
### 1. Create PCG Graph

```
Spline Input
  ↓
Spline Sampler (sample along spline)
  ↓
Offset (offset from spline path)
  ↓
Tree Spawner
  ↓
Output
```

<!-- 中文翻译 -->
### 2. Add Spline Component to PCG Volume

1. PCG Volume > Add Component > Spline
2. Draw spline path
3. PCG Graph reads spline data

---

<!-- 中文翻译 -->
## Runtime Generation

<!-- 中文翻译 -->
### Trigger Generation from C++

```cpp
#include "PCGComponent.h"

UPCGComponent* PCGComp = /* Get PCG Component */;
PCGComp->Generate(); // Execute PCG graph
```

<!-- 中文翻译 -->
### Stream Generation (Large Worlds)

- PCG automatically streams with World Partition
- Only generates content in loaded cells

---

<!-- 性能 -->
## Performance

<!-- 中文翻译 -->
### Optimization Tips

- Use **culling distance** on spawned meshes (LOD)
- Limit **density** (fewer points = better performance)
- Use **Hierarchical Instanced Static Meshes (HISM)** for repeated meshes
- Enable **streaming** for large worlds

<!-- 中文翻译 -->
### Debug Performance

```cpp
// Console commands:
// pcg.graph.debug 1 - Show PCG debug info
// stat pcg - Show PCG performance stats
```

---

<!-- 常见模式 -->
## Common Patterns

<!-- 中文翻译 -->
### Forest with Clearings

```
Surface Sampler
  ↓
Density Filter (noise texture with clearings)
  ↓
Tree Spawner (pine, oak, birch)
```

---

<!-- 中文翻译 -->
### Rocks on Steep Slopes

```
Landscape Input
  ↓
Surface Sampler
  ↓
Slope Filter (angle > 30°)
  ↓
Rock Spawner
```

---

<!-- 中文翻译 -->
### Props Along Road

```
Spline Input (road spline)
  ↓
Spline Sampler
  ↓
Offset (side of road)
  ↓
Street Light Spawner
```

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### PCG Debug Visualization

```cpp
// Console commands:
// pcg.debug.display 1 - Show points and generation bounds
// pcg.debug.colormode points - Color-code points
```

<!-- 中文翻译 -->
### Graph Debugging

- PCG Graph Editor > Debug > Show Debug Points
- Visualize points at each node in the graph

---

<!-- 中文翻译 -->
## Migration from UE 5.6 (Experimental) to 5.7 (Production)

<!-- 中文翻译 -->
### API Changes

```cpp
// ❌ OLD (5.6 experimental API):
// Some nodes renamed, API unstable

// ✅ NEW (5.7 production API):
// Stable node types, documented API
```

**Migration:** Rebuild PCG graphs using stable 5.7 nodes. Test thoroughly.

---

<!-- 限制 -->
## Limitations

- **Not for gameplay logic**: Use Blueprints/C++ for game rules
- **Large graphs can be slow**: Optimize with filters and density reduction
- **Runtime generation overhead**: Pre-generate when possible

---

<!-- 来源 -->
## Sources
- https://docs.unrealengine.com/5.7/en-US/procedural-content-generation-in-unreal-engine/
- https://docs.unrealengine.com/5.7/en-US/pcg-quick-start-in-unreal-engine/
- UE 5.7 Release Notes (PCG Production-Ready announcement)
