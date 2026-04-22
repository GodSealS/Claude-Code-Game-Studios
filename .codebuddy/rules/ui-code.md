---
paths:
  - "src/ui/**"
---

# UI Code Rules / UI 代码规则

- UI must NEVER own or directly modify game state — display only, use commands/events to request changes
  > **中文翻译**：UI 永远不能拥有或直接修改游戏状态 — 仅显示，使用命令/事件请求变更
- All UI text must go through the localization system — no hardcoded user-facing strings
  > **中文翻译**：所有 UI 文本必须经过本地化系统 — 禁止硬编码面向用户的字符串
- Support both keyboard/mouse AND gamepad input for all interactive elements
  > **中文翻译**：所有交互元素必须同时支持键鼠和手柄输入
- All animations must be skippable and respect user motion/accessibility preferences
  > **中文翻译**：所有动画必须可跳过并尊重用户的动效/无障碍偏好
- UI sounds trigger through the audio event system, not directly
  > **中文翻译**：UI 音效通过音频事件系统触发，而非直接播放
- UI must never block the game thread
  > **中文翻译**：UI 不得阻塞游戏线程
- Scalable text and colorblind modes are mandatory, not optional
  > **中文翻译**：可缩放文本和色盲模式是强制性的，而非可选
- Test all screens at minimum and maximum supported resolutions
  > **中文翻译**：在最低和最高支持的分辨率下测试所有屏幕
