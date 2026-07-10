---
name: astro-client-site
description: 為 SaaS 架站平台建立客戶 Astro 專案。觸發時機：開新客戶、開新模板、改 BaseLayout / 模板共通結構、設定 Content Collections、設定 SEO、設定 Cloudflare Pages 部署、處理 home.yaml schema、執行 provisioning。不適用於純視覺設計（改用 modern-web-design）、不適用於在既有客戶站加單頁（用 astro-client-page）。
---

# Astro 客戶網站建置 Skill

## 平台架構概覽

這個 skill 服務的是一個 SaaS 架站平台：

- **平台團隊**負責建立 Astro 專案、設定版型、開通客戶
- **客戶**只做一件事：在 Editor 裡寫文章 → 發布
- 每個客戶是獨立的 Astro 專案，部署到各自的 Cloudflare Pages
- 客戶網站與 Editor API、VPS 完全分離

```
VPS（Editor API + astro build）
        ↓ wrangler deploy
Cloudflare Pages（靜態托管）
        ↓
client-a.com（客戶自訂網域，CNAME → *.pages.dev）
```

---

## 樣式與視覺：用 token + scoped CSS，不用 Tailwind（**先讀這段**）

- **技術骨架**（Content Collections / BaseLayout / 部署 / provisioning）→ 這份 skill。
- **視覺與美學**（版型、字體個性、配色、破格元素、動效）→ **套用 `modern-web-design` skill**（10 種美學方向 + 反 AI slop 清單）。這份 skill 不教美學決策。
- **樣式怎麼寫**：一律用 `tokens.css` 的 CSS 變數 + 元件 scoped `<style>`，**不用 Tailwind utility class**（沒有 `py-20`、`text-4xl`、`md:grid-cols-2`）。token 系統見 §九之五 與 `design-tokens-設計系統.md`（靈感來自 CoreFramework / utopia.fyi）。
- **不要跟 demo 撞臉**：客戶站若沿用模板預設的 `home.yaml` 區塊組合，會長得跟 demo 很像。要做客戶獨有的首頁，走 **`客戶頁面建置-SOP.md` §六（客製首頁）**——**同一套 token / 設計系統，但區塊結構、敘事順序、hero 樣式重新設計**（像 stronghan 用 clinic 的 token 卻有完全不同的首頁）。

---

## 一、伺服器目錄結構

```
/var/www/
├── api-server/                  ← 共用 API（Hono，單一 process）
│   └── src/
│       ├── index.ts
│       ├── middleware/auth.ts
│       └── routes/
│           ├── articles.ts      ← 讀寫 MD
│           ├── upload.ts        ← 圖片上傳（sharp）
│           └── publish.ts       ← git commit + astro build + wrangler deploy
│
└── clients/
    ├── client-a/
    │   ├── astro/               ← Astro 專案
    │   └── .env                 ← CLIENT_EMAIL, DOMAIN, CF_PROJECT_NAME
    └── client-b/
        ├── astro/
        └── .env
```

---

## 二、Astro 專案目錄結構

每個客戶的 `astro/` 資料夾結構如下：

```
astro/
├── src/
│   ├── content/
│   │   ├── config.ts            ← Content Collections schema 定義（per-template）
│   │   ├── posts/               ← 客戶文章（MD 檔）
│   │   │   └── my-article.md
│   │   ├── pages/
│   │   │   └── home.yaml        ← 首頁內容（per-template 具名欄位，見 §四）
│   │   └── site/
│   │       └── site.yaml        ← 品牌 / nav / 配色 / 商業資訊 / pageSeo / analytics
│   │
│   ├── styles/
│   │   └── tokens.css           ← design tokens（fluid type/space + semantic colors）
│   │
│   ├── layouts/
│   │   └── BaseLayout.astro     ← <head> 全套 + nav/footer + themeColors 注入
│   │
│   └── pages/
│       ├── index.astro          ← 首頁（讀 home.yaml 具名欄位直接 render）
│       ├── 404.astro            ← 必備！見 §九之六
│       └── blog/
│           ├── index.astro      ← 文章列表
│           └── [slug].astro     ← 文章頁
│
├── public/
│   ├── images/                  ← 圖片（WebP）
│   └── favicon.png
│
└── astro.config.mjs             ← robots.txt 動態產生（見 §十）
```

> 注意：**沒有 BlockRenderer、沒有共用 sections/ 目錄**——那是設計期的廢案（見 §五）。
> 每個模板的首頁區塊直接寫在 `index.astro` 裡。

---

## 三、Content Collections Schema

三個 collection：`posts`（文章 MD）、`pages`（頁面結構 YAML）、`site`（全站設定 YAML）。
**以實際 `src/content/config.ts` 為準**，下面是骨架：

```typescript
// src/content/config.ts
import { defineCollection, z } from 'astro:content'

const posts = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string().optional(),
    publishedAt: z.coerce.date().optional(),
    draft: z.boolean().default(true),
    cover: z.string().optional(),
    ogImage: z.string().optional(),
    category: z.union([z.string(), z.array(z.string())]).optional(),
  }),
})

const pages = defineCollection({
  type: 'data',                     // YAML，不是 MD
  schema: z.object({
    title: z.string(),
    description: z.string().optional(),
    sections: z.array(z.object({ type: z.string() }).passthrough()),
  }),
})

// site.yaml：品牌 / 配色 / 商業資訊 / nav，platform 後台會寫入。
const site = defineCollection({
  type: 'data',
  schema: z.object({
    brandName: z.string(),
    tagline: z.string().optional(),
    theme: z.string().optional(),
    themeColors: z.object({}).passthrough().optional(),
    business: z.object({}).passthrough().optional(),
    nav: z.array(z.object({ label: z.string(), href: z.string() })).default([]),
  }).passthrough(),                 // ← 關鍵：見下方
})

export const collections = { posts, pages, site }
```

