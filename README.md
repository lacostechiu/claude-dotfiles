# claude-dotfiles

> 跨機器同步 Claude Code 的個人化設定:skills、memory、settings、MCP servers。
> 主機:Windows 11 / PowerShell 7。

---

## 內容物

```
claude-dotfiles/
├── skills/           # 自訂 skills(astro / jhost / 部落格 / 設計等)
├── memory/           # 跨對話記憶(語言偏好、Obsidian 路徑、開發路徑規範)
├── settings/
│   └── settings.json # ~/.claude/settings.json
├── mcp/
│   └── mcp-servers.json  # mcpServers 區塊,${USERPROFILE} 為佔位符
├── credentials/      # 不入 git,放敏感檔(用 USB / sftp 傳)
├── bootstrap.ps1     # 筆電端執行,把上述內容套用到 ~/.claude/
└── sync-from-machine.ps1  # 任一台執行,把當前環境拉進 repo
```

---

## 在新機器(筆電)第一次設定

### 1. 先裝好前置工具

| 工具 | 安裝 |
|---|---|
| Git | <https://git-scm.com/download/win> |
| Node.js | <https://nodejs.org/>(npx 用) |
| Python 3.10+ | <https://www.python.org/downloads/> |
| pipx | `python -m pip install --user pipx` 然後 `python -m pipx ensurepath` |
| uv / uvx | `powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 \| iex"` |
| gcloud | <https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe> |
| Claude Code | <https://claude.com/claude-code> |

裝完後**重開終端機**讓 PATH 生效。

### 2. clone 這個 repo

```powershell
New-Item -ItemType Directory -Path D:\Dev -Force | Out-Null
cd D:\Dev
git clone git@github.com:lacostechiu/claude-dotfiles.git
cd claude-dotfiles
```

### 3. 跑 bootstrap

```powershell
.\bootstrap.ps1
```

腳本會做:
- 把 `skills\` 鏡射到 `~\.claude\skills\`
- 把 `memory\` 放到 `~\.claude\projects\<編碼後的 home>\memory\`
- 把 `settings\settings.json` 複製到 `~\.claude\settings.json`
- 讀 `mcp\mcp-servers.json`,把 `${USERPROFILE}` 替換成本機路徑,再用 `claude mcp add --scope user` 一一註冊

### 4. 手動補的東西(腳本會印出清單)

- **GA / GSC MCP**:
  ```powershell
  pipx install analytics-mcp
  ```
  uvx 第一次呼叫 `mcp-search-console` 會自動下載。
- **OAuth client**:把 `oauth-client.json` 從桌機 `~\.claude\mcp-credentials\` 複製到筆電同位置(用 USB / 加密 sftp,**不要透過 git**)。
- **gcloud ADC 認證**(每台機器都要做一次,7 天到期再做):
  ```powershell
  gcloud config set project seo-mcp-report
  gcloud auth application-default login `
    --scopes=https://www.googleapis.com/auth/analytics.readonly,https://www.googleapis.com/auth/cloud-platform,https://www.googleapis.com/auth/webmasters.readonly `
    --client-id-file="$env:USERPROFILE\.claude\mcp-credentials\oauth-client.json"
  ```
- **GSC MCP token**:首次在 Claude Code 呼叫 GSC 工具時會跳瀏覽器授權,點允許。
- **Claude Code 登入**:開 Claude Code,跑 `/login`(`.credentials.json` 是機器專屬,不能複製過去)。

### 5. 驗證

```powershell
claude mcp list
```

應該看到 9 個都 `✓ Connected`(GA/GSC 可能要等 ADC 完成)。

---

## 平常維護

**單向同步政策**:桌機是 source of truth,筆電只 pull 不 push。

### 桌機改了東西 → 推到 repo

```powershell
cd D:\Dev\claude-dotfiles
.\sync-from-machine.ps1   # 把 ~/.claude/ 的最新狀態拉進 repo
git add -A
git commit -m "sync: <說明改了什麼>"
git push
```

### 筆電拉最新(只做這個)

```powershell
cd D:\Dev\claude-dotfiles
git pull
.\bootstrap.ps1   # 把 repo 鏡射到 ~/.claude/(用 robocopy /MIR)
```

> ⚠️ **筆電別跑 sync-from-machine.ps1**。筆電對話時 Claude 寫的 memory 是「臨時的」,下次 bootstrap 會被桌機版覆蓋。如果在筆電上學到值得永久保留的事實,口頭交辦在桌機補上就好。

---

## 安全提醒

- ⚠️ `oauth-client.json` 含 `client_secret`,**不放 git**。手動傳。
- ⚠️ `application_default_credentials.json`(在 `%APPDATA%\gcloud\`)是 token,**不要同步**。
- ⚠️ `.credentials.json`(在 `~\.claude\`)是 Claude Code 自己的登入 token,**不要同步**,各機器跑 `/login`。
- ⚠️ `~\.claude.json` 含 `userID`、`oauthAccount`、recently opened projects 等個人資料,所以這 repo **只同步 `mcpServers` 區塊**,不同步整個檔。
