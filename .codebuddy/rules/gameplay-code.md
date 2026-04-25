---
paths:
  - "src/gameplay/**"
---

# Gameplay Code Rules / 玩法代码规则

- ALL gameplay values MUST come from external config/data files, NEVER hardcoded / 所有玩法数值必须来自外部配置/数据文件，绝不硬编码
- Use delta time for ALL time-dependent calculations (frame-rate independence) / 所有时间相关计算使用 delta time（帧率无关）
- NO direct references to UI code — use events/signals for cross-system communication / 不直接引用 UI 代码 — 使用事件/信号进行跨系统通信
- Every gameplay system must implement a clear interface / 每个玩法系统必须实现清晰的接口
- State machines must have explicit transition tables with documented states / 状态机必须有显式的转换表和文档化的状态
- Write unit tests for all gameplay logic — separate logic from presentation / 为所有玩法逻辑编写单元测试 — 逻辑与表现分离
- Document which design doc each feature implements in code comments / 在代码注释中记录每个功能实现的设计文档
- No static singletons for game state — use dependency injection / 游戏状态不使用静态单例 — 使用依赖注入

## Examples / 示例

**Correct** (data-driven) / **正确**（数据驱动）：

```gdscript
var damage: float = config.get_value("combat", "base_damage", 10.0)
var speed: float = stats_resource.movement_speed * delta
```

**Incorrect** (hardcoded) / **错误**（硬编码）：

```gdscript
var damage: float = 25.0   # VIOLATION: hardcoded gameplay value / 违规：硬编码玩法数值
var speed: float = 5.0      # VIOLATION: not from config, not using delta / 违规：非配置来源，未使用 delta
```
