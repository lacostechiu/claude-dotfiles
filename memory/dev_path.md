---
name: 本機開發專案路徑規範
description: 所有 Node / Astro / 含 node_modules 的開發專案放在 D:\Dev,絕不放在 Google Drive 同步路徑下;曾因此造成電腦當機
type: feedback
originSessionId: 8a6ed495-2dbb-462b-8d7e-efc4754c6c9d
---
**規則**:任何含 `node_modules` / `.git/objects` / `dist` / `.next` / `.astro` 的開發專案一律放在 `D:\Dev\<專案名>`,**不要放** `D:\GoogleDrive\Execution\` 之下。

**已搬遷**:
- `D:\Dev\Astro`(GitHub: `lacostechiu/jhost-platform`)— 主開發專案

**已退役**(2026-04-30):
- `astro-single`(GitHub: `lacostechiu/astro-demo`)已不再使用,網站改用 Jhost 平台重做。本機已刪除(2026-05-08);原本內含的 5 個網頁文案 md 已搬到 `D:\GoogleDrive\Execution\jhost-copy`,要上 Jhost 平台時取用。

**Claude Code session 路徑**:換 cwd 後 `/resume` 看不到舊對話,因為 session 存在 `~\.claude\projects\<encoded-cwd>\`(編碼規則:去 `:`、`\`/`/` → `-`)。搬路徑時要把舊 encoded 資料夾的 `*.jsonl`、`memory\` 與 attachment 子資料夾一起複製到新 encoded 資料夾。

**Why**:2026-04-30 實測,Astro 專案 4 萬檔放在 Drive 同步路徑下,Drive 監控 + npm/HMR 雙重 I/O 把 SSD 打到塞車,32 GB RAM + Core Ultra 7 也會卡住當機。Drive 設計就不適合同步幾萬個小檔。

**How to apply**:
- 建議路徑時,優先用 `D:\Dev\<name>`,不要建議 Drive 路徑
- 客戶素材 / 設計稿 / SOP 文件等小數量 → 放 Drive 沒問題
- 若發現使用者把新專案放在 Drive 路徑,主動提醒搬到 `D:\Dev\`
- 雲端備份用 GitHub,不要靠 Drive 備份程式碼
- 詳細搬遷 SOP 與替換腳本在 `D:\GoogleDrive\Execution\ClaudeManual\開發專案路徑與電腦效能.md`