> `.passthrough()` 很關鍵：admin 後台陸續加的欄位（`analytics`、`pageSeo`、`seoFocus`、`logo`…）
> 不必每次改 schema 就能存讀。漏了它，後台一存新欄位整個 build 就 fail。

---

## 四、home.yaml：per-template 具名欄位（**不是通用 sections 陣列**）

每個模板的首頁內容抽在 `src/content/pages/home.yaml`，但 **schema 是該模板自己定義的具名欄位**
（在該模板的 `src/content/config.ts`），不是通用的 `sections: [{type: ...}]`。
`index.astro` 直接讀具名欄位 render——`p.hero.image`、`p.philosophy.principles` 這樣用。

真實範例（interior 模板，節錄）：

```yaml
# src/content/pages/home.yaml — 欄位名是這個模板獨有的
title: 溯源室內設計
description: 溯源相信，真正好的空間設計是回到生活本身。

hero:
  eyebrow: "Interior Design Studio · Taipei"
  titleLine1: "回到"
  titleItalic: "空間"
  titleLine3: "本質"
  subtitle: "……"
  image: /images/hero.webp
  primaryCta: { label: "查看作品集", href: "#works" }

philosophy:
  eyebrow: DESIGN PHILOSOPHY
  quote: |-
    「空間不是用來填滿的……」
  principles:
    - word: 溯源
      en: Trace Back
      desc: "……"
```

**要點**：
- 換一個模板，`home.yaml` 的欄位就完全不同（clinic 有 `doctors`、restaurant 有 `menu`）——**yaml 分離的是「內容 vs 版面」，不是「版面可組合」**
- 改 home.yaml 欄位時，同步改該模板 `config.ts` 的 pages schema，否則 build fail
- admin 後台不編輯 home.yaml（它是開站時定稿的）；客戶可改的是 site.yaml 的配色 / pageSeo / 商業資訊

**現有版型（10 套，在 `api-server/templates/`）：**

`clinic`、`lawyer`、`beauty`、`consultant`、`restaurant`、`gym`、`marketing`、`interior`、`blogger`、`_default`

> 選 template = 選**視覺風格**（token、字體、components 設計語言），**不選排版結構**。
> 同一模板的不同客戶可以有完全不同的首頁排版（stronghan 用 clinic 的 token 但首頁全重排）。

---

## 五、為什麼沒有 BlockRenderer（歷史決策，別走回頭路）

設計期曾規劃「通用 section 元件 + BlockRenderer + sections 陣列自由組合」，**實作中放棄了**
（詳見 `system-design.md` §13）。理由：

1. 每個版型美學完全不同（Brutalist / Editorial / Refined Luxury…），同一組 section 元件用 props 切樣式，做出來的三個變體像同一個版型——差異化不夠
2. 客戶不會自己組區塊——版型在開通時就決定，之後也不換
3. 維護一組共用 section 反而限制每個版型的設計表達

**現實做法**：每個模板 = 一份完整獨立的 Astro pages 實作，區塊直接寫在 `index.astro`。
跨模板共用的是 `tokens.css` 的**型別系統**（fluid type/space + semantic colors，§九之五），不是元件介面。

⚠️ 如果你在某個舊文件 / 舊對話裡看到 BlockRenderer 的做法，**不要照做**——以本節為準。

---

## 六、區塊 / 元件寫法規範（**用 token，不用 Tailwind**）

首頁區塊通常直接寫在 `index.astro`；單一模板內若某區塊要重用（如卡片），可以抽成**該模板自己的**
`src/components/*.astro`（不跨模板共用）。無論寫在哪，規範相同：
樣式全寫在 scoped `<style>`，尺寸/顏色一律用 `tokens.css` 的 CSS 變數。
範本（注意：**沒有任何 Tailwind utility class**）：

```astro
---
// 模板內的區塊寫法示意（直接寫在 index.astro 或抽成該模板自己的元件都適用）
interface Props {
  title: string
  subtitle?: string
  image?: string
  style?: 'centered' | 'split'
}
const { title, subtitle, image, style = 'centered' } = Astro.props
---

<section class="hero" data-style={style}>
  <div class="hero-inner">
    <div class="hero-text">
      <h1 class="hero-title f-display">{title}</h1>
      {subtitle && <p class="hero-sub">{subtitle}</p>}
    </div>
    {style === 'split' && image && (
      <img class="hero-img" src={image} alt={title} fetchpriority="high" />
    )}
  </div>
</section>

<style>
  .hero { padding: var(--space-2xl) var(--content-pad); background: var(--color-bg); }
  .hero-inner { max-width: 1080px; margin: 0 auto; }
  .hero[data-style="split"] .hero-inner {
    display: grid; grid-template-columns: 1fr 1fr;
    gap: var(--space-l); align-items: center;
  }
  .hero-title { font-size: var(--text-4xl); line-height: 0.95; letter-spacing: -0.02em; color: var(--color-text); }
  .hero-sub   { font-size: var(--text-m); color: var(--color-text-soft); margin-top: var(--space-m); }
  .hero-img   { width: 100%; object-fit: cover; }
  @media (max-width: 768px) {
    .hero[data-style="split"] .hero-inner { grid-template-columns: 1fr; }
  }
</style>
```

