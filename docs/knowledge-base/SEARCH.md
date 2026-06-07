# 知识库检索指南

Agent 在设计/编码阶段从本目录检索技术方案的标准流程。

## 何时检索

触发条件（任一满足即启动检索）：
- 设计新系统或子系统时
- 遇到性能瓶颈需要优化方案时
- 需要选型（多种技术路线如何选择）时
- 用户明确提到 "参考知识库" 或 "有没有类似方案"

## 检索流程

### Step 1: 问题建模

从设计需求中提取检索要素：

| 要素 | 来源 | 示例 |
|------|------|------|
| domain | 寻找哪个领域的技术 | `ai`, `rendering`, `physics`, `networking` |
| problem | 核心问题关键词 | "近邻查询", "大量物体", "路径规划" |
| engine | 使用的引擎 | `unreal`, `unity`, `godot`, `cocos` |
| constraint | 性能/内存/复杂度约束 | "1000+ objects", "每帧执行" |

### Step 2: 检索 INDEX.yaml

读取 `docs/knowledge-base/INDEX.yaml` 全文（通常 < 200行），按以下优先级匹配：

1. **engine + domain 精确匹配** → 最高优先级
2. **domain + problem 关键词** → 高优先级
3. **仅 domain 匹配** → 中优先级
4. **tag 交集** → 备选

使用 `search_content` 工具做多轮精确匹配：
```
pattern: "domain:.*ai"         # 找到所有AI领域的技术
pattern: "tags:.*proximity"    # 找到包含proximity tag的技术
pattern: "engine:.*unreal"     # 找到支持Unreal的技术
```

### Step 3: 并行读取候选章节

从 INDEX.yaml 匹配到候选列表后，并行读取 3-5 个最匹配章节的全文。

读取优先级：
1. `title` 和 `problem` 与当前问题最相似
2. `engine` 与当前引擎匹配
3. `tags` 命中更多关键词

### Step 4: 输出方案评估

对每个候选技术输出：

```
## 候选技术: [名称]
**来源**: [书籍/章节]
**适配度**: 高/中/低
**理由**: [为什么适合/不适合当前场景]
**适用点**: [可以直接用的部分]
**需改造**: [需要调整的部分]
**不适用**: [需要避免的部分]
**引擎实现**: [该引擎是否有内置实现或类似机制]
```

### Step 5: 生成最终推荐

综合所有候选技术，输出 1-3 个推荐方案，标注：
- ✅ 推荐（直接适用）
- 🔧 改造后可用
- ❌ 不适用（及原因）

## 索引文件位置

所有知识源的技术条目汇总在：`docs/knowledge-base/INDEX.yaml`

章节详细内容在：`docs/knowledge-base/<source>/<volume>/<chapter>.md`
