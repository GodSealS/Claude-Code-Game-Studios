# 通用对象池系统

**来源**: 游戏编程精粹 Vol.1 Ch.4
**标签**: #memory #pooling #performance #allocation #gc
**最后验证**: 2026-05-31

## 解决的问题

游戏运行时频繁创建/销毁同类对象（子弹、粒子、敌人），导致：
- 托管语言（C#/GDScript）：GC 回收卡顿
- C++：内存碎片 + 频繁 malloc 开销

## 核心思路

预分配一批对象，用完不销毁，而是重置状态后放回池中复用。对外暴露 `acquire()` / `release()` 接口，对使用者透明。

## 伪代码

```
class ObjectPool<T> where T: IPoolable:
    available: Stack<T>
    active: List<T>
    factory: () -> T
    
    acquire():
        obj = available.pop_or_create(factory)
        obj.onAcquire()
        active.add(obj)
        return obj
    
    release(obj):
        obj.onRelease()  // 重置状态
        active.remove(obj)
        available.push(obj)
        
    prewarm(count):
        for i in range(count):
            available.push(factory())
```

## 适用场景

- ✅ 子弹、导弹等频繁射击的投射物
- ✅ 粒子效果、伤害数字
- ✅ 频繁刷新的敌人 / NPC
- ✅ UI 列表中的行控件

## 不适用场景

- ❌ 对象类型完全不可预测（池命中率低）
- ❌ 对象生命周期极长且从不复用
- ❌ 对象有复杂的构造依赖（重置成本高于创建成本）

## 引擎实现参考

| 引擎 | 内置实现 | 备注 |
|------|---------|------|
| Unreal | `UObjectPool` (5.1+) / Blueprint Pooling | Actor 池化内建支持 |
| Unity | `ObjectPool<T>` (2021+) | Unity 已内置泛型对象池 |
| Godot | 无内置 | 可用 `Array` + 标志位；或 C# ObjectPool |
| Cocos | `cc.NodePool` | Cocos 自带节点池 |

## 关键细节

- **IPoolable 接口**: 确保对象可重置，`onRelease()` 中清空所有状态
- **预热**: 加载阶段预分配峰值用量，避免运行时创建
- **上限控制**: 设置 maxSize，超出后 release 直接丢弃而非缓存
- **泄露检测**: debug 模式下记录 acquire 调用栈，检测未释放对象
