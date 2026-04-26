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
## Content Complete

- [ ] All placeholder assets replaced with final versions
- [ ] All player-facing text proofread
- [ ] All text localization-ready (no hardcoded strings)
- [ ] Localization complete for: [list locales]
- [ ] Audio mix finalized and approved
- [ ] Credits complete and accurate
- [ ] Legal notices and third-party attributions complete

---

<!-- 中文翻译 -->
## Platform: PC

- [ ] Minimum and recommended specs documented
- [ ] Keyboard+mouse controls fully functional
- [ ] Controller support tested (Xbox, PlayStation, generic)
- [ ] Resolution scaling tested: 1080p, 1440p, 4K, ultrawide
- [ ] Windowed, borderless, fullscreen modes working
- [ ] Graphics settings save and load correctly
- [ ] Store SDK integrated and tested: [Steam/Epic/GOG]
- [ ] Achievements functional
- [ ] Cloud saves functional

<!-- 中文翻译 -->
## Platform: Console (if applicable)

- [ ] TRC/TCR/Lotcheck requirements met
- [ ] Platform controller prompts correct
- [ ] Suspend/resume works
- [ ] User switching handled
- [ ] Network loss handled gracefully
- [ ] Storage full scenario handled
- [ ] Parental controls respected
- [ ] Certification submission prepared

---

<!-- 中文翻译 -->
## Store and Distribution

- [ ] Store page metadata complete and proofread
- [ ] Screenshots current and meet platform requirements
- [ ] Trailer current
- [ ] Key art and capsule images final
- [ ] Age ratings obtained: [ ] ESRB [ ] PEGI [ ] Other
- [ ] Legal: EULA, Privacy Policy, Terms of Service
- [ ] Pricing configured for all regions

---

<!-- 中文翻译 -->
## Launch Readiness

- [ ] Analytics/telemetry verified and receiving data
- [ ] Crash reporting configured: [service name]
- [ ] Day-one patch prepared (if needed)
- [ ] On-call team schedule set for first 72 hours
- [ ] Community announcements drafted
- [ ] Press/influencer keys prepared
- [ ] Support team briefed on known issues
- [ ] Rollback plan documented and tested

---

<!-- 中文翻译 -->
## Sign-offs

| Role | Name | Status | Date |
| ---- | ---- | ---- | ---- |
| QA Lead | | [ ] Approved | |
| Technical Director | | [ ] Approved | |
| Producer | | [ ] Approved | |
| Creative Director | | [ ] Approved | |

---

<!-- 中文翻译 -->
## Final Decision

**GO / NO-GO**: ____________

**Rationale**: [Summary of readiness. If NO-GO, list specific blocking items and estimated time to resolve.]

**Notes**: [Any additional context, known risks accepted, or conditions on the release.]
