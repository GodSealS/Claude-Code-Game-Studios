#!/usr/bin/env python3
"""
分析 .codebuddy/agents/ 目录中 Markdown 文件的中文翻译完整性
"""

import os
import re
import glob
from pathlib import Path
from typing import List, Dict, Tuple

def analyze_file(file_path: str) -> Dict[str, any]:
    """分析单个文件的翻译完整性"""
    results = {
        'file_name': os.path.basename(file_path),
        'total_english_paragraphs': 0,
        'paragraphs_without_translation': 0,
        'paragraphs_with_translation': 0,
        'total_list_items': 0,
        'list_items_without_translation': 0,
        'list_items_with_translation': 0,
        'untranslated_paragraphs': [],
        'untranslated_list_items': []
    }
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"无法读取文件 {file_path}: {e}")
        return results
    
    # 分割成行以便分析
    lines = content.split('\n')
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        
        # 跳过空行
        if not line:
            i += 1
            continue
            
        # 跳过 YAML front matter (以 --- 开头和结束)
        if line == '---':
            i += 1
            while i < len(lines) and lines[i].strip() != '---':
                i += 1
            if i < len(lines):
                i += 1
            continue
            
        # 跳过代码块 (以 ``` 开头)
        if line.startswith('```'):
            i += 1
            while i < len(lines) and not lines[i].strip().startswith('```'):
                i += 1
            if i < len(lines):
                i += 1
            continue
            
        # 跳过标题行 (以 # 开头)
        if line.startswith('#'):
            i += 1
            continue
            
        # 检查段落（不以 - 或 * 或 1. 等开头的文本块）
        if not line.startswith(('- ', '* ', '+ ', '1. ', '2. ', '3. ', '4. ', '5. ', '6. ', '7. ', '8. ', '9. ')):
            # 这是段落文本，需要检查是否有翻译
            paragraph_lines = []
            # 收集连续的非列表、非空行作为段落
            while i < len(lines) and lines[i].strip() and not lines[i].strip().startswith(('- ', '* ', '+ ', '1. ', '2. ', '3. ', '4. ', '5. ', '6. ', '7. ', '8. ', '9. ', '> ', '#', '```')):
                paragraph_lines.append(lines[i])
                i += 1
            
            if paragraph_lines:
                paragraph_text = ' '.join(paragraph_lines).strip()
                if paragraph_text and not paragraph_text.startswith('>'):
                    results['total_english_paragraphs'] += 1
                    
                    # 检查下一行是否是翻译块
                    has_translation = False
                    if i < len(lines):
                        next_line = lines[i].strip()
                        if next_line.startswith('> **中文翻译**：'):
                            results['paragraphs_with_translation'] += 1
                            has_translation = True
                        elif i + 1 < len(lines):
                            next_next_line = lines[i + 1].strip()
                            if next_next_line.startswith('> **中文翻译**：'):
                                results['paragraphs_with_translation'] += 1
                                has_translation = True
                    
                    if not has_translation:
                        results['paragraphs_without_translation'] += 1
                        # 只记录前100个字符作为示例
                        truncated_text = paragraph_text[:100] + ('...' if len(paragraph_text) > 100 else '')
                        results['untranslated_paragraphs'].append(truncated_text)
            
            continue
        
        # 检查列表项
        if line.startswith(('- ', '* ', '+ ', '1. ', '2. ', '3. ', '4. ', '5. ', '6. ', '7. ', '8. ', '9. ')):
            results['total_list_items'] += 1
            
            # 检查列表项是否包含 `/` 格式的双语内容
            if '/' in line:
                # 检查是否有中文翻译（包含中文字符）
                chinese_chars = re.search(r'[\u4e00-\u9fff]', line)
                if chinese_chars:
                    results['list_items_with_translation'] += 1
                else:
                    results['list_items_without_translation'] += 1
                    results['untranslated_list_items'].append(line[:100])
            else:
                # 没有 `/` 格式，检查是否有独立的中文翻译块
                has_translation = False
                j = i + 1
                while j < len(lines) and lines[j].strip().startswith('  '):
                    if '/' in lines[j].strip():
                        has_translation = True
                        break
                    j += 1
                
                if has_translation:
                    results['list_items_with_translation'] += 1
                else:
                    results['list_items_without_translation'] += 1
                    results['untranslated_list_items'].append(line[:100])
            
            i += 1
            continue
        
        i += 1
    
    return results

def main():
    """主分析函数"""
    agents_dir = "e:/Work/Claude-Code-Game-Studios/.codebuddy/agents"
    md_files = glob.glob(os.path.join(agents_dir, "*.md"))
    
    print(f"找到 {len(md_files)} 个 Markdown 文件")
    print("=" * 80)
    
    summary_table = []
    total_issues = 0
    
    for file_path in sorted(md_files):
        print(f"分析: {os.path.basename(file_path)}")
        results = analyze_file(file_path)
        
        if results['paragraphs_without_translation'] > 0 or results['list_items_without_translation'] > 0:
            total_issues += 1
            summary_table.append({
                'File': results['file_name'],
                'Untranslated Paragraphs': results['paragraphs_without_translation'],
                'Untranslated List Items': results['list_items_without_translation'],
                'Note': f"段落: {len(results['untranslated_paragraphs'])}个未翻译，列表项: {len(results['untranslated_list_items'])}个未翻译"
            })
            
            if results['paragraphs_without_translation'] > 0:
                print(f"  ⚠️  有 {results['paragraphs_without_translation']} 个英文段落缺少中文翻译")
                for i, para in enumerate(results['untranslated_paragraphs'][:3]):  # 只显示前3个作为示例
                    print(f"    {i+1}. {para}")
                if len(results['untranslated_paragraphs']) > 3:
                    print(f"    ... 还有 {len(results['untranslated_paragraphs']) - 3} 个未翻译段落")
            
            if results['list_items_without_translation'] > 0:
                print(f"  ⚠️  有 {results['list_items_without_translation']} 个列表项缺少中文翻译")
                for i, item in enumerate(results['untranslated_list_items'][:3]):  # 只显示前3个作为示例
                    print(f"    {i+1}. {item}")
                if len(results['untranslated_list_items']) > 3:
                    print(f"    ... 还有 {len(results['untranslated_list_items']) - 3} 个未翻译列表项")
        else:
            print(f"  ✓ 翻译完整")
        
        print("-" * 80)
    
    # 输出总结表格
    print("\n" + "=" * 80)
    print("翻译完整性审计总结")
    print("=" * 80)
    print(f"总文件数: {len(md_files)}")
    print(f"有翻译问题的文件数: {total_issues}")
    print(f"翻译完整的文件数: {len(md_files) - total_issues}")
    print("\n问题文件汇总表:")
    print("-" * 80)
    print(f"{'文件':<35} {'未翻译段落':<15} {'未翻译列表项':<15} {'备注'}")
    print("-" * 80)
    
    for entry in summary_table:
        print(f"{entry['File']:<35} {entry['Untranslated Paragraphs']:<15} {entry['Untranslated List Items']:<15} {entry['Note']}")
    
    print("-" * 80)

if __name__ == "__main__":
    main()