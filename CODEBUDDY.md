# Claude Code Game Studios -- Game Studio Agent Architecture

Indie game development managed through 48 coordinated CodeBuddy subagents.
Each agent owns a specific domain, enforcing separation of concerns and quality.

> **中文翻译**：独立游戏开发，由 48 个协调的 CodeBuddy 子代理管理。每个代理拥有特定领域，确保关注点分离和质量。

## Technology Stack / 技术栈

- **Engine / 引擎**: [CHOOSE: Godot 4 / Unity / Unreal Engine 5 / Cocos Creator]
- **Language / 语言**: [CHOOSE: GDScript / C# / C++ / Blueprint]
- **Version Control / 版本控制**: Git with trunk-based development / Git 与主干开发
- **Build System / 构建系统**: [SPECIFY after choosing engine / 选择引擎后指定]
- **Asset Pipeline / 资产管线**: [SPECIFY after choosing engine / 选择引擎后指定]

> **Note**: Engine-specialist agents exist for Godot, Unity, Unreal, and Cocos Creator with
> dedicated sub-specialists. Use the set matching your engine.
>
> **注意**：Godot、Unity、Unreal 和 Cocos Creator 均有引擎专家代理及专用子专家。请使用与你的引擎匹配的代理集。

## Project Structure / 项目结构

@.codebuddy/docs/directory-structure.md

## Engine Version Reference / 引擎版本参考

The `@` import below points to the pinned engine version. Update it after
running `/setup-engine` to match your chosen engine:
> **中文翻译**：下面的 `@` 导入指向固定的引擎版本。运行 `/setup-engine` 后更新以匹配你选择的引擎：

- Godot: `@docs/engine-reference/godot/VERSION.md`
- Unity: `@docs/engine-reference/unity/VERSION.md`
- Unreal: `@docs/engine-reference/unreal/VERSION.md`
- Cocos Creator: `@docs/engine-reference/cocos/VERSION.md`

Current project engine: / 当前项目引擎：

## Technical Preferences / 技术偏好

@.codebuddy/docs/technical-preferences.md

## Coordination Rules / 协调规则

@.codebuddy/docs/coordination-rules.md

## Collaboration Protocol / 协作协议

**User-driven collaboration, not autonomous execution.**
Every task follows: **Question -> Options -> Decision -> Draft -> Approval**

> **中文翻译**：**用户驱动的协作，而非自主执行。**每个任务遵循：**提问 → 选项 → 决策 → 草案 → 批准**

- Agents MUST ask "May I write this to [filepath]?" before using Write/Edit tools / 代理在使用 Write/Edit 工具前必须询问"我可以写入[文件路径]吗？"
- Agents MUST show drafts or summaries before requesting approval / 代理在请求批准前必须展示草案或摘要
- Multi-file changes require explicit approval for the full changeset / 多文件更改需要对完整变更集的明确批准
- No commits without user instruction / 未经用户指示不得提交

See `docs/COLLABORATIVE-DESIGN-PRINCIPLE.md` for full protocol and examples.
> **中文翻译**：完整协议和示例请参见 `docs/COLLABORATIVE-DESIGN-PRINCIPLE.md`。

> **First session? / 首次会话？** If the project has no engine configured and no game concept,
> run `/start` to begin the guided onboarding flow.
> 运行 `/start` 开始引导式入职流程。

## Coding Standards / 编码标准

@.codebuddy/docs/coding-standards.md

## Context Management / 上下文管理

@.codebuddy/docs/context-management.md
