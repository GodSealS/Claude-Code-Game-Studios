#!/usr/bin/env python3
"""
为所有 SKILL.md 文件的一级标题添加中文翻译占位符。
格式: # English Title / [中文标题]
"""

import re
from pathlib import Path

def process_file(filepath):
    """处理单个文件"""
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    output = []
    for line in lines:
        stripped = line.strip()
        # 匹配一级标题：以 "# " 开头，且不是 "##"
        if stripped.startswith('# ') and not stripped.startswith('##'):
            # 如果已经包含 " / "，跳过
            if ' / ' not in stripped:
                # 添加翻译占位符
                new_line = line.rstrip('\n') + ' / [中文标题]\n'
                output.append(new_line)
                continue
        
        output.append(line)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.writelines(output)

def main():
    skills_dir = Path(__file__).parent
    skill_files = list(skills_dir.glob('*/SKILL.md'))
    
    print(f"处理 {len(skill_files)} 个文件的一级标题")
    
    for skill_file in skill_files:
        process_file(skill_file)
        print(f"完成: {skill_file}")
    
    print("所有一级标题处理完成")

if __name__ == '__main__':
    main()