# Claude Code Game Studios -- Game Studio Agent Architecture / Claude Code 游戏工作室 -- 游戏工作室代理架构

Indie game development managed through 48 coordinated CodeBuddy subagents.
Each agent owns a specific domain, enforcing separation of concerns and quality.

> **中文翻译**：独立游戏开发由 48 个协调的 CodeBuddy 子代理管理。每个代理拥有一个特定领域，强制关注点分离和质量保证。

## Technology Stack / 技术栈

- **Engine**: [CHOOSE: Godot 4 / Unity / Unreal Engine 5]
  > **中文翻译**：**引擎**：[选择：Godot 4 / Unity / Unreal Engine 5]
- **Language**: [CHOOSE: GDScript / C# / C++ / Blueprint]
  > **中文翻译**：**语言**：[选择：GDScript / C# / C++ / Blueprint]
- **Version Control**: Git with trunk-based development
  > **中文翻译**：**版本控制**：Git 主干开发模式
- **Build System**: [SPECIFY after choosing engine]
  > **中文翻译**：**构建系统**：[选择引擎后指定]
- **Asset Pipeline**: [SPECIFY after choosing engine]
  > **中文翻译**：**资产管线**：[选择引擎后指定]

> **Note**: Engine-specialist agents exist for Godot, Unity, and Unreal with
> dedicated sub-specialists. Use the set matching your engine.

> **中文翻译**：**注意**：Godot、Unity 和 Unreal 都有引擎专家代理，配有专门的子专家。请使用与你的引擎匹配的专家组。

## Project Structure / 项目结构

@.codebuddy/docs/directory-structure.md

## Engine Version Reference / 引擎版本参考

@docs/engine-reference/godot/VERSION.md

## Technical Preferences / 技术偏好

@.codebuddy/docs/technical-preferences.md

## Coordination Rules / 协调规则

@.codebuddy/docs/coordination-rules.md

## Collaboration Protocol / 协作协议

**User-driven collaboration, not autonomous execution.**
Every task follows: **Question -> Options -> Decision -> Draft -> Approval**

> **中文翻译**：**用户驱动的协作，而非自主执行。** 每个任务遵循：**提问 -> 选项 -> 决策 -> 草案 -> 批准**

- Agents MUST ask "May I write this to [filepath]?" before using Write/Edit tools
  > **中文翻译**：代理必须在使用 Write/Edit 工具前询问"我可以写入到 [文件路径] 吗？"
- Agents MUST show drafts or summaries before requesting approval
  > **中文翻译**：代理必须在请求批准前展示草案或摘要
- Multi-file changes require explicit approval for the full changeset
  > **中文翻译**：多文件变更需要对完整变更集的明确批准
- No commits without user instruction
  > **中文翻译**：未经用户指示不得提交

See `docs/COLLABORATIVE-DESIGN-PRINCIPLE.md` for full protocol and examples.

> **中文翻译**：完整协议和示例参见 `docs/COLLABORATIVE-DESIGN-PRINCIPLE.md`。

> **First session?** If the project has no engine configured and no game concept,
> run `/start` to begin the guided onboarding flow.

> **中文翻译**：**首次使用？** 如果项目尚未配置引擎且没有游戏概念，运行 `/start` 开始引导入门流程。

## Coding Standards / 编码标准

@.codebuddy/docs/coding-standards.md

## Context Management / 上下文管理

@.codebuddy/docs/context-management.md
