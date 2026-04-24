---
name: security-audit
description: "Audit the game for security vulnerabilities: save tampering, cheat vectors, network exploits, data exposure, and input validation gaps. Produces a prioritised security report with remediation guidance. Run before any public release or multiplayer launch. / 审计游戏安全漏洞：存档篡改、作弊向量、网络利用、数据暴露和输入验证缺口。生成带修复指导的优先级安全报告。在任何公开发布或多玩家上线前运行。"
argument-hint: "[full | network | save | input | quick]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash, Write, Task
agent: security-engineer
---

# Security Audit / 安全审计

Security is not optional for any shipped game. Even single-player games have
save tampering vectors. Multiplayer games have cheat surfaces, data exposure
risks, and denial-of-service potential. This skill systematically audits the
codebase for the most common game security failures and produces a prioritised
remediation plan.

> **中文翻译**：安全对于任何已发布的游戏都不是可选项。即使是单机游戏也存在存档篡改向量。多人游戏则面临作弊面、数据暴露风险和拒绝服务攻击的可能性。此技能系统性地审计代码库中最常见的游戏安全故障，并生成优先级修复计划。

**Run this skill:** / **运行此技能：**
- Before any public release (required for the Polish → Release gate) / 在任何公开发布之前（Polish → Release 门控所必需）
- Before enabling any online/multiplayer feature / 在启用任何在线/多人功能之前
- After implementing any system that reads from disk or network / 在实现任何从磁盘或网络读取的系统之后
- When a security-related bug is reported / 当报告了安全相关缺陷时

**Output:** `production/security/security-audit-[date].md`

---

## Phase 1: Parse Arguments and Scope / 阶段1：解析参数和范围

**Modes:** / **模式：**
- `full` — all categories (recommended before release) / 所有类别（发布前推荐）
- `network` — network/multiplayer only / 仅网络/多人
- `save` — save file and serialization only / 仅存档文件和序列化
- `input` — input validation and injection only / 仅输入验证和注入
- `quick` — high-severity checks only (fastest, for iterative use) / 仅高严重性检查（最快，用于迭代使用）
- No argument — run `full` / 无参数 — 运行 `full`

Read `.codebuddy/docs/technical-preferences.md` to determine: / 读取 `.codebuddy/docs/technical-preferences.md` 以确定：
- Engine and language (affects which patterns to search for) / 引擎和语言（影响搜索哪些模式）
- Target platforms (affects which attack surfaces apply) / 目标平台（影响哪些攻击面适用）
- Whether multiplayer/networking is in scope / 多人/网络是否在范围内

---

## Phase 2: Spawn Security Engineer / 阶段2：生成安全工程师

Spawn `security-engineer` via Task. Pass: / 通过 Task 生成 `security-engineer`。传递：
- The audit scope/mode / 审计范围/模式
- Engine and language from technical preferences / 来自技术偏好的引擎和语言
- A manifest of all source directories: `src/`, `assets/data/`, any config files / 所有源目录的清单：`src/`、`assets/data/`、任何配置文件

The security-engineer runs the audit across 6 categories (see Phase 3). Collect their full findings before proceeding.

> **中文翻译**：安全工程师跨6个类别运行审计（见阶段3）。在继续之前收集其完整发现。

---

## Phase 3: Audit Categories / 阶段3：审计类别

The security-engineer evaluates each of the following. Skip categories not applicable to the project scope.

> **中文翻译**：安全工程师评估以下每一项。跳过不适用于项目范围的类别。

### Category 1: Save File and Serialization Security / 类别1：存档文件和序列化安全
- Are save files validated before loading? (no blind deserialization) / 存档文件在加载前是否经过验证？（无盲目反序列化）
- Are save file paths constructed from user input? (path traversal risk) / 存档文件路径是否从用户输入构建？（路径遍历风险）
- Are save files checksummed or signed? (tamper detection) / 存档文件是否有校验和或签名？（篡改检测）
- Does the game trust numeric values from save files without bounds checking? / 游戏是否未经边界检查就信任存档文件中的数值？
- Are there any eval() or dynamic code execution calls near save loading? / 存档加载附近是否有 eval() 或动态代码执行调用？

Grep patterns: `File.open`, `load`, `deserialize`, `JSON.parse`, `from_json`, `read_file` — check each for validation.

> **中文翻译**：Grep 模式：`File.open`、`load`、`deserialize`、`JSON.parse`、`from_json`、`read_file` — 检查每一项是否有验证。

