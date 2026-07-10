# Bricks Academy — Integrations (WooCommerce/Gutenberg/Maps)

> 來源：Bricks Builder Academy 官方文件 | 共 21 篇

---



## Gutenberg

*來源網址：https://academy-preview.bricksbuilder.io/integrations/gutenberg/*

If you've created your pages with Gutenberg you can continue editing them with Bricks without having to start all over again. Bricks will convert your Gutenberg blocks into Bricks elements.

You can also save and convert your Bricks generated data to Gutenberg data to continue editing a page with Gutenberg.

This way you'll not suffer any lock-in effect when start using Bricks or if you should ever decide to move away from Bricks.

:::note
The block conversion works only with standard WordPress Gutenberg blocks, NOT custom-third party blocks
:::

## How to load Gutenberg data into Bricks

Bricks allows you to convert your existing Gutenberg data into Bricks data. So you can continue editing any page created with Gutenberg in Bricks.

This only works for pages without any existing Bricks data. To delete the Bricks data of any page click the "Delete Bricks data" button in the WordPress top menu when editing a page in WordPress.

To enable this functionality go to **Bricks > Settings** and make sure **Load Gutenberg Data Into Bricks** is selected.

## How to save Bricks data for Gutenberg

By default, your WordPress-generated data won’t change when editing with Bricks. If you want to save your Bricks generated data as Gutenberg data as well go to **Bricks > Settings** and select **Save Bricks Data As Gutenberg Data**.

From now on whenever you edit and save in Bricks, your content will be saved as WordPress content, too. So your WordPress and Bricks data are in sync.

## Render content with Bricks or WordPress {#render-with-wordpress}

You decide which pages you want to create with Gutenberg, the Classic Editor, or Bricks. The post status next to the page title tells you which content is used for rendering on the frontend:

![](imgs/wp-admin-pages-post-status-1024x576-fbb987d518.png)

To change the data being used to render a page edit the page in WordPress and hover over the **Render with WordPress/Bricks** button in the top menu, and select the source you want to use:



![](imgs/wp-admin-edit-page-render-with-wordpress-bricks-1024x576-92fd8fa2c5.png)

<figcaption>

Render with Bricks / Render with WordPress

</figcaption>

---


## Bricks components as blocks

*來源網址：https://academy-preview.bricksbuilder.io/integrations/gutenberg/components-as-blocks/*

https://youtu.be/tgpjMcZaLNc

Most sites built with Bricks follow a simple pattern: you create your pages and templates in Bricks, and write your posts or other content in the block editor (Gutenberg).

That works well for standard content, but as soon as you need something more custom inside the block editor, like a styled testimonial or a reusable promo block, you quickly run out of options.

We are introducing a new experimental feature called **components as blocks** to bridge this gap. It lets you design blocks in Bricks and make them available directly inside the block editor.

You get the same builder features you already use for pages and templates, while deciding exactly what editors can override through component properties.

This makes it possible to:

- Build custom, styled blocks entirely in Bricks
- Keep design consistent across your site by updating the component once in Bricks
- Give editors freedom to customize content inside the block editor while staying within your design system

## Enable components as blocks

This new feature is currently experimental and disabled by default. You can enable it from the WordPress dashboard under `Bricks → Settings → General → Block editor → Bricks components in the block editor`.

Three options are available:

- **Disabled** (default)
- **Enable individual components manually**
  - Components must be enabled individually to appear in the block editor.
  - In the builder:
    - Open the **Components panel**, hover over a component, click **Use in block editor**, then confirm.
    - Or edit a component and toggle **Use in block editor → Enabled** from the component settings header.
  - A filter in the Components panel lets you view only components enabled for the block editor.
- **Enable all components automatically**
  - All Bricks components are instantly available in the block editor.

When a component is enabled for block editor use, additional block-specific settings appear in the component settings header under "Use in block editor":

- **Block category**: Choose which block category the component should appear under inside the block editor.
- **Block icon**: Select the icon shown in the block picker.
- **Block preview image**: Set an optional preview image that appears in the block inserter.

## Insert a component in the block editor

1. Open or create a post/page in the block editor.
2. Click **Add block (+)** and search for your component by name.
3. Select the component. It renders directly inside the editor.

The component behaves like any other block. You can add text above or below, reorder it, or combine it with other block editor blocks.

## Customize component properties

When you select a Bricks component block in the block editor, its editable properties appear in the **Block settings sidebar** in the same way as editing an instance in Bricks.

All property types are supported:

- Text
- Rich text
- Select
- Toggle
- Global classes
- Image
- Image gallery
- Link
- Query loop *(Query editor (PHP), External APIs, and Query manager are not supported at this time)*

Each block instance can have unique property values, while the component design remains consistent.

## Centralized design updates

All block instances remain linked to the main component in Bricks. Any design change you make in Bricks (such as adjusting layout, typography, or spacing) applies site-wide to every instance, including those inside the block editor.

## Use cases

- **Reusable design elements**: Insert testimonials, event cards, promo blocks, or signup forms into posts.
- **Design consistency**: Global updates in Bricks apply throughout your entire site.
- **Content flexibility**: Editors can update text, images, and toggles per instance without leaving the block editor.
- **Workflow separation**: Designers build components in Bricks, editors use them in the block editor.

