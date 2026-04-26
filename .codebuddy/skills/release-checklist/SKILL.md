---
name: release-checklist
description: "Generates a comprehensive pre-release validation checklist covering build verification, certification requirements, store metadata, and launch readiness. / 生成全面的发布前验证清单，涵盖构建验证、认证要求、商店元数据和发布就绪度。"
argument-hint: "[platform: pc|console|mobile|all]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
---

> **Explicit invocation only**: This skill should only run when the user explicitly requests it with `/release-checklist`. Do not auto-invoke based on context matching.
> **中文翻译**：**仅限显式调用**：此技能仅应在用户使用 `/release-checklist` 显式请求时运行。不要基于上下文匹配自动调用。

## Phase 1: Parse Arguments / 第 1 阶段：解析参数

<!-- 读取目标平台参数 -->
Read the argument for the target platform (`pc`, `console`, `mobile`, or `all`). If no platform is specified, default to `all`.
> **中文翻译**：读取目标平台参数（`pc`、`console`、`mobile` 或 `all`）。如果未指定平台，默认为 `all`。

---

## Phase 2: Load Project Context / 第 2 阶段：加载项目上下文

- Read `CODEBUDDY.md` for project context, version information, and platform targets. / 读取 `CODEBUDDY.md` 获取项目上下文、版本信息和平台目标。
- Read the current milestone from `production/milestones/` to understand what features and content should be included in this release. / 从 `production/milestones/` 读取当前里程碑，了解此发布应包含的功能和内容。

---

## Phase 3: Scan Codebase / 第 3 阶段：扫描代码库

Scan for outstanding issues: / 扫描未解决的问题：

- Count `TODO` comments / 计算 `TODO` 注释
- Count `FIXME` comments / 计算 `FIXME` 注释
- Count `HACK` comments / 计算 `HACK` 注释
- Note their locations and severity / 记录其位置和严重程度

<!-- 检查测试结果 -->
Check for test results in any test output directories or CI logs if available.
> **中文翻译**：检查任何测试输出目录或 CI 日志中的测试结果（如有）。

---

## Phase 4: Generate the Release Checklist / 第 4 阶段：生成发布清单

```markdown
## Release Checklist: [Version] -- [Platform] / 发布清单：[版本] -- [平台]
Generated: [Date] / 生成时间：[日期]

### Codebase Health / 代码库健康状况
- TODO count: [N] ([list top 5 if many]) / TODO 计数：[N]（如很多则列出前 5 个）
- FIXME count: [N] ([list all -- these are potential blockers]) / FIXME 计数：[N]（列出所有 — 这些是潜在阻塞项）
- HACK count: [N] ([list all -- these need review]) / HACK 计数：[N]（列出所有 — 这些需要审查）

### Build Verification / 构建验证
- [ ] Clean build succeeds on all target platforms / 所有目标平台干净构建成功
- [ ] No compiler warnings (zero-warning policy) / 无编译器警告（零警告策略）
- [ ] All assets included and loading correctly / 所有资产已包含且正确加载
- [ ] Build size within budget ([target size]) / 构建大小在预算内（[目标大小]）
- [ ] Build version number correctly set ([version]) / 构建版本号正确设置（[版本]）
- [ ] Build is reproducible from tagged commit / 构建可从标记的提交重现

### Quality Gates / 质量门控
- [ ] Zero S1 (Critical) bugs / 零 S1（严重）缺陷
- [ ] Zero S2 (Major) bugs -- or documented exceptions with producer approval / 零 S2（主要）缺陷 — 或经制作人批准的已记录例外
- [ ] All critical path features tested and signed off by QA / 所有关键路径功能已测试并由 QA 签收
- [ ] Performance within budgets: / 性能在预算内：
  - [ ] Target FPS met on minimum spec hardware / 目标 FPS 在最低规格硬件上达标
  - [ ] Memory usage within budget / 内存使用在预算内
  - [ ] Load times within budget / 加载时间在预算内
  - [ ] No memory leaks over extended play sessions / 扩展游戏会话中无内存泄漏
- [ ] No regression from previous build / 与上一个构建相比无回归
- [ ] Soak test passed (4+ hours continuous play) / 浸泡测试通过（4 小时以上连续游玩）

### Content Complete / 内容完成
- [ ] All placeholder assets replaced with final versions / 所有占位符资产已替换为最终版本
- [ ] All TODO/FIXME in content files resolved or documented / 内容文件中所有 TODO/FIXME 已解决或记录
- [ ] All player-facing text proofread / 所有面向玩家的文本已校对
- [ ] All text localization-ready (no hardcoded strings) / 所有文本已为本地化做好准备（无硬编码字符串）
- [ ] Audio mix finalized and approved / 音频混音已完成并批准
- [ ] Credits complete and accurate / 鸣谢完整且准确
```

Add platform-specific sections based on the argument: / 根据参数添加平台特定章节：

**For `pc`: / 对于 `pc`：**
```markdown
### Platform Requirements: PC / 平台要求：PC
- [ ] Minimum and recommended specs verified and documented / 最低和推荐规格已验证并记录
- [ ] Keyboard+mouse controls fully functional / 键盘+鼠标控制完全可用
- [ ] Controller support tested (Xbox, PlayStation, generic) / 控制器支持已测试（Xbox、PlayStation、通用）
- [ ] Resolution scaling tested (1080p, 1440p, 4K, ultrawide) / 分辨率缩放已测试
- [ ] Windowed, borderless, and fullscreen modes working / 窗口、无边框和全屏模式正常
- [ ] Graphics settings save and load correctly / 图形设置保存和加载正确
- [ ] Steam/Epic/GOG SDK integrated and tested / Steam/Epic/GOG SDK 已集成并测试
- [ ] Achievements functional / 成就功能正常
- [ ] Cloud saves functional / 云存档功能正常
- [ ] Steam Deck compatibility verified (if targeting) / Steam Deck 兼容性已验证（如面向该平台）
```

