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
    let paragraphStartLine = 0;
    
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i].trim();
        const rawLine = lines[i];
        
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
                    line: paragraphStartLine,
                    rawText: currentParagraph
                });
                currentParagraph = '';
            }
            continue;
        }
        
        // 检查是否是列表项
        const isListItem = /^[-*+]\s|^\d+\.\s/.test(rawLine);
        
        if (isListItem) {
            // 如果之前有段落，保存它
            if (currentParagraph) {
                paragraphs.push({
                    text: currentParagraph,
                    line: paragraphStartLine,
                    rawText: currentParagraph
                });
                currentParagraph = '';
            }
            
            if (!inList) {
                inList = true;
            }
            currentList.push({
                text: line,
                line: i + 1,
                rawText: rawLine
            });
        } else {
            // 如果之前在列表中，保存列表
            if (inList) {
                if (currentList.length > 0) {
                    lists.push([...currentList]);
                }
                currentList = [];
                inList = false;
            }
            
            // 检查是否是翻译块（以> **中文翻译**：开头）
            if (line.startsWith('> **中文翻译**：')) {
                // 这是翻译块，跳过
                continue;
            }
            
            // 如果是普通文本，添加到段落
            if (!rawLine.startsWith('>')) {
                if (currentParagraph === '') {
                    currentParagraph = rawLine;
                    paragraphStartLine = i + 1;
                } else {
                    currentParagraph += '\n' + rawLine;
                }
            }
        }
    }
    
    // 处理最后一个段落或列表
    if (currentParagraph) {
        paragraphs.push({
            text: currentParagraph,
            line: paragraphStartLine,
            rawText: currentParagraph
        });
    }
    
    if (currentList.length > 0) {
        lists.push([...currentList]);
    }
    
    return { paragraphs, lists, lines };
}