### Category 2: Network and Multiplayer Security (skip if single-player only) / 类别2：网络和多人安全（仅单机时跳过）
- Is game state authoritative on the server, or does the client dictate outcomes? / 游戏状态是否由服务器权威控制，还是由客户端决定结果？
- Are incoming network packets validated for size, type, and value range? / 传入的网络数据包是否验证了大小、类型和值范围？
- Are player positions and state changes validated server-side? / 玩家位置和状态变化是否在服务器端验证？
- Is there rate limiting on any network calls? / 任何网络调用是否有速率限制？
- Are authentication tokens handled correctly (never sent in plaintext)? / 认证令牌是否正确处理（从不以明文发送）？
- Does the game expose any debug endpoints in release builds? / 游戏是否在发布版本中暴露了任何调试端点？

Grep for: `recv`, `receive`, `PacketPeer`, `socket`, `NetworkedMultiplayerPeer`, `rpc`, `rpc_id` — check each call site for validation.

> **中文翻译**：Grep 搜索：`recv`、`receive`、`PacketPeer`、`socket`、`NetworkedMultiplayerPeer`、`rpc`、`rpc_id` — 检查每个调用点是否有验证。

### Category 3: Input Validation / 类别3：输入验证
- Are any player-supplied strings used in file paths? (path traversal) / 是否有任何玩家提供的字符串用于文件路径？（路径遍历）
- Are any player-supplied strings logged without sanitization? (log injection) / 是否有任何玩家提供的字符串未经清理就被记录？（日志注入）
- Are numeric inputs (e.g., item quantities, character stats) bounds-checked before use? / 数值输入（如物品数量、角色属性）在使用前是否进行了边界检查？
- Are achievement/stat values checked before being written to any backend? / 成就/统计值在写入任何后端之前是否经过检查？

Grep for: `get_input`, `Input.get_`, `input_map`, user-facing text fields — check validation.

> **中文翻译**：Grep 搜索：`get_input`、`Input.get_`、`input_map`、面向用户的文本字段 — 检查验证。

### Category 4: Data Exposure / 类别4：数据暴露
- Are any API keys, credentials, or secrets hardcoded in `src/` or `assets/`? / 是否有任何 API 密钥、凭据或秘密硬编码在 `src/` 或 `assets/` 中？
- Are debug symbols or verbose error messages included in release builds? / 发布版本中是否包含调试符号或详细错误消息？
- Does the game log sensitive player data to disk or console? / 游戏是否将敏感玩家数据记录到磁盘或控制台？
- Are any internal file paths or system information exposed to players? / 是否有任何内部文件路径或系统信息暴露给玩家？

Grep for: `api_key`, `secret`, `password`, `token`, `private_key`, `DEBUG`, `print(` in release-facing code.

> **中文翻译**：Grep 搜索：发布面向代码中的 `api_key`、`secret`、`password`、`token`、`private_key`、`DEBUG`、`print(`。

### Category 5: Cheat and Anti-Tamper Vectors / 类别5：作弊和反篡改向量
- Are gameplay-critical values stored only in memory, not in easily-editable files? / 游戏关键值是否仅存储在内存中，而非易编辑的文件中？
- Are any critical game progression flags (e.g., "has paid for DLC") validated server-side? / 是否有任何关键游戏进度标志（如"已付费购买 DLC"）在服务器端验证？
- Is there any protection against memory editing tools (Cheat Engine, etc.) for multiplayer? / 多人游戏中是否有任何针对内存编辑工具（如 Cheat Engine 等）的保护？
- Are leaderboard/score submissions validated before acceptance? / 排行榜/分数提交在接收前是否经过验证？

Note: Client-side anti-cheat is largely unenforceable. Focus on server-side validation for anything competitive or monetised.

> **中文翻译**：注意：客户端反作弊在很大程度上无法强制执行。对于任何竞争性或货币化的内容，应专注于服务器端验证。

### Category 6: Dependency and Supply Chain / 类别6：依赖和供应链
- Are any third-party plugins or libraries used? List them. / 是否使用了任何第三方插件或库？列出它们。
- Do any plugins have known CVEs in the version being used? / 任何插件在所使用的版本中是否有已知的 CVE？
- Are plugin sources verified (official marketplace, reviewed repository)? / 插件来源是否经过验证（官方市场、已审查的仓库）？

Glob for: `addons/`, `plugins/`, `third_party/`, `vendor/` — list all external dependencies.

> **中文翻译**：Glob 搜索：`addons/`、`plugins/`、`third_party/`、`vendor/` — 列出所有外部依赖。

---

## Phase 4: Classify Findings / 阶段4：分类发现

For each finding, assign: / 对每个发现，分配：

**Severity:** / **严重性：**
| Level | Definition |
|-------|-----------|
| **CRITICAL** | Remote code execution, data breach, or trivially-exploitable cheat that breaks multiplayer integrity / 远程代码执行、数据泄露或轻易可利用的破坏多人完整性的作弊 |
| **HIGH** | Save tampering that bypasses progression, credential exposure, or server-side authority bypass / 绕过进度的存档篡改、凭据暴露或服务器端权限绕过 |
| **MEDIUM** | Client-side cheat enablement, information disclosure, or input validation gap with limited impact / 客户端作弊启用、信息泄露或影响有限的输入验证缺口 |
| **LOW** | Defence-in-depth improvement — hardening that reduces attack surface but no direct exploit exists / 纵深防御改进 — 减少攻击面的加固但不存在直接利用 |

