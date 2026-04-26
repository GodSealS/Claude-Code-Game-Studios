---
name: wechat-build
description: "Builds, packages, and prepares a WeChat Mini Game for submission to the WeChat platform. Validates package size, optimizes assets, and generates submission checklist. / 构建、打包并准备微信小游戏提交到微信平台。验证包大小、优化资产生成提交清单。"
argument-hint: "[release|preview|test]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash
---

# WeChat Mini Game Build and Package / 微信小游戏构建和打包

This skill builds and packages a WeChat Mini Game for submission. It validates package size, optimizes assets, checks configuration, and generates a submission checklist. / 此技能构建和打包微信小游戏以供提交。它验证包大小、优化资产、检查配置并生成提交清单。

---

## Phase 1: Validate Project / 第 1 阶段：验证项目

### Check Project Structure / 检查项目结构

Verify the WeChat Mini Game project exists: / 验证微信小游戏项目是否存在：

```bash
# Check for required files / 检查必需文件
Read("miniprogram/game.json")
Read("miniprogram/app.json")
Read("miniprogram/game.js")
```

If files don't exist, inform the user: / 如果文件不存在，通知用户：
> "WeChat Mini Game project not found. Run `/setup-wechat-minigame` first to initialize the project." / > "未找到微信小游戏项目。请先运行 `/setup-wechat-minigame` 来初始化项目。"

### Read Configuration / 读取配置

```bash
Read("miniprogram/game.json")
Read("miniprogram/app.json")
Read("miniprogram/project.config.json")
Read(".codebuddy/docs/technical-preferences.md")
```

---

## Phase 2: Package Size Analysis / 第 2 阶段：包大小分析

### Calculate Package Size / 计算包大小

Check the total size of the main package: / 检查主包的总大小：

```bash
# Calculate sizes
Bash("find miniprogram -type f -name '*.js' -o -name '*.json' -o -name '*.png' -o -name '*.jpg' -o -name '*.mp3' | xargs du -ch | grep total")
Bash("find miniprogram/js -type f | xargs du -ch | grep total")
Bash("find miniprogram/images -type f 2>/dev/null | xargs du -ch | grep total")
Bash("find miniprogram/audio -type f 2>/dev/null | xargs du -ch | grep total")
```

### Size Report / 大小报告

Generate a size report: / 生成大小报告：

```
📦 Package Size Analysis
========================

Main Package Limit: 4 MB (4,194,304 bytes)
Current Size: {mainSize} MB
Status: {✅ Under limit | ⚠️ Near limit (>{80%}) | ❌ Exceeds limit}

Breakdown:
├── JavaScript: {jsSize} MB
├── Images: {imageSize} MB
├── Audio: {audioSize} MB
├── JSON Config: {configSize} KB
└── Other: {otherSize} KB

Subpackages:
{subpackageList}

Recommendations:
{if mainSize > 3MB}
⚠️  Package approaching 4MB limit. Consider:
   - Move non-essential assets to subpackages
   - Compress images (convert PNG to WebP)
   - Remove unused code
{endif}
```

---

## Phase 3: Asset Optimization / 第 3 阶段：资产优化

### Image Optimization / 图片优化

Check for optimization opportunities: / 检查优化机会：

```bash
# Find large images / 查找大图片
Bash("find miniprogram/images -type f \( -name '*.png' -o -name '*.jpg' \) -size +100k")

# Check for unoptimized images / 检查未优化的图片
Bash("find miniprogram/images -type f -name '*.png' | head -10")
```

**Recommendations to user**:

```
🖼️  Image Optimization
======================

Large images found:
- image1.png (245 KB) → Consider WebP (estimated: ~80 KB)
- background.jpg (512 KB) → Consider compression (estimated: ~200 KB)

Recommendations:
1. Convert PNG to WebP for better compression
2. Use texture atlases to reduce draw calls
3. Remove unused images from the project
4. Use 9-patch images for UI elements

Would you like me to:
- [ ] Generate image optimization report
- [ ] Suggest subpackage strategy for assets
```

### Audio Optimization / 音频优化

```bash
# Check audio files
Bash("find miniprogram/audio -type f \( -name '*.mp3' -o -name '*.wav' -o -name '*.ogg' \)")
```

