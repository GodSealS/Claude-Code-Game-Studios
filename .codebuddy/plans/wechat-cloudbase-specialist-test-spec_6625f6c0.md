---
name: wechat-cloudbase-specialist-test-spec
overview: 完成微信云开发专家测试规范的设计和创建，并验证所有五个微信代理测试规范的完整性和一致性
todos:
  - id: create-cloudbase-spec
    content: 基于.codebuddy/agents/wechat-cloudbase-specialist.md内容创建CCGS测试规范文件
    status: completed
  - id: verify-structure
    content: 验证五个文件的结构完整性和一致性
    status: completed
    dependencies:
      - create-cloudbase-spec
  - id: verify-terminology
    content: 检查术语统一性和接口设计一致性
    status: completed
    dependencies:
      - verify-structure
  - id: verify-test-cases
    content: 验证测试用例覆盖面和关键场景完整性
    status: completed
    dependencies:
      - verify-terminology
  - id: skill-validation
    content: 使用[skill:skill-test]对所有测试规范进行合规性验证
    status: completed
    dependencies:
      - verify-test-cases
  - id: generate-report
    content: 生成整体验证报告和一致性检查结果
    status: completed
    dependencies:
      - skill-validation
---

## 产品概述

为微信小游戏平台设计并生成符合CCGS Skill Testing Framework架构标准的代理测试规范，确保与其他游戏引擎（Godot、Unity、Unreal）保持一致的测试规范结构和职责划分。

## 核心功能

1. 完成第五个微信代理测试规范 `wechat-cloudbase-specialist.md` 的创建
2. 验证所有五个微信代理测试规范的完整性和一致性
3. 确保术语、接口设计和测试用例覆盖面保持统一
4. 验证完整覆盖微信小游戏开发的所有关键场景

## 技术栈选择

- 文件格式：Markdown（遵循现有测试规范模板）
- 模板结构：继承自Godot、Unity、Unreal引擎代理测试规范模式
- 验证工具：使用项目内置的skill-test技能进行合规性验证

## 实现方案

### 1. wechat-cloudbase-specialist.md 设计

基于现有 `.codebuddy/agents/wechat-cloudbase-specialist.md`（417行）内容，遵循统一模板结构：

- **Agent Summary**：定义域（云开发数据库设计、云函数、安全规则、存储管理、配额控制），明确不负责内容（架构决策、UI设计等），指定模型层级（DeepSeek-V4-Flash）
- **Static Assertions**：7个结构检查点，确保描述字段、允许工具、模型层级、引用关系等符合标准
- **Test Cases**：8个测试用例，覆盖数据库设计、云函数防作弊、安全规则、实时同步、存储管理、配额控制、版本兼容、错误处理等场景
- **Protocol Compliance**：8条协议合规检查，确保不越界、正确委派、考虑微信特有约束
- **Coverage Notes**：8条覆盖说明，验证关键场景覆盖度

### 2. 一致性验证要点

- **结构完整性**：所有5个文件必须包含相同的5个部分（Agent Summary、Static Assertions、Test Cases、Protocol Compliance、Coverage Notes）
- **术语统一性**：Domain字段格式、Does NOT own表述、Model tier指定（specialist用Kimi-k2.6，子专家用DeepSeek-V4-Flash）
- **接口设计统一**：所有测试用例使用TypeScript代码示例，引用wx.* API，考虑4MB包体限制和分包加载策略
- **测试用例覆盖面**：每个文件6-8个测试用例，覆盖各自域的关键场景

### 3. 验证方法

- 使用 [skill:skill-test] 对每个测试规范进行静态和行为验证
- 手动检查关键术语和引用关系的一致性
- 确认子专家与协调者的委派逻辑正确

## 实现细节

### 关键目录结构

```
CCGS Skill Testing Framework/
└── agents/
    └── engine/
        └── wechat/
            ├── wechat-specialist.md                # [已存在] 微信协调者
            ├── wechat-minigame-specialist.md       # [已存在] 小游戏实现专家
            ├── wechat-shader-specialist.md         # [已存在] Shader专家
            ├── wechat-ui-specialist.md             # [已存在] UI专家
            └── wechat-cloudbase-specialist.md      # [待创建] 云开发专家
```

### 云开发专家测试用例设计

1. **NoSQL数据库设计**：验证文档结构优化和索引策略
2. **云函数防作弊**：验证输入校验、速率限制、验证逻辑
3. **安全规则配置**：验证读写权限和数据隔离
4. **实时数据同步**：验证watch()监听和状态更新
5. **存储管理**：验证文件上传下载和配额控制
6. **成本优化**：验证查询优化和资源清理
7. **版本兼容性**：验证API版本检测和回退策略
8. **错误处理**：验证异常场景处理和用户反馈

### 微信特有约束嵌入

- 所有测试用例考虑4MB主包大小限制
- 使用微信原生API（wx.*）而非通用解决方案
- 考虑移动设备性能和电池寿命
- 支持竖屏优先的交互模式

## 代理扩展

### Skill

- **skill-test**
- 用途：验证创建的测试规范文件的结构合规性和行为正确性
- 预期结果：生成详细的测试报告，确认所有测试规范符合CCGS Skill Testing Framework标准

### MCP

- **CloudBase AI ToolKit**
- 用途：参考云开发相关API和最佳实践，确保测试规范中的代码示例准确可靠
- 预期结果：测试用例中的云函数、数据库操作等代码符合微信云开发实际要求