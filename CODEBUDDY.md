# Claude Code Game Studios -- Game Studio Agent Architecture / Claude Code 游戏工作室 -- 游戏工作室代理架构

Indie game development managed through 48 coordinated CodeBuddy subagents.
通过 48 个协调的 CodeBuddy 子代理管理独立游戏开发。
Each agent owns a specific domain, enforcing separation of concerns and quality.
每个代理拥有特定的领域，执行关注点分离和质量控制。

## Technology Stack / 技术栈

- **Engine**: [CHOOSE: Godot 4 / Unity / Unreal Engine 5] / 引擎
- **Language**: [CHOOSE: GDScript / C# / C++ / Blueprint] / 语言
- **Version Control**: Git with trunk-based development / 版本控制：基于主干的Git开发
- **Build System**: [SPECIFY after choosing engine] / 构建系统
- **Asset Pipeline**: [SPECIFY after choosing engine] / 资源管线

> **Note** / **注意**: Engine-specialist agents exist for Godot, Unity, and Unreal with
> Godot、Unity 和 Unreal 都有专门的引擎专家代理，
> dedicated sub-specialists. Use the set matching your engine.
> 配备专门的子专家。请使用与您引擎匹配的代理集合。

## Project Structure / 项目结构

@.codebuddy/docs/directory-structure.md

## Engine Version Reference / 引擎版本参考

@docs/engine-reference/[engine]/VERSION.md

## Technical Preferences / 技术偏好

@.codebuddy/docs/technical-preferences.md

## Coordination Rules / 协调规则

@.codebuddy/docs/coordination-rules.md

## Collaboration Protocol / 协作协议

**User-driven collaboration, not autonomous execution.** / **用户驱动的协作，而非自主执行。**
Every task follows: **Question -> Options -> Decision -> Draft -> Approval** / 每个任务遵循：**提问 -> 选项 -> 决策 -> 草稿 -> 批准**

- Agents MUST ask "May I write this to [filepath]?" before using Write/Edit tools / 代理在使用写入/编辑工具之前必须询问"我可以将此写入 [filepath] 吗？"
- Agents MUST show drafts or summaries before requesting approval / 代理在请求批准之前必须展示草稿或摘要
- Multi-file changes require explicit approval for the full changeset / 多文件更改需要对整个更改集的明确批准
- No commits without user instruction / 未经用户指示不得提交

See `docs/COLLABORATIVE-DESIGN-PRINCIPLE.md` for full protocol and examples.
查看 `docs/COLLABORATIVE-DESIGN-PRINCIPLE.md` 获取完整协议和示例。

> **First session?** If the project has no engine configured and no game concept,
> **首次会话？** 如果项目尚未配置引擎且没有游戏概念，
> run `/start` to begin the guided onboarding flow.
> 运行 `/start` 开始引导式入门流程。

## Coding Standards / 编码标准

@.codebuddy/docs/coding-standards.md

## Context Management / 上下文管理

@.codebuddy/docs/context-management.md
