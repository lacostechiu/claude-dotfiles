---
name: astro-client-page
description: 為「已建立的客戶 Astro 網站」新增單個頁面（about / services / contact / pricing / FAQ / 案例集 / 團隊 / 隱私政策 等）。觸發時機：客戶網站已 provision 完成，現在要在 src/pages/ 加新的 .astro 檔，或要決定某頁的 title / description / 內文。不適用於建立整個新客戶專案（用 astro-client-site）；不適用於修改 BaseLayout / 模板共通結構（也用 astro-client-site）；不適用於寫部落格文章（用編輯器 UI）。
---

# 為客戶 Astro 網站新增單一頁面

當客戶說「我要加一個關於我們頁面 / 服務頁 / 聯絡頁⋯⋯」時用這個 skill。

---

## 第一原則：方案 B（content-driven）— 客戶寫文案，Claude 排版

### 為什麼必須用方案 B

| 比較 | 方案 A（Claude 寫文案） | 方案 B（客戶寫文案） |
|------|----------------------|------------------|
| 品牌口吻 | ✗ 「無國籍商業文案」 | ✓ 100% 客戶口吻 |
| 具體事實 | ✗ AI 可能編年份/姓名/執照字號 | ✓ 全是客戶提供的真實資料 |
| SEO 關鍵字 | ✗ AI 隨機分布 | ✓ 客戶決定密度與位置 |
| 法規敏感（醫療/法律/財經） | ✗ 可能踩線 | ✓ 安全 |
| 客戶自己 review | 需仔細逐字校對 | 只需確認排版 |

**方案 A 只在客戶還沒寫好任何文案、想看雛形長相時用**。正式上線一律用方案 B。

---

## 方案 B 工作流（3 步驟）

### Step 1：請客戶準備文案稿

任何頁面都要 4 個欄位：

```yaml
slug: about              # URL 路徑（小寫英數橫線）
title: <一句話，8-30 字，含關鍵字>
description: <50-160 字 SEO 描述，含關鍵字 + 痛點 + 解法>
body: |
  <完整 markdown 內文，含 H1/H2/H3、段落、列表>
```

每類頁面的「**body 應包含什麼**」見下面第 III 節。

### Step 2：丟給 Claude Code 排版

通用 prompt（任何頁面都用這個）：

```
請先讀以下檔案理解現有風格：
- src/layouts/BaseLayout.astro
- src/pages/index.astro
- src/content/site/site.yaml

然後幫我加一個新頁面，存到 src/pages/<<slug>>.astro。

【嚴格要求】
1. 文字一字不改，照我提供的原文使用（保留標點、換行、術語）
2. Markdown 結構自然映射到 HTML（H1 / H2 / H3 / 段落 / 列表 / 引言 / 連結）
3. 用 <BaseLayout title="..." description="..."> 包起來，title 與 description 用我給的「原文」
4. 排版視覺風格參考 src/pages/index.astro：間距、字體、區塊分隔線、CTA 按鈕等
5. 響應式（手機 / 平板 / 桌機都要好看）
6. 圖片用 <img loading="lazy" />（除非是該頁的 hero 圖才用 fetchpriority="high" loading="eager"）
7. 加上 nav：改 src/content/site/site.yaml 的 nav 把這頁加進去（label 用一個短的）
8. CSS 一律用 design tokens（var(--text-base)、var(--space-2xl) 等），不要寫死 0.85rem / 6rem 等數值。若該客戶站還沒 tokens.css，回頭跑 astro-client-site skill 補上。

【內容】
slug: <貼客戶提供>
title: <貼客戶提供>
description: <貼客戶提供>

body:
<貼客戶提供的完整 markdown body>
```

### Step 3：跑完後檢查
- `npm run dev` 開本機預覽
- 對比客戶原稿，**確認沒有亂改字**
- 若 Claude 改了字（常見：把「我們」改「本診所」、加裝飾性形容詞），跟它說「請使用我提供的原文，不要改寫，重做這個頁面」

