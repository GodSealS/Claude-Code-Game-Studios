#!/usr/bin/env python3
"""
为 .codebuddy/skills/ 目录下的 SKILL.md 文件添加全文中文翻译。
使用 deep_translator 进行翻译，保留原文结构。
"""

import os
import re
import sys
from pathlib import Path

# 使用 deep_translator
try:
    from deep_translator import GoogleTranslator
    TRANSLATOR_AVAILABLE = True
except ImportError:
    TRANSLATOR_AVAILABLE = False
    print("警告: deep_translator 未安装，将使用占位符翻译")

def translate_text(text, src='en', dest='zh-CN'):
    """翻译文本，如果翻译器不可用则返回占位符"""
    if not text.strip():
        return ""
    
    if not TRANSLATOR_AVAILABLE:
        return f"[待翻译: {text[:50]}...]"
    
    try:
        translator = GoogleTranslator(source=src, target=dest)
        result = translator.translate(text)
        return result
    except Exception as e:
        print(f"翻译出错: {e}")
        return f"[翻译失败: {text[:50]}...]"

def is_code_block(line):
    """检查是否为代码块开始或结束"""
    return line.strip().startswith('```')

def is_frontmatter(line):
    """检查是否为 frontmatter 行"""
    return line.strip() == '---'

def is_translation_marker(line):
    """检查是否为翻译标记行"""
    return '中文翻译' in line or 'Chinese translation' in line

def process_skill_file(filepath):
    """处理单个 SKILL.md 文件"""
    print(f"处理: {filepath}")
    
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    in_frontmatter = False
    in_code_block = False
    output_lines = []
    i = 0
    
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        
        # 处理 frontmatter
        if stripped == '---':
            in_frontmatter = not in_frontmatter
            output_lines.append(line)
            i += 1
            continue
        
        if in_frontmatter:
            output_lines.append(line)
            i += 1
            continue
        
        # 处理代码块
        if is_code_block(line):
            in_code_block = not in_code_block
            output_lines.append(line)
            i += 1
            continue
        
        if in_code_block:
            output_lines.append(line)
            i += 1
            continue
        
        # 跳过空行
        if not stripped:
            output_lines.append(line)
            i += 1
            continue
        
        # 跳过已经是翻译的行
        if is_translation_marker(line):
            output_lines.append(line)
            i += 1
            continue
        
        # 跳过标题（已经双语化）
        if line.startswith('#') and ' / ' in line:
            output_lines.append(line)
            i += 1
            continue
        
        # 对于普通文本行，收集连续段落
        paragraph = []
        while i < len(lines) and lines[i].strip() and not is_code_block(lines[i]) and not is_frontmatter(lines[i]):
            # 检查是否遇到列表项、表格等
            current_line = lines[i]
            if current_line.strip().startswith(('|', '- ', '* ', '1. ', '2. ', '3. ', '4. ', '5. ', '6. ', '7. ', '8. ', '9. ')):
                # 列表项或表格行，单独处理
                break
            paragraph.append(current_line.rstrip('\n'))
            i += 1
        
        if paragraph:
            paragraph_text = ' '.join(paragraph)
            translation = translate_text(paragraph_text)
            output_lines.extend([' '.join(paragraph) + '\n'])
            if translation:
                output_lines.append(f'> **中文翻译**：{translation}\n\n')
            else:
                output_lines.append('\n')
            continue
        
        # 处理列表项
        if stripped.startswith(('- ', '* ', '1. ', '2. ', '3. ', '4. ', '5. ', '6. ', '7. ', '8. ', '9. ')):
            # 收集连续列表项
            list_items = []
            while i < len(lines) and lines[i].strip() and lines[i].strip().startswith(('- ', '* ', '1. ', '2. ', '3. ', '4. ', '5. ', '6. ', '7. ', '8. ', '9. ')):
                list_items.append(lines[i].rstrip('\n'))
                i += 1
            
            for item in list_items:
                output_lines.append(item + '\n')
                # 翻译列表项文本（去掉标记）
                item_text = re.sub(r'^[-*0-9.]+\s*', '', item.strip())
                if item_text:
                    translation = translate_text(item_text)
                    if translation:
                        output_lines.append(f'  > **中文翻译**：{translation}\n')
            output_lines.append('\n')
            continue
        
        # 处理表格行
        if stripped.startswith('|') and stripped.endswith('|'):
            # 收集连续表格行
            table_rows = []
            while i < len(lines) and lines[i].strip().startswith('|') and lines[i].strip().endswith('|'):
                table_rows.append(lines[i].rstrip('\n'))
                i += 1
            
            for row in table_rows:
                output_lines.append(row + '\n')
                # 简单翻译表格内容（跳过分隔行）
                if '---' not in row and '|' in row:
                    # 提取单元格内容
                    cells = [cell.strip() for cell in row.split('|')[1:-1]]
                    for cell in cells:
                        if cell and not cell.startswith('--'):
                            translation = translate_text(cell)
                            if translation:
                                output_lines.append(f'  <!-- 翻译: {translation} -->\n')
            output_lines.append('\n')
            continue
        
        # 默认情况：直接添加行
        output_lines.append(line)
        i += 1
    
    # 写回文件
    with open(filepath, 'w', encoding='utf-8') as f:
        f.writelines(output_lines)
    
    print(f"完成: {filepath}")

def main():
    skills_dir = Path(__file__).parent
    skill_files = list(skills_dir.glob('*/SKILL.md'))
    
    print(f"找到 {len(skill_files)} 个 SKILL.md 文件")
    
    for skill_file in skill_files:
        process_skill_file(skill_file)
    
    print("所有文件处理完成")

if __name__ == '__main__':
    main()