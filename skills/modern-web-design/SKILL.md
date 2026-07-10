---
name: modern-web-design
description: 製作有設計質感的現代網頁——現代、簡潔、有創意與藝術感，排版不死板。任何時候使用者要求製作網站、landing page、個人網站、作品集、SaaS 首頁、商業網站、元件，或是要求「美化」、「改版」、「重做」既有頁面時，立即套用此 skill。輸出必須具備明確美學主張，避免通用 AI 生成風格。本 skill 管美學決策，技術中立：在 jhost 客戶站/模板內用 tokens.css + scoped CSS 實作（見「jhost 情境」節），獨立 HTML 專案才用 Tailwind。
---

# 現代網頁設計 Skill

## 核心原則

每次開始設計前，先做兩件事：

1. **選一個明確的美學方向**（不是「現代、簡潔、乾淨」——這三個詞等於沒選）
2. **拒絕 AI slop 清單**（見下方）

設計網站沒有「中性、安全」的選項。試圖讓所有人都喜歡的設計，沒有人會記住。

---

## jhost 情境：實作層用 tokens.css，不用 Tailwind（**先確認場景**）

本 skill 的**美學決策**（定調、反 slop、排版節奏、動效）適用所有專案；**實作語法看場景**：

| 場景 | 實作方式 |
|------|---------|
| **jhost 客戶站 / 模板**（`clients/<id>/`、`api-server/templates/`） | **tokens.css CSS 變數 + scoped `<style>`**，禁用 Tailwind（規範見 `astro-client-site` skill §六/§九之五） |
| 獨立 HTML / 平台外專案 | 可用 Tailwind（本文件的 Tailwind 段落適用） |

jhost 場景的字級/間距**對映 token**，不寫 utility class 也不寫死數值：

| 本文件的 Tailwind 寫法 | jhost 寫法 |
|---|---|
| `text-6xl` ~ `text-9xl`（hero 大標） | `font-size: var(--text-4xl)`（48→96px fluid）或 `--text-display-*` |
| `text-4xl`（section 標題） | `var(--text-2xl)` |
| `py-32`（section 間距） | `padding: var(--space-2xl) var(--content-pad)` |
| `tracking-tighter` | `letter-spacing: -0.02em`（這類微調直接寫，不是 token 範疇） |
| 色彩 `bg-[#F5F1E8]` | 定義進該模板 `tokens.css` 的 semantic colors（`--color-bg` 等） |

> token 系統是 fluid scale（`clamp()`，靈感來自 **CoreFramework / utopia.fyi**，完整見
> `design-tokens-設計系統.md`）——它管「尺寸階梯」，**不管美學**。字體選擇、破格、
> 不對稱、動效這些美學決策照本 skill 走，只是落地時寫成 token + scoped CSS。

---

## 第一步：定調（必做）

從以下方向明確選一個，並在程式碼註解寫出選擇：

- **Editorial / Magazine**：大標題、襯線字體、留白、報導感排版
- **Brutalist**：單色、粗體、格線外露、刻意的粗糙感
- **Refined Luxury**：窄字距、深色、金屬色點綴、慢動效
- **Retro-futuristic**：80s/90s 數位感、CRT 掃描線、像素字
- **Organic / Natural**：手繪質感、不規則形狀、大地色
- **Swiss / Helvetica-style**：極嚴謹網格、大量留白、無裝飾
- **Maximalist**：大量動效、重疊元素、衝突色彩
- **Newspaper / Print**：多欄排版、drop cap、分隔線
- **Glass / Aurora**：玻璃擬態、大面積漸層光、模糊背景
- **Terminal / Dev**：等寬字、暗色、綠字、指令列美學

選完之後，整個頁面所有決策都要服務這個方向。不要混搭。

---

## 第二步：反 AI Slop 清單（嚴禁）

以下是「一看就是 AI 生成」的特徵，**禁止使用**：

### 字體（絕對禁用）
- ❌ Inter, Roboto, Arial, Helvetica（系統預設感）
- ❌ Space Grotesk（被 AI 用爛了）
- ❌ 全站只有一種字體

**改用**：從 Google Fonts 載入，標題 + 內文各選一個有個性的字體。範例組合：
- `Fraunces` (標題) + `Inter Tight` (內文)
- `Instrument Serif` (標題) + `Geist` (內文)
- `Bricolage Grotesque` (標題) + `DM Sans` (內文)
- `PP Editorial New` / `Cormorant Garamond` (標題) + `JetBrains Mono` (程式感內文)
- `Syne` (標題) + `Work Sans` (內文)

