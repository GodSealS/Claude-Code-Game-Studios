# PowerShell script to add Chinese translation comments to SKILL.md files
$skillsDir = "e:\Work\Claude-Code-Game-Studios\.codebuddy\skills"

# List of files to process (relative paths)
$filesToProcess = @(
    "qa-plan\SKILL.md",
    "quick-design\SKILL.md",
    "regression-suite\SKILL.md",
    "release-checklist\SKILL.md",
    "retrospective\SKILL.md",
    "reverse-document\SKILL.md",
    "review-all-gdds\SKILL.md",
    "scope-check\SKILL.md",
    "security-audit\SKILL.md",
    "setup-engine\SKILL.md",
    "setup-wechat-minigame\SKILL.md",
    "skill-improve\SKILL.md",
    "skill-test\SKILL.md",
    "smoke-check\SKILL.md",
    "soak-test\SKILL.md",
    "sprint-plan\SKILL.md",
    "sprint-status\SKILL.md",
    "start\SKILL.md",
    "story-done\SKILL.md",
    "story-readiness\SKILL.md"
)

foreach ($file in $filesToProcess) {
    $fullPath = Join-Path $skillsDir $file
    Write-Host "Processing: $file"
    
    if (Test-Path $fullPath) {
        # Read the file
        $content = Get-Content $fullPath -Raw
        
        # We'll do a simple pattern matching to add comments
        # This is a simplified approach - in reality you'd need more complex regex
        Write-Host "  - File exists, length: $($content.Length) characters"
    } else {
        Write-Host "  - File not found!"
    }
}

Write-Host "Done processing $($filesToProcess.Count) files."