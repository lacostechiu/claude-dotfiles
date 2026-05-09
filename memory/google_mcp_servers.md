---
name: Google Analytics / Search Console MCP 安裝資訊
description: 本機已安裝的 GA 與 GSC MCP 套件名稱、執行檔路徑與啟動方式;Claude Code CLI 與桌面 app 透過 ~/.claude.json 共用設定
type: reference
originSessionId: 8a6ed495-2dbb-462b-8d7e-efc4754c6c9d
---
**GA MCP**(官方 googleanalytics/google-analytics-mcp)
- 套件:`analytics-mcp`(pipx 安裝)
- 執行檔:`C:\Users\W11\.local\bin\analytics-mcp.exe`
- 環境變數:`GOOGLE_PROJECT_ID=seo-mcp-report`
- 認證來源:ADC(`gcloud auth application-default login`)

**GSC MCP**(AminForou/mcp-gsc,套件名 `mcp-search-console`)
- 啟動:`uvx mcp-search-console`(uvx 路徑 `C:\Users\W11\.local\bin\uvx.exe`)
- 環境變數:`GSC_OAUTH_CLIENT_SECRETS_FILE=C:\Users\W11\.claude\mcp-credentials\oauth-client.json`
- 認證來源:獨立 OAuth flow,首次呼叫時會跳瀏覽器授權,token 自存

**Claude Code 設定**:兩個 MCP 都用 `--scope user` 加在 `C:\Users\W11\.claude.json`,CLI 與桌面 app 共用。

**Claude.ai Desktop**(獨立的 Anthropic 客戶端)如未來安裝,設定檔在 `C:\Users\W11\AppData\Roaming\Claude\claude_desktop_config.json`,需另外複製設定。

**Why**:把套件名與執行檔路徑記下來,日後升級、移除或診斷連線問題時不用重新查 GitHub repo。

**How to apply**:
- 升級 GA MCP:`pipx upgrade analytics-mcp`
- 升級 GSC MCP:`uvx --refresh mcp-search-console`(uvx 預設會用快取)
- 移除:`claude mcp remove analytics-mcp --scope user` / `claude mcp remove gsc --scope user`
