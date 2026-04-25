# Hooks and Rules / 钩子与规则

This document details the automated Hooks and path-specific Rules in the CodeBuddy Game Studios architecture.

> **中文翻译**：本文档详细介绍 CodeBuddy Game Studios 架构中的自动化 Hooks 和路径特定 Rules。

---

## Hooks 系统

Hooks 是在特定事件触发时自动执行的 Bash 脚本，配置在 `.codebuddy/settings.json` 中。

### 事件类型

| 事件 | 触发时机 |
|------|----------|
| `SessionStart` | 会话开始时 |
| `PreToolUse` | 工具使用前 |
| `PostToolUse` | 工具使用后 |
| `PreCompact` | 上下文压缩前 |
| `PostCompact` | 上下文压缩后 |
| `Stop` | 会话结束时 |
| `SubagentStart` | Agent 启动时 |
| `SubagentStop` | Agent 停止时 |
| `Notification` | 通知事件时 |

---

### 可用 Hooks

#### session-start.sh

**触发**: `SessionStart`

**功能**:
- 加载当前迭代上下文
- 读取里程碑状态
- 分析 Git 活动
- 检测并预览活跃会话状态文件（用于恢复）

**输出示例**:
```
当前迭代: Sprint 3 (第 2 周)
里程碑: Alpha (剩余 14 天)
Git: 3 个未提交更改
活跃会话: design/combat-system.md (待审查)
```

---

#### detect-gaps.sh

**触发**: `SessionStart`

**功能**:
- 检测新项目（建议 `/start`）
- 代码/原型存在时检测缺失文档（建议 `/reverse-document` 或 `/project-stage-detect`）

**场景**:
- 项目没有任何配置时，提示运行 `/start`
- 有代码但没有设计文档时，提示运行 `/reverse-document`

---

#### pre-compact.sh

**触发**: `PreCompact`

**功能**:
- 在上下文压缩前将会话状态转储到对话中
- 保存活跃会话状态（active.md）
- 记录修改的文件列表
- 记录进行中的设计文档

**重要性**: 确保状态在压缩后不会丢失

---

#### post-compact.sh

**触发**: `PostCompact`

**功能**:
- 提醒 Claude 从 `active.md` 检查点恢复会话状态

**输出**:
```
[上下文已压缩] 请从 production/session-state/active.md 恢复会话状态
```

---

#### session-stop.sh

**触发**: `Stop`

**功能**:
- 总结会话成果
- 更新会话日志
- 记录下次会话的待办事项

**输出到**: `production/session-logs/[date].md`

---

#### validate-commit.sh

**触发**: `PreToolUse (Bash)`, 匹配 `git commit`

**功能**:
- 验证设计文档章节完整性
- 验证 JSON 数据文件有效性
- 检查硬编码值（应该配置化）
- 检查 TODO 格式是否符合标准

**拒绝提交的情况**:
- 设计文档缺少必需章节
- JSON 文件语法错误
- 检测到关键硬编码值

---

#### validate-push.sh

**触发**: `PreToolUse (Bash)`, 匹配 `git push`

**功能**:
- 警告推送到受保护分支（develop/main）
- 检查是否有未审查的更改

**输出警告**:
```
⚠️  即将推送到受保护分支 [main]
请确认:
- [ ] 代码已通过审查
- [ ] 测试已通过
- [ ] 文档已更新
```

---

#### validate-assets.sh

**触发**: `PostToolUse (Write/Edit)`, 匹配 `assets/**`

**功能**:
- 检查命名规范
- 验证 JSON 有效性（对于数据文件）

**命名规范检查**:
- 小写字母
- 使用下划线分隔
- 包含版本号（如需要）

---

#### validate-skill-change.sh

**触发**: `PostToolUse (Write/Edit)`, 匹配 `.codebuddy/skills/**`

**功能**:
- 建议运行 `/skill-test` 验证修改的 Skill

**输出**:
```
检测到 Skill 文件变更，建议运行: /skill-test
```

---

#### notify.sh

**触发**: `Notification`

**功能**:
- 通过 PowerShell 显示 Windows 弹窗通知

**使用场景**:
- 长时间任务完成
- 需要用户注意的事件

---

#### log-agent.sh

**触发**: `SubagentStart`

**功能**:
- 审计追踪开始
- 记录 Agent 调用时间戳

**输出到**: `.codebuddy/agent-memory/`

---

#### log-agent-stop.sh

**触发**: `SubagentStop`

**功能**:
- 审计追踪结束
- 完成 Agent 调用记录

---

### Hooks 配置示例