---

## 各類頁面：body 應包含的章節

下面只列「文案稿建議結構」，**Claude 不要自己編文字**，等客戶填。

### 1. 關於我們（About）
```yaml
body: |
  # 關於 <品牌名>
  ## 我們的故事
  <200-300 字創立故事：年份、地點、為什麼做這件事>
  
  ## 核心價值（3 條）
  ### <價值 1>
  <具體說明，避免抽象名詞堆砌>
  ### <價值 2>
  ### <價值 3>
  
  ## <主理人 / 院長 / 創辦人>介紹
  - 姓名：
  - 學經歷：
  - 認證/執照：
  - 引言：「<一段話>」
  
  ## 立即行動
  <CTA 文字 + 連結到 / 或 /contact>
```

### 2. 服務 / 課程 / 診療項目（Services）
```yaml
body: |
  # <服務頁標題>
  
  ## 服務 1：<名稱>
  - 簡介：<一行>
  - 適合對象：
  - 流程：
  - 時間：
  - 價格：
  
  ## 服務 2：<名稱>
  ⋯
  
  ## 預約方式
  <CTA + 連結 / 電話>
```
若服務超過 6 項，建議改用 content collection（每項 1 個 .md）— 觸發 `astro-client-site` skill 來建 collection。

### 3. 聯絡（Contact）
```yaml
body: |
  # 聯絡我們
  
  <一段話歡迎客戶聯繫，說明回覆時間>
  
  ## 聯絡資訊
  - 電話：
  - email：
  - 地址：（含 Google Maps 連結）
  - 營業時間：
  
  ## 加 LINE
  <LINE QR Code 圖片或 LINE ID>
  
  ## 表單
  <選用：Web3Forms 嵌入 or 引導去 LINE>
```

### 4. FAQ
```yaml
body: |
  # 常見問題
  
  ## Q1：<問題>
  <答案，可多行 markdown>
  
  ## Q2：<問題>
  <答案>
  ⋯
```
記得加 `<script type="application/ld+json">` FAQPage schema 提升 SEO（請 Claude 自動加）。

### 5. 產品 / 商品（Products）
```yaml
body: |
  # 商品列表
  
  ## <商品 1 名稱>
  - 圖片：<URL>
  - 價格：
  - 簡介：
  - 詳細描述：
  - 詢問購買：<連到 /contact 或 LINE>
  
  ⋯
```
超過 8 項建議改 content collection。

### 6. 案例 / 作品集（Cases / Portfolio）
```yaml
body: |
  # 精選案例
  
  ## <案例 1 名稱>
  - 客戶：
  - 年份：
  - 分類：
  - 圖片：（可多張）
  - 描述：
  
  ⋯
```
超過 5 個建議改 content collection。

### 7. 團隊 / 醫師（Team）
```yaml
body: |
  # <團隊 / 醫師 / 設計師>介紹
  
  ## <成員 1 姓名>
  - 職稱：
  - 大頭照：<URL>
  - credentials：
  - bio：
  
  ⋯
```

### 8. 價格 / 方案（Pricing）
```yaml
body: |
  # 服務方案
  
  ## 基礎方案
  - 價格：NT$ X,XXX
  - 包含：
    - 項目 1
    - 項目 2
  - CTA：「<按鈕文字>」
  
  ## 進階方案（推薦）
  ⋯
  
  ## 客製方案
  ⋯
  
  ## FAQ
  <短版，連到 /faq 看完整>
```

### 9. 隱私政策 / 服務條款（Privacy / Terms）
```yaml
body: |
  # 隱私政策
  
  最後更新：YYYY-MM-DD
  
  ## 一、收集資訊
  ## 二、使用方式
  ## 三、第三方分享
  ⋯
```
法規敏感頁面**絕不用方案 A**。客戶請律師或自己寫好。

---

## 必做：title / description 撰寫原則

