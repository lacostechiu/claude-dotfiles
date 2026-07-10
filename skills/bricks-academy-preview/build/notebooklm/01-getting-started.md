# Bricks Academy — Getting Started 入門指南

> 來源：Bricks Builder Academy 官方文件 | 共 13 篇

---



## Welcome

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/*

Welcome to Bricks! If you're here, you're probably looking for a better way to build WordPress sites, one that gives you full control without forcing you to write code for every little thing.

## What is Bricks?

Bricks is a visual site builder for WordPress that gives you complete design freedom without compromising on code quality.

Unlike traditional page builders that generate bloated code, Bricks outputs clean HTML and CSS. You design visually, Bricks writes efficient code. No wrapper divs, no inline styles, no mystery markup.

**What makes Bricks different:**

- **Full design control** - Every element, every style, every layout option is customizable
- **Clean code output** - Fast-loading sites with lean, semantic HTML and efficient CSS
- **Built for growth** - Start simple, access deeper capabilities as your skills develop
- **True visual editing** - What you see in the builder is what you get on the front end

## Who is Bricks for?

Bricks meets you where you are:

- **Starting out?** You can build beautiful, functional sites without knowing any code
- **Growing your skills?** Bricks reveals how web standards work as you build, helping you level up naturally
- **Already technical?** You'll appreciate the direct control, the clean output, and the ability to extend everything with your own code when needed

You don't need to be a developer. But if you're on that path, Bricks grows with you instead of getting in your way.

## What you'll learn in this series

In this getting started series, we'll build a simple site together: a homepage with a latest posts section, a header template, and a blog post template.

Along the way, you'll learn how to:

- Install and configure Bricks
- Navigate the builder interface
- Build pages and templates
- Apply consistent styling with theme styles and global classes
- Create responsive layouts
- Connect designs to WordPress content with dynamic data
- Display repeating content with query loops

These fundamentals prepare you for more advanced features you can explore as your projects demand them.

---


## Blog post template

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/blog-post-template/*

## Before you begin: sample posts

You need **at least one published blog post** to preview this template (more is better). If you already created **3 test posts with featured images** for [Query loops and dynamic data](/getting-started/query-loops-dynamic-data/), you are set.

Otherwise:

1. Go to **Posts > Add New**
2. Add a title, body content in the block editor, and a **featured image**
3. Click **Publish**

Your homepage shows a grid of posts. When you click one, you see the default WordPress template (pretty basic). Let's create a proper blog post template.

## What is a single template?

Remember in the intro to templates article when we talked about different template types? **Single** templates control the layout of individual blog posts or pages.

For blog posts, we separate design from content:
- **Design** (layout, styles) = Bricks template
- **Content** (post text, images) = WordPress block editor

This way, if you need a new design later, you just change the template without recopying all your content.

## Create the template

1. Go to **Bricks > Templates** in WordPress dashboard
2. Click **Add New**
3. Title it: "Blog Post"
4. Click **Edit with Bricks**


### Set template type and conditions

Before building, let's configure where this applies:

1. Click **Settings** (gear icon) in toolbar
2. Go to **Template Settings**
3. Set **Template Type** to `Single`
4. Under **Template Conditions**, click **Add Condition**
5. Select **Post type: Posts**


This template now applies to all blog posts.

### Test it's working

Save the template, then open one of your test blog posts on the front end. You'll see a blank page. Perfect! That means our template is applied, but since we haven't added any elements yet, it's empty.

## Build the template with a wireframe

Instead of building from scratch (which you certainly can do), let's use a wireframe template. This is also a great way to learn.

1. Click **Templates** (folder icon) in toolbar
2. Set **Source** to **Wireframes**
3. Filter by **Template Type**: select `Single`
4. Find "Article 01" (or similar)
5. Click **Insert**


When prompted to import global classes, theme styles, and color palette, click "Yes" to all.

:::note[What you are importing]
Saying **yes** here can add **reusable design assets** to your site, not just layout: **global classes**, **theme styles**, and **color palette** entries. That is normal for wireframes, but it means your site may gain styles and colors you did not build by hand yet. If you prefer to keep the site minimal, build the template yourself instead of inserting the wireframe, or skip importing these assets and style the template manually later.
:::

These assets are what make the wireframe look polished out of the box. We'll explain global classes and theme styles in upcoming articles.

:::warning[Post Content is required for the post body]
If the template does not include a **Post Content** element, the text you write in the WordPress editor will **not** appear on the front end. After you insert the wireframe, confirm a **Post Content** element exists in the structure (see [The Post Content element](#the-post-content-element) below).
:::

The wireframe inserts with a complete blog post layout!


## Examine the template

One of the best ways to learn is by looking at how someone else built something. With wireframe templates, feel free to move things around, break it, try to put it back together. If you're having trouble, just delete and re-insert!

Let's examine what we have.

### Look at the Structure Panel


You'll see sections with various elements: headings, text, images, and more.

### Notice the curly braces

See text like `{post_title}`, `{featured_image}`, `{post_date}`?

These are **dynamic data tags** - the same ones we used in the query loop!

But now they're in a different **context**.

## Understanding context

Context matters in dynamic data.

**In the query loop** (homepage): As you loop through posts, the context changes for each card. First card = post #1, second card = post #2, etc.

**In the single template**: The context is the post you're currently viewing. `{post_title}` shows the title of whatever post the visitor is on.

This is what makes templates + dynamic data so powerful. One template, infinite posts, each showing its own content.

### Key elements in the template

Look for these important elements:

**Heading with `{post_title}`** - Displays the post's title

**Image element with featured image** - Shows the post's featured image (using `{featured_image}` dynamic data)

**Post Content element** - This special element displays the actual post content you write in the WordPress block editor

**Meta data** - Author, date, categories (using tags like `{author_name}`, `{post_date}`, `{post_terms_category}`)


## The Post Content element

This element is special. It renders whatever you write in the WordPress block editor (the default WordPress editor when you create a post).

**Why keep content in WordPress editor?**

- **Content portability** - If you switch themes, content stays intact
- **Client-friendly** - Non-technical users already know this editor
- **Plugin compatibility** - SEO plugins, table of contents, etc. expect content there
- **Separation of concerns** - Design in Bricks, content in WordPress

Bricks handles the layout. WordPress handles the written content. Keep them separate: you still create and edit your posts in the normal WordPress editor, Bricks just controls how that content is presented.

## View on the front end

Open one of your test posts on the front end. Your template is now applied, and dynamic data shows that post's specific content!


Click another post. Same template, different content. Magic!

## Customize your template

Want to make changes?

1. Go to **Bricks > Templates**
2. Find "Blog Post"
3. Click **Edit with Bricks**
4. Modify colors, spacing, fonts
5. Save

All posts update automatically. One template, all posts. Change once, update everywhere.

:::tip[Try it]
Edit your blog post template. Change heading colors, adjust spacing, or rearrange elements. Save and view different posts on the front end. They all use your updated design. Add a new test post in WordPress — it automatically uses your template. This is the efficiency of templates!
:::

## What you've learned

You can now:
- Create single post templates
- Set template types and conditions
- Use wireframe templates to learn and speed up building
- Understand dynamic data context
- Use the Post Content element
- Separate design (Bricks) from content (WordPress)
- Customize templates that apply to all posts

---


## Start your first page

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/building-your-first-page/*

Time to build. We will start your homepage by creating the hero section. This is where you'll learn the core workflow and understand how layout elements work. We will add more sections (like a latest posts grid) later in the series.

## Open your Home page

In the previous article you already created a **Home** page and opened it in the builder.

If the builder is not open anymore:

1. In your WordPress dashboard, go to **Pages > All Pages**
2. Find the page titled **Home**
3. Hover it and click **Edit with Bricks**

The builder opens with your Home page ready to work on. If you do not have a Home page yet, quickly create one now and open it with Bricks.

## Set this page as your homepage

Before we build, tell WordPress to use **Home** as the static front page:

1. In the WordPress dashboard, go to **Settings > Reading**
2. Under **Your homepage displays**, select **A static page**
3. Set **Homepage** to your **Home** page
4. Optionally set **Posts page** to a page named **Blog** (or leave default for now)
5. Click **Save Changes**

## How most web pages are structured

Before we touch anything, notice how most websites are laid out when you scroll:

- A **header** at the very top (logo and navigation, usually global)
- A **hero** section that introduces the page
- One or more **content sections** (features, testimonials, blog posts, contact)
- A **footer** at the bottom

Visually, the page is a vertical stack of horizontal bands. In Bricks, we build those bands with the **Section** element.

Under the hood, each section is just a semantic HTML box. Inside that box we place more boxes, and inside those we place content.

## Layout elements in Bricks

To build those bands and columns, Bricks gives you four layout elements. You will use them to hold all other elements.

**Section** → **Container** → **Block / Div** → **Elements**

- **Section**: The root band. Spans the full width of the screen. Used to separate major parts of your page (header, hero, features, footer).
- **Container**: Sits inside the section. Keeps your content centered and bounded (width 1100px by default).
- **Block**: A layout box that uses flexbox and takes up 100 percent width by default. Great for columns and cards inside a section or container.
- **Div**: A plain, unstyled `div` that grows with its content. Use it as a lightweight wrapper when you want full control.
- **Elements**: The actual content (headings, images, buttons) that live inside those layout boxes.

### When to use each layout element

You can think of these layout elements as different kinds of wrappers for your content.

- **Section**: Use when you want a new horizontal band on the page. A typical page is one section for hero, one for features, one for testimonials, one for contact, and so on.
- **Container**: Use when you want the content of a section to have a fixed maximum width and be centered. Most sections have exactly one container.
- **Block**: Use when you want to divide a container into columns or repeated boxes. For example, in a hero section, one Block for text and another for the image. In a features section, one Block per feature card.
- **Div**: Use when you just need a simple box inside other layout elements. For example, to group a heading and an icon, or to wrap part of a card without affecting the overall layout.

Where you apply styles matters:

- Background colors and borders on the **Section** affect the full width band.
- Styles on the **Container** affect the centered content area.
- Styles on a **Block** or **Div** affect just that column or card.

If you inspect your page in the browser later and hover over these elements in the dev tools, you will see colored overlays showing content, padding, and margin for each box. That is the box model in action.

These layout elements are just wrappers. Where you place them determines width, positioning, and which parts of your design share the same background or border.

We will keep coming back to them as you build more pages and templates.

## Build the hero section

For this first hero we will create a very common pattern:

- Text and button on the left  
- Image on the right  
- Both aligned nicely in the middle of the screen

### 1. Add a section

1. In the Settings Panel (left), click **Section** (under Layout)
2. A **Section** with a **Container** inside is automatically added to your canvas

![](imgs/add-section-element-c37b4a7eed.png)

### 2. Add your hero content

We will first add all the content, then turn it into two columns.

1. Select the **Container** from the structure panel or by clicking on the canvas

![](imgs/container-element-selected-32498eac7d.png)
2. Add a **Heading** element
3. Add a **Rich Text** element below the heading
4. Add a **Button** element below the text
5. Add an **Image** element below the button

Right now everything is in one column (stacked). We will group elements into columns next.

![](imgs/bulk-selected-elements-inside-container-a34adc4dbf.png)

### 3. Group content into columns with Blocks

Blocks are perfect for columns. Instead of adding them empty and dragging elements in, we will wrap existing elements in Blocks.

**Left column (text + button):**

1. Open the **Structure Panel** on the right
2. In the Container, click the **Heading**
3. Hold **Shift** and click the **Button**  
   → This selects the Heading, Rich Text, and Button together  
   (Optionally, hold `Cmd/Ctrl` and click items one by one to select them)
4. Right-click on the selection and choose **Wrap → Block**

Bricks wraps those three elements in a new Block. This Block will be your left column.

**Right column (image):**

1. In the Structure Panel, select the **Image**
2. Right-click it and choose **Wrap → Block**

You now have a Container with **two Blocks** inside: one for text/button, one for the image. Next we will tell Bricks to lay those Blocks out as columns.

![](imgs/hero-section-two-columns-structure-panel-8a526b8116.png)

### 4. Layout the columns

Now let's make them sit side-by-side using Flexbox.

1. Select the **Container**
2. Go to **Content > Layout**
3. Set **Direction** to `Row` (horizontal)
4. Set **Align cross axis** to `Center` (vertically centers content)
5. Set **Column gap** to `24` (adds space between first column and second column)
6. Set a background color from the "Styles" tab > "Background" 

![](imgs/hero-section-styles-c0578cf278.png)

### A quick note on flexbox

In CSS, the `display` property controls how elements are laid out. By default, many elements are `block` (stacked vertically) or `inline` (flow with text).

**Flexbox** is a layout mode that makes it easy to arrange children of a container in a row or a column. In Bricks, Section, Container, and Block all use flexbox by default.

When you set **Direction** to `Row`, you tell the container to line up its children horizontally. If you changed it to `Column`, they would stack vertically.

A simple way to think about the main controls:

- **Direction**: chooses the main axis (row = side by side, column = stacked).
- **Gap**: spaces out the children along that main axis (the white space between our text Block and Image).
- **Align items**: lines up the children along the cross axis (here: vertically) so both columns share the same vertical center.

Flexbox is perfect for one dimensional layouts like our two column hero. If you want to go deeper into flexbox itself, you can read the [Flexbox basics guide on MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox). We will stay focused on using it visually in Bricks.

### 5. Style the content

**Left column Block:**
1. Select the **Block**
2. Set **Row gap** to `8` (adds space between heading, text, and button)

**Heading:**
1. Change text to: "Welcome to Bricks"
2. Set **Tag** to `H1`

**Image:**
1. Select the Image element
2. Choose a photo from the media library

## See the HTML Bricks generates

You might have heard that Bricks outputs clean, semantic, non-bloated markup. Let's take a quick look at what that actually means.

1. Click **Preview** in the toolbar to open your Home page on the front end  
2. In your browser, right-click somewhere in your hero section and choose **Inspect** (or use the browser's developer tools shortcut)  
3. Look for the `<main>` element and expand it

You should see something very close to:

- A `<section>` for the hero
- A `<div>` (Container) inside it
- Inside that, your content boxes and elements (heading, text, button, image)

There are no mysterious extra wrapper divs, no huge chains of nested containers you did not create.

Even if you're not familiar with HTML yet, the important idea is:

- What you add in the builder is what you get in the markup  
- Bricks keeps the structure lean so you have full control over layout and performance

## The spacing problem

Your section looks good, but it's hugging the top and bottom of the screen. We need padding.

You *could* select the Section and add `80px` padding manually. But then you'd have to do that for every single section on your site. That's tedious and hard to maintain.

**The solution?** Theme Styles.

Instead of styling each section individually, we'll set a global rule: "All sections should have 80px padding."

Let's do that in the next article.

:::note[Help improve this lesson]
Bricks Academy is new. If a step in this lesson felt confusing, incomplete, or out of date, use the feedback box in the right sidebar and tell us what to improve.
:::

---


## Global classes

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/global-classes/*

Theme Styles handle element defaults beautifully. But what about reusable utility styles you want to apply on demand? Things like centering text, adding shadows, or creating button variations?

This article goes a bit deeper than some earlier ones. If you're in a hurry, you can skim now, get a feel for what global classes are, and come back later when your projects start to feel repetitive.

That's where global classes excel. They're your custom CSS class library, built visually in Bricks and reusable anywhere with a click.

## What are global classes?

A CSS class is a collection of styles you can apply to any element. Instead of styling each element individually, you create a class once and apply it wherever needed.

**Example**: You create a class called `.shadow-large` that adds a drop shadow. Now you can apply that shadow to buttons, images, cards, or any element instantly, without redefining the shadow styles each time.

Global classes are vital for building scalable, maintainable sites. They ensure consistency and speed up your workflow dramatically.

## Why global classes matter

Imagine you have 20 buttons across your site. Without classes, you'd style each button individually (20 times). If your client wants to change the button style, you'd update each one manually. That's tedious and error-prone.

With a global class:
1. You create `.btn-primary` once
2. You apply it to all 20 buttons
3. When styles need to change, you edit the class once
4. All 20 buttons update automatically

This is how professionals build sites that scale.

## The problem global classes solve

Let's demonstrate with a real example. Say you want two headings on different pages to have the same blue color and bold weight.

**Without classes:**
1. Style the first heading (color: blue, weight: 700)
2. Navigate to the second page
3. Style that heading the same way
4. Repeat for every similar heading

If you decide blue should be purple later, you hunt down every heading and change it manually.

**With global classes:**
1. Create a class `.heading-blue` (color: blue, weight: 700)
2. Apply it to both headings with one click
3. Later, edit `.heading-blue` to be purple
4. Every heading using that class updates instantly

This is the efficiency gain. You style once, apply everywhere.

## Creating your first global class

Let's create a utility class to demonstrate the workflow.

### Set up the example

1. Create a new page or open an existing one
2. Add two Heading elements on the page


Right now, if you want both headings to look identical, you'd style each one individually. Let's use a global class instead.

### Create the class

1. Select the first heading
2. Look at the panel on the left. At the top, you'll see the element name and an ID field below it (shows something like `#brxe-abc123`)
3. Click that ID field
4. In the input that appears, type: `heading-feature`
5. Press Enter or click the **Save** (floppy disk) icon


Notice the field now shows `.heading-feature` (with a dot, indicating it's a class, not an ID).

**You've just created a global class.** Now every style you apply to this heading gets added to the `.heading-feature` class, not just this specific element.

### Style the class

With the heading still selected and the class applied:

1. Under **Typography**, set **Font size** to `32`
2. Set **Font weight** to `700`
3. Set **Color** to a vibrant blue (`#0066ff`)
4. Under **Spacing**, add **Margin bottom** of `20`


These styles are now stored in the `.heading-feature` class.

### Apply the class to another element

Now let's apply this class to the second heading:

1. Select the second heading
2. Click the ID field at the top of the panel
3. Start typing `heading-feature`
4. You'll see it appear in the autocomplete dropdown
5. Select it or press Enter


The second heading instantly matches the first. Same font size, weight, color, and spacing. You didn't retype any settings. You just applied the class.

**Change the class, update everything:**

1. Select either heading (both use the class)
2. Change the color to purple (`#9333ea`)
3. Both headings update immediately

This is the power of global classes. Style once, apply everywhere, update globally.

## Understanding the difference: ID vs. class styles

By default, when you select an element and apply styles, they're added to that element's unique ID. Those styles only affect that one element.

When you create and apply a global class, styles go into the class instead. Now every element using that class inherits those styles.

**Important**: ID styles override class styles (CSS specificity). If you apply a class to an element but then add individual styles to that same element, the individual styles win.

**Best practice**: Use global classes for shared styles. Use element-specific (ID) styles only for unique, one-off adjustments.

## Building a utility class system

Now that you understand the concept, let's build some useful utility classes. These are small, single-purpose classes you can combine for maximum flexibility.

### Text alignment classes

Create these three classes:

**.text-center**
1. Create a Heading element
2. Add the class `text-center`
3. Under **Typography**, set **Text align** to `Center`
4. Delete the heading (we only needed it to create the class)

**.text-left**
- Same process, set **Text align** to `Left`

**.text-right**
- Same process, set **Text align** to `Right`

Now you can center any text element instantly by applying `.text-center`.

### Spacing utility classes

Create a set of margin classes for consistent spacing:

**.mb-sm** (margin bottom small)
- Set **Margin bottom** to `16`

**.mb-md** (margin bottom medium)
- Set **Margin bottom** to `32`

**.mb-lg** (margin bottom large)
- Set **Margin bottom** to `48`

Do the same for **margin top** (`.mt-sm`, `.mt-md`, `.mt-lg`) if you want.

These simple classes speed up spacing dramatically. Instead of typing margin values repeatedly, you apply a class.

### Button variation classes

Let's create button style variations:

**.btn-outline**
1. Add a Button element
2. Apply the class `btn-outline`
3. Under **Style**, remove the **Background color** (make it transparent)
4. Under **Border**, add a border: `2px` solid, color `#0066ff`
5. Set **Text color** to `#0066ff`
6. Add **Padding** of `12` top/bottom, `24` left/right
7. Set **Border radius** to `8`

**.btn-ghost**
1. Similar to outline, but with no border
2. Just text color and padding
3. Subtle hover effect (set `:hover` state to add background)


Now you can create button variations instantly by swapping classes.

## Managing global classes

As your class library grows, organization matters.

### View all classes

Press `Cmd/Ctrl + .` to open the **Style Manager** (or click the **Styles** icon in the toolbar). Navigate to the **Classes** tab.


![](imgs/style-manager-classes-ed7974a7d7.png)

Here you can:
- See all your global classes
- Edit, rename, or delete classes
- Search for specific classes
- See where classes are used
- Export/import classes

### Edit a class

In the Style Manager's **Classes** tab:
1. Find the class you want to edit
2. Click the **Edit** (pencil) icon
3. Modify styles in the panel
4. All elements using that class update immediately

### Delete unused classes

The manager shows which classes are used and where. If a class isn't used anywhere, you can safely delete it to keep your library clean.

## Real-world example: styling different elements the same way

Here's a common scenario that shows why global classes are essential.

### The problem

You're building a landing page. You want:
- Headings in the hero section
- Headings in the features section
- Headings in testimonials

All should be the same shade of blue with the same weight. That's three headings on one page, each needing identical styles.

**Without classes**: Style each heading individually (tedious, hard to maintain).

**With classes**: Create `.heading-accent`, apply it to all three headings. Done.

### The evolution

Later, the client asks: "Can we make those blue headings purple instead?"

**Without classes**: Hunt down all three headings, change each one individually, hope you didn't miss any.

**With classes**: Edit `.heading-accent`, change the color once. All three update. You're done in 10 seconds.

This example scales to hundreds of elements across dozens of pages. Global classes keep everything manageable.

## Combining classes

You can apply multiple classes to one element. This is powerful for composing styles.

**Example**: Apply both `.heading-feature` and `.text-center` to a heading. It gets the feature heading styles (color, weight, size) plus center alignment.

This modular approach gives you maximum flexibility with minimum duplication.

## Pseudo-selectors: hover states and more

Global classes support pseudo-selectors like `:hover`, `:focus`, `:active`, and more.

**Creating a hover effect:**

1. Create a class `.btn-primary`
2. Style the default state (background: blue, text: white)
3. Change **State** to `:hover`
4. Darken the background color
5. Add a subtle scale transform (under **Transform** in advanced controls)


Now every button with `.btn-primary` has that hover effect. You defined it once.

## Quick mention: advanced features for scaling

As you grow with Bricks, you'll discover features that complement global classes:

**[Variables](/builder/styling/global-variables-manager/)** - Also inside the Style Manager, the **Variables** tab lets you define CSS variables (colors, spacing scales, font sizes) that you can reference in your classes. Change a variable, update every class using it.

**[Components](/builder/features/components/)** - Turn entire layouts (not just styles) into reusable, synchronized blocks. Think of them as global classes for structure + content + styles.

These advanced features build on the same principle: define once, reuse everywhere, update globally. Master global classes first, then explore these when your projects demand more.

:::tip[Try it]
Create a global class called `.shadow-soft` that adds a subtle box shadow (`0 4px 16px rgba(0,0,0,0.1)`). Apply it to several different elements (images, cards, containers). Notice how one class adds consistent shadows everywhere. Then edit the class to make the shadow stronger. Watch all elements update together. This is the workflow that makes large projects manageable.
:::

## What you've learned

You can now:
- Create global classes and understand why they matter
- Apply classes to multiple elements for consistency
- Build utility classes for text alignment, spacing, and button styles
- Manage classes inside the Style Manager
- Use pseudo-selectors like `:hover` in classes
- Combine multiple classes on one element
- Understand the difference between ID-specific and class-based styling

Global classes are how you build sites that scale. They transform your workflow from repetitive styling to efficient system-building.

---


## Building a header template

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/header-template/*

Let's build a global header with a logo and menu.

## Create the template

1. Go to **Bricks > Templates**
2. Add New: "Header"
3. Edit with Bricks

## Settings

1. **Settings (gear) > Template Settings**
2. **Type**: Header
3. **Conditions**: Entire Website

## Build the structure

1. Add a **Section**
2. Inside the **Container**:
   - Add a **Logo** element (or Image/Text)
   - Add a **Nav Menu** element (we'll use the standard WordPress menu)

## Style the layout

**Container:**
1. **Direction**: `Row` (horizontal)
2. **Justify content**: `Space between` (pushes logo and menu apart)
3. **Align items**: `Center` (vertically aligned)

**Section:**
1. **Background color**: Pick a light gray or your brand color
2. **Padding**: `12` top/bottom (this intentionally overrides our global 80px for this specific section)

Your header is part of the site chrome, not page content. It usually needs tighter spacing than regular sections, so it is a good place to make a deliberate exception to your global section padding.

## Create a WordPress menu (if you do not have one yet)

The Nav Menu element uses a normal WordPress menu. If **Appearance > Menus** is empty or you have never built a menu:

1. From the WordPress dashboard, go to **Appearance > Menus**
2. Enter a **Menu name** (for example `Main`) and click **Create Menu**
3. Add a few items from the left (**Pages**, **Custom links**, and so on), then click **Save Menu**

Then return to this template in the builder.

## Configure the menu

1. Select the **Nav Menu** element
2. Under **Menu**, choose the WordPress menu you created (for example **Main**)

## Save and verify

1. Save the template
2. Go to your **Pages** panel (top bar) -> **Home**
3. You should see your new header sitting perfectly atop your hero section!

![](imgs/header-template-8d5d7b145b.png)

---


## Installation and setup

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/installation-setup/*

Let's get Bricks installed on your WordPress site.

Before you install, confirm your host meets [Bricks requirements](/builder/setup/requirements/) (PHP, database, memory, upload size, and a modern browser). Most hosting does; use that article if you need to raise limits or troubleshoot.

## Install the Bricks theme

Installing Bricks works exactly like any other WordPress theme. Use one place for everything account-related: [my.bricksbuilder.io](https://my.bricksbuilder.io/) (download the theme ZIP and find your license key there).

### Download Bricks

Log into [my.bricksbuilder.io](https://my.bricksbuilder.io/) and download the latest version as a ZIP file.

![](imgs/download-bricks-564287efe3.png)

### Upload to WordPress

:::note[Theme, not plugin]
Install Bricks as a **theme** (**Appearance > Themes > Upload**), not under **Plugins**. Uploading the ZIP as a plugin will not work.
:::

1. In your WordPress dashboard, go to **Appearance > Themes**
2. Click **Add New**
![](imgs/wordpress-add-theme-222214e407.png)
3. Click **Upload Theme**
![](imgs/wordpress-upload-theme-6e4847f818.png)
4. Select the `bricks.zip` file from your computer
5. Click **Install Now**
6. After the upload completes, click **Activate** (or go to **Appearance > Themes** and activate **Bricks**)

**If the upload fails**, it is usually because your WordPress site does not allow large enough uploads. See [Requirements](/builder/setup/requirements/) (max file upload size) or, as a last resort, unzip the file on your computer and upload the `bricks` folder via FTP to `/wp-content/themes/`.

## Activate your license

Once Bricks is installed, you'll see a new **Bricks** menu item in your WordPress dashboard, along with a notification prompting you to activate your license.

Click **Bricks > License** (or the notification link). This opens the license activation screen.
![](imgs/bricks-license-tab-3af973d724.png)

### Steps to activate

1. Copy your license key from [my.bricksbuilder.io](https://my.bricksbuilder.io/)
2. Paste it into the license field
3. Click **Activate License**

You should see a confirmation that your license is **active**.

That's it, Bricks is ready to use!

For license limits, staging URLs, managing activations, automatic updates, and updating safely, see [License, updates, and your account](/builder/license/license-and-updates/).

## What you've accomplished

You now have Bricks installed and licensed.

---


## Interface tour

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/interface-tour/*

Before you start building, let's get oriented. This quick tour shows you where everything is in the Bricks builder interface.

## Open the builder

Let's create a Home page so you can follow along:

1. In your WordPress dashboard, go to **Pages > Add New**
2. Give it a title: "Home"
3. Click **Edit with Bricks**

![](imgs/admin-edit-with-bricks-button-eb75f876c9.png)

The builder opens. This is where you'll build your site.

![](imgs/builder-empty-canvas-052a44a859.png)

## The interface

The builder has four main areas: Toolbar (top), Settings Panel (left), Canvas (center), and Structure Panel (right).

A simple mental map:

- **Toolbar** = global tools and actions
- **Settings Panel** = what you can add or how you style what is selected
- **Canvas** = what you are currently designing (page or template)
- **Structure Panel** = the outline of your HTML structure

### Toolbar

The toolbar at the top is always visible. Here's what the main icons do:

![](imgs/builder-toolbar-styles-icon-3740959350.png)

- **Bricks logo** - Open the link configured in Bricks settings (defaults to the WordPress dashboard; you can change this later)
- **Styles** - Open the Style Manager, where you manage classes, variables, colors, typography scales, and spacing scales (`Cmd/Ctrl + .`)
- **Pages** - Switch between pages while staying in the builder
- **Templates** - Open the template library and your saved templates
- **Manage** - Access builder-related settings and tools
- **Command palette** - Search for elements and actions (`Cmd/Ctrl + K`)
- **Elements / Components** - Toggle the elements and components panel
- **Reload canvas** - Reload the preview if something looks out of sync
- **Breakpoints and preview size** - Switch between desktop, tablet, and mobile editing and adjust the preview width
- **Undo / Redo** - Step backward or forward through changes
- **Structure** - Toggle the Structure Panel on the right
- **Edit in WordPress** - Jump back to the WordPress editor for this page
- **View on front end** - Open the current page on the front end in a new tab
- **Preview mode** - Hide builder overlays so you can see a cleaner preview
- **Save** - Save your work

### Settings panel (left)

This panel changes based on what you're doing.

**By default**: Shows all available elements you can add (Layout, Basic, Media, WordPress, etc.)

**When element selected**: Shows that element's controls (typography, colors, spacing, etc.)

**When Theme Styles clicked**: Shows global design settings

**When Page settings clicked**: Shows page-specific settings

### Canvas (center)

Your visual workspace. This is where you build your page or template.

- Drag elements from the Settings Panel onto the canvas
- Click elements to select them
- Selected elements show a blue outline
- Changes update in real-time
- Right-click for quick actions (duplicate, delete, etc.)

**Important**: The canvas shows your design accurately, but always preview on the front end to see the final result.

### Structure panel (right)

Shows the hierarchy of everything on your current page as a nested tree.

```
Section
  └─ Container
      ├─ Heading
      ├─ Text
      └─ Button
```

**Why this is useful:**
- Click elements here instead of hunting for them on the canvas
- Drag to reorder elements or change hierarchy
- See your page structure at a glance

You can toggle it on/off with the tree icon in the toolbar, but most people keep it visible.

## What you've learned

You now know:
- Where the toolbar, settings panel, canvas, and structure panel are
- What each area shows

:::note[Help improve this lesson]
Bricks Academy is new. If anything in this lesson felt unclear or missing, use the feedback box in the right sidebar and leave us a quick note.
:::

---


## Next steps

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/next-steps/*

You've made it through the essentials! You can now build professional WordPress sites with Bricks. But this is just the foundation. Bricks includes powerful advanced features you haven't touched yet.

This article maps out what's next. For each feature, you'll learn:
- **What it is** - Clear explanation
- **Why it matters** - Real-world benefits
- **When you'll need it** - What problems it solves
- **Where to learn more** - Links to detailed guides

You don't need to learn everything at once. Build projects, encounter challenges, then learn the features that solve those specific problems. This is how you master Bricks naturally.

## How to best learn Bricks

**Don't try to memorize everything**. Instead:

1. **Build real projects** - Personal site, client work, passion projects
2. **Encounter problems** - "I need consistent CTAs across 20 pages..." or "This accordion needs to work everywhere..."
3. **Learn the solution** - "Ah, Components solve this!"
4. **Apply it** - Build it, break it, understand it
5. **Repeat** - Each project teaches something new

You'll master Bricks by using it, not by reading about it. These resources exist when you need them.

## Advanced features roadmap

### Components

**What it is:** Reusable elements that sync across your entire site. Create a card design once, use it everywhere. Update the component, and every instance updates automatically.

**Why it matters:** Ensures consistency and speeds up maintenance. Need to change button colors on 50 cards? Edit one component instead of 50 individual cards.

**When you'll need it:**
- Building card layouts used across multiple pages
- Creating reusable CTAs, testimonials, or team member cards
- When you find yourself copying and pasting the same design repeatedly

**Key difference from templates:** Templates control entire page layouts. Components control individual elements or small groups of elements. Use components for repeating design elements, templates for page structure.

**Where to learn more:** [Components documentation](/builder/features/components/)

### Style Manager

**What it is:** The central hub for managing your site's design system. Opened via the **Styles** icon in the toolbar or `Cmd/Ctrl + .`, it organizes theme styles, classes, CSS variables, colors, typography scales, spacing scales, and framework settings into a single interface.

**Why it matters:** Instead of hunting through different panels, you manage all your design tokens and reusable styles in one place. Define a color palette, set up fluid typography, create spacing scales, and manage classes — all from the same popup.

**When you'll need it:**
- Managing design tokens (colors, spacing, typography) across large sites
- Client sites where brand colors might change
- When you want more flexibility than theme styles offer
- Setting up a consistent design system from the start

**Combines with:** Theme styles and global classes. The Style Manager is where you define variables, classes, and scales — then reference them throughout your designs.

**Where to learn more:** [Style Manager documentation](/builder/features/style-manager/)

### Element interactions

**What it is:** Trigger actions (show/hide elements, toggle classes, start animations) based on user events (click, hover, scroll, form submit).

**Why it matters:** Create interactive experiences without writing JavaScript. Build accordions, tabs, modals, animated reveals, and more visually.

**When you'll need it:**
- Building custom accordions or tabs
- Creating show/hide functionality
- Adding scroll-triggered animations
- Opening popups on button clicks

**Examples:**
- Click a button → Show a hidden div
- Hover over an image → Fade in caption
- Scroll to element → Trigger animation
- Form submission → Show success message

**Where to learn more:** [Interactions documentation](/builder/features/interactions/)

### Element conditions

**What it is:** Show or hide elements based on conditions (user role, custom field value, query string, date, etc.).

**Why it matters:** Create dynamic layouts that adapt to context. Show admin-only content to logged-in admins. Display sale banners only during promotion periods. Show different CTAs based on custom field values.

**When you'll need it:**
- Membership sites (show content based on user role)
- Conditional pricing (show special offers to specific users)
- Dynamic templates (display different layouts based on post meta)
- A/B testing (show different versions based on query parameters)

**Powerful combination:** Element conditions + dynamic data + query loops = incredibly flexible templates.

**Where to learn more:** [Element Conditions documentation](/builder/features/element-conditions/)

### External APIs and custom integrations

**What it is:** Pull data from external services (weather APIs, stock tickers, social media feeds, custom databases) and display it in Bricks.

**Why it matters:** Connect your site to any service with an API. Display real-time data, integrate with third-party platforms, or build custom dashboards.

**When you'll need it:**
- Displaying live data (weather, currency rates, stock prices)
- Integrating with CRMs or custom systems
- Building complex dashboards

**Requires:** Some PHP knowledge to fetch and format API data, then use dynamic data to display it.

**Where to learn more:** [Dynamic Data API integrations documentation](/builder/dynamic-content/dynamic-data/)

### Query filters (advanced)

**What it is:** Real-time AJAX filtering for query loops. Users can search, filter by category, adjust price ranges, and sort results without page reloads.

**Why it matters:** Creates powerful, interactive search and filter experiences. Essential for e-commerce, directories, and large content libraries.

**When you'll need it:**
- WooCommerce shops (filter products by category, price, attributes)
- Directories (search and filter team members, locations, services)
- Large blogs (filter posts by category, tag, date)

**Available filters:**
- Live search
- Checkboxes (categories, tags, custom taxonomies)
- Radio buttons
- Select dropdowns
- Range sliders (price, dates)
- Date pickers

**Where to learn more:** [Query Filters documentation](/builder/dynamic-content/query-filters/)

### WooCommerce builder

**What it is:** Dedicated elements and templates for building custom WooCommerce shops. Complete control over product layouts, shop pages, cart, checkout, and account pages.

**Why it matters:** Default WooCommerce templates are generic. With Bricks, you design every aspect of the shopping experience to match your brand.

**When you'll need it:**
- Building e-commerce sites
- Customizing product pages beyond what themes offer
- Creating unique shop layouts

**Includes:**
- Product elements (price, add to cart, images, galleries, tabs)
- Shop templates (product archives, single products, cart, checkout)
- WooCommerce dynamic data tags
- Query filters for products

**Where to learn more:** [WooCommerce Builder documentation](/integrations/woocommerce/woocommerce-builder/)

### Custom code and hooks

**What it is:** Extend Bricks with your own PHP, CSS, and JavaScript. Use WordPress hooks to modify Bricks behavior programmatically.

**Why it matters:** When visual tools reach their limits, code gives you infinite flexibility. Build custom functionality, integrate with plugins, or create unique features.

**When you'll need it:**
- Adding custom functionality beyond Bricks' GUI
- Integrating with custom plugins or systems
- Building highly specialized templates

**Requires:** PHP, JavaScript, and WordPress development knowledge.

**Where to learn more:** [Hooks and Filters documentation](/developer/hooks/filters/)

### Popups

**What it is:** Build custom modals and popups that appear on any trigger (click, scroll, exit intent, time delay, etc.).

**Why it matters:** Create newsletter signups, promotional offers, video modals, login forms, or any overlay content with complete design control.

**When you'll need it:**
- Newsletter signup popups
- Video lightboxes
- Exit-intent offers
- Terms and conditions modals
- Custom login/register forms

**Combines with:** Interactions to control when and how popups appear.

**Where to learn more:** [Popups documentation](/builder/features/popup-builder/)

### Font manager

**What it is:** Upload and manage custom fonts (self-hosted or from services) directly in Bricks. Organize font families, weights, and styles.

**Why it matters:** Use any font you want, not just Google Fonts. Better performance with self-hosted fonts. Complete control over typography.

**When you'll need it:**
- Using brand-specific fonts
- Optimizing performance by self-hosting fonts
- Accessing fonts not available on Google Fonts

**Where to learn more:** [Font Manager documentation](/builder/styling/font-manager/)

### Keyboard shortcuts

**What it is:** Speed up your workflow with keyboard shortcuts for common actions.

**Why it matters:** Professionals use shortcuts. They're faster than clicking through menus repeatedly.

**Common shortcuts:**
- `Cmd/Ctrl + K` - Command panel (search elements, actions)
- `Cmd/Ctrl + D` - Duplicate selected element
- `Cmd/Ctrl + Z` - Undo
- `Cmd/Ctrl + Shift + Z` - Redo
- `Cmd/Ctrl + B` - Toggle responsive breakpoints
- `Delete` - Delete selected element

**When you'll need it:** Every project. Learn shortcuts gradually as you work.

**Where to learn more:** [Keyboard Shortcuts documentation](/builder/interface/keyboard-shortcuts/)

## Learning path by site type

Different projects need different features. Here's what to prioritize:

### Building a blog or content site

**Priority features:**
1. Dynamic data and query loops (essential)
2. Templates (single post, archive)
3. Theme styles (consistent typography)
4. Search functionality (query filters)

**Nice-to-haves:**
- Components (for reusable post cards)
- Popups (newsletter signups)
- Interactions (animated reveals)

### Building an e-commerce site

**Priority features:**
1. WooCommerce builder
2. Query loops (product grids)
3. Query filters (product filtering)
4. Templates (product pages, shop pages)

**Nice-to-haves:**
- Components (reusable product cards)
- Interactions (quick view modals)
- Popups (sale announcements)

### Building a business/portfolio site

**Priority features:**
1. Theme styles (brand consistency)
2. Global classes (reusable styles)
3. Components (team members, testimonials)
4. Templates (service pages, case studies)

**Nice-to-haves:**
- Interactions (portfolio galleries)
- Element conditions (role-based content)
- Popups (contact forms)

### Building a membership/community site

**Priority features:**
1. Element conditions (restrict content by role)
2. Templates (member profiles, directories)
3. Dynamic data (user-specific content)
4. Query loops (member lists)

**Nice-to-haves:**
- Custom code (advanced restrictions)
- Interactions (member dashboard features)

## Your next project

The best way to solidify what you've learned:

**Build a complete site from scratch.** Include:
- A homepage (static design)
- A blog with posts (template + dynamic data + query loop)
- An about page
- A contact page
- Header and footer templates

This project touches everything you've learned and prepares you for client work.

**Tips:**
- Start with wireframes or sketches
- Use theme styles from the beginning
- Create global classes for common patterns
- Test responsive behavior as you build
- Preview frequently on actual devices

## Community and resources

You're not alone in learning Bricks:

**Official resources:**
- [Bricks Academy](https://academy.bricksbuilder.io) - Comprehensive documentation
- [Bricks YouTube Channel](https://youtube.com/bricksbuilder) - Video tutorials
- [Bricks Changelog](https://bricksbuilder.io/changelog) - New features and updates

**Community:**
- [Bricks Facebook Group](https://facebook.com/groups/bricksbuilder) - Active community, Q&A
- [Bricks Forum](https://forum.bricksbuilder.io) - Official support forum

**Pro tip:** When you encounter issues, search the forum first. Most problems have been solved by the community already.

## A final word

You've completed the getting started series. You now have the foundational knowledge to build professional WordPress sites with Bricks.

But mastery doesn't come from reading. It comes from building, breaking, fixing, and building again. Each project teaches you something new. Each challenge reveals a feature you didn't know you needed.

**Start building.** The best learning happens when you're solving real problems.

**Don't aim for perfection.** Your first sites won't be masterpieces. That's normal. Every professional started where you are now.

**Stay curious.** When you see a site with a cool feature, ask yourself: "How would I build that in Bricks?" Then try building it.

**Enjoy the process.** Bricks is a powerful tool, but it's also fun. You're building websites visually, seeing changes instantly, and bringing ideas to life. That's pretty awesome.

Welcome to the Bricks community. We're excited to see what you build.

Now go make something great.

---


## Query loops and dynamic data

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/query-loops-dynamic-data/*

We're back on the homepage. Let's add a "Latest Posts" section below the hero.

## Before you begin: sample posts

This section needs **at least three published blog posts** so the query loop has something to show. If you skip this, the grid can look empty or broken even when you did everything right in Bricks.

**Create 3 test posts first:**

1. In the WordPress dashboard, go to **Posts > Add New**
2. Give each post a **title** and a short **excerpt** (use the excerpt field if your screen shows it, or add a couple of lines in the content and let WordPress generate one)
3. Set a **featured image** for each post (**Featured image** in the sidebar)
4. Click **Publish** and repeat until you have at least **3 published posts**

You can use the same steps later in the [Blog post template](/getting-started/blog-post-template/) article; the posts you create here are what that template will display.

Before we start clicking, we need two core ideas: **query loops** and **dynamic data**.

## What is a query loop?

In WordPress, a "query" is just a question like:

- "Give me the 3 latest posts"
- "Give me all posts in this category"

A **query loop** takes the answer to that question (the list of posts) and repeats a design once for each item.

You design a single **card** (image, title, excerpt, button). The loop runs through the posts and outputs one card per post. Change the query rules, and the same design shows different posts.

## What is dynamic data?

Until now, when you added a Heading or Text element, you typed the content manually. That is **static** text.

With **dynamic data**, you connect an element to a WordPress field instead:

- Heading pulls the **post title**
- Image pulls the **featured image**
- Text pulls the **post excerpt**

In a loop, each card shows the field values for the current post in the list.

You will see this as options like `{post_title}` or `{featured_image}` in Bricks. They are just visual placeholders for real WordPress fields.

## Prepare content

You should already have at least **3 published posts**, each with a **featured image** (see **Before you begin** above). Quick check: **Posts > All Posts** — you should see three or more posts with **Published** status.

## Build the section

1. Add a new **Section**
2. Inside the Container, add a **Heading** ("Latest Posts")
3. Add a **Block** element below the heading

## Configure the Grid

We want a 3-column grid for our posts.

Earlier in the series you used flexbox for a simple row layout (text on the left, image on the right). **CSS Grid** is the other famous layout system. It is ideal for two dimensional layouts where you care about rows and columns at the same time, like a grid of cards.

When you set a Block to use Grid, you tell the browser to place its children on a grid.

- The **Grid template columns** control describes how many columns you want and how wide they should be.  
  - `1fr 1fr 1fr` means “three equal columns”, each taking one fraction of the available width.
- The **Gap** control sets the space between both columns and rows, so your cards are evenly spaced in all directions.

As you add more cards, Grid automatically flows them into these columns, then wraps onto new rows as needed. You do not have to manually position each card.

1. Select the **Block**
2. **Display**: `Grid`
3. **Grid template columns**: `1fr 1fr 1fr` (three equal columns)
4. **Gap**: `24`

## Create the card (Loop item)

Inside the Grid Block, add another **Block** (this will be our repeating card).

Inside this Card Block, add:
1. **Image** (Featured Image)
2. **Heading** (Post Title, H3)
3. **Basic Text** (Post Excerpt)
4. **Text Link** ("Read more")

## Enable Query Loop

1. Select the **Card Block** (the inner one)
2. Toggle **Use query loop**
3. **Query settings**:
   - Post type: Posts
   - Posts per page: 3

You should now see 3 post cards!

## Connect dynamic data

1. **Image**: Select dynamic data -> `Featured Image`

![](imgs/dynamic-data-featured-image-ba69c6e2d3.png)

2. **Heading**: Select dynamic data -> `Post Title`. Link to -> `Post URL`

![](imgs/dynamic-data-post-title-ab1b4876dc.png)

3. **Excerpt**: Select dynamic data -> `Post Excerpt`
4. **Read more**: Link to -> `Post URL`

![](imgs/query-loop-2a3315a85b.png)

## Responsive check

1. Switch to **Mobile Landscape**
2. Select the **Grid Block**
3. Change **Grid template columns** to `1fr` (stacks cards vertically)

Done! You have a dynamic post grid.

---


## Responsive basics

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/responsive-basics/*

Earlier in the series we focused on building on desktop first, without worrying about smaller screens. Now it is time to take that same page and make it work everywhere.

Over half your visitors use phones or tablets. Responsive design means your layouts adjust gracefully to any screen size. This article covers how Bricks handles that.

## Understanding breakpoints

Breakpoints are screen width thresholds where your design adapts. Bricks includes four defaults:

| Breakpoint | Screen width | What it targets |
| --- | --- | --- |
| Desktop | Base (no limit) | Laptops, large monitors |
| Tablet portrait | < 992px | iPads, tablets |
| Mobile landscape | < 768px | Phones in landscape |
| Mobile portrait | < 478px | Phones in portrait |

Click the device icons in the toolbar to switch between breakpoints. The canvas resizes to show you what users on that screen size will see.

**How inheritance works:** Styles you set on Desktop apply to all breakpoints automatically. When you switch to a smaller breakpoint and change a value, that change applies to that breakpoint and anything smaller. You only override what needs to change — you do not redefine everything from scratch.

For example: set a Container's direction to `Row` on Desktop. Switch to Mobile landscape and change it to `Column`. Desktop and Tablet stay side-by-side. Mobile landscape and portrait stack vertically.

Bricks uses desktop-first by default (design large, refine smaller). Most users stick with this since it is easier to think "scale down" than "scale up."

## The responsive workflow

Let's make the hero section we built earlier responsive.

### 1. Check tablet

Click the **Tablet portrait** icon in the toolbar and look at your design. Common things to check:

- Does the two-column layout still feel comfortable, or does it feel cramped?
- Is the padding still proportional to the screen size?

### 2. Adjust spacing

Your Section has 80px padding. On tablets that is a lot of vertical space.

1. Select the Section
2. Make sure you are on the **Tablet portrait** breakpoint
3. Change **Padding** top/bottom to `60`

Desktop keeps 80px. Tablet and smaller use 60px.

### 3. Switch to mobile and stack the columns

On a phone, the two-column hero (text left, image right) is too cramped. Let's stack it.

1. Click **Mobile landscape** in the toolbar
2. Select the **Container** inside the hero section
3. Under **Layout**, change **Direction** from `Row` to `Column`

The text and image now stack vertically on mobile. Desktop and tablet stay side-by-side. This is the most common responsive technique: horizontal on large screens, vertical on small.

### 4. Check mobile portrait

Click **Mobile portrait** for the smallest view. Reduce padding a bit further if needed (around `32`). Check that buttons are large enough to tap comfortably.

## Hiding elements on specific breakpoints

Sometimes you want an element visible on desktop but hidden on mobile.

1. Select the element
2. Switch to the breakpoint where it should disappear
3. Under **Layout**, set **Display** to `None`

The element hides at that breakpoint and smaller, stays visible everywhere else.

## Two approaches to handling values across screen sizes

So far we have been manually setting a value (like `60px` padding) at each breakpoint. This works well for layout decisions like stacking columns or adjusting spacing.

But there is a second approach, especially useful for things like font sizes and spacing scales: instead of picking specific values at each breakpoint, you define a minimum and a maximum and let the browser smoothly calculate everything in between based on screen width. No breakpoints needed for those values at all.

For example: a heading that is always at least 24px on the smallest screen and never more than 48px on the widest. Between those two extremes, it scales automatically.

Bricks has this built in. The **Style Manager** (the same popup you used for Theme Styles) has dedicated **Typography** and **Spacing** tabs where you can generate these fluid scales as CSS variables. You set up the scale once, apply the variables to your elements, and responsiveness for those values is handled automatically.

This is a more advanced topic and not something you need right now. But it is worth knowing the two approaches exist:

- **Hard values at each breakpoint** — explicit, manual, great for layout
- **Fluid scaling** — define a range, let the browser do the math, great for typography and spacing

For a deeper look: [Fluid Typography](/builder/styling/fluid-typography)

## Testing your design

The builder canvas gives you a preview, but always test on real devices or browser dev tools.

**In the builder:** Use the breakpoint switcher. You can also drag the canvas edges to check intermediate widths.

**In the browser:**
1. Click **Preview** in the toolbar to open the front end
2. Open browser dev tools (`F12` or `Cmd/Ctrl + Shift + I`)
3. Enable **Responsive Design Mode**
4. Test at various widths

Real device testing reveals things emulation misses — touch target size, actual font legibility, performance on slower phones.

## Custom breakpoints

Bricks' four defaults cover most sites. If you need a breakpoint at a specific width (say, a wide desktop at 1440px), you can add one.

Go to **Bricks > Settings > General**, enable **Custom breakpoints**, then add them from the breakpoint manager in the builder.

## Troubleshooting

**Changes on mobile are not showing on the front end.**
Save the page, then hard-refresh the browser (`Cmd/Ctrl + Shift + R`).

**Styles I set on desktop are changing when I switch breakpoints.**
You likely overrode them on a smaller breakpoint earlier. Inheritance goes downward only — changes on mobile do not affect desktop.

**Layout breaks at a width between two breakpoints.**
Test widths like 850px (between Tablet 992px and Mobile landscape 768px). If something breaks there, either adjust your layout to be more flexible or add a custom breakpoint.

## What you've learned

- How breakpoints work and how styles inherit downward
- How to adjust spacing and stack columns on smaller screens
- How to hide elements on specific breakpoints
- The two approaches to responsive values: hard breakpoint overrides vs. fluid scaling
- How to test your design across screen sizes

---


## Settings and defaults

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/settings-defaults/*

import SchemaDownload from '../../../components/SchemaDownload.astro'

Before you start building pages, it helps to know that Bricks has a separate settings screen in the WordPress dashboard: **Bricks > Settings**.

These are your global Bricks settings. They affect how Bricks behaves across the site and are separate from the builder controls you will use while designing pages and templates.

Bricks tries to stay as unopinionated as possible, so there is no single "correct" setup. This preset is completely optional. If you want a simple starting point with sensible defaults for this series, import it and keep moving. If not, you can skip it and come back to the deeper settings later when a specific need comes up.

## Import the preset

1. Download the preset:

   <SchemaDownload
     href="/downloads/getting-started-bricks-settings.json"
     label="Download preset (JSON)"
     fileName="getting-started-bricks-settings.json"
   />

2. In the WordPress dashboard, go to **Bricks > Settings** → **Import Settings**.
3. Drop the JSON onto the upload area or use **Select file**.
4. Click **Import Settings**.

This preset enables:

- **Pages** only
- **Load all matching theme styles**
- **Query sort / filter / live search**
- **Custom breakpoints**
- Template thumbnails
- Toolbar logo set to **Dashboard**
- Structure actions
- Breadcrumbs
- **HTML & CSS to Bricks** with confirm-on-paste
- **Global class import manager** on conflicts
- Hover previews
- **Disable jQuery migrate**
- **Disable class chaining**
- **Preload custom fonts**

## Set it yourself

If you prefer not to import anything, that is totally fine too. The defaults are good enough to continue with the series.

When you start needing something specific, like builder access for editors, performance tweaks, template options, or API keys, you can revisit the full [Bricks Settings](/builder/setup/settings/) article.

---


## An intro to templates

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/templates-intro/*

You've built a homepage with theme styles applied. But what about elements that appear on every page, like a header or footer? You don't want to rebuild those manually on each page. That's where templates come in.

## What are templates?

Templates are reusable layouts that automatically appear on multiple pages based on rules you set.

Think of them as layout blueprints that apply themselves.

In classic WordPress, you would create different PHP template files and let WordPress decide which one to use for a given URL. With Bricks, you design those templates visually and control the rules (conditions) without touching PHP.

**Common examples:**

- **Header template** - Logo and navigation that appears on every page
- **Footer template** - Copyright and footer links on every page
- **Single post template** - The layout all blog posts share
- **Archive template** - Layout for category pages, blog archives

Build a template once, set where it should appear, and Bricks handles the rest.

## Template types

Bricks has different template types for different purposes:

- **Header** - Site header (logo, menu)
- **Footer** - Site footer (copyright, links)
- **Single** - Individual post/page layouts
- **Section** - Reusable sections you manually insert
- **Archive** - Blog archives, category pages, author pages
- **Error Page** - 404 page
- **Search Results** - Search results page

The template type tells Bricks how to use it.

## How templates apply

Templates use **conditions** to determine where they appear.

**Example**: Set a Header template's condition to "Entire Website" and it shows on every page automatically.

Other condition options:
- All posts
- All pages
- Front page only
- Specific pages/posts
- Category archives
- Etc.

### Auto-loading templates

Some template types load automatically if published:

| Template type | Auto-loads? |
| --- | --- |
| Header | Yes (if no conditions set) |
| Footer | Yes (if no conditions set) |
| Archive | Yes |
| Search Results | Yes |
| Error Page | Yes |
| Single, Section | No (conditions required) |

Once you publish a Header template, it appears site-wide by default (unless you disable this in **Bricks > Settings**).

## Why templates matter

**Efficiency** - Build once, use everywhere. Update once, change everywhere.

**Consistency** - Every page uses the same header, footer, and post layout.

**Scalability** - Add 100 blog posts, they all use your single post template automatically.

**Maintenance** - Need to update your footer? Edit one template, not 50 pages.

This is how professionals build WordPress sites that are easy to manage.

## Managing templates

View all templates at **Bricks > Templates** in WordPress dashboard.

![](imgs/template-manager-f548e28f7c.png)

Here you can:
- See template types
- View where templates are applied (conditions)
- Edit, duplicate, or delete templates
- Export/import templates
- Organize with bundles and tags

## Template library

Bricks also includes pre-made templates:

Click **Templates** (folder icon) in the builder toolbar.

**Source dropdown**:
- **My Templates** - Your custom templates
- **Wireframes** - Simple, unstyled layouts you can insert and customize
- **Design Sets** - Fully designed templates
- **Remote Templates** - Connect to other Bricks installations as template sources. If you've added any, they show up here too. Learn more: [Remote Templates documentation](/builder/features/remote-templates/)

We'll use wireframes later to speed up building.

## What you've learned

You now understand:
- What templates are and why they matter
- Different template types and their purposes
- How template conditions work
- Which templates auto-load
- Where to manage templates
- The template library sources

In the next article, we'll put this into practice by building a header template.

---


## Theme styles

*來源網址：https://academy-preview.bricksbuilder.io/getting-started/theme-styles/*

We just built a hero section, but it needs better spacing. Instead of adding padding manually to every section (slow and inconsistent), let's set a global rule using Theme Styles.

Theme Styles are your site-wide design system. They control the default look of every element. Under the hood, Bricks writes the CSS for you. Instead of hand-coding `section { padding: 80px 16px; }`, you set it visually once and it applies everywhere.

## Create a theme style

1. Click the **Styles** icon in the toolbar (or press `Cmd/Ctrl + .`)
2. Click the **Select: Theme Styles** dropdown and enter a name for the theme style
3. Click the "Create" icon

![](imgs/style-manager-theme-styles-tab-cffb6f0128.png)

This opens the **Style Manager**. This is the central place in Bricks for managing your design system. You will notice it has several tabs: Theme Styles, Classes, Variables, Colors, Typography, Spacing, Framework, and Settings. We will focus on Theme Styles for now and come back to the others as you need them.

## Set global section spacing

We want every section to have consistent padding and spacing.

1. In the Theme Styles panel, go to **Element > Section**
2. Set **Padding**:
   - Top: `80`
   - Bottom: `80`
   - Left: `16`
   - Right: `16`
3. Set **Row gap** to `32`

![](imgs/theme-styles-section-padding-4d1fe9b72f.png)

**Watch the canvas**: Your hero section immediately updates with the new padding! You didn't touch the section itself; you just changed the global rule.

Now, every new section you add will automatically have this perfect spacing.

## Apply to entire website

Right now, this style is only visible in the builder. Let's make it live for the whole site.

1. In Theme Styles, go to **Conditions**
2. Click **Add Condition**
3. Select **Entire Website**
4. Click **Save** in the toolbar

![](imgs/theme-styles-conditions-4d7f998860.png)

## Why this is powerful

**Scalability**: If you decide later that sections need `100px` padding, you change it *once* in Theme Styles, and your entire site updates.

**Consistency**: You never have to remember "was it 60px or 80px?" Bricks handles it for you.

Think of it this way:

- **Theme Styles** define sensible **defaults** for your whole site.
- **Global classes** (later in the series) give you reusable patterns you can apply on demand.
- **One-off element styles** are for rare exceptions.

Most of your design decisions should live in Theme Styles and classes. That is how you keep sites predictable and easy to change.

## Next: templates

Now that our global styles are set, let's look at another powerful global feature: Templates. We'll use them to build a header that appears on every page.

---
