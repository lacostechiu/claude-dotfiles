---
name: astro-client-site
description: 為 SaaS 架站平台建立客戶 Astro 專案。觸發時機：開新客戶、建立 Section 元件、設定 Content Collections、設定 SEO、設定 Cloudflare Pages 部署、撰寫 BlockRenderer、處理 template YAML、執行 provisioning。不適用於純視覺設計（改用 modern-web-design）。
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
│   │   ├── config.ts            ← Content Collections schema 定義
│   │   ├── posts/               ← 客戶文章（MD 檔）
│   │   │   └── my-article.md
│   │   └── pages/               ← 頁面結構（YAML 檔）
│   │       └── home.yaml
│   │
│   ├── layouts/
│   │   └── BaseLayout.astro     ← SEO、字體、全域樣式
│   │
│   ├── components/
│   │   ├── BlockRenderer.astro  ← YAML → Section 元件轉換器
│   │   └── sections/
│   │       ├── HeroSection.astro
│   │       ├── ServicesSection.astro
│   │       ├── TeamSection.astro
│   │       ├── TestimonialsSection.astro
│   │       └── CtaSection.astro
│   │
│   └── pages/
│       ├── index.astro          ← 首頁（讀 home.yaml）
│       └── blog/
│           ├── index.astro      ← 文章列表
│           └── [slug].astro     ← 文章頁
│
├── public/
│   ├── images/                  ← 客戶上傳的圖片（WebP）
│   ├── robots.txt
│   └── favicon.svg
│
└── astro.config.mjs
```

---

## 三、Content Collections Schema

```typescript
// src/content/config.ts
import { defineCollection, z } from 'astro:content'

const posts = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    publishedAt: z.coerce.date(),
    draft: z.boolean().default(false),
    ogImage: z.string().optional(),
  }),
})

const pages = defineCollection({
  type: 'data',   // YAML，不是 MD
  schema: z.object({
    sections: z.array(z.object({
      type: z.string(),
      style: z.string().optional(),
      layout: z.string().optional(),
      title: z.string().optional(),
      subtitle: z.string().optional(),
      image: z.string().optional(),
      text: z.string().optional(),
      items: z.array(z.any()).optional(),
    })),
  }),
})

export const collections = { posts, pages }
```

---

## 四、Template YAML 格式

每套版型對應一個 YAML，定義頁面由哪些 section 組成：

```yaml
# src/content/pages/home.yaml
sections:
  - type: hero
    style: split          # centered | split | fullscreen
    title: "專業醫療，值得信賴"
    subtitle: "台北市信義區，提供全方位家庭醫療服務"
    image: /images/hero.webp

  - type: services
    layout: grid-3        # grid-2 | grid-3 | list
    title: "我們的服務"
    items:
      - icon: heart
        title: "一般內科"
        desc: "常見疾病診療、慢性病管理"
      - icon: stethoscope
        title: "健康檢查"
        desc: "定期健檢、報告說明"

  - type: testimonials
    style: grid           # carousel | grid | single

  - type: cta
    style: full-width     # full-width | card | banner
    text: "立即線上預約"
    link: "https://booking.example.com"
```

**版型 ID 與對應行業（初期 5 套）：**

| 版型 ID | 行業 | 核心 Section |
|---------|------|-------------|
| `clinic` | 診所 / 醫療 | Hero、服務、醫師、評價、預約 CTA |
| `restaurant` | 餐廳 / 飲食 | Hero、菜單、環境、評價、訂位 CTA |
| `consultant` | 顧問 / 律所 | Hero、服務、團隊、案例、聯絡 CTA |
| `beauty` | 美容 / 髮廊 | Hero、服務列表、作品集、評價、預約 CTA |
| `retail` | 零售 / 品牌 | Hero、精選商品、品牌故事、評價、購買 CTA |

---

## 五、BlockRenderer 元件

YAML 的 `sections` 陣列透過 BlockRenderer 轉換成實際元件：

```astro
---
// src/components/BlockRenderer.astro
import type { CollectionEntry } from 'astro:content'

import HeroSection from './sections/HeroSection.astro'
import ServicesSection from './sections/ServicesSection.astro'
import TeamSection from './sections/TeamSection.astro'
import TestimonialsSection from './sections/TestimonialsSection.astro'
import CtaSection from './sections/CtaSection.astro'

interface Props {
  sections: CollectionEntry<'pages'>['data']['sections']
}
const { sections } = Astro.props
---

{sections.map(section => {
  switch (section.type) {
    case 'hero':         return <HeroSection {...section} />
    case 'services':     return <ServicesSection {...section} />
    case 'team':         return <TeamSection {...section} />
    case 'testimonials': return <TestimonialsSection {...section} />
    case 'cta':          return <CtaSection {...section} />
    default:             return null
  }
})}
```

---

## 六、Section 元件寫法規範

每個 Section 元件必須遵守以下格式：

```astro
---
// src/components/sections/HeroSection.astro

interface Props {
  title: string
  subtitle?: string
  image?: string
  style?: 'centered' | 'split' | 'fullscreen'
}

const { title, subtitle, image, style = 'centered' } = Astro.props
---

