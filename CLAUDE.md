# 使用者通用偏好(跨所有專案)

> 這個檔案由 `bootstrap.ps1` 複製到 `~/.claude/CLAUDE.md`,每次 claude 啟動都會自動載入。
> 只放「不分專案、永遠適用」的偏好;專案相關的脈絡寫在各專案的 `CLAUDE.md`;偶爾才查的事實放 memory。

## 語言
- 用繁體中文回應使用者。

## 開發環境
- 所有開發專案放本機的 `Dev` 資料夾:**桌機 `D:\Dev\<專案名>`、筆電 `C:\Dev\<專案名>`**(視哪個碟有 `Dev` 資料夾為準)。
- **絕對不要**把開發專案放在 Google Drive 同步資料夾(`D:\GoogleDrive\` 或 `我的雲端硬碟` 之下),Drive 同步幾萬個 `node_modules` 小檔會把 SSD 打到塞車,造成電腦當機。
- 工作前先 `cd` 到專案資料夾再啟動 `claude`,這樣 Claude 會自動讀該專案的 `CLAUDE.md` 與該 cwd 的 auto-memory。

## MCP 設定
- 新增 MCP server 一律用 `claude mcp add ... --scope user`(寫到 `~/.claude.json`),不要用 project scope。這樣 CLI 與桌面 app 共用,跨機器同步也只要同步一份。

## Obsidian
- Obsidian vault 位置:`D:\GoogleDrive\Execution\Valut-Wordpress`(僅桌機)。
- 筆記、想法、知識管理走 Obsidian,不要用其他工具。
- Claude / MCP / Obsidian 相關筆記預設放 vault 內 `AI學習/` 子資料夾,YAML frontmatter(title / date / type / tags)。