### title（瀏覽器頁籤標題）
- 8-30 字
- 結構：`<頁面主題> — <品牌名>` 或 `<頁面主題> | <品牌名>`
- BaseLayout 會自動加品牌名 suffix（看 BaseLayout.astro 的 fullTitle 邏輯），所以你只需給「頁面主題」部分，例如 `關於 仁愛牙醫`
- 必含主關鍵字

### description（meta description，搜尋結果預覽）
- 50-160 字（偏好 90 字左右，自然不堆砌）
- 兩段式：**讀者痛點 + 文章/服務的解法**
- 含主關鍵字（從 title 擷取）
- ✗ 禁止以「本文」「本頁」「歡迎來到」「這是」開頭
- ✓ 範例：「想做矯正卻擔心要拔牙？仁愛牙醫 18 年矯正經驗，以數位 3D 掃描精準評估每位患者，多數案例不需拔牙。免費諮詢預約。」

---

## title / description 的位置（提醒給客戶用）

| 頁面 | title / description 來源 | 誰維護 |
|------|------------------------|--------|
| `/`（首頁） | `src/content/pages/home.yaml` 的 `title` 與 `description` | 平台管理員 |
| `/about`、`/services` 等自訂頁 | 該 `.astro` 檔的 `<BaseLayout title="..." description="...">` props | 平台管理員（用 Claude 改 .astro） |
| `/blog/<slug>/`（文章） | 文章 .md frontmatter 的 `title` 與 `description` | 客戶（透過編輯器 UI） |
| `/blog/`（文章列表） | 該 `.astro` 檔 hardcode | 平台管理員 |

---

## 圖片資產管理（**必做**）

加頁面常會用到圖片。**絕對不要在 `home.yaml` / `<img src>` 寫死 `https://images.unsplash.com/...` 這種外站連結**——會拖累 PageSpeed 分數 1-2 秒（DNS 解析 + TLS 握手 + 不可控）。

### 規則

1. **所有圖片放在客戶 `public/images/` 目錄**，URL 用 `/images/<filename>`
2. **格式優先用 WebP**（檔案小 25-35%，所有現代瀏覽器都支援）
3. **大小依用途**：
   - hero / 全 viewport 背景：1200px 寬
   - 大卡片 / featured：900px 寬
   - 小卡片 / thumbnail：600px 寬
   - 文章內圖：800-1200px
4. **加優先級提示**：
   - 首屏 hero 圖：`<img fetchpriority="high" loading="eager" ...>`
   - 其他全部：`<img loading="lazy" ...>`
5. **加寬高屬性或 `aspect-ratio` CSS** 避免 CLS（layout shift）

### 圖片來源策略

| 來源 | 適用場景 | 商用合法性 | 備註 |
|------|---------|---------|------|
| 客戶提供（自己拍 / 找專業攝影） | 實際客戶網站 | ✅ 100% 安全 | 首選 |
| Unsplash（unsplash.com） | demo 網站、低風險素材（風景、食物、建築） | ⚠️ 大致 OK；含人臉 / 商標 / 地標的有風險 | License 允許商用、不需署名，但**不保證** model release |
| Pexels、Adobe Stock | 同 Unsplash，Adobe Stock 有 model release 保障 | ✅/⚠️ | Adobe Stock 付費，但安全 |
| AI 生成（DALL-E / Midjourney / Stable Diffusion） | 真人客戶不想用真實照片時 | ✅ 通常無侵權，**自有版權**| 適合 hero 背景、概念圖；人臉細節仍有 artifact |
| Pixabay | 同 Unsplash | ⚠️ 同上 | License 類似 |

### Unsplash 本地化腳本

如果模板 / 客戶已經用了 Unsplash hotlink（例如所有 jhost demo），跑這個腳本一次性轉本地：

```bash
# 在 VPS
node /var/www/api-server/scripts/localize-unsplash.mjs <client-id>
```