在 `.codebuddy/settings.json` 中：

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "bash .codebuddy/hooks/session-start.sh",
            "timeout": 10
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash .codebuddy/hooks/validate-commit.sh",
            "timeout": 15
          }
        ]
      }
    ]
  }
}
```

---

## Rules 系统

Rules 是当编辑特定路径的文件时自动应用的规则，位于 `.codebuddy/rules/` 目录。

### 规则格式

每个规则文件是 Markdown 格式，包含：
- 规则说明
- 强制要求
- 禁止事项
- 示例

---

### 可用 Rules

#### gameplay-code.md

**路径**: `src/gameplay/**`

**强制规则**:
- ✅ 使用数据驱动值（不在代码中硬编码）
- ✅ 使用 Delta 时间（帧率独立）
- ❌ 禁止 UI 引用（游戏逻辑不应依赖 UI）

**示例**:
```gdscript
# ✅ 正确
const BASE_DAMAGE = 10
var damage = BASE_DAMAGE * upgrade_multiplier * delta

# ❌ 错误
var damage = 10  # 硬编码
ui.health_bar.value = health  # UI 引用
```

---

#### engine-code.md

**路径**: `src/core/**`

**强制规则**:
- ✅ 热路径零分配
- ✅ 线程安全
- ✅ API 稳定性

**示例**:
```cpp
// ✅ 正确 - 预分配
void ProcessBatch(std::vector<Entity>& entities) {
    // 使用对象池，避免每帧分配
}

// ❌ 错误 - 热路径分配
void ProcessBatch() {
    auto entities = new std::vector<Entity>();  // 每帧分配
}
```

---

#### ai-code.md

**路径**: `src/ai/**`

**强制规则**:
- ✅ 遵守性能预算
- ✅ 可调试性（可视化、日志）
- ✅ 数据驱动参数

---

#### network-code.md

**路径**: `src/networking/**`

**强制规则**:
- ✅ 服务器权威
- ✅ 版本化消息
- ✅ 安全考虑

**示例**:
```cpp
// ✅ 正确 - 服务器验证
void OnPlayerMove(Request& req) {
    if (!ValidatePosition(req.position)) {
        Reject(req);
        return;
    }
    Apply(req);
}

// ❌ 错误 - 客户端信任
void OnPlayerMove(Request& req) {
    Apply(req);  // 直接应用，不验证
}
```

---

#### ui-code.md

**路径**: `src/ui/**`

**强制规则**:
- ❌ 禁止游戏状态所有权（UI 只显示，不拥有）
- ✅ 本地化就绪
- ✅ 无障碍支持

**示例**:
```gdscript
# ✅ 正确 - UI 只绑定数据
func _update_health():
    health_bar.value = player.health

# ❌ 错误 - UI 修改数据
func _on_button_pressed():
    player.health += 10  # UI 不应该修改游戏状态
```

---

#### design-docs.md

**路径**: `design/gdd/**`

**强制规则**:
- ✅ 必需 8 个章节
- ✅ 公式使用标准格式
- ✅ 边界情况已记录

**必需章节**:
1. 系统概述
2. 目标与体验
3. 机制详解
4. 数学公式和数值
5. 边界情况和错误处理
6. UI/UX 需求
7. 音频需求
8. 与其他系统的关系

---

#### narrative.md

**路径**: `design/narrative/**`

**强制规则**:
- ✅ 传说一致性
- ✅ 角色声音
- ✅ 正典级别

---

#### data-files.md

**路径**: `assets/data/**`

**强制规则**:
- ✅ JSON 有效性
- ✅ 命名规范
- ✅ Schema 合规

**命名规范**:
- 小写
- 下划线分隔
- 包含类型前缀

**示例**:
```
✅ weapon_sword_iron.json
✅ enemy_orc_grunt.json
❌ SwordIron.json
❌ orc_grunt
```

---

#### test-standards.md

**路径**: `tests/**`

**强制规则**:
- ✅ 测试命名规范
- ✅ 覆盖率要求
- ✅ 夹具模式

**测试命名**:
```python
# ✅ 正确
def test_player_take_damage_reduces_health():
    pass

# ❌ 错误
def test_damage():
    pass
```

---

#### prototype-code.md

**路径**: `prototypes/**`

**强制规则**:
- ✅ 宽松标准（允许快速和粗糙）
- ✅ 必需 README（记录假设）
- ✅ 假设文档化

**README 必需内容**:
- 原型目标
- 测试假设
- 结论/结果

---

#### shader-code.md

**路径**: `assets/shaders/**`

**强制规则**:
- ✅ 命名规范
- ✅ 性能目标
- ✅ 跨平台规则

---

### 自定义 Rules

你可以添加自己的规则文件：

1. 在 `.codebuddy/rules/` 创建新的 `.md` 文件
2. 定义适用的路径模式
3. 描述规则和示例

**模板**:
```markdown
# [名称] 规则

**路径**: `[路径模式]`

## 强制规则

- ✅ [必须做的]
- ❌ [禁止做的]

## 示例

### ✅ 正确
```
[正确示例]
```

### ❌ 错误
```
[错误示例]
```

## 原因

[为什么有这些规则]
```

---

## Hooks 和 Rules 最佳实践

### Hooks

1. **保持轻量**: Hook 执行时间应短（设置超时）
2. **不要阻塞**: 使用警告而非强制阻止，除非确实危险
3. **提供价值**: Hook 应该提供有用的信息或防止常见错误
4. **可配置**: 允许用户在某些情况下跳过

### Rules

1. **具体明确**: 规则应该清晰、可执行
2. **提供示例**: 展示正确和错误的做法
3. **解释原因**: 不只是"做什么"，还要解释"为什么"
4. **适度**: 规则应该帮助而非阻碍

---

## 故障排除

### Hook 不触发

检查 `.codebuddy/settings.json`:
- 事件名称拼写正确
- 命令路径正确
- 匹配器模式正确

### Rule 不生效

- 确认文件路径匹配规则中的模式
- 检查是否有多个规则冲突
- 验证规则文件格式

---

> **提示**: Hooks 和 Rules 是自动化的安全网，但最终决策权在用户。