As this feature is experimental, we would love your feedback on components as blocks specifically, as well as ideas for how Bricks could integrate even smoother with the block editor to support your workflow. Share your thoughts in the [Bricks forum](https://forum.bricksbuilder.io/) or get in touch with us directly via email.

---


## How to set up your Google Maps API key

*來源網址：https://academy-preview.bricksbuilder.io/integrations/how-to-set-up-your-google-maps-api-key/*

Thanks to the `Map` element, adding a Google Map to Bricks is easy. The biggest hurdle is creating the Google Maps API key. This article will show you how to create an API key and how to prevent unauthorized use by setting API and application restrictions.

:::note
Since [Bricks 1.10.2](https://bricksbuilder.io/release/bricks-1-10-2/), Google Maps can be used without an API key through the Embed API, which is very limited by Google. It only allows for one address, zoom level, and map type. For more options, you have to use an API key.
:::

## Prerequisites

Before you start using the Maps JavaScript API, you need a project with a **billing account,** and the **Maps JavaScript API** and **Geocoding API** enabled. Check out the [Google documentation](https://developers.google.com/maps/documentation/javascript/cloud-setup) on how to do so.

As soon as you have completed the setup, you will find your API key under **Keys and Credentials » API Keys**.

![](imgs/Keys-and-credentials-%E2%80%93-Google-Maps-Platform-%E2%80%93-Bricks-%E2%80%93-Google-Clo-b0e8bd373b.png)

Copy and paste the key into **Bricks » Settings » API keys » Google Maps: API key** and hit save.

![](imgs/Settings-%E2%80%B9-bricksRecent-%E2%80%94-WordPress-d9f52b2c94.jpg)

Now, you can use the "Map" element on any page. If your map doesn’t show properly, inspect the developer console for more information.

## API and application restrictions

We recommend restricting where and for which APIs the API key can be used to prevent unauthorized use.

![](imgs/Edit-API-key-%E2%80%93-APIs-and-services-%E2%80%93-Bricks-%E2%80%93-Google-Cloud-console-1024x617-e51c2fbfbf.jpg)

### Application restrictions

Since you're running a website, restrict the API key for websites only. Select "Websites" and add your URL by clicking the "Add" button. Here are some examples of URLs that you can allow to set up a website:

- Any URL in a single domain with no subdomains: https://example.com
- Any URL in a single subdomain: https://sub.example.com
- Any subdomain in a single domain, using a wildcard asterisk (*): https://*.example.com
- A domain and all its subdomains, using a wildcard asterisk (*):
https://example.com
https://*.example.com

### API Restrictions

**Restrict key** » Select APIs and enable the **Maps JavaScript API** and **Geocoding API**.

Save your API key settings.

## Common problems

If the map is not showing, open the developer console. You will receive further information and how to solve your specific issue there. In most cases, no billing account is assigned, the necessary APIs are not activated, or the restrictions are incorrect.

![](imgs/Screenshot-2023-12-05-13.33.02-48c0d0bf96.jpg)

---


## How to use WPML with Bricks

*來源網址：https://academy-preview.bricksbuilder.io/integrations/how-to-use-wpml-with-bricks/*

WPML is a WordPress plugin known for its role in facilitating the creation of multilingual websites.

Coupling it with Bricks (`@since 1.9.1`) allows not only for the manual translation of posts, pages, and various content types into numerous languages but also offers automatic translation features, significantly broadening your website's reach and accessibility.

Once you've established a page in your primary language with Bricks, WPML enables you to easily translate the content into any language you wish to add to your website, be it manually or automatically.

This documentation will guide you through the process of translating your Bricks website using WPML.

## Setting up the environment

Before translating, set up your environment with the necessary plugins:

1. **Bricks setup**:
  - This guide will illustrate the translation process using a simple Bricks website. This website has main pages like Home and Blog, and templates including a header and an "All Archives" template, which has a [template condition](/builder/features/template-settings/#template-conditions) to apply to all archives and the blog page.

1. **WPML plugin installation**:
  - You can use the [OTGS installer](https://wpml.org/version/otgs-installer-3-0-0/) to install the required **WPML Multilingual CMS **and** WPML String Translation** plugins.

![](imgs/bricks-wpml-3-1024x520-0d06281547.png)

1. **Language Configuration**:
  - You can configure your website's languages and other settings through [the WPML setup wizard](https://wpml.org/documentation/getting-started-guide/). During this process, WPML will also ask you for context about your website, such as what it’s about and whose it for.

![](imgs/Bricks-Translation-Context-1024x748-2967d7a334.png)

Using the context that you provide, WPML’s AI translator – [PTC (Private Translation Cloud)](https://ptc.wpml.org/about/) will create translations that fit your target audience and industry.

## Translation options with WPML & Bricks

WPML offers different ways to translate your Bricks content:

1. **[Advanced Translation Editor](https://wpml.org/documentation/translating-your-contents/advanced-translation-editor/)**:
  - Automatic (AI) Translation: Instantly translate your content using WPML’s AI-based engine, then optionally review it before publishing.
  - Manual Translation: A method where each page & string is translated individually.
2. **[String Translation](https://wpml.org/documentation/getting-started-guide/string-translation/)**:
  - Translate theme/plugin strings, widget texts, and other interface strings found under WPML → String Translation.
3. **Edit with Bricks**:
  - If needed, post-translation modifications to design or layout can be done in the Bricks builder for each language.

For more in-depth information on each method, refer to the official [WPML documentation](https://wpml.org/documentation/).

## Translating website content

Translate your website content using WPML and Bricks through the following steps:

### Bulk translation via translation dashboard {#translation-dashboard}

WPML can translate any content you build with Bricks, including pages, posts, templates, and components.

To translate any Bricks content, start by going to **WPML **→ **Translation Dashboard**. From here, expand the section with the content you want to translate and select your items.

For example, to translate a page, expand the **Pages** section and select the page. This will include all Bricks element data and any component instance property values used on that page. To translate Bricks components themselves, expand the **Bricks components** section and select the components you want to translate.

![](imgs/Bricks-TD-efcca4e3e9.png)

Next, select **Translate automatically** for the languages you want to translate into, and click the **Translate **button to begin. If you look under the table, WPML also shows you how much translating your content costs.

![](imgs/Bricks-TD-Step-2-03bfc3b70f.png)

In most cases, your translations will be good to go, but you can always review and make changes using WPML’s **Advanced Translation Editor**.

![](imgs/Editing-translations-in-the-Advanced-Translation-Editor-fccf36bc01.png)

Just visit the translated page you want to edit on the front-end, and click **Edit translation **in the top admin bar. This will open the editor, where you can make any changes necessary.

Once you’re done reviewing, you can instantly publish your translations and display them on your website. Remember that you need to switch languages to view your translations.

### Translating individual pages and posts

While **Translation Management** is perfect for translating multiple pages and templates in one go, you may sometimes want to focus on a single page or post—either for fine-tuning the translation or making additional adjustments. In those cases, you can use the **WPML Advanced Translation Editor** directly from the page/post edit screen.
For comprehensive guidance on the various methods to translate pages and posts created by page builders like Bricks, refer to [WPML's official documentation](https://wpml.org/documentation/translating-your-contents/page-builders/) about this topic.

![](imgs/bricks-wpml-4-1024x518-361fa0bfa5.png)

![](imgs/bricks-wpml-8-1024x516-6f584b0b8f.png)

### Template translation: {#template-translation}

Translating templates follows the same process as translating WordPress pages & posts. Your template settings & type will be automatically duplicated to the translated post.

:::note
If the translation of templates is not automatically enabled when you activate WPML, please [refer to the WPML documentation](https://wpml.org/documentation/support/language-configuration-files/#custom-types) on how to enable translation for custom post types, and ensure that it is enabled for “bricks_template”.
:::

![](imgs/bricks-wpml-15-1024x296-57a6e9acc0.png)

![](imgs/bricks-wpml-14-02733440de.png)

### Example: Translating an archive template:

We have set up a simple archive template, which is applied to both the "Blog" page and its translated version, "Blogue".

![](imgs/bricks-wpml-17-1024x428-3af0457f1a.png)

![](imgs/bricks-wpml-19-564x1024-ef8b4a1a74.png)

Each blog page will only display blog posts of that particular language (using only one template):

![](imgs/bricks-wpml-18-1024x545-b6867df6c7.png)

![](imgs/bricks-wpml-25-1024x563-ba4714525d.png)

## Language switcher & menu translation

### Language switcher

Bricks provides a “Language switcher” element for WPML, which you can add anywhere on your site.

By default, the language switcher comes with a basic preset design. However, you can always customize the switcher to match your website style:

1. Go to **WPML **→ **Languages**.
2. Scroll down to **Custom language switchers** and check the **Enable **box. This will reveal a **Customize **button.
3. Click the button to set your custom preferences and save.

Your changes will immediately take effect on your website.

![](imgs/bricks-wpml-7-1024x515-05d35589f3.png)

![](imgs/Adding-language-swicther-in-Bricks-2ff09b9009.png)

![](imgs/Viewing-language-switcher-on-front-end-b708121596.png)

### WPML menu translation:

Consult WPML documentation for guidance on [translating WordPress menus](https://wpml.org/documentation/getting-started-guide/translating-menus/).

## Sync Bricks data across translated pages {#sync-bricks-data}

After translating a page, you might want to modify the original page. Those changes you perform with Bricks in your original page are not applied to the secondary language pages.

But Bricks and WPML make it seamless to sync your design changes across translated pages without affecting the translated text. Here’s how you can do it:

### Step 1: Edit your original page with Bricks

Open the page in the primary language in the builder. Make the necessary design changes (edit layout, change styles, etc.)

### Step 2: Save your changes

Once done, save your changes.

### Step 3: Edit with WordPress

Close the builder by clicking "Edit with WordPress" to edit the page in WordPress.

![](imgs/bricks-wpml-26-1024x568-d4e89d4c1e.png)

### Step 4: Update translation in the "Languages" panel

In the WordPress editor, navigate to the "Languages" panel. Typically found in the right sidebar or the document settings panel.

Here, you will find an option to edit or update the translation. Click the icon to open the "Advanced Translations Editor" as shown in this screenshot:

![](imgs/bricks-wpml-27-532x1024-1f11064b01.png)

Translate any untranslated strings inside the Advanced Translation Editor, then click the "Complete" button at the bottom of the screen. Your new design changes are now synced with this translated page without affecting the translated text.

## Creating different designs per language {#different-designs}

You can also access and edit the translated content directly with Bricks for specific language design or content modifications. For instance, instead of simply translating the text of your homepage, you can create a completely different layout that appeals to a specific target audience.

To create a different design per language:

1. Use the admin language switcher to change to the language you want to edit.
2. Find the page or template you want to make changes to and open it in Bricks.

![](imgs/Switching-to-translations-in-WordPress-admin-1024x692-918234febe.png)

1. Make your design changes and save. Your pages will now have different designs when switching languages.

![](imgs/Translations-with-design-A-1024x661-2d2c514c64.png)

![](imgs/Translations-with-design-B-1024x661-344f18f5b6.png)

## Additional resources

Consult the following official WPML documentation for further guidance:

1. [**Getting Started with WPML**.](https://wpml.org/documentation/getting-started-guide/)
2. [**WPML FAQ**.](https://wpml.org/faq/)
3. [**Translating Content Created with Page Builders**.](https://wpml.org/documentation/translating-your-contents/page-builders/)
4. [**Translating External Links**.](https://wpml.org/announcements/2020/02/translating-links-with-advanced-translation-editor/)

## Fancy trying out WPML?

If you found this post insightful and you're considering giving WPML a try, we encourage you to use [our affiliate link](https://wpml.org/?aid=482001&affiliate_key=S35UDkP4zjiP).

*Note: The link we've provided is an affiliate link. This means we may earn a small commission if you decide to make a purchase through it. This comes at no extra cost to you, and it assists us in further innovating and refining our offerings.*

---


## How to get your Instagram Access Token

*來源網址：https://academy-preview.bricksbuilder.io/integrations/instagram-access-token/*

To use the Instagram Feed element (@since 1.9.1), you need an access token. This token allows secure retrieval of your Instagram account data. This guide explains how to get the token using the Instagram API with Instagram Login.

:::note
Before you can publish your app and generate an access token, you must connect your app to a **Business that has completed Business Verification**. Follow Meta’s [Business Verification guide](https://developers.facebook.com/docs/development/release/business-verification/) for instructions.
:::

## Step 1: Ensure you have an Instagram Creator or Business account

Before proceeding, make sure your Instagram account is either a **Creator** or **Business** account.

1. Log in to your Instagram account.
2. Convert your account by following these instructions:
  - [Set up a Creator Account](https://help.instagram.com/2358103564437429?helpref=faq_content).
  - [Convert to a Business Account](https://help.instagram.com/502981923235522).

## Step 2: Set up an application

You first have to set up an application on the Meta for Developers platform by following these steps:

1. Access your [Meta for Developers platform](https://developers.facebook.com/apps). You can use an existing account or [create a new one](https://developers.facebook.com/docs/development/register/).
2. Provide an **App Name** and **Contact Email**.
3. Click **Create App**, then:
  - Under **Add use cases**, select **Manage messaging & content on Instagram** (from the **Content management category**), then click **Next**.
  - When prompted, you may connect a Business account now or skip and do it later.
4. Click **Next** and then **Go to dashboard** to complete the setup.

You will be redirected to the app dashboard for your new app with products you can add to your app.

## Step 3: Add the Instagram product to your app

1. On the app dashboard, scroll down to **Products** and locate **Instagram**.
2. Click **Set Up** next to Instagram.
3. Select **API Setup with Instagram Login** (NOT API Setup with Facebook Login).

## Step 4: Generate your Instagram access token

To retrieve an access token:

1. Assign an Instagram account for token generation:
  - In the App Dashboard, go to **Instagram > API Setup with Instagram Login**.
  - Click **Add an Instagram Account**.
  - Log in with your Instagram Creator or Business account credentials.

![](imgs/bricks-instagram-generate-access-token-1024x684-cd344b7186.png)

1. Confirm the account connection:
  - Your Instagram account must be public.
  - If you manage multiple accounts, ensure the correct one is selected.
2. Copy the generated access token tied to the assigned Instagram account.

## Step 5: Add the access token to Bricks

To finalize the setup, navigate to `Bricks settings > API keys` from your WordPress dashboard and paste the access token into the `Instagram Access Token` input field, and save your changes.

![](imgs/bricks-instagram-access-token-20-1024x101-6c47192621.png)

For more information, refer to Meta’s official documentation: [Create a Meta App for Instagram Platform](https://developers.facebook.com/docs/instagram-platform/instagram-api-with-instagram-login/create-a-meta-app-with-instagram).

**Note:** Once you retrieve and add the access token, Bricks will automatically refresh it every **20 days** using the `bricks_refresh_instagram_access_token` CRON job. No manual updates are required.

---


## Map (Leaflet)

*來源網址：https://academy-preview.bricksbuilder.io/integrations/map-leaflet/*

Starting with **Bricks 2.1**, you can use the new **Map (Leaflet)** element to display fully interactive maps powered by [Leaflet.js](https://leafletjs.com/).

This element allows you to combine multiple map layers, add custom markers, and fine-tune map behaviour directly inside Bricks.

## Overview {#overview}

The Map (Leaflet) element is divided into three main groups of settings:

1. **Layers** – define map sources (OpenStreetMap, OpenTopoMap, etc.)
2. **Markers** – add custom points with icons and popups
3. **Map** – configure global map settings (center, zoom, etc.)

Let’s explore each group in detail.

## Layers {#layers}

Layers control which map tiles are displayed.

Each layer is defined through a **Repeater**. Meaning you can add multiple layers (map styles) and let visitors switch between them.

For each layer, you'll configure:

- **Name** – label shown in the layer switcher (e.g. “Street Map”, “Topographic”).
- **URL** – the provider URL (e.g. `https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png`). You can view list of *some* providers [here](https://leaflet-extras.github.io/leaflet-providers/preview/index.html).
  - The placeholders `{s}`, `{z}`, `{x}`, `{y}` must be present because Leaflet replaces them dynamically:
    - `{s}` → subdomain (a, b, c, …)
    - `{z}` → zoom level
    - `{x}` / `{y}` → tile coordinates
- **Min/Max Zoom** – zoom levels the layer supports.
- **Error Tile URL** – fallback image if tiles fail to load.
- **Attribution** – copyright or usage text (required by most providers).

👉 Example:

- **Street Map** → OpenStreetMap tiles
- **Topo Map** → OpenTopoMap tiles
- **Satellite** → Esri or other provider

Your users can then toggle between these layers on the frontend.

## Markers {#markers}

Markers let you highlight specific points of interest on your map.

You can set:

- **Default Marker Icon** – used if no custom icon is defined.
- **Marker Repeater** – add multiple markers, each with:
  - **Coordinates (Lat, Lng)**
  - **Label** (for identification)
  - **Custom Icon** (optional, overrides default icon)
  - **Popup Text** (text that shows when the marker is clicked)

## Map

The **Map** group controls the basic setup of your map. The most important settings are the **map height**, which is set to 300 px by default but can be adjusted to match your layout, along with the **map center** (latitude and longitude) and the **initial zoom level**. These define how the map looks and where it is focused when first loaded.

Beyond that, you’ll also find controls grouped around **zoom behaviour**, **map interactions** (like dragging and clicking), and **display options** (such as attribution and resizing). All of these settings are based on Leaflet.js, and you can find full descriptions in the [Leaflet documentation](https://leafletjs.com/reference.html#map).

---


## How to use Polylang with Bricks

*來源網址：https://academy-preview.bricksbuilder.io/integrations/polylang/*

Polylang is a WordPress plugin designed to simplify the creation of multilingual websites.

With Polylang, you can write posts, custom post types, pages, create categories, and post tags in multiple languages.

In combination, Bricks and Polylang facilitate the design and management of multilingual websites.

After creating a page in your default language with Bricks, you can use Polylang to translate the page into any other language your website supports.

## Setting up Polylang with Bricks

Assuming you have Bricks installed and activated on your WordPress site, the next step is to set up Polylang. This guide applies to both the free version of Polylang and Polylang Pro.

To set up Polylang with Bricks, follow the steps below:

1. In your WordPress dashboard, go to `Plugins > Add New`.
2. Type "Polylang" into the search bar and press Enter.
3. You'll see the Polylang plugin in the search results. Click on `Install Now`.
4. After the installation is complete, click `Activate`.
5. Once activated, a new `Languages` menu item appears on your WordPress dashboard. Visit it, and add the languages you want to support on your website.

:::note
Remember to set the default language and add other languages as needed.
:::

:::note
After adding languages and assigning any current posts/pages to their appropriate language, you can start translating your pages and posts with Polylang.
:::

For Polylang Pro users, the installation process is slightly different as the plugin needs to be downloaded from the Polylang website and uploaded to your WordPress site. You can refer to the official Polylang documentation for detailed instructions on installing Polylang Pro.

For detailed instructions on configuring Polylang's settings, please refer to the [official Polylang documentation](https://polylang.pro/doc-category/getting-started/).

## Translating posts & pages

Translating your pages and posts using Polylang and Bricks is a straightforward process. Here are the steps:

1. In your WordPress dashboard, navigate to the page or post you want to translate.
2. On the right-hand side, you'll see a "Languages" meta box (added by Polylang). This box displays your default language and other languages you've added.
3. Under each language, you'll see a "+" button. Click this button to create a new translation for the selected language.

![](imgs/polylang-translate-post-e7799c30f1.png)

1. This action will create a new page or post draft. You can now use Bricks to design your page or write your post in the new language.
2. Once you're done, click "Publish". The translated page or post will automatically be linked to the original one.

:::note
**Note:** Polylang Pro users have the advantage of the "Clone" feature, which allows you to copy the entire content and settings of a page or post into a new translation. This can significantly speed up the translation process, especially for complex layouts.
:::

For users of the free version of Polylang, the [Yoast Duplicate Post](https://wordpress.org/plugins/duplicate-post/) plugin can be a good alternative. It allows you to duplicate a post or page, which you can then edit with the translation.

Make sure to enable the duplicator for the "My templates" post type under `Settings > Duplicate post > Permissions`. **Assign the duplicate page to the correct language and link it back to the page you’ve cloned it from.**

Please ensure you check the [official Polylang documentation](https://polylang.pro/doc/translating-pages-posts-categories-and-tags/)for detailed instructions.

## Translating components {#translating-components}

Since Bricks 2.2-beta, you can now translate components with Polylang. All component strings are registered automatically, and you can translate them directly from the WordPress dashboard.

To translate component strings:

1. Go to **Languages > Translations**.
2. Search for the component string you want to translate.
3. Add translations for each language your site supports and save.

:::note
Make sure the admin language selector in the top admin bar is set to **Show all languages**.
:::

1.

## Translating templates {#translating-templates}

Translating templates in Bricks using Polylang is a similar process to translating standard pages or posts.

1. From your WordPress dashboard, navigate to `Bricks > Templates` in your WordPress dashboard.
2. Choose the template you want to translate and assign a language to it in the "Languages" meta box.

![](imgs/polylang-bricks-template-assign-language-9f6bf2d551.png)

1. Once the language is set, you can initiate the translation process as you would do with a standard post or page by clicking the "+" button for the desired language in the Languages meta box.

![](imgs/polylang-bricks-translate-template-c7eda02535.png)

1. The newly translated template will be created in draft mode. At this point, you can modify the content and adapt it to the new language using Bricks.

![](imgs/polylang-bricks-template-translated-4c2714eaa3.png)

:::note
**Note:** Setting a language for your current templates, if not already assigned, is a prerequisite before you can translate them.
:::

:::note
**Important:** Duplicating the template for each language you wish to translate it into is essential. If a Bricks page uses a template that has not been translated into the page's language, that template will not be visible on the page in that language. Hence, ensure that all the templates used on your pages are translated for each supported language.
:::

## Using templates conditions {#template-conditions}

Bricks templates have [template conditions](/builder/features/template-settings/) that define where a particular template is rendered on your website. While these conditions offer flexibility, using them with Polylang introduces complexities due to how Polylang handles languages as WordPress taxonomy terms.

Although you can select language terms in Bricks conditions, it's generally not recommended because of potential unexpected bugs. This is due to Polylang creating distinct posts or pages for each language, which are separate entities linked by the plugin.

Due to backward compatibility, these language terms are available in the conditionals but may not behave as expected.

:::note
Instead, it's advisable to directly translate the templates as covered in the [Translating templates](#translating-templates) section. This involves duplicating each template for every language you want to support and translating the content within those templates. This method ensures consistent results when showing the correct template per language and avoids potential confusion and inconsistencies.
:::

## Managing multilingual menus {#managing-multilingual-menus}

Polylang's method for handling menu translations involves creating a separate menu for each language. To do so, you should follow these steps:

1. Go to `Appearance > Menus` in your WordPress dashboard.
2. Click `Create a new menu`.
3. Give your menu a name, ideally including the language for easy identification.
4. Choose the display location for this menu, then click `Create Menu`.
5. *(Optional)* Use the admin language option in the admin bar at the top of the screen to match the menu language. This ensures the pages listed are in the selected language, helping you add the correct content.
6. Start adding the pages, posts, categories, or custom links this menu will contain.
7. Repeat these steps for each language your website supports.

:::note
Keep in mind that Polylang changes the language of the content on your site, not individual menu items, so you’ll need to create separate menus for each language. Additionally, when translating a page or template (e.g., a header template with a Nav element), be sure to edit the navigation element in the translated template to select the correct menu for that language. This ensures that each language version of the header template displays the appropriate menu.
:::

For more details, please refer to the Polylang documentation: [https://polylang.pro/doc/create-menus/](https://polylang.pro/doc/create-menus/).

## The language switcher

Bricks provides a dedicated "Language switcher" element for Polylang, which you can add anywhere on your site and customize without leaving the builder.

![](imgs/bricks-polylang-language-switcher-d685cd7efd.png)

:::note
To replace default Polylang flags with custom ones, please refer to the Polylang documentation on this topic [here](https://polylang.pro/doc/can-i-use-my-own-flags-for-the-language-switcher/).
:::

You can also add the language switcher to your WordPress menu by adding the "Language switcher" under Appearance > Menus like this:

![](imgs/bricks-polylang-language-switcher-wp-nav-menu-c04b35a969.png)

## Troubleshooting common Polylang issues

When integrating Polylang with Bricks, you might encounter some common issues. Here are a few possible problems and suggested solutions:

### 1. Templates don't show after Polylang activation

If you have Bricks templates that don't appear after activating Polylang, this might be due to language settings. Ensure each of your templates is assigned a language. This setting is found on the right side of the WordPress editor page under "Languages". Remember to update your template after assigning a language.

### 2. Untranslated templates do not appear

When an untranslated Bricks template doesn't appear, it might be due to a language discrepancy between the page and the template. If a Bricks page uses a template that isn't translated into that page's language, the template won't show. To fix this, translate your templates into all languages your pages use.

### 3. Incorrect language in menus

If a menu appears in the wrong language, double-check that you've assigned the correct language to each of your menus, as per the [Managing multilingual menus](#managing-multilingual-menus) section above. Remember, Polylang requires a separate menu for each language on your site.

### 4. Incorrect language query results in Archive or Search template

Please ensure all archive or search templates have enabled **Is main query** on the main query loop.

## Additional resources

To learn more about Polylang and its various features, you can refer to the following resources from Polylang's official documentation:

1. [Getting Started with Polylang](https://polylang.pro/doc-category/getting-started/): This guide covers the basics of setting up and using Polylang on your WordPress site.
2. [Polylang FAQ](https://polylang.pro/doc-category/faq/): Here you'll find answers to commonly asked questions about using Polylang.
3. [Polylang advanced](https://polylang.pro/doc-category/polylang-advanced/): This section provides more advanced Polylang guides.

These resources can provide additional insights and answers to more specific or complex issues you might encounter when using Polylang.

---


## Unsplash Integration

*來源網址：https://academy-preview.bricksbuilder.io/integrations/unsplash/*

Finding affordable, high-quality, commercially useable photography for your website (that doesn't scream stock photography) is really hard. Bricks is putting an end to it.

[Unsplash.com](https://unsplash.com?ref=bricksbuilder), the world's largest and most generous community of photographers, allows you to use their photography royalty free (commercial use included). No linking back or attribution required. Unsplash operates under a so-called "do whatever you want" [license](https://unsplash.com/license).

Browse and download any Unsplash photo inside the builder by clicking the **Browse Unsplash** button below any image control.

https://youtu.be/yLgi-L2doIM

## Rename & Download

Hover over any photo and click the** Download** button to download a photo from Unsplash directly into your WordPress media library. All resizing is done automatically in the background for you.

File renaming is enabled by default, to give your images this extra SEO push. If you prefer to keep the default file names you can disable the "Rename images" checkbox in the top right corner of the Unsplash popup.

## How To Generate Your Unsplash API Key

To receive access to Unsplash's photo library you need to generate an API key. It's 100% free and only takes two minutes.

1. Create an Unsplash developer account if you don't already have one:
[https://unsplash.com/developers](https://unsplash.com/developers)
2. Log in and visit [https://unsplash.com/oauth/applications](https://unsplash.com/oauth/applications)
3. Click **New Application**, check all boxes and click **Accept terms**.
4. Fill out the application name and description and click **Create application**.
5. Scroll down to **Keys** and copy the **Access key**.
6. Return to your WordPress dashboard. Go to **Bricks > Settings > API Keys** and paste your Unsplash API key under **Unsplash API Key**. Click Save.

If you click on **Browse Unsplash** below any image control in the builder the latest Unsplash photos should now appear, ready for you to download.

---


## Cart (WooCommerce)

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/cart/*

The cart page is a special WooCommerce page, created by default during WooCommerce installation. It contains WooCommerce Cart gutenberg blocks. Please remove all of the gutenberg blocks and use `[woocommerce_cart]` instead.

:::note
Remove the Gutenberg Cart block if it is located within your Cart Page. Instead, replace it with [woocommerce_cart] or utilize the Shortcode element if you have edited the Cart page with Bricks.
:::

![](imgs/remove-gutenberg-cart-blocks-7806b6f1d6.png)

Bricks is only supporting `[woocommerce_cart]` shortcode. You can either place the `[woocommerce_cart]` shortcode directly in the Cart page, or edit the Cart page with Bricks, then use Shortcode element and set the content as `[woocommerce_cart]`. Bricks offers two different template types (in this context, they are like template parts) to customize the cart:

- **WooCommerce - Cart**: Rendered when the cart contains products.
- **WooCommerce** - **Empty** **Cart**: Rendered when the cart is empty.

![](imgs/bricks-woocommerce-templates-cart-a68b4c2fa3.png)

:::note
The "Cart" and "Empty Cart" template types are only visible if you have the WooCommerce plugin installed and active. These templates are used inside the WooCommerce Cart shortcode logic and **they do not support template conditions (they are automatically rendered on the correct page)**.
:::

By default, the cart in the Bricks theme will be shown as in the image below. You'll notice there are typically two different zones: the cart items table & the cart totals:

![](imgs/bricks-woo-cart-blocks-aba769c7a5.png)

If you want to customize this screen, you'll need to create a **WooCommerce - Cart** template type.

:::note
Please remember to add [template hooks](/integrations/woocommerce/woocommerce-template-hooks/#cart-template-hooks) if you are using third-party plugins.
:::

## Template Type: WooCommerce - Cart {#cart-template}

You would set the **WooCommerce - Cart** template type to customize the Cart page (used when the cart contains products).

When opening this template with Bricks you'll see three new elements (specific for this template type):



![](imgs/bricks-woo-cart-elements-fed76934c8.png)

<figcaption>

The specific Bricks elements to be used inside the "WooCommerce - Cart" template type

</figcaption>



### Cart items

Render the cart contents table. With this element, you'll be able to hide different parts of the table, style the table elements and the buttons, and hide the coupon input (so you could set it separately using the **Cart Coupon** element). For custom layout, check the section down below [Cart contents loop](#loop).

### Cart totals

Renders the cart totals zone. With this element, you could hide the cart cross-sells, style the totals table, and style the button.

### Cart Coupon

Render the coupon input. Use this element if you don't want to have the coupon input attached to the cart items table. With this element, you could style the input and the apply coupon button

## Template Type: WooCommerce - Empty Cart {#empty-cart-template}

You would set the** WooCommerce - Empty Cart** template type to customize how the cart page renders when the cart is empty.

By default, the empty cart shows a message and a button to return to the shop page.

![](imgs/bricks-woocommerce-empty-cart-screen-d465d93d95.png)

To customize this screen you need to create a **WooCommerce - Empty Cart** template type where you could place the required elements and configure as needed.

## Cart contents loop {#loop}

Bricks 1.4. introduces a new query loop type, the **Cart Contents**. This query loops through all the products in the cart thus enabling the usage of the [Dynamic Data tags](/integrations/woocommerce/woocommerce-builder/#dynamic-data) to get the product name (post title), the product image (featured image), and the product-related tags like the product price, description, SKU and so on. This query loop is just for the Cart page.

This will allow you to build your own cart items widget, and place it anywhere on your site.

### Build your own cart items element inside the cart page {#custom-cart-contents-loop}

By default, the list of products inside the cart appears displayed on a table layout. This happens in the default WooCommerce cart template or when using the Bricks Cart Items element.

To create a different layout for the cart products list, you'll need to add a container with a query loop, and set it to **Cart Contents**. Inside this container you may use the following new dynamic data tags (since Bricks 1.5.3):

:::note
In order to make your custom cart loop work, you must add `woocommerce-cart-form__cart-item cart_item` CSS class on the loop itself and add `woocommerce-cart-form__contents` CSS class on the parent of looping div.
:::



![](imgs/bricks-woo-cart-loop-css-class-a9949ed8f6.png)

<figcaption>

CSS classes needed for WooCommerce JS works in cart page

</figcaption>



![](imgs/cart-contents-query-loop-d8058cc1a1.png)

<figcaption>

Cart Contents query loop

</figcaption>



- `{woo_cart_product_name}` - Renders the product name with a link. It is meant to be used inside of the Cart Contents loop.
- `{woo_cart_remove_link}` - Renders the anchor tag with the link to remove the product from the cart. By default, uses an "x" in the anchor content. Remember to add `product-remove` CSS class on the element that holding this dynamic tag. Do **NOT** use on Rich text element or additional `` tag will cause the AJAX not working.
- `{woo_product_price}` - This tag shows the product price. But when used inside of the Cart Contents loop it doesn't show the sale price.
- `{woo_cart_quantity}` - Renders the input field to add/remove the product quantity inside of the cart.
- `{woo_cart_subtotal}` - Renders the product price subtotal (price x quantity)

To complete this component, you have to wrap the products loop inside a `form` tag in order to use the product quantity input fields. To do that, wrap the container loop inside of another container (or div, or block) and set the HTML tag to `custom` and then insert `form` in the Custom tag input field.



![](imgs/bricks-container-form-cart-items-93f16cbdbb.png)

<figcaption>

Wrap the products loop with a form container

</figcaption>



:::note
**IMPORTANT**: Using Bricks 1.10.2+ you have explicitly allow the `form` HTML tag programmatically. Please follow the instructions at [/developer/hooks/filters/filter-bricks-allowed_html_tags/](/developer/hooks/filters/filter-bricks-allowed_html_tags/)
:::

This form container, in order to work properly with the WooCommerce scripts needs the following configurations:

- Add the custom class `woocommerce-cart-form` (Style > CSS > CSS classes)
- Add custom attributes: method = `post` and action = `{post_url}`



![](imgs/example-form-container-98fc67c778.png)

<figcaption>

Example Form container

</figcaption>



![](imgs/bricks-cart-form-attributes-2-7db061c007.png)

![](imgs/bricks-cart-form-attributes-b5ff2d12f5.png)

To add the update cart button, there's also another dynamic data tag `{woo_cart_update}` that you'll need to add inside of the form container (but outside of the loop). This will generate a button with the proper settings to update the cart.

---


## Checkout (WooCommerce)

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/checkout/*

The checkout page is a special WooCommerce page, created by default during WooCommerce installation. It contains WooCommerce Checkout gutenberg blocks. Please remove all gutenberg blocks and use `[woocommerce_checkout]` instead.

:::note
Remove the Gutenberg Checkout block if it is located within your Checkout Page. Instead, replace it with [woocommerce_checkout] or utilize the Shortcode element if you have edited the Checkout page with Bricks.
:::

![](imgs/remove-gutenberg-checkout-block-76874bded5.png)

Bricks is only supporting `[woocommerce_checkout]` shortcode. You can either place the `[woocommerce_checkout]` shortcode directly in the Checkout page, or edit the Checkout page with Bricks, then use Shortcode element and set the content as `[woocommerce_checkout]`. Bricks offers four different template types (in this context, they are like template parts) to customize the checkout workflow:

- WooCommerce - Checkout
- WooCommerce - Thank you
- WooCommerce - Pay
- WooCommerce - Order receipt

![](imgs/bricks-woocommerce-checkout-templates-3aae203491.png)

:::note
The "WooCommerce - Checkout", "WooCommerce - Pay", "WooCommerce - Thank you", and "WooCommerce - Order receipt" template types are only visible if you have the WooCommerce plugin installed and active. These templates are used inside the WooCommerce checkout shortcode logic and **they do not support template conditions (they are automatically rendered on the correct page)**.
:::

## Checkout template {#checkout-template}

The default checkout page consists of a two-columns layout: one column with the billing and shipping details form and another one with the order summary + a button to proceed with the order.



![](imgs/bricks-woocommerce-checkout-screen-2ba0697bad.png)

<figcaption>

Bricks default WooCommerce default checkout screen

</figcaption>



Use the **WooCommerce - Checkout** template type to change the appearance of this first checkout screen.

When editing this template with Bricks you’ll see two new elements (specific to this template type):

![](imgs/bricks-woocommerce-checkout-elements-80b945f5e7.png)

### Checkout customer details

The checkout customer details element renders the billing and shipping details form.

You'll be able to remove/hide some of the non-required fields (e.g. Company name) and style the form fields.

### Checkout order review

The checkout order review element renders the order summary, the available payment methods, and the button to place the order. Using this element, you'll be able to style its different parts.

### Remove the checkout coupon form {#remove-coupon-form}

If you have enabled the use of coupons in the WooCommerce general settings you'll notice a blue coupon form on the top of the checkout form page. If you want to remove this form from the checkout page you may hide it using custom CSS or adding the following code to your child theme:

```php
remove_action( 'woocommerce_before_checkout_form', 'woocommerce_checkout_coupon_form', 10 );
```

### Checkout Coupon & Checkout Login elements {#checkout-coupon-login}

Starting at version 1.11.1 you have greater control over the location and design of the checkout coupon & login by enabling and using the following two checkout elements:

- [Checkout Coupon element](/integrations/woocommerce/element-checkout-coupon/)
- [Checkout Login element](/integrations/woocommerce/element-checkout-login/)

## Thank you template {#thank-you-template}

After placing an order, and depending on the payment workflow, you'll get to the "Thank you" screen.



![](imgs/bricks-woocommerce-checkout-thank-you-e5c0624d44.png)

<figcaption>

The Bricks default **Thank You** screen

</figcaption>



To style this screen, you'd create a Bricks template of type **WooCommerce - Thank you**. And insert the **Checkout Thank You** element to customize the thank you message, and modify the styles of the different components of the order details.

## Pay template {#pay-template}

For the situation where the visitor gets a link to pay for an unpaid order, there's a special checkout screen that contains the order summary, the available payment gateways, and the button to pay for the order.



![](imgs/bricks-woocommerce-form-pay-default-471x1024-70038ec928.png)

<figcaption>

Default pay form screen with the representation of the Bricks elements

</figcaption>



If you would like to customize this screen you'd need to add a **WooCommerce - Pay** template type where you'll have access to two new elements: the **Checkout order table** and the **Checkout order payment** both with style controls to customize the look and feel.

## Order receipt {#order-receipt-template}

For the situation where the visitor gets a link to the unpaid order receipt, the checkout workflow triggers the `checkout/order-receipt.php` template, which by default will look like this:

![](imgs/bricks-woocommerce-order-receipt-default-f0fda4a858.png)

If you would like to customize this template you could add the Bricks **WooCommerce - Order receipt **template type and inside the builder, you'll have access to the order-specific Dynamic Data tags such as:

![](imgs/bricks-woocommerce-order-dynamic-data-tags-6aa5075155.png)

`{woo_order_id}` - Returns the order id

`{woo_order_number}` - Returns the order number

`{woo_order_date}` - Returns the order date

`{woo_order_total}` - Returns the order total

`{woo_order_payment_title}` - Returns the order payment method name

`{woo_order_email}` - Returns the email address registered with the order

:::note
**NOTE:** These Dynamic Data tags will also work inside the **WooCommerce - Thank you** template type.
:::

---


## Creating dynamic WooCommerce archive pages

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/creating-dynamic-woocommerce-archive-pages/*

By following this tutorial, you will be able to create a custom WooCommerce archive template that can show product categories and products.

At the same time you can also use the **Shop page display** option and **Category page display** option to control when to show categories or products.



![](imgs/woocommerce-product-catalog-options-6c2e3b22c2.png)

<figcaption>

Appearance > Customize > WooCommerce > Product Catalog

</figcaption>



![](imgs/dynamic-woo-archive-result-2bf0c37199.gif)

<figcaption>

Example result

</figcaption>



## Step 1: Products & Product Categories Preparation

Ensure your product categories created included subcategories as well. Add some products and assigned them to different product categories. Best if you can add some images for each category, we will output them in the template too.

![](imgs/woocommerce-data-prepared-1024x643-c7acdaf9eb.png)

## Step 2: Create WooCommerce Archive

Remember to select the correct template type (**WooCommerce - Product archive**)
If you are not familiar with the Bricks product archive, you can learn more about them [here](/integrations/woocommerce/product-archive-woocommerce/).

![](imgs/woo-archive-template-9f9c19ae11.png)

Set the conditions for the template in Settings > Template Settings > Conditions so it will be applied when browsing the WooCommerce shop page and product categories & tags archive pages.

![](imgs/woo-archive-template-conditions-24eede5872.png)

You have to create 2 different query loops and we will use condition to dynamically render them in actual frontend. In below example, 2 sections were created. 1 for the product categories loop, and another 1 for the products loop.

![](imgs/2-sections-for-2-loops-5052340cd2.png)

## Step 3: Product Categories Section

:::note
Important: You must enable code execution when using echo dynamic tag. Please also ensure the function names added in the `bricks/code/echo_function_names` hook. Reference: [Code Review](/builder/features/code-review/)
:::

To show product categories dynamically, you will need to use `get_queried_object_id()` PHP function on Parent field. Simply use Bricks echo dynamic tag and set `{echo:get_queried_object_id}` on Parent field like below.

![](imgs/product-categories-loop-settings-6551ab17c9.png)

Additionally, we will also use `woocommerce_get_loop_display_mode()` PHP function from WooCommerce to conditionally display this section.

`woocommerce_get_loop_display_mode()` will return either **products**, **subcategories**, or **both** (in string) based on your settings.

![](imgs/woocommerce_get_loop_display_mode-bb42e7fb44.png)

Let's set the condition on the categories section like this:

Use `{echo:woocommerce_get_loop_display_mode}` != products



![](imgs/product-categories-section-condition-settings-2aafeb7d24.png)

<figcaption>

This section will show if you are not selecting Show products

</figcaption>



Here are the settings for the looping images and text of my example.`{woo_product_cat_image}` to output the category image. `{term_name:link}` to output the category text with link

![](imgs/looping-term-settings-769be62581.png)

## Step 4: Products Section

Query settings for products are pretty straightforward, just control how many posts per page will do.

![](imgs/products-loop-settings-e7068a4157.png)

Let's set the condition on the products section like this:

Use `{echo:woocommerce_get_loop_display_mode}` != subcategories



![](imgs/products-condition-settings-01-f8b0a2b151.png)

<figcaption>

Products section will shows if you are not selecting Show subcategories / Show categories

</figcaption>



Here are the settings for the looping product for your reference. (Only focus on the dynamic tag I used instead of the style)

![](imgs/looping-product-settings-5e70006e27.png)



![](imgs/product-structure-e3d67795fb.png)

In case your product has multiple product categories checked, but you wish to output the first checked category only so the green box wouldn't be too long, you can use this simple custom function. Just replace the `{post_terms_product_cat}` with `{echo:product_first_category_name}`

```php
// Place in your child theme functions.php
// Returns the first category name of a product
function product_first_category_name() {
	global $product;
	if( $product && is_a( $product, 'WC_Product' ) ) {
		// Get the product categories
		$terms = get_the_terms( $product->get_id(), 'product_cat' );

		$cats = [];

		// Loop through the categories, and add them to the $cats array
		foreach( $terms as $term ) {
			$cats[] = $term->name;
		}

		// Return the first category
		if( ! empty($cats) ) {
			ob_start();
			echo $cats[0];
			return ob_get_clean();
		}
	}
}

```

## Check Result

Now, your shop page and product category pages should be able to work as expected. You can always control when to display the product categories section and products section via the settings in the WordPress dashboard under **Appearance > Customize > WooCommerce > Product Catalog**



![](imgs/dynamic-woo-archive-final-result-96835d135e.gif)

<figcaption>

Custom WooCommerce Archive Template

</figcaption>

---


## Element: Checkout Coupon

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/element-checkout-coupon/*

This Checkout coupon element, available @since 1.11.1, allows you to display the coupon field in various locations on the checkout page, making it easy for customers to apply discount codes during their purchase.

In previous versions, you couldn’t control the location of the checkout coupon. Additionally, styling options were limited, and adjustments required custom CSS. With this new, dedicated checkout coupon element you now have greater control over placement and design.

To use this element, first enable it under **`Bricks > Settings > WooCommerce`** by turning on **`Enable Bricks WooCommerce "Checkout coupon" element`**.

![](imgs/woocommerce-checkout-coupon-setting-0904751fda.png)

:::note
**Note:** This element is specifically designed for the Checkout page and will only work when placed on the **Checkout template** or the Checkout page itself, depending on your design requirements.
:::

**Key Controls**

**Location:**

- By default, the **Checkout Coupon** element will appear where it’s placed in the layout. However, you can choose alternative positions, such as: Before Order Review Heading, After Order Review Heading, Before Payment
- Custom location settings only apply on the actual frontend (Checkout page). To ensure correct placement, add this element at the top of your Checkout template.

![](imgs/woocommerce-checkout-coupon-element-controls-b0380e9852.png)

![](imgs/element-location-example-4a61316ca3.png)

You can set the form to be toggle-able, hiding it by default and revealing it only when the toggle is clicked, for a cleaner layout.

---


## Element: Checkout Login

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/element-checkout-login/*

The Checkout Login element allows for a convenient login option directly on the checkout page, enabling returning customers to sign in before completing their purchase.

This features becomes available once you've enabled the **`Enable login during checkout`** under **`WooCommerce > Settings > Accounts & Privacy`** .

In previous versions, the placement of the checkout login form was fixed, and styling options were limited, requiring custom CSS for adjustments. Now, you can control both placement and appearance.

![](imgs/woocommerce-enable-login-during-checkout-896d42520e.png)

To use this element, activate it under **`Bricks > Settings > WooCommerce`** by toggling on **`Enable Bricks WooCommerce "Checkout login" element`**.

![](imgs/woocommerce-checkout-login-setting-38a81d8895.png)

:::note
**Note:** This element is specifically intended for the Checkout page. Place it within the **Checkout template** or directly on the Checkout page, depending on your design needs.
:::

**Key Controls**

**Location:**

- By default, the **Checkout Login** element will appear where it’s placed in the layout. However, you can choose alternative positions, such as: Before Order Review Heading, After Order Review Heading, Before Payment.
- Custom location settings only apply on the frontend. To ensure the login form appears in the desired location, add this element at the beginning of your Checkout template.

![](imgs/woocommerce-checkout-login-element-controls-b5cc94a3c9.png)

![](imgs/element-location-example-4a61316ca3.png)

You can set the form to be toggle-able, hiding it by default and revealing it only when the toggle is clicked, for a cleaner layout.

---


## How to Create Product Quick View with Bricks

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/how-to-create-product-quick-view-with-bricks/*

## Step 1: Design a Popup Template for Quick View

Begin by designing the popup template that will be used for the Quick View functionality. Incorporate essential elements such as the Product Gallery, Product Rating, Product Price, and Add to Cart button.

Additionally, consider including a WooCommerce Notice element within the popup to display any notifications or confirmations directly to the user after an add-to-cart action.

It's crucial to implement the appropriate template hooks, similar to those used in a standard single product page. If you're unfamiliar with template hooks, we recommend reviewing [this article](/integrations/woocommerce/woocommerce-template-hooks/#single-product-template-hooks) for further guidance.

Below is an example of a WooCommerce Quick View Popup design:

![](imgs/woo-quick-view-design-example-9ad09f2e2f.png)

## Step 2: Configure Popup settings

To proceed, ensure that you have enabled the **"WooCommerce Quick View"** (@since 1.10.2) and **"Fetch content via AJAX"** options in **Settings > Template Settings > Popup**.

Enabling the **AJAX loader** will enhance the user experience by providing a smoother interaction with the Quick View Popup.

:::note
Do not set any template condition for the popup template as we will embed it in the Products loop.
:::

![](imgs/woo-quick-view-popup-control-560978de25.png)

## Step 3: Create a Product Query Loop

Proceed by creating a Product query loop on a new page or within your Shop page template. Insert the necessary elements according to your specific requirements.

Include the appropriate [template hooks](/integrations/woocommerce/product-archive-woocommerce/) within the loop to ensure that any WooCommerce third-party plugins can effectively apply their logic within your Product query loop.

![](imgs/woo-quick-view-query-loop-example-8002463c15.png)

## Step 4: Insert Popup template and Configure Interaction to Trigger Quick View Popup

Within the product query loop, insert a Template element and select the popup template you created in Step 1.

For a cleaner HTML structure, you may choose to enable the "Render without wrapper" option.

![](imgs/woo-quick-view-template-element-location-ac5b0be60a.png)

![](imgs/woo-quick-view-popup-template-element-f06a8c402d.png)

Instead of using the Add to Cart element within the loop, utilize a Button element.

To ensure this button triggers the Quick View popup, configure the interaction as shown in the following screenshot:

![](imgs/woo-quick-view-button-interaction-ae53e7fdef.png)

## Summary

By following these steps, you've successfully implemented a Quick View Popup feature using Bricks.

This enhancement not only improves the user experience by allowing visitors to quickly access product details without navigating away from the current page, but it also provides a seamless integration with WooCommerce.

Remember, fine-tuning the design and interaction settings can further optimize the effectiveness of the Quick View feature, ensuring it meets your specific needs and enhances your overall site performance.

---


## Product Archive (WooCommerce)

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/product-archive-woocommerce/*

:::note
The template type "WooCommerce – Product Archive" is only visible if WooCommerce is installed & active.
:::

Create a template of type "WooCommerce – Product Archive" in Bricks to design your product archive pages (product categories, tags, attributes, etc.).

To create this template, go to the Bricks templates screen and add a new template. Then select the template type **"WooCommerce – Product Archive"** from the top-right dropdown:

![](imgs/woocommerce-template-type-product-archive-bfc7fd180a.png)

Click "Publish" or "Save Draft". Then "Edit with Bricks" to open the builder.

It is also possible to create/edit this and other templates in the Bricks editor interface by clicking on the Folders icon or pressing CMD / CTRL + SHIFT + L.

:::note
Please remember to add [template hooks](/integrations/woocommerce/woocommerce-template-hooks/#product-archive-template-hooks) if you are using third-party plugins.
:::

## Product Archive Elements {#elements}

![](imgs/woocommerc-product-archive-elements-580x1024-7d4f533090.png)

### Archive title

There is no specific element to add a heading to the product archive.

To add a heading to this template you could use the Post Title element or add a Heading element with the `{archive_title}` tag.

### Breadcrumbs

Use the breadcrumbs element to output the navigation links from "Home", and higher level categories until the content displayed in the page.

This element uses the WooCommerce breadcrumbs default engine to generate each part of the breadcrumbs path.

### Products archive description

The products archive description will render the product category (or any other product taxonomy term) description.

If used in a template that renders the **Shop** page, it will output the page content (from the Gutenberg/blocks editor).

### Products

This is the main element to list products in a grid. You have controls to customize the style and layout, tweak the query, and select which content (fields) you want to show for each product.

This element interconnects with the **Products Filter**, **Products Pagination**, **Products Orderby** and the **Products Total Results** elements.

This means that the query results will be conditioned by the filters and the orderby conditions and it will also impact the pagination and the total results elements output.

The query used inside the products element to generate the grid of products will merge the query arguments from the element with the default WooCommerce query in the case the page rendered is the product archive or the product taxonomy archive (product category or product tag). This means that if you are seeing a certain product category archive page you only get a list of products from that category.

### Products filter

The products filter element allows you to add query filters to the page so the visitor could search/narrow down the list of products presented.

This element contains three filter types:

- **Taxonomy**: filter the list by one or multiple taxonomy terms.
- **Product attributes**: filter the list by product attributes like size, color or any other custom attribute used.
- **Others**: Special set of filters like a product **price dual-range slider**, a** stars rating** filter, a status **stock** filter or a simple **search** input. In this set, you will also find a **Reset filters** option which you would set to add a reset product filters button.

When using the taxonomy or product attributes filters, you may select different filter inputs, like a dropdown, a set of checkboxes, a radio list, a text list, or a box list.

### Products pagination

List of page links that allow the visitor to navigate through the different products' list pages.

### Products orderby

Adds a dropdown to the layout where the visitor could change the order of the products in the presented list. The default sort options are by popularity, by average rating, by latest, and by price (low to high and high to low). This list uses the WooCommerce default list and it can be extended using the WooCommerce hooks or third-party plugins.

### Products total results

Use this element to output the number of results returned by the current products query.

---


## Product Variation Swatches (WooCommerce)

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/product-variation-swatches/*

Bricks 2.0 introduces **Product variation swatches**, giving you more control over how product attribute options (i.e. color, size, pattern) appear on the frontend.

Instead of dropdowns, you can now display your product variations as **color swatches, image buttons, or custom labels**, creating a more visual and intuitive shopping experience.

This feature integrates directly into the **Add to cart** element, letting you style variation swatches exactly how you want, without the need for extra plugins.

![](imgs/bricks-woo-variation-swatches-before-1024x637-45c65e88ff.png)

<figcaption>

Before Product Variation Swatches

</figcaption>



![](imgs/bricks-woo-variation-swatches-after-1024x637-0469b80fd1.png)

<figcaption>

After Product Variation Swatches

</figcaption>

## Enable product variation swatches

To get started, go to **Bricks > Settings > WooCommerce > Enable product variation swatches**.

![](imgs/bricks-woo-variation-swatches-enable-b8bc7ed877.png)

Once enabled, you’ll be able to customize variation swatches directly from your product attribute settings.

## Assign a swatch type to product attributes

Go to **Products > Attributes**, and click "Edit" on an existing attribute (or create a new one).

![](imgs/bricks-woo-variation-swatches-edit-attribute-942e30f69d.png)

You’ll see a new **Swatch type** setting with the following options:

- **None (default)**: Standard WooCommerce behavior (dropdowns)
- **Color**: Displays swatches using color values
- **Label**: Displays custom text labels for each term
- **Image**: Displays swatches using images from your media library

![](imgs/bricks-woo-variation-swatches-attribute-settings-4da18dfa6d.png)

**Example:** Use the "Color" swatch type to show red and blue color boxes, or choose "Label" for size options like S, M, L.

### Set a fallback value (optional)

While editing the attribute, you can also set a **Fallback value**. This fallback will be used if a specific term doesn't have its own swatch value.

## Assign swatch values to individual terms

Next, click **Configure terms** for the attribute you just edited.

![](imgs/bricks-woo-variation-swatches-configure-terms-47ccc13137.png)

Then, click **Edit** on a specific term (like “Red” or “Large”).

![](imgs/bricks-woo-variation-swatches-edit-term-aaf2c35c01.png)

For each term, you’ll see a new input that matches the swatch type:

- **Color** → Choose a color
- **Image** → Select or upload an image
- **Label** → Add custom text

![](imgs/bricks-woo-variation-swatches-term-settings-04dd7f83da.png)

These values are what will be shown on the frontend in the Add to cart element.

## Style swatches in the Add to cart element

Variation swatches are rendered inside the **Add to cart** element, as long as your product uses attributes with a swatch type.

To style them:

1. Select the **Add to cart** element (e.g in your single product template)
2. Open the new **Variation swatches** group in the element settings

![](imgs/bricks-woo-variation-swatches-add-to-cart-4a68c0f57d.png)

From there, you can adjust the size, spacing, borders, active states, tooltips, and more.

That's it. With variation swatches, you can now turn standard variation dropdowns into polished, interactive product selectors, designed your way, directly in the Bricks builder.

---


## Single Product (WooCommerce)

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/single-product/*

:::note
The template type "WooCommerce - Single Product" is only visible if WooCommerce is installed & active.
:::

Create a template of type "WooCommerce - Single product" in Bricks to design an individual layout for the single products page.

To create this template, go to the Bricks templates screen and add a new template. Then select the template type **"WooCommerce - Single Product"** from the top-right dropdown:

![](imgs/WooCommerce-Template-Type-Single-Product-992095ad21.png)

Click "Publish" or "Save Draft". Then "Edit with Bricks" to open the builder.

It is also possible to create/edit this and other templates in the Bricks editor interface by clicking on the Folders icon or pressing CMD / CTRL + SHIFT + L.

:::note
Please remember to add [template hooks](/integrations/woocommerce/woocommerce-template-hooks/#single-product-template-hooks) if you are using third-party plugins.
:::

## Single Product Elements {#elements}

When editing a "Single Product" template you'll find the "Products" elements at the very top of the elements panel:

![](imgs/woocommerc-single-product-elements-379x1024-e303f37457.png)

### Product title

The product title renders the title of the product.

### Product gallery

The product gallery element displays the product images defined in the product image and in the product gallery meta boxes.

*To disable the image zoom or lightbox, go to "Bricks > Settings > WooCommerce > Single Product".*

### Product short description

Renders the content of the Product short description editor.

### Product price

Renders the product price. If the product is on sale, you could hide the regular price.

### Product stock

Displays the number of products in stock. You can replace the number of products in stock with a custom message for "in", "low", or "out of stock".

### Product meta

Use the product meta element to display product data like the SKU, the product categories or tags, or any other WooCommerce metadata. Use [Dynamic Data](/builder/dynamic-content/dynamic-data/) to pull the values.

### Product rating

Shows the product's rating on a scale of 1 to 5 stars.

### Product content

Renders the product's main content as written in the WordPress editor.

### Add to cart

This element adds an "Add to cart" button to trigger the addition of this element to the cart. With this element, you may style the product variations inputs, the product stock, the quantity input, and the look & feel of the button itself.

### Related products

Shows a list of products that have the same product categories and tags of the main product displayed in the page.

### Product additional information

Renders the list of product attributes. This information will also be part of the product tabs element.

### Product tabs

Renders a section with the default tabs: Description, Additional Information, and Reviews. Other tabs might be added by third-party plugins.

### Product up/cross-sells

The product up/cross-sells element renders the list of products defined in the linked product section. You could use this element to list the upsell & cross-sell products (by default, it lists the upsells products).



![](imgs/woocommerce-product-upsells-0893b74c49.png)

<figcaption>

WooCommerce product editor screen - Linked Products

</figcaption>

---


## WooCommerce Account Builder

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/woocommerce-account-builder/*

Bricks 1.9 introduces the My Account builder, which lets you customize the account area of your WooCommerce site.

This includes the My Account page (logged-in), the account login/register/lost & reset password pages (shown when not logged-in), and all My Account endpoints (e.g., Orders, Downloads, etc.).

:::note
**IMPORTANT:** In order to ensure that all your customizations to the WooCommerce My Account templates are properly applied, it is imperative that you complete the "[My Account Page (logged in)](#my-account-page)" step.
:::

## My Account Page (logged in) {#my-account-page}

To design your My Account page (navigation + content wrapper), **please edit your "My Account" page directly**. You'll find a dedicated "Account Page" element that you can add and adjust its settings to your liking.



![](imgs/bricks-woocommerce-my-account-page-1-24ad9d8476.png)

<figcaption>

Custom My Account page using the "Account - Page" element

</figcaption>



:::note
**IMPORTANT:** If you have the *"Enable Bricks WooCommerce "Notice" element"* Bricks setting enabled, please make sure that you have added the "Notice" element to your account page or to all account templates individually. So the notifications when submitting the account forms (e.g., address, reset password, etc.) are displayed.
:::

## Account - Login / Register {#my-account-login-register}

The login form is displayed when a not-logged-in visitor views the My Account page. And the registration form, if you have the *"Allow customers to create an account on the "My account" page"* WooCommerce setting enabled.

You can design your account login/registration layout by creating a new template type "WooCommerce - Account - Login".

When editing this template, you'll find dedicated elements for the **"Account - Login form"** & **"Account - Register form"** as shown in the screenshot below:

You should also check the **Account creation** settings located at *WooCommerce > Settings > Accounts & Privacy* section to control what form to be displayed via **Account - Register form** element.

![](imgs/woocommerce-account-creation-settings-a3c9ee4cab.png)



![](imgs/bricks-woocommerce-account-login-register-158493f74a.png)

<figcaption>

Custom account login/register template

</figcaption>



:::note
**IMPORTANT:** Ensure you have inserted a Basic Text element with `{do_action:woocommerce_before_customer_login_form}` before your Login and Register form. And another Basic Text element with `{do_action:woocommerce_after_customer_login_form}` after the forms.
:::



![](imgs/woocommerce-do-action-account-login-db5e432226.png)

<figcaption>

Example do_action location. Before and after the login/register forms.

</figcaption>



## Account - Lost / reset password {#my-account-lost-reset-password}

The WooCommerce account builder in Bricks also provides the following dedicated templates and elements for the lost & reset password pages:

| **Account page** | **Template type** | **Elements** |
| --- | --- | --- |
| Lost password | WooCommerce - Account - Lost password | Account - Lost password |
| Lost password confirmation | WooCommerce - Account - Lost password (Confirmation | Displayed after submitting the lost password form. No special elements.

Example:
*A password reset email has been sent to the email address on file for your account, but may take several minutes to show up in your inbox. Please wait at least 10 minutes before attempting another reset.* |
| Reset password | WooCommerce - Account - Reset password | Account - Reset password |

## Templates for specific account endpoints {#my-account-endpoints}

Designing the account content area for individual account endpoints (Orders, Downloads, etc.) is possible by creating templates of the corresponding template type.

In the example below, we created a "WooCommerce - Account - Orders" template, to which we then added the "Account - Orders" that we styled a bit.

![](imgs/bricks-woocommerce-account-orders-1024x384-afc60cd021.png)

:::note
When editing the template for an account endpoint (Orders, Downloads, etc.), the drag & drop area is located inside the account content area. Offering a better preview in the builder than just rendering an empty canvas without the account navigation.
:::

The process of creating those account endpoint templates is the same for all other WooCommerce account template types.

## Account template types & elements

| **Template type** | **Endpoint** | **Element** |
| --- | --- | --- |
| WooCommerce - Account - Dashboard | `/` | - |
| WooCommerce - Account - Orders | `orders/` | Account - Orders |
| WooCommerce - Account - View order | `orders/view-order/{order_id}/` | Account - View order |
| WooCommerce - Account - Downloads | `downloads`/ | Account - Downloads |
| WooCommerce - Account - Addresses | `edit-address/` | Account - Addresses |
| WooCommerce - Account - Edit address | `edit-address/billing/`
`edit-address/shipping/` | Account - Edit address |
| WooCommerce - Account - Edit account | `edit-account/` | Account - Edit account |

---


## WooCommerce Builder

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/woocommerce-builder/*

WooCommerce is a free plugin to manage the e-commerce functionality of your WordPress site. It is the world's most popular open-source solution to create and manage a shop on the Internet, and therefore Bricks proudly integrates with it.

Bricks introduces the new in-theme WooCommerce Builder, which allows you to build your entire store with it. Including the main shop page, single product page, products archives, cart, checkout, and account pages.

To design these layouts, Bricks offers WooCommerce-specific elements and template types.

Certain elements only show when editing a specific template type.

The `Checkout customer details` element, for example, is only available when editing the `WooCommerce Checkout` template.

## Getting Started {#start}

To access the WooCommerce Builder in Bricks, install and activate the free WooCommerce plugin available in the official [WordPress repository](https://wordpress.org/plugins/woocommerce/) or through your WordPress dashboard under `Plugins → Add New`.

After activation, you might want to set up the store using the in-site configuration wizard or do it manually through the WooCommerce settings menus.

Please note that during the configuration wizard, you won't need to pick up a new theme because Bricks is already a theme and fully supports WooCommerce.

With the configuration done and after adding some products, you can start visually building your WooCommerce layouts with Bricks.

## WooCommerce Templates {#templates}

With WooCommerce activated, you can visually create and style the following WooCommerce templates in Bricks:

| **Template Type** | **Description** |
| --- | --- |
| **Single product** | Individual product page. |
| **Product archive** | Archive pages like product categories, tags, attributes, etc. Set visibility via Template Conditions. |
| **Cart** | The cart (when it contains products). |
| **Empty cart** | The empty cart (when it doesn't contain any products). |
| **Checkout** | Checkout screen where the customer enters billing & shipping details and selects the payment method. |
| **Pay** | Checkout screen where the customer enters the payment details. |
| **Thank you** | Displayed after successful checkout completion. |
| **Order receipt** | Displayed when viewing the order receipt. |
| **Account login** | Displayed when viewing the My Account page not logged in. |
| **Account lost password** | Displayed when viewing the lost password My Account page. |
| **Account lost password (confirmation)** | Displayed after submitting the lost password form. |
| **Account reset password** | Displayed after clicking the link in the password reset email. |
| **Account dashboard** | Displayed when viewing the My account page logged in. |
| **Account orders** | Displayed when viewing the "Orders" tab of the My Account page. |
| **Account view order** | Displayed when viewing an individual order. |
| **Account downloads** | Displayed when viewing the "Downloads" tab of the My Account page. |
| **Account addresses** | Displayed when viewing the "Addresses" tab of the My Account page. |
| **Account edit address** | Displayed when editing the billing or shipping address on the My Account page. |
| **Account edit account** | Displayed when editing the account details on the My Account page. |

## My Account builder

Starting at Bricks 1.9, you can also visually design your Account page. Including the login/registration, lost & reset password pages.

For more details, please refer to our dedicated Academy article about the new WooCommerce Account builder here [/integrations/woocommerce/woocommerce-account-builder/](/integrations/woocommerce/woocommerce-account-builder/)

## Shop page {#shop-page}

The shop page is a special WooCommerce page which is defined as the archive page for your products.

To design a unique Shop page layout, you can directly edit the Shop page with Bricks.

Or you could add a template condition in your `WooCommerce - Product Archive` template so this template is used for the Shop page as well. Since shop page is the archive for the product post type, just set it like this.

![](imgs/shop-page-woocommerce-product-archive-condition-a1e707d359.png)

## WooCommerce elements {#elements}

Bricks aims to provide the most flexible approach to the visual design of the WooCommerce templates without losing the functionality & hooks WooCommerce already provides that many third-party WooCommerce plugins/extensions rely upon.

Among the general WooCommerce elements and Products element, Bricks has special elements for specific WooCommerce template types like the cart or the checkout.

More than 30 WooCommerce-specific elements in total are available to design your WooCommerce templates & pages with Bricks.

![](imgs/bricks-woocommerce-elements-b887c7a76c.gif)

These are some of the WooCommerce-specific elements:

- Add to cart
- Product title
- Product gallery
- Product price
- Product stock
- Product meta
- Product rating
- Product reviews
- Product content
- Product short description
- Product additional information
- Product tabs
- Product up/cross-sells
- Related products

## Dynamic Data {#dynamic-data}

The WooCommerce integration adds new [dynamic data tags](/builder/dynamic-content/dynamic-data/#:~:text=Bricks%201.4%20introduces,support%20double%20quotes) to target product and [order properties](/integrations/woocommerce/checkout/#order-receipt-template).

`{woo_product_price}` - Returns the full product price with currency and HTML

`{woo_product_regular_price}` - Returns the product regular price with currency and HTML

`{woo_product_sale_price}` - Returns the product sale price with currency and HTML. If no sale price set, empty string will be returned.

`{woo_product_regular_price:plain}` - Returns product regular price with currency without HTML

`{woo_product_regular_price:value}` - Returns product regular price as simple string (e.g: 65.3, 2.5, 5)

`{woo_product_cat_image}` - Renders the product category image

`{woo_product_images}` - Renders the product featured image and product gallery images. Can use on Carousel and Image gallery element. You can also use `:value` filter to output the gallery images IDs in comma separated format. (@since 1.11)

`{woo_product_gallery_images}` - Renders the product gallery images (excluded the product featured image). Can use on Carousel and Image gallery element. You can also use `:value` filter to output the gallery images IDs in comma separated format. (@since 1.11)

`{woo_add_to_cart}` - Renders the add to cart button

`{woo_product_on_sale}` - Renders the on-sale badge if the product is on sale

`{woo_product_rating}` - Renders the product rating

`{woo_product_rating:plain}` - Outputs the product rating in text form. Ex: Rated 5.00 out of 5

`{woo_product_rating:format}` - Outputs the product rating even if no rating has been submitted yet

`{woo_product_sku}` - Returns the the product SKU

`{woo_product_excerpt}` - Renders the product short description

`{woo_product_stock}` - Renders the product stock (append `value` filter outputs number of products in stock)

`{woo_product_stock_status}` - Outputs `instock`, `outofstock`, or `onbackorder` (Useful for element conditions)

`{woo_product_badge_new}` - Renders "New" span with classes `.badge.new` if condition met. (@since 1.11.1) (Bricks Settings > WooCommerce > Products.)

`{woo_product_badge_new:plain}` - Renders "New" text only if condition met. (@since 1.11.1) (Bricks Settings > WooCommerce > Products.)

You can use the basic dynamic tags as well.

`{post_id}` - Outputs the product ID

`{post_title:link}` - Renders the product title with link

`{post_terms_product_cat}` - Renders the product categories with links

`{post_terms_product_cat:plain}` - Renders the product categories without links)

## Bricks Settings: WooCommerce

You'll find a dedicated tab for the WooCommerce integration in your WordPress dashboard under "Bricks > Settings > WooCommerce".

![](imgs/woo-settings-1.11-d511549739.png)

- **Disable WooCommerce Builder** - This toggle disables the Bricks' WooCommerce integration.
- **Product Badge "Sale"** - Choose between not showing the on-sale badge, showing the "Sale" badge, or the discount percentage.
- **Product Badge "New"** - Show a "New" badge if the product was published in less than the .. days configured.
- **Disable Product Gallery Zoom/Lightbox** - Disable the product gallery zoom or lightbox scripts.

![](imgs/ajax-add-to-cart-error-action-setting-b63e365f28.png)

- **AJAX add to cart Error action** - Select either "Redirect to product page" or "Show notice" when an error occurs during the AJAX add to cart process. (@since 1.11)

## Theme Styles {#theme-styles}

When WooCommerce is active, you'll find the following control groups in the Theme Styles panel:

- WooCommerce - Button
- WooCommerce - Notice



## WooCommerce Products Query Loop {#query}

![](imgs/new-woocommerce-product-queries-72b570952b.png)

You can use these checkboxes under WooCommerce section to easily retrieve WooCommerce products. Please select the "Products" post type; otherwise, the WooCommerce section will be hidden. (`@since 1.10`)

Check [this article](/builder/dynamic-content/query-loop/#woocommerce) for more examples.

---


## WooCommerce Notices

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/woocommerce-notices/*

New theme style settings under "WooCommerce - Notice" and a new "WooCommerce Notice" element were introduced in Bricks `1.8.1`. Allowing you to elevate the appearance of WooCommerce (WC) notices across your website.

With this new theme style, you can effortlessly customize the design of WC notices, ensuring they blend seamlessly with your website's overall look and feel.

In this article, we will explore the functionalities and benefits of this feature and guide you through the process of implementing it effectively.

## Theme Style: WooCommerce - Notice {#woocommerce-notice-theme-style}

You can find the "WooCommerce - Notice" settings in the builder under Settings > [Theme Styles](/builder/styling/theme-styles/).

There are three different types of notice: Error, Success, and default Notice.

![](imgs/wc-notice-theme-style-81729a317e.png)

With the WC notice theme style, you can effortlessly align your notice styles with your brand guidelines, and achieve a uniform and professional appearance for your notices.

## Element: WooCommerce Notice {#woocommerce-notice-element}

One of the primary objectives of this new feature is to offer you greater control over the placement of WC notices within their website's design.

Native WC notices often pose challenges, as they may appear outside of the desired design or wrapper, impacting the aesthetics and user experience.

To start using the Bricks WooCommerce notice element you first have to enable it under `Bricks > Settings > WooCommerce > Enable Bricks WooCommerce Notice Element`.

![](imgs/bricks-wc-notice-element-9c8aff50e4.png)

:::note
Once enabled all native WC notices are automatically removed from your website. So you can & have to manually place the notice element in your desired template & location.
:::



![](imgs/bricks-wc-notice-preview-d54d315328.png)

<figcaption>

WC notice element. Not only theme style but can also style individual elements as well.

</figcaption>



**The following Bricks templates should be equipped with the Notice element:**

- WooCommerce Product Archive
- WooCommerce Single Product
- WooCommerce Cart
- WooCommerce Empty Cart
- WooCommerce Checkout
- WooCommerce My account login
- WooCommerce My account lost password
- WooCommerce My account reset password

In addition to the Bricks templates mentioned above, several pages within your WooCommerce website require the Notice element **if they are edited and rendered using Bricks**. These pages include:

- My Account page (if the WC notice is not placed in the My account login template)
- Checkout page (if the WC notice is not placed in the Checkout template)
- Cart page (if the WC notice element is not placed in the Cart template)
- Shop page (if the WC notice element is not placed in the Product Archive template)

**Only one Notice element is needed per page.**

If you happen to add multiple WC notice elements, only the first one will output the actual notices, following the native WooCommerce behavior. WooCommerce clears notices after the 1st output. Check WooCommerce `wc_print_notices()` for more information.

---


## WooCommerce Template Hooks

*來源網址：https://academy-preview.bricksbuilder.io/integrations/woocommerce/woocommerce-template-hooks/*

Bricks 1.7 introduces a new [`do_action`](/builder/dynamic-content/dynamic-data/#do_action) dynamic tag, which is designed to address the majority of compatibility issues between Bricks and third-party WooCommerce plugins. This new dynamic tag not only solves these compatibility issues but also enhances the flexibility of design by allowing users to place hooks anywhere they desire.

This article will guide you through the templates that need to be updated with the new `do_action` dynamic tag, though this step is optional if your Bricks-built WooCommerce website is already functioning properly.



Please note that when using the `do_action` dynamic tag with the specified hooks, Bricks will automatically remove certain native WooCommerce actions to prevent duplicate content.



As an example, consider using `{do_action:woocommerce_after_shop_loop_item_title}` dynamic tag in Bricks. This tag will automatically remove the `woocommerce_template_loop_rating` and `woocommerce_template_loop_price` actions. The reason for this is because the Product price and Product rating elements will be used to output the information in the desired location. At the same time, other plugins or codes will still be able to successfully hook onto the dynamic tag.



#### WooCommerce actions list removed by Bricks when using the do_action tag {#woo-special-actions-list}

| Hook | Actions removed by Bricks, Priority |
| --- | --- |
| woocommerce_before_shop_loop_item | woocommerce_template_loop_product_link_open, 10 |
| woocommerce_before_shop_loop_item_title | woocommerce_show_product_loop_sale_flash, 10
woocommerce_template_loop_product_thumbnail, 10 |
| woocommerce_shop_loop_item_title | woocommerce_template_loop_product_title,10 |
| woocommerce_after_shop_loop_item_title | woocommerce_template_loop_rating, 5
woocommerce_template_loop_price, 10 |
| woocommerce_after_shop_loop_item | woocommerce_template_loop_product_link_close, 5
woocommerce_template_loop_add_to_cart, 10 |
| woocommerce_before_single_product_summary | woocommerce_show_product_sale_flash, 10
woocommerce_show_product_images, 20 |
| woocommerce_single_product_summary | woocommerce_template_single_title, 5
woocommerce_template_single_rating, 10
woocommerce_template_single_price, 10
woocommerce_template_single_excerpt, 20
woocommerce_template_single_add_to_cart, 30
woocommerce_template_single_meta, 40
woocommerce_template_single_sharing, 50 |
| woocommerce_after_single_product_summary | woocommerce_output_product_data_tabs, 10
woocommerce_upsell_display, 15
woocommerce_output_related_products, 20 |
| woocommerce_before_main_content | woocommerce_output_content_wrapper,10
woocommerce_breadcrumb, 20 |
| woocommerce_archive_description | woocommerce_taxonomy_archive_description, 10
woocommerce_product_archive_description, 10 |
| woocommerce_before_shop_loop | woocommerce_result_count, 20
woocommerce_catalog_ordering, 30 |
| woocommerce_after_shop_loop | woocommerce_pagination, 10 |
| woocommerce_after_main_content | woocommerce_output_content_wrapper_end, 10 |
| woocommerce_cart_is_empty | wc_empty_cart_message, 10 |



:::note
Simply use a Basic Text element when applying the `{do_action:xxx}` dynamic tag within your template.
:::



## WooCommerce Single Product Template Hooks {#single-product-template-hooks}

For the WooCommerce Single Product template, the following hooks are recommended to be used with the `do_action` dynamic tag:

- `{do_action:woocommerce_before_single_product}` - Important (WooCommerce notice)
- `{do_action:woocommerce_before_single_product_summary}`
- `{do_action:woocommerce_single_product_summary}` - Important (Many third-party plugins using this hook to inject their code)
- `{do_action:woocommerce_after_single_product_summary}`
- `{do_action:woocommerce_after_single_product}`

Best to place all of these in your single product template if you are not sure which hook will be using by the third-party plugins.



![](imgs/bricks-standard-woocommerce-single-product-template-hooks-d63ef55cc9.png)

<figcaption>

Single product template hooks location

</figcaption>



## WooCommerce Product Archive Template Hooks {#product-archive-template-hooks}

For the WooCommerce Product Archive template, the following hooks are recommended to be used with the `do_action` dynamic tag:

- `{do_action:woocommerce_archive_description}`
- `{do_action:woocommerce_before_shop_loop}` - Important (WooCommerce notice)
- `{do_action:woocommerce_before_shop_loop_item}`
- `{do_action:woocommerce_before_shop_loop_item_title}`
- `{do_action:woocommerce_shop_loop_item_title}`
- `{do_action:woocommerce_after_shop_loop_item_title}`
- `{do_action:woocommerce_after_shop_loop_item}`
- `{do_action:woocommerce_after_shop_loop}`



![](imgs/bricks-standard-woocommerce-product-archive-template-hooks-0224c0d9e2.png)

<figcaption>

Product archive template hooks location (Custom Query Loop)

</figcaption>



In Bricks 1.7, the dynamic tag `do_action` hooks will be automatically included in the fields of the Products element (for newly inserted Products elements only).



![](imgs/Products-element-with-do_action-included-since-1_6_3-680f992a58.png)

<figcaption>

Default Products element with do_action hooks (Bricks 1.7+)

</figcaption>



## WooCommerce Empty Cart Template Hooks {#empty-cart-template-hooks}

For the WooCommerce Empty Cart template, the following hook is recommended to be used with the `do_action` dynamic tag:

- `{do_action:woocommerce_cart_is_empty}` - Important (WooCommerce notice)



![](imgs/bricks-standard-woocommerce-empty-cart-template-hooks-a04efc4fc9.png)

<figcaption>

Empty cart template hook location

</figcaption>



## WooCommerce Cart Template Hooks {#cart-template-hooks}

For the WooCommerce Cart template, the following hooks are recommended to be used with the `do_action` dynamic tag:

- `{do_action:woocommerce_before_cart}` - Important (WooCommerce notice)
- `{do_action:woocommerce_before_cart_collaterals}`
- `{do_action:woocommerce_after_cart}`



![](imgs/bricks-standard-woocommerce-cart-template-hooks-34955c9d90.png)

<figcaption>

Cart template hooks location

</figcaption>



## WooCommerce Pay Template {#pay-template-hooks}

For the WooCommerce Pay template, the following hooks are recommended to be used with the `do_action` dynamic tag:

- `{do_action:woocommerce_pay_order_before_payment}`



![](imgs/woo-pay-template-830e9211f3.png)

<figcaption>

Pay template hooks location

</figcaption>



By following this guide, you can ensure that the templates created in Bricks are fully compatible with WooCommerce and that all necessary actions and details are displayed as intended.

---
