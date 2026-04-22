#!/usr/bin/env python3
"""
为 .codebuddy/skills/ 目录下的 SKILL.md 文件添加中文翻译占位符。
在每段英文文本后添加 > **中文翻译**：[待翻译] 块。
跳过已包含中文翻译的段落。
"""

import os
import re
from pathlib import Path

def contains_chinese(text):
    """检查文本是否包含中文字符"""
    return bool(re.search(r'[\u4e00-\u9fff]', text))

def is_translation_line(line):
    """检查是否为翻译行（包含中文翻译标记）"""
    return '> **中文翻译**：' in line or '> **Chinese translation**:' in line

def is_frontmatter(line):
    """检查是否为 frontmatter 分隔线"""
    return line.strip() == '---'

def is_code_block(line):
    """检查是否为代码块开始或结束"""
    return line.strip().startswith('```')

def is_already_translated(text):
    """检查文本是否已经包含中文翻译（通过检查中文字符或翻译标记）"""
    if contains_chinese(text):
        return True
    # 检查是否在行内翻译格式，如 "English / 中文"
    if ' / ' in text and contains_chinese(text.split(' / ')[-1]):
        return True
    return False

def process_file(filepath):
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
        if is_frontmatter(line):
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
        if is_translation_line(line):
            output_lines.append(line)
            i += 1
            continue
        
        # 检查标题是否已经双语化（包含 " / " 且后面有中文）
        if line.startswith('#') and ' / ' in line:
            parts = line.split(' / ', 1)
            if len(parts) == 2 and contains_chinese(parts[1]):
                # 标题已经双语化，跳过
                output_lines.append(line)
                i += 1
                continue
        
        # 收集连续的文本块（段落）
        block_lines = []
        while i < len(lines) and lines[i].strip() and not is_code_block(lines[i]) and not is_frontmatter(lines[i]):
            # 检查是否遇到列表项、表格等特殊格式
            current_line = lines[i]
            # 如果是列表项或表格行，单独处理
            if current_line.strip().startswith(('|', '- ', '* ', '1. ', '2. ', '3. ', '4. ', '5. ', '6. ', '7. ', '8. ', '9. ')):
                # 如果当前块不为空，先处理当前块
                if block_lines:
                    break
                # 否则开始新的特殊块
                special_lines = []
                # 收集连续的列表项或表格行
                while i < len(lines) and lines[i].strip() and (lines[i].strip().startswith(('|', '- ', '* ', '1. ', '2. ', '3. ', '4. ', '5. ', '6. ', '7. ', '8. ', '9. '))):
                    special_lines.append(lines[i])
                    i += 1
                # 处理特殊块
                if special_lines:
                    # 为整个特殊块添加翻译占位符
                    special_text = ''.join(special_lines).strip()
                    if not is_already_translated(special_text):
                        # 添加特殊块内容
                        output_lines.extend(special_lines)
                        # 添加翻译占位符
                        output_lines.append(f'> **中文翻译**：[待翻译]\n\n')
                    else:
                        output_lines.extend(special_lines)
                        output_lines.append('\n')
                continue
            
            block_lines.append(lines[i])
            i += 1
        
        if block_lines:
            block_text = ''.join(block_lines).strip()
            if not is_already_translated(block_text):
                # 添加原文
                output_lines.extend(block_lines)
                # 添加翻译占位符
                output_lines.append(f'> **中文翻译**：[待翻译]\n\n')
            else:
                output_lines.extend(block_lines)
                output_lines.append('\n')
            continue
        
        # 如果既不是文本块也不是特殊块，直接添加行
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
        process_file(skill_file)
    
    print("所有文件处理完成")
    print("\n注意：")
    print("- 已在每段英文文本后添加 '> **中文翻译**：[待翻译]' 占位符")
    print("- 请用实际的中文翻译替换 '[待翻译]'")
    print("- 已经包含中文翻译的段落（如description字段）已跳过")

if __name__ == '__main__':
    main()