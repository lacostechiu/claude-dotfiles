---
name: MCP 設定偏好
description: 新增 MCP 時一律使用 --scope user，讓任何目錄都能用
type: feedback
originSessionId: 5e89b347-a019-4896-924a-f72090ce726b
---
新增 Claude Code CLI 的 MCP 時，一律使用 `claude mcp add --scope user <name> -- <command>`。

**Why**: 使用者想在任何目錄啟動 Claude Code 都能用到 MCP。過去踩雷過——MCP 預設會綁在當下工作目錄，換資料夾就看不到。2026-04-25 的 session 中使用者明確要求把 Obsidian、NotebookLM 等 MCP 全部改成 user scope。

**How to apply**: 幫使用者加裝新 MCP 時不用問要不要 user scope，直接加 `--scope user`。若指令沒 scope 參數（例如第三方工具自己寫進 config），要提醒使用者確認是否寫進了 user 區塊。
