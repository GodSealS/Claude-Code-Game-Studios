---
name: cocos_physics
description: Cocos Creator 3D physics engine expert. Triggers when users need to handle RigidBody, Collider, PhysicsWorld, Joint, raycast, collision detection, rigid body dynamics, 3D physics simulation. 当用户需要处理刚体、碰撞体、射线检测、3D物理模拟等物理相关功能时触发此 Skill。
---

# Physics - Cocos Creator 3D Physics Engine / 3D物理引擎

## Overview / 概述

The Cocos Creator 3D physics module (`cocos/physics`) provides 3D physics simulation based on Cannon.js, supporting rigid body dynamics, collision detection, and joint systems.

> **中文翻译**：Cocos Creator 3D物理模块(`cocos/physics`)基于Cannon.js提供3D物理模拟，支持刚体动力学、碰撞检测和关节系统。

## Domain Knowledge / 领域知识

### Core Design Patterns / 核心设计模式
- **component-based** — Physics components (RigidBody, Collider) mounted on Nodes / 基于组件 — 物理组件（刚体、碰撞体）挂载在节点上
- **physics-integration** — Physics simulation driven by the Cannon.js backend / 物理集成 — 由Cannon.js后端驱动物理模拟

### Key Concepts / 关键概念
- `RigidBody` — Rigid body component, controls physical motion properties / 刚体组件，控制物理运动属性
- `Collider` — Collider component, defines collision shapes / 碰撞体组件，定义碰撞形状
- `PhysicsWorld` — Physics world, manages all physics objects and simulation stepping / 物理世界，管理所有物理对象和模拟步进
- `Joint` — Joint component, constrains relative motion between two rigid bodies / 关节组件，约束两个刚体之间的相对运动

## Key APIs / 关键API

### Classes / 类
- `RigidBody` — Rigid body (mass, velocity, force, damping) / 刚体（质量、速度、力、阻尼）
- `Collider` — Collider (Box, Sphere, Cylinder, etc.) / 碰撞体（盒子、球体、圆柱等）
- `PhysicsWorld` — Physics world (gravity, stepping, debugging) / 物理世界（重力、步进、调试）
- `Joint` — Joint (Hinge, Distance, Spring, etc.) / 关节（铰链、距离、弹簧等）

### Functions / 函数
- `raycast()` — Raycast detection, returns hit information / 射线检测，返回命中信息
- `sweepTest()` — Sweep test, detects collisions along a path / 扫掠测试，检测沿路径的碰撞
- `overlapTest()` — Overlap test, checks if two objects intersect / 重叠测试，检查两个对象是否相交

## Dependencies / 依赖
- Required modules: `core` / 必需模块：`core`
- Backend engine: Cannon.js / 后端引擎：Cannon.js

## Code Examples / 代码示例

```typescript
import { RigidBody, BoxCollider, PhysicsSystem } from 'cc';

// Add rigid body
const rigidBody = node.addComponent(RigidBody);
rigidBody.type = RigidBody.Type.DYNAMIC;
rigidBody.mass = 1.0;

// Add collider
const collider = node.addComponent(BoxCollider);
collider.size = new Vec3(1, 1, 1);
collider.on('onCollisionEnter', (event) => {
    console.log('Collision detected:', event.otherCollider.node.name);
});

// Raycast
const ray = new Ray(origin, direction);
const hitResult = PhysicsSystem.instance.raycast(ray);
if (hitResult) {
    console.log('Hit:', hitResult.node.name, hitResult.distance);
}
```

## Usage Guide / 使用指南

### When to Use This Skill / 何时使用此技能
- Adding 3D rigid bodies and colliders / 添加3D刚体和碰撞体
- Implementing character collision detection and physics interaction / 实现角色碰撞检测和物理交互
- Configuring physics world parameters (gravity, step size) / 配置物理世界参数（重力、步长）
- Using raycasts for click-picking / 使用射线进行点击拾取
- Creating joint constraints (hinges, springs, etc.) / 创建关节约束（铰链、弹簧等）

### Best Practices / 最佳实践
1. Use `RigidBody.Type.STATIC` for static objects to avoid unnecessary physics computation / 对静态对象使用`RigidBody.Type.STATIC`以避免不必要的物理计算
2. Prefer simple collider shapes (Box > Sphere > Mesh) / 优先使用简单碰撞体形状（盒子 > 球体 > 网格）
3. Avoid heavy computation in physics callbacks; only set flags, process in `update` / 避免在物理回调中进行重计算；只设置标志，在`update`中处理
4. Use `mask` for raycast filtering to reduce detection scope / 使用`mask`进行射线过滤以减少检测范围
5. Adjust physics step size (fixedDeltaTime) to balance precision and performance / 调整物理步长（fixedDeltaTime）以平衡精度和性能

### Common Tasks / 常见任务
- Add rigid body and collider components / 添加刚体和碰撞体组件
- Implement character controller collision / 实现角色控制器碰撞
- Configure physics collision matrix / 配置物理碰撞矩阵
- Raycast for object picking / 射线拾取对象
- Create joint constraints / 创建关节约束