**規則：**
- TypeScript Props interface 必寫，可選 props 用 `?` + 解構給預設值。
- **樣式全寫在 scoped `<style>`**——不用 Tailwind utility class（`py-20`、`text-4xl`、`md:grid-cols-2` 一律不寫）。
- 尺寸用 token：字級 `var(--text-*)`、間距 `var(--space-*)`、顏色 `var(--color-*)`——**不寫死 `rem` / `hex`**（理由見 §九之五）。
- 半透明 brand 色用 `color-mix(in srgb, var(--color-primary) 85%, transparent)`，不寫 `rgba()`。
- **RWD 用 `@media` 切 `grid-template-columns`**（如上），不用 Tailwind responsive prefix；多欄版面可沿用 `.g2/.g3/.g4` 慣例（見 `modern-web-design` 的 RWD 規則）。
- 元件**不跨模板共用**（§五 的決策）；模板內部要不要抽元件看複雜度，直接寫在 index.astro 也完全可以。
- **視覺好不好看**（版型膽量、字體個性、破格、動效）→ 套 `modern-web-design`，這裡只規範「怎麼接線」。

---

## 七、首頁讀取 home.yaml 的寫法（具名欄位直接 render）

```astro
---
// src/pages/index.astro
import { getEntry } from 'astro:content'
import BaseLayout from '../layouts/BaseLayout.astro'

const page = await getEntry('pages', 'home')
const p = page.data   // 具名欄位：p.hero、p.philosophy、p.works…（schema 在本模板 config.ts）
---

<BaseLayout title={p.title} description={p.description}>
  <section class="hero">
    <p class="lbl">{p.hero.eyebrow}</p>
    <h1 class="f-display">
      {p.hero.titleLine1}<em>{p.hero.titleItalic}</em>{p.hero.titleLine3}
    </h1>
    <p class="hero-sub">{p.hero.subtitle}</p>
    {p.hero.image && (
      <img src={p.hero.image} alt="" fetchpriority="high" loading="eager" />
    )}
  </section>

  <!-- 其餘區塊照樣直接寫：philosophy / works / cta…，樣式全用 token（§九之五） -->
</BaseLayout>
```

區塊的 HTML / CSS 直接寫在 `index.astro`（scoped `<style>`），視覺參考 `modern-web-design` skill 定調。

---

## 八、文章列表與文章頁

```astro
---
// src/pages/blog/index.astro
import { getCollection } from 'astro:content'
import BaseLayout from '../../layouts/BaseLayout.astro'

// draft:true 的文章在 build 時自動排除
const posts = (await getCollection('posts', ({ data }) => !data.draft))
  .sort((a, b) => b.data.publishedAt.valueOf() - a.data.publishedAt.valueOf())
---

<BaseLayout title="最新文章" description="文章列表">
  <ul>
    {posts.map(post => (
      <li>
        <a href={`/blog/${post.slug}`}>{post.data.title}</a>
        <time>{post.data.publishedAt.toLocaleDateString('zh-TW')}</time>
      </li>
    ))}
  </ul>
</BaseLayout>
```

```astro
---
// src/pages/blog/[slug].astro
import { getCollection } from 'astro:content'
import BaseLayout from '../../layouts/BaseLayout.astro'

export async function getStaticPaths() {
  const posts = await getCollection('posts', ({ data }) => !data.draft)
  return posts.map(post => ({ params: { slug: post.slug }, props: { post } }))
}

const { post } = Astro.props
const { Content } = await post.render()
---

<BaseLayout
  title={post.data.title}
  description={post.data.description}
  ogImage={post.data.ogImage}
>
  <article>
    <h1>{post.data.title}</h1>
    <Content />
  </article>
</BaseLayout>
```

---

## 九、BaseLayout.astro（SEO 全套）

> 第一行必須 `import '../styles/tokens.css'`——design system 從這裡進站。詳見「九之五」。
>
> ⚠️ 下面是**教學骨架**。真實模板的 BaseLayout 比這個多很多：nav / footer、
> `site.yaml` 讀入（brandName / nav / analytics / themeColors）、GA4+GSC 追蹤碼注入、
> themeColors 的 `:root !important` 注入（§九之一）。**改既有模板時以該模板的實際檔案為準**，
> 這份骨架只給「從零理解結構」用。

