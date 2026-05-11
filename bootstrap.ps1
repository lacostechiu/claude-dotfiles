# bootstrap.ps1
# 把 claude-dotfiles 的內容套用到本機 ~/.claude/
# 用法:在 dotfiles repo 根目錄執行 .\bootstrap.ps1

$ErrorActionPreference = 'Stop'

$repoRoot   = $PSScriptRoot
$claudeDir  = Join-Path $env:USERPROFILE '.claude'
$encodedHome = ($env:USERPROFILE -replace '[:\\/]','-')
$projectsDir = Join-Path $claudeDir "projects\$encodedHome"
$memoryDir   = Join-Path $projectsDir 'memory'

Write-Host '== Claude dotfiles bootstrap ==' -ForegroundColor Cyan
Write-Host "USERPROFILE : $env:USERPROFILE"
Write-Host "Encoded home: $encodedHome"
Write-Host "Memory dir  : $memoryDir"
Write-Host ''

# 1. 確認 claude CLI
$claude = Get-Command claude -ErrorAction SilentlyContinue
if (-not $claude) {
    Write-Host '[X] 找不到 claude CLI。先安裝 Claude Code:https://claude.com/claude-code' -ForegroundColor Red
    exit 1
}
Write-Host "[OK] claude CLI: $($claude.Source)" -ForegroundColor Green

# 2. 確保目錄存在
New-Item -ItemType Directory -Path $claudeDir,$projectsDir,$memoryDir -Force | Out-Null

# 3. 鏡射 skills
$skillsSrc = Join-Path $repoRoot 'skills'
$skillsDst = Join-Path $claudeDir 'skills'
Write-Host '-- 同步 skills --'
& robocopy $skillsSrc $skillsDst /MIR /NFL /NDL /NP /NJH /NJS | Out-Null
if ($LASTEXITCODE -gt 7) { Write-Host "[X] robocopy skills failed ($LASTEXITCODE)" -ForegroundColor Red; exit 1 }
Write-Host "[OK] skills -> $skillsDst" -ForegroundColor Green

# 4. 鏡射 memory(注意:會覆蓋目標,但只動 memory 子資料夾)
$memorySrc = Join-Path $repoRoot 'memory'
Write-Host '-- 同步 memory --'
& robocopy $memorySrc $memoryDir /MIR /NFL /NDL /NP /NJH /NJS | Out-Null
if ($LASTEXITCODE -gt 7) { Write-Host "[X] robocopy memory failed ($LASTEXITCODE)" -ForegroundColor Red; exit 1 }
Write-Host "[OK] memory -> $memoryDir" -ForegroundColor Green

# 5. settings.json
$settingsSrc = Join-Path $repoRoot 'settings\settings.json'
$settingsDst = Join-Path $claudeDir 'settings.json'
Copy-Item $settingsSrc $settingsDst -Force
Write-Host "[OK] settings.json -> $settingsDst" -ForegroundColor Green

# 6. 註冊 MCP servers
$mcpSrc = Join-Path $repoRoot 'mcp\mcp-servers.json'
$raw = Get-Content $mcpSrc -Raw
# 把 ${USERPROFILE} 換回本機路徑,要先 JSON-encode(\ -> \\),才能進 JSON 字串裡
$upJson = ($env:USERPROFILE -replace '\\','\\')   # C:\Users\W11 -> C:\\Users\\W11
$raw = $raw.Replace('${USERPROFILE}', $upJson)
$mcp = $raw | ConvertFrom-Json -AsHashtable

Write-Host '-- 註冊 MCP servers --'
foreach ($name in $mcp.Keys) {
    $cfg = $mcp[$name]
    $cmd = $cfg.command
    $argv = @($cfg.args)
    $envArgs = @()
    if ($cfg.env) {
        foreach ($k in $cfg.env.Keys) { $envArgs += @('-e', "$k=$($cfg.env[$k])") }
    }

    # 先移除舊的(若有),忽略錯誤
    & claude mcp remove $name --scope user 2>$null | Out-Null

    $addArgs = @('mcp','add', $name, '--scope', 'user') + $envArgs + @('--', $cmd) + $argv
    & claude @addArgs
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] mcp add $name" -ForegroundColor Green
    } else {
        Write-Host "[!] mcp add $name 失敗 (exit $LASTEXITCODE)" -ForegroundColor Yellow
    }
}

Write-Host ''
Write-Host '== 完成 ==' -ForegroundColor Cyan
Write-Host ''
Write-Host '剩下要手動做的:'
Write-Host '  1. pipx install analytics-mcp  (GA MCP 執行檔)'
Write-Host '  2. 把 oauth-client.json 從桌機複製到:'
Write-Host "     $env:USERPROFILE\.claude\mcp-credentials\oauth-client.json"
Write-Host '  3. gcloud auth application-default login(見 README)'
Write-Host '  4. claude /login'
Write-Host '  5. claude mcp list  驗證'
