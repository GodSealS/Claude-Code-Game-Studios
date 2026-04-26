#!/usr/bin/env python3
"""
审计双语翻译完整性的脚本
检查英文段落和列表项是否有对应的中文翻译
"""

import os
import re
from pathlib import Path

def analyze_md_file(file_path):
    """
    分析单个Markdown文件的翻译完整性
    返回：
        - untranslated_paragraphs: 没有对应中文翻译的英文段落数量
        - untranslated_list_items: 没有翻译的英文列表项数量
        - notes: 未翻译内容的简要说明
    """
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    untranslated_paragraphs = 0
    untranslated_list_items = 0
    notes = []
    
    # 分割为行
    lines = content.split('\n')
    
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        
        # 跳过空行
        if not line:
            i += 1
            continue
        
        # 跳过YAML front matter
        if line == '---' and i == 0:
            # 跳过整个YAML front matter
            i += 1
            while i < len(lines) and lines[i].strip() != '---':
                i += 1
            if i < len(lines):
                i += 1
            continue
        
        # 跳过代码块
        if line.startswith('```'):
            i += 1
            while i < len(lines) and not lines[i].strip().startswith('```'):
                i += 1
            if i < len(lines):
                i += 1
            continue
        
        # 检查英文段落（段落通常有多个句子）
        # 简单的段落检测：不以#、-、*、>、|、`开头的行，且长度较长
        is_paragraph = (not line.startswith('#') and 
                       not line.startswith('-') and 
                       not line.startswith('*') and 
                       not line.startswith('>') and 
                       not line.startswith('|') and 
                       not line.startswith('`') and 
                       not line.startswith('[') and
                       not line.startswith('![') and
                       len(line) > 40 and  # 假设段落至少有40字符
                       not re.match(r'^\d+\.', line) and  # 排除编号列表
                       not line.startswith('---') and  # 排除分隔线
                       not line.startswith('<!--'))  # 排除HTML注释
        
        if is_paragraph:
            # 检查是否为英文（不包含中文字符）
            contains_chinese = re.search(r'[\u4e00-\u9fff]', line)
            is_english = not contains_chinese and re.search(r'[a-zA-Z]', line)
            
            if is_english:
                # 查找下一行是否有翻译标记
                has_translation = False
                j = i + 1
                # 跳过空行查找翻译
                while j < len(lines) and not lines[j].strip():
                    j += 1
                
                if j < len(lines):
                    next_line = lines[j].strip()
                    if next_line.startswith('> **中文翻译**：'):
                        has_translation = True
                
                if not has_translation:
                    untranslated_paragraphs += 1
                    # 截取前50个字符作为说明
                    preview = line[:50] + ('...' if len(line) > 50 else '')
                    notes.append(f"段落: {preview}")
        
        # 检查列表项
        # 检测项目符号列表：以-、*或数字.开头的行
        is_list_item = (line.startswith('- ') or 
                       line.startswith('* ') or 
                       re.match(r'^\d+\.\s', line))
        
        if is_list_item:
            # 检查是否包含中文
            contains_chinese = re.search(r'[\u4e00-\u9fff]', line)
            # 检查是否包含英文（有字母且没有中文）
            contains_english = re.search(r'[a-zA-Z]', line) and not contains_chinese
            
            if contains_english and not contains_chinese:
                # 检查是否包含 "/ 中文" 格式的翻译
                has_inline_translation = '/' in line and re.search(r'/[\s\u4e00-\u9fff]', line)
                
                if not has_inline_translation:
                    untranslated_list_items += 1
                    preview = line[:50] + ('...' if len(line) > 50 else '')
                    notes.append(f"列表项: {preview}")
        
        i += 1
    
    return untranslated_paragraphs, untranslated_list_items, notes[:3]  # 只返回前3个例子

def audit_files():
    """审计所有指定目录的文件"""
    workspace = Path("e:/Work/Claude-Code-Game-Studios")
    
    # 需要审计的文件列表
    files_to_audit = [
        # design目录
        workspace / "design" / "CLAUDE.md",
        
        # docs目录（顶层）
        workspace / "docs" / "architecture-analysis.md",
        workspace / "docs" / "CODEBUDDY.md",
        workspace / "docs" / "COLLABORATIVE-DESIGN-PRINCIPLE.md",
        workspace / "docs" / "prompt-engineering-analysis.md",
        workspace / "docs" / "WORKFLOW-GUIDE.md",
        
        # Readme目录
        workspace / "Readme" / "01-Project-Overview.md",
        workspace / "Readme" / "02-Directory-Structure.md",
        workspace / "Readme" / "03-Workflow-Guide.md",
        workspace / "Readme" / "04-Agents-Reference.md",
        workspace / "Readme" / "05-Skills-Reference.md",
        workspace / "Readme" / "06-Hooks-and-Rules.md",
        workspace / "Readme" / "07-Game-Development-Guide.md",
        workspace / "Readme" / "08-Open-Spec-Integration.md",
        workspace / "Readme" / "09-Diagrams-and-Charts.md",
        workspace / "Readme" / "10-WeChat-Mini-Game-Guide.md",
        workspace / "Readme" / "11-Unity-Agent-Collaboration-Guide.md",
        workspace / "Readme" / "12-WeChat-Agent-Collaboration-Guide.md",
        workspace / "Readme" / "cocos-creator-guide.md",
        workspace / "Readme" / "README.md",
        
        # src目录
        workspace / "src" / "CODEBUDDY.md",
    ]
    
    results = []
    
    for file_path in files_to_audit:
        if not file_path.exists():
            print(f"警告: 文件不存在 {file_path}")
            continue
        
        print(f"分析: {file_path.relative_to(workspace)}")
        untranslated_paras, untranslated_list_items, notes = analyze_md_file(file_path)
        
        if untranslated_paras > 0 or untranslated_list_items > 0:
            results.append({
                'file': file_path.relative_to(workspace),
                'untranslated_paragraphs': untranslated_paras,
                'untranslated_list_items': untranslated_list_items,
                'notes': notes
            })
    
    # 输出结果
    print("\n" + "="*80)
    print("双语翻译审计结果")
    print("="*80)
    
    if not results:
        print("✅ 所有文件的翻译都是完整的！")
        return
    
    # 汇总表格
    print("\n汇总表格：")
    print("-"*80)
    print(f"{'文件名':<30} {'未翻译段落':<15} {'未翻译列表项':<15} {'说明'}")
    print("-"*80)
    
    total_untranslated_paragraphs = 0
    total_untranslated_list_items = 0
    
    for result in results:
        file_str = str(result['file'])
        paras = result['untranslated_paragraphs']
        list_items = result['untranslated_list_items']
        
        # 构建简要说明
        note_parts = []
        if result['notes']:
            note_parts = [f"{n}" for n in result['notes'][:2]]
        notes_str = "; ".join(note_parts) if note_parts else "无具体示例"
        
        print(f"{file_str:<30} {paras:<15} {list_items:<15} {notes_str}")
        
        total_untranslated_paragraphs += paras
        total_untranslated_list_items += list_items
    
    print("-"*80)
    print(f"{'总计':<30} {total_untranslated_paragraphs:<15} {total_untranslated_list_items:<15}")
    print("\n" + "="*80)

if __name__ == "__main__":
    audit_files()