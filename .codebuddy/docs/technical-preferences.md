# Technical Preferences / 技术偏好

<!-- Populated by /setup-engine. Updated as the user makes decisions throughout development. -->
<!-- All agents reference this file for project-specific standards and conventions. -->

<!-- 中文翻译：由 /setup-engine 填充。随用户在开发过程中做出决策而更新。 -->
<!-- 中文翻译：所有代理参考此文件获取项目特定的标准和约定。 -->

## Engine & Language / 引擎与语言

- **Engine**: [TO BE CONFIGURED — run /setup-engine]
  > **中文翻译**：**引擎**：[待配置 — 运行 /setup-engine]
- **Language**: [TO BE CONFIGURED]
  > **中文翻译**：**语言**：[待配置]
- **Rendering**: [TO BE CONFIGURED]
  > **中文翻译**：**渲染**：[待配置]
- **Physics**: [TO BE CONFIGURED]
  > **中文翻译**：**物理**：[待配置]

## Input & Platform / 输入与平台

<!-- Written by /setup-engine. Read by /ux-design, /ux-review, /test-setup, /team-ui, and /dev-story -->
<!-- to scope interaction specs, test helpers, and implementation to the correct input methods. -->

<!-- 中文翻译：由 /setup-engine 写入。被 /ux-design、/ux-review、/test-setup、/team-ui 和 /dev-story 读取 -->
<!-- 中文翻译：用于将交互规格、测试辅助和实现限定到正确的输入方法。 -->

- **Target Platforms**: [TO BE CONFIGURED — e.g., PC, Console, Mobile, Web]
  > **中文翻译**：**目标平台**：[待配置 — 例如：PC、主机、移动端、Web]
- **Input Methods**: [TO BE CONFIGURED — e.g., Keyboard/Mouse, Gamepad, Touch, Mixed]
  > **中文翻译**：**输入方法**：[待配置 — 例如：键盘/鼠标、手柄、触屏、混合]
- **Primary Input**: [TO BE CONFIGURED — the dominant input for this game]
  > **中文翻译**：**主要输入**：[待配置 — 本游戏的主要输入方式]
- **Gamepad Support**: [TO BE CONFIGURED — Full / Partial / None]
  > **中文翻译**：**手柄支持**：[待配置 — 完整 / 部分 / 无]
- **Touch Support**: [TO BE CONFIGURED — Full / Partial / None]
  > **中文翻译**：**触屏支持**：[待配置 — 完整 / 部分 / 无]
- **Platform Notes**: [TO BE CONFIGURED — any platform-specific UX constraints]
  > **中文翻译**：**平台备注**：[待配置 — 任何平台特定的UX约束]

## Naming Conventions / 命名约定

- **Classes**: [TO BE CONFIGURED]
  > **中文翻译**：**类**：[待配置]
- **Variables**: [TO BE CONFIGURED]
  > **中文翻译**：**变量**：[待配置]
- **Signals/Events**: [TO BE CONFIGURED]
  > **中文翻译**：**信号/事件**：[待配置]
- **Files**: [TO BE CONFIGURED]
  > **中文翻译**：**文件**：[待配置]
- **Scenes/Prefabs**: [TO BE CONFIGURED]
  > **中文翻译**：**场景/预制体**：[待配置]
- **Constants**: [TO BE CONFIGURED]
  > **中文翻译**：**常量**：[待配置]

## Performance Budgets / 性能预算

- **Target Framerate**: [TO BE CONFIGURED]
  > **中文翻译**：**目标帧率**：[待配置]
- **Frame Budget**: [TO BE CONFIGURED]
  > **中文翻译**：**帧预算**：[待配置]
- **Draw Calls**: [TO BE CONFIGURED]
  > **中文翻译**：**绘制调用**：[待配置]
- **Memory Ceiling**: [TO BE CONFIGURED]
  > **中文翻译**：**内存上限**：[待配置]

## Testing / 测试

