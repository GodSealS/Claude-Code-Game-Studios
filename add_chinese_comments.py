#!/usr/bin/env python3
"""
为 .codebuddy/skills/ 目录下的特定 SKILL.md 文件添加中文翻译注释。
在英文标题和段落前添加 <!-- 中文翻译 --> HTML 注释。
"""

import os
import re
from pathlib import Path

def contains_chinese(text):
    """检查文本是否包含中文字符"""
    return bool(re.search(r'[\u4e00-\u9fff]', text))

def is_translation_comment(line):
    """检查是否为翻译注释行"""
    return line.strip().startswith('<!--') and '翻译' in line and line.strip().endswith('-->')

def is_translation_blockquote(line):
    """检查是否为翻译块引用行"""
    return '> **中文翻译**：' in line or '> **Chinese translation**:' in line

def is_bilingual_heading(line):
    """检查是否为双语标题（包含 " / " 且后面有中文）"""
    if not (line.startswith('#') or line.startswith('##') or line.startswith('###') or line.startswith('####')):
        return False
    if ' / ' in line:
        parts = line.split(' / ', 1)
        if len(parts) == 2 and contains_chinese(parts[1]):
            return True
    return False

def is_english_only_heading(line):
    """检查是否为纯英文标题"""
    if not (line.startswith('#') or line.startswith('##') or line.startswith('###') or line.startswith('####')):
        return False
    # 检查是否包含中文字符
    if contains_chinese(line):
        return False
    # 检查是否已经有翻译注释（查找前一行）
    return True

def is_english_only_paragraph(line):
    """检查是否为纯英文段落（非标题、非代码、非特殊格式）"""
    stripped = line.strip()
    if not stripped:
        return False
    # 跳过特殊格式
    if stripped.startswith('>') or stripped.startswith('-') or stripped.startswith('|') or stripped.startswith('```') or stripped.startswith('---'):
        return False
    # 检查是否包含中文字符
    if contains_chinese(line):
        return False
    # 检查是否以数字开头（如 "1. **Some step:**"）
    if re.match(r'^\d+\.\s+\*\*', stripped):
        return True
    return True

def get_translation_for_heading(heading):
    """根据标题内容生成翻译注释"""
    heading_text = heading.strip()
    
    # 移除标题标记
    heading_text = re.sub(r'^#+\s*', '', heading_text)
    
    # 常见标题翻译映射
    translations = {
        'Phase 1:': '第1阶段：',
        'Phase 2:': '第2阶段：', 
        'Phase 3:': '第3阶段：',
        'Phase 4:': '第4阶段：',
        'Phase 5:': '第5阶段：',
        'Step 1:': '步骤1：',
        'Step 2:': '步骤2：',
        'Step 3:': '步骤3：',
        'Collaboration Protocol': '协作协议',
        'Implementation Workflow': '实施工作流',
        'When this skill is invoked:': '当该技能被调用时：',
        'Before writing any code:': '在编写任何代码之前：',
        '1. **Read the design document:**': '1. 阅读设计文档：',
        '2. **Ask architecture questions:**': '2. 提出架构问题：',
        '3. **Propose architecture before implementing:**': '3. 在实施前提出架构：',
    }
    
    # 查找匹配的翻译
    for key, value in translations.items():
        if key in heading_text:
            return f'<!-- {value} -->'
    
    # 默认翻译
    if ':' in heading_text:
        parts = heading_text.split(':', 1)
        return f'<!-- {parts[0].strip()}： -->'
    
    return f'<!-- {heading_text} -->'

def get_translation_for_paragraph(paragraph):
    """根据段落内容生成翻译注释"""
    para_text = paragraph.strip()
    
    # 检查是否为数字步骤
    match = re.match(r'^(\d+)\.\s+\*\*(.+?)\*\*:', para_text)
    if match:
        num = match.group(1)
        step = match.group(2)
        return f'<!-- {num}. {step}： -->'
    
    # 检查是否为常见短语
    if para_text == "Determine scope from the argument:":
        return "<!-- 从参数确定范围： -->"
    elif para_text == "After resolving scope, report:":
        return "<!-- 解析范围后报告： -->"
    elif para_text == "Assemble the full QA plan document. Use this structure:":
        return "<!-- 组装完整的 QA 计划文档。使用此结构： -->"
    elif para_text.startswith("Show the complete plan"):
        return "<!-- 展示完整计划并询问用户 -->"
    
    # 默认翻译
    if len(para_text) > 50:
        return "<!-- 段落翻译 -->"
    else:
        return f'<!-- {para_text[:30]}... -->'

def process_file(filepath):
    """处理单个 SKILL.md 文件"""
    print(f"处理: {filepath}")
    
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    output_lines = []
    i = 0
    
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        
        # 检查前一行是否已经是翻译注释
        if i > 0 and is_translation_comment(output_lines[-1]):
            output_lines.append(line)
            i += 1
            continue
        
        # 检查当前行是否已经是翻译块引用
        if is_translation_blockquote(line):
            output_lines.append(line)
            i += 1
            continue
        
        # 检查是否为双语标题
        if is_bilingual_heading(line):
            output_lines.append(line)
            i += 1
            continue
        
        # 检查是否为纯英文标题
        if is_english_only_heading(line):
            # 添加翻译注释
            translation = get_translation_for_heading(line)
            output_lines.append(translation + '\n')
            output_lines.append(line)
            i += 1
            continue
        
        # 检查是否为纯英文段落
        if is_english_only_paragraph(line):
            # 添加翻译注释
            translation = get_translation_for_paragraph(line)
            output_lines.append(translation + '\n')
            output_lines.append(line)
            i += 1
            continue
        
        # 其他情况直接添加
        output_lines.append(line)
        i += 1
    
    # 写回文件
    with open(filepath, 'w', encoding='utf-8') as f:
        f.writelines(output_lines)
    
    print(f"  完成处理")

def main():
    """主函数"""
    skills_dir = Path("e:/Work/Claude-Code-Game-Studios/.codebuddy/skills")
    
    # 需要处理的文件列表
    files_to_process = [
        "qa-plan/SKILL.md",
        "quick-design/SKILL.md",
        "regression-suite/SKILL.md",
        "release-checklist/SKILL.md",
        "retrospective/SKILL.md",
        "reverse-document/SKILL.md",
        "review-all-gdds/SKILL.md",
        "scope-check/SKILL.md",
        "security-audit/SKILL.md",
        "setup-engine/SKILL.md",
        "setup-wechat-minigame/SKILL.md",
        "skill-improve/SKILL.md",
        "skill-test/SKILL.md",
        "smoke-check/SKILL.md",
        "soak-test/SKILL.md",
        "sprint-plan/SKILL.md",
        "sprint-status/SKILL.md",
        "start/SKILL.md",
        "story-done/SKILL.md",
        "story-readiness/SKILL.md"
    ]
    
    for file in files_to_process:
        filepath = skills_dir / file
        if filepath.exists():
            process_file(filepath)
        else:
            print(f"文件不存在: {filepath}")

if __name__ == "__main__":
    main()