**Audio recommendations**:
- Use MP3 for music (good compression)
- Use shorter audio files for SFX
- Consider audio compression settings

---

## Phase 4: Code Quality Check / 第 4 阶段：代码质量检查

### JavaScript/TypeScript Validation / JavaScript/TypeScript 验证

```bash
# Check for common issues
Grep("miniprogram/js/**/*.js", "document\\.")  # DOM API not available
Grep("miniprogram/js/**/*.js", "window\\.")   # window object not available
Grep("miniprogram/js/**/*.js", "localStorage") # Use wx.setStorageSync instead
```

### Check for Anti-patterns / 检查反模式

```
🔍 Code Quality Check
=====================

Issues Found:
{if DOM_APIs_found}
❌ DOM API usage detected (not available in WeChat Mini Games):
   {file:line} document.getElementById(...)
   Fix: Use wx.createCanvas() and canvas.getContext('2d')
{endif}

{if window_APIs_found}
❌ window object usage detected:
   {file:line} window.innerWidth
   Fix: Use wx.getSystemInfoSync().windowWidth
{endif}

{if localStorage_found}
⚠️  localStorage usage detected:
   {file:line} localStorage.setItem(...)
   Fix: Use wx.setStorageSync(key, value)
{endif}

{if console_logs_found}
⚠️  console.log statements found ({count} occurrences)
   Consider removing for production build
{endif}
```

---

## Phase 5: Configuration Validation / 第 5 阶段：配置验证

### Validate game.json / 验证 game.json

```javascript
// Required fields check
const required = ['deviceOrientation'];
const gameJson = Read("miniprogram/game.json");

// Validate subpackages if present
if (gameJson.subpackages) {
  for (const pkg of gameJson.subpackages) {
    Check pkg.name is unique
    Check pkg.root exists as directory
  }
}
```

### Validate app.json / 验证 app.json

```javascript
// Check for common issues
const appJson = Read("miniprogram/app.json");

// Validate permissions
if (appJson.permission) {
  for (const [scope, config] of Object.entries(appJson.permission)) {
    Check config.desc is provided (required for user consent)
  }
}
```

### Configuration Report / 配置报告

```
⚙️  Configuration Validation
============================

✅ game.json:
   - deviceOrientation: {portrait|landscape}
   - showStatusBar: {true|false}
   - networkTimeout: configured
   - subpackages: {count} configured

✅ app.json:
   - permissions: {list}
   - subpackages: {list}
   
{if issues_found}
⚠️  Issues:
   {issue_list}
{endif}
```

---

## Phase 6: Security and Privacy Check / 第 6 阶段：安全和隐私检查

### Check for Sensitive Data / 检查敏感数据

```bash
# Scan for potential issues
Grep("miniprogram/**/*", "appid|appsecret|api[_-]?key|password|token", "-i")
Grep("miniprogram/**/*", "http://")  # Should use https://
```

### Privacy Compliance / 隐私合规

```
🔒 Security and Privacy Check
==============================

{if hardcoded_secrets}
❌ Potential hardcoded secrets found:
   {locations}
   Action: Move to environment variables or secure storage
{endif}

{if http_urls}
⚠️  HTTP URLs found (should use HTTPS):
   {locations}
{endif}

{if no_privacy_policy && collects_user_data}
⚠️  User data collection detected but no privacy policy found
   Action: Add privacy policy if collecting any user data
{endif}

Permissions declared:
{permissions_list}
```

---

## Phase 7: Performance Check / 第 7 阶段：性能检查

### Performance Recommendations / 性能建议

```
🚀 Performance Check
====================

Asset Counts:
- Images: {imageCount}
- Audio files: {audioCount}
- JavaScript files: {jsCount}

Recommendations:
{if imageCount > 50}
⚠️  High image count ({imageCount}). Consider:
   - Using texture atlases
   - Lazy loading non-essential images
{endif}

{if jsCount > 20}
⚠️  Many JS files ({jsCount}). Consider bundling for production.
{endif}

Best Practices:
✅ Use requestAnimationFrame for game loop
✅ Pause rendering in onHide event
✅ Use object pooling for frequently created objects
✅ Implement touch event throttling
```