```astro
---
// src/layouts/BaseLayout.astro
import '../styles/tokens.css'   // ← 必做，見九之五

interface Props {
  title: string
  description: string
  ogImage?: string
}

const { title, description, ogImage } = Astro.props
const siteUrl = import.meta.env.SITE   // 讀自 astro.config.mjs 的 site
const canonicalUrl = new URL(Astro.url.pathname, siteUrl).href
const defaultOgImage = `${siteUrl}/og-default.webp`
---

<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <title>{title}</title>
  <meta name="description" content={description} />
  <link rel="canonical" href={canonicalUrl} />

  <!-- Open Graph（Facebook / LINE 分享）-->
  <meta property="og:title" content={title} />
  <meta property="og:description" content={description} />
  <meta property="og:image" content={ogImage ?? defaultOgImage} />
  <meta property="og:url" content={canonicalUrl} />
  <meta property="og:type" content="website" />

  <!-- JSON-LD -->
  <script type="application/ld+json" set:html={JSON.stringify({
    "@context": "https://schema.org",
    "@type": "WebPage",
    "name": title,
    "description": description,
    "url": canonicalUrl,
  })} />

  <!-- Sitemap -->
  <link rel="sitemap" href="/sitemap-index.xml" />

  <!-- Google Fonts — 必做：用非阻塞 preload（見下方第九之三節） -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    rel="preload"
    as="style"
    href="https://fonts.googleapis.com/css2?family=YourFont&display=swap"
    onload="this.onload=null;this.rel='stylesheet'"
  />
  <noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=YourFont&display=swap" /></noscript>
</head>
<body>
  <slot />
</body>
</html>
```

---

## 九之一、`<head>` 一律由 BaseLayout 提供 — 每一頁都必須包在 `<BaseLayout>` 裡（**鐵則**）

`<head>` 裡的東西**全部集中在 BaseLayout**：GA4 / Google Ads 追蹤碼、GSC 驗證 meta、SEO title/description、canonical、OG、字體 preload、JSON-LD。平台後台「網站追蹤與分析」填的 GA4 / GSC 就是注入到 BaseLayout 的 `<head>`（BaseLayout 讀 `site.yaml` 的 `analytics`，格式驗證後才輸出 `gtag.js` 與 `google-site-verification`）。

因此：

- **每一頁**（首頁、about、contact、產品頁、文章頁…）都必須 `import BaseLayout` 並把內容包進 `<BaseLayout title=... description=...>...</BaseLayout>`。
- **客製首頁 = 客製「BaseLayout 裡面的內容」**，不是另寫一套外殼。版型再怎麼跳脫 demo（例：stronghan 首頁完全重排），也只是換掉塞進 `<slot/>` 的內容，外層仍是 `<BaseLayout>`。
- **絕對不要**在任何頁面自己從頭寫 `<!doctype html><html><head>…`、繞過 BaseLayout。那一頁會同時失去：追蹤碼、SEO meta、OG、字體、nav/footer、配色注入 —— 而且**不會有任何錯誤提示**，極難發現。

> 為什麼這樣設計：追蹤碼、SEO、未來任何 `<head>` 層功能只要改 BaseLayout 一處，全站每頁自動套用，客製內容怎麼變都不受影響。

**驗收新頁面**：檢視原始碼，`<head>` 應有 BaseLayout 提供的 title / OG / 字體；客戶若已設追蹤碼，應看得到 `gtag` 與 `google-site-verification`。

---

## 九之二、手機版 Hamburger Menu（**必做**）

桌機 nav 在 ≤768px 必須收成漢堡選單，否則手機看不到 menu。**新建版型時務必加上**，否則 demo 看起來不專業且 SEO 重要連結觸不到。

### ⚠️ 三個容易踩到的坑

**坑 1：burger 位置跑掉（不在右邊）**

原因：把 `<button class="nav-burger">` 放進 `<div class="nav-brand-wrap">` 之類的 brand 容器裡，導致 burger 被困在 brand 區。

✗ 錯誤結構：
```astro
<nav class="nav">
  <div class="nav-brand-wrap">
    <a class="nav-name">{brand}</a>
    <button class="nav-burger">...</button>   <!-- ❌ 在 wrap 裡面 -->
  </div>
  <ul class="nav-links">...</ul>
</nav>
```

✓ 正確結構（burger 必須是 `<nav>` 的直接子元素，跟 brand-wrap 與 nav-links 平行）：
```astro
<nav class="nav">
  <div class="nav-brand-wrap">
    <a class="nav-name">{brand}</a>
  </div>
  <button class="nav-burger">...</button>      <!-- ✓ 跟 wrap 同層 -->
  <ul class="nav-links">...</ul>
</nav>
```

`.nav` 用 `display: flex; justify-content: space-between` 時，brand 在左、ul 用 fixed 移走後不佔空間，burger 自動靠右。

---

**坑 2：burger icon 看不見（深色背景上的深色 icon）**

預設 `.nav-burger { color: inherit }` 會繼承到 body 的文字色。如果 body 的文字色是深色（黑、深褐、深藍），但 nav 是深色背景（`background: var(--black)` / `var(--ink)` / `var(--navy)` 等），icon 就消失了。

✓ 暗底版型必須**明確覆寫**：
```css
.nav-burger {
  /* ...其他屬性... */
  color: var(--white);   /* 或 --paper / --cream，反正用版型自己的淺色 token */
}
```

寫好後務必檢查：手機版 nav 的 burger 是否清楚可見（建議跟 nav-link 同色）。

---

**坑 3：含 backdrop-filter 的版型必須注意 containing-block 陷阱**

如果 `.nav` 上有以下任一屬性，會建立 fixed 定位的 containing block，導致 `.nav-links { position: fixed }` 被困在 `.nav` 元素內（panel 只展開 nav 高度，看起來像「只露出上面一段」）：
- `transform`（任何非 none 的值）
- `filter`、`backdrop-filter`
- `perspective`
- `contain: paint | layout | strict`
- `will-change: transform | filter | perspective`

