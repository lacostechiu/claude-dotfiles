# credentials/

這個資料夾**永遠不進 git**(由 `.gitignore` 排除),用來放本機需要、但不能放雲端的敏感檔。

## 要放這裡的東西

實際上 nothing。這個資料夾在 repo 是空的,只是提醒你:

- `oauth-client.json`(GA + GSC MCP 共用的桌面型 OAuth client)
  → 應該放在 `%USERPROFILE%\.claude\mcp-credentials\oauth-client.json`,**不是這裡**
  → 在新機器上,用 USB 或加密 sftp 從舊機器傳過來

- `application_default_credentials.json`(gcloud ADC token,7 天會過期)
  → 在 `%APPDATA%\gcloud\` 自動產生
  → 重新登入即可:`gcloud auth application-default login --scopes=... --client-id-file=...`

- `.credentials.json`(Claude Code 自己的 OAuth token)
  → 在 `%USERPROFILE%\.claude\` 自動產生
  → 各機器獨立跑 `claude /login`