---

## Phase 8: Build Package / 第 8 阶段：构建包

### Create Build Directory / 创建构建目录

```bash
# Create production build
Bash("mkdir -p build/wechat-minigame")
Bash("cp -r miniprogram/* build/wechat-minigame/")

# Remove development files
Bash("rm -f build/wechat-minigame/.eslintrc.js")
Bash("rm -rf build/wechat-minigame/node_modules")
```

### Generate Build Report / 生成构建报告

```
📦 Build Complete
==================

Build location: build/wechat-minigame/

Package Structure:
├── game.js
├── game.json
├── app.json
├── project.config.json
├── js/ ({jsFileCount} files)
├── images/ ({imageFileCount} files)
├── audio/ ({audioFileCount} files)
└── subpackages/ ({subpackageCount} packages)

Size Summary:
- Main package: {mainSize} MB / 4 MB
- Total with subpackages: {totalSize} MB

Build type: {release|preview|test}
```

---

## Phase 9: Submission Checklist / 第 9 阶段：提交清单

Generate a submission checklist: / 生成提交清单：

```markdown
# 🚀 WeChat Mini Game Submission Checklist

## Pre-submission Checklist

### Required Items
- [ ] AppID configured in `project.config.json`
- [ ] Game name finalized (4-30 characters)
- [ ] Game icon (144x144 PNG, < 2MB)
- [ ] Screenshots (5 screenshots, 480x800 or 800x480)
- [ ] Game description (10-1000 characters)
- [ ] Privacy policy (if collecting user data)
- [ ] ICP备案 (if required for online features)

### Technical Checklist
- [ ] Package size < 4 MB
- [ ] No DOM API usage
- [ ] HTTPS URLs only
- [ ] No hardcoded secrets
- [ ] Proper error handling
- [ ] Touch input working
- [ ] Lifecycle events handled (onShow/onHide)
- [ ] Audio works on both iOS and Android

### Feature Checklist
- [ ] Start button works
- [ ] Game can be completed
- [ ] Score/lives displayed correctly
- [ ] Share functionality (if implemented)
- [ ] Leaderboard (if implemented)
- [ ] Tutorial/help (if applicable)

### Compliance Checklist
- [ ] 实名制 compliance (real-name verification)
- [ ] 防沉迷系统 (anti-addiction) for underage users
- [ ] No prohibited content (gambling, violence, etc.)
- [ ] No misleading gameplay in screenshots
- [ ] Copyright compliance for assets

## Build Instructions

1. Open WeChat DevTools
2. Import project from `build/wechat-minigame/`
3. Click "预览" (Preview) to test on device
4. Click "上传" (Upload) to submit for review
5. Fill in submission form at mp.weixin.qq.com

## Review Timeline

- Standard review: 1-7 business days
- Expedited review: Available for urgent updates
- Re-review required for: Major version updates

## Post-launch Checklist

- [ ] Monitor error logs in Mini Game Assistant
- [ ] Track performance metrics
- [ ] Respond to user feedback
- [ ] Update Cloud Base security rules if needed
```

---

## Phase 10: Summary Output / 第 10 阶段：总结输出

Show final summary to user:

```
✅ WeChat Mini Game Build Complete!

📊 Build Summary:
   Package size: {size} MB / 4 MB limit
   Status: {ready | needs attention}

📁 Output:
   Build directory: build/wechat-minigame/
   Checklist: build/SUBMISSION_CHECKLIST.md

{if issues.length > 0}
⚠️  Issues to address before submission:
{issues}
{endif}

📝 Next steps:
   1. Review SUBMISSION_CHECKLIST.md
   2. Test on real device using Preview
   3. Address any warnings above
   4. Upload to WeChat platform for review

💡 Tips:
   - Use WeChat DevTools "Audits" tab for additional checks
   - Test on both iOS and Android devices
   - Check performance on low-end devices
```

---

## Edge Cases / 边界情况

- **Missing required files**: Offer to create or guide to `/setup-wechat-minigame`
- **Package exceeds 4MB**: Provide detailed subpackage migration plan
- **DOM API usage found**: Suggest WeChat Mini Game alternatives
- **Build type**: `release` (production), `preview` (development), `test` (automated testing)
