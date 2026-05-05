$ErrorActionPreference = 'Stop'

$scriptDir = $PSScriptRoot
if (-not $scriptDir) { $scriptDir = (Get-Location).Path }

$configPath = Join-Path $scriptDir 'CC_CN_Config'
if (-not (Test-Path $configPath)) {
    Write-Error "配置文件不存在: $configPath"
    exit 1
}

$config = Get-Content $configPath -Raw | ConvertFrom-Json
$direction = $config.mappings.cn_to_cc

$excludeFiles = @('CC_CN_Config', 'CC_2_CN.ps1', 'CN_2_CC.ps1', 'CC_2_CN.bat', 'CN_2_CC.bat')
$files = Get-ChildItem -Path $scriptDir -Recurse -Include '*.md','*.yaml','*.yml','*.json' | Where-Object {
    $relative = $_.FullName.Substring($scriptDir.Length).TrimStart('\','/')
    -not ($relative -like '.git/*') -and
    $excludeFiles -notcontains $_.Name
}

$updatedCount = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $original = $content
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)

    # 1. 处理 agent/skill 文件中的 model 行
    if ($direction.agent_overrides.PSObject.Properties.Name -contains $fileName) {
        $targetModel = $direction.agent_overrides.$fileName
        $content = $content -replace '(?m)^model:.*$', "model: $targetModel"
    } else {
        foreach ($src in $direction.default_models.PSObject.Properties.Name) {
            $dst = $direction.default_models.$src
            $content = $content -replace "(?m)^model:\s*$src\s*$", "model: $dst"
        }
    }

    # 2. 处理文档文本替换
    foreach ($pair in $direction.text_replacements) {
        $src = $pair[0]
        $dst = $pair[1]
        $content = $content -replace [regex]::Escape($src), $dst
    }

    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($false))
        Write-Host "已更新: $($file.FullName)"
        $updatedCount++
    }
}

Write-Host ""
Write-Host "[CN -> CC] 模型配置切换完成. 共更新 $updatedCount 个文件."