中文字體考慮：`Noto Serif TC`、`jf-openhuninn`、`Taipei Sans TC Beta`——不要用 `Noto Sans TC` 搭新細明體這種預設組合。

### 配色（絕對禁用）
- ❌ 白底紫漸層（`from-purple-500 to-pink-500`）
- ❌ 白底藍漸層（SaaS 通用色）
- ❌ 純 `bg-gray-50` + `bg-white` 的灰階層次
- ❌ 均分五色的柔和色盤

**改用**：一個主色 + 一個銳利點綴色 + 背景。範例：
- 奶油白 `#F5F1E8` + 深墨 `#1A1A1A` + 橙 `#FF4500`
- 深藍黑 `#0A0E27` + 米 `#E8DCC4` + 電光青 `#00F5FF`
- 暖灰 `#E8E4DD` + 深綠 `#1B4332` + 芥末黃 `#E9C46A`

### 版面（絕對禁用）
- ❌ 對稱的三欄 feature cards（所有 AI 網站都這樣）
- ❌ Hero 區塊：左文字 + 右大圖
- ❌ **每個 section 都長一樣**：「置中 eyebrow + 置中大標 + 等寬卡片 grid」從頭重複到尾——這是死板排版的頭號特徵
- ❌ 所有內容都關在同一個等寬 container 裡，從上到下沒有一處變化
- ❌ 所有圖片同尺寸、同圓角、整齊排列（像素材庫縮圖牆）
- ❌ Emoji 當 icon（🎯📊🚀🤝💡🌐）
- ❌ 「500+ 客戶 / 98% 滿意度 / 24/7 支援」式的假數據欄
- ❌ 圓形頭像 + 姓名 + 職稱的見證卡
- ❌ DaisyUI / shadcn 預設樣式未修改

### 內容（絕對禁用）
- ❌ 「王小明 CEO」「陳美玲 創辦人」這類 placeholder 見證
- ❌ 「讓您的業務快速成長」這種通用標語
- ❌ Unsplash / daisyui.com 的 stock 商務照

---

## 第三步：設計必做清單

### 字體
- 從 Google Fonts 載入至少兩個字體
- 標題字體要有個性（襯線、粗重、窄體、或實驗性）
- 內文字體要好讀但不無聊
- 中英混排時為中文單獨設定 font-family

### 配色
- 在 `:root` 或 Tailwind config 定義 CSS 變數
- 主色占 60%、背景 30%、點綴色 10%
- 暗色模式優先考慮（不是每次都要白底）

### 排版
- 標題字級要夠大（桌機 `text-6xl` ~ `text-9xl` 不要怕；jhost 用 `var(--text-4xl)` 級）
- 使用 `tracking-tight` 於大標題、`tracking-wide` 於小標籤
- 至少一個破格元素：超出 container 的圖、對角排版、重疊文字、巨大數字背景

### 排版節奏：不死板的五個手法（每頁至少用三個）

「簡潔」不等於「每個 section 複製同一個版式」。簡潔是**少元素、大字級、留白有膽量**，
節奏靠變化撐起來：

1. **section 版式輪替**——連續兩個 section 不用同一種結構。輪替菜單：
   全寬 hero → 不對稱兩欄（3:7 或 4:8，不是 1:1）→ 窄欄純文字（60ch 置中）→
   full-bleed 圖 / 色塊 → 交錯列表（圖左文右、下一項反轉）→ 大引言（quote 當一個 section）
2. **不對稱網格**：欄寬刻意不等（`grid-template-columns: 5fr 7fr`）、卡片跨列跨欄
   （masonry 感）、元素刻意偏離中軸。對稱只留給刻意要「莊重感」的版型（如 Refined Luxury）
3. **大小對比要狠**：hero 標題 vs 內文至少 5 倍字級差；一張大圖配多張小圖，
   不要全部同尺寸；某個數字 / 單字放大到誇張（背景字、跨兩行的 drop cap）
4. **留白當設計元素**：section 之間敢留 1.5 個螢幕高的空；文字欄寬壓窄（50-65ch）
   讓兩側大量留白；不是每一寸都要塞內容