**Status:** Open / Accepted Risk / Out of Scope / **状态：** 开放 / 已接受风险 / 超出范围

---

## Phase 5: Generate Report / 阶段5：生成报告

```markdown
# Security Audit Report

**Date**: [date]
**Scope**: [full | network | save | input | quick]
**Engine**: [engine + version]
**Audited by**: security-engineer via /security-audit
**Files scanned**: [N source files, N config files]

---

## Executive Summary

| Severity | Count | Must Fix Before Release |
|----------|-------|------------------------|
| CRITICAL | [N] | Yes — all |
| HIGH | [N] | Yes — all |
| MEDIUM | [N] | Recommended |
| LOW | [N] | Optional |

**Release recommendation**: [CLEAR TO SHIP / FIX CRITICALS FIRST / DO NOT SHIP]

---

## CRITICAL Findings

### SEC-001: [Title]
**Category**: [Save / Network / Input / Data / Cheat / Dependency]
**File**: `[path]` line [N]
**Description**: [What the vulnerability is]
**Attack scenario**: [How a malicious user would exploit it]
**Remediation**: [Specific code change or pattern to apply]
**Effort**: [Low / Medium / High]

[repeat per finding]

---

## HIGH Findings

[same format]

---

## MEDIUM Findings

[same format]

---

## LOW Findings

[same format]

---

## Accepted Risk

[Any findings explicitly accepted by the team with rationale]

---

## Dependency Inventory

| Plugin / Library | Version | Source | Known CVEs |
|-----------------|---------|--------|------------|
| [name] | [version] | [source] | [none / CVE-XXXX-NNNN] |

---

## Remediation Priority Order

1. [SEC-NNN] — [1-line description] — Est. effort: [Low/Medium/High]
2. ...

---

## Re-Audit Trigger

Run `/security-audit` again after remediating any CRITICAL or HIGH findings.
The Polish → Release gate requires this report with no open CRITICAL or HIGH items.
```

---

## Phase 6: Write Report / 阶段6：写入报告

Present the report summary (executive summary + CRITICAL/HIGH findings only) in conversation.

> **中文翻译**：在对话中呈现报告摘要（仅执行摘要 + CRITICAL/HIGH 发现）。

Ask: "May I write the full security audit report to `production/security/security-audit-[date].md`?"

> **中文翻译**：询问："我可以将完整的安全审计报告写入 `production/security/security-audit-[date].md` 吗？"

Write only after approval. / 仅在批准后写入。

---

## Phase 7: Gate Integration / 阶段7：门控集成

This report is a required artifact for the **Polish → Release gate**.

> **中文翻译**：此报告是 **Polish → Release 门控** 的必需工件。

After remediating findings, re-run: `/security-audit quick` to confirm CRITICAL/HIGH items are resolved before running `/gate-check release`.

> **中文翻译**：修复发现后，重新运行：`/security-audit quick` 以确认 CRITICAL/HIGH 项已解决，然后再运行 `/gate-check release`。

If CRITICAL findings exist: / 如果存在 CRITICAL 发现：
> "⛔ CRITICAL security findings must be resolved before any public release. Do not proceed to `/launch-checklist` until these are addressed."

> **中文翻译**："⛔ CRITICAL 安全发现必须在任何公开发布前解决。在解决这些问题之前，不要进入 `/launch-checklist`。"

If no CRITICAL/HIGH findings: / 如果没有 CRITICAL/HIGH 发现：
> "✅ No blocking security findings. Report written to `production/security/`. Include this path when running `/gate-check release`."

> **中文翻译**："✅ 无阻塞性安全发现。报告已写入 `production/security/`。运行 `/gate-check release` 时包含此路径。"

---

## Collaborative Protocol / 协作协议

- **Never assume a pattern is safe** — flag it and let the user decide / **绝不假设一个模式是安全的** — 标记它并让用户决定
- **Accepted risk is a valid outcome** — some LOW findings are acceptable trade-offs for a solo team; document the decision / **已接受风险是有效结果** — 对于独立团队来说，一些 LOW 发现是可接受的权衡；记录该决策
- **Multiplayer games have a higher bar** — any HIGH finding in a multiplayer context should be treated as CRITICAL / **多人游戏有更高标准** — 多人游戏环境中的任何 HIGH 发现应被视为 CRITICAL
- **This is not a penetration test** — this audit covers common patterns; a real pentest by a human security professional is recommended before any competitive or monetised multiplayer launch / **这不是渗透测试** — 此审计涵盖常见模式；在任何竞争性或货币化的多人游戏发布之前，建议由人类安全专业人员进行真正的渗透测试
