# 总索引与快速跳转

本文档提供关键词级别的快速查找，帮助学习者根据具体需求定位到相关学习材料。

---

## 按主题索引

### 框架核心概念

| 关键词 | 相关文档 | 说明 |
|--------|----------|------|
| Skill | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #框架核心概念<br>[phase-guide/phase-1-proficiency.md](phase-guide/phase-1-proficiency.md) #1-调用Skill<br>[phase-guide/phase-3-extension.md](phase-guide/phase-3-extension.md) #1-创建新Skill | 技能定义、调用方法、创建规范 |
| Agent | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #角色与协作概念<br>[phase-guide/phase-1-proficiency.md](phase-guide/phase-1-proficiency.md) #3-阅读Agent定义<br>[phase-guide/phase-3-extension.md](phase-guide/phase-3-extension.md) #2-创建新Agent | 智能体定义、阅读方法、创建规范 |
| Rule | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #框架核心概念<br>[phase-guide/phase-1-proficiency.md](phase-guide/phase-1-proficiency.md) #4-理解和遵循Rule<br>[phase-guide/phase-3-extension.md](phase-guide/phase-3-extension.md) #3-创建新Rule | 规则定义、触发机制、创建规范 |
| Frontmatter | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #框架核心概念<br>[phase-guide/phase-2-customization.md](phase-guide/phase-2-customization.md) #1-调整Frontmatter<br>[phase-guide/phase-3-extension.md](phase-guide/phase-3-extension.md) #1-2-Frontmatter规范 | YAML元数据、修改方法、必填字段 |
| Hook | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #框架核心概念<br>[architecture/prompt-engineering-flow.md](architecture/prompt-engineering-flow.md) #2-4-Hook模块 | 钩子脚本、触发时机、与其他模块关系 |

### 协作与组织

| 关键词 | 相关文档 | 说明 |
|--------|----------|------|
| Delegation Map | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #角色与协作概念<br>[phase-guide/phase-2-customization.md](phase-guide/phase-2-customization.md) #2-3-调整委托地图 | 委托地图定义、修改方法 |
| 垂直委托 | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #角色与协作概念<br>[architecture/prompt-engineering-flow.md](architecture/prompt-engineering-flow.md) #四-协作层级图 | 领导层→部门层→专家层的委托规则 |
| 平级协商 | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #角色与协作概念<br>[architecture/prompt-engineering-flow.md](architecture/prompt-engineering-flow.md) #四-协作层级图 | 同层级Agent的协商规则与限制 |
| 模型层级 | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #技术工具概念<br>[phase-guide/phase-2-customization.md](phase-guide/phase-2-customization.md) #4-调整模型层级分配 | Haiku/Sonnet/Opus的分配策略与调整 |
| 审查模式 | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #文档流程概念<br>[phase-guide/phase-1-proficiency.md](phase-guide/phase-1-proficiency.md) #5-2-审查模式<br>[phase-guide/phase-2-customization.md](phase-guide/phase-2-customization.md) #5-修改审查模式 | Full/Lean/Solo模式的含义与配置 |

### 上下文与状态管理

| 关键词 | 相关文档 | 说明 |
|--------|----------|------|
| active.md | [phase-guide/phase-1-proficiency.md](phase-guide/phase-1-proficiency.md) #5-1-会话状态文件<br>[architecture/prompt-engineering-flow.md](architecture/prompt-engineering-flow.md) #五-数据流与上下文管理 | 会话状态文件的位置、内容和维护方法 |
| 上下文压缩 | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #技术工具概念<br>[phase-guide/phase-1-proficiency.md](phase-guide/phase-1-proficiency.md) #5-3-上下文压缩 | Compact机制、压缩时机和恢复方法 |
| 文件持久化 | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #技术工具概念 | File-Backed State策略 |
| 增量写入 | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #技术工具概念 | 多章节文档的增量写入策略 |

### 流程与阶段

| 关键词 | 相关文档 | 说明 |
|--------|----------|------|
| Phase | [phase-guide/phase-1-proficiency.md](phase-guide/phase-1-proficiency.md) #1-调用Skill<br>[phase-guide/phase-2-customization.md](phase-guide/phase-2-customization.md) #1-2-调整阶段逻辑<br>[phase-guide/phase-3-extension.md](phase-guide/phase-3-extension.md) #1-3-内容结构设计 | Skill的阶段划分、修改方法和设计原则 |
| Gate Check | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #文档流程概念 | 阶段门控的PASS/CONCERNS/FAIL裁决 |
| GDD | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #文档流程概念 | 游戏设计文档的定义和存放位置 |
| ADR | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #文档流程概念 | 架构决策记录的定义和存放位置 |
| Epic/Story | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) #文档流程概念 | 史诗与故事的定义和关系 |

---

## 按问题索引

### 我想知道……

