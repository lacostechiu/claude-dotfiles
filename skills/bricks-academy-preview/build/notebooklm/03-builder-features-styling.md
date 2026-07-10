# Bricks Academy — Builder 功能/樣式/動態內容/介面

> 來源：Bricks Builder Academy 官方文件 | 共 73 篇

---



## Dynamic Data

*來源網址：https://academy-preview.bricksbuilder.io/builder/dynamic-content/dynamic-data/*

Use dynamic data to render all sorts of data from your WordPress database with Bricks.

For example: Featured image, post title, post date, author name, categories, tags, site title, all of your custom fields, etc.

You'll most likely use dynamic data when creating templates in Bricks. Such as your blog post template, and custom post type templates (e.g. single property listing).

## How to insert dynamic data

The dynamic data picker for text shows up when typing a "\{" onto the canvas. You can also click the "bolt" icon in the settings panel to reveal it:

https://youtu.be/w4Bv-Pd6n2w

Dynamic data for non-text settings such as images, videos, etc. is available from the "Select dynamic data" dropdown menu in the panel settings.

Below you can see an Advanced Custom Fields gallery (named "Gallery") rendered inside the Bricks image gallery element:

![](imgs/builder-dynamic-data-panel-1024x576-66a7446700.png)

All dynamic data tags are available in all elements that support dynamic data. This means that you may insert a gallery field (like an ACF gallery field type) inside a text element and it will be rendered as a set of `img` tags (using the filter `:image`), like so:

![](imgs/dynamic-data-gallery-text-element-8b39206318.png)

![](imgs/dynamic-data-gallery-output-text-element-53d9e58f02.png)



## Custom Fields Integrations {#integrations}

You can render much more than just standard dynamic WordPress data. Bricks supports the most popular custom fields plugins such as:

- [Advanced Custom Fields](#acf)
- [Meta box](#metabox)
- [Crocoblock (JetEngine)](#jetengine) (Not support WooCommerce Product Data / Variation Meta Box)
- Pods
- CMB2
- Toolset

This allows you to design templates for even the most complex custom post type layouts and data requirements.

### Advanced Custom Fields {#acf}

Bricks integrates with all the ACF and ACF Pro fields, including Flexible Content and Nested Groups.

The fields will be listed in the Dynamic Data dropdown inside of the Bricks builder so you can use them while building your pages and templates with Bricks.

The Relationship (including the [bidirectional](https://www.advancedcustomfields.com/resources/bidirectional-relationships/) implementation) and the Repeater field types are also available inside the Query Loop builder, so you could loop through the output of these fields while rendering the sub-fields as dynamic data.

The ACF field type "[True / False](https://www.advancedcustomfields.com/resources/true-false/)" is great for conditional checks inside the element conditions. By default, the localized "True / False" label is returned. When using it in your element conditions, make sure to apply the `:value` filter. To check for false, you can compare against `== 0`. Or `== 1` to check for true.



![](imgs/bricks-acf-field-type-true-false-e6d665226f.png)

<figcaption>

Check if ACF True / False field is false

</figcaption>



The following dynamic data can be used together with [Element conditions](/builder/features/element-conditions/) effectively.

`{acf_get_row_layout:raw}` - Returns the ACF Flexible layout name

### Meta Box {#metabox}

Bricks is compatible with the Meta Box Post Types, Taxonomies, Custom Fields, and Relationships. Regarding the Custom Fields, Bricks will list the fields inside the builder in the Dynamic Data dropdown. According to the custom field contents, these tags will be rendered properly in the front end.

The Group field (when cloneable) and the Relationships will also be available inside the Query Loop builder. You can iterate through these values and render the sub-fields as dynamic data.

It is also possible to build nested non-clone-able Group fields in Bricks Query Loop.

### Crocoblock JetEngine {#jetengine}

Bricks is compatible with Crocoblock JetEngine Post Types, Meta Boxes (Custom fields), Taxonomies, Relations, and Options pages.

[Custom Content Types](https://crocoblock.com/knowledge-base/jetengine/how-to-showcase-cct-meta-fields-using-dynamic-tags-in-bricks/) (CCT) has been supported since April 2024 by the JetEngine plugin, not Bricks itself. For any CCT questions, please get in touch with the JetEngine support directly.

Bricks integration with the JetEngine plugin makes the custom fields available as dynamic data inside the Bricks builder.

Bricks also integrates with the JetEngine Relations and Repeaters to feed the Bricks builder query loop.

## Standard WordPress data {#wordpress}

By default, you may use the following dynamic data tags.

### Post fields {#post-fields}

The following fields are related to the posts or custom post types.

`{post_title}` - Returns the post title

`{post_id}` - Returns the post ID

`{post_url}` - Returns the post link

`{post_slug}` - Returns the post slug

`{post_type}` - Returns the post type (@since 1.12)

`{post_date}` - Returns post published date

`{post_modified}` - Returns post modified date

`{post_time}` - Returns post publish time

`{post_comments_count}` - Returns number of comments

`{post_content}` - Returns post content (Gutenberg editor)

`{post_excerpt}` - Returns the post excerpt

`{read_more}` - Renders an anchor tag (link) to the post with the label "Read more"

`{featured_image}` - Renders an image tag with the featured image



These fields support the following **dynamic data filters**:

`{post_title:link}` - Renders the post title as a link to the post

`{post_title:link:3}` - Same as before but the title is limited to 3 words

`{post_title:link:newTab}` - Open post title in new tab

`{post_date:human_time_diff}` - outputs the date difference in a human readable format such as "1 hour", "5 mins", "2 days"

`{post_excerpt:55}` - Limit post excerpt to 55 words. Using the ":" followed by a number limits the output to that number of words

`{post_excerpt:format:10}` - Keep the HTML format and limit post excerpt to 10 words.

`{featured_image:medium_large}` - Renders an image tag with the featured image of size medium_large (defaults to thumbnail size)

`{featured_image:large:link}` - Renders an image tag (within text context) of the featured image, size "large2, wrapped by an anchor tag to the post



### Taxonomies {#taxonomies}

The following dynamic data tags render a list of the taxonomy terms assigned to a post. A link to the term archive wraps each term:

`{post_terms_category}`

`{post_terms_post_tag}`

`{post_terms_my_taxonomy_slug}` - Replace the "my_taxonomy_slug" part with the slug of the actual taxonomy you want to use

`{post_terms_category:plain}` - Remove the links via :plain filter



If you already use a link around your element, you can disable the terms' links output using the [`bricks/dynamic_data/post_terms_links`](/developer/hooks/filters/filter-bricks-dynamic_data-post_terms_links/) filter.

### Terms {#terms}

The following dynamic data tags render data related to taxonomy terms.

`{term_id}` - Renders the term ID

`{term_name}` - Renders the term name

`{term_slug}` - Renders the term slug

`{term_count}` - Renders the term count

`{term_taxonomy_slug}` - Renders the term's taxonomy slug. (@since 1.11)

`{term_url}` - Renders the term archive link

`{term_description}` - Renders the term description

`{term_meta:my_term_meta_key}` - Renders the "my_term_meta_key" meta value



### Author Fields {#author}

`{author_id}` - Returns the post author ID

`{author_name}` - Returns the post author name

`{author_bio}` - Returns the post author biographical info

`{author_email}` - Returns the post author email

`{author_website}` - Returns the post author website

`{author_archive_url}` - Returns the post author url

`{author_avatar}` - Returns the post author avatar as an image tag (text) or an image url (link)

`{author_meta:meta_key}` - Returns the specified author meta value. Set the author meta key as the filter. Example. author_meta:first_name returns the author's first name. See [here](https://developer.wordpress.org/reference/functions/get_the_author_meta/#description) for available author meta keys.



These fields support dynamic data filters like the following:

`{author_bio:20}` - Post author biographical info limited to 20 words

`{author_name:link}` - Post author name rendered as a link to the author profile page

`{author_email:link}` - Post author email rendered as a link

`{author_website:link}` - Post author website rendered as a link

`{author_avatar:200}` - Post author avatar image tag limited to the width/height of 200px



### Query fields {#query}

`{query_loop_index:raw}` - Returns the index of the current loop item, starting at 0. Use the `@start-at` argument to start the index from any other number. Example: `{query_loop_index:raw @start-at:1}` to start the index at 1 instead of 0. The `@pad` argument lets you define a 0-based padding. Using `{query_loop_index @pad:2:raw}` results in an index output of `001` and `010` instead of `1` and `10`.

`{query_results_count:raw}` – Use inside or outside a query loop to return the query results count. When used outside a loop you have to pass the query loop ID as a filter to this tag like this: `{query_results_count:quer34:raw}`. "quer34" in this example is the Bricks ID, which you can copy to your clipboard from the right-click context menu.

### Site & Archive fields {#site-archive}

`{site_title}` - Returns site title as defined in the WordPress settings > General > Site Title

`{site_tagline}` - Returns site tagline as defined in the WordPress settings > General > Tagline

`{site_url}` - Returns site URL as defined in the WordPress settings > General > Site address (URL)

`{site_login}` - Returns site login URL. Redirect after login URL can be set by specifying the post ID as the filter like this: `{site_login:3}`


`{site_logout}` - Returns site logout URL. Redirect after logout URL can be set by specifying the post ID as the filter like this: `{site_logout:3}`

`{archive_title}` - Returns archive title

`{archive_title:context}` - Add context to the archive title

`{archive_description}` - Returns archive description (author, post type or term)



You can get dynamic data from the URL parameters like so:

`{url_parameter:my_key}` - Returns the value of the `my_key` parameter in the url (https://mydomain.pt/?my_key=value)



### User profile fields {#user-profile}

`{wp_user_id}` - Returns current user context ID

`{wp_user_login}` - Returns current user context username

`{wp_user_email}` - Returns current user context email address

`{wp_user_url}` - Returns current user context website

`{wp_user_author_url}` - Returns current user context author URL

`{wp_user_role}` - Returns current user context primary role. Use `:value` to return the role slug. (@since 1.12)

`{wp_user_registered_date}` - Returns current user context registered date (@since 1.12)

`{wp_user_nicename}` - Returns current user context nicename

`{wp_user_description}` - Returns current user context biographical info

`{wp_user_first_name}` - Returns current user context first name

`{wp_user_last_name}` - Returns current user context last name

`{wp_user_display_name}` - Returns current user context display name

`{wp_user_picture}` - Returns current user context avatar image tag or url

`{wp_user_meta:my_user_meta_key}` - Returns current user context "my_user_meta_key" meta value



### Native WordPress custom fields

To render your own custom field entries, you have to prefix them with `cf_`.

If your custom field name is `phone_number`, you'd use `{cf_phone_number}` to render this custom field on the front end.

Your `phone_number` custom field entry should also be available in the dynamic data picker dropdown under "Custom fields".

## Date Dynamic Tags {#date}

### Current Date fields {#current-date}

You can render the current date through dynamic data.

`{current_date}` - Returns the current date (UTC) with the format defined at WordPress > Settings > General > Date Format

`{current_wp_date}` - Returns the current date (WordPress timezone) with the format defined at WordPress > Settings > General > Date Format

You may specify a different date format using the PHP date format, for example:

`{current_date:Y}`

`{current_date:Ymd}`

`{current_date:Y-m-d}`

`{current_date:Y.m.d}`

`{current_date:Y/m/d}`

`{current_date:Y m d}`

`{current_date:g:i A}`

`{current_date:timestamp}`



### Format Date {#format-date}

Bricks 2.2 introduces a new dynamic tag `{format_date:raw}` that allows you to convert a date string from one format to another — directly within the builder, without writing any PHP.

`{format_date:raw @date:'your-date-value' @from:'input-format' @to:'output-format'}`

Parameters

- `@date`: The original date string to convert. This can be a raw date or another dynamic tag
- `@from`: The input format (e.g., `Y-m-d`, `Y/m/d`, `Y-m-d\TH:i:s.v\Z`, etc. [https://www.php.net/manual/en/datetime.format.php](https://www.php.net/manual/en/datetime.format.php) )
- `@to`: The desired output format (e.g., `d M Y`, `timestamp`, `Y-m-d (l)`)

##### Example 1: Simple Date format conversion

`{format_date:raw @date:'2025-01-10' @from:'Y-m-d' @to:'d M Y'}`

**Output:** `10 Jan 2025`

##### Example 2: Format from API Response

Assume this dynamic tag returns an ISO-formatted datetime string:

`{query_api:raw @key:'registered'}` → 2025-04-30T09:41:02.053Z

`{format_date:raw @date:'{query_api:raw @key:'registered'}' @from:'Y-m-d\TH:i:s.v\Z' @to:'Y m d (l)'}`

**Output:** `2025 04 30 (Wednesday)`

---

`{query_api:raw @key:'publishDate'}` → 2025-09-22T11:22:33.0123456Z

`{format_date:raw @date:'{query_api:raw @key:'publishDate'}' @from:'Y-m-d\TH:i:s.u\Z' @to:'Y-m-d H:i'}`

**Output:** `2025-09-22 11:22`

##### Example 3: Convert to Timestamp

This is useful especially when you want to use in condition to compare 2 different dates.

Assume a custom field (by your custom plugin) dynamic tag returns a date:

`{cf_my_date:raw}` → 2025/03/25

You can convert it to a UNIX timestamp for comparison:

`{format_date:raw @date:'{cf_my_date:raw}' @from:'Y/m/d' @to:'timestamp'}`

**Output:** `174277440`

### Advanced: echo {#advanced}

:::note
Starting at Bricks 1.9.7, you have to explicitly allow any function names that you want to call via Bricks’ dynamic data `echo` tag using the new `bricks/code/echo_function_names` filter. Which you can add to your Bricks child theme or the code snippet plugin of your choice. You can find more information in this article: [/developer/hooks/filters/filter-bricks-code-echo_function_names/](/developer/hooks/filters/filter-bricks-code-echo_function_names/)
:::

Bricks 1.4 introduces the `echo` tag to render the output of any PHP function:

`{echo:my_custom_function}` - Echoes the value of the PHP function `my_custom_function()`



It accepts arguments, with or without single quotes, like so:

`{echo:get_the_date('Y-m-d', '55')}` - Echoes the date of the post 55 formatted to `Y-m-d`



### Argument Formatting Rule

When passing arguments to functions inside `{echo::raw}` tags, all arguments must be enclosed in single quotes, regardless of whether they are static values or dynamic tags. (`@since 1.9.3`)

`{echo:my_function('static value')}`

`{echo:my_function('{post_title}')}`

:::note
Please note that the `echo` tag does not support double quotes, and the custom PHP function should `return` the value (do not `echo` the value inside of the custom function).
:::

https://www.youtube.com/watch?v=ajAXEZoyk0E

### Advanced: do_action {#do_action}

The `do_action` tag enables developers and other plugins to integrate with your template designs seamlessly. With this tag, you can place action hooks such as `{do_action:my_custom_hook}` anywhere.

For example, you can insert the `{do_action:woocommerce_after_single_product}` in your WooCommerce single product template, allowing other plugins to hook into it. This enhances the flexibility of your template design.

:::note
It is important to note that the `do_action` tag does not support passing arguments to the action. If the `add_action()` function expects additional arguments, an error in PHP will occur. The `do_action` only runs on the front end of the website, not inside the builder.
:::

### WooCommerce {#user-profile}

When the WooCommerce plugin is installed and active, you'll get access to an extra set of Dynamic Data tags related to the products and orders. Please refer to the [WooCommerce builder](/integrations/woocommerce/woocommerce-builder/#dynamic-data) article for more details.

## Filters {#filters}

You can change the output of certain dynamic data tags by using the following filters:

- `:*numeric value*` - When used on a text field, it trims the content to the number of words specified (e.g. `{post_excerpt:10}`). When used with an avatar field like `author_avatar` it specifies the width/height of the avatar image
- `:context` *or* `:prefix` - Add context to the archive title
- `:image `- Outputs the field as an image tag, *e.g.* ``
- `:link` - Output the field as an anchor tag, *e.g.* [`*value*`](https://...)
- `:newTab` - Sets the link to open in a new tab
- `:tel` - The URL of the anchor will be formatted as a telephone number,
*e.g.* [`+123456789`](tel:+123456789)
- `:*text value *`- Depending on the context, it could mean the following:
  - User or term custom field meta key
  - The URL parameter key
  - Post terms separator
  - Date format
  - Image size slug (e.g., thumbnail or full)
  - The echo tag function name
- `:value` - Outputs the value instead of the label. Useful for comparing choices field types like MetaBox checkbox list, etc. inside element conditions, or with ACF choice fields (set the return type to "Both (Array)") such as Select, Checkbox, Radio Button, and Button Group. ACF field types that supporting this filter: True/False, User, Taxonomy, Image, Gallery, Post Object, Relationship (`@since 1.12`) MetaBox field types that supporting this filter: File Input, File, File Upload, File Advanced, Video, Image, Image Advanced, Image Upload, Single Image, Image Select Taxonomy, Taxonomy Advanced, Post, User (`@since 1.12`)
- `:raw` - Skip parsing dynamic data tag
- `:url` - Return URL from post ID. Useful to return URL for `file` field, etc.
- `:format` - Keep HTML format or show empty Star rating for [WooCommerce dynamic data](/integrations/woocommerce/woocommerce-builder/#dynamic-data)
- `:plain` - Removes HTML tags using `wp_strip_all_tags`, which can be helpful when you need to extract plain text from a dynamic tag result. For example, you may want to remove links from a post term dynamic tag.
- `:array_value|{KEY}` - Returns the value of a specific array key within a dynamic tag result. It can be particularly useful for custom fields such as ACF Google Map and ACF Link types. The filter can also be applied to an echo dynamic tag. In cases where the value is a nested array, Bricks will flatten it as a JSON string to allow for seamless output without any errors. It's important to note that this filter should only be used when you are certain that the dynamic tag result is an array. Another important point to keep in mind is that if the specified array key does not exist, this filter will return an empty string. [Examples](#array_value-filter-examples)
- `:timestamp` - Convert the date or time related dynamic data to timestamp value.
- `:slug` and `:term_id` - Used in `{post_terms_xxxx}` dynamic tags, to output slug or term ID, instead of the term name. It can also be helpful in combination with `:plain` filter, like `{post_terms_xxxx:slug:plain}`, when using it inside conditions, taxonomy query, ... to compare the correct values (`@since 2.0`).

##### Examples of :array_value filter {#array_value-filter-examples}

`{acf_place_map:array_value|lat}` - Echoes the `$value['lat']` of the ACF google map type field

`{acf_place_map:array_value|post_code}` - Echoes the `$value['post_code']` of the ACF google map type field

`{acf_ext_link:array_value|title}` - Echoes the `$value['title']` of the ACF link type field

`{je_football-team_logo:array_value|id}` - Echoes the `$value['id']` of the JetEngine media field (Value format set as Array with media ID and URL)

`{mb_testimonials_user_image:array_value|name}` - Echoes the `$value['name']` of the Metabox single image field

`{echo:custom_function:array_value|hello}` - Echoes the `$value['hello']` of PHP `custom_function()` function

## Key-value pair arguments {#arguments}

This feature allows for greater flexibility and customization in displaying dynamic content. The general syntax for using key-value pair arguments is: `{dynamic_data_tag @key:value}`.

- Wrap text with spaces in single quotes.
- The value can include other dynamic data tags (e.g., `{acf_text_field @fallback:'No content was found for {post_title}'}`).

### Available arguments:

<span id="fallback"></span>

`@fallback` – Provides fallback text if the dynamic data tag doesn't return any data. This argument can be used with any dynamic data tag (`@since 1.10`).

- **Example:** `{acf_text_field @fallback:'This is the fallback text!'}`. If `acf_text_field` is empty, "This is the fallback text!" will be displayed.
- **Example**: `{acf_page_builder_cta_modul_options_css_id:raw @fallback:'{acf_get_row_layout:raw}-{query_loop_index:raw}'}`. If `acf_page_builder_cta_modul_options_css_id` is empty, use current ACF flexible layout concatenate with current loop index as return string. Good use case when using this on dynamic CSS ID.

<span id="fallback-image"></span>

`**@fallback-image**` – Used for image dynamic data tags. It accepts either an attachment ID or a URL.

- **Examples:** `{acf_image @fallback-image:554}` or `{acf_image @fallback-image:'https://example.com/placeholder.png'}`. If `acf_image` is not available, the specified image (by attachment ID or URL) will be displayed.

<span id="sanitize"></span>

`@sanitize` - Available `@since 1.11.1` it allows you to control the sanitization method applied to all dynamic tags within a "text" context. By default, all dynamic tags are sanitized using `wp_kses_post`, which helps secure output by stripping unwanted HTML and scripts.

This argument is particularly useful if you have a shortcode outputting JavaScript—such as a form shortcode from plugins—stored within a custom field. In earlier versions, this JavaScript would be sanitized, preventing the form from functioning when the field is output via `{acf_custom_field}`.

**Examples:**

- `{acf_my_wysiwyg @sanitize:false}` – Disables sanitization, allowing scripts to be output if stored in the custom field. **Use carefully, ensuring that the content is safe for output without sanitization.**
- `{acf_my_wysiwyg @sanitize:sanitize_email}` – Applies `sanitize_email` to the `my_wysiwyg` field. If the value doesn’t pass as a valid email, it returns empty.
- `{acf_my_wysiwyg @sanitize:sanitize_email @fallback:'abc@gmail.com'}` – Applies `sanitize_email` to the `my_wysiwyg` field. If the result is empty, it falls back to `'abc@gmail.com'`.

:::note
**Note:** The `@sanitize` argument only accepts methods listed in the [WordPress Sanitizing API](https://developer.wordpress.org/apis/security/sanitizing/) , `**false**` or `wp_kses`. If using `@sanitize:false`, be cautious, as this will output the field content without sanitization.
:::

## Bricks hooks related to Dynamic Data {#hooks}

[`bricks/dynamic_data/exclude_tags`](/developer/hooks/filters/filter-bricks-dynamic_data-exclude_tags/) - exclude a list of tags from the Bricks dynamic data logic

[`bricks/dynamic_data/replace_nonexistent_tags`](/developer/hooks/filters/filter-bricks-dynamic_data-replace_nonexistent_tags/) - Disable the default Bricks behavior of replacing the non-existent dynamic data tags with an empty string

---


## Global Queries & Query Manager

*來源網址：https://academy-preview.bricksbuilder.io/builder/dynamic-content/global-queries-query-manager/*

https://youtu.be/b4nGPJIE5rE

Starting with **Bricks 2.1**, you can create and manage **reusable global queries**. This lets you define query logic once and reuse it across your entire website. Any changes you make to a global query are automatically applied everywhere it’s used.

This feature improves efficiency, consistency, and maintainability for sites that rely on complex queries.

## Creating a Global Query {#create}

1. **Define a Local Query**
  - Insert a nestable element (e.g., Container, Block, Div).
  - Enable the **Query Loop**.
  - Configure query settings (e.g., post type, posts per page).
2. **Save as Global Query**
  - Click the new Save icon in the query control.
  - Provide:
    - **Name** (e.g., “Latest Three Properties”)
    - **Description** (optional, for team clarity)
    - **Category** (optional, useful for grouping queries)
3. Click **Create**.

The query now becomes global and can be reused site-wide.

![](imgs/bricks-global-query-save-button-ed4cdae3f2.png)

You can also create a global query inside the [Query Manager](#query-manager).

## Using a Global Query {#use}

- When adding a new Query Loop, click the **globe icon**.
- Choose from your list of available global queries.
- Bricks will apply the stored query logic automatically.

If no global queries exist, the globe icon will not be available.

## Editing Global Queries {#edit}

You can edit a global query in several ways:

- **Query Manager (recommended):**
  - Toolbar: **Manage → Query Manager**, or
  - Use the **Command Palette → Manage Queries**.
- **Inline Editing:**
  - Inside the Query Control, click the **Edit** (pencil) icon.
  - Bricks will indicate you are editing a global query (changes apply everywhere).

Edits update **all instances** that use the global query. For example, changing "Posts per page" from "3" to "5" updates every loop referencing that query.

## Disconnecting a Global Query

- Use **Disconnect** to convert a global query into a **local query**.
- The local query inherits the global settings as a starting point, but further edits won’t affect the original global query or other instances.
- Useful when you want a slightly different query in a specific context.

## Query Manager {#query-manager}

The new Query Manager lets you create, organise, edit, import & export all your global queries.

![](imgs/bricks-query-manager-scaled-639981bec6.png)

It can be accessed in those following ways:

- Toolbar under **Manage → Query Manager**
- From the **Command Palette → Manage Queries**
- Query control **Globe → Gear icon**

## Import & Export {#import-export}

Global queries can be exported and imported as **JSON files** from the Query Manager.

- **Export:** Creates a JSON file containing queries and categories.
- **Import:** Upload the JSON file to another WordPress site to reuse queries.

This works the same way as exporting/importing classes and variables.

## Summary

The **Global Queries & Query Manager** feature in Bricks 2.1 allows you to:

- Create reusable queries.
- Apply them site-wide with a single click.
- Edit once, update everywhere.
- Disconnect for local variations.
- Import/export for portability.

This makes query management more consistent, efficient, and scalable across projects.

---


## Query Data from APIs

*來源網址：https://academy-preview.bricksbuilder.io/builder/dynamic-content/query-data-from-apis/*

Starting with Bricks 2.1, you can now use the powerful Query Loop builder to fetch and display data from an **API endpoint**—without writing custom PHP code.

This **experimental feature** is perfect for displaying content from third-party services, public APIs, or even another WordPress site via REST API.

https://youtu.be/84jlX9gSz7o

## Getting Started

A new **Query Type** called **API** lets you connect to and consume data from REST API. Once configured, the API response is parsed and rendered using Bricks' dynamic tag system—just like any other query loop.

To begin:

1. Select any nestable element that supports the **Query Loop** (e.g., Container, Block, Div).
2. Enable the **Query Loop** and set the **Query Type** to **API**.
3. Click the **API Settings** button to open the API configuration popup.

![](imgs/bricks-query-loop-type-api-c54eb3aca6.png)

## API Settings

In the API settings popup, you can define everything required for the API call—like the endpoint URL, HTTP method, headers, parameters, and more.

Once you have everything configured you can fetch the API response data and preview it in the column on the right-hand side. And copy or generate custom dynamic data tags to easily render the API data inside the loop.

![](imgs/bricks-query-loop-api-settings-ce896c059b.png)

### Name

Internal label for identifying this API connection (e.g. “Books API”, "Google Spreadsheet A").

### URL (Required)

The full API URL based on the documentation.

### HTTP Method

Define if you want to perform a GET (default) or POST request.

### Authorization

Supports API Key (header or URL parameter), Bearer Token, and Basic Auth.

For enhanced security, you can use a PHP constant instead of entering sensitive values directly. Tick the "Use PHP Constant" box, and Bricks will generate a constant name for you. You can then define its value in your environment (e.g., wp-config.php), and Bricks will reference it during the API request.

### Headers

Default headers:

- `Content-Type: application/json`
- `User-Agent: BricksBuilder/{CURRENT_VERSION}`

You can add more headers or override these defaults by defining custom headers in the UI. These headers will be sent with each API request.

### URL Parameters

You can add key-value pairs that will be appended as query parameters to the API URL.

Example: Adding a URL parameter with key `limit` and value `5` when the API URL is `https://dummyjson.com/recipes` generates the final API URL of `https://dummyjson.com/recipes?limit=5`.

![](imgs/bricks-query-loop-api-url-parameters-c4e4d87b1d.png)

### Request Body

If your HTTP method is set to `POST`, you can provide a request body in one of the following formats:

- JSON
- Form Data
- x-www-form-urlencoded

Use this to send payloads when interacting with POST-based endpoints.

### Response path

Specify the **object path** to extract data from within the response. Leave it blank to use the full top-level response.

Example: `data.results` to get results from `{data: {results: […]}}`

:::note
**IMPORTANT: Only array data can be looped. The response path must return an array!  If it resolves to an object instead, the query loop will not render anything.**
:::

### Cache duration

Set to 0 to disable caching. Default is 300 seconds (five minutes).

Bricks stores the response using WordPress transients, which helps reduce unnecessary API calls during page building or repeated visits.

## Pagination

Bricks' API query loop supports pagination—provided the target API allows navigation via **page numbers** or **offsets**.

To enable pagination:

- Enable the **"Has pagination"** checkbox in the API settings.
- Add a Bricks **Pagination element** to your page and set target query to the API query loop.
- Define the **"Total items path"** so Bricks knows how many pages to generate.
- Choose either **"Page number" **or **"Offset"** pagination method and complete the configuration.

This ensures Bricks can dynamically render pagination and load the correct data when navigating through pages.

### Pagination method: Page number

Use this method when the API supports navigation by specifying the page number (e.g., `page=3`).

**Example**: The WordPress REST API

- Add `page` as a URL parameter
- Set `per_page` to define how many items to load per page (e.g., `per_page=3`)
- Enable **Has pagination**
- Set the **Page parameter** to `page`

Bricks will automatically update the `page=n` value when users interact with the pagination element.

![](imgs/wp-api-pagination-example-new-49514aad7b.png)

### Total Items Path

WordPress REST API includes `x-wp-totalpages` in the response headers, so you can set `header.x-wp-totalpages` for the **"Total items path"** field.

This tells Bricks how many pages exist, allowing it to generate the correct pagination structure.

### Pagination method: Offset

Use this when the API requires offset-based navigation.

**Example**: [DummyJSON Products API](https://dummyjson.com/docs/products?utm_source=chatgpt.com#products-limit_skip)

Based on the documentation, to get 3rd page data when limit (items per page) is 5, we should pass `limit=5&skip=10` in the API request. In Bricks, just need to set as below image.

![](imgs/offset-api-pagination-example-new-695df56903.png)

By doing this, clicking page number "3" on the pagination element generates `limit=5&skip=10` parameter when making the request.

Note that we also indicate `body.total` in the "Total items path" field.

## API Response

The fetched API response data is shown in the API response panel on the right.

This panel lets you inspect the response data in a tree view (default). Click the "RAW JSON" button to view the response in raw JSON format.

### Using the API response data in your loop

Bricks introduces a new `query_api` dynamic data tag to render any piece of the API response defined via the `@key` filter.

![](imgs/bricks-query-loop-api-response-ec95be347e.png)

In the API response above, to render the recipe `name`, use the `{query_api:raw @key:name}` inside the query loop.

To output nested data, such as the post title in a WordPress REST API response, use the `|` (pipe) delimiter like so `{query_api:raw @key:title|rendered}`.

You can also **copy the dynamic data tag** by hovering over the specific dataset you want to render, and click the clipboard icon to copy the ready-to-use dynamic data tag to your clipboard.

Third, click the `+` icon, next to the clipboard icon, to generate a **custom dynamic data tag** that'll be available inside the DD picker.

![](imgs/dynamic-tag-localStorage-ecf3973273.png)

:::note
**NOTE**: The created dynamic data tag is saved in your browser localStorage instead of the database. So only you in your browser will have access to it.
:::

---


## Query Sort, Filter & Live Search

*來源網址：https://academy-preview.bricksbuilder.io/builder/dynamic-content/query-filters/*

This new feature set, introduced in Bricks 1.9.6, enhances content interaction through AJAX-powered filter elements such as search, checkboxes, select options, radio buttons, range sliders, and date selectors.

It allows advanced real-time content sorting, filtering, and searching without a page refresh, resulting in a more dynamic and interactive user experience.

https://youtu.be/5oDHG-bTAfQ

### How To Enable Query Filters

Enable Query filters from your WordPress dashboard under `Bricks > Settings > Query filters`.

Once enabled, a new "Filter" element group with all filter elements becomes available in the builder elements panel.

![](imgs/bricks-1.9.6-filter-elements-aa3e16222b.png)

### Important Notes {#important-notes}

- **Compatibility warning**: Query filters might conflict with plugins that override the `bricks/query/force_run` filter. It is best to avoid using Bricks query filters in combination with other filter plugins.
- **Scope limitation**: Query sort & filter are limited to target the outer layer (in nested query scenarios). Supported query types: "Post", "Term", and "User" `(@since 1.12)`
- **Custom field support**: By default, Bricks Query Filters work only with simple, plain-text custom field values. They do not support fields that store data in serialized formats. (Please read this [Custom Fields Integration](#custom-fields-integration) if you are using ACF or Metabox.io, we improved this in `1.11.1`)
- **Component limitation**: Filter elements must not be used inside a Bricks component. Similarly, the target query loop must not be a loop that lives inside a component **unless** the component's root is the query loop itself. [Read more](https://forum.bricksbuilder.io/t/no-bug-pagination-does-not-work-with-query-loop-in-post-grid-component/33215/2)

![](imgs/scope-limitation-posts-query-548d276358.png)

## How To Setup A Filter {#how-to}

When adding a filter element to your page, you always have to assign it a "Target Query". This is necessary so Bricks knows which query a particular filter should affect.

![](imgs/bricks-1.9.6-filter-target-query-setting-594x1024-e5972ba16f.png)

This flexibility of setting the Target Query on the filter element itself allows you to add your filters anywhere on your page. You don't have to arrange all your filters inside one block.

You can, for example, add a sorting element somewhere else on your page, as we did in the following example. Where all filters are located inside the left-hand column, and the sorting element is placed inside the right-hand column right above the query loop.

![](imgs/bricks-1.9.6-filter-and-sort-woo-products-1bc867304b.png)

### Apply Filter On "Input" Or "Submit" {#filter-on-input-or-submit}

By default, any change you apply to a filter, such as selecting a different radio filter option or a checkbox filter value, updates the target query. You can change this behavior by setting the "Apply to" control to "Submit." This way, the query will only be updated by clicking the "Filter - Submit" element connected to the same Target Query.

![](imgs/bricks-1.9.6-filter-apply-on-submit-1cf5b97e95.png)

## Filter elements {#elements}

### 1. Filter - Active Filters {#filter-active-filters-element}

- **Function**: Displays the currently active or selected filters, allowing users to easily remove a filter with a single click for faster navigation. (@since 1.11)
- **Exclude filter IDs**: If you want certain filters not to appear in the list of active filters once selected, you can specify their Bricks element IDs here (comma-separated).

By default, Bricks displays the value of the active filter as its label. However, you can also customize the label by configuring a Prefix, Suffix, and Title (attribute) on individual filter elements. (See the "Active Filter" tab on each filter element for these options.)

![](imgs/example-prefix-for-active-filters-02-96f37fb7d1.png)

### 2. Filter - Search {#filter-search-element}

- **Function**: Live AJAX search. (Passes the search term to "s" parameter for Post queries or "search" parameter for User and Term queries.)
- **URL parameter**: This will be used to populate the filter URL parameter in the frontend. (@since 1.11)
- **Debounce (ms)**: Control the delay before triggering the search after typing stops. Improving performance by reducing unnecessary search queries.
- **Min. characters**: The minimum number of characters required to trigger a search. Searches will not initiate with fewer characters. The default is 3 characters.
- **Icon (Clear)**: Set an icon so the search value will be clearable by clicking on it. (@since 1.11)

![](imgs/example-filter-search-clear-icon-a1fda949ef.png)

:::note
Tips: To ensure compatibility with the WordPress search function when using the Filter - Search element within a Search template, set the URL parameter to "s". This will allow the filter to work seamlessly with the native WordPress search functionality.
:::

### 3. Filter - Checkbox {#filter-checkbox-element}

- **Filter options**: Taxonomy, Post Fields, Post Meta Fields.
- **Hierarchy display**: Supported.
- **Indent: Prefix/Gap:** Define the prefix or gap for hierarchy display.
- **URL parameter**: This will be used to populate the filter URL parameter in the frontend. (@since 1.11)
- **Terms Order by & Order:** Specify the taxonomy query order parameter. (@since 1.11)
- **Terms (Include/Exclude):** Include/Exclude specific taxonomy terms. (@since 1.11)
- **Top Level Terms Only:** Display only top-level terms (parent = 0) when the source is a taxonomy. (@since 1.11)
- **Hide Count Bracket:** Remove the brackets surrounding the count value. You can style the count by targeting `.brx-option-count`. (@since 1.11)
- **Auto Toggle Child Terms:** If hierarchical option is enabled, this option automatically toggles the check value of child terms when their parent option is clicked. (@since 1.11)
- **Mode:** Option to select “Button” style or traditional “Checkbox” inputs for the filter display. (@since 1.11)

![](imgs/filter-checkbox-1.11-397657097f.png)

### 4. Filter - Datepicker {#filter-datepicker-element}

- **Filter options**: Taxonomy, Post Fields, Post Meta Fields.
- **Enable time**: Adds time selection capability to the date filter.
- **Date range**: Enables selection of a range of dates.
- **Min/max date**: Option to utilize minimum and maximum dates from the index table for filtering.
- **URL parameter**: This will be used to populate the filter URL parameter in the frontend. (@since 1.11)

### 5. Filter - Radio {#filter-radio-element}

- **Filter options**: Taxonomy, Post Fields, Post Meta Fields.
- **Hierarchy display**: Supported.
- **Indent: Prefix/Gap:** Define the prefix or gap for hierarchy display.
- **Action**: Choice between applying a filter or sorting.
- **Mode**: Option to select "Button" style or traditional "Radio" inputs for the filter display.
- **URL parameter**: This will be used to populate the filter URL parameter in the frontend. (@since 1.11)
- **Terms Order by & Order:** Specify the taxonomy query order parameter. (@since 1.11)
- **Terms (Include/Exclude):** Include/Exclude specific taxonomy terms. (@since 1.11)
- **Top Level Terms Only:** Display only top-level terms (parent = 0) when the source is a taxonomy. (@since 1.11)
- **Hide Count Bracket:** Remove the brackets surrounding the count value. You can style the count by targeting `.brx-option-count`. (@since 1.11)

![](imgs/example-style-brx-option-count-552073d516.png)

### 6. Filter - Range {#filter-range-element}

- **Source**: Currently limited to "Custom Field" to specify a meta key (e.g. `_regular_price`, which represents the standard product price in WooCommerce).
- **Automatic min/max**: Automatically sets minimum and maximum values based on the results of the query loop.
- **Mode**: Offers a choice between a "Slider" or "Input" style for the range selection.
- **URL parameter**: This will be used to populate the filter URL parameter in the frontend. (@since 1.11)
- Slider section: More controls to style the "Slider" mode range filter. (@since 1.11)

![](imgs/filter-range-slider-control-section-e6dea6f48f.png)

### 7. Filter - Select {#filter-select-element}

- **Filter options**: Taxonomy, Post Fields, Post Meta Fields.
- **Hierarchy display**: Supported.
- **Indent: Prefix:** Define the prefix for hierarchy display.
- **Action**: Choice between applying a filter or sorting.
- **URL parameter**: This will be used to populate the filter URL parameter in the frontend. (@since 1.11)
- **Terms Order by & Order:** Specify the taxonomy query order parameter. (@since 1.11)
- **Terms (Include/Exclude):** Include/Exclude specific taxonomy terms. (@since 1.11)
- **Top Level Terms Only:** Display only top-level terms (parent = 0) when the source is a taxonomy. (@since 1.11)

### 8. Filter - Submit / Reset {#filter-submit-reset-element}

- **Functionality**: Provides buttons to reset or submit (apply) all filters of the target query.
- **Action: **The button act as a "Submit" or "Reset" button.
- **Hide if No Active Filter:** Enable this option to hide the button when there are no active filters on the target query. Bricks will add the `.brx-no-active-filter` class to this button, allowing you to apply custom CSS for alternative styling. *(Reset action only).* (@since 1.11)
- **Redirect to:** Specify a URL where Bricks will redirect users while preserving all current filter values. This is particularly useful for scenarios like a Live Search on the homepage, where users can be redirected to a dedicated Search page with pre-filtered parameters. *(Submit action only).* (@since 1.11)

![](imgs/filter-submit-controls-1.11-f42fc7b7f5.png)

### 9. Pagination element {#pagination-element}

Select the "Enable AJAX" option on the Pagination element to ensure compatibility with other filter elements.

![](imgs/pagination-filter-enable-ajax-e054a94523.png)



## Dynamic Data Tags {#dynamic-data}

The Query Sort / Filter comes with two new dynamic data tags (`search_term_filter`, `query_results_count_filter`) whose value automatically updates whenever the query results change.

`{search_term_filter:quer34}` - Wraps the search term result in `span data-brx-ls-term="quer34">>`. Updates dynamically with AJAX when the targeted Query ID `quer34` (your element's Query ID) is refreshed.

`{query_results_count_filter:quer34}` - Encloses the query results count in `span data-brx-qr-count="quer34">>`. Dynamically updates in response to AJAX changes in the Query ID `quer34` (your element's Query ID).

#### search_term {#search_term}

The new `search_term` dynamic data tag renders the search term value.

`{search_term}` - Outputs the value of `$_GET['s']` or `get_query_var('s')`, ideal for displaying the current search term on the page.

`{search_term:quer34}` - Retrieves the `search` query variable from the Query ID `quer34`. To find your Query ID, copy the element ID of the query element into your clipboard and use the last six characters, omitting the “#brxe-” prefix.

It is meant to be used on a static search results page. To display the search term value of the `Filter - Search` element, make sure to use the new `search_term_filter` dynamic data tag instead.

#### active_filters_count {#active_filters_count}

Since version 2.0, Bricks introduce a new `{active_filters_count}` tag to dynamically display the number of active filters for a target query. It outputs a `span>` element that updates automatically when filters change.

`{active_filters_count:ehljca}` - Displays the active filter count for the query with ID `ehljca`.

`{active_filters_count:ehljca @exclude:'desplk,mn3p9,88510'}` - Excludes the specified filter element IDs from the count.

You can style the span using:

```php
span[data-brx-af-count] {
  /* Your styles here */
}
```

![](imgs/active-filters-count-example-77ae9844d5.png)

This allows for easy integration into buttons, badges, or other UI components to show the number of active filters visually while the actual filters located inside Offcanvas.

## Live Search {#live-search}

While the "Filter - Search" element connected to a Target Query updates the results immediately, it is meant to be used for search queries that you render on the initial page load, such as your WooCommerce shop page or your blog home page.

You can also create a true live search, whose query results only appear after performing a search using the "Filter - Search" element.

All you need to do is enable the "Is live search" setting inside your target query loop element like this:

![](imgs/bricks-1.9.6-query-control-is-live-search-b555717c3d.png)

Once enabled, this query only runs when a live search is performed.

To hide the query initially (on page load), edit the element that holds your live search results. This is usually the parent element of your query loop or another outer element of your query.

Then, copy its element ID (e.g. `#brxe-dx44gp`), return to your query settings, and paste this element ID from your clipboard into the `Live search results` text input field.

**Live search demo:** [https://youtu.be/5oDHG-bTAfQ?si=ZR61wiAVxFFbjP-c&t=461](https://youtu.be/5oDHG-bTAfQ?si=ZR61wiAVxFFbjP-c&t=461)

## Update Filter Index {#filter-index}

Applicable for checkbox, datepicker, radio, range, and select elements inside the builder. Also available from the WordPress dashboard under `Bricks > Settings > Query filters`.

![](imgs/query-filters-regenerate-continue-index-job-553de7deee.png)

:::note
If the indexing jobs remain pending without any progress, please check [this solution](/builder/setup/known-issues/#query-filter-indexer-no-progress).
:::

Regenerate filter index:

- **Purpose**: Ensures all filter options are up-to-date.
- **Function**: Regenerate indexing job for all filter elements, generate index records and stored in a custom table.

Continue index job: (`@since 1.10`)

- **Purpose**: Immediately run any remaining/queued filter index jobs instead of waiting for the next WP cronjob.
- **Function**: Trigger the indexing jobs and update the progress on settings page.



If your website is protected by HTTP Authentication, the indexing process may get stuck. To prevent this, add the following snippet to your child theme.

```php
add_filter( 'bricks/remote_post', function( $args, $url ) {
  if ( strpos( $url, 'action=bricks_background_index_job' ) === false && strpos( $url, 'action=bricks_system_info_wp_remote_post_test' === false ) ) {
    return $args;
  }

  // Add Basic Auth to the request
  $username = 'XXXX'; // Replace XXXX to your HTTP Auth username
  $password = 'XXXX'; // Replace XXXX to your HTTP Auth password

  $args['headers']['Authorization'] = 'Basic ' . base64_encode( $username . ':' . $password );

  return $args;
}, 10, 2 );
```

## Custom Option Labels {#label}

Applicable for checkbox, radio, and select elements.

- **Use Case**: "Source" is set to "Custom field" or "WordPress field."
- **Example**: Mapping `_stock_status` to a user-friendly label.

![](imgs/bricks-1.9.6-custom-label-mapping-0ce10a13ee.png)



## Filter By URL Parameter {#url-parameters}

Starting with version 1.11, Bricks Query Filters now support filtering based on URL parameters.

A new control, "**URL Parameter**", has been added for the Filter types: Search, Checkbox, Radio, Range, Datepicker, and Select. If you don't define a custom parameter, Bricks will automatically use `brx_{BRICKS_ID}` as the default parameter. For example, a filter with the ID qwe123 would use the URL parameter `brx_qwe123`.

You can assign unique parameters to each filter using the "**URL Parameter**" field. When setting custom parameters, it's recommended to use a unique prefix to prevent conflicts with other plugins or WordPress reserved parameters.

#### What to Expect

- Filter options will be pre-selected or activated if the URL contains the corresponding parameter, such as: `/my-page/?filter-a=230&filter-b[]=3&filter-b[]=5`
- On page load, the query will display the filtered results based on the provided URL parameters.
- As users interact with filter options after the page loads, the URL parameters will dynamically update to reflect the selected filters.
- For [Live Search Queries](#live-search), URL parameters won't be populated. However, you can use a [Filter-Submit](#filter-submit-reset-element) element and define a URL if you wish to pass the current filter values to a specific page or target URL.

## Browser History {#browser-history}

Starting in version 1.11, each filter action will be tracked and added to the browser's history using the **popstate** event. This means users can navigate through their filtering history using the browser’s forward and backward buttons, and the filtered results will be displayed accordingly.

This feature ensures a smoother browsing experience, allowing users to easily revisit previous filter states without losing their progress. As they navigate through the filter history, the query will automatically update to reflect the filters active during that step, providing a more intuitive and user-friendly experience.

## Interactions {#interactions}

In version 1.11, two new interaction triggers —**Filter: Empty** and **Filter: Not Empty**— were introduced. These triggers allow you to dynamically show or hide elements based on whether the associated filters' options or values meet specific conditions.

These triggers are particularly useful for enhancing user experience by adapting the visibility of elements based on the state of filters in real time. You can set interactions on any element, enabling a more dynamic and responsive design without writing custom JavaScript.

Example:
Imagine you have a block containing:

- A heading: **“Active Filters”** text
- An **Active Filters element** that lists the currently applied filters

You want to hide this entire block when no filters are applied.
To achieve this, apply interactions on the block using:

- **Filter: Empty** > **Hide element**
- **Filter: Not Empty** > **Show element**

:::note
In this setup, the triggers are evaluated based on the Active Filters element itself, not the query directly:
- **Filter: Empty** is triggered when the *Active Filters element has no items to display* (i.e. no active filters exist for the target query).
- **Filter: Not Empty** is triggered when the *Active Filters element contains one or more items* (i.e. at least one filter is active).
:::

![](imgs/filter-empty-trigger-with-active-filters-example-4c661c9442.png)

Expected result:

- **Filter: Empty** – The block is hidden when the Active Filters element has no items (no filters applied). Ensuring the page doesn’t show unnecessary UI elements.
- **Filter: Not Empty** – The block is shown when the Active Filters element contains at least one item (filters are active), keeping the heading and filter list visible for the user to interact with.

:::note
For more details on these triggers, see the [Interactions documentation](/builder/features/interactions/#trigger-filter-empty-or-not-empty).
:::



## Custom Fields Integrations {#custom-fields-integration}

Starting with version 1.11.1, Bricks introduced a **Custom Fields Integrations** feature, which you can enable under **Bricks > Settings > Query Filters**. When this setting is turned on, Bricks can retrieve settings from supported custom field providers, allowing it to index field values accurately and generate query parameters for filtering—even for fields stored in serialized format, which wasn’t previously possible.

![](imgs/query-filters-custom-fields-integration-06f997f8d4.png)

In the builder, when the filter source is set to "Custom Field," a new **Provider** dropdown will appear. Select the appropriate provider here, and a **Dynamic Tag** picker will then appear in the "Meta Key" field. Use this picker to select the custom field. From this point on, Bricks will automatically retrieve the field's settings.

:::note
Note: The dynamic tag is not intended to parse dynamic data directly; it simply allows Bricks to access the field settings. Do not use irrelevant dynamic tag here.
:::

![](imgs/query-filters-custom-fields-integration-builder-provider-control-146964e1de.png)

With this feature enabled, Bricks can:

- Automatically retrieve choices set in ACF or Meta Box fields and display them as options in **Filter - Checkbox, Radio, and Select** elements.
- **Filter - Datepicker:** Access ACF and Meta Box date and time formats without requiring manual configuration.
- **ACF Compatibility:** Support fields like Relationship, multiple values fields, and Post Object fields.
- **Meta Box Compatibility:** Support fields such as multiple choices, and Post, Taxonomy, and User fields. Not support Custom Table fields.

Currently, integrations are available for **Advanced Custom Fields (ACF)** and **Meta Box**.



## New Action: "Results Per Page" for Select and Radio Filters {#results-per-page-action}

Introduced in version 1.12.2, the **"Results Per Page"** action is now available for **Filter - Select** and **Filter - Radio** elements. This feature allows users to dynamically adjust the number of results displayed per page in the target query. Supported query types: “Post”, “Term”, and “User”

![](imgs/results-per-page-action-4b8f7462fc.png)

By default, the available options are 10, 20, 50, and 100. However, you can customize these values using the "Options: Results Per Page" control. URL parameter will be generated and supported too like other filter elements.



Example:

![](imgs/results-per-page-action-example-66b0bf250e.png)

:::note
Note: This action does not modify the original query per page setting. When active, it will be displayed in the Active Filters element (if present). If you do not want it to appear, you can exclude it by entering the element ID in the Active Filters element settings.
:::

This enhancement provides greater flexibility, allowing users to refine their search experience by selecting their preferred number of results per page.

## WooCommerce Filter Support (Source) {#woocommerce}

Starting from version 2.0, you can now choose WooCommerce as a Filter Source if WooCommerce is installed on your website.

Once selected, each filter element will display additional WooCommerce-specific options depending on the filter element and action mode.

![](imgs/woocommerce-filter-source-94ed823ffa.png)

![](imgs/woocommerce-sort-source-b81b494324.png)

|  | Filter - Radio, Filter - Select | Filter - Checkbox | Filter - Range |
| --- | --- | --- | --- |
| On Sale | ✔️ | ✔️ |  |
| In Stock | ✔️ | ✔️ |  |
| Featured Products | ✔️ | ✔️ |  |
| Product Type | ✔️ | ✔️ |  |
| Rating | ✔️ |  |  |
| Price |  |  | ✔️ |
| (Sort) Price | ✔️ |  |  |
| (Sort) Rating | ✔️ |  |  |

![](imgs/frontend-example-woo-filters-f364de8a8e.png)

These filters make it easier to create intuitive product filtering experiences for WooCommerce stores without custom coding. Let customers narrow down product listings using stock status, pricing, rating, and more—all fully integrated with Bricks Query Filters. (**Note: Filter by Rating in Radio or Select elements is text-based only.**)

---


## Query Loop

*來源網址：https://academy-preview.bricksbuilder.io/builder/dynamic-content/query-loop/*

https://www.youtube.com/watch?v=LxrLROitgn8

The **Query Loop** builder is available for all [layout elements](/builder/styling/layout/), Accordion, and Slider elements.

It can also be enabled for the Accordion (Nestable), Tabs (Nestable), and Slider (Nestable).

It lets you query your database (according to your query parameters) and renders the query results you want to show inside the loop (dynamic data).

You can query post types, taxonomy terms, and users. Some typical use cases are:

- **Posts**: Latest posts, related posts (works for any registered & public post type)
- **Terms**: Post categories & tags, product categories, etc.
- **Users**: List blog authors, community members, and team members

## Important {#important}

Bricks Query Loop automatically generates `!--brx-loop-xxxxx-->` HTML comments on the frontend. These comments are essential for features like AJAX Pagination, Query Filters, Load More, and Infinite Scroll to function correctly.

:::note
**Do not remove these comments**, as doing so may cause these features to stop working.
:::

Some **performance optimization plugins** may remove all HTML comments by default. If you are using such a plugin, ensure that Bricks-generated comments are preserved to avoid breaking dynamic query functionality.

## How to create a query loop {#custom-loop}

Add a "Container" element to the canvas. Enable the **Use Query Loop** setting to turn your container into a loop (repeater) item.



![](imgs/container-query-loop-control-4cca4e2617.png)

<figcaption>

Container element: new query loop control

</figcaption>



Once you've enabled the **Use Query Loop** setting, you'll see a **Query** control (loop/infinity icon).

Open the query control to set the query parameters for retrieving the content from your database.

This container now serves as your repeater item. All elements inside this container are repeated as often as there are query results.

## Query control {#query-control}

The **Query** control supports three different object types: `posts`, `terms`, and `users`.

![](imgs/query-control-object-type-d6a9a73db0.png)

- **Posts** enable a [WP_Query](https://developer.wordpress.org/reference/classes/wp_query/) type of query. This is the default query type and should be used when you want to display a loop of posts, pages, media files, or custom post types.
- **Terms** enable the [WP_Term_Query](https://developer.wordpress.org/reference/classes/wp_term_query/). This should be used when you want to loop through the different terms of a taxonomy. Useful to list all the product categories that contain products.
- **Users** enable the [WP_User_Query](https://developer.wordpress.org/reference/classes/WP_User_Query/). This should be used when you want to loop through a set of site users. Useful to list the blog authors or a list of team members (as long as they are inserted as site users).

The query controls adapt according to the selected query type.

## Query editor (PHP) {#query-editor}

Bricks 1.9.1 introduces a new `Query editor` control that lets you write your own queries in PHP for maximum flexibility and querying capabilities.

The query editor appears after enabling the "Query editor (PHP)" control.

:::note
Note: You must enable code execution in [Bricks settings](/getting-started/misc/settings/) to access this feature.
:::



![](imgs/bricks-1.9.1-query-editor-php-5faf64bc0c.png)

<figcaption>

Custom query using dynamic data (ACF) for the post type, returning all posts for September 2023.

</figcaption>



You have to **return a PHP array** containing the [WordPress query arguments](https://developer.wordpress.org/reference/classes/wp_query/#parameters) you'd like to use for your query.

As shown in the screenshot above, the query editor supports dynamic data.

## Posts query {#posts-query}

![](imgs/post-query-1-6-3-1667846e99.png)

**Post type**: Select one or multiple post types (default: posts)

**Order by**: Order the results by post ID, author, title, published or modified date, comment count, relevance, menu order, or random (default: published date). (Support multiple values `@since 1.11.1`)

**Order**: Ascending or Descending (default). (Support multiple values `@since 1.11.1`)

**Posts Per Page**: The number of posts to show per page (default: WordPress settings → Reading → Blog pages show at most)

**Offset**: The number of posts to skip.

**Ignore Sticky Posts**: Turn this on if do not want to move sticky posts to the start of the set.

**Disable Query Merge**: Turn this on if do not want the query to be auto-merged by Bricks in archive pages, search pages, etc. Usually, you will turn this on for the Query loops in the footer, header, or non-main query. This is the GUI for the [bricks/posts/merge_query](/developer/hooks/filters/filter-bricks-posts-merge_query/) filter.

**Child Of**: Set the parent ID to return all its children only. (`post_parent` in WP_Query)

**Include/Exclude**: If you want to include or exclude one or multiple posts from the query. You can use [dynamic tag](#use-dynamic-tag-on-post-query-include-control) on this control too (`@since 1.12`)

**Exclude Current Post**: If enabled it will exclude the current post from the loop (useful to build a "related posts" section)

**Terms Include/Exclude**: Include or Exclude posts that have one or multiple terms.

**Taxonomy Query**: Add one or multiple taxonomy queries to filter the posts.

**Tax Query Relation**: Define if the taxonomy queries should be inclusive (OR) or exclusive (AND).

**Meta Query**: Add one or multiple meta queries to filter the posts based on the custom fields.

**Relation**: Define if the meta queries should be inclusive (OR) or exclusive (AND).

**Random seed TTL**: Duration in minutes for which the random seed exists. Set to prevent duplicate post results (only needed & available when using a random order query loop).  Set "0" to turn this feature off.

If you set the TTL to 10 minutes, the query result remains the same for the next 10 minutes. This ensures that no duplicate posts are displayed on different pages or when the infinite scroll is active. (`@since 1.7.1`)

**Is main query (Archive, Search)**: When creating an archive or search template, choose one of the loops as the main query. This will prevent a 404 error from occurring when visitors navigate to different pages. Turn on to designate the main query. Remember to set the correct query on your pagination element as well.

However, do not turn on this option for multiple queries on the same page, as only the first one will be set as the archive main query. `(@since 1.8)`

### Enhanced Ordering Options {#enhanced-ordering-options}

Starting with version 1.11.1, the **Order By** and **Order** settings in Bricks Query Loop have been improved to support multiple ordering criteria. This allows you to define complex ordering rules directly within Bricks, eliminating the need for a custom PHP filter that was previously required.

![](imgs/enhanced-query-loop-order-by-example-1-82acf0fb2e.png)

This update is particularly useful in scenarios where you want to order query results by more than one criterion. For example, you can now order by **name** in descending order and then by **ID** in descending order. Bricks will process these criteria sequentially, applying each in the order specified to deliver the desired result.

**Example Scenarios:**

- **Multi-Criteria Ordering**: Suppose you have a directory listing and want to display results by popularity first (custom field) and then by date added. With this update, you can set the query to order first by the popularity meta field in descending order and then by date added in ascending order, ensuring that the most popular and newest items appear at the top.
- **Custom Order Clauses with Meta Queries**: Bricks now supports more complex ordering directly aligned with meta query conditions. For instance, if you’re working with a meta query to order posts by **performance date** and **time**, you can define this directly in the order clause. Code example in [this article](/developer/hooks/filters/filter-bricks-posts-query_vars/#orderby-with-multiple-fields).

![](imgs/enhanced-query-loop-order-by-example-2-3473e6b92f.png)

### Best Practice for Pagination & Order By {#best-practice-for-pagination-and-order-by}

When using multiple ordering criteria, it’s recommended to always include **ID** as the second ordering criterion to avoid duplicate results across paginated pages. For example, if you’re displaying 5 posts per page and have 15 posts with the same **price**, simply ordering by **price** may cause posts to appear on multiple pages. To avoid this, set the query to order by **price** in ascending or descending order, followed by **ID** in ascending or descending order. This ensures consistent results and resolves potential duplication issues in pagination.

### Example 1: Latest Posts

In this example, we'll list the latest four posts (each item shows the featured image, post title, and excerpt) using the Query Loop Builder.



![Custom Query Loop Builder - latest posts](imgs/container-loop-latest-posts-1024x399-cfb6193032.png)

<figcaption>

Display the latest posts using a custom query loop

</figcaption>



We start by adding a container to the canvas. This container holds our loop and serves as the blueprint for each query item.

Next, we enable the "**Use Query Loop**" setting to turn our simple container into a query loop.

We add an image element inside our container and set it to "Featured Image" using the Dynamic Data dropdown.

Add another container with a Heading and Text element in the same container.

For the Heading element, we add the `{post_title}` tag.

For the Text element, we add `{post_excerpt}` tag.

You could use the Post Title element or the Post Excerpt element instead if you like.

By default, the query control shows the latest posts. But because we want to restrict the number of posts shown, we need to edit the Query setting and set the Posts Per Page control to 4 to restrict the output to four rows.

## Media query {#media-query}

Bricks 1.5 introduces the possibility to query for media files (the attachment post type). You'll now find the `Media` (attachment) post type in the Posts query type.

After selecting `Media` in the post type control, you'll get a new control to define the mime type. By default, Bricks automatically queries for images, but you may define other mime types (separated by a comma, e.g., *image/jpeg,image/png,image/gif*).

To query for the images attached to a post, you may use the **Child of** control to specify the post ID. To do it dynamically, you may use dynamic data to fetch the current post id: `{post_id}`.

![](imgs/bricks-media-query-loop-settings-a70ece8a34.png)

### Example 2: Media gallery

The media query opens the possibility of building a custom media gallery using the Query Loop builder. To start, you need to add a Container element, insert a Block element inside it, and finally, an image element inside of the Block.

In the container, you'll set the flex-wrap to `wrap` and the direction to horizontal (row). In the Block, you must activate the Query Loop and set the Media post type and the number of images you'll want to get (posts per page). In the Block layout, you must set the width and the height (e.g. 300px).

In the Image, you'll set the dynamic data as `{post_id}` - note that the query returns the attachment posts (media files), so the image ID is the post ID. To complete the layout, set the image object-fit to `cover` and the height to 300px.



![](imgs/bricks-media-query-loop-1024x618-f796ba55b8.jpg)

<figcaption>

The final result of a media gallery using the Query Loop builder

</figcaption>



## WooCommerce Products Query {#woocommerce}

Since 1.10, Bricks introduced new settings for WooCommerce products query. Once selected Products post type, you will be able to see the WooCommerce section. (Only available if WooCommerce is activated)

### Example 1: WooCommerce Featured Products {#example-woocommerce-featured-products}

To show latest 10 featured products on your homepage, just set a query loop with below settings.

![](imgs/woo-featured-products-query-settings-174ed48751.png)

### Example 2: WooCommerce Related Products {#example-woocommerce-related-products}

To show 4 related products on your single product template.

![](imgs/woo-related-products-query-settings-5f6853ebee.png)

### Example 3: WooCommerce Upsells Products {#example-woocommerce-upsells-products}

To show 3 upsells product in  a single product template.

![](imgs/woo-upsell-products-query-d94f0b1ae5.png)

## Terms query {#terms-query}

![](imgs/bricks-query-control-terms-341x1024-506fe4e353.png)

**Taxonomies**: Select one or multiple taxonomies to query (default: none).

**Order by**: Order the results by term ID, term name, term parent, count, or include list.

**Order**: Ascending (default) or Descending.

**Number**: The number of terms to show per page. WordPress default is all, but Bricks defaults to the number defined in the WordPress settings → Reading → Blog pages show at most. Use 0 to display all the results.

**Offset**: The number of terms to skip.

**Parent**: Parent term ID to retrieve direct-child terms. Set this to 0 to fetch only the terms that have children. Ex.: Given this structure, entering 55 would get only the T-shirts.

**Child of**: Term ID to retrieve child terms of.  Ex.: Given [this](https://academy.bricksbuilder.io/wp-content/uploads/2022/07/sample-terms-structure.png) structure, entering 55 would get T-shirts and Tees.

**Childless**: (bool) True to limit results to terms with no children. This parameter has no effect on non-hierarchical taxonomies. Default false.

**Disable Query Merge**: Turn this on if do not want the query to be auto-merged by Bricks. (@since 1.7.1)

**Terms Include/Exclude**: Include or Exclude terms from the query

**Show empty**: Whether to show terms not assigned to any posts.

**Meta Query**: Add one or multiple meta queries to filter the posts based on the custom fields.

**Relation**: Define if the meta queries should be inclusive (OR) or exclusive (AND).

**No Results**: Text to be shown when there are no matching results.

<span id="current-post-term"></span>

**Current post term**: Enable to get the terms assigned to the current post only. `(@since 1.8.4)` Only use in single post context. Only visible if "Type" is set to "Term". This is the same logic as the example in [bricks/terms/query_vars](/developer/hooks/filters/filter-bricks-terms-query_vars/#get-terms-assigned-to-a-post)

![](imgs/term-query-current-post-term-a31533ec77.png)

### Example 3: Product categories {#example-2}

In this example, we'll build a dynamic list of product categories (product category image + a link to the category archive).

The example is based on the WooCommerce plugin and the sample products. We'll need one container to hold the container loop. Inside the container loop, we've added a Basic Text element that contains the Dynamic Data `{term_name}` tag.



![](imgs/bricks-query-loop-terms-1024x499-a7a9ef477d.png)

<figcaption>

Display the product categories with a link

</figcaption>



After setting the Query to loop through "terms" and selecting the Taxonomy "Product Categories", you'll get in the canvas as many containers as the existing categories. Inside the loop, you'll be able to use several dynamic data tags to fetch the term's data, such as the term ID, the term name, the term archive URL, the term description, and any term meta.

In this example, we set the loop container background image as the product category thumbnail, using the Dynamic Data dropdown and selecting the Product Category Image tag:



![](imgs/bricks-query-terms-bg-image-332c0558a6.png)

<figcaption>

Set the container background image

</figcaption>



We also set the loop container as a link to the product category archive page (using the Term Archive URL dynamic data tag). You'll need to set the HTML tag to "a (link)" and the link type to Dynamic Data, which will enable the Dynamic Data dropdown:

![](imgs/bricks-query-terms-link-1-58cdbd869a.png)

## Users query {#users-query}

![](imgs/bricks-query-control-users-93e8272579.png)

**Roles**: Select one or multiple user roles to query (default: any)

**Order by**: Order the results by user ID, name, username, nicename, login, email, registered date, post count, or include list.

**Order**: Ascending (default) or Descending.

**Number**: The number of users to show per page. WordPress defaults to all, but Bricks defaults to the number defined in the WordPress settings > Reading > Blog pages show at most. Use -1 to display all the results.

**Offset**: The number of users to skip.

**Current post author:** Enable to query the current post author (@since 1.9.1)

**Disable Query Merge**: Turn this on if do not want the query to be auto-merged by Bricks. (@since 1.7.1)

**Meta Query**: Add one or multiple meta queries to filter the posts based on the custom fields.

**Relation**: Define if the meta queries should be inclusive (OR) or exclusive (AND).

**No Results**: Text to be shown when there are no matching results.

### Example 4: The blog authors {#example-3}

In this example, we want to build a section to list all the blog authors.

The blog authors are website users with the role of author. As in the other examples, we've used a container to loop through the users. In that container, we've set a query of user type, setting roles to "Author" to pull only the website's authors.

We've added an Image and a Basic Text element inside the query loop container.

The image we've set to display an ACF Dynamic Data field containing the profile image.

In the Basic Text, we've used the Dynamic Data `{wp_user_display_name}` tag.



![](imgs/bricks-query-loop-users-1024x467-7ed97d40cb.png)

<figcaption>

Display the blog authors

</figcaption>



## The Pagination element {#pagination}

The perfect companion to the custom query loop builder. You'll find the Pagination element under the **WordPress** group of the elements panel.

![](imgs/bricks-pagination-element-ee27f8cd0f.png)

Having pagination as a separate element offers you the most flexibility to build any layout.

After adding the Pagination element to the canvas, you'll need to link this pagination element to one of the elements that run a query. To do so, please select the element in the **Related Query** control by editing the Pagination element:

![](imgs/bricks-pagination-related-query-46c513614a.png)

Tip: to make it easier to recognize elements, give descriptive element names to the containers that have a query enabled.

## Load more (button) {#load-more}

Besides the infinite scroll, which automatically loads more results as you scroll down the page, you can also give any element (typically the Button) a "Load more" functionality by adding a "Load more" click [interaction](/builder/features/interactions/) to it like this:

![](imgs/bricks-query-loop-load-more-button-scaled-e0ce185ba9.jpg)

## Query loop in Accordions & Sliders {#query-accordions-or-sliders}

The Accordion & Slider elements also allow to pull data dynamically through the Query Loop to feed the element parts.

You'll find a Query Loop control in the Accordion element to configure a query. The query results create as many accordion items as the query results.

You'll be able to configure the accordion title, subtitle, and content of the "master" accordion item, and this will be used as a template for the dynamic accordion items:



![](imgs/bricks-query-loop-accordion-e6a2cf3154.png)

<figcaption>

Use the query loop in the accordion element

</figcaption>



The same happens in the Slider element. If the Query Loop is enabled, you'll have access to a Query control and a slide item, which will behave as the template for all the slides.



![](imgs/bricks-query-control-slider-dedc7a717d.png)

<figcaption>

Use the query loop in the slider element.

</figcaption>



## Include/Exclude Controls: Dynamic data tag support {#include-exclude-dynamic-data}

Starting at version 1.12, Bricks supports dynamic data tags in the "Include" and "Exclude" query loop controls.

This allows you to include or exclude posts dynamically using field values, such as those retrieved from ACF or Meta Box relationship fields.

- **Include**: Adds IDs to the `post__in` parameter.
- **Exclude**: Adds IDs to the `post__not_in` parameter.

![](imgs/query-loop-include-supports-dynamic-values-4e67a05cfe.png)

This enhancement enables you to use dynamic data to retrieve post IDs from custom fields (e.g., ACF or Meta Box), while still combining additional query parameters like **meta queries** or **taxonomy queries**.

#### Supported Field Types

- **ACF: ** Relationship, Post Object, Gallery
- **Meta Box:** Relationship, Post, Image Advanced, Image, Image Upload, Single Image
- **JetEngine:** Relationship, Post, Gallery, Media (`@since 2.2`)

:::note
Important: When using dynamic data in the Include field, ensure the selected Post Type matches the field values. For example, if you are using a Gallery field, set the Post Type to Media to ensure the dynamic value aligns correctly.
:::

### Example 1: Retrieve ACF Relationship Posts by Post Type and Order by Post IDs {#filter-acf-relationship-by-post-type}

Imagine you have an ACF Relationship field that connects to multiple post types. On a specific query, you only want to retrieve the related posts limited to the "Book" post type and have them displayed in the same order as defined in the relationship field.

![](imgs/query-loop-include-supports-dynamic-values-example-1-746411d716.png)



### Example 2: Use Meta Box Image Advanced Field for a Nestable Slider Query Loop {#query-loop-for-metabox-image-field}

Previously, retrieving images saved in the **Meta Box Image Advanced** field required using a PHP filter to pass the image IDs into the `post__in` parameter. Now, you can achieve this directly within the Query Loop UI.

Simply choose your dynamic field, set the **Post Type** to **Media** and, if needed, add an additional **Mime Type** filter to ensure only the correct image types are included.

:::note
Note: Inside the loop, use dynamic tags like `{post_id}` for the image source and `{post_title}` to retrieve the image title. Avoid using `{featured_image}`, as this is not applicable in this context.
:::

![](imgs/query-loop-include-supports-dynamic-values-example-2-a925ae18cf.png)

### Example 3: Query ACF Gallery with Random Order {#query-acf-gallery-with-random-order}

To display images from an **ACF Gallery** field in a random order, set the Post Type to **Media**. (Add an additional Mime Type filter if necessary to ensure only specific file types are included.) Select **Random (rand)** to randomize the order of the images in the gallery.

:::note
Note: Inside the loop, use dynamic tags like `{post_id}` for the image source and `{post_title}` to retrieve the image title. Avoid using `{featured_image}`, as this is not applicable in this context.
:::

![](imgs/query-loop-include-supports-dynamic-values-example-3-2c0adf05e1.png)

![](imgs/query-loop-include-supports-dynamic-values-example-3-result-7c26e763ca.png)

## Query Type: Array {#array}

The **Array** query loop type lets you loop through any PHP or JSON array. (`@since 2.2`)

This is especially useful for:

- Rendering API response arrays. ([API query](/builder/dynamic-content/query-data-from-apis/) loop)
- Combining data from multiple sources (e.g. posts + custom arrays).
- Displaying values returned by custom functions in loop format.

![](imgs/query-array-control-f04d8d1838.png)



Once configured, the loop behaves like any other Bricks query: you can style each item using the builder, use dynamic tags to access values, and even enable pagination features.

*Supported features: AJAX/non-AJAX pagination, Load More, Infinite Scroll*

#### Use Case 1: Looping Nested Arrays from API Responses

If your API response contains nested arrays (e.g. `cars: ['BMW', 'Mazda']`), you can easily loop through them by using a **nested array loop** and setting the correct path in the Array Editor.

![](imgs/query-array-nested-loop-with-dynamic-tag-f25545e398.png)



#### Use Case 2: Looping Custom PHP Arrays

If you have a custom PHP function that returns an array, you can use it in the loop using a dynamic tag like `{echo:my_custom_array()}`.

```php
// Ensure that my_custom_array is whitelisted via the bricks/code/echo_function_names hook
function my_custom_array() {
  return [
    ['name' => 'John', 'age' => 30],
    ['name' => 'Jane', 'age' => 25],
  ];
}
```

### Dynamic Data Tag: `{query_array:raw}`

`{query_array:raw}` - Output the current array value (array items are a simple list of strings).

`{query_array:raw @key:'age'}` - Output a specific key from the array item.

#### Example 1: Flat List

```php
[
  'Apple',
  'Banana',
  'Cherry',
  'Donut'
]
```

Use `{query_array:raw}` inside the loop to display each fruit name.

#### Example 2: Associative Array

```php
[
  ['name' => 'John', 'age' => 30],
  ['name' => 'Alan', 'age' => 25],
  ['name' => 'Pony', 'age' => 66]
]
```

Use `{query_array:raw @key:'name'}` and `{query_array:raw @key:'age'}`

#### Example 3: Nested Arrays

```php
[
  {
    "name": "John",
    "age": 30,
    "cars": ["Ford", "BMW", "Fiat"]
  },
  {
    "name": "Elbert",
    "age": 66,
    "cars": ["Mazda", "Benz"]
  }
]
```

To loop through each `cars` array inside the main loop:

1. Nest another **Array Loop** inside the parent loop.
2. In the nested loop’s **Array Editor**, set: `{query_array:raw @key:'cars'}`
3. Use `{query_array:raw}` inside the nested loop to output each car.

---

## Results Filter {#results-filter}

The **“Results Filter”** feature allows you to filter loop results using conditions **after the array is fetched but before rendering begins** (similar to the [bricks/query/result](/developer/hooks/filters/filter-bricks-query-result/) PHP filter). (`@since 2.2`)

**Supported Loop Types:** Array, ACF Repeater

Use this feature to:

- Remove unnecessary or invalid results based on your requirement
- Prevent rendering of unwanted loop

![](imgs/results-filter-control-2133dfab01.png)



#### Example: Filter by Age

Imagine this is the array passed to the Array loop:

```php
[
  ['name' => 'John', 'age' => 30],
  ['name' => 'Alan', 'age' => 25],
  ['name' => 'Pony', 'age' => 66]
]

```

You only want to display people whose **age is less than 50**. You can configure a result filter like this:

| Field | Operator | Value |
| --- | --- | --- |
| `{query_array:raw @key:'age'}` | `<` | `50` |

This filter will exclude the last item (`Pony`, age 66) from rendering, so only `John` and `Alan` will appear in the loop output.

:::note
You can add multiple filter rules if needed—each rule will be evaluated with `AND` logic. Use `bricks/query/result` hook for more complex filtering.
:::

## Query loop hooks {#hooks}

- [bricks/query/run](/developer/hooks/filters/filter-bricks-query-run/) (filter)
- [bricks/terms/query_vars](/developer/hooks/filters/filter-bricks-terms-query_vars/) (filter)
- [bricks/users/query_vars](/developer/hooks/filters/filter-bricks-users-query_vars/) (filter)
- [bricks/posts/merge_query](/developer/hooks/filters/filter-bricks-posts-merge_query/) (filter)
- [bricks/posts/query_vars](/developer/hooks/filters/filter-bricks-posts-query_vars/) (filter)
- [bricks/query/loop_object](/developer/hooks/filters/filter-bricks-query-loop_object/) (filter)
- [bricks/query/loop_object_id](/developer/hooks/filters/filter-bricks-query-loop_object_id/) (filter)
- [bricks/query/loop_object_type](/developer/hooks/filters/filter-bricks-query-loop_object_type/) (filter)
- [bricks/query/no_results_content](/developer/hooks/filters/filter-bricks-query-no_results_content/) (filter)
- [bricks/query/before_loop](/developer/hooks/actions/action-bricks-query-before_loop/) (action)
- [bricks/query/after_loop](/developer/hooks/actions/action-bricks-query-after_loop/) (action)
- [bricks/query/result](/developer/hooks/filters/filter-bricks-query-result/) (filter)
- [bricks/query/result_count](/developer/hooks/filters/filter-bricks-query-result_count/) (filter)
- [bricks/query/result_max_num_pages](/developer/hooks/filters/filter-bricks-query-result_max_num_pages/) (filter)
- [bricks/query/init_loop_index](/developer/hooks/filters/filter-bricks-query-init_loop_index/) (filter)

---


## Accessibility

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/accessibility/*

Accessibility (short: **a11y**), is the fine art of making your website as usable as possible by as many people as possible.

No matter your drive to improve the accessibility of your website, making your website as inclusive as possible is the most ethical approach and will benefit your business in the long term.

According to the [WHO](https://www.who.int/disabilities/world_report/2011/report.pdf) around 15% of the world’s population has some sort of disability. Your time is better invested in improving your site accessibility than optimizing it for IE (which has only 2% global usage). In some countries, this is a legal requirement.

## How Bricks Helps To Address Accessibility

Bricks provides the tools for you to generate the most semantic HTML possible and approach a11y requirements & best practices without the need to code.

Making sure the content is understandable by the majority of your site's target visitors. The [HTML is valid](https://validator.w3.org/nu/) with an appropriate semantic structure. Links and buttons are descriptive enough. Images have relevant `alt` descriptions, etc. Just to mention some of the relevant aspects of **a11y**.

## ARIA landmarks

Bricks, by default, creates three different [landmark regions](https://www.w3.org/TR/wai-aria-practices/examples/landmarks/HTML5.html) for you: Header, Main, and Footer.

Bricks elements use the most semantic tags whenever possible. For example, the **Form** element and the **Nav Menu** element use the correct HTML tag: `form` and `nav`, respectively. If you need to add more landmarks to your page, or any other semantic tag, you may do it using the Container element, selecting the **HTML tag** needed. You can specify a custom HTML tag, too.

![Select a semantic HTML tag to a container.](imgs/container-landmark-tags-daa8c4de0f.jpg)

Bricks 1.3 also introduces [Custom Attributes](/builder/features/custom-attributes/). Those allow you to add other attributes to any Bricks element.

A common example: If you want to assign the **role** attribute to a container, to go "Style > Attributes", add a new attribute by clicking the "+" icon, and set the "Name" to "role" and the "Value" to the appropriate value:

![Add custom attributes to a Bricks element](imgs/custom-attributes-f7a2b88a85.jpg)

## Images

Images in Bricks are rendered using the alternative text provided in the image media attributes (WordPress Media). The `alt` attribute is the place where site owners should provide a description of the image for people that are not able to view it. Bricks will also allow you to provide a custom `alt` attribute if you are using the Image element inside the builder.

For background images, when needed, Bricks automatically adds `role="img" aria-label="{image alt description}"` to the div that displays the image on the background. The description of the image is the content got from the image `alt` attribute defined on the WordPress media.

## Links

Set `aria-label` (and `title`) attributes to links using the builder if the link description is empty or not clear enough. These attributes will improve how assistive technology like screen readers interpret your website and should be used to provide better context to the link in case the link content is not semantic enough.

It is also important to mention that it is a good practice to avoid using links with terms like "Read more" or "Click here" as these labels do not provide any context to the visitors. If you still want to use these terms, make sure your links contain the `aria-label` attribute to provide context to the navigation.

## Forms

The Form element lets you add or remove field labels. Field labels are important to comply with a11y guidelines as they provide a description of what is expected to be input in each field. If you prefer to not present field labels, Bricks automatically adds the `aria-label` attribute to the field input using the label defined for each field in the builder.

## Keyboard navigation

One of the main a11y requirements is to make sure your website can be operated/navigated using the keyboard only.  Assuring good keyboard navigation not only will allow people that cannot use a mouse to navigate through your website but also people using other assistive technologies.

One of the key aspects of keyboard navigation is to have a visual hint of where the focus is. Bricks 1.3 introduces default CSS to style the `:focus` property.

You can set your own focus style under "Settings > Theme Styles > Typography > Focus Outline". Although not recommended, if you want to remove this focus outline default, simply set it to "none".

### Skip navigation links

When using the keyboard navigation it can be frustrating having to navigate through all the menu links before arriving at the page's main content. To overcome this, one of the best practices, together with semantic ARIA landmarks (as described above), is to insert links on the top of the page to bypass the navigation.

Bricks 1.3 introduces two skip links by default: one to skip to the content and another to skip to the footer (if the footer exists). These skip links are added automatically to your website and will only appear if you press the TAB key on your keyboard.

### Menus

One of the most used elements in websites is the navigation menu. This element makes the website content more approachable to everyone and therefore deserves special attention to allow people without a mouse to also be able to navigate and open links inside menus.

Bricks also covers this need. All menus generated by Bricks are wrapped inside a `` tag and are fully keyboard-accessible according to the typical behavior of the keys when the focus is inside a menu element:

- TAB: Selects the next menu item
- SHIFT TAB: Select the previous menu item
- ENTER: Follows the link (similar to click)
- SPACE: Toggles the submenu (if exists)

Bricks implements the keyboard menu navigation using the [fly-out menu](https://www.w3.org/WAI/tutorials/menus/flyout/) approach.

:::note
As accessibility requirements and best practices evolve, so does Bricks. If you spot any potential accessibility improvements, [please let us know](https://bricksbuilder.io/contact/).
:::

---


## How to add a custom animation in interaction

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/add-custom-animation-to-interaction/*

## Step 1: Add a new option via bricks/setup/control_options hook

Hook documentation: [/developer/hooks/filters/filter-bricks-setup-control_options/](/developer/hooks/filters/filter-bricks-setup-control_options/)

```php
add_filter( 'bricks/setup/control_options', function( $options ) {
  // Add custom animation into animationTypes
  // Note that the key is very important, must be unique
  $options['animationTypes']['myAnim1'] = esc_html__( 'My animation 1', 'bricks' );

  return $options;
}, 10 );
```

![](imgs/custom-animation-added-6e67f5d597.png)

Custom animation added to the interaction "Animation" dropdown

## Step 2: Add animation CSS

When the interaction is set, Bricks will assign a class to the element using your animation key (`myAnim1` in our example), and it will be prefixed with `brx-animate-`.

All you have to do is create a CSS class that sets the animation name for your element, along with the corresponding keyframes for your animation. You can place these CSS inside `Bricks > Settings > Custom Code > Custom CSS`.

![](imgs/custom-css-code-for-animation-b473556e0b.png)

```php
.brx-animate-myAnim1 {
  animation-name: my-anim-1;
}

@keyframes my-anim-1 {
  0% {
    animation-timing-function: ease-in;
    opacity: 0;
    transform: translateY(-250px);
  }
  38% {
    animation-timing-function: ease-out;
    opacity: 1;
    transform: translateY(0);
  }
  55% {
    animation-timing-function: ease-in;
    transform: translateY(-65px);
  }
  72% {
    animation-timing-function: ease-out;
    transform: translateY(0);
  }
  81% {
    animation-timing-function: ease-in;
    transform: translateY(-28px);
  }
  90% {
    animation-timing-function: ease-out;
    transform: translateY(0);
  }
  95% {
    animation-timing-function: ease-in;
    transform: translateY(-8px);
  }
  100% {
    animation-timing-function: ease-out;
    transform: translateY(0);
  }
}
```

Now, you can use this new animation on any element from the "Interactions" panel.

---


## An Intro To Templates

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/an-intro-to-templates/*

Templates are a central feature of Bricks. There are different template types. At the very least, you usually create a header, footer, and blog post template.

A template can contain a single section (your website header, a hero section, etc.) or the entire page content (a single blog post layout, archive pages, search results page, error page, etc.).

You can create your own templates or browse dozens of pre-designed templates from the [Template Library](/builder/features/template-library/) by clicking the Templates (folder) icon in the builder toolbar.

Add a screenshot for your template by setting the featured image.

https://youtu.be/AALkqzu-aBA

## Pre-Designed Community Templates {#community-templates}

Browse our ever-growing collection of pre-designed templates right from within the builder.

Access the Community Templates by clicking the "folder" icon in the builder's top toolbar. Then, under "Source," select "Community Templates". You'll now see a list of all pre-designed templates:

![](imgs/bricks-builder-community-templates-6ed3b8e26f.jpg)

Insert the template of your choice with a single click and tweak it from there. All community template images are royalty-free and can be used in your and your client's projects.

:::note
**TIP:** When you start with Bricks, inspecting a template is a great way to learn how a certain layout is structured.
:::

## My Templates {#my-templates}

You can view, create, import, and export your own templates by clicking the Templates (folder) icon in the builder toolbar or directly from the WordPress dashboard:



![](imgs/docs-my-templates-wp-dashboard-1024x861-032d54ff9a.png)

<figcaption>

My Templates in WordPress Dashboard

</figcaption>



This also provides a great overview of where on your site a template appears (**Template Conditions**), the **Template Type**, plus any template metadata you've added (**Templates Bundle**, **Template Tags**) to better organize your templates.

Let's quickly go over those template-specific terms:

## Template Conditions {#template-conditions}

Template conditions determine where on your site a template appears.

For example, an **Archive** template will be used on all author and date archive pages (see screenshot below). The **Single Blog Post** template is responsible for all your posts. Both are set as such via template conditions.

If no template condition is set, Bricks will use published templates of certain Template Type, such as header and footer templates on the front end of your website.

View the table below to see which [Template Types](#template-types) are picked up by default.

To set template conditions for the template you are editing, click the **Settings** (gear) icon in the builder toolbar, then go to **Template Settings → Template Conditions**:



![](imgs/docs-template-conditions-builder-1024x782-2590897481.png)

<figcaption>

Template Conditions are located under Settings > Template Settings

</figcaption>



:::note
**TIP:** To disable the use of default templates, go to **Bricks → Settings** and select the **Disable Default Templates** setting.
:::

### Inject Section templates via hooks {#hook}

Want to render a template at a specific WordPress hook? Starting at Bricks 1.9.1, you can inject any template of type "Section" via any WordPress hook.

All you need to do when editing your section template is to select your template condition (i.e., the entire website) and enter the WordPress action hook name under "**Hook: Name**". Your section template will now be rendered wherever this action hook is triggered.

You can optionally also set a "**Hook: Priority**" (default is 10).



![](imgs/bricks-1.9.2-section-template-condition-hook-name-edc9481c68.png)

<figcaption>

Section template rendered at the `bricks_before_header` hook

</figcaption>



:::note
Templates with action hook set will only be injected on the actual frontend.
:::

## Template Types {#template-types}

Setting a template type is required for any template.

Assigning the most suitable template type helps you easily filter large template libraries, and it allows Bricks to determine if a certain template should be shown on the front end of your website in case no conditions are set. This is if you haven't disabled this option as described in the tip above.

| **Template Type** | **Description** | **Used By Default** |
| --- | --- | --- |
| **Header** | Set for any template that contains your website header (logo, nav menu, etc.) | Yes |
| **Footer** | Set for any template that contains your website footer (copyright info, footer nav menu, etc.) | Yes |
| **Single** | Set for any template that contains the main content. Such as a single blog post template. | No (it's unique) |
| **Single product** | Set for any template that contains the main content of the WooCommerce product. | No (it's unique) |
| **Section** | Set for any template that contains a single section. Such as a hero section, contact section, etc. | No (it's unique) |
| **Archive** | Set for any template that contains your website archive. Can be broken down via Template Conditions into author, date, category/tags archive pages. | Yes |
| **Product archive** | Set for any template that contains a WooCommerce archive. Can be broken down via Template Conditions into product categories or tags archive pages. | No (it's unique) |
| **Search Results** | Set for the template that you want to use to display your search results page. | Yes |
| **Error Page** | Set for the template that you want to use as your 404 error page. | Yes |
| **Password Protection** | Set for any template designed to protect content using the [Password Protection feature](https://academy.bricksbuilder.io/password-protection). | No (it's unique) |

:::note
**IMPORTANT:** Section templates do NOT sync/are updated between pages. Please set the template type to show a certain template at a specific area of your site.  "Single" & "Section" templates are unique and not used anywhere by default.
:::

## Template Bundles & Template Tags {#bundles}

These two Bricks template taxonomies can be used to organize and group your templates together. They are 100% optional.

For example, Our Community Templates use **Template Bundles** to group individual templates of the same website design (Milo, Sizzle, Rank, etc.) together. Feel free to use template bundles in any other way.

**Template Tags** are simple tags. The "My Templates" screenshot above uses template tags such as "Dark" and "Light". Again, they are completely optional but often very useful. Especially as your template library grows over time.

---


## Steps to identify and repair a compromised Bricks site

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/bricks-rce/*

In this post, we'll discuss the security vulnerability discovered in Bricks on February 10th, 2024, for which we provided a verified security patch on February 13th, 2024, with Bricks version 1.9.6.1.

:::note
**If you still haven't updated to the latest version of Bricks (1.9.6.1 or above), please do so now!**
:::

We'll then go over some concrete, actionable steps you can take to inspect and clean up infected sites.

## A disclaimer

Although this recent vulnerability in Bricks sparked this article, we hope that you take this opportunity to review and adjust your website security measures in general. Both in terms of preventive care and the procedure to identify and clean up a possibly infected WordPress site.

In 2023, around 13,000 WordPress sites experienced security breaches each day. Given this statistic, it's important for website owners to be prepared and informed about potential security threats, rather than if they might encounter them.

The information in this article contains some of the most known steps you can take to check if your Bricks site, or any WordPress site really, has been compromised and how to clean it up.

While we've made every effort to provide accurate and helpful steps in this article, please note that these are general guidelines. The effectiveness of these steps can vary based on individual site conditions and the nature of any potential compromise.

As such, we encourage caution and recommend regularly backing up your site as a safeguard. Consulting with a professional is always a wise decision if you're unsure about any process or encounter complex issues. We aim to support and inform but can't assume liability for unintended outcomes.

## What happened?

Security researcher Calvin Alkan contacted the Bricks team on February 10th, 2024, about his discovery of an "Unauthenticated Remote Code Execution in Bricks &lt;= 1.9.6", which can grant bad actors who know how to exploit it, access to your site.

The Bricks team immediately got to work on a fix that addressed the root problem.

Bricks 1.9.6.1 was released as a one-click update on February 13th, 2024, which contained a security patch to address this vulnerability.

After consulting with the WordPress security experts at patchstack.com, Bricks released a public changelog entry about the 1.9.6.1 release highlighting the security patch and immediately sent an email (subject: "Security Patch: Update to Bricks 1.9.6.1 Now") to all customers about this **mandatory security update**, even if that meant temporary functionality loss. A second email was sent within the following 24 hours.

The same information was shared in a pinned [Facebook post](https://www.facebook.com/groups/brickscommunity/posts/1320122348652282/) in the Bricks Community group. Bricks urged everyone to update to Bricks 1.9.6.1 immediately and to share this news with fellow Bricks users in other groups, etc., to help spread awareness about it.

While no exploits of this vulnerability were reported at the time of the 1.9.6.1 release, not everyone was able to update in time, and the first affected sites were reported 5 to 6 hours later, as later confirmed by Patchstack.

Less than 72 hours after the release, this 1.9.6.1 security patch became the most downloaded version of the Bricks theme.

:::note
**Even if you updated your Bricks site right away, and there are no signs that your site has been compromised, we urge you to take the time to ensure your site is clean.**
:::

## How to check if your WordPress site has been compromised {#check}

Take detailed notes of all your findings, as we will use those to clean up your site in the next section (*"Steps to clean a compromised site"*).

While all steps can be performed via the command line, we'll focus on performing them through the GUI so as many users as possible can follow along.

1. **Review user accounts:**
  - Go to your WordPress dashboard, then click on `Users`
  - Look for any user accounts you don’t recognize. Especially those with a user role of `Administrator`.
2. **Inspect child themes:**
  - In your WordPress dashboard, go to `Appearance > Themes`.
  - Check for any themes you didn’t install yourself. Unfamiliar names are a red flag.
3. **Examine server files for modifications:**
  - Use an FTP client (like FileZilla) or login to your hosting account to access your site's files.
  - Inspect the root directory (where your WordPress site is installed) and all its sub-folders.
  - Search for Recently Changed Files: To find files that may have been added or modified by an attacker, use the command `find . -type f -newermt "2024-02-01"` in SSH. This command lists all files that were added or changed after February 1st, 2024. **Note**: this is not foolproof. Sophisticated attackers might hide their tracks by altering file timestamps or employing other tactics. So, even if this search doesn't turn up anything suspicious, it doesn't guarantee your site is completely safe. However, it's still a valuable step as it can quickly flag obvious issues.
  - Cryptic-named, non-WP files are a red flag: look for anything that seems out of place or unusual. This includes files with strange names, files in unexpected locations, or files that don't appear to be related to WordPress or your usual content.
    - Examples of unusual files might include:
      - Files with random or nonsensical names like `xj47v.php` or `file.fplka28as` in your WordPress directories.
      - PHP files located in directories where they usually aren't found, like image upload folders.
      - Files with unusual extensions that are not typically associated with WordPress, such as `.java` or `.exe` files.
4. **Check posts and pages:**
  - In your WordPress dashboard, review the `Posts` and `Pages` sections. Plus, any custom post types you have registered.
  - Look for any content that you or your team didn’t create.
5. **Investigate server performance anomalies:**
  - Keep an eye out for errors when you load your site. Such as a page not loading correctly or displaying a `500 Internal Server Error`.
  - Check with your hosting provider's control panel for any sudden increases in CPU usage, which could indicate hidden activities on your site.
6. **Check cron jobs:**
  - Cron jobs are scheduled tasks on your server. Access them through your hosting control panel. Check with your hosting provider for any unknown cron jobs.
  - As for WordPress-specific cron jobs, you can use a free plugin like [WP Crontrol](https://wordpress.org/plugins/wp-crontrol/). Remove any unknown custom cron jobs.
7. **Unknown redirects:**
  - Visit your website and see if you're unexpectedly taken to a different site or page. This could be a sign of unauthorized redirects.
8. **Audit logs review:**
  - If your hosting provides an audit log, review it. It’s a record of activities on your site.
  - Look for unusual login attempts, changes in user roles, or modifications in settings.
  - Pay special attention to error messages like "Headers already sent" or sudden patterns of malfunctions.
  - The key is to check the timestamps. If suspicious activities started occurring around or after February 13th, 2024, they could be related to the vulnerability discovered in Bricks.
9. **Check .htaccess file:**
  - Access your site's files using FTP or your hosting file manager.
  - Find the `.htaccess` file in your root directory.
  - To check when it was last edited, you can use an FTP client to view the file's properties or use the command `ls -l .htaccess` in SSH.
  - If the last edit date is recent and you didn’t make the changes, examine the file for unknown rules or redirects.
  - If you’re unsure about the contents, consult a professional or your hosting provider for assistance.

## Steps to clean a compromised site {#fix}

If you've followed the steps in our previous section and suspect your site has been compromised, here's a guide on how you may fix it.

Remember, these are general steps, and it's crucial to keep monitoring your site even after these actions.

**The steps below assume you have recent backups of your site and that you can perform the cleanup locally on your computer to avoid your site getting compromised again during your cleanup.**

### 1 - Block incoming traffic: {#block-incoming-traffic}

If you are unable to set up a WordPress installation on your computer and you must perform the cleanup on your live site, please make sure to block incoming traffic to your site during this time to ensure your site can't be compromised again while you clean it up.

If you are unsure how to do this or how to do it best, please get in touch with your hosting provider.

One possible solution is to block all IP addresses except your own by adding the following code at the very top of your `.htaccess` file:

```php
Order Deny,Allow
Deny from all
Allow from YOUR_IP_ADDRESS
```

Make sure to replace the `YOUR_IP_ADDRESS` placeholder with your own public IP address. You can retrieve and then copy & paste it from free websites like [whatismyip.com](https://www.whatismyip.com/)

If you're using a managed hosting solution, your provider may offer user-friendly options to enable a 'maintenance mode' or a similar setting that blocks all incoming traffic except for specific IP addresses. Check with your hosting provider for specific options they offer to make your site temporarily inaccessible.

### 2 - Restore a backup in your local environment

1. **Choose a backup:** Pick one from February 12th, 2024, or earlier (the earlier, the better).
2. **Create a local server:** To restore your backup locally, you need to set up a local server environment on your computer. You can use software like [LocalWP](https://localwp.com/) or [DevKinsta](https://kinsta.com/devkinsta/), which are specifically designed for WordPress and offer user-friendly interfaces. Alternatively, general-purpose tools like XAMPP or MAMP are also suitable. Choose the one you're most comfortable with.
3. **Restore the backup locally:** Import your WordPress files and database into this local setup.

### 3 - Update the Bricks theme to the latest version

1. **Log into your local WordPress:** Open your WordPress dashboard on the local site.
2. **Update Bricks:** Navigate to `Dashboard > Updates` and apply the update to Bricks version 1.9.6.1.

### 4 - Re-perform the steps outlined above

1. Go over the steps [above](#check) ("How to check if your WordPress site has been compromised") again to ensure your backup wasn't compromised either. And remove all suspicious user accounts, child themes, files, and content.

### 5 - Reinstall WordPress core, all themes, and plugins

1. **Reinstall WordPress:** Go to `Dashboard > Update` and click the "Reinstall version x.x.x" button. This will reinstall your WordPress core files, without affecting your existing content (posts, pages, etc.), configurations, themes, and plugins.
2. **Reinstall all plugins: **Either update all plugins to their latest version or reinstall all plugins.
3. **Reinstall all themes: **Either update all themes to their latest version or reinstall all themes.

While all of those steps can be done via the CLI for free themes and plugins listed in the WordPress repository, you still need to do this manually for some of your premium plugins. We recommend performing this manually, one by one, to verify that all the latest versions are working on your site as expected. This is also a great chance to revisit which plugins might no longer be needed.

### 6 - Change sensitive credentials and keys

After ensuring that your site's files and database are clean, it's important to address the potential compromise of sensitive information such as API keys, SMTP passwords, and licenses. Attackers may have accessed these and could misuse them, leading to further security issues.

- **Update API keys and secrets:**
  - Identify all APIs used in your WordPress site, including payment gateways, social media integrations, and other external services.
  - Generate new API keys and secrets for each service.
  - Update these new keys in your WordPress settings or relevant plugin settings.
- **Change SMTP passwords:**
  - If using an SMTP service for emails, assume the password is compromised.
  - Change the SMTP password through your email service provider.
  - Update the new SMTP password in your WordPress or email plugin settings.
- **Update license keys:**
  - For premium plugins, themes, or other licensed software, change their license keys.
  - Contact the providers to issue new keys if necessary.
  - Update these keys in your WordPress settings.
- **Secure other sensitive data:**
  - Review and update any other sensitive data in your WordPress configuration. This includes custom authentication keys or custom credentials.

### 7 - Migrate your local installation to your live environment

When you're ready to migrate your local WordPress installation to your live environment, it's important to ensure the site is not accessible to the public during this process. Refer back to [1- Block incoming traffic](#block-incoming-traffic) for methods to temporarily make your site inaccessible, either through editing the `.htaccess` file or using options provided by your managed hosting service.

1. **Fresh Install on Live Server**: Start by installing a new instance of WordPress on your live server. This ensures you are working with a clean and secure base.
2. **Transfer your site:** You can use plugins like [Duplicator](https://wordpress.org/plugins/duplicator/), [WPVivid](https://wordpress.org/plugins/wpvivid-backuprestore/), or [All-in-One WP Migration](https://wordpress.org/plugins/all-in-one-wp-migration/) to move your updated local site to the new live server setup.

### 8 - Alternative method (for hosts allowing site isolation)

1. **Isolate your site:** Ask your host to block internet access to your site temporarily.
2. **Restore and update on the live server:** Directly restore the backup and update Bricks to 1.9.6.1 on the live server before reopening access.

### Additional steps (important for all scenarios)

1. **Run security scans with a plugin like Wordfence:**
  - **Install Wordfence:** In your WordPress dashboard, go to `Plugins > Add New`. Search for "Wordfence". Install and activate it.
  - **Run a scan:** Navigate to `Wordfence > Scan` in your dashboard. Click on "Start a new scan". Make sure you’re in "High Sensitivity" mode for thorough scanning.
  - **Review scan results:** After the scan, you'll get a list of potential threats. Carefully review each item. If you're unsure about a file, research it or ask for expert advice.
  - **Remember:** While plugins like Wordfence can sometimes be valuable, they are not infallible since they're running on the application level. It's crucial to use them as part of a broader security strategy, including regular manual checks and monitoring for unusual site activity at the server level.
2. **Scan for malware at the server level:**
  - **Use hosting provider tools:** The best way to scan for malware is at the server level through tools provided by your hosting provider. Plugins can sometimes be tampered with, making them less reliable for thorough security checks.
  - **Consult with your provider:** Engage with your hosting provider to understand and implement the security features they offer. These tools are generally more integrated with the server's infrastructure, offering a more robust and comprehensive approach to malware scanning.
3. **Change database password:**
  - **Access hosting control panel:** Log into your web hosting account and go to the database section.
  - **Find database settings:** Locate the database used by your WordPress site.
  - **Change password:** Update the password. Ensure it’s strong and unique.
  - **Delete the old `wp-config.php` file**:
    - Using FTP or your host's file manager, access your site's root directory.
    - Locate the existing `wp-config.php` file and delete it. This is an important step to remove any potentially compromised or unsafe configurations.
  - **Start with a fresh `wp-config.php` file**:
    - Download a fresh `wp-config.php` sample file from the official WordPress repository: [WordPress Repo wp-config-sample.php](https://github.com/WordPress/WordPress/blob/master/wp-config-sample.php).
    - Copy and paste the content of this file directly into a new file named `wp-config.php`. Alternatively, you may download the file, rename it to `wp-config.php`, and upload it to your site's root directory.
  - **Update new `wp-config.php`**:
    - Open the new `wp-config.php` file.
    - Copy your new database password and paste it into the corresponding line (`define( 'DB_PASSWORD', 'new_password' );`).
    - Fill in or update other necessary details like database name, user, and host.
  - **Note**: If you're using a managed hosting service and are unsure about this process, it's advisable to contact your hosting provider for assistance. They can offer support and guidance in updating your `wp-config.php` file.
4. **Reset all user passwords in WordPress:**
  - **Go to users:** In your WordPress dashboard, click on `Users`.
  - **Edit each user:** Click on each user account, especially admins, and set a new password. Use strong passwords.
5. **Update security keys in `wp-config.php`:**
  - **Access your site files:** Use FTP or your host's file manager to access your site's root directory.
  - **Edit `wp-config.php`**: Open the `wp-config.php` file you've just created or updated.
  - **Generate new keys:** Visit [WordPress’s Security Key Generator](https://api.wordpress.org/secret-key/1.1/salt/). Copy the generated keys.
  - **Replace old keys:** In `wp-config.php`, find the section with authentication unique keys and salts. Replace them with the new ones you copied.
  - **Save changes:** After replacing, save and close the file.
6. **Check and adjust file permissions:**
  - **Using FTP:** Connect to your site using an FTP client.
  - **Navigate to WordPress folders:** Look for the `wp-admin`, `wp-includes`, and `wp-content` directories.
  - **Set folder permissions:** Right-click on each folder and choose 'File Permissions'. Set the numeric value to 755.
  - **Set file permissions:** For individual files within these directories, set permissions to 644.

While outlining the general steps you can take to check for and address compromises in your WordPress site, it's important to understand that each site is unique, with different types of attacks and impacts.

Therefore, we recommend also consulting the [WordPress Hardening Guide](https://developer.wordpress.org/advanced-administration/security/hardening/). This technical guide covers advanced security measures. If you're using a managed hosting service, your provider typically handles many of these security aspects.

However, it's still beneficial to be aware of these practices, as they provide valuable insights into securing your WordPress environment.

---


## Code review

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/code-review/*

With the implementation of code signatures in Bricks 1.9.7 providing a robust mechanism to safeguard code authenticity, another new key feature to further improve the security management of your Bricks site is the "Code review".

The "Code review" gives you a thorough overview of all custom and executable PHP code added to your site through Bricks.

:::note
We recommend performing a code review every time before generating code signatures globally via the Bricks settings.
:::

You can access and start a "Code review" under `Bricks > Settings > Custom code` by clicking the "Start: Code review" button.



![](imgs/bricks-settings-code-review-06ecd7477a.png)

<figcaption>

Code review results

</figcaption>



## Core functionalities

**Review executable code & functions:** The code review displays all instances of executable code in Code elements, SVG elements (source: code), Query editor instances, and all functions called through `echo:` tags.

**Quickly locate code:** View and edit the specific page or template where each code instance is located, along with the element's ID, and if contains a valid, invalid or no code signature. And the user who last signed the code.

**Lists all echo function names in use:** At the bottom of the code review results, you'll find a code snippet for the new Bricks filter `bricks/code/echo_function_names`, which you can copy & paste into your Bricks child theme `functions.php` file in order to use those functions in your dynamic `echo` tag. For more details about using the `echo` tag in Bricks 1.9.7+, please visit [/developer/hooks/filters/filter-bricks-code-echo_function_names/](/developer/hooks/filters/filter-bricks-code-echo_function_names/)

## Advantages of centralized code monitoring

- **Centralized code oversight:** Offering one page to review all the Bricks-added PHP code on your site, this feature makes it easy to ensure that all code added through Bricks elements to your website is legitimate and safe.
- **Proactive security:** The new code review feature empowers you to identify and rectify potential exploitations preemptively by providing an overview of all code elements.

---


## Code signatures

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/code-signatures/*

With the release of version 1.9.7, Bricks takes another significant step to enhance the built-in code security by introducing code signatures.

:::note
Code signatures ensure that the code you are running has not been tampered with. Valid code signatures are now mandatory. Any code without a valid signature won't run.
:::

## Elements that require code signatures

The following elements require valid code signatures to run:

- Code element with "Code execution" enabled
- SVG element with "Source" set to "Code"
- Query loop editor

## How to generate code signatures

You can generate code signatures for individual elements when editing them in the builder, for the entire page inside the builder, or globally via the Bricks settings. Let's explore all options together.

### Generate code signatures in the builder

Inside the builder, all elements with unsigned code are highlighted in red. You'll also see a red "fingerprint" icon at the top of the structure panel.



![](imgs/bricks-query-editor-unsigned-code-0242226db7.png)

<figcaption>

Builder: Code, SVG, and Query editor with unsigned code

</figcaption>



#### Sign code for an individual element

![](imgs/bricks-builder-panel-sign-code-16ac2d0a2d.png)

To generate a code signature for an individual element while you edit it, you can click the "Sign code" button right above the code editor. Or, if your cursor focus is inside the code editor, use the "CMD/CRTL + R" keyboard shortcut.

### View & sign unsigned code in bulk

You can also view and sign all elements with unsigned code on the current page by clicking the "fingerprint" icon at the top of the structure panel. The same icon is also available on individual unsigned elements in the structure panel.

![](imgs/bricks-builder-popup-unsigned-code-b4e5e5f054.png)

### Sign all code globally via Bricks settings

To generate code signatures for your entire site, navigate to `Bricks > Settings` > Custom code > Code signature in your WordPress dashboard.

Click the `Regenerate code signatures` button. This will generate code signatures for all pages, templates, etc., built with Bricks.

This feature is only available when code execution is enabled and for users with code execution capability.

## Locking code signature generation {#lock-code-signatures}

In Bricks 1.11.1, we introduced the `BRICKS_LOCK_CODE_SIGNATURES` constant, an additional layer of control for high-security environments. When `BRICKS_LOCK_CODE_SIGNATURES` is set to `true`, Bricks prevents any new code signatures from being generated, regardless of user permissions. This feature is especially useful if you want to lock down the ability to modify code signatures after initial development is complete.

To enable this lock, add the following line to your `functions.php` file:

```php
if ( ! defined( 'BRICKS_LOCK_CODE_SIGNATURES' ) ) {
    define( 'BRICKS_LOCK_CODE_SIGNATURES', true );
}
```

With this constant set to `true`, any attempt to generate new code signatures will be blocked. This constant provides an alternative to the Bricks settings for managing code signature access in production environments where strict security is essential.

## When to regenerate signatures

:::note
**When updating Bricks from a version before 1.9.7, generating code signatures via `Bricks > Settings` for your code to execute is mandatory, as only code with a valid signature will be executed. Please make sure to first perform a "Code review" on the same page**.
:::

**After changing your WordPress salt (secret keys):** Whenever the salts in `wp-config.php` are changed, you have to regenerate code signatures.

**After site migration:** When moving your site to a new domain or server, you might need to regenerate signatures if the salts in the new environment are different.

## Why code signatures?

Before explaining the rationale behind introducing code signatures in Bricks and how Bricks uses them, it's important to understand how hashing works and the specific role of WordPress salts in this process.

### Understanding WordPress salts

In the context of WordPress, salts are essentially random strings that serve as keys for cryptographic operations.

These strings, stored in the `wp-config.php` file, are crucial for operations like keyed hashing and encryption. Salts add an extra layer of security by ensuring that the hash signatures generated for your site's code are unique and securely encrypted.

In simpler terms, think of WordPress salts as a secret ingredient in your website's recipe, stored in the `wp-config.php` file. Just like a secret ingredient can uniquely identify a dish, these salts ensure the uniqueness of your website's code.

When the code is prepared (or hashed) with this secret ingredient, it creates a signature that's unique to your site.

If someone tries to replicate or alter your website's code without knowing the secret ingredient, their version won't have the same signature, making it easy to spot and reject the change.

### Understanding the `wp_hash` function

For hashing, Bricks utilizes the WordPress-native [`wp_hash`](https://developer.wordpress.org/reference/functions/wp_hash/) function, which uses an HMAC-MD5 algorithm to generate unique hash signatures.

This function combines your site’s data with its unique salts, creating a hash signature that is distinctive to your site.

### Bricks code integrity verification process

In Bricks, these hash signatures are important in ensuring that any modifications to the code on your site can only be made with access to these unique salts and code execution capability in Bricks.

Here's a brief overview of how this process works:

1. **Code and signature generation:** When you sign your code, a unique hash signature is generated using your site's unique WordPress salts.
2. **Code retrieval for execution:** When the code is accessed on your site, Bricks retrieves the code and its stored hash signature from the database.
3. **Verification process:** Bricks re-hashes the retrieved code and compares this new hash with the original stored signature.
4. **Execution decision:** If the hashes match, it confirms the code's integrity, allowing it to execute. A mismatch indicates potential unauthorized changes, preventing execution.

The integration of `Code signatures` & `Code review` in Bricks 1.9.7 marks a significant advancement in our commitment to enhancing the security and integrity of websites built with Bricks.

Collectively, these enhancements provide a comprehensive framework for ensuring the security and authenticity of your site's code. Helping you safeguard against potential unauthorized modifications and maintain the overall health and safety of your WordPress site.

## Why rotating WordPress salts regularly is a bad idea {#rotating-salts}

If you rotate the salts in your `wp-config.php` file, all existing Bricks code signatures will become invalid. You’ll need to manually regenerate them from **Bricks Settings > Custom code > Code signatures** for any signed code to run again. If you're wondering why we don’t automate signature regeneration, read [the next section](#no-automatic-code-signing).

Some plugins offer automatic salt rotation with the claim that it makes cracking passwords harder. That claim is incorrect. WordPress salts are not used for hashing user passwords. Rotating them provides no added protection against password theft or brute-force attacks.

What salt rotation *does* cause:

- Logs out all users by invalidating authentication cookies
- Breaks nonces, which can disrupt form submissions and AJAX requests
- Can break plugins that use salts for encryption or data integrity
- Invalidates all code signatures

Unless your site has been compromised, there’s no practical reason to rotate salts. It introduces unnecessary breakage and instability.

## Why can’t code be automatically signed? {#no-automatic-code-signing}

Bricks requires **manual code signing** to prevent a bad situation from becoming much worse in the event of a breach.

Here’s the risk: If someone gains access to your database (e.g. through a plugin vulnerability or compromised credentials *of a user without code execution capability*), they could inject malicious code into a Bricks element. That’s already a serious breach, but it *doesn’t* mean they have full control of your server.

Because Bricks uses code signatures tied to your site’s unique WordPress salts, that attacker can’t make the code executable by only having access to the database. It remains unsigned, and Bricks blocks it from running.

However, if code were automatically signed just because a logged-in user with code execution capability opens the builder, that entire protection would collapse. The attacker could plant malicious code in the database and wait. As soon as you load the builder, the code would be auto-signed and run the code on your behalf, *without you even seeing it*.

Manual signing forces a checkpoint. The code shows up as unsigned (red), so you have a chance to review and decide whether it should be trusted. This step contains the impact of a partial breach and stops it from escalating into full code execution.

---


## Color Manager

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/color-manager/*

The Color Manager lets you define and maintain color tokens for your site. Each color is stored as a CSS variable and can optionally support dark mode, shades, harmonies, and utility classes.

It is designed to help you build a predictable color system instead of setting isolated and impossible to maintainable hex values across your elements.

## Getting started

To access the Color Manager:

1. Open the builder
2. Click the "Gear" icon on the left-hand site of the builder toolbar
3. Open the "Colors" tab to access the Color Manager

![](imgs/bricks-2.2-color-manager-scaled-3de807b3c1.png)

If you don't have any palettes yet, you'll see a prompt to create your first one from scratch or to import an existing color palette (JSON file).

## Creating and managing palettes

### Creating a new palette

1. Click the **Add Palette** button (plus icon)
2. Enter a name for your palette (e.g., "Brand Colors" or "Website Theme")
3. Click **Create**

### Switching between palettes

Use the dropdown at the top to select different palettes

### Renaming or deleting palettes

1. Click the **Edit** button (pencil icon) in the toolbar
2. To rename: Click in the palette name field and type a new name
3. To delete: Click the **Delete** button (trash icon) and confirm

## Adding colors to your palette

### Adding a new color

1. Scroll to the bottom of the color list
2. Enter a variable name (like "primary" or "brand-blue")
3. Pick a color using the color picker or type in a color value
4. Click **Add color**

### Editing existing colors

Click on any color's name or value to edit it

## Using dark mode

Dark mode lets you define different colors for light and dark themes:

1. Click the "Edit" icon on any color
2. Check the "Enable dark mode" box
3. Set a separate color for dark mode using the color picker
4. The color swatch will show both light and dark versions

![](imgs/bricks-2.2-style-manager-color-manager-dark-mode-scaled-09ace2e948.png)

## Creating color shades

Shades are variations of your base colors with different lightness or transparency:

1. Click the "Edit" icon on any color
2. Enable the shade type you want to create

- **Light shades**: Brighter versions of your color
- **Dark shades**: Darker versions
- **Transparent shades**: Semi-transparent versions

![](imgs/bricks-2.2-style-manager-color-manager-shades-scaled-fb7300d045.png)

## Generating color harmonies

Color harmonies create matching color combinations automatically:

1. Select a base color
2. Click the **Harmony** button (design palette icon)
3. Choose a harmony type:

- **Analogous**: Colors next to each other on the color wheel
- **Monochromatic**: Different shades of the same color
- **Complementary**: Colors opposite each other
- **Split Complementary**: One complementary color split into two
- **Triadic**: Three colors evenly spaced
- **Tetradic**: Four colors in a rectangle pattern

1. Preview the generated colors
2. Click **Generate colors** to add them to your palette

## Setting up utility classes

Utility classes let you quickly apply colors to elements without custom CSS:

1. Edit a color
2. Scroll down to "Utility classes"
3. Check the boxes for the properties you want:

- **Background**: For background colors
- **Text**: For text colors
- **Border**: For border colors
- **Outline**: For outline colors
- **Fill**: For SVG fill colors
- **Stroke**: For SVG stroke colors

Once enabled, you'll have classes like `bg-primary`, `text-primary`, etc available to you when editing elements.

![](imgs/bricks-2.2-style-manager-color-utility-classes-scaled-0cabab3ac8.png)

## Importing and exporting palettes

### Importing palettes

1. Click the **Import** button (download icon)
2. Drag and drop a JSON file or click to browse
3. The system will validate and import your colors
4. You'll see success or error messages for each imported palette

### Exporting palettes

There are two ways to export your colors:

1. Click the **Export** button (upload icon) to export as JSON (to import into other Bricks sites)
2. Click the "Generated CSS" button to copy the generated CSS

---


## Components

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/components/*

Components let you create reusable elements. Each component instance can is be customized through properties.

While templates serve as the blueprint for specific pages, components are the blueprints for a specific element (i.e. button) or collection of elements (i.e. a card) that you can reuse and customize per instance throughout your website.

Create a component from an element (including all its children) such as a button, card, navigation, or even an entire hero section, and reuse it anywhere else on your site.

Any change to the main component automatically applies to every instance of this component.

This keeps the structure and style of those reusable elements consistent throughout your website.

Resulting in an extremely consistent, scalable, and easy to maintain workflow. 🚀

https://www.youtube.com/watch?v=nNvcrK-vDDs

## How to create a component

Create a component from any element, except Template & Filter elements, by right-clicking on the element, and select the `Save as component` action.

![](imgs/bricks-save-as-components-394be02d95.png)

In the popup that appears, enter a name (required), category (optional), and description (optional) for your new component. Once done, click `Create` to finish creating your component.

![](imgs/bricks-create-component-popup-97981ec8f4.png)

Once created, you can components anywhere on your site from the components library.

## Components Library

![](imgs/bricks-components-panel-20d6e59fa8.png)

You can access your components from the `Components` tab, located next to the `Elements` panel tab.

From here you can add a component to the canvas or structure panel via drag & drop or click (same as any other element).

You can perform the following actions by clicking the respective icons at the top of the `Components` tab:

- **Import:** Import a components JSON file from another installation.
- **Export:** Export all components of your site as a JSON file. To export a specific component, hover over it, and click the "export" action icon.
- **Delete:** Click the "delete" icon to enter the delete mode. Once activated, hover over the component you want to delete, and click the "delete" icon. We recommend to first export all components before performing any deletion.

### Instance count & location (current page/global)

![](imgs/bricks-components-panel-instances-count-a8b41c5783.png)

Below the name of the component is the instance count. For our "Card" component it says "Instances: 3/6". The first number (3) is the instance count of the page you are currently editing, and the second number (6) is the total instance count global/site-wide.

Hover over the component, and clicking the "globe" icon shows you all instances of this component on the "Current page", and a list with count of all the "Other Pages" on which this component is being used.

## Instances - How to reuse a component

Every time you add a component to a page, a so-called `Instance` of that component is created.

Changes to the main component automatically reflect in all instances of this component throughout your entire website.

The following screenshot shows three instances of our Card component:

![](imgs/bricks-components-panel-instances-0a79a33d4f.png)

Before we explore customizing our instances, let's have a look at ...

## Editing the main component

To view and edit the elements of the main component, which is the source of truth for all its instances, right-click on any instance (purple) and select `Edit component`.

![](imgs/bricks-component-edit-context-menu-3c9a2b0b39.png)

Alternatively, you can also click the gear icon in the control panel header of the instance to enter the component editing mode:

![](imgs/bricks-component-instance-edit-component-068318b0ff.png)

**You are now editing the main component** indicated by the purple color in the control panel header.

As mentioned before, any change you perform on the main component applies to all instances of this component on your site.

![](imgs/bricks-components-editing-main-component-92e8d4ca7c.png)

The main component header contains the following actions:

- **Description** (info icon): Click to show/hide the component description (editable).
- **Category** (folder icon): Click to show/hide the component category (editable).
- **Properties** (box icon): Click to view the component properties panel.
- **Instance** (arrow icon): Exit the component edit mode, and go back to the instance you were editing before or the components panel. Pressing the ESCAPE key also exists the main component.

Now that you are editing the main component you can see and edit all elements of this component in the structure panel:

![](imgs/bricks-components-main-component-structure-panel-8d2b47e36d.png)

To edit the title of our Card component, select the Heading element inside our component, and change its text to "Just a card".

All instances of our Card component automatically reflect this change:

![](imgs/bricks-components-edit-component-heading-f18ab29b6c.png)

While this is great for using the exact same element multiple times throughout your site, and updating the main component automatically applies every change to all instances, the real power of components lies in their ability to customize the content of each instance through `Properties`.

## Properties {#properties}

**Properties let you expose controls for customization for each instance.**

Lets create some properties so each Card instance on our website can have its own unique card title and image.

There's a simple, two-step process of (1) creating and (2) connecting properties.

**NOTE:** Creating and editing properties requires the `Edit component` [builder permission](/builder/interface/builder-access/#components).

### 1) Creating a property

To access the properties panel, select any instance of the component you want to edit.

Then click the "edit" icon in the properties control panel on the left-hand side:

![](imgs/bricks-components-instance-edit-property-1-ea1814d68c.png)

If there aren't any instances of the component you want to edit on the current page, you can go to the Components library, hover over the respective component, and click the "edit" icon.

If you are editing the main component, you can access the Properties panel by clicking the "box" icon in the panel header (highlighted in the screenshot below).

### Property types {#property-types}

You can choose from the following, growing variety of property types, that you can then connect to specific controls of elements inside your component:

| **Property type** | **Connectable to** | **Example** |
| --- | --- | --- |
| Text | Text/textarea controls | Heading or Basic text |
| Rich text | Rich text controls | Rich text or Accordion content |
| Icon | Icon controls | Icon or Icon Box element |
| Image | Image controls | Image or Logo element |
| Image gallery | Image gallery controls | Image gallery or Carousel element |
| Link | Link controls | Button or Heading link |
| Select *(@since 2.0)* | Text/select controls | HTML tag, Button style |
| Toggle *(@since 2.0)* | Toggle controls | Hide element toggle |
| Query loop | Query loop controls | Layout elements |
| Global classes *(@since 2.0)* | Global classes control | Element global classes |

![](imgs/bricks-2.0-components-create-property-form-3371a09a07.png)

We want to expose the heading of our card component, so we select the property type `Text`.

The **property name** is mandatory. Choose a descriptive name. This is especially important for complex components with potentially dozens of different properties, so everyone working with this component knows exactly what each property is for.

Providing a **property description** is optional, but can be super helpful for anyone who will be using this component.

Selecting a **property group** is optional, but very useful for complex components with multiple properties and potentially even the same name.

The **default property value** is optional. Its used for the control you connect this property to. If left empty, no setting will be applied to the connected control by default.

### 2) Connecting a property to a control

Now that we created our first property, we have to connect it to the element control that we want to expose on the instance.

Note that the properties panel shows a message if any unconnected properties are detected.

Also, unconnected properties have a "broken link" icon next to their name.

![](imgs/bricks-components-unconnected-properties-b6eb14e548.png)

Lets connect our "Card heading" text property to the "Heading" element of our card component.

First, we select the "Heading" element inside our component.

You'll notice a round purple `+` icon next to the text control of our Heading element.

This `+` icon indicates that this control can be connected to a property.

![](imgs/bricks-components-control-property-indicator-bbbfb30bfc.png)

Clicking the `+` icon reveals a list of properties that we can connect to this control:

![](imgs/bricks-components-control-property-options-37b1896ac1.png)

:::note
**Workflow boost:** Quickly create a new property by clicking the `+` icon, located at the top right of the "Connect property" dropdown.
:::

We can see the "Card heading" property that we just created in the dropdown and select it.

Once selected, our Heading text control shows the name of the property that we just connected:

![](imgs/bricks-components-control-property-connected-67630e740f.png)

Our default property value "Default Card heading" that we set when we created this property is now used as the text value for our all our Card component headings.

And that's it. You successfully created and connected your first property. 🥳

You can continue creating and connecting as many properties as needed.

We used the same two-step process of creating & connecting for our image property so we can customize the "Card image" as well. Our component now looks like this:

![](imgs/bricks-components-instance-default-property-values-2-3c026aeef1.png)

### Disconnecting a property

To disconnect a property from a settings, click the connected property setting, hover over the connected property name, and click the "unlink" icon.

![](imgs/bricks-component-disconnect-property-3d3cee32d7.png)

## Customizing an instance

Right now, all our Card components use the exact same content.

But we've created two properties so we can customize the title & image of each Card instance. So lets do that by selecting the Card instance that you want to customize, then set custom property values in the control panel like this:

![](imgs/bricks-components-instances-custom-values-b286394b46.png)

We could continue to also expose the button text through a text property, but you get the picture.

## Components as loops and inside loops {#loops}

Components are also compatible with query loop. Either by enabling the loop on the component root or by having a loop inside the component.

In the following screenshot we use our Card component inside a loop. The Card title uses the `post_title` dynamic data tag and the Card image uses the `featured_image` tag to render the post title & featured image of the loop results.

![](imgs/bricks-component-inside-query-loop-34b964a441.png)

There's also a property type "Query loop" which allows you to customise your in-component query loop for every instance.

## Component variations {#variations}

Starting with Bricks 2.0, you can further customize your components instance by conditionally hiding elements within a component through the `Toggle` property.

Styling variations are easy to setup through the new `Global classes` property.

Lets have a look at both approaches next.

### Variation: Show/hide elements {#visibility}

![](imgs/bricks-2.0-component-property-toggle-hide-element-e3aa2e7c16.png)

Bricks `2.0` introduces a new "Hide element" feature, available by clicking the `"eye`" icon in the element panel header, or from the context menu.

You can create a `toggle` property and connect it to the "Builder Hide element" and/or "Frontend: Hide element" toggle controls to show/hide elements inside your component on an instance-basis.

"Hide element" doesn't visually hide the element via CSS. The element is not loaded or added to the DOM at all.

### Variation: Global classes {#global-classes}

The `Global classes` property type, available @since 2.0, lets you create different styling variations through global classes. Assign a collection of default and/or custom classes on the instance for any element of your component.

![](imgs/bricks-2.0-component-property-type-global-classes-connectable-property-37e734cbe6.png)

In the following example (see screenshot below) we create a global classes property with the custom options "Small", "Medium", "Large". Each option is has a different global class assigned to it. You can also assign multiple classes.

![](imgs/bricks-2.0-component-property-type-global-classes-custom-options-bd8e69c016.png)

Once we have created this new "Heading size" property, we need to connect it to the global classes control of the element of our choice. For our example, we connect it to the Heading:

![](imgs/bricks-2.0-component-property-type-global-classes-connect-property-a34621fe55.png)

![](imgs/bricks-2.0-component-property-type-global-classes-connected-property-534b91206e.png)

Once connected, the property becomes available on every instance. In the following screenshot we selected the "Large" option, which adds global class `prop-text-lg` to the Heading element of the instance.

![](imgs/bricks-2.0-component-property-type-global-classes-instance-scaled-ef8a070d55.png)

This is just a very simple example of how you can use the global classes property to create styling variations for your components.

You can connect as many global class properties to an element as needed.

When defining custom options you can leave the "Label" empty to show the selected global class names instead. User-friendly labels are usually the preferred option.

You can change the global class selection of an option any time and the newly selected global classes will be added to the instance if the corresponding option is selected.

### Variation: Local classes {#local-classes}

If you aren't working with global classes you can utilize the "Select" property type to define custom options that your users can choose from, which then apply the class names through the "Attributes" control to an element of your component.

![](imgs/bricks-2.0-component-property-type-select-local-classes-a8d0409215.png)

Next, lets create a "Select" property with the class name options:

![](imgs/bricks-2.0-component-property-type-select-custom-options-b6c792f4e0.png)

Once we created & connected this select property to the Attributes value, it'll be available on the instance, and we can apply our local class with one click like this, which add the `color-red` class to our Heading element inside the component.

![](imgs/bricks-2.0-component-property-type-select-instance-scaled-48c509ac3e.png)

You can, of course, also connect a "Text" control to the "Attributes" value, if you want to allow users to enter the plain class names directly instead of choosing from predefined options.

## Unlinking a component {#unlink}

To unlink an instance from a component, right-click on the instance, and select the "Unlink component" icon under the "Edit component" menu item.

Once unlinked, this instance is no longer tied to your main component, and can be edited independently, like any other normal element.

## Global element to component converter

As global elements are officially deprecated @since 2.0, and you can't create new global elements, please use our "Global element to Component converter" available under `Bricks > Settings > General > Global elements`.

## Notes & Tips

- A component must have exactly one root element
- Components can't be created from Template or Query Filter elements
- Components are identifiable in the builder by their **purple** color
- You can change the label of each instance like any other element
- Take advantage of property descriptions & groups when working with complex property setups

---


## Creating Your First Template

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/create-template/*

Now that you are familiar with all [template concepts](/builder/features/an-intro-to-templates/) and the [template library](/builder/features/template-library/) let's create the most commonly used templates: a website header, footer, and blog post layout in the video below.

Bricks, by default, shows your first published header and footer template on your website. You can disable this behavior from your WordPress dashboard under **Bricks → Settings → Templates** by selecting the **Disable Default Templates** setting.

With default templates disabled you need to manually set Template Conditions when editing your template under **Settings → Template Settings → Template Conditions**.

The following video will walk you through the entire process:

https://youtu.be/bLZDN9UcUyo

## Header Template Settings

When editing a header template, an additional **Header** settings group is available under **Settings → Template Settings →** Header.

There you can find various header-specific settings such as:

- Header position (top/right/left)
- Header width (available when header position is set to left/right)
- Sticky header (available when header position is set to top)

### Disable Header On Specific Page

To disable the header on a specific Page, go to **Settings → Page Settings → General** and check **Disable Header**. Useful for landing/splash pages.

### Disable Footer On Specific Page

To disable the footer on a specific Page, edit this page and go to **Settings → Page Settings → General** and check **Disable Footer**. Useful for landing/splash pages.

---


## Create & Update Posts on the Frontend

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/create-update-posts-on-the-frontend/*

Bricks 2.1 introduces the "Create post" and "Update post" form action to allow users to create and update content of any post type on the frontend.

In this guide, we'll create & update property listings for our custom post type `property`.

:::note
**IMPORTANT:** Forms with the "Create post" or "Update post" action are only rendered if the current user has the necessary capabilities to create/update a new post for the selected post type or to edit the selected existing post.
:::

https://www.youtube.com/watch?v=c9JcrLEVbnM

## How to create/update posts via form submission

As the process of creating a form to create or update a post is almost identical, we'll summarise both actions in one go in the following step-by-step instructions.

### Step 1 - Add form fields for post data

Create form fields for all the post data that you want to save when creating or updating a post through the Form element:

| **Post data** | **Field type** |
| --- | --- |
| Post title | Text |
| Post content | Rich text |
| Post excerpt | Textarea |
| Featured image | Image |
| Post meta | The most suitable field type |
| Taxonomy | Checkbox, radio, select |

#### Post meta

Make sure to select the most suitable field type for every piece of post meta data that you want to modify.

Bricks automatically detects the checkbox, radio, or select field options from ACF or Meta Box when you map the meta key correctly, so you don't have to specify those in the form field itself. For more details about this, please watch the Academy video on this page.

#### Taxonomy

The checkbox, radio or select form fields are most suitable to modify post taxonomies, such as the post category or tags. You can leave the options empty. Bricks will automatically populate the options with the terms of the selected taxonomy, when correctly mapped.

### Step 2 - Select "Create post" or "Update post" form action

Depending if you want to create or update a post, select the desired action when editing the Form element.

![](imgs/bricks-form-action-create-update-post-b89704ad84.png)

### Step 3 - "Create post" or "Update post" configuration

When creating a new post, select the post type that you want to create a new post for under the "Create post" control group:



![](imgs/CleanShot-2025-09-16-at-14.07.14@2x-8ebd422c47.png)

<figcaption>

Create new post for post type "Property" on form submission

</figcaption>



When updating an existing post, select the specific post that you want to update under the "Update post" control group:

![](imgs/bricks-form-update-post-control-group-0bb9923f1c.png)

Leave the "Post to update" field empty to update the current post. Which is what we did in the Academy video as the update post form was located on the single post page.

## Step 4 - Field mapping

The last, and most important step is to map/connect your form fields with the post data that should be modified when the form is submitted. The mapping controls are also located within the "Create post" and "Update post" control groups.

### Mapping simple post data

For simple post data such as the Post title, Post content, Post excerpt, and Featured image you just have to select the corresponding form field from the select dropdown:

![](imgs/bricks-form-create-post-field-mapping-simple-post-data-c1deec3f19.png)

### Mapping post meta

When updating post meta via a form field you have to provide the correct "Meta key", select the corresponding form field under "Meta value", and select the correct "Sanitization method".

![](imgs/bricks-form-create-post-field-mapping-post-meta-52b3d9ff60.png)

#### Auto-populated ACF & Meta Box checkbox, radio, select options

Bricks automatically detects if a post meta key belongs to ACF or Meta Box, and it'll auto-populate the options for the field for you, so you don't have to specify any "Options" when you create the form field in the Form element.

### Taxonomies

Mapping a form field to a taxonomy is straight-forward. Under "Taxonomies", select the taxonomy that you want to update, plus the corresponding form field, for which we recommend using the checkbox, radio, or select type.

Again, there's no need to manually enter the taxonomy terms, except that's what you want to do to limit the choice the user has, Bricks will automatically populate the form field with the taxonomy terms for you.

## Filters

Bricks offer support of some field types with ACF & Meta Box out-of-the-box, but it's impossible to support all field types. But you can programmatically handle all form submissions and how the post meta should be stored, by using the following two filters:

- [`bricks/form/create_post/meta_value`](/developer/hooks/filters/filter-bricks-form-create_post-meta_value/)
- [`bricks/form/update_post/meta_value`](/developer/hooks/filters/filter-bricks-form-update_post-meta_value/)

---


## Custom Attributes

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/custom-attributes/*

Bricks 1.3 introduces the possibility to add your own custom HTML attributes to any element.

You can add custom attributes under "Style > Attributes". Set a "Name" and a "Value" and your attribute(s) will be added to the elements' most relevant node. By default, your attributes are added to the element root node. Besides manually entered values you can populate your custom attributes with dynamic data, too.

In there you'll be able to insert multiple attributes (name and value). You'll also be able to use Dynamic Data in both name and value fields.

![](imgs/feature-custom-attributes-02d33d1179.png)

<figcaption>

Container: Custom Attributes

</figcaption>

Let's say you want to add an ARIA **role** and **label** to a container that contains multiple images that should be [considered as a single image](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/Role_Img). You'd add the following two attributes when editing your container:

- Attribute #1 name: **role**
- Attribute #1 value: **img**
- Attribute #2 name: **aria-label**
- Attribute #2 value: **Description of the overall image**

This results in the following container HTML:

```php
<div id="bricks-element-sfglik" class="bricks-element-sfglik bricks-container" role="img" aria-label="Description of the overall image">
... Container elements ...
</div>
```

Custom attributes precede default attributes. So if you set a custom **alt** attribute when editing your image, this custom attribute will be used instead of the default image **alt** attribute.

Elements where custom attributes are added to the following specific HTML tags:

| **Bricks Element** | **HTML tag** |
| --- | --- |
| Nav Menu |  |
| Heading | or any other heading tag |
| Text |  |
| Button | or  depending if there is a link |
| Image |  |
| Video |  |
| Form |  |

### How To Add Tooltips {#tooltips}

Bricks comes with built-in (CSS-only) tooltips that you can set via custom attributes.

Make sure to set the attribute "Name" to `data-balloon` and the value to whatever you want your tooltip text to be. You also have to set a second HTML attribute named `data-balloon-pos` and then set the value to whatever you want your tooltip to be positioned like:

- top | top-right | top-left
- right
- bottom | top-bottom | top-bottom
- left

For a full list of all available tooltip HTML attributes please visit the official website of the Balloon.css library Bricks uses for its tooltips: [https://kazzkiq.github.io/balloon.css/](https://kazzkiq.github.io/balloon.css/)

:::note
If you are planning to add tooltips on the Icon element, please wrap the Icon element in a Div element and set the attribute on the Div element. Otherwise, balloon library CSS will overwrite the Icon element's CSS and cause it invisible in the frontend.
:::

#### Resources:

- HTML attribute reference: [https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes)

---


## Custom Authentication Pages

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/custom-authentication-pages/*

Since Bricks 1.9.2, you can create custom pages for the various authentication processes, effectively substituting the standard WordPress authentication pages.

![Bricks custom authentication settings screen showing options to assign custom pages for login, registration, lost password, and reset password. The ‘WordPress authentication page access’ dropdown is set to 'Error page,' and the ‘Disable custom authentication page bypass’ toggle is enabled.](imgs/bricks-custom-authentication-settings-0e4ab11487.png)

## How to set custom authentication pages

1. Navigate to the WordPress dashboard
2. Navigate to **Bricks** > **Settings** > **General**
3. Scroll down to **Custom authentication pages**

Here, you can choose a custom page for the following processes:

- Login
- Registration
- Lost Password
- Reset Password

## Setting up your custom pages

When creating these custom pages, it's essential to use the "Form" element on those pages with the appropriate authentication actions set under the "Actions" control group of your form.

:::note
For detailed information on setting up form actions and other features of the Form Element, please refer to the [Form element](/builder/elements/general/form/#actions) article.
:::

For instance, for a login page, you should have a form that includes fields for username/email and password, with the "User Login" action set.

## WordPress authentication page access {#wp-auth}

As of Bricks 1.11, you have control over what happens when someone visits a default WordPress authentication URL (such as `wp-login.php`), provided custom authentication pages are set.

To manage this:

1. Navigate to **Bricks** > **Settings** > **General** > **Custom authentication pages**.
2. Under **WordPress authentication page access**, select one of the following options:
  - **Redirect to custom authentication page (default)**: The user will be redirected to the corresponding custom authentication page you’ve set.
  - **Error page**: Visitors will be redirected to the 404 error page, effectively blocking access to the default WordPress login page.
  - **Home URL**: Redirects visitors to your homepage.
  - **Redirect to specific page**: Allows you to choose a specific page on your site to redirect visitors to.

This feature is particularly useful if you want to prevent access to the default WordPress login page (`wp-login.php`) entirely. For example, combining this with the bypass disabling feature (below) will fully restrict access to the default authentication URLs.

## Bypassing custom login (since 1.9.4):

By default, when visiting any authentication page on your site, you can access the default WordPress login page by adding `brx_use_wp_login` as a URL parameter (e.g., https://example.com**/wp-login.php?brx_use_wp_login=1**). This feature allows users to bypass the custom login page if needed.

In Bricks settings, you have the option **to disable this feature**:

- Navigate to Bricks > Settings > General > Custom authentication pages.
- Check the **Disable custom authentication page bypass** setting to force the use of your custom authentication pages, preventing access to the default WordPress login page through the URL parameter.

---


## Custom Code

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/custom-code/*

Bricks allows you to add your own custom code (CSS, JavaScript, HTML, PHP) to various parts of your website.

https://www.youtube.com/watch?v=LiYwBZ_R-f8

## Global CSS & JavaScript

You can add your own **Custom CSS** & **Custom JavaScript** globally from your WordPress dashboard under **Bricks > Settings > Custom Code**.

Custom scripts (JavaScript) can be added in three different (document) locations:

- **Header scripts**: Adds your scripts right before the closing  tag. This is where you want to copy & paste tracking scripts, etc.
- **Body (header) scripts**: Adds your scripts right after the opening  tag.
- **Body (footer) scripts**: Adds your scripts right before the closing  tag.

## Page-Specific CSS & JavaScript

To apply custom CSS & JavaScript to a specific page, edit this page with Bricks. Go to **Settings > Page Settings > Custom Code**. There, you can add your custom CSS & JS that should only be applied to the page you are currently editing.

## Element-Specific Custom CSS {#custom-css}

![](imgs/bricks-1.9.1-custom-css-root-placeholder-591x1024-232b04106b.png)

Extend the styles of any element and global class by adding your own custom CSS to it.

First, edit the element to which you want to add your own custom CSS.

Under the "Style" tab, open the "CSS" control group.

There, you can find the Custom CSS code editor.

Use the `**%root%**` placeholder to target the element or global class you are currently editing. Bricks automatically converts this**`%root%**` placeholder to your element ID or global class.

Keyboard shortcode to insert **`%root%**` is "r + TAB".

The screenshot on the right illustrates how to add a 1px width red border to an element.

### CSS code completion via Emmet

You can use CSS abbreviations to write your CSS even faster. Instead of writing `margin: 10px`, simply type `m10` and press the TAB key.

[https://docs.emmet.io/css-abbreviations/](https://docs.emmet.io/css-abbreviations/)

## Code Element (PHP, HTML, CSS, JS) {#code-element}

The "Code" element allows you to execute your own code (PHP, HTML, CSS & JS) anywhere on any page.

By default, the code added to the Code element is displayed as a code snippet.

In order to execute your code, you need to first enable **"Code Execution"** for the appropriate user role or user in your WordPress dashboard under "Bricks - Settings - Custom code" (see the screenshot below).



![](imgs/bricks-builder-code-execution-1024x803-04ea3793e3.png)

<figcaption>

Code Execution: Enabled for user role "Administrator"

</figcaption>



Make sure to only enable code execution for users & user roles you trust 100%.

### How to add PHP & HTML code to your element {#execute}



![](imgs/bricks-builder-code-element-execution-691c12e5a9.png)

<figcaption>

Code Element: Executing HTML & PHP code

</figcaption>



Once you've enabled code execution you can start adding the "Code" element wherever you want to execute your code.

You'd usually execute PHP & HMTL code, as CSS & JS can be added much easier via the solutions outlined above.

Once you've added the Code element to your page, you can add your custom code to it (as shown in the screenshot ).

To run/execute the code, enable the "**Execute Code**" setting. Otherwise, the code just shows as a code snippet.

:::note
Click the "Sign code" icon at the top-right of the code editor (or CMD/CTRL + R) once you've finished editing your executable code.
:::

### HTML Code Completion via Emmet

You can use abbreviations to generate your HTML structures much faster via a familiar CSS-based syntax.

**Abbreviation:** `#header` (+ TAB key)

**Generates:** ``

**Abbreviation:** `h$[title=item$]{Header $}*3`

**Generates:**

```php
<h1 title="item1">Header 1</h1>
<h2 title="item2">Header 2</h2>
<h3 title="item3">Header 3</h3>
```

[https://docs.emmet.io/cheat-sheet/](https://docs.emmet.io/cheat-sheet/)

---


## Element Conditions

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/element-conditions/*

Element Conditions let you define one or multiple conditions for any element. Only if those conditions are met is the element rendered on the front end.

Conditions are validated server-side and are meant to filter out/not load an element based on data (post, user, dynamic data, date & time, etc.).

Not rendering an element means **the element HTML doesn't exist in the source code**.

This is perfect for restricting content to logged-in users or users with a specific role (e.g., membership sites) to hide time-sensitive information according to a certain weekday/date/time, according to dynamic data, etc.

If you need full programmatic power to define your element conditions, use the [bricks/element/render](/developer/hooks/filters/filter-bricks-element-render/) Bricks filter.

## Accessing conditions

When editing an element, click the "Conditions" (toggle) icon in the panel header to open/close the element conditions interface. You'll see the "Conditions" toggle icon in the structure panel if an element has conditions. Click the icon to jump right into the conditions interface for this element.

![](imgs/bricks-render-conditions-toggle-7b4fd2dd15.png)

## How element conditions work

At least one set of conditions must be fulfilled to render the element. This means all conditions inside a condition "set" must be evaluated to be true.

So there is an OR relationship between condition sets and an AND relationship between conditions inside a set.

To add your first set of conditions, click the "+" icon next to the "Conditions" title:

![](imgs/bricks-render-conditions-add-condition-a94f98d731.png)

We now have one set with one condition. Every condition consists of the following three properties:

- **Key** (post ID, user role, date, dynamic data, etc.)
- **Comparison operand** (==, !=, >, &lt;, contains, before, after, etc.)
- **Value** (numeric, text, checkbox, select option(s), etc.)

Let's say we want to show an element only to logged-in users. We'd create the following condition:

![](imgs/bricks-render-conditions-user-is-logged-in-03bf483a2f.png)

This element is only rendered when the person viewing this page is logged in.

Non-logged-in guests, bots, crawlers, etc., will not be able to see this element (as it's not in the source code).

## Conditions indicator

Notice the highlighted "Conditions" icon in the screenshot above. It's a great indicator to see at a glance if the element you are editing has any conditions (without having to open the conditions interface).

The "Conditions" (toggle) icon is also visible next to an element in the structure panel to quickly scan for element conditions on your page. A click on it brings you right into the conditions interface.

## Checking multiple conditions

Between a set of conditions exists an **OR** relation. And conditions within a set have an **AND** relation.

Let's create a second set of conditions (by clicking the "+" icon at the top-right again) to illustrate this.

The condition in this new set is fulfilled (true) if the post title is "Account".

As there is an OR relation between condition sets, the element is rendered if (1) the user is logged in **OR** (2) the title of the post/page being viewed is "Account".

![](imgs/bricks-render-conditions-groups-dfdde150b2.png)

## Combining AND & OR conditions

Let's extend the conditions for this element by checking if the logged-in user has been registered before the 1st of Jan 2022.

As there is an AND relation between conditions inside a set, we'll click the "+" bottom on the bottom-right of our first condition to add another condition to this first set like this:

![](imgs/bricks-render-conditions-and-or-5ba5a0b165.png)

You'll also notice the vertical "**AND**" label between conditions inside a set.

And the horizontal "**OR**" label between condition sets.

We hope this helps to visualize the element conditions logic even better.

### How to compare dynamic data against the value {#dynamic-data}

:::note
The element conditions, by default, compare against the label.
:::

Certain dynamic data provider fields allow you to specify the value & label (e.g., [ACF true false](/builder/dynamic-content/dynamic-data/#acf), Metabox checkbox list, radio, select, etc.).

To compare against the value instead, you can use the `:value` filter like this:

![](imgs/bricks-1.5.7-dynamic-data-value-filter-1350e1f8cd.png)

In the example above, the condition is fulfilled when the Metabox checkbox list has the `blue` value selected. Without the `:value` filter, the condition would compare against the checkbox option label.

## Element Conditions API {#api}

The following information is intended for developers who wish to extend the default element conditions interface programmatically (`@since 1.8.4`).

The custom element condition that we will create should resemble the following example:



![](imgs/custom-condition-in-bricks-3f51fb8f74.png)

<figcaption>

Builder: New condition group with "Post type" option

</figcaption>



### Step 1: Add condition group via filter:  bricks/conditions/groups {#bricks-conditions-groups}

```php
add_filter( 'bricks/conditions/groups', 'add_my_condition_group' );
function add_my_condition_group( $groups ) {
  // Ensure your group name is unique (best to prefix it)
  $groups[] = [
    'name'  => 'my_group',
    'label' => esc_html__( 'My Group', 'my-plugin' ),
  ];

  return $groups;
}
```

### Step 2: Add condition options via filter: bricks/conditions/options {#bricks-conditions-lists}

In this example, we'll create a new condition to compare the current page post type with the user's value. The compare is a dropdown with "is" and "is not" options. The value field type is a `text` input.

```php
add_filter( 'bricks/conditions/options', 'add_my_custom_condition' );
function add_my_custom_condition( $options ) {
  // Ensure key is unique, and that group exists
  $options[] = [
    'key'   => 'my_post_type',
    'label' => esc_html__( 'Post Type (New)', 'my-plugin' ),
    'group' => 'my_group',
    'compare' => [
      'type'        => 'select',
      'options'     =>  [
        '==' => esc_html__( 'is', 'my-plugin' ),
        '!=' => esc_html__( 'is not', 'my-plugin' ),
      ],
      'placeholder' => esc_html__( 'is', 'my-plugin' ),
    ],
    'value'   => [
      'type'        => 'text',
    ],
  ];

  return $options;
}
```



![](imgs/custom-condition-in-bricks-example01-87211f30e8.png)

<figcaption>

Expected result: New condition in the builder

</figcaption>



### Step 3: Execute your logic to return a Boolean result via filter: bricks/conditions/result {#bricks-conditions-result}

Based on your custom logic, return `true` or `false` for your condition. Bricks take care of the `OR` and `AND` conditions.

In this example, we check if the current post type matches the user value.

If the condition is met, return `true`.

You can access the `$condition` variable, which has been set inside the builder.

```php
add_filter( 'bricks/conditions/result', 'run_my_custom_condition', 10, 3 );
function run_my_custom_condition( $result, $condition_key, $condition ) {
  // If $condition_key is not 'my_post_type', we return the $render as it is
  if ( $condition_key !== 'my_post_type' ) {
    return $result;
  }

  // Now you can perform your logic by using the $condition variable
  // $condition['compare'] is the compare operator, might be empty
  // $condition['value'] is the user value, might be empty

  // In my example, if compare is empty, we set it to '==' as default
  $compare    = isset( $condition['compare'] ) ? $condition['compare'] : '==';
  $user_value = isset( $condition['value'] ) ? $condition['value'] : '';

  $condition_met = false;

  // Get the current post type of the page
  $current_post_type = get_post_type();

  switch( $compare ) {
    case '==': // "is"
      $condition_met = $current_post_type === $user_value;
      break;
    case '!=': // "is not"
      $condition_met = $current_post_type !== $user_value;
      break;
  }

  return $condition_met;
}
```

If you have added multiple options under the same group, you can target them like this:

```php
add_filter( 'bricks/conditions/result', 'run_my_custom_condition', 10, 3 );
function run_my_custom_condition( $result, $condition_key, $condition ) {

  $condition_options = \Bricks\Conditions::$options;
  $registered_condition = $condition_options[ $condition_key ];
  if ( $registered_condition['group'] !== 'my_group' ) {
    return $result;
  }
  // Now you can perform your logic by using the $condition variable
  // $condition['compare'] is the compare operator, might be empty
  // $condition['value'] is the user value, might be empty

  $condition_met= false;

  switch( $condition_key ) {
    case 'my_condition_option_1':
      // Example
      $condition_met = execute_my_logic_1( $condition );
      break;
    case 'my_condition_option_2':
      // Example
      $condition_met = execute_my_logic_2( $condition );
      break;
  }

  return $condition_met;
}
```

---


## Global Elements

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/global-elements/*

:::note
**Global elements are officially deprecated since Bricks 2.0! Please convert all existing global elements into components using the new converter under Bricks > Settings > General > Global elements as soon as possible as we will remove global elements render completely in a future 2.x release.**
:::

To reuse an existing element somewhere else on your site we can convert this element into a **Global Element**.

## How To Create A Global Element

Once you've finished editing your element (content & styles), right-click onto your element to reveal the custom context menu. Then click **Save as global element**.

Your element is now available as a global element at the bottom of your elements panel under the **Global Elements** group.

You can now add this global element anywhere else on your site. Whenever you make changes to a global element (content & styles) those changes are automatically applied in real-time to any other instance of this global element throughout your entire site.

:::note
When you save an element as a global element you save the selected element only. Its children are not saved as those are different elements. If a container contains other elements, and you'd like to save all of them, you have to [save it as a template](#multiple-elements).
:::

https://youtu.be/Ny7qucg8pvM

## Saving multiple elements as a template {#multiple-elements}

When you want to add multiple elements as a "global" reusable component, the way in Bricks is to add them into a "section" template type. Just right-click in the container and select "Save as template" or edit the container and you'll find a save icon on the edit element panel, to save the container (and its children elements) as a Bricks template.

You may add this section to your templates or pages using the Template element or the Shortcode element (using the template shortcode). Whenever you change the original section template content, it will automatically change inside the pages where you add it using the Template element or the Template shortcode.

If you opt to insert the template directly (Templates popup > Insert) the template won't change whenever you update the original section template.

---


## Icon Manager

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/icon-manager/*

Bricks 2.0 introduces the **Icon Manager**, a new feature for uploading and managing your own custom SVG icon sets directly inside the builder. The Icon Manager makes it easy to create and maintain a consistent icon system across your site.

![](imgs/bricks-icon-manager-e6ae063eaa.png)

## Accessing the Icon Manager

To open the Icon Manager, go to **Settings > Icon Manager** in the builder toolbar, or click the **gear icon** within any icon control.

This opens a popup where you can manage both built-in and custom icon sets.

## Core functionalities

### Upload and manage custom icon sets

You can create your own icon sets by uploading a collection of SVG files. Each icon set is organized by name and can include as many icons as needed.

- **Create a new icon set** by entering a new name in the "Create icon set" field and click save
- **Upload SVG files** individually or in bulk from the WordPress media library
- Each icon in the set becomes available in all icon controls

#### Enable or disable icon sets

To keep your icon selection streamlined, you can disable any icon set, including built-in ones (i.e. FontAwesome). Disabled sets won't appear in the icon picker, but any icons already used on the page will still display and render as expected.

---


## Interactions

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/interactions/*

Interactions, available since Bricks 1.6, let you bind certain user or browser events (e.g. click, mouse hover, content loaded, etc.) to trigger specific actions like show/hide an element or popup, add/remove/toggle CSS classes or HTML attributes, start animations, load more query loop results, etc.

:::note
You can also define interactions on your global classes instead of the individual element. Useful for interactions you plan on using throughout your site.
:::

Running interactions inside the builder is not supported. Please preview your page on the front end to confirm your interactions are running as expected.

## Accessing interactions {#access}

When editing an element, click the “Interactions” (toggle) icon in the panel header to open/close the element interactions interface.

![](imgs/element-interactions-toggle-0d0978cd97.png)

If an element has interactions, you’ll also see the “Interactions” toggle icon in the structure panel. Click the icon to open the interactions interface of this element.

## Adding interactions {#add}

To add an interaction to an element, click the "+" icon next to the "Interactions" title. You can add as many interactions to an element as you like. Clicking on the title of a specific interaction allows you to rename it.

![](imgs/element-interactions-add-fbe261ba1d.png)

Each interaction is defined by a `trigger`, `target`, and `action`.

![](imgs/element-interactions-add-first-6de266f2aa.png)

## Interaction: Trigger {#trigger}

The **Trigger** is the event that triggers this interaction. The event can be bound to the element itself (click, mouse hover, focus, blur, mouse enter, mouse leave, enter/leave viewport) or to the browser window (scroll, content loaded, mouse leave the window). Avaiable triggers as below:

- Click
- Hover
- Focus
- Blur
- Mouse enter
- Mouse leave
- Enter viewport
- Leave viewport
- [Animation end](#animation-end)
- [Query AJAX loader (Start / End)](#query-ajax-loader)
- [Form Submit](#trigger-form-submit), [Form Success](#trigger-form-success), [Form Error](#trigger-form-error)
- Scroll
- Content loaded
- Mouse leave window
- [Filter : Empty / Not Empty](#trigger-filter-empty-or-not-empty) (@since 1.11)
- WooCommerce (@since 2.0)
  - Added to cart
  - Remove from cart
  - Cart updated
  - Coupon applied
  - Coupon removed

## Interaction: Action {#action}

The **Action** is the logic that runs when the event is triggered. Here are the available actions in Bricks:

- Show element
- Hide element
- Set attribute
- Remove attribute
- Toggle attribute
- [Toggle offcanvas](#toggle-offcanvas) (@since 1.11)
- Load more (Query Loop)
- [Start animation](#animation-start)
- [Scroll to](#scroll-to)
- [JavaScript (Function)](#javascript)
- Open address (Map) (@since 2.0)
- Close address (Map) (@since 2.0)
- Clear form (@since 2.0)
- Browser Storage (Add, Remove, or Count)

The **Target** is the element on the page that the action affects. The target could be the element itself (default), a [CSS selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors), or a Popup.

By default, the interaction runs every time the event occurs (e.g., on every click on the element). Enable the "**Run only once**" checkbox if you want the interaction to only occur once on each page load.

### Action: Scroll To {#scroll-to}

Set up automatic scrolling to a specific element when certain events occur on your page. Additionally, you have the flexibility to fine-tune the behavior using the "Scroll to: Offset (px)" and "Scroll to: Delay (ms)" settings to meet your precise requirements.

Here's an example to illustrate how it works:

![](imgs/bricks-interactions-scroll-to-action-595cb72d63.png)

In this scenario, after the "Posts Query" AJAX call finishes, the page will smoothly scroll to the element with the CSS selector `#my-grid-wrapper`, waiting for `500 milliseconds` before initiating the scroll.

### Action: Toggle Offcanvas {#toggle-offcanvas}

Starting from version 1.11, a new action allows you to toggle the Offcanvas element using any element. Previously, only the Toggle element could interact with the Offcanvas. Please note: do not apply this action directly to the Toggle element itself.

![](imgs/new-toggle-offcanvas-interaction-action-97465c8cca.png)

### Action: JavaScript (Function) {#javascript}

With the release of Bricks 1.9.5, you have the ability to execute your own JavaScript functions directly from the Interactions panel.

:::note
Only JavaScript functions within the global scope can be executed.
:::

To illustrate this, let's go over a few custom JavaScript function examples:

```php
<script>
window.myHelperFunctions = {}

myHelperFunctions.myCall = () => {
  console.log('myCall executed')
}

myHelperFunctions.nestedFn = {
  fn1: () => {
    console.log('fn1 executed')
  },
  fn2: () => {
    console.log('fn2 executed')
  }
}

// toggleMiniCart is a global scope function
function toggleMiniCart() {
  // run() is not a global scope function
  const run = () => {
    document.querySelector('.bricks-woo-toggle').dispatchEvent( new Event('click') )
  }
  setTimeout( run, 100 )
}
</script>
```

To execute the above functions, just enter the function name in the `Function` name (JavaScript) field. **Without parentheses or the window object!**

- To execute `myHelperFunctions.myCall()` : `myHelperFunctions.myCall`
- To execute `myHelperFunctions.nestedFn.fn1()`: `myHelperFunctions.nestedFn.fn1`
- To execute `myHelperFunctions.nestedFn.fn2()`: `myHelperFunctions.nestedFn.fn2`
- To execute `toggleMiniCart()`: `toggleMiniCart`
- You cannot execute the `run()` inside `toggleMiniCart` as it is not a global scope function

:::note
**IMPORTANT:** If you are targetting multiple elements through the "CSS Selector", Bricks iterates over each target element and executes the associated function.
:::

### JavaScript function arguments {#custom-javascript-arguments}

You can further enhance the versatility of your custom JavaScript functions by passing arguments directly to them. This is made possible through the use of the `Arguments` repeater control. Remember to arrange the order of your arguments to avoid any JavaScript errors.

The `%brx%` placeholder serves as an argument for your custom functions. By setting `%brx%` as an argument value, you gain access to valuable information related to the interaction:

- `param.source` (source element) : The interaction's source element node is the element that triggered the interaction in the first place.
- `param.targets` (target elements): An array of target elements node based on your target setting.
- `param.target` (target element): The target element node.

Here is an example to retrieve that information in a function:

![](imgs/bricks-interaction-action-javascript-function-38f6a3b715.png)

```php
// Play or pause a video element
// Click interaction that runs this custom JavaScript function
function playOrPauseVideo( brxParam, postId ) {
  const target = brxParam?.target || false
  // You can access targets (array) and the source element too
  // const targets = brxParam?.targets || false
  // const source = brxParam?.source || false

  if ( target ) {
    // Find the first video tag from my target node
    const video = target.querySelector('video')
    if ( video && video.play && video.pause ) {
	  // Pause or Play
      if ( !video.paused ){
        video.pause()
      } else {
        video.play()
      }
    }
  }
}
```

## Interaction: Conditions {#conditions}

Interaction conditions are an optional, more advanced feature. Allowing you to run an interaction only if certain conditions related to the browser storage (`window`, `sessionStorage`, `localStorage`) are fulfilled.

You can set "Interaction conditions" when editing an interaction like this:

![](imgs/bricks-interaction-conditions-ae177c21cf.png)

The interaction example above is fulfilled when the value of `window.some_key` is `some_value`.

The "Relation" setting lets you define if one (OR) or all (AND) interaction conditions must be fulfilled in order for the interaction to run.

### Example: Open a newsletter popup on click {#example-open-modal}

In this example, we want to add a "subscribe newsletter" button to the site's footer. A click on this button should open a popup that contains our newsletter subscription form.

To create the modal/popup, we need to create a popup template first. Let's name it "Newsletter popup".

Make sure to set the template conditions of your newsletter popup to "Entire website".

In your footer template, add a button and set the following interaction:

![](imgs/element-interactions-example-click-8be9715c82.png)

Now every time someone clicks this newsletter button in the footer of your website, your newsletter popup shows.

### Example: Show custom tooltip on hover

Let's create a custom tooltip next to a text element. The following example uses a "Basic Text" and an "Icon" element:

![](imgs/custom-tooltip-1-af50f6031e.png)

To show a custom tooltip near the "?" icon, we'll have a hidden element (e.g. Div + Text), where the Div has a custom class `.my-tooltip`, and it will be shown when the mouse is over the icon.

For this, we need to create two interactions on the Icon element. One to show the tooltip and another to hide the tooltip, like this:

![](imgs/element-interactions-custom-tooltip-90979ca128.png)

The end result, with some more styling, could look like this:

![](imgs/tooltip-80d3c6b04f.gif)

### Example: Create a toggle button (e.g. nestable accordion open/close icon)

We can create a toggle button like the mobile menu toggle using element interactions.

![](imgs/open-close-0868746b23.gif)

The idea in this example is to add two Icon elements inside a Div.

One of the icons shows when the button is not *active* and the other icon shows when the button is *active*.

We'll also add custom CSS and custom classes to the Div and the icons. The Div should have a custom class `.toggle-button` with the following custom CSS:

```php
%root% .toggle-close-icon {
  display: none;
}

%root%.is-open .toggle-open-icon {
  display: none;
}

%root%.is-open .toggle-close-icon {
  display: block;
}
```

The default icon should have the class `.toggle-open-icon` and the *active* icon the class `.toggle-close-icon`.

Finally, we need to set the element interactions.

The idea is to add and remove the class `.is-open` on the Div. So, when we click on the default icon, the `.is-open` class is added, and when we click on the *active* icon, the `.is-open` class is removed.

For this to happen in the default icon, we set the following interaction:

![](imgs/interaction-default-icon-edec9628d1.png)

On the *active* icon we set the opposite interaction:

![](imgs/element-interaction-active-icon-fd84dca57b.png)

## Animations {#animations}

You can animate elements in Bricks through Interactions.

Bricks uses the popular [Animate.css](https://animate.style/) library to provide various pure CSS animations.

### Action: Start animation {#animation-start}

Adding the following interaction to an element runs the "jello" animation when someone clicks on the element.

![](imgs/bricks-interaction-start-animation-3dc90db6ad.png)

### Trigger: Animation end {#animation-end}

A significant enhancement introduced in Bricks `1.8.4` is the ability to perform actions when a set of animations ends. This opens up opportunities for creating seamless chains of animations or interactions.

![](imgs/bricks-interaction-animation-end-trigger-9560320e51.png)

The **Target Interaction ID** field allows you to specify a particular Interaction with the "Start animation" action to listen to.

If the specified Interaction does not have the "Start animation" action or is not set, this interaction setting will be ignored and will not be triggered.

To listen to any previous Interaction within the same Interaction group (either set on the element level or class level), you can leave the field empty.

If you wish to target an Interaction in a different interaction group, you must fill in the **Target Interaction ID** field accordingly.

![](imgs/how-target-interaction-id-works-1300227755.png)

In the example above, **uzfgcm** interaction will execute its action once the **xyyyeh** animation ends.

:::note
Avoid using the current Interaction ID as the Target Interaction ID. Bricks will ignore this setting to prevent potential infinite interaction loops that could consume excessive browser memory.
:::

<span id="bricks-animation-end-code"></span>

You can also listen to this event to execute more complicated JavaScript logic.

```php
// Listen to animation xyyyeh
document.addEventListener( 'bricks/animation/end/xyyyeh', (event) => {
  // Get the element from the event
  const element = event.detail.el || false

  // Do your magic here
})
```

### Special Consideration for Popups {#popup-animation}

Popups in Bricks have special behavior when it comes to animations.

To open or close a Popup automatically after an animation ends, you only need to define the "Start animation" action with any *In or *Out animation. This eliminates creating a separate Interaction to close or open the Popup based on the animation end trigger.

![](imgs/popup-special-consideration-32fccac1e0.png)



## Trigger: Query AJAX loader (Start/End) {#query-ajax-loader}

An excellent addition introduced in Bricks 1.9. These two new triggers are for advanced users to build their own AJAX loader if the native AJAX loader inside the Query loop setting is unable to meet their design needs. This helps to execute actions when Bricks AJAX initiates or concludes.

:::note
Bricks AJAX = Infinite Scroll, Load More, AJAX pagination, or Query Filter
:::

##### Example: Apply opacity 0.5 to a query div when AJAX starts and revert when AJAX ends

1. Create a grid layout for your query loop, then set a custom class for the grid with an opacity of 0.5.
2. Add an interaction to your grid so we can add and remove this class when AJAX starts and ends.

![](imgs/query-ajax-loader-trigger-01custom-css-3f4ddd3520.png)

![](imgs/query-ajax-loader-trigger-02-interactions-0c05f397c7.png)

<span id="bricks-ajax-start-end-code"></span>

You can execute your own JavaScript function when the Bricks AJAX starts or ends via `bricks/ajax/start` or `bricks/ajax/end` events. (@since 1.9)

```php
document.addEventListener('bricks/ajax/start', (event) => {
  // Get the queryId from the event
  const queryId = event.detail.queryId || false

  if (!queryId) {
    return
  }

  // Do your magic here
})
```



## Form {#form}

Bricks `1.9.2` introduces a set of exciting new features that enhance your ability to customize interactions creatively. In this release, we've introduced three new interaction triggers and corresponding JavaScript events to empower you in crafting dynamic user experiences.



![](imgs/form-new-interactions-12a3c0b50c.png)

<figcaption>

New triggers: Form Submit, Form Success, Form Error

</figcaption>



### Trigger: Form Submit {#trigger-form-submit}

This trigger occurs when the form has been submitted. It provides an opportunity to perform actions such as resetting or hiding specific elements before the form submission process takes place.

JavaScript example:

```php
document.addEventListener( 'bricks/form/submit', function ( event ) {
  // Access the element ID
  const elementId = event.detail.elementId;

  // Access the form data
  const formData = event.detail.formData;

  // Perform actions using elementId and formData
  console.log('Element ID:', elementId);
  console.log('Form Data:', formData);

  // You can now work with the elementId and formData in your event handler
});
```

### Trigger: Form Success {#trigger-form-success}

Occurs when a form submission was successful.

JavaScript example:

```php
document.addEventListener( 'bricks/form/success', function ( event ) {
  // Access the element ID
  const elementId = event.detail.elementId;

  // Access the form data
  const formData = event.detail.formData;

  // Access the raw response from AJAX
  const res = event.detail.res;

  // Do your magic here

});
```

### Trigger: Form Error {#trigger-form-error}

Is triggered when the form submission was not successful. Use this trigger to manage error scenarios.

JavaScript example:

```php
document.addEventListener( 'bricks/form/error', function ( event ) {
  // Access the element ID
  const elementId = event.detail.elementId;

  // Access the form data
  const formData = event.detail.formData;

  // Access the raw response from AJAX
  const res = event.detail.res;

  // Do your magic here

});
```

## Trigger: Filter: Empty / Not Empty {#trigger-filter-empty-or-not-empty}

Introduced in version 1.11, these two new interaction triggers available when the Query Filters feature is activated.

![](imgs/interaction-filter-empty-not-empty-fd01adf988.png)

The triggers allow you to show or hide elements based on whether the associated filter's options or values meet the specified conditions. This is particularly useful when you enable the "Hide empty" option for filter elements.

**Filter: Empty** is triggered when:

- Active filters, Checkbox, Radio, Select - No options are available.
- Datepicker, Range, Search - The current value is empty.

**Filter: Not Empty** is triggered when:

- Active filters, Checkbox, Radio, Select - Options are available.
- Datepicker, Range, Search - The current value is not empty.



:::note
These triggers should be used together to toggle the visibility of elements dynamically. Using only one might cause issues, such as the target element hiding after the first filter action but failing to reappear on subsequent actions, unless you have a specific requirement or plan in place.
:::

![](imgs/interaction-filter-empty-not-empty-example-eae62bce4a.png)

Example:
If the Filter - Select returns no options, hide the block wrapper to avoid an awkward empty display. Otherwise, the block remains visible. This behavior is dynamic and handled via JavaScript.

---


## Maintenance Mode

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/maintenance-mode/*

Bricks 1.9.4 introduces the **Maintenance Mode** feature. A straightforward way to manage your site's availability during updates or construction.

![](imgs/bricks-settings-maintenance-mode-2-0-d872498143.png)

**How to enable Maintenance Mode**

1. Log in to the WordPress dashboard.
2. Navigate to Bricks > Settings > Maintenance.

Here, you'll find several settings to configure:

- **Mode selection**: Choose `Disabled`, `Maintenance`, or `Coming Soon`. "Maintenance" mode (HTTP status code 503) indicates that your site is temporarily unavailable, signaling search engines to come back later. "Coming soon" mode (HTTP status code 200) indicates that your site is available for search engine indexing.
- **Template** *(optional)*: Assign a custom single template for your maintenance or coming soon mode.
  - **Render popups** *(optional)*: Enable this setting if you want Bricks popups to be rendered on the maintenance or coming soon template. This is **disabled by default**.
- **Bypass maintenance**: Customize access settings for different user roles.
- **Exclude posts/pages** *(since 2.0)*: Select specific pages or posts where Maintenance Mode should **not** be applied.

**Configuring role-based access**

In the "Bypass maintenance" setting:

1. Select from the dropdown menu: `Logged-in users` allows all logged-in users to bypass maintenance mode; `Logged-in users with role` provides a more granular control.
2. If `Logged-in users with role` is selected, checkboxes will appear to enable or disable maintenance mode bypass for specific roles such as Editor, Author, Contributor, etc.

**Individual user access settings**

To configure access on an individual user level:

1. From the WordPress dashboard, go to "Users".
2. Click to edit a specific user's profile.
3. In the user profile, find and adjust the "Bypass Maintenance" setting. This allows you to enable or disable maintenance mode bypass for that user, overriding the broader role-based settings.

<span id="filters"></span>

**Filters:**

- [/developer/hooks/filters/filter-bricks-maintenance-should_apply/](/developer/hooks/filters/filter-bricks-maintenance-should_apply/)

---


## Menu Builder

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/menu-builder/*

Bricks 1.8 introduced a completely new, fully responsive, accessible, and highly customizable suite of elements to create nav menus/site navigations in Bricks.

https://www.youtube.com/watch?v=1GbJx0JnDDE

The new menu builder consists of 5 new elements (listed below), which you can mix, match, and configure to your liking to design all kinds of desktop & mobile menus.

There are some best practices to be aware of to ensure proper accessibility & styling. So please take the time to go over the information below to get a solid understanding of this new, powerful tool.

### Nav (nestable) {#nav-nestable}

This new nestable element contains both your desktop & mobile menu.

As with any other nestable element, you can now add any element to your menus in Bricks and are no longer limited to the old "flat" Nav menu.

There is a built-in setting for selecting the breakpoint at which you want to show your mobile menu. The mobile menu uses the same markup & elements as the desktop menu. It's just optimized & styled for mobile devices & small screens.

You can also design mobile menus with completely different content/elements by using the new Offcanvas & Toggle elements. Both of which we'll explore later on.

### Text link {#text-link}

A simple, but super handy new element to create simple nav menu text links (plus an icon if needed). This is much better than turning a Basic Text element into a link. You can, of course, use the Text link anywhere else on your site.

### Dropdown (nestable) {#dropdown}

Use the new Dropdown element to create fully accessible sub-menus. Which you can nest as many levels as you want by adding dropdowns within dropdowns. You can also choose when to trigger a dropdown (on hover, click, or both).

The little dropdown arrow next to the dropdown text/link lets you always toggle the Dropdown via the keyboard (on SPACE or ENTER press) for accessibility.

A Dropdown can be turned into a fully-fledged nestable mega menu in one click. Covering the entire width of the viewport or adapting to the width and vertical position of any other element on your page.

You can even create multilevel mobile menus where only the active dropdown slides into the view.

We also got settings to easily design custom dropdown carets.

### Toggle {#toggle}

The main purpose of this new, fully-accessible "hamburger" toggle icon/button is to show/hide your mobile menu and/or Offcanvas elements.

You can choose from various animation effects, and even set your own custom toggle icon.

The Toggle automatically detects the Offcanvas or Nav (Nestable) context it is placed in. If you have multiple toggleable elements or want to trigger a specific one, simply enter its "CSS selector" into the control field.

You can use it for so much more, though. As it provides settings to toggle any HTML attribute of any element on your page.

Similar triggers can be achieved via [Interactions](/builder/features/interactions/). But the Toggle comes with built-in accessibility & menu builder logic that makes the whole toggle process so much faster, easier, and better.

### Offcanvas (nestable) {#offcanvas}

Being nestable, the new Offcanvas element lets you create unique mobile menus with completely different content from your desktop menu. You can populate the Offcanvas with any elements you like, and are not limited to menus, though.

The Offcanvas comes with two effects: slide-in (default) & offset, and can be toggled (open/close) through the "Toggle" element. It's super simple as you can see in the [Offcanvas set up](#mobile-menu-offcanvas) section down below.

Starting at Bricks 1.11, [the new "Toggle Offcanvas" interaction](/builder/features/interactions/#toggle-offcanvas), let's you toggle your Offcanvas from any element.

## Default menu structure {#menu-structure}

When adding a **Nav (Nestable)** element to the canvas it is populated with 2 Nav links, 1 Dropdown, and 2 Toggle elements (to show & hide the mobile menu).

![](imgs/bricks-1.8-nav-nestable-default-structure-950a0ebb49.png)

Being a nestable element, you can add any Bricks element inside your menu.

The "Nav items" Block is a special element that can't be deleted individually as it holds all top-level menu items, and serves as the mobile menu wrapper. The same goes for the "Content" Div inside the Dropdown element, which contains all dropdown content.

All top-level menu items are automatically wrapped in a `li` HTML tag for accessibility. The "Nav items" uses an `ul` tag. The same goes for the "Dropdown structure.

## Default mobile menu structure {#mobile-menu}

By default, the mobile menu becomes visible at the "Mobile landscape" breakpoint. Meaning instead of displaying the top-level menu items, a (hamburger) Toggle becomes visible that opens the mobile menu when you click on it. You can, of course, select any other breakpoint to start showing your mobile menu when editing your Nav nestable element.

:::note
**IMPORTANT**: Make sure you are editing the "Mobile menu" and "Nav items" element settings on the breakpoint at which the mobile menu starts to display at (default: Mobile landscape).
:::

![](imgs/bricks-1.8-nav-nestable-mobile-menu-toggle-f476d2b096.png)

The Toggle element labeled "Toggle (Open: Mobile)" opens the mobile menu (highlighted in the screenshot above).

You can choose from various animations that are performed on the Toggle when clicked.

The "Toggle (Close: Mobile)" element is located inside the "Nav items" (the mobile menu wrapper).

## Mega menus {#mega-menu}

Creating mega menus with Bricks couldn't be easier. Just "Enable" the mega menu setting when editing the "Dropdown" element of your choice.

By default, the Dropdown Content covers the entire available (viewport) width like this:

![](imgs/bricks-1.8-dropdown-mega-menu-24cff55c92.png)

You can also define a "CSS selector" whose width & horizontal position the mega menu will adjust to. The following screenshot uses the element `id` of its outer Container:

![](imgs/bricks-1.8-dropdown-mega-menu-css-selector-74c35edf4e.png)

The Dropdown "Content" is just a Div element. Allowing you to can create any mega menu layout:



![](imgs/bricks-1.8-dropdown-mega-menu-three-columns-715fda3ffe.png)

<figcaption>

A simple three-column mega menu

</figcaption>



### WordPress mega menu {#wp-mega-menu}

You can also add mega menus to your WordPress menu by enabling the "Mega menu" setting of your  "Nav menu" element like this:

![](imgs/bricks-1.8-nav-menu-mega-menu-cb007a21bf.png)

Next, create your mega menu using a new template (template type: section).

Then, go to "Appearance > Menus" and expand the top-level menu item you want to display this mega menu under, and select your mega menu template from the "Mega menu" options:

![](imgs/bricks-1.8-wordpress-mega-menu-a30e35b9ed.png)

Your mega menu template now appears when you hover over this menu item on the frontend.

## Multilevel dropdown menus {#multilevel}

Creating multilevel dropdowns is just as easy. Simply enable the "Multilevel" setting on an individual Dropdown or directly on the "Nav nestable" element so it gets applied to all your Dropdowns.

"Multilevel" means that only the active Dropdown Content is visible. This is especially useful for dropdown menus with a lot of items or for dropdowns with multiple nested Dropdowns, as they most likely overflow the viewport. Especially on mobile.

A customizable "back" link can also be set, which is displayed as the first item of every Dropdown level.

As only the active Dropdown is visible, the multilevel dropdown automatically toggles on click, not hover.

You also only have to enable "Multilevel" at the root level of your Dropdown. All sub Dropdowns have multilevel capability out-of-the-box.

### WordPress multilevel menus {#wp-multilevel}

Bricks 1.8 lets you turn your WordPress sub menus into multilevel menus too. Simply enable the "Multilevel" setting of your "Nav menu" element, and then activate the "Multilevel" setting of your WordPress menu items under "Appearance > Menus" like this:

![](imgs/bricks-1.8-wordpress-multilevel-menu-aa7d663b9b.png)

## Static (position) dropdown menus {#dropdown-static}

![](imgs/bricks-1.8-menu-builder-dropdown-position-static-54e9a5db5f.png)

By default, the dropdown content is positioned `absolute`. Taking it out over the document flow. Which is the expected/desired in a desktop menu.

But when, for example, the Dropdown is placed inside an Offcanvas you most likely don't want this behaviour.

Instead you want to show the dropdown content on click and positioned right underneath the dropdown toggle & in the normal document flow.

To accomplish that simply enable the "Position: Static" setting when editing the Dropdown of your choice.

## WordPress dropdown menus {#wordpress-menu}

To use a WordPress menu inside your custom nav nestable, add the "Nav menu" element inside your Dropdown > Content element. Then edit it, and select the WordPress menu you'd like to display inside your dropdown.

![](imgs/bricks-1.8-nav-menu-inside-dropdown-c270413a1b.png)

This means every WordPress menu you create for your nav nestable should hold the menu items you want to display inside a specific dropdown.

We have chosen this approach as it lets you take full advantage of the nav nestable customisation options, while still being able to control your menu via WordPress.

You can style this WordPress menu by editing the "Dropdown" it's been places in, or if you wish to style it like the entire menu you can tweak the "Dropdown" settings of your "Nav nestable".

## Unique mobile menus (Offcanvas + Toggle) {#mobile-menu-offcanvas}

Use the new Offcanvas element to create unique mobile menus. Or any other content you want to slide into view via the Toggle element.

Let's start by adding an Offcanvas element to our page.

:::note
Make sure you position the Offcanvas element outside the "Nav (nestable)". Otherwise, the Toggle logic of those two togglable elements can interfere. **We position it AFTER our "Nav nestable". **
:::

As we don't use the default mobile menu view of the Nav nestable, we can delete the "Toggle (Close: Mobile)" element.

We'll use the "Toggle (Open: Mobile)" element to open our Offcanvas element. Simply copy the Offcanvas element ID from the panel, edit the "Toggle (Open: Mobile)" element, and paste it under the "CSS selector" setting.



![](imgs/bricks-1.8-offcanvas-add-element-id-to-toggle-open-1835fc92b0.png)

<figcaption>

Toggle: "CSS selector" setting containing our Offcanvas element ID

</figcaption>



Save your changes, and head to the front end. A click on the Toggle icon should open your Offcanvas.

As the Offcanvas is a nestable element, you can add any layouts & elements inside of it.

The Offcanvas comes prepopulated with a close Toggle. Clicking outside the Offcanvas (on the backdrop) also closes the Offcanvas.

When editing the Offcanvas in the builder make sure to enable the "Keep open while styling" setting, so the Offcanvas does not disappear when you edit different elements.



![](imgs/bricks-1.8-offcanvas-element-keep-open-while-styling-89442cae93.png)

<figcaption>

Offcanvas: Enable the "Keep open while styling" setting while editing the Offcanvas content

</figcaption>



## Non-fullscreen mobile menus {#mobile-menu-non-fullscreen}

To show the default mobile menu without it covering the full screen, edit your Nav (nestable) and set the "Height" under "Mobile menu" to `fit-content`.

This way the height of your mobile menu automatically grows or shrinks according to its content.

![](imgs/bricks-1.8-menu-builder-mobile-height-fit-content-4fcc1a92fa.png)

Then set the "Position" of your "Mobile menu" to your liking, (see screenshot above) so it doesn't cover the Toggle.

As the "Nav items" element serves as the mobile menu wrapper, you can edit it to set your mobile menu padding, background, etc. Make sure you perform those styling changes on the breakpoint at which your mobile menu starts to show, so those styles only apply to the mobile, and not the desktop menu.

Now that the mobile menu no longer covers the entire screen, you can probably remove the "Toggle (Close: Mobile)" element that Bricks adds by default.

Bonus tip: To prevent the mobile menu from covering your Toggle, which might happen on certain screen sizes & positioning, edit the Toggle element and set it's `z-index` under "Style > Layout > Z-index" to a value of `1001` or more.

---


## Nestable Slider: Customization via JavaScript

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/nestable-slider-instance/*

Bricks introduced the Nestable Slider in version 1.5, utilizing the [SplideJS](https://splidejs.com/) library.

This article is intended for developers, walking you through how to access and customize the Splide instance.

All initialized Splide instances are stored and can be accessed through `window.bricksData.splideInstances`.

You must first identify the Nestable Slider element's unique ID to retrieve the appropriate instance from the variable. You can find this ID within the builder when editing this element or through your browsers' developer tools.

![](imgs/how-to-get-nestable-slider-id-a8d71424f3.png)

According to the example above, I can access my Splide Instance through `window.bricksData.splideInstances['rrbqsp']`

:::note
If you have assigned a custom CSS ID to the Slider, please note that this ID is not the same as the element ID. In such cases, you should obtain the correct element ID through your browser's developer tools.
:::

## Update Nestable Slider options via JavaScript {#update-slider-options}

Objective: Update `noDrag` option for all Nestable Sliders on the current page.

```php
<script>
document.addEventListener('DOMContentLoaded', (event) => {
  // Define a function to update the no-drag option for all splide instances on the page
  const updateNoDragOption = () => {
    for( const splideId in window.bricksData.splideInstances ) {
      const splideInstance = window.bricksData.splideInstances[splideId]
      if ( splideInstance ) {
        // Tell Splide that any elements with .no-drag class is not draggable
        splideInstance.options = { noDrag : '.no-drag' }
      }
    }
  }

  // Need some delay for Bricks to init the sliders
  setTimeout(updateNoDragOption, 250)
})
</script>
```

## Custom navigation arrows outside the slider {#custom-arrows}

Objective: Implement custom navigation buttons located outside of the Nestable Slider.

![](imgs/slider-structure-example-0faa73ebcf.png)

Please set unique classes for your buttons. We assigned the `my-prev` and `my-next` CSS classes in our example.

![](imgs/assign-css-classes-to-custom-slider-buttons-56e1e8bb95.png)

Next, place a Code element and write some simple JavaScript. Remember to turn **ON **the Execute code checkbox. (Arrows for the Slider remained **OFF**)

![](imgs/slider-arrows-off-07a45f6632.png)

![](imgs/code-element-for-custom-navigation-7179ca6e46.png)

```php
<script>
document.addEventListener('DOMContentLoaded', (event) => {
  // Give some times for Bricks to init the sliders
  setTimeout(() => {
    // Please replace rrbqsp to your Slider element ID !!NOT CSS ID!!
    const mySlider = window.bricksData?.splideInstances['rrbqsp'] || false
    // Please replace the button classes to suit your scenario
    const myPrevBtn = document.querySelector('.my-prev')
    const myNextBtn = document.querySelector('.my-next')

    if (mySlider && myPrevBtn && myNextBtn) {
      // Add click event handlers for your custom buttons
      myPrevBtn.addEventListener('click', function () {
        mySlider.go('-1') // go() function by SplideJS
      })
      myNextBtn.addEventListener('click', function () {
        mySlider.go('+1') // go() function by SplideJS
      })
    }
  }, 250)
})
</script>

```

---


## Password Protection

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/password-protection/*

Bricks 1.11.1 introduces a Bricks-native Password Protection feature, giving you a simple yet powerful way to secure content across your website without needing extra plugins.

Whether you want to lock down individual pages, posts, broader areas like custom post types, or even the entire website, you can create custom templates that control access with ease.

Customize the password entry experience, schedule when protection is active, and manage everything directly within Bricks.

## How to set up password protection

1. Enable this experimental feature under `Bricks > Settings > General > Password Protection`
2. **Create a password protection template**
  - From the WordPress dashboard, navigate to `Bricks > Templates` and create a new template.
  - Under **Template type**, select **Password protection**.
3. **Configure password protection settings**
  - Click **Edit in Bricks** to customize the template.
  - To access the password protection settings, go to `Settings > Template settings > Password protection`.
  - Available settings include:
    - **Password source:** Select how passwords are managed. Options are **Template password**, **Post password**, or **Template & post password**. See details on each method in the [password source options](#password-source-options) section below.
    - **Password:** Set the password for template-wide protection. This field is only available if the **Password source** is set to **Template password** or **Template & post password**.
    - **Disable header**.
    - **Disable footer**.
    - **Disable popups**.
    - **Allow logged-in users to bypass**.
    - **Schedule:** Schedule when the password protection is active.
      - **Start date:** Set the date and time when protection begins.
      - **End date:** Set the date and time when protection ends.

![](imgs/bricks-password-protection-settings-e713b1adb5.png)

![](imgs/bricks-password-protection-settings-group-63ee01c26d.png)

![](imgs/bricks-password-protection-settings-1-13b6e10096.png)

1. **Set template conditions**
  - Set [the template conditions](/builder/features/template-settings/#template-conditions) under `Settings > Template settings > Conditions` to define where this template applies.
  - For more dynamic control, use the [`bricks/password_protection/is_active`](https://academy.bricksbuilder.io/filter-bricks-password_protection-is_active) filter to customize when the template should be active or bypassed.

![](imgs/bricks-password-protection-template-conditions-e31525199e.png)

1. **Add form element for unlocking**
  - Add a **Form Element** to the password protection template.
  - Add an **Unlock password protection** form action. This action will allow users to unlock the protected content by entering the correct password.

![](imgs/bricks-password-protection-form-action-af97a38160.png)

## Password source options {#password-source-options}

The behavior of the password protection feature depends on the selected **password source** option. Below are details on how each option works and instructions for setup:

### Template password

Selecting **Template password** applies the password set in the template settings to all pages or posts that meet the template conditions. No further configuration is needed on individual posts. Simply:

- Set the password in `Settings > Template settings > Password protection > Password`.
- Define the template conditions under `Settings > Template settings > Conditions` to specify where this template will apply.

![](imgs/bricks-password-protection-template-password-2731f3656e.png)

For any content matching these conditions, the password form will be automatically rendered, restricting access to those pages.

### Post password

When **Post password** is selected, this template customizes the default WordPress password protection form but requires individual post-level password settings.

To protect content using the **Post password** method:

1. Enable password protection on each post or page through the WordPress editor.
2. Set a password directly on the individual post or page (or through quick edit).
3. The template conditions will control where the custom password form appearance applies, but protection is managed at the post level.

![](imgs/bricks-password-protection-wp-editor-63e8703975.png)

![](imgs/bricks-password-protection-post-password-79bf1bff93.png)

### Template & post password

The **Template & post password** option uses the template password by default. However, if an individual post password is set, it will take precedence.

Setup process:

1. Enter a password in **Password protection > Password**.
2. Define template conditions as needed to apply the password protection across relevant content.
3. For any posts with an individual password set, that password will override the template password.

![](imgs/bricks-password-protection-template-and-post-password-86673cf3d7.png)

This setup provides flexibility by allowing individual content to have unique passwords while maintaining general protection for all content under the template.

### Password protection filters: {#filters}

- [/developer/hooks/filters/filter-bricks-password_protection-cookie-expires/](/developer/hooks/filters/filter-bricks-password_protection-cookie-expires/)
- [/developer/hooks/filters/filter-bricks-password_protection-is_active/](/developer/hooks/filters/filter-bricks-password_protection-is_active/)

---


## Popup Builder

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/popup-builder/*

The Popup Builder is a very flexible, fully customizable solution to show popups anywhere on your website based on [Interactions](/builder/features/interactions/).

A popup in Bricks is just a template. To create our first popup, let's add a new template and select the new template type **Popup** like so:

![](imgs/popup-template-type-f2866d4885.png)

Save the new template, then edit it with Bricks.

You'll immediately notice that this template looks different than other Bricks template types.

The popup content shows centered on the canvas, there is a new "Template Settings" group named "Popup", and there is no "Populated Content":

![](imgs/popup-template-type-screen-a6367badf8.png)

Building out the content of your popup is the same process as on any other page or template in Bricks: You simply add the elements you need to the canvas via click and/or drag & drop.

## Popup conditions {#popup-template-conditions}

Use the [template conditions](/builder/features/an-intro-to-templates/#template-conditions) inside the builder under "*Settings > Template Settings > Conditions*" to tell Bricks where on your website this popup should appear.

![](imgs/popup-condition-8dd0a86489.png)

You can add as many popup templates to a page as you like.

## Popup settings {#popup-settings}

Popup-specific settings are located under "*Settings > Template Settings > Popup*".

The first control group lets you style the popup overlay & content:

![](imgs/popup-settings-31bd471773.png)

You can globally style your popups via the "Popups" control group inside your Theme Styles.

## Popup interactions {#popup-interactions}

Further down the popup settings panel, you'll find the **Interactions** control group.

This is where you define the trigger(s) to open/close the popup.

**Triggers** are browser events like "Content loaded", "Scroll" (by *X* px, *X* % of the body height or *X* vh (viewport height)), moving the mouse outside the window, etc.

A commonly used trigger is to show the popup once the content is loaded (e.g. newsletter popup, special offers, etc.). To do that, set a "Content loaded" interaction like so:

![](imgs/bricks-popup-builder-interaction-content-loaded-465x1024-2c6406a082.png)

:::note
**NOTE**: Clicking outside the popup content (on the overlay) or pressing the ESC key closes the popup.
:::

***If no interactions are defined on the popup itself or any other element on the page that triggers the popup to show, the popup remains hidden***.

## Popup limit {#limit}

By default, the popup shows every time it is triggered by an interaction.

You can also define popup limits under "*Settings > Template settings > Popup > Popup limit*" when editing your popup template.

Once a limit has been reached, the popup is no longer displayed.

There are three types of popup limits, and the counter for each increases every time the popup is displayed:

| **Limit type** | **Browser storage** | **Description** |
| --- | --- | --- |
| Per page load | `window.brx_popup_{id}_total` | Resets after page load |
| Per session | `sessionStorage.brx_popup_{id}_total` | Resets after tab close |
| Across sessions | `localStorage.brx_popup_{id}_total` | Resets once deleted |

![](imgs/bricks-1.6-popup-limit-6a0a4a2748.png)

## Popup events & helper functions {#events-functions}

Below is a list of the available popup helper functions and events (JavaScript) for developers.

### Open or close popup via JS {#popup-js-functions}

You can use `bricksOpenPopup` and `bricksClosePopup` to programmatically open or close the popups created in Bricks.

Both of these functions accept the popup ID (= template ID) or popup element node.

### Example: Open Popup by selector {#open-popup-by-selector}

```php
// Open Popup ID 3321 if any element with .brxe-heading or .my-custom-selector class
document.querySelectorAll('.brxe-heading, .my-custom-selector').forEach( (el) => {
	el.addEventListener('click', () => {
		bricksOpenPopup(3321)
	})
})
```

### Example: Open a looping popup by query element ID and loop index on page load {#open-looping-popup-by-query-element-id-and-loop-index}

```php
// Open a selected looping popup where query Element ID is vfiqrn and loop index is 7
document.addEventListener('DOMContentLoaded', ()=>{
	// If you are using code element, set some delay after DOMContentLoaded to ensure windows.bricksIsFrontend set properly
	setTimeout( ()=>{
		const queryId = 'vfiqrn'
		const targetPopup = document.querySelector(`.brx-popup[data-popup-loop="${queryId}"][data-popup-loop-index="7"]`)
		bricksOpenPopup(targetPopup)

	}, 200)

})
```



### Listen to popup open or close events {#popup-js-events}

You can execute your own JavaScript function when the popup is opened or closed via `bricks/popup/open` or `bricks/popup/close` events.

<span id="bricks-popup-open-close-code"></span>

```php
// Listen to open event
document.addEventListener( 'bricks/popup/open', (event) => {
	// You can get the popup id
	const popupId = event.detail.popupId
	// You can get the popup element
	// const popupElement = event.detail.popupElement

	// Do your stuff here
	if (popupId == 3321) {
		console.log(`3321 popup is opened`)
	}
})

// Listen to close event
document.addEventListener( 'bricks/popup/close', (event) => {
	// You can get the popup id
	const popupId = event.detail.popupId
	// You can get the popup element
	// const popupElement = event.detail.popupElement

	// Do your stuff here
	if (popupId == 3321) {
		console.log(`3321 popup is closed`)
	}
})
```



## Popup setup examples {#popup-setup-examples}

### Example: Popup inside query loop {#query-loop}

You can also add a popup inside a query loop via the **Template** element. Inside the popup template, you can use dynamic data to display data of the loop item.

The screenshot below illustrates the setup for a "Quick view" button that shows a popup template with a "Add to cart" button, the product short description, etc.

We've also set an interaction on the button inside the query loop that shows our "Quick view" popup template when it's clicked.

![](imgs/bricks-1.6-popup-inside-query-loop-1024x403-ef8920cbec.jpg)

:::note
**NOTE (for Bricks version NOT** set interaction on the Query Loop div itself.
:::



![](imgs/query-loop-popup-template-interaction-structure-e7e219615e.png)

<figcaption>

Example layout structure to trigger a looping popup for Bricks version &lt; 1.7.1

</figcaption>



### Example: Show popup when the mouse leaves the browser window (exit intent) {#example-mouse-leaves}

After setting up the popup template, and creating the layout, go to "*Settings > Template Settings > Popup*", scroll down to the Interactions group, and add the following interaction:

![](imgs/popup-builder-mouse-leave-open-e2fe126189.png)

### Example: Add popup close icon (using interactions) {#example-close-icon}

To create a popup close icon that is triggered when clicking on it, let's add an Icon element to our popup. Any element works, though.

Tip: When editing the Icon element, set the "Cursor" style under Styles > Layout > Misc to "pointer". This offers a better visual hint that this is an interactive icon.

Open the **Interactions** panel when editing your Icon element, and create a new interaction of type "Click", set the target to"Popup", select the popup, and set the "Action" to "Hide element".

![](imgs/popup-close-icon-interaction-e9788ba5c5.png)

If you are planning to use this popup close icon in more places creating a global close popup element might be a good idea.

After saving this element as a [Global Element](/builder/features/global-elements/), you need to use a different approach when setting the close popup interaction so it can target any popup. In this case, use "CSS selector" as the "Target", and set the "CSS selector" to "`.brx-popup`", like so:

![](imgs/popup-global-close-icon-interaction-8689ee292d.png)

### Example: Show popup before a certain date/time (using element conditions)

While the template conditions determine on which pages the popup appears, you can further restrict a popup by defining [Element Conditions](/builder/features/element-conditions/) on the outermost popup element.

To only show a popup before November 1st, 2022, you'd set the following element condition on the outermost layout element of your popup:

![](imgs/bricks-popup-builder-element-conditions-1536x624-0a1291390f.png)

If this element condition is not fulfilled, meaning Nov 1st, 2022, is reached, then the popup HTML is no longer rendered. So even if the popup is triggered by an interaction, it won't show as there is no popup HTML to display.

## AJAX popup {#ajax}

Bricks introduces AJAX popups in `1.9.4`. The primary goal is to reduce the DOM size and queries of popups when they are used within query loops.

### Enabling AJAX content fetching for popups

When editing a popup template, simply enable the **"Fetch content via AJAX"** option. You can also specify an AJAX loader animation, which is placed inside the popup's `.brx-popup-content` by default. Keep in mind that for AJAX rendering, context is vital. Dynamic data from repeater rows (like ACF or Metabox) can't be displayed as they lack unique IDs, such as posts, terms, or users.

![](imgs/ajax-popup-controls-in-popup-template-b466209ee9.png)

### New popup interaction context settings

![](imgs/context-controls-in-interactions-ui-6937f45724.png)

These new settings can be found in the "Interactions" panel if your interaction is set to show a popup.

By default, Bricks automatically identifies the current context or object when opening an AJAX popup through interaction. This works regardless of whether you're within a query loop and covers various object types, such as posts, terms, or users.

### Why are these context settings necessary?

Consider creating a product quick view popup with all the related dynamic data in the popup template. When fetching this template via AJAX, it's crucial to inform Bricks about the current product (context). This ensures that all dynamic data populates correctly. Providing an incorrect context type and ID during the fetch can result in empty or inaccurate dynamic data. Remember that not all looping data can be the context in an AJAX popup. As an example, you cannot tell Bricks currently your context is a repeater few in N row of the repeater field.

### When to specify context type and ID?

In cases where you're inside a query loop, especially a nested query loop or a custom field repeater loop, Bricks may not detect the correct context automatically. In such instances, you should specify the Context Type (post, term, or user) and Context ID (post ID, Term ID, or User ID). You can use dynamic data like `{post_id}`, `{term_id}`, `{mb_related_agent:value}`, etc., to set these values.



![](imgs/example-for-woo-product-quick-view-setup-127b8af8af.png)

<figcaption>

A looping product quick view popup structure in Bricks

</figcaption>



### AJAX popup JavaScript events (@since 1.9.4) {#ajax-events}

New JavaScript events added related to AJAX Popup:

- `bricks/ajax/popup/start` - Emitted before making an AJAX popup call.
- `bricks/ajax/popup/end` - Emitted after completing an AJAX popup call.
- `bricks/ajax/popup/loaded` - Emitted after adding AJAX popup content to the DOM.

You can retrieve the `popupId` or `popupElement` by accessing `event.details.popupId` or `event.details.popupElement` as usual.

```php
// Listen to AJAX popup content loaded event
document.addEventListener( 'bricks/ajax/popup/loaded', (event) => {
    // You can get the popup id
    const popupId = event.detail.popupId
    // You can get the popup element
    // const popupElement = event.detail.popupElement

    // Do your stuff here
    if (popupId == 3321) {
      console.log(`3321 AJAX popup content DOM loaded. Init my custom element JS`)
    }
})
```

### Example: Open an AJAX popup with context in JavaScript (@since 1.9.4) {#open-ajax-popup}

Since `1.9.4`, `bricksOpenPopup` accepts 3 parameters.

- `object` - Either the popup element object or the popup ID
- `timeout` - This parameter is for the counter animation inside the popup (can be ignored if not needed).
- `additionalParams` - Used specifically for AJAX popups. Expect properties like popupContextId and popupContextType

```php
// To open the popup with ID 1190 (already set to fetch content via AJAX) with a context of post ID 668
bricksOpenPopup(
  1190,
  0,
  {
    popupContextId: 668,
    popupContextType: 'post'
  }
);


// To open the popup with ID 2350 (already set to fetch content via AJAX) with a context of term ID 39:
bricksOpenPopup(
  2350,
  0,
  {
    popupContextId: 39,
    popupContextType: 'term'
  }
);
```

---


## Remote Templates

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/remote-templates/*

Remote templates allow you to view & insert templates of another Bricks installation. Avoiding the constant template export from one site and then importing them on another site.

Public access to your templates is disabled by default. Follow the steps below to make your templates easily available as a remote template source.

## Step 1: Enable My Templates Access

First, you have to enable template access on the site whose templates you want to browse and insert.

In your WordPress dashboard, go to **Bricks → Settings → Templates** and enable the **My Templates Access** checkbox. With this setting enabled, your template library is accessible to anyone who knows your site URL.

It is recommended to restrict access by whitelisting URLs and/or password protection:

Use the **Whitelist URLs** setting to provide template access only to the specified URLs.

Set a password under **Password Protection** to restrict template access to people who know the correct password.

:::note
**Since Bricks 1.9.4, you can add unlimited remote template URLs!** Click the "Add" button to add another template URL. To remove a previously added remote source, clear the URL and password input fields and save your settings.
:::

![](imgs/bricks-settings-unlimited-remote-template-urls-d8f656cdc6.png)

Please ensure the **permalink structure** of this WordPress website (Settings > Permalinks) is set to something other than **Plain**.

![](imgs/permalink-structure-not-plain-type-for-remote-templates-01-86cd7b208f.png)

## Step 2: Remote Templates Settings

Log into the site you want to browse and insert templates from.

Go to **Bricks → Settings → Templates** and paste the URL of the Bricks site you want to retrieve templates from into the **Remote Templates URL** field.

If you've set password protection on the other website, make sure to enter the password under **Remote Templates Password**.

Then click **Save Settings**, open the builder, and then open the template library.

You should now see the remote template URLs added to the template `SOURCE` dropdown, as illustrated in the following screenshot:

![](imgs/bricks-builder-template-sources-3fd59e3094.png)

Since version 1.9.4, Bricks pulls in the latest template data every time you view a remote template source instead of storing it in your database. Guaranteeing you that you always work with the latest remote template data without having to worry about refreshing the remote templates every time.

---


## Save Form Submissions

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/save-form-submissions/*

Bricks 1.9.2 introduces an exciting new feature that allows you to capture form submissions. With the new `**Save form submissions in database**` setting, your Bricks experience is now even more powerful and versatile. In this article, we will delve into the details of this feature.

## How to enable {#how-to-activate}

You can find and enable the new `**Save form submissions in database**` setting under `Bricks > Settings > General > Form submissions`.

![](imgs/bricks-form-submissions-settings-a2d4832536.png)

After enabling it, save your settings. Bricks now creates a custom table named `bricks_form_submissions` in your database (plus your WP database prefix).

You should now also see the following action buttons:

- **Reset database table**: Click this button to remove all form submissions from your database.
- **Delete database table**: Click this button to delete the custom form submissions database table.

:::note
It's important to exercise caution when using these buttons, as it permanently clears or deletes the form submissions database table. Make sure you have a backup of your data before proceeding.
:::

## Form action: Save submission {#save-submission-form-action}

![](imgs/save-submission-action-in-form-element-191308ffa7.png)

Collecting form submissions is a straightforward process. Simply select the **"Save Submission"** action under the Form element's "Actions" control group.

In the following example, we set the "Save submission" and "Email" actions.

The sequence of your actions matters. If an action fails, execution of all subsequent form actions is halted. Set the order of your form actions according to your workflow and requirements.

In our example, this means if the "Save submission" action fails, the "Email" action that follows it won't be triggered.



## Save submission settings

![](imgs/save-submission-settings-a8f6799aef.png)

### Form name

Make sure to give your form a unique and descriptive name, as this name is used on the "Form submissions" page in your dashboard under `Bricks > Form submissions`.

### Save IP address

Enabling this checkbox to save the IP address of the user who submitted the form in the form submission entry. Make sure to add any required information about collecting this person's IP address.

### Max. entries

Set the maximum number of form submissions you want to store in the database for this particular form. This is useful for event registration forms etc.

### Prevent duplicates

You can prevent storing duplicate form submissions if an entry with this particular data already exists.

![](imgs/save-submission-prevent-duplicate-for-2-form-fields-241194e328.png)

Copy the unique, six-character ID of the form field you want to check against, create a new item under "Prevent duplicates" and paste your form ID in there.

If you've enabled "Save IP address", you can use the `ip` keyword to prevent saving any submission coming from the same IP address.

A submission is considered a duplicate if all field values you check against match an existing entry in the database.

Submissions flagged as a duplicate aren't saved. A customizable error message appears, and all subsequent form actions are halted.

## Viewing form submissions

To view all collected form submissions, navigate to `Bricks > Form submissions` in your WordPress dashboard.

Hook related to the form data before saving into the database: [bricks/form/save-submission/form_data](/developer/hooks/filters/bricks-form-save-submission-form_data/)

### Overview page

This overview page provides a summary of all form submissions grouped by their respective forms. This helps you quickly understand the submission distribution across different forms on your website.

![](imgs/form-submissions-admin-overview-page-5b364269c3.png)

The "Delete" button in each form row allows you to delete all entries of the respective form.

This action permanently removes all submissions for the selected form, so make sure you have a backup or genuinely intend to delete them.

### Individual form submission

Click on the "Form name" of the overview page lets you view all entries of a specific form.

![](imgs/form-submissions-single-form-view-95fc86fd48.png)

A click on "Screen options" in the top-right corner lets you toggle the form submission columns. The available columns include metadata such as Date, Browser, IP address, OS (Operating System), Referrer, and User (if logged in during form submission).

The search box allows you to search for specific form submissions based on the submitted form data. Note that the search queries the form field values, not the metadata such as browser, IP address, etc.

You can select multiple entries from the list and delete them in bulk. This feature simplifies the process of removing specific submissions, especially if you want to clear out any irrelevant, outdated, or test data.

A click on the "**Download (CSV)**" button exports all form submissions for the form you are viewing into a CSV file for further analysis, reporting, or data processing.

### Form submission access {#access}

Bricks 1.11 introduces more granular control over who can view form submissions on your site. With the new `bricks_form_submission_access` capability, you can specify which user roles or individual users have permission to access form submissions.

#### User role access

To configure role-based access:

1. Navigate to **Bricks** > **Settings** > **General** > **Form submissions**.
2. Under **Form submissions access**, you will see checkboxes for various user roles on your site such as Administrator, Editor, Author, Contributor...etc.
  - The **Administrator** role is always enabled by default and cannot be disabled.
  - For other roles, simply check or uncheck the boxes to grant or revoke access to form submissions.

This allows you to easily control who on your team can view form submissions based on their user role.

#### Individual user access

To configure access on an individual user level:

1. From the WordPress dashboard, go to **Users**.
2. Click to edit a specific user’s profile.
3. In the user profile, find and adjust the **Read form submissions** setting.

This lets you manage form submissions access for specific users, overriding the broader role-based settings if needed.

---


## Search Criteria

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/search-criteria/*

Bricks 2.2 introduces a powerful new way to control **how search results are generated**, whether the search is triggered by:

- the **native WordPress search** (via the Search element), or
- the **Filter – Search** element - Query Filters feature.

With **Search Criteria**, you can define exactly where Bricks should search: post fields, term fields, user fields, and any custom meta fields. This gives you far more control than the default WordPress `"s"` search and allows fully customized search behaviour across your entire site.

## Override Native WordPress Search ("s" parameter)

The native WordPress search is usually triggered through the **Search element**, and the results land on the **Search Result template**.

By default, WordPress only searches the following post fields:

- post_title
- post_content
- post_excerpt

If you want to override or extend this behaviour, the settings must be configured **inside your Search Result template**.

## Search Criteria in the Search Result Template

![](imgs/bricks-search-criteria-search-results-template-2a0c1cefab.png)

Inside the builder, open your **Search Result** template → Template Settings → **Search Criteria** section.

**Custom search criteria**: This reveals all available search settings for controlling how the native `s` search behaves.

**Use weight score (optional):** When enabled, Bricks will calculate a ranking score based on your defined weight values and order the results accordingly. More about [weight scoring](#weight-score).

#### Search Controls (Posts)

Search post fields - Enable to define which standard WordPress post fields should be searched

Search post meta fields - You can add any meta key here (custom fields) to include them in your search criteria.

:::note
Make sure the **main Query Loop inside the Search Result template** has **"Is main query"** enabled. Otherwise the native search override will not apply.
:::

Once configured, perform a search on the frontend and your results will follow the criteria defined in the Search Result template.

## Search Criteria in the "Filter – Search" Element

When [Query Filters](/builder/dynamic-content/query-filters/) are enabled in Bricks, you can create advanced filtering systems for any Query Loop on any page.

Before Bricks 2.2, the **Filter – Search** element always used the default WordPress `"s"` logic. Now, you can define custom search criteria per filter element. Inside the Filter – Search element settings, you will now see a **Search Criteria** section.

#### Post Query

Search post fields - Enable to define whether to search in Title, Content, and Excerpt

Search post meta fields - You can add any meta key here (custom fields) to include them in your search criteria.

#### Term Query

Search term fields - Enable to define whether to search in Name, Slug, and Description

Search term meta fields - You can add any meta key here (custom fields) to include them in your search criteria.

#### User Query

Search user fields - Enable to define whether to search in Username, Nicename, Email, URL, and Display name

Search user meta fields - You can add any meta key here (custom fields) to include them in your search criteria.

## What is "Use weight score"? {#weight-score}

Weight score lets you control the order of your search results. The higher the weight score for a specific search field, the higher the result will appear if that field matches the search term.

:::note
Important Notes:
- You must enable **Use weight score** for ranking to take effect.
- If a **Sort** filter is active, it will override the weight-score ordering.
:::

#### Example: How weight scoring works

Search Criteria setup:

Search post fields:
- Title → **weight 1**
- Content → **weight 1**

Search post meta fields:
- my_field → **weight 3**

Search term: **"car**"

Matched posts:

| Post ID | Found in | Weight |
| --- | --- | --- |
| 1001 | Title | 1 |
| 1002 | Title + Content | 1 + 1 = 2 |
| 1003 | my_field | 3 |

**Final result order:**
**1003**, **1002**, **1001**

---


## Create Your Own Sidebars

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/sidebars/*

Bricks provides you with its own, built-in sidebar generator. Located in your WordPress dashboard under **Bricks > Sidebars** it lets you to create unlimited sidebars (widgetized areas).

All you need to do is give your sidebar a name and description (optional), and click Create new sidebar.

Once your custom sidebar is created go to **Appearance > Widgets** and drag and drop the widgets of your choice into your newly created sidebar.

You can now add this newly created sidebar inside the builder by dragging the **Sidebar** element onto the canvas.

---


## Style Manager

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/style-manager/*

The Style Manager is the central place in Bricks for managing design system primitives and reusable styling tools. It brings together theme styles, classes, variables, colors, scales, and imported CSS into a single interface inside the builder.

Its purpose is to centralize styling decisions so you can change colors, spacing, typography, and layout rules in one place without hunting through different panels.

## What the style manager contains

The Style Manager is organized into eight tabs:

1. Theme styles
2. Classes
3. Variables
4. Colors
5. Typography
6. Spacing
7. Framework
8. Settings

---

## Theme styles

![](imgs/bricks-2.2-style-manager-canvas-preview-fullscreen-scaled-e6a5ea0c16.png)

Theme Styles define global default styles for HTML elements and Bricks elements.

Typical use cases include:

- Base typography for headings and body text
- Default button and form styles
- Global colors and spacing
- Responsive defaults
- Global hover and focus states

Theme Styles are condition-based. You can apply them to the entire site, specific templates, or specific pages. They support breakpoints and pseudo-classes, which makes them suitable for defining interaction behavior centrally.

For more: [/builder/styling/theme-styles/](/builder/styling/theme-styles/)

## Classes

![](imgs/bricks-2.2-style-manager-class-manager-scaled-3baba8f901.png)

The Class Manager is used to create reusable CSS classes that can be applied to any element.

Use classes when:

- A style is reused across multiple elements
- The style is not a global default
- You want consistent reuse instead of copying values

Classes can be organized into categories, locked, and filtered by usage and status.

Theme Styles define defaults. Classes opt elements into specific behavior.

For more: [/builder/styling/global-class-manager/](/builder/styling/global-class-manager/)

## Variables

![](imgs/bricks-2.2-style-manager-variable-manager-scaled-9b1c2a9cc2.png)

The Variable Manager is where you define CSS custom properties that act as design tokens.

Variables are commonly used for:

- Colors
- Spacing values
- Font sizes
- Layout dimensions
- Reusable numeric values

Instead of repeating numbers, you reference variables using `var(--variable-name)`. Updating a variable updates every place where it is used.

Variables can be imported from CSS or JSON, grouped into categories, and renamed.

For more: [/builder/styling/global-variables-manager/](/builder/styling/global-variables-manager/)

## Colors

![](imgs/bricks-2.2-color-manager-scaled-3de807b3c1.png)

The Color Manager builds structured color systems on top of CSS variables.

Each color is stored as a variable and can optionally:

- Have light and dark mode values
- Generate shade and transparency variants
- Generate utility classes

For more: [/builder/features/color-manager/](/builder/features/color-manager/)

## Typography

![](imgs/bricks-2.2-style-manager-typography-scales-scaled-3b77bdedf2.png)

The Typography tab generates fluid type scales using CSS variables and `clamp()`.

Instead of manually setting font sizes, you define:

- A base size
- A scale ratio
- Minimum and maximum viewport widths

From this, Bricks generates a set of variables that scale smoothly between mobile and desktop.

Typography scales are useful when you want:

- Consistent hierarchy
- Responsive sizing without manual breakpoints
- Fewer arbitrary font-size decisions

You can use t-shirt sizing, numeric steps, or custom names. Generated variables can be used directly or via utility classes.

Manual mode allows overriding calculated values when precise control is required.

## Spacing

![](imgs/bricks-2.2-style-manager-spacing-scales-scaled-a8c4184118.png)

The Spacing tab generates fluid spacing values for margins, padding, and gaps using the same scale-based system as typography.

This helps enforce consistent layout rhythm across pages.

You can generate utility classes such as `gap-m` or `p-l`, but only generate what you actually use.

## Framework

![](imgs/bricks-2.2-framework-importer-scaled-a2b50b1ea5.png)

The Framework tab imports external CSS and converts it into Bricks classes & variables.

It can:

- Parse class rules
- Extract variables from `:root`
- Categorize styles by intent
- Apply prefixes to avoid conflicts

This is mainly useful for:

- Migrating or importing CSS frameworks
- Importing existing custom CSS stylesheets

All imports can be manually reviewed before being added.

## Settings

![](imgs/bricks-2.2-style-manager-settings-scaled-b77456fa0f.png)

The Settings tab controls how typography and spacing scales are generated, and which color mode is used by default.

### Color mode

- Light: always start in light mode
- Dark: always start in dark mode
- Auto: follow system preference

### Scale configuration

These settings affect typography and spacing:

- HTML font-size for rem calculations
- Minimum and maximum viewport widths

---

## Interface controls and preview

The Style Manager header includes a full-screen button and a toggle to show or hide the canvas preview per tab.

The canvas preview shows the currently edited page and updates in real time as you make changes. It responds to breakpoint switching and can be resized.

---

## Keyboard shortcuts

You can switch between Style Manager tabs using number keys based on their position.

You can also open and close the Style Manager popup using:

`CMD + .` (macOS)
`CTRL + .` (Windows/Linux)

---


## SVG Uploads

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/svg-uploads/*

WordPress, by default, does not allow SVG file uploads as this XML-based file format can contain malicious code. It can be especially dangerous when downloaded from unknown/untrusted sources or by untrusted users.

## How to enable SVG support

You can enable SVG uploads on a user role basis under **Bricks > Settings > SVG Uploads** (tab: General). Once enabled Bricks will try to sanitize any SVG file uploads.

:::note
It is important to note that no built-in SVG sanitizer has a 100% guarantee to remove all malicious code. You should therefore download SVG files only from trusted sources, and only enable SVG uploads for user roles that you trust to follow this rule.
:::

## Bypass sanitization {#bypass-sanitization}

Although it is wise to sanitize all the SVG files uploaded to WordPress, there could be a situation where you don't want to rely on the Bricks SVG sanitizer. To bypass the sanitization logic, Bricks provides the hook `bricks/svg/bypass_sanitization`, and you could use it like so:

```php
add_filter( 'bricks/svg/bypass_sanitization', function( $bypass, $file ) {
  // Perform some logic to decide to bypass or not the sanitization

  return $bypass;
}, 10, 2 );
```

Filter callback parameters:

- `$bypass` is a boolean variable (`true` = bypass)
- `$file` represents a single element of the $\_FILES array

If you just want to bypass the sanitization without conditions you could use this shorthand approach:

```php
add_filter( 'bricks/svg/bypass_sanitization', '__return_true' );
```

## Sanitizer allowed tags and attributes {#allowed-tags-attributes}

The sanitizer uses a predefined list of allowed tags and attributes. In some edge cases you would like to upload SVG files that contain other tags and attributes and therefore you need to include them in the allowed list. Or, you may want to narrow the allowed tags and attributes for high security reasons. To manage these lists, Bricks has two different filters:

```php
add_filter( 'bricks/svg/allowed_tags', function( $tags ) {
    $tags[] = 'filter'; // Allow the "filter" tag

    return $tags;
} );
```

```php
add_filter( 'bricks/svg/allowed_attributes', function( $attributes ) {
    $attributes[] = 'filterUnits'; // Allow the "filterUnits" attribute

    return $attributes;
} );
```

---


## Template Library

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/template-library/*

Open the Template Library by clicking the Templates (folder) icon in the builder toolbar or using the CMD / CTRL + SHIFT + L keyboard shortcut. All of your own templates are located under the "My Templates" tab. Browse dozens of pre-designed templates that you can insert with a single click under "Community Templates".



![](imgs/docs-template-library-1024x576-7bc799863b.png)

<figcaption>

Template Library: My Templates & Community Templates

</figcaption>



https://www.youtube.com/watch?v=Nj8uPGQ56VY

## Remote Templates {#interface}

If you've set a Remote Templates URL under **Bricks → Settings** in your WordPress dashboard, then you'll see a **Remote Templates** label instead of Community Templates.

[Remote Templates](/builder/features/remote-templates/) allow you to browse templates from any other Bricks installation that you have access to.

## Import Images & Replace Content {#import-images}

In the top right corner of the Template Library are two checkboxes (set to appear like toggles):

- **IMPORT IMAGES**: When checked all template images are downloaded into your media library. Leave it unchecked to insert a template without images. A placeholder image will show instead.
- **REPLACE CONTENT**: When checked your existing content is deleted and the template will be inserted on a blank canvas. If unchecked the template will be inserted after the last section.

## Template Filters {#filters}

Located below the template sources are the following template filters:

- **Template Bundle**: Select a template bundle to show only templates that belong to the selected bundle. A template bundle can be a collection of templates of the same website (e.g. home page, contact, about us page, etc.)
- **Template Tag**: Select a template tag to show only templates that have the selected tag assigned to them.
- **Template Type**: Select a template type to show only templates of the selected template type.
- **Search Templates**: Enter any keyword to search for a specific template.

## Template Actions

Next to template filters you'll find the following actions:

### Create Template {#create-template}

Click the "+" icon to create a new template. Enter a title and select a template type. The template bundle is optional. Click **CREATE TEMPLATE** to create a new template.

You can also create a new Bricks template from the WordPress dashboard by going to **Bricks → Templates** and click **Add New**. Then give your template a title, select a template type from the meta box on the right side of the editing screen and click **Publish**. Template tags and bundles are optional.

### Save As Template {#save-as-template}

Click the "disk" icon to save your existing content as a template. Enter a title and select a template type. Selecting a template bundle is optional. Click **SAVE NEW TEMPLATE** to save your template.

To save a specific section as a template hover over a section in the builder. The Edit (pen) icon should appear in the bottom right corner. Hover over it, and click the "disk" icon (Save Section As Template). Give your template section a name and select template type "Section". Then click **SAVE NEW TEMPLATE**.

### Import Template {#import-template}

Click the download icon to import existing template(s). You can import a single template (JSON file) or multiple templates in ZIP format.

Click "Select file(s) to import" and select the JSON/ZIP file from your computer or drag and drop those files into the marked drop zone.

To import templates from the WordPress dashboard go to
**Bricks > Templates** and click **Import Templates**.

Select your template file (JSON/ZIP) from your computer and click **Import template(s)**. Or drag and drop those files into the drop zone.

### Sync Templates

The sync icon is only available for Community Templates, and will check if any new Community Templates are available.

## Export Template(s) {#export-templates}

To export a template, hover over the template title and click **Export Template**. This will generate and download a JSON file with your template data onto your computer.

To export multiple templates at once as a ZIP file, go to **Bricks → Templates** in your WordPress dashboard, and select the templates you want to export.

Now select **Export** from the **Bulk Actions** dropdown, and click **Apply**:

![](imgs/file-XTTkSk9tej-87df7aa53f.jpg)

A ZIP file of your selected templates will be generated and downloaded onto your computer.

This ZIP file contains all templates as individual JSON files. Either unzip it to import individual templates or import the entire ZIP file to bulk import all templates at once.

---


## Template Settings

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/template-settings/*

When editing a template click the **Settings** (gear) icon in the builder toolbar to access the **Template Settings**:



![](imgs/builder-template-settings-1024x576-f330b1092c.png)

<figcaption>

Toolbar > Settings > Template Settings

</figcaption>



You should see the following Template Settings groups:

## Group: Header {#template-settings-header}

Only available when editing a header template. Here you can set the header position (top/right/left), header width (when header position is set to left/right). Make your header sticky and optionally slide up on scroll.

## Group: Conditions {#template-conditions}

We had a look at Template Conditions in the [Intro To Templates](/builder/features/an-intro-to-templates/#template-conditions) article. They determine where on your site a specific template is displayed.

You can choose from the following template conditions:

- Entire website (usually used for header/footer templates)
- Front page
- Post type (e.g. single post blog layouts)
- Archive (your archive pages)
- Search results (your search results page)
- Error page (404 error page)
- Terms (term archive pages)

Bricks, by default, displays published templates of certain [template types](/builder/features/an-intro-to-templates/#template-types) on the frontend of your site.

To disable this behavior visit your WordPress dashboard and go to **Bricks → Settings → Templates → Disable Default Templates**.

A blue notification in the builder panel tells you if this setting is disabled or not (see screenshot above). Clicking the notification link brings you to the Bricks settings page, where you can disable default templates.

### Exclude conditions {#exclude}

Since Bricks 1.3.6 you'll be able to apply exclude conditions for any template. To exclude a specific condition you need to toggle the exclude control. Excluding a certain condition will let Bricks know that if the condition applies in a certain scenario, then this template won't be used.

![](imgs/template-condition-exclude-e253151a35.png)



## Group: Populate Content {#template-preview}

Here you can choose to populate the canvas with the content of a specific page.

Let's say you are editing your header template and would like to see how it looks together with your homepage content.

Select **Single Post/Page** under **Content Type** and then select your homepage from the dropdown below. Click **Apply Preview** to saves and reload your template with the selected content.

### WordPress Admin Area: Set Template Preview Image

A template's featured image is used when browsing "My Templates" in the Template Library. You can assign a featured image when editing a template in the WordPress dashboard.

---


## User activation

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/user-activation/*

Starting with **Bricks 2.1**, you can enable the new **User activation** feature. Once enabled, newly registered users must confirm their email address (via a one-click activation link) before they can log in.

:::note
**IMPORTANT: This feature applies to all new user registrations, not just those submitted via the Form element.**
:::

## Quick overview {#quick-overview}

Here is a step-by-step overview of how this feature works once it's enabled.

1. When user activation is enabled, **every new user** must confirm their email by clicking a unique activation link before their account becomes active.
2. The activation email contains a link the user must click to complete verification, and it's automatically sent on user registration.
3. After clicking:
  - If verification **succeeds**, the user is marked **Activated** and is redirected to your chosen **Verification success page.**
  - If verification **fails**, the user is redirected to your chosen **Verification failure page**.
4. You can enable **Auto login after activation** so users are automatically logged in after successful verification.
5. The activation feature **applies to all new registrations**, not just registrations submitted with the Form element.
6. Users created **before** you enabled User activation are **automatically active**.
7. If a user is **Inactive**, they cannot log in until activated. An error message will be shown.

## Configuration and controls {#configuration-and-controls}

Inside the WP Dashboard go to Bricks > Settings > General, and scroll down to **User activation** group, where you will find the following settings:

![](imgs/bricks-user-activation-settings-306557121e.png)

**User activation**: to enable activation, you have to toggle this on. After you toggle this on, you can access the other settings described below.

*NOTE: After activating this, the auto-login after registration setting in the Bricks Form element will not be available anymore. You can use the next control for this.*

**Auto login after activation**: users will be automatically logged in after the registration and successful activation.

**Verification success page**: page where the user will be redirected after successful activation. Useful for writing an welcome message, and if user is also auto logged in, you can also use user dynamic tags

**Verification failure page**: page where the user will be redirected after failed activation. Useful for notifying users about the next step and possible manual approval.

**User Activation Email**:

- From email address
- From name
- Subject
- Email content (use the available placeholders listed the left-hand side)
- HTML email (toggle on if your content includes HTML)

## Users page {#users-page}

A new **Activation status** column appears on the WordPress **Users** page.

![](imgs/bricks-user-activation-admin-column-d5697e3abd.png)

Possible statuses:

- **Active**: user can log in normally.
- **Inactive**: user cannot log in until activated.

For each user, you can perform different actions based on their activation status, by hovering of the user entry:

- For an **active** user:
  - **Mark as inactive** (useful to prevent the user from logging in).
- For an **inactive** user:
  - **Resend activation email** sends a new activation link using the current email template.
  - **Mark as active** will manually mark the user as active, bypassing the email verification.

---


## Visual Grid Builder

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/visual-grid-builder/*

The new **Visual Grid Builder **allows you to visually design and manage your grid layouts. The feature is available for any element with the `display` control set to `grid`, and allows you to:

- **Adjust grid size**: Modify the number of columns and rows to fit your design needs.
- **Resize and move elements**: Easily adjust the size and position of elements within your grid through simple drag and drop.
- **Query loop support**: Tweak any query loop item inside your grid.
- **Breakpoint support**: Create different grid layouts for various breakpoints to ensure responsiveness.
- **Rename elements**: Organize your layout by renaming elements for better identification.
- **Edit elements**: Hover over any grid item and click the pencil icon to continue editing it in the element panel.
- **Reset options**: Reset the entire grid or individual elements on the current breakpoint.
- **History**: Use history buttons to go back and forth between changes.
- **Fill grid**: Auto-fill any empty grid cells with one click using Block elements.
- **ID & class level**: Visually design your grid on the element ID or class-level.



![](imgs/CleanShot-2025-04-04-at-21.17.50@2x-1-cb357fc14d.png)

<figcaption>

Visual Grid Builder modal

</figcaption>



## How it works {#how-it-works}

![](imgs/CleanShot-2025-04-04-at-21.39.14@2x-973087f90a.png)

### Accessing the Visual Grid Builder {#access}

Begin by setting the `display` property of your grid layout element to `grid`. Once activated, the Visual Grid Builder icon appears next to the `grid` value.

![](imgs/CleanShot-2025-04-04-at-21.43.02@2x-e119a3c284.png)

:::note
*NOTE: The visual grid builder (icon) is not available when bulk-editing elements.*
:::

### Styling elements

The Visual Grid Builder allows you to style both individual elements and elements that are part of a query loop. The approach to styling depends on whether you are working at the class or ID level. Here’s an overview of how this works:

**Static elements:**

- **ID level**: When you resize or move a static element, the changes are reflected in the `Grid Item` controls, specifically updating the `Grid Column` and `Grid Row` properties. This approach is straightforward and directly modifies the element's grid positioning.
- **Class level**: If you have defined the grid at the class level, any resizing or movement of the element will save the changes as custom CSS. These custom styles are applied to the `Custom CSS` control of the main element.

**Query loop element:**

- **ID or class level**: When working with elements that are part of a query loop, changes to size or position are saved as custom CSS in the `Custom CSS` control of the main element, regardless of whether you are styling at the ID or class level.

**Important**: It is crucial not to alter the auto-generated CSS styles, as they are essential for maintaining the layout's integrity. These styles are clearly marked with code comments, making them easy to identify and preserve. After moving or resizing an element, the CSS will automatically update to reflect the new values. If you choose to reset an element, the auto-generated custom CSS will be cleared, reverting the element to its original state.

![](imgs/CleanShot-2025-04-04-at-22.04.21@2x-44f0b5b1f3.png)

## Controls {#controls}

**Grid actions:**

1. **Reset (Grid)**: Resets all grid styles for the currently selected breakpoint.
2. **Breakpoints**: Toggle between different breakpoints without leaving the editor.
3. **History**: Undo or redo actions.

![](imgs/CleanShot-2025-04-04-at-22.06.50@2x-a2c8619f82.png)

**Grid controls: **

1. **Columns and rows**: Adjust the number of columns and rows within the grid.
2. **Gap**: Modify the gap between grid elements using any valid CSS value, including variables.
3. **Use min/max**: Toggle to set column or row size to `minmax(0, 1fr)` for better flexibility.

![](imgs/CleanShot-2025-04-04-at-22.11.56@2x-9b80e3b62a.png)

When you open the Visual Grid Builder, it will automatically detect and adjust the column and row controls to match your existing grid configuration.

**Grid panel controls: **

1. **Individual Columns and rows**: Precisely control the size of columns and rows.
2. **Elements**: Edit the elements within the grid.

![](imgs/CleanShot-2025-04-04-at-22.20.35@2x-839e0972ab.png)

Sizes aure automatically calculated from your main element settings. For instance, `repeat(3, 2fr)` is converted to `2fr 2fr 2fr`. You can also customize sizes using values like `1fr`, `300px`, or `minmax(0, 1fr)` or any other valid value, to adjust the design to your needs.

**Single element controls: **

1. **Resize**: Click and drag the borders to resize elements.
2. **Move**: Click and drag within the element to reposition it.
3. **Rename**: Click on the element label to rename it.
4. **Reset**: Reset all styling for the element on the current breakpoint.
5. **Edit**: Close the Visual Grid Builder and select the element in the structure panel for further editing.

![](imgs/CleanShot-2025-04-04-at-22.31.58@2x-f814bdd9e5.png)

You can also view the index of each element, and if an element is part of a query loop, its specific index within the loop will be displayed, starting at 0.

---


## Wireframe Templates

*來源網址：https://academy-preview.bricksbuilder.io/builder/features/wireframe-templates/*

https://youtu.be/B53_o8GfpvQ

## What are Wireframes

Wireframes are premade layouts that allow you to build your templates and pages quickly and effortlessly.

Focusing on structure, layout, and functionality. They contain minimal styling, use placeholder texts, and only represent the overall structure of a specific area on your website such as a section, grid, or card.

Get an overview of all currently available wireframe templates: [https://templates.bricksbuilder.io/wireframes/](https://templates.bricksbuilder.io/wireframes/)

Primarily intended for building new pages, but can also be used in existing websites.

![](imgs/Wireframes-Sample-Page-Builder_4-6d852a0deb.jpg)

Bricks wireframes are based on classes and variables to keep them as flexible, maintainable, and extensible as possible.

In other words, most don't contain styles on the element ID (see [Styling: Classes, IDs and CSS variables](#styling-classes-ids-variables)), but almost every element is assigned a class.

If you have never worked with classes or variables before, we recommend the following free courses and articles:

- [https://www.youtube.com/watch?v=NtRmIp4eMjs](https://www.youtube.com/watch?v=NtRmIp4eMjs)
- [https://www.youtube.com/playlist?list=PL4-IK0AVhVjOT2KBB5TSbD77OmfHvtqUi](https://www.youtube.com/playlist?list=PL4-IK0AVhVjOT2KBB5TSbD77OmfHvtqUi)
- [https://css-tricks.com/a-complete-guide-to-custom-properties/](https://css-tricks.com/a-complete-guide-to-custom-properties/)
- [https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties)

- [/builder/styling/global-class-manager/](/builder/styling/global-class-manager/)
- [/builder/styling/global-variables-manager/](/builder/styling/global-variables-manager/)

## Prerequisites

Please enable the necessary settings to use the wireframes to their full extent.

### Required settings

**Bricks > Settings > General:**

1. SVG Uploads (Administrator) must be activated
2. Class Manager & Variable Manager not deactivated

### Optional settings

**Bricks > Settings > Performance:**

1. Disable chaining element & global class

**Bricks > Settings > WooCommerce:**

1. Miscellaneous: Enable Bricks WooCommerce "Notice" element
2. Products: Set Product badge "Sale" to percentage or text
3. Ajax Add to cart: Enable AJAX add to cart

## Types of wireframes

By default, the wireframe templates are organised through **Template bundle**, **Template type**, and **Template tags**.

Use these filters to find the most suitable wireframe template quickly.

![](imgs/Wireframes-Sample-Page-Builder_5-fb1bbfd46e.jpg)

### Template bundles

Template bundles categorize templates by theme/topic.

The **Blog** bundle, for instance, includes Article/Post layouts along with individual Article Cards, Article Sections, and Article Grids. Similarly, the **FAQs** bundle features individual (FAQ) accordions and FAQ sections.

| **Bundle** |
| --- |
| 404 |
| Avatars |
| Blog |
| Contact |
| Content |
| CTAs |
| FAQs |
| Features |
| … |

### Template Types

A template type is assigned to each wireframe template. The template types are comparable to the [WordPress Template Hierarchy](https://developer.wordpress.org/themes/basics/template-hierarchy/) and let WordPress know what kind of template it is (e.g., a single template for single posts, an archive, a WooCommerce cart, ...).

Using [Template Conditions](/builder/features/template-settings/#template-conditions), you can specify in detail where and when a template is displayed (except for "Section templates").

| **Type** |
| --- |
| Header |
| Footer |
| Single |
| Section |
| Archive |
| Popup |
| WooCommerce - Single Product |
| WooCommerce - Account - Orders |
| … |

Additional information: [/builder/features/an-intro-to-templates/#template-types](/builder/features/an-intro-to-templates/#template-types)

### Template Tags

Template tags organize the templates according to their function.

| **Tag** | **Tag Description** |
| --- | --- |
| Single | A single element or a small group of elements, such as a custom list, feature card, image/media groups, forms, intros, etc., that can be used anywhere. |
| Grid | A layout grid, usually with CSS grid or flexbox, grouping single templates, e.g., feature cards. |
| Section | A section usually contains one or more grid templates or individual layouts. |
| Template | A fully functional template (see template types) such as a single post/product, archive, header, footer, 404, … |
| Popup | A popup layout is, strictly speaking, a template, too, but it has its tag, so it’s easier to find |

## Template structure and layout

Most Bricks Wireframe templates have a modular structure, i.e., several templates are combined into one template. Imagine a section that contains a grid with various cards. This results in a total of three templates:

1. A card template (tag "Single")
2. A grid template (tag "Grid"), which contains the cards
3. The section template (tag "Section"), which contains the grid template including cards

Each of these templates is available as an individual template.

For example, you can use the card in a different context or place the grid template with cards in a different section ("mix and match").

### Example: "Feature Section 01"

![](imgs/Wireframes-Sample-Page-Builder_3-d22a88d784.jpg)

"Feature Section 01" contains a total of three templates:

1. Intro 01 (template tag "Single")
2. Feature Grid 01 (template tag "Grid")
3. Feature Card 01 (template tag "Single")

In this case, all templates have the same index (01) because they were created within the same context. You may also see templates with different or no indexes, which is perfectly fine and doesn’t affect how you can use them.

### Example: "Feature Section 04"

If we take a closer look at "Feature Section 04", we can see that the "Content Wrapper" block has no index - "Media Group 04", on the other hand, does.

This means that the content wrapper only applies to this template (Feature Section 04) and does not exist as a separate template. "Media Group 04", on the other hand, exists as a separate template and can, therefore, also be used in different places.

![](imgs/Wireframes-Sample-Page-Builder_2-3fa6fd9d95.jpg)

### When do I use a section template, and when do I use a grid?

Each page of your website should be divided into sections.

Sections represent, semantically speaking, a new topic. For example, your homepage could contain the following sections: Hero Section, Feature Section, About Us Section, and a CTA or Contact Section.

Make sure to not place sections within sections.

Grid templates are placed within sections. If they belong together thematically, you can put several grids in a section.

A negative example is adding a blog post grid and a product grid to the same section. Both grids should be placed in a separate section because they make no semantic sense together.

### Can I customize the templates and add additional elements or delete elements that are not needed?

Of course, you can customize the templates and add or delete elements you don't need.

It is best to save the customized template in your custom templates so that you can reuse it. If you import the template from the community templates again, it will not contain the structural changes you have made. However, changes to imported classes or variables will persist across the site unless you delete or override them by re-importing the original class (more on that later).

Remember that the templates are only a starting point and are by no means finished, complete, or 100% suitable for every project. You are welcome to add your own sections, grids, and single templates to adapt them to your project.

## Styling: Theme Styles / CSS Variables / Color Palette Import

When importing a wireframe, you will be asked whether you want to import the associated CSS variables, theme style, and color palette.

### CSS Variables

Since CSS variables are used almost exclusively, the import of variables is mandatory.

### Theme Style

The theme style contains basic settings like responsive font sizes using the default 62.5% HTML font size, section padding, container width, gaps, and others. If you already use a custom theme style, transfer the settings to your theme style (if necessary) and leave the brxwireframes theme style as a reference without a condition. This way, you can always fall back on it in case of doubt. If you are not yet using a custom theme style, don't forget to assign a condition “entire website” to the wireframes theme style.

### Color Palette

In some templates it is necessary to use colors (e.g. for overlays, border-, background- or text-colors). For this purpose, we created 12 neutral color variables (--brxw-color-neutral-xxx), which are also available in a "Bricks Wireframes" color palette. We recommend importing the color palette, as this gives you a visual reference of the [existing variables](#styling-colors) and allows you to quickly assign the colors to other elements.

## Styling: Classes, IDs and CSS variables {#styling-classes-ids-variables}

As mentioned in the introduction, the Bricks wireframes are class- and variable-based to keep them as flexible, maintainable, and extendable as possible.

All classes and CSS variables use `**brxw-**` as a prefix to prevent overlaps with existing classes and variables.

Almost every element within a template is assigned at least one class whose naming convention is based on the [BEM ("Block Element Modifier") methodology](https://getbem.com/).

**Blocks **are independent parent elements. An example could be a card, a menu, or a grid. Block classes only contain hyphens. *Example:* .brxw-article-card-01

**Elements** are the child elements within a block. They are connected to the block by two underscores. *Example:* .brxw-article-card-01__title

**Modifiers** are variants of a block or element that change the status or appearance. Modifiers are connected to the block or element by two hyphens.
*Example:* .brxw-article-card-01--dark.

Block, element, and modifier classes can be easily distinguished based on the spelling alone. However, it may be confusing that BEM uses the terms "block" and "element" just like Bricks. If you need clarification, just remember this: BEM Block classes can be used on all Bricks parent elements - it doesn't matter if the parent element is a Bricks block, div, section, container, nav menu, or icon list.

BEM element classes are applied to Bricks elements within a BEM block, regardless of which Bricks elements you use.

### Example: Article Card 01

| **Block Class** | **Element Classes** |
| --- | --- |
| .brxw-article-card-01 | .brxw-article-card-01__body |
|  | .brxw-article-card-01__title |
|  | .brxw-article-card-01__taxonomy |
|  | .brxw-article-card-01__text |
|  | .brxw-article-card-01__footer |
|  | .brxw-article-card-01__date |
|  | .brxw-article-card-01__author |
|  | .brxw-article-card-01__media-wrapper |
|  | .brxw-article-card-01__media |

### Important to know:

- **Not all blocks must have children - they can exist independently**
- **Blocks can have other blocks as children**
*Example:* The section element in the “Article section 04 template” is an independent block (.brxw-article-section-04) and contains two different blocks: .brxw-intro-02 and .brxw-article-grid-04, which in turn have children.
- **Elements cannot exist without a parent block.**
*Example:* .brxw-intro-02__title cannot exist without its parent block .brxw-intro-02

#### When do I style on the existing brxw-classes, when on custom classes, and when on the ID?

You should consider carefully where and how often you want to insert the relevant template. There are different possibilities depending on this.

For templates that are used multiple times (e.g., a section placed various times, cards in a loop, etc.), styling on classes (brxw- or custom) is preferable to ID styling, as the CSS ID must be unique and may, therefore, only occur once per page.

##### Existing brxw-classes

Styling on the existing brxw-classes is the standard method for giving the elements the desired styling. You can also adjust the values, such as the number of grid columns within the templates, to your needs - they are not set in stone.

If you import the same template again from the community templates elsewhere, it will automatically receive the same styling and the exact customizations that you have applied to the brxw-class.

##### Custom classes

In addition to the brxw-classes, you can add custom classes containing your custom styles. In most cases, this also makes it possible to overwrite the existing values of the brxw-classes.

However, if you insert the same template elsewhere from the community templates, you must add your custom classes manually, if desired. Alternatively, you can save the customized template including the custom classes in your templates to reuse it later.

##### IDs

Sometimes, you can use the ID to style your elements or to overwrite class styles.

Imagine you place the same section template twice on your homepage. You select the section class and assign it a background color that applies to both sections accordingly. To "exceptionally" give the second section a different background color, you can style on the section ID to overwrite the class.

**Remember:** IDs always have a higher specificity than classes. Accordingly, it is impossible to overwrite an ID style with a class but the other way around. If you re-import the same template from the community templates, the section will not contain any ID styles but will include the changed class styles.

#### Can I rename the existing classes?

You can rename the `brxw-` classes if you wish. However, remember to do this for the block and contained element classes of the child elements, if available ([Class Manager](/builder/styling/global-class-manager/)).

If you import the same template again, it will use your class names and style changes. However, this also means you cannot re-import the original template unchanged.

Suppose you want to retain the option of re-importing the original template **without** changes to the class name or styles. In that case, it is not enough to rename the classes, as they still have the same ID in the database, i.e., the same unique identifier. In this case, you would have to duplicate the classes ([Class Manager](/builder/styling/global-class-manager/)) so that they each have a new, unique identifier, reassign them to the elements, and remove the "old" classes from the elements.

#### I have accidentally deleted a brxw-class. Can I restore it?

Yes. In the first step, look in the Class Manager’s trash (top right), and if the class is still there, you can restore it directly.

If you have emptied the trash, you can simply re-import the template.

In both cases, remember to reassign the class to the elements on which it is missing, as it will be removed from the elements as soon as it is deleted.

### CSS variables

If values are assigned to a `brxw-` class (or theme style settings), the values are defined as CSS variables, with few exceptions. You can find the variables and values in the [Global Variables Manager](/builder/styling/global-variables-manager/).

![](imgs/Variable-Manager-28b43d8181.png)

CSS variables offer the advantage of reusability, flexibility, and easy maintenance of styles, as they define central values that all elements in the CSS can use. For example, if you want to increase or decrease the gap of your grids, you only need to adjust the value of the variable `–brxw-grid-gap`. The change now affects every grid in which the variable is used.

#### Variable categories

The available variables cover essential areas such as CSS grids, font sizes, spacing, gaps, border radius, and others, which are sufficient for the "start" of a project. If you need additional categories or variables, you can create them as per your requirements in the variable manager.

| **Variable Category** | **Examples** | **Purpose** |
| --- | --- | --- |
| Grids | –brxw-grid-1, –brxw-grid-2, …, –brxw-grid-12 | Used within CSS Grids to set the number of columns |
| Spacing | –brxw-space-xs, –brxw-space-2xl, … | Used within margins, paddings, widths, heights, gaps, … |
| Typography | –brxw-text-xs, –brxw-text-m, –brxw-text-2xl | 9 (fluid) font sizes from xs to 5xl |
| … |  |  |

#### Variable values

The brxw-variables use [CSS clamp functions](https://developer.mozilla.org/en-US/docs/Web/CSS/clamp) for font sizes, spacing, and border-radius, which calculate the value based on a minimum, preferred, and maximum value depending on the viewport (minimum/maximum width). This has the advantage that you do not manually adjust the font size or padding in the mobile breakpoint, for example, as it is automatically adjusted (reduced or enlarged).

As a basis for this calculation, the wireframe templates assume a minimum viewport of 320px, and a maximum viewport of 1440px, which should be a good starting point for typical websites.

#### I already use a framework and CSS variables (e.g., ACSS, Frames, or CoreFramework). Can I continue to use my variables?

Of course, you can continue to use your existing variables. However, remember that the values of your variables will probably differ from those of the brxw-variables.

As there is a lot of overlap with other frameworks, you can use your existing variables as the brxw-variable value. This allows you to adapt the wireframe templates to your existing layout and spacing without editing each template.

##### Example ACSS

| **ACSS Variable** | **brxw-Variable** | **Extended brxw-variable** |
| --- | --- | --- |
| --container-gap: var(--space-xl) | --brxw-container-gap: var(--brxw-space-2xl) | –brxw-container-gap: var(--container-gap) |
| --grid-gap: var(--space-l) | --brxw-grid-gap: var(--brxw-space-l) | –brxw-grid-gap: var(--grid-gap) |
| –space-m: clamp(2rem, calc(1.09375vw + 1.65rem), 3.4rem) | –brxw-space-m: clamp(1.6rem, calc(0.36vw + 1.49rem), 2rem) | –brxw-space-m: var(--space-m) |
| –h2: clamp(2.592rem, calc(1.725vw + 2.04rem), 4.8rem) | –brxw-text-fluid-3xl: clamp(2.56rem, calc(1.04vw + 2.23rem), 3.73rem) | –brxw-text-3xl: var(--h2) |
| … |  |  |

##### Example Core Framework

| **Core Framework Variable** | **brxw-Variable** | **Extended brxw-Variable** |
| --- | --- | --- |
| --space-m:clamp(1.6rem, calc(1.11vw + 1.24rem), 2.8rem) | --brxw-space-m: clamp(1.6rem, calc(0.36vw + 1.49rem), 2rem) | –brxw-space-m: var(--space-m) |
| --radius-m: clamp(1rem, calc(-0.19vw + 1.26rem), 1.2rem) | –brxw-radius-m: clamp(1rem, calc(-0.18vw + 1.26rem), 1.2rem) | –brxw-radius-m: var(--radius-m) |
| … |  |  |

##### Custom responsive variable values (clamp)

If you want to use other viewport sizes (instead of 320px min, 1440px max), all variable values that use clamp /Fluid Typography, Spacing, Radius) must/should be customized/regenerated.

We do not recommend doing this manually (unless you are a math genius). Instead, you can use the built-in **Fluid Typography Scale Generator** located in the Variable Manager to create new text or spacing variables. The radius variables were created with CoreFramework (free) because they are not based on a base value but should have individual min and max values.

![](imgs/Fluid-Variables-2414dc54ca.png)

Alternatively, you can use generators that provide you with the ready-made clamp functions. Depending on which generator you use, you can adjust the variable name/prefix directly in the generator, or you have to do this later in a code editor of your choice.

All generators mentioned are currently (September 2025) free of charge and are not affiliated or connected with Bricks:

1. [fluid-type-scale.com](https://www.fluid-type-scale.com/calculate?minFontSize=16&minWidth=320&minRatio=1.25&maxFontSize=18&maxWidth=1440&maxRatio=1.333&steps=xs,s,m,l,xl,2xl,3xl,4xl,5xl&baseStep=m&prefix=brxw-text&useContainerWidth=false&includeFallbacks=false&useRems=true&remValue=10&decimals=2&previewFont=Inter&previewText=Almost+before+we+knew+it,+we+had+left+the+ground&previewWidth=1280)
2. [utopia.fyi](https://utopia.fyi/type/calculator/?c=320,16,1.25,1440,18,1.333,4,2,&s=0.75%7C0.5%7C0.25,1.5%7C2%7C3%7C4%7C6,s-l&g=s,l,xl,12)
3. [coreframework.com](https://coreframework.com)

## Styling: Color Palettes {#styling-colors}

Most wireframes do not contain any colors unless absolutely necessary or beneficial (e.g., overlays, borders, backgrounds, text-colors). For this purpose, we have created a neutral color palette (shades of grey) with 12 color-steps from light to dark, which can be imported during template import.

The colors are defined in CSS variables, located in the Variable Manager (--brxw-color-neutral-25, --brxw-color-neutral-50, --brxw-color-neutral-100, ..., --brxw-color-neutral-950) and can be adjusted there. If you don't want to use any predefined colors at all, delete the color variables from the variable manager.

There are various free generators for creating custom color palettes (to add primary or secondary colors, or change the existing neutral color values). We have had good experiences with these generators, for example:

- [https://components.ai/color-scale/rnjyBVIn24NiNNH0ob2W](https://components.ai/color-scale/rnjyBVIn24NiNNH0ob2W)
- [https://uicolors.app/create](https://uicolors.app/create)

## Custom CSS / JS / Code

### Custom CSS

We try to avoid custom CSS. However, some layouts or customizations would not be possible without it.

### Custom JS / Code

Custom JS or PHP is only used if the use case requires it. We've commented the code used in as much detail as possible. When using a template with a Code element, remember to enable code execution and sign the code.

## Frequently asked questions

- **Why are there no wireframes for Category X or Y?**
  - Bricks is designed to give you the ultimate flexibility to create exactly what you need. While we will add new wireframes as part of our ongoing work with community templates, we've provided all the tools you need to easily create your own wireframes for any category or design. This way, you are not limited by what’s available and can build to your unique vision.
- **Can I request new wireframes?**
  - Of course! We’re always open to hearing your ideas. While we can't guarantee every suggestion will be implemented, your input helps us better understand what’s important to the community. Feel free to contact us by email (subject: "Wireframes") or share your suggestions in the forum under the Feature Requests/Improvements category (prefix your title with "Wireframes").
- **Who can I contact if I have found a potential bug?**
  - Please contact us by email (subject "Wireframes") or create a new report in the forums bugs category (title prefix: "Wireframes"). Please tell us the name of the template and the issue in as much detail as possible.

Happy wireframing!

---


## Builder Access & Capabilities

*來源網址：https://academy-preview.bricksbuilder.io/builder/interface/builder-access/*

Starting at version 2.0, Bricks gives you full control over who can access the builder, and what actions they’re allowed to perform. You can either assign a **predefined capability**, or create your own **custom capability** that allows only the specific permissions you enable for it.

This gives you complete freedom and control to tailor the builder experience to any roles (i.e. content editor, designer, client, etc.) depending on what they should be able to do.

![](imgs/bricks-settings-builder-access-9b54f82998.png)

## Access levels

There are two ways to manage builder access:

1. Use one of the predefined capabilities: **Full access**, **Edit content**, or **No access**
2. Create your own custom builder capability with detailed permission control

### Predefined capabilities

- **Full access**: Grants access to all features and permissions in the Bricks builder.
- **Edit content**: Limits the user to content editing only. Layout, styling, and structural controls are disabled. More specifically, this includes the following permissions:
  - Access revisions
  - Set component properties (instance)
  - Access content (HTML) settings
  - Edit all elements
  - Edit all Bricks-enabled post types
- **No access**: Blocks access to the Bricks builder entirely.

## Creating a custom capability {#custom}

If you need precise control over the actions a user or role should be able to perform, you can create your very own custom builder capability, following the steps outlines below.

1. Go to **Bricks > Settings > Builder access**
2. Under **Builder capabilities**, click **Add new capability**

![](imgs/bricks-builder-access-add-custom-capability-c224a877a2.png)

Inside the capability popup, you can:

- Give the capability a name & a description
- Enable exactly the permissions you want to grant

![](imgs/bricks-builder-access-permissions-4cd00f47bc.png)

Once created, you can assign this capability to specific users or user roles.

## Assigning capabilities

You can assign any builder capability, whether predefined or custom:

- To a **user role**, under **Bricks > Settings > Builder access > Builder access**

![](imgs/bricks-builder-access-custom-capabilities-929f21f58e.png)

- To a **specific user**, by editing their WordPress user profile

![](imgs/bricks-builder-edit-user-profile-c36683ac92.png)

![](imgs/bricks-builder-access-user-settings-cfebb7da70.png)

This gives you flexibility to apply permissions globally or individually.

## Available permissions

When editing a capability, the following permissions are available and grouped by category:

### Post types {#post-types}

Choose which post types can be edited using Bricks.

### General {#general}

- Access breakpoints manager
- Access page settings
- Access template settings
- Access revisions
- Delete revisions
- Access font manager
- Access icon manager

### Templates {#templates}

- Create templates
- Edit templates
- Delete templates
- Insert templates
- Access remote templates
- Import/export templates

### Global styles & settings {#styles-setting}

- Access theme styles
- Access color palettes
- Access variables manager
- Access class manager
- Create global classes
- Edit global classes
- Assign/unassign global classes
- Delete global classes
- Lock/unlock global classes
- Copy/paste global class styles
- Access pseudo classes & selectors

### Components {#components}

- Insert components
- Edit properties (instance)
- Edit components
- Create components
- Delete components
- Import/export components

### Element editing & styling {#element-edit-style}

- Access content (HTML) settings
- Access style (CSS) settings
- Access query loop builder
- Access element conditions
- Access element interactions
- Duplicate elements
- Delete elements
- Move elements
- Copy/paste elements
- Copy/paste element styles
- Copy/paste element conditions
- Copy/paste element interactions
- Copy/paste element attributes
- Pin/unpin elements

### Edit elements {#edit-elements}

Controls general editing of existing elements.

*Note: Requires access to content and/or style settings.*

### Add elements {#add-elements}

Define which elements can be inserted.

---


## Builder Mode (Custom)

*來源網址：https://academy-preview.bricksbuilder.io/builder/interface/builder-mode/*

Starting with Bricks 1.3.7 you can customize the builder mode (color scheme) to your liking by tweaking a few CSS variables.

You first have to set the "Builder Mode" under Bricks → Settings → Builder to "Custom" and save your settings.

The following new setting called "Builder Mode (Custom)" should now appear:

![Builder Mode: Custom](imgs/bricks-setting-builder-mode-custom-1024x721-2eb5570921.png)

Below you can find an example CSS snippet that contains all relevant builder CSS variables:

```php
[data-builder-mode=custom] {
  --builder-bg: #f6f4f2;
  --builder-bg-2: #efebe6;
  --builder-bg-3: #e7e1da;
  --builder-bg-accent: #EED8FD;

  --builder-color: #2e271e;
  --builder-color-description: #76634c;
  --builder-color-accent: #7209B7;
  --builder-color-accent-inverse: #fff;

  --builder-color-knob: #c8baaa;
  --builder-border-color: #d8cec2;
  --builder-placeholder-opacity: .33;

  --bricks-tooltip-bg:   #16130f;
  --bricks-tooltip-text: #f6f4f2;
}
```

If you copy the CSS above, paste it into your "Builder Mode (Custom)" setting, and save your settings, your builder should look like this:



![](imgs/bricks-screenshot-builder-mode-custom-1024x576-189c4e8ae9.png)

<figcaption>

Bricks builder with a custom color scheme (mode)

</figcaption>



### Resources

- Color palettes: [https://coolors.co/palettes/trending](https://coolors.co/palettes/trending)
- Color palettes: [https://colorhunt.co](https://colorhunt.co)
- Generate color shades & tints: [https://www.colorhexa.com](https://www.colorhexa.com)

Note: In custom builder mode, Code element's background color changes to a light color scheme.

---


## Command Palette

*來源網址：https://academy-preview.bricksbuilder.io/builder/interface/command-palette/*

Bricks 2.0 introduces the **Command Palette**, a powerful new feature that gives you instant keyboard-driven access to core functionality inside the builder.

## How to launch It

Click the command `⌘` icon in the builder toolbar or use the `CMD/CTRL + K` keyboard shortcut to open the Command Palette, which appears as an overlay, allowing you to type and filter commands across three distinct scopes.

## Scope: Builder {#builder}

Navigate to key parts of the builder from a growing list of targets such as classes, variables, templates, theme styles, settings, etc.

![](imgs/bricks-2.0-command-palette-scope-builder-bbca6af3b5.png)

## Scope: Post Types {#post-types}

This scope lets browse all registered post types, create new posts or duplicate any existing post.

The scope auto-selects the post type that you are currently editing. So if are editing a Bricks template the "Template (Bricks)" post type will be selected. If you edit a "Page", then "Page" is selected and so on.

![](imgs/bricks-2.0-command-palette-scope-post-types-7f3ed022db.png)

## Scope: Elements {#elements}

The "Elements" scope will dramatically speed up your workflow by allowing you to insert multiple elements with specific structure in a single action.

By mastering the Emmet-like syntax, you can create complex layouts in seconds rather than minutes, making your design process significantly more efficient.

With practice, this feature becomes second nature and an essential part of your Bricks Builder toolkit, especially for quickly creating common page structures and element combinations that you use frequently, which you can also save for instant access to use whenever needed.

![](imgs/bricks-2.0-command-palette-scope-elements-19419e521f.png)

### Insert single element

To insert a single element simple type its name, such as "Section", then `ARROW`-navigate to it in the elements list, and insert it by pressing `ENTER` or just click on the element name.

### Insert element structure

Each element starts with an **@** symbol.

The element name that the command bar requires is displayed in square brackets in the results list:



![](imgs/bricks-2.0-command-palette-element-name-36cecc31ef.png)

<figcaption>

Text link element command: `@text-link`

</figcaption>



### Supported operators

Use the following opeators to define nested structure, siblings or a multiplier.

| Symbol | Meaning |
| --- | --- |
| `@` | Bricks element name (e.g. `@heading`) |
| `>` | Nest inside |
| `+` | Insert element as sibling |
| * | How often to insert the element |

### Element structure example

`@section * 2 > @heading + @text + @button`
This creates the following structure *(two times because of the multiplier: `* 2`)*:

- `Section`
 └ `Container`
   ├ `Heading`
   ├ `Text`
   └ `Button`

### Quick element insertion

:::note
After selecting an element from the search results, its name is added to your query with the `@` prefix, allowing you to quickly build complex queries:
:::

1. Type `@` to activate insertion mode
2. Select an element (e.g., "section")
3. Type `>` for a child element
4. Continue building your structure
5. Click your element structture
  - Click the "Insert" button that appears next to your query
  - Press `CMD/CTRL + ENTER`

### Save element structures

Instead of typing out your favorite structures by hand every time can just save them by clicking the "Save" button next to the command bar. Your structures are stored in `localStorage`, so every user on your site can have it own set of their favorite structures.



![](imgs/bricks-2.0-command-palette-saved-element-structures-495af7fcc3.png)

<figcaption>

List of saved element structures

</figcaption>



To delete a structure, mouseover the structure item in the list, and click the "Delete" icon.

## Keyboard shortcuts

| **Keyboard shortcut** | **Action** |
| --- | --- |
| `CMD/CTRL + K` | Open/close the command palette |
| `ESC` | Navigate to a specific post type |
| `TAB > ENTER` (to enter selected scope) | Navigate between search and scopes |
| `#` (as the first character in the search input) | Enter scope “Builder” |
| `/` (as the first character in the search input) | Enter scope “Post Types” |
| `+` or `@` (as the first character in the search input) | Enter scope “Elements” |
| `/0-9` (forward slash followed by number) | Navigate to a specific post type |
| `ARROW UP/DOWN` + ENTER | Navigate to a search result and open it |

## Notes

Bricks remembers your last selected scope, even after builder reload (stored in your localStorage).

The "Pages" panel has been deprecated as all its functionality is now available in the Command Palette.

The "Docs" icon disappeared from the toolbar as well, but is still accessible from the "Builder" scope.

---


## Context Menu

*來源網址：https://academy-preview.bricksbuilder.io/builder/interface/context-menu/*

Bricks' context menu gives you quick access to various block actions such as edit, clone, delete, copy & paste styles (works also across different browser tabs), and to save elements as [Global Elements](/builder/features/global-elements/).

To reveal the context menu simply hover over any block on the canvas and perform a right-click.

https://youtu.be/WGVpLuzuKuE

---


## Adding & Editing Elements

*來源網址：https://academy-preview.bricksbuilder.io/builder/interface/editing-elements/*

To add an element to the canvas simply drag it from the panel and drop it anywhere onto the canvas.

Click on any element to start editing it. The panel will now show you all available controls of the selected element.

:::note
**Tip:** You can edit text directly on the canvas by clicking on it and start typing. Select text portions with your mouse to reveal the text formatting toolbar with various styling options such as bold, italic, links, etc.
:::

Element controls are organized under two tabs: **CONTENT** and **STYLE**. Sections, rows, and columns don't have a control tab, as all controls are styling-related.

## Tab: Content

Content controls affect the actual element markup (HTML) of your page. The screenshot below shows you all available Content controls for the image element:



![Panel: Content (Tab)](imgs/bricks-academy-panel-content-tab-1024x576-ef8193e1db.png)

<figcaption>

Element Image: Content Tab

</figcaption>



## Tab: Style

Controls under the **STYLE** tab affect the style/design (CSS) of a block and are grouped into:

- Layout
- Typography
- Background
- Border / Box Shadow
- Gradient / Overlay
- Shape Dividers
- Transform
- CSS



![Panel: Style (Tab)](imgs/bricks-academy-panel-style-tab-1024x576-c6b5eb8ba6.png)

<figcaption>

Element Image: Style Tab

</figcaption>



## How To Reset Controls

To undo all styling changes you have applied to a block, click the **Reset Styles** icon next to the block name in the panel header.

This will only remove any settings that concern the design of your element. All content controls are preserved.

You can also reset individual controls and entire control groups with a single click. Every control and control group with a setting value has a little grey indicator next to its label.

To reset an entire control group (such as **Typography**) click the indicator next to its label. This removes all settings of this control group.

## Copy & Paste Styles

To copy & paste block styles hover over the blocks' action icons, and right-click to reveal the custom context menu. Click on **Copy Styles**.

Then hover over the action icons of the block you want to apply those copied styles to, right-click, and select **Paste Styles**.

---


## Start Editing With Bricks

*來源網址：https://academy-preview.bricksbuilder.io/builder/interface/editing-with-bricks/*

Once you have [activated your license](/builder/license/license-and-updates/) head over to **Bricks → Settings** and select the post types you want to edit with Bricks:

![](imgs/bricks-settings-post-types-b72d842342.png)

:::note
**Tip:** While you could write your blog posts with Bricks, it's best to create a Bricks template for your blog post layout, and write your blog posts in the WordPress editor as usual.
:::

To enter the builder, click the **Edit with Bricks** link when hovering over the post title in your WordPress dashboard:

![](imgs/docs-edit-with-bricks-button-6356de51ff.png)

You can also enter the builder right after creating a new Page or while editing an existing Page by clicking the **Edit with Bricks** button at the top of the page:

![](imgs/bricks-post-edit-screen-1024x576-0518ec73c3.png)

### WP Admin Bar

You'll also find an **Edit with Bricks** link in the admin bar. When editing with Gutenberg and you don't see the admin bar, make sure you've disabled Gutenberg's "Fullscreen mode".

Use the **Delete Bricks Data** button in the WP admin bar to delete the Bricks data of the page you are currently editing. This action is disabled by default. To enable it, go to Bricks → Settings and check the 'Enable "Delete Bricks Data" Button' setting.

The last Bricks item in the admin bar is the **Render with Bricks** / **Render with WordPress** links. Select whatever data source you want to render this page with.

If a Page (or any other Bricks-enabled post type) is rendered with Bricks, you'll see a "**- Bricks**" post status after the title. In the screenshot below, you can see that the Account Page is not rendered with Bricks, but WordPress, and that the Blank Page is rendered with Bricks:



![](imgs/bricks-post-screen-post-status-42973d9f78.png)

<figcaption>

Post status "Bricks" shows you that a page is rendered with Bricks

</figcaption>

---


## Keyboard Shortcuts

*來源網址：https://academy-preview.bricksbuilder.io/builder/interface/keyboard-shortcuts/*

Quickly perform the most common in-builder actions through short & simple keyboard shortcuts:

| **Key Combination** | **Description** |
| --- | --- |
| `CMD / CTRL` | Insert element outside active nestable/parent element |
| `CMD / CTRL + S` | Save changes |
| `CMD / CTRL + Shift + S` | Force save all data |
| `CMD / CTRL + K` | Open command palette |
| `CMD / CTRL + P` | Toggle preview mode |
| `CMD / CTRL + B` | Switch between responsive editing modes |
| `CMD / CTRL + Z` | Undo your last change |
| `CMD / CTRL + ALT + NUMBER` | Quick Access Bar: Go to tab/control group |
| `CMD / CTRL + Shift + Arrow down` | Edit next element (same level) |
| `CMD / CTRL + Shift + Arrow up` | Edit previous element (same level) |
| `CMD / CTRL + Shift + Arrow right` | Edit first child element |
| `CMD / CTRL + Shift + Arrow left` | Edit parent element (container) |
| `CMD / CTRL + Shift + Z` | Redo your last change |
| `CMD / CTRL + Shift + D` | Duplicate selected element |
| `CMD / CTRL + Shift + F` | Focus on element setting search input (in panel) |
| `CMD / CTRL + Shift + L` | Toggle template library |
| `CMD / CTRL + Shift + P` | Wrap in block |
| `CMD / CTRL + Shift + H` | Show history panel |
| `CMD / CTRL + Shift + V` | View on frontend |
| `CMD / CTRL + Shift + X` | Show structure panel |
| `CMD / CTRL + Shift + E` | Show elements panel (and focus on search) |
| `CMD / CTRL + Delete` | Delete active element (and its children) |
| `CMD / CTRL + ENTER` | Toggle element classes UI |
| `Shift (modifier)` | Hold down "Shift" to:
- Adjust element spacing (margin, padding)
or container sizing (height, width) on the canvas
in steps of 5 (custom units) or 10 (default unit = px)
- Directly edit new element |
| `ESC` | Cancel/close popup (templates, documentation, etc.) |
| `ALT/OPTION + T` | Focus on toolbar (logo). TAB through toolbar possible |

---


## Page Settings

*來源網址：https://academy-preview.bricksbuilder.io/builder/interface/page-settings/*

Page Settings allow you to customize the markup and styling of the page you are currently editing. They are located within the Settings panel (gear icon in the builder toolbar).

Use the **Reset** icon in the panel header to clear all page settings with a single click.

There are different kind Page Settings organized into the following groups:

- **General**: Disable header and footer of an individual page.
- **One Page Navigation**: Settings to create a one-page site.
- **SEO**: Permalink, title, and metadata.
- **Social Media**: To customize how this page looks when shared on social media.
- **Custom Code**: Custom CSS & JavaScript for use on the current page.

![](imgs/bricks-page-settings-dbcbf54b6b.png)

## One Page Navigation {#one-page-nav}

If enabled, Bricks adds a vertical dot menu to the right edge of the page in a fixed position, with each dot linking to the page's root element.

![](imgs/bricks-one-page-navigation-1024x534-764e97e861.png)

:::note
**Note**: A unique CSS ID is required for root elements (sections, etc.) for One Page Navigation to work. If the root element is within a query loop, you can assign a CSS ID using dynamic tags like post_id or post_slug. (assumed it's a post loop)
:::

![](imgs/one-page-navigation-loop-unique-css-id-a2137af3e5.png)

---


## Responsive Editing

*來源網址：https://academy-preview.bricksbuilder.io/builder/interface/responsive-editing/*

What looks great on a large desktop screen usually needs some refinement for smaller devices. This typically involves applying smaller font sizes, margins, paddings, column width/stacking, or hiding certain elements on smaller devices.

Bricks provides the following four breakpoints out-of-the-box:

| **Breakpoint** | **@media query** |
| --- | --- |
| Desktop | Base breakpoint |
| Tablet portrait | &lt; 992px |
| Mobile landscape | &lt; 768px |
| Mobile portrait | &lt; 478px |

Styles set on the base breakpoint are inherited by all other breakpoints.

Once you've finished styling a page on the base breakpoint (desktop), make sure to view & adjust the styling on the other breakpoints too.

To view & edit the styles for a specific breakpoint simply click on its breakpoint icon located in the center of the builder toolbar. Or via the [keyboard shortcut](/builder/interface/keyboard-shortcuts/) "CMD/CTRL + B".



![](imgs/bricks-1.5.1-in-builder-breakpoint-mobile-landscape-1024x576-247ad7fc48.jpg)

<figcaption>

Editing in the "Mobile landscape" breakpoint

</figcaption>



The screenshot above shows the builder editing the **Mobile portrait** breakpoint.

Next to the breakpoint icons are inputs for width ("W"), height ("H"), and scale (%).

## Custom Breakpoints {#custom-breakpoints}

To start using custom breakpoints, you first have to enable them in your WordPress dashboard under `Bricks > Settings > General > Custom breakpoints`:

![](imgs/bricks-enable-custom-breakpoints-c0742e58dd.jpg)

Once enabled, you can access the **breakpoint manager** in the builder by clicking the three-dotted icon in the builder toolbar (next to the first breakpoint icon):



![](imgs/bricks-1.5.1-breakpoint-manager-default-breakpoints-c683d463e5.jpg)

<figcaption>

Breakpoint Manager (open via the three-dotted icon in the builder toolbar)

</figcaption>



### Editing a breakpoint

Clicking the pencil icon brings up the editing options of the selected breakpoint:



![](imgs/bricks-edit-default-breakpoint-e48254334e.jpg)

<figcaption>

Editing the default "Tablet portrait" breakpoint

</figcaption>



You can edit the following breakpoint properties:

| **Property** | **Description** |
| --- | --- |
| Label | Used when hovering over the breakpoint icon in the builder toolbar |
| Width (px) | @media query min-width/max-width value (depending on the base breakpoint) |
| Width (Builder) | Width is used when switching to the breakpoint in the builder |
| Icon | Used as the breakpoint icon in the builder toolbar |
| Base breakpoint | Set breakpoint as base breakpoint |
| *Key* | *Not customizable (used to store & identify breakpoint settings)* |

The most common action is to customize the widths of the default (mobile) breakpoints. The following screenshot shows you the "Tablet portrait" with a custom width of 1023px:

![](imgs/bricks-edit-breakpoint-width-1cbf3a9a28.jpg)

That means any styles set on the "Tablet portrait" breakpoint will apply to devices with a width of less than 1024px.

### Creating new breakpoints

You can create as many additional custom breakpoints as you want. Although, it is recommended to customize the widths of the default mobile breakpoints to your liking before utilizing more breakpoints.

You should rarely need more than one or two additional breakpoints on top of the default ones.

Clicking the "+" (plus) icon in the breakpoint manager's header launches the breakpoint creator form.

The following screenshot shows how we created a  new breakpoint named "Large" with a width of 1400px:



![](imgs/bricks-create-new-breakpoint-d53b575489.jpg)

<figcaption>

Creating a new breakpoint

</figcaption>



Once you click "Create" your newly created breakpoint should appear in the breakpoint manager (alongside a "CUSTOM" label) & in the builder toolbar like this:



![](imgs/bricks-custom-breakpoint-large-created-e8677be067.jpg)

<figcaption>

Breakpoint manager with new custom breakpoint

</figcaption>



As we've set the width of this new breakpoint to 1400px, it shows as the first breakpoint, as it is now the largest of our breakpoints. The Desktop (base breakpoint) has a default width of 1279px.

### Pausing a custom breakpoint

You can pause any of your custom breakpoints by toggling the checkbox at the right-hand side of the breakpoint manager:



![](imgs/bricks-pause-custom-breakpoint-ac70c2e7ef.jpg)

<figcaption>

Pausing custom breakpoint "Large"

</figcaption>



Pausing a custom breakpoint allows you to skip generating the styles for it on the frontend, while still retaining the styles you've set throughout your site without having to delete them one by one. Which, on a full-built-out site, can go into thousands of settings.

### Resetting a default breakpoint

To restore the default values of a default breakpoint, click on the "reset" icon (next to the pencil) icon.

### Resetting all breakpoints

Clicking the "gear" icon in the breakpoint manager header opens up the "Reset: Breakpoints" action. Clicking this button removes all your breakpoint edits (default & custom breakpoints) from the database.

:::note
**Breakpoint-specific settings performed on an element or the Theme Styles are not deleted. Please choose desktop or mobile-first at the very beginning.**
:::

![](imgs/bricks-reset-all-breakpoints-c0b6acf1af.jpg)

### Understanding the base breakpoint

The base breakpoint doesn't have a @media query. So all styles set on the base breakpoint apply to all screen widths.

That is why, by default, any styles set on the "Desktop" breakpoint are visible on any other breakpoint. Unless you specify a style on a specific breakpoint. Then the breakpoint-specific rule precedes the base breakpoint style.

When editing a breakpoint, you can set it as the "Base breakpoint". Then all styles set on this new base breakpoint are inherited up & down the breakpoint chain.

In the following screenshot, you can see that the "Tablet portrait" breakpoint has been set as the base breakpoint.

The yellow dot, lines, and arrows next to the breakpoint icons should help to visualize the style inheritance:



![](imgs/bricks-custom-base-breakpoint-d328bbf2a4.jpg)

<figcaption>

Changed base breakpoint to "Tablet portrait"

</figcaption>



### Mobile-first design {#mobile-first}

Styling in Bricks, by default, happens from the largest breakpoint down to "Tablet portrait" > "Mobile landscape" and "Mobile portrait".

Utilise a so-called `**mobile-first**` design approach by setting the smallest breakpoint as the base breakpoint.

The following screenshot shows the "Mobile portrait" (our smallest breakpoint) set as the base breakpoint. We now use the mobile-first approach. Also indicated by the "MOBILE FIRST" label in the breakpoint manager header:



![](imgs/bricks-mobile-first-b42051bcc1.jpg)

<figcaption>

Mobile-first design in Bricks

</figcaption>



You'll also notice that the order of the breakpoints is reversed and now starts at the smallest breakpoint. You can now start to design your pages starting at the smallest breakpoint.

### Regenerating (Bricks) CSS files

Whenever you customize the width of a default breakpoint, Bricks automatically updates any Bricks CSS files (like frontend.min.css, etc.) that contain media queries for this breakpoint.

If you experience that your breakpoint widths on the front end are not correctly applied, please regenerate your Bricks CSS files by clicking the "Regenerate CSS files" button under `Bricks > Settings > General > Custom breakpoints`.

## Responsive control indicator {#responsive-control-indicator}

In Bricks 1.11.1, we introduced the responsive control indicator which helps you see which controls can have different values at different breakpoints. We provide multiple options for when to show this indicator to suit different preferences. You can adjust these under `Bricks > Settings > Builder > Control panel > Responsive control indicator`:

- **Show if any value exists (Default)**: Displays if a control has any value set across breakpoints.
- **Show if non-base breakpoint value exists**: Shows only if a control’s value differs from the base breakpoint.
- **Show on all responsive controls**: Displays on all responsive controls, regardless of values.
- **Disable**.

![](imgs/bricks-responsive-control-indicator-20ed6c3e24.png)

---


## Revisions

*來源網址：https://academy-preview.bricksbuilder.io/builder/interface/revisions/*

Every time you perform a save in the builder, Bricks creates a revision/snapshot of your Bricks elements data (template, page, etc.). Using the official WordPress Revisions API.

You can browse, preview, and apply your revisions inside the builder by clicking the **Revisions** (clock) icon in the builder toolbar, then going to the "Revisions" tab.

Select any revision in this list to preview it. The canvas should automatically update showing you the selected revision.

Click **Apply** to continue editing the selected revision. Click **Discard** to continue editing your current version.

![](imgs/builder-revisions-1024x576-6f6134aa57.png)

## Manage the number of Bricks revisions {#bricks_max_revisions_to_keep}

In order to limit the number of Bricks revisions, you may define the constant `BRICKS_MAX_REVISIONS_TO_KEEP` like so (insert this code in the Bricks child theme):

```php
if ( ! defined( 'BRICKS_MAX_REVISIONS_TO_KEEP' ) ) {
    define( 'BRICKS_MAX_REVISIONS_TO_KEEP', 10 );
}
```

By default, Bricks sets the maximum to 100 revisions per post for the Bricks templates and enabled post types.

You may set the following values:

- true: unlimited revisions
- false or 0: do not store any Bricks' revisions
- value above 0: store up to this number of revisions per post. Old revisions are automatically deleted.

---


## Save & Publish

*來源網址：https://academy-preview.bricksbuilder.io/builder/interface/save-publish/*

Bricks, by default, automatically saves your builder changes every 60 seconds.

To adjust or disable the autosave interval go to **Bricks > Settings > Builder** in your WordPress admin area.

Bricks detects unsaved changes and will show you a prompt to help prevent data loss in case you reload the builder by accident.

To manually save your changes click the **Save** (disk) icon at the very right of the builder toolbar. Or use the [keyboard shortcut](/builder/interface/keyboard-shortcuts/) CMD/CTRL + S.

**Bricks creates a revision/snapshot** every time builder data is saved using the standard WordPress Revisions API ([learn more about revisions](/builder/interface/revisions/)).

Designing a stunning website or writing compelling content is hard. That's why Bricks celebrates every saved change by displaying a random save message to keep your spirit up :)

You can, of course, customize those save messages via the [bricks/builder/save_messages](/developer/hooks/filters/filter-save-messages/) filter.

## Publishing A Page

When an unpublished page (draft) is saved the status does not change by itself. So once your page is ready to be published click the **Publish** (power) icon in the builder toolbar.

---


## License, updates, and your account

*來源網址：https://academy-preview.bricksbuilder.io/builder/license/license-and-updates/*

For first-time installation and activation, follow [Installation and setup](/getting-started/installation-setup/).

This article covers **automatic updates**, **staging and safe updates**, **which URLs count toward your license**, and **managing activations** in your Bricks account.

Your Bricks account and downloads live at [my.bricksbuilder.io](https://my.bricksbuilder.io/) (same destination the theme uses for remote services).

## How to update Bricks {#how-to-update}

If you have activated your Bricks license key on your site, you'll automatically receive update notifications in your WordPress dashboard. You can then perform the update to the latest version of Bricks with one click from your WordPress dashboard.

![](imgs/bricks-wp-dashboard-how-to-update-41e0c3b43e.png)

You can also always manually download the latest version from your Bricks account at [https://my.bricksbuilder.io/](https://my.bricksbuilder.io/) as a ZIP file.

### Test on staging & read the changelog

We recommend to perform updating a mission-critical software like Bricks first on a staging server. Especially if your website is live, receives a lot of traffic, you are running marketing campaigns, offers, etc. Once you confirmed that everything is working as expected you can update your live site.

Every noticeable host offers, mostly free of charge, an easy one-click staging solution. Please reach out to your host if you are not sure how this works.

Every update is accompanied by an in-depth release changelog. Please take the time to go over it at [https://bricksbuilder.io/changelog/](https://bricksbuilder.io/changelog/) before you perform the update.

This way you know exactly what changed, if any adjustments or steps need to be performed on your end, which new features are available, and so on.

### Local, staging & intranet installations don't count against your license limit {#local}

The following URL structures are qualified as local, staging, or intranet sites and do not count against your license limit.

**Local URLs:**

- `192.168.x.x`
- `127.0.0.1`
- `localhost` (includes)
- `.local` (top-level domain)
- `.test` (top-level domain)
- `.wip` (top-level domain)

<span id="staging"></span>

**Staging URLs:**

- Staging subdomains (dev, staging, test)
  - `dev.yoursite.com`
  - `staging.yoursite.com`
  - `test.yoursite.com`
- Cloudways: `.cloudwaysapps.com`
- Dreamhost: `.stage.site`
- Flywheel: `.mysites.io`
- GoDaddy: `.myftpupload.com`
- Hostinger: `.hostingersite.com`
- InstaWP: `.instawp.site` & `.instawp.xyz` & `instawp.com`
- Kinsta: `.kinsta.cloud`
- Lando Pantheon: `.lndo.site`
- Plesk: `.plesk.page`
- Raidboxes: `.myrdbx.io`
- Runcloud: `.temp-site.link`
- TasteWP: `.tastewp.com`
- WP Engine:`.wpenginepowered.com`
- xCloud: `.wp1.site`
- ZipWP: `.zipwp.link`

<span id="intranet"></span>

**Intranet (top-level domains):**

- `.intranet`
- `.internal`
- `.private`
- `.corp`
- `.home`
- `.lan`

**With a Bricks Starter license (1 active site limit), you can build your site locally with Bricks & use your Starter license on your live site simultaneously.**

You can deactivate the license key from your site from your WP dashboard under `Bricks > License`, and activate it on another site or remove the site from your Bricks account under the "Sites" tab. We monitor any potential misusage (attempts to avoid purchasing a sufficient plan) and reserve the right to limit further license activations.

---


## Restrict License Key Usage

*來源網址：https://academy-preview.bricksbuilder.io/builder/license/restrict-license-key-usage/*

By default, you can activate your Bricks license key on any website that runs the Bricks theme. That is, if you have not already reached the site limit of your purchased license ([https://bricksbuilder.io/pricing/](https://bricksbuilder.io/pricing/)).

To restrict on which WordPress sites your license can be activated, navigate to the "Sites" tab of your Bricks account at [https://my.bricksbuilder.io/#sites](https://my.bricksbuilder.io/#sites) and scroll to the "Whitelist/blacklist URL" section at the bottom:

![](imgs/bricks-account-sites-whitelist-blacklist-urls-481c9e51b1.png)

There, you can add the URLs of the WordPress sites that you want to allow your license key to be activated at (= whitelist) or disallow your license key to be activated at (= blacklist).

**NOTE:** Removing an activated site from the list of sites at https://my.bricksbuilder.io/#sites is not enough to stop it from reappearing. Please make sure to remove the site, and add it to either the white- or blacklist.

### Using the correct site URL

To make sure you are adding the correct URL to the list, navigate the the WordPress dashboard of the site you want to exclude, and copy the URL under `Settings > General > Site Address`.

![](imgs/bricks-account-whitelist-site-address-829efe6f55.png)

If you don't have access to the backend of the site, use the home page URL of the site, but without any trailing slash at the end.

---


## Known issues

*來源網址：https://academy-preview.bricksbuilder.io/builder/setup/known-issues/*

## When I open the builder I don't see the elements on the canvas {#empty-canvas}

If you open the builder and you don't see the elements in the canvas but they are shown in the structure panel, and if you are using Cloudflare, then this is a known problem caused by a conflict between the [Cloudflare Rocket Loader](https://support.cloudflare.com/hc/en-us/articles/200168056-Understanding-Rocket-Loader)™ / other performance optimization feature and the Bricks builder JavaScript.

Starting with Bricks 2.0, a new **experimental setting** has been introduced to improve compatibility with Rocket Loader™. Enable it in **Bricks > Settings > Builder** and reload the builder page, your elements should now appear correctly on the canvas.

![](imgs/cloudflare-rocket-loader-b5c5c4edf4.png)

### Workarounds

### Method 1) Configuration Rules

Create a configuration rule for builder mode.

1. Log into the Cloudflare [dashboard](https://dash.cloudflare.com/login).
2. Select your account and website.
3. Go to Rules > Configuration Rules.
4. Create a new Rule, give it a name, and choose Custom filter expression
  - Field: URI Query String
  - Operator: contains
  - Value: bricks=run
5. Configure "Then the settings are…":
  - Add Rocket Loader and leave the checkbox empty.
6. Leave the other settings empty.
7. Save the rule by clicking "Deploy".
8. Wait for a few minutes and do a browser hard refresh in Bricks builder. (Clear browser caches)

![](imgs/bricks-known-issues-rocket-loader-rules-f9f51111eb.png)

![](imgs/bricks-known-issues-rocket-loader-expression-5afefcf404.png)

![](imgs/bricks-known-issues-rocket-loader-then-settings-8b8f3d768d.png)

![](imgs/bricks-known-issues-rocket-loader-deploy-5a85998048.png)

### Method 2) Disable Rocket Loader

Disable the Rocket Loader™ in the Cloudflare dashboard:

1. Log into the Cloudflare [dashboard](https://dash.cloudflare.com/login).
2. Select your account and website.
3. Go to Speed > Optimization.
4. Scroll down until you find Rocket Loader.
5. Turn it off.



### Method 3) Disable SiteGround Worker Routes

If the above 2 methods do not work and you are using SiteGround hosting, please check and disable the Worker created by SiteGround.

1. Log into the Cloudflare dashboard.
2. Select your account and website.
3. Go to Workers Routes.
4. If sg_worker exists or another suspicious worker is defined without your awareness, you can remove it.

![](imgs/sg-worker-in-cf-1024x640-457d4070fe.png)



![](imgs/remove-sg-worker-in-cf-eea22dca3e.png)

## GoDaddy MU Plugin Causing Empty Canvas {#godaddy-empty-canvas}

For **GoDaddy** users, if you're experiencing an empty canvas issue **without Cloudflare Rocket Loader**, the cause might be a MU plugin injected by GoDaddy hosting.

To resolve this, add the following snippet in your child theme's `functions.php` file or via a code snippets plugin to dequeue the problematic script:

```php
add_action( 'wp_enqueue_scripts', function() {
  if ( bricks_is_builder() ) {
    wp_dequeue_script( 'GoDaddy\WordPress\Plugins\Launch\PublishGuidepublish-guide-script' );
    wp_deregister_script( 'GoDaddy\WordPress\Plugins\Launch\PublishGuidepublish-guide-script' );
  }
}, 1000 );
```

This will prevent the GoDaddy MU plugin from interfering with Bricks' builder rendering.

## Copy/paste elements or styles not working {#copy-paste}

Bricks 1.5.1 uses the Clipboard API to copy and paste elements and styles across different domains.

:::note
Copy/paste is only supported for pages served over **HTTPS**.
:::

### Using Firefox

Firefox is more restrictive regarding reading from this API, which prevents the paste action, and therefore it requires the user to manually grant permission to use the API.

To do so, please follow these steps in your Firefox browser:

1. Enter `about:config` in navigation bar
2. Click "Accept the Risk and Continue"
3. Search `clipboard`  and set `dom.events.asyncClipboard.readText` and `dom.events.testing.asyncClipboard` to  `true`
4. Restart Firefox

## Internal server error (500) when trying to edit homepage with Bricks {#error-500}

![](imgs/internal-server-error-500-e5d8c5783b.png)

If you see a screen similar to the above, showing an internal server error (500) when trying to edit a page with Bricks (often reported as the homepage), you should look at the server logs and adjust the server configuration. This error is most probably caused by a security server configuration that prevents the request to hit WordPress and Bricks.

Some servers do not have the `SecResponseBodyLimit` defined leading to errors like:

```php
ModSecurity: Output filter: Response body too large (over limit of 1048576, total not specified).
```

(Note: the SecResponseBodyLimit sets the maximum response body size that will be accepted for buffering).

Check this [forum post](https://forum.bricksbuilder.io/t/solved-internal-server-error/1711) for possible solutions. If the issue persists, please contact your hosting support for guidance.

For **GoDaddy** users, you might need to add this line of code in your .htaccess file (first line)

```php
SubstituteMaxLineLength 10M
```

## My Blog page is not using the posts archive template {#blog-template}

![](imgs/bricks-blog-page-template-conditions-3045cf63dd.png)

The Blog page (WordPress Posts Page set in the Settings > Reading) is a special WordPress page, and therefore it is not an archive. If you want to set a Bricks template for the Blog page, you would need to set the template condition Individual and select the Blog page.

## I'm using SVG files in Bricks elements but I cannot change their color {#svg-styles}

This usually happens when your SVG file contains inline styles which override the styles generated by the Bricks builder. If you want to use these SVG files in combination with the Bricks style's controls, you need to remove the inline styles from the SVG file before uploading it to the WordPress installation.



![](imgs/Screenshot-2022-09-04-at-16.11.20-d939aeb45a.png)

<figcaption>

An example of an SVG file containing inline styles

</figcaption>



## Custom Fonts not working on the frontend {#custom-fonts}

If your custom fonts are not displayed in the frontend, it is probably because your WordPress website is delivered via HTTPS, but your WordPress URLs are still set to HTTP (WordPress Settings » General).

Changing the WordPress URLs from `http://` to `https://` will fix the problem and your fonts will be displayed correctly from now on.

## YouTube background video doesn't autoplay on mobile {#youtube-mobile-background-video}

This restriction is imposed by the YoutTube iFrame Player API and cannot be influenced by us. See [https://developers.google.com/youtube/iframe_api_reference#Mobile_considerations](https://developers.google.com/youtube/iframe_api_reference#Mobile_considerations)

However, Vimeo and local videos (mp4) should work as long as the mobile device is not in low-battery mode.

## Slider doesn't autoplay / Animation Flickering {#slider-autoplay}

This is most likely caused by the reduced motion or animation setting of your operating system.

On Windows, please make sure that the **"Show animations in windows"** setting is enabled:

![](imgs/show-animations-in-windows-1296bc3855.jpeg)

On macOS, please make sure that the **"Reduce motion"** setting is NOT enabled:

![](imgs/macos-reduce-motion-464e48da72.png)

## Invalid Post Type / Custom Post Type 404 Errors {#cpt-404}

This problem is probably [the most common problem](https://www.google.com/search?q=wordpress+404+cpt&sourceid=chrome&ie=UTF-8) in WordPress: your custom post type returns a 404 error. In most cases, however, the problem can be solved very easily.

### Re-save your permalink settings

All you have to do is go to WordPress » Settings » Permalinks and click on "Save Changes".

### Check for slug conflicts

The slug refers to the user-friendly and URL-valid name of a post, page, category, tag, or any content (even images) within your website. It is a part of the URL that identifies a specific piece of content.

Let's assume you have a "Portfolio" page whose slug is "portfolio". Now you create a custom post type called "Portfolio", whose slug is also "portfolio". If you now try to call up a single post from your portfolio (yoursite.com/portfolio/your-portfolio-post), there will be a 404 error too. To solve this issue, rename either the page slug, or the custom post type slug to something else. Re-save your permalinks again, and everything should work as expected.

## Builder changes not saved {#not-saved}

If you save changes in the builder and everything appears to be saved, but upon refreshing or viewing on the frontend the changes are lost, it could be due to an issue with your database schema.

Specifically, check the `meta_value` column in your `wp_postmeta` table (or your table prefix, e.g., `psjw_postmeta`). This column should be set to "LONGTEXT" to ensure it can store large amounts of data. If it's set to a type with a lower storage capacity, such as "TEXT," it may not save larger data correctly.

For more details on storage limitations, refer to this resource: [Understanding Storage Sizes for MySQL TEXT Data Types](https://www.atlassian.com/data/databases/understanding-strorage-sizes-for-mysql-text-data-types).

WordPress defaults to using "LONGTEXT" for the `meta_value` column, which allows for much larger data storage. See the default schema here: [WordPress Database Description](https://codex.wordpress.org/Database_Description).

To resolve this issue:

1. Check your `meta_value` column type in the `wp_postmeta` table (or `psjw_postmeta`).
2. Ensure it is set to "LONGTEXT."

You can change the column type to "LONGTEXT" using the following MySQL command:

```php
ALTER TABLE your_prefix_postmeta MODIFY COLUMN meta_value LONGTEXT;
```

Replace `your_prefix_postmeta` with your actual table name, e.g., `psjw_postmeta`.

1. Verify that other columns in your `postmeta` table match the default WordPress schema.

If you are not comfortable making these changes or are using a managed hosting provider, it's best to get in touch with your hosting provider. They can help address this issue, which might persist across different hosting services due to the migration of the incorrect database schema.

## Save button spinning endlessly due to ModSecurity {#not-saved-modsec}

If you find that the save button in the Bricks builder is spinning endlessly, and your server logs point to ModSecurity errors, this could be caused by certain ModSecurity variables being too restrictive:

- `SecRequestBodyLimit`
- `SecRequestBodyNoFilesLimit`
- `SecResponseBodyLimit`

While we can’t guarantee this will resolve your specific issue, other users have found that increasing these values fixed the problem.

The values can vary depending on your server, so you might need to experiment or consult your hosting provider to make these changes.

## Query Filter Indexer: No Progress {#query-filter-indexer-no-progress}

![](imgs/element-indexing-in-progress-01d73b525e.png)

If the filter element continues to display "Indexing in Progress" in the builder, try clicking the "Continue Index Job" button by following the instructions in [this article](/builder/dynamic-content/query-filters/#filter-index).

![](imgs/indexer-always-stuck-issue-7b51c43efb.png)

However, if the indexing jobs remain pending without any progress, it might be caused by specific firewall rules blocking the background process.

Best to check your website firewall settings or contact your hosting support. If your website is protected by HTTP Authentication, please add this [code snippet](/builder/dynamic-content/query-filters/#filter-index) in your child theme's functions.php as well.

<span id="cloudflare"></span>

For users with Cloudflare proxy enabled, ensure that Bot Fight Mode is disabled. [Refer to this guide to prevent false positives](https://developers.cloudflare.com/bots/troubleshooting/frequently-asked-questions/#what-should-i-do-if-i-am-getting-false-positives-caused-by-bot-fight-mode-bfm-or-super-bot-fight-mode-sbfm).

## Avoiding Slow Queries in Media/Attachment Dynamic Data {#avoid-slow-queries-in-media-attachment-dynamic-data}

When working with plugins like **ACF**, **Meta Box**, or **JetEngine** to create fields that store image or attachment file information, it is recommended to set the field’s return value to **object** or **ID** instead of **URL**.
Examples of Field Types:

- **ACF**: Image, Gallery, File
- **JetEngine**: Media, Gallery
- **Meta Box**: File Input, Image Select
- **Toolset**: Attachment URL to Post ID

This recommendation is important because Bricks uses the `attachment_url_to_postid` WordPress function to retrieve additional image data, such as dimensions and available sizes, when working with URL values. On websites with a large number of posts, this function can be resource-intensive, potentially slowing down page loading times.
By returning the field as an object or ID, Bricks can access the required data directly, improving performance and reducing the likelihood of slow queries.

## Slider doesn’t autoplay / Animations not working {#no-animation}

If your animations on your site are not working or your slider isn't autoplaying, it might be due to the "Reduce motion" setting on your device. This is an accessibility feature that Bricks respects. To see animations:

- **On Windows**: Ensure that the “Show animations in windows” setting is enabled.
- **On macOS**: Make sure that the “Reduce motion” setting is NOT enabled.

## Orphaned elements {#orphaned-elements}

In rare cases, Bricks element data may become corrupted. This can happen if a parent element (like a Section) is deleted but its child elements are not properly deleted due to a bug or third-party template import with corrupt data. These leftover elements are no longer linked to a valid parent and are referred to as **orphaned elements**.

Orphaned elements are not rendered in the builder or frontend but still exist in the page data, which can lead to unexpected issues such as:

- Orphaned text showing up in the WPML Advanced Translation Editor
- Incorrect filter element counts
- Unused styles or scripts (e.g. icon libraries) being loaded

### How to detect and clean up orphaned elements

Starting with Bricks 2.0, you can now detect and remove orphaned elements from within the builder.

Bricks automatically checks for orphaned elements on builder **load**. You can also:

1. Enable **“Check for orphaned elements on builder save”** in **Bricks Settings → General → Data integrity** to scan every time you save in the builder.
2. Add `&check=orphaned` to the builder URL to manually trigger a scan on save (helpful for debugging).

When enabled, Bricks will automatically check for orphaned elements on builder load and save. If any are found, you’ll see a notification with an option to **Clean up** the data. Clicking it will remove the orphaned elements from the current page.

After cleanup, we recommend reviewing your page to confirm everything looks correct. If anything went wrong, you can simply click undo to reverse the operation.

#### Site-wide orphaned elements review

You can also scan your entire site for orphaned elements from **Bricks Settings → General → Data integrity**. Click the **“Start: Orphaned elements review”** button to begin. Bricks will crawl all templates, pages, and any post type using Bricks, and list any that contain orphaned elements.

If no issues are found, you’ll see the message “No orphaned elements found”. If orphaned elements are detected, you’ll have the option to click **“Clean up all orphaned elements”**, which will remove them across all affected posts.

We recommend taking a backup before running the cleanup, just in case. Once confirmed, Bricks will proceed to delete the orphaned elements from each listed post.

---


## Requirements

*來源網址：https://academy-preview.bricksbuilder.io/builder/setup/requirements/*

This article is the **reference** for what your server and browser need to run Bricks, and how to fix common limits. The [Installation and setup](/getting-started/installation-setup/) guide links here when you need the full checklist or troubleshooting.

To provide you with a cutting-edge site builder for WordPress Bricks uses the most modern technology stack (VueJS 3, etc.) while keeping sufficient backward compatibility.

Below are the minimum requirements your server should meet so Bricks runs smoothly:

- PHP 7.4+ (recommended: 8.0+)
- MySQL 5.6+
- WordPress memory limit: min. 64 MB (recommended: 512 MB)
- Max file upload size: min. 64 MB
- Modern browser: **Please use the latest version of Chrome, Firefox, Safari, or Microsoft Edge when editing your website with Bricks**. Older browsers (e.g. Internet Explorer) lack support for some of the more advanced builder features.

:::note
*Bricks is a self-hosted solution that you download & install on your own WordPress website!*
:::

## How To Increase WP Memory Limit {#wp-memory-limit}

You can define **WP_MEMORY_LIMIT** by adding the following code to your **wp-config.php** file, above the line that says "That's all, stop editing!":

```php
define( 'WP_MEMORY_LIMIT', '512M' );
/* That's all, stop editing! Happy publishing. */
```

Some web hosts set the PHP memory limit to as low as 8 MB. In that case, you might consider upgrading to a more powerful hosting plan. If your host does not allow you to config this setting by yourself, please get in touch with them.

## How To Increase Max File Upload Size {#max-file-upload-size}

If you encounter problems uploading larger files to your site (or when downloading high-resolution images from Bricks' Unsplash integration) there are a few ways to increase the maximum upload file size.

A maximum upload size should be 64 MB or more. Log into your hosting account and change the following two **PHP server settings** to:

- post_max_size: 64M
- upload_max_filesize: 64M

If you have access to your **php.ini** file, located in the root directory of your WordPress installation, open it, and modify the following settings:

```php
upload_max_filesize = 64M
post_max_size = 64M
```

You can also add the following code to your **.htaccess** file, but make sure to backup your existing .htaccess file beforehand:

```php
php_value upload_max_filesize 64M
php_value post_max_size 64M
```

If all above fails, you can try adding the following code to your wp-config.php:

```php
@ini_set( 'upload_max_size' , '64M' );
@ini_set( 'post_max_size', '64M');
```

To confirm that your maximum upload file size has been updated successfully, go to **Media > Add New**. On the bottom of this page, you should see your maximum upload file size.

## How To Increase Maximum Execution Time {#max-execution-time}

When you start seeing a message like "Maximum execution time of 30 seconds exceeded" you have to increase the execution time of your website by using one of the following three solutions:

**#1: Add the following code to your wp-config.php file (above the "That's all, stop editing!" line):**

```php
set_time_limit(180);
/* That's all, stop editing! Happy publishing. */
```

**#2: Backup your .htaccess file and add the following code to it:**

```php
php_value max_execution_time 180
```

**#3: Add the following code to your php.ini file:**

```php
max_execution_time = 180
```

---


## Bricks Settings

*來源網址：https://academy-preview.bricksbuilder.io/builder/setup/settings/*

The Bricks settings screen (**Bricks > Settings**) is where you configure global options for your entire installation. Every setting documented here maps directly to what you see in the admin screen.

![](imgs/bricks-admin-settings-461a3c05a8.png)

Settings are split across tabs: **General**, **Builder access**, **Templates**, **Builder**, **Performance**, **Maintenance mode**, **API keys**, **Custom code**, and **WooCommerce** (only visible when WooCommerce is active).

At the top of the page you'll find two buttons:

- **Export settings**: Downloads your current Bricks settings as a JSON file. Security-sensitive settings (builder access capabilities, SVG upload permissions, code execution) are excluded from exports and must be configured manually after each import.
- **Import settings**: Uploads a previously exported JSON file to restore or transfer settings between installations.

---

## General

### Post types

Select which WordPress post types can be edited with Bricks. Pages are enabled by default. For post types where every post shares the same layout (e.g. Products, Properties), you typically don't need to enable them here. Create a Bricks template with appropriate conditions instead.

### Block editor

Controls how Bricks interacts with WordPress block editor (Gutenberg) data.

- **Load Block editor data into Bricks**: When editing a page that has existing block editor content, Bricks will attempt to convert and load that content into the builder.
- **Save Bricks data as Block editor data**: Each time you save in Bricks, Bricks will attempt to write a Gutenberg-compatible copy of your content so it's visible in the standard WordPress editor. Not all elements are supported.

See the [Gutenberg integration](/integrations/gutenberg) article for more details.

#### Bricks components in the block editor <span title="Experimental">experimental</span>

Introduced in Bricks 2.1. Determines how Bricks components are made available as Gutenberg blocks.

- **Disabled (default)**: Components are not exposed in the block editor.
- **Enable individual components manually**: Each component must be explicitly enabled for block editor use.
- **Enable all components automatically**: All components are registered as block editor blocks automatically.

### SVG uploads

WordPress disables SVG uploads by default because SVG files are XML-based and can contain malicious scripts. This setting lets you enable SVG uploads per user role for roles with at least the `edit_posts` capability. All uploaded SVGs are automatically sanitized. Enable only for roles you trust.

See the [SVG uploads](/builder/features/svg-uploads) article for more details.

### Miscellaneous

- **Disable global class manager**: Removes the global class manager panel from the builder interface.
- **Disable CSS variables manager**: Removes the CSS variables manager panel from the builder interface.
- **Disable Bricks Open Graph meta tags**: Stops Bricks from outputting its own Open Graph meta tags. Use this when another plugin like Yoast SEO or RankMath handles these.
- **Disable Bricks SEO meta tags**: Stops Bricks from outputting its own SEO meta tags. Use when an external SEO plugin handles these.
- **Generate custom image sizes**: Tells WordPress to generate the custom image sizes registered by Bricks when images are uploaded.
- **Add element ID as needed**: By default, Bricks adds the element's unique ID and class attributes to every rendered element regardless of whether it has any styles applied. With this setting enabled, Bricks skips those attributes on elements that have no CSS settings, producing slightly leaner HTML. Always added in the builder regardless of this setting.
- **Disable "Skip links"**: Removes the accessibility skip-navigation links Bricks injects at the top of each page (e.g. "Skip to main content"). Only disable if your theme handles skip links separately.
- **Smooth scroll**: Adds `scroll-behavior: smooth` globally via CSS, enabling smooth scrolling for anchor link navigation.
- **Enable "Delete Bricks data" button**: Reveals a "Delete Bricks data" button in the post/page edit screen that removes all stored Bricks data for that post. Requires explicit enabling to prevent accidental data loss.
- **Query Bricks data in search results**: Extends WordPress search to also query the post meta tables where Bricks stores page content. Text placed inside Bricks elements becomes searchable through WordPress native search.

### Theme styles: Loading method

Controls which theme styles are applied when multiple theme styles have conditions that match the current page.

- **Most specific (default)**: Only the single highest-scoring theme style is loaded, where score is based on condition specificity.
- **Load all matching theme styles**: All theme styles whose conditions match the current context are loaded and merged. More specific styles take precedence.

### Duplicate content

Controls who can use the "Duplicate" feature on posts and pages. By default, any user with the `edit_post` capability can duplicate content.

- **Enable (default)**: Duplication is available to all users with `edit_post` capability.
- **Disable globally**: Removes the duplicate option for all users.
- **Disable for WordPress data**: Disables duplication of WordPress core data (post title, content, etc.) while still allowing Bricks data duplication.

For advanced rules, use the [`bricks/use_duplicate_content`](/developer/hooks/filters/filter-bricks-use_duplicate_content) filter.

### Form submissions

- **Save form submissions in database**: Enables the built-in form submission storage system. Submissions from the Bricks Form element are stored in a custom database table and accessible under **Bricks > Form submissions**.
- **Form submission access**: Select which user roles can view stored form submissions. Administrators always have access. Individual user access can also be set via the user profile edit page.
- **Reset database table**: Clears all stored form submission records while keeping the table structure.
- **Delete database table**: Drops the custom form submissions database table entirely. Only visible when form submissions are enabled.

### Query filters

Enables the query sort, filter, and live search system for Post, Term, and User query loops. Powers the Filter element.

- **Enable query sort / filter / live search**: Activates the query filter system and creates the required database index table.
- **Custom fields integration**: Enables ACF and Meta Box field integration with query filters, so you can filter results by custom field values. See the [query filters](/builder/dynamic-content/query-filters#custom-fields-integration) article.

When enabled, an indexer manages a background database index used for filtering:

- **Regenerate filter index**: Rebuilds the filter index for the entire site. Run this after enabling filters or after major content changes.
- **Continue index job**: Immediately runs any queued index jobs without waiting for the next WP cron execution.
- **Fix corrupted database**: Appears when database corruption is detected. Repairs the filter index tables.
- **Remove all index jobs**: Clears all queued indexer jobs. Use this if the indexer gets stuck, then regenerate the index afterwards.

If your indexer makes no progress, see the [known issues: indexer no progress](/builder/setup/known-issues#query-filter-indexer-no-progress) article.

Avoid using query filters in combination with third-party filter plugins.

### Custom breakpoints

Enables custom breakpoints beyond Bricks' default set. Configure these before you start designing your site.

See [responsive editing](/builder/interface/responsive-editing#custom-breakpoints) for details.

- **Regenerate CSS files**: When using external CSS file loading, regenerates all CSS files to reflect the current breakpoint configuration.

### Custom authentication pages

Replaces WordPress' default `wp-login.php` authentication pages with your own Bricks-built pages.

See [custom authentication pages](/builder/features/custom-authentication-pages) for setup instructions.

- **Login**: Select the page to use as the custom login page.
- **Registration**: Select the page to use as the custom registration page.
- **Lost password**: Select the page to use as the custom lost password page.
- **Reset password**: Select the page to use as the custom reset password page.

#### WordPress authentication page access

Determines what happens when a visitor goes directly to a default WordPress authentication URL (e.g. `wp-login.php`). Only applies when custom pages above have been set.

- **Redirect to custom authentication page (default)**: Sends the visitor to the appropriate custom page set above.
- **Error page**: Returns a 404 error page.
- **Home URL**: Redirects to the homepage.
- **Redirect to specific page**: Redirects to any page you select from a dropdown.

**Disable custom authentication page bypass**: By default, anyone can access the original WordPress auth pages by appending `?brx_use_wp_login` to the URL. Enable this to remove that bypass and enforce your custom authentication pages in all cases.

### User activation

When enabled, newly registered users receive an email with an activation link they must click to activate their account. Applies to all new user registrations site-wide, not only those submitted through the Bricks Form element.

- **User activation**: Enables the email verification flow.
- **Auto login after activation**: Automatically logs the user in after they click the activation link.
- **Verification success page**: The page users are sent to after successful activation.
- **Verification failure page**: The page users are sent to if activation fails or the link is invalid.

An **Activation status** column appears under **Users** so you can manually set users as active/inactive and resend activation emails.

#### User activation: Email

Configure the activation email sent to new users. Only visible when user activation is enabled.

- **From email address**: Sender email address. Falls back to the WordPress default.
- **From name**: Sender display name. Falls back to `WordPress`.
- **Subject**: Email subject line. Default: "Activate your account".
- **Email content**: Body of the activation email. Supports template parameters for site name, site URL, username, user email, and an activation link or raw activation URL.
- **HTML email**: Send the email as HTML instead of plain text.

### Password protection

Enables the password protection system for pages and templates. Password protection restricts frontend access only and does not affect the REST API or other access methods. For sensitive data, use more restrictive security controls.

See the [password protection](/builder/features/password-protection) article for details on applying protection to individual pages.

### Orphaned elements

Orphaned elements are elements whose parent no longer exists in the data, which can cause layout issues.

- **Check for orphaned elements on builder save**: Runs a scan for orphaned elements every time you save in the builder. Bricks always checks on load regardless of this setting. You can also trigger a check manually by adding `?check=orphaned` to the builder URL.
- **Start: Orphaned elements review**: Scans your entire site for orphaned elements and reports them. Results appear in-place after clicking the button.

See [known issues: orphaned elements](/builder/setup/known-issues#orphaned-elements) for more information.

---

## Builder access

Configure who can open the Bricks builder and what they can do inside it. See the [builder access](/builder/interface/builder-access) article for a full overview.

### Builder capabilities <span title="Experimental">experimental</span>

Bricks ships with three predefined capability levels:

- **Full access**: Grants access to all builder features.
- **Edit content**: Content editing only. Layout, styling, and structural controls are disabled.
- **No access**: Blocks builder entry completely.

You can create **custom capabilities** with granular permission control by clicking **Add new capability**. Custom capabilities can be named, given a description, and configured with only the permissions you want to grant. Once created, they appear in the builder access dropdowns alongside the defaults.

Administrators always have full access and cannot be restricted.

### Builder access

Assign a builder capability to each WordPress user role. Select from the predefined capabilities or any custom capability you've created.

To set access for a specific individual user, edit that user's WordPress profile directly.

Note: Any user role with the `manage_options` WordPress capability has full builder access regardless of this setting.

---

## Templates

### My templates

Settings for your locally created Bricks templates.

- **Template screenshots**: Bricks automatically generates a screenshot of each template on every builder save. Screenshots appear in the template manager thumbnail and can also be bulk-generated from the template manager. A "Delete screenshots" button appears once screenshots exist.
- **Template manager thumbnail height**: Maximum height in px for template thumbnails in the builder's template manager. Templates taller than this auto-scroll on mouseover.
- **Template thumbnail column**: Shows a thumbnail column in the **Bricks > Templates** admin list, displaying the featured image or screenshot.
  - **Template thumbnail column: Width**: Column thumbnail width in px. Default: 60.
  - **Template thumbnail column: Height**: Column thumbnail height in px. Default: 60.
- **Disable default templates**: By default, if a published Bricks template exists with no conditions set, Bricks renders it on the frontend. Enable this to disable that fallback behavior and require explicit conditions on all templates.
- **Public templates**: When enabled, your templates can be viewed by anyone. When disabled, only logged-in users can view templates.
- **My templates access**: Allows other Bricks installations to browse and import your templates from their own template library. Restrict access using the whitelist and password settings below.
- **Whitelist URLs**: Limits remote template access to specific site URLs. Enter one URL per line. Leave blank to allow any site.
- **Password protection**: Adds a password that remote sites must enter to access your templates.
- **Exclude templates**: Select specific templates to exclude from remote access even when access is otherwise enabled.

### Remote templates

Configure remote Bricks installations to pull templates from in your local template library. You can add multiple remote sources.

For each remote source:

- **Name**: Label shown in the template source dropdown instead of the URL.
- **URL**: Full URL of the remote Bricks installation. The remote site must have "My templates access" enabled.
- **Password**: The password set on the remote site under "My templates access: Password protection."

See the [remote templates](/builder/features/remote-templates) article for setup instructions.

### Miscellaneous

- **Convert templates**: When importing or inserting a template built with the old `Container` element structure, Bricks automatically converts it to the current layout structure (Section > Container > Block / Div). See the [layout](/builder/styling/layout) article for the current element hierarchy.

---

## Builder

### Autosave

- **Disable autosave**: Turns off automatic background saving. The autosave creates a recovery copy of all canvas elements. Global data (components, classes, variables) is not included. Autosaves can be restored from **Manage > History / Revisions** in the builder toolbar.
- **Autosave interval**: How often the autosave runs, in seconds. Default: 60. Minimum: 15.

### Builder mode

Sets the visual theme of the builder UI.

- **Dark (default)**: Dark background builder interface.
- **Light**: Light background builder interface.
- **Custom**: Define your own builder color scheme using CSS variables. See [builder mode](/builder/interface/builder-mode) for available CSS variables.

When "Custom" is selected, a code editor appears for entering your CSS variable overrides.

### Language

- **Builder language**: Sets the language for the builder UI, independent of the WordPress site language. Defaults to the site language.
- **Builder language direction**: Overrides the text direction in the builder.
  - **Auto (default)**: Determined by the selected language.
  - **Left to right**
  - **Right to left**

### Toolbar logo link

Sets what happens when you click the Bricks logo in the builder toolbar.

- **View on frontend (default)**: Opens the frontend view of the currently edited page.
- **Home page**: Links to the site homepage.
- **Dashboard**: Links to the WordPress admin dashboard.
- **Post type**: Links to the post type list in WordPress admin.
- **Edit in WordPress**: Opens the standard WordPress editor for the current post.
- **Custom URL**: Links to any URL you specify.
- **No link**: Removes the link from the logo.

**Open in new tab**: Opens the logo link destination in a new browser tab.

### Control panel

Fine-tune the behavior of the builder's settings panel.

- **Class preview on hover**: When hovering over a global class name in the classes field, shows a preview of the styles defined in that class.
- **Color preview on hover**: Shows a color swatch when hovering over color values in the control panel.
- **Variable preview on hover**: Shows the resolved value of a CSS variable when hovering over it in dropdowns or input fields.
- **Disable auto-expand**: Prevents text editor and code controls from automatically expanding when you focus them.
- **Disable pinned control groups**: Disables the ability to pin frequently used control groups to keep them open.
- **Disable global classes (interface)**: Hides the global classes UI in the control panel. Global classes can still be used programmatically. This is distinct from disabling the global class manager under General.
- **Variable dropdown: Hide value**: In the CSS variable picker dropdown, hides the resolved value shown next to variable names.
- **Code control: Vim toggle**: Enables Vim keybindings in CodeMirror code editors within the builder.
- **Spacing control: Remember linked state**: Persists the linked/unlinked state of spacing controls (margin, padding, border-radius) across all elements. When enabled, if you set one element's padding to "all sides linked," subsequent spacing controls open in that same state.

#### Element breadcrumbs

Shows a breadcrumb trail above the element in the control panel indicating where you are in the element hierarchy.

- **Disabled (default)**
- **Show default element names**: Uses Bricks' built-in element type names (e.g. "Section > Container > Text").
- **Show custom element names**: Uses the custom names you've assigned to elements.

#### Responsive control indicator

Controls when an indicator icon appears on controls that support per-breakpoint values.

- **Show if any value exists (default)**: Shown when any value (including base/desktop) is set.
- **Show if non-base breakpoint value exists**: Shown only when a tablet or mobile override exists.
- **Show on all responsive controls**: Always visible on every control that supports responsive values.
- **Disable**: Never shown.

#### Control group visibility

- **Hide if not open (default)**: Control groups are collapsed until clicked.
- **Always show**: All control groups are expanded at all times.

#### Font family options

- **Show all fonts (default)**: All available fonts appear in the font family dropdown.
- **Show favorites only**: Only fonts you've marked as favorites appear.

### Canvas

- **Disable element spacing**: Removes the visual margin and padding indicators on elements when selected in the builder canvas.
- **Auto scroll element into view**: When you select an element in the structure panel, the canvas scrolls to bring it into view. Set the scroll offset as a percentage (e.g. `50%` centers the element) or `off` to disable. Default: `0`.

### Structure panel

- **Element actions: Duplicate**: Adds a "Duplicate" button to each element row in the structure panel.
- **Element actions: Delete**: Adds a "Delete" button to each element row in the structure panel.
- **Collapse on page load**: The structure panel opens with all element groups collapsed when you first open the builder.
- **Expand active element & scroll into view**: When you select an element on the canvas, the structure panel automatically expands its parent groups and scrolls to show it.

### Element actions

#### Wrap element

Sets the default wrapper element used when wrapping an element (via keyboard shortcut or right-click context menu).

- **Block (default)**
- **Div**
- **Container**

#### Insert element

Sets the default element type inserted via the "+" icon or right-click context menu.

- **Block (default)**
- **Div**
- **Container**

#### Insert layout

Sets the element type used when inserting a layout via the "Layout" action icon.

- **Block (default)**
- **Div**
- **Container**

#### Import pasted images/SVGs

When pasting elements from a different site, images and SVGs are represented as placeholders by default because source URLs may not be accessible. Enable this to have Bricks download and import those assets from the source site into the local media library.

Only applies to Image, Image Gallery, and SVG elements. Images with a custom URL or dynamic data tag as their source are not imported.

### WP polyfill

Loads `wp-polyfill.min.js` in the builder to improve compatibility with older browsers. Not recommended for modern browsers due to the performance overhead.

### Cloudflare Rocket Loader <span title="Experimental">experimental</span>

Enable if the builder fails to load when Cloudflare Rocket Loader is active. Rocket Loader defers JavaScript loading and can interfere with the builder's initialization.

### Query loop

- **Max results**: Limits the number of results displayed per query loop in the builder canvas. Useful for keeping the builder fast when queries return large result sets. Applies to Bricks-native queries only. Minimum: 2.
- **Show query loop type**: Shows the underlying object type key in the query loop type dropdown (e.g. `acf_related_writers`, `mb_page-to-user`). Useful for developers working with custom query integrations.

### Dynamic data

- **Render dynamic data text on canvas**: Bricks evaluates and renders dynamic data tags live on the builder canvas so you see real content instead of tag placeholders.
- **Disable WordPress custom fields in dropdown**: Hides WordPress custom fields from the dynamic data tag dropdown. Can noticeably improve builder performance on sites with many custom fields. You can still use these fields by typing tags like `{cf_my_field}` directly.
- **Dropdown: Show dynamic data key**: Shows the tag key (e.g. `{post_title}`) alongside the label in the dynamic data dropdown.
- **Dropdown: Hide dynamic data label**: Hides the human-readable label and shows only the tag key in the dropdown.
- **Dropdown: Expand panel when dropdown is visible**: Widens the control panel when the dynamic data dropdown is open so more items are visible.

### Global data sync <span title="Experimental">experimental</span>

When multiple people work in the builder at the same time, saves can overwrite each other's global class changes. Enabling this syncs global classes on every builder save across all open builder instances.

### Global class import manager

Controls when the global class import manager dialog appears when pasting elements, importing classes, or inserting templates that contain classes.

- **Show for class conflicts (default)**: Opens when an imported class conflicts with an existing one (same name, different styles).
- **Show for new classes**: Opens when imported content contains classes not yet in your library.
- **Show for new & conflicting classes**: Opens for both new and conflicting classes.
- **Never**: Applies imported classes silently without the dialog.

### Render

- **Disable WP REST API render**: By default, the builder uses the WP REST API to render elements on the canvas. Enable this to fall back to AJAX rendering. Only use if you experience rendering issues such as when the REST API is blocked on your server.

### Instant navigation <span title="Experimental">experimental</span>

Switch between pages and templates in the builder without a full page reload. Useful when working across multiple pages in sequence.

---

## Performance

### Disable emojis

Removes WordPress' emoji conversion script and CSS (`wp-emoji-release.min.js`). Recommended if you don't use emojis in your content, as it removes an unnecessary HTTP request.

### Disable embed

Removes WordPress' oEmbed scripts and the ability to paste URLs to auto-embed content. Recommended if you don't embed external content like YouTube videos or tweets.

### Disable Google Fonts

Stops Bricks from loading Google Fonts from Google's CDN. Enable if you don't use any Google Fonts, or if you've uploaded and self-host your Google Fonts as custom fonts.

### Disable lazy loading

Bricks applies native lazy loading to images by default. Disable if lazy loading causes display problems on your site.

- **Lazy load offset**: How many pixels before an image enters the viewport for it to start loading. Default: 300px.

### Disable jQuery migrate

Removes the `jquery-migrate.min.js` script WordPress includes for backward compatibility with older jQuery code. Safe to disable if you're not running any jQuery older than version 1.9.

### Cache query loops

Caches query loop results using WordPress' object cache. The cache key includes the element ID, query vars, and parent loop context, so different queries produce separate cache entries. Works best when query arguments stay relatively stable between requests.

For caching that persists across page loads, a server-level object cache (Redis, Memcached) must be in place. Disable this if you see unexpected or stale query results.

### Disable class chaining

By default, when an element has a global class applied, Bricks generates CSS selectors that chain the global class with the element type class (e.g. `.my-class.brxe-button`). This raises selector specificity. Enabling this removes that chaining so the selector becomes just `.my-class`. Useful in edge cases where the higher specificity conflicts with third-party CSS.

### CSS loading method

Controls how Bricks outputs page-specific CSS.

- **Inline styles (default)**: CSS is included in `<style>` tags directly in the HTML. Always current, no caching.
- **External files**: Bricks generates `.css` files in the `wp-content/uploads/bricks/css/` directory and loads them as external stylesheets. Enables browser and CDN caching. The uploads directory must be writable.

When external files are selected, a **Regenerate CSS files** button appears. The date and Bricks version of the last regeneration is also shown.

See the [asset loading](/developer/guides/asset-loading) article for a detailed comparison.

### Webfont loading method

Only visible when Google Fonts are not disabled.

- **Stylesheets (default)**: Fonts are loaded via a `<link>` stylesheet. Can cause a Flash of Unstyled Text (FOUT) before fonts load.
- **Webfont Loader (JS)**: Uses the Webfont Loader library to manage font loading. Hides site content until fonts have loaded, preventing FOUT.

### Preload custom fonts

When using self-hosted custom fonts, enabling this adds `<link rel="preload">` tags for those font files in the `<head>`, so the browser fetches them earlier and avoids FOUT. Added in Bricks 2.0.

### Cascade layer <span title="Legacy">legacy</span>

Bricks uses a CSS cascade layer system to manage style specificity and prevent unintended overrides. Disabling it reverts to the older behavior without cascade layers.

Strongly discouraged. Leave this off unless you have a specific compatibility reason for doing so. See the [Bricks cascade layer system](/builder/styling/cascade-layer) for details.

---

## Maintenance mode

### Mode

Activates a site-wide maintenance or coming soon page.

- **Disabled (default)**: Site is fully accessible.
- **Maintenance**: Returns HTTP status code 503, indicating temporary unavailability. Search engines treat this as "check back later."
- **Coming soon**: Returns HTTP status code 200. The site is accessible to search engine indexing while showing the maintenance page.

### Template

Select a Bricks template (type: Single) to display as the maintenance or coming soon page. The template must be published.

- **Render header**: Include your header template on the maintenance page.
- **Render footer**: Include your footer template on the maintenance page.
- **Render popups**: Include popup templates on the maintenance page.

### Bypass maintenance

Controls which logged-in users can bypass maintenance mode and see the real site.

- **Logged-in users (default)**: All logged-in users bypass the maintenance page.
- **Logged-in users with role**: Only users with the selected roles bypass maintenance. Administrators always bypass.

Individual user bypass can also be granted via the user's profile page.

### Exclude posts/pages

Select specific pages or posts that stay publicly accessible while maintenance mode is active.

---

## API keys

Paste third-party service credentials here. Keys are partially obfuscated on screen for security.

- **Adobe Fonts (Project ID)**: Your Adobe Fonts (Typekit) project ID. After saving, click **Sync fonts** to pull the font list from the Typekit API. See [Adobe fonts](/builder/styling/adobe-fonts) for setup instructions.
- **Unsplash: API key**: Enables the Unsplash image search integration in the media picker. See [Unsplash](/integrations/unsplash) for setup instructions.
- **Google Maps: API key**: Required for the Google Maps element. See the [Google Maps API documentation](https://developers.google.com/maps/documentation/javascript/get-api-key) for how to obtain a key.
- **Google reCAPTCHA v3: Site key**: Public site key for reCAPTCHA v3 integration with Bricks forms.
- **Google reCAPTCHA v3: Secret key**: Private secret key for server-side reCAPTCHA v3 verification. See [Google reCAPTCHA v3 documentation](https://developers.google.com/recaptcha/docs/v3).
- **hCaptcha: Site key**: Public site key for hCaptcha integration.
- **hCaptcha: Secret key**: Private secret key for hCaptcha server-side verification. See [hCaptcha documentation](https://docs.hcaptcha.com/switch/#get-your-hcaptcha-sitekey-and-secret-key).
- **Cloudflare Turnstile: Site key**: Public site key for Cloudflare Turnstile CAPTCHA integration.
- **Cloudflare Turnstile: Secret key**: Private secret key for Turnstile verification. See [Cloudflare Turnstile documentation](https://developers.cloudflare.com/turnstile/get-started/).
- **MailChimp: API key**: Connects to the MailChimp API to power the MailChimp form action in Bricks forms. Save settings to sync your audience lists. See [MailChimp API keys](https://mailchimp.com/help/about-api-keys/).
- **SendGrid: API key**: Connects to SendGrid to power the SendGrid email action in Bricks forms. Save settings to sync lists. See [SendGrid API keys](https://sendgrid.com/docs/ui/account-and-settings/api-keys/#creating-an-api-key).
- **Facebook App ID**: Required for Facebook-powered features. See [Facebook App registration](https://developers.facebook.com/docs/apps#register).
- **Instagram Access Token**: Required for the Instagram feed element. See [Instagram access token](/integrations/instagram-access-token) for how to generate a token.

---

## Custom code

### Code review

A site-wide audit tool that scans for all Code elements (PHP & HTML), SVG elements with inline code, query editor instances, and `{echo:}` dynamic data tags.

Click **Start: Code review** to generate a full report. Results show which page or template contains each code instance, the element type, and the code content. Use the filter dropdown to narrow results by type (Code, SVG, Query editor, Echo tags).

Code instances are tagged with their signature status:

- **No signature**: Code has never been signed.
- **Invalid**: Code has been modified since it was last signed.
- **Valid**: Code is signed and unmodified.

When Echo tags are detected, a code snippet is shown at the bottom of the results ready to copy into your child theme to whitelist those functions via the [`bricks/code/echo_function_names`](/developer/hooks/filters/filter-bricks-code-echo_function_names) filter.

### Code execution

Controls the ability to execute PHP code via Code elements, SVG element code, Query editors, and `{echo:}` dynamic data tags.

- **Enable code execution**: Globally enables code execution. Off by default.

When enabled, you must also grant the execute code capability to specific roles or individual users:

- **User roles with code execution capability**: Checkboxes for each role with at least `edit_posts` capability.
- **Individual users with code execution capability**: Lists users who have been individually granted code execution via their user profile. Edit a user profile directly to grant or revoke access.

> Grant code execution only to trusted users, and prefer per-user grants over role-based grants where possible.

Function names used in `{echo:}` tags must be whitelisted separately via the [`bricks/code/echo_function_names`](/developer/hooks/filters/filter-bricks-code-echo_function_names) filter.

The `bricks/code/disable_execution` filter can forcibly disable code execution regardless of these settings. When active, an info notice appears here.

### Code signatures

Code signatures cryptographically sign code content. Signed code that has been modified since signing is treated as invalid and will not execute.

- **Regenerate code signatures**: Signs all Code elements, SVG elements, and Query editors site-wide. Always create a full-site backup and run the code review above before generating signatures globally.

Signatures must be regenerated whenever your WordPress secret keys (salts) change, as the signatures are derived from them.

### Custom CSS

Global CSS applied to every page on your site. Output as an inline `<style>` block in the `<head>`. Use this for global overrides, utility classes, or styles that need to apply everywhere.

For page-specific CSS, use the Custom CSS control in the page settings panel inside the builder. See the [custom code](/builder/features/custom-code) article.

### Header scripts

Scripts (and other HTML) injected right before the closing `</head>` tag on every page. Wrap scripts in `<script>` tags. Common uses: analytics tracking tags, tag manager snippets, preconnect hints.

### Body (header) scripts

Scripts injected immediately after the opening `<body>` tag on every page. Wrap scripts in `<script>` tags. Common uses: Google Tag Manager `<noscript>` fallback, chat widgets.

### Body (footer) scripts

Scripts injected right before the closing `</body>` tag on every page. Wrap scripts in `<script>` tags. Common uses: analytics event scripts, deferred third-party libraries.

---

## WooCommerce

This tab is only visible when WooCommerce is installed and active.

### Miscellaneous

- **Disable WooCommerce builder**: Disables all Bricks WooCommerce-specific elements and features, reverting to default WooCommerce output.
- **Enable Bricks WooCommerce "Notice" element**: All native WooCommerce notices are removed when this is enabled. You must manually add the Bricks "Notice" element wherever notices should appear (cart page, checkout page, etc.).
- **Enable Bricks WooCommerce "Checkout coupon" element**: Removes the native WooCommerce checkout coupon form. You must manually add the Bricks "Checkout coupon" element to your checkout page. Requires "Enable the use of coupon codes" to be active in WooCommerce > General.
- **Enable Bricks WooCommerce "Checkout login" element**: Removes the native WooCommerce checkout login form. You must manually add the Bricks "Checkout login" element to your checkout page. Requires "Enable log-in during checkout" in WooCommerce > Accounts & Privacy.
- **Show quantity input field in product loop**: Adds a quantity input field next to the add-to-cart button in product loops. Applies to purchasable simple products that are in stock only.
- **Enable product variation swatches**: Converts product variation attribute dropdowns to visual swatches (color, image, or label) on the add-to-cart element for variable products.

### Products

- **Product badge "Sale"**: Controls the content of the sale badge on sale products.
  - **None (default)**: No sale badge.
  - **Text**: Shows the word "Sale".
  - **Percentage**: Shows the discount percentage (e.g. "25% off").
- **Product badge "New"**: Shows a "New" badge on products published within the specified number of days. Leave blank to disable.

### Single product

- **Disable product gallery zoom**: Disables the zoom-on-hover behavior on single product gallery images.
- **Disable product gallery lightbox**: Disables the lightbox that opens when clicking product gallery images.

### AJAX add to cart

Enables asynchronous add-to-cart on product archives and loops without requiring a page reload.

- **Enable AJAX add to cart**: Overrides WooCommerce's native AJAX add to cart on archive pages. Only simple products within query loops benefit from this. Requires "Enable AJAX add to cart buttons on archives" to be active in WooCommerce > Products settings.

**Adding state:**

- **Button text: Adding**: Text shown on the button while the add-to-cart request is in progress. Default: "Adding".

**Added state:**

- **Button text: Added**: Text shown on the button after the item is successfully added. Default: "Added".
- **Reset text after .. seconds**: How many seconds before the button text reverts to the original label. Default: 3.
- **Hide "View cart" button**: Hides the "View cart" link WooCommerce shows after an item is added.
- **Show notice**: Displays a WooCommerce notice when the item is successfully added.
- **Scroll to notice**: Scrolls the page to the notice after a successful add-to-cart.

**Error handling:**

- **Action on error**: What happens when an add-to-cart error occurs (e.g. a variable product that requires attribute selection).
  - **Redirect to product page (default)**: Sends the user to the product's single page.
  - **Show notice**: Displays an inline error notice.
- **Scroll to notice on error**: Scrolls to the error notice. Only visible when "Show notice" is selected as the error action.

---


## Integration: Adobe Fonts

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/adobe-fonts/*

## How to use Adobe Fonts with Bricks

All you need to do is provide Bricks with your Adobe Fonts "Project ID".

First, visit the "web projects" section inside your Adobe Fonts account: [https://fonts.adobe.com/my_fonts#web_projects-section](https://fonts.adobe.com/my_fonts#web_projects-section)

Each of your web projects contains a unique "Project ID".

Copy the project ID of the web project whose fonts you want to use on your Bricks site.



![](imgs/bricks-adobe-fonts-web-project-id-dad703e0c6.png)

<figcaption>

Copy the project ID into your clipboard

</figcaption>



Next, inside your WordPress dashboard, go to `Bricks > Settings > API keys` and paste the project ID into the "Adobe fonts (Project ID)" input field. Then save your settings.



![](imgs/bricks-adobe-fonts-project-id-saved-e16137ff86.png)

<figcaption>

Click "Sync fonts" to fetch all fonts of this project

</figcaption>



Next to the project ID input, a "Sync fonts" button should now be visible. Click it to fetch the Adobe fonts of this project. A success message should appear & the "Published Adobe fonts" counter should reflect the number of published fonts.



![](imgs/bricks-adobe-fonts-synced-4bc773650f.png)

<figcaption>

Fonts are now synced & available in the builder

</figcaption>



Those fonts are now available inside the builder in any `font-family` dropdown:

![](imgs/bricks-adobe-fonts-in-bricks-7363f0e2de.png)

:::note
NOTE: Bricks recognizes when you use an Adobe font that is also available as a Google font. Bricks will load only the Adobe font to prevent loading this font from Google as well.
:::

## Variable fonts {#font-variation-settings}

Bricks also provides a new `font-variation-settings`. This CSS property allows you to control the four-letter axis names of a variable Adobe font. Such as the `wght`, `wdth`, `slnt`, and `ital`.

For more information about the specifics please visit [https://developer.mozilla.org/en-US/docs/Web/CSS/font-variation-settings](https://developer.mozilla.org/en-US/docs/Web/CSS/font-variation-settings)



![](imgs/bricks-adobe-fonts-variable-font-variation-settings-294be67f86.png)

<figcaption>

Variable Adobe font with a custom font-weight (axis: "wght") of 535

</figcaption>



You can view available variable Adobe fonts by selecting "Variable Fonts" under "Font technology on [https://fonts.adobe.com/fonts](https://fonts.adobe.com/fonts).

:::note
NOTE: This new `font-variation-settings` is also available for [custom fonts](/builder/styling/custom-fonts/). Google fonts currently only support the `wght` axis in Bricks. We are working on full variable font support with Google fonts as well.
:::

---


## Cascade layer

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/cascade-layer/*

The specificity of default Bricks styles has always been a balancing act. While we aim to keep these styles as non-intrusive as possible, providing a blank canvas for users to build upon, achieving this solely through selector specificity has its limitations. In some cases, it’s been challenging for users to override specific selectors, even when desired.

Bricks 1.12 introduces a promising solution to this longstanding issue through [CSS cascade layers](https://developer.mozilla.org/en-US/docs/Web/CSS/@layer), which as of December 2024 reach an impressive 96% browser support and "Widely available" Baseline.

Since Bricks 2.0, this feature has been **enabled by default**. You can disable it from **Bricks Settings > Performance > Cascade layer**, though it is not recommended.

This feature leverages cascade layers to define how Bricks' default styles interact with other styles on the page.

## How it works

This feature introduces **two cascade layers**:

- **`bricks.reset`** (a lower-priority layer): This sublayer is empty, providing a safety net for advanced users. Bricks itself does not apply any styles in this layer.
- **`bricks`**: This layer contains all of Bricks' default styles, making them easier to override using un-layered styles or styles in higher-priority user-defined layers.

Here’s an example to illustrate the problem and the solution:

### The problem: Selector specificity

In the default Bricks styles, a common pattern might look like this:

```php
[class*="brxe-"] {
    max-width: 100%;
}
```

If you tried to override this with a general element selector, such as:

```php
div {
    max-width: 400px;
}
```

…the override wouldn't work because the attribute selector `[class*="brxe-"]` has a higher specificity then the `div`.

One potential workaround could be wrapping Bricks' attribute selectors in `:where()` to reduce specificity:

```php
:where([class*="brxe-"]) {
    max-width: 100%;
}
```

However, this approach would require wrapping every selector, which is not only complex but also impractical at scale.

### The solution: Cascade layers

With cascade layers, we can simply define the default styles within a layer named `bricks`.

Styles outside this layer (un-layered) or in a higher-priority layer automatically precede the default Bricks styles.

Here's how the layers are structured:

```php
@layer bricks.reset;

@layer bricks {
    [class*="brxe-"] {
        max-width: 100%;
    }
    /* Other default Bricks styles */
}
```

Now, when you add your own styles outside the `bricks` layer, like this:

```php
div {
    max-width: 400px;
}
```

…they will precede the default Bricks styles because un-layered styles and higher-priority layers take precedence, regardless of the selector.

### The role of `bricks.reset` {#bricks-reset}

The `bricks.reset` sublayer ensures flexibility when overriding default Bricks styles.

Normally, styles in the `bricks` layer are easy to override, but if a default style uses `!important`, the cascade order flips, making it harder to override with un-layered styles or higher-priority layers. You can learn more about this behaviour [here](https://css-tricks.com/css-cascade-layers/#aa-establishing-a-layer-order).

The `bricks.reset` layer, being lower priority, provides a fallback for safely defining custom styles in these rare cases. While we aim to avoid using `!important` in our default styles unless absolutely required, this sublayer is there as a safeguard.

## Why this matters

By moving default Bricks styles into a dedicated cascade layer, we ensure:

1. **Easier overrides**: Un-layered or higher-priority layered styles can override the default Bricks styles without battling selector specificity.
2. **Simplified maintenance**: Instead of manually tweaking every selector's specificity, cascade layers offer a clean, scalable solution.

## Resources

- **Kevin Powell's YouTube video on cascade layers**: [A look at CSS Cascade Layers](https://www.youtube.com/watch?v=NDNRGW-_1EE)
- **In-depth guide on CSS cascade layers**: [CSS-Tricks: Cascade Layers Guide](https://css-tricks.com/css-cascade-layers/)

---


## Contextual Spacing

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/contextual-spacing/*

Bricks 2.0 introduces **Contextual spacing** to give you full control over vertical spacing (margin) between elements like headings, paragraphs, and lists within embedded content.

Contextual spacing automatically applies to elements within:

- Rich text element
- Post content element (source: WordPress)
- WooCommerce embedded content (excluding Checkout)

Out-of-the-box, Bricks tries to apply various top margins (`margin-block-start`) to elements like headings and paragraphs depending on their context.

If you want to override these defaults, you had to manually remove browser spacing, undo Bricks' built-in styles, and then define your own margins.

Contextual spacing simplifies this process. You can now reset easily reset those margins and visually define custom spacing rules under **[Theme Styles](/builder/styling/theme-styles/) →** Contextual Spacing.

Whether you are styling embedded content, working with dynamic layouts, or creating utility-based wrappers, this feature gives you consistent and flexible control over spacing.

## How to use contextual spacing

![](imgs/bricks-2.0-contextual-spacing-1-da009e338e.png)

You can enable Contextual spacing inside the builder under **Settings → Theme Styles → Contextual Spacing**.

**Remove default margins**: Lets you select the HTML tags from which you want to remove the default margins (i.e. Heading, Paragraph, Lists, etc.). This creates a clean starting point for spacing that fits your layout needs, without interference from inherited or default styles

:::note
**Contextual spacing:** Only applies margins when an element is preceded by another. This prevents extra spacing at the very top while maintaining consistent spacing between elements.
:::

## Settings overview

| Setting | Description |
| --- | --- |
| **Remove default margins** | Resets margins on the selected or manually entered HTML tags. |
| **Heading** | Applies top margin to `h1` through `h6` elements when they are preceded by another element. |
| **Paragraph** | Applies top margin to `p` elements when they are preceded by another element. |
| **Fallback spacing** | Applied to any element that does not match a heading, paragraph, or target elements, or when those targets have no spacing value defined. |
| **Additional target elements** | Define spacing rules for elements like `ul`, `blockquote`, or any custom selector. Lets you block margin (top, bottom) and inline padding (left, right). |
| **Additional selectors** | Extend contextual spacing to other parts of your layout by targeting wrapper selectors such as `.contextual-spacing`. |

## Additional target elements

Use the **Additional target elements** repeater to extend Contextual spacing to more than headings and paragraphs.

You can choose from predefined elements:

- Unordered list (ul)
- Ordered list (ol)
- List item (li)
- Figure (figure)
- Blockquote (blockquote)

Or enter your own custom selectors like `.my-class`, `code`, or `div`.

For each, you can set:

- Top and bottom margin (`margin-block`)
- Start and end padding (`padding-inline`)

This gives you spacing consistency across all types of content.

## Apply to more content areas

:::note
By default, Contextual spacing only targets Rich Text, Post Content, and WooCommerce content. But you can easily extend it by defining **Additional selectors** to apply Contextual spacing to any wrapper of your choice, such as `.contextual-spacing, .brxe-shortcode`.
:::

Add these utility classes to wrappers (i.e. Container, Div, Block elements) that hold a mix of content elements, and Bricks will apply your Contextual spacing settings to them.

### Why not apply spacing to all headings and paragraphs by default?

In most Bricks layouts, especially when using **Heading** and **Basic text** elements in combination with other elements, spacing is typically handled using the **gap** property between containers.

Because of that, applying a single spacing rule to all headings and paragraphs wouldn't make sense in every context.

Contextual spacing gives you the flexibility to apply spacing only where it's needed, using selectors and utility classes.

## Example use case 1: Embedded post content

You’re building a single post template using a **Post Content** element (source: WordPress).
Before enabling Contextual spacing, the post displays the default spacing added by Bricks.

When **Remove default margins** is enabled, Bricks removes both its own default spacing and the browser's default margins. You can then define your own spacing values using the Contextual spacing controls.

When you enable **Remove default margins**, then set spacing values. For example:

- **Heading**: `2rem`
- **Paragraph**: `1.25rem`
- **Fallback**: `1rem`

Bricks then applies spacing only between elements where needed. The first element inside the post has no margin above it, but elements that follow each other are spaced consistently.

![](imgs/bricks-contextual-spacing-enable-scaled-4e81c768e7.png)

![](imgs/bricks-contextual-spacing-example-values-scaled-f01950818c.png)

**Result:** Clean layout, no spacing at the top, full control over vertical rhythm.

![](imgs/bricks-contextual-spacing-use-case-1-1-1024x791-46658bbaf7.png)

![](imgs/bricks-contextual-spacing-use-case-1-2-1024x1017-f8617447e4.png)

![](imgs/bricks-contextual-spacing-use-case-1-3-1024x1012-011cac3d56.png)

![](imgs/bricks-contextual-spacing-use-case-1-4-926x1024-b446bc5d19.png)

## Example use case 2: Mixed content layout

You've created a custom template that includes a container with the following elements:

- A **Heading** element
- A **Basic text** element (with a `p` tag)
- An **Image** element (with a `figure` tag)
- A **Post Content** element (source: WordPress)

Because these use different systems for spacing, the result may feel inconsistent.

To unify the layout:

1. Under Theme Styles > Contextual Spacing > Enable **Remove default margins**
2. Set spacing values. For example:
  - Heading: `2rem`
  - Paragraph: `1.25rem`
  - Fallback: `1rem`
3. Add a global class like `.contextual-spacing` to the container
4. Enter `.contextual-spacing` under **Additional selectors**

![](imgs/bricks-contextual-spacing-utility-class-scaled-f5b292185a.png)

![](imgs/bricks-contextual-spacing-apply-to-utility-class-scaled-2be083b1fb.png)

**Result**: All elements within that wrapper now follow your contextual spacing rules.

---


## CSS Grid Layout

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/css-grid-layout/*

Available since Bricks 1.6.1 CSS grid allows you to create two-dimensional layouts (columns & rows). Whereas CSS flexbox, which Bricks uses as the default layout model, is designed for one-dimensional layouts (either column or row).

## Creating a grid layout

You can turn any layout element (section, container, block, div) into a CSS grid layout by setting the **Display** value to `grid`. This element is your **Grid Container**.

Every direct child element of your Grid container is a **Grid Item**, with additional settings for **Grid column** & **Grid row** to place an item it within the grid.

When editing a grid container in the builder a grid overlay becomes visible indicating the [grid cells](https://developer.mozilla.org/en-US/docs/Glossary/Grid_Cell). Clicking the little four-square element action icon lets to show/hide this overlay.



![](imgs/bricks-css-grid-3ecc9cdb17.jpg)

<figcaption>

Grid container (display: grid) with 6 grid items (direct children) and 20px gap

</figcaption>



As you can see in the screenshot above grid items are laid out in rows by default, covering the full width of the grid container. Which in itself doesn't unlock the true power of CSS grid, until you start ...

## Setting up column & row tracks (explicit grid)

Once we've created our grid container it is time to define our grid column & row [tracks](https://developer.mozilla.org/en-US/docs/Glossary/Grid_Tracks).

We can do this explicitly via the **Grid template columns** ([`grid-template-columns`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-columns)) & **Grid template rows** ([`grid-template-rows`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-rows)) settings of our grid container.

Let's explore a few examples together ...

`***grid-template-columns: 200px 1fr 2fr***`

Each value of the `grid-template-columns` property creates a column track.

The example above creates a three-column grid layout.

Column 1 has a fixed width of 200px. Column 2 is `1fr` a column 3 is `2fr` wide.

`**fr**` is a new flexible unit, called the fractional unit, which takes up x parts of the available space.

How is `fr` calculated?

Let's say our grid container has a width of 1100px (the container's default width).

We first need to subtract all non-fr values and gaps: So minus the fixed 200px width of column 1 the remaining available width is 900px.

We have 3 fractional units in total (1fr from column 2 plus 2fr from column 3) to allocate the remaining space towards.

Meaning 1fr equals 300px (= 900px / 3). So column 2 is 300px wide (= 1fr x 300px), and column 3 is 600px (= 2fr x 300px) wide.

`***grid-template-rows: 100px 300px***`

Each value of the `grid-template-row`s property creates a row track.

The example above explicitly defines the first two rows. Row 1 is 100px high, and row 2 is 300px high.

As we only explicitly defined the height for the first two rows, the height of any row after row 2 is determined by the height of its content by default. We can change this behaviour by creating an implicit grid ...

### Implicit grid

The grid container automatically generates additional (column & row) tracks for grid items that fall outside of your explicitly defined grid. This is called the implicit grid.

You can define the column & row sizes of this implicit grid via the **Grid auto columns** (`grid-auto-columns`) and **Grid auto rows** (`grid-auto-rows`) settings of your grid container.

### Min & max grid track sizes

The [`minmax`](https://developer.mozilla.org/en-US/docs/Web/CSS/minmax) CSS function lets you set a minimum and maximum track size.

It accepts two arguments. The first one is the minimum value, and the second one is the maximum value of your grid track.

`grid-template-columns: repeat(3, minmax(200px, 1fr))`

Creates an explicit 3-column grid where each grid item has a min. width of 200px, and a max. width of 1fr.

The problem is this sort of explicit grid is that is it not responsive. It overflows when the viewport is less than 600px wide (3 columns of min. 200px), and the number of columns doesn't adjust to different breakpoints out of the box.

### auto-fill & auto-fit keywords

We can use the `auto-fill` or `auto-fit` keywords to address those responsive issues. Allowing us to create responsive grid layouts without media queries.

So instead of setting an explicit 3 column grid, we use the `auto-fill` or `auto-fit` keyword like this:

`grid-template-columns: repeat(auto-fill, minmax(200px, 1fr))`

Which keyword to use depends on the desired behavior. `auto-fit` expands grid items to fill the available space. While `auto-fill` does not (it keeps the available space).

### Repeat track sizes

The [repeat](https://developer.mozilla.org/en-US/docs/Web/CSS/repeat) CSS function lets you define a repeating track size pattern in a compact format.

It accepts two arguments. The first one is the number of times the track should repeat and the second one is the definition of the tracks.

`grid-template-columns: repeat(3, 1fr)`
Creates an explicit 3-column grid.

`grid-template-rows: 100px repeat(2, 1fr) 200px`
Creates an explicit 4-row grid. Where row 1 is 100px high, row 2 & 3 are 1fr each, and row 4 is 200px high.

## Placing grid items (by line number)

[Grid lines](https://developer.mozilla.org/en-US/docs/Glossary/Grid_Lines) mark the start or end of a column or row track. The count starts at 1.

We can use those line numbers to place a grid item onto the grid.

The example below shows an explicit three column grid layout, whose grid items cover three rows.

![](imgs/bricks-css-grid-lines-0f66d0effb.jpg)

That means this grid has 4 column lines and 4 row lines.

When inspecting the grid layout of any website by clicking the little blue `grid` button next to the element node in the browser, in this case Chrome, shows you the grid lines as well:

![](imgs/bricks-css-grid-lines-browser-scaled-2a2237a9c3.jpg)

In our example above we positioned **Grid Item 2** via the Grid column ([`grid-column`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-column)) and Grid row ([`grid-row`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-row)) settings like this, so it takes up two columns and two rows:

![](imgs/bricks-css-grid-column-grid-row-993e62561f.jpg)

The **Grid column** & **Grid row** settings are available for all grid items (direct children of the grid container).

Syntax: The first value specifies the starting line number. Followed by a forward slash (`/`). Followed by the second value, which specifies the end line number.

In our example above we've set the Grid column to "2 / 4". Telling the grid we want Grid Item 2 to start at column line 2 and end at column line 4. The Grid row is set to "1 / 3", meaning Grid Item 2 starts at row line 1 and ends at row line 3.

We could have achieved the same layout by setting the grid column & Grid row setting to "`span 2`". `span` is a keyword that tells the grid layout how many columns or rows the item should span.

## Notes

Named grid areas ([`grid-template-areas`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-areas)) have to be defined via custom CSS.

Placing grid items inside a query loop are best done via `nth-child` custom CSS.

This article is meant to provide an overview of CSS grid, and not a complete reference. We recommend following the resources linked below to learn more about CSS grid.

### Additional resources

- [A Complete Guide to CSS Grid](https://css-tricks.com/snippets/css/complete-guide-grid/) (by CSS tricks)
- [learncssgrid.com](https://learncssgrid.com/) (comprehensive CSS grid overview)
- [cssgrid.io](https://cssgrid.io/) (free CSS grid course by Wes Bos)

---


## Custom Fonts

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/custom-fonts/*

Your website typography has a huge impact on how your site is perceived, and it'll pay off to spend some time to get this aspect right.

Bricks allows you to add any font you want. From web-safe fonts to Google fonts, and of course, uploading your own custom fonts in your WordPress dashboard under **Bricks > Custom Fonts**. The latter which we are going to have a more in-depth look at now.

:::note
**Bricks 2.0 introduces a brand-new "[Font  Manager](/builder/styling/font-manager/)" for uploading and managing your Custom Fonts right from within the builder. Download Google Fonts locally, etc.**
:::

## How To Create & Upload Custom Fonts

https://youtu.be/Zu2RZFl6eAE

To create a new custom font go to **Bricks > Custom Fonts** in your WordPress dashboard, and click **Add New**.

First, let's give your custom font a title. This title shows in the *font-family* dropdown control when editing the typography in the builder.

Now your can start uploading your font files for all the font variants (*font-weight* and *font-style*) you plan to use on your site:



![](imgs/doce-custom-fonts-edit-font-variants-1024x786-850c88e7d5.png)

<figcaption>

Editing your custom font and managing all its font files and variant.

</figcaption>



You can see in the example above that we've uploaded a .WOFF and .WOFF2 font file for the standard font-weight (400) and a "Normal" font style.

If we'd have font files for font-weight 700 (bold) and font-style "Italic" we'd click the "Add a font variant" button. Select the font-weight value "700" and the font-style "Italic", and then upload the correct font files for this variant.

Once you've created all relevant font variants and uploaded all font files accordingly, you can save your fonts. Your new custom font is now available in the builder.

You can also see a font preview when editing your font or on the "Custom Fonts" page.

:::note
If your custom fonts are not showing correctly, please check your [WordPress URL settings](/builder/setup/known-issues/#custom-fonts).
:::

## Supported Font Formats

The following font formats are enabled by default:

- **WOFF (Web Open Font Format)**: This is the recommend font format used by all modern browsers. Font data is compressed and therefore loads faster than the same font provided via TrueType or OpenType files. Full support for IE9+.
- **WOFF2 (Web Open Font Format 2.0)**: TrueType/OpenType font with even better compression than WOFF 1.0. No IE browser support.
- **TTF (TrueType Font)**: Uncompressed font data, but partial IE9+ support.

The recommended font format is WOFF, with a current [browser](https://caniuse.com/woff)[support of 98.26%](https://caniuse.com/woff), and full support for IE9+.

## How To Enable More Font Formats

If you need to support IE8 you can programatically enable the EOT font format (or any other font format) by adding the following code to your Bricks child theme:

```php
add_filter( 'bricks/custom_fonts/mime_types', function( $mime_types ) {
  // Enable EOT font format for <IE9 browser support
  array_unshift( $mime_types, ['eot' => 'font/eot'] );

  return $mime_types;
} );
```

Once you've created at least one custom font a "Custom Fonts" section with all your custom fonts will show underneath the "Standard Fonts" in any "font-family" control:

![](imgs/docs-custom-fonts-control-003fd90cf3.png)

#### Pro Tip: How To Become GDPR Compliant By Hosting Google Fonts Yourself {#google-fonts}

When using a Google Font on your website, you have to get consent from your website visitors before displaying the font.

You can avoid this whole issue by downloading all relevant font variants for the Google Fonts you want to use on your site, and then upload them as "Custom fonts" in Bricks.

:::note
The "[Google Webfonts Helper](https://gwfh.mranftl.com/fonts)" project is a great resource to directly download all `.eot`, `.woff`, `.woff2`, `.svg`, `.ttf` files of a Google font.
:::

Bricks 1.4 allows you to “Disable Google Fonts” altogether via the Bricks settings under “Performance”:



![](imgs/bricks-1.4-disable-google-fonts-setting-1024x944-5d9bd72ef5.png)

<figcaption>

Bricks > Settings > Performance: Disable Google Fonts

</figcaption>



### Free Fonts Resources

- [fontsquirrel.com](https://www.fontsquirrel.com)
- [reedesignresources.net/category/free-fonts](https://freedesignresources.net/category/free-fonts)
- [awwwards.com/awwwards/collections/free-fonts](https://www.awwwards.com/awwwards/collections/free-fonts)

---


## Fluid Typography

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/fluid-typography/*

Starting with Bricks 2.1, the **Fluid Typography Generator** lets you create pixel-perfect & responsive font sizes (through CSS variables using `clamp`) that scale smoothly between defined minimum and maximum values, ensuring consistent readability across all screen sizes and devices. Simplifying the process of managing font sizes while maintaining flexibility and precision in your design.

## Accessing fluid typography {#access}

To access the Fluid Typography Generator click the `Aa` icon in the header of the **Variable Manager**:

![](imgs/bricks-fluid-typo-open-icon-5d31bab5ee.png)

There's also a "Fluid Typography" control under `Theme Styles > Typography` for easy access ;)

## Fluid typography categories {#adding-category}

Bricks lets you create unlimited Fluid Typography Scales for your Headings, Text, etc. through categories.

So, **every Category is a Fluid Typography Scale**, that stores all its scale settings alongside it.

You can keep it simple and just create a `Headings` and `Text` category for those two scales as we did in the following screenshot:

![](imgs/bricks-fluid-typo-category-text-empty-53b4564aed.png)

## Fluid typography variables {#generating-variables}

Fluid typography variables can be generated with the Scale Generator on the right-hand side.

Whenever variables are generated, all existing variables within the selected category are deleted and replaced with the newly created variables. The number of variables is the same as in the previous set, but the names and values will be regenerated. So, any manual edits made to variable names or values are lost once the variables are regenerated.

## Scale controls {#controls-overview}

### Prefix {#control-prefix}

The prefix determines how variable names are structured. For instance, setting the prefix to `text-` results in variables being named `--text-m` or `--text-xl`, depending on the scale. It is recommended to use a prefix that is both unique and descriptive to maintain clarity and avoid conflicts.

### Scale type {#control-scale-type}

The scale type specifies the naming convention used for fluid typography variables. There are three available options:

1. **T-shirt:** Generates variable names based on standard t-shirt sizes, such as `2xs, xs, s, m, l, xl, 2xl`. An example output would be `--text-m`.
2. **Numeric:** Generates variable names using numbers, typically ranging from 1 through 6. An example output would be `--text-4`.
3. **Custom:** Allows complete manual control over the naming convention. For example, scale names such as `small, medium, large, title` could be entered, resulting in variable names such as `--text-medium`.

### Custom scale type {#control-custom-scale-type}

This control only shows when the scale type is set to **Custom**. It provides the ability to define custom scale names, offering flexibility in aligning the naming convention with project-specific requirements.

### Baseline step {#control-baseline-step}

The baseline step acts as the foundation of the scale. The baseline variable will directly reflect the minimum and maximum font sizes defined, and all other scale steps will be calculated relative to this baseline. Proper definition of the baseline ensures accurate scaling across all steps.

### Px to rem {#control-px-to-rem}

This value is automatically populated based on the root font-size setting defined in Theme Styles > Typography > HTML: font-size. For example, an HTML font-size of 100% corresponds to a value of 16, while an HTML font-size of 62.5% corresponds to a value of 10. Leaving this field empty results in units being expressed in `px` rather than `rem`. To ensure scalability and accessibility, it is strongly recommended to maintain this setting.

### Base font size (px) {#control-base-font-size}

The base font size establishes the minimum and maximum values for the baseline step. Font sizes for all other steps will be calculated automatically based on the defined **Type Scale Ratio**.

### Screen width (px) {#control-screen-width}

Screen width determines the breakpoints at which the baseline font size reaches its minimum or maximum values. Outside these breakpoints, font sizes will remain constant.

### Type scale ratio {#control-type-scale-ratio}

This control defines the ratio by which font sizes increase or decrease in relation to the next adjacent variable. For example, with a baseline of 16px and a scale ratio of 1.5, the next step above the baseline will be calculated as 24px. Ratios are applied upward and downward, generating consistent scaling in both directions.

For advanced use cases, it is possible to enter a custom ratio. A new control for defining custom values becomes available only when the **Custom** option is selected. This allows precise manual control over how each step in the scale is calculated.

## Editing variables {#editing-variables}

Once generated, variables are displayed in the central panel. These variables may be managed in several ways.

![](imgs/bricks-fluid-typo-category-text-generated-a8a4fd47e5.png)

### Adding variables {#add-variables}

Two buttons (arrow up & arrow down) are located at the top of the variables panel: one to create a smaller variable and one to create a larger variable.

Selecting either option inserts a new variable at the appropriate position, either above or below the baseline. Both the variable name and value are automatically generated.

In cases where the **Custom** scale type is used, variable names may need to be updated manually, or additional values can be added directly in the custom scale definition.

**Note:** If you used the **Custom** scale type, then you will need to update the variable name, or even better, add new value to the **Custom** scale directly.

### Deleting variables {#delete-and-export}

Any variable, including the baseline, can be deleted. Removing variables does not interfere with calculations, even when additional variables are generated afterwards.

### Editing variables {#manually-editing}

Variable names and values can be directly edited by selecting them in the center column. Manual edits apply only to the selected variable and do not affect any calculations. This allows fine-tuned adjustments while maintaining overall scale consistency.

## Typography preview {#typography-preview}

A preview of the fluid typography can be activated by selecting the `eye` icon in the Scale Generator. Which opens the preview window on the left side of the popup, while hiding the categories to maximise space.

![](imgs/bricks-fluid-typo-preview-136b1ec3a5.png)

Within the preview window, several actions are available for managing and testing the generated variables:

- **Add variables:** New variables can be inserted above or below the existing ones, using the same process as described earlier.
- **Remove variables:** Each variable includes a trash icon, which can be used to delete it.
- **Customisable preview text:** The input field at the top of the panel allows the preview text to be customized.
- **Identify baseline step:** The highlighted variable (yellow border) represents the baseline step in the scale.

---


## Font Manager

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/font-manager/*

Bricks 2.0 introduces the new **Font Manager**, a centralized interface for adding, organizing, and managing all your site's fonts directly inside the builder.

![](imgs/bricks-font-manager-scaled-bd5cae96c8.png)

## Accessing the Font Manager

You can open the Font Manager by going to **Settings > Font Manager** in the builder toolbar, or by clicking the **gear icon** next to any font-family control.

This opens a popup where you can manage all available fonts (Google fonts, Adobe fonts, Standard fonts, and Custom fonts).

## Core functionalities

### Add and manage custom fonts

Create and edit custom font families in just a few steps.

- **Add variant manually**: Click the **Add** button to upload a single font file. Set the font's **weight** and **style** individually.
- **Import multiple variants**: Click **Import** to drag and drop or select multiple font files. Bricks will automatically upload and organize them by weight and style.

![](imgs/bricks-font-manager-add-993x1024-58e5077ebe.png)

![](imgs/bricks-font-manager-import-988x1024-29c020183f.png)

You can rename, edit, or delete any custom font family. Fonts moved to the **Trash** are not deleted immediately and can be restored.

### Use Google Fonts locally

Browse the full Google Fonts library and download any font with a single click. Fonts are stored locally and loaded from your server, helping you stay GDPR-compliant by avoiding external requests.

### Favorite fonts

Mark individual fonts as **favorites** for faster access as they are added to the very top of the font-family options by default.

Under **Bricks > Settings > Builder > Font family: Options** you can choose to "Show all fonts", which lists any favorite fonts first (= default), or "Show favorites only", which limits the font family selection to the favoured fonts.

---


## Global class import manager

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/global-class-import-manager/*

The global class import manager addresses a key challenge in managing imported classes. Previously, conflicting classes were always automatically discarded, and users had no way to prepare or organize classes before importing them.

This feature provides a clear and structured way to handle imported classes, giving users the ability to resolve conflicts, categorize classes, and maintain a clean workflow. To further streamline the process, we’ve included a setting that lets users decide when they’d like to be prompted, ensuring the feature suits their workflow.

![](imgs/bricks-class-import-manager-294c6a62c0.png)

## When does this show up?

The global class import manager opens whenever global classes are imported into the builder. This includes importing a global classes JSON file, pasting elements, or importing a template. Depending on your settings, it can open for specific situations, such as new classes, conflicting classes, or both.

## Types of classes in the import manager

The import manager displays two types of classes:

- **New classes**: These are classes that do not exist in the current site. Users can choose to import and categorize these classes before they are added to the site.
- **Conflicting classes**: These are classes that either share the same name or the same internal ID as an existing local class, but have different settings. Conflicting classes are highlighted in red, and users must resolve each conflict before completing the import. Conflicts can be resolved by:
  - **Overriding the local class**: Replace the existing class with the imported one.
  - **Discarding the conflicting class**: Skip importing the conflicting class.

![](imgs/bricks-class-import-manager-override-zoomed-fab5605b95.png)

![](imgs/bricks-class-import-manager-import-zoomed-350aecfc81.png)

## Configuring when the import manager opens

You can control when the global class import manager opens by navigating to **WordPress admin > Bricks Settings > Builder > Global class import manager**. The available options are:

- **Show for class conflicts (default)**: The manager opens only when conflicts are detected. New classes are imported automatically.
- **Show for new classes**: The manager opens for all new classes, allowing users to review and manage them, while conflicting classes are automatically discarded.
- **Show for new & conflicting classes**: The manager opens for both new and conflicting classes, providing full control over the import process.
- **Never**: The manager is disabled. New classes are imported automatically, and conflicting classes are automatically discarded.

---


## Global Class Manager

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/global-class-manager/*

Bricks' Global Class Manager is a powerful new feature for creating, editing, deleting, and categorizing CSS classes directly inside the builder. This tool simplifies managing global styles, allowing you to apply consistent designs across your entire project easily.

## Accessing the class manager

To access the Class Manager click the "Gear" icon in the top-left side o f the builder toolbar to open the "Style Manager". Then, clicking the "CSS 3" icon in the sidebar opens up the Class Manager.

![](imgs/bricks-2.2-style-manager-class-manager-scaled-3baba8f901.png)

The Class Manager can be disabled under `Bricks > Settings > General > Disable global class manager`.

## Core functionalities

### Class creation and management

In the Global Class Manager, you can seamlessly handle your CSS classes through a unified interface where they can:

- **Manage classes:** Create new CSS classes or update existing ones. Delete classes that are no longer needed.
- **Order & categorize: **You can categorize classes for better management and order classes or categories via drag-and-drop for preferred structuring.
- **Bulk actions:** When two or more classes are selected, the editor enables users to perform mass actions such as renaming, duplicating, locking, and unlocking classes. These actions include the ability to find and replace strings or add prefixes or suffixes to class names.

![](imgs/bricks-classes-manager-b6250c57a1.png)

### Search and sorting capabilities

In the header of the Global Class Manager, you can filter classes by:

- **Including or excluding specific strings.**
- **Sorting options:** Alphabetically sort classes for better organization.
- **Filtering based on usage and properties:** Filter options include "Used on this site", "Unused on this site", "Used on this page," "Unused on this page," "Has styles," "Has no styles," "Locked," and "Unlocked."

![](imgs/bricks-classes-manager-subheader-8128095cf9.png)

:::note
For more information on creating and applying global CSS classes, please refer to our dedicated [Global CSS Classes](/builder/styling/global-css-classes/) guide.
:::

### Exporting and importing classes

The Global Class Manager facilitates the exporting and importing of CSS classes, making it easier to maintain a consistent styling framework across various Bricks projects.

#### Exporting classes

Users have two options for exporting classes:

1. **Export all:** By clicking the "Export" button at the top of the manager, users can export all classes currently managed within the system as a JSON file.

![](imgs/bricks-classes-manager-export-all-1024x682-efaf2310c5.png)

2. **Export selected:** Users can also choose specific classes to export by selecting them and then clicking the "Export selected" icon within the classes column header. This allows for more granular control over which classes are included in the exported JSON file.

![](imgs/bricks-classes-manager-export-selected-1024x682-7ea0818798.png)

#### Importing classes

In the "Import" popup, users can drag and drop a JSON file containing exported classes, streamlining transferring classes between projects.

![](imgs/bricks-classes-manager-import-1024x682-0acb623c18.png)

![](imgs/bricks-classes-manager-import-file-6bdff8580f.png)

#### Managing imported classes

If you're importing global classes and need to handle **conflicts** or organize new classes before they are added to your project, check out the [Global Class Import Manager](/builder/styling/global-class-import-manager/). This feature, introduced in Bricks 1.12, provides a structured way to resolve conflicts and categorize imported classes, ensuring a smooth and controlled workflow.

---


## Global CSS Classes

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/global-css-classes/*

A CSS class is a collection of styles (CSS rules) that you can apply to any element anywhere on your site by assigning that CSS class to it.

Class-based styling is vital in web design and development in order to build scalable and maintainable websites.

Bricks allows you to visually create & manage your own CSS classes right in the builder and assign your classes to any element anywhere on your site with a few clicks.

https://youtu.be/JMCkE6dneTM

:::note
Styles applied to the element ID (which is what you do by default when editing an element) precede styles defined in a CSS class.
:::

## How to create a global class

![](imgs/adding-global-classes-bricks-a4022e5f9f.png)

1. Select any element by clicking on it in the canvas or via the structure panel at the right.
2. Click on the input that shows the element's ID under its name in the left panel.
3. Type a valid class name in the "Enter CSS class name ..." input and hit return press the Save (floppy) icon.
4. Now any styling applied visually via the builder controls are added to that class.

---


## Global Variables Manager

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/global-variables-manager/*

The Global Variables Manager is a powerful new feature that allows you to create, manage, and categorize all your CSS variables directly inside the builder.

This will simplify managing your CSS variables and allow you to apply consistent designs across your projects with ease.

## Accessing the Variable Manager

To access the Variable Manager click the "Gear" icon in the top-left side o f the builder toolbar to open the "Style Manager". Then, clicking the "Curly Brackets" icon in the sidebar opens up the Variable Manager.

![](imgs/bricks-2.2-style-manager-variable-manager-scaled-9b1c2a9cc2.png)

You can disabled the Variable manager under `Bricks > Settings > General > Disable global variable manager`.

## Core functionalities

### Variable creation and management

In the Global Variables Manager, users can seamlessly handle CSS variables through a unified interface where they can:

- **Manage variables:** Create new CSS variables or update existing ones with customizable names and values. Delete variables that are no longer needed.
- **Bulk actions:** When two or more variables are selected, the editor enables you to perform bulk actions such as renaming and duplicating. These actions include the ability to find and replace strings or add prefixes or suffixes to variable names. However, it’s important to note that renaming a CSS variable does not automatically update its instances throughout your site.
- **Variable categorization:** You can categorize variables for better management and order variables or categories via drag-and-drop for preferred structuring.

![](imgs/bricks-css-variables-manager-1f50abd7d9.png)

### Search and sorting capabilities

In the header of the Global Variables Manager, users can filter variables by:

- **Including or excluding specific strings**.
- **Sorting options:** Alphabetically sort variables for better organization.
- **Filtering based on usage:** Easily view variables that are "Used on this page" or "Unused on this page".

![](imgs/bricks-css-variables-manager-subheader-b32b9b330a.png)

### Variable picker integration in the builder

A new "Variable Picker" is now available when editing element settings within the builder.

This picker lists all the variables created via the Global Variables Manager, organized by category.

Clicking on a variable from the picker inserts it directly into the selected setting. Simplifying using consistent styles across different elements and classes of your website.

![](imgs/bricks-variables-picker-611d7981a2.png)

### Exporting and importing variables

The Global Variables Manager facilitates the exporting and importing of CSS variables, making it easier to maintain a consistent styling framework across various Bricks projects.

#### Exporting variables

Users have two options for exporting variables:

1. **Export all:** By clicking the "Export" button at the top of the manager, users can export all variables currently managed within the system as a JSON file.

![](imgs/bricks-css-variables-manager-export-all-3c7fb5e020.png)

2. **Export selected:** Users can also choose specific variables to export by selecting them and then clicking the "Export selected" icon within the variables column header. This allows for more granular control over which variables are included in the exported JSON file.

![](imgs/bricks-css-variables-manager-export-selected-1024x682-de26e5ce0c.png)

#### Importing variables

Importing variables into Bricks is flexible and user-friendly, accommodating different scenarios:

**Importing via JSON file:** In the "Import" popup, users can drag and drop a JSON file containing exported variables, streamlining the process of transferring settings between projects.

![](imgs/bricks-css-variables-manager-import-1024x682-9783ae9ad6.png)

![](imgs/bricks-css-variables-manager-import-file-1024x682-8dc369a9ee.png)

**Manual text entry:** Additionally, you can manually enter variables into a textarea. This is particularly useful for quickly importing variables from child themes, custom plugins, or code snippets. The expected format for manual entry is a semicolon-separated list of CSS variable definitions, such as:

```php
--bricks-color-primary: #ffd64f;
--bricks-color-secondary: #fc5778;
--bricks-text-dark: #212121;
```

![](imgs/bricks-css-variables-manager-import-textarea-1024x682-a8f316f208.png)

**Importing from remote templates:** When inserting a remote template, users can choose whether to include the CSS variables from the remote site. This option ensures that the imported template retains its intended design consistency or it can be adapted to fit the local styling guidelines.

---


## Gradients & Overlays

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/gradients-overlays/*

Spice up your site's design by adding background, overlay, and text gradients to any element. When editing an element, the Gradients & Overlays control group is under the Style tab.

https://youtu.be/fHjio0iWkk8

## Available controls:

- **Apply to**: Select the type of content you want to add a gradient to (text, background, overlay).
- **CSS selector**: To target a specific HTML within an element.
- **Colors**: Add at least two colors to see a gradient. When you apply the gradient to an overlay make sure to reduce the color transparency in order to see through it.
- **Type**: Choose the gradient type—linear, radial, or conic.
- **Repeat (since 1.9.4)**: Allows the gradient to repeat across the element. Define 'stops' to control the transition points of each color, using units like percentages or pixels.

### Linear gradient controls:

- **Angle in °**: Set a specific angle for your linear gradient between 0 to 360°.

### Radial gradient controls:

- **Shape**: Choose between 'circle' or 'ellipse'.
- **Size**: Select from 'closest-side', 'farthest-side', 'closest-corner', 'farthest-corner'. For details on these settings, see the [Mozilla Documentation](https://developer.mozilla.org/en-US/docs/Web/CSS/gradient/radial-gradient#size).
- **Position**: Define the central point of the gradient.

### Conic gradient controls:

- **Starting angle in °**: Specify the starting angle of the gradient between 0 to 360°.
- **Position**: Set the gradient's center.

---


## Hover Styles

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/hover-styles/*

:::note
The "Hover Styles" button as outlined below is now outdated. It has been replaced by a fully customizable pseudo-class & pseudo-element menu in Bricks 1.3.5: [Styling Element States & Parts](/builder/styling/pseudo-classes/)
:::

Bring your site to life and boost visitor engagement by styling the hover state of any block.

Activate the **Hover Styles **mode by clicking the "cursor" icon in the builder toolbar. The icon should now be highlighted, indicating that you are editing not the default state, but the mouseover/hover styles.

You can now start editing any style of any block that you'd like to add hover effects for.

Once done, leave the hover styles mode by clicking the "cursor" icon in the builder toolbar again. Then switch to Preview Mode (CMD/CTRL + P) to see your changes in action by hovering over the block(s) you just styled.

https://youtu.be/nWEz6N4JGpQ

---


## Understanding The Layout

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/layout/*

Bricks has four layout elements (since 1.5) to group & lay out your content in a fast, predictable, and streamlined approach:

- **Section**: Use to structure/divide your page (think: one topic per section)
- **Container**: Contain elements at 1100px width (centered)
- **Block**: Flexbox with 100% width (e.g. column)
- **Div**: Plain, unstyled div (grows according to inner elements)



![](imgs/bricks-layout-elements-1024x626-a573a37fa1.png)

<figcaption>

Two-column layout inside a section

</figcaption>



If you are new to web design, we recommend using the Section, Container, and Block element. As they come with presets that work well out-of-the-box without having to configure commonly used settings for every layout element.

![](imgs/Bricks-1.5-Layout-Elements-5acd06e934.png)

**The Section, Container, & Block element are just Divs with some presets**. They all use the [flexbox](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox) layout model. So you can easily direct, align, and space out elements inside of them.

**The Div element is the most basic element to group & lay out your content.** In Bricks the Div is plain (no predefined styles). So you can style it any way you want.

You can customize the defaults of any layout element in your [Theme Styles](/builder/styling/theme-styles/).

Quick overview of the main properties of each layout element:

| **Element ** | ** Tag** | **Display** | **Width** | **Where To Use** |
| --- | --- | --- | --- | --- |
| Section | `section` | flex | 100% | Root level |
| Container | `div` | flex | 1100px | Inside Section |
| Block | `div` | flex | 100% | Inside Section or Container |
| Div | `div` | block | - | Anywhere |

## Section {#section}

Use sections as the outermost building block. To separate & space out individuals parts of your page.

A section takes up 100% of the available width. It adjusts in height according to its content. Sections are stacked on top of one another.

When adding a new Section, a "Container" element is automatically added inside the section.

You can remove this Container if you don't need to "contain" any other elements inside of it. As we did in the following hero section example:



![](imgs/bricks-hero-section-1024x576-91f27ca559.jpg)

<figcaption>

Example: Hero Section (width: 100vh)

</figcaption>



You can overwrite the section defaults under Settings → Theme Styles → Element - Section.

To space out your sections, you can set the `margin` or `padding` to your liking. You can also change the default `display` and `height` values.

*Learn more: [Section element](/builder/elements/layout/section/)*

## Container {#container}

A Container is automatically centered, and has a default width of 1100px. Which you can customize under Settings → Theme Styles → Element - Container.

Place your Container inside a Section. And Block / Div elements inside your Container for a multi-column or multi-row layout.

The following screenshot shows a Container (with 60px `padding`) inside a Section (with `background-image`):

![](imgs/bricks-container-inside-section-1024x576-bdd27ca559.jpg)

*Learn more: [Container element](/builder/elements/layout/container/)*

## Block {#block}

The Block element provides the same controls as the Container (flexbox, query loop, etc.). The difference is that the Block uses a default width of 100% instead of a predefined 1100px width like the Container.

Use the Block element to create equal column/row layouts inside a Section or Container.

*Learn more: *[Block element](/builder/elements/layout/block/)

### How To Create Multi-Column Layouts {#columns}

To create a three-column layout inside a Container:

1. Select the Container
2. Change "Direction" to "Horizontal"
3. Click the little "+" icon on the canvas 3x to insert 3 Block elements.

The result should look like this:



![](imgs/bricks-blocks-inside-container-1024x459-b66d9343bc.jpg)

<figcaption>

Section > Container > 3 Blocks: 3-column-layout

</figcaption>



The fastest way to create a multi-column layout is to select the Container, click the little "column" layout icon on the canvas, and select the pre-defined column layout of your choice:



![](imgs/bricks-insert-layout-tool-1024x293-d5db213b50.jpg)

<figcaption>

"Insert Layout" Tool

</figcaption>



[By default](#default), the inserted layout consists of "Block" elements. The "Column" label is just that: a label. It's still a Block element. Visible by the icon in the structure panel. You can also see the element name when you hover over the element icon in the structure panel:

![](imgs/bricks-3-column-block-layout-1024x256-9013690220.jpg)

## Div {#div}

The Div element is the most generic element to group and lay out your content.

In contrast to the other layout elements, **the Div element in Bricks is completely unstyled**. Giving you 100% freedom regarding its markup & styling.

When used inside one of the other layout elements the Div grows and shrinks according to the elements it contains.

*Learn more: *[Div element](/builder/elements/layout/div/)

## How to Insert, Wrap, and Convert layout elements {#actions}

You can right-click on any layout element to reveal the context menu. From there you can "Insert", "Wrap", and "Convert" layout elements with one click.

The screenshot below shows how to convert a root Container to a Section by right-clicking on the "Hero" Container in the structure panel, and then selecting the "Section" icon under "Convert":



![](imgs/bricks-1.5-context-menu-convert-to-section-1024x550-a2d30e6add.jpg)

<figcaption>

Context menu: Convert "Container" into a "Section"

</figcaption>



When editing a layout element, you can insert any other layout element by hovering over the "+" icon on the canvas, which provides you with "Container", "Block", "Div" options.

Hold down "CMD / CRTL" to insert an element after the active element.

![](imgs/bricks-1.5-element-action-insert-2084a1b2d6.png)

### Element actions: Setting the default element {#default}

Under "Bricks → Settings → Builder → Element actions" you can change the layout element that's being used by default for "Insert", "Wrap", and the "Layout" tool:

![](imgs/bricks-1.5-setting-element-actions-1024x363-22b289a284.png)

### Optional: Converting your Container-based layout

To convert your existing "Container"-based site to use the new "Section" & "Block" elements, you can run the Converter with the **'Convert "Container" to new "Section" & "Block" elements'** option enabled:



![](imgs/bricks-1.5-convert-container-to-section-block-1024x192-94e5cadc38.png)

<figcaption>

Located under: Bricks > Settings > General > Converter

</figcaption>



## Masonry layout {#masonry}

Starting at Bricks 1.11.1 you can enable the "Masonry layout" for all layout elements under `Style > Layout > Masonry`. Learn more at [/builder/styling/masonry-layout/](/builder/styling/masonry-layout/)

---


## Masonry Layout

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/masonry-layout/*

Starting with version 1.11.1, you can easily apply a masonry layout to any layout element in Bricks.

The new Masonry Layout controls are available under `Style > Layout > Masonry` for all layout elements (Section, Container, Block, Div).

![](imgs/masonry-layout-controls-3173503428.png)

Bricks utilizes the [IsotopeJS](https://isotope.metafizzy.co/) library to create the masonry layout, which it also uses for the **Image Gallery** and **Posts** elements, for optimal performance.

## How It Works {#how-it-works}

When the Masonry layout is enabled, all direct child elements become masonry items.

You can customize the number of columns and adjust spacing for different breakpoints to achieve a responsive layout.

:::note
**Tip:** Ensure that no conflicting CSS styles are applied to the masonry-enabled element, as they may interfere with the masonry layout. It’s best to clear all custom styles for the element to allow the masonry effect to work smoothly.
:::

You can also use the masonry layout to wrap items in a **query loop** for a dynamic grid effect. This is particularly useful for layouts with posts, products, or any repeated content, enabling you to display query items in a visually engaging, staggered grid format.

![](imgs/masonry-layout-example-query-loop-1c3b987eda.png)

## Use Bricks Interaction Animation

If you want to apply custom animations using the **Interactions** panel (e.g., setting an **Entry Viewport Trigger** and **Start Animation** for masonry children), you can disable the default masonry animations by setting **Transition: Duration** to `0`.

This prevents any overlap between the default masonry transitions and your custom animations, ensuring a smoother effect.

![](imgs/masonry-layout-disable-animation-75601c99dd.png)

## Troubleshooting {#troubleshoot}

### Custom CSS Conflicts

If the masonry columns don’t align with your settings, inspect the CSS styles applied to the child elements. Styles such as **width**, **flex-basis** or **align-self** within flex layouts can override the masonry column settings. Adjust or remove these styles to ensure the masonry layout functions as expected.

### Dynamic Content Updates via Custom JavaScript/AJAX

If you have custom code/plugins that adds masonry child nodes via JavaScript or AJAX, it’s likely that the masonry layout may not update correctly. To fix this, you can manually refresh the masonry instance by running the following JavaScript.

```php
bricksUtils.updateIsotopeInstance('BRICKS_ID');

```

Replace `'BRICKS_ID'` with the specific ID of your masonry element. This function will reinitialize the masonry layout to accommodate the new nodes, ensuring the layout remains intact.

![](imgs/masonry-copy-bricks-id-2-d7850891fd.png)

---


## Styling Element States & Parts

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/pseudo-classes/*

Bricks lets you apply different styles to an element depending on its state (such as on mouse `:hover` or a `:visited` link) via pseudo-classes.

You can also apply different styles to specific parts of an element via pseudo-elements. Such as the `::first-letter` or the `::first-line`.

The video below shows how to work with pseudo-classes & pseudo-elements in Bricks (1.3.5+) and how you can add pseudo keywords yourself to Bricks:



https://youtu.be/0a9teO2moEE

<figcaption>

How to work with pseudo-classes & pseudo-elements in Bricks.

</figcaption>



:::note
Pseudo-classes & pseudo-elements are available when editing an element, theme styles, and page settings.
:::

## How to edit a specific element state or part of an element

Click the "cursor" icon in the builder toolbar to toggle the pseudo-class menu:

![](imgs/toggle-pseudo-classes-1-233e23518e.png)

Click the text input to reveal all available pseudo-classes & pseudo-elements:

![](imgs/default-pseudo-classes-5ec9e8b685.png)

## How to create your own pseudo-classes & pseudo-elements

By default, Bricks shows `:hover`, `:active` and `:focus` pseudo-classes, but you can add other pseudo-classes or pseudo-elements yourself.

Simply type out the pseudo-class or pseudo-element you want to create (such as `:visited`) and press enter or click the little save icon:

![](imgs/adding-other-pseudo-classes-edfdf8ed7a.png)

## Edit styles for element states or parts

Click the "cursor" icon in the builder toolbar to open the pseudo-class menu. Another click inside the text input reveals all available pseudo-classes & -elements. Select the one you want to edit.

![](imgs/edit-styles-507453b5e7.png)

The "active" pseudo keyword will now show highlighted in the right corner. The toolbar "cursor" will appear highlighted as well, indicating you're now editing the styles for a pseudo-class or pseudo-element:

![](imgs/edit-states-styles-f030512fea.png)

At this point, changing the styles controls will only affect the active pseudo-class or pseudo-element. When you finish editing click the "x" icon inside the input to clear the state selection.

After that, you'll notice the input will show a little indicator of how many pseudo-classes or pseudo-elements are configured to this element or theme style:

![](imgs/pseudo-classes-assigned-5f74219d99.png)

To clear the styles associated with a pseudo-class or a pseudo-element, open the dropdown list where you'll notice a little dot indicator for the states that have styles associated with them. To clear the styles of a specific state, click the dot indicator:

![](imgs/clear-styles-pseudo-classes-eaaf3892c7.png)

## Deleting pseudo keywords

You can delete custom-added pseudo-classes or pseudo-elements (except the ones Bricks adds by default).

To do so, open the pseudo-class menu, reveal the dropdown, hover with your mouse over the pseudo keyword you want to delete. Then click the "bin" icon.

![](imgs/delete-pseudo-class-5c29a39b3b.png)

:::note
Please note, deleting a pseudo-class or a pseudo-element **will delete it globally**. It may affect other elements or theme styles where you used that state or part.
:::

## Example 1: Style a child class when a parent is hovered

Let's say there's a Div having a Heading element and that the heading has a class called `text--blue` with blue color text. Now you want to change the heading text to a different color when the Div is hovered.

For this:

1. Set a padding of say 40px all around for the Div element so the end result can be seen.
2. Select the Div.
3. Click the "States (pseudo-classes)" icon.
4. Click in the input field.
5. Type `:hover .text--blue` and hit return or click the Save (floppy) icon.
6. With the Div element still as the current element that is selected, go to STYLE → TYPOGRAPHY, click the Color control's circle and set your desired color.

Save and check the frontend. Hovering the Div should change the heading color.

Resources (list of available pseudo keywords):

[https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-classes](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-classes)

[https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-elements](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-elements)

---


## Scroll Snap

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/scroll-snap/*

With the introduction of scroll snapping in Bricks 1.9.3, enhancing your web pages with sophisticated scrolling effects has never been easier.

In our latest video, we provide a step-by-step guide on using scroll snap in Bricks, including how to set it up on a page and fine-tune it for individual elements.

https://www.youtube.com/watch?v=LoKCda8uDNw

For an in-depth look at the CSS properties behind this feature, such as `scroll-snap-align`, `scroll-snap-type`, and more, please visit [https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_scroll_snap](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_scroll_snap)

---


## Shape Dividers

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/shape-dividers/*

Give your design an edge by adding an unlimited number of shape dividers such as tilts, drops, grids, clouds, strokes, triangles, waves, etc. to any block:

https://youtu.be/rXhgQ5fsKDc

---


## Theme Styles

*來源網址：https://academy-preview.bricksbuilder.io/builder/styling/theme-styles/*

Adjust the default styling of your site layout, elements, colors, links, typography, etc. throughout your site via Theme Styles for a consistent and easy-to-maintain design system for your entire site.

Access the Theme Styles by clicking the **Settings** (gear) icon in the builder toolbar. Then go to **Theme Styles**.

To create your own Theme Style, click the **Create** (plus) icon and provide a name.

Apply any styling changes you want in the control groups below (like setting your fonts under "Typography", etc.).

https://youtu.be/UgoMtcacMus

## Conditions {#conditions}

Open the **Conditions** control group to tell Bricks where on your site this theme style should be used.

To apply a theme style to your entire website open the **Conditions** control group, click **Add Condition**, and select **Entire Website**.

You can set as many theme style conditions as you want.

Let's say you want to apply a Theme Style to two specific landing pages and your home page. You simply add a condition, click on Individual, and select your two landing pages. Then you add another condition and select **Front page**.

These are the available control groups:

- CONDITIONS
- GENERAL
- COLORS
- CONTENT
- LINKS
- TYPOGRAPHY
- ELEMENT - SECTION
- ELEMENT - CONTAINER
- ELEMENT - BLOCK
- ELEMENT - DIV
- ELEMENT - ACCORDION
- ELEMENT - ALERT
- ELEMENT - BUTTON
- ELEMENT - CAROUSEL
- ELEMENT - CODE
- ELEMENT - COUNTER
- ELEMENT - DIVIDER
- ELEMENT - FORM
- ELEMENT - HEADING
- ELEMENT - ICON BOX
- ELEMENT - IMAGE
- ELEMENT - IMAGE GALLERY
- ELEMENT - LIST
- ELEMENT - NAV MENU
- ELEMENT - POST CONTENT
- ELEMENT - META DATA
- ELEMENT - POST NAVIGATION
- ELEMENT - RELATED POSTS
- ELEMENT - TAXONOMY
- ELEMENT - POST TITLE
- ELEMENT - PRICING TABLES
- ELEMENT - PROGRESS BAR
- ELEMENT - SEARCH
- ELEMENT - SIDEBAR
- ELEMENT - SLIDER
- ELEMENT - ICON LIST
- ELEMENT - SVG
- ELEMENT - TABS
- ELEMENT - TEAM MEMBERS
- ELEMENT - TESTIMONIALS
- ELEMENT - TEXT
- ELEMENT - VIDEO
- ELEMENT - WORDPRESS
- WOOCOMMERCE - BUTTON

### Exclude condition {#exclude}

Since Bricks 1.3.6 you'll be able to set exclude conditions for any theme style. To exclude a specific condition you need to toggle the exclude control. Excluding a certain condition will let Bricks know that if the condition applies in a certain scenario, then that theme style won't be used.



![](imgs/theme-style-exclude-condition-62775d6c4f.png)

<figcaption>

Use this theme style everywhere except for the Privacy Policy page

</figcaption>



## Export {#export}

1. Inside the builder go to `Settings > Theme styles`
2. Select the theme style you wish to export
3. Click the **Edit** (pencil) icon
4. Click the **Export** (download) icon
5. Download the generated JSON file to your computer

## Import {#import}

1. Inside the builder go to `Settings > Theme styles`
2. Click the **Create** (plus) icon
3. Click the **Import** (upload) icon
4. Select the theme style JSON file from your computer, and upload it

If a theme style with the same name already exists in your installation, the import will fail. This is to prevent any theme styles with identical names.

## Style Hierarchy

Bricks applies styles based on specificity:

- Element settings override everything
- Page settings override theme styles
- Theme styles apply last unless overridden above

### Loading Method {#loading-method}

By default, Bricks loads only the **most specific** theme style on a page.

For example, if one theme style targets the entire website and another targets a specific page, only the one with the more specific condition (the specific page) is applied.

You can change this behavior under` WordPress Admin > Bricks > Settings > General > Theme Styles: Loading Method`

Options:

- **Most specific** (default): Loads only one theme style, the one with the most specific condition.
- **Load all matching theme styles**: Loads all theme styles whose conditions match the page.

Use "Load all matching theme styles" if you want to stack styles, like a global typography style combined with a post-type-specific layout.

---
