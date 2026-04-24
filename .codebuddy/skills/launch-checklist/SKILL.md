---
name: launch-checklist
description: "Complete launch readiness validation covering every department: code, content, store, marketing, community, infrastructure, legal, and go/no-go sign-offs. / 完整的发布就绪验证，涵盖每个部门：代码、内容、商店、营销、社区、基础设施、法律和继续/停止签署。"
argument-hint: "[launch-date or 'dry-run']"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
---

> **Explicit invocation only**: This skill should only run when the user explicitly requests it with `/launch-checklist`. Do not auto-invoke based on context matching.
> **中文翻译**：**仅限显式调用**：此技能仅应在用户使用 `/launch-checklist` 显式请求时运行。不要基于上下文匹配自动调用。

## Phase 1: Parse Arguments / 第 1 阶段：解析参数

Read the argument for the launch date or `dry-run` mode. Dry-run mode generates the checklist without creating sign-off entries or writing files.
> **中文翻译**：读取发布日期参数或 `dry-run` 模式。Dry-run 模式生成检查清单但不创建签署条目或写入文件。

---

## Phase 2: Gather Project Context / 第 2 阶段：收集项目上下文

- Read `CODEBUDDY.md` for tech stack, target platforms, and team structure / 读取 `CODEBUDDY.md` 获取技术栈、目标平台和团队结构
- Read the latest milestone in `production/milestones/` / 读取 `production/milestones/` 中最新的里程碑
- Read any existing release checklist in `production/releases/` / 读取 `production/releases/` 中现有的发布检查清单
- Read the content calendar in `design/live-ops/content-calendar.md` if it exists / 如存在则读取 `design/live-ops/content-calendar.md` 中的内容日历

---

## Phase 3: Scan Codebase Health / 第 3 阶段：扫描代码库健康状况

- Count `TODO`, `FIXME`, `HACK` comments and their locations / 计算 `TODO`、`FIXME`、`HACK` 注释及其位置
- Check for any `console.log`, `print()`, or debug output left in production code / 检查生产代码中是否遗留了 `console.log`、`print()` 或调试输出
- Check for placeholder assets (search for `placeholder`, `temp_`, `WIP_`) / 检查占位符资产（搜索 `placeholder`、`temp_`、`WIP_`）
- Check for hardcoded test/dev values (localhost, test credentials, debug flags) / 检查硬编码的测试/开发值（localhost、测试凭据、调试标志）

---

## Phase 4: Generate the Launch Checklist / 第 4 阶段：生成发布检查清单