| 问题 | 跳转文档 | 具体章节 |
|------|----------|----------|
| 如何调用一个Skill？ | [phase-guide/phase-1-proficiency.md](phase-guide/phase-1-proficiency.md) | 第1节：调用Skill |
| 如何查看所有可用命令？ | [dictionary/file-reference.md](dictionary/file-reference.md) | Skill文件速查表 |
| Agent文件怎么读？重点看什么？ | [phase-guide/phase-1-proficiency.md](phase-guide/phase-1-proficiency.md) | 第3节：阅读Agent定义 |
| Rule什么时候触发？怎么生效？ | [phase-guide/phase-1-proficiency.md](phase-guide/phase-1-proficiency.md) | 第4节：理解和遵循Rule |
| 如何修改现有Skill的功能？ | [phase-guide/phase-2-customization.md](phase-guide/phase-2-customization.md) | 第1节：修改Skill |
| 如何调整Agent的职责边界？ | [phase-guide/phase-2-customization.md](phase-guide/phase-2-customization.md) | 第2节：修改Agent |
| 如何增加一条代码规范？ | [phase-guide/phase-2-customization.md](phase-guide/phase-2-customization.md) | 第3节：修改Rule |
| 如何创建一个全新的Skill？ | [phase-guide/phase-3-extension.md](phase-guide/phase-3-extension.md) | 第1节：创建新Skill |
| 如何创建一个全新的Agent？ | [phase-guide/phase-3-extension.md](phase-guide/phase-3-extension.md) | 第2节：创建新Agent |
| 如何创建一个全新的Rule？ | [phase-guide/phase-3-extension.md](phase-guide/phase-3-extension.md) | 第3节：创建新Rule |
| 新创建的Skill如何验证？ | [phase-guide/phase-3-extension.md](phase-guide/phase-3-extension.md) | 第4节：注册与验证 |
| 提示词工程的模块关系是怎样的？ | [architecture/prompt-engineering-flow.md](architecture/prompt-engineering-flow.md) | 全景流程图 |
| Skill、Agent、Rule之间如何交互？ | [architecture/prompt-engineering-flow.md](architecture/prompt-engineering-flow.md) | 第3节：模块间关系详解 |
| 数据流和上下文如何管理？ | [architecture/prompt-engineering-flow.md](architecture/prompt-engineering-flow.md) | 第5节：数据流与上下文管理 |
| 项目目录结构是什么？ | [dictionary/directory-reference.md](dictionary/directory-reference.md) | 根目录结构 |
| .codebuddy下面各目录放什么？ | [dictionary/directory-reference.md](dictionary/directory-reference.md) | .codebuddy子目录详解 |
| 某个术语是什么意思？ | [dictionary/terminology-dictionary.md](dictionary/terminology-dictionary.md) | 按分类查阅 |

---

## 按平台索引

| 平台 | 专属Agent | 专属Skill | 学习文档 |
|------|-----------|-----------|----------|
| Godot | godot-specialist及4个子专家 | /setup-engine, /dev-story等 | [platform-guide/godot.md](platform-guide/godot.md) |
| Unity | unity-specialist及4个子专家 | /setup-engine, /dev-story等 | [platform-guide/unity.md](platform-guide/unity.md) |
| Unreal | unreal-specialist及4个子专家 | /setup-engine, /dev-story等 | [platform-guide/unreal.md](platform-guide/unreal.md) |
| 微信小游戏 | wechat-specialist及4个子专家 | /setup-wechat-minigame, /wechat-shader等7个 | [platform-guide/wechat.md](platform-guide/wechat.md) |
| Cocos | cocos-specialist及8个子专家 | /setup-engine, /dev-story等 | [platform-guide/cocos.md](platform-guide/cocos.md) |

---

## 文档间交叉引用表

| 文档 | 引用了哪些其他Study文档 |
|------|------------------------|
| README.md | 所有子文档 |
| terminology-dictionary.md | 无（被其他文档引用） |
| directory-reference.md | 无（被其他文档引用） |
| file-reference.md | 无（被其他文档引用） |
| prompt-engineering-flow.md | 无（被其他文档引用） |
| phase-1-proficiency.md | phase-2-customization.md |
| phase-2-customization.md | phase-1-proficiency.md, phase-3-extension.md |
| phase-3-extension.md | 无（终点文档） |
| godot.md | 无（平台独立文档） |
| unity.md | 无（平台独立文档） |
| unreal.md | 无（平台独立文档） |
| wechat.md | 无（平台独立文档） |
| cocos.md | 无（平台独立文档） |

---

## 快速链接

### 学习路径
- [阶段一：熟练使用](phase-guide/phase-1-proficiency.md)
- [阶段二：定制修改](phase-guide/phase-2-customization.md)
- [阶段三：扩展新建](phase-guide/phase-3-extension.md)

### 查询字典
- [术语中英文对照](dictionary/terminology-dictionary.md)
- [目录关系说明](dictionary/directory-reference.md)
- [核心文件索引](dictionary/file-reference.md)

### 架构理解
- [提示词工程流程图](architecture/prompt-engineering-flow.md)

### 平台指南
- [Godot](platform-guide/godot.md)
- [Unity](platform-guide/unity.md)
- [Unreal](platform-guide/unreal.md)
- [微信小游戏](platform-guide/wechat.md)
- [Cocos](platform-guide/cocos.md)
