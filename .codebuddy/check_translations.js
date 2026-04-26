const fs = require('fs');
const path = require('path');

// 检查翻译完整性的函数
function checkFileTranslation(filePath) {
    const content = fs.readFileSync(filePath, 'utf-8');
    const lines = content.split('\n');
    
    let inCodeBlock = false;
    let inFrontMatter = false;
    let currentParagraph = '';
    let paragraphs = [];
    let lists = [];
    let currentList = [];
    let inList = false;
    
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i].trim();
        
        // 跳过代码块
        if (line.startsWith('```')) {
            inCodeBlock = !inCodeBlock;
            continue;
        }
        if (inCodeBlock) continue;
        
        // 跳过YAML front matter
        if (line === '---') {
            inFrontMatter = !inFrontMatter;
            continue;
        }
        if (inFrontMatter) continue;
        
        // 跳过标题行（以#开头）
        if (line.startsWith('#')) continue;
        
        // 跳过空行
        if (line === '') {
            if (currentParagraph) {
                paragraphs.push({
                    text: currentParagraph,
                    line: i - currentParagraph.split('\n').length + 1
                });
                currentParagraph = '';
            }
            continue;
        }
        
        // 检查是否是列表项
        const isListItem = /^[-*+]\s|^\d+\.\s/.test(line);
        
        if (isListItem) {
            if (!inList) {
                inList = true;
            }
            currentList.push({
                text: line,
                line: i + 1
            });
        } else {
            if (inList) {
                lists.push([...currentList]);
                currentList = [];
                inList = false;
            }
            
            // 检查是否是翻译块（以> **中文翻译**：开头）
            if (line.startsWith('> **中文翻译**：')) {
                // 这是翻译块，跳过
                continue;
            }
            
            // 如果是普通文本，添加到段落
            if (!line.startsWith('>')) {
                if (currentParagraph) {
                    currentParagraph += '\n' + lines[i];
                } else {
                    currentParagraph = lines[i];
                }
            }
        }
    }
    
    // 处理最后一个段落或列表
    if (currentParagraph) {
        paragraphs.push({
            text: currentParagraph,
            line: lines.length - currentParagraph.split('\n').length
        });
    }
    
    if (currentList.length > 0) {
        lists.push([...currentList]);
    }
    
    return { paragraphs, lists };
}

// 检查段落是否有翻译
function checkParagraphTranslation(lines, paraLine) {
    // 检查下一行或下下行是否有翻译块
    for (let offset = 1; offset <= 2; offset++) {
        const checkLine = lines[paraLine + offset];
        if (checkLine && checkLine.trim().startsWith('> **中文翻译**：')) {
            return true;
        }
    }
    return false;
}

// 检查列表项是否有双语格式
function checkListItemTranslation(itemText) {
    // 检查是否有斜杠格式的双语内容
    if (itemText.includes('/')) {
        // 检查是否有中文字符
        return /[\u4e00-\u9fff]/.test(itemText);
    }
    return false;
}

// 主函数
function main() {
    const agentsDir = path.join(__dirname, 'agents');
    const files = fs.readdirSync(agentsDir).filter(f => f.endsWith('.md'));
    
    console.log(`审计目录: ${agentsDir}`);
    console.log(`找到 ${files.length} 个文件`);
    console.log('='.repeat(80));
    
    const results = [];
    
    for (const file of files.slice(0, 20)) { // 先检查前20个文件
        const filePath = path.join(agentsDir, file);
        const content = fs.readFileSync(filePath, 'utf-8');
        const lines = content.split('\n');
        
        const { paragraphs, lists } = checkFileTranslation(filePath);
        
        const untranslatedParagraphs = [];
        const untranslatedListItems = [];
        
        // 检查段落翻译
        for (const para of paragraphs) {
            // 跳过短段落（可能是标题或元数据）
            if (para.text.length < 20) continue;
            
            // 检查翻译
            if (!checkParagraphTranslation(lines, para.line - 1)) {
                untranslatedParagraphs.push(`${para.line}: ${para.text.substring(0, 80)}...`);
            }
        }
        
        // 检查列表项翻译
        for (const list of lists) {
            for (const item of list) {
                // 跳过短的列表项
                if (item.text.length < 10) continue;
                
                // 检查翻译
                if (!checkListItemTranslation(item.text)) {
                    untranslatedListItems.push(`${item.line}: ${item.text.substring(0, 80)}...`);
                }
            }
        }
        
        if (untranslatedParagraphs.length > 0 || untranslatedListItems.length > 0) {
            results.push({
                file,
                untranslatedParagraphs: untranslatedParagraphs.length,
                untranslatedListItems: untranslatedListItems.length,
                paragraphSamples: untranslatedParagraphs.slice(0, 2),
                listItemSamples: untranslatedListItems.slice(0, 2)
            });
            
            console.log(`\n📄 ${file}`);
            if (untranslatedParagraphs.length > 0) {
                console.log(`  ⚠️  有 ${untranslatedParagraphs.length} 个未翻译段落`);
                for (const sample of untranslatedParagraphs.slice(0, 2)) {
                    console.log(`    ${sample}`);
                }
            }
            if (untranslatedListItems.length > 0) {
                console.log(`  ⚠️  有 ${untranslatedListItems.length} 个未翻译列表项`);
                for (const sample of untranslatedListItems.slice(0, 2)) {
                    console.log(`    ${sample}`);
                }
            }
        }
    }
    
    console.log('\n' + '='.repeat(80));
    console.log('审计总结 (前20个文件)');
    console.log('='.repeat(80));
    
    console.log(`\n📊 有翻译问题的文件: ${results.length} 个`);
    
    if (results.length > 0) {
        console.log('\n详细汇总:');
        console.log('-' .repeat(80));
        console.log('文件'.padEnd(40) + '未翻译段落'.padEnd(15) + '未翻译列表项');
        console.log('-' .repeat(80));
        
        for (const result of results) {
            console.log(
                result.file.padEnd(40) + 
                result.untranslatedParagraphs.toString().padEnd(15) + 
                result.untranslatedListItems.toString()
            );
        }
    }
}

// 运行主函数
try {
    main();
} catch (error) {
    console.error('错误:', error.message);
}