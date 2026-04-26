# Hook Input/Output Schemas / 钩子输入/输出模式

This documents the JSON payloads each Claude Code hook receives on stdin for every event type.

> **中文翻译**：本文档记录了每种事件类型下 Claude Code 钩子通过 stdin 接收的 JSON 载荷。

## PreToolUse / 工具使用前

Fired before a tool is executed. Can **allow** (exit 0) or **block** (exit 2).

> **中文翻译**：在工具执行前触发。可以**允许**（退出码 0）或**阻止**（退出码 2）。

<!-- 中文翻译 -->
### PreToolUse: Bash

```json
{
  "tool_name": "Bash",
  "tool_input": {
    "command": "git commit -m 'feat: add player health system'",
    "description": "Commit changes with message",
    "timeout": 120000
  }
}
```

<!-- 中文翻译 -->
### PreToolUse: Write

```json
{
  "tool_name": "Write",
  "tool_input": {
    "file_path": "src/gameplay/health.gd",
    "content": "extends Node\n..."
  }
}
```

<!-- 中文翻译 -->
### PreToolUse: Edit

```json
{
  "tool_name": "Edit",
  "tool_input": {
    "file_path": "src/gameplay/health.gd",
    "old_string": "var health = 100",
    "new_string": "var health: int = 100"
  }
}
```

<!-- 中文翻译 -->
### PreToolUse: Read

```json
{
  "tool_name": "Read",
  "tool_input": {
    "file_path": "src/gameplay/health.gd"
  }
}
```

## PostToolUse / 工具使用后

Fired after a tool completes. **Cannot block** (exit code ignored for blocking). Stderr messages are shown as warnings.

> **中文翻译**：在工具完成后触发。**无法阻止**（退出码对阻止无效）。Stderr 消息作为警告显示。

<!-- 中文翻译 -->
### PostToolUse: Write

```json
{
  "tool_name": "Write",
  "tool_input": {
    "file_path": "assets/data/enemy_stats.json",
    "content": "{\"goblin\": {\"health\": 50}}"
  },
  "tool_output": "File written successfully"
}
```

<!-- 中文翻译 -->
### PostToolUse: Edit

```json
{
  "tool_name": "Edit",
  "tool_input": {
    "file_path": "assets/data/enemy_stats.json",
    "old_string": "\"health\": 50",
    "new_string": "\"health\": 75"
  },
  "tool_output": "File edited successfully"
}
```

## SubagentStart / 子代理启动

Fired when a subagent is spawned via the Task tool.

> **中文翻译**：通过 Task 工具生成子代理时触发。

```json
{
  "agent_name": "game-designer",
  "model": "sonnet",
  "description": "Design the combat healing mechanic"
}
```

## SessionStart / 会话启动

Fired when a Claude Code session begins. **No stdin input** — the hook just runs and its stdout is shown to Claude as context.

> **中文翻译**：Claude Code 会话开始时触发。**无 stdin 输入** — 钩子直接运行，其 stdout 作为上下文显示给 Claude。

## PreCompact / 压缩前

Fired before context window compression. **No stdin input** — the hook runs to save state before compression occurs.

> **中文翻译**：上下文窗口压缩前触发。**无 stdin 输入** — 钩子在压缩发生前运行以保存状态。

## Stop / 停止

Fired when the Claude Code session ends. **No stdin input** — the hook runs for cleanup and logging.

> **中文翻译**：Claude Code 会话结束时触发。**无 stdin 输入** — 钩子用于清理和日志记录。

## Exit Code Reference / 退出码参考

| Exit Code | Meaning | Applicable Events |
|-----------|---------|-------------------|
| 0 | Allow / Success | All events |
| 2 | Block (stderr shown to Claude) | PreToolUse only |
| Other | Treated as error, tool proceeds | All events |

> **中文翻译**：

| 退出码 | 含义 | 适用事件 |
|--------|------|----------|
| 0 | 允许/成功 | 所有事件 |
| 2 | 阻止（stderr 显示给 Claude） | 仅 PreToolUse |
| 其他 | 视为错误，工具继续执行 | 所有事件 |

## Notes / 注意事项

- Hooks receive JSON on **stdin** (pipe). Use `INPUT=$(cat)` to capture.
  > **中文翻译**：钩子通过 **stdin**（管道）接收 JSON。使用 `INPUT=$(cat)` 捕获。
- Parse with `jq` if available, fall back to `grep` for cross-platform compatibility.
  > **中文翻译**：如可用则用 `jq` 解析，否则使用 `grep` 以保证跨平台兼容性。
- On Windows, `grep -P` (Perl regex) is often unavailable. Use `grep -E` (POSIX extended) instead.
  > **中文翻译**：在 Windows 上，`grep -P`（Perl 正则）通常不可用。改用 `grep -E`（POSIX 扩展）。
- Path separators may be `\` on Windows. Normalize with `sed 's|\\|/|g'` when comparing paths.
  > **中文翻译**：Windows 上路径分隔符可能为 `\`。比较路径时用 `sed 's|\\|/|g'` 规范化。
