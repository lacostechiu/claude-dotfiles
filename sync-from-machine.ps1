# sync-from-machine.ps1
# 把當前機器的 ~/.claude/ 拉進這個 repo,之後 git commit + push 就完成同步
# 用法:在 dotfiles repo 根目錄執行 .\sync-from-machine.ps1

$ErrorActionPreference = 'Stop'

# 不要同步的 MCP server(只裝在桌機,筆電不裝)
# 想新增 desktop-only MCP 加在這
$ExcludeMcp = @('obsidian','notebooklm-mcp')

$repoRoot    = $PSScriptRoot
$claudeDir   = Join-Path $env:USERPROFILE '.claude'
$encodedHome = ($env:USERPROFILE -replace '[:\\/]','-')
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

# 4. 全域 CLAUDE.md
$claudeMdSrc = Join-Path $claudeDir 'CLAUDE.md'
if (Test-Path $claudeMdSrc) {
    Copy-Item $claudeMdSrc (Join-Path $repoRoot 'CLAUDE.md') -Force
    Write-Host '[OK] CLAUDE.md' -ForegroundColor Green
} else {
    Write-Host '[!] ~/.claude/CLAUDE.md 不存在,略過' -ForegroundColor Yellow
}

# 5. 從 ~/.claude.json 抽出 mcpServers,排除 desktop-only,把 USERPROFILE 與 DEV_ROOT 換成佔位符
$rootJson = Get-Content (Join-Path $env:USERPROFILE '.claude.json') -Raw | ConvertFrom-Json -AsHashtable
$filtered = [ordered]@{}
$skipped = @()
foreach ($name in $rootJson.mcpServers.Keys) {
    if ($ExcludeMcp -contains $name) { $skipped += $name; continue }
    $filtered[$name] = $rootJson.mcpServers[$name]
}
$mcpJson = $filtered | ConvertTo-Json -Depth 8
# 用 string .Replace() 避開 -replace 把 ${USERPROFILE} 當成 regex backreference
$upBack = ($env:USERPROFILE -replace '\\','\\')     # C:\\Users\\W11 (JSON 編碼形式,每 \ 變成 \\)
$upFwd  = ($env:USERPROFILE -replace '\\','/')      # C:/Users/W11
$mcpJson = $mcpJson.Replace($upBack, '${USERPROFILE}')
$mcpJson = $mcpJson.Replace($upFwd,  '${USERPROFILE}')
# DEV_ROOT:把 D:\Dev 或 C:\Dev(視當前機器有哪個)替換為佔位符
foreach ($dev in 'D:\Dev','C:\Dev') {
    $devBack = $dev -replace '\\','\\'
    $devFwd  = $dev -replace '\\','/'
    $mcpJson = $mcpJson.Replace($devBack, '${DEV_ROOT}')
    $mcpJson = $mcpJson.Replace($devFwd,  '${DEV_ROOT}')
}
[System.IO.File]::WriteAllText(
    (Join-Path $repoRoot 'mcp\mcp-servers.json'),
    $mcpJson,
    [System.Text.UTF8Encoding]::new($false))
Write-Host "[OK] mcp-servers.json(納入 $($filtered.Count) 個,排除:$($skipped -join ', '))" -ForegroundColor Green

Write-Host ''
Write-Host '完成。檢查 diff 後 git commit + push。' -ForegroundColor Cyan
Write-Host ("   git -C `"{0}`" status" -f $repoRoot)