**For `console`: / 对于 `console`：**
```markdown
### Platform Requirements: Console / 平台要求：主机
- [ ] TRC/TCR/Lotcheck requirements checklist complete / TRC/TCR/Lotcheck 要求清单完成
- [ ] Platform-specific controller prompts display correctly / 平台特定控制器提示正确显示
- [ ] Suspend/resume works correctly / 暂停/恢复正确工作
- [ ] User switching handled properly / 用户切换正确处理
- [ ] Network connectivity loss handled gracefully / 网络连接丢失优雅处理
- [ ] Storage full scenario handled / 存储满场景已处理
- [ ] Parental controls respected / 家长控制已遵守
- [ ] Platform-specific achievement/trophy integration tested / 平台特定成就/奖杯集成已测试
- [ ] First-party certification submission prepared / 第一方认证提交已准备
```

**For `mobile`: / 对于 `mobile`：**
```markdown
### Platform Requirements: Mobile / 平台要求：移动端
- [ ] App store guidelines compliance verified / 应用商店指南合规性已验证
- [ ] All required device permissions justified and documented / 所有必需的设备权限已论证并记录
- [ ] Privacy policy linked and accurate / 隐私政策已链接且准确
- [ ] Data safety/nutrition labels completed / 数据安全/营养标签已完成
- [ ] Touch controls tested on multiple screen sizes / 触摸控制在多种屏幕尺寸上测试
- [ ] Battery usage within acceptable range / 电池使用在可接受范围内
- [ ] Background behavior correct (pause, resume, terminate) / 后台行为正确（暂停、恢复、终止）
- [ ] Push notification permissions handled correctly / 推送通知权限正确处理
- [ ] In-app purchase flow tested (if applicable) / 应用内购买流程已测试（如适用）
- [ ] App size within store limits / 应用大小在商店限制内
```

**Store and launch sections (all platforms): / 商店和发布章节（所有平台）：**
```markdown
### Store / Distribution / 商店/分发
- [ ] Store page metadata complete and proofread / 商店页面元数据完整且已校对
  - [ ] Short description / 简短描述
  - [ ] Long description / 详细描述
  - [ ] Feature list / 功能列表
  - [ ] System requirements (PC) / 系统要求（PC）
- [ ] Screenshots up to date and per-platform resolution requirements met / 截图是最新的且符合各平台分辨率要求
- [ ] Trailers up to date / 预告片是最新的
- [ ] Key art and capsule images current / 主视觉图和封面图是最新的
- [ ] Age rating obtained and configured: / 年龄分级已获取并配置：
  - [ ] ESRB
  - [ ] PEGI
  - [ ] Other regional ratings as required / 其他地区性分级（如需要）
- [ ] Legal notices, EULA, and privacy policy in place / 法律声明、EULA 和隐私政策已就位
- [ ] Third-party license attributions complete / 第三方许可证归属已完成
- [ ] Pricing configured for all regions / 所有区域定价已配置

### Launch Readiness / 发布就绪
- [ ] Analytics / telemetry verified and receiving data / 分析/遥测已验证并接收数据
- [ ] Crash reporting configured and dashboard accessible / 崩溃报告已配置且仪表板可访问
- [ ] Day-one patch prepared and tested (if needed) / 首日补丁已准备并测试（如需要）
- [ ] On-call team schedule set for first 72 hours / 发布后 72 小时的值班团队计划已设定
- [ ] Community launch announcements drafted / 社区发布公告已起草
- [ ] Press/influencer keys prepared for distribution / 媒体/影响者密钥已准备分发
- [ ] Support team briefed on known issues and FAQ / 支持团队已了解已知问题和 FAQ
- [ ] Rollback plan documented (if critical issues found post-launch) / 回滚计划已记录（如发布后发现关键问题）

### Go / No-Go: [READY / NOT READY] / 继续/停止：[就绪/未就绪]

**Rationale:** / **理由：**
[Summary of readiness assessment. List any blocking items that must be
resolved before launch. If NOT READY, list the specific items that need
resolution and estimated time to address them.]
[发布就绪评估摘要。列出发布前必须解决的阻塞项。如果未就绪，列出需要解决的具体项目和预计处理时间。]

**Sign-offs Required:** / **必需签署：**
- [ ] QA Lead / QA 负责人
- [ ] Technical Director / 技术总监
- [ ] Producer / 制作人
- [ ] Creative Director / 创意总监
```

---

## Phase 5: Save Checklist / 第 5 阶段：保存清单

Present the checklist to the user with: total checklist items, number of known blockers (FIXME/HACK counts, known bugs).
> **中文翻译**：向用户展示清单：总检查项数、已知阻塞项数量（FIXME/HACK 计数、已知缺陷）。

Ask: "May I write this to `production/releases/release-checklist-[version].md`?"
> **中文翻译**：询问："我可以将其写入 `production/releases/release-checklist-[version].md` 吗？"

If yes, write the file, creating the directory if needed.
> **中文翻译**：如果同意，写入文件，如需要则创建目录。

---

## Phase 6: Next Steps / 第 6 阶段：后续步骤

- Run `/gate-check` for a formal phase gate verdict before proceeding to release. / 运行 `/gate-check` 在进入发布前获取正式的阶段门控裁决。
- Coordinate final sign-offs via `/team-release`. / 通过 `/team-release` 协调最终签署。
