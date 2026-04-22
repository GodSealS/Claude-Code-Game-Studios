---
paths:
  - "src/core/**"
---

# Engine Code Rules / 引擎代码规则

- ZERO allocations in hot paths (update loops, rendering, physics) — pre-allocate, pool, reuse
  > **中文翻译**：热路径（更新循环、渲染、物理）中零分配 — 预分配、对象池、复用
- All engine APIs must be thread-safe OR explicitly documented as single-thread-only
  > **中文翻译**：所有引擎 API 必须是线程安全的，或明确文档标注为仅限单线程
- Profile before AND after every optimization — document the measured numbers
  > **中文翻译**：每次优化前后都要进行性能分析 — 记录测量的数值
- Engine code must NEVER depend on gameplay code (strict dependency direction: engine <- gameplay)
  > **中文翻译**：引擎代码永远不能依赖玩法代码（严格依赖方向：引擎 <- 玩法）
- Every public API must have usage examples in its doc comment
  > **中文翻译**：每个公共 API 必须在其文档注释中包含使用示例
- Changes to public interfaces require a deprecation period and migration guide
  > **中文翻译**：公共接口的变更需要废弃期和迁移指南
- Use RAII / deterministic cleanup for all resources
  > **中文翻译**：对所有资源使用 RAII / 确定性清理
- All engine systems must support graceful degradation
  > **中文翻译**：所有引擎系统必须支持优雅降级
- Before writing engine API code, consult `docs/engine-reference/` for the current engine version and verify APIs against the reference docs
  > **中文翻译**：编写引擎 API 代码前，查阅 `docs/engine-reference/` 获取当前引擎版本，并对照参考文档验证 API

## Examples / 示例

**Correct** (zero-alloc hot path):
> **中文翻译**：**正确**（零分配热路径）：

```gdscript
# Pre-allocated array reused each frame
# 预分配数组每帧复用
var _nearby_cache: Array[Node3D] = []

func _physics_process(delta: float) -> void:
    _nearby_cache.clear()  # Reuse, don't reallocate / 复用，不要重新分配
    _spatial_grid.query_radius(position, radius, _nearby_cache)
```

**Incorrect** (allocating in hot path):
> **中文翻译**：**错误**（热路径中分配）：

```gdscript
func _physics_process(delta: float) -> void:
    var nearby: Array[Node3D] = []  # VIOLATION: allocates every frame / 违规：每帧分配
    nearby = get_tree().get_nodes_in_group("enemies")  # VIOLATION: tree query every frame / 违规：每帧查询场景树
```