// 检查段落是否有翻译
function checkParagraphTranslation(lines, paraLine) {
    // 检查下一行或下下行是否有翻译块
    for (let offset = 1; offset <= 3; offset++) {
        const checkIdx = paraLine + offset - 1;
        if (checkIdx < lines.length) {
            const checkLine = lines[checkIdx].trim();
            if (checkLine.startsWith('> **中文翻译**：')) {
                return true;
            }
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

// 检查是否是双语标题（包含中文翻译）
function isBilingualHeading(text) {
    return text.includes(' / ') && /[\u4e00-\u9fff]/.test(text);
}

// 主函数
function main() {
    const agentsDir = path.join(__dirname, 'agents');
    const files = fs.readdirSync(agentsDir).filter(f => f.endsWith('.md'));
    
    console.log(`审计目录: ${agentsDir}`);
    console.log(`找到 ${files.length} 个文件`);
    console.log('='.repeat(80));
    
    const results = [];
    let totalUntranslatedParagraphs = 0;
    let totalUntranslatedListItems = 0;
    let filesWithIssues = 0;
    
    for (const file of files) {
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
            
            // 跳过双语标题
            if (isBilingualHeading(para.text)) continue;
            
            // 检查是否是包含中文字符的段落（可能是已翻译）
            if (/[\u4e00-\u9fff]/.test(para.text)) continue;
            
            // 检查翻译
            if (!checkParagraphTranslation(lines, para.line - 1)) {
                untranslatedParagraphs.push({
                    line: para.line,
                    text: para.text.substring(0, 100)
                });
            }
        }
        
        // 检查列表项翻译
        for (const list of lists) {
            for (const item of list) {
                // 跳过短的列表项
                if (item.text.length < 10) continue;
                
                // 跳过双语标题或已包含中文字符的项
                if (isBilingualHeading(item.text) || /[\u4e00-\u9fff]/.test(item.text)) continue;
                
                // 检查翻译
                if (!checkListItemTranslation(item.text)) {
                    untranslatedListItems.push({
                        line: item.line,
                        text: item.text.substring(0, 100)
                    });
                }
            }
        }
        
        if (untranslatedParagraphs.length > 0 || untranslatedListItems.length > 0) {
            filesWithIssues++;
            totalUntranslatedParagraphs += untranslatedParagraphs.length;
            totalUntranslatedListItems += untranslatedListItems.length;
            
            results.push({
                file,
                untranslatedParagraphs: untranslatedParagraphs.length,
                untranslatedListItems: untranslatedListItems.length,
                paragraphSamples: untranslatedParagraphs.slice(0, 2),
                listItemSamples: untranslatedListItems.slice(0, 2)
            });
        }
    }
    
    // 输出详细结果
    console.log('\n' + '='.repeat(80));
    console.log('翻译完整性审计总结');
    console.log('='.repeat(80));
    
    console.log(`\n📊 总体统计:`);
    console.log(`   总文件数: ${files.length}`);
    console.log(`   有翻译问题的文件数: ${filesWithIssues}`);
    console.log(`   翻译完整的文件数: ${files.length - filesWithIssues}`);
    console.log(`   总未翻译段落数: ${totalUntranslatedParagraphs}`);
    console.log(`   总未翻译列表项数: ${totalUntranslatedListItems}`);
    
    console.log('\n📋 问题文件汇总表:');
    console.log('-' .repeat(120));
    console.log('文件'.padEnd(35) + '未翻译段落'.padEnd(15) + '未翻译列表项'.padEnd(20) + '备注');
    console.log('-' .repeat(120));
    
    // 按未翻译数量排序
    const sortedResults = results.sort((a, b) => {
        const totalA = a.untranslatedParagraphs + a.untranslatedListItems;
        const totalB = b.untranslatedParagraphs + b.untranslatedListItems;
        return totalB - totalA; // 降序
    });
    
    for (const result of sortedResults) {
        const note = [];
        if (result.paragraphSamples.length > 0) {
            note.push(`例: "${result.paragraphSamples[0].text}..."`);
        }
        if (result.listItemSamples.length > 0) {
            note.push(`列表: "${result.listItemSamples[0].text}..."`);
        }
        
        console.log(
            result.file.padEnd(35) + 
            result.untranslatedParagraphs.toString().padEnd(15) + 
            result.untranslatedListItems.toString().padEnd(20) + 
            note.join('; ')
        );
    }
    
    console.log('-' .repeat(120));
    
    // 输出前几个问题最严重的文件详情
    console.log('\n🔍 问题最严重的文件详情 (前10个):');
    console.log('='.repeat(80));
    
    const topFiles = sortedResults.slice(0, 10);
    for (let i = 0; i < topFiles.length; i++) {
        const result = topFiles[i];
        console.log(`\n${i+1}. ${result.file} (${result.untranslatedParagraphs}个未翻译段落, ${result.untranslatedListItems}个未翻译列表项)`);
        
        if (result.paragraphSamples.length > 0) {
            console.log('   未翻译段落示例:');
            for (const sample of result.paragraphSamples) {
                console.log(`     [第${sample.line}行] ${sample.text}...`);
            }
        }
        
        if (result.listItemSamples.length > 0) {
            console.log('   未翻译列表项示例:');
            for (const sample of result.listItemSamples) {
                console.log(`     [第${sample.line}行] ${sample.text}...`);
            }
        }
    }
    
    // 输出建议
    console.log('\n' + '='.repeat(80));
    console.log('🎯 翻译修复建议:');
    console.log('='.repeat(80));
    console.log('\n1. 优先修复问题最严重的文件（见上方前10个文件）');
    console.log('2. 修复模式:');
    console.log('   - 段落: 在英文段落后添加 `> **中文翻译**：` 翻译块');
    console.log('   - 列表项: 使用 "English / 中文" 格式添加中文翻译');
    console.log('3. 重点关注:');
    console.log('   - 代理介绍段落（You are...开头）');
    console.log('   - 协作协议段落（Collaboration Protocol）');
    console.log('   - 工作流程列表项');
    console.log('   - 关键职责列表项');
}

// 运行主函数
try {
    main();
} catch (error) {
    console.error('错误:', error.message);
}