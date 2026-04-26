---
name: cocos_core
description: Cocos Creator core engine expert. Triggers when users need to handle Component, Node, Director, Game, Scene, ECS architecture, scene graph, lifecycle management, event system, object pool. 当用户需要处理组件、节点、场景图、生命周期管理、事件系统、对象池等核心功能时触发此 Skill。
---

# Core - Cocos Creator Core Engine / 核心引擎

## Overview / 概述

The Cocos Creator core module (`cocos/core`) is the foundation of the entire engine, providing ECS component system, scene graph management, lifecycle control, and event mechanisms.

> **中文翻译**：Cocos Creator核心模块(`cocos/core`)是整个引擎的基础，提供ECS组件系统、场景图管理、生命周期控制和事件机制。

## Domain Knowledge / 领域知识

### Core Design Patterns / 核心设计模式
- **ecs-pattern** — Entity-Component-System architecture, Node as Entity, Component as behavior unit / ECS模式 — 实体-组件-系统架构，节点为实体，组件为行为单元
- **object-pool** — Object pool pattern, reusing frequently created/destroyed objects / 对象池 — 对象池模式，复用频繁创建/销毁的对象
- **event-emitter** — Event emitter for decoupled inter-module communication / 事件发射器 — 用于模块间解耦通信的事件发射器

### Key Concepts / 关键概念
- `Component` — Base class for all components, mounted on Nodes to provide behavior / 所有组件的基类，挂载在节点上提供行为
- `Node` — Scene node, the basic unit of the scene tree / 场景节点，场景树的基本单元
- `Director` — Game director, manages main loop and scene transitions / 游戏导演，管理主循环和场景切换
- `Game` — Game entry point, initializes engine and drives main loop / 游戏入口，初始化引擎并驱动主循环
- `Scene` — Scene root node, hosts all game objects / 场景根节点，承载所有游戏对象

## Key APIs / 关键API

### Classes / 类
- `Component` — Component base class (`onLoad`, `start`, `update`, `onDestroy`) / 组件基类（`onLoad`、`start`、`update`、`onDestroy`）
- `Node` — Scene node (`addChild`, `removeChild`, `getComponent`) / 场景节点（`addChild`、`removeChild`、`getComponent`）
- `Director` — Game director (`loadScene`, `preloadScene`) / 游戏导演（`loadScene`、`preloadScene`）
- `Game` — Game instance (`run`, `pause`, `resume`) / 游戏实例（`run`、`pause`、`resume`）
- `Scene` — Scene container / 场景容器

### Functions / 函数
- `find()` — Find a node by path / 通过路径查找节点
- `isValid()` — Check if an object is valid (not destroyed) / 检查对象是否有效（未销毁）
- `destroy()` — Destroy an object and release resources / 销毁对象并释放资源

## Dependencies / 依赖
- No external dependencies; this is the foundation for all other modules / 无外部依赖；这是所有其他模块的基础

## Code Examples / 代码示例

```typescript
import { _decorator, Component, Node, director } from 'cc';
const { ccclass, property } = _decorator;

@ccclass('PlayerController')
export class PlayerController extends Component {
    @property(Node)
    targetNode: Node = null;

    onLoad() {
        // Initialize when component loads
    }

    start() {
        // Called before first frame update
    }

    update(deltaTime: number) {
        // Per-frame update
    }

    onDestroy() {
        // Cleanup when component is destroyed
    }
}

// Scene transition
director.loadScene('main-menu');

// Find node by path
const node = find('Canvas/Player');
```

## Usage Guide / 使用指南

### When to Use This Skill / 何时使用此技能
- Creating custom Components / 创建自定义组件
- Managing scene node trees / 管理场景节点树
- Handling engine lifecycle callbacks / 处理引擎生命周期回调
- Implementing inter-module event communication / 实现模块间事件通信
- Using object pools for performance optimization / 使用对象池进行性能优化

### Best Practices / 最佳实践
1. Keep component logic within `onLoad`/`start`/`update` lifecycle methods / 将组件逻辑保持在`onLoad`/`start`/`update`生命周期方法内
2. Use `isValid()` to check node references, avoiding access to destroyed objects / 使用`isValid()`检查节点引用，避免访问已销毁的对象
3. Use object pools (`NodePool`) for frequently created/destroyed objects / 对频繁创建/销毁的对象使用对象池（`NodePool`）
4. Register event listeners in `onLoad`, unregister in `onDestroy` / 在`onLoad`中注册事件监听，在`onDestroy`中取消注册
5. Avoid heavy computation in `update`; use schedulers or async operations / 避免在`update`中进行重计算；使用调度器或异步操作

### Common Tasks / 常见任务
- Create custom component classes / 创建自定义组件类
- Manage node parent-child relationships / 管理节点父子关系
- Implement scene transition logic / 实现场景切换逻辑
- Use event system for communication / 使用事件系统进行通信
- Implement object pool reuse / 实现对象池复用