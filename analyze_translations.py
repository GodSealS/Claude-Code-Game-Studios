#!/usr/bin/env python3
"""
中文翻译完整性分析工具
用于分析 .codebuddy/docs/ 目录中的 .md 文件翻译完整性
"""

import os
import re
from pathlib import Path

def analyze_md_file(file_path):
    """分析单个 .md 文件的翻译完整性"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    lines = content.split('\n')
    
    # 初始化统计
    untranslated_paragraphs = []
    untranslated_list_items = []
    current_paragraph = []
    in_code_block = False
    in_front_matter = False
    paragraph_start_line = 0
    skip_next_line = False  # 跳过已经检测到翻译的行
    
    for i, line in enumerate(lines):
        line_num = i + 1
        
        # 如果标记为跳过（已检测到翻译）
        if skip_next_line:
            skip_next_line = False
            if current_paragraph:
                # 删除当前段落（因为它有翻译）
                current_paragraph = []
            continue
        
        # 检测代码块
        if line.strip().startswith('```'):
            in_code_block = not in_code_block
        
        # 检测YAML front matter
        if i == 0 and line.strip() == '---':
            in_front_matter = True
        elif in_front_matter and line.strip() == '---':
            in_front_matter = False
        
        # 跳过代码块和YAML front matter
        if in_code_block or in_front_matter:
            if current_paragraph:
                untranslated_paragraphs.append({
                    'start': paragraph_start_line,
                    'end': i,
                    'text': '\n'.join(current_paragraph)
                })
                current_paragraph = []
            continue
        
        # 跳过空行
        if not line.strip():
            if current_paragraph:
                untranslated_paragraphs.append({
                    'start': paragraph_start_line,
                    'end': i,
                    'text': '\n'.join(current_paragraph)
                })
                current_paragraph = []
            continue
        
        # 检查表格行（通常有中文翻译）
        if line.strip().startswith('|') and ' / ' in line:
            # 表格行已经有双语格式
            if current_paragraph:
                untranslated_paragraphs.append({
                    'start': paragraph_start_line,
                    'end': i,
                    'text': '\n'.join(current_paragraph)
                })
                current_paragraph = []
            continue
        
        # 检查标题行
        if line.strip().startswith('#'):
            # 检查标题是否包含双语格式
            if ' / ' in line:
                # 标题已有双语格式
                if current_paragraph:
                    untranslated_paragraphs.append({
                        'start': paragraph_start_line,
                        'end': i,
                        'text': '\n'.join(current_paragraph)
                    })
                    current_paragraph = []
                continue
            else:
                # 纯英文标题，需要双语
                if line.strip() and len(line.strip()) > 3:
                    if not any(c in line for c in '中文翻译'):
                        # 检查下一行是否是中文翻译
                        if i < len(lines) - 1:
                            next_line = lines[i + 1].strip()
                            if not next_line.startswith('> **中文翻译**：'):
                                untranslated_paragraphs.append({
                                    'start': line_num,
                                    'end': line_num,
                                    'text': line.strip()
                                })
                continue
        
        # 检查是否有中文翻译块
        if line.strip().startswith('> **中文翻译**：'):
            # 如果有翻译块，标记跳过下一行（翻译行本身）
            skip_next_line = False
            # 清空当前段落（因为它有翻译）
            if current_paragraph:
                # 如果当前段落有内容，说明前一段英文有翻译
                current_paragraph = []
            continue
        
        # 检查是否是列表项
        if line.strip().startswith('- ') or line.strip().startswith('* ') or line.strip().startswith('1. '):
            # 检查列表项是否已经有双语格式
            if ' / ' in line:
                # 已有双语格式
                if current_paragraph:
                    untranslated_paragraphs.append({
                        'start': paragraph_start_line,
                        'end': i,
                        'text': '\n'.join(current_paragraph)
                    })
                    current_paragraph = []
                continue
            else:
                # 纯英文列表项
                text = line.strip()[2:].strip() if line.strip().startswith('- ') or line.strip().startswith('* ') else line.strip()[3:].strip()
                if text and len(text) > 10:  # 有实质性内容
                    # 检查下一行是否有翻译
                    has_translation = False
                    # 检查当前行后面2行内是否有翻译
                    for j in range(1, 3):
                        if i + j < len(lines):
                            next_line = lines[i + j].strip()
                            if next_line.startswith('> **中文翻译**：'):
                                has_translation = True
                                break
                    
                    if not has_translation:
                        untranslated_list_items.append({
                            'line': line_num,
                            'text': line.strip()
                        })
                
                # 列表项也属于段落的一部分
                if not current_paragraph:
                    paragraph_start_line = line_num
                current_paragraph.append(line)
                continue
        
        # 积累段落文本
        if not current_paragraph:
            paragraph_start_line = line_num
        
        # 检查当前行是否是纯英文且有实质性内容
        if line.strip() and len(line.strip()) > 20:
            # 检查下一行是否有翻译
            has_translation = False
            for j in range(1, 3):  # 检查后面2行
                if i + j < len(lines):
                    next_line = lines[i + j].strip()
                    if next_line.startswith('> **中文翻译**：'):
                        has_translation = True
                        break
            
            if not has_translation:
                current_paragraph.append(line)
            else:
                # 有翻译，跳过这几行
                skip_next_line = True
    
    # 处理最后一段
    if current_paragraph:
        untranslated_paragraphs.append({
            'start': paragraph_start_line,
            'end': len(lines),
            'text': '\n'.join(current_paragraph)
        })
    
    # 过滤掉过短的段落（可能是误判）
    filtered_paragraphs = []
    for para in untranslated_paragraphs:
        text = para['text'].strip()
        # 过滤掉过短的文本、代码注释等
        if len(text) > 15 and not text.startswith('```') and not text.endswith('```'):
            # 检查是否已经有中文内容
            if not any(c in text for c in '中文翻译'):
                filtered_paragraphs.append(para)
    
    return {
        'file_path': str(file_path),
        'untranslated_paragraphs': filtered_paragraphs,
        'untranslated_list_items': untranslated_list_items,
        'total_untranslated_paragraphs': len(filtered_paragraphs),
        'total_untranslated_list_items': len(untranslated_list_items)
    }

def main():
    docs_dir = Path(".codebuddy/docs")
    
    if not docs_dir.exists():
        print(f"目录不存在: {docs_dir}")
        return
    
    md_files = list(docs_dir.glob("**/*.md"))
    print(f"找到 {len(md_files)} 个 .md 文件")
    
    results = []
    
    for md_file in md_files:
        print(f"分析: {md_file}")
        result = analyze_md_file(md_file)
        results.append(result)
    
    # 生成报告
    with open("translation_audit_detailed.md", "w", encoding="utf-8") as f:
        f.write("# 详细中文翻译完整性审核报告\n\n")
        f.write(f"## 概述\n")
        f.write(f"分析时间: {__import__('datetime').datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"总文件数: {len(md_files)}\n\n")
        
        # 汇总统计
        total_untranslated_paragraphs = sum(r['total_untranslated_paragraphs'] for r in results)
        total_untranslated_list_items = sum(r['total_untranslated_list_items'] for r in results)
        files_with_issues = [r for r in results if r['total_untranslated_paragraphs'] > 0 or r['total_untranslated_list_items'] > 0]
        
        f.write(f"## 汇总统计\n")
        f.write(f"- 总未翻译段落数: {total_untranslated_paragraphs}\n")
        f.write(f"- 总未翻译列表项数: {total_untranslated_list_items}\n")
        f.write(f"- 有翻译问题的文件数: {len(files_with_issues)}\n\n")
        
        f.write("## 详细分析结果\n\n")
        
        for result in sorted(results, key=lambda x: (x['total_untranslated_paragraphs'] + x['total_untranslated_list_items']), reverse=True):
            if result['total_untranslated_paragraphs'] > 0 or result['total_untranslated_list_items'] > 0:
                f.write(f"### {result['file_path']}\n")
                f.write(f"- 未翻译段落数: {result['total_untranslated_paragraphs']}\n")
                f.write(f"- 未翻译列表项数: {result['total_untranslated_list_items']}\n")
                
                if result['untranslated_paragraphs']:
                    f.write("\n**未翻译段落:**\n")
                    for para in result['untranslated_paragraphs']:
                        f.write(f"\n**行 {para['start']}-{para['end']}:**\n")
                        f.write(f"```\n{para['text']}\n```\n")
                
                if result['untranslated_list_items']:
                    f.write("\n**未翻译列表项:**\n")
                    for item in result['untranslated_list_items']:
                        f.write(f"- 行 {item['line']}: {item['text']}\n")
                
                f.write("\n" + "-" * 80 + "\n\n")
    
    print(f"详细报告已生成: translation_audit_detailed.md")
    
    # 生成简表
    with open("translation_audit_summary_table.md", "w", encoding="utf-8") as f:
        f.write("| 文件名 | 未翻译段落数 | 未翻译列表项数 | 备注 |\n")
        f.write("|--------|--------------|----------------|------|\n")
        
        for result in sorted(results, key=lambda x: (x['total_untranslated_paragraphs'] + x['total_untranslated_list_items']), reverse=True):
            rel_path = os.path.relpath(result['file_path'], start=docs_dir)
            
            # 生成备注
            notes = []
            if result['total_untranslated_paragraphs'] > 0:
                notes.append(f"{result['total_untranslated_paragraphs']}个段落需要翻译")
            if result['total_untranslated_list_items'] > 0:
                notes.append(f"{result['total_untranslated_list_items']}个列表项需要翻译")
            
            if not notes:
                notes.append("双语格式完整")
            
            f.write(f"| {rel_path} | {result['total_untranslated_paragraphs']} | {result['total_untranslated_list_items']} | {', '.join(notes)} |\n")

if __name__ == "__main__":
    main()