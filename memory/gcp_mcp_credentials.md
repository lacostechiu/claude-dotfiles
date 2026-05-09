---
name: GCP / Google MCP 憑證與專案
description: Google Analytics 與 Search Console MCP 共用的 GCP 專案、OAuth 桌面用戶端與 service account 路徑;OAuth consent 是 Testing 模式,測試使用者 100 天到期需重加
type: reference
originSessionId: 8a6ed495-2dbb-462b-8d7e-efc4754c6c9d
---
**GCP 專案(MCP 共用)**:`seo-mcp-report`

**憑證資料夾**:`C:\Users\W11\.claude\mcp-credentials\`
- `oauth-client.json` — 桌面型 OAuth client(GA + GSC 共用,給 ADC 與 GSC MCP 使用)
- `seo-reports-sa.json` — service account(暫未掛在 MCP 上,備用)

**ADC 憑證**:`C:\Users\W11\AppData\Roaming\gcloud\application_default_credentials.json`
- 已授權 scopes:`analytics.readonly` / `cloud-platform` / `webmasters.readonly`
- 重新登入指令:`gcloud auth application-default login --scopes=... --client-id-file=C:\Users\W11\.claude\mcp-credentials\oauth-client.json`

**已啟用 API**:Analytics Data、Analytics Admin、Search Console

**OAuth consent screen**:Testing 模式,test user `lacostechiu@gmail.com`
- ⚠️ refresh token 7 天會失效(Testing 模式限制),需要時重跑 `gcloud auth application-default login`

**Why**:這些是外部 GCP 資源的指針,讀程式碼或 git 歷史都查不到。重灌 / debug / 新增 scope / 換 service account 時會用到。

**How to apply**:
- 任何 Google API MCP(GA、GSC、Drive、BigQuery 等)優先掛在 `seo-mcp-report` 專案下、共用 `oauth-client.json`,避免每個 MCP 各開一個專案。
- 遇到 GA/GSC MCP 401 / token expired 先重跑 ADC login,不要重建 OAuth client。