- **Framework**: [TO BE CONFIGURED]
  > **中文翻译**：**框架**：[待配置]
- **Minimum Coverage**: [TO BE CONFIGURED]
  > **中文翻译**：**最低覆盖率**：[待配置]
- **Required Tests**: Balance formulas, gameplay systems, networking (if applicable)
  > **中文翻译**：**必需测试**：平衡公式、游戏系统、网络（如适用）

## Forbidden Patterns / 禁止模式

<!-- Add patterns that should never appear in this project's codebase -->
<!-- 中文翻译：添加永远不应出现在本项目代码库中的模式 -->
- [None configured yet — add as architectural decisions are made]
  > **中文翻译**：[尚未配置 — 随架构决策做出后添加]

## Allowed Libraries / Addons / 允许的库/插件

<!-- Add approved third-party dependencies here -->
<!-- 中文翻译：在此添加已批准的第三方依赖 -->
- [None configured yet — add as dependencies are approved]
  > **中文翻译**：[尚未配置 — 随依赖批准后添加]

## Architecture Decisions Log / 架构决策日志

<!-- Quick reference linking to full ADRs in docs/architecture/ -->
<!-- 中文翻译：链接到 docs/architecture/ 中完整ADR的快速参考 -->
- [No ADRs yet — use /architecture-decision to create one]
  > **中文翻译**：[尚无ADR — 使用 /architecture-decision 创建]

## Engine Specialists / 引擎专家

<!-- Written by /setup-engine when engine is configured. -->
<!-- Read by /code-review, /architecture-decision, /architecture-review, and team skills -->
<!-- to know which specialist to spawn for engine-specific validation. -->

<!-- 中文翻译：引擎配置时由 /setup-engine 写入。 -->
<!-- 中文翻译：被 /code-review、/architecture-decision、/architecture-review 和团队技能读取 -->
<!-- 中文翻译：以了解为引擎特定验证生成哪个专家。 -->

- **Primary**: [TO BE CONFIGURED — run /setup-engine]
  > **中文翻译**：**主要**：[待配置 — 运行 /setup-engine]
- **Language/Code Specialist**: [TO BE CONFIGURED]
  > **中文翻译**：**语言/代码专家**：[待配置]
- **Shader Specialist**: [TO BE CONFIGURED]
  > **中文翻译**：**着色器专家**：[待配置]
- **UI Specialist**: [TO BE CONFIGURED]
  > **中文翻译**：**UI专家**：[待配置]
- **Additional Specialists**: [TO BE CONFIGURED]
  > **中文翻译**：**附加专家**：[待配置]
- **Routing Notes**: [TO BE CONFIGURED]
  > **中文翻译**：**路由备注**：[待配置]

### File Extension Routing / 文件扩展名路由

<!-- Skills use this table to select the right specialist per file type. -->
<!-- If a row says [TO BE CONFIGURED], fall back to Primary for that file type. -->

<!-- 中文翻译：技能使用此表为每种文件类型选择正确的专家。 -->
<!-- 中文翻译：如果某行显示 [TO BE CONFIGURED]，则该文件类型回退到主要专家。 -->

| File Extension / Type | Specialist to Spawn |
|-----------------------|---------------------|
| Game code (primary language) | [TO BE CONFIGURED] |
| Shader / material files | [TO BE CONFIGURED] |
| UI / screen files | [TO BE CONFIGURED] |
| Scene / prefab / level files | [TO BE CONFIGURED] |
| Native extension / plugin files | [TO BE CONFIGURED] |
| General architecture review | Primary |

> **中文翻译**：

| 文件扩展名/类型 | 要生成的专家 |
|----------------|------------|
| 游戏代码（主要语言） | [待配置] |
| 着色器/材质文件 | [待配置] |
| UI/界面文件 | [待配置] |
| 场景/预制体/关卡文件 | [待配置] |
| 原生扩展/插件文件 | [待配置] |
| 通用架构审查 | 主要专家 |
