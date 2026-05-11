---
name: claude-dotfiles 同步工作流程
description: 桌機是 source of truth(寫入端),筆電只 pull 不 push;筆電 memory 漂移由使用者口頭交辦補回
type: feedback
originSessionId: 8a6ed495-2dbb-462b-8d7e-efc4754c6c9d
---
**規則**:`claude-dotfiles` 同步走「桌機推、筆電拉」單向:
- **桌機(Windows W11)**:正常工作。改完 skills / memory / settings / MCP 後 → `sync-from-machine.ps1` → commit → push
- **筆電**:只 `git pull && .\bootstrap.ps1`,**不跑 sync,不 push**

**Why**:筆電以「使用」Claude 為主,不開發 skill、不主動養 memory,單向同步最簡單,避免兩台分支衝突。

**How to apply**:
- 在筆電對話時若 Claude 想寫新的 memory(新的偏好、新專案資訊等),正常寫沒關係,但要知道**下次 `bootstrap.ps1` 跑 `robocopy /MIR` 會被桌機版蓋掉**
- 若使用者在筆電講出值得永久保留的事實,**主動提醒**:「這條筆電 memory 下次同步會被覆蓋。要保留的話跟我說『也存到桌機』,我下次在桌機處理時補上。」
- 不要建議使用者在筆電跑 `sync-from-machine.ps1`(腳本本身允許跑,只是不該用)