5. **打破容器一次以上**：讓一張圖 / 一條色帶 / 一段超大文字滿版出血（full-bleed），
   或讓元素壓過 section 邊界重疊到下一區

**自我檢查**：把頁面縮到 25% 看縮圖——如果每個 section 的輪廓長得一樣（同高、同置中、
同網格），就是死板，回去輪替版式。

### 動效（至少實作一項）
- **頁面載入 stagger reveal**：標題字/段落依序淡入（用 `animation-delay`）
- **Scroll-triggered reveal**：用 Intersection Observer 或 CSS `animation-timeline: view()`
- **Hover 微互動**：按鈕底線展開、卡片 3D 傾斜、圖片 scale + 濾鏡
- **游標效果**：自訂 cursor、跟隨光暈、hover 元素放大游標

### 背景 / 氣氛（至少一項）
- 漸層 mesh（用 `radial-gradient` 疊多層）
- 噪點疊加（SVG filter 或 noise texture）
- 幾何裝飾（SVG 線條、網格、圓點）
- 動態漸層背景（CSS `@keyframes` 動畫背景）
- 玻璃模糊層（`backdrop-blur`）

---

## Tailwind CSS 具體實作指引（**僅獨立 HTML 專案**；jhost 客戶站/模板改用開頭的 token 對映表）

### 字體載入
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,300..900&family=Inter+Tight:wght@400..700&display=swap" rel="stylesheet">
```

在 `tailwind.config.js`（v3）或 `@theme`（v4）定義：
```css
@theme {
  --font-display: "Fraunces", serif;
  --font-body: "Inter Tight", sans-serif;
  --color-ink: #1a1a1a;
  --color-cream: #f5f1e8;
  --color-accent: #ff4500;
}
```

### 常用組合片段

**有質感的 Hero 標題**：
```html
<h1 class="font-display text-7xl md:text-9xl font-light tracking-tighter leading-[0.9]">
  主標文字
  <span class="italic font-normal">斜體強調</span>
</h1>
```

**破格的統計數字**（取代對稱四欄）：
```html
<div class="relative py-32">
  <span class="absolute -top-10 left-0 font-display text-[20rem] leading-none text-ink/5">
    500
  </span>
  <div class="relative">
    <p class="font-body text-xl">服務超過 500 位客戶</p>
  </div>
</div>
```

**Stagger reveal on load**：
```css
@keyframes rise {
  from { opacity: 0; transform: translateY(2rem); }
  to { opacity: 1; transform: translateY(0); }
}
.rise { animation: rise 0.8s cubic-bezier(0.22, 1, 0.36, 1) both; }
.rise-1 { animation-delay: 0.1s; }
.rise-2 { animation-delay: 0.25s; }
.rise-3 { animation-delay: 0.4s; }
```

### 避免的 Tailwind 反模式
- 不要全站都用 `rounded-lg`——rounded 要嘛全部銳角（`rounded-none`），要嘛用極端圓角（`rounded-full` / `rounded-[3rem]`）
- 不要用 `shadow-md`——陰影要嘛不用，要嘛做戲劇性陰影（`shadow-[0_30px_60px_-15px_rgba(0,0,0,0.3)]`）
- 不要無腦 `gap-4` + `p-6`——間距要有節奏感，section 之間用 `py-32`、內部用 `py-16`

---

## RWD 響應式排版規則（必做，不得省略）

### 核心禁令：inline style 不能控制 RWD

**媒體查詢無法覆蓋 inline style。** 以下寫法在手機版永遠是兩欄，無法修正：

```html
<!-- ❌ 錯誤：grid 屬性在 inline style 裡，media query 覆蓋不到 -->
<div style="display:grid; grid-template-columns:1fr 1fr; gap:2rem;">
```

**正確做法：grid 屬性一律放 CSS class，gap/background/padding 可留 inline：**

```html
<!-- ✅ 正確：class 控制 grid，inline 只留不需要 RWD 的屬性 -->
<style>
  .g2 { display: grid; grid-template-columns: 1fr 1fr; }
  .g3 { display: grid; grid-template-columns: repeat(3, 1fr); }
  .g4 { display: grid; grid-template-columns: repeat(4, 1fr); }
  @media (max-width: 768px) {
    .g2, .g3 { grid-template-columns: 1fr; }
    .g4 { grid-template-columns: repeat(2, 1fr); }  /* 4欄→2欄，比1欄更適合 */
  }
