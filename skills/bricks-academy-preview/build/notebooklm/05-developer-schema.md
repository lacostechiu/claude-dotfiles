# Bricks Academy — Developer Schema (Data Model)

> 來源：Bricks Builder Academy 官方文件 | 共 176 篇

---



## Bricks Data Model

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/*

import SchemaDownload from '../../../../components/SchemaDownload.astro'

This page explains how Bricks structures its data. Use it alongside the individual element and control schemas to understand or generate valid Bricks content. Each JSON file describes the exact shape of data Bricks reads and writes, so AI coding assistants, build tools, import/export scripts, and custom integrations can generate, validate, or transform Bricks content without the builder UI.

**Schema version:** 2.3

<SchemaDownload />

## Element structure

Every element in Bricks shares the same envelope, regardless of its type:

```json
{
  "id": "dlceeu",
  "name": "button",
  "parent": 0,
  "children": [],
  "settings": { "text": "I am a button", "style": "primary" },
  "label": "My Button"
}
```

The element envelope has 8 fields (`id`, `name`, `parent`, `children`, `settings`, `selectors`, `label`, `themeStyles`). The `settings` object combines three layers: element-specific controls, inherited CSS controls (the `_`-prefixed keys), and meta-settings (`_cssGlobalClasses`, `_conditions`, `_interactions`, `_attributes`, etc.).

See the [Element schema](./elements/common/element/) for the full envelope reference, settings layers, meta-settings, and selectors documentation.

## Content areas

A Bricks page (or any post type using Bricks) stores its elements across three independent content areas: header, content, and footer. Each content area is a flat array of elements with parent-child references (not a nested tree). An array may contain both regular elements and component instances (identifiable by the presence of a `cid` field).

| Content area | WordPress post meta key | Description |
|---|---|---|
| Header | `_bricks_page_header_2` | Header template elements |
| Content | `_bricks_page_content_2` | Main page/post content |
| Footer | `_bricks_page_footer_2` | Footer template elements |

All three content areas use the exact same data structure: an array of elements as described in the [Element schema](./elements/common/element/).

**Storage:** These are stored as serialized arrays in the `wp_postmeta` table.

| Data | Meta key | PHP constant |
|---|---|---|
| Header elements | `_bricks_page_header_2` | `BRICKS_DB_PAGE_HEADER` |
| Content elements | `_bricks_page_content_2` | `BRICKS_DB_PAGE_CONTENT` |
| Footer elements | `_bricks_page_footer_2` | `BRICKS_DB_PAGE_FOOTER` |

See the [Content Area schema](./general/content-area/) for the array structure and storage details.

### Responsive and state variants

CSS-related settings support breakpoint and pseudo-class suffixes using colon syntax. A setting key with no suffix applies at the base breakpoint (desktop by default):

```
_typography                          → base breakpoint (no suffix)
_typography:tablet_portrait          → tablet portrait breakpoint
_typography:mobile_landscape:hover   → mobile landscape + hover state
```

## Page settings

Per-page configuration controlling header/footer visibility, scroll behavior, SEO metadata, social sharing, and custom code injection. These settings apply to the specific post being edited and are separate from element settings and global data.

```json
{
  "headerDisabled": true,
  "scrollSnapType": "y proximity"
}
```

See the [page settings schema](./settings/page/) for all available controls.

**Storage:** Stored as a serialized array in the `wp_postmeta` table.

| Data | Meta key | PHP constant |
|---|---|---|
| Page settings | `_bricks_page_settings` | `BRICKS_DB_PAGE_SETTINGS` |

## Template settings

Settings specific to Bricks templates (stored as the `bricks_template` custom post type). Includes template conditions that determine where on the site a template is applied (e.g., entire website, specific post types, archives, or individual pages). Header templates also store layout settings such as sticky behavior here.

```json
{
  "templateConditions": [
    { "id": "iwjjdg", "main": "any" }
  ]
}
```

See the [template settings schema](./settings/template/) for all available controls.

**Storage:** Stored as serialized arrays in the `wp_postmeta` table.

| Data | Meta key | PHP constant |
|---|---|---|
| Template settings | `_bricks_template_settings` | `BRICKS_DB_TEMPLATE_SETTINGS` |
| Template type | `_bricks_template_type` | `BRICKS_DB_TEMPLATE_TYPE` |

## Global data structures

Bricks stores several global data structures as WordPress options. These are site-wide and shared across all pages and templates.

**Storage:** All global data is stored as serialized arrays in the `wp_options` table.

| Data | Option name | PHP constant |
|---|---|---|
| Global classes | `bricks_global_classes` | `BRICKS_DB_GLOBAL_CLASSES` |
| Global variables | `bricks_global_variables` | `BRICKS_DB_GLOBAL_VARIABLES` |
| Theme styles | `bricks_theme_styles` | `BRICKS_DB_THEME_STYLES` |
| Color palettes | `bricks_color_palette` | `BRICKS_DB_COLOR_PALETTE` |
| Breakpoints | `bricks_breakpoints` | `BRICKS_DB_BREAKPOINTS` |
| Components | `bricks_components` | `BRICKS_DB_COMPONENTS` |
| Pseudo-classes | `bricks_pseudo_classes` | `BRICKS_DB_PSEUDO_CLASSES` |

### Global classes

Reusable CSS class definitions that can be applied to any element via the `_cssGlobalClasses` setting. Edit a class once and every element using it updates everywhere. The `settings` object on a class follows the same structure as element settings, including support for breakpoint and pseudo-class variants using the colon syntax (e.g., `_typography:tablet_portrait`).

```json
[
  {
    "id": "xkatss",
    "name": "hero-section",
    "settings": {
      "_background": {
        "color": {
          "light": "#81D4FA",
          "raw": "var(--bricks-color-sky-blue)",
          "id": "573827"
        }
      },
      "_padding:mobile_portrait": {
        "top": "40",
        "bottom": "40"
      }
    },
    "modified": 1772645626,
    "user_id": 2
  }
]
```

See the [global classes schema](./global/global-classes/).

### Global variables

CSS custom properties that become available site-wide as `var(--variable-name)`. Used to define design tokens (colors, spacing, font sizes, etc.) that can be referenced from any element setting that accepts a CSS value.

```json
[
  { "id": "jeeawn", "name": "primary-color", "value": "green" },
  { "id": "ab3kxz", "name": "spacing-xl", "value": "80px" }
]
```

See the [global variables schema](./global/global-variables/).

### Theme styles

Site-wide default styling applied per element type (e.g., default section padding, heading typography, button colors). Each theme style requires conditions to determine which pages it applies to. Multiple theme styles can coexist with different conditions; a loading method setting controls whether only the most specific or all matching theme styles are applied on a given page.

```json
{
  "my-theme-style": {
    "label": "My Theme Style",
    "settings": {
      "conditions": {
        "conditions": [
          { "id": "vrniaa", "main": "any" }
        ]
      },
      "section": {
        "padding": { "top": "80", "right": "16", "left": "16", "bottom": "80" },
        "_rowGap": "32"
      },
      "heading": {
        "_typography": { "font-family": "Inter", "font-weight": "700" }
      }
    }
  }
}
```

See the [theme styles schema](./global/theme-styles/).

### Color palettes

Named color collections used across the builder. Multiple palettes can coexist. Each color stores a CSS variable reference (`raw`), the resolved light-mode value (`light`), and an optional dark-mode value (`dark`). The `raw` value is what gets written into settings; `light`/`dark` are the resolved display values.

```json
[
  {
    "id": "58e6a6",
    "name": "Brand Colors",
    "colors": [
      { "id": "920e35", "raw": "var(--bricks-color-red)", "light": "#f44336" },
      { "id": "58c724", "raw": "var(--bricks-color-blue)", "light": "#2196f3" },
      { "id": "3f6995", "raw": "var(--bricks-color-green)", "light": "#4caf50" }
    ]
  }
]
```

See the [color palettes schema](./global/color-palettes/).

### Breakpoints

Responsive breakpoint definitions. The entry marked `"base": true` is the default breakpoint; settings with no breakpoint suffix apply at this breakpoint (e.g., `_typography`). All other breakpoints generate a media query at their `width` value and are referenced via colon suffix on the setting key (e.g., `_typography:tablet_portrait`). Users can add custom breakpoints and modify widths.

```json
[
  { "base": true, "key": "desktop", "label": "Desktop", "width": 1279, "icon": "laptop" },
  { "key": "tablet_portrait", "label": "Tablet portrait", "width": 991, "icon": "tablet-portrait" },
  { "key": "mobile_landscape", "label": "Mobile landscape", "width": 767, "icon": "phone-landscape" },
  { "key": "mobile_portrait", "label": "Mobile portrait", "width": 478, "icon": "phone-portrait" }
]
```

See the [breakpoints schema](./global/breakpoints/).

### Components

Reusable element bundles, analogous to components in Vue or React. A component definition holds a tree of elements (`elements`) and an optional list of `properties` that expose specific controls for per-instance customization (e.g., a different heading text or image on each instance). When added to a page, a component instance is created that references the main component via `cid`.

```json
[
  {
    "id": "fdqkmn",
    "category": "Marketing",
    "desc": "A reusable CTA button with configurable label",
    "elements": [
      {
        "id": "fdqkmn",
        "name": "button",
        "parent": 0,
        "children": [],
        "settings": { "text": "Get started", "style": "dark" },
        "label": "CTA Button"
      }
    ],
    "properties": [
      {
        "id": "pbutxt",
        "label": "Button text",
        "type": "text",
        "connections": { "fdqkmn": ["text"] }
      }
    ],
    "_created": 1772645617,
    "_user_id": 2,
    "_version": "2.2-rc2"
  }
]
```

See the [components schema](./global/components/).

### Pseudo-classes

CSS pseudo-classes available in the builder for state variants (e.g., hover, active, focus). These determine which pseudo-class suffixes can be applied to CSS settings using the colon syntax (e.g., `_typography:mobile_portrait:hover`). The defaults are `:hover`, `:active`, and `:focus`, but users can add custom pseudo-classes via Bricks settings.

```json
[":hover", ":active", ":focus"]
```

See the [pseudo-classes schema](./global/pseudo-classes/).

## Nesting example

Below is a real-world hero section showing how elements nest via the flat array structure. The tree view shows the visual hierarchy, followed by the actual data.

```
section (Hero Section 06)
  └─ container
       ├─ block (Content Wrapper)
       │    ├─ heading (h1)
       │    ├─ text-basic (Tagline)
       │    ├─ text-basic (Lede)
       │    └─ div (Button Group)
       │         ├─ button
       │         └─ button (outline)
       └─ block (Media Wrapper)
            └─ image (eager, figure)
```

```json
[
  {
    "id": "13877b",
    "name": "section",
    "parent": 0,
    "children": ["65f029"],
    "settings": { "_cssGlobalClasses": ["skznjf"] },
    "label": "Hero Section 06"
  },
  {
    "id": "65f029",
    "name": "container",
    "parent": "13877b",
    "children": ["bf5a3e", "19454c"],
    "settings": { "_cssGlobalClasses": ["ubprdn"] }
  },
  {
    "id": "bf5a3e",
    "name": "block",
    "parent": "65f029",
    "children": ["c85e7f", "dfe903", "436fc0", "9b4d18"],
    "settings": { "_cssGlobalClasses": ["ebvzqj"] },
    "label": "Content Wrapper"
  },
  {
    "id": "c85e7f",
    "name": "heading",
    "parent": "bf5a3e",
    "children": [],
    "settings": {
      "text": "This hero headline is a temporary placeholder",
      "_cssGlobalClasses": ["deprgo"],
      "tag": "h1",
      "type": "hero"
    }
  },
  {
    "id": "dfe903",
    "name": "text-basic",
    "parent": "bf5a3e",
    "children": [],
    "settings": {
      "text": "Tagline",
      "tag": "p",
      "_cssGlobalClasses": ["dzwkrp", "xlqxzg"]
    },
    "label": "Tagline"
  },
  {
    "id": "436fc0",
    "name": "text-basic",
    "parent": "bf5a3e",
    "children": [],
    "settings": {
      "text": "While we're still finalizing our content, we've included this placeholder text to occupy the space temporarily.",
      "tag": "p",
      "_cssGlobalClasses": ["vpsyry", "ebhacb"]
    },
    "label": "Lede"
  },
  {
    "id": "9b4d18",
    "name": "div",
    "parent": "bf5a3e",
    "children": ["15596e", "c19a95"],
    "settings": { "_cssGlobalClasses": ["zoyzsf"] },
    "label": "Button Group"
  },
  {
    "id": "15596e",
    "name": "button",
    "parent": "9b4d18",
    "children": [],
    "settings": { "text": "Button" }
  },
  {
    "id": "c19a95",
    "name": "button",
    "parent": "9b4d18",
    "children": [],
    "settings": { "text": "Button Outline", "outline": true }
  },
  {
    "id": "19454c",
    "name": "block",
    "parent": "65f029",
    "children": ["849138"],
    "settings": { "_cssGlobalClasses": ["vxsvbb"] },
    "label": "Media Wrapper"
  },
  {
    "id": "849138",
    "name": "image",
    "parent": "19454c",
    "children": [],
    "settings": {
      "tag": "figure",
      "caption": "none",
      "image": {
        "id": 90346,
        "filename": "image_16-9_portrait.jpg",
        "size": "medium_large",
        "full": "https://example.com/wp-content/uploads/image_16-9_portrait.jpg",
        "url": "https://example.com/wp-content/uploads/image_16-9_portrait-768x1365.jpg"
      },
      "_cssGlobalClasses": ["zqibqu"],
      "loading": "eager"
    },
    "label": "Media",
    "themeStyles": []
  }
]
```

## Schema categories

### [Elements](./elements/accordion/)

Individual element schemas describing the settings, metadata, and value types for each element type. 130 element schemas available.

#### [Common](./elements/common/element/)

Shared element documentation: the [element schema](./elements/common/element/) (envelope, settings layers, meta-settings, selectors), [element conditions](./elements/common/conditions/) (display conditions with 32 condition keys and comparison operators), and [element interactions](./elements/common/interactions/) (event-driven behavior with triggers, actions, and sub-conditions).

### [General](./general/content-area/)

Foundational data structures: the [content area](./general/content-area/) schema (flat array container, storage, and meta keys).

### [Controls](./controls/text/)

Value schemas for each control type (text, select, checkbox, typography, etc.), describing the shape of data each control produces.

### [Global](./global/global-classes/)

Root schemas for global data structures: global classes, theme styles, components, color palettes, breakpoints, pseudo-classes, and global variables.

### [Settings](./settings/page/)

Page and template settings schemas describing the available settings controls.

---


## Align Items Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/align-items/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/align-items.json" />

---


## Audio Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/audio/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/audio.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `id` | string \| integer | — |
| `url` | string | — |
| `autoplay` | boolean | — |
| `loop` | boolean | — |
| `controls` | boolean | — |

---


## Background Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/background/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/background.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `color` | any | Color value in various formats |
| `image` | object | Image settings |
| `video` | object | Video settings |
| `size` | string | — |
| `position` | string | — |
| `repeat` | string | One of: `repeat`, `repeat-x`, `repeat-y`, `no-repeat` |
| `attachment` | string | One of: `scroll`, `fixed`, `local` |

---


## Border Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/border/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/border.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `width` | object | Spacing value with directional properties |
| `style` | string | One of: `none`, `solid`, `dashed`, `dotted`, `double`, `groove`, `ridge`, `inset`, `outset` |
| `color` | any | Color value in various formats |
| `radius` | object | Spacing value with directional properties |

---


## Box Shadow Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/box-shadow/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/box-shadow.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `values` | array | — |

---


## Checkbox Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/checkbox/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/checkbox.json" />

---


## Code Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/code/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/code.json" />

---


## Color Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/color/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/color.json" />

---


## Datepicker Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/datepicker/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/datepicker.json" />

---


## Dimensions Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/dimensions/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/dimensions.json" />

---


## Direction Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/direction/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/direction.json" />

---


## Editor Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/editor/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/editor.json" />

---


## Filters Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/filters/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/filters.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `blur` | string | — |
| `brightness` | string | — |
| `contrast` | string | — |
| `grayscale` | string | — |
| `hue-rotate` | string | — |
| `invert` | string | — |
| `opacity` | string | — |
| `saturate` | string | — |
| `sepia` | string | — |

---


## Icon Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/icon/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/icon.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `library` | string | — |
| `icon` | string | — |
| `svg` | object | — |

---


## Image Gallery Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/image-gallery/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/image-gallery.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `images` | array | — |

---


## Image Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/image/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/image.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `id` | string \| integer | — |
| `filename` | string | — |
| `url` | string | — |
| `size` | string | — |
| `full` | string | — |
| `useDynamicData` | string | — |

---


## Justify Content Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/justify-content/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/justify-content.json" />

---


## Link Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/link/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/link.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `type` | string | — |
| `url` | string | — |
| `postId` | string \| integer | — |
| `newTab` | boolean | — |
| `rel` | string | — |
| `title` | string | — |
| `ariaLabel` | string | — |
| `lightboxId` | string | — |
| `lightboxType` | string | — |

---


## Number Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/number/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/number.json" />

---


## Query List Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/query-list/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/query-list.json" />

---


## Query Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/query/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/query.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `NOTE` | any | — |
| `ajax_loader_animation` | any | — |
| `ajax_loader_color` | any | — |
| `ajax_loader_scale` | any | — |
| `ajax_loader_selector` | any | — |
| `ajax_loader_separator` | any | — |
| `api_auth_api_key_name` | any | — |
| `api_auth_api_key_use_constant` | any | — |
| `api_auth_api_key_use_constant_info` | any | — |
| `api_auth_api_key_value` | any | — |
| `api_auth_api_location` | any | — |
| `api_auth_basic_password` | any | — |
| `api_auth_basic_use_constant` | any | — |
| `api_auth_basic_use_constant_info` | any | — |
| `api_auth_basic_username` | any | — |
| `api_auth_bearer_token` | any | — |
| `api_auth_bearer_use_constant` | any | — |
| `api_auth_bearer_use_constant_info` | any | — |
| `api_auth_sep` | any | — |
| `api_auth_type` | any | — |
| `api_body_json` | any | — |
| `api_body_params` | any | — |
| `api_body_type` | any | — |
| `api_docs` | any | — |
| `api_headers` | any | — |
| `api_method` | any | — |
| `api_name` | any | — |
| `api_params` | any | — |
| `api_params_sep` | any | — |
| `api_sep` | any | — |
| `api_url` | any | — |
| `arrayEditor` | any | — |
| `array_conditions` | any | — |
| `body_separator` | any | — |
| `builderQueryMaxResults` | any | — |
| `cache_time` | any | — |
| `cartCrossSells` | any | — |
| `child_of` | any | — |
| `childless` | any | — |
| `crossSells` | any | — |
| `current_post_author` | any | — |
| `current_post_term` | any | — |
| `disable_query_merge` | any | — |
| `disable_update_post_meta_cache` | any | — |
| `disable_update_post_term_cache` | any | — |
| `disable_url_params` | any | — |
| `exclude_current_post` | any | — |
| `featured` | any | — |
| `headers_separator` | any | — |
| `hideOutOfStock` | any | — |
| `id` | any | — |
| `ignore_sticky_posts` | any | — |
| `infinite_scroll` | any | — |
| `infinite_scroll_delay` | any | — |
| `infinite_scroll_margin` | any | — |
| `infinite_scroll_separator` | any | — |
| `is_archive_main_query` | any | — |
| `is_live_search` | any | — |
| `is_live_search_info` | any | — |
| `is_live_search_separator` | any | — |
| `is_live_search_wrapper_selector` | any | — |
| `items_per_page` | any | — |
| `meta_key` | any | — |
| `meta_query` | any | — |
| `meta_query_relation` | any | — |
| `meta_query_separator` | any | — |
| `no_found_rows` | any | — |
| `no_results_separator` | any | — |
| `no_results_template` | any | — |
| `no_results_text` | any | — |
| `number` | any | — |
| `objectType` | any | — |
| `offset` | any | — |
| `onSale` | any | — |
| `order` | any | — |
| `orderby` | any | — |
| `pagination_enabled` | any | — |
| `pagination_method` | any | — |
| `pagination_page_offset_key` | any | — |
| `pagination_page_offset_key_location` | any | — |
| `pagination_page_param` | any | — |
| `pagination_param_location` | any | — |
| `pagination_separator` | any | — |
| `pagination_total_extract` | any | — |
| `parent` | any | — |
| `performanceInfo` | any | — |
| `performanceSeparator` | any | — |
| `post__in` | any | — |
| `post__not_in` | any | — |
| `post_mime_type` | any | — |
| `post_parent` | any | — |
| `post_type` | any | — |
| `posts_per_page` | any | — |
| `queryEditor` | any | — |
| `query_api_button` | any | — |
| `query_api_error` | any | — |
| `query_api_table` | any | — |
| `query_filters_separator` | any | — |
| `randomSeedTtl` | any | — |
| `relatedProducts` | any | — |
| `response_path` | any | — |
| `response_separator` | any | — |
| `role__in` | any | — |
| `show_empty` | any | — |
| `tax_query` | any | — |
| `tax_query_advanced` | any | — |
| `tax_query_not` | any | — |
| `tax_query_relation` | any | — |
| `tax_query_separator` | any | — |
| `taxonomy` | any | — |
| `upSells` | any | — |
| `useQueryEditor` | any | — |
| `wooControlsSeparator` | any | — |

---


## Repeater Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/repeater/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/repeater.json" />

---


## Select Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/select/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/select.json" />

---


## Spacing Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/spacing/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/spacing.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `top` | string | Top spacing value with unit |
| `right` | string | Right spacing value with unit |
| `bottom` | string | Bottom spacing value with unit |
| `left` | string | Left spacing value with unit |

---


## Svg Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/svg/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/svg.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `id` | string \| integer | — |
| `url` | string | — |
| `library` | string | — |

---


## Text Align Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/text-align/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/text-align.json" />

---


## Text Shadow Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/text-shadow/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/text-shadow.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `values` | array | — |

---


## Text Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/text/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/text.json" />

---


## Textarea Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/textarea/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/textarea.json" />

---


## Transform Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/transform/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/transform.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `translateX` | string | — |
| `translateY` | string | — |
| `translateZ` | string | — |
| `scaleX` | string | — |
| `scaleY` | string | — |
| `scaleZ` | string | — |
| `rotateX` | string | — |
| `rotateY` | string | — |
| `rotateZ` | string | — |
| `skewX` | string | — |
| `skewY` | string | — |
| `perspective` | string | — |

---


## Typography Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/typography/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/typography.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `font-family` | string | — |
| `font-size` | string | — |
| `font-weight` | string \| integer | — |
| `font-style` | string | One of: `normal`, `italic`, `oblique` |
| `line-height` | string | — |
| `letter-spacing` | string | — |
| `text-align` | string | One of: `left`, `center`, `right`, `justify` |
| `text-transform` | string | One of: `none`, `uppercase`, `lowercase`, `capitalize` |
| `text-decoration` | string | — |
| `color` | any | Color value in various formats |

---


## Video Control Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/controls/video/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="controls/video.json" />

## Properties

| Property | Type | Description |
|---|---|---|
| `source` | string | One of: `media`, `youtube`, `vimeo`, `url` |
| `id` | string \| integer | — |
| `url` | string | — |
| `youtubeId` | string | — |
| `vimeoId` | string | — |
| `autoplay` | boolean | — |
| `loop` | boolean | — |
| `muted` | boolean | — |
| `controls` | boolean | — |

---


## Accordion (Nestable) Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/accordion-nested/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | accordion-nested |
| `category` | general |
| `tag` | div |
| `nestable` | true |

<SchemaJson path="elements/accordion-nested.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `expandItem` | text | Expand item indexes | — |
| `independentToggle` | checkbox | Independent toggle | — |
| `transition` | number | Transition | — |
| `faqSchema` | checkbox | FAQ schema | — |
| `titleHeight` | number | Min. height | `min-height` on `.accordion-title-wrapper` |
| `titleMargin` | spacing | Margin | `margin` on `.accordion-title-wrapper` |
| `titlePadding` | spacing | Padding | `padding` on `.accordion-title-wrapper` |
| `titleBackgroundColor` | color | Background color | `background-color` on `.accordion-title-wrapper` |
| `titleBorder` | border | Border | `border` on `.accordion-title-wrapper` |
| `titleTypography` | typography | Typography | `font` on `.accordion-title-wrapper`, `font` on `.accordion-title-wrapper .brxe-heading` |
| `titleActiveBackgroundColor` | color | Background color | `background-color` on `.brx-open .accordion-title-wrapper` |
| `titleActiveBorder` | border | Border | `border` on `.brx-open .accordion-title-wrapper` |
| `titleActiveTypography` | typography | Typography | `font` on `.brx-open .accordion-title-wrapper`, `font` on `.brx-open .accordion-title-wrapper .brxe-heading` |
| `contentMargin` | spacing | Margin | `margin` on `.accordion-content-wrapper` |
| `contentPadding` | spacing | Padding | `padding` on `.accordion-content-wrapper` |
| `contentBackgroundColor` | color | Background color | `background-color` on `.accordion-content-wrapper` |
| `contentBorder` | border | Border | `border` on `.accordion-content-wrapper` |
| `contentTypography` | typography | Typography | `font` on `.accordion-content-wrapper` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Accordion Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/accordion/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | accordion |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/accordion.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `accordions` | repeater | Title | — |
| `expandItem` | text | Expand item indexes | — |
| `independentToggle` | checkbox | Independent toggle | — |
| `transition` | number | Transition | — |
| `faqSchema` | checkbox | FAQ schema | — |
| `titleTag` | select | HTML tag | — |
| `icon` | icon | Icon | — |
| `iconTypography` | typography | Icon typography | `font` on `.accordion-title\{pseudo\} .icon` |
| `iconExpanded` | icon | Icon expanded | — |
| `iconExpandedTypography` | typography | Icon expanded typography | `font` on `.accordion-title\{pseudo\} .icon.expanded` |
| `iconPosition` | select | Icon position | — |
| `iconRotate` | number | Icon rotate in ° | `transform:rotate` on `.brx-open .title + .icon` |
| `titleMargin` | spacing | Margin | `margin` on `.accordion-title-wrapper` |
| `titlePadding` | spacing | Padding | `padding` on `.accordion-title-wrapper` |
| `titleTypography` | typography | Title typography | `font` on `.accordion-title\{pseudo\} .title` |
| `subtitleTypography` | typography | Subtitle typography | `font` on `.accordion-subtitle` |
| `titleBackgroundColor` | color | Background color | `background-color` on `.accordion-title-wrapper` |
| `titleBorder` | border | Border | `border` on `.accordion-title-wrapper` |
| `titleActiveBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.accordion-title-wrapper` |
| `titleActiveTypography` | typography | Active typography | `font` on `.brx-open .title` |
| `titleActiveBackgroundColor` | color | Active background | `background-color` on `.brx-open .accordion-title-wrapper` |
| `titleActiveBorder` | border | Active border | `border` on `.brx-open .accordion-title-wrapper` |
| `contentMargin` | spacing | Margin | `margin` on `.accordion-content-wrapper` |
| `contentPadding` | spacing | Padding | `padding` on `.accordion-content-wrapper` |
| `contentTypography` | typography | Content typography | `font` on `.accordion-content-wrapper` |
| `contentBackgroundColor` | color | Background color | `background-color` on `.accordion-content-wrapper` |
| `contentBorder` | border | Border | `border` on `.accordion-content-wrapper` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Alert Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/alert/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | alert |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/alert.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `content` | editor | content | — |
| `type` | select | Type | — |
| `dismissable` | checkbox | Dismissable | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Anim. Typing Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/animated-typing/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | animated-typing |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/animated-typing.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `tag` | select | Tag | — |
| `prefix` | text | Prefix | — |
| `suffix` | text | Suffix | — |
| `strings` | repeater | Strings | — |
| `typeSpeed` | number | Type speed in ms | — |
| `backSpeed` | number | Back speed in ms | — |
| `startDelay` | number | Start delay in ms | — |
| `backDelay` | number | Back delay in ms | — |
| `cursorChar` | text | Cursor character | — |
| `loop` | checkbox | Loop | — |
| `shuffle` | checkbox | Shuffle | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Audio Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/audio/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | audio |
| `category` | media |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/audio.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `source` | select | Source | — |
| `file` | audio | file | — |
| `external` | text | external | — |
| `useDynamicData` | text | useDynamicData | — |
| `titleCustom` | text | Custom title | — |
| `artist` | checkbox | Show artist | — |
| `title` | checkbox | Show title | — |
| `autoplay` | checkbox | Autoplay | — |
| `loop` | checkbox | Loop | — |
| `tag` | select | Tag | — |
| `preload` | select | Preload | — |
| `theme` | select | Theme | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Back To Top Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/back-to-top/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | back-to-top |
| `category` | general |
| `tag` | button |
| `nestable` | true |

<SchemaJson path="elements/back-to-top.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `tag` | text | HTML tag | — |
| `ariaLabel` | text | aria-label | — |
| `position` | select | Position | `position` |
| `positionTop` | number | Top | `top` |
| `positionRight` | number | Right | `right` |
| `positionBottom` | number | Bottom | `bottom` |
| `positionLeft` | number | Left | `left` |
| `visibleAfter` | number | Visible after | — |
| `visibleOnScrollUp` | checkbox | Visible on scroll up | — |
| `smoothScroll` | checkbox | Smooth scroll | — |
| `moveFocusToTop` | checkbox | Move focus to top | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Block Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/block/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | block |
| `category` | layout |
| `tag` | div |
| `nestable` | true |

<SchemaJson path="elements/block.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `link` | link | Link | — |
| `tag` | select | HTML tag | — |
| `customTag` | text | Custom tag | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_gridItemColumnSpan` | text | Grid column | `grid-column` |
| `_gridItemRowSpan` | text | Grid row | `grid-row` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_display` | select | Display | `display`, `align-items` |
| `_gridGap` | number | Gap | `grid-gap` |
| `_gridTemplateColumns` | text | Grid template columns | `grid-template-columns` |
| `_gridTemplateRows` | text | Grid template rows | `grid-template-rows` |
| `_gridAutoColumns` | text | Grid auto columns | `grid-auto-columns` |
| `_gridAutoRows` | text | Grid auto rows | `grid-auto-rows` |
| `_gridAutoFlow` | select | Grid auto flow | `grid-auto-flow` |
| `_justifyItemsGrid` | justify-content | Justify items | `justify-items` |
| `_alignItemsGrid` | align-items | Align items | `align-items` |
| `_justifyContentGrid` | justify-content | Justify content | `justify-content` |
| `_alignContentGrid` | align-items | Align content | `align-content` |
| `_flexWrap` | select | Flex wrap | `flex-wrap` |
| `_direction` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_columnGap` | number | Column gap | `column-gap` |
| `_rowGap` | number | Row gap | `row-gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_order` | number | Order | `order` |
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_gap` | number | Gap | `gap` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Breadcrumbs Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/breadcrumbs/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | breadcrumbs |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/breadcrumbs.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `gap` | number | Gap | `gap` |
| `singularStructure` | repeater | Post types | — |
| `showDateContext` | checkbox | Add context | — |
| `homeURL` | text | URL | — |
| `homeLabel` | text | Text | — |
| `homeIcon` | icon | Icon | — |
| `hideIconGap` | number | Icon | `gap` on `.item:has(> svg), .item:has(> i)` |
| `homeIconPosition` | select | Icon | — |
| `hideHomeLabel` | checkbox | Hide label | — |
| `separatorType` | select | Separator | — |
| `separatorText` | text | Separator | — |
| `separatorIcon` | icon | Icon | — |
| `separatorColor` | color | Color | `color` on `.separator` |
| `separatorSize` | number | Size | `font-size` on `.separator` |
| `itemPadding` | spacing | Padding | `padding` on `.item` |
| `itemBackgroundColor` | color | Background color | `background-color` on `.item` |
| `itemBorder` | border | Border | `border` on `.item` |
| `itemTypography` | typography | Typography | `font` on `.item` |
| `currentItemPadding` | spacing | Padding | `padding` on `.item[aria-current="page"]` |
| `currentItemBackgroundColor` | color | Background color | `background-color` on `.item[aria-current="page"]` |
| `currentItemBorder` | border | Border | `border` on `.item[aria-current="page"]` |
| `currentItemTypography` | typography | Typography | `font` on `.item[aria-current="page"]` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Button Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/button/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | button |
| `category` | basic |
| `tag` | span |
| `nestable` | false |

<SchemaJson path="elements/button.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `text` | text | text | — |
| `tag` | text | HTML tag | — |
| `size` | select | Size | — |
| `style` | select | Style | — |
| `circle` | checkbox | Circle | — |
| `outline` | checkbox | Outline | — |
| `link` | link | Link type | — |
| `icon` | icon | Icon | — |
| `iconTypography` | typography | Typography | `font` on `i` |
| `iconPosition` | select | Position | — |
| `iconGap` | number | Gap | `gap` |
| `iconSpace` | checkbox | Space between | `justify-content` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Carousel Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/carousel/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | carousel |
| `category` | media |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/carousel.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `type` | select | Type | — |
| `items` | image-gallery | Images | — |
| `query` | query | Query | — |
| `alignItems` | align-items | Align items | `align-items` on `.swiper-wrapper` |
| `imageDisable` | checkbox | Hide image | — |
| `imageSize` | select | Image size | — |
| `imageLightbox` | checkbox | Link to lightbox | — |
| `imageLightboxSize` | select | Image size | — |
| `lightboxImageClick` | select | Image click action | — |
| `lightboxAnimationType` | select | Animation | — |
| `lightboxCaption` | checkbox | Caption | — |
| `lightboxThumbnails` | checkbox | Thumbnail navigation | — |
| `lightboxThumbnailSize` | number | Thumbnail size | — |
| `lightboxPadding` | dimensions | Padding | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Code Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/code/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | code |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/code.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `executeCode` | checkbox | Execute code | — |
| `parseDynamicData` | checkbox | Parse dynamic data | — |
| `supressPhpErrors` | checkbox | Suppress PHP errors | — |
| `noRoot` | checkbox | Render without wrapper | — |
| `code` | code | code | — |
| `cssCode` | code | cssCode | — |
| `javascriptCode` | code | javascriptCode | — |
| `prettify` | select | Theme | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Element Conditions Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/common/conditions/*

import SchemaJson from '../../../../../../components/SchemaJson.astro'

Element display conditions control whether an element renders on the frontend. They are stored in the `_conditions` key inside any element's `settings` object.

## Data structure

Conditions use an OR-of-AND structure: the outer array contains OR groups, and each inner array contains AND items. The element renders if **any** OR group evaluates to true, and an OR group is true when **all** its AND items are true.

<SchemaJson path="elements/common/conditions.json" />

## `conditionItem` properties

Each condition item has the following properties:

| Property | Type | Required | Description |
|---|---|---|---|
| `id` | string \| integer | Yes | Unique identifier for this condition |
| `key` | string | Yes | Condition type (see enum below) |
| `compare` | string | Yes | Comparison operator (see table below) |
| `value` | any | Conditional | The value to compare against. Not needed when compare is `empty` or `empty_not`. |
| `dynamic_data` | string | No | Dynamic data tag to use as the value source |

### Example

```json
{
  "_conditions": [
    [
      { "id": "abc123", "key": "user_logged_in", "compare": "==", "value": true },
      { "id": "def456", "key": "user_role", "compare": "==", "value": "administrator" }
    ],
    [
      { "id": "ghi789", "key": "dynamic_data", "compare": "contains", "value": "sale", "dynamic_data": "{post_title}" }
    ]
  ]
}
```

This reads as: show the element if (user is logged in AND is an administrator) OR (the post title contains "sale").

## Condition keys

**General**
- `browser`
- `current_url`
- `date`
- `datetime`
- `dynamic_data`
- `featured_image`
- `operating_system`
- `referer`
- `time`
- `weekday`

**Post**
- `post_author`
- `post_date`
- `post_id`
- `post_parent`
- `post_status`
- `post_title`

**User**
- `user_id`
- `user_logged_in`
- `user_registered`
- `user_role`

**WooCommerce**
- `woo_product_category`
- `woo_product_featured`
- `woo_product_new`
- `woo_product_purchased_by_user`
- `woo_product_rating`
- `woo_product_sale`
- `woo_product_sold_individually`
- `woo_product_stock_management`
- `woo_product_stock_quantity`
- `woo_product_stock_status`
- `woo_product_tag`
- `woo_product_type`

Available compare operators vary by condition key. For example, `post_id` supports math operators (`==`, `!=`, `>=`, `<=`, `>`, `<`), while `user_logged_in` only supports `==` and `!=`.

## Comparison operators

| Operator | Description |
|---|---|
| `==` | Equal (loose comparison, supports arrays via intersection) |
| `!=` | Not equal (loose comparison) |
| `>=` | Greater than or equal |
| `<=` | Less than or equal |
| `>` | Greater than |
| `<` | Less than |
| `contains` | String contains substring |
| `contains_not` | String does not contain substring |
| `empty` | Value is empty (no value field needed) |
| `empty_not` | Value is not empty (no value field needed) |

## Extensibility

Condition keys and comparison operators are filterable via PHP hooks:

- `bricks/conditions/groups`: add custom condition groups
- `bricks/conditions/options`: add custom condition keys with their own compare operators
- `bricks/conditions/result`: modify the boolean result of any individual condition evaluation

Third-party plugins can introduce additional condition keys beyond those listed above.

---


## Element Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/common/element/*

import SchemaJson from '../../../../../../components/SchemaJson.astro'

Every element in Bricks uses the same envelope structure, regardless of type. Element-specific controls are documented in each [individual element schema](../../elements/accordion/); content areas (the flat arrays that hold elements) are documented in the [content area schema](../../general/content-area/).

<SchemaJson path="elements/common/element.json" />

## Element envelope

Every element object has these top-level fields:

| Field | Type | Required | Description |
|---|---|---|---|
| `id` | string | Yes | Unique 6-character alphanumeric identifier (e.g. `"dlceeu"`) |
| `name` | string | Yes | Element type, matches the element schema filename (e.g. `"button"`, `"heading"`) |
| `parent` | string \| 0 | Yes | Parent element ID, or `0` for root-level elements |
| `children` | string[] | Yes | Ordered array of child element IDs |
| `settings` | object | Yes | All control values for this element (element-specific + inherited + meta) |
| `selectors` | array | No | Custom CSS selectors with scoped settings (since Bricks 2.0) |
| `label` | string | No | Custom label assigned by the user in the builder |
| `themeStyles` | array | No | Theme style overrides applied to this element |

## Settings: three layers

The `settings` object combines three layers of keys:

1. **Element-specific controls:** unique to each element type (e.g. `text`, `tag`, `link` on a button). Documented in each element's schema.
2. **Inherited CSS controls:** shared by all elements, prefixed with `_` (e.g. `_typography`, `_margin`, `_padding`, `_background`). These support responsive and pseudo-class variants via colon suffixes (e.g. `_typography:tablet_portrait:hover`). Documented in each element's schema under the `_`-prefixed keys.
3. **Meta-settings:** shared by all elements but not listed in individual element schemas. These control visibility, behavior, and class assignment. Documented below.

## Meta-settings

These keys can appear in any element's `settings` object. They are not included in per-element schemas to avoid duplication across 130+ elements.

### `_cssGlobalClasses`

Array of global class IDs applied to this element. Each ID references a global class defined in the [global classes](../../global/global-classes/) data.

```json
"_cssGlobalClasses": ["mmdqed", "xkatss"]
```

### `_conditions`

Element display conditions that control whether this element renders. Structured as an array of arrays: outer array is OR groups, inner arrays are AND items.

```json
"_conditions": [
  [
    { "id": "abc123", "key": "user_logged_in", "compare": "==", "value": true }
  ]
]
```

See the [Element Conditions](./conditions/) page for the full `conditionItem` schema, all 32 condition keys, and available comparison operators.

### `_interactions`

Array of interaction rules that trigger actions in response to events (click, scroll, hover, etc.). Each interaction specifies a trigger, action, and target.

```json
"_interactions": [
  {
    "id": "abc123",
    "trigger": "click",
    "action": "startAnimation",
    "target": "self"
  }
]
```

See the [Element Interactions](./interactions/) page for the full `interactionItem` schema, all triggers, actions, and sub-conditions.

### `_hideElementBuilder`

Boolean (default `false`). When `true`, the element is hidden on the builder canvas but still renders on the frontend.

### `_hideElementFrontend`

Boolean (default `false`). When `true`, the element is hidden on the frontend but remains visible in the builder.

### `_attributes`

Array of custom HTML attributes added to the element's root DOM node.

```json
"_attributes": [
  { "id": "abc123", "name": "data-aos", "value": "fade-up" }
]
```

## Selectors

The `selectors` array allows scoping control settings to arbitrary CSS selectors on an element (since Bricks 2.0). Each selector entry has its own `settings` object that follows the same structure as the element's main settings.

```json
"selectors": [
  {
    "id": "nopzhs",
    "selector": "#brxe-opxcoa h3",
    "settings": {
      "_typography": { "color": { "raw": "blue" } }
    },
    "label": "Heading within container"
  }
]
```

| Field | Type | Required | Description |
|---|---|---|---|
| `id` | string | Yes | Unique identifier for this selector entry |
| `selector` | string | Yes | CSS selector string (e.g. `".my-class"`, `"&::before"`, `"& > span"`) |
| `settings` | object | Yes | Control settings scoped to this selector |
| `label` | string | No | Display label in the builder UI |

### Selector item schema

```json
{
  "type": "object",
  "description": "Custom CSS selector on an element or global class (since Bricks 2.0). Allows scoping control settings to arbitrary CSS selectors.",
  "properties": {
    "id": {
      "type": "string",
      "description": "Unique identifier for this selector entry"
    },
    "selector": {
      "type": "string",
      "description": "CSS selector string (e.g. \".my-class\", \"&::before\", \"& > span\")"
    },
    "settings": {
      "description": "Control settings scoped to this selector (same shape as element settings)",
      "_note": "Dynamic map of all settings for this element or class. Keys are element-specific control names (e.g. `text`, `style`) or inherited CSS setting keys, optionally suffixed with a breakpoint and/or pseudo-class using colon syntax (e.g. `_typography:tablet_portrait:hover`). See the individual element schemas for available control keys."
    },
    "label": {
      "type": "string",
      "description": "Optional display label for this selector in the builder UI"
    }
  },
  "required": [
    "id",
    "selector",
    "settings"
  ],
  "additionalProperties": false
}
```

## How this relates to individual element schemas

Each element schema (e.g. [button](../../elements/button/), [heading](../../elements/heading/)) documents the element-specific and inherited CSS controls that go into the `settings` object. The envelope fields (`id`, `name`, `parent`, `children`, `selectors`, `label`, `themeStyles`) and meta-settings (`_cssGlobalClasses`, `_conditions`, `_interactions`, etc.) documented on this page apply identically to every element type.

To construct a complete element, combine:
1. The envelope fields from this page
2. Element-specific controls from the individual element schema
3. Inherited CSS controls (the `_`-prefixed keys in the element schema)
4. Any applicable meta-settings from this page

---


## Element Interactions Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/common/interactions/*

import SchemaJson from '../../../../../../components/SchemaJson.astro'

Element interactions define event-driven behavior: when a trigger fires, an action is executed on a target. They are stored in the `_interactions` key inside any element's `settings` object.

## Data structure

Interactions are a flat array of interaction items. Each item specifies a trigger event, the action to perform, and a target element or selector.

<SchemaJson path="elements/common/interactions.json" />

## `interactionItem` core properties

| Property | Type | Description |
|---|---|---|
| `id` | string \| integer | Unique identifier for this interaction |
| `trigger` | string | Event that fires this interaction (see triggers below) |
| `action` | string | Action to perform (see actions below) |
| `target` | string | Target reference (`"self"`, element ID, or selector context) |
| `targetSelector` | string | CSS selector for the target element |
| `delay` | string | Delay before executing the action (ms) |
| `runOnce` | boolean | If true, the interaction fires only once |

## Additional properties

These properties apply depending on the chosen action:

| Property | Type | Used with |
|---|---|---|
| `animationType` | string | `startAnimation` (animation type) |
| `animationId` | string | `startAnimation` (predefined animation ID) |
| `animationDelay` | string | `startAnimation` (animation delay) |
| `animationDuration` | string | `startAnimation` (animation duration) |
| `jsFunction` | string | `javascript` (function name to call) |
| `jsFunctionArgs` | array | `javascript` (arguments array: `[{ jsFunctionArg: "value" }]`) |
| `scrollToDelay` | string | `scrollTo` (delay before scrolling) |
| `scrollToOffset` | string | `scrollTo` (scroll offset in pixels) |
| `scrollOffset` | string | `scroll` trigger (scroll position threshold) |
| `rootMargin` | string | `enterView`/`leaveView` (IntersectionObserver root margin) |
| `templateId` | string | Template ID reference |
| `formId` | string | Form element ID |
| `ajaxQueryId` | string | AJAX query element ID |
| `offCanvasSelector` | string | `toggleOffCanvas` (offcanvas CSS selector) |
| `toggleOffCanvasInfo` | string | `toggleOffCanvas` (info field) |
| `filterElementId` | string | Query filter element ID |
| `infoBoxId` | string | Info box element ID |
| `loadMoreQuery` | string | `loadMore` (query element ID) |
| `targetFormSelector` | string | `clearForm` (form CSS selector) |
| `actionAttributeKey` | string | `setAttribute`/`removeAttribute`/`toggleAttribute` (attribute name) |
| `actionAttributeValue` | string | `setAttribute`/`toggleAttribute` (attribute value) |
| `disablePreventDefault` | boolean | Do not call `preventDefault()` on the trigger event |
| `storageType` | string | `storageAdd`/`storageRemove`/`storageCount` (storage type) |
| `popupContextId` | string | Popup context ID |
| `popupContextType` | string | Popup context type |
| `conditionsSep` | string | Visual separator for conditions UI |

### Example

```json
{
  "_interactions": [
    {
      "id": "abc123",
      "trigger": "click",
      "action": "startAnimation",
      "target": "self",
      "animationType": "fadeIn",
      "animationDuration": "500"
    },
    {
      "id": "def456",
      "trigger": "enterView",
      "action": "show",
      "target": "self",
      "rootMargin": "0px 0px -100px 0px",
      "runOnce": true
    }
  ]
}
```

## Triggers

**Element**
- `click`
- `mouseover`
- `focus`
- `blur`
- `mouseenter`
- `mouseleave`
- `enterView`
- `leaveView`
- `animationEnd`
- `ajaxStart`
- `ajaxEnd`
- `formSubmit`
- `formSuccess`
- `formError`

**Browser / Window**
- `scroll`
- `contentLoaded`
- `mouseleaveWindow`

**Query filters**
- `filterOptionEmpty`
- `filterOptionNotEmpty`

**WooCommerce**
- `wooAddedToCart`
- `wooAddingToCart`
- `wooRemovedFromCart`
- `wooUpdateCart`
- `wooCouponApplied`
- `wooCouponRemoved`

Popup templates have two additional triggers (`showPopup`, `hidePopup`) available via the `templateInteractionItem` variant in template settings.

## Actions

| Action | Description |
|---|---|
| `show` | Show element |
| `hide` | Hide element |
| `click` | Click element |
| `setAttribute` | Set an HTML attribute |
| `removeAttribute` | Remove an HTML attribute |
| `toggleAttribute` | Toggle an HTML attribute |
| `toggleOffCanvas` | Toggle an offcanvas panel |
| `loadMore` | Load more items (query loop) |
| `startAnimation` | Start a CSS animation |
| `scrollTo` | Scroll to an element |
| `javascript` | Execute a custom JavaScript function |
| `openAddress` | Open a map address |
| `closeAddress` | Close a map address |
| `clearForm` | Clear a form |
| `storageAdd` | Add item to browser storage |
| `storageRemove` | Remove item from browser storage |
| `storageCount` | Count items in browser storage |

## Interaction sub-conditions

Each interaction can optionally include sub-conditions that must be met before the action fires. These are stored in the `interactionConditions` array, with `interactionConditionsRelation` controlling whether conditions are combined with AND or OR logic.

| Property | Type | Description |
|---|---|---|
| `interactionConditions` | array | Array of `interactionConditionItem` objects |
| `interactionConditionsRelation` | string | `"and"` or `"or"` (default: `"and"`) |

### `interactionConditionItem` properties

| Property | Type | Description |
|---|---|---|
| `conditionType` | string | Type of condition check |
| `storageCompare` | string | Comparison operator for storage value |
| `storageCompareValue` | any | Value to compare storage against |
| `storageKey` | any | Browser storage key to check |

### Example with sub-conditions

```json
{
  "id": "abc123",
  "trigger": "click",
  "action": "show",
  "target": "self",
  "interactionConditions": [
    {
      "conditionType": "storage",
      "storageKey": "user_preference",
      "storageCompare": "==",
      "storageCompareValue": "dark"
    }
  ],
  "interactionConditionsRelation": "and"
}
```

---


## Container Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/container/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | container |
| `category` | layout |
| `tag` | div |
| `nestable` | true |

<SchemaJson path="elements/container.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `link` | link | Link | — |
| `tag` | select | HTML tag | — |
| `customTag` | text | Custom tag | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_gridItemColumnSpan` | text | Grid column | `grid-column` |
| `_gridItemRowSpan` | text | Grid row | `grid-row` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_display` | select | Display | `display`, `align-items` |
| `_gridGap` | number | Gap | `grid-gap` |
| `_gridTemplateColumns` | text | Grid template columns | `grid-template-columns` |
| `_gridTemplateRows` | text | Grid template rows | `grid-template-rows` |
| `_gridAutoColumns` | text | Grid auto columns | `grid-auto-columns` |
| `_gridAutoRows` | text | Grid auto rows | `grid-auto-rows` |
| `_gridAutoFlow` | select | Grid auto flow | `grid-auto-flow` |
| `_justifyItemsGrid` | justify-content | Justify items | `justify-items` |
| `_alignItemsGrid` | align-items | Align items | `align-items` |
| `_justifyContentGrid` | justify-content | Justify content | `justify-content` |
| `_alignContentGrid` | align-items | Align content | `align-content` |
| `_flexWrap` | select | Flex wrap | `flex-wrap` |
| `_direction` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_columnGap` | number | Column gap | `column-gap` |
| `_rowGap` | number | Row gap | `row-gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_order` | number | Order | `order` |
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_gap` | number | Gap | `gap` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Countdown Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/countdown/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | countdown |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/countdown.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `date` | datepicker | Date | — |
| `timezone` | select | Time zone | — |
| `action` | select | Date Reached | — |
| `actionText` | text | Date Reached | — |
| `fields` | repeater | Prefix | — |
| `flexDirectionFields` | direction | Direction | `flex-direction` |
| `justifyContent` | justify-content | Align main axis | `justify-content` |
| `alignItems` | align-items | Align cross axis | `align-items` |
| `flexDirection` | direction | Direction | `flex-direction` on `.field` |
| `gutter` | spacing | Margin | `margin` on `.field` |
| `typography` | typography | Typography | `font` |
| `typographyPrefix` | typography | Typography | `font` on `.prefix` |
| `typographySuffix` | typography | Typography | `font` on `.suffix` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Counter Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/counter/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | counter |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/counter.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `countFrom` | text | Count from | — |
| `countTo` | text | Count to | — |
| `duration` | number | Animation in ms | — |
| `countTypography` | typography | Typography | `font` on `.count` |
| `prefix` | text | Prefix | — |
| `prefixTypography` | typography | Typography | `font` on `.prefix` |
| `suffix` | text | Suffix | — |
| `suffixTypography` | typography | Typography | `font` on `.suffix` |
| `thousandSeparator` | checkbox | Thousand separator | — |
| `separatorText` | text | Separator | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Div Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/div/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | div |
| `category` | layout |
| `tag` | div |
| `nestable` | true |

<SchemaJson path="elements/div.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `link` | link | Link | — |
| `tag` | select | HTML tag | — |
| `customTag` | text | Custom tag | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_gridItemColumnSpan` | text | Grid column | `grid-column` |
| `_gridItemRowSpan` | text | Grid row | `grid-row` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_display` | select | Display | `display`, `align-items` |
| `_gridGap` | number | Gap | `grid-gap` |
| `_gridTemplateColumns` | text | Grid template columns | `grid-template-columns` |
| `_gridTemplateRows` | text | Grid template rows | `grid-template-rows` |
| `_gridAutoColumns` | text | Grid auto columns | `grid-auto-columns` |
| `_gridAutoRows` | text | Grid auto rows | `grid-auto-rows` |
| `_gridAutoFlow` | select | Grid auto flow | `grid-auto-flow` |
| `_justifyItemsGrid` | justify-content | Justify items | `justify-items` |
| `_alignItemsGrid` | align-items | Align items | `align-items` |
| `_justifyContentGrid` | justify-content | Justify content | `justify-content` |
| `_alignContentGrid` | align-items | Align content | `align-content` |
| `_flexWrap` | select | Flex wrap | `flex-wrap` |
| `_direction` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_columnGap` | number | Column gap | `column-gap` |
| `_rowGap` | number | Row gap | `row-gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_order` | number | Order | `order` |
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_gap` | number | Gap | `gap` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Divider Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/divider/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | divider |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/divider.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `height` | number | Height | `height` on `.line`, `border-top-width` on `&.horizontal .line` |
| `width` | number | Width | `width` on `&.horizontal .line`, `border-right-width` on `&.vertical .line` |
| `style` | select | Style | `border-top-style` on `&.horizontal .line`, `border-right-style` on `&.vertical .line` |
| `direction` | select | Direction | — |
| `justifyContent` | justify-content | Align | `justify-content` on `&.horizontal`, `align-self` on `&.vertical` |
| `color` | color | Color | `border-top-color` on `&.horizontal .line`, `border-right-color` on `&.vertical .line`, `color` on `.icon` |
| `icon` | icon | Icon | — |
| `iconTypography` | typography | Typography | `font` on `.icon` |
| `iconAlignItems` | align-items | Align | `align-items` |
| `iconPosition` | select | Position | — |
| `iconSpacing` | number | Spacing | `gap` |
| `link` | link | Link | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Dropdown Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/dropdown/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | dropdown |
| `category` | general |
| `tag` | li |
| `nestable` | true |

<SchemaJson path="elements/dropdown.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `tag` | text | HTML tag | — |
| `text` | text | Text | — |
| `link` | link | Link to | — |
| `ariaLabel` | text | Attribute | — |
| `icon` | icon | Icon | `—` on `.brx-submenu-toggle button > svg` |
| `iconPadding` | spacing | Icon padding | `padding` on `.brx-submenu-toggle button` |
| `gap` | number | Gap | `gap` on `.brx-submenu-toggle` |
| `iconPosition` | select | Icon position | `flex-direction` on `.brx-submenu-toggle` |
| `iconSize` | number | Icon size | `font-size` on `.brx-submenu-toggle button` |
| `iconColor` | color | Icon color | `color` on `.brx-submenu-toggle button` |
| `iconTransform` | transform | Icon transform | `transform` on `.brx-submenu-toggle button` |
| `iconTransformOpen` | transform | Icon transform | `transform` on `.brx-submenu-toggle button[aria-expanded="true"]` |
| `iconTransition` | text | Icon transition | `transition` on `.brx-submenu-toggle button` |
| `caretSize` | number | Size | `border-width` on `> .brx-dropdown-content::before` |
| `caretColor` | color | Color | `border-bottom-color` on `> .brx-dropdown-content::before` |
| `caretTransform` | transform | Transform | `transform` on `> .brx-dropdown-content::before` |
| `caretPosition` | dimensions | Position | `—` on `> .brx-dropdown-content::before` |
| `static` | checkbox | Position | — |
| `toggleOn` | select | Toggle on | — |
| `contentWidth` | number | Min. width | `min-width` on `.brx-dropdown-content` |
| `contentTransition` | text | Transition | `transition` on `> .brx-dropdown-content` |
| `contentTransform` | transform | Transform | `transform` on `> .brx-dropdown-content` |
| `contentTransformOpen` | transform | Transform | `transform` on `&.open > .brx-dropdown-content` |
| `contentBackground` | background | Background | `background` on `.brx-dropdown-content` |
| `contentBorder` | border | Border | `border` on `.brx-dropdown-content` |
| `contentBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.brx-dropdown-content` |
| `contentTypography` | typography | Typography | `font` on `.brx-dropdown-content` |
| `contentItemJustifyContent` | justify-content | Justify content | `justify-content` on `.brx-dropdown-content > li > a`, `justify-content` on `.brx-submenu-toggle`, `width` on `.brx-dropdown-content > li > a`, `width` on `.brx-submenu-toggle a` |
| `contentItemPadding` | spacing | Padding | `padding` on `.brx-dropdown-content > li > a`, `padding` on `.brx-dropdown-content .brx-submenu-toggle > *`, `padding` on `&.brx-has-megamenu .brx-dropdown-content > *` |
| `contentItemBackground` | color | Background | `background-color` on `.brx-dropdown-content > li > a`, `background-color` on `.brx-dropdown-content .brx-submenu-toggle`, `background-color` on `&.brx-has-megamenu .brx-dropdown-content > *` |
| `contentItemBorder` | border | Border | `border` on `.brx-dropdown-content > li > a`, `border` on `.brx-dropdown-content .brx-submenu-toggle`, `border` on `&.brx-has-megamenu .brx-dropdown-content > *` |
| `contentItemTypography` | typography | Typography | `font` on `.brx-dropdown-content > li > a`, `font` on `.brx-dropdown-content .brx-submenu-toggle > *`, `font` on `&.brx-has-megamenu .brx-dropdown-content > *` |
| `contentItemTransition` | text | Transition | `transition` on `.brx-dropdown-content > li`, `transition` on `.brx-dropdown-content > li > a`, `transition` on `.brx-dropdown-content .brx-submenu-toggle`, `transition` on `&.brx-has-megamenu .brx-dropdown-content > *` |
| `contentItemBackgroundActive` | color | Background | `background-color` on `.brx-dropdown-content > li [aria-current="page"]`, `background-color` on `.brx-dropdown-content > li .aria-current`, `background-color` on `&.brx-has-megamenu .brx-dropdown-content [aria-current="page"]` |
| `contentItemBorderActive` | border | Border | `border` on `.brx-dropdown-content > li [aria-current="page"]`, `border` on `.brx-dropdown-content > li .aria-current`, `border` on `&.brx-has-megamenu .brx-dropdown-content [aria-current="page"]` |
| `contentItemTypographyActive` | typography | Typography | `font` on `.brx-dropdown-content > li [aria-current="page"]`, `font` on `.brx-dropdown-content > li .aria-current`, `font` on `&.brx-has-megamenu .brx-dropdown-content [aria-current="page"]` |
| `megaMenu` | checkbox | Enable | — |
| `megaMenuSelector` | text | CSS selector | — |
| `megaMenuSelectorVertical` | text | CSS selector | — |
| `multiLevel` | checkbox | Enable | — |
| `multiLevelBackText` | text | Back | — |
| `multiLevelBackTypography` | typography | Back | `font` on `.brx-multilevel-back` |
| `multiLevelBackBackground` | color | Back | `background-color` on `.brx-multilevel-back` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Facebook Page Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/facebook-page/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | facebook-page |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/facebook-page.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `href` | text | Facebook page URL | — |
| `height` | number | Height | — |
| `width` | number | Width | — |
| `tabs` | select | Tabs | — |
| `hideCover` | checkbox | Hide cover | — |
| `profilePhotos` | checkbox | Show friends\ | — |
| `hideCta` | checkbox | Hide CTA button | — |
| `smallHeader` | checkbox | Small header | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Filter - Active Filters Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/filter-active-filters/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | filter-active-filters |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/filter-active-filters.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `excludeIds` | text | Exclude filter IDs | — |
| `buttonPadding` | spacing | Padding | `padding` on `.bricks-button` |
| `buttonGap` | number | Gap | `gap` |
| `buttonSize` | select | Size | — |
| `buttonStyle` | select | Style | — |
| `buttonCircle` | checkbox | Circle | — |
| `buttonOutline` | checkbox | Outline | — |
| `buttonBackgroundColor` | color | Background color | `background-color` on `.bricks-button` |
| `buttonBorder` | border | Border | `border-color` on `.bricks-button` |
| `buttonTypography` | typography | Typography | `font` on `.bricks-button` |
| `icon` | icon | Icon | — |
| `iconColor` | color | Color | `color` on `.bricks-button i`, `fill` on `.bricks-button svg path` |
| `iconSize` | number | Size | `font-size` on `.bricks-button .icon` |
| `iconGap` | number | Gap | `gap` on `.bricks-button` |
| `iconPosition` | select | Position | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Filter - Checkbox Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/filter-checkbox/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | filter-checkbox |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/filter-checkbox.json" />

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Filter - Datepicker Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/filter-datepicker/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | filter-datepicker |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/filter-datepicker.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `placeholder` | text | Placeholder | — |
| `placeholderTypography` | typography | Placeholder typography | `font` on `input::placeholder` |
| `l10n` | text | Language | — |
| `dateFormat` | text | Datepicker format | — |
| `icon` | icon | Icon | — |
| `iconColor` | color | Icon color | `color` on `.icon` |
| `iconSize` | number | Icon size | `font-size` on `.icon` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Filter - Radio Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/filter-radio/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | filter-radio |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/filter-radio.json" />

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Filter - Range Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/filter-range/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | filter-range |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/filter-range.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `disableAutoMinMax` | checkbox | Disable auto min/max value | — |
| `displayMode` | select | Mode | — |
| `step` | number | Step | — |
| `decimalPlaces` | number | Decimal places | — |
| `labelThousandSeparator` | checkbox | Thousand separator | — |
| `labelSeparatorText` | text | Separator | — |
| `labelMin` | text | Min | — |
| `labelMax` | text | Max | — |
| `labelDirection` | direction | Direction | `flex-direction` on `.min-max-wrap > *, .value-wrap > *` |
| `labelGap` | number | Gap | `gap` on `.value-wrap > span`, `gap` on `.min-max-wrap > div` |
| `labelTypography` | typography | Typography | `font` on `.label` |
| `placeholderMin` | text | Placeholder | — |
| `placeholderMax` | text | Placeholder | — |
| `inputBackgroundColor` | color | Background color | `background-color` on `.min-max-wrap input` |
| `inputBorder` | border | Border | `border` on `.min-max-wrap input` |
| `inputTypography` | typography | Typography | `font` on `.min-max-wrap input` |
| `inputWidth` | number | Width | `width` on `.min-max-wrap input` |
| `inputUseCustomStepper` | checkbox | Custom stepper | — |
| `inputCustomStepperButtonGap` | number | Gap | `gap` on `.min-max-wrap.has-custom-stepper .brx-stepper` |
| `inputCustomStepperInputGap` | number | Gap | `margin-inline-start` on `.min-max-wrap.has-custom-stepper .brx-stepper` |
| `inputCustomStepperButtonBackgroundColor` | color | Button | `background-color` on `.min-max-wrap.has-custom-stepper .brx-stepper-button` |
| `inputCustomStepperButtonBorder` | border | Button | `border` on `.min-max-wrap.has-custom-stepper .brx-stepper-button` |
| `inputCustomStepperButtonTypography` | typography | Button | `font` on `.min-max-wrap.has-custom-stepper .brx-stepper-button` |
| `sliderSpacing` | number | Spacing | `padding-top` on `.double-slider-wrap`, `margin-top` on `.double-slider-wrap .value-wrap` |
| `sliderBarHeight` | number | Bar | `border-width` on `.double-slider-wrap .slider-wrap .slider-base`, `border-width` on `.double-slider-wrap .slider-wrap .slider-track` |
| `sliderBarColor` | color | Bar | `border-color` on `.double-slider-wrap .slider-wrap .slider-base` |
| `sliderBarColorActive` | color | Bar | `border-color` on `.double-slider-wrap .slider-wrap .slider-track`, `border-color` on `.double-slider-wrap input[type="range"]::-moz-range-thumb`, `border-color` on `.double-slider-wrap input[type="range"]::-webkit-slider-thumb` |
| `sliderThumbSize` | number | Thumb | `width` on `.double-slider-wrap input[type="range"]::-moz-range-thumb`, `width` on `.double-slider-wrap input[type="range"]::-webkit-slider-thumb`, `height` on `.double-slider-wrap input[type="range"]::-moz-range-thumb`, `height` on `.double-slider-wrap input[type="range"]::-webkit-slider-thumb`, `border-radius` on `:scope > .double-slider-wrap input[type="range"]::-moz-range-thumb`, `border-radius` on `:scope > .double-slider-wrap input[type="range"]::-webkit-slider-thumb` |
| `sliderThumbBackgroundColor` | color | Thumb | `background-color` on `.double-slider-wrap input[type="range"]::-moz-range-thumb`, `background-color` on `.double-slider-wrap input[type="range"]::-webkit-slider-thumb` |
| `sliderThumbBorderFull` | border | Thumb | `border` on `.double-slider-wrap input[type="range"]::-moz-range-thumb`, `border` on `.double-slider-wrap input[type="range"]::-webkit-slider-thumb` |
| `sliderThumbBoxShadow` | box-shadow | Thumb | `box-shadow` on `.double-slider-wrap input[type="range"]::-moz-range-thumb`, `box-shadow` on `.double-slider-wrap input[type="range"]::-webkit-slider-thumb` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Filter - Search Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/filter-search/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | filter-search |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/filter-search.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `placeholder` | text | Placeholder | — |
| `placeholderTypography` | typography | Placeholder typography | `font` on `input::placeholder` |
| `label` | text | Label | — |
| `labelTypography` | typography | Label typography | `font` on `label` |
| `icon` | icon | Icon | — |
| `iconColor` | color | Icon color | `color` on `.icon` |
| `iconSize` | number | Icon size | `font-size` on `.icon` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Filter - Select Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/filter-select/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | filter-select |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/filter-select.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `placeholder` | text | Placeholder | — |
| `choicesJs` | checkbox | Enhanced select | — |
| `choicesPosition` | select | Dropdown position | — |
| `choicesSearch` | checkbox | Enable search | — |
| `choicesSearchBackground` | color | Background color | `background-color` on `input[type="search"]` |
| `choicesSearchPlaceholder` | text | Placeholder | — |
| `choicesSearchTypography` | typography | Placeholder | `font` on `.bricks-choices__input::placeholder` |
| `choicesSearchInputTypography` | typography | Input | `font` on `.bricks-choices__input` |
| `choicesSearchInputPadding` | text | Input | `--choices-brx-search-input-padding` |
| `choicesNoResultsText` | text | No results | — |
| `choicesNoChoicesText` | text | No choices | — |
| `enableMultiple` | checkbox | Multiple options | — |
| `choicesPillGap` | number | Pill | `--choices-multiple-item-margin` |
| `choicesPillBackground` | color | Pill | `--choices-primary-color` |
| `choicesPillBorder` | border | Pill | `border` on `.bricks-choices__list--multiple .bricks-choices__item` |
| `choicesPillTypography` | typography | Pill | `font` on `.bricks-choices__list--multiple` |
| `choicesPadding` | text | Padding | `--choices-inner-padding` |
| `choicesBackgroundColor` | color | Background | `--choices-bg-color` |
| `choicesBorderBase` | text | Border | `--choices-base-border` |
| `choicesBorderColor` | color | Border color | `--choices-keyline-color` |
| `choicesBorderRadius` | number | Border radius | `--choices-border-radius` |
| `choicesFontSize` | number | Font size | `--choices-font-size` |
| `choicesTextColor` | color | Text color | `--choices-brx-text-color` |
| `choicesArrowColor` | color | Arrow color | `--choices-text-color` |
| `choicesItemPadding` | text | Padding | `--choices-dropdown-item-padding` |
| `choicesDropdownBackground` | color | Background | `--choices-bg-color-dropdown` |
| `choicesHighlightBackground` | color | Highlight | `--choices-highlighted-color` |
| `choicesHighlightTextColor` | color | Highlight | `--choices-brx-highlighted-text-color` |
| `choicesDisabledBackground` | color | Disabled | `--choices-brx-bg-color-disabled` |
| `choicesDisabledTextColor` | color | Disabled | `--choices-brx-text-color-disabled` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Filter - Submit / Reset Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/filter-submit/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | filter-submit |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/filter-submit.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `text` | text | Text | — |
| `size` | select | Size | — |
| `style` | select | Style | — |
| `circle` | checkbox | Circle | — |
| `outline` | checkbox | Outline | — |
| `icon` | icon | Icon | — |
| `iconColor` | color | Icon color | `color` on `.icon`, `fill` on `.icon` |
| `iconSize` | number | Icon size | `font-size` on `.icon` |
| `gap` | number | Gap | `gap` |
| `direction` | direction | Direction | `flex-direction` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Form Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/form/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | form |
| `category` | general |
| `tag` | form |
| `nestable` | false |

<SchemaJson path="elements/form.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `fields` | repeater | Type | `font` on `.password-toggle .show-password i` |
| `requiredAsterisk` | checkbox | Show required asterisk | — |
| `disableRequiredAsteriskInPlaceholder` | checkbox | Disable required asterisk in placeholder | — |
| `showLabels` | checkbox | Show labels | — |
| `labelTypography` | typography | Label typography | `font` on `label`, `font` on `.label` |
| `placeholderTypography` | typography | Placeholder typography | `font` on `::placeholder`, `font` on `select` |
| `disableFormValidationOn` | select | Disable form validation | — |
| `disableBrowserValidation` | checkbox | Don\ | — |
| `validateAllFieldsOnSubmit` | checkbox | Validate all fields on submit | — |
| `fieldMargin` | spacing | Spacing | `padding` on `.form-group:not(.submit-button-wrapper):not(.message):not(.captcha)` |
| `fieldPadding` | spacing | Padding | `padding` on `.form-group input`, `padding` on `.flatpickr`, `padding` on `select`, `padding` on `textarea` |
| `horizontalAlignFields` | justify-content | Alignment | `justify-content` |
| `fieldBackgroundColor` | color | Background color | `background-color` on `.form-group input`, `background-color` on `.flatpickr`, `background-color` on `select`, `background-color` on `textarea` |
| `fieldBorder` | border | Border | `border` on `.form-group input`, `border` on `.flatpickr`, `border` on `select`, `border` on `textarea`, `border` on `.bricks-button:not([type=submit])`, `border` on `.choose-files` |
| `fieldTypography` | typography | Typography | `font` on `.form-group input`, `font` on `select`, `font` on `textarea` |
| `submitButtonText` | text | Text | — |
| `submitButtonSize` | select | Size | — |
| `submitButtonStyle` | select | Style | — |
| `submitButtonWidth` | number | Width | `width` on `.submit-button-wrapper` |
| `submitButtonMargin` | spacing | Margin | `margin` on `.submit-button-wrapper` |
| `submitButtonTypography` | typography | Typography | `font` on `.bricks-button` |
| `submitButtonBackgroundColor` | color | Background | `background-color` on `.bricks-button` |
| `submitButtonBorder` | border | Border | `border` on `button[type=submit].bricks-button` |
| `submitButtonIcon` | icon | Icon | — |
| `submitButtonIconPosition` | select | Icon position | — |
| `actions` | select | Actions after successful form submit | — |
| `successMessage` | text | Success message | — |
| `noticeCloseAfter` | number | Close after | — |
| `noticeCloseButton` | checkbox | Close button | — |
| `emailSubject` | text | Subject | — |
| `emailTo` | select | Send to email address | — |
| `emailToCustom` | text | Send to custom email address | — |
| `emailBcc` | text | BCC email address | — |
| `fromEmail` | text | From email address | — |
| `fromName` | text | From name | — |
| `replyToEmail` | text | Reply to email address | — |
| `emailContent` | textarea | Email content | — |
| `emailErrorMessage` | text | Error message | — |
| `htmlEmail` | checkbox | HTML email | — |
| `webhooks` | repeater | Endpoints | — |
| `webhookMaxSize` | number | Max payload size | — |
| `webhookRateLimit` | checkbox | Rate limiting | — |
| `webhookRateLimitRequests` | number | Max requests per hour | — |
| `webhookErrorIgnore` | checkbox | Continue on error | — |
| `webhookErrorMessage` | text | Error message | — |
| `confirmationEmailSubject` | text | Subject | — |
| `confirmationEmailTo` | text | Send to email address | — |
| `confirmationFromEmail` | text | From email address | — |
| `confirmationFromName` | text | From name | — |
| `confirmationReplyToEmail` | text | Reply to email address | — |
| `confirmationEmailContent` | textarea | Email content | — |
| `confirmationEmailHTML` | checkbox | HTML email | — |
| `redirectAdminUrl` | checkbox | Redirect to admin area | — |
| `redirect` | text | Custom redirect URL | — |
| `redirectTimeout` | number | Redirect after (ms) | — |
| `mailchimpDoubleOptIn` | checkbox | Double opt-in | — |
| `mailchimpList` | select | List | — |
| `mailchimpGroups` | select | Groups | — |
| `mailchimpEmail` | select | Field | — |
| `mailchimpFirstName` | select | First name | — |
| `mailchimpLastName` | select | Last name | — |
| `mailchimpPendingMessage` | text | Pending message | — |
| `mailchimpErrorMessage` | text | Error message | — |
| `sendgridList` | select | List | — |
| `sendgridEmail` | select | Field | — |
| `sendgridFirstName` | select | Field | — |
| `sendgridLastName` | select | Field | — |
| `sendgridPendingMessage` | text | Pending message | — |
| `sendgridErrorMessage` | text | Error message | — |
| `loginName` | select | Field | — |
| `loginPassword` | select | Field | — |
| `loginRemember` | select | Field | — |
| `loginErrorMessage` | text | Error message | — |
| `registrationEmail` | select | Field | — |
| `registrationPassword` | select | Field | — |
| `registrationPasswordMinLength` | number | Password min. length | — |
| `registrationUserName` | select | Field | — |
| `registrationFirstName` | select | Field | — |
| `registrationLastName` | select | Field | — |
| `registrationRole` | select | Role | — |
| `registrationAutoLogin` | checkbox | Auto log in user | — |
| `registrationWPNotification` | checkbox | Send WordPress notification | — |
| `lostPasswordEmailUsername` | select | Field | — |
| `resetPasswordNew` | select | Field | — |
| `createPostType` | select | Post type | — |
| `createPostErrorMessage` | text | Error message | — |
| `createPostDisableCapabilityCheck` | checkbox | Disable capability checks | — |
| `createPostTitle` | select | Post title | — |
| `createPostContent` | select | Post content | — |
| `createPostExcerpt` | select | Post excerpt | — |
| `createPostFeaturedImage` | select | Featured image | — |
| `createPostStatus` | select | Post status | — |
| `createPostMeta` | repeater | Post meta | — |
| `createPostTaxonomies` | repeater | Taxonomies | — |
| `updatePostId` | select | Post to update | — |
| `updatePostErrorMessage` | text | Error message | — |
| `updatePostDisableCapabilityCheck` | checkbox | Disable capability checks | — |
| `updatePostTitle` | select | Post title | — |
| `updatePostContent` | select | Post content | — |
| `updatePostExcerpt` | select | Post excerpt | — |
| `updatePostFeaturedImage` | select | Featured image | — |
| `updatePostStatus` | select | Post status | — |
| `updatePostMeta` | repeater | Post meta | — |
| `updatePostTaxonomies` | repeater | Taxonomies | — |
| `enableRecaptcha` | checkbox | reCAPTCHA (Google) | — |
| `enableTurnstile` | checkbox | Turnstile (Cloudflare) | — |
| `turnstileSize` | select | Turnstile:  | — |
| `turnstileTheme` | select | Turnstile:  | — |
| `turnstileLabel` | text | Turnstile:  | — |
| `enableHCaptcha` | select | hCaptcha | — |
| `hCaptchaSize` | select | hCaptcha:  | — |
| `hCaptchaTheme` | select | hCaptcha:  | — |
| `submissionFormName` | text | Form name | — |
| `submissionSaveIp` | checkbox | Save IP address | — |
| `submissionMaxEntries` | number | Max. entries | — |
| `submissionMaxEntriesErrorMessage` | text | Error message | — |
| `submissionDupEntries` | repeater | Compare with | — |
| `submissionDupEntriesErrorMessage` | text | Error message | — |
| `passwordProtectionPassword` | select | Field | — |
| `passwordProtectionErrorMessage` | text | Error message | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Heading Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/heading/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | heading |
| `category` | basic |
| `tag` | h3 |
| `nestable` | false |

<SchemaJson path="elements/heading.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `text` | text | text | — |
| `tag` | select | HTML tag | — |
| `customTag` | text | Custom tag | — |
| `type` | select | Type | — |
| `style` | select | Style | — |
| `link` | link | Link to | — |
| `separator` | select | Separator | — |
| `separatorWidth` | number | Width | `width` on `.separator`, `flex-grow` on `.separator`, `width` |
| `separatorHeight` | number | Height | `border-top-width` on `.separator`, `height` on `.separator` |
| `separatorSpacing` | number | Spacing | `gap` on `&.has-separator` |
| `separatorStyle` | select | Style | `border-top-style` on `.separator` |
| `separatorAlignItems` | align-items | Align | `align-items` on `&.has-separator` |
| `separatorColor` | color | Color | `border-top-color` on `.separator` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## HTML Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/html/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | html |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/html.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `html` | code | Raw HTML | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Icon Box Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/icon-box/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | icon-box |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/icon-box.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `direction` | direction | Direction | `flex-direction` |
| `gap` | number | Spacing | `gap` |
| `icon` | icon | Icon | — |
| `verticalAlign` | align-items | Align | `align-self` on `.icon` |
| `link` | link | Link | — |
| `iconMargin` | spacing | Margin | `margin` on `.icon` |
| `iconPadding` | spacing | Padding | `padding` on `.icon` |
| `iconSize` | number | Size | `font-size` on `.icon i` |
| `iconHeight` | number | Height | `height` on `.icon`, `line-height` on `.icon` |
| `iconWidth` | number | Width | `min-width` on `.icon` |
| `iconColor` | color | Color | `color` on `.icon`, `color` on `.icon a` |
| `iconBackgroundColor` | color | Background color | `background-color` on `.icon` |
| `iconBorder` | border | Border | `border` on `.icon` |
| `iconBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.icon` |
| `content` | editor | content | — |
| `contentMargin` | spacing | Margin | `margin` on `.content` |
| `contentPadding` | spacing | Padding | `padding` on `.content` |
| `contentAlign` | align-items | Align | `align-self` on `.content` |
| `typographyHeading` | typography | Heading typography | `font` on `h1`, `font` on `h2`, `font` on `h3`, `font` on `h4`, `font` on `h5`, `font` on `h6` |
| `typographyBody` | typography | Body typography | `font` on `.content` |
| `contentBackgroundColor` | color | Background | `background-color` on `.content` |
| `contentBorder` | border | Border | `border` on `.content` |
| `contentBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.content` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Icon Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/icon/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | icon |
| `category` | basic |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/icon.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `icon` | icon | Icon | — |
| `iconColor` | color | Color | `color`, `fill` |
| `iconSize` | number | Size | `font-size` |
| `link` | link | Link | — |
| `isAccordionIcon` | checkbox | Is | — |
| `accordionTitleIconState` | select | Show | — |
| `accordionTitleIconTransform` | transform | Transform | `--brx-icon-transform` |
| `accordionTitleIconTransition` | text | Transition | `transition` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Image Gallery Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/image-gallery/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | image-gallery |
| `category` | media |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/image-gallery.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `items` | image-gallery | Images | — |
| `layout` | select | Layout | — |
| `columns` | number | Columns | `--columns` |
| `gutter` | number | Spacing | `--gutter` |
| `imageHeight` | number | Image height | `height` on `.image` |
| `imageRatio` | text | Image ratio | `aspect-ratio` on `.image` |
| `caption` | checkbox | Image caption | — |
| `link` | select | Link to | — |
| `linkCustom` | repeater | Custom links | — |
| `lightboxImageSize` | select | Image size | — |
| `lightboxImageClick` | select | Image click action | — |
| `lightboxAnimationType` | select | Animation | — |
| `lightboxCaption` | checkbox | Caption | — |
| `lightboxThumbnails` | checkbox | Thumbnail navigation | — |
| `lightboxThumbnailSize` | number | Thumbnail size | — |
| `lightboxPadding` | dimensions | Padding | — |
| `lightboxId` | text | Lightbox | — |
| `fetchpriorityAttribute` | select | Fetch priority | — |
| `loadingAttribute` | select | Loading | — |
| `loadMoreInitial` | number | Initial items | — |
| `loadMoreStep` | number | Items per load | — |
| `loadMoreInfiniteScroll` | checkbox | Infinite scroll | — |
| `loadMoreInfiniteScrollDelay` | number | Infinite scroll delay | — |
| `loadMoreInfiniteScrollOffset` | number | Infinite scroll offset | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Image Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/image/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | image |
| `category` | basic |
| `tag` | figure |
| `nestable` | false |

<SchemaJson path="elements/image.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `image` | image | image | — |
| `tag` | select | HTML tag | — |
| `customTag` | text | Custom tag | — |
| `sources` | repeater | Sources | — |
| `altText` | text | Custom alt text | — |
| `caption` | select | Caption type | — |
| `captionCustom` | text | Custom caption | — |
| `loading` | select | Loading | — |
| `showTitle` | checkbox | Show title | — |
| `stretch` | checkbox | Stretch | `width` |
| `link` | select | link | — |
| `lightboxImageSize` | select | Image size | — |
| `lightboxWidth` | number | Width | — |
| `lightboxHeight` | number | Height | — |
| `lightboxAnimationType` | select | Animation | — |
| `lightboxCaption` | checkbox | Caption | — |
| `lightboxId` | text | ID | — |
| `lightboxCropped` | checkbox | Cropped | — |
| `lightboxPadding` | dimensions | Padding | — |
| `newTab` | checkbox | Open in new tab | — |
| `url` | link | url | — |
| `lightboxAriaLabel` | text | aria-label | — |
| `lightboxTitle` | text | title | — |
| `popupIconDisable` | checkbox | Disable icon | — |
| `popupIcon` | icon | Icon | — |
| `popupIconBackgroundColor` | color | Icon background color | `background-color` on `&\{pseudo\} .icon` |
| `popupIconBorder` | border | Icon border | `border` on `&\{pseudo\} .icon` |
| `popupIconBoxShadow` | box-shadow | Icon box shadow | `box-shadow` on `&\{pseudo\} .icon` |
| `popupIconTypography` | typography | Icon typography | `font` on `&\{pseudo\} .icon` |
| `popupIconHeight` | number | Icon height | `line-height` on `&\{pseudo\} .icon` |
| `popupIconWidth` | number | Icon width | `width` on `&\{pseudo\} .icon` |
| `popupIconTransition` | text | Icon transition | `transition` on `&\{pseudo\} .icon` |
| `mask` | select | Mask | — |
| `maskCustom` | image | maskCustom | — |
| `maskSize` | select | Size | — |
| `maskSizeCustom` | number | Custom size | — |
| `maskPosition` | select | Position | — |
| `maskRepeat` | select | Repeat | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Instagram Feed Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/instagram-feed/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | instagram-feed |
| `category` | media |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/instagram-feed.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `columns` | number | Columns | `grid-template-columns` on `ul` |
| `numberOfPosts` | number | Posts | — |
| `imageObjectFit` | select | Object fit | `object-fit` on `img` |
| `imageAspectRatio` | text | Aspect ratio | `aspect-ratio` on `img` |
| `imageHeight` | number | Height | `height` on `img` |
| `imageWidth` | number | Width | `width` on `img` |
| `imageGap` | number | Gap | `gap` on `ul` |
| `imageBorder` | border | Border | `border` on `img` |
| `imageLink` | checkbox | Link | — |
| `carouselIcon` | icon | Icon | — |
| `carouselIconColor` | color | Icon color | `color` on `.brx-icon.carousel` |
| `carouselIconSize` | number | Icon size | `height` on `.brx-icon.carousel svg`, `width` on `.brx-icon.carousel svg`, `font-size` on `.brx-icon.carousel` |
| `carouselIconPosition` | dimensions | Icon position | — |
| `videoIcon` | icon | Icon | — |
| `videoIconColor` | color | Icon color | `color` on `.brx-icon.video` |
| `videoIconSize` | number | Icon size | `height` on `.brx-icon.video svg`, `width` on `.brx-icon.video svg`, `font-size` on `.brx-icon.video` |
| `videoIconPosition` | dimensions | Icon position | — |
| `caption` | checkbox | Enable | — |
| `captionBackground` | color | Background color | `background-color` on `.caption` |
| `captionBorder` | border | Border | `border` on `.caption` |
| `captionTypography` | typography | Typography | `font` on `.caption` |
| `followText` | text | Text | — |
| `followPosition` | select | Position | — |
| `followIcon` | icon | Icon | `—` on `.follow-icon` |
| `followTypography` | typography | Typography | `font` on `.follow` |
| `cacheDuration` | select | Duration | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## List Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/list/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | list |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/list.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `items` | repeater | List items | — |
| `itemJustifyContent` | justify-content | Justify content | `justify-content` on `.content`, `justify-content` on `.description` |
| `itemAlignItems` | align-items | Align items | `align-items` on `.content`, `align-items` on `.description` |
| `itemMargin` | spacing | Margin | `margin` on `li` |
| `itemPadding` | spacing | Padding | `padding` on `li` |
| `itemOddBackground` | color | Odd background | `background-color` on `li:nth-child(odd)` |
| `itemEvenBackground` | color | Even background | `background-color` on `li:nth-child(even)` |
| `itemBorder` | border | Border | `border` on `li` |
| `itemAutoWidth` | checkbox | Auto width | `justify-content` on `.content`, `flex-grow` on `.separator` |
| `highlightBlock` | checkbox | Block | `display` on `li[data-highlight]::before` |
| `highlightLabelPadding` | spacing | Padding | `padding` on `li[data-highlight]::before` |
| `highlightLabelBackground` | color | Background | `background-color` on `li[data-highlight]::before` |
| `highlightLabelBorder` | border | Border | `border` on `li[data-highlight]::before` |
| `highlightLabelTypography` | typography | Typography | `font` on `li[data-highlight]::before` |
| `highlightContentPadding` | spacing | Padding | `padding` on `li[data-highlight] .content` |
| `highlightContentBackground` | color | Background | `background-color` on `li[data-highlight] .content` |
| `highlightContentBorder` | border | Border | `border` on `li[data-highlight] .content` |
| `highlightContentColor` | color | Text color | `color` on `li[data-highlight] .content .title`, `color` on `li[data-highlight] .content .meta`, `color` on `li[data-highlight] .content .description` |
| `icon` | icon | Icon | — |
| `iconAfterTitle` | checkbox | After title | — |
| `iconWidth` | number | Width | `width` on `.icon` |
| `iconHeight` | number | Height | `height` on `.icon` |
| `iconSize` | number | Size | `font-size` on `.icon`, `height` on `.icon svg`, `width` on `.icon svg` |
| `iconColor` | color | Color | `color` on `.icon` |
| `iconBackgroundColor` | color | Background color | `background-color` on `.icon` |
| `iconBorder` | border | Border | `border` on `.icon` |
| `iconBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.icon` |
| `titleMargin` | spacing | Margin | `margin` on `.title` |
| `titleTag` | text | HTML tag | — |
| `titleTypography` | typography | Typography | `font` on `.title` |
| `metaMargin` | spacing | Margin | `margin` on `.meta` |
| `metaTypography` | typography | Typography | `font` on `.meta` |
| `descriptionTypography` | typography | Typography | `font` on `.description` |
| `separatorDisable` | checkbox | Disable | `display` on `.separator` |
| `separatorStyle` | select | Style | `border-top-style` on `.separator` |
| `separatorWidth` | number | Width | `flex-basis` on `.separator`, `flex-grow` on `.separator` |
| `separatorHeight` | number | Height | `border-top-width` on `.separator` |
| `separatorColor` | color | Color | `border-top-color` on `.separator` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Logo Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/logo/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | logo |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/logo.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `logo` | image | Logo | — |
| `logoInverse` | image | Logo inverse | — |
| `logoHeight` | number | Height | `height` on `.bricks-site-logo` |
| `logoWidth` | number | Width | `width` on `.bricks-site-logo` |
| `logoText` | text | Text | — |
| `logoLoading` | select | Loading | — |
| `logoUrl` | link | Link to | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Map Connector Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/map-connector/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | map-connector |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/map-connector.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `latitude` | text | Latitude | — |
| `longitude` | text | Longitude | — |
| `address` | text | Address | — |
| `infoBoxTemplateId` | select | Info Box | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Map (Leaflet) Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/map-leaflet/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | map-leaflet |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/map-leaflet.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `layers` | repeater | Name | — |
| `markers` | repeater | Coordinates | — |
| `markerIcon` | image | Icon | — |
| `markerIconHeight` | number | Icon | — |
| `markerIconWidth` | number | Icon | — |
| `height` | number | Height | `height` |
| `center` | text | Map center | — |
| `zoom` | number | Zoom level | — |
| `minZoom` | number | Zoom level | — |
| `maxZoom` | number | Zoom level | — |
| `zoomSnap` | number | Zoom | — |
| `zoomDelta` | number | Zoom | — |
| `doubleClickZoom` | select | Zoom | — |
| `scrollWheelZoom` | select | Zoom | — |
| `boxZoom` | checkbox | Box Zoom | — |
| `zoomControl` | checkbox | Zoom Control | — |
| `attributionControl` | checkbox | Attribution Control | — |
| `closePopupOnClick` | checkbox | Close popup on click | — |
| `dragging` | checkbox | Dragging | — |
| `trackResize` | checkbox | Track resize | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Map (Google) Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/map/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | map |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/map.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `address` | text | Address | — |
| `addresses` | repeater | Addresses | — |
| `infoBoxTemplateId` | select | Info Box | — |
| `syncQuery` | query-list | syncQuery | — |
| `mapNoResultsText` | text | Text | — |
| `markerCluster` | checkbox | Cluster | — |
| `markerClusterBgColor` | color | Cluster | `fill` on `.brx-map-cluster` |
| `markerClusterTextColor` | color | Cluster | `fill` on `.brx-map-cluster text` |
| `markerType` | select | Type | — |
| `googleMapId` | text | Map ID | — |
| `mapCenterLat` | text | Latitude | — |
| `mapCenterLng` | text | Longitude | — |
| `mapCenterAddress` | text | Address | — |
| `localization` | checkbox | Use page locale | — |
| `height` | number | Height | `height` |
| `zoom` | number | Zoom level | — |
| `type` | select | Map type | — |
| `loading` | select | Loading | — |
| `style` | select | Map style | — |
| `customStyle` | code | Custom map style | — |
| `fitMapOnMarkersChange` | checkbox | Fit map on markers change | — |
| `scrollwheel` | checkbox | Scroll | — |
| `draggable` | checkbox | Draggable | — |
| `fullscreenControl` | checkbox | Fullscreen Control | — |
| `mapTypeControl` | checkbox | Map Type Control | — |
| `streetViewControl` | checkbox | Street View Control | — |
| `disableDefaultUI` | checkbox | Disable Default UI | — |
| `disableClickPOI` | checkbox | Disable clickable POI | — |
| `zoomControl` | checkbox | Zoom Control | — |
| `minZoom` | number | Zoom level | — |
| `maxZoom` | number | Zoom level | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Nav Menu Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/nav-menu/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | nav-menu |
| `category` | wordpress |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/nav-menu.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `menu` | select | Menu | — |
| `menuAlignment` | direction | Alignment | `flex-direction` on `.bricks-nav-menu` |
| `menuJustifyContent` | justify-content | Justify content | `justify-content` on `.bricks-nav-menu > li > a`, `justify-content` on `.bricks-nav-menu > li > .brx-submenu-toggle` |
| `menuGap` | number | Gap | `gap` on `.bricks-nav-menu` |
| `menuMargin` | spacing | Margin | `margin` on `.bricks-nav-menu > li` |
| `menuPadding` | spacing | Padding | `padding` on `.bricks-nav-menu > li > a`, `padding` on `.bricks-nav-menu > li > .brx-submenu-toggle > *` |
| `menuBackground` | background | Background | `background` on `.bricks-nav-menu > li\{pseudo\} > a`, `background` on `.bricks-nav-menu > li\{pseudo\} > .brx-submenu-toggle` |
| `menuBorder` | border | Border | `border` on `.bricks-nav-menu > li\{pseudo\} > a`, `border` on `.bricks-nav-menu > li\{pseudo\} > .brx-submenu-toggle` |
| `menuTypography` | typography | Typography | `font` on `.bricks-nav-menu > li\{pseudo\} > a`, `font` on `.bricks-nav-menu > li\{pseudo\} > .brx-submenu-toggle > *` |
| `menuActiveBackground` | background | Active background | `background` on `.bricks-nav-menu > .current-menu-item > a`, `background` on `.bricks-nav-menu > .current-menu-item > .brx-submenu-toggle`, `background` on `.bricks-nav-menu > .current-menu-parent > a`, `background` on `.bricks-nav-menu > .current-menu-parent > .brx-submenu-toggle`, `background` on `.bricks-nav-menu > .current-menu-ancestor > a`, `background` on `.bricks-nav-menu > .current-menu-ancestor > .brx-submenu-toggle` |
| `menuActiveBorder` | border | Active border | `border` on `.bricks-nav-menu .current-menu-item > a`, `border` on `.bricks-nav-menu .current-menu-item > .brx-submenu-toggle`, `border` on `.bricks-nav-menu > .current-menu-parent > a`, `border` on `.bricks-nav-menu > .current-menu-parent > .brx-submenu-toggle`, `border` on `.bricks-nav-menu > .current-menu-ancestor > a`, `border` on `.bricks-nav-menu > .current-menu-ancestor > .brx-submenu-toggle` |
| `menuActiveTypography` | typography | Active typography | `font` on `.bricks-nav-menu .current-menu-item > a`, `font` on `.bricks-nav-menu .current-menu-item > .brx-submenu-toggle > *`, `font` on `.bricks-nav-menu > .current-menu-parent > a`, `font` on `.bricks-nav-menu > .current-menu-parent > .brx-submenu-toggle > *`, `font` on `.bricks-nav-menu > .current-menu-ancestor > a`, `font` on `.bricks-nav-menu > .current-menu-ancestor > .brx-submenu-toggle > *` |
| `menuIcon` | icon | Icon | `—` on `.bricks-nav-menu > li.menu-item > .brx-submenu-toggle svg` |
| `menuIconTransform` | transform | Icon transform | `transform` on `.bricks-nav-menu button[aria-expanded="false"] > *` |
| `menuIconTransformOpen` | transform | Icon transform | `transform` on `.bricks-nav-menu button[aria-expanded="true"] > *` |
| `menuIconTypography` | typography | Icon typography | `font` on `.bricks-nav-menu > li.menu-item-has-children > .brx-submenu-toggle\{pseudo\} button[aria-expanded]` |
| `menuIconPosition` | select | Icon position | — |
| `menuIconMargin` | spacing | Icon margin | `margin` on `.bricks-nav-menu .brx-submenu-toggle button` |
| `menuIconPadding` | spacing | Icon padding | `padding` on `.bricks-nav-menu .brx-submenu-toggle button` |
| `submenuStatic` | checkbox | Position | — |
| `subMenuBackgroundList` | background | Background | `background` on `.bricks-nav-menu .sub-menu` |
| `subMenuBorder` | border | Border | `border` on `.bricks-nav-menu .sub-menu` |
| `subMenuBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.bricks-nav-menu .sub-menu` |
| `subMenuTransform` | transform | Transform | `transform` on `.bricks-nav-menu > li > .sub-menu`, `transform` on `.bricks-nav-menu > li > .brx-megamenu` |
| `subMenuTransformOpen` | transform | Transform | `transform` on `.bricks-nav-menu > li.open > .sub-menu`, `transform` on `.bricks-nav-menu > li.open > .brx-megamenu` |
| `caretSize` | number | Size | `border-width` |
| `caretColor` | color | Color | `border-bottom-color` |
| `caretTransform` | transform | Transform | `transform` |
| `caretPosition` | dimensions | Position | — |
| `subMenuJustifyContent` | justify-content | Justify content | `justify-content` on `.bricks-nav-menu .sub-menu a`, `justify-content` on `.bricks-nav-menu .sub-menu button` |
| `subMenuPadding` | spacing | Padding | `padding` on `.bricks-nav-menu .sub-menu a`, `padding` on `.bricks-nav-menu .sub-menu button` |
| `subMenuBackground` | background | Background | `background` on `.bricks-nav-menu .sub-menu .menu-item` |
| `subMenuItemBorder` | border | Border | `border` on `.bricks-nav-menu .sub-menu > li` |
| `subMenuTypography` | typography | Typography | `font` on `.bricks-nav-menu .sub-menu > li\{pseudo\} > a`, `font` on `.bricks-nav-menu .sub-menu > li\{pseudo\} > .brx-submenu-toggle > *` |
| `subMenuActiveBackground` | background | Active background | `background` on `.bricks-nav-menu .sub-menu > .current-menu-item > a`, `background` on `.bricks-nav-menu .sub-menu > .current-menu-item > .brx-submenu-toggle`, `background` on `.bricks-nav-menu .sub-menu > .current-menu-ancestor > a`, `background` on `.bricks-nav-menu .sub-menu > .current-menu-ancestor > .brx-submenu-toggle` |
| `subMenuActiveBorder` | border | Active border | `border` on `.bricks-nav-menu .sub-menu > .current-menu-item > a`, `border` on `.bricks-nav-menu .sub-menu > .current-menu-item > .brx-submenu-toggle`, `border` on `.bricks-nav-menu .sub-menu > .current-menu-ancestor > a`, `border` on `.bricks-nav-menu .sub-menu > .current-menu-ancestor > .brx-submenu-toggle` |
| `subMenuActiveTypography` | typography | Active typography | `font` on `.bricks-nav-menu .sub-menu > .current-menu-item > a`, `font` on `.bricks-nav-menu .sub-menu > .current-menu-item > .brx-submenu-toggle > *`, `font` on `.bricks-nav-menu .sub-menu > .current-menu-ancestor > a`, `font` on `.bricks-nav-menu .sub-menu > .current-menu-ancestor > .brx-submenu-toggle > *` |
| `subMenuIcon` | icon | Icon | `—` on `.bricks-nav-menu .sub-menu .brx-submenu-toggle\{pseudo\} svg` |
| `subMenuIconSize` | number | Icon size | `height` on `.bricks-nav-menu .sub-menu .brx-submenu-toggle svg`, `width` on `.bricks-nav-menu .sub-menu .brx-submenu-toggle svg`, `font-size` on `.bricks-nav-menu .sub-menu .brx-submenu-toggle i` |
| `subMenuIconTransform` | transform | Icon transform | `transform` on `.bricks-nav-menu .sub-menu button > *` |
| `subMenuIconTransformOpen` | transform | Icon transform | `transform` on `.bricks-nav-menu .sub-menu button[aria-expanded="true"] > *` |
| `subMenuIconTypography` | typography | Icon typography | `font` on `.bricks-nav-menu .sub-menu .brx-submenu-toggle > a\{pseudo\} + button` |
| `subMenuIconPosition` | select | Icon position | — |
| `subMenuIconMargin` | spacing | Icon margin | `margin` on `.bricks-nav-menu .sub-menu .brx-submenu-toggle button` |
| `subMenuIconPadding` | spacing | Icon padding | `padding` on `.bricks-nav-menu .sub-menu .brx-submenu-toggle button` |
| `mobileMenu` | select | mobileMenu | — |
| `mobileMenuCustomBreakpoint` | number | Custom breakpoint | — |
| `mobileMenuPosition` | select | Position | — |
| `mobileMenuTop` | number | Top | `top` on `.bricks-mobile-menu-wrapper` |
| `mobileMenuWidth` | number | Width | `width` on `.bricks-mobile-menu-wrapper` |
| `mobileMenuHeight` | number | Height | `height` on `.bricks-mobile-menu-wrapper` |
| `mobileMenuFadeIn` | checkbox | Fade in | — |
| `mobileMenuAlignment` | justify-content | Vertical | `justify-content` on `.bricks-mobile-menu-wrapper` |
| `mobileMenuAlignItems` | align-items | Horizontal | `align-items` on `.bricks-mobile-menu-wrapper`, `justify-content` on `.bricks-mobile-menu-wrapper .brx-submenu-toggle`, `width` on `.bricks-mobile-menu-wrapper a` |
| `mobileMenuTextAlign` | text-align | Text align | `text-align` on `.bricks-mobile-menu-wrapper` |
| `mobileMenuBackground` | background | Background | `background` on `.bricks-mobile-menu-wrapper:before` |
| `mobileMenuBackgroundFilters` | filters | Background filters | `filter` on `.bricks-mobile-menu-wrapper:before` |
| `mobileMenuBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.bricks-mobile-menu-wrapper:before` |
| `mobileMenuOverlay` | background | Overlay | `background` on `.bricks-mobile-menu-overlay` |
| `mobileMenuPadding` | spacing | Padding | `padding` on `.bricks-mobile-menu > li > a`, `padding` on `.bricks-mobile-menu > li > .brx-submenu-toggle > *` |
| `mobileMenuItemBackground` | color | Background | `background-color` on `.bricks-mobile-menu > li > a`, `background-color` on `.bricks-mobile-menu > li > .brx-submenu-toggle` |
| `mobileMenuItemBackgroundActive` | color | Background | `background-color` on `.bricks-mobile-menu > li > a[aria-current="page"]`, `background-color` on `.bricks-mobile-menu > .current-menu-item > .brx-submenu-toggle` |
| `mobileMenuBorder` | border | Border | `border` on `.bricks-mobile-menu > li > a`, `background-color` on `.bricks-mobile-menu > li > .brx-submenu-toggle` |
| `mobileMenuActiveBorder` | border | Border | `border` on `.bricks-mobile-menu > .current-menu-item > a`, `border` on `.bricks-mobile-menu > .current-menu-item > .brx-submenu-toggle`, `border` on `.bricks-mobile-menu > .current-menu-ancestor > .brx-submenu-toggle` |
| `mobileMenuTypography` | typography | Typography | `font` on `.bricks-mobile-menu > li > a`, `font` on `.bricks-mobile-menu > li > .brx-submenu-toggle > *` |
| `mobileMenuActiveTypography` | typography | Typography | `font` on `.bricks-mobile-menu [aria-current="page"]`, `font` on `.bricks-mobile-menu [aria-current="page"] + button`, `font` on `.bricks-mobile-menu > .current-menu-item > a`, `font` on `.bricks-mobile-menu > .current-menu-parent > a`, `font` on `.bricks-mobile-menu > .current-menu-item > .brx-submenu-toggle > *`, `font` on `.bricks-mobile-menu > .current-menu-parent > .brx-submenu-toggle > *` |
| `mobileMenuIcon` | icon | Icon | `—` on `.bricks-mobile-menu-wrapper .brx-submenu-toggle svg` |
| `mobileMenuCloseIcon` | icon | Close icon | `—` on `.bricks-mobile-menu-wrapper .brx-submenu-toggle svg.close` |
| `mobileMenuIconTypography` | typography | Icon typography | `font` on `.bricks-mobile-menu > .menu-item-has-children .brx-submenu-toggle button` |
| `mobileMenuIconPosition` | select | Icon position | — |
| `mobileMenuIconMargin` | spacing | Icon margin | `margin` on `.bricks-mobile-menu .menu-item-has-children .brx-submenu-toggle button` |
| `mobileSubMenuPadding` | spacing | Padding | `padding` on `.bricks-mobile-menu .sub-menu > .menu-item > a`, `padding` on `.bricks-mobile-menu .sub-menu > .menu-item > .brx-submenu-toggle > *` |
| `mobileSubMenuItemBackground` | color | Background | `background-color` on `.bricks-mobile-menu .sub-menu > .menu-item > a`, `background-color` on `.bricks-mobile-menu .sub-menu > .menu-item > .brx-submenu-toggle` |
| `mobileSubMenuItemBackgroundActive` | color | Background | `background-color` on `.bricks-mobile-menu .sub-menu > .menu-item > a[aria-current="page"]`, `background-color` on `.bricks-mobile-menu .sub-menu .current-menu-item > .brx-submenu-toggle` |
| `mobileSubMenuBorder` | border | Border | `border` on `.bricks-mobile-menu .sub-menu > .menu-item` |
| `mobileSubMenuBorderActive` | border | Border | `border` on `.bricks-mobile-menu .sub-menu > .current-menu-item > a`, `border` on `.bricks-mobile-menu .sub-menu > .current-menu-item > .brx-submenu-toggle`, `border` on `.bricks-mobile-menu .sub-menu > .current-menu-ancestor > .brx-submenu-toggle` |
| `mobileSubMenuTypography` | typography | Typography | `font` on `.bricks-mobile-menu .sub-menu > li > a`, `font` on `.bricks-mobile-menu .sub-menu > li > .brx-submenu-toggle > *` |
| `mobileSubMenuActiveTypography` | typography | Active typography | `font` on `.bricks-mobile-menu .sub-menu > .current-menu-item > a`, `font` on `.bricks-mobile-menu .sub-menu > .current-menu-item > .brx-submenu-toggle > *` |
| `mobileMenuToggleAriaLabel` | text | aria-label | — |
| `mobileMenuToggleWidth` | number | Toggle width | `width` on `.bricks-mobile-menu-toggle`, `width` on `.bricks-mobile-menu-toggle .bar-top`, `width` on `.bricks-mobile-menu-toggle .bar-center`, `width` on `.bricks-mobile-menu-toggle .bar-bottom` |
| `mobileMenuToggleColor` | color | Color | `color` on `.bricks-mobile-menu-toggle` |
| `mobileMenuToggleHide` | checkbox | Hide close | `display` on `&.show-mobile-menu .bricks-mobile-menu-toggle` |
| `mobileMenuToggleColorClose` | color | Color close | `color` on `&.show-mobile-menu .bricks-mobile-menu-toggle` |
| `mobileMenuToggleClosePosition` | dimensions | Close position | `—` on `&.show-mobile-menu .bricks-mobile-menu-toggle` |
| `megaMenu` | checkbox | Enable | — |
| `megaMenuSelector` | text | CSS selector | — |
| `megaMenuToggleOn` | select | Toggle on | — |
| `megaMenuTransition` | text | Transition | `transition` on `.brx-megamenu` |
| `megaMenuTransform` | transform | Transform | `transform` on `.bricks-nav-menu > .brx-has-megamenu > .brx-megamenu` |
| `megaMenuTransformOpen` | transform | Transform | `transform` on `.bricks-nav-menu > .brx-has-megamenu.open > .brx-megamenu`, `transform` on `.bricks-nav-menu > .brx-has-megamenu.open > .brx-megamenu` |
| `multiLevel` | checkbox | Enable | — |
| `multiLevelBackText` | text | Back | — |
| `multiLevelBackTypography` | typography | Back | `font` on `.brx-multilevel-back` |
| `multiLevelBackground` | color | Back | `background-color` on `.brx-multilevel-back` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Nav (Nestable) Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/nav-nested/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | nav-nested |
| `category` | general |
| `tag` | nav |
| `nestable` | true |

<SchemaJson path="elements/nav-nested.json" />

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Offcanvas Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/offcanvas/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | offcanvas |
| `category` | general |
| `tag` | div |
| `nestable` | true |

<SchemaJson path="elements/offcanvas.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `direction` | select | Direction | — |
| `effect` | select | Effect | — |
| `closeOn` | select | Close on | — |
| `width` | number | Width | `width` on `&[data-direction] .brx-offcanvas-inner` |
| `height` | number | Height | `height` on `&[data-direction] .brx-offcanvas-inner` |
| `transitionDuration` | number | Transition | `transition-duration` on `.brx-offcanvas-inner, .brx-offcanvas-backdrop` |
| `transitionTimingFunction` | text | Transition | `transition-timing-function` on `.brx-offcanvas-inner, .brx-offcanvas-backdrop` |
| `ariaLabel` | text | aria-label | — |
| `noScrollBody` | checkbox | No scroll | — |
| `scrollToTop` | checkbox | Scroll to top | — |
| `noAutoFocus` | checkbox | Disable auto focus | — |
| `openByDefault` | checkbox | Open on page load | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Pagination Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/pagination/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | pagination |
| `category` | query |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/pagination.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `queryId` | query-list | Query | — |
| `justifyContent` | justify-content | Alignment | `justify-content` on `.bricks-pagination ul` |
| `navigationHeight` | number | Height | `height` on `.bricks-pagination ul .page-numbers` |
| `navigationWidth` | number | Width | `width` on `.bricks-pagination ul .page-numbers` |
| `gap` | number | Spacing | `gap` on `.bricks-pagination ul` |
| `navigationBackground` | color | Background | `background` on `.bricks-pagination ul .page-numbers` |
| `navigationBorder` | border | Border | `border` on `.bricks-pagination ul .page-numbers` |
| `navigationTypography` | typography | Typography | `font` on `.bricks-pagination ul .page-numbers` |
| `navigationBackgroundActive` | color | Background | `background` on `.bricks-pagination ul .page-numbers.current` |
| `navigationBorderActive` | border | Border | `border` on `.bricks-pagination ul .page-numbers.current` |
| `navigationTypographyActive` | typography | Typography | `font` on `.bricks-pagination ul .page-numbers.current` |
| `prevIcon` | icon | Previous Icon | — |
| `nextIcon` | icon | Next Icon | — |
| `endSize` | number | End Size | — |
| `midSize` | number | Mid Size | — |
| `ajax` | checkbox | Enable AJAX | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Pie Chart Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/pie-chart/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | pie-chart |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/pie-chart.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `percent` | number | Percentage | — |
| `size` | number | Chart size in px | `height` |
| `lineWidth` | number | Line width in px | — |
| `lineCap` | select | Line cap | — |
| `content` | select | Content | — |
| `icon` | icon | Icon | — |
| `text` | text | Text | — |
| `barColor` | color | Bar color | — |
| `trackColor` | color | Track color | — |
| `scaleLength` | number | Scale length in px | — |
| `scaleColor` | color | Scale color | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Author Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/post-author/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | post-author |
| `category` | single |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/post-author.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `avatar` | checkbox | Show avatar | — |
| `avatarSize` | number | Avatar size | `height` on `.avatar`, `width` on `.avatar` |
| `avatarPosition` | select | Avatar position | — |
| `avatarBorder` | border | Avatar border | `border` on `.avatar` |
| `avatarBoxShadow` | box-shadow | Avatar box shadow | `box-shadow` on `.avatar` |
| `name` | checkbox | Show name | — |
| `website` | checkbox | Link to website | — |
| `nameTypography` | typography | Typography | `font` on `.author-name` |
| `nameTag` | text | HTML tag | — |
| `bio` | checkbox | Show bio | — |
| `bioTypography` | typography | Typography | `font` on `.author-bio` |
| `postsLink` | checkbox | Show link to author posts | — |
| `postsPadding` | spacing | Padding | `padding` on `.bricks-button` |
| `postsText` | text | Text | — |
| `postsSize` | select | Size | — |
| `postsStyle` | select | Style | — |
| `postsBackgroundColor` | color | Background | `background-color` on `.bricks-button` |
| `postsBorder` | border | Border | `border` on `.bricks-button` |
| `postsTypography` | typography | Typography | `font` on `.bricks-button` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Comments Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/post-comments/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | post-comments |
| `category` | single |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/post-comments.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `source` | select | Source | — |
| `title` | checkbox | Show title | — |
| `titleTag` | select | HTML tag | — |
| `titleTypography` | typography | Typography | `font` on `.comments-title` |
| `avatar` | checkbox | Show avatar | — |
| `avatarSize` | number | Size | `margin-left` on `.depth-2`, `margin-left` on `.depth-3` |
| `avatarBorder` | border | Border | `border` on `.avatar` |
| `avatarBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.avatar` |
| `commentAuthorTag` | select | Author | — |
| `commentAuthorTypography` | typography | Author | `font` on `.comment-author .fn` |
| `commentMetaTypography` | typography | Meta | `font` on `.comment-meta` |
| `commentContentTypography` | typography | Content | `font` on `.comment-content` |
| `formTitle` | checkbox | Show | — |
| `formTitleTag` | select | HTML tag | — |
| `formTitleText` | text | Text | — |
| `label` | checkbox | Show | — |
| `labelTypography` | typography | Typography | `font` on `label` |
| `placeholderTypography` | typography | Placeholder typography | `font` on `::placeholder` |
| `cookies` | checkbox | Show | — |
| `cookiesRequired` | checkbox | Required | — |
| `cookiesText` | text | Text | — |
| `fieldKeys` | select | fieldKeys | — |
| `fieldBackgroundColor` | color | Background color | `background-color` on `.form-group input`, `background-color` on `.form-group textarea` |
| `fieldBorder` | border | Border | `border` on `.form-group input`, `border` on `.form-group textarea` |
| `fieldTypography` | typography | Typography | `font` on `.form-group input`, `font` on `.form-group textarea` |
| `fieldResize` | select | Textarea | `resize` on `.form-group textarea` |
| `submitButtonText` | text | Text | — |
| `submitButtonSize` | select | Size | — |
| `submitButtonStyle` | select | Style | — |
| `submitButtonBackgroundColor` | color | Background | `background-color` on `.bricks-button` |
| `submitButtonBorder` | border | Border | `border` on `.bricks-button` |
| `submitButtonTypography` | typography | Typography | `font` on `.bricks-button` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Post Content Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/post-content/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | post-content |
| `category` | single |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/post-content.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `dataSource` | select | Data source | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Excerpt Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/post-excerpt/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | post-excerpt |
| `category` | single |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/post-excerpt.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `length` | number | Excerpt length | — |
| `more` | text | More text | — |
| `keepHTML` | checkbox | Keep formatting | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Meta Data Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/post-meta/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | post-meta |
| `category` | single |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/post-meta.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `meta` | repeater | Dynamic data | — |
| `direction` | direction | Direction | `flex-direction` |
| `gutter` | number | Gap | `gap` |
| `separator` | text | Separator | — |
| `separatorColor` | color | Separator color | `color` on `.separator` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Post Navigation Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/post-navigation/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | post-navigation |
| `category` | single |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/post-navigation.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `postWidth` | number | Max. post width | `width` on `a` |
| `inSameTerm` | checkbox | In same term | — |
| `excludedTerms` | select | Excluded terms | — |
| `taxonomy` | select | Taxonomy | — |
| `label` | checkbox | Show label | — |
| `prevLabel` | text | Prev label | — |
| `nextLabel` | text | Next label | — |
| `labelTypography` | typography | Label typography | `font` on `.label` |
| `title` | checkbox | Show title | — |
| `titleTag` | text | Title tag | — |
| `titleTypography` | typography | Title typography | `font` on `.title` |
| `prevJustifyContent` | justify-content | Alignment | `justify-content` on `.prev-post` |
| `nextJustifyContent` | justify-content | Alignment | `justify-content` on `.next-post` |
| `image` | checkbox | Show image | — |
| `imageSize` | select | Size | — |
| `imageHeight` | number | Height | `height` on `.image` |
| `imageWidth` | number | Width | `width` on `.image` |
| `imageBorder` | border | Border | `border` on `.image` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Reading Progress Bar Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/post-reading-progress-bar/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | post-reading-progress-bar |
| `category` | single |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/post-reading-progress-bar.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `contentSelector` | text | Content selector | — |
| `barPosition` | select | Position | — |
| `barHeight` | number | Bar height | `height` |
| `barColor` | color | Bar color | `background-color` on `&::-webkit-progress-value`, `background-color` on `&::-moz-progress-bar` |
| `barBackgroundColor` | color | Bar background color | `background-color` on `&::-webkit-progress-bar`, `background-color` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Reading Time Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/post-reading-time/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | post-reading-time |
| `category` | single |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/post-reading-time.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `contentSelector` | text | Content selector | — |
| `prefix` | text | Prefix | — |
| `suffix` | text | Suffix | — |
| `calculationMethod` | select | Calculation method | — |
| `wordsPerMinute` | number | Words per minutes | — |
| `charactersPerMinute` | number | Characters per minute | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Social Sharing Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/post-sharing/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | post-sharing |
| `category` | single |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/post-sharing.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `items` | repeater | Share via | `background-color` on `a` |
| `brandColors` | checkbox | Use brand colors | — |
| `direction` | direction | Direction | `flex-direction` |
| `newTab` | checkbox | Open in new tab | — |
| `linkRel` | text | Rel attribute | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Taxonomy Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/post-taxonomy/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | post-taxonomy |
| `category` | single |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/post-taxonomy.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `taxonomy` | select | Taxonomy | — |
| `linkDisable` | checkbox | Disable link | — |
| `separator` | text | Separator | — |
| `orderby` | select | Order by | — |
| `order` | select | Order | — |
| `size` | select | Size | — |
| `style` | select | Style | — |
| `gap` | number | Spacing | `gap` |
| `icon` | icon | Icon | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Post Title Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/post-title/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | post-title |
| `category` | single |
| `tag` | h3 |
| `nestable` | false |

<SchemaJson path="elements/post-title.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `tag` | select | HTML tag | — |
| `type` | select | Type | — |
| `style` | select | Style | — |
| `linkToPost` | checkbox | Link to post | — |
| `context` | checkbox | Add context | — |
| `prefix` | text | Prefix | — |
| `prefixSpacing` | number | Spacing | `margin-inline-end` on `.post-prefix` |
| `prefixBlock` | checkbox | Block | `display` on `.post-prefix` |
| `prefixTypography` | typography | Typography | `font` on `.post-prefix` |
| `suffix` | text | Suffix | — |
| `suffixSpacing` | number | Spacing | `margin-inline-start` on `.post-suffix` |
| `suffixBlock` | checkbox | Block | `display` on `.post-suffix` |
| `suffixTypography` | typography | Typography | `font` on `.post-suffix` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Table Of Contents Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/post-toc/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | post-toc |
| `category` | single |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/post-toc.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `contentSelector` | text | Content selector | — |
| `headingSelectors` | text | Heading selectors | — |
| `ignoreSelector` | text | Ignore selector | — |
| `collapseInactive` | checkbox | Collapse inactive | — |
| `noWrap` | checkbox | No wrap | — |
| `sticky` | checkbox | Sticky | — |
| `stickyTop` | number | Top | `top` on `&[data-sticky]` |
| `headingsOffset` | number | Headings offset | — |
| `itemPadding` | spacing | Padding | `padding` on `.toc-list-item` |
| `itemBorder` | border | Border | `border` on `.toc-link::before` |
| `itemTypography` | typography | Typography | `font` on `.toc-link` |
| `itemBorderActive` | border | Border | `border` on `.toc-link.is-active-link::before` |
| `itemTypographyActive` | typography | Typography | `font` on `.toc-link.is-active-link` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Posts Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/posts/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | posts |
| `category` | wordpress |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/posts.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `query` | query | Query | — |
| `linkPost` | checkbox | Link entire post | — |
| `layout` | select | Layout | — |
| `direction` | direction | Direction | `flex-direction` on `.bricks-layout-wrapper[data-layout=list] .bricks-layout-inner` |
| `columns` | number | Columns | `--columns` on `.bricks-layout-wrapper` |
| `columnsMetro` | number | Columns | `grid-template-columns` on `.bricks-layout-wrapper`, `grid-column` on `.bricks-layout-item`, `grid-row` on `.bricks-layout-item` |
| `gutter` | number | Spacing | `--gutter` on `.bricks-layout-wrapper` |
| `firstPostFullWidth` | checkbox | First post full width | `grid-column` on `[data-layout="grid"] .bricks-layout-item:first-child`, `width` on `[data-layout="grid"] .bricks-layout-item:first-child` |
| `imageDisable` | checkbox | Disable image | — |
| `imageLink` | checkbox | Link image | — |
| `imageLinkAlt` | text | Image link alt text | — |
| `alternate` | checkbox | Alternate images | — |
| `imagePosition` | select | Image position | — |
| `width` | number | Image width | `max-width` on `.bricks-layout-wrapper[data-layout=list] .image-wrapper`, `max-width` on `.bricks-layout-wrapper[data-layout=grid] .image-wrapper`, `max-width` on `.bricks-layout-inner > a`, `max-width` on `.overlay-wrapper` |
| `height` | number | Image height | `height` on `.bricks-layout-wrapper[data-layout=list] img`, `height` on `.bricks-layout-wrapper[data-layout=grid] img`, `height` on `.overlay-wrapper` |
| `imageRatio` | text | Image ratio | `aspect-ratio` on `.image` |
| `imageSize` | select | Image size | — |
| `filter` | select | Taxonomy | — |
| `filterTextAlign` | text-align | Text align | `text-align` on `.bricks-isotope-filters` |
| `filterBackground` | color | Background | `background-color` on `.bricks-isotope-filters li` |
| `filterBackgroundActive` | color | Background active | `background` on `.bricks-isotope-filters .active` |
| `filterBorder` | border | Border | `border` on `.bricks-isotope-filters li` |
| `filterTypography` | typography | Typography | `font` on `.bricks-isotope-filters li` |
| `filterTypographyActive` | typography | Typography active | `font` on `.bricks-isotope-filters .active` |
| `filterMargin` | spacing | Margin | `margin` on `.bricks-isotope-filters li` |
| `filterPadding` | spacing | Padding | `padding` on `.bricks-isotope-filters li` |
| `postsNavigation` | checkbox | Show | — |
| `postsNavigationJustifyContent` | justify-content | Alignment | `justify-content` on `.bricks-pagination ul` |
| `postsNavigationHeight` | number | Height | `height` on `.bricks-pagination ul .page-numbers` |
| `postsNavigationWidth` | number | Width | `width` on `.bricks-pagination ul .page-numbers` |
| `postsNavigationGap` | number | Spacing | `gap` on `.bricks-pagination ul` |
| `postsNavigationBackground` | color | Background | `background` on `.bricks-pagination ul .page-numbers` |
| `postsNavigationBorder` | border | Border | `border` on `.bricks-pagination ul .page-numbers` |
| `postsNavigationTypography` | typography | Typography | `font` on `.bricks-pagination .page-numbers` |
| `postsNavigationBackgroundActive` | color | Background | `background` on `.bricks-pagination ul .page-numbers.current` |
| `postsNavigationBorderActive` | border | Border | `border` on `.bricks-pagination ul .page-numbers.current` |
| `postsNavigationTypographyActive` | typography | Typography | `font` on `.bricks-pagination ul .page-numbers.current` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Pricing Tables Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/pricing-tables/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | pricing-tables |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/pricing-tables.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `pricingTables` | repeater | Show under | `background` on `.pricing-table-bg` |
| `columns` | number | Columns | `grid-template-columns` on `.pricing-tables`, `grid-auto-flow` on `.pricing-tables` |
| `gutter` | number | Spacing | `gap` on `.pricing-tables` |
| `horizontalAlign` | align-items | Align tables | `align-items` on `.pricing-tables` |
| `tabs` | checkbox | Show tabs | — |
| `tab1Label` | text | Tab 1 label | — |
| `tab2Label` | text | Tab 2 label | — |
| `defaultTab` | select | Default tab | — |
| `tabsJustifyContent` | justify-content | Alignment | `justify-content` on `.tabs` |
| `tabsMargin` | spacing | Margin | `margin` on `.tabs` |
| `tabsBackgroundColor` | color | Background | `background-color` on `.tabs` |
| `tabsBorder` | border | Border | `border` on `.tabs` |
| `tabsBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.tabs` |
| `tabWidth` | number | Width | `width` on `.tab` |
| `tabMargin` | spacing | Margin | `margin` on `.tab` |
| `tabPadding` | spacing | Padding | `padding` on `.tab` |
| `tabBackgroundColor` | color | Background | `background-color` on `.tab` |
| `tabBorder` | border | Border | `border` on `.tab` |
| `tabBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.tab` |
| `tabTitleTypography` | typography | Typography | `font` on `.tab` |
| `tabActiveBackgroundColor` | color | Active background | `background-color` on `.tab.active` |
| `tabActiveBorder` | border | Active border | `border` on `.tab.active` |
| `tabActiveBoxShadow` | box-shadow | Active box shadow | `box-shadow` on `.tab.active` |
| `tabActiveTitleTypography` | typography | Active typography | `font` on `.tab.active` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Add To Cart Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-add-to-cart/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-add-to-cart |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-add-to-cart.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `variationsTypography` | typography | Typography | `font` on `table.variations label` |
| `variationsBackgroundColor` | color | Background color | `background-color` on `table.variations tr` |
| `variationsBorder` | border | Border | `border` on `.cart .variations tr:not(:has(.reset_variations))` |
| `variationsMargin` | spacing | Margin | `margin` on `.cart table.variations` |
| `variationsPadding` | spacing | Padding | `padding` on `.cart table.variations td`, `padding` on `.cart table.variations th` |
| `variationsDescriptionTypography` | typography | Description typography | `font` on `.woocommerce-variation-description` |
| `variationsPriceTypography` | typography | Price typography | `font` on `.woocommerce-variation-price` |
| `variationsRegularPriceTypography` | typography | Regular price typography | `font` on `.woocommerce-variation-price .price del, .woocommerce-variation-price .price > span` |
| `variationsSalePriceTypography` | typography | Sale price typography | `font` on `.woocommerce-variation-price .price ins` |
| `swatchesWrap` | select | Wrap | `flex-wrap` on `.bricks-variation-swatches` |
| `swatchesDirection` | direction | Direction | `flex-direction` on `.bricks-variation-swatches` |
| `swatchesJustifyContent` | justify-content | Align main axis | `justify-content` on `.bricks-variation-swatches` |
| `swatchesAlignItems` | align-items | Align cross axis | `align-items` on `.bricks-variation-swatches` |
| `swatchesColumnGap` | number | Column gap | `column-gap` on `.bricks-variation-swatches` |
| `swatchesRowGap` | number | Row gap | `row-gap` on `.bricks-variation-swatches` |
| `colorSwatchSize` | number | Size | `width` on `.bricks-variation-swatches.bricks-swatch-color li`, `height` on `.bricks-variation-swatches.bricks-swatch-color li` |
| `colorSwatchBorder` | border | Border | `border` on `.bricks-variation-swatches.bricks-swatch-color li` |
| `colorSwatchActiveBorder` | border | Border | `border` on `.bricks-variation-swatches.bricks-swatch-color li.bricks-swatch-selected` |
| `labelSwatchPadding` | spacing | Padding | `padding` on `.bricks-variation-swatches.bricks-swatch-label li` |
| `labelSwatchTypography` | typography | Typography | `font` on `.bricks-variation-swatches.bricks-swatch-label li` |
| `labelSwatchActiveTypography` | typography | Typography | `font` on `.bricks-variation-swatches.bricks-swatch-label li.bricks-swatch-selected` |
| `labelSwatchBackgroundColor` | color | Background color | `background-color` on `.bricks-variation-swatches.bricks-swatch-label li` |
| `labelSwatchActiveBackgroundColor` | color | Background color | `background-color` on `.bricks-variation-swatches.bricks-swatch-label li.bricks-swatch-selected` |
| `labelSwatchBorder` | border | Border | `border` on `.bricks-variation-swatches.bricks-swatch-label li` |
| `labelSwatchActiveBorder` | border | Border | `border` on `.bricks-variation-swatches.bricks-swatch-label li.bricks-swatch-selected` |
| `imageSwatchWidth` | number | Width | `width` on `.bricks-variation-swatches.bricks-swatch-image li img` |
| `imageSwatchHeight` | number | Height | `height` on `.bricks-variation-swatches.bricks-swatch-image li img` |
| `imageSwatchBorder` | border | Border | `border` on `.bricks-variation-swatches.bricks-swatch-image li` |
| `imageSwatchActiveBorder` | border | Border | `border` on `.bricks-variation-swatches.bricks-swatch-image li.bricks-swatch-selected` |
| `swatchTooltipPadding` | spacing | Padding | `padding` on `.bricks-variation-swatches li[data-balloon]::after` |
| `swatchTooltip` | typography | Typography | `font` on `.bricks-variation-swatches li[data-balloon]::after` |
| `swatchTooltipBackground` | color | Background color | `background-color` on `.bricks-variation-swatches li[data-balloon]::after`, `border-top-color` on `.bricks-variation-swatches li[data-balloon]::before` |
| `swatchTooltipBorder` | border | Border | `border` on `.bricks-variation-swatches li[data-balloon]::after` |
| `hideStock` | checkbox | Hide stock | `display` on `.stock` |
| `stockTypography` | typography | Typography | `font` on `.stock` |
| `inStockTypography` | typography | Typography | `font` on `.stock.in-stock` |
| `outOfStockTypography` | typography | Typography | `font` on `.stock.out-of-stock` |
| `formDisplay` | select | Display | `display` on `form.cart:not(.variations_form), form.cart.variations_form .woocommerce-variation-add-to-cart` |
| `formFlexDirection` | direction | Direction | `flex-direction` on `form.cart:not(.variations_form), form.cart.variations_form .woocommerce-variation-add-to-cart` |
| `formAlignSelf` | align-items | Align self | `align-self` on `form.cart:not(.variations_form), form.cart.variations_form .woocommerce-variation-add-to-cart` |
| `formJustifyContent` | justify-content | Align main axis | `justify-content` on `form.cart:not(.variations_form), form.cart.variations_form .woocommerce-variation-add-to-cart` |
| `formAlignItems` | align-items | Align cross axis | `align-items` on `form.cart:not(.variations_form), form.cart.variations_form .woocommerce-variation-add-to-cart` |
| `formGap` | number | Gap | `gap` on `form.cart:not(.variations_form), form.cart.variations_form .woocommerce-variation-add-to-cart` |
| `formFlexGrow` | number | Flex grow | `flex-grow` on `form.cart:not(.variations_form), form.cart.variations_form .woocommerce-variation-add-to-cart` |
| `formFlexShrink` | number | Flex shrink | `flex-shrink` on `form.cart:not(.variations_form), form.cart.variations_form .woocommerce-variation-add-to-cart` |
| `formFlexBasis` | text | Flex basis | `flex-basis` on `form.cart:not(.variations_form), form.cart.variations_form .woocommerce-variation-add-to-cart` |
| `quantityWidth` | number | Width | `width` on `.cart .quantity` |
| `quantityBackground` | color | Background | `background-color` on `.cart .quantity` |
| `quantityBorder` | border | Border | `border` on `.qty`, `border` on `.minus`, `border` on `.plus` |
| `buttonText` | text | Simple product | — |
| `variableText` | text | Variable product | — |
| `groupedText` | text | Grouped product | — |
| `externalText` | text | External product | — |
| `buttonMargin` | spacing | Margin | `margin` on `.cart .single_add_to_cart_button, a.button[data-product_id]` |
| `buttonPadding` | spacing | Padding | `padding` on `.cart .single_add_to_cart_button, a.button[data-product_id]` |
| `buttonWidth` | number | Width | `min-width` on `.cart .single_add_to_cart_button, a.button[data-product_id]` |
| `buttonBackgroundColor` | color | Background color | `background-color` on `.cart .single_add_to_cart_button, a.button[data-product_id]` |
| `buttonBorder` | border | Border | `border` on `.cart .single_add_to_cart_button, a.button[data-product_id]` |
| `buttonTypography` | typography | Typography | `font` on `.cart .single_add_to_cart_button, a.button[data-product_id]` |
| `icon` | icon | Icon | — |
| `iconTypography` | typography | Icon typography | `font` on `.icon` |
| `iconOnly` | checkbox | Icon only | — |
| `iconPosition` | select | Icon position | — |
| `groupedProductTablePadding` | spacing | Table cell | `padding` on `.cart.grouped_form .group_table td` |
| `groupedProductQuantityWidth` | number | Width | `width` on `.cart.grouped_form .quantity` |
| `groupedProductQuantityBackground` | color | Background | `background-color` on `.cart.grouped_form .quantity` |
| `groupedProductQuantityBorder` | border | Border | `border` on `.cart.grouped_form .quantity .minus`, `border` on `.cart.grouped_form .quantity .plus`, `border` on `.cart.grouped_form .quantity .qty` |
| `groupedProductLabelTypography` | typography | Typography | `font` on `.cart.grouped_form .woocommerce-grouped-product-list-item__label a` |
| `groupedProductStockTypography` | typography | Typography | `font` on `.cart.grouped_form .stock` |
| `groupedProductInStockTypography` | typography | Typography | `font` on `.cart.grouped_form .stock.in-stock` |
| `groupedProductOutOfStockTypography` | typography | Typography | `font` on `.cart.grouped_form .stock.out-of-stock` |
| `groupedProductPriceTypography` | typography | Typography | `font` on `.cart.grouped_form .woocommerce-grouped-product-list-item__price .woocommerce-Price-amount` |
| `groupedProductSalePriceTypography` | typography | Sale price typography | `font` on `.cart.grouped_form .woocommerce-grouped-product-list-item__price ins .woocommerce-Price-amount` |
| `groupedProductRegularPriceTypography` | typography | Regular price typography | `font` on `.cart.grouped_form .woocommerce-grouped-product-list-item__price del .woocommerce-Price-amount` |
| `groupedProductButtonWidth` | number | Width | `min-width` on `.cart.grouped_form .group_table .button` |
| `groupedProductButtonPadding` | spacing | Padding | `padding` on `.cart.grouped_form .group_table .button` |
| `groupedProductButtonTypography` | typography | Typography | `font` on `.cart.grouped_form .group_table .button` |
| `groupedProductButtonBackground` | color | Background color | `background-color` on `.cart.grouped_form .group_table .button` |
| `addingButtonText` | text | Button text | — |
| `addingButtonIcon` | icon | Icon | — |
| `addingButtonIconOnly` | checkbox | Icon only | — |
| `addingButtonIconPosition` | select | Icon position | — |
| `addingButtonIconSpinning` | checkbox | Icon spinning | — |
| `addedButtonText` | text | Button text | — |
| `resetTextAfter` | number | Reset text after .. seconds | — |
| `addedButtonIcon` | icon | Icon | — |
| `addedButtonIconOnly` | checkbox | Icon only | — |
| `addedButtonIconPosition` | select | Icon position | — |
| `showNotice` | select | Show notice | — |
| `scrollToNotice` | select | Scroll to notice | — |
| `hideViewCart` | select | Hide "View cart" button | `display` on `.added_to_cart.wc-forward` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Product Additional Information Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-additional-information/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-additional-information |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-additional-information.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `headingText` | text | Heading | — |
| `headingTypography` | typography | Typography | `font` on `h2` |
| `labelWidth` | number | Width | `width` on `th` |
| `labelTypography` | typography | Typography | `font` on `th` |
| `detailsWidth` | number | Width | `width` on `td` |
| `detailsTypography` | typography | Typography | `font` on `td` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Product Content Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-content/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-content |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-content.json" />

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Product Gallery Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-gallery/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-gallery |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-gallery.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `productImageSize` | select | Product | — |
| `thumbnailImageSize` | select | Thumbnail | — |
| `lightboxImageSize` | select | Lightbox | — |
| `thumbnailPosition` | select | Position | — |
| `itemWidth` | number | Item width | `width` on `&[data-pos="right"] .woocommerce-product-gallery .flex-control-nav`, `width` on `&[data-pos="left"] .woocommerce-product-gallery .flex-control-nav`, `width` on `&[data-pos="right"] .brx-product-gallery-thumbnail-slider`, `width` on `&[data-pos="left"] .brx-product-gallery-thumbnail-slider` |
| `columns` | number | Columns | `grid-template-columns` on `.flex-control-thumbs` |
| `gap` | number | Gap | `gap` on `.flex-control-thumbs`, `gap` on `.woocommerce-product-gallery`, `gap` on `&.thumbnail-slider` |
| `thumbnailOpacity` | number | Opacity | `opacity` on `.woocommerce-product-gallery .flex-control-thumbs img:not(.flex-active)`, `opacity` on `&.thumbnail-slider .brx-product-gallery-thumbnail-slider .woocommerce-product-gallery__image:not(.flex-active-slide) img` |
| `thumbnailActiveOpacity` | number | Opacity | `opacity` on `.woocommerce-product-gallery .flex-control-thumbs img.flex-active`, `opacity` on `&.thumbnail-slider .brx-product-gallery-thumbnail-slider .woocommerce-product-gallery__image.flex-active-slide img` |
| `thumbnailBorder` | border | Border | `border` on `.woocommerce-product-gallery .flex-control-thumbs img`, `border` on `&.thumbnail-slider .brx-product-gallery-thumbnail-slider .woocommerce-product-gallery__image img` |
| `thumbnailActiveBorder` | border | Border | `border` on `.woocommerce-product-gallery .flex-control-thumbs img.flex-active`, `border` on `&.thumbnail-slider .brx-product-gallery-thumbnail-slider .woocommerce-product-gallery__image.flex-active-slide img` |
| `thumbnailSlider` | checkbox | Slider | — |
| `thumbnailWrapperMaxHeight` | number | Slider | `max-height` on `&.thumbnail-slider .brx-product-gallery-thumbnail-slider` |
| `itemMargin` | number | Slider | `margin-inline-end` on `&.thumbnail-slider[data-pos="top"] .brx-product-gallery-thumbnail-slider .woocommerce-product-gallery__image`, `margin-inline-end` on `&.thumbnail-slider[data-pos="bottom"] .brx-product-gallery-thumbnail-slider .woocommerce-product-gallery__image`, `margin-bottom` on `&.thumbnail-slider[data-pos="right"] .brx-product-gallery-thumbnail-slider .woocommerce-product-gallery__image`, `margin-bottom` on `&.thumbnail-slider[data-pos="left"] .brx-product-gallery-thumbnail-slider .woocommerce-product-gallery__image` |
| `maxItems` | number | Max. items | — |
| `prevArrow` | icon | Prev arrow | — |
| `nextArrow` | icon | Next arrow | — |
| `arrowBackground` | color | Background | `background-color` on `.flex-direction-nav a` |
| `arrowBorder` | border | Border | `border` on `.flex-direction-nav a` |
| `arrowColor` | color | Color | `color` on `.flex-direction-nav a` |
| `arrowSize` | number | Size | `font-size` on `.flex-direction-nav a > *`, `height` on `.flex-direction-nav a > svg` |
| `arrowHeight` | number | Height | `height` on `.flex-direction-nav a` |
| `arrowWidth` | number | Width | `width` on `.flex-direction-nav a` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Product Meta Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-meta/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-meta |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-meta.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `direction` | direction | Direction | `flex-direction` |
| `gutter` | number | Spacing | `gap` |
| `separator` | text | Separator | — |
| `separatorColor` | color | Separator color | `color` on `.separator` |
| `prefixTypography` | typography | Typography | `font` on `.prefix` |
| `suffixTypography` | typography | Typography | `font` on `.suffix` |
| `linkTypography` | typography | Typography | `font` on `a` |
| `fields` | repeater | Fields | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Product Price Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-price/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-price |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-price.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `hideRegularPrice` | checkbox | Hide regular price | `display` on `del` |
| `regularPriceTypography` | typography | Regular price typography | `font` on `.price del, .price > span` |
| `salePriceTypography` | typography | Sale price typography | `font` on `.price ins` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Product Rating Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-rating/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-rating |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-rating.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `starColor` | color | Star color | `color` on `.star-rating span::before` |
| `emptyStarColor` | color | Empty star color | `color` on `.star-rating::before` |
| `hideReviewsLink` | checkbox | Hide reviews link | — |
| `reviewsLinkTextSingle` | text | Text | — |
| `reviewsLinkTextPlural` | text | Text | — |
| `noRatingsText` | text | Text | — |
| `noRatingsStars` | checkbox | Show empty stars | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Related Products Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-related/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-related |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-related.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `headingText` | text | Heading | — |
| `headingTypography` | typography | Heading typography | `font` on `.related.products > h2` |
| `count` | number | Max. products | — |
| `columns` | number | Columns | `grid-template-columns` on `.products` |
| `orderby` | select | Order by | — |
| `order` | select | Order | — |
| `gap` | number | Gap | `gap` on `.products` |
| `textAlign` | text-align | Align | `text-align` on `.product` |
| `imageHeight` | number | Image height | `height` on `.product img` |
| `buttonPadding` | spacing | Padding | `padding` on `.button` |
| `buttonBackgroundColor` | color | Background color | `background-color` on `.button` |
| `buttonBorder` | border | Border | `border` on `.button` |
| `buttonTypography` | typography | Typography | `font` on `.button` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Product Reviews Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-reviews/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-reviews |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-reviews.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `formTitleTypography` | typography | Title | `font` on `.comment-reply-title` |
| `formLabelTypography` | typography | Label | `font` on `form label` |
| `formTextareaResize` | select | Textarea | `resize` on `form .comment-form-comment textarea` |
| `authorTypography` | typography | Author | `font` on `.meta .woocommerce-review__author` |
| `dateTypography` | typography | Date | `font` on `.meta .woocommerce-review__published-date` |
| `descriptionTypography` | typography | Description | `font` on `.description` |
| `starsSize` | number | Size | `font-size` on `.stars`, `height` on `.stars a`, `width` on `.stars a`, `padding-top` on `.star-rating span`, `font-size` on `.star-rating`, `height` on `.star-rating`, `width` on `.star-rating` |
| `starsBackgroundColor` | color | Background color | `color` on `form .stars a::before, form .stars.selected a.active ~ a::before`, `color` on `.star-rating` |
| `starsFillColor` | color | Fill color | `color` on `.stars a.bricks-star-filled::before`, `color` on `.star-rating span::before` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Product Short Description Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-short-description/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-short-description |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-short-description.json" />

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Product Stock Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-stock/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-stock |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-stock.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `inStockText` | text | inStockText | — |
| `inStockTypography` | typography | Typography | `font` on `.in-stock` |
| `inStockBackgroundColor` | color | Background color | `background-color` on `.in-stock` |
| `lowStockText` | text | lowStockText | — |
| `lowStockTypography` | typography | Typography | `font` on `.low-stock, .available-on-backorder` |
| `lowStockBackgroundColor` | color | Background color | `background-color` on `.low-stock, .available-on-backorder` |
| `outOfStockText` | text | outOfStockText | — |
| `outOfStockTypography` | typography | Typography | `font` on `.out-of-stock` |
| `outOfStockBackgroundColor` | color | Background color | `background-color` on `.out-of-stock` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Product Tabs Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-tabs/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-tabs |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-tabs.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `direction` | direction | Direction | `flex-direction` |
| `tabsDirection` | direction | Direction | `flex-direction` on `.wc-tabs` |
| `tabsJustifyContent` | justify-content | Alignment | `justify-content` on `.wc-tabs` |
| `tabsPadding` | spacing | Padding | `padding` on `.wc-tabs li` |
| `tabsTypography` | typography | Typography | `font` on `.wc-tabs a` |
| `tabsBackgroundColor` | color | Background color | `background-color` on `.wc-tabs` |
| `tabsBorder` | border | Border | `border` on `.wc-tabs` |
| `tabActiveTypography` | typography | Typography | `font` on `.wc-tabs .active a` |
| `tabActiveBackgroundColor` | color | Background color | `background-color` on `.wc-tabs .active` |
| `panelPadding` | spacing | Padding | `padding` on `.panel` |
| `panelTypography` | typography | Typography | `color` on `.panel` |
| `panelBackgroundColor` | color | Background color | `background-color` on `.panel` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Product Title Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-title/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-title |
| `category` | woocommerce_product |
| `tag` | h1 |
| `nestable` | false |

<SchemaJson path="elements/product-title.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `tag` | select | HTML tag | — |
| `prefix` | text | Prefix | — |
| `prefixBlock` | checkbox | Prefix block | — |
| `suffix` | text | Suffix | — |
| `suffixBlock` | checkbox | Suffix block | — |
| `linkToProduct` | checkbox | Link to product | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Product Up/Cross-Sells Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/product-upsells/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | product-upsells |
| `category` | woocommerce_product |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/product-upsells.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `type` | select | Type | — |
| `headingText` | text | Heading | — |
| `headingTypography` | typography | Heading typography | `font` on `.up-sells > h2`, `font` on `.cross-sells > h2` |
| `count` | number | Max. products | — |
| `columns` | number | Columns | `grid-template-columns` on `.products` |
| `gap` | number | Gap | `gap` on `.products` |
| `orderby` | select | Order by | — |
| `order` | select | Order | — |
| `buttonPadding` | spacing | Padding | `padding` on `.button` |
| `buttonBackgroundColor` | color | Background color | `background-color` on `.button` |
| `buttonBorder` | border | Border | `border` on `.button` |
| `buttonTypography` | typography | Typography | `font` on `.button` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Progress Bar Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/progress-bar/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | progress-bar |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/progress-bar.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `bars` | repeater | Label | `background-color` on `.bar span` |
| `height` | number | Height | `height` |
| `barSpacing` | number | Spacing | `gap` |
| `showPercentage` | checkbox | Show percentage | — |
| `barColor` | color | Bar color | `background-color` on `.bar span` |
| `barBackgroundColor` | color | Bar background color | `background-color` on `.bar` |
| `barBorder` | border | Bar border | `border` on `.bar` |
| `labelTypography` | typography | Label typography | `font` on `.label` |
| `percentageTypography` | typography | Percentage typography | `font` on `.percentage` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Query Results Summary Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/query-results-summary/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | query-results-summary |
| `category` | query |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/query-results-summary.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `queryId` | query-list | Query | — |
| `statsFormat` | text | Format | — |
| `oneResultText` | text | oneResultText | — |
| `noResultsText` | text | noResultsText | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Rating Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/rating/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | rating |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/rating.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `rating` | number | Rating | — |
| `maxRating` | number | Max. rating | — |
| `gap` | number | Gap | `gap` |
| `icon` | icon | Icon | — |
| `iconColorFull` | color | Icon color | `color` on `.icon.full-color` |
| `iconColorEmpty` | color | Icon color | `color` on `.icon.empty-color` |
| `iconSize` | number | Icon size | `font-size` on `.icon` |
| `schema` | checkbox | Generate review schema | — |
| `schemaType` | text | Required | — |
| `schemaName` | text | Required | — |
| `reviewAuthor` | text | Optional | — |
| `schemaProperties` | repeater | Additional item reviewed properties | — |
| `schemaReviewProperties` | repeater | Additional review properties | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Related Posts Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/related-posts/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | related-posts |
| `category` | single |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/related-posts.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `title` | text | Title | — |
| `titleTag` | select | HTML tag | — |
| `titleMargin` | spacing | Margin | `margin` on `.related-posts-title` |
| `titleTypography` | typography | Typography | `font` on `.related-posts-title` |
| `post_type` | select | Post type | — |
| `count` | number | Max. related posts | — |
| `order` | select | Order | — |
| `orderby` | select | Order by | — |
| `taxonomies` | select | Common taxonomies | — |
| `gap` | number | Gap | `gap` on `ul` |
| `columns` | number | Posts per row | `grid-template-columns` on `ul`, `grid-auto-flow` on `ul` |
| `content` | repeater | Dynamic data | `margin` |
| `noImage` | checkbox | Disable | — |
| `imageSize` | select | Image size | — |
| `imagePosition` | select | Position | — |
| `imageHeight` | number | Height | `height` on `img` |
| `imageWidth` | number | Width | `width` on `img` |
| `imageMargin` | spacing | Margin | `margin` on `figure` |
| `contentWidth` | number | Width | `width` on `.post-content` |
| `contentPadding` | spacing | Padding | `padding` on `.post-content` |
| `contentBackground` | color | Background color | `background-color` on `.post-content` |
| `overlay` | checkbox | Overlay content | — |
| `overlayAlignItems` | align-items | Horizontal alignment | `align-items` on `.post-content` |
| `overlayJustifyContent` | justify-content | Vertical alignment | `justify-content` on `.post-content` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Search Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/search/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | search |
| `category` | wordpress |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/search.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `searchType` | select | Type | — |
| `ariaLabel` | text | aria-label | — |
| `actionURL` | text | Action URL | — |
| `additionalParams` | repeater | Additional parameters | — |
| `inputHeight` | number | Height | `height` on `input[type=search]` |
| `inputWidth` | number | Width | `width` on `input[type=search]`, `max-width` on `.bricks-search-overlay .bricks-search-form` |
| `placeholder` | text | Placeholder | — |
| `placeholderColor` | color | Placeholder color | `color` on `input[type=search]::placeholder` |
| `inputBackgroundColor` | color | Background color | `background-color` on `input[type=search]` |
| `inputBorder` | border | Border | `border` on `input[type=search]` |
| `inputBoxShadow` | box-shadow | Box shadow | `box-shadow` on `input[type=search]` |
| `inputTypography` | typography | Typography | `font` on `input[type=search]` |
| `showLabel` | checkbox | Show label | — |
| `labelText` | text | Label text | — |
| `labelTypography` | typography | Label typography | `typography` on `label` |
| `buttonAriaLabel` | text | aria-label | — |
| `buttonText` | text | Text | — |
| `icon` | icon | Icon | — |
| `buttonPadding` | spacing | Padding | `padding` on `button` |
| `iconHeight` | number | Height | `height` on `button` |
| `iconWidth` | number | Width | `width` on `button` |
| `iconBackgroundColor` | color | Background color | `background-color` on `button` |
| `iconBorder` | border | Border | `border` on `button` |
| `iconBoxShadow` | box-shadow | Box shadow | `box-shadow` on `button` |
| `iconTypography` | typography | Typography | `font` on `button` |
| `overlayFormDirection` | direction | Direction | `flex-direction` on `.bricks-search-overlay form` |
| `overlayFormGap` | number | Gap | `gap` on `.bricks-search-overlay form` |
| `searchOverlayTitle` | text | Title | — |
| `searchOverlayTitleTag` | text | Title tag | — |
| `searchOverlayTitleTypography` | typography | Title typography | `font` on `.title` |
| `searchOverlayBackground` | background | Background | `background` on `.bricks-search-overlay` |
| `searchOverlayBackgroundOverlay` | color | Background | `background-color` on `.bricks-search-overlay:after` |
| `overlayIconWidth` | number | Button | `width` on `.bricks-search-overlay button[type="submit"]` |
| `overlayButtonPadding` | spacing | Button | `padding` on `.bricks-search-overlay button[type="submit"]` |
| `overlayButtonBackground` | color | Button | `background-color` on `.bricks-search-overlay button[type="submit"]` |
| `overlayButtonBorder` | border | Button | `border` on `.bricks-search-overlay button[type="submit"]` |
| `overlayButtonTypography` | typography | Button | `font` on `.bricks-search-overlay button[type="submit"]` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Section Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/section/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | section |
| `category` | layout |
| `tag` | section |
| `nestable` | true |

<SchemaJson path="elements/section.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `link` | link | Link | — |
| `tag` | select | HTML tag | — |
| `customTag` | text | Custom tag | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_gridItemColumnSpan` | text | Grid column | `grid-column` |
| `_gridItemRowSpan` | text | Grid row | `grid-row` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_display` | select | Display | `display`, `align-items` |
| `_gridGap` | number | Gap | `grid-gap` |
| `_gridTemplateColumns` | text | Grid template columns | `grid-template-columns` |
| `_gridTemplateRows` | text | Grid template rows | `grid-template-rows` |
| `_gridAutoColumns` | text | Grid auto columns | `grid-auto-columns` |
| `_gridAutoRows` | text | Grid auto rows | `grid-auto-rows` |
| `_gridAutoFlow` | select | Grid auto flow | `grid-auto-flow` |
| `_justifyItemsGrid` | justify-content | Justify items | `justify-items` |
| `_alignItemsGrid` | align-items | Align items | `align-items` |
| `_justifyContentGrid` | justify-content | Justify content | `justify-content` |
| `_alignContentGrid` | align-items | Align content | `align-content` |
| `_flexWrap` | select | Flex wrap | `flex-wrap` |
| `_direction` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_columnGap` | number | Column gap | `column-gap` |
| `_rowGap` | number | Row gap | `row-gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_order` | number | Order | `order` |
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_gap` | number | Gap | `gap` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Shortcode Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/shortcode/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | shortcode |
| `category` | wordpress |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/shortcode.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `shortcode` | textarea | Shortcode | — |
| `showPlaceholder` | checkbox | Don\ | — |
| `placeholderWidth` | number | Placeholder | — |
| `placeholderHeight` | number | Placeholder | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Sidebar Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/sidebar/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | sidebar |
| `category` | wordpress |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/sidebar.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `sidebar` | select | Sidebar | — |
| `margin` | spacing | Widget margin | `margin` on `.bricks-widget-wrapper` |
| `titleTypography` | typography | Title typography | `font` on `.bricks-widget-title`, `font` on `h1`, `font` on `h2`, `font` on `h3`, `font` on `h4`, `font` on `h5`, `font` on `h6` |
| `contentTypography` | typography | Content typography | `font` |
| `searchBackground` | color | Search background color | `background-color` on `input[type=search]` |
| `searchBorder` | border | Search border | `border` on `input[type=search]` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Slider (Nestable) Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/slider-nested/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | slider-nested |
| `category` | media |
| `tag` | div |
| `nestable` | true |

<SchemaJson path="elements/slider-nested.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `optionsType` | select | Options type | — |
| `options` | code | Custom options | — |
| `type` | select | Type | — |
| `direction` | select | Direction | — |
| `keyboard` | select | Keyboard | — |
| `autoHeight` | checkbox | Auto height | — |
| `height` | number | Height | — |
| `gap` | number | Spacing | — |
| `start` | number | Start index | — |
| `perPage` | number | Items to show | — |
| `perMove` | number | Items to scroll | — |
| `speed` | number | Speed in ms | — |
| `focus` | number | Focus | — |
| `autoplay` | checkbox | Autoplay | — |
| `pauseOnHover` | checkbox | Pause on hover | — |
| `pauseOnFocus` | checkbox | Pause on focus | — |
| `interval` | number | Interval in ms | — |
| `rewind` | checkbox | Rewind | — |
| `rewindByDrag` | checkbox | Rewind by drag | — |
| `rewindSpeed` | number | Speed in ms | — |
| `slidePadding` | spacing | Padding | `padding` on `.splide__slide` |
| `slideAlignHorizontal` | align-items | Align horizontal | `align-items` on `.splide__slide` |
| `slideAlignVertical` | justify-content | Align vertical | `justify-content` on `.splide__slide` |
| `slideBackground` | background | Background | `background` on `.splide__slide` |
| `slideBorder` | border | Border | `border` on `.splide__slide` |
| `arrows` | checkbox | Show | — |
| `arrowHeight` | number | Height | `height` on `.splide__arrow` |
| `arrowWidth` | number | Width | `width` on `.splide__arrow` |
| `arrowBackground` | color | Background | `background-color` on `.splide__arrow` |
| `arrowBorder` | border | Border | `border` on `.splide__arrow` |
| `arrowColor` | color | Color | `color` on `.splide__arrow`, `fill` on `.splide__arrow svg` |
| `arrowSize` | number | Size | `font-size` on `.splide__arrow`, `height` on `.splide__arrow svg`, `width` on `.splide__arrow svg`, `min-height` on `.splide__arrow`, `min-width` on `.splide__arrow` |
| `arrowTextShadow` | text-shadow | Text shadow | `text-shadow` on `.splide__arrow` |
| `arrowDisabledBackground` | color | Background | `background-color` on `.splide__arrow:disabled` |
| `arrowDisabledBorder` | border | Border | `border` on `.splide__arrow:disabled` |
| `arrowDisabledColor` | color | Color | `color` on `.splide__arrow:disabled`, `fill` on `.splide__arrow:disabled svg` |
| `arrowDisabledOpacity` | number | Opacity | `opacity` on `.splide__arrow:disabled` |
| `prevArrow` | icon | Prev arrow | `—` on `.splide__arrow--prev > *` |
| `prevArrowTop` | number | Top | `top` on `.splide__arrow--prev` |
| `prevArrowRight` | number | Right | `right` on `.splide__arrow--prev` |
| `prevArrowBottom` | number | Bottom | `bottom` on `.splide__arrow--prev` |
| `prevArrowLeft` | number | Left | `left` on `.splide__arrow--prev` |
| `prevArrowTransform` | transform | Transform | `transform` on `.splide__arrow--prev` |
| `nextArrow` | icon | Next arrow | `—` on `.splide__arrow--next > *` |
| `nextArrowTop` | number | Top | `top` on `.splide__arrow--next` |
| `nextArrowRight` | number | Right | `right` on `.splide__arrow--next` |
| `nextArrowBottom` | number | Bottom | `bottom` on `.splide__arrow--next` |
| `nextArrowLeft` | number | Left | `left` on `.splide__arrow--next` |
| `nextArrowTransform` | transform | Transform | `transform` on `.splide__arrow--next` |
| `pagination` | checkbox | Show | — |
| `paginationSpacing` | spacing | Margin | `margin` on `.splide__pagination .splide__pagination__page` |
| `paginationHeight` | number | Height | `height` on `.splide__pagination .splide__pagination__page` |
| `paginationWidth` | number | Width | `width` on `.splide__pagination .splide__pagination__page` |
| `paginationColor` | color | Color | `color` on `.splide__pagination .splide__pagination__page`, `background-color` on `.splide__pagination .splide__pagination__page` |
| `paginationBorder` | border | Border | `border` on `.splide__pagination .splide__pagination__page` |
| `paginationHeightActive` | number | Height | `height` on `.splide__pagination .splide__pagination__page.is-active` |
| `paginationWidthActive` | number | Width | `width` on `.splide__pagination .splide__pagination__page.is-active` |
| `paginationColorActive` | color | Color | `color` on `.splide__pagination .splide__pagination__page.is-active`, `background-color` on `.splide__pagination .splide__pagination__page.is-active` |
| `paginationBorderActive` | border | Border | `border` on `.splide__pagination .splide__pagination__page.is-active` |
| `paginationTop` | number | Top | `top` on `.splide__pagination`, `bottom` on `.splide__pagination` |
| `paginationRight` | number | Right | `right` on `.splide__pagination`, `left` on `.splide__pagination`, `transform` on `.splide__pagination` |
| `paginationBottom` | number | Bottom | `bottom` on `.splide__pagination` |
| `paginationLeft` | number | Left | `left` on `.splide__pagination`, `right` on `.splide__pagination`, `transform` on `.splide__pagination` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Slider Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/slider/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | slider |
| `category` | media |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/slider.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `items` | repeater | Slides | `width` on `.bricks-button` |
| `titleMargin` | spacing | Title margin | `margin` on `.slider-content .title` |
| `titleTypography` | typography | Title typography | `font` on `.title` |
| `contentWidth` | number | Content width | `width` on `.slider-content` |
| `contentBackgroundColor` | color | Content background | `background-color` on `.slider-content` |
| `contentTypography` | typography | Content typography | `font` on `.content` |
| `contentMargin` | spacing | Content margin | `margin` on `.slider-content` |
| `contentPadding` | spacing | Content padding | `padding` on `.slider-content` |
| `contentAlignHorizontal` | justify-content | Content align horizontal | `justify-content` on `.swiper-slide` |
| `contentAlignVertical` | align-items | Content align vertical | `align-items` on `.swiper-slide` |
| `contentTextAlign` | text-align | Content text align | `text-align` on `.slider-content` |
| `buttonStyle` | select | Button style | — |
| `buttonSize` | select | Button size | — |
| `buttonWidth` | number | Button width | `width` on `.bricks-button` |
| `buttonBackground` | color | Background | `background-color` on `.bricks-button` |
| `buttonBorder` | border | Border | `border` on `.bricks-button` |
| `buttonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.bricks-button` |
| `buttonTypography` | typography | Typography | `font` on `.bricks-button` |
| `backgroundPositionTop` | number | Top | `top` on `.image` |
| `backgroundPositionRight` | number | Right | `right` on `.image` |
| `backgroundPositionBottom` | number | Bottom | `bottom` on `.image` |
| `backgroundPositionLeft` | number | Left | `left` on `.image` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Slot Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/slot/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | slot |
| `category` | general |
| `tag` | div |
| `nestable` | true |

<SchemaJson path="elements/slot.json" />

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Icon List Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/social-icons/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | social-icons |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/social-icons.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `icons` | repeater | Icons | `color` on `.icon` |
| `iconColor` | color | Icon | `color` on `.icon` |
| `iconSize` | number | Icon | `font-size` on `.icon`, `height` on `svg`, `width` on `svg` |
| `direction` | direction | Direction | `flex-direction` |
| `alignIcons` | align-items | Align items | `align-items` |
| `justifyIcons` | justify-content | Justify content | `justify-content` |
| `gap` | number | Spacing | `gap` |
| `gapItem` | number | Spacing | `gap` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## SVG Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/svg/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | svg |
| `category` | media |
| `tag` | svg |
| `nestable` | false |

<SchemaJson path="elements/svg.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `source` | select | Source | — |
| `file` | svg | file | — |
| `iconSet` | icon | Icon set | — |
| `dynamicData` | text | Dynamic data | — |
| `code` | code | Code | — |
| `height` | number | Height | `height` |
| `width` | number | Width | `width` |
| `strokeWidth` | number | Stroke width | `stroke-width` on `*` |
| `stroke` | color | Stroke color | `stroke` on `:not([stroke="none"])` |
| `fill` | color | Fill | `fill` on `:not([fill="none"])` |
| `link` | link | Link | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Tabs (Nestable) Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/tabs-nested/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | tabs-nested |
| `category` | general |
| `tag` | div |
| `nestable` | true |

<SchemaJson path="elements/tabs-nested.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `direction` | direction | Direction | `flex-direction` |
| `openTabOn` | select | Open tab on | — |
| `openTab` | text | Open tab index | — |
| `titleWidth` | number | Width | `width` on `> .tab-menu .tab-title` |
| `titleMargin` | spacing | Margin | `margin` on `> .tab-menu .tab-title` |
| `titlePadding` | spacing | Padding | `padding` on `> .tab-menu .tab-title` |
| `titleBackgroundColor` | color | Background | `background-color` on `> .tab-menu .tab-title` |
| `titleBorder` | border | Border | `border` on `> .tab-menu .tab-title` |
| `titleTypography` | typography | Typography | `font` on `> .tab-menu .tab-title` |
| `titleActiveBackgroundColor` | color | Background color | `background-color` on `> .tab-menu .tab-title.brx-open` |
| `titleActiveBorder` | border | Border | `border` on `> .tab-menu .tab-title.brx-open` |
| `titleActiveTypography` | typography | Typography | `font` on `> .tab-menu .tab-title.brx-open` |
| `contentMargin` | spacing | Margin | `margin` on `> .tab-content` |
| `contentPadding` | spacing | Padding | `padding` on `> .tab-content` |
| `contentColor` | color | Text color | `color` on `> .tab-content` |
| `contentBackgroundColor` | color | Background color | `background-color` on `> .tab-content` |
| `contentBorder` | border | Border | `border` on `> .tab-content` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Tabs Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/tabs/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | tabs |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/tabs.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `tabs` | repeater | Icon | — |
| `layout` | select | Layout | — |
| `accordionLayoutAtBreakpoint` | select | Accordion layout at breakpoint | — |
| `openTabOn` | select | Open tab on | — |
| `openTab` | text | Open tab index | — |
| `titleGrow` | checkbox | Stretch | `flex-grow` on `.tab-title` |
| `titleHorizontal` | justify-content | Align | `justify-content` on `.tab-menu` |
| `titlePadding` | spacing | Padding | `padding` on `.tab-title` |
| `titleBackgroundColor` | color | Background | `background-color` on `.tab-title` |
| `titleBorder` | border | Border | `border` on `.tab-title` |
| `titleTypography` | typography | Typography | `font` on `.tab-title` |
| `titleActiveBackgroundColor` | color | Active background | `background-color` on `.tab-title.brx-open` |
| `titleActiveBorder` | border | Active border | `border` on `.tab-title.brx-open` |
| `titleActiveTypography` | typography | Active typography | `font` on `.tab-title.brx-open` |
| `contentPadding` | spacing | Padding | `padding` on `.tab-content .tab-pane` |
| `contentTextAlign` | text-align | Text align | `text-align` on `.tab-content` |
| `contentColor` | color | Text color | `color` on `.tab-content` |
| `contentBackgroundColor` | color | Background color | `background-color` on `.tab-content` |
| `contentBorder` | border | Border | `border` on `.tab-content` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Team Members Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/team-members/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | team-members |
| `category` | general |
| `tag` | ul |
| `nestable` | false |

<SchemaJson path="elements/team-members.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `items` | repeater | Image | — |
| `membersPerRow` | number | Columns | `grid-template-columns`, `grid-auto-flow` |
| `memberGutter` | number | Gap | `gap` |
| `contentBackgroundColor` | color | Background | `background-color` on `.member` |
| `contentBorder` | border | Border | `border` on `.member` |
| `contentBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.member` |
| `imagePosition` | select | Image position | — |
| `imageWidth` | number | Width | `width` on `.image` |
| `imageMargin` | spacing | Margin | `margin` on `.image` |
| `imageBorder` | border | Border | `border` on `.image` |
| `contentPadding` | spacing | Padding | `padding` on `.content` |
| `contentAlign` | text-align | Text align | `text-align` on `.content` |
| `memberTitleTag` | select | Title tag | — |
| `memberTitleTypography` | typography | Title typography | `font` on `.title` |
| `memberSubtitleTypography` | typography | Subtitle typography | `font` on `.subtitle` |
| `memberDescriptionTypography` | typography | Description typography | `font` on `.description` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Template Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/template/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | template |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/template.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `template` | select | Template | — |
| `noRoot` | checkbox | Render without wrapper | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Testimonials Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/testimonials/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | testimonials |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/testimonials.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `items` | repeater | Content | — |
| `alignItems` | justify-content | Align items | `justify-content` on `.repeater-item` |
| `textAlign` | text-align | Text align | `text-align` |
| `random` | checkbox | Random order | — |
| `imageAlign` | align-items | Image align | `align-items` on `.repeater-item` |
| `imagePosition` | select | Image position | — |
| `imageSize` | number | Image size | `width` on `.image`, `height` on `.image` |
| `imageBorder` | border | Image border | `border` on `.image` |
| `imageBoxShadow` | box-shadow | Image box shadow | `box-shadow` on `.image` |
| `typographyContent` | typography | Testimonial | `font` on `.testimonial-content-wrapper` |
| `typographyName` | typography | Name | `font` on `.testimonial-name` |
| `typographyTitle` | typography | Title | `font` on `.testimonial-title` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Basic Text Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/text-basic/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | text-basic |
| `category` | basic |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/text-basic.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `text` | textarea | text | — |
| `tag` | select | HTML tag | — |
| `customTag` | text | Custom tag | — |
| `link` | link | Link to | — |
| `wordsLimit` | number | Words limit | — |
| `readMore` | text | Read more | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Text Link Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/text-link/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | text-link |
| `category` | basic |
| `tag` | a |
| `nestable` | false |

<SchemaJson path="elements/text-link.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `text` | text | text | — |
| `link` | link | Link to | — |
| `icon` | icon | Icon | `—` on `.icon > svg` |
| `iconSize` | number | Size | `font-size` on `.icon > i`, `width` on `.icon > svg`, `height` on `.icon > svg` |
| `iconWidth` | number | Width | `width` on `.icon` |
| `iconHeight` | number | Height | `height` on `.icon` |
| `iconColor` | color | Color | `color` on `.icon`, `fill` on `.icon` |
| `iconBackground` | color | Background color | `background-color` on `.icon` |
| `iconBorder` | border | Border | `border` on `.icon`, `overflow` on `.icon` |
| `iconPosition` | select | Position | `flex-direction` |
| `gap` | number | Gap | `gap` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Rich Text Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/text/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | text |
| `category` | basic |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/text.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `text` | editor | text | — |
| `type` | select | Type | — |
| `style` | select | Style | — |
| `wordsLimit` | number | Words limit | — |
| `readMore` | text | Read more | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Toggle - Mode Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/toggle-mode/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | toggle-mode |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/toggle-mode.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `icon` | icon | Icon | — |
| `iconColor` | color | Color | `color` on `.toggle.light > *`, `fill` on `.toggle.light > *` |
| `iconSize` | number | Size | `font-size` on `.toggle.light > *` |
| `iconDark` | icon | Icon | — |
| `iconDarkColor` | color | Color | `color` on `.toggle.dark > *`, `fill` on `.toggle.dark > *` |
| `iconDarkSize` | number | Size | `font-size` on `.toggle.dark > *` |
| `ariaLabel` | text | aria-label | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Toggle Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/toggle/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | toggle |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/toggle.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `icon` | icon | Icon | — |
| `iconColor` | color | Color | `color`, `fill` |
| `iconSize` | number | Size | `font-size` |
| `animation` | select | Animation | — |
| `ariaLabel` | text | aria-label | — |
| `toggleSelector` | text | CSS selector | — |
| `toggleAttribute` | text | Attribute | — |
| `toggleValue` | text | Value | — |
| `barScale` | number | Scale | `--brxe-toggle-scale` |
| `barHeight` | number | Height | `--brxe-toggle-bar-height` on `.brxa-inner` |
| `barRadius` | number | Radius | `--brxe-toggle-bar-radius` on `.brxa-inner` |
| `barColor` | color | Color | `color` on `.brxa-wrap` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Video Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/video/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | video |
| `category` | basic |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/video.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `videoType` | select | Source | — |
| `iframeTitle` | text | Iframe title | — |
| `aspectRatio` | select | Aspect ratio | `aspect-ratio` |
| `objectFit` | select | Object fit | `object-fit` on `video` |
| `youTubeId` | text | YouTube video ID/URL | — |
| `youtubeAutoplay` | checkbox | Autoplay | — |
| `youtubeControls` | checkbox | Controls | — |
| `youtubeLoop` | checkbox | Loop | — |
| `youtubeMute` | checkbox | Mute | — |
| `youtubeRel` | checkbox | Related videos from other channels | — |
| `youtubeDoNotTrack` | checkbox | Do not track | — |
| `youtubeStart` | number | Start time [s] | — |
| `youtubeEnd` | number | End time [s] | — |
| `youtubeDisableFullscreenButton` | checkbox | Disable fullscreen button | — |
| `youtubeDisableKeyboard` | checkbox | Disable keyboard controls | — |
| `youtubeLanguage` | text | Interface language | — |
| `youtubeCcLang` | text | Captions language | — |
| `youtubeCcLoad` | checkbox | Show captions by default | — |
| `youtubeColor` | select | Progress bar color | — |
| `youtubeHideAnnotationsByDefault` | checkbox | Hide video annotations by default | — |
| `youtubePlaysinline` | checkbox | Play inline | — |
| `vimeoId` | text | Vimeo video ID/URL | — |
| `vimeoHash` | text | Vimeo privacy hash | — |
| `vimeoAutoplay` | checkbox | Autoplay | — |
| `vimeoLoop` | checkbox | Loop | — |
| `vimeoMute` | checkbox | Mute | — |
| `vimeoByline` | checkbox | Byline | — |
| `vimeoTitle` | checkbox | Title | — |
| `vimeoPortrait` | checkbox | User portrait | — |
| `vimeoDoNotTrack` | checkbox | Do not track | — |
| `vimeoColor` | color | Color | — |
| `previewImage` | select | previewImage | — |
| `previewImageCustom` | image | previewImageCustom | — |
| `previewImageSize` | select | Image size | — |
| `media` | video | Media | — |
| `fileUrl` | text | Video file URL | — |
| `useDynamicData` | text | useDynamicData | — |
| `filePreload` | select | Preload | — |
| `fileAutoplay` | checkbox | Autoplay | — |
| `fileLoop` | checkbox | Loop | — |
| `fileMute` | checkbox | Mute | — |
| `fileInline` | checkbox | Play inline | — |
| `fileControls` | checkbox | Controls | — |
| `fileControlNoDownload` | checkbox | Disable | — |
| `fileControlNoFullscreen` | checkbox | Disable | — |
| `fileControlNoRemotePlayback` | checkbox | Disable | — |
| `videoPoster` | image | Poster | — |
| `overlay` | background | Overlay | `background` on `.bricks-video-overlay` |
| `overlayIcon` | icon | Icon | — |
| `overlayAriaLabel` | text | aria-label | — |
| `overlayIconTypography` | typography | Icon typography | `font` on `.bricks-video-overlay-icon` |
| `overlayIconPadding` | spacing | Icon padding | `padding` on `.bricks-video-overlay-icon` |
| `overlayIconBackgroundColor` | color | Icon background color | `background-color` on `.bricks-video-overlay-icon` |
| `overlayIconBorder` | border | Icon border | `border` on `.bricks-video-overlay-icon` |
| `overlayIconBoxShadow` | box-shadow | Icon box shadow | `box-shadow` on `.bricks-video-overlay-icon` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - Add Payment Method Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-add-payment-method/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-add-payment-method |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-add-payment-method.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `radioCheckedColor` | color | Color | `background-color` on `ul.woocommerce-PaymentMethods .woocommerce-PaymentMethod input.input-radio:checked + label::before`, `border-color` on `ul.woocommerce-PaymentMethods .woocommerce-PaymentMethod input.input-radio:checked + label::before` |
| `wrapperMargin` | spacing | Margin | `margin` on `ul.woocommerce-PaymentMethods` |
| `wrapperPadding` | spacing | Padding | `padding` on `ul.woocommerce-PaymentMethods` |
| `wrapperBackgroundColor` | color | Background color | `background-color` on `ul.woocommerce-PaymentMethods` |
| `wrapperBorder` | border | Border | `border` on `ul.woocommerce-PaymentMethods` |
| `wrapperBoxShadow` | box-shadow | Box shadow | `box-shadow` on `ul.woocommerce-PaymentMethods` |
| `wrapperTypography` | typography | Typography | `font` on `ul.woocommerce-PaymentMethods` |
| `listMargin` | spacing | Margin | `margin` on `ul.woocommerce-PaymentMethods` |
| `listPadding` | spacing | Padding | `padding` on `ul.woocommerce-PaymentMethods` |
| `listBackgroundColor` | color | Background color | `background-color` on `ul.woocommerce-PaymentMethods` |
| `listBorder` | border | Border | `border` on `ul.woocommerce-PaymentMethods` |
| `listBoxShadow` | box-shadow | Box shadow | `box-shadow` on `ul.woocommerce-PaymentMethods` |
| `listTypography` | typography | Typography | `font` on `ul.woocommerce-PaymentMethods` |
| `itemMargin` | spacing | Margin | `margin` on `ul.woocommerce-PaymentMethods li.woocommerce-PaymentMethod` |
| `itemPadding` | spacing | Padding | `padding` on `ul.woocommerce-PaymentMethods li.woocommerce-PaymentMethod` |
| `itemBackgroundColor` | color | Background color | `background-color` on `ul.woocommerce-PaymentMethods li.woocommerce-PaymentMethod` |
| `itemBorder` | border | Border | `border` on `ul.woocommerce-PaymentMethods li.woocommerce-PaymentMethod` |
| `itemBoxShadow` | box-shadow | Box shadow | `box-shadow` on `ul.woocommerce-PaymentMethods li.woocommerce-PaymentMethod` |
| `itemTypography` | typography | Typography | `font` on `ul.woocommerce-PaymentMethods li.woocommerce-PaymentMethod` |
| `labelMargin` | spacing | Margin | `margin` on `ul.woocommerce-PaymentMethods li.woocommerce-PaymentMethod label` |
| `labelPadding` | spacing | Padding | `padding` on `ul.woocommerce-PaymentMethods li.woocommerce-PaymentMethod label` |
| `labelBackgroundColor` | color | Background color | `background-color` on `ul.woocommerce-PaymentMethods li.woocommerce-PaymentMethod label` |
| `labelBorder` | border | Border | `border` on `ul.woocommerce-PaymentMethods li.woocommerce-PaymentMethod label` |
| `labelBoxShadow` | box-shadow | Box shadow | `box-shadow` on `ul.woocommerce-PaymentMethods li.woocommerce-PaymentMethod label` |
| `labelTypography` | typography | Typography | `font` on `ul.woocommerce-PaymentMethods li.woocommerce-PaymentMethod label` |
| `paymentBoxMargin` | spacing | Margin | `margin` on `ul.woocommerce-PaymentMethods .woocommerce-PaymentBox` |
| `paymentBoxPadding` | spacing | Padding | `padding` on `ul.woocommerce-PaymentMethods .woocommerce-PaymentBox` |
| `paymentBoxBackgroundColor` | color | Background color | `background-color` on `ul.woocommerce-PaymentMethods .woocommerce-PaymentBox` |
| `paymentBoxBorder` | border | Border | `border` on `ul.woocommerce-PaymentMethods .woocommerce-PaymentBox` |
| `paymentBoxBoxShadow` | box-shadow | Box shadow | `box-shadow` on `ul.woocommerce-PaymentMethods .woocommerce-PaymentBox` |
| `paymentBoxTypography` | typography | Typography | `font` on `ul.woocommerce-PaymentMethods .woocommerce-PaymentBox` |
| `buttonMargin` | spacing | Margin | `margin` on `.woocommerce-Payment .form-row .woocommerce-Button` |
| `buttonPadding` | spacing | Padding | `padding` on `.woocommerce-Payment .form-row .woocommerce-Button` |
| `buttonBackgroundColor` | color | Background color | `background-color` on `.woocommerce-Payment .form-row .woocommerce-Button` |
| `buttonBorder` | border | Border | `border` on `.woocommerce-Payment .form-row .woocommerce-Button` |
| `buttonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-Payment .form-row .woocommerce-Button` |
| `buttonTypography` | typography | Typography | `font` on `.woocommerce-Payment .form-row .woocommerce-Button` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - Addresses Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-addresses/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-addresses |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-addresses.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `addressesDirection` | direction | Direction | `flex-direction` on `.woocommerce-Addresses` |
| `addressesGap` | number | Gap | `gap` on `.woocommerce-Addresses` |
| `wrapperMargin` | spacing | Margin | `margin` on `.woocommerce-Address` |
| `wrapperPadding` | spacing | Padding | `padding` on `.woocommerce-Address` |
| `wrapperBackgroundColor` | color | Background color | `background-color` on `.woocommerce-Address` |
| `wrapperBorder` | border | Border | `border` on `.woocommerce-Address` |
| `wrapperBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-Address` |
| `wrapperTypography` | typography | Typography | `font` on `.woocommerce-Address` |
| `titleMargin` | spacing | Margin | `margin` on `.woocommerce-Address-title h2` |
| `titlePadding` | spacing | Padding | `padding` on `.woocommerce-Address-title h2` |
| `titleBackgroundColor` | color | Background color | `background-color` on `.woocommerce-Address-title h2` |
| `titleBorder` | border | Border | `border` on `.woocommerce-Address-title h2` |
| `titleBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-Address-title h2` |
| `titleTypography` | typography | Typography | `font` on `.woocommerce-Address-title h2` |
| `editLinkMargin` | spacing | Margin | `margin` on `.edit` |
| `editLinkPadding` | spacing | Padding | `padding` on `.edit` |
| `editLinkBackgroundColor` | color | Background color | `background-color` on `.edit` |
| `editLinkBorder` | border | Border | `border` on `.edit` |
| `editLinkBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.edit` |
| `editLinkTypography` | typography | Typography | `font` on `.edit` |
| `addressMargin` | spacing | Margin | `margin` on `address` |
| `addressPadding` | spacing | Padding | `padding` on `address` |
| `addressBackgroundColor` | color | Background color | `background-color` on `address` |
| `addressBorder` | border | Border | `border` on `address` |
| `addressBoxShadow` | box-shadow | Box shadow | `box-shadow` on `address` |
| `addressTypography` | typography | Typography | `font` on `address` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - Downloads Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-downloads/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-downloads |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-downloads.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `tableBackgroundColor` | color | Background color | `background-color` on `.woocommerce-table--order-downloads` |
| `tableBorder` | border | Border | `border` on `.woocommerce-table--order-downloads` |
| `tableBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-table--order-downloads` |
| `tableTypography` | typography | Typography | `font` on `.woocommerce-table--order-downloads` |
| `theadPadding` | spacing | Padding | `padding` on `thead th, tbody td::before` |
| `theadBackgroundColor` | color | Background color | `background-color` on `thead th, tbody td::before` |
| `theadBorder` | border | Border | `border` on `thead th, tbody td::before` |
| `theadTypography` | typography | Typography | `font` on `thead th, tbody td::before` |
| `tbodyPadding` | spacing | Padding | `padding` on `tbody td` |
| `tbodyBackgroundColor` | color | Background color | `background-color` on `tbody td` |
| `tbodyBorder` | border | Border | `border` on `tbody td` |
| `tbodyTypography` | typography | Typography | `font` on `tbody td` |
| `tbodyLinksMargin` | spacing | Margin | `margin` on `tbody td a:not(.woocommerce-MyAccount-downloads-file.button)` |
| `tbodyLinksPadding` | spacing | Padding | `padding` on `tbody td a:not(.woocommerce-MyAccount-downloads-file.button)` |
| `tbodyLinksBackgroundColor` | color | Background color | `background-color` on `tbody td a:not(.woocommerce-MyAccount-downloads-file.button)` |
| `tbodyLinksBorder` | border | Border | `border` on `tbody td a:not(.woocommerce-MyAccount-downloads-file.button)` |
| `tbodyLinksBoxShadow` | box-shadow | Box shadow | `box-shadow` on `tbody td a:not(.woocommerce-MyAccount-downloads-file.button)` |
| `tbodyLinksTypography` | typography | Typography | `font` on `tbody td a:not(.woocommerce-MyAccount-downloads-file.button)` |
| `buttonPadding` | spacing | Padding | `padding` on `.woocommerce-MyAccount-downloads-file.button` |
| `buttonBackgroundColor` | color | Background color | `background-color` on `.woocommerce-MyAccount-downloads-file.button` |
| `buttonBorder` | border | Border | `border` on `.woocommerce-MyAccount-downloads-file.button` |
| `buttonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-MyAccount-downloads-file.button` |
| `buttonTypography` | typography | Typography | `font` on `.woocommerce-MyAccount-downloads-file.button` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - Edit Account Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-form-edit-account/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-form-edit-account |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-form-edit-account.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `labelTypography` | typography | Label typography | `font` on `label[for]` |
| `fieldsInputMargin` | spacing | Margin | `margin` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputPadding` | spacing | Padding | `padding` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBackgroundColor` | color | Background color | `background-color` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBorder` | border | Border | `border` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBoxShadow` | box-shadow | Box shadow | `box-shadow` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputTypography` | typography | Typography | `font` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `submitButtonWidth` | number | Width | `width` on `button[type=submit]` |
| `submitButtonMargin` | spacing | Margin | `margin` on `button[type=submit]` |
| `submitButtonPadding` | spacing | Padding | `padding` on `button[type=submit]` |
| `submitButtonBackgroundColor` | color | Background color | `background-color` on `button[type=submit]` |
| `submitButtonBorder` | border | Border | `border` on `button[type=submit]` |
| `submitButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `button[type=submit]` |
| `submitButtonTypography` | typography | Typography | `font` on `button[type=submit]` |
| `fieldsetGap` | number | Gap | `gap` on `fieldset` |
| `fieldsetMargin` | spacing | Margin | `margin` on `fieldset` |
| `fieldsetPadding` | spacing | Padding | `padding` on `fieldset` |
| `fieldsetBackgroundColor` | color | Background color | `background-color` on `fieldset` |
| `fieldsetBorder` | border | Border | `border` on `fieldset` |
| `fieldsetBoxShadow` | box-shadow | Box shadow | `box-shadow` on `fieldset` |
| `fieldsetTypography` | typography | Typography | `font` on `fieldset` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - Edit Address Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-form-edit-address/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-form-edit-address |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-form-edit-address.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `titleHide` | checkbox | Hide | `display` on `> form > h2` |
| `titleMargin` | spacing | Margin | `margin` on `> form > h2` |
| `titlePadding` | spacing | Padding | `padding` on `> form > h2` |
| `titleBackgroundColor` | color | Background color | `background-color` on `> form > h2` |
| `titleBorder` | border | Border | `border` on `> form > h2` |
| `titleBoxShadow` | box-shadow | Box shadow | `box-shadow` on `> form > h2` |
| `titleTypography` | typography | Typography | `font` on `> form > h2` |
| `labelTypography` | typography | Label typography | `font` on `label[for]` |
| `placeholderTypography` | typography | Placeholder typography | `font` on `::placeholder`, `font` on `select` |
| `fieldsInputMargin` | spacing | Margin | `margin` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputPadding` | spacing | Padding | `padding` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBackgroundColor` | color | Background color | `background-color` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBorder` | border | Border | `border` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBoxShadow` | box-shadow | Box shadow | `box-shadow` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputTypography` | typography | Typography | `font` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `submitButtonWidth` | number | Width | `width` on `button[type=submit]` |
| `submitButtonMargin` | spacing | Margin | `margin` on `button[type=submit]` |
| `submitButtonPadding` | spacing | Padding | `padding` on `button[type=submit]` |
| `submitButtonBackgroundColor` | color | Background color | `background-color` on `button[type=submit]` |
| `submitButtonBorder` | border | Border | `border` on `button[type=submit]` |
| `submitButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `button[type=submit]` |
| `submitButtonTypography` | typography | Typography | `font` on `button[type=submit]` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - Login Form Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-form-login/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-form-login |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-form-login.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `rememberMeDisable` | checkbox | Disable | — |
| `rememberMeTypography` | typography | Typography | `font` on `.woocommerce-form-login__rememberme` |
| `lostPasswordDisable` | checkbox | Disable | — |
| `lostPasswordTypography` | typography | Typography | `font` on `.woocommerce-LostPassword a` |
| `fieldsAlignItems` | align-items | Align items | `align-items` |
| `fieldsWidth` | number | Width | `width` on `.password-input, .woocommerce-Input` |
| `fieldsGap` | number | Gap | `gap` |
| `labelTypography` | typography | Label typography | `font` on `label[for]` |
| `fieldsInputMargin` | spacing | Margin | `margin` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputPadding` | spacing | Padding | `padding` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBackgroundColor` | color | Background color | `background-color` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBorder` | border | Border | `border` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBoxShadow` | box-shadow | Box shadow | `box-shadow` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputTypography` | typography | Typography | `font` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `submitButtonWidth` | number | Width | `width` on `button[type=submit]` |
| `submitButtonMargin` | spacing | Margin | `margin` on `button[type=submit]` |
| `submitButtonPadding` | spacing | Padding | `padding` on `button[type=submit]` |
| `submitButtonBackgroundColor` | color | Background color | `background-color` on `button[type=submit]` |
| `submitButtonBorder` | border | Border | `border` on `button[type=submit]` |
| `submitButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `button[type=submit]` |
| `submitButtonTypography` | typography | Typography | `font` on `button[type=submit]` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - Lost Password Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-form-lost-password/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-form-lost-password |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-form-lost-password.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `messageDisable` | checkbox | Disable | `display` on `form > p:first-child` |
| `messageTypography` | typography | Typography | `font` on `form > p:first-child` |
| `fieldsAlignItems` | align-items | Align items | `align-items` |
| `fieldsWidth` | number | Width | `width` on `.password-input, .woocommerce-Input` |
| `fieldsGap` | number | Gap | `gap` |
| `labelTypography` | typography | Label typography | `font` on `label[for]` |
| `fieldsInputMargin` | spacing | Margin | `margin` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputPadding` | spacing | Padding | `padding` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBackgroundColor` | color | Background color | `background-color` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBorder` | border | Border | `border` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBoxShadow` | box-shadow | Box shadow | `box-shadow` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputTypography` | typography | Typography | `font` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `submitButtonWidth` | number | Width | `width` on `button[type=submit]` |
| `submitButtonMargin` | spacing | Margin | `margin` on `button[type=submit]` |
| `submitButtonPadding` | spacing | Padding | `padding` on `button[type=submit]` |
| `submitButtonBackgroundColor` | color | Background color | `background-color` on `button[type=submit]` |
| `submitButtonBorder` | border | Border | `border` on `button[type=submit]` |
| `submitButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `button[type=submit]` |
| `submitButtonTypography` | typography | Typography | `font` on `button[type=submit]` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - Register Form Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-form-register/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-form-register |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-form-register.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `generatePasswordTypography` | typography | Typography | `font` on `.generate-password-text` |
| `privacyPolicyTypography` | typography | Typography | `font` on `.woocommerce-privacy-policy-text` |
| `privacyPolicyLink` | typography | Link | `font` on `.woocommerce-privacy-policy-text a` |
| `fieldsAlignItems` | align-items | Align items | `align-items` |
| `fieldsWidth` | number | Width | `width` on `.password-input, .woocommerce-Input` |
| `fieldsGap` | number | Gap | `gap` |
| `labelTypography` | typography | Label typography | `font` on `label[for]` |
| `fieldsInputMargin` | spacing | Margin | `margin` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputPadding` | spacing | Padding | `padding` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBackgroundColor` | color | Background color | `background-color` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBorder` | border | Border | `border` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBoxShadow` | box-shadow | Box shadow | `box-shadow` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputTypography` | typography | Typography | `font` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `submitButtonWidth` | number | Width | `width` on `button[type=submit]` |
| `submitButtonMargin` | spacing | Margin | `margin` on `button[type=submit]` |
| `submitButtonPadding` | spacing | Padding | `padding` on `button[type=submit]` |
| `submitButtonBackgroundColor` | color | Background color | `background-color` on `button[type=submit]` |
| `submitButtonBorder` | border | Border | `border` on `button[type=submit]` |
| `submitButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `button[type=submit]` |
| `submitButtonTypography` | typography | Typography | `font` on `button[type=submit]` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - Reset Password Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-form-reset-password/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-form-reset-password |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-form-reset-password.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `messageDisable` | checkbox | Disable | `display` on `form > p:first-child` |
| `messageTypography` | typography | Typography | `font` on `form > p:first-child` |
| `fieldsAlignItems` | align-items | Align items | `align-items` |
| `fieldsWidth` | number | Width | `width` on `.password-input, .woocommerce-Input` |
| `fieldsGap` | number | Gap | `gap` |
| `labelTypography` | typography | Label typography | `font` on `label[for]` |
| `fieldsInputMargin` | spacing | Margin | `margin` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputPadding` | spacing | Padding | `padding` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBackgroundColor` | color | Background color | `background-color` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBorder` | border | Border | `border` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBoxShadow` | box-shadow | Box shadow | `box-shadow` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputTypography` | typography | Typography | `font` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `submitButtonWidth` | number | Width | `width` on `button[type=submit]` |
| `submitButtonMargin` | spacing | Margin | `margin` on `button[type=submit]` |
| `submitButtonPadding` | spacing | Padding | `padding` on `button[type=submit]` |
| `submitButtonBackgroundColor` | color | Background color | `background-color` on `button[type=submit]` |
| `submitButtonBorder` | border | Border | `border` on `button[type=submit]` |
| `submitButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `button[type=submit]` |
| `submitButtonTypography` | typography | Typography | `font` on `button[type=submit]` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - Orders Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-orders/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-orders |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-orders.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `tableBackgroundColor` | color | Background color | `background-color` on `.woocommerce-orders-table` |
| `tableBorder` | border | Border | `border` on `.woocommerce-orders-table` |
| `tableBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-orders-table` |
| `tableTypography` | typography | Typography | `font` on `.woocommerce-orders-table` |
| `theadPadding` | spacing | Padding | `padding` on `.woocommerce-orders-table thead th, .woocommerce-orders-table tbody td::before, .woocommerce-orders-table tbody th::before` |
| `theadBackgroundColor` | color | Background color | `background-color` on `.woocommerce-orders-table thead th, .woocommerce-orders-table tbody td::before, .woocommerce-orders-table tbody th::before` |
| `theadBorder` | border | Border | `border` on `.woocommerce-orders-table thead th, .woocommerce-orders-table tbody td::before, .woocommerce-orders-table tbody th::before` |
| `theadTypography` | typography | Typography | `font` on `.woocommerce-orders-table thead th, .woocommerce-orders-table tbody td::before, .woocommerce-orders-table tbody th::before` |
| `tbodyPadding` | spacing | Padding | `padding` on `.woocommerce-orders-table tbody td` |
| `tbodyBackgroundColor` | color | Background color | `background-color` on `.woocommerce-orders-table tbody td` |
| `tbodyBorder` | border | Border | `border` on `.woocommerce-orders-table tbody td` |
| `tbodyTypography` | typography | Typography | `font` on `.woocommerce-orders-table tbody td` |
| `tbodyHeadingPadding` | spacing | Padding | `padding` on `.woocommerce-orders-table tbody th` |
| `tbodyHeadingBackgroundColor` | color | Background color | `background-color` on `.woocommerce-orders-table tbody th` |
| `tbodyHeadingBorder` | border | Border | `border` on `.woocommerce-orders-table tbody th` |
| `tbodyHeadingTypography` | typography | Typography | `font` on `.woocommerce-orders-table tbody th` |
| `tbodyLinksTypography` | typography | Typography | `font` on `.woocommerce-orders-table tbody td a:not(.woocommerce-button)` |
| `buttonPadding` | spacing | Padding | `padding` on `.woocommerce-orders-table a.woocommerce-button` |
| `buttonBackgroundColor` | color | Background color | `background-color` on `.woocommerce-orders-table a.woocommerce-button` |
| `buttonBorder` | border | Border | `border` on `.woocommerce-orders-table a.woocommerce-button` |
| `buttonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-orders-table a.woocommerce-button` |
| `buttonTypography` | typography | Typography | `font` on `.woocommerce-orders-table a.woocommerce-button` |
| `paginationMargin` | spacing | Margin | `margin` on `.woocommerce-pagination` |
| `paginationPadding` | spacing | Padding | `padding` on `.woocommerce-pagination` |
| `paginationBackgroundColor` | color | Background color | `background-color` on `.woocommerce-pagination` |
| `paginationBorder` | border | Border | `border` on `.woocommerce-pagination` |
| `paginationBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-pagination` |
| `paginationTypography` | typography | Typography | `font` on `.woocommerce-pagination` |
| `paginationButtonPadding` | spacing | Padding | `padding` on `.woocommerce-pagination a.woocommerce-button` |
| `paginationButtonBackgroundColor` | color | Background color | `background-color` on `.woocommerce-pagination a.woocommerce-button` |
| `paginationButtonBorder` | border | Border | `border` on `.woocommerce-pagination a.woocommerce-button` |
| `paginationButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-pagination a.woocommerce-button` |
| `paginationButtonTypography` | typography | Typography | `font` on `.woocommerce-pagination a.woocommerce-button` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - Page Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-page/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-page |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-page.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `direction` | direction | Direction | `flex-direction` on `.woocommerce:not(#brx-content)` |
| `gap` | number | Gap | `gap` on `.woocommerce:not(#brx-content)` |
| `disableNav` | checkbox | Disable navigation | — |
| `navDirection` | direction | Direction | `flex-direction` on `.woocommerce-MyAccount-navigation ul` |
| `navAlignItems` | align-items | Align items | `align-items` on `.woocommerce-MyAccount-navigation ul` |
| `navJustifyContent` | justify-content | Justify content | `justify-content` on `.woocommerce-MyAccount-navigation ul` |
| `navGap` | number | Gap | `gap` on `.woocommerce-MyAccount-navigation ul` |
| `navBackground` | color | Background | `background-color` on `.woocommerce-MyAccount-navigation` |
| `navBorder` | border | Border | `border` on `.woocommerce-MyAccount-navigation` |
| `navBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-MyAccount-navigation` |
| `navItemPadding` | spacing | Padding | `padding` on `.woocommerce-MyAccount-navigation a` |
| `navItemBackground` | color | Background | `background-color` on `.woocommerce-MyAccount-navigation a` |
| `navItemBorder` | border | Border | `border` on `.woocommerce-MyAccount-navigation a` |
| `navItemBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-MyAccount-navigation a` |
| `navItemTypogaphy` | typography | Typography | `font` on `.woocommerce-MyAccount-navigation a` |
| `navItemBackgroundActive` | color | Background | `background-color` on `.woocommerce-MyAccount-navigation .is-active a` |
| `navItemBorderActive` | border | Border | `border` on `.woocommerce-MyAccount-navigation .is-active a` |
| `navItemBoxShadowActive` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-MyAccount-navigation .is-active a` |
| `navItemTypogaphyActive` | typography | Typography | `font` on `.woocommerce-MyAccount-navigation .is-active a` |
| `contentPadding` | spacing | Padding | `padding` on `.woocommerce-MyAccount-content` |
| `contentBackground` | color | Background | `background-color` on `.woocommerce-MyAccount-content` |
| `contentBorder` | border | Border | `border` on `.woocommerce-MyAccount-content` |
| `contentBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-MyAccount-content` |
| `contentTypogaphy` | typography | Typography | `font` on `.woocommerce-MyAccount-content` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - Payment Methods Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-payment-methods/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-payment-methods |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-payment-methods.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `tableBackgroundColor` | color | Background color | `background-color` on `.woocommerce-MyAccount-paymentMethods` |
| `tableBorder` | border | Border | `border` on `.woocommerce-MyAccount-paymentMethods` |
| `tableBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-MyAccount-paymentMethods` |
| `tableTypography` | typography | Typography | `font` on `.woocommerce-MyAccount-paymentMethods` |
| `theadPadding` | spacing | Padding | `padding` on `.woocommerce-MyAccount-paymentMethods thead th` |
| `theadBackgroundColor` | color | Background color | `background-color` on `.woocommerce-MyAccount-paymentMethods thead th` |
| `theadBorder` | border | Border | `border` on `.woocommerce-MyAccount-paymentMethods thead th` |
| `theadTypography` | typography | Typography | `font` on `.woocommerce-MyAccount-paymentMethods thead th` |
| `tbodyPadding` | spacing | Padding | `padding` on `.woocommerce-MyAccount-paymentMethods tbody td` |
| `tbodyBackgroundColor` | color | Background color | `background-color` on `.woocommerce-MyAccount-paymentMethods tbody td` |
| `tbodyBorder` | border | Border | `border` on `.woocommerce-MyAccount-paymentMethods tbody td` |
| `tbodyTypography` | typography | Typography | `font` on `.woocommerce-MyAccount-paymentMethods tbody td` |
| `deleteButtonPadding` | spacing | Padding | `padding` on `.woocommerce-MyAccount-paymentMethods tbody td .button.delete` |
| `deleteButtonBackgroundColor` | color | Background color | `background-color` on `.woocommerce-MyAccount-paymentMethods tbody td .button.delete` |
| `deleteButtonBorder` | border | Border | `border` on `.woocommerce-MyAccount-paymentMethods tbody td .button.delete` |
| `deleteButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-MyAccount-paymentMethods tbody td .button.delete` |
| `deleteButtonTypography` | typography | Typography | `font` on `.woocommerce-MyAccount-paymentMethods tbody td .button.delete` |
| `makeDefaultButtonPadding` | spacing | Padding | `padding` on `.woocommerce-MyAccount-paymentMethods tbody td .button.default` |
| `makeDefaultButtonBackgroundColor` | color | Background color | `background-color` on `.woocommerce-MyAccount-paymentMethods tbody td .button.default` |
| `makeDefaultButtonBorder` | border | Border | `border` on `.woocommerce-MyAccount-paymentMethods tbody td .button.default` |
| `makeDefaultButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-MyAccount-paymentMethods tbody td .button.default` |
| `makeDefaultButtonTypography` | typography | Typography | `font` on `.woocommerce-MyAccount-paymentMethods tbody td .button.default` |
| `addButtonMargin` | spacing | Margin | `margin` on `> a.button` |
| `addButtonPadding` | spacing | Padding | `padding` on `> a.button` |
| `addButtonBackgroundColor` | color | Background color | `background-color` on `> a.button` |
| `addButtonBorder` | border | Border | `border` on `> a.button` |
| `addButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `> a.button` |
| `addButtonTypography` | typography | Typography | `font` on `> a.button` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Account - View Order Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-account-view-order/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-account-view-order |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-account-view-order.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `previewOrderId` | number | Preview order ID | — |
| `orderInfoHide` | checkbox | Hide | `display` on `> p:first-child` |
| `orderInfoTypography` | typography | Typography | `font` on `> p:first-child` |
| `orderMarkPadding` | spacing | Padding | `padding` on `mark` |
| `orderMarkBackgroundColor` | color | Background color | `background-color` on `mark` |
| `orderMarkTypography` | typography | Typography | `font` on `mark` |
| `notesTitleHide` | checkbox | Hide | `display` on `> h2` |
| `orderDetailsTfootHeadingTypography` | typography | Typography | `typography` on `.woocommerce-order-details tfoot th` |
| `orderAgainButtonWidth` | number | Width | `width` on `.order-again a.button` |
| `notesMargin` | spacing | Margin | `margin` on `.woocommerce-OrderUpdates` |
| `notesPadding` | spacing | Padding | `padding` on `.woocommerce-OrderUpdates` |
| `notesBackgroundColor` | color | Background color | `background-color` on `.woocommerce-OrderUpdates` |
| `notesBorder` | border | Border | `border` on `.woocommerce-OrderUpdates` |
| `notesBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-OrderUpdates` |
| `notesTypography` | typography | Typography | `font` on `.woocommerce-OrderUpdates` |
| `notesTitleMargin` | spacing | Margin | `margin` on `> h2` |
| `notesTitlePadding` | spacing | Padding | `padding` on `> h2` |
| `notesTitleBackgroundColor` | color | Background color | `background-color` on `> h2` |
| `notesTitleBorder` | border | Border | `border` on `> h2` |
| `notesTitleBoxShadow` | box-shadow | Box shadow | `box-shadow` on `> h2` |
| `notesTitleTypography` | typography | Typography | `font` on `> h2` |
| `notesMetaMargin` | spacing | Margin | `margin` on `.woocommerce-OrderUpdate-meta` |
| `notesMetaPadding` | spacing | Padding | `padding` on `.woocommerce-OrderUpdate-meta` |
| `notesMetaBackgroundColor` | color | Background color | `background-color` on `.woocommerce-OrderUpdate-meta` |
| `notesMetaBorder` | border | Border | `border` on `.woocommerce-OrderUpdate-meta` |
| `notesMetaBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-OrderUpdate-meta` |
| `notesMetaTypography` | typography | Typography | `font` on `.woocommerce-OrderUpdate-meta` |
| `notesDescriptionMargin` | spacing | Margin | `margin` on `.woocommerce-OrderUpdate-description` |
| `notesDescriptionPadding` | spacing | Padding | `padding` on `.woocommerce-OrderUpdate-description` |
| `notesDescriptionBackgroundColor` | color | Background color | `background-color` on `.woocommerce-OrderUpdate-description` |
| `notesDescriptionBorder` | border | Border | `border` on `.woocommerce-OrderUpdate-description` |
| `notesDescriptionBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-OrderUpdate-description` |
| `notesDescriptionTypography` | typography | Typography | `font` on `.woocommerce-OrderUpdate-description` |
| `downloadsMargin` | spacing | Margin | `margin` on `.woocommerce-table--order-downloads` |
| `downloadsPadding` | spacing | Padding | `padding` on `.woocommerce-table--order-downloads` |
| `downloadsBackgroundColor` | color | Background color | `background-color` on `.woocommerce-table--order-downloads` |
| `downloadsBorder` | border | Border | `border` on `.woocommerce-table--order-downloads` |
| `downloadsBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-table--order-downloads` |
| `downloadsTypography` | typography | Typography | `font` on `.woocommerce-table--order-downloads` |
| `downloadsTitleMargin` | spacing | Margin | `margin` on `.woocommerce-order-downloads__title` |
| `downloadsTitlePadding` | spacing | Padding | `padding` on `.woocommerce-order-downloads__title` |
| `downloadsTitleBackgroundColor` | color | Background color | `background-color` on `.woocommerce-order-downloads__title` |
| `downloadsTitleBorder` | border | Border | `border` on `.woocommerce-order-downloads__title` |
| `downloadsTitleBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-order-downloads__title` |
| `downloadsTitleTypography` | typography | Typography | `font` on `.woocommerce-order-downloads__title` |
| `downloadsTheadPadding` | spacing | Padding | `padding` on `.woocommerce-order-downloads thead th, .woocommerce-order-downloads tbody td::before` |
| `downloadsTheadBackgroundColor` | color | Background color | `background-color` on `.woocommerce-order-downloads thead th, .woocommerce-order-downloads tbody td::before` |
| `downloadsTheadBorder` | border | Border | `border` on `.woocommerce-order-downloads thead th, .woocommerce-order-downloads tbody td::before` |
| `downloadsTheadTypography` | typography | Typography | `font` on `.woocommerce-order-downloads thead th, .woocommerce-order-downloads tbody td::before` |
| `downloadsTbodyPadding` | spacing | Padding | `padding` on `.woocommerce-order-downloads tbody td` |
| `downloadsTbodyBackgroundColor` | color | Background color | `background-color` on `.woocommerce-order-downloads tbody td` |
| `downloadsTbodyBorder` | border | Border | `border` on `.woocommerce-order-downloads tbody td` |
| `downloadsTbodyTypography` | typography | Typography | `font` on `.woocommerce-order-downloads tbody td` |
| `downloadsButtonMargin` | spacing | Margin | `margin` on `.woocommerce-MyAccount-downloads-file.button` |
| `downloadsButtonPadding` | spacing | Padding | `padding` on `.woocommerce-MyAccount-downloads-file.button` |
| `downloadsButtonBackgroundColor` | color | Background color | `background-color` on `.woocommerce-MyAccount-downloads-file.button` |
| `downloadsButtonBorder` | border | Border | `border` on `.woocommerce-MyAccount-downloads-file.button` |
| `downloadsButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-MyAccount-downloads-file.button` |
| `downloadsButtonTypography` | typography | Typography | `font` on `.woocommerce-MyAccount-downloads-file.button` |
| `orderDetailsMargin` | spacing | Margin | `margin` on `.woocommerce-order-details` |
| `orderDetailsPadding` | spacing | Padding | `padding` on `.woocommerce-order-details` |
| `orderDetailsBackgroundColor` | color | Background color | `background-color` on `.woocommerce-order-details` |
| `orderDetailsBorder` | border | Border | `border` on `.woocommerce-order-details` |
| `orderDetailsBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-order-details` |
| `orderDetailsTypography` | typography | Typography | `font` on `.woocommerce-order-details` |
| `orderDetailsTitleMargin` | spacing | Margin | `margin` on `.woocommerce-order-details__title` |
| `orderDetailsTitlePadding` | spacing | Padding | `padding` on `.woocommerce-order-details__title` |
| `orderDetailsTitleBackgroundColor` | color | Background color | `background-color` on `.woocommerce-order-details__title` |
| `orderDetailsTitleBorder` | border | Border | `border` on `.woocommerce-order-details__title` |
| `orderDetailsTitleBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-order-details__title` |
| `orderDetailsTitleTypography` | typography | Typography | `font` on `.woocommerce-order-details__title` |
| `orderDetailsTbodyPadding` | spacing | Padding | `padding` on `.woocommerce-order-details tbody td` |
| `orderDetailsTbodyBackgroundColor` | color | Background color | `background-color` on `.woocommerce-order-details tbody td` |
| `orderDetailsTbodyBorder` | border | Border | `border` on `.woocommerce-order-details tbody td` |
| `orderDetailsTbodyTypography` | typography | Typography | `font` on `.woocommerce-order-details tbody td` |
| `orderDetailsTfootPadding` | spacing | Padding | `padding` on `.woocommerce-order-details tfoot` |
| `orderDetailsTfootBackgroundColor` | color | Background color | `background-color` on `.woocommerce-order-details tfoot` |
| `orderDetailsTfootBorder` | border | Border | `border` on `.woocommerce-order-details tfoot` |
| `orderDetailsTfootTypography` | typography | Typography | `font` on `.woocommerce-order-details tfoot` |
| `orderAgainButtonMargin` | spacing | Margin | `margin` on `.order-again a.button` |
| `orderAgainButtonPadding` | spacing | Padding | `padding` on `.order-again a.button` |
| `orderAgainButtonBackgroundColor` | color | Background color | `background-color` on `.order-again a.button` |
| `orderAgainButtonBorder` | border | Border | `border` on `.order-again a.button` |
| `orderAgainButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.order-again a.button` |
| `orderAgainButtonTypography` | typography | Typography | `font` on `.order-again a.button` |
| `customerDetailsMargin` | spacing | Margin | `margin` on `.woocommerce-customer-details` |
| `customerDetailsPadding` | spacing | Padding | `padding` on `.woocommerce-customer-details` |
| `customerDetailsBackgroundColor` | color | Background color | `background-color` on `.woocommerce-customer-details` |
| `customerDetailsBorder` | border | Border | `border` on `.woocommerce-customer-details` |
| `customerDetailsBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-customer-details` |
| `customerDetailsTypography` | typography | Typography | `font` on `.woocommerce-customer-details` |
| `customerDetailsTitleMargin` | spacing | Margin | `margin` on `.woocommerce-customer-details h2` |
| `customerDetailsTitlePadding` | spacing | Padding | `padding` on `.woocommerce-customer-details h2` |
| `customerDetailsTitleBackgroundColor` | color | Background color | `background-color` on `.woocommerce-customer-details h2` |
| `customerDetailsTitleBorder` | border | Border | `border` on `.woocommerce-customer-details h2` |
| `customerDetailsTitleBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-customer-details h2` |
| `customerDetailsTitleTypography` | typography | Typography | `font` on `.woocommerce-customer-details h2` |
| `customerDetailsAddressMargin` | spacing | Margin | `margin` on `.woocommerce-customer-details address` |
| `customerDetailsAddressPadding` | spacing | Padding | `padding` on `.woocommerce-customer-details address` |
| `customerDetailsAddressBackgroundColor` | color | Background color | `background-color` on `.woocommerce-customer-details address` |
| `customerDetailsAddressBorder` | border | Border | `border` on `.woocommerce-customer-details address` |
| `customerDetailsAddressBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-customer-details address` |
| `customerDetailsAddressTypography` | typography | Typography | `font` on `.woocommerce-customer-details address` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Breadcrumbs (WooCommerce) Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-breadcrumbs/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-breadcrumbs |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-breadcrumbs.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `beforeLabel` | text | Before | — |
| `homeURL` | text | Home | — |
| `homeLabel` | text | Home | — |
| `homeIcon` | icon | Home | `—` on `svg.home` |
| `homeIconGap` | number | Home | `gap` on `.navigation > a:has(.home)` |
| `homeIconSize` | number | Home | `font-size` on `i.home`, `width` on `svg.home`, `height` on `svg.home` |
| `hideHomeLabel` | checkbox | Hide label | — |
| `prefix` | text | Prefix | — |
| `suffix` | text | Suffix | — |
| `separatorType` | select | Type | — |
| `separatorText` | text | Separator | — |
| `separatorIcon` | icon | Icon | `—` on `svg.separator` |
| `separatorIconTypography` | typography | Icon typography | `font` on `.separator` |
| `separatorGap` | number | Gap | `gap` on `.navigation` |
| `separatorMargin` | spacing | Margin | `margin` on `.separator` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Cart Totals Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-cart-collaterals/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-cart-collaterals |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-cart-collaterals.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `disableCrossSells` | checkbox | Disable cross sells | — |
| `hideTitle` | checkbox | Hide title | `display` on `h2` |
| `titleTypography` | typography | Title | `font` on `h2` |
| `subtotalTypography` | typography | Subtotal | `font` on `.cart-subtotal` |
| `totalTypography` | typography | Total | `font` on `.order-total` |
| `tableMargin` | spacing | Margin | `margin` on `table`, `margin` on `table` |
| `tablePadding` | spacing | Padding | `padding` on `table tbody th`, `padding` on `table tbody td` |
| `tableBorder` | border | Border | `border` on `table` |
| `buttonText` | text | buttonText | — |
| `buttonWidth` | number | Width | `width` on `.wc-proceed-to-checkout .button` |
| `buttonBackground` | color | Background | `background-color` on `.wc-proceed-to-checkout .button` |
| `buttonBorder` | border | Border | `border` on `.wc-proceed-to-checkout .button` |
| `buttonTypography` | typography | Typography | `font` on `.wc-proceed-to-checkout .button` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Cart Coupon Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-cart-coupon/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-cart-coupon |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-cart-coupon.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `ajaxUpdate` | checkbox | Update cart via AJAX | — |
| `direction` | direction | Direction | `flex-direction` on `.coupon` |
| `inputPlaceholder` | text | Placeholder | — |
| `inputWidth` | number | Width | `width` on `.coupon input` |
| `inputBackground` | color | Background color | `background-color` on `.coupon input` |
| `inputBorder` | border | Border | `border` on `.coupon input` |
| `inputPlaceholderTypography` | typography | Placeholder typography | `font` on `.coupon input::placeholder` |
| `buttonSeperator` | text | Button | — |
| `buttonText` | text | Text | — |
| `buttonWidth` | number | Width | `width` on `.coupon button` |
| `buttonMargin` | spacing | Margin | `margin` on `.coupon button` |
| `buttonBackground` | color | Background color | `background-color` on `.coupon button` |
| `buttonBorder` | border | Border | `border` on `.coupon button` |
| `buttonTypography` | typography | Typography | `font` on `.coupon button` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Cart Items Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-cart-items/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-cart-items |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-cart-items.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `itemLinkDisable` | checkbox | Disable link | — |
| `headHide` | checkbox | Hide | `display` on `thead` |
| `headBackground` | color | Background | `background-color` on `thead` |
| `headBorder` | border | Border | `border` on `thead` |
| `headTypography` | typography | Typography | `font` on `thead th` |
| `bodyBackground` | color | Background | `background-color` on `tbody` |
| `bodyBorder` | border | Border | `border` on `tbody tr` |
| `imageDisable` | checkbox | Disable | — |
| `width` | number | Width | `width` on `.product-thumbnail img` |
| `imageHeight` | number | Height | `height` on `.product-thumbnail img` |
| `imageSize` | select | Size | — |
| `removeColor` | color | Color | `color` on `.product-remove a` |
| `removeSize` | number | Size | `font-size` on `.product-remove a` |
| `removePosition` | dimensions | Position | `—` on `.product-remove`, `position` on `.product-remove` |
| `buttonsTypography` | typography | Typography | `font` on `.button` |
| `buttonsBackground` | color | Background color | `background-color` on `.button` |
| `buttonsBorder` | border | Border | `border` on `.button` |
| `hideCoupon` | checkbox | Hide | — |
| `couponMargin` | spacing | Margin | `margin` on `.coupon` |
| `removeHide` | checkbox | Hide Remove | `display` on `.product-remove` |
| `thumbnailHide` | checkbox | Hide Thumbnail | `display` on `.product-thumbnail` |
| `nameHide` | checkbox | Hide Name | `display` on `.product-name` |
| `priceHide` | checkbox | Hide Price | `display` on `.product-price` |
| `quantityHide` | checkbox | Hide Quantity | `display` on `.product-quantity` |
| `subtotalHide` | checkbox | Hide Subtotal | `display` on `.product-subtotal` |
| `nameTypography` | typography | Name typography | `font` on `tbody .product-name` |
| `priceTypography` | typography | Price typography | `font` on `tbody .product-price` |
| `quantityTypography` | typography | Quantity typography | `font` on `tbody .product-quantity` |
| `subtotalTypography` | typography | Subtotal typography | `font` on `tbody .product-subtotal` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Checkout Coupon Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-checkout-coupon/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-checkout-coupon |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-checkout-coupon.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `location` | select | Location | — |
| `toggleableForm` | checkbox | Toggleable form | — |
| `toggleText` | text | Text | — |
| `toggleDivJustifyContent` | justify-content | Justify content | `justify-content` on `.coupon-toggle` |
| `toggleDivGap` | number | Gap | `gap` on `.coupon-toggle` |
| `toggleButtonNoText` | checkbox | Disable text | — |
| `toggleButtonText` | text | Text | — |
| `toggleIcon` | icon | Icon | — |
| `toggleIconTypography` | typography | Icon typography | `font` on `.coupon-toggle .showcoupon i` |
| `disableCouponMessage` | checkbox | Disable coupon message | — |
| `couponMessage` | text | Coupon message | — |
| `fieldsWrapperFlexDirection` | direction | Flex direction | `flex-direction` on `.coupon-form` |
| `applyButtonText` | text | Button text | — |
| `toggleDivMargin` | spacing | Margin | `margin` on `.coupon-toggle` |
| `toggleDivPadding` | spacing | Padding | `padding` on `.coupon-toggle` |
| `toggleDivBackgroundColor` | color | Background color | `background-color` on `.coupon-toggle` |
| `toggleDivBorder` | border | Border | `border` on `.coupon-toggle` |
| `toggleDivBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.coupon-toggle` |
| `toggleDivTypography` | typography | Typography | `font` on `.coupon-toggle` |
| `toggleButtonMargin` | spacing | Margin | `margin` on `.coupon-toggle .showcoupon` |
| `toggleButtonPadding` | spacing | Padding | `padding` on `.coupon-toggle .showcoupon` |
| `toggleButtonBackgroundColor` | color | Background color | `background-color` on `.coupon-toggle .showcoupon` |
| `toggleButtonBorder` | border | Border | `border` on `.coupon-toggle .showcoupon` |
| `toggleButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.coupon-toggle .showcoupon` |
| `toggleButtonTypography` | typography | Typography | `font` on `.coupon-toggle .showcoupon` |
| `formWrapperMargin` | spacing | Margin | `margin` on `.coupon-div` |
| `formWrapperPadding` | spacing | Padding | `padding` on `.coupon-div` |
| `formWrapperBackgroundColor` | color | Background color | `background-color` on `.coupon-div` |
| `formWrapperBorder` | border | Border | `border` on `.coupon-div` |
| `formWrapperBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.coupon-div` |
| `formWrapperTypography` | typography | Typography | `font` on `.coupon-div` |
| `fieldsAlignItems` | align-items | Align items | `align-items` |
| `fieldsWidth` | number | Width | `width` on `.password-input, .woocommerce-Input` |
| `fieldsGap` | number | Gap | `gap` |
| `placeholderTypography` | typography | Placeholder typography | `font` on `::placeholder`, `font` on `select` |
| `fieldsInputMargin` | spacing | Margin | `margin` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputPadding` | spacing | Padding | `padding` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBackgroundColor` | color | Background color | `background-color` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBorder` | border | Border | `border` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBoxShadow` | box-shadow | Box shadow | `box-shadow` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputTypography` | typography | Typography | `font` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `submitButtonWidth` | number | Width | `width` on `button[type=submit]` |
| `submitButtonMargin` | spacing | Margin | `margin` on `button[type=submit]` |
| `submitButtonPadding` | spacing | Padding | `padding` on `button[type=submit]` |
| `submitButtonBackgroundColor` | color | Background color | `background-color` on `button[type=submit]` |
| `submitButtonBorder` | border | Border | `border` on `button[type=submit]` |
| `submitButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `button[type=submit]` |
| `submitButtonTypography` | typography | Typography | `font` on `button[type=submit]` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Checkout Customer Details Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-checkout-customer-details/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-checkout-customer-details |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-checkout-customer-details.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `removeBillingFields` | select | Remove billing fields | — |
| `removeShippingFields` | select | Remove shipping fields | — |
| `hideTitle` | checkbox | Hide | `display` on `.woocommerce-billing-fields h3` |
| `titleTypography` | typography | Typography | `font` on `.woocommerce-billing-fields h3` |
| `hideLabels` | checkbox | Hide | `display` on `.woocommerce-billing-fields__field-wrapper label, .woocommerce-shipping-fields__field-wrapper label` |
| `labelTypography` | typography | Typography | `font` on `.woocommerce-billing-fields__field-wrapper label, .woocommerce-shipping-fields__field-wrapper label` |
| `labelMargin` | spacing | Margin | `margin` on `.woocommerce-billing-fields__field-wrapper label, .woocommerce-shipping-fields__field-wrapper label` |
| `fieldTypography` | typography | Typography | `font` on `input:not([type=submit])`, `font` on `select`, `font` on `.select2-selection__rendered`, `font` on `textarea` |
| `placeholderTypography` | typography | Placeholder typography | `font` on `::placeholder` |
| `hideAdditionalInformation` | checkbox | Hide additional information | `display` on `.woocommerce-additional-fields` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Checkout Login Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-checkout-login/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-checkout-login |
| `category` | general |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-checkout-login.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `location` | select | Location | — |
| `toggleableForm` | checkbox | Toggleable form | — |
| `toggleText` | text | Text | — |
| `toggleDivJustifyContent` | justify-content | Justify content | `justify-content` on `.login-toggle` |
| `toggleDivGap` | number | Gap | `gap` on `.login-toggle` |
| `toggleButtonNoText` | checkbox | Disable text | — |
| `toggleButtonText` | text | Text | — |
| `toggleIcon` | icon | Icon | — |
| `toggleIconTypography` | typography | Icon typography | `font` on `.login-toggle .showlogin i` |
| `disableLoginMessage` | checkbox | Disable login message | — |
| `loginMessage` | text | Login message | — |
| `rememberMeDisable` | checkbox | Disable | — |
| `rememberMeTypography` | typography | Typography | `font` on `.woocommerce-form-login__rememberme` |
| `lostPasswordDisable` | checkbox | Disable | — |
| `lostPasswordTypography` | typography | Typography | `font` on `.woocommerce-LostPassword a` |
| `toggleDivMargin` | spacing | Margin | `margin` on `.login-toggle` |
| `toggleDivPadding` | spacing | Padding | `padding` on `.login-toggle` |
| `toggleDivBackgroundColor` | color | Background color | `background-color` on `.login-toggle` |
| `toggleDivBorder` | border | Border | `border` on `.login-toggle` |
| `toggleDivBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.login-toggle` |
| `toggleDivTypography` | typography | Typography | `font` on `.login-toggle` |
| `toggleButtonMargin` | spacing | Margin | `margin` on `.login-toggle .showlogin` |
| `toggleButtonPadding` | spacing | Padding | `padding` on `.login-toggle .showlogin` |
| `toggleButtonBackgroundColor` | color | Background color | `background-color` on `.login-toggle .showlogin` |
| `toggleButtonBorder` | border | Border | `border` on `.login-toggle .showlogin` |
| `toggleButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.login-toggle .showlogin` |
| `toggleButtonTypography` | typography | Typography | `font` on `.login-toggle .showlogin` |
| `formWrapperMargin` | spacing | Margin | `margin` on `.login-div` |
| `formWrapperPadding` | spacing | Padding | `padding` on `.login-div` |
| `formWrapperBackgroundColor` | color | Background color | `background-color` on `.login-div` |
| `formWrapperBorder` | border | Border | `border` on `.login-div` |
| `formWrapperBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.login-div` |
| `formWrapperTypography` | typography | Typography | `font` on `.login-div` |
| `fieldsAlignItems` | align-items | Align items | `align-items` |
| `fieldsGap` | number | Gap | `gap` |
| `labelTypography` | typography | Label typography | `font` on `label[for]` |
| `fieldsInputPadding` | spacing | Padding | `padding` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBackgroundColor` | color | Background color | `background-color` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBorder` | border | Border | `border` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputBoxShadow` | box-shadow | Box shadow | `box-shadow` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `fieldsInputTypography` | typography | Typography | `font` on `input, .woocommerce-Input, .select2-selection.select2-selection--single` |
| `submitButtonWidth` | number | Width | `width` on `button[type=submit]` |
| `submitButtonMargin` | spacing | Margin | `margin` on `button[type=submit]` |
| `submitButtonPadding` | spacing | Padding | `padding` on `button[type=submit]` |
| `submitButtonBackgroundColor` | color | Background color | `background-color` on `button[type=submit]` |
| `submitButtonBorder` | border | Border | `border` on `button[type=submit]` |
| `submitButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `button[type=submit]` |
| `submitButtonTypography` | typography | Typography | `font` on `button[type=submit]` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Checkout Order Payment Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-checkout-order-payment/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-checkout-order-payment |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-checkout-order-payment.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `previewOrderId` | number | Preview order ID | — |
| `paymentMargin` | spacing | Margin | `margin` on `#payment` |
| `paymentPadding` | spacing | Padding | `padding` on `#payment` |
| `paymentBackground` | color | Background | `background-color` on `#payment` |
| `paymentBorder` | border | Border | `border` on `#payment` |
| `paymentMethodLabelTypography` | typography | Label typography | `font` on `#payment .payment_methods label` |
| `paymentDescriptionMargin` | spacing | Margin | `margin` on `#payment .payment_methods .payment_box` |
| `paymentDescriptionPadding` | spacing | Padding | `padding` on `#payment .payment_methods .payment_box` |
| `paymentDescriptionBackground` | color | Background | `background-color` on `#payment .payment_methods .payment_box` |
| `paymentMethodDescriptionTypography` | typography | Typography | `font` on `#payment .payment_methods .payment_box` |
| `privacyMargin` | spacing | Margin | `margin` on `.woocommerce-privacy-policy-text` |
| `privacyTypography` | typography | Typography | `font` on `.woocommerce-privacy-policy-text` |
| `buttonWidth` | number | Width | `width` on `button[type="submit"]` |
| `buttonAlign` | align-items | Align | `align-self` on `button[type="submit"]` |
| `buttonMargin` | spacing | Margin | `margin` on `button[type="submit"]` |
| `buttonPadding` | spacing | Padding | `padding` on `button[type="submit"]` |
| `buttonBackground` | color | Background | `background-color` on `button[type="submit"]` |
| `buttonBorder` | border | Border | `border` on `button[type="submit"]` |
| `buttonTypography` | typography | Typography | `font` on `button[type="submit"]` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Checkout Order Review Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-checkout-order-review/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-checkout-order-review |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-checkout-order-review.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `hideTitle` | checkbox | Hide title | `display` on `#order_review_heading` |
| `orderTitle` | text | Title | — |
| `orderTitleTypography` | typography | Title typography | `font` on `#order_review_heading` |
| `orderSubtitlesTypography` | typography | Subtitles typography | `font` on `.shop_table thead`, `font` on `.shop_table tfoot` |
| `cartItemsTypography` | typography | Typography | `font` on `.shop_table tbody td` |
| `cartItemsPadding` | spacing | Padding | `padding` on `.shop_table thead th, .shop_table tbody td, .shop_table tfoot th, .shop_table tfoot td` |
| `cartItemsBorder` | border | Border | `border` on `.shop_table tbody td` |
| `paymentMargin` | spacing | Margin | `margin` on `#payment` |
| `paymentPadding` | spacing | Padding | `padding` on `#payment` |
| `paymentBackground` | color | Background | `background-color` on `#payment` |
| `paymentMethodLabelTypography` | typography | Label typography | `font` on `#payment .payment_methods label` |
| `paymentDescriptionMargin` | spacing | Margin | `margin` on `#payment .payment_methods .payment_box` |
| `paymentDescriptionPadding` | spacing | Padding | `padding` on `#payment .payment_methods .payment_box` |
| `paymentDescriptionBackground` | color | Background | `background-color` on `#payment .payment_methods .payment_box` |
| `paymentMethodDescriptionTypography` | typography | Typography | `font` on `#payment .payment_methods .payment_box` |
| `privacyMargin` | spacing | Margin | `margin` on `.woocommerce-privacy-policy-text` |
| `privacyTypography` | typography | Typography | `font` on `.woocommerce-privacy-policy-text` |
| `buttonWidth` | number | Width | `width` on `button[type="submit"]` |
| `buttonAlign` | align-items | Align | `align-self` on `button[type="submit"]` |
| `buttonMargin` | spacing | Margin | `margin` on `button[type="submit"]` |
| `buttonPadding` | spacing | Padding | `padding` on `button[type="submit"]` |
| `buttonBackground` | color | Background | `background-color` on `button[type="submit"]` |
| `buttonBorder` | border | Border | `border` on `button[type="submit"]` |
| `buttonTypography` | typography | Typography | `font` on `button[type="submit"]` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Checkout Order Table Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-checkout-order-table/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-checkout-order-table |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-checkout-order-table.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `previewOrderId` | number | Preview order ID | — |
| `headPadding` | spacing | Padding | `padding` on `.shop_table thead th` |
| `headBackground` | color | Background | `background-color` on `.shop_table thead` |
| `headBorder` | border | Border | `border` on `.shop_table thead` |
| `headTypography` | typography | Typography | `font` on `.shop_table thead th` |
| `productPadding` | spacing | Padding | `padding` on `.shop_table th`, `padding` on `.shop_table td` |
| `productBackground` | color | Background | `background-color` on `.shop_table tbody` |
| `productBorder` | border | Border | `border` on `.shop_table tbody tr` |
| `productTypography` | typography | Typography | `font` on `.shop_table tbody td` |
| `footPadding` | spacing | Padding | `padding` on `.shop_table tfoot th`, `padding` on `.shop_table tfoot td` |
| `footBackground` | color | Background | `background-color` on `.shop_table tfoot` |
| `footBorder` | border | Border | `border` on `.shop_table tfoot tr` |
| `footerTypography` | typography | Typography | `font` on `.shop_table tfoot th`, `font` on `.shop_table tfoot td` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Checkout Thank You Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-checkout-thankyou/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-checkout-thankyou |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-checkout-thankyou.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `previewOrderId` | number | Preview order ID | — |
| `hideMessage` | checkbox | Hide message | — |
| `message` | text | message | — |
| `messageMargin` | spacing | Margin | `margin` on `.woocommerce-notice` |
| `messagePadding` | spacing | Padding | `padding` on `.woocommerce-notice` |
| `messageBackground` | color | Background | `background-color` on `.woocommerce-notice` |
| `messageBorder` | border | Border | `border` on `.woocommerce-notice` |
| `messageTypography` | typography | Typography | `font` on `.woocommerce-thankyou-order-received` |
| `overviewMargin` | spacing | Margin | `margin` on `.woocommerce-order-overview.order_details` |
| `overviewBackground` | color | Background | `background-color` on `.woocommerce-order-overview.order_details` |
| `overviewBorder` | border | Border | `border` on `.woocommerce-order-overview.order_details` |
| `overviewBorderItem` | border | Border | `border` on `.woocommerce-order-overview.order_details li` |
| `overviewLabelTypography` | typography | Label typography | `font` on `.woocommerce-order-overview.order_details li` |
| `overviewTextTypography` | typography | Typography | `font` on `.woocommerce-order-overview.order_details li strong` |
| `detailsMargin` | spacing | Margin | `margin` on `.woocommerce-order-details` |
| `detailsPadding` | spacing | Padding | `padding` on `.shop_table th`, `padding` on `.shop_table td` |
| `detailsBackground` | color | Background | `background-color` on `.woocommerce-order-details table` |
| `detailsBorder` | border | Border | `border` on `.woocommerce-order-details table` |
| `detailsBackgroundFooter` | color | Background | `background-color` on `.shop_table tfoot` |
| `detailsActionButtonGap` | number | Gap | `gap` on `th.order-actions--heading + td` |
| `addressMargin` | spacing | Margin | `margin` on `.woocommerce-customer-details` |
| `addressTypography` | typography | Typography | `font` on `.woocommerce-customer-details address` |
| `detailsActionButtonMargin` | spacing | Margin | `margin` on `th.order-actions--heading + td > a` |
| `detailsActionButtonPadding` | spacing | Padding | `padding` on `th.order-actions--heading + td > a` |
| `detailsActionButtonBackgroundColor` | color | Background color | `background-color` on `th.order-actions--heading + td > a` |
| `detailsActionButtonBorder` | border | Border | `border` on `th.order-actions--heading + td > a` |
| `detailsActionButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `th.order-actions--heading + td > a` |
| `detailsActionButtonTypography` | typography | Typography | `font` on `th.order-actions--heading + td > a` |
| `orderAgainButtonMargin` | spacing | Margin | `margin` on `.order-again .button` |
| `orderAgainButtonPadding` | spacing | Padding | `padding` on `.order-again .button` |
| `orderAgainButtonBackgroundColor` | color | Background color | `background-color` on `.order-again .button` |
| `orderAgainButtonBorder` | border | Border | `border` on `.order-again .button` |
| `orderAgainButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.order-again .button` |
| `orderAgainButtonTypography` | typography | Typography | `font` on `.order-again .button` |
| `downloadsMargin` | spacing | Margin | `margin` on `.woocommerce-table--order-downloads` |
| `downloadsPadding` | spacing | Padding | `padding` on `.woocommerce-table--order-downloads` |
| `downloadsBackgroundColor` | color | Background color | `background-color` on `.woocommerce-table--order-downloads` |
| `downloadsBorder` | border | Border | `border` on `.woocommerce-table--order-downloads` |
| `downloadsBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-table--order-downloads` |
| `downloadsTypography` | typography | Typography | `font` on `.woocommerce-table--order-downloads` |
| `downloadsTitleMargin` | spacing | Margin | `margin` on `.woocommerce-order-downloads__title` |
| `downloadsTitlePadding` | spacing | Padding | `padding` on `.woocommerce-order-downloads__title` |
| `downloadsTitleBackgroundColor` | color | Background color | `background-color` on `.woocommerce-order-downloads__title` |
| `downloadsTitleBorder` | border | Border | `border` on `.woocommerce-order-downloads__title` |
| `downloadsTitleBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-order-downloads__title` |
| `downloadsTitleTypography` | typography | Typography | `font` on `.woocommerce-order-downloads__title` |
| `downloadsTheadPadding` | spacing | Padding | `padding` on `.woocommerce-order-downloads thead th, .woocommerce-order-downloads tbody td::before` |
| `downloadsTheadBackgroundColor` | color | Background color | `background-color` on `.woocommerce-order-downloads thead th, .woocommerce-order-downloads tbody td::before` |
| `downloadsTheadBorder` | border | Border | `border` on `.woocommerce-order-downloads thead th, .woocommerce-order-downloads tbody td::before` |
| `downloadsTheadTypography` | typography | Typography | `font` on `.woocommerce-order-downloads thead th, .woocommerce-order-downloads tbody td::before` |
| `downloadsTbodyPadding` | spacing | Padding | `padding` on `.woocommerce-order-downloads tbody td` |
| `downloadsTbodyBackgroundColor` | color | Background color | `background-color` on `.woocommerce-order-downloads tbody td` |
| `downloadsTbodyBorder` | border | Border | `border` on `.woocommerce-order-downloads tbody td` |
| `downloadsTbodyTypography` | typography | Typography | `font` on `.woocommerce-order-downloads tbody td` |
| `downloadsButtonMargin` | spacing | Margin | `margin` on `.woocommerce-MyAccount-downloads-file.button` |
| `downloadsButtonPadding` | spacing | Padding | `padding` on `.woocommerce-MyAccount-downloads-file.button` |
| `downloadsButtonBackgroundColor` | color | Background color | `background-color` on `.woocommerce-MyAccount-downloads-file.button` |
| `downloadsButtonBorder` | border | Border | `border` on `.woocommerce-MyAccount-downloads-file.button` |
| `downloadsButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-MyAccount-downloads-file.button` |
| `downloadsButtonTypography` | typography | Typography | `font` on `.woocommerce-MyAccount-downloads-file.button` |
| `failedOrderButtonMargin` | spacing | Margin | `margin` on `.woocommerce-thankyou-order-failed-actions a` |
| `failedOrderButtonPadding` | spacing | Padding | `padding` on `.woocommerce-thankyou-order-failed-actions a` |
| `failedOrderButtonBackgroundColor` | color | Background color | `background-color` on `.woocommerce-thankyou-order-failed-actions a` |
| `failedOrderButtonBorder` | border | Border | `border` on `.woocommerce-thankyou-order-failed-actions a` |
| `failedOrderButtonBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.woocommerce-thankyou-order-failed-actions a` |
| `failedOrderButtonTypography` | typography | Typography | `font` on `.woocommerce-thankyou-order-failed-actions a` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Mini Cart Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-mini-cart/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-mini-cart |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-mini-cart.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `icon` | icon | Icon | — |
| `iconTypography` | typography | Icon typography | `font` on `.mini-cart-link i` |
| `openMiniCartOnAddedToCart` | checkbox | Open on add to cart (AJAX) | — |
| `cartCount` | select | Visibility | `display` on `.cart-count` |
| `cartCountBackground` | color | Background color | `background-color` on `.cart-count` |
| `cartCountBorder` | border | Border | `border` on `.mini-cart-link .cart-icon .cart-count` |
| `cartCountTypography` | typography | Typography | `font` on `.mini-cart-link .cart-icon .cart-count` |
| `cartCountTransform` | transform | Transform | `transform` on `.mini-cart-link .cart-icon .cart-count` |
| `cartCountHeight` | number | Height | `height` on `.cart-count` |
| `cartCountWidth` | number | Width | `width` on `.cart-count` |
| `cartCountTop` | number | Top | `top` on `.mini-cart-link .cart-icon .cart-count` |
| `cartCountRight` | number | Right | `right` on `.mini-cart-link .cart-icon .cart-count` |
| `cartCountBottom` | number | Bottom | `bottom` on `.mini-cart-link .cart-icon .cart-count` |
| `cartCountLeft` | number | Left | `left` on `.mini-cart-link .cart-icon .cart-count` |
| `subtotalPosition` | select | Position | `flex-direction` on `.mini-cart-link` |
| `subtotalGap` | number | Gap | `gap` on `.mini-cart-link` |
| `subtotalTypography` | typography | Typography | `font` on `.mini-cart-link .cart-subtotal` |
| `hideCartDetails` | checkbox | Hide | — |
| `skipClickOutside` | checkbox | Don\ | — |
| `cartDetailsOffCanvas` | select | Off-Canvas | — |
| `cartDetailsHeight` | number | Height | `height` on `.cart-detail` |
| `cartDetailsWidth` | number | Width | `width` on `.cart-detail` |
| `cartDetailsImageWidth` | number | Image width | `width` on `.cart-detail img` |
| `cartDetailsPadding` | spacing | Padding | `padding` on `.widget_shopping_cart_content` |
| `cartDetailsPosition` | dimensions | Position | `—` on `.cart-detail` |
| `cartDetailsTransform` | transform | Transform | `transform` on `.cart-detail` |
| `cartDetailsBackground` | color | Background | `background-color` on `.cart-detail` |
| `cartDetailsBorder` | border | Border | `border` on `.cart-detail` |
| `cartDetailsBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.cart-detail` |
| `cartDetailsTypography` | typography | Typography | `font` on `.woocommerce-mini-cart-item a:not(.remove)` |
| `cartDetailsTypographyQuantity` | typography | Typography | `font` on `.woocommerce-mini-cart-item .quantity` |
| `buttonBackgroundColor` | color | Background color | `background-color` on `.cart-detail .woocommerce-mini-cart__buttons .button` |
| `buttonBorder` | border | Border | `border` on `.cart-detail .woocommerce-mini-cart__buttons .button` |
| `buttonTypography` | typography | Typography | `font` on `.cart-detail .woocommerce-mini-cart__buttons .button` |
| `cartDetailsCloseIcon` | icon | Icon | — |
| `cartDetailsCloseTypography` | typography | Typography | `font` on `.bricks-mini-cart-close > *` |
| `cartDetailsClosePosition` | dimensions | Position | `—` on `.bricks-mini-cart-close` |
| `cartDetailsClosePadding` | spacing | Padding | `padding` on `.bricks-mini-cart-close` |
| `cartDetailsCloseBackgroundColor` | color | Background color | `background-color` on `.bricks-mini-cart-close` |
| `cartDetailsCloseBorder` | border | Border | `border` on `.bricks-mini-cart-close` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Notice Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-notice/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-notice |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-notice.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `previewType` | select | Preview notice type | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Products Archive Description Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-products-archive-description/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-products-archive-description |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-products-archive-description.json" />

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Products Filter Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-products-filter/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-products-filter |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-products-filter.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `filters` | repeater | Filter type | `font` on `.filter .stars a` |
| `spacing` | number | Spacing | `gap` |
| `titleMargin` | spacing | Margin | `margin` on `.title` |
| `titlePadding` | spacing | Padding | `padding` on `.title` |
| `titleTypography` | typography | Typography | `font` on `.title .title-tag` |
| `titleBackgroundColor` | color | Background color | `background-color` on `.title` |
| `titleBorder` | border | Border | `border` on `.title` |
| `iconExpanded` | icon | Icon expanded | — |
| `iconCollapsed` | icon | Icon collapsed | — |
| `iconTypography` | typography | Icon typography | `font` on `.toggle` |
| `iconPosition` | select | Icon position | `flex-direction` on `.title` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Products Orderby Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-products-orderby/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-products-orderby |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-products-orderby.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `orderby` | select | Order by | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Products Pagination Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-products-pagination/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-products-pagination |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-products-pagination.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `justifyContent` | align-items | Alignment | `align-self` |
| `prevIcon` | icon | Previous Icon | — |
| `nextIcon` | icon | Next Icon | — |
| `endSize` | number | End Size | — |
| `midSize` | number | Mid Size | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Products Total Results Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-products-total-results/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-products-total-results |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-products-total-results.json" />

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Products Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-products/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-products |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-products.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `columns` | number | Columns | `grid-template-columns` on `.products` |
| `gap` | number | Gap | `gap` on `.products` |
| `linkProduct` | checkbox | Link entire product | — |
| `beforeGrid` | select | Show Before Grid | — |
| `afterGrid` | select | Show After Grid | — |
| `sortbyOptions` | select | Sort by options | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## WooCommerce Template Hook Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/woocommerce-template-hook/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | woocommerce-template-hook |
| `category` | woocommerce |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/woocommerce-template-hook.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `template` | select | Template | — |
| `singleProductHook` | select | Hook | — |
| `shopHook` | select | Hook | — |
| `showTips` | checkbox | Show tips | — |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## WordPress Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/elements/wordpress/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

| Property | Value |
|---|---|
| `name` | wordpress |
| `category` | wordpress |
| `tag` | div |
| `nestable` | false |

<SchemaJson path="elements/wordpress.json" />

## Controls

| Key | Type | Label | CSS |
|---|---|---|---|
| `type` | select | Widget | — |
| `icon` | icon | Icon | — |
| `iconTypography` | typography | Icon typography | `font` on `.bricks-widget-wrapper i` |
| `showCount` | checkbox | Show count | — |
| `sortBy` | select | Sort by | — |
| `include` | select | Include | — |
| `exclude` | select | Exclude | — |
| `commentsNumber` | number | Number of comments | — |
| `postsNumber` | number | Number of posts | — |
| `direction` | direction | Direction | `flex-direction` on `&.posts a` |
| `postsDate` | checkbox | Show date | — |
| `postsFeaturedImage` | checkbox | Show featured image | — |
| `postsFeaturedImageSize` | select | Featured image sizes | — |
| `postsImageWidth` | text | Featured image width | `width` on `img` |
| `postsImageHeight` | text | Featured image height | `height` on `img` |
| `postsTitleTypography` | typography | Post title typography | `font` on `.post-title` |
| `postsMetaTypography` | typography | Post meta typography | `font` on `.post-meta` |
| `taxonomy` | select | Taxonomy | — |
| `title` | text | Title | — |
| `titletag` | select | HTML tag | — |
| `titleBorder` | border | Border | `font` on `.bricks-widget-title` |
| `titleTypography` | typography | Typography | `font` on `.bricks-widget-title` |

## Inherited CSS controls

Shared CSS controls available on all elements. Keys are prefixed with `_` and support responsive/pseudo-class variants via colon syntax (e.g. `_typography:tablet_portrait:hover`).

| Key | Type | Label | CSS |
|---|---|---|---|
| `_content` | text | Content | `content` |
| `_margin` | spacing | Margin | `margin` |
| `_padding` | spacing | Padding | `padding` |
| `_width` | number | Width | `width` |
| `_widthMin` | number | Min. width | `min-width` |
| `_widthMax` | number | Max. width | `max-width` |
| `_height` | number | Height | `height` |
| `_heightMin` | number | Min. height | `min-height` |
| `_heightMax` | number | Max. height | `max-height` |
| `_aspectRatio` | text | Aspect ratio | `aspect-ratio` |
| `_position` | select | Position | `position` |
| `_top` | number | Top | `top` |
| `_right` | number | Right | `right` |
| `_bottom` | number | Bottom | `bottom` |
| `_left` | number | Left | `left` |
| `_zIndex` | number | Z-index | `z-index` |
| `_order` | number | Order | `order` |
| `_display` | select | Display | `display`, `align-items` |
| `_visibility` | select | Visibility | `visibility` |
| `_overflow` | text | Overflow | `overflow` |
| `_opacity` | number | Opacity | `opacity` |
| `_cursor` | select | Cursor | `cursor` |
| `_isolation` | select | Isolation | `isolation` |
| `_mixBlendMode` | select | Mix blend mode | `mix-blend-mode` |
| `_pointerEvents` | text | Pointer events | `pointer-events` |
| `_perspective` | number | Perspective | `perspective` |
| `_perspectiveOrigin` | text | Perspective origin | `perspective-origin` |
| `_gridItemJustifySelf` | align-items | Justify self | `justify-self` |
| `_flexDirection` | direction | Direction | `flex-direction` |
| `_alignSelf` | align-items | Align self | `align-self` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` |
| `_alignItems` | align-items | Align cross axis | `align-items` |
| `_gap` | number | Gap | `gap` |
| `_flexGrow` | number | Flex grow | `flex-grow` |
| `_flexShrink` | number | Flex shrink | `flex-shrink` |
| `_flexBasis` | text | Flex basis | `flex-basis` |
| `_useMasonry` | checkbox | %s layout | — |
| `_masonryColumn` | number | Columns | `--columns` |
| `_masonryGutter` | number | Spacing | `--gutter` |
| `_masonryHorizontalOrder` | checkbox | Horizontal order | — |
| `_masonryTransitionDuration` | number | Transition | — |
| `_masonryTransitionMode` | select | Reveal animation | — |
| `_typography` | typography | _typography | `font` |
| `_background` | background | _background | `background` |
| `_shapeDividers` | repeater | Custom shape | — |
| `_gradient` | gradient | _gradient | `background-image` |
| `_border` | border | Border | `border` |
| `_boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `_transform` | transform | Transform | `transform` |
| `_transformOrigin` | text | Transform origin | `transform-origin` |
| `_motionElementParallax` | checkbox | Element parallax | — |
| `_motionElementParallaxSpeedX` | number | Horizontal speed | `--brx-motion-parallax-speed-x` |
| `_motionElementParallaxSpeedY` | number | Vertical speed | `--brx-motion-parallax-speed-y` |
| `_motionBackgroundParallax` | checkbox | Background parallax | — |
| `_motionBackgroundParallaxSpeed` | number | Background speed | `--brx-motion-background-speed` |
| `_motionStartVisiblePercent` | number | Parallax start point | — |
| `_cssCustom` | code | Custom CSS | — |
| `_cssClasses` | text | CSS classes | — |
| `_cssId` | text | CSS ID | — |
| `_cssFilters` | filters | CSS Filters | `filter` |
| `_cssTransition` | text | Transition | `transition` |
| `_attributes` | repeater | Name | — |
| `_scrollSnapType` | select | Type | `scroll-snap-type` on `html`, `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapAlign` | select | Align | `scroll-snap-align` on `.brxe-section` |
| `_scrollSnapStop` | select | Stop | `scroll-snap-stop` on `.brxe-section` |

---


## Content Area Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/general/content-area/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

A content area is a flat array of element objects. Bricks uses three independent content areas per page (header, content, and footer), each stored in its own post meta key. The array is flat (not nested): parent-child relationships are expressed via the `parent` and `children` fields on each element.

For the structure of each element in the array, see the [Element schema](../elements/common/element/).

<SchemaJson path="general/content-area.json" />

## Content areas

A Bricks page (or any post type using Bricks) stores its elements across three independent content areas:

| Content area | WordPress post meta key | Description |
|---|---|---|
| Header | `_bricks_page_header_2` | Header template elements |
| Content | `_bricks_page_content_2` | Main page/post content |
| Footer | `_bricks_page_footer_2` | Footer template elements |

All three use the exact same data structure: an array of elements as described in the [Element schema](../elements/common/element/).

## Storage

These are stored as serialized arrays in the `wp_postmeta` table.

| Data | Meta key | PHP constant |
|---|---|---|
| Header elements | `_bricks_page_header_2` | `BRICKS_DB_PAGE_HEADER` |
| Content elements | `_bricks_page_content_2` | `BRICKS_DB_PAGE_CONTENT` |
| Footer elements | `_bricks_page_footer_2` | `BRICKS_DB_PAGE_FOOTER` |

## Flat array structure

Elements reference each other by ID rather than nesting physically. A root-level element has `"parent": 0`; all others reference their parent's `id`. The `children` array on each element lists its direct children in order. This makes it easy to reorder, move, or flatten elements without restructuring a tree.

```json
[
  { "id": "aaa111", "name": "section", "parent": 0, "children": ["bbb222"], "settings": {} },
  { "id": "bbb222", "name": "heading", "parent": "aaa111", "children": [], "settings": { "text": "Hello" } }
]
```

The array may also contain component instances (identifiable by the presence of a `cid` field). See [Components](../global/components/) for details.

---


## Breakpoints Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/global/breakpoints/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="global/breakpoints.json" />

## Item properties

| Property | Type | Description |
|---|---|---|
| `key` | string | — |
| `label` | string | — |
| `width` | integer | — |
| `widthBuilder` | integer | — |
| `icon` | string | — |
| `base` | boolean | — |
| `custom` | boolean | — |
| `edited` | boolean | — |
| `paused` | boolean | — |

---


## Color Palettes Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/global/color-palettes/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="global/color-palettes.json" />

## Item properties

| Property | Type | Description |
|---|---|---|
| `id` | string | — |
| `name` | string | — |
| `colors` | array | — |

---


## Components Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/global/components/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="global/components.json" />

## Item properties

| Property | Type | Description |
|---|---|---|
| `id` | string | — |
| `category` | string | — |
| `desc` | string | — |
| `elements` | array | — |
| `properties` | array | — |
| `_created` | integer \| string | — |
| `_user_id` | integer \| string | — |
| `_version` | string | — |
| `variants` | array | — |
| `blockEditor` | integer \| boolean | — |
| `blockCategory` | string | — |
| `blockIcon` | object | — |
| `blockPreviewImage` | object | Image settings |

---


## Global Classes Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/global/global-classes/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="global/global-classes.json" />

## Item properties

| Property | Type | Description |
|---|---|---|
| `id` | string | — |
| `name` | string | — |
| `category` | string | — |
| `settings` | dynamic | Dynamic map of all settings for this element or class. Keys are element-specific control names (e.g. `text`, `style`) or inherited CSS setting keys, optionally suffixed with a breakpoint and/or pseudo-class using colon syntax (e.g. `_typography:tablet_portrait:hover`). See the individual element schemas for available control keys. |
| `selectors` | array | Custom CSS selectors with scoped settings (since Bricks 2.0) |
| `modified` | integer \| string | — |
| `user_id` | integer \| string | — |
| `deletedAt` | integer \| string | — |

---


## Global Variables Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/global/global-variables/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="global/global-variables.json" />

## Item properties

| Property | Type | Description |
|---|---|---|
| `id` | string | — |
| `name` | string | — |
| `value` | string | — |
| `category` | string | — |
| `type` | string | — |

---


## Pseudo-Classes Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/global/pseudo-classes/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="global/pseudo-classes.json" />

---


## Theme Styles Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/global/theme-styles/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

Theme styles define global CSS defaults for element types (buttons, headings, typography, etc.) and site-wide settings (colors, links, spacing). They are stored in the `bricks_theme_styles` WordPress option.

## Data structure

Each theme style has a `label` and a `settings` object. The settings object is keyed by section name, and each section contains controls that map to CSS properties.

<SchemaJson path="global/theme-styles.json" />

## Storage

| Data | Option name | PHP constant |
|---|---|---|
| Theme styles | `bricks_theme_styles` | `BRICKS_DB_THEME_STYLES` |

The option value is an associative array keyed by theme style ID (e.g. `"flavor"`), with each entry being a `themeStyle` object.

## Responsive and state variants

Theme style control keys support the same colon syntax as element settings for breakpoint and pseudo-class variants:

```
typography                          → base breakpoint
typography:tablet_portrait          → tablet portrait
typography:mobile_portrait:hover    → mobile + hover
```

## Sections

### Accordion

Section key: `accordion`

Theme style controls for the "accordion" section. Default CSS selector: .brxe-accordion

| Key | Type | Label | CSS |
|---|---|---|---|
| `accordionIcon` | icon | Icon | — |
| `accordionIconExpanded` | icon | Icon expanded | — |
| `titleTypography` | typography | Title typography | `font` on `.accordion-title .title` |
| `subtitleTypography` | typography | Subtitle typography | `font` on `.accordion-subtitle` |
| `contentTypography` | typography | Content typography | `font` on `.accordion-content-wrapper` |

### Alert

Section key: `alert`

Theme style controls for the "alert" section. Default CSS selector: .brxe-alert

| Key | Type | Label | CSS |
|---|---|---|---|
| `padding` | spacing | Padding | `padding` |
| `typography` | typography | Typography | `font` |
| `border` | border | Border | `border` |
| `infoColor` | color | Text color | `color` on `&.info` |
| `infoBackground` | color | Background color | `background-color` on `&.info` |
| `infoBorder` | border | Border | `border` on `&.info` |
| `successColor` | color | Text color | `color` on `&.success` |
| `successBackground` | color | Background color | `background-color` on `&.success` |
| `successBorder` | border | Border | `border` on `&.success` |
| `warningColor` | color | Text color | `color` on `&.warning` |
| `warningBackground` | color | Background color | `background-color` on `&.warning` |
| `warningBorder` | border | Border | `border` on `&.warning` |
| `dangerColor` | color | Text color | `color` on `&.danger` |
| `dangerBackground` | color | Background color | `background-color` on `&.danger` |
| `dangerBorder` | border | Border | `border` on `&.danger` |
| `mutedColor` | color | Text color | `color` on `&.muted` |
| `mutedBackground` | color | Background color | `background-color` on `&.muted` |
| `mutedBorder` | border | Border | `border` on `&.muted` |

### Block

Section key: `block`

Theme style controls for the "block" section. Default CSS selector: .brxe-block

| Key | Type | Label | CSS |
|---|---|---|---|
| `_display` | select | Display | `display` on `.brxe-block:where(:not(.accordion-content-wrapper):not(.accordion-title-wrapper))` |
| `_direction` | direction | Direction | `flex-direction` on `.brxe-block` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` on `.brxe-block` |
| `_alignItems` | align-items | Align cross axis | `align-items` on `.brxe-block` |
| `width` | number | Width | `width` on `.brxe-block` |
| `widthMin` | number | Min. width | `min-width` on `.brxe-block` |
| `widthMax` | number | Max. width | `max-width` on `.brxe-block` |
| `_columnGap` | number | Column gap | `column-gap` on `.brxe-block` |
| `_rowGap` | number | Row gap | `row-gap` on `.brxe-block` |
| `margin` | spacing | Margin | `margin` on `.brxe-block` |
| `padding` | spacing | Padding | `padding` on `.brxe-block` |

### Button

Section key: `button`

Theme style controls for the "button" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `typography` | typography | Typography | `font` on `.bricks-button` |
| `background` | color | Background color | `background-color` on `.bricks-button:not([class*="bricks-background-"]):not([class*="bricks-color-"]):not(.outline)` |
| `border` | border | Border | `border` on `.bricks-button` |
| `boxShadow` | box-shadow | Box shadow | `box-shadow` on `.bricks-button` |
| `transition` | text | Transition | `transition` on `.bricks-button` |
| `outlineBackground` | color | Outline | `background-color` on `.bricks-button.outline` |
| `outlineBorder` | border | Outline | `border` on `.bricks-button.outline` |
| `outlineBoxShadow` | box-shadow | Outline | `box-shadow` on `.bricks-button.outline` |
| `outlineTypography` | typography | Outline | `font` on `.bricks-button.outline` |
| `primaryTypography` | typography | Typography | `font` on `:root .bricks-button[class*="primary"]` |
| `primaryBackground` | color | Background color | `background-color` on `:root .bricks-button[class*="primary"]:not(.outline)` |
| `primaryBorder` | border | Border | `border` on `:root .bricks-button[class*="primary"]` |
| `primaryBoxShadow` | box-shadow | Box shadow | `box-shadow` on `:root .bricks-button[class*="primary"]` |
| `primaryOutlineBackground` | color | Outline | `background-color` on `:root .bricks-button[class*="primary"].outline` |
| `primaryOutlineBorder` | border | Outline | `border` on `:root .bricks-button[class*="primary"].outline` |
| `primaryOutlineBoxShadow` | box-shadow | Outline | `box-shadow` on `:root .bricks-button[class*="primary"].outline` |
| `primaryOutlineTypography` | typography | Outline | `font` on `:root .bricks-button[class*="primary"].outline` |
| `secondaryTypography` | typography | Typography | `font` on `:root .bricks-button[class*="secondary"]` |
| `secondaryBackground` | color | Background color | `background-color` on `:root .bricks-button[class*="secondary"]:not(.outline)` |
| `secondaryBorder` | border | Border | `border` on `:root .bricks-button[class*="secondary"]` |
| `secondaryBoxShadow` | box-shadow | Box shadow | `box-shadow` on `:root .bricks-button[class*="secondary"]` |
| `secondaryOutlineBackground` | color | Outline | `background-color` on `:root .bricks-button[class*="secondary"].outline` |
| `secondaryOutlineBorder` | border | Outline | `border` on `:root .bricks-button[class*="secondary"].outline` |
| `secondaryOutlineBoxShadow` | box-shadow | Outline | `box-shadow` on `:root .bricks-button[class*="secondary"].outline` |
| `secondaryOutlineTypography` | typography | Outline | `font` on `:root .bricks-button[class*="secondary"].outline` |
| `lightTypography` | typography | Typography | `font` on `:root .bricks-button[class*="light"]:not(.bricks-lightbox)` |
| `lightBackground` | color | Background color | `background-color` on `:root .bricks-button[class*="light"]:not(.outline):not(.bricks-lightbox)` |
| `lightBorder` | border | Border | `border` on `:root .bricks-button[class*="light"]:not(.bricks-lightbox)` |
| `lightBoxShadow` | box-shadow | Box shadow | `box-shadow` on `:root .bricks-button[class*="light"]:not(.bricks-lightbox)` |
| `lightOutlineBackground` | color | Outline | `background-color` on `:root .bricks-button[class*="light"].outline` |
| `lightOutlineBorder` | border | Outline | `border` on `:root .bricks-button[class*="light"].outline` |
| `lightOutlineBoxShadow` | box-shadow | Outline | `box-shadow` on `:root .bricks-button[class*="light"].outline` |
| `lightOutlineTypography` | typography | Outline | `font` on `:root .bricks-button[class*="light"].outline` |
| `darkTypography` | typography | Typography | `font` on `:root .bricks-button[class*="dark"]` |
| `darkBackground` | color | Background color | `background-color` on `:root .bricks-button[class*="dark"]:not(.outline)` |
| `darkBorder` | border | Border | `border` on `:root .bricks-button[class*="dark"]` |
| `darkBoxShadow` | box-shadow | Box shadow | `box-shadow` on `:root .bricks-button[class*="dark"]` |
| `darkOutlineBackground` | color | Outline | `background-color` on `:root .bricks-button[class*="dark"].outline` |
| `darkOutlineBorder` | border | Outline | `border` on `:root .bricks-button[class*="dark"].outline` |
| `darkOutlineBoxShadow` | box-shadow | Outline | `box-shadow` on `:root .bricks-button[class*="dark"].outline` |
| `darkOutlineTypography` | typography | Outline | `font` on `:root .bricks-button[class*="dark"].outline` |
| `mutedTypography` | typography | Typography | `font` on `:root .bricks-button[class*="muted"]` |
| `mutedBackground` | color | Background color | `background-color` on `:root .bricks-button[class*="muted"]:not(.outline)` |
| `mutedBorder` | border | Border | `border` on `:root .bricks-button[class*="muted"]` |
| `mutedBoxShadow` | box-shadow | Box shadow | `box-shadow` on `:root .bricks-button[class*="muted"]` |
| `mutedOutlineBackground` | color | Outline | `background-color` on `:root .bricks-button[class*="muted"].outline` |
| `mutedOutlineBorder` | border | Outline | `border` on `:root .bricks-button[class*="muted"].outline` |
| `mutedOutlineBoxShadow` | box-shadow | Outline | `box-shadow` on `:root .bricks-button[class*="muted"].outline` |
| `mutedOutlineTypography` | typography | Outline | `font` on `:root .bricks-button[class*="muted"].outline` |
| `infoTypography` | typography | Typography | `font` on `:root .bricks-button[class*="info"]` |
| `infoBackground` | color | Background color | `background-color` on `:root .bricks-button[class*="info"]:not(.outline)` |
| `infoBorder` | border | Border | `border` on `:root .bricks-button[class*="info"]` |
| `infoBoxShadow` | box-shadow | Box shadow | `box-shadow` on `:root .bricks-button[class*="info"]` |
| `infoOutlineBackground` | color | Outline | `background-color` on `:root .bricks-button[class*="info"].outline` |
| `infoOutlineBorder` | border | Outline | `border` on `:root .bricks-button[class*="info"].outline` |
| `infoOutlineBoxShadow` | box-shadow | Outline | `box-shadow` on `:root .bricks-button[class*="info"].outline` |
| `infoOutlineTypography` | typography | Outline | `font` on `:root .bricks-button[class*="info"].outline` |
| `successTypography` | typography | Typography | `font` on `:root .bricks-button[class*="success"]` |
| `successBackground` | color | Background color | `background-color` on `:root .bricks-button[class*="success"]:not(.outline)` |
| `successBorder` | border | Border | `border` on `:root .bricks-button[class*="success"]` |
| `successBoxShadow` | box-shadow | Box shadow | `box-shadow` on `:root .bricks-button[class*="success"]` |
| `successOutlineBackground` | color | Outline | `background-color` on `:root .bricks-button[class*="success"].outline` |
| `successOutlineBorder` | border | Outline | `border` on `:root .bricks-button[class*="success"].outline` |
| `successOutlineBoxShadow` | box-shadow | Outline | `box-shadow` on `:root .bricks-button[class*="success"].outline` |
| `successOutlineTypography` | typography | Outline | `font` on `:root .bricks-button[class*="success"].outline` |
| `warningTypography` | typography | Typography | `font` on `:root .bricks-button[class*="warning"]` |
| `warningBackground` | color | Background color | `background-color` on `:root .bricks-button[class*="warning"]:not(.outline)` |
| `warningBorder` | border | Border | `border` on `:root .bricks-button[class*="warning"]` |
| `warningBoxShadow` | box-shadow | Box shadow | `box-shadow` on `:root .bricks-button[class*="warning"]` |
| `warningOutlineBackground` | color | Outline | `background-color` on `:root .bricks-button[class*="warning"].outline` |
| `warningOutlineBorder` | border | Outline | `border` on `:root .bricks-button[class*="warning"].outline` |
| `warningOutlineBoxShadow` | box-shadow | Outline | `box-shadow` on `:root .bricks-button[class*="warning"].outline` |
| `warningOutlineTypography` | typography | Outline | `font` on `:root .bricks-button[class*="warning"].outline` |
| `dangerTypography` | typography | Typography | `font` on `:root .bricks-button[class*="danger"]` |
| `dangerBackground` | color | Background color | `background-color` on `:root .bricks-button[class*="danger"]:not(.outline)` |
| `dangerBorder` | border | Border | `border` on `:root .bricks-button[class*="danger"]` |
| `dangerBoxShadow` | box-shadow | Box shadow | `box-shadow` on `:root .bricks-button[class*="danger"]` |
| `dangerOutlineBackground` | color | Outline | `background-color` on `:root .bricks-button[class*="danger"].outline` |
| `dangerOutlineBorder` | border | Outline | `border` on `:root .bricks-button[class*="danger"].outline` |
| `dangerOutlineBoxShadow` | box-shadow | Outline | `box-shadow` on `:root .bricks-button[class*="danger"].outline` |
| `dangerOutlineTypography` | typography | Outline | `font` on `:root .bricks-button[class*="danger"].outline` |
| `sizeDefaultPadding` | spacing | Padding | `padding` on `.bricks-button` |
| `sizeSmPadding` | spacing | Padding | `padding` on `.bricks-button.sm` |
| `sizeSmTypography` | typography | Typography | `font` on `.bricks-button.sm` |
| `sizeMdPadding` | spacing | Padding | `padding` on `.bricks-button.md` |
| `sizeMdTypography` | typography | Typography | `font` on `.bricks-button.md` |
| `sizeLgPadding` | spacing | Padding | `padding` on `.bricks-button.lg` |
| `sizeLgTypography` | typography | Typography | `font` on `.bricks-button.lg` |
| `sizeXlPadding` | spacing | Padding | `padding` on `.bricks-button.xl` |
| `sizeXlTypography` | typography | Typography | `font` on `.bricks-button.xl` |

### Carousel

Section key: `carousel`

No typed controls extracted for this section. It uses the generic theme style control map.

### Code

Section key: `code`

Theme style controls for the "code" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `prettify` | select | Theme | — |

### Colors

Section key: `colors`

Theme style controls for the "colors" section. Default CSS selector: :where(:root)

| Key | Type | Label | CSS |
|---|---|---|---|
| `colorPrimary` | color | Primary color | `color` on `.bricks-color-primary`, `background-color` on `.bricks-background-primary` |
| `colorSecondary` | color | Secondary color | `color` on `.bricks-color-secondary`, `background-color` on `.bricks-background-secondary` |
| `colorLight` | color | Light color | `color` on `.bricks-color-light`, `background-color` on `.bricks-background-light` |
| `colorDark` | color | Dark color | `color` on `.bricks-color-dark`, `background-color` on `.bricks-background-dark` |
| `colorMuted` | color | Muted color | `color` on `.bricks-color-muted`, `background-color` on `.bricks-background-muted` |
| `colorBorder` | color | Border color | `border-color` on `*` |
| `colorInfo` | color | Info color | `color` on `.bricks-color-info`, `background-color` on `.bricks-background-info` |
| `colorSuccess` | color | Success color | `color` on `.bricks-color-success`, `background-color` on `.bricks-background-success` |
| `colorWarning` | color | Warning color | `color` on `.bricks-color-warning`, `background-color` on `.bricks-background-warning` |
| `colorDanger` | color | Danger color | `color` on `.bricks-color-danger`, `background-color` on `.bricks-background-danger` |

### Conditions

Section key: `conditions`

Theme style controls for the "conditions" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `conditions` | repeater | Style conditions | — |

### Container

Section key: `container`

Theme style controls for the "container" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `_display` | select | Display | `display` on `.brxe-container` |
| `_direction` | direction | Direction | `flex-direction` on `.brxe-container` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` on `.brxe-container` |
| `_alignItems` | align-items | Align cross axis | `align-items` on `.brxe-container` |
| `width` | number | Width | `width` on `.brxe-container`, `width` on `.woocommerce main.site-main`, `width` on `#brx-content.wordpress` |
| `widthMin` | number | Min. width | `min-width` on `.brxe-container`, `min-width` on `#brx-content.wordpress` |
| `widthMax` | number | Max. width | `max-width` on `.brxe-container`, `max-width` on `#brx-content.wordpress` |
| `_columnGap` | number | Column gap | `column-gap` on `.brxe-container` |
| `_rowGap` | number | Row gap | `row-gap` on `.brxe-container` |
| `margin` | spacing | Margin | `margin` on `.brxe-container` |
| `padding` | spacing | Padding | `padding` on `.brxe-container` |

### Content

Section key: `content`

Theme style controls for the "content" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `contentMargin` | spacing | Margin | `margin` on `#brx-content`, `margin` on `.content-area` |
| `contentBlockquoteMargin` | spacing | Margin | `margin` on `blockquote` |
| `contentBlockquotePadding` | spacing | Padding | `padding` on `blockquote` |
| `contentBlockquoteBorder` | border | Border | `border` on `blockquote` |
| `contentBlockquoteTypography` | typography | Typography | `font` on `blockquote` |

### Contextual-spacing

Section key: `contextual-spacing`

No typed controls extracted for this section. It uses the generic theme style control map.

### Contextual Spacing

Section key: `contextualSpacing`

Theme style controls for the "contextualSpacing" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `contextualSpacingRemoveDefaultMargins` | select | Remove default margins | — |
| `contextualSpacingRemoveDefaultPadding` | select | Remove default padding | — |
| `contextualSpacingHeading` | number | Heading | `margin-block-start` |
| `contextualSpacingParagraph` | number | Paragraph | `margin-block-start` |
| `contextualSpacingFallback` | number | Fallback spacing | `margin-block-start` |
| `contextualSpacingCustomTarget` | repeater | Selector | `margin-block-start` |
| `contextualSpacingApplyTo` | text | contextualSpacingApplyTo | — |

### Counter

Section key: `counter`

Theme style controls for the "counter" section. Default CSS selector: .brxe-counter

| Key | Type | Label | CSS |
|---|---|---|---|
| `typography` | typography | Typography | `font` |

### Css

Section key: `css`

No typed controls extracted for this section. It uses the generic theme style control map.

### Div

Section key: `div`

Theme style controls for the "div" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `_display` | select | Display | `display` on `.brxe-div:where(:not(.brx-dropdown-content))` |
| `_direction` | direction | Direction | `flex-direction` on `.brxe-div` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` on `.brxe-div` |
| `_alignItems` | align-items | Align cross axis | `align-items` on `.brxe-div` |
| `width` | number | Width | `width` on `.brxe-div` |
| `widthMin` | number | Min. width | `min-width` on `.brxe-div` |
| `widthMax` | number | Max. width | `max-width` on `.brxe-div` |
| `_columnGap` | number | Column gap | `column-gap` on `.brxe-div` |
| `_rowGap` | number | Row gap | `row-gap` on `.brxe-div` |
| `margin` | spacing | Margin | `margin` on `.brxe-div` |
| `padding` | spacing | Padding | `padding` on `.brxe-div` |

### Divider

Section key: `divider`

Theme style controls for the "divider" section. Default CSS selector: .brxe-divider

| Key | Type | Label | CSS |
|---|---|---|---|
| `height` | number | Height | `border-top-width` on `.line` |
| `color` | color | Color | `border-top-color` on `&.horizontal .line`, `border-right-color` on `&.vertical .line`, `color` on `.icon i` |

### Elements

Section key: `elements`

No typed controls extracted for this section. It uses the generic theme style control map.

### Form

Section key: `form`

Theme style controls for the "form" section. Default CSS selector: .brxe-form

| Key | Type | Label | CSS |
|---|---|---|---|
| `labelTypography` | typography | Label typography | `font` on `.form-group label`, `font` on `.form-group .label` |
| `placeholderTypography` | typography | Placeholder typography | `font` on `::placeholder`, `font` on `select` |
| `fieldTypography` | typography | Typography | `font` on `.form-group input`, `font` on `select`, `font` on `textarea` |
| `fieldBackgroundColor` | color | Background color | `background-color` on `.form-group input`, `background-color` on `.flatpickr`, `background-color` on `select`, `background-color` on `textarea` |
| `fieldBorder` | border | Border | `border` on `.form-group input`, `border` on `.flatpickr`, `border` on `select`, `border` on `textarea`, `border` on `.bricks-button`, `border` on `.choose-files` |
| `fieldMargin` | spacing | Spacing | `padding` on `.form-group` |
| `fieldPadding` | spacing | Padding | `padding` on `.form-group input`, `padding` on `.flatpickr`, `padding` on `select`, `padding` on `textarea` |
| `submitButtonPadding` | spacing | Padding | `padding` on `.bricks-button` |
| `submitButtonTypography` | typography | Typography | `font` on `.bricks-button` |
| `submitButtonBackgroundColor` | color | Background color | `background-color` on `.bricks-button` |
| `submitButtonBorder` | border | Border | `border` on `.bricks-button` |

### General

Section key: `general`

Theme style controls for the "general" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `siteLayout` | select | Site layout | — |
| `siteLayoutBoxedMaxWidth` | number | Boxed max. width | `max-width` on `.brx-boxed`, `max-width` on `.brx-boxed #brx-header.brx-sticky`, `margin-left` on `.brx-boxed #brx-header.brx-sticky`, `margin-right` on `.brx-boxed #brx-header.brx-sticky` |
| `contentBoxShadow` | box-shadow | Content box shadow | `box-shadow` on `.brx-boxed` |
| `contentBackground` | background | Content background | `background` on `.brx-boxed` |
| `siteBackground` | background | Site background | `background` on `html`, `background` on `body` |
| `siteBorder` | border | Site border | `border` on `.brx-boxed` |
| `elementMargin` | spacing | Element margin | `margin` on `[class*="brxe-"]:not(.brxe-section):not(.brxe-container):not(.brxe-div)` |
| `sectionMargin` | spacing | Root container margin | `margin` on `.brxe-container.root` |
| `sectionPadding` | spacing | Root container padding | `padding` on `.brxe-container.root:not(.stretch)`, `padding` on `.brxe-container.root.stretch > .brxe-container`, `padding` on `.brxe-container.root.stretch > .brxe-div` |
| `containerMaxWidth` | number | Root container width | `width` on `.brxe-container.root`, `width` on `.brxe-container.root.stretch > .brxe-container`, `width` on `.brxe-container.root.stretch > .brxe-div`, `width` on `.woocommerce main.site-main`, `width` on `#brx-content.wordpress` |
| `lightboxBackground` | background | Background | `background` on `.pswp .pswp__bg` |
| `lightboxCloseColor` | color | Close color | `color` on `.pswp.brx .pswp__top-bar button.pswp__button--close svg` |
| `lightboxCloseSize` | number | Close size | `width` on `.pswp.brx .pswp__top-bar button.pswp__button svg`, `height` on `.pswp.brx .pswp__top-bar button.pswp__button svg` |
| `lightboxWidth` | number | Width | — |
| `lightboxHeight` | number | Height | — |

### Heading

Section key: `heading`

Theme style controls for the "heading" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `tag` | select | HTML tag | — |
| `separator` | select | Separator | — |
| `separatorWidth` | number | Width | `width` on `.brxe-heading .separator`, `flex-grow` on `.brxe-heading .separator` |
| `separatorHeight` | number | Height | `border-top-width` on `.brxe-heading .separator` |
| `separatorSpacing` | number | Spacing | `gap` on `.brxe-heading.has-separator` |
| `separatorAlignItems` | align-items | Align | `align-items` on `.brxe-heading.has-separator` |
| `separatorStyle` | select | Style | `border-top-style` on `.brxe-heading .separator` |
| `separatorColor` | color | Color | `border-top-color` on `.brxe-heading .separator` |
| `separatorMargin` | spacing | Margin | `margin` on `.brxe-heading .separator` |

### Icon-box

Section key: `icon-box`

Theme style controls for the "icon-box" section. Default CSS selector: .brxe-icon-box

| Key | Type | Label | CSS |
|---|---|---|---|
| `verticalAlign` | align-items | Icon align | `align-self` on `.icon` |
| `iconMargin` | spacing | Icon margin | `margin` on `.icon` |
| `iconPadding` | spacing | Icon padding | `padding` on `.icon` |
| `textAlign` | text-align | Text align | `text-align`, `align-self` on `.icon` |
| `iconSize` | number | Icon size | `font-size` on `.icon i` |
| `iconHeight` | number | Icon height | `height` on `.icon`, `line-height` on `.icon` |
| `iconWidth` | number | Icon width | `min-width` on `.icon` |
| `iconColor` | color | Icon color | `color` on `.icon`, `color` on `.icon a` |
| `iconBackgroundColor` | color | Icon background | `background-color` on `.icon` |
| `iconBorder` | border | Icon border | `border` on `.icon` |
| `iconBoxShadow` | box-shadow | Icon box shadow | `box-shadow` on `.icon` |
| `typographyHeading` | typography | Heading typography | `font` on `h1`, `font` on `h2`, `font` on `h3`, `font` on `h4`, `font` on `h5`, `font` on `h6` |
| `typographyBody` | typography | Body typography | `font` on `.content` |
| `contentBackgroundColor` | color | Content background | `background-color` on `.content` |
| `contentBorder` | border | Content border | `border` on `.content` |
| `contentBoxShadow` | box-shadow | Content box shadow | `box-shadow` on `.content` |
| `contentMargin` | spacing | Content margin | `margin` on `.content` |
| `contentPadding` | spacing | Content padding | `padding` on `.content` |

### Image

Section key: `image`

Theme style controls for the "image" section. Default CSS selector: .brxe-image

| Key | Type | Label | CSS |
|---|---|---|---|
| `popupIcon` | icon | Icon | — |
| `popupIconBackgroundColor` | color | Icon background color | `background-color` on `.brxe-image .icon` |
| `popupIconBorder` | border | Icon border | `border` on `.brxe-image .icon` |
| `popupIconBoxShadow` | box-shadow | Icon box shadow | `box-shadow` on `.brxe-image .icon` |
| `popupIconHeight` | number | Icon height | `line-height` on `.brxe-image .icon` |
| `popupIconWidth` | number | Icon width | `width` on `.brxe-image .icon` |
| `popupIconTypography` | typography | Icon typography | `font` on `.brxe-image .icon` |
| `caption` | select | Caption type | — |
| `captionCustomStyles` | checkbox | Custom styles | — |
| `captionMargin` | spacing | Margin | `margin` on `.brxe-image .bricks-image-caption-custom, .wp-element-caption:not(.wp-block-gallery *)` |
| `captionPadding` | spacing | Padding | `padding` on `.brxe-image .bricks-image-caption-custom, .wp-element-caption:not(.wp-block-gallery *)` |
| `captionPosition` | select | Position | `position` on `.brxe-image .bricks-image-caption-custom, .wp-element-caption:not(.wp-block-gallery *)`, `position` on `.wp-block-image:has(.wp-element-caption:not(.wp-block-gallery *))` |
| `captionPositions` | dimensions | Position | `—` on `.brxe-image .bricks-image-caption-custom, .wp-element-caption:not(.wp-block-gallery *)` |
| `captionBackgroundColor` | color | Background color | `background` on `.brxe-image .bricks-image-caption-custom, .wp-element-caption:not(.wp-block-gallery *)`, `text-shadow` on `.brxe-image .bricks-image-caption-custom, .wp-element-caption:not(.wp-block-gallery *)` |
| `captionBorder` | border | Border | `border` on `.brxe-image .bricks-image-caption-custom, .wp-element-caption:not(.wp-block-gallery *)` |
| `captionBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.brxe-image .bricks-image-caption-custom, .wp-element-caption:not(.wp-block-gallery *)` |
| `captionTypography` | typography | Typography | `font` on `.brxe-image .bricks-image-caption-custom, .wp-element-caption:not(.wp-block-gallery *)` |

### Image-gallery

Section key: `image-gallery`

Theme style controls for the "image-gallery" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `layout` | select | Layout | — |
| `imageRatio` | text | Image ratio | `aspect-ratio` on `.image` |
| `columns` | number | Columns | — |
| `imageHeight` | number | Image height | `padding-top` on `.brxe-image-gallery .image` |
| `gutter` | number | Spacing | `--gutter` on `.brxe-image-gallery` |
| `captionMargin` | spacing | Margin | `margin` on `.brxe-image-gallery .bricks-image-caption, .wp-block-gallery.has-nested-images figure.wp-block-image figcaption.wp-element-caption` |
| `captionPadding` | spacing | Padding | `padding` on `.brxe-image-gallery .bricks-image-caption, .wp-block-gallery.has-nested-images figure.wp-block-image figcaption.wp-element-caption` |
| `captionPosition` | select | Position | `position` on `.brxe-image-gallery .bricks-image-caption, .wp-block-gallery.has-nested-images figure.wp-block-image figcaption.wp-element-caption`, `flex` on `.wp-block-gallery.has-nested-images figure.wp-block-image figcaption.wp-element-caption`, `display` on `.wp-block-gallery.has-nested-images figure.wp-block-image:has(figcaption):before` |
| `captionPositions` | dimensions | Position | `—` on `.brxe-image-gallery .bricks-image-caption, .wp-block-gallery.has-nested-images figure.wp-block-image figcaption.wp-element-caption`, `width` on `.brxe-image-gallery .bricks-image-caption, .wp-block-gallery.has-nested-images figure.wp-block-image figcaption.wp-element-caption` |
| `captionBackgroundColor` | color | Background color | `background` on `.brxe-image-gallery .bricks-image-caption, .wp-block-gallery.has-nested-images figure.wp-block-image figcaption.wp-element-caption`, `text-shadow` on `.brxe-image-gallery .bricks-image-caption, .wp-block-gallery.has-nested-images figure.wp-block-image figcaption.wp-element-caption` |
| `captionBorder` | border | Border | `border` on `.brxe-image-gallery .bricks-image-caption, .wp-block-gallery.has-nested-images figure.wp-block-image figcaption.wp-element-caption` |
| `captionBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.brxe-image-gallery .bricks-image-caption, .wp-block-gallery.has-nested-images figure.wp-block-image figcaption.wp-element-caption` |
| `captionTypography` | typography | Typography | `font` on `.brxe-image-gallery .bricks-image-caption, .wp-block-gallery.has-nested-images figure.wp-block-image figcaption.wp-element-caption` |

### Links

Section key: `links`

Theme style controls for the "links" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `cssSelectors` | textarea | Link | — |
| `typography` | typography | Typography | `font` |
| `background` | background | Background | `background` |
| `border` | border | Border | `border` |
| `padding` | spacing | Padding | `padding` |
| `textDecoration` | text-decoration | Text decoration | `text-decoration` |
| `transition` | text | Transition | `transition` |

### List

Section key: `list`

Theme style controls for the "list" section. Default CSS selector: .brxe-list

| Key | Type | Label | CSS |
|---|---|---|---|
| `itemMargin` | spacing | Margin | `margin` on `li` |
| `itemPadding` | spacing | Padding | `padding` on `li` |
| `itemOddBackground` | color | Odd background | `background-color` on `li:nth-child(odd)` |
| `itemEvenBackground` | color | Even background | `background-color` on `li:nth-child(even)` |
| `itemBorder` | border | Border | `border` on `li` |
| `itemAutoWidth` | checkbox | Auto width | `justify-content` on `.content`, `flex-grow` on `.separator` |
| `highlightBlock` | checkbox | Block | `display` on `li[data-highlight]::before` |
| `highlightLabelPadding` | spacing | Padding | `padding` on `li[data-highlight]::before` |
| `highlightLabelBackground` | color | Background | `background-color` on `li[data-highlight]::before` |
| `highlightLabelBorder` | border | Border | `border` on `li[data-highlight]::before` |
| `highlightLabelTypography` | typography | Typography | `font` on `li[data-highlight]::before` |
| `highlightContentPadding` | spacing | Padding | `padding` on `li[data-highlight] + div` |
| `highlightContentBackground` | color | Background | `background-color` on `li[data-highlight] + div` |
| `highlightContentBorder` | border | Border | `border` on `li[data-highlight] + div` |
| `highlightContentColor` | color | Text color | `color` on `li[data-highlight] + div .title`, `color` on `li[data-highlight] + div .meta`, `color` on `li[data-highlight] + div .description` |
| `titleMargin` | spacing | Margin | `margin` on `.title` |
| `titleTypography` | typography | Typography | `font` on `.title` |
| `metaMargin` | spacing | Margin | `margin` on `.meta` |
| `metaTypography` | typography | Typography | `font` on `.meta` |
| `descriptionTypography` | typography | Typography | `font` on `.description` |
| `separatorDisable` | checkbox | Disable | `display` on `.separator` |
| `separatorStyle` | select | Style | `border-top-style` on `.separator` |
| `separatorWidth` | number | Width | `flex-basis` on `.separator` |
| `separatorHeight` | number | Height | `border-top-width` on `.separator` |
| `separatorColor` | color | Color | `border-top-color` on `.separator` |

### Nav-menu

Section key: `nav-menu`

Theme style controls for the "nav-menu" section. Default CSS selector: .brxe-nav-menu

| Key | Type | Label | CSS |
|---|---|---|---|
| `menuMargin` | spacing | Margin | `margin` on `.bricks-nav-menu > li` |
| `menuPadding` | spacing | Padding | `padding` on `.bricks-nav-menu > li > a`, `padding` on `.bricks-nav-menu > li > .brx-submenu-toggle > *` |
| `menuAlignment` | direction | Alignment | `flex-direction` on `.bricks-nav-menu` |
| `menuTypography` | typography | Typography | `font` on `.bricks-nav-menu > li > a`, `font` on `.bricks-nav-menu > li > .brx-submenu-toggle` |
| `menuActiveTypography` | typography | Active typography | `font` on `.bricks-nav-menu .current-menu-item > a`, `font` on `.bricks-nav-menu .current-menu-item > .brx-submenu-toggle` |
| `menuActiveBorder` | border | Active border | `border` on `.bricks-nav-menu .current-menu-item > a`, `border` on `.bricks-nav-menu .current-menu-item > .brx-submenu-toggle` |
| `subMenuPadding` | spacing | Padding | `padding` on `.bricks-nav-menu .sub-menu a`, `padding` on `.bricks-nav-menu .sub-menu button` |
| `subMenuTypography` | typography | Typography | `font` on `.bricks-nav-menu .sub-menu > li` |
| `subMenuActiveTypography` | typography | Active typography | `font` on `.bricks-nav-menu .sub-menu > .current-menu-item > a`, `font` on `.bricks-nav-menu .sub-menu > .current-menu-item > .brx-submenu-toggle` |
| `subMenuBackground` | background | Background | `background` on `.bricks-nav-menu .sub-menu .menu-item` |
| `subMenuBorder` | border | Border | `border` on `.bricks-nav-menu .sub-menu` |
| `subMenuBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.bricks-nav-menu .sub-menu` |

### Popup

Section key: `popup`

No typed controls extracted for this section. It uses the generic theme style control map.

### Popups

Section key: `popups`

No typed controls extracted for this section. It uses the generic theme style control map.

### Post-content

Section key: `post-content`

Theme style controls for the "post-content" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `typography` | typography | Typography | `font` on `.brxe-post-content` |

### Post-meta

Section key: `post-meta`

Theme style controls for the "post-meta" section. Default CSS selector: .brxe-post-meta

| Key | Type | Label | CSS |
|---|---|---|---|
| `padding` | spacing | Padding | `padding` on `.item` |
| `gutter` | number | Gap | `width` on `.separator` |
| `background` | color | Background | `background-color` on `.item` |
| `border` | border | Border | `border` on `.item` |
| `typography` | typography | Typography | `font` on `.item` |

### Post-navigation

Section key: `post-navigation`

Theme style controls for the "post-navigation" section. Default CSS selector: .brxe-post-navigation

| Key | Type | Label | CSS |
|---|---|---|---|
| `titleTypography` | typography | Title typography | `font` on `.title` |
| `labelTypography` | typography | Label typography | `font` on `label` |
| `imageBorder` | border | Image border | `border` on `.image` |

### Post-taxonomy

Section key: `post-taxonomy`

Theme style controls for the "post-taxonomy" section. Default CSS selector: .brxe-post-taxonomy

| Key | Type | Label | CSS |
|---|---|---|---|
| `margin` | spacing | Margin | `margin` on `.bricks-button` |
| `padding` | spacing | Padding | `padding` on `.bricks-button` |
| `background` | color | Background | `background-color` on `.bricks-button` |
| `border` | border | Border | `border` on `.bricks-button` |
| `typography` | typography | Typography | `font` on `.bricks-button` |

### Post-title

Section key: `post-title`

Theme style controls for the "post-title" section. Default CSS selector: .brxe-post-title

| Key | Type | Label | CSS |
|---|---|---|---|
| `typography` | typography | Typography | `font` |

### Pricing-tables

Section key: `pricing-tables`

Theme style controls for the "pricing-tables" section. Default CSS selector: .brxe-pricing-tables

| Key | Type | Label | CSS |
|---|---|---|---|
| `background` | background | Table background | `background` on `.pricing-table` |
| `headerPadding` | spacing | Padding | `padding` on `.pricing-table-header` |
| `headerBackgroundColor` | color | Background color | `background-color` on `.pricing-table-header` |
| `headerBorder` | border | Border | `border` on `.pricing-table-header` |
| `headerTitleTypography` | typography | Title typography | `font` on `.pricing-table-title` |
| `headerSubtitleTypography` | typography | Subtitle typography | `font` on `.pricing-table-subtitle` |
| `pricePadding` | spacing | Padding | `padding` on `.pricing-table-pricing` |
| `priceBackgroundColor` | color | Background color | `background-color` on `.pricing-table-pricing` |
| `priceBorder` | border | Border | `Border` on `.pricing-table-pricing` |
| `priceTypography` | typography | Price typography | `font` on `.pricing-table-price-prefix`, `font` on `.pricing-table-price`, `font` on `.pricing-table-price-suffix` |
| `priceMetaTypography` | typography | Meta typography | `font` on `.pricing-table-price-meta` |
| `priceOriginalTypography` | typography | Original price typography | `font` on `.pricing-table-original-price` |
| `featuresPadding` | spacing | Padding | `padding` on `.pricing-table-feature` |
| `featuresIconColor` | color | Icon color | `color` on `.pricing-table-feature i` |
| `featuresBackgroundColor` | color | Background color | `background-color` on `.pricing-table-feature` |
| `featuresBorder` | border | Border | `border` on `.pricing-table-feature` |
| `featuresTypography` | typography | Features typography | `font` on `.pricing-table-feature` |
| `footerPadding` | spacing | Padding | `padding` on `.pricing-table-footer` |
| `footerBackgroundColor` | color | Background color | `background-color` on `.pricing-table-footer` |
| `footerBorder` | border | Border | `border` on `.pricing-table-footer` |
| `buttonBackgroundColor` | color | Background color | `background-color` on `.bricks-button` |
| `buttonBorder` | border | Border | `border` on `.bricks-button` |
| `buttonTypography` | typography | Typography | `font` on `.bricks-button` |
| `additionalInfoTypography` | typography | Typography | `font` on `.pricing-table-additional-info` |
| `ribbonTextColor` | color | Text color | `color` on `.pricing-table-ribbon-title` |
| `ribbonBackgroundColor` | color | Background color | `background-color` on `.pricing-table-ribbon-title` |

### Progress-bar

Section key: `progress-bar`

Theme style controls for the "progress-bar" section. Default CSS selector: .brxe-progress-bar

| Key | Type | Label | CSS |
|---|---|---|---|
| `height` | number | Height | `height` on `.bar` |
| `barColor` | color | Bar color | `background-color` on `.bar span` |
| `barBackgroundColor` | color | Bar background color | `background-color` on `.bar` |
| `barBorder` | border | Bar border | `border` on `.bar` |
| `labelTypography` | typography | Label typography | `font` on `.label` |
| `percentageTypography` | typography | Percentage typography | `font` on `.percentage` |

### Related-posts

Section key: `related-posts`

Theme style controls for the "related-posts" section. Default CSS selector: .brxe-related-posts

| Key | Type | Label | CSS |
|---|---|---|---|
| `contentBackground` | color | Content background | `background-color` on `.post-content` |
| `contentPadding` | spacing | Content padding | `padding` on `.post-content` |

### Search

Section key: `search`

Theme style controls for the "search" section. Default CSS selector: .brxe-search

| Key | Type | Label | CSS |
|---|---|---|---|
| `inputBackgroundColor` | color | Input background | `background-color` on `input[type=search]` |
| `inputBorder` | border | Input border | `border` on `input[type=search]` |
| `iconBackgroundColor` | color | Icon background | `background-color` on `button` |
| `iconTypography` | typography | Icon typography | `font` on `button` |
| `iconWidth` | number | Icon width | `width` on `button` |

### Section

Section key: `section`

Theme style controls for the "section" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `_display` | select | Display | `display` on `.brxe-section` |
| `_direction` | direction | Direction | `flex-direction` on `.brxe-section` |
| `_justifyContent` | justify-content | Align main axis | `justify-content` on `.brxe-section` |
| `_alignItems` | align-items | Align cross axis | `align-items` on `.brxe-section` |
| `width` | number | Width | `width` on `.brxe-section` |
| `widthMin` | number | Min. width | `min-width` on `.brxe-section` |
| `widthMax` | number | Max. width | `max-width` on `.brxe-section` |
| `_columnGap` | number | Column gap | `column-gap` on `.brxe-section` |
| `_rowGap` | number | Row gap | `row-gap` on `.brxe-section` |
| `margin` | spacing | Margin | `margin` on `.brxe-section` |
| `padding` | spacing | Padding | `padding` on `.brxe-section` |

### Sidebar

Section key: `sidebar`

Theme style controls for the "sidebar" section. Default CSS selector: .brxe-sidebar

| Key | Type | Label | CSS |
|---|---|---|---|
| `margin` | spacing | Widget margin | `margin` on `.bricks-widget-wrapper` |
| `titleTypography` | typography | Widget title | `font` on `.bricks-widget-title`, `font` on `h1`, `font` on `h2`, `font` on `h3`, `font` on `h4`, `font` on `h5`, `font` on `h6` |
| `contentTypography` | typography | Content typography | `font` |
| `searchBackground` | color | Search background color | `background-color` on `input[type=search]` |

### Slider

Section key: `slider`

Theme style controls for the "slider" section. Default CSS selector: .brxe-slider

| Key | Type | Label | CSS |
|---|---|---|---|
| `titleMargin` | spacing | Title margin | `margin` on `.title` |
| `titleTypography` | typography | Title typography | `font` on `.title` |
| `contentWidth` | number | Content width | `width` on `.slider-content` |
| `contentBackgroundColor` | color | Content background | `background-color` on `.slider-content` |
| `contentMargin` | spacing | Content margin | `margin` on `.slider-content` |
| `contentPadding` | spacing | Content padding | `padding` on `.slider-content` |
| `contentAlignHorizontal` | select | Content align horizontal | `justify-content` on `.swiper-slide` |
| `contentAlignVertical` | align-items | Content align vertical | `align-items` on `.swiper-slide` |
| `contentTextAlign` | text-align | Content text align | `text-align` on `.slider-content` |
| `contentTypography` | typography | Content typography | `font` on `.content` |
| `buttonStyle` | select | Style | — |
| `buttonSize` | select | Size | — |
| `buttonBackground` | color | Background | `background-color` on `.bricks-button` |
| `buttonBorder` | border | Border | `border` on `.bricks-button` |
| `buttonBoxshadow` | box-shadow | Box shadow | `box-shadow` on `.bricks-button` |
| `buttonTypography` | typography | Button typography | `color` on `.bricks-button` |
| `backgroundFilters` | filters | CSS Filters | `filter` on `.css-filter` |
| `backgroundPositionTop` | number | Top | `top` on `.image` |
| `backgroundPositionRight` | number | Right | `right` on `.image` |
| `backgroundPositionBottom` | number | Bottom | `bottom` on `.image` |
| `backgroundPositionLeft` | number | Left | `left` on `.image` |

### Social-icons

Section key: `social-icons`

Theme style controls for the "social-icons" section. Default CSS selector: .brxe-social-icons

| Key | Type | Label | CSS |
|---|---|---|---|
| `margin` | spacing | Margin | `margin` on `li` |
| `padding` | spacing | Padding | `padding` on `li` |
| `backgroundColor` | color | Background color | `background-color` on `li` |
| `border` | border | Border | `border` on `li` |
| `typography` | typography | Typography | `font` on `li` |

### Svg

Section key: `svg`

Theme style controls for the "svg" section. Default CSS selector: .brxe-svg

| Key | Type | Label | CSS |
|---|---|---|---|
| `height` | number | Height | `height` |
| `width` | number | Width | `width` |
| `strokeWidth` | number | Stroke width | `stroke-width` on `*` |
| `stroke` | color | Stroke color | `stroke` on `*` |
| `fill` | color | Fill | `fill` on `*` |

### Tabs

Section key: `tabs`

Theme style controls for the "tabs" section. Default CSS selector: .brxe-tabs

| Key | Type | Label | CSS |
|---|---|---|---|
| `titlePadding` | spacing | Padding | `padding` on `.tab-title` |
| `titleTypography` | typography | Typography | `font` on `.tab-title` |
| `titleBackgroundColor` | color | Background | `background-color` on `.tab-title` |
| `titleBorder` | border | Border | `border` on `.tab-title` |
| `titleActiveTypography` | typography | Active typography | `font` on `.tab-title.brx-open` |
| `titleActiveBackgroundColor` | color | Active background | `background-color` on `.tab-title.brx-open` |
| `titleActiveBorder` | border | Active border | `border` on `.tab-title.brx-open` |
| `contentPadding` | spacing | Padding | `padding` on `.tab-content` |
| `contentTextAlign` | select | Text align | `text-align` on `.tab-content` |
| `contentColor` | color | Text color | `color` on `.tab-content` |
| `contentBackgroundColor` | color | Background color | `background-color` on `.tab-content` |
| `contentBorder` | border | Border | `border` on `.tab-content` |

### Team-members

Section key: `team-members`

Theme style controls for the "team-members" section. Default CSS selector: .brxe-team-members

| Key | Type | Label | CSS |
|---|---|---|---|
| `memberGutter` | number | Gap | `gap` |
| `memberBorder` | border | Border | `border` on `.member` |
| `memberBoxShadow` | box-shadow | Box shadow | `box-shadow` on `.member` |
| `memberTitleTypography` | typography | Title typography | `font` on `.title` |
| `memberSubtitleTypography` | typography | Subtitle typography | `font` on `.subtitle` |
| `memberDescriptionTypography` | typography | Description typography | `font` on `.description` |
| `imageBorder` | border | Image border | `border` on `.image` |
| `contentPadding` | spacing | Padding | `padding` on `.content` |
| `contentAlign` | select | Text align | `text-align` on `.content` |
| `contentBackgroundColor` | color | Background | `background-color` on `.member` |

### Testimonials

Section key: `testimonials`

Theme style controls for the "testimonials" section. Default CSS selector: .brxe-testimonials

| Key | Type | Label | CSS |
|---|---|---|---|
| `imageAlign` | select | Image align | `align-items` on `.repeater-item` |
| `imageSize` | number | Image size | `width` on `.image`, `height` on `.image` |
| `imageBorder` | border | Image border | `border` on `.image` |
| `typographyContent` | typography | Testimonial | `font` on `.testimonial-content-wrapper` |
| `typographyName` | typography | Name | `font` on `.testimonial-name` |
| `typographyTitle` | typography | Title | `font` on `.testimonial-title` |

### Text

Section key: `text`

Theme style controls for the "text" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `typography` | typography | Typography | `font` on `.brxe-text`, `font` on `.brxe-text-basic` |

### Text-basic

Section key: `text-basic`

Theme style controls for the "text-basic" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `tag` | select | HTML tag | — |

### Typography

Section key: `typography`

Theme style controls for the "typography" section.

| Key | Type | Label | CSS |
|---|---|---|---|
| `typographyHtml` | number | HTML: font-size | `font-size` on `html` |
| `typographyBody` | typography | Body | `font` on `body` |
| `typographyHeadings` | typography | All headings | `font` on `h1, h2, h3, h4, h5, h6` |
| `typographyHeadingH1` | typography | Typography | `font` on `h1` |
| `h1Margin` | spacing | Margin | `margin` on `h1` |
| `typographyHeadingH2` | typography | Typography | `font` on `h2` |
| `h2Margin` | spacing | Margin | `margin` on `h2` |
| `typographyHeadingH3` | typography | Typography | `font` on `h3` |
| `h3Margin` | spacing | Margin | `margin` on `h3` |
| `typographyHeadingH4` | typography | Typography | `font` on `h4` |
| `h4Margin` | spacing | Margin | `margin` on `h4` |
| `typographyHeadingH5` | typography | Typography | `font` on `h5` |
| `h5Margin` | spacing | Margin | `margin` on `h5` |
| `typographyHeadingH6` | typography | Typography | `font` on `h6` |
| `h6Margin` | spacing | Margin | `margin` on `h6` |
| `typographyHero` | typography | Hero | `font` on `.bricks-type-hero` |
| `typographyLead` | typography | Lead | `font` on `.bricks-type-lead` |
| `focusOutline` | text | Focus outline | `outline` on `body.bricks-is-frontend :focus-visible`, `outline` on `@supports not selector(:focus-visible) { body.bricks-is-frontend :focus` |
| `blockquoteMargin` | spacing | Blockquote margin | `margin` on `blockquote` |
| `blockquotePadding` | spacing | Blockquote padding | `padding` on `blockquote` |
| `blockquoteBorder` | border | Blockquote border | `border` on `blockquote` |
| `blockquoteTypography` | typography | Blockquote typography | `font` on `blockquote` |

### Video

Section key: `video`

Theme style controls for the "video" section. Default CSS selector: .brxe-video

| Key | Type | Label | CSS |
|---|---|---|---|
| `previewImageFallback` | image | Fallback preview image | — |
| `boxShadow` | box-shadow | Box shadow | `box-shadow` |
| `overlay` | background | Overlay | `background` on `.bricks-video-overlay` |
| `overlayIcon` | icon | Icon | `—` on `.bricks-video-overlay-icon` |
| `overlayIconTypography` | typography | Icon typography | `font` on `.bricks-video-overlay-icon` |
| `customPlayer` | checkbox | Custom video player | — |
| `fileRestart` | checkbox | Restart | — |
| `fileRewind` | checkbox | Rewind | — |
| `fileFastForward` | checkbox | Fast forward | — |
| `fileSpeed` | checkbox | Speed | — |
| `filePip` | checkbox | Picture in picture | — |

### Wordpress

Section key: `wordpress`

Theme style controls for the "wordpress" section. Default CSS selector: .brxe-wordpress

| Key | Type | Label | CSS |
|---|---|---|---|
| `titleBorder` | border | Widget title border | `border` on `.bricks-widget-title` |
| `titleTypography` | typography | Widget title typography | `font` on `.bricks-widget-title` |
| `contentTypography` | typography | Content typography | `font` on `ul` |
| `postsTitleTypography` | typography | Post title typography | `font` on `.post-title` |
| `postsMetaTypography` | typography | Post meta typography | `font` on `.post-meta` |

---


## Page Settings Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/settings/page/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="settings/page.json" />

## Controls

| Key | Type | Label |
|---|---|---|
| `bodyClasses` | text | CSS classes |
| `customCss` | code | Custom CSS |
| `customScriptsBodyFooter` | code | Body (footer) scripts |
| `customScriptsBodyHeader` | code | Body (header) scripts |
| `customScriptsHeader` | code | Header scripts |
| `disableLazyLoad` | checkbox | Disable lazy load |
| `documentTitle` | text | Document title |
| `footerDisabled` | checkbox | Disable footer |
| `headerDisabled` | checkbox | Disable header |
| `metaDescription` | textarea | Meta description |
| `metaKeywords` | text | Meta keywords |
| `metaRobots` | select | Meta robots |
| `onePageNavigation` | checkbox | Show navigation |
| `onePageNavigationItemBorder` | border | Border |
| `onePageNavigationItemBorderActive` | border | Border |
| `onePageNavigationItemBoxShadow` | box-shadow | Box shadow |
| `onePageNavigationItemBoxShadowActive` | box-shadow | Box shadow |
| `onePageNavigationItemColor` | color | Color |
| `onePageNavigationItemColorActive` | color | Color |
| `onePageNavigationItemHeight` | number | Height |
| `onePageNavigationItemHeightActive` | number | Height |
| `onePageNavigationItemSpacing` | number | Spacing |
| `onePageNavigationItemWidth` | number | Width |
| `onePageNavigationItemWidthActive` | number | Width |
| `popupDisabled` | checkbox | Disable popups |
| `postName` | text | Permalink |
| `postTitle` | text | Title |
| `scrollMargin` | number | Margin |
| `scrollPadding` | number | Padding |
| `scrollSnapAlign` | select | Align |
| `scrollSnapSelector` | text | Snapping elements selector |
| `scrollSnapStop` | select | Stop |
| `scrollSnapType` | select | Type |
| `sharingDescription` | text | Description |
| `sharingImage` | image | Image |
| `sharingTitle` | text | Title |

---


## Template Settings Schema

*來源網址：https://academy-preview.bricksbuilder.io/developer/schema/settings/template/*

import SchemaJson from '../../../../../components/SchemaJson.astro'

<SchemaJson path="settings/template.json" />

## Controls

| Key | Type | Label |
|---|---|---|
| `headerPosition` | select | Header location |
| `headerSticky` | checkbox | Sticky header |
| `headerStickyOnScroll` | checkbox | Sticky on scroll |
| `headerStickyScrollingBackground` | background | Scrolling background |
| `headerStickyScrollingBoxShadow` | box-shadow | Scrolling box shadow |
| `headerStickyScrollingColor` | color | Scrolling text color |
| `headerStickyScrollingColorHover` | color | Scrolling text color |
| `headerStickySlideUpAfter` | number | Slide up after |
| `headerStickyTransition` | text | Transition |
| `headerWidth` | number | Header width |
| `passwordProtectionBypassLoggedIn` | checkbox | Disable for logged-in users |
| `passwordProtectionEndDate` | datepicker | End date |
| `passwordProtectionPassword` | text | Password |
| `passwordProtectionSchedule` | checkbox | Schedule |
| `passwordProtectionSource` | select | Password source |
| `passwordProtectionStartDate` | datepicker | Start date |
| `popupAjax` | checkbox | Fetch content via AJAX |
| `popupAjaxLoaderAnimation` | select | Animation |
| `popupAjaxLoaderColor` | color | Color |
| `popupAjaxLoaderScale` | number | Scale |
| `popupAjaxLoaderSelector` | text | CSS Selector |
| `popupAlignItems` | align-items | Align cross axis |
| `popupBackdropTransition` | text | Transition |
| `popupBackground` | background | Background |
| `popupBodyScroll` | checkbox | Scroll |
| `popupBreakpointMode` | select | popupBreakpointMode |
| `popupCloseOn` | select | Close on |
| `popupContentBackground` | background | Background |
| `popupContentBorder` | border | Border |
| `popupContentBoxShadow` | box-shadow | Box shadow |
| `popupContentHeight` | number | Height |
| `popupContentMaxHeight` | number | Max. height |
| `popupContentMaxWidth` | number | Max. width |
| `popupContentMinHeight` | number | Min. height |
| `popupContentMinWidth` | number | Min. width |
| `popupContentPadding` | spacing | Padding |
| `popupContentWidth` | number | Width |
| `popupDisableAutoFocus` | checkbox | Disable auto focus |
| `popupDisableBackdrop` | checkbox | Disable backdrop |
| `popupInfoBoxWidth` | number | Width |
| `popupIsInfoBox` | checkbox | Info Box |
| `popupIsWoo` | checkbox | WooCommerce  |
| `popupJustifyConent` | justify-content | Align main axis |
| `popupLimitLocalStorage` | number | Across sessions |
| `popupLimitSessionStorage` | number | Per session |
| `popupLimitTimeStorage` | number | Show again after .. hours |
| `popupLimitWindow` | number | Per page load |
| `popupPadding` | spacing | Padding |
| `popupScrollToTop` | checkbox | Scroll to top |
| `popupShowAt` | select | popupShowAt |
| `popupShowOn` | select | popupShowOn |
| `popupZindex` | number | Z-index |
| `templateConditions` | repeater | Archive type |
| `templatePreviewAuthor` | select | Author |
| `templatePreviewPostId` | select | Single |
| `templatePreviewPostType` | select | Post type |
| `templatePreviewSearchTerm` | text | Search term |
| `templatePreviewTerm` | select | Term |
| `templatePreviewType` | select | Content type |
| `template_interactions` | repeater | Interactions |

---
