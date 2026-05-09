# sync-from-machine.ps1
# 把當前機器的 ~/.claude/ 拉進這個 repo,之後 git commit + push 就完成同步
# 用法:在 dotfiles repo 根目錄執行 .\sync-from-machine.ps1

$ErrorActionPreference = 'Stop'

$repoRoot    = $PSScriptRoot
$claudeDir   = Join-Path $env:USERPROFILE '.claude'
$encodedHome = ($env:USERPROFILE -replace ':','' -replace '[\\/]','-')
$memorySrc   = Join-Path $claudeDir "projects\$encodedHome\memory"

Write-Host '== 從 ~/.claude/ 同步進 repo ==' -ForegroundColor Cyan

# 1. skills
$skillsSrc = Join-Path $claudeDir 'skills'
$skillsDst = Join-Path $repoRoot 'skills'
& robocopy $skillsSrc $skillsDst /MIR /XD .obsidian /NFL /NDL /NP /NJH /NJS | Out-Null
if ($LASTEXITCODE -gt 7) { Write-Host '[X] robocopy skills failed' -ForegroundColor Red; exit 1 }
Write-Host "[OK] skills" -ForegroundColor Green

# 2. memory
$memoryDst = Join-Path $repoRoot 'memory'
if (Test-Path $memorySrc) {
    & robocopy $memorySrc $memoryDst /MIR /NFL /NDL /NP /NJH /NJS | Out-Null
    if ($LASTEXITCODE -gt 7) { Write-Host '[X] robocopy memory failed' -ForegroundColor Red; exit 1 }
    Write-Host "[OK] memory" -ForegroundColor Green
} else {
    Write-Host "[!] 找不到 $memorySrc(本機可能還沒有 memory)" -ForegroundColor Yellow
}

# 3. settings.json
$settingsSrc = Join-Path $claudeDir 'settings.json'
Copy-Item $settingsSrc (Join-Path $repoRoot 'settings\settings.json') -Force
Write-Host '[OK] settings.json' -ForegroundColor Green

# 4. 從 ~/.claude.json 抽出 mcpServers,把 USERPROFILE 換成佔位符
$rootJson = Get-Content (Join-Path $env:USERPROFILE '.claude.json') -Raw | ConvertFrom-Json -AsHashtable
$mcpJson = $rootJson.mcpServers | ConvertTo-Json -Depth 8
$mcpJson = $mcpJson -replace [regex]::Escape(($env:USERPROFILE -replace '\\','\\\\')), '${USERPROFILE}'
$mcpJson = $mcpJson -replace [regex]::Escape(($env:USERPROFILE -replace '\\','/')), '${USERPROFILE}'
[System.IO.File]::WriteAllText(
    (Join-Path $repoRoot 'mcp\mcp-servers.json'),
    $mcpJson,
    [System.Text.UTF8Encoding]::new($false))
Write-Host '[OK] mcp-servers.json(已替換 USERPROFILE)' -ForegroundColor Green

Write-Host ''
Write-Host '完成。檢查 diff 後 git commit + push。' -ForegroundColor Cyan
Write-Host '   git -C "{0}" status' -f $repoRoot