腳本會：
1. 掃 `home.yaml` 與 `posts/*.md` 找所有 `https://images.unsplash.com/...` URL
2. 依 yaml 欄位 context 推估該下載多大（hero=1200, cover=900, img=600）
3. 用 Unsplash 的 `&fm=webp` 直接拿 WebP
4. 存到 `public/images/u-<photo-id>-<width>.webp`
5. 改 yaml / md 內 URL 為 `/images/...`

### 處理客戶上傳的圖

客戶在編輯器上傳的圖片由 `src/lib/provisioning.ts` 用 sharp 處理：
- favicon → 自動縮 32×32 PNG
- logo → 限寬 800px，保留 SVG / 轉 PNG/WebP

文章內圖也經過編輯器後端的 `/api/<id>/upload` 處理，存到 `public/images/`，前端直接用 `/images/<filename>`。

---

## 部署流程

加完頁面、本機 dev 確認 OK 後：

```bash
# 1. Build 本機驗證
npm run build

# 2. 推 GitHub
git add -A
git commit -m "feat: add about page"
git push

# 3. CF Pages 自動 deploy（30-60 秒）

# 4. 同步回 VPS（讓編輯器看到原始檔）
ssh jhost "cd /var/www/clients/<id>/astro && git pull"
# 若沒設 git remote：scp 改動的檔案
```

**注意**：客戶在編輯器寫文章時，編輯器讀的是 VPS 上的原始檔。Step 4 不做的話，admin 後台「編輯客戶」看不到 nav 的變動。

---

## 響應式 / SEO / a11y 檢查清單（每頁加完都過一次）

- [ ] 手機 (375px) 不破版、不水平捲動
- [ ] 平板 (768px) grid 正確切換到 1-2 欄
- [ ] 桌機 (1280px) 跟首頁風格一致
- [ ] `<title>` 與 `<meta description>` 出現在 `<head>`（DevTools 確認）
- [ ] H1 唯一，H2/H3 不跳級
- [ ] 所有 `<img>` 有 `alt`（裝飾用 `alt=""`）
- [ ] 圖片有 `loading="lazy"`（首屏 hero 例外，用 `fetchpriority="high"`）
- [ ] 內部連結都通（點開能跳到正確位置）
- [ ] CTA 按鈕對比 ≥ 4.5:1
- [ ] 加完後 `npm run build` 不能報錯（schema validation 等）

---

## 常見錯誤與處置

| 症狀 | 原因 | 修法 |
|------|------|------|
| Claude 改了客戶的字 | 沒下「一字不改」硬指令 | 重跑：「請使用我提供的原文，禁止改寫」 |
| 跟首頁風格不一致 | 沒讓 Claude 先讀 index.astro | prompt 第一行務必寫「請先讀 BaseLayout 與 index.astro」 |
| build 失敗 zod schema error | site.yaml 多了不認識的欄位 | 看 `src/content/config.ts`，schema 用 `.passthrough()` 允許額外欄位 |
| 線上沒看到變動 | 沒 push 或 CF 還在 build | git push 後等 30-60 秒 |
| 編輯器看到的客戶資訊跟網站不一致 | VPS 沒 sync | 跑 `ssh jhost "cd /var/www/clients/<id>/astro && git pull"` |
| nav 漢堡選單行為異常 | 模板共通問題 | 屬於 `astro-client-site` skill 範疇，不在這 |

---

## 跟其他 skill 的分工

- **astro-client-site**：建立整個客戶專案、修改 BaseLayout / 模板、provisioning、CF Pages 部署設定
- **astro-client-page**（本 skill）：在已存在的客戶專案內**新增單一頁面**
- **modern-web-design**：純視覺探索、設計風格 R&D（不是真實客戶頁面）
- **jclassroom-blog**：寫 WordPress 部落格文章

如果客戶的請求跨範圍（例如「加 about 頁順便改 BaseLayout 加 footer logo」），先做本 skill 的部分，BaseLayout 修改觸發 `astro-client-site`。