```markdown
# Launch Checklist: [Game Title] / 发布检查清单：[游戏标题]
Target Launch: [Date or DRY RUN] / 目标发布日期：[日期或试运行]
Generated: [Date] / 生成时间：[日期]

---

## 1. Code Readiness / 1. 代码就绪

### Build Health / 构建健康
- [ ] Clean build on all target platforms / 所有目标平台干净构建
- [ ] Zero compiler warnings / 零编译器警告
- [ ] All unit tests passing / 所有单元测试通过
- [ ] All integration tests passing / 所有集成测试通过
- [ ] Performance benchmarks within targets / 性能基准在目标范围内
- [ ] No memory leaks (verified via extended soak test) / 无内存泄漏（通过扩展浸泡测试验证）
- [ ] Build size within platform limits / 构建大小在平台限制内
- [ ] Build version correctly set and tagged in source control / 构建版本在源代码控制中正确设置和标记

### Code Quality / 代码质量
- [ ] TODO count: [N] (zero required for launch, or documented exceptions) / TODO 计数：[N]（发布要求为零，或已记录的例外）
- [ ] FIXME count: [N] (zero required) / FIXME 计数：[N]（要求为零）
- [ ] HACK count: [N] (each must have documented justification) / HACK 计数：[N]（每个必须有已记录的理由）
- [ ] No debug output in production code / 生产代码中无调试输出
- [ ] No hardcoded dev/test values / 无硬编码的开发/测试值
- [ ] All feature flags set to production values / 所有功能标志设为生产值
- [ ] Error handling covers all critical paths / 错误处理覆盖所有关键路径
- [ ] Crash reporting integrated and verified / 崩溃报告已集成并验证

### Security / 安全
- [ ] No exposed API keys or credentials in source / 源代码中无暴露的 API 密钥或凭据
- [ ] Save data encrypted / 存档数据已加密
- [ ] Network communication secured (TLS/DTLS) / 网络通信已加密（TLS/DTLS）
- [ ] Anti-cheat measures active (if multiplayer) / 反作弊措施已激活（如为多人游戏）
- [ ] Input validation on all server endpoints (if multiplayer) / 所有服务器端点已进行输入验证（如为多人游戏）
- [ ] Privacy policy compliance verified / 隐私政策合规性已验证

---

## 2. Content Readiness / 2. 内容就绪

### Assets / 资产
- [ ] All placeholder art replaced with final assets / 所有占位符美术已替换为最终资产
- [ ] All placeholder audio replaced with final audio / 所有占位符音频已替换为最终音频
- [ ] Audio mix finalized and approved by audio director / 音频混音已完成并由音频总监批准
- [ ] All VFX polished and performance-verified / 所有特效已打磨并验证性能
- [ ] No missing or broken asset references / 无缺失或断裂的资产引用
- [ ] Asset naming conventions enforced / 资产命名约定已执行

### Text and Localization / 文本与本地化
- [ ] All player-facing text proofread / 所有面向玩家的文本已校对
- [ ] No hardcoded strings (all externalized for localization) / 无硬编码字符串（所有已外部化供本地化）
- [ ] All supported languages translated and verified / 所有支持的语言已翻译并验证
- [ ] Text fits UI in all languages (text fitting pass complete) / 文本在所有语言中适配 UI（文本适配检查已完成）
- [ ] Font coverage verified for all supported languages / 所有支持语言的字体覆盖已验证
- [ ] Credits complete, accurate, and up to date / 鸣谢完整、准确且最新

### Game Content / 游戏内容
- [ ] All levels/maps playable from start to finish / 所有关卡/地图可从头玩到尾
- [ ] Tutorial flow complete and tested with new players / 教程流程已完成并与新玩家测试
- [ ] All achievements/trophies implemented and tested / 所有成就/奖杯已实现并测试
- [ ] Save/load works correctly for all game states / 存档/读档对所有游戏状态正确工作
- [ ] Difficulty settings balanced and tested / 难度设置已平衡并测试
- [ ] End-game/credits sequence complete / 终局/鸣谢序列已完成

---

## 3. Quality Assurance / 3. 质量保证

### Testing / 测试
- [ ] Full regression test suite passed / 完整回归测试套件已通过
- [ ] Zero S1 (Critical) bugs open / 零 S1（严重）缺陷开放
- [ ] Zero S2 (Major) bugs open (or documented exceptions) / 零 S2（主要）缺陷开放（或已记录的例外）
- [ ] Soak test passed (8+ hours continuous play) / 浸泡测试通过（8 小时以上连续游玩）
- [ ] Multiplayer stress test passed (if applicable) / 多人压力测试通过（如适用）
- [ ] All critical user paths tested on every platform / 所有关键用户路径在每个平台上测试
- [ ] Edge cases tested (full storage, no network, suspend/resume) / 边缘情况已测试（存储满、无网络、暂停/恢复）

### Platform Certification / 平台认证
- [ ] PC: Steam/Epic/GOG SDK requirements met / PC：Steam/Epic/GOG SDK 要求已满足
- [ ] Console: TRC/TCR/Lotcheck submission prepared / 主机：TRC/TCR/Lotcheck 提交已准备
- [ ] Mobile: App Store/Play Store guidelines compliant / 移动端：App Store/Play Store 指南合规
- [ ] Accessibility: minimum standards met (remapping, text scaling, colorblind) / 无障碍：最低标准已满足（重映射、文本缩放、色盲）
- [ ] Age ratings obtained (ESRB, PEGI, regional) / 年龄分级已获取（ESRB、PEGI、地区性）

### Performance / 性能
- [ ] Target FPS met on minimum spec hardware / 目标 FPS 在最低规格硬件上达标
- [ ] Load times within budget on all platforms / 加载时间在所有平台上在预算内
- [ ] Memory usage within budget on all platforms / 内存使用在所有平台上在预算内
- [ ] Network bandwidth within targets (if multiplayer) / 网络带宽在目标内（如为多人游戏）
- [ ] No frame hitches in critical gameplay moments / 关键游戏玩法时刻无帧卡顿

---

## 4. Store and Distribution / 4. 商店与分发

### Store Pages / 商店页面
- [ ] Store page copy finalized and proofread / 商店页面文案已定稿并校对
- [ ] Screenshots current and per-platform resolution / 截图是最新的且符合各平台分辨率
- [ ] Trailers current and approved / 预告片是最新的且已批准
- [ ] Key art and capsule images finalized / 主视觉图和封面图已定稿
- [ ] System requirements accurate (PC) / 系统要求准确（PC）
- [ ] Pricing configured for all regions / 所有区域定价已配置
- [ ] Pre-purchase/wishlist campaigns active (if applicable) / 预购/愿望清单活动已激活（如适用）

### Legal / 法律
- [ ] EULA finalized and approved by legal / EULA 已定稿并由法务批准
- [ ] Privacy policy published and linked / 隐私政策已发布并链接
- [ ] Third-party license attributions complete / 第三方许可证归属已完成
- [ ] Music/audio licensing verified / 音乐/音频许可已验证
- [ ] Trademark/IP clearance confirmed / 商标/知识产权清理已确认
- [ ] GDPR/CCPA compliance verified (data collection, consent, deletion) / GDPR/CCPA 合规性已验证（数据收集、同意、删除）

---

## 5. Infrastructure / 5. 基础设施

### Servers (if multiplayer/online) / 服务器（如为多人/在线）
- [ ] Production servers provisioned and load-tested / 生产服务器已配置并经过负载测试
- [ ] Auto-scaling configured and tested / 自动缩放已配置并测试
- [ ] Database backups configured / 数据库备份已配置
- [ ] CDN configured for content delivery / CDN 已配置用于内容分发
- [ ] DDoS protection active / DDoS 防护已激活
- [ ] Monitoring and alerting configured / 监控和告警已配置

### Analytics and Monitoring / 分析与监控
- [ ] Analytics pipeline verified and receiving data / 分析管线已验证并接收数据
- [ ] Crash reporting active and dashboard accessible / 崩溃报告已激活且仪表板可访问
- [ ] Server monitoring dashboards live / 服务器监控仪表板已上线
- [ ] Key metrics tracked: DAU, session length, retention, crashes / 关键指标已追踪：DAU、会话长度、留存率、崩溃
- [ ] Alerts configured for critical thresholds / 关键阈值告警已配置

---

## 6. Community and Marketing / 6. 社区与营销

### Community Readiness / 社区就绪
- [ ] Community guidelines published / 社区指南已发布
- [ ] Moderation team briefed and tools ready / 版主团队已简报且工具就绪
- [ ] Discord/forum/social channels set up / Discord/论坛/社交频道已建立
- [ ] FAQ and known issues page prepared / FAQ 和已知问题页面已准备
- [ ] Support email/ticketing system active / 支持邮件/工单系统已激活

### Marketing / 营销
- [ ] Launch trailer published / 发布预告片已发布
- [ ] Press/influencer review keys distributed / 媒体/影响者评测密钥已分发
- [ ] Social media launch posts scheduled / 社交媒体发布帖子已排期
- [ ] Launch day blog post/dev update drafted / 发布日博客文章/开发更新已起草
- [ ] Patch notes for launch version published / 发布版本的补丁说明已发布

---

## 7. Operations / 7. 运营

### Team Readiness / 团队就绪
- [ ] On-call schedule set for first 72 hours post-launch / 发布后 72 小时的值班计划已设定
- [ ] Incident response playbook reviewed by team / 事件响应手册已由团队审查
- [ ] Rollback plan documented and tested / 回滚计划已记录并测试
- [ ] Hotfix pipeline tested (can ship emergency fix within 4 hours) / 热修管线已测试（可在 4 小时内发布紧急修复）
- [ ] Communication plan for launch issues (who posts, where, how fast) / 发布问题的沟通计划（谁发布、在哪里、多快）

### Day-One Plan / 首日计划
- [ ] Day-one patch prepared (if needed) / 首日补丁已准备（如需要）
- [ ] Server unlock/go-live procedure documented / 服务器解锁/上线流程已记录
- [ ] Launch monitoring dashboard bookmarked by all leads / 发布监控仪表板已由所有主管收藏
- [ ] War room/channel established for launch day / 发布日作战室/频道已建立

---

## Go / No-Go Decision / 继续/停止决策

**Overall Status**: [READY / NOT READY / CONDITIONAL] / **整体状态**：[就绪/未就绪/有条件]

### Blocking Items / 阻塞项
[List any items that must be resolved before launch] / [列出发布前必须解决的所有项目]

### Conditional Items / 有条件项
[List items that have documented workarounds or accepted risk] / [列出有已记录的变通方案或已接受风险的项目]

### Sign-Offs Required / 必需签署
- [ ] Creative Director — Content and experience quality / 创意总监 — 内容和体验质量
- [ ] Technical Director — Technical health and stability / 技术总监 — 技术健康和稳定性
- [ ] QA Lead — Quality and test coverage / QA 负责人 — 质量和测试覆盖
- [ ] Producer — Schedule and overall readiness / 制作人 — 进度和整体就绪
- [ ] Release Manager — Build and deployment readiness / 发布经理 — 构建和部署就绪
```

---

## Phase 5: Save Checklist / 第 5 阶段：保存检查清单

Present the completed checklist and summary to the user (total items, blocking items count, conditional items count, departments with incomplete sections).
> **中文翻译**：向用户展示完成的检查清单和摘要（总项目数、阻塞项数量、有条件项数量、不完整部门的部门）。

If not in dry-run mode, ask: "May I write this to `production/releases/launch-checklist-[date].md`?"
> **中文翻译**：如果不是 dry-run 模式，询问："我可以将其写入 `production/releases/launch-checklist-[date].md` 吗？"

If yes, write the file, creating directories as needed.
> **中文翻译**：如果同意，写入文件，如需要则创建目录。

---

## Phase 6: Next Steps / 第 6 阶段：后续步骤

- Run `/gate-check` to get a formal PASS/CONCERNS/FAIL verdict before launch. / 运行 `/gate-check` 在发布前获取正式的 PASS/CONCERNS/FAIL 裁决。
- Coordinate sign-offs via `/team-release`. / 通过 `/team-release` 协调签署。
