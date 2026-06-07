# 空间哈希快速近邻查询

**来源**: 游戏编程精粹 Vol.1 Ch.1
**标签**: #spatial #hash #performance #proximity #broad-phase
**最后验证**: 2026-05-31

## 解决的问题

场景中有 1000+ 个动态物体，每帧需要找到每个物体周围半径 R 内的其他物体。暴力 O(n²) 在物体数超过 500 时帧率降至不可接受。

## 核心思路

将世界空间划分为固定大小的网格。每个物体映射到其所在的格子（用坐标计算 hash key）。查询时只检查目标物体所在格子及其相邻格子中的物体。

```
查询半径 R → 选择格子边长 = R
物体(x,y) → hash_key = floor(x/R) * PRIME1 + floor(y/R) * PRIME2
查询: 遍历所在格子 + 8个相邻格子中的物体
```

## 伪代码

```
class SpatialHash:
    cellSize: float
    table: HashMap<Int, Array<Object>>
    
    insert(obj):
        key = hash(obj.x, obj.y)
        table[key].append(obj)
        obj.hashKey = key
    
    query(obj, radius):
        result = []
        cells = cellsInRadius(obj, radius)  // 最多 9 个格子
        for cell in cells:
            for candidate in table[cell]:
                if distance(obj, candidate) < radius:
                    result.append(candidate)
        return result
```

## 适用场景

- ✅ 碰撞检测 broad phase (先 hash 筛选，再精确检测)
- ✅ AI 感知系统 (NPC 每帧检测附近玩家/敌人)
- ✅ 粒子/群集系统的邻居查询
- ✅ 物体尺寸接近的情况

## 不适用场景

- ❌ 物体尺寸差异极大 (格子边长难选，大物体会跨很多格子)
- ❌ 极度稀疏分布 (大量空格子浪费内存)
- ❌ 物体极密集 (一个格子内有上千物体，内部退化回 O(n²))

## 引擎实现参考

| 引擎 | 内置实现 | 备注 |
|------|---------|------|
| Unreal | `FGridHash2D` in PhysicsCore | UE 自带的 2D 空间哈希 |
| Unity | 无内置 | 可用 NativeHashMap + JobSystem 实现并行版本 |
| Godot | 无内置 | GDScript 可用 Dictionary + Vector2i key；C# 可用 ConcurrentDictionary |
| Cocos | 无内置 | TypeScript 可用 Map<number, T[]> |

## 变体/扩展

- **多分辨率 Hash**: 对大物体用更大格子尺寸的第二层 hash
- **并行查询**: 读操作天然无竞争，可多线程并行
- **增量更新**: 物体只在跨格子边界时重新哈希，减少重复计算

## 参数调优

| 参数 | 建议值 | 原因 |
|------|--------|------|
| cellSize | = queryRadius | 确保查询半径最多覆盖 3×3 格子 |
| hash 质数 | 大质数 (73856093, 19349663) | 减少碰撞，均匀分布 |
| 初始容量 | 预期物体数 × 1.5 | 减少 rehash |