</style>
<div class="g2" style="gap:2rem;">
```

### 標準 grid class 命名

每個獨立 HTML 頁面（demo 頁等）都必須在 `<style>` 裡定義這組 class，用到哪個就定義哪個：

```css
.g2     { display: grid; grid-template-columns: 1fr 1fr; }
.g3     { display: grid; grid-template-columns: repeat(3, 1fr); }
.g4     { display: grid; grid-template-columns: repeat(4, 1fr); }
.g-hero { display: grid; grid-template-columns: 1fr 1fr; min-height: 88vh; }

@media (max-width: 768px) {
  .nav-links { display: none; }             /* 導覽列隱藏 */
  .section { padding: 4rem 1.5rem; }        /* section 間距縮小 */
  .g2, .g3 { grid-template-columns: 1fr; } /* 兩欄、三欄 → 單欄 */
  .g4 { grid-template-columns: repeat(2, 1fr); } /* 四欄 → 雙欄 */
  .g-hero { grid-template-columns: 1fr; min-height: auto; }
}
```

### 其他容易出錯的 RWD 地雷

**1. `grid-row: span N` 不能放 inline style**

`grid-row:span 2` 在 inline style 裡，手機版單欄時會產生空白列：

```html
<!-- ❌ 手機版會留下空白列 -->
<div style="grid-row: span 2;">

<!-- ✅ 加 class，media query 裡強制 span 1 -->
<div class="proj-span" style="/* 其他屬性 */">
/* CSS: @media (max-width:768px) { .proj-span { grid-row: span 1; } } */
```

**2. `position:absolute` 負值偏移會溢出螢幕**

浮動裝飾元素用負值定位（`left:-2rem`、`right:-2rem`），手機版容器縮至全寬後會溢出邊緣造成橫向捲動：

```html
<!-- ❌ 手機版會溢出螢幕邊緣 -->
<div style="position:absolute; left:-2rem; right:-2rem;">

<!-- ✅ 加 class，手機版隱藏 -->
<div class="deco-badge" style="position:absolute; left:-2rem;">
/* CSS: @media (max-width:768px) { .deco-badge { display: none; } } */
```

**3. Flex 容器要加 `flex-wrap: wrap`**

水平排列的 flex 如果沒有 wrap，手機版會擠爆：

```html
<!-- ✅ 按鈕組、標籤組、頁尾等水平排列都要加 flex-wrap:wrap -->
<div style="display:flex; gap:1rem; flex-wrap:wrap;">
```

---

## 輸出前自我檢查

生成 HTML 後，問自己：

**美學面（5 題）**
1. 這個頁面如果去掉文字內容，光看版面能不能認出這是什麼產業/調性？（能 = 有美學主張）
2. 有沒有一個「記憶點」——讓人截圖分享的瞬間？
3. 關掉這個網站後 5 秒，使用者會記得什麼具體視覺元素？
4. 這個設計跟 v0.dev / bolt.new 預設輸出有什麼不同？
5. 縮到 25% 看縮圖：每個 section 的輪廓是否長得不一樣？（一樣 = 死板，回去輪替版式）

**RWD 面（3 題，每次必查）**
5. 全頁搜尋 `grid-template-columns`——有沒有出現在 inline style 裡？有的話立刻移出來。
6. 有沒有用了 `grid-row:span` 或 `position:absolute` 負值？有的話加 class 並寫 media query。
7. 所有用到的 `.g2/.g3/.g4/.g-hero` class 有沒有都在 `<style>` 裡定義，且有對應的 `@media (max-width:768px)` 規則？

如果任何一題答不出來，修完再交。

---

## 與使用者溝通

在開始 coding 前，如果使用者沒指定美學方向，**主動提案兩到三個方向**讓使用者選，例如：

> 我看你要做個人作品集，有幾個方向可以選：
> A) Editorial 雜誌風：大襯線標題 + 大量留白 + 黑白為主
> B) Terminal 開發者風：等寬字 + 深色底 + 綠字點綴
> C) Brutalist 粗野風：無裝飾粗體字 + 格線外露 + 單色
> 你偏好哪個？或有其他想法？

不要問「你喜歡什麼顏色」這種太低階的問題。定調是美學層次的決策。
