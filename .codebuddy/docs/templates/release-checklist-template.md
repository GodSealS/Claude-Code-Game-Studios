# Release Checklist: [Version] -- [Platform] / 发布清单：[版本] -- [平台]

**Release Date** / **发布日期**: [Target Date] / [目标日期]
**Release Manager** / **发布经理**: [Name] / [姓名]
**Status** / **状态**: [ ] GO / [ ] NO-GO / [ ] 进行 / [ ] 不进行

---

## Build Verification / 构建验证

- [ ] Clean build succeeds on all target platforms / 在所有目标平台上干净构建成功
- [ ] No compiler warnings (zero-warning policy) / 没有编译器警告（零警告策略）
- [ ] Build version number set correctly: `[version]` / 构建版本号正确设置：`[version]`
- [ ] Build is reproducible from tagged commit: `[commit hash]` / 构建可从标记提交重现：`[commit hash]`
- [ ] Build size within budget: [actual] / [budget] / 构建大小在预算内：[实际] / [预算]
- [ ] All assets included and loading correctly / 所有资产已包含并正确加载
- [ ] No debug/development features enabled in release build / 在发布构建中没有启用调试/开发功能

---

## Quality Gates / 质量关卡

### Critical Bugs / 严重错误
- [ ] Zero S1 (Critical) bugs open / 零个S1（严重）错误开放
- [ ] Zero S2 (Major) bugs -- or documented exceptions below: / 零个S2（主要）错误——或以下记录的例外情况：

| Bug ID / 错误ID | Description / 描述 | Exception Rationale / 例外理由 | Approved By / 批准人 |
| ---- | ---- | ---- | ---- |
| | | | |

### Test Coverage / 测试覆盖
- [ ] All critical path features tested and signed off / 所有关键路径功能已测试并签署
- [ ] Full regression suite passed: [pass rate]% / 完整回归测试套件通过：[通过率]%
- [ ] Soak test passed (4+ hours continuous play) / 浸泡测试通过（4小时以上连续游玩）
- [ ] Edge case testing complete / 边界情况测试完成

### Performance / 性能
- [ ] Target FPS met on minimum spec: [actual] / [target] FPS / 在最低配置下达到目标FPS：[实际] / [目标] FPS
- [ ] Memory usage within budget: [actual] / [budget] MB / 内存使用在预算内：[实际] / [预算] MB
- [ ] Load times within budget: [actual] / [target] seconds / 加载时间在预算内：[实际] / [目标] 秒
- [ ] No memory leaks over extended play (soak test) / 长时间游玩无内存泄漏（浸泡测试）
- [ ] No frame drops below [threshold] in normal gameplay / 正常游玩中帧率不低于[阈值]

---

<!-- 中文翻译 -->
## Content Complete / 内容完成

- [ ] All placeholder assets replaced with final versions / 所有占位符资产已替换为最终版本
- [ ] All player-facing text proofread / 所有面向玩家的文本已校对
- [ ] All text localization-ready (no hardcoded strings) / 所有文本已准备本地化（无硬编码字符串）
- [ ] Localization complete for: [list locales] / 本地化完成：[列表语言]
- [ ] Audio mix finalized and approved / 音频混音最终确定并批准
- [ ] Credits complete and accurate / 制作人员名单完整准确
- [ ] Legal notices and third-party attributions complete / 法律声明和第三方归属完整

---

<!-- 中文翻译 -->
## Platform: PC / 平台：PC

- [ ] Minimum and recommended specs documented / 最低和推荐配置已记录
- [ ] Keyboard+mouse controls fully functional / 键盘+鼠标操控完全正常
- [ ] Controller support tested (Xbox, PlayStation, generic) / 控制器支持已测试（Xbox、PlayStation、通用）
- [ ] Resolution scaling tested: 1080p, 1440p, 4K, ultrawide / 分辨率缩放已测试：1080p、1440p、4K、超宽
- [ ] Windowed, borderless, fullscreen modes working / 窗口、无边框、全屏模式正常运行
- [ ] Graphics settings save and load correctly / 图形设置保存和加载正确
- [ ] Store SDK integrated and tested: [Steam/Epic/GOG] / 商店SDK已集成并测试：[Steam/Epic/GOG]
- [ ] Achievements functional / 成就功能正常
- [ ] Cloud saves functional / 云存档功能正常

<!-- 中文翻译 -->
## Platform: Console (if applicable) / 平台：主机（如适用）

- [ ] TRC/TCR/Lotcheck requirements met / TRC/TCR/Lotcheck要求已满足
- [ ] Platform controller prompts correct / 平台控制器提示正确
- [ ] Suspend/resume works / 暂停/恢复功能正常
- [ ] User switching handled / 用户切换已处理
- [ ] Network loss handled gracefully / 断网情况已优雅处理
- [ ] Storage full scenario handled / 存储空间不足场景已处理
- [ ] Parental controls respected / 遵守家长控制
- [ ] Certification submission prepared / 认证提交已准备

---

<!-- 中文翻译 -->
## Store and Distribution / 商店与分发

- [ ] Store page metadata complete and proofread / 商店页元数据完整且已校对
- [ ] Screenshots current and meet platform requirements / 截图最新且符合平台要求
- [ ] Trailer current / 预告片最新
- [ ] Key art and capsule images final / 主视觉图和胶囊图已定稿
- [ ] Age ratings obtained: [ ] ESRB [ ] PEGI [ ] Other / 年龄评级已获得：[ ] ESRB [ ] PEGI [ ] 其他
- [ ] Legal: EULA, Privacy Policy, Terms of Service / 法律：EULA、隐私政策、服务条款
- [ ] Pricing configured for all regions / 所有区域的定价已配置

---

<!-- 中文翻译 -->
## Launch Readiness / 发布就绪

- [ ] Analytics/telemetry verified and receiving data / 分析/遥测已验证并接收数据
- [ ] Crash reporting configured: [service name] / 崩溃报告已配置：[服务名称]
- [ ] Day-one patch prepared (if needed) / 首日补丁已准备好（如需要）
- [ ] On-call team schedule set for first 72 hours / 前72小时值班团队排班已安排
- [ ] Community announcements drafted / 社区公告已起草
- [ ] Press/influencer keys prepared / 媒体/意见领袖Key已准备
- [ ] Support team briefed on known issues / 支持团队已知悉已知问题
- [ ] Rollback plan documented and tested / 回滚计划已记录并测试

---

<!-- 中文翻译 -->
## Sign-offs / 签署

| Role | Name | Status | Date | 角色 | 姓名 | 状态 | 日期 |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| QA Lead | | [ ] Approved | | QA主管 | | [ ] 已批准 | |
| Technical Director | | [ ] Approved | | 技术总监 | | [ ] 已批准 | |
| Producer | | [ ] Approved | | 制作人 | | [ ] 已批准 | |
| Creative Director | | [ ] Approved | | 创意总监 | | [ ] 已批准 | |

---

<!-- 中文翻译 -->
## Final Decision / 最终决定

**GO / NO-GO**: ____________ / **通过 / 不通过**: ____________

**Rationale**: [Summary of readiness. If NO-GO, list specific blocking items and estimated time to resolve.] / **理由**: [就绪情况摘要。如不通过，列出具体阻塞项和预计解决时间。]

**Notes**: [Any additional context, known risks accepted, or conditions on the release.] / **备注**: [任何额外背景、已接受的已知风险或发布条件。]