<section class="py-20 bg-white">
  <div class="max-w-6xl mx-auto px-4 md:px-8">
    <!-- style='centered' -->
    {style === 'centered' && (
      <div class="text-center max-w-3xl mx-auto">
        <h1 class="text-4xl md:text-6xl font-bold tracking-tight">{title}</h1>
        {subtitle && <p class="mt-6 text-lg text-gray-600">{subtitle}</p>}
      </div>
    )}

    <!-- style='split' -->
    {style === 'split' && (
      <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
        <div>
          <h1 class="text-4xl md:text-5xl font-bold tracking-tight">{title}</h1>
          {subtitle && <p class="mt-6 text-lg text-gray-600">{subtitle}</p>}
        </div>
        {image && <img src={image} alt={title} class="w-full rounded-xl object-cover" />}
      </div>
    )}
  </div>
</section>
```

**Section 元件規則：**
- TypeScript Props interface 必寫，所有 props 明確標型別
- 可選 props 用 `?`，並在解構時給預設值
- RWD 一律用 Tailwind responsive prefix（`md:`, `lg:`），**不寫 CSS `@media`**
- 不用 inline style 控制 grid（`md:grid-cols-2` 取代 `style="grid-template-columns:..."`)
- 共用 section（Hero、Testimonials、CTA）各版型共用同一元件，用 props 控制 style 差異

---

## 七、首頁讀取 YAML 的寫法

```astro
---
// src/pages/index.astro
import { getEntry } from 'astro:content'
import BaseLayout from '../layouts/BaseLayout.astro'
import BlockRenderer from '../components/BlockRenderer.astro'

const page = await getEntry('pages', 'home')
---

<BaseLayout title="診所名稱" description="診所 meta description">
  <BlockRenderer sections={page.data.sections} />
</BaseLayout>
```

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

## 十、astro.config.mjs 標準設定

```js
// astro.config.mjs
import { defineConfig } from 'astro/config'
import tailwind from '@astrojs/tailwind'
import sitemap from '@astrojs/sitemap'

export default defineConfig({
  site: 'https://client-a.com',   // ← 每個客戶填入自己的網域
  output: 'static',
  integrations: [
    tailwind(),
    sitemap(),                    // build 時自動產出 /sitemap-index.xml
  ],
})
```

安裝指令（開新客戶時執行一次）：
```bash
npm create astro@latest .
npx astro add tailwind
npx astro add sitemap
```

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

客戶按「發布」時，API 執行：

```typescript
// routes/publish.ts
import simpleGit from 'simple-git'
import { exec } from 'child_process'
import { promisify } from 'util'
const execAsync = promisify(exec)

app.post('/api/:clientId/publish', async (c) => {
  const clientId = c.req.param('clientId')
  const clientPath = `/var/www/clients/${clientId}/astro`
  const git = simpleGit(clientPath)

  // 1. 將 draft:false 存入 MD 檔（由 articles.ts 處理）
  // 2. Git commit
  await git.add('.')
  await git.commit(`publish: ${new Date().toISOString()}`)

  // 3. Astro build
  await execAsync('npm run build', { cwd: clientPath })

  // 4. Wrangler deploy
  const { CF_PROJECT_NAME } = loadClientEnv(clientId)
  await execAsync(`wrangler pages deploy dist --project-name=${CF_PROJECT_NAME}`, {
    cwd: clientPath
  })

  return c.json({ ok: true })
})
```

---

## 十四、開通新客戶 SOP

### Cloudflare Pages 部署（必用 Pages，不是 Workers）

1. Dashboard → Workers 和 Pages → **建立應用程式**
2. 點畫面最下方 **「想要部署 Pages？開始使用」**（不要選 Workers）
3. Connect to Git → 選客戶 repo
4. Build command: `npm run build` / Output directory: `dist`
5. 完成後：Custom domains → Add → 輸入客戶網域
6. Cloudflare 顯示 CNAME 目標（`xxx.pages.dev`）→ 請客戶在原 DNS 加 CNAME 記錄

> ⚠️ CNAME 目標必須是 `*.pages.dev`，不是 `*.workers.dev`

### Provisioning Script 執行順序

```bash
./new-client.sh client-a client-a.com owner@client-a.com

# script 內容：
# 1. 建立 /var/www/clients/client-a/ 目錄
# 2. 複製 Astro 模板，填入客戶資訊
# 3. 寫入 .env（CLIENT_EMAIL / DOMAIN / CF_PROJECT_NAME）
# 4. 修改 astro.config.mjs 的 site 為客戶網域
# 5. npm install
# 6. 首次 astro build + wrangler deploy 確認上線
```

### 新客戶 .env 內容

```bash
# /var/www/clients/client-a/.env
CLIENT_EMAIL=owner@client-a.com
DOMAIN=client-a.com
CF_PROJECT_NAME=client-a
```

---

## 十五、常見錯誤與檢查清單

**開新客戶時必查：**
- [ ] `astro.config.mjs` 的 `site` 有沒有填客戶正確網域
- [ ] Content Collections `config.ts` 已定義 `posts` 和 `pages` 兩個 collection
- [ ] `home.yaml` 的 section `type` 有對應的元件 import 在 BlockRenderer 裡
- [ ] CNAME 目標指向 `*.pages.dev`，不是 `*.workers.dev`
- [ ] `draft: false` 的文章才會進 build，測試時確認 frontmatter 正確

**Section 元件開發時必查：**
- [ ] Props interface 有定義，可選 props 有 `?` 和預設值
- [ ] RWD 用 `md:grid-cols-2` 等 Tailwind prefix，沒有寫 `style="grid-template-columns:..."`
- [ ] 沒有用 inline style 控制 grid（參考 modern-web-design skill 的 RWD 規則）
