#!/usr/bin/env python3
"""
为 .codebuddy/skills/ 目录下的 SKILL.md 文件进行全文双语化。
处理标题、段落、列表、表格等，添加中文翻译占位符。
跳过已包含中文翻译的块。
"""

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

def get_block_type(lines):
    """判断块类型：标题、列表、表格、代码、普通段落"""
    if not lines:
        return 'empty'
    
    first_line = lines[0].strip()
    
    # 标题：以 1-6 个 # 开头
    if re.match(r'^#{1,6}\s', first_line):
        return 'heading'
    
    # 列表项：以 -、*、或数字. 开头
    if re.match(r'^(\s*[-*]\s|\s*\d+\.\s)', first_line):
        return 'list'
    
    # 表格行：以 | 开头和结尾
    if re.match(r'^\s*\|', first_line) and re.search(r'\|\s*$', first_line):
        return 'table'
    
    # 代码块：已经由外层处理
    return 'paragraph'

def needs_translation(block_text):
    """检查块是否需要翻译（是否包含中文）"""
    # 如果已经包含中文，则不需要翻译
    if contains_chinese(block_text):
        return False
    
    # 检查是否是双语标题格式：包含 " / " 且后面有中文
    if ' / ' in block_text:
        parts = block_text.split(' / ', 1)
        if len(parts) == 2 and contains_chinese(parts[1]):
            return False
    
    return True

def process_heading(line):
    """处理标题，添加中文翻译占位符"""
    # 如果标题已经包含 " / "，假设已经双语化
    if ' / ' in line:
        return line
    
    # 提取标题级别和文本
    match = re.match(r'^(#{1,6})\s+(.*)$', line)
    if not match:
        return line
    
    level = match.group(1)
    text = match.group(2).strip()
    
    # 添加中文翻译占位符
    return f'{level} {text} / [中文标题]\n'

def process_paragraph(lines):
    """处理段落块，添加翻译占位符"""
    output = []
    output.extend(lines)
    output.append('> **中文翻译**：[待翻译]\n')
    return output

def process_list(lines):
    """处理列表块，为整个列表添加翻译占位符"""
    output = []
    output.extend(lines)
    output.append('> **中文翻译**：[待翻译]\n')
    return output

def process_table(lines):
    """处理表格块，为整个表格添加翻译占位符（跳过分隔行）"""
    output = []
    output.extend(lines)
    # 表格通常不需要整体翻译，但添加占位符以供参考
    output.append('<!-- 表格翻译占位符 -->\n')
    return output

def split_into_blocks(lines):
    """将行分割成块（由空行分隔）"""
    blocks = []
    current_block = []
    
    for line in lines:
        stripped = line.strip()
        if not stripped and current_block:
            # 空行结束当前块
            blocks.append(current_block)
            current_block = []
        elif stripped:
            # 非空行添加到当前块
            current_block.append(line)
        else:
            # 空行且当前块为空，忽略
            pass
    
    if current_block:
        blocks.append(current_block)
    
    return blocks

def process_file(filepath):
    """处理单个 SKILL.md 文件"""
    print(f"处理: {filepath}")
    
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    # 分割成块
    blocks = split_into_blocks(lines)
    
    output_lines = []
    in_frontmatter = False
    in_code_block = False
    
    for block in blocks:
        if not block:
            output_lines.append('\n')
            continue
        
        # 检查 frontmatter
        first_line = block[0]
        if is_frontmatter(first_line):
            in_frontmatter = not in_frontmatter
            output_lines.extend(block)
            output_lines.append('\n')
            continue
        
        if in_frontmatter:
            output_lines.extend(block)
            output_lines.append('\n')
            continue
        
        # 检查代码块
        if is_code_block(first_line):
            in_code_block = not in_code_block
            output_lines.extend(block)
            output_lines.append('\n')
            continue
        
        if in_code_block:
            output_lines.extend(block)
            output_lines.append('\n')
            continue
        
        # 获取块类型
        block_type = get_block_type(block)
        
        # 检查是否需要翻译
        block_text = ''.join(block)
        if not needs_translation(block_text):
            output_lines.extend(block)
            output_lines.append('\n')
            continue
        
        # 根据块类型处理
        if block_type == 'heading':
            # 标题处理（假设每个块只有一个标题行）
            heading_line = block[0]
            processed = process_heading(heading_line)
            output_lines.append(processed)
        elif block_type == 'list':
            processed = process_list(block)
            output_lines.extend(processed)
        elif block_type == 'table':
            processed = process_table(block)
            output_lines.extend(processed)
        else:  # paragraph
            processed = process_paragraph(block)
            output_lines.extend(processed)
        
        output_lines.append('\n')
    
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
    
    print("\n所有文件处理完成")
    print("注意事项:")
    print("- 标题已添加中文翻译占位符（格式: '## English Title / [中文标题]'）")
    print("- 段落、列表已添加 '> **中文翻译**：[待翻译]' 占位符")
    print("- 表格已添加注释占位符")
    print("- 请用实际的中文翻译替换 '[中文标题]' 和 '[待翻译]'")
    print("- 已经包含中文翻译的块已跳过")

if __name__ == '__main__':
    main()