**正確做法**：把 `backdrop-filter` 與半透明 `background` 移到 `.nav::before` 偽元素，`.nav` 改用 `isolation: isolate` 隔離 stacking context：

```css
.nav {
  position: sticky; top: 0; z-index: 50;
  isolation: isolate;          /* 確保 ::before 的 z-index:-1 不穿幫 */
  border-bottom: 1px solid var(--ink20);
  padding: 0 3rem; height: 70px;
  display: flex; align-items: center; justify-content: space-between;
}
.nav::before {
  content: '';
  position: absolute;
  inset: 0;
  background: rgba(12,10,6,0.92);   /* 從 .nav 搬過來 */
  backdrop-filter: blur(12px);      /* 從 .nav 搬過來 */
  z-index: -1;
  pointer-events: none;
}
```

### JSX 結構

`<nav>` 內部除了 brand 與 nav-links，還要有 hamburger button：

```astro
<nav class="nav">
  <a href="/" class="nav-brand">{logo ? <img src={logo} alt={brand} /> : brand}</a>
  <button class="nav-burger" type="button" aria-label="選單" aria-expanded="false"
          onclick="document.body.classList.toggle('nav-open');this.setAttribute('aria-expanded',document.body.classList.contains('nav-open'))">
    <span></span><span></span><span></span>
  </button>
  <ul class="nav-links">
    {nav.map((item) => (
      item.label.includes('預約') || item.label.includes('訂位')
        ? <li><a href={item.href} class="nav-cta">{item.label}</a></li>
        : <li><a href={item.href} class="nav-link">{item.label}</a></li>
    ))}
  </ul>
</nav>
```

### CSS（放在桌機 nav 規則後 + `@media (max-width: 768px)` 內）

```css
/* 桌機預設：burger 隱藏 */
.nav-burger { display: none; }

@media (max-width: 768px) {
  .nav { padding: 0 1.5rem; }

  /* burger 顯示 */
  .nav-burger {
    display: flex;
    flex-direction: column;
    gap: 5px;
    background: none;
    border: 0;
    cursor: pointer;
    padding: 0.5rem;
    position: relative;
    z-index: 60;
    color: inherit;
  }
  .nav-burger span {
    display: block;
    width: 24px;
    height: 2px;
    background: currentColor;
    transition: transform 0.2s, opacity 0.2s;
  }

  /* nav-links 變側滑 panel（從右邊滑入） */
  .nav .nav-links {
    position: fixed;
    inset: 0 0 0 auto;
    width: min(82vw, 320px);
    background: #fff;
    color: #111;
    flex-direction: column;
    align-items: stretch;
    gap: 0;
    padding: 5rem 1.5rem 2rem;
    margin: 0;
    transform: translateX(110%);
    transition: transform 0.25s ease;
    z-index: 50;
    box-shadow: -8px 0 32px rgba(0,0,0,0.18);
    overflow-y: auto;
    list-style: none;
    display: flex;
  }
  .nav .nav-links li,
  .nav .nav-links > a {
    list-style: none;
    border-bottom: 1px solid rgba(0,0,0,0.08);
  }
  .nav .nav-links a {
    display: block;
    padding: 1rem 0.25rem;
    font-size: 1rem;
    color: inherit;
  }
  .nav .nav-links .nav-cta {
    background: #111;
    color: #fff !important;
    margin-top: 1rem;
    padding: 1rem !important;
    text-align: center;
    border: 0;
  }

  /* 開啟狀態：panel 滑入 + burger 變 X + 半透明 backdrop */
  body.nav-open .nav .nav-links { transform: translateX(0); }
  body.nav-open .nav-burger span:nth-child(1) { transform: translateY(7px) rotate(45deg); }
  body.nav-open .nav-burger span:nth-child(2) { opacity: 0; }
  body.nav-open .nav-burger span:nth-child(3) { transform: translateY(-7px) rotate(-45deg); }
  body.nav-open::before {
    content: '';
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,0.45);
    z-index: 40;
    pointer-events: auto;
  }
}
```

### 行為腳本（放在 `</body>` 前）

```astro
<script is:inline>
  // 點 backdrop 或選單連結時關閉
  document.addEventListener('click', function (e) {
    const target = e.target;
    if (target.closest('.nav-burger')) return;
    if (!document.body.classList.contains('nav-open')) return;
    if (target.closest('.nav-links a') || !target.closest('.nav-links')) {
      document.body.classList.remove('nav-open');
      const b = document.querySelector('.nav-burger');
      if (b) b.setAttribute('aria-expanded', 'false');
    }
  });
</script>
```

### 驗收清單
- [ ] DevTools 切手機模擬（≤768px），nav-links 隱藏，burger 顯示
- [ ] **burger 在右邊**（不是中間或左邊；若跑位 → 坑 1）
- [ ] **burger icon 清楚可見**（深底版型必須覆寫 `color`；若看不到 → 坑 2）
- [ ] 點 burger，panel 從右邊**全高**滑入（不是只展開到 nav 高度；若被截短 → 坑 3）
- [ ] burger icon 變成 X
- [ ] 點 backdrop（panel 外暗色區）關閉
- [ ] 點 panel 內任一連結會跳轉並關閉 panel
- [ ] 桌機（>768px）整套都不該出現

