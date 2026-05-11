---
name: claude-dotfiles 跨機器同步 repo
description: 跨機器同步 Claude Code 個人化設定（skills / memory / settings / mcpServers）的私有 GitHub repo,建立於 2026-05-10
type: reference
originSessionId: 8a6ed495-2dbb-462b-8d7e-efc4754c6c9d
---
**Repo**:<https://github.com/lacostechiu/claude-dotfiles>(私有)
**本機路徑**:`D:\Dev\claude-dotfiles`

**內容**:
- `skills/` — 自訂 skills(astro / jhost / 部落格 / bricks-academy-preview / modern-web-design 等 8 個)
- `memory/` — 跨對話記憶(7 個檔)
- `settings/settings.json` — 全域設定
- `mcp/mcp-servers.json` — 9 個 MCP server 註冊資訊,絕對路徑用 `${USERPROFILE}` 佔位符
- `bootstrap.ps1` — 新機器套用腳本(複製 + `claude mcp add`)
- `sync-from-machine.ps1` — 把當前 `~/.claude/` 拉進 repo

**不放 repo 的敏感檔**(各機器手動處理):
- `~/.claude/.credentials.json`(Claude 登入 token)→ `claude /login`
- `~/.claude/mcp-credentials/oauth-client.json` → USB / sftp 傳
- `%APPDATA%\gcloud\application_default_credentials.json` → `gcloud auth application-default login`

**Why**:筆電要開機時不用重新摸索安裝流程,8 個 skill + memory 不會兩台分歧。

**How to apply**:
- 桌機改了 skill/memory/settings → `cd D:\Dev\claude-dotfiles; .\sync-from-machine.ps1; git add -A; git commit; git push`
- 筆電拉新版 → `git pull; .\bootstrap.ps1`
- 新增 MCP server 之後也跑 sync 腳本(會重新從 `~/.claude.json` 抽 `mcpServers`)
