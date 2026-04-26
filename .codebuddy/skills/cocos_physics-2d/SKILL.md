---
name: cocos_physics-2d
description: Cocos Creator 2D physics engine expert. Triggers when users need to handle RigidBody2D, Collider2D, PhysicsWorld2D, 2D collision detection, Box2D integration, 2D rigid body dynamics. 当用户需要处理2D刚体、2D碰撞检测、Box2D集成等2D物理相关功能时触发此 Skill。
---

# Physics 2D - Cocos Creator 2D Physics Engine / 2D物理引擎

## Overview / 概述

The Cocos Creator 2D physics module (`cocos/physics-2d`) provides 2D physics simulation based on Box2D, supporting rigid bodies, colliders, and joint systems.

> **中文翻译**：Cocos Creator 2D物理模块(`cocos/physics-2d`)基于Box2D提供2D物理模拟，支持刚体、碰撞体和关节系统。

## Domain Knowledge / 领域知识

### Core Design Patterns / 核心设计模式
- **component-based** — Physics components mounted on Nodes / 基于组件 — 物理组件挂载在节点上
- **2d-physics** — Box2D-driven 2D physics simulation / 2D物理 — Box2D驱动的2D物理模拟

### Key Concepts / 关键概念
- `RigidBody2D` — 2D rigid body component / 2D刚体组件
- `Collider2D` — 2D collider component (Box, Circle, Polygon) / 2D碰撞体组件（盒子、圆形、多边形）
- `PhysicsWorld2D` — 2D physics world / 2D物理世界

## Key APIs / 关键API

### Classes / 类
- `RigidBody2D` — 2D rigid body (type, linear velocity, angular velocity, damping) / 2D刚体（类型、线速度、角速度、阻尼）
- `Collider2D` — 2D collider (BoxCollider2D, CircleCollider2D, PolygonCollider2D) / 2D碰撞体（盒子碰撞体、圆形碰撞体、多边形碰撞体）
- `PhysicsWorld2D` — 2D physics world (gravity, stepping) / 2D物理世界（重力、步进）

### Functions / 函数
- `raycast2D()` — 2D raycast detection / 2D射线检测
- `testPoint()` — Test if a point is inside a collider / 测试点是否在碰撞体内

## Dependencies / 依赖
- Required modules: `core` / 必需模块：`core`
- Backend engine: Box2D / 后端引擎：Box2D

## Code Examples / 代码示例

```typescript
import { RigidBody2D, BoxCollider2D, EPhysics2DDrawFlags } from 'cc';

// Add 2D rigid body
const rigidBody = node.addComponent(RigidBody2D);
rigidBody.type = ERigidBody2DType.Dynamic;

// Add 2D collider
const collider = node.addComponent(BoxCollider2D);
collider.size = new Size(100, 50);
collider.apply();

// Collision callback
collider.on('onCollisionEnter', (event) => {
    console.log('2D Collision:', event.otherCollider.node.name);
});

// 2D raycast
const results = PhysicsSystem2D.instance.raycast(p1, p2);
```

## Usage Guide / 使用指南

### When to Use This Skill / 何时使用此技能
- Adding physics effects to 2D games / 为2D游戏添加物理效果
- Implementing 2D collision detection and collision events / 实现2D碰撞检测和碰撞事件
- Configuring Box2D physics world parameters / 配置Box2D物理世界参数
- Implementing platformer physics interaction / 实现平台游戏物理交互

### Best Practices / 最佳实践
1. Prefer simple colliders in 2D physics (Box > Circle > Polygon) / 2D物理中优先使用简单碰撞体（盒子 > 圆形 > 多边形）
2. Call `collider.apply()` after editing collider properties / 编辑碰撞体属性后调用`collider.apply()`
3. Enable physics debug drawing during development (`EPhysics2DDrawFlags`) / 开发期间启用物理调试绘制（`EPhysics2DDrawFlags`）
4. Do not mix 2D and 3D physics on the same node / 不要在同一节点上混用2D和3D物理

### Common Tasks / 常见任务
- Add 2D rigid bodies and colliders / 添加2D刚体和碰撞体
- Implement platformer physics / 实现平台游戏物理
- Configure 2D collision matrix / 配置2D碰撞矩阵
- 2D raycast detection / 2D射线检测
```