---

## 九之三、Google Fonts 非阻塞載入（**必做**）

預設用 `<link rel="stylesheet">` 載 Google Fonts CSS 會**阻塞 LCP 達 1.5 秒**（PageSpeed 會明確指出「轉譯封鎖要求」）。原因：browser 必須先下載 fonts.googleapis.com 的 CSS（300+ ms），再下載 fonts.gstatic.com 的 woff2，才會開始 render。

### ✗ 錯誤（預設新手做法）

```astro
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=...&display=swap" />
```

問題：
- 同步阻塞，render 卡住等 fonts CSS
- `display=swap` 只能避免 FOIT（看不見字），不能讓 CSS 不阻塞

### ✓ 正確（preload + onload swap）

```astro
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
  rel="preload"
  as="style"
  href="https://fonts.googleapis.com/css2?family=...&display=swap"
  onload="this.onload=null;this.rel='stylesheet'"
/>
<noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=...&display=swap" /></noscript>
```

運作原理：
1. `rel="preload" as="style"` — browser 高優先抓取 CSS，**但不阻塞 render**
2. `onload="this.rel='stylesheet'"` — CSS 載入完成後，把它改回 stylesheet 套用樣式
3. URL 內 `&display=swap` — 字型還沒下載完時用 fallback（系統字），下載完才換字
4. `<noscript>` fallback — JS 關閉的 user agent 退化為同步載入

### 驗證
- PageSpeed Insights 跑一次該頁
- 「轉譯封鎖要求」section 不應出現 `fonts.googleapis.com`
- LCP 應降低約 1.5 秒

### 進階優化（可選）
如果 LCP 還想再壓：自架字體（下載 woff2 到 `public/fonts/`，用 `@font-face` 載入）。但對小型 SaaS 客戶是過度優化，先做 preload 就夠。

---

## 九之四、圖片優先級提示（**必做**）

每個 `<img>` 都要決定它是 hero（首屏 LCP 元素）還是 below-fold。預設 browser 會把所有 `<img>` 視為「無優先級」，導致：
- Hero 圖被同等對待，LCP 落後
- Below-fold 圖在首屏就開始下載，浪費頻寬與主執行緒

### Hero 圖（首屏看得到的那一張）

```astro
<img
  fetchpriority="high"     {/* 明確告訴 browser：這張優先 */}
  loading="eager"           {/* 不要 lazy，立即下載 */}
  src={p.hero.image}
  alt=""
  width="1200" height="800"  {/* 寫清楚尺寸避免 CLS（若用 aspect-ratio CSS 可省） */}
/>
```

### Below-fold 圖（團隊照、案例、文章 cover、blog 圖）

```astro
<img
  loading="lazy"           {/* 滾到附近才下載 */}
  src={teacher.img}
  alt={teacher.name}
  class="trainer-img"
/>
```

### 重要：每個 index.astro 必須**指定一張且只一張**為 hero

寫腳本批次處理時不要直接「第一張當 hero」——某些版型（如 brutalist 純文字 hero）根本沒有 hero 圖，這時所有 `<img>` 都應該是 `loading="lazy"`。

判斷方法：
- 看 hero 區塊是否有 `<img>` — 有就標 high
- hero 是純文字 / CSS 漸層 / SVG — 沒有 `<img>` 就全部 lazy

### Unsplash 圖片 URL 參數
- `?w=1200`：手機螢幕別超過 1200，桌機別超過 1600
- `&auto=format`：自動 WebP（多數 browser 支援）
- `&fit=crop`：填滿容器
- 客戶上傳的 logo / favicon 由 `src/lib/provisioning.ts` 用 sharp 處理（已有），不必擔心

---

## 九之五、Design Tokens 設計系統（**必做**）

每個客戶站都用一份 fluid type/space scale + semantic colors。**不要手寫 `font-size: 0.85rem` 或 `padding: 6rem 3rem`**——一律用 token。原因：
- 手機字級會自動放大（`var(--text-base)` 在 320px 是 16px、在 1280px 是 18px）
- section 間距會跟著畫面大小縮放，不用寫 `@media` override
- 換配色只改 `--color-primary`，不用 grep 全 codebase

完整文件：`design-tokens-設計系統.md`（在 Astro/ 根目錄）。實作範本：`clients/stronghan/src/styles/tokens.css`。

### 開新客戶站時必做

1. 建 `clients/<id>/src/styles/tokens.css`，複製 stronghan 那份當起點
2. 改三個值（其餘 scale 不動）：
   - `--color-primary`：品牌主色
   - `--color-accent`：連結 / 強調色
   - `--color-accent-tint`：accent 的淡背景
3. BaseLayout.astro 第一行：`import '../styles/tokens.css'`
4. **不要在 BaseLayout 裡再寫 `:root { --navy: ... }`**——tokens.css 已經包了

### Token 索引（最常用）

字級（fluid mobile→desktop）：
- `--text-base` 16→18px：內文、段落
- `--text-s` 14→16px：日期、meta、filter button、micro UI
- `--text-eyebrow` 12→13px：上方 ALL CAPS 小標（`.lbl`）
- `--text-xl` 24→32px：h3、卡片標題
- `--text-2xl` 32→56px：h2、section 標題
- `--text-3xl` 40→72px：h1
- `--text-4xl` 48→96px：hero display

間距：
- `--space-2xl` 64→104px：section 上下 padding（最常用）
- `--space-l` 32→48px：區塊 gap
- `--content-pad` 20→48px：section 左右 padding

顏色（語意名）：
- `--color-primary` / `--color-accent` / `--color-accent-tint`
- `--color-bg` / `--color-surface`
- `--color-text` / `--color-text-soft` / `--color-border`

### 用法範例

```astro
<style>
  .product-title { font-size: var(--text-xl); color: var(--color-text); }
  .product-desc  { font-size: var(--text-base); color: var(--color-text-soft); }
  .product-date  { font-size: var(--text-s); color: var(--color-text-faint); }
  .section       { padding: var(--space-2xl) var(--content-pad); }
</style>
```

### 不要做

- ✗ 不要在某頁裡寫 `--my-special-size: 1.5rem`——要用就用 token，不夠用就在 tokens.css 加新的
- ✗ 不要寫 `clamp(2rem, 4vw, 3.5rem)` 這種臨時 fluid——已經有 `var(--text-2xl)` 了
- ✗ 不要套 dark mode 雙色值（除非客戶明確要求）——B2B 客戶不需要
- ✗ 不要為某頁改 tokens.css 的 scale ratio——要客製單一尺寸就直接寫 px/rem，不要動全站

### 驗收

開瀏覽器 DevTools，切換 375px / 1280px 兩個寬度：
- 內文字級從 16px → 18px（fluid 起作用）
- h1 從 ~40px → ~72px
- section padding 從 ~64px → ~104px
- 沒有任何 `font-size: 0.XXrem` 寫死的數值（全用 token）

---

## 九之六、404 頁面（**必做，漏了會出 SEO 事故**）

**每個模板 / 客戶站都必須有 `src/pages/404.astro`**（包在 BaseLayout 裡，給「找不到頁面 + 回首頁」連結）。

原因：Cloudflare Pages 對靜態站的 fallback 行為是——**沒有 `404.html` 時，任何無效 URL 都回 200 + index.html**。
後果：錯字網址、已刪頁面全部「看起來正常」，Google 會把無限多的無效 URL 當成重複首頁收錄，SEO 災難且極難發現。

Astro 只要有 `src/pages/404.astro`，build 就會產出 `dist/404.html`，CF Pages 自動改回正確的 404 行為。

**驗收**：`curl -I https://<site>/this-page-does-not-exist` 必須回 `404`，不是 `200`。

---

## 十、astro.config.mjs 標準設定 + robots.txt

```js
// astro.config.mjs
import { defineConfig } from 'astro/config'
import sitemap from '@astrojs/sitemap'

const site = process.env.SITE_URL || 'https://example.com'

export default defineConfig({
  site,                          // ← build 時由 VPS 用 SITE_URL 環境變數帶入客戶網域
  integrations: [sitemap()],     // build 時自動產出 /sitemap-index.xml
  build: { format: 'directory' },
})
```

> **不裝 Tailwind**——平台用 `tokens.css`（CSS 變數）+ 元件 scoped `<style>`，不用 utility class。
> 開新模板沿用既有模板的結構與 `tokens.css` 即可，**不要** `astro add tailwind`。

**robots.txt 用動態 endpoint，不用靜態檔**（2026-06 改）：`src/pages/robots.txt.ts` 從 `site` 組出
**絕對網址**的 `Sitemap:` 行（robots.txt 規範要求絕對網址，相對路徑會被 GSC 判錯誤；
靜態 `public/robots.txt` 塞不進每客戶不同的網域）。開新模板從既有模板複製這個檔即可。

---

## 十一、文章 Frontmatter 規範

```markdown
---
title: 膝關節退化怎麼辦？
description: 了解膝關節退化的成因、症狀與治療選擇，骨科醫師詳細說明。（建議 50~160 字）
publishedAt: 2026-04-22
draft: false
ogImage: /images/knee-article.webp   # 可選，未填則用預設 OG 圖
---

文章內容從這裡開始...
```

**欄位說明：**
| 欄位 | 必填 | 說明 |
|------|------|------|
| `title` | ✓ | 文章標題，同時作為 `<title>` |
| `description` | ✓ | Meta description，50~160 字 |
| `publishedAt` | ✓ | 發布日期，`YYYY-MM-DD` 格式 |
| `draft` | ✓ | `true` = 草稿不進 build；`false` = 公開 |
| `ogImage` | 選填 | 分享預覽圖，未填用網站預設圖 |

---

## 十二、圖片上傳處理（API 端，sharp）

客戶上傳圖片後，API 自動最佳化，流程：
```
原始檔（任意格式）→ sharp 處理 → WebP 輸出到 public/images/{uuid}.webp
```

```typescript
// routes/upload.ts
import sharp from 'sharp'
import { randomUUID } from 'crypto'

app.post('/api/:clientId/upload', async (c) => {
  const clientId = c.req.param('clientId')
  const body = await c.req.parseBody()
  const file = body['image'] as File

  if (file.size > 20 * 1024 * 1024) {
    return c.json({ error: '檔案超過 20MB 限制' }, 400)
  }

  const buffer = Buffer.from(await file.arrayBuffer())
  const filename = `${randomUUID()}.webp`
  const outputPath = `/var/www/clients/${clientId}/astro/public/images/${filename}`

  await sharp(buffer)
    .resize({ width: 1600, withoutEnlargement: true })
    .webp({ quality: 80 })
    .toFile(outputPath)

  return c.json({ url: `/images/${filename}` })
})
```

---

## 十三、發布流程（API 端）

客戶按「發布」/ admin 按「儲存並重新部署」→ `routes/publish.ts` 把工作丟進佇列（`enqueuePublish`），由 `lib/publishQueue.ts` 的 `execute()` 依序跑（**以該檔為準**，下面是示意）：

```typescript
// lib/publishQueue.ts（示意，實際以原始碼為準）
const git = simpleGit(client.astroDir)

// 1a. 先 pull origin/main —— 把平台側推到 client repo 的更新（如 BaseLayout hotfix）拉下來。
//     --autostash 讓 admin 表單剛寫入、還沒 commit 的 site.yaml 等被臨時收起、pull 完放回。
await git.fetch('origin', 'main')
await git.pull('origin', 'main', { '--rebase': null, '--autostash': null })

// 1b. commit 工作區變動（剛存的文章 / site.yaml）→ 1c. push 回 GitHub
await git.add('.')
if ((await git.status()).files.length > 0) {
  await git.commit(message, undefined, { '--author': 'jhost <publishing@jhost.tw>' })
  await git.push('origin', 'main')
}

// 2. build（客戶站一律用 pnpm，不是 npm）
await execAsync('pnpm build', { cwd: client.astroDir, env: { ...process.env, SITE_URL } })

// 3. wrangler 直傳 CF Pages（不經 CF git-connected）
await execAsync(
  `wrangler pages deploy dist --project-name=${cfProjectName} --branch=main --commit-dirty=true`,
  { cwd: client.astroDir },
)
```

> 關鍵：**1a 的 pull 讓「本機 push 到 client repo → 按發布」就會自動同步到 VPS**，不必手動 SSH git pull（見 `客戶頁面建置-SOP.md` Step 6）。這是 2026-05-07 後的行為。

---

## 十四、開通新客戶（已自動化——走 admin 後台）

開新客戶**不手動操作 Cloudflare**。流程是 admin 後台「**+ 開新客戶**」表單 → 後端 `src/lib/provisioning.ts` 自動完成。完整逐步看 `admin-manual.md` §二（此處只講架構重點，避免兩邊步驟各自漂移）。

provisioning 自動做：建客戶目錄、複製選定模板、建 GitHub repo（`jhost-<id>`）、透過 CF API 建 Pages 專案、寫 `.env` / `services.yaml`、首次 build + `wrangler pages deploy` 上線。

### 部署模型：VPS build + wrangler 直傳（**不是** CF git-connected）

- 客戶站的 build 與部署都在 **VPS** 跑：`pnpm build` → `wrangler pages deploy dist`（直接上傳產物）。
- **CF Pages 不連 Git、不負責 build**（dashboard 顯示「沒有 Git 連線」是正常的）。所以 push 到 GitHub **不會**觸發部署——部署一律走 publishQueue（pull origin/main → build → wrangler，見 `客戶頁面建置-SOP.md` Step 6）。
- 自訂網域：admin 後台設定 → CF 給 CNAME 目標 `xxx.pages.dev` → 客戶在原 DNS 加 CNAME。
  > ⚠️ CNAME 目標必須是 `*.pages.dev`，不是 `*.workers.dev`。詳見 `dns-guide-for-clients.md`。

### 每客戶 .env（VPS `/var/www/clients/<id>/.env`，provisioning 自動寫，不入 git）

```bash
CLIENT_EMAIL=owner@client-a.com
DOMAIN=client-a.com
CF_PROJECT_NAME=client-a
```

---

## 十五、常見錯誤與檢查清單

**開新客戶 / 新模板時必查：**
- [ ] `astro.config.mjs` 的 `site` 有沒有填客戶正確網域（或由 SITE_URL 帶入）
- [ ] Content Collections `config.ts` 已定義 `posts`、`pages`、`site` 三個 collection（site 要 `.passthrough()`）
- [ ] `home.yaml` 的欄位跟該模板 `config.ts` 的 pages schema 對得上（改一邊要改另一邊）
- [ ] **有 `src/pages/404.astro`**（§九之六——漏了 CF Pages 會把無效 URL 回 200 + 首頁）
- [ ] **有 `src/pages/robots.txt.ts`**（動態產生，Sitemap 絕對網址）
- [ ] CNAME 目標指向 `*.pages.dev`，不是 `*.workers.dev`
- [ ] `draft: false` 的文章才會進 build，測試時確認 frontmatter 正確

**Section / 頁面元件開發時必查：**
- [ ] Props interface 有定義，可選 props 有 `?` 和預設值
- [ ] 樣式寫在 scoped `<style>`，**沒有 Tailwind utility class**（`py-20`/`text-4xl`/`md:grid-cols-2`）
- [ ] 尺寸/顏色用 token（`var(--text-*)`/`var(--space-*)`/`var(--color-*)`），沒有寫死 `rem`/`hex`
- [ ] grid 的 `grid-template-columns` 放在 `<style>`（class）裡 + `@media` 切換，**不在 inline style**（參考 modern-web-design 的 RWD 規則）
