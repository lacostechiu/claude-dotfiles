# Bricks Academy — Developer Hooks (Actions & Filters)

> 來源：Bricks Builder Academy 官方文件 | 共 231 篇

---



## Hooks List

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/*

import HooksMasterList from "../../../../components/HooksMasterList.astro";

These are all documented Bricks hooks:

<HooksMasterList />

---


## Action: bricks/generate_css_file

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/action-bricks-generate_css_file/*

If your CSS loading method is set to **External files**, this hook will be triggered when a CSS file is generated in Bricks. Developers can use this hook to trigger other actions related to CSS file generation. It's useful for instructing a cache plugin to clear the cache when a CSS file is generated. (`@since 1.9.5`)



```php
/**
  * $type : 'global-color-palettes' | 'global-elements' | 'theme-styles' | 'global-custom-css' | 'post'
  * $file_name : The generated CSS file name
*/
add_action( 'bricks/generate_css_file', function( $type, $file_name ) {
  error_log( 'Generated CSS file: ' . $type . ' - ' . $file_name );
}, 10, 2 );
```



**Parameters:**

- `$type` (string): Possible strings `global-color-palettes` `global-elements` `theme-styles` `global-custom-css` `post`
- `$file_name` (string): The generated CSS file name

---


## Action: bricks/query/after_loop

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/action-bricks-query-after_loop/*

If you are creating a custom query loop or a custom plugin, you might want to perform some additional tasks like setting/resetting specific data after the loop runs. (`@since 1.7.2`)

```php
// Perform certain action after the loop of query element oklvcq
add_action( 'bricks/query/after_loop', function( $query, $args ) {
  if ( $query->element_id !== 'oklvcq' ) {
    return;
  }
  // $args is an array of the element settings
  // Perform your own logic here

}, 10, 2 );
```

---


## Action: bricks/query/before_loop

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/action-bricks-query-before_loop/*

If you are creating a custom query loop or a custom plugin, you might want to perform some additional tasks like setting/resetting specific data before the loop runs. (`@since 1.7.2`)

```php
// Perform certain action before the loop of query element oklvcq
add_action( 'bricks/query/before_loop', function( $query, $args ) {
  if ( $query->element_id !== 'oklvcq' ) {
    return;
  }
  // $args is an array of the element settings
  // Perform your own logic here

}, 10, 2 );
```

---


## Action: bricks/archive_product/after

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-archive_product-after/*

Runs after the Bricks content is rendered on a WooCommerce product archive page when a Bricks template is used. This action is specific to WooCommerce archives rendered by Bricks.

## Parameters

- `$bricks_data` (*array*): The Bricks data for the template being rendered.
- `$post_id` (*int*): The ID of the post/archive being rendered.

## Example usage

```php
add_action( 'bricks/archive_product/after', function( $bricks_data, $post_id ) {
    // Output custom content after the product archive
    echo '<div class="custom-archive-footer">End of product list</div>';
} );
```

---


## Action: bricks/archive_product/before

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-archive_product-before/*

Runs before the Bricks content is rendered on a WooCommerce product archive page when a Bricks template is used. This action is specific to WooCommerce archives rendered by Bricks.

## Parameters

- `$bricks_data` (_array_): The Bricks data for the template being rendered.
- `$post_id` (_int_): The ID of the post/archive being rendered.

## Example usage

```php
add_action( 'bricks/archive_product/before', function( $bricks_data, $post_id ) {
    // Output custom content before the product archive
    echo '<div class="custom-archive-header">Welcome to our shop</div>';
} );
```

---


## Action: bricks/dynamic_data/after_do_action

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-dynamic_data-after_do_action/*

Runs after the dynamic data `{do_action:my_hook}` tag is processed. This allows you to execute code after a specific `do_action` tag has been rendered.

## Parameters

- `$action` (*string*): The action name specified in the tag (e.g. `my_hook` in `{do_action:my_hook}`).
- `$filters` (*array*): Array of filters applied to the tag.
- `$context` (*string*): The context in which the tag is being rendered (e.g., 'text').
- `$post` (*WP_Post|null*): The current post object, or null.
- `$value` (*string*): The rendered output of the action (captured via output buffering).

## Example usage

```php
add_action( 'bricks/dynamic_data/after_do_action', function( $action, $filters, $context, $post, $value ) {
    if ( $action === 'my_custom_hook' ) {
        // Code to run after 'my_custom_hook' is processed via dynamic data
        error_log( 'Finished processing my_custom_hook' );
    }
}, 10, 5 );
```

---


## Action: bricks/dynamic_data/before_do_action

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-dynamic_data-before_do_action/*

Runs before the dynamic data `{do_action:my_hook}` tag is processed. This allows you to execute code before a specific `do_action` tag is rendered.

## Parameters

- `$action` (_string_): The action name specified in the tag (e.g. `my_hook` in `{do_action:my_hook}`).
- `$filters` (_array_): Array of filters applied to the tag.
- `$context` (_string_): The context in which the tag is being rendered (e.g., 'text').
- `$post` (_WP_Post|null_): The current post object, or null.

## Example usage

```php
add_action( 'bricks/dynamic_data/before_do_action', function( $action, $filters, $context, $post ) {
    if ( $action === 'my_custom_hook' ) {
        // Code to run before 'my_custom_hook' is processed via dynamic data
        error_log( 'Starting processing my_custom_hook' );
    }
}, 10, 4 );
```

---


## Action: bricks/dynamic_data/tags_registered

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-dynamic_data-tags_registered/*

Runs after all core dynamic data tags have been registered. This is the recommended hook for registering custom dynamic data providers or adding logic that depends on registered tags.

## Parameters

None.

## Example usage

```php
add_action( 'bricks/dynamic_data/tags_registered', function() {
    // Register custom dynamic data tags or providers here
    // Example: Bricks\Integrations\Dynamic_Data\Providers::register( 'my_custom_provider', $provider_instance );
} );
```

---


## Action: bricks/filter_element/before_set_data_source_from_custom_field

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-filter_element-before_set_data_source_from_custom_field/*

Runs before setting the data source for a filter element that uses a custom field. This hook allows you to modify the filter element instance before the custom field data is processed.

## Parameters

- `$filter_element` (*Bricks\Filter_Element*): The filter element instance.

## Example usage

```php
add_action( 'bricks/filter_element/before_set_data_source_from_custom_field', function( $filter_element ) {
    // You can access $filter_element properties here, for example:
    // $settings = $filter_element->settings;
    
    // Example: modify settings before processing
    // $filter_element->settings['customFieldKey'] = 'modified_key';
} );
```

---


## Action: bricks/form/custom_action

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-form-custom_action/*

Runs when a form with a "Custom" action is submitted. This allows you to execute custom PHP logic to handle the form submission.

## Parameters

- `$form` (*Bricks\Form*): The form instance.

## Example usage

```php
add_action( 'bricks/form/custom_action', function( $form ) {
    // Get form fields
    $fields = $form->get_fields();
    
    // Get form settings
    $settings = $form->get_settings();
    
    // Get submitted data
    $form_data = $fields['formId'] ?? []; // Or retrieve specific field values
    
    // Perform custom logic, e.g., send to external API
    $name = isset( $fields['form-field-name'] ) ? $fields['form-field-name'] : '';
    
    if ( $name === 'Specific Name' ) {
        // Do something
        $form->set_result( [
            'type' => 'success', // or 'danger', 'info', 'warning'
            'message' => esc_html__( 'Custom action executed successfully.', 'bricks' ),
        ] );
    }
} );
```

---


## Action: bricks/frontend/after_render_data

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-frontend-after_render_data/*

Runs after the `Bricks\Frontend::render_data` method has finished generating the HTML for a set of elements. This action is undocumented in the official docs but useful for re-adding plugin actions/filters that were removed in `bricks/frontend/before_render_data` or performing cleanup.

## Parameters

- `$elements` (_array_): The array of elements that were rendered.
- `$area` (_string_): The area being rendered (e.g., 'content', 'header', 'footer').

## Example usage

```php
add_action( 'bricks/frontend/after_render_data', function( $elements, $area ) {
    // Restore actions/filters removed in before_render_data
    // add_filter( 'the_content', 'my_plugin_content_filter' );

    // Example: Log render completion
    // error_log( "Finished rendering area: $area" );
} );
```

---


## Action: bricks/frontend/before_render_data

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-frontend-before_render_data/*

Runs before the `Bricks\Frontend::render_data` method starts generating the HTML for a set of elements. This action is undocumented in the official docs but useful for removing plugin actions/filters that might interfere with Bricks rendering.

## Parameters

- `$elements` (*array*): The array of elements to be rendered.
- `$area` (*string*): The area being rendered (e.g., 'content', 'header', 'footer').

## Example usage

```php
add_action( 'bricks/frontend/before_render_data', function( $elements, $area ) {
    // Remove actions/filters that interfere with Bricks rendering
    // remove_filter( 'the_content', 'my_plugin_content_filter' );
    
    // Example: Log render start
    // error_log( "Starting rendering area: $area" );
} );
```

---


## Action: bricks/query/query_api_response

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-query-query_api_response/*

Runs after a Query API request is performed. This action allows you to inspect or process the response from the API query.

## Parameters

- `$response` (*array|WP_Error*): The response from the API request.
- `$element_id` (*string*): The element ID associated with the query.

## Example usage

```php
add_action( 'bricks/query/query_api_response', function( $response, $element_id ) {
    if ( is_wp_error( $response ) ) {
        error_log( 'Query API Error for element ' . $element_id . ': ' . $response->get_error_message() );
        return;
    }
    
    // Process successful response
    // $data = $response;
    // Do something with $data
}, 10, 2 );
```

---


## Action: bricks/query_filters/index_post/before

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-query_filters-index_post-before/*

Runs before a post is indexed for Query Filters. This action is triggered during the indexing process for a specific post.

## Parameters

- `$post_id` (*int*): The ID of the post being indexed.

## Example usage

```php
add_action( 'bricks/query_filters/index_post/before', function( $post_id ) {
    // Perform actions before indexing a post, e.g., logging or checking conditions
    // error_log( "Starting indexing for post ID: $post_id" );
    
    // Maybe register custom dynamic data providers if needed for indexing
} );
```

---


## Action: bricks/query_filters/index_user/before

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-query_filters-index_user-before/*

Runs before a user is indexed for Query Filters. This action is triggered during the indexing process for a specific user.

## Parameters

- `$user_id` (*int*): The ID of the user being indexed.

## Example usage

```php
add_action( 'bricks/query_filters/index_user/before', function( $user_id ) {
    // Perform actions before indexing a user
    // error_log( "Starting indexing for user ID: $user_id" );
    
    // Maybe register custom dynamic data providers if needed for indexing
} );
```

---


## Action: bricks/render_popup_content/start

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-render_popup_content-start/*

Runs at the start of the AJAX popup content rendering process (`load_popup_content` endpoint). This action allows you to execute custom logic before the popup content is generated and returned.

## Parameters

- `$request_data` (*array*): The request data parameters (e.g., postId, popupId, etc.).

## Example usage

```php
add_action( 'bricks/render_popup_content/start', function( $request_data ) {
    // Access request data
    // $post_id = $request_data['postId'] ?? 0;
    
    // Example: Switch language for multilingual plugins (Polylang/WPML integration uses this)
    // if ( isset( $request_data['lang'] ) ) {
    //     // Switch language logic
    // }
} );
```

---


## Action: bricks/render_query_page/start

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-render_query_page-start/*

Runs at the start of the AJAX query page rendering process (`load_query_page` endpoint - used for infinite scroll/pagination). This action allows you to execute custom logic before the query page content is generated.

## Parameters

- `$request_data` (*array*): The request data parameters (e.g., queryElementId, postId, page, queryVars, etc.).

## Example usage

```php
add_action( 'bricks/render_query_page/start', function( $request_data ) {
    // Access request data
    // $page = $request_data['page'] ?? 1;
    
    // Example: Switch language for multilingual plugins
    // if ( isset( $request_data['lang'] ) ) {
    //     // Switch language logic
    // }
} );
```

---


## Action: bricks/render_query_result/start

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/actions/bricks-render_query_result-start/*

Runs at the start of the AJAX query result rendering process (`query_result` endpoint - used for filters, live search, etc.). This action allows you to execute custom logic before the query result content is generated.

## Parameters

- `$request_data` (*array*): The request data parameters (e.g., queryElementId, postId, filters, etc.).

## Example usage

```php
add_action( 'bricks/render_query_result/start', function( $request_data ) {
    // Access request data
    // $filters = $request_data['filters'] ?? [];
    
    // Example: Switch language for multilingual plugins
    // if ( isset( $request_data['lang'] ) ) {
    //     // Switch language logic
    // }
} );
```

---


## Filter: bricks/acf/filter_field_groups

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-acf-filter_field_groups/*

Filters the ACF field groups available in the Bricks dynamic data picker. This allows you to exclude specific field groups from appearing in the builder's dynamic data dropdown.

## Parameters

- `$groups` (*array*): Array of ACF field groups retrieved via `acf_get_field_groups()`.

## Example usage

```php
add_filter( 'bricks/acf/filter_field_groups', function( $groups ) {
    // Loop through groups and unset the one you want to hide
    foreach ( $groups as $key => $group ) {
        // Example: Hide field group with key 'group_60f1234567890'
        if ( $group['key'] === 'group_60f1234567890' ) {
            unset( $groups[ $key ] );
        }
    }

    return $groups;
} );
```

---


## Filter: bricks/acf/google_map/address_parts

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-acf-google_map-address_parts/*

Filters the parts of the address displayed when rendering an ACF Google Map field. You can use this to reorder or remove specific components of the address.

## Parameters

- `$address_parts` (*array*): Array of address part keys. Defaults: `[ 'street_name', 'street_number', 'city', 'state', 'post_code', 'country' ]`.
- `$value` (*array*): The raw value of the ACF Google Map field.
- `$field` (*array*): The ACF field settings.

## Example usage

```php
add_filter( 'bricks/acf/google_map/address_parts', function( $address_parts, $value, $field ) {
    // Example: Only show city and country, and change order
    return [ 'city', 'country' ];
}, 10, 3 );
```

---


## Filter: bricks/acf/google_map/show_as_address

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-acf-google_map-show_as_address/*

Determines whether the ACF Google Map field dynamic data should be rendered as a formatted address or as latitude/longitude coordinates.

## Parameters

- `$show_as_address` (*bool*): Whether to render as an address. Defaults to `true` if ACF version >= 5.6.8.
- `$value` (*array*): The raw value of the ACF Google Map field.
- `$field` (*array*): The ACF field settings.

## Example usage

```php
add_filter( 'bricks/acf/google_map/show_as_address', function( $show_as_address, $value, $field ) {
    // Force showing latitude and longitude instead of address
    return false;
}, 10, 3 );
```

---


## Filter: bricks/acf/google_map/text_output

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-acf-google_map-text_output/*

Filters the final HTML output of the ACF Google Map field dynamic data. This runs after the address parts or coordinates have been formatted.

## Parameters

- `$output` (*string*): The rendered HTML output string.
- `$value` (*array*): The raw value of the ACF Google Map field.
- `$field` (*array*): The ACF field settings.

## Example usage

```php
add_filter( 'bricks/acf/google_map/text_output', function( $output, $value, $field ) {
    // Example: Strip HTML tags to get plain text
    return wp_strip_all_tags( $output );
}, 10, 3 );
```

---


## Filter: bricks/acf/taxonomy/show_as_link

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-acf-taxonomy-show_as_link/*

Determines whether the ACF Taxonomy field dynamic data output should be rendered as links to the term archives.

## Parameters

- `$show_as_link` (*bool*): Whether to render as links. Defaults to `true`.
- `$value` (*mixed*): The raw value of the ACF Taxonomy field.
- `$field` (*array*): The ACF field settings.

## Example usage

```php
add_filter( 'bricks/acf/taxonomy/show_as_link', function( $show_as_link, $value, $field ) {
    // Disable links for taxonomy terms
    return false;
}, 10, 3 );
```

---


## Filter: bricks/active_templates

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-active_templates/*

Filters the array of active templates (header, footer, content, popup) that Bricks has determined should be rendered for the current page.

## Parameters

- `$active_templates` (*array*): Array of active template IDs, keyed by template type (e.g., `header`, `footer`, `content`, `popup`).
- `$post_id` (*int*): The current post ID being rendered.
- `$content_type` (*string*): The type of content being rendered (e.g., `content`, `archive`, `search`, `error`).

## Example usage

```php
add_filter( 'bricks/active_templates', function( $active_templates, $post_id, $content_type ) {
    // Example: Use a specific header template (ID: 1234) for single posts
    if ( is_single() ) {
        $active_templates['header'] = 1234;
    }

    return $active_templates;
}, 10, 3 );
```

---


## Filter: bricks/ajax/get_pages_args

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-ajax-get_pages_args/*

Filters the query arguments used when searching for pages or posts within the Bricks builder (e.g., in link controls or populate content settings).

## Parameters

- `$query_args` (*array*): Array of arguments passed to `get_posts()`.

## Example usage

```php
add_filter( 'bricks/ajax/get_pages_args', function( $query_args ) {
    // Example: Exclude specific post IDs from the search results
    $query_args['post__not_in'] = [ 12, 34, 56 ];

    return $query_args;
} );
```

---


## Filter: bricks/allowed_html_tags

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-allowed_html_tags/*

Filters the list of allowed HTML tags that can be used when selecting a "Custom" HTML tag in element settings. This ensures that custom tags are sanitized correctly.

## Parameters

- `$allowed_html_tags` (*array*): Array of allowed HTML tag names.

## Example usage

```php
add_filter( 'bricks/allowed_html_tags', function( $allowed_html_tags ) {
    // Add 'marquee' to the list of allowed tags
    $allowed_html_tags[] = 'marquee';

    return $allowed_html_tags;
} );
```

---


## Filter: bricks/api/get_templates_data

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-api-get_templates_data/*

Filters the data returned by the Bricks REST API endpoint `/get-templates-data/`. This endpoint is used to retrieve templates, authors, bundles, tags, and other assets for the template library.

## Parameters

- `$templates_data` (*array*): Array containing:
    - `templates` (*array*): List of template data.
    - `authors` (*array*): List of template authors.
    - `bundles` (*array*): List of template bundles.
    - `tags` (*array*): List of template tags.
    - `globalVariables` (*array*): Global variables.
    - `colorPalette` (*array*): Color palettes.
    - `timestamp` (*int*): Current timestamp.
    - `date` (*string*): Formatted date.
    - `get` (*array*): URL parameters from the request.

## Example usage

```php
add_filter( 'bricks/api/get_templates_data', function( $templates_data ) {
    // Example: Remove a specific template bundle by name
    if ( ! empty( $templates_data['bundles'] ) ) {
        foreach ( $templates_data['bundles'] as $key => $bundle ) {
            if ( $bundle === 'Deprecated Bundle' ) {
                unset( $templates_data['bundles'][ $key ] );
            }
        }
    }

    return $templates_data;
} );
```

---


## Filter: bricks/breadcrumbs/home_label

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-breadcrumbs-home_label/*

Filters the label text used for the "Home" link in the Breadcrumbs element.

## Parameters

- `$home_label` (*string*): The home label text (may include HTML if an icon is used).

## Example usage

```php
add_filter( 'bricks/breadcrumbs/home_label', function( $home_label ) {
    return 'Start';
} );
```

---


## Filter: bricks/breadcrumbs/items

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-breadcrumbs-items/*

Filters the array of breadcrumb items (HTML strings) before they are rendered in the Breadcrumbs element. This allows you to add, remove, or modify specific breadcrumb links.

## Parameters

- `$breadcrumb_items` (*array*): Array of HTML strings, where each string represents a breadcrumb item (e.g., a link or current page span).

## Example usage

```php
add_filter( 'bricks/breadcrumbs/items', function( $breadcrumb_items ) {
    // Example: Add a custom item after the Home link (assuming Home is the first item)
    $custom_item = '<a href="/custom-link/">Custom Link</a>';
    array_splice( $breadcrumb_items, 1, 0, $custom_item );

    return $breadcrumb_items;
} );
```

---


## Filter: bricks/breadcrumbs/separator

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-breadcrumbs-separator/*

Filters the separator HTML displayed between items in the Breadcrumbs element.

## Parameters

- `$separator` (*string*): The HTML string for the breadcrumb separator (e.g., a span containing text or an icon).

## Example usage

```php
add_filter( 'bricks/breadcrumbs/separator', function( $separator ) {
    // Change separator to a custom character
    return '<span class="bricks-breadcrumbs-separator"> &raquo; </span>';
} );
```

---


## Filter: bricks/builder/current_page_type

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-builder-current_page_type/*

Filters the detected current page type stored in `Database::$page_data['current_page_type']`. This value is used by Bricks to determine the context for dynamic data and other logic.

## Parameters

- `$page_type` (*string*): The detected page type (e.g., `post`, `archive`, `search`, `author`, `404`, `term`, `user`).

## Example usage

```php
add_filter( 'bricks/builder/current_page_type', function( $page_type ) {
    // Example: Treat a custom endpoint as an archive
    if ( get_query_var( 'my_custom_archive' ) ) {
        return 'archive';
    }

    return $page_type;
} );
```

---


## Filter: bricks/builder/data_post_id

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-builder-data_post_id/*

Filters the post ID used by Bricks to retrieve page data (header, content, footer). This allows you to programmatically change the source of the Bricks data for the current page request.

## Parameters

- `$post_id` (*int*): The current post ID.

## Example usage

```php
add_filter( 'bricks/builder/data_post_id', function( $post_id ) {
    // Example: Use a specific post ID for a custom route
    if ( get_query_var( 'my_custom_route' ) ) {
        return 123; // ID of the post/template to use
    }

    return $post_id;
} );
```

---


## Filter: bricks/builder/dynamic_wrapper

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-builder-dynamic_wrapper/*

Filters the dynamic wrappers available in the Bricks builder. Dynamic wrappers are used to inject content before or after specific hooks in the builder canvas (e.g., WooCommerce hooks).

## Parameters

- `$dynamic_wrapper` (*array*): Array of dynamic wrappers.

## Example usage

```php
add_filter( 'bricks/builder/dynamic_wrapper', function( $dynamic_wrapper ) {
    // Add a custom dynamic wrapper
    $dynamic_wrapper[] = [
        'name' => 'my_custom_wrapper',
        'title' => esc_html__( 'My Custom Wrapper', 'my-plugin' ),
        'hooks' => [
            'before' => 'my_custom_action_before',
            'after'  => 'my_custom_action_after',
        ],
    ];

    return $dynamic_wrapper;
} );
```

---


## Filter: bricks/builder/first_element_category

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-builder-first_element_category/*

Filters the default expanded element category in the Bricks builder panel. This allows you to prioritize specific element categories based on the post type or ID being edited.

## Parameters

- `$category` (*string|bool*): The category name to expand by default (e.g., `layout`, `basic`, `single`). Default is `false`.
- `$post_id` (*int*): The ID of the post being edited.
- `$post_type` (*string*): The post type of the post being edited.

## Example usage

```php
add_filter( 'bricks/builder/first_element_category', function( $category, $post_id, $post_type ) {
    // Example: Expand 'woocommerce' category for product templates
    if ( $post_type === 'product' ) {
        return 'woocommerce';
    }

    return $category;
}, 10, 3 );
```

---


## Filter: bricks/builder/post_title

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-builder-post_title/*

Filters the post title displayed in the Bricks builder interface (e.g., in search results, dropdowns, and lists).

## Parameters

- `$title` (*string*): The post title.
- `$post_id` (*int*): The ID of the post.

## Example usage

```php
add_filter( 'bricks/builder/post_title', function( $title, $post_id ) {
    // Example: Append the post ID to the title
    return $title . ' (ID: ' . $post_id . ')';
}, 10, 2 );
```

---


## Filter: bricks/builder/supported_post_types

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-builder-supported_post_types/*

Filters the list of post types that are enabled for editing with Bricks. This checks whether the builder should load for the current post type.

## Parameters

- `$supported_post_types` (*array*): Array of supported post type slugs (e.g., `['page', 'post', 'my_cpt']`).
- `$current_post_type` (*string*): The post type of the post being accessed.

## Example usage

```php
add_filter( 'bricks/builder/supported_post_types', function( $supported_post_types, $current_post_type ) {
    // Example: Always allow 'my_custom_post_type' to be edited with Bricks
    if ( $current_post_type === 'my_custom_post_type' && ! in_array( 'my_custom_post_type', $supported_post_types ) ) {
        $supported_post_types[] = 'my_custom_post_type';
    }

    return $supported_post_types;
}, 10, 2 );
```

---


## Filter: bricks/builder/term_name

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-builder-term_name/*

Filters the term name displayed in the Bricks builder interface (e.g., in taxonomy pickers).

## Parameters

- `$term_name` (*string*): The formatted term name (e.g., `Term Name (Taxonomy Label)`).
- `$term_id` (*int|string*): The ID of the term.
- `$taxonomy` (*string*): The slug of the taxonomy.

## Example usage

```php
add_filter( 'bricks/builder/term_name', function( $term_name, $term_id, $taxonomy ) {
    // Example: Add the term ID to the name
    return $term_name . ' [ID: ' . $term_id . ']';
}, 10, 3 );
```

---


## Filter: bricks/cmb2/checkbox_value

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-cmb2-checkbox_value/*

Filters the output value of a CMB2 checkbox field when rendered via Bricks dynamic data. By default, Bricks converts 'on' to "Yes" and other values to "No".

## Parameters

- `$value` (*string*): The processed value (e.g., "Yes" or "No").
- `$original_value` (*string*): The raw value from the database (e.g., 'on').
- `$field` (*array*): The CMB2 field settings array.
- `$post` (*WP_Post*): The current post object.

## Example usage

```php
add_filter( 'bricks/cmb2/checkbox_value', function( $value, $original_value, $field, $post ) {
    // Example: Return "True" or "False" instead of "Yes" or "No"
    return $original_value === 'on' ? 'True' : 'False';
}, 10, 4 );
```

---


## Filter: bricks/code/echo_everywhere

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-code-echo_everywhere/*

Determines whether the `{echo:}` dynamic data tag should be parsed recursively if it appears within the output of another dynamic data tag. By default, this is disabled for security and performance reasons.

## Parameters

- `$echo_everywhere` (*bool*): Whether to allow recursive parsing of `{echo:}` tags. Default is `false`.

## Example usage

```php
add_filter( 'bricks/code/echo_everywhere', function( $echo_everywhere ) {
    // Enable recursive parsing of {echo:} tags
    // WARNING: Use with caution as this may lead to infinite loops or security vulnerabilities
    return true;
} );
```

---


## Filter: bricks/combined_search/post_ids

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-combined_search-post_ids/*

Filters the list of post IDs returned by the combined search logic (used in AJAX search filters). This allows you to include or exclude posts from the search results after the initial search query has run.

## Parameters

- `$post_ids` (*array*): Array of found post IDs.
- `$search_fields` (*array*): Array of post fields being searched (e.g., `['title', 'content', 'excerpt']`).
- `$meta_fields` (*array*): Array of meta keys being searched.
- `$search_term` (*string*): The search term entered by the user.
- `$filter_id` (*string*): The ID of the filter element initiating the search.
- `$query_id` (*string*): The ID of the query loop being filtered.

## Example usage

```php
add_filter( 'bricks/combined_search/post_ids', function( $post_ids, $search_fields, $meta_fields, $search_term, $filter_id, $query_id ) {
    // Example: Always include a specific sticky post in search results
    $sticky_post_id = 123;
    if ( ! in_array( $sticky_post_id, $post_ids ) ) {
        $post_ids[] = $sticky_post_id;
    }

    return $post_ids;
}, 10, 6 );
```

---


## Filter: bricks/combined_search/term_ids

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-combined_search-term_ids/*

Filters the list of term IDs returned by the combined search logic (used in AJAX search filters targeting terms). This allows you to include or exclude terms from the search results after the initial search query has run.

## Parameters

- `$term_ids` (*array*): Array of found term IDs.
- `$term_fields` (*array*): Array of term fields being searched (e.g., `['name', 'slug']`).
- `$meta_fields` (*array*): Array of meta keys being searched.
- `$search_term` (*string*): The search term entered by the user.
- `$filter_id` (*string*): The ID of the filter element initiating the search.
- `$query_id` (*string*): The ID of the query loop being filtered.

## Example usage

```php
add_filter( 'bricks/combined_search/term_ids', function( $term_ids, $term_fields, $meta_fields, $search_term, $filter_id, $query_id ) {
    // Example: Exclude 'uncategorized' term (ID: 1) from search results
    if ( ( $key = array_search( 1, $term_ids ) ) !== false ) {
        unset( $term_ids[ $key ] );
    }

    return $term_ids;
}, 10, 6 );
```

---


## Filter: bricks/combined_search/user_ids

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-combined_search-user_ids/*

Filters the list of user IDs returned by the combined search logic (used in AJAX search filters targeting users). This allows you to include or exclude users from the search results after the initial search query has run.

## Parameters

- `$user_ids` (*array*): Array of found user IDs.
- `$user_fields` (*array*): Array of user fields being searched (e.g., `['display_name', 'user_email']`).
- `$meta_fields` (*array*): Array of meta keys being searched.
- `$search_term` (*string*): The search term entered by the user.
- `$filter_id` (*string*): The ID of the filter element initiating the search.
- `$query_id` (*string*): The ID of the query loop being filtered.

## Example usage

```php
add_filter( 'bricks/combined_search/user_ids', function( $user_ids, $user_fields, $meta_fields, $search_term, $filter_id, $query_id ) {
    // Example: Exclude administrator (ID: 1) from search results
    if ( ( $key = array_search( 1, $user_ids ) ) !== false ) {
        unset( $user_ids[ $key ] );
    }

    return $user_ids;
}, 10, 6 );
```

---


## Filter: bricks/comments/author_tag

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-comments-author_tag/*

Filters the HTML tag used to wrap the comment author's name in the comments list.

## Parameters

- `$tag` (*string*): The HTML tag name. Defaults to `h5`.

## Example usage

```php
add_filter( 'bricks/comments/author_tag', function( $tag ) {
    // Change author name tag to 'span'
    return 'span';
} );
```

---


## Filter: bricks/conditions/groups

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-conditions-groups/*

Filters the condition groups available in the element conditions interface. This allows you to add new categories for your custom conditions.

## Parameters

- `$groups` (*array*): Array of condition groups. Each group has a `name` and `label`.

## Example usage

```php
add_filter( 'bricks/conditions/groups', function( $groups ) {
    // Add a custom condition group
    $groups[] = [
        'name'  => 'my_custom_group',
        'label' => esc_html__( 'My Custom Group', 'my-plugin' ),
    ];

    return $groups;
} );
```

---


## Filter: bricks/conditions/options

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-conditions-options/*

Filters the condition options available in the element conditions interface. This allows you to add custom conditions that users can select to control element visibility.

## Parameters

- `$options` (*array*): Array of condition options. Each option defines the condition key, label, group, comparison operators, and value input type.

## Example usage

```php
add_filter( 'bricks/conditions/options', function( $options ) {
    // Add a custom 'Is Weekend' condition
    $options[] = [
        'key'     => 'is_weekend',
        'group'   => 'other', // Or a custom group created via bricks/conditions/groups
        'label'   => esc_html__( 'Is Weekend', 'my-plugin' ),
        'compare' => [
            'type'        => 'select',
            'options'     => [
                '==' => esc_html__( 'is', 'bricks' ),
            ],
        ],
        'value'   => [
            'type'    => 'select',
            'options' => [
                'true'  => esc_html__( 'True', 'bricks' ),
                'false' => esc_html__( 'False', 'bricks' ),
            ],
        ],
    ];

    return $options;
} );
```

---


## Filter: bricks/conditions/result

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-conditions-result/*

Filters the boolean result of a condition check. This filter is used to implement the logic for custom conditions or to override existing condition logic.

## Parameters

- `$result` (*bool*): The result of the condition evaluation.
- `$condition_key` (*string*): The key of the condition being evaluated (e.g., `user_role`, `my_custom_condition`).
- `$condition` (*array*): The condition settings (contains `compare`, `value`, etc.).

## Example usage

```php
add_filter( 'bricks/conditions/result', function( $result, $condition_key, $condition ) {
    // Logic for custom 'is_weekend' condition
    if ( $condition_key === 'is_weekend' ) {
        $is_weekend = ( date( 'N' ) >= 6 );
        $value      = isset( $condition['value'] ) ? $condition['value'] : 'true';

        // Check if condition value matches current state
        if ( $value === 'true' ) {
            return $is_weekend;
        } else {
            return ! $is_weekend;
        }
    }

    return $result;
}, 10, 3 );
```

---


## Filter: bricks/custom_fonts/mime_types

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-custom_fonts-mime_types/*

Filters the list of allowed MIME types for custom font uploads in the Bricks Custom Fonts manager.

## Parameters

- `$mime_types` (*array*): Array of file extensions and their corresponding MIME types (e.g., `['woff2' => 'font/woff2']`).

## Example usage

```php
add_filter( 'bricks/custom_fonts/mime_types', function( $mime_types ) {
    // Add support for OTF fonts
    $mime_types['otf'] = 'font/otf';

    return $mime_types;
} );
```

---


## Filter: bricks/database/bricks_get_all_templates_by_type_args

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-database-bricks_get_all_templates_by_type_args/*

Filters the query arguments used to retrieve all Bricks templates. This is primarily used by multilingual plugins (like WPML and Polylang) to ensure only templates in the current language are fetched.

## Parameters

- `$args` (*array*): Array of arguments passed to `get_posts()`.

## Example usage

```php
add_filter( 'bricks/database/bricks_get_all_templates_by_type_args', function( $args ) {
    // Example: Include private templates
    $args['post_status'] = [ 'publish', 'private' ];

    return $args;
} );
```

---


## Filter: bricks/database/content_type

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-database-content_type/*

Filters the content type determined by Bricks for the current page request. This affects which template conditions are checked (e.g., whether to look for a single template, archive template, or search results template).

## Parameters

- `$content_type` (*string*): The detected content type (e.g., `content`, `archive`, `search`, `error`, `header`, `footer`).
- `$post_id` (*int*): The current post ID.

## Example usage

```php
add_filter( 'bricks/database/content_type', function( $content_type, $post_id ) {
    // Example: Treat a specific page as a search results page
    if ( is_page( 'advanced-search' ) ) {
        return 'search';
    }

    return $content_type;
}, 10, 2 );
```

---


## Filter: bricks/database/get_all_templates_cache_key

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-database-get_all_templates_cache_key/*

Filters the cache key used to store and retrieve the list of all Bricks templates. This allows plugins to create unique cache entries based on context (e.g., current language).

## Parameters

- `$cache_key` (*string*): The default cache key (e.g., `all_templates_{timestamp}`).

## Example usage

```php
add_filter( 'bricks/database/get_all_templates_cache_key', function( $cache_key ) {
    // Example: Append current language code to cache key
    if ( defined( 'ICL_LANGUAGE_CODE' ) ) {
        $cache_key .= '_' . ICL_LANGUAGE_CODE;
    }

    return $cache_key;
} );
```

---


## Filter: bricks/dynamic_data/allowed_keys

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-dynamic_data-allowed_keys/*

Filters the allowed argument keys (modifiers) that can be parsed in dynamic data tags (e.g., `{post_title:my_key}`). This allows you to introduce custom arguments for your dynamic tags.

## Parameters

- `$allowed_keys` (*array*): Array of allowed argument keys. Defaults include `fallback`, `fallback-image`, `sanitize`, `exclude`, `start-at`, `pad`, `key`, `is-array`, `date`, `from`, `to`.

## Example usage

```php
add_filter( 'bricks/dynamic_data/allowed_keys', function( $allowed_keys ) {
    // Add 'limit' as an allowed argument key
    $allowed_keys[] = 'limit';

    return $allowed_keys;
} );
```

---


## Filter: bricks/dynamic_data/author_value

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-dynamic_data-author_value/*

Filters the value returned by `{author_...}` dynamic data tags (e.g., `{author_name}`, `{author_email}`).

## Parameters

- `$value` (*string*): The value of the author field.
- `$field_type` (*string*): The specific author field being retrieved (e.g., `name`, `email`, `bio`, `website`, `avatar`).
- `$filters` (*array*): Array of modifiers applied to the tag (e.g., `['fallback' => '...']`).

## Example usage

```php
add_filter( 'bricks/dynamic_data/author_value', function( $value, $field_type, $filters ) {
    // Example: Append text to author bio
    if ( $field_type === 'bio' ) {
        return $value . ' [Verified Author]';
    }

    return $value;
}, 10, 3 );
```

---


## Filter: bricks/dynamic_data/format_value

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-dynamic_data-format_value/*

Filters the final processed value of any dynamic data tag before it is rendered. This is a powerful filter that runs for every dynamic tag, allowing you to globally modify outputs based on context or tag name.

## Parameters

- `$value` (*mixed*): The processed value of the dynamic tag.
- `$tag` (*string*): The dynamic data tag (e.g., `post_title`, `my_custom_tag`).
- `$post_id` (*int*): The ID of the post context.
- `$filters` (*array*): Array of modifiers/arguments applied to the tag (e.g., `['fallback' => '...']`).
- `$context` (*string*): The context where the tag is being rendered (e.g., `text`, `link`, `image`, `video`, `object`, `media`).

## Example usage

```php
add_filter( 'bricks/dynamic_data/format_value', function( $value, $tag, $post_id, $filters, $context ) {
    // Example: Add a suffix to the post title when used in text context
    if ( $tag === 'post_title' && $context === 'text' ) {
        return $value . ' | My Site';
    }

    return $value;
}, 10, 5 );
```

---


## Filter: bricks/dynamic_data/meta_value/my_price_field

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-dynamic_data-meta_value-meta_key/*

Filters the value of a specific post meta key when retrieved via dynamic data (e.g., `{cf_my_key}`). The `{$meta_key}` portion of the hook name should be replaced with your actual meta key.

## Parameters

- `$value` (*mixed*): The value of the custom field.
- `$post` (*WP_Post*): The post object.

## Example usage

```php
// Filter the value of the custom field with key 'my_price_field'
add_filter( 'bricks/dynamic_data/meta_value/my_price_field', function( $value, $post ) {
    // Example: Format the price
    return '$' . number_format( (float) $value, 2 );
}, 10, 2 );
```

---


## Filter: bricks/dynamic_data/register_hook

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-dynamic_data-register_hook/*

Filters the WordPress action hook used to register Bricks dynamic data providers and tags.

## Parameters

- `$hook` (*string*): The action hook name. Defaults to `init`.

## Example usage

```php
add_filter( 'bricks/dynamic_data/register_hook', function( $hook ) {
    // Register dynamic data on 'wp_loaded' instead of 'init'
    return 'wp_loaded';
} );
```

---


## Filter: bricks-dynamic_data-render_content

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-dynamic_data-render_content/*

Filters the content to be parsed for dynamic data tags. This is the main filter used to resolve dynamic tags (e.g., `{post_title}`) into their actual values.

## Parameters

- `$content` (*string*): The content string containing dynamic tags.
- `$post` (*WP_Post*): The post context.
- `$context` (*string*): The context where the content is used (e.g., `text`).

## Example usage

```php
$content = 'Hello {post_title}';
$post_id = 123;
$post    = get_post( $post_id );

// Manually parse dynamic data in a string
$parsed_content = apply_filters( 'bricks/dynamic_data/render_content', $content, $post, 'text' );

// Output: Hello My Post Title
echo $parsed_content;
```

---


## Filter: bricks/dynamic_data/render_tag

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-dynamic_data-render_tag/*

Filters the logic to resolve a single dynamic data tag to its value. This filter is called for each individual tag found in the content.

## Parameters

- `$tag` (*string*): The dynamic data tag string (without curly braces, e.g., `post_title:fallback`).
- `$post` (*WP_Post*): The post context.
- `$context` (*string*): The context where the tag is being rendered.

## Example usage

```php
add_filter( 'bricks/dynamic_data/render_tag', function( $tag, $post, $context ) {
    // Implement a custom tag '{my_custom_tag}'
    if ( $tag === 'my_custom_tag' ) {
        return 'My Custom Value';
    }

    return $tag; // Return original tag to let other providers handle it
}, 10, 3 );
```

---


## Filter: bricks/dynamic_data/text_separator

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-dynamic_data-text_separator/*

Filters the separator used when joining array values in a dynamic data tag (text context). The default separator is a comma and a space (`, `).

## Parameters

- `$sep` (*string*): The separator string.
- `$tag` (*string*): The dynamic data tag.
- `$post_id` (*int*): The ID of the post context.
- `$filters` (*array*): Array of modifiers applied to the tag.

## Example usage

```php
add_filter( 'bricks/dynamic_data/text_separator', function( $sep, $tag, $post_id, $filters ) {
    // Example: Use a line break separator for a specific custom field
    if ( $tag === 'my_repeater_field' ) {
        return '<br>';
    }

    return $sep;
}, 10, 4 );
```

---


## Filter: bricks/dynamic_data/user_value

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-dynamic_data-user_value/*

Filters the value returned by `{wp_user_...}` dynamic data tags (e.g., `{wp_user_email}`, `{wp_user_role}`).

## Parameters

- `$value` (*mixed*): The value of the user field.
- `$field_type` (*string*): The specific user field being retrieved (e.g., `email`, `login`, `first_name`, `last_name`, `bio`, `picture`, `role`, `registered_date`).
- `$filters` (*array*): Array of modifiers applied to the tag.

## Example usage

```php
add_filter( 'bricks/dynamic_data/user_value', function( $value, $field_type, $filters ) {
    // Example: Capitalize the user role
    if ( $field_type === 'role' && is_string( $value ) ) {
        return ucfirst( $value );
    }

    return $value;
}, 10, 3 );
```

---


## Filter: bricks/dynamic_tags_list

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-dynamic_tags_list/*

Filters the list of dynamic data tags available in the builder's dynamic data picker. This allows you to register your custom dynamic tags so they appear in the UI.

## Parameters

- `$tags` (*array*): Array of dynamic data tag definitions.

## Example usage

```php
add_filter( 'bricks/dynamic_tags_list', function( $tags ) {
    $tags[] = [
        'name'  => '{my_custom_tag}',
        'label' => esc_html__( 'My Custom Tag', 'my-plugin' ),
        'group' => 'My Plugin Group',
    ];

    return $tags;
} );
```

---


## Filter: bricks/element/builder_setup_query

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-element-builder_setup_query/*

Filters the query arguments used to set up the preview context in the builder (e.g., when "Populate Content" is active).

## Parameters

- `$query_args` (*array*): Array of arguments passed to `WP_Query`.
- `$post_id` (*int*): The ID of the template being edited.

## Example usage

```php
add_filter( 'bricks/element/builder_setup_query', function( $query_args, $post_id ) {
    // Example: If editing a specific template, force a specific post for preview
    if ( $post_id === 123 ) {
        $query_args['p'] = 456;
        $query_args['post_type'] = 'post';
    }

    return $query_args;
}, 10, 2 );
```

---


## Filter: bricks/element/form/datepicker_options

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-element-form-datepicker_options/*

Filters the Flatpickr options for the datepicker field in the Form element. This allows you to customize the behavior of the date picker (e.g., disable specific dates, change the date format, set min/max dates).

## Parameters

- `$datepicker_options` (*array*): Array of Flatpickr options.
- `$element` (*object*): The Form element instance.

## Example usage

```php
add_filter( 'bricks/element/form/datepicker_options', function( $datepicker_options, $element ) {
    // Example: Disable weekends (Saturday and Sunday)
    $datepicker_options['disable'] = [
        function( $date ) {
            // Return true to disable
            return ( $date->format( 'N' ) >= 6 );
        }
    ];

    // Example: Set minDate to today
    $datepicker_options['minDate'] = 'today';

    return $datepicker_options;
}, 10, 2 );
```

---


## Filter: bricks/element/form/honeypot/result

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-element-form-honeypot-result/*

Filters the result returned when a honeypot field is triggered (spam detection). This allows you to customize the error message shown to potential bots (or users who accidentally filled the hidden field).

## Parameters

- `$result` (*array*): The result array, typically containing `['type' => 'error', 'message' => '...']`.
- `$field_id` (*string*): The ID of the honeypot field that was filled.
- `$form` (*object*): The Form integration object.

## Example usage

```php
add_filter( 'bricks/element/form/honeypot/result', function( $result, $field_id, $form ) {
    // Customize the error message
    $result['message'] = esc_html__( 'Spam detected. Please do not fill out the hidden fields.', 'my-domain' );

    return $result;
}, 10, 3 );
```

---


## Filter: bricks/element/maybe_set_aria_current_page

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-element-maybe_set_aria_current_page/*

Filters the boolean value that determines whether to add the `aria-current="page"` attribute to a link element. This is used to indicate that a link points to the currently active page.

## Parameters

- `$set_aria_current` (*bool*): Whether the link matches the current page.
- `$url` (*string*): The URL of the link being checked.

## Example usage

```php
add_filter( 'bricks/element/maybe_set_aria_current_page', function( $set_aria_current, $url ) {
    // Example: Consider a link active if it matches a specific query parameter
    if ( isset( $_GET['section'] ) && strpos( $url, 'section=' . $_GET['section'] ) !== false ) {
        return true;
    }

    return $set_aria_current;
}, 10, 2 );
```

---


## Filter: bricks/elements/slider/scripts

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-elements-element_name-scripts/*

Filters the list of script handles to be loaded for a specific element. The `{$element_name}` portion of the hook name should be replaced with the element's name (e.g., `slider`, `accordion`, `my_custom_element`).

## Parameters

- `$scripts` (*array*): Array of script handles registered via `wp_register_script`.

## Example usage

```php
// Filter scripts for the 'slider' element
add_filter( 'bricks/elements/slider/scripts', function( $scripts ) {
    // Add a custom script dependency
    $scripts[] = 'my-custom-slider-script';

    return $scripts;
} );
```

---


## Filter: bricks/export_template_args

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-export_template_args/*

Filters the URL arguments used for the "Export Template" link in the Bricks templates list table.

## Parameters

- `$args` (*array*): Array of query arguments for the export URL (e.g., `action`, `nonce`, `templateId`).
- `$post_id` (*int*): The ID of the template being exported.

## Example usage

```php
add_filter( 'bricks/export_template_args', function( $args, $post_id ) {
    // Example: Add a custom parameter to the export URL
    $args['my_param'] = 'value';

    return $args;
}, 10, 2 );
```

---


## Filter: bricks/filter-element/datepicker_options

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-filter-element-datepicker_options/*

Filters the Flatpickr options used by the Filter: Datepicker element. This allows you to customize the behavior of the date picker within query filters.

## Parameters

- `$datepicker_options` (*array*): Array of Flatpickr options.
- `$element` (*object*): The Filter: Datepicker element instance.

## Example usage

```php
add_filter( 'bricks/filter-element/datepicker_options', function( $datepicker_options, $element ) {
    // Example: Change the date format
    $datepicker_options['dateFormat'] = 'Y-m-d';

    // Example: Disable specific dates
    $datepicker_options['disable'] = [ '2023-12-25', '2024-01-01' ];

    return $datepicker_options;
}, 10, 2 );
```

---


## Filter: bricks/filter/taxonomy_args

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-filter-taxonomy_args/*

Filters the arguments passed to `get_terms()` when generating options for taxonomy-based filter elements (e.g., Checkbox, Radio, Select filters).

## Parameters

- `$args` (*array*): Array of arguments for `get_terms()`.
- `$element` (*object*): The filter element instance.

## Example usage

```php
add_filter( 'bricks/filter/taxonomy_args', function( $args, $element ) {
    // Example: Exclude specific term IDs from the filter options
    $args['exclude'] = [ 1, 2, 3 ];

    return $args;
}, 10, 2 );
```

---


## Filter: bricks/filter_element/controls

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-filter_element-controls/*

Filters the controls available for filter elements (e.g., Checkbox, Radio, Select, Range). This allows you to add, remove, or modify settings for these elements globally.

## Parameters

- `$controls` (*array*): Array of element controls.
- `$element` (*object*): The filter element instance.

## Example usage

```php
add_filter( 'bricks/filter_element/controls', function( $controls, $element ) {
    // Add a custom control to all filter elements
    $controls['my_custom_setting'] = [
        'tab'   => 'content',
        'group' => 'filter',
        'label' => esc_html__( 'My Custom Setting', 'my-plugin' ),
        'type'  => 'checkbox',
    ];

    return $controls;
}, 10, 2 );
```

---


## Filter: bricks/filter_element/count_source_custom_field

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-filter_element-count_source-filter_source/*

Filters the count data for a specific filter source. The `{$filter_source}` portion of the hook name should be replaced with the actual source name (e.g., `taxonomy`, `custom_field`, `wcField`).

## Parameters

- `$count_source` (*array*): Associative array where keys are filter values and values are their respective counts.
- `$element` (*object*): The filter element instance.

## Example usage

```php
// Filter counts for a custom field filter source
add_filter( 'bricks/filter_element/count_source_custom_field', function( $count_source, $element ) {
    // Example: Override the count for a specific value
    if ( isset( $count_source['featured'] ) ) {
        $count_source['featured'] = 999;
    }

    return $count_source;
}, 10, 2 );
```

---


## Filter: bricks/filter_element/count_source_wcField

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-filter_element-count_source_wcfield/*

Filters the count data specifically for WooCommerce field filters (e.g., price, rating). This allows you to customize the counts displayed next to filter options.

## Parameters

- `$count_source` (*array*): Associative array where keys are filter values and values are their respective counts.
- `$element` (*object*): The filter element instance.

## Example usage

```php
add_filter( 'bricks/filter_element/count_source_wcField', function( $count_source, $element ) {
    // Example: Hide counts for rating filter by setting them to 0 (if logic hides 0 counts)
    // Or manipulate them for specific ratings
    return $count_source;
}, 10, 2 );
```

---


## Filter: bricks/filter_element/data_source_my_source

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-filter_element-data_source-filter_source/*

Filters the data source (options) for a specific filter source. The `{$filter_source}` portion of the hook name should be replaced with the actual source name.

## Parameters

- `$data_source` (*array*): Array of filter options. Each option should be an associative array with keys like `value`, `text`, `class`, etc.
- `$element` (*object*): The filter element instance.

## Example usage

```php
// Populate options for a custom source 'my_source'
add_filter( 'bricks/filter_element/data_source_my_source', function( $data_source, $element ) {
    $data_source[] = [
        'value' => 'option_1',
        'text'  => 'Option 1',
    ];

    $data_source[] = [
        'value' => 'option_2',
        'text'  => 'Option 2',
    ];

    return $data_source;
}, 10, 2 );
```

---


## Filter: bricks/filter_element/data_source_wcField

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-filter_element-data_source_wcfield/*

Filters the data source (options) specifically for WooCommerce field filters. This allows you to customize the options displayed for WooCommerce filters like product visibility, stock status, etc.

## Parameters

- `$data_source` (*array*): Array of filter options.
- `$element` (*object*): The filter element instance.

## Example usage

```php
add_filter( 'bricks/filter_element/data_source_wcField', function( $data_source, $element ) {
    // Example: Add a custom option to a WooCommerce filter
    // Note: You might need to check $element->settings to target specific WC fields
    if ( isset( $element->settings['sourceFieldType'] ) && $element->settings['sourceFieldType'] === 'stock_status' ) {
         // Modify stock status options
    }

    return $data_source;
}, 10, 2 );
```

---


## Filter: bricks/filter_element/datepicker_date_format

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-filter_element-datepicker_date_format/*

Filters the PHP date format string used by the Filter: Datepicker element. This determines how dates are parsed and formatted for comparison with the database values.

## Parameters

- `$date_format` (*string*): The PHP date format string (e.g., `Y-m-d`, `d/m/Y`).
- `$provider` (*string*): The data provider (e.g., `acf`, `metabox`, `pods`, `jetengine`).
- `$element` (*object*): The filter element instance.

## Example usage

```php
add_filter( 'bricks/filter_element/datepicker_date_format', function( $date_format, $provider, $element ) {
    // Example: Use a specific format for ACF date fields
    if ( $provider === 'acf' ) {
        return 'Ymd'; // ACF often stores dates as Ymd
    }

    return $date_format;
}, 10, 3 );
```

---


## Filter: bricks/filter_element/filtered_source

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-filter_element-filtered_source/*

Filters the data retrieved from the index representing the available filter options and their counts based on the current query results.

## Parameters

- `$filtered_source` (*array*): Associative array where keys are filter values and values are their respective counts (based on the current filtered query).
- `$element` (*object*): The filter element instance.

## Example usage

```php
add_filter( 'bricks/filter_element/filtered_source', function( $filtered_source, $element ) {
    // Example: Ensure a specific value is always present with a count of 0 if missing
    if ( ! isset( $filtered_source['some_value'] ) ) {
        $filtered_source['some_value'] = 0;
    }

    return $filtered_source;
}, 10, 2 );
```

---


## Filter: bricks/fix_filter_element_db

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-fix_filter_element_db/*

Allows plugins to intercept and handle the database update process for filter elements on a per-post basis. If the filter returns `true`, Bricks will skip its default update logic for that post.

## Parameters

- `$handled` (*bool*): Whether the update has been handled. Default is `false`.
- `$post_id` (*int*): The ID of the post being processed.
- `$template_type` (*string*): The template type of the post.

## Example usage

```php
add_filter( 'bricks/fix_filter_element_db', function( $handled, $post_id, $template_type ) {
    // Example: Skip processing for a specific post ID
    if ( $post_id === 1234 ) {
        return true;
    }

    return $handled;
}, 10, 3 );
```

---


## Filter: bricks/form/file_directory

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-form-file_directory/*

This filter allows you to modify the directory where your uploaded form files are stored when the `Save File` setting is "Save in custom directory".

![](imgs/bricks-filter-form-file-directory-442x1024-a7d700eaed.png)



By default, the folder is always located in WordPress "uploads" if you configure it via the `Direction name` in the setting below `Save file`.

You can change the final file storage location by utilizing the `bricks/form/file_directory` filter.

:::note
Bricks will automatically create the directory if it doesn't already exist.
:::

```php
add_filter( 'bricks/form/file_directory', function( $directory_path, $form, $input_name ){
  $form_fields   = $form->get_fields();
  $form_id       = $form_fields['formId'];

  // Return: Target form ID is not 'exbedq' OR field name is not 'form-field-vfkfev'
  // if ( $form_id !== 'exbedq' || $input_name !== 'form-field-vfkfev' ) {
    // return $directory_path;
  // }

  // Get uploads directory
  $wp_upload_dir = wp_upload_dir();

  // Store form files under /uploads/form-files
  $directory_path = $wp_upload_dir['basedir'] . '/form-files';

  return $directory_path;
}, 10, 3);
```

---


## Filter: bricks/form/recaptcha_score_threshold

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-form-recaptcha_score_threshold/*

Filters the minimum score required for Google reCAPTCHA v3 validation in Bricks forms. Scores range from 0.0 (likely a bot) to 1.0 (likely a human).

## Parameters

- `$score` (*float*): The minimum score threshold. Default is `0.5`.

## Example usage

```php
add_filter( 'bricks/form/recaptcha_score_threshold', function( $score ) {
    // Increase threshold to 0.8 for stricter validation
    return 0.8;
} );
```

---


## Filter: bricks/form/response

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-form-response/*

Filters the JSON response sent to the browser after a Bricks form submission. This allows you to customize the success message, redirection URL, or add extra data to the response.

## Parameters

- `$response` (*array*): The response data array (e.g., `['type' => 'success', 'message' => '...', 'redirectUrl' => '...']`).
- `$form` (*object*): The Form integration instance.

## Example usage

```php
add_filter( 'bricks/form/response', function( $response, $form ) {
    // Example: Append a "Thank you" note to the success message
    if ( isset( $response['type'] ) && $response['type'] === 'success' ) {
        $response['message'] .= ' ' . esc_html__( 'Thank you for contacting us!', 'my-domain' );
    }

    return $response;
}, 10, 2 );
```

---


## Filter: bricks/form/save-submission/form_data

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-form-save-submission-form_data/*

The `bricks/form/save-submission/form_data` filter allows you to modify submitted Bricks form data before it is saved to the database and shown in the Form Submissions admin screen. ([Save submission](/builder/features/save-form-submissions/))

This is useful when you want to:

- Remove unwanted fields from stored submissions
- Mask sensitive values (e.g. passwords, tokens, IDs)
- Normalize or reformat values before storage



### Example:

In this example, the form submission should store other registration fields, but the password field is masked before saving.

```php
/**
 * $form_data is an array of Submission data to be saved.
 * $form_id The Bricks Form element ID.
 * $post_id The post/page ID where the form is located
 */
add_filter( 'bricks/form/save-submission/form_data', function( $form_data, $form_id, $post_id ) {
  if ( $form_id !== 'coudkb' ) {
    return $form_data;
  }

  // Array of all data going to be saved for this submission, the array key is the field ID
  // Example, mask the field ID 798ce3 before saving
  if ( isset( $form_data['798ce3']['value'] ) ) {
    $form_data['798ce3']['value'] = '******';
  }
  return $form_data;
}, 10, 3 );
```



**Notes:**

- This filter affects **save submissions only**. It does not change what is sent via email actions or other integrations unless those also use the stored submission data.
- For sensitive fields, consider disabling save submission entirely if you don’t need it, or mask/remove values using this filter.

---


## Filter: bricks/form/submission-table/file_url

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-form-submission-table-file_url/*

Filters the URL of an uploaded file displayed in the Form Submissions table in the admin area. This is useful if you have customized the upload directory and the auto-generated URL is incorrect.

## Parameters

- `$file_url` (*string*): The generated URL for the file.
- `$file` (*array*): Array containing file information (e.g., `file` path, `name`, `type`).
- `$field_key` (*string*): The ID of the form field.

## Example usage

```php
add_filter( 'bricks/form/submission-table/file_url', function( $file_url, $file, $field_key ) {
    // Example: Fix URL for files in a custom 'secure-uploads' directory
    if ( strpos( $file['file'], 'secure-uploads' ) !== false ) {
        return site_url( '/secure-uploads/' . basename( $file['file'] ) );
    }

    return $file_url;
}, 10, 3 );
```

---


## Filter: bricks/form/tinymce_settings

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-form-tinymce_settings/*

Filters the TinyMCE configuration settings for "Rich Text" fields in Bricks forms. This allows you to customize the toolbar, menus, and other editor options.

## Parameters

- `$settings` (*array*): Array of TinyMCE settings.

## Example usage

```php
add_filter( 'bricks/form/tinymce_settings', function( $settings ) {
    // Example: Disable the menubar
    $settings['menubar'] = false;

    // Example: Simplify the toolbar
    $settings['toolbar'] = 'bold italic underline | bullist numlist | link unlink';

    return $settings;
} );
```

---


## Filter: bricks/form/validate

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-form-validate/*

Filters the validation errors for a form submission. This allows you to implement custom validation logic (e.g., checking if an email is from a specific domain, or if a field value meets certain criteria).

## Parameters

- `$errors` (*array*): Array of validation error messages.
- `$form` (*object*): The Form integration instance.

## Example usage

```php
add_filter( 'bricks/form/validate', function( $errors, $form ) {
    $form_id = $form->get_element_id();
    $fields  = $form->get_fields();

    // Example: Only validate a specific form
    if ( $form_id === 'my_form_id' ) {
        // Check if email domain is allowed
        $email_field_id = 'form-field-email';
        if ( isset( $fields[ $email_field_id ] ) ) {
            $email = $fields[ $email_field_id ];
            if ( strpos( $email, '@example.com' ) === false ) {
                $errors[] = esc_html__( 'Please use an @example.com email address.', 'my-domain' );
            }
        }
    }

    return $errors;
}, 10, 2 );
```

---


## Filter: bricks/frontend/disable_opengraph

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-frontend-disable_opengraph/*

Determines whether Bricks should generate and output Open Graph meta tags (e.g., `og:title`, `og:image`). Use this to disable Bricks' Open Graph implementation if you are using a third-party SEO plugin that already handles this.

## Parameters

- `$disable` (*bool*): Whether to disable Open Graph tags.

## Example usage

```php
add_filter( 'bricks/frontend/disable_opengraph', function( $disable ) {
    // Example: Disable Open Graph tags on 'product' post type
    if ( is_singular( 'product' ) ) {
        return true;
    }

    return $disable;
} );
```

---


## Filter: bricks/frontend/disable_seo

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-frontend-disable_seo/*

Determines whether Bricks should generate and output SEO meta tags (e.g., description, keywords, robots) and modify the document title. Use this to disable Bricks' built-in SEO features if you are using a dedicated SEO plugin.

## Parameters

- `$disable` (*bool*): Whether to disable SEO tags.

## Example usage

```php
add_filter( 'bricks/frontend/disable_seo', function( $disable ) {
    // Example: Always disable Bricks SEO features
    return true;
} );
```

---


## Filter: bricks/frontend/render_loop

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-frontend-render_loop/*

Filters the HTML output of a query loop iteration. This allows you to modify the content of each item rendered within a loop.

## Parameters

- `$output` (*string*): The rendered HTML of the loop item.
- `$element` (*array*): The element data array.
- `$container` (*object*): The container element instance managing the loop.

## Example usage

```php
add_filter( 'bricks/frontend/render_loop', function( $output, $element, $container ) {
    // Example: Wrap each loop item in a custom div
    return '<div class="my-custom-loop-wrapper">' . $output . '</div>';
}, 10, 3 );
```

---


## Filter: bricks/get_builder_edit_link

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-get_builder_edit_link/*

Filters the "Edit with Bricks" URL generated for a post. This allows you to append custom query parameters or modify the link structure.

## Parameters

- `$url` (*string*): The "Edit with Bricks" URL.
- `$post_id` (*int*): The ID of the post.

## Example usage

```php
add_filter( 'bricks/get_builder_edit_link', function( $url, $post_id ) {
    // Example: Append a custom parameter to the builder URL
    return add_query_arg( 'my_param', 'value', $url );
}, 10, 2 );
```

---


## Filter: bricks/get_remote_templates_data

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-get_remote_templates_data/*

Filters the data retrieved from a remote template source (e.g., the Bricks Community Templates or a custom remote library). This allows you to modify, add, or remove templates before they are displayed in the template manager.

## Parameters

- `$remote_templates` (*array*): The decoded JSON response from the remote source, containing template data.

## Example usage

```php
add_filter( 'bricks/get_remote_templates_data', function( $remote_templates ) {
    // Example: Remove templates with a specific tag
    if ( ! empty( $remote_templates['templates'] ) ) {
        foreach ( $remote_templates['templates'] as $key => $template ) {
            if ( isset( $template['tags'] ) && in_array( 'deprecated', $template['tags'] ) ) {
                unset( $remote_templates['templates'][ $key ] );
            }
        }
    }

    return $remote_templates;
} );
```

---


## Filter: bricks/get_template_authors

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-get_template_authors/*

Filters the list of authors displayed in the Bricks template manager. This allows you to customize which authors are selectable when filtering templates.

## Parameters

- `$authors` (*array*): Array of author display names.

## Example usage

```php
add_filter( 'bricks/get_template_authors', function( $authors ) {
    // Example: Remove 'admin' from the authors list
    if ( ( $key = array_search( 'admin', $authors ) ) !== false ) {
        unset( $authors[ $key ] );
    }

    return $authors;
} );
```

---


## Filter: bricks/get_template_bundles

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-get_template_bundles/*

Filters the list of template bundles displayed in the Bricks template manager. Template bundles are a custom taxonomy used to categorize templates.

## Parameters

- `$bundles` (*array*): Associative array of template bundles, where the key is the term slug and the value is the term name.

## Example usage

```php
add_filter( 'bricks/get_template_bundles', function( $bundles ) {
    // Example: Rename a specific bundle
    if ( isset( $bundles['my-bundle'] ) ) {
        $bundles['my-bundle'] = 'My Renamed Bundle';
    }

    return $bundles;
} );
```

---


## Filter: bricks/get_template_tags

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-get_template_tags/*

Filters the list of template tags displayed in the Bricks template manager. Template tags are a custom taxonomy used to organize templates.

## Parameters

- `$tags` (*array*): Associative array of template tags, where the key is the term slug and the value is the term name.

## Example usage

```php
add_filter( 'bricks/get_template_tags', function( $tags ) {
    // Example: Remove the 'dark' tag from the list
    if ( isset( $tags['dark'] ) ) {
        unset( $tags['dark'] );
    }

    return $tags;
} );
```

---


## Filter: bricks/get_templates/query_vars

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-get_templates-query_vars/*

Filters the query arguments used by `Templates::get_templates_query()` to retrieve Bricks templates. This allows you to customize which templates are fetched, for example, to support multilingual plugins or custom filtering.

## Parameters

- `$query_vars` (*array*): Array of arguments passed to `WP_Query`.

## Example usage

```php
add_filter( 'bricks/get_templates/query_vars', function( $query_vars ) {
    // Example: Exclude templates with a specific meta key
    $query_vars['meta_query'][] = [
        'key'     => 'my_exclude_key',
        'compare' => 'NOT EXISTS',
    ];

    return $query_vars;
} );
```

---


## Filter: bricks/get_templates

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-get_templates/*

Filters the list of templates returned by the `Templates::get_templates()` method. This allows you to modify the templates array before it is returned to the builder or other parts of the application.

## Parameters

- `$templates` (*array*): Array of template data.
- `$custom_args` (*array*): The arguments used to query the templates.

## Example usage

```php
add_filter( 'bricks/get_templates', function( $templates, $custom_args ) {
    // Example: Add a custom property to all templates
    foreach ( $templates as $key => $template ) {
        $templates[ $key ]['my_custom_property'] = 'value';
    }

    return $templates;
}, 10, 2 );
```

---


## Filter: bricks/get_templates_query/cache_key

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-get_templates_query-cache_key/*

Filters the cache key used by `Templates::get_templates_query()` to store and retrieve template queries. Use this to create unique cache entries when modifying the template query arguments based on custom context (e.g., user role, language).

## Parameters

- `$cache_key` (*string*): The unique cache key string.

## Example usage

```php
add_filter( 'bricks/get_templates_query/cache_key', function( $cache_key ) {
    // Example: Append current user role to cache key
    $user = wp_get_current_user();
    $role = ( array ) $user->roles;
    
    return $cache_key . '_' . implode( '-', $role );
} );
```

---


## Filter: bricks/get_terms_options/enable_limit

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-get_terms_options-enable_limit/*

Enables a limit on the number of taxonomies queried when fetching terms for builder controls. This is useful for sites with a very large number of taxonomies to prevent memory exhaustion.

## Parameters

- `$enable_limit` (*bool*): Whether to limit the number of queried taxonomies. Default is `false`.

## Example usage

```php
add_filter( 'bricks/get_terms_options/enable_limit', function( $enable_limit ) {
    // Enable the limit to improve performance on sites with many taxonomies
    return true;
} );
```

---


## Filter: bricks/get_terms_options/excluded_taxonomies

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-get_terms_options-excluded_taxonomies/*

Filters the list of taxonomies excluded from term selection controls in the builder. This allows you to hide specific taxonomies (e.g., internal taxonomies) from the UI.

## Parameters

- `$excluded_taxonomies` (*array*): Array of taxonomy slugs to exclude. Defaults include `nav_menu`, `link_category`, `post_format`.

## Example usage

```php
add_filter( 'bricks/get_terms_options/excluded_taxonomies', function( $excluded_taxonomies ) {
    // Example: Exclude 'my_internal_taxonomy'
    $excluded_taxonomies[] = 'my_internal_taxonomy';

    return $excluded_taxonomies;
} );
```

---


## Filter: bricks/get_the_title

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-get_the_title/*

Filters the page title returned by `Helpers::get_the_title()`. This function determines the appropriate title based on the context (single post, archive, search results, etc.).

## Parameters

- `$title` (*string*): The generated page title.
- `$post_id` (*int*): The ID of the current post or template.

## Example usage

```php
add_filter( 'bricks/get_the_title', function( $title, $post_id ) {
    // Example: Add a prefix to the title for search results
    if ( is_search() ) {
        return 'Searching: ' . $title;
    }

    return $title;
}, 10, 2 );
```

---


## Filter: bricks/handle_no_results_children_elements

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-handle_no_results_children_elements/*

Determines whether Bricks should run logic to handle children elements displayed when a query loop returns no results (e.g., ensuring scripts/styles are enqueued for "No results" content).

## Parameters

- `$run` (*bool*): Whether to handle "No results" children logic. Defaults to `true` if Query Filters are enabled.

## Example usage

```php
add_filter( 'bricks/handle_no_results_children_elements', function( $run ) {
    // Example: Always enable this logic, even if native Query Filters are disabled
    return true;
} );
```

---


## Filter: bricks/helpers/get_posts_args

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-helpers-get_posts_args/*

Filters the query arguments used to fetch posts for the "Preview as" setting and other post selection controls in the builder.

## Parameters

- `$query_args` (*array*): Array of arguments passed to `get_posts()`.

## Example usage

```php
add_filter( 'bricks/helpers/get_posts_args', function( $query_args ) {
    // Example: Exclude 'private' posts from the selection list
    $query_args['post_status'] = 'publish';

    return $query_args;
} );
```

---


## Filter: bricks/metabox/checkbox_value

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-metabox-checkbox_value/*

Filters the output value of a Meta Box checkbox field when rendered via Bricks dynamic data. By default, Bricks converts truthy values to "Yes" and falsy values to "No".

## Parameters

- `$value` (*string*): The processed value (e.g., "Yes" or "No").
- `$original_value` (*mixed*): The raw value from the database.
- `$field` (*array*): The Meta Box field settings array.
- `$post` (*WP_Post*): The current post object.

## Example usage

```php
add_filter( 'bricks/metabox/checkbox_value', function( $value, $original_value, $field, $post ) {
    // Example: Return "Active" or "Inactive"
    return $original_value ? 'Active' : 'Inactive';
}, 10, 4 );
```

---


## Filter: bricks/metabox/show_as_map

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-metabox-show_as_map/*

Determines whether a Meta Box map field should be rendered as a map (using `rwmb_meta()`) or as raw latitude/longitude coordinates when used in dynamic data.

## Parameters

- `$show_as_map` (*bool*): Whether to render as a map. Default is `false` (renders coordinates).
- `$field` (*array*): The Meta Box field settings array.
- `$post` (*WP_Post*): The current post object.

## Example usage

```php
add_filter( 'bricks/metabox/show_as_map', function( $show_as_map, $field, $post ) {
    // Example: Render as map for a specific field ID
    if ( $field['id'] === 'my_map_field' ) {
        return true;
    }

    return $show_as_map;
}, 10, 3 );
```

---


## Filter: bricks/metabox/taxonomy/show_as_link

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-metabox-taxonomy-show_as_link/*

Determines whether Meta Box taxonomy fields retrieved via dynamic data should be rendered as links to the term archives.

## Parameters

- `$show_as_link` (*bool*): Whether to render as links. Default is `true`.
- `$value` (*mixed*): The raw value of the taxonomy field.
- `$field` (*array*): The Meta Box field settings array.

## Example usage

```php
add_filter( 'bricks/metabox/taxonomy/show_as_link', function( $show_as_link, $value, $field ) {
    // Disable links for a specific taxonomy field
    if ( $field['id'] === 'my_taxonomy_field' ) {
        return false;
    }

    return $show_as_link;
}, 10, 3 );
```

---


## Filter: bricks/posts/query_vars

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-object_types-query_vars/*

Allows you to modify the query variables for a specific object type query loop. This is a dynamic filter where `{$object_type}` is replaced by the type of object being queried (e.g., `post`, `term`, `user`).

Common variations:
- `bricks/posts/query_vars`
- `bricks/terms/query_vars`
- `bricks/users/query_vars`

## Parameters

- `$query_vars` (array): The query variables/arguments.
- `$settings` (array): The element settings.
- `$element_id` (string): The element ID.
- `$element_name` (string): The element name (available since Bricks 1.11.1).

## Example usage

```php
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {
    // Only apply to a specific element ID
    if ( $element_id !== 'brxe-abcdef' ) {
        return $query_vars;
    }

    // Modify query variables
    $query_vars['posts_per_page'] = 12;

    return $query_vars;
}, 10, 4 );
```

---


## Filter: bricks/paginate_links_args

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-paginate_links_args/*

Filters the arguments passed to the WordPress `paginate_links()` function when generating pagination output. This allows you to customize the pagination structure, text labels, and other settings.

## Parameters

- `$args` (*array*): Array of arguments for `paginate_links()`.

## Example usage

```php
add_filter( 'bricks/paginate_links_args', function( $args ) {
    // Example: Change the "Previous" and "Next" text
    $args['prev_text'] = 'Previous';
    $args['next_text'] = 'Next';

    // Example: Change the number of adjacent page links shown
    $args['mid_size'] = 3;

    return $args;
} );
```

---


## Filter: bricks/pagination/current_page

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-pagination-current_page/*

The `bricks/pagination/current_page` filter allows you to modify the current page number used in the pagination logic of Bricks Builder. In this example, we'll demonstrate how to customize the current page value based on query variables for a custom loop. `@since 2.2`

You can use `\Bricks\Helpers::get_ajax_current_page()` helper function to retrieve the Bricks AJAX pagination endpoint current page value inside your custom query logic.

Related hooks:

- `bricks/pagination/custom_logic`
- `bricks/pagination/total_pages`

```php
add_filter( 'bricks/pagination/current_page', function( $current_page, $query_settings, $element ) {
  $query_object_type = $query_settings['query']['objectType'] ?? false;

  // If not my custom loop, return original value
  if( $query_object_type !== 'my_custom_loop' ) {
    return $current_page;
  }

  // You can access the element settings via $element->settings

  // Change current page based on query var
  if ( \Bricks\Helpers::get_ajax_current_page() ) {
    $current_page = \Bricks\Helpers::get_ajax_current_page();
  } elseif ( get_query_var( 'page' ) ) {
    // Check for 'page' on static front page
    $current_page = get_query_var( 'page' );
  } elseif ( get_query_var( 'paged' ) ) {
    $current_page = get_query_var( 'paged' );
  } else {
    $current_page = 1;
  }

  return $current_page;
}, 10, 3);
```

---


## Filter: bricks/pagination/custom_logic

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-pagination-custom_logic/*

The `bricks/pagination/custom_logic` filter allows you to implement custom pagination logic in Bricks Builder based on specific query settings. `@since 2.2`

In this example, we'll demonstrate how to apply custom pagination logic to a custom loop.

Next, you will need to use the following 2 filters to amend the current page and total page arguments when generating HTML for the pagination:

- `bricks/pagination/current_page`
- `bricks/pagination/total_pages`

```php
// Return true if want to use custom logic, default is false
add_filter( 'bricks/pagination/custom_logic', function( $custom_logic, $query_settings, $element ) {
  $query_object_type = $query_settings['query']['objectType'] ?? false;

  // If not my custom loop, return original value
  if( $query_object_type !== 'my_custom_loop' ) {
    return $custom_logic;
  }

  // You can access the element settings via $element->settings

  return true;
}, 10, 3);

```

---


## Filter: bricks/pagination/total_pages

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-pagination-total_pages/*

The `bricks/pagination/total_pages` filter allows you to modify the total number of pages used in the pagination logic of Bricks Builder. In this example, we'll demonstrate how to customize the total pages value based on custom loop results. `@since 2.2`

Related hooks:

- `bricks/pagination/custom_logic`
- `bricks/pagination/current_page`

```php
add_filter( 'bricks/pagination/total_pages', function( $total_page, $query_settings, $element ) {
  $query_object_type = $query_settings['query']['objectType'] ?? false;

  // If not my custom loop, return original value
  if( $query_object_type !== 'my_custom_loop' ) {
    return $total_page;
  }

  // You can access the element settings via $element->settings

  // My result stored in a global variable
  global $my_custom_loop_results;

  if ( ! $my_custom_loop_results ) {
    return $total_page;
  }

  // My predefined items per page
  $post_per_page = 3;

  return ceil( count( $my_custom_loop_results ) / $post_per_page );
}, 10, 3);
```

---


## Filter: bricks/popup/attributes

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-popup-attributes/*

Filters the HTML attributes of the popup container. This allows you to add custom classes, data attributes, or other attributes to the popup element.

## Parameters

- `$attributes` (*array*): Array of HTML attributes (e.g., `class`, `data-popup-id`).
- `$popup_id` (*int*): The ID of the popup template.

## Example usage

```php
add_filter( 'bricks/popup/attributes', function( $attributes, $popup_id ) {
    // Example: Add a custom class to a specific popup
    if ( $popup_id === 1234 ) {
        $attributes['class'][] = 'my-custom-popup-class';
        $attributes['data-custom-attr'] = 'value';
    }

    return $attributes;
}, 10, 2 );
```

---


## Filter: bricks/query/archive_query_arguments

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query-archive_query_arguments/*

Filters the list of `WP_Query` arguments that are preserved from the main WordPress query when "Is main query" is enabled in a query loop. This ensures that essential archive parameters (like pagination, taxonomy terms) are passed to the Bricks query.

## Parameters

- `$arguments` (*array*): Array of `WP_Query` argument keys (e.g., `post_type`, `posts_per_page`, `tax_query`).

## Example usage

```php
add_filter( 'bricks/query/archive_query_arguments', function( $arguments ) {
    // Example: specific custom query var from the main query
    $arguments[] = 'my_custom_var';

    return $arguments;
} );
```

---


## Filter: bricks/query/archive_query_supported_object_types

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query-archive_query_supported_object_types/*

Filters the list of Bricks query object types that support the "Is main query" setting (archive loop). By default, only 'post' queries are supported.

## Parameters

- `$object_types` (*array*): Array of supported query object types (e.g., `['post']`).

## Example usage

```php
add_filter( 'bricks/query/archive_query_supported_object_types', function( $object_types ) {
    // Example: Enable "Is main query" for user loops (if implementing custom archive logic)
    $object_types[] = 'user';

    return $object_types;
} );
```

---


## Filter: bricks/query/fake_result

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query-fake_result/*

Filters the results of a "fake" query execution. Fake queries are auxiliary queries run by Bricks (e.g., to count total results for filters without pagination) that mirror the main query but with modified parameters (like `posts_per_page = -1`).

## Parameters

- `$results` (*array*): The query results (e.g., array of WP_Post objects or IDs).
- `$query` (*object*): The Bricks Query instance.

## Example usage

```php
add_filter( 'bricks/query/fake_result', function( $results, $query ) {
    // Example: Manipulate the results for a specific query ID
    if ( $query->id === 'my_filtered_loop' ) {
        // Custom logic to modify results
    }

    return $results;
}, 10, 2 );
```

---


## Filter: bricks/query/force_is_looping

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query-force_is_looping/*

Forces `Bricks\Query::is_looping()` to return `true`. This is useful in AJAX contexts (like popups) where you need to simulate being inside a query loop to correctly render dynamic data that depends on the loop context.

## Parameters

- `$force` (*bool*): Whether to force the is_looping state. Default is `false`.
- `$query_id` (*string*): The ID of the query being checked.
- `$element_id` (*string*): The ID of the element being checked.

## Example usage

```php
add_filter( 'bricks/query/force_is_looping', function( $force, $query_id, $element_id ) {
    // Example: Force looping for a specific element ID
    if ( $element_id === 'my_element_id' ) {
        return true;
    }

    return $force;
}, 10, 3 );
```

---


## Filter: bricks/query/force_loop_index

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query-force_loop_index/*

Forces `Bricks\Query::get_loop_index()` to return a specific value. This is useful for AJAX contexts (like popups) where you need to simulate a specific loop iteration to render correct data or styles.

## Parameters

- `$index` (*string|int*): The forced loop index. Default is `''` (empty string), meaning no override.

## Example usage

```php
add_filter( 'bricks/query/force_loop_index', function( $index ) {
    // Example: Force loop index to 0
    return 0;
} );
```

---


## Filter: bricks/query/prepare_query_vars_from_settings

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query-prepare_query_vars_from_settings/*

Filters the element settings before they are converted into query variables. This runs early in the query setup process, allowing you to modify the raw query settings of an element.

## Parameters

- `$settings` (*array*): The element settings array. The query settings are typically located in `$settings['query']`.
- `$element_id` (*string*): The ID of the element being queried.

## Example usage

```php
add_filter( 'bricks/query/prepare_query_vars_from_settings', function( $settings, $element_id ) {
    // Example: Force a specific post type for a query element with ID 'my_query_element'
    if ( $element_id === 'my_query_element' ) {
        $settings['query']['post_type'] = 'my_custom_post_type';
    }

    return $settings;
}, 10, 2 );
```

---


## Filter: bricks/query/result_end

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query-result_end/*

Filters the ending index used when slicing the query results. This allows you to control which portion of the results is displayed, useful for custom pagination or limit logic.

## Parameters

- `$end` (*int*): The ending index for the result slice.
- `$query` (*object*): The Bricks Query instance.

## Example usage

```php
add_filter( 'bricks/query/result_end', function( $end, $query ) {
    // Example: Limit results to 5 for a specific query ID
    if ( $query->id === 'my_limited_query' ) {
        return 5;
    }

    return $end;
}, 10, 2 );
```

---


## Filter: bricks/query/result_start

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query-result_start/*

Filters the starting index used when slicing the query results. This allows you to control where the displayed results begin, useful for custom offsets or pagination.

## Parameters

- `$start` (*int*): The starting index for the result slice.
- `$query` (*object*): The Bricks Query instance.

## Example usage

```php
add_filter( 'bricks/query/result_start', function( $start, $query ) {
    // Example: Offset results by 1 for a specific query ID
    if ( $query->id === 'my_offset_query' ) {
        return $start + 1;
    }

    return $start;
}, 10, 2 );
```

---


## Filter: bricks/query/run_fake

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query-run_fake/*

Defines the results of a "fake" query execution for custom or unsupported query types. This is used when calculating filter counts or other logic that requires querying all potential results without pagination.

## Parameters

- `$results` (*array*): The query results array (default `[]`).
- `$query` (*object*): The Bricks Query instance.

## Example usage

```php
add_filter( 'bricks/query/run_fake', function( $results, $query ) {
    // Example: Provide all results for a custom 'my_api' query type
    if ( $query->object_type === 'my_api' ) {
        // Fetch all IDs from your API
        return [ 1, 2, 3, 4, 5 ]; 
    }

    return $results;
}, 10, 2 );
```

---


## Filter: bricks/query/supress_render_content

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query-supress_render_content/*

Determines whether to suppress the rendering of the query loop content. This is used by the "Live Search" feature to prevent rendering initial results on page load if they are going to be immediately replaced by AJAX results.

## Parameters

- `$suppress` (*bool*): Whether to suppress rendering.
- `$query` (*object*): The Bricks Query instance.

## Example usage

```php
add_filter( 'bricks/query/supress_render_content', function( $suppress, $query ) {
    // Example: Suppress content rendering for a specific query ID on mobile devices
    if ( $query->id === 'heavy_query' && wp_is_mobile() ) {
        return true;
    }

    return $suppress;
}, 10, 2 );
```

---


## Filter: bricks/query_api/total_pages

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_api-total_pages/*

Filters the total number of pages calculated for an external API query loop. This is useful when the API response structure for pagination doesn't match Bricks' standard extraction logic.

## Parameters

- `$total_pages` (*int*): The calculated total number of pages.
- `$element_id` (*string*): The ID of the query element.
- `$query_api` (*object*): The `Bricks\Integrations\Query\Query_API` instance.

## Example usage

```php
add_filter( 'bricks/query_api/total_pages', function( $total_pages, $element_id, $query_api ) {
    // Example: Set total pages for a specific API query
    if ( $element_id === 'my_api_loop' ) {
        // Assume you stored the total in a custom property or need a fixed value
        return 10;
    }

    return $total_pages;
}, 10, 3 );
```

---


## Filter: bricks/query_filters/custom_field_index_rows

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters-custom_field_index_rows/*

Filters the index rows generated for a custom field in the Query Filters system. This allows providers (like ACF, Meta Box) or custom code to handle how complex field data is indexed for filtering.

## Parameters

- `$rows` (*array*): Array of index rows. Each row is an associative array representing a filterable value.
- `$object_id` (*int*): The ID of the object (post, term, user) being indexed.
- `$meta_key` (*string*): The meta key of the custom field.
- `$provider` (*string*): The data provider (e.g., `acf`, `metabox`).
- `$object_type` (*string*): The type of object (`post`, `term`, `user`).

## Example usage

```php
add_filter( 'bricks/query_filters/custom_field_index_rows', function( $rows, $object_id, $meta_key, $provider, $object_type ) {
    // Example: Index a custom serialized field
    if ( $meta_key === 'my_serialized_field' ) {
        $value = get_post_meta( $object_id, $meta_key, true );
        // ... parse value ...
        $rows[] = [
            'filter_value' => 'parsed_value',
            'filter_value_display' => 'Display Value',
            // ... other required fields ...
        ];
    }

    return $rows;
}, 10, 5 );
```

---


## Filter: bricks/query_filters/custom_field_meta_query

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters-custom_field_meta_query/*

Filters the `meta_query` generated for a custom field filter in the Query Filters system. This allows you to customize how the filtering logic is applied to the main query.

## Parameters

- `$meta_query` (*array*): The generated `meta_query` array (e.g., `['key' => '...', 'value' => '...', 'compare' => '...']`).
- `$filter` (*array*): The active filter data, including settings and selected values.
- `$provider` (*string*): The data provider (e.g., `acf`, `metabox`).
- `$query_id` (*string*): The ID of the query loop being filtered.

## Example usage

```php
add_filter( 'bricks/query_filters/custom_field_meta_query', function( $meta_query, $filter, $provider, $query_id ) {
    // Example: Change comparison to 'LIKE' for a specific field
    if ( $filter['settings']['fieldName'] === 'my_text_field' ) {
        $meta_query['compare'] = 'LIKE';
    }

    return $meta_query;
}, 10, 4 );
```

---


## Filter: bricks/query_filters/datepicker_custom_field_meta_query

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters-datepicker_custom_field_meta_query/*

Filters the `meta_query` generated for a datepicker filter targeting a custom field. This allows you to customize how date comparisons are handled (e.g., date formats, range logic) for specific fields.

## Parameters

- `$meta_query` (*array*): The generated `meta_query` array (e.g., `['key' => '...', 'value' => '...', 'type' => 'DATE']`).
- `$filter` (*array*): The active filter data, including settings and parsed dates.
- `$provider` (*string*): The data provider (e.g., `acf`, `metabox`).
- `$query_id` (*string*): The ID of the query loop being filtered.

## Example usage

```php
add_filter( 'bricks/query_filters/datepicker_custom_field_meta_query', function( $meta_query, $filter, $provider, $query_id ) {
    // Example: Change type to 'NUMERIC' for timestamp fields stored as numbers
    if ( $filter['settings']['fieldName'] === 'my_timestamp_field' ) {
        if ( isset( $meta_query['type'] ) ) {
            $meta_query['type'] = 'NUMERIC';
        } elseif ( isset( $meta_query[0] ) ) {
            // Handle range query (array of arrays)
            foreach ( $meta_query as $key => $clause ) {
                if ( is_int( $key ) ) {
                    $meta_query[ $key ]['type'] = 'NUMERIC';
                }
            }
        }
    }

    return $meta_query;
}, 10, 4 );
```

---


## Filter: bricks/query_filters/element_data

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters-element_data/*

Filters the data for a filter element before it is saved to the internal index table (`bricks_filter_elements`). This allows plugins to attach extra metadata (like language) to the filter configuration.

## Parameters

- `$element_data` (*array*): The data array to be saved (e.g., `filter_id`, `settings`, `post_id`, `language`).
- `$element` (*array*): The raw element data from the builder.
- `$post_id` (*int*): The ID of the post/template containing the element.

## Example usage

```php
add_filter( 'bricks/query_filters/element_data', function( $element_data, $element, $post_id ) {
    // Example: Add a custom property to the saved data
    $element_data['my_custom_prop'] = 'value';

    return $element_data;
}, 10, 3 );
```

---


## Filter: bricks/query_filters/filter_query_vars

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters-filter_query_vars/*

Filters the query variables generated by an active filter element before they are applied to the query loop. This allows you to customize how specific filters affect the query.

## Parameters

- `$query_vars` (*array*): The `WP_Query` arguments generated by this filter.
- `$filter` (*array*): The active filter data (settings, selected values).
- `$query_id` (*string*): The ID of the query loop being filtered.
- `$filter_index` (*int*): The index of this filter in the active filters list.

## Example usage

```php
add_filter( 'bricks/query_filters/filter_query_vars', function( $query_vars, $filter, $query_id, $filter_index ) {
    // Example: Add extra query args for a specific filter
    if ( $filter['settings']['fieldName'] === 'my_special_filter' ) {
        $query_vars['post_status'] = 'publish';
    }

    return $query_vars;
}, 10, 4 );
```

---


## Filter: bricks/query_filters/index_args

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters-index_args/*

Filters the query arguments used by the Query Filters indexer to find objects (posts, terms, users) that need to be indexed.

## Parameters

- `$args` (*array*): The query arguments (for `WP_Query`, `WP_Term_Query`, or `WP_User_Query`).
- `$filter_source` (*string*): The source of the filter data (e.g., `wpField`, `customField`).
- `$filter_settings` (*array*): The settings of the filter element being indexed.
- `$query_type` (*string*): The type of query being run (`wp_query`, `wp_term_query`, `wp_user_query`).

## Example usage

```php
add_filter( 'bricks/query_filters/index_args', function( $args, $filter_source, $filter_settings, $query_type ) {
    // Example: Include 'private' posts when indexing
    if ( $query_type === 'wp_query' ) {
        $args['post_status'] = [ 'publish', 'private' ];
    }

    return $args;
}, 10, 4 );
```

---


## Filter: bricks/query_filters/index_post/meta_exists

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters-index_post-meta_exists/*

Determines if a custom field (meta key) exists for a specific post during the indexing process. This is used when a third-party provider (like ACF or Meta Box) is selected, to avoid indexing empty or non-existent fields.

## Parameters

- `$exists` (*bool*): Whether the meta key exists. Default is `false`.
- `$post_id` (*int*): The ID of the post being checked.
- `$meta_key` (*string*): The meta key of the custom field.
- `$provider` (*string*): The data provider (e.g., `acf`, `metabox`).

## Example usage

```php
add_filter( 'bricks/query_filters/index_post/meta_exists', function( $exists, $post_id, $meta_key, $provider ) {
    // Example: Custom check for a serialized meta field
    if ( $meta_key === 'my_serialized_data' ) {
        $data = get_post_meta( $post_id, $meta_key, true );
        return ! empty( $data );
    }

    return $exists;
}, 10, 4 );
```

---


## Filter: bricks/query_filters/index_post/my_custom_source

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters-index_post-source/*

Filters the index rows generated for a post when the filter source is unknown or handled by a third-party provider. The `{$source}` portion of the hook name corresponds to the filter source (e.g., `wcField` or a custom source).

## Parameters

- `$rows` (*array*): Array of index rows to be inserted into the database. Default is `[]`.
- `$post_id` (*int*): The ID of the post being indexed.
- `$elements` (*array*): Array of filter elements targeting this post.

## Example usage

```php
add_filter( 'bricks/query_filters/index_post/my_custom_source', function( $rows, $post_id, $elements ) {
    foreach ( $elements as $element ) {
        // Calculate filter value for this post
        $value = get_post_meta( $post_id, 'my_custom_field', true );

        if ( $value ) {
            $rows[] = [
                'filter_id'            => $element['filter_id'],
                'object_id'            => $post_id,
                'object_type'          => 'post',
                'filter_value'         => $value,
                'filter_value_display' => $value, // Optional display value
            ];
        }
    }

    return $rows;
}, 10, 3 );
```

---


## Filter: bricks/query_filters/index_post/wcField

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters-index_post-wcfield/*

A specialized hook for indexing WooCommerce product fields (like price, stock status, rating) when a product is saved. This allows the Query Filters index to stay updated with WooCommerce product data.

## Parameters

- `$rows` (*array*): Array of index rows to be inserted.
- `$post_id` (*int*): The ID of the product (post) being indexed.
- `$elements` (*array*): Array of filter elements targeting this product.

## Example usage

```php
add_filter( 'bricks/query_filters/index_post/wcField', function( $rows, $post_id, $elements ) {
    // This filter is typically used internally by Bricks to handle WooCommerce fields.
    // However, you could hook into it to index custom WooCommerce product data.
    
    // Example: Index a custom product property
    $product = wc_get_product( $post_id );
    if ( $product ) {
        // ... generate index rows ...
    }

    return $rows;
}, 10, 3 );
```

---


## Filter: bricks/query_filters/index_user/meta_exists

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters-index_user-meta_exists/*

Determines if a custom field (meta key) exists for a specific user during the indexing process. This is used when a third-party provider (like ACF or Meta Box) is selected, to avoid indexing empty or non-existent fields for users.

## Parameters

- `$exists` (*bool*): Whether the meta key exists. Default is `false`.
- `$user_id` (*int*): The ID of the user being checked.
- `$meta_key` (*string*): The meta key of the custom field.
- `$provider` (*string*): The data provider (e.g., `acf`, `metabox`).

## Example usage

```php
add_filter( 'bricks/query_filters/index_user/meta_exists', function( $exists, $user_id, $meta_key, $provider ) {
    // Example: Custom check for a serialized meta field on a user
    if ( $meta_key === 'user_custom_data' ) {
        $data = get_user_meta( $user_id, $meta_key, true );
        return ! empty( $data );
    }

    return $exists;
}, 10, 4 );
```

---


## Filter: bricks/query_filters/range_custom_field_meta_query

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters-range_custom_field_meta_query/*

Filters the `meta_query` generated for a range filter (slider) targeting a custom field. This allows you to customize how the range comparison is performed (e.g., handling decimal values, changing the data type).

## Parameters

- `$meta_query` (*array*): The generated `meta_query` array (e.g., `['key' => '...', 'value' => [min, max], 'compare' => 'BETWEEN', 'type' => 'NUMERIC']`).
- `$filter` (*array*): The active filter data, including settings and selected min/max values.
- `$provider` (*string*): The data provider (e.g., `acf`, `metabox`).
- `$query_id` (*string*): The ID of the query loop being filtered.

## Example usage

```php
add_filter( 'bricks/query_filters/range_custom_field_meta_query', function( $meta_query, $filter, $provider, $query_id ) {
    // Example: Change type to 'DECIMAL' for precise price filtering
    if ( $filter['settings']['fieldName'] === 'product_price' ) {
        $meta_query['type'] = 'DECIMAL(10,2)';
    }

    return $meta_query;
}, 10, 4 );
```

---


## Filter: bricks/query_filters/sort_query_vars

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters-sort_query_vars/*

Filters the query variables generated by an active "Sort" filter element. This allows you to implement custom sorting logic (e.g., sorting by a custom meta key or a calculated value).

## Parameters

- `$query_vars` (*array*): The `WP_Query` arguments generated by the sort filter (e.g., `['orderby' => '...', 'order' => '...']`).
- `$filter` (*array*): The active filter data, including selected sort option.
- `$query_id` (*string*): The ID of the query loop being sorted.
- `$filter_index` (*int*): The index of this filter in the active filters list.

## Example usage

```php
add_filter( 'bricks/query_filters/sort_query_vars', function( $query_vars, $filter, $query_id, $filter_index ) {
    // Example: Custom sort by 'popularity'
    if ( $filter['value'] === 'popularity' ) {
        $query_vars['orderby'] = 'meta_value_num';
        $query_vars['meta_key'] = 'post_views_count';
        $query_vars['order'] = 'DESC';
    }

    return $query_vars;
}, 10, 4 );
```

---


## Filter: bricks/query_filters_indexer/post/my_custom_source

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters_indexer-post-filter_source/*

Filters the index rows generated for a post by the Query Filters Indexer when processing a specific filter job. The `{$filter_source}` portion of the hook name corresponds to the filter source (e.g., `wcField` or a custom source).

## Parameters

- `$rows` (*array*): Array of index rows to be inserted. Default is `[]`.
- `$post` (*WP_Post|int*): The post object or ID being indexed.
- `$filter_id` (*string*): The ID of the filter element.
- `$filter_settings` (*array*): The settings of the filter element.

## Example usage

```php
add_filter( 'bricks/query_filters_indexer/post/my_custom_source', function( $rows, $post, $filter_id, $filter_settings ) {
    // Generate index rows for custom logic
    $value = get_post_meta( $post->ID, 'my_custom_field', true );

    if ( $value ) {
        $rows[] = [
            'filter_id'            => $filter_id,
            'object_id'            => $post->ID,
            'object_type'          => 'post',
            'filter_value'         => $value,
            'filter_value_display' => $value,
        ];
    }

    return $rows;
}, 10, 4 );
```

---


## Filter: bricks/query_filters_indexer/post/wcField

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters_indexer-post-wcfield/*

A specialized hook for the Query Filters Indexer to generate index rows for WooCommerce product fields (like price, stock status, rating) when processing a filter job.

## Parameters

- `$rows` (*array*): Array of index rows to be inserted. Default is `[]`.
- `$post` (*WP_Post|int*): The product object or ID being indexed.
- `$filter_id` (*string*): The ID of the filter element.
- `$filter_settings` (*array*): The settings of the filter element.

## Example usage

```php
add_filter( 'bricks/query_filters_indexer/post/wcField', function( $rows, $post, $filter_id, $filter_settings ) {
    // This filter is typically used internally by Bricks to handle WooCommerce fields.
    // However, you could hook into it to index custom WooCommerce product data via the 'wcField' source.
    
    // Check if indexing a specific custom WC field
    if ( isset( $filter_settings['sourceFieldType'] ) && $filter_settings['sourceFieldType'] === 'my_custom_wc_field' ) {
        // ... generate and return rows ...
    }

    return $rows;
}, 10, 4 );
```

---


## Filter: bricks/query_filters_indexer/validate_job_settings

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-query_filters_indexer-validate_job_settings/*

Validates the settings of a filter job before the Query Filters Indexer processes it. This is used for unknown or custom filter sources to ensure they have the necessary configuration.

## Parameters

- `$validate` (*bool*): Whether the settings are valid. Default is `false` for unknown sources.
- `$filter_source` (*string*): The source of the filter data (e.g., `wcField`, `customSource`).
- `$filter_settings` (*array*): The settings of the filter element.

## Example usage

```php
add_filter( 'bricks/query_filters_indexer/validate_job_settings', function( $validate, $filter_source, $filter_settings ) {
    // Validate settings for a custom source
    if ( $filter_source === 'my_custom_source' ) {
        // Check if required 'my_key' setting is present
        return ! empty( $filter_settings['my_key'] );
    }

    return $validate;
}, 10, 3 );
```

---


## Filter: bricks/remote_get

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-remote_get/*

Filters the arguments passed to `wp_remote_get()` when Bricks performs a remote GET request (e.g., fetching templates, community library).

## Parameters

- `$args` (*array*): Array of arguments for `wp_remote_get()` (e.g., `timeout`, `sslverify`).
- `$url` (*string*): The URL being requested.

## Example usage

```php
add_filter( 'bricks/remote_get', function( $args, $url ) {
    // Example: Increase timeout for specific API requests
    if ( strpos( $url, 'api.example.com' ) !== false ) {
        $args['timeout'] = 60;
    }

    return $args;
}, 10, 2 );
```

---


## Filter: bricks/remote_post

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-remote_post/*

Filters the arguments passed to `wp_remote_post()` when Bricks performs a remote POST request (e.g., verifying license, submitting form data to webhook).

## Parameters

- `$args` (*array*): Array of arguments for `wp_remote_post()` (e.g., `body`, `timeout`, `sslverify`).
- `$url` (*string*): The URL being requested.

## Example usage

```php
add_filter( 'bricks/remote_post', function( $args, $url ) {
    // Example: Add custom headers to webhook requests
    if ( strpos( $url, 'webhook.example.com' ) !== false ) {
        $args['headers']['X-Custom-Header'] = 'my-value';
    }

    return $args;
}, 10, 2 );
```

---


## Filter: bricks/render_footer

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-render_footer/*

Filters the rendered HTML of the Bricks footer template. This allows you to wrap the footer in custom markup or modify its output before it is echoed to the page.

## Parameters

- `$footer_html` (*string*): The rendered HTML of the footer.

## Example usage

```php
add_filter( 'bricks/render_footer', function( $footer_html ) {
    // Example: Wrap the footer in a custom container
    return '<div class="custom-footer-wrapper">' . $footer_html . '</div>';
} );
```

---


## Filter: bricks/render_header

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-render_header/*

Filters the rendered HTML of the Bricks header template. This allows you to wrap the header in custom markup or modify its output before it is echoed to the page.

## Parameters

- `$header_html` (*string*): The rendered HTML of the header.

## Example usage

```php
add_filter( 'bricks/render_header', function( $header_html ) {
    // Example: Add a notification bar before the header
    $notification = '<div class="notification-bar">Welcome!</div>';
    
    return $notification . $header_html;
} );
```

---


## Filter: bricks/render_with_bricks

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-render_with_bricks/*

Determines whether a specific post or page should be rendered using Bricks. If this filter returns `false`, Bricks will yield control to the default WordPress template loader or another builder.

## Parameters

- `$render` (*bool|null*): Whether to render with Bricks. Default is `null` (Bricks decides based on settings).
- `$post_id` (*int*): The ID of the post being checked.

## Example usage

```php
add_filter( 'bricks/render_with_bricks', function( $render, $post_id ) {
    // Example: Disable Bricks rendering for posts with a specific meta value
    if ( get_post_meta( $post_id, 'disable_bricks', true ) ) {
        return false;
    }

    return $render;
}, 10, 2 );
```

---


## Filter: bricks/rtl_languages

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-rtl_languages/*

Filters the list of language codes that Bricks considers right-to-left (RTL). This affects the layout direction of the builder interface when a specific locale is active.

## Parameters

- `$languages` (*array*): Array of RTL language codes (e.g., `['ar', 'he', 'fa']`).

## Example usage

```php
add_filter( 'bricks/rtl_languages', function( $languages ) {
    // Add a custom RTL language code
    $languages[] = 'abc';

    return $languages;
} );
```

---


## Filter: bricks/security_check_before_save/new_elements

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-security_check_before_save-new_elements/*

Filters the array of new elements before they are saved to the database, specifically during the security check process (e.g., when validating `{echo:}` tags). This allows you to inspect or modify the element data before it persists.

## Parameters

- `$new_elements` (*array*): Array of new element data structures.
- `$old_elements_indexed` (*array*): Array of existing elements, indexed by their ID, for comparison.

## Example usage

```php
add_filter( 'bricks/security_check_before_save/new_elements', function( $new_elements, $old_elements_indexed ) {
    // Example: Loop through new elements and log changes
    foreach ( $new_elements as $element ) {
        // Custom logic here
    }

    return $new_elements;
}, 10, 2 );
```

---


## Filter: bricks/support_masonry_element

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-support_masonry_element/*

Filters the list of element names that support the Masonry layout option. By default, this includes `section`, `container`, `block`, and `div`.

## Parameters

- `$element_names` (*array*): Array of element names (slugs) that support Masonry.

## Example usage

```php
add_filter( 'bricks/support_masonry_element', function( $element_names ) {
    // Enable Masonry support for a custom element
    $element_names[] = 'my-custom-grid';

    return $element_names;
} );
```

---


## Filter: bricks/svg/allowed_attributes

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-svg-allowed_attributes/*

Filters the list of allowed SVG attributes during sanitization. This is used by the Bricks SVG sanitizer to ensure that uploaded or rendered SVGs do not contain malicious attributes.

## Parameters

- `$attributes` (*array*): Array of allowed SVG attributes.

## Example usage

```php
add_filter( 'bricks/svg/allowed_attributes', function( $attributes ) {
    // Example: Allow 'data-custom' attribute
    $attributes[] = 'data-custom';

    return $attributes;
} );
```

---


## Filter: bricks/svg/allowed_tags

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-svg-allowed_tags/*

Filters the list of allowed SVG tags during sanitization. This is used by the Bricks SVG sanitizer to ensure that uploaded or rendered SVGs do not contain malicious tags.

## Parameters

- `$tags` (*array*): Array of allowed SVG tags.

## Example usage

```php
add_filter( 'bricks/svg/allowed_tags', function( $tags ) {
    // Example: Allow 'foreignObject' tag (use with caution!)
    $tags[] = 'foreignObject';

    return $tags;
} );
```

---


## Filter: bricks/svg/bypass_sanitization

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-svg-bypass_sanitization/*

Determines whether to bypass the SVG sanitization process when uploading SVG files. This can be useful if you need to upload SVGs with complex features (like animations or scripts) that the sanitizer would normally strip out, but it comes with security risks.

## Parameters

- `$bypass` (*bool*): Whether to bypass sanitization. Default is `false`.
- `$file` (*array*): Array containing file information (e.g., `tmp_name`, `type`).

## Example usage

```php
add_filter( 'bricks/svg/bypass_sanitization', function( $bypass, $file ) {
    // Example: Bypass sanitization for trusted users only
    if ( current_user_can( 'administrator' ) ) {
        return true;
    }

    return $bypass;
}, 10, 2 );
```

---


## Filter: bricks/template_preview/supported_content_types

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-template_preview-supported_content_types/*

Filters the list of content types available for selection in the "Populate Content" (Template Preview) setting. This allows you to add custom preview contexts.

## Parameters

- `$types` (*array*): Associative array where keys are the content type IDs and values are their labels.

## Example usage

```php
add_filter( 'bricks/template_preview/supported_content_types', function( $types ) {
    // Example: Add a custom preview type
    $types['my_custom_preview'] = esc_html__( 'My Custom Preview', 'my-plugin' );

    return $types;
} );
```

---


## Filter: bricks/theme_style_name

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-theme_style_name/*

Filters the name of the Theme Style used when generating the CSS file name. This allows you to sanitize or modify the name before it is used in the file system.

## Parameters

- `$name` (*string*): The theme style name.
- `$theme_style` (*array*): The theme style data array.

## Example usage

```php
add_filter( 'bricks/theme_style_name', function( $name, $theme_style ) {
    // Example: Prefix theme style file names
    return 'custom-prefix-' . $name;
}, 10, 2 );
```

---


## Filter: bricks/theme_styles/control_groups

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-theme_styles-control_groups/*

Filters the control groups available in the Theme Styles settings panel. This allows you to add new sections or tabs to organize custom Theme Style controls.

## Parameters

- `$control_groups` (*array*): Associative array of control groups.

## Example usage

```php
add_filter( 'bricks/theme_styles/control_groups', function( $control_groups ) {
    // Add a new control group for 'My Plugin'
    $control_groups['my_plugin'] = [
        'title' => esc_html__( 'My Plugin Settings', 'my-plugin' ),
        'tab'   => 'content', // or 'style'
    ];

    return $control_groups;
} );
```

---


## Filter: bricks/theme_styles/controls

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-theme_styles-controls/*

Filters the individual controls available within the Theme Styles settings. This allows you to add custom fields to existing Theme Style groups or to your own custom groups.

## Parameters

- `$controls` (*array*): Associative array of controls.

## Example usage

```php
add_filter( 'bricks/theme_styles/controls', function( $controls ) {
    // Add a custom color control to the 'colors' group
    $controls['myCustomColor'] = [
        'group' => 'colors', // Target existing group
        'label' => esc_html__( 'My Custom Color', 'my-plugin' ),
        'type'  => 'color',
    ];

    return $controls;
} );
```

---


## Filter: bricks/theme_styles

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-theme_styles/*

Filters the array of Theme Styles loaded from the database. This allows you to modify, add, or remove Theme Styles programmatically.

## Parameters

- `$styles` (*array*): Associative array of Theme Styles, where the key is the style name and the value is an array of style data.

## Example usage

```php
add_filter( 'bricks/theme_styles', function( $styles ) {
    // Example: Add a default property to all theme styles
    foreach ( $styles as $key => $style ) {
        if ( ! isset( $styles[ $key ]['settings']['typography'] ) ) {
            $styles[ $key ]['settings']['typography'] = [ 'font-size' => '16px' ];
        }
    }

    return $styles;
} );
```

---


## Filter: bricks/webhook/timeout

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-webhook-timeout/*

Allows you to modify the timeout duration (in seconds) for webhook requests triggered by the Form element.

## Parameters

- `$timeout` (int): The timeout duration in seconds. Default is `15`.

## Example usage

```php
add_filter( 'bricks/webhook/timeout', function( $timeout ) {
    // Increase timeout to 30 seconds
    return 30;
} );
```

---


## Filter: bricks/woocommerce/cart_proceed_label

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-woocommerce-cart_proceed_label/*

Allows you to modify the text of the "Proceed to checkout" button in the WooCommerce Cart element.

## Parameters

- `$label` (string): The button text. Default is "Proceed to checkout".

## Example usage

```php
add_filter( 'bricks/woocommerce/cart_proceed_label', function( $label ) {
    return 'Go to Checkout';
} );
```

---


## Filter: bricks/woocommerce/products_filters/options

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/bricks-woocommerce-products_filters-options/*

Allows you to modify the options available in the WooCommerce Products Filter element.

## Parameters

- `$options` (array): An array of options, where each option is an associative array with `id` and `name`.
- `$settings` (array): The element settings.

## Example usage

```php
add_filter( 'bricks/woocommerce/products_filters/options', function( $options, $settings ) {
    // Add a custom "All" option to the beginning
    array_unshift( $options, [
        'id'   => 'all',
        'name' => 'All Products',
    ] );

    return $options;
}, 10, 2 );
```

---


## Filter: bricks/active_templates

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-active_templates/*

Modify the templates applied on a page programmatically (`@since 1.8.4`)

This is an alternative to setting an active template via the [bricks/screen_conditions/scores](/developer/hooks/filters/filter-bricks-screen_conditions-scores/) filter.

:::note
Please note that this filter is executed after `bricks/screen_conditions/scores`
:::

## Example: Do not use the Single template if the post has been edited with Bricks {#exclude-default-template-if-post-edit-by-bricks}

In this example, we want to exclude the single post from utilizing a template if it contains Bricks data (Edit with Bricks).

```php
add_filter( 'bricks/active_templates', 'set_my_active_templates', 10, 3 );
function set_my_active_templates( $active_templates, $post_id, $content_type ) {
  // Return if single post $content_type is not 'content'
  if ( $content_type !== 'content' ) {
    return $active_templates;
  }

  // Return: Current post type is not 'post'
  $post_type = get_post_type( $post_id );

  if ( $post_type !== 'post' ) {
    return $active_templates;
  }

  /**
   * $active_templates is an array with different important keys
   *
   * $active_templates['header'] is the header template ID, set it to 0 if do not want to use any template
   * $active_templates['content'] is the content template ID, set it to current post ID if do not want to use any template
   * $active_templates['footer'] is the footer template ID, set it to 0 if do not want to use any template
   *
   * $active_templates['search'] is the search template ID, will only be used if $content_type is 'search'
   * $active_templates['archive'] is the archive template ID, will only be used if $content_type is 'archive'
   * $active_templates['error] is the error template ID, will only be used if $content_type is 'error'
  */

  // Check if the current post has Bricks data, return value is an array
  $bricks_data = \Bricks\Database::get_data( $post_id, 'content' );

  if ( count( $bricks_data ) > 0 ) {
    // Has Bricks data: Don't use any template, set the $active_templates['content'] to current post ID
    $active_templates['content'] = $post_id;

    // To disable header & footer (e.g. landing page) set $active_templates['header'] & $active_templates['footer'] to 0
    $active_templates['header'] = 0;
    $active_templates['footer'] = 0;
  }

  return $active_templates;
}
```

## Example: Change a single template based on a custom field {#single-template-via-custom-field}

There is a scenario like having multiple single templates for a custom post type. Using this filter, you can decide which template to apply based on a custom field.

```php
add_filter( 'bricks/active_templates', 'set_active_templates_by_custom_field', 10, 3 );

function set_active_templates_by_custom_field( $active_templates, $post_id, $content_type ) {
  // Return if single post $content_type is not 'content'
  if ( $content_type !== 'content' ) {
    return $active_templates;
  }

  // Return: Current post type is not 'project'
  $post_type = get_post_type( $post_id );

  if ( $post_type !== 'project' ) {
    return $active_templates;
  }

  // Get the custom field value from Metabox
  $value = absint( rwmb_meta( 'use_template_id' ) );

  // Value not empty: Set $active_templates['content'] to the value
  if ( $value > 0 ) {
    $active_templates['content'] = $value;
    // If single template, the page settings will be used, so no need to set header and footer
  }

  return $active_templates;
}
```

## Example: Disable active template in the builder {#disable-active-template-in-builder}

Since Bricks 1.12, templates applied to a page are now also displayed in the Builder. Previously, only the *Post Content* element was visible, making it difficult to style surrounding elements. If you prefer the old behavior and want to disable the applied template *only inside the builder*, you can use this filter:

```php
add_filter( 'bricks/active_templates', 'disable_template_in_builder', 10, 3 );

function disable_template_in_builder( $active_templates, $post_id, $content_type ) {
  // Only run my logic in the Builder
  if ( bricks_is_builder() ) {
    $active_templates['content'] = 0;
  }

  return $active_templates;
}
```

### Explanation:

- This function runs only when Bricks is in **Builder mode** (`bricks_is_builder()`).
- It prevents the active single template from applying inside the Builder by setting `$active_templates['content'] = 0`.
- The frontend remains unaffected; the template is still used when viewing the post/page normally.
- This effectively disables the new **outer Post Content elements visibility** introduced in **Bricks 1.12**, restoring the previous Builder behavior.

---


## Filter: bricks/allowed_html_tags

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-allowed_html_tags/*

Starting at version `1.10.2` Bricks restricts the allowed HTML tags to the WordPress core logic for `wp_kses_allowed_html( 'post' )`.

This results in the following HTML tags being allowed out-of-the-box:

address, a, abbr, acronym, area, article, aside, audio, b, bdo, big, blockquote, br, button, caption, cite, code, col, colgroup, del, dd, dfn, details, div, dl, dt, em, fieldset, figure, figcaption, font, footer, h1, h2, h3, h4, h5, h6, header, hgroup, hr, i, img, ins, kbd, label, legend, li, main, map, mark, menu, nav, object, p, pre, q, rb, rp, rt, rtc, ruby, s, samp, span, section, small, strike, strong, sub, summary, sup, table, tbody, td, textarea, tfoot, th, thead, title, tr, track, tt, u, ul, ol, var, video

For example, setting the "Custom tag" on a "Block" element to `form` is not allowed by default, and will throw the following error in the builder:

![](imgs/bricks-1.10.3-filter-bricks-allowed-html-tags-c1fe111b75.png)

Using the new filter as shown in the code snippet below, the `form` tag is added to the list of allowed HTML tags and can be used without throwing any errors.

```php

add_filter( 'bricks/allowed_html_tags', function( $allowed_html_tags ) {
    // Define the additional tags to be added (e.g. 'form' & 'select')
    $additional_tags = ['form', 'select'];

    // Merge additional tags with the existing allowed tags
    return array_merge( $allowed_html_tags, $additional_tags );
} );
```

:::note
**Only allow HTML tags that are considered safe, as anyone with builder access can use them!**
:::

---


## Filter: bricks//assets/generate_css_from_element

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-assets-generate_css_from_element/*

This filter allows you to include your custom query loop supported element to generate the children styles in Bricks. (@since 1.9.2)

```php
add_filter( 'bricks/assets/generate_css_from_element', function( $element_name, $current_element, $css_type ) {
  // $css_type is a string (e.g. header, footer, content, etc.)
  // Add your custom element name so the looping children styles are generated.
  if ( ! in_array( 'my-custom-element-name', $element_name ) ) {
    $element_name[] = 'my-custom-element-name';
  }

  return $element_name;
}, 10, 3 );
```

---


## Filter: bricks//assets/load_webfonts

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-assets-load_webfonts/*

Bricks 1.4 introduces the possibility to "Disable Google Fonts". Either via the Bricks settings under "Performance" or programmatically using the filter as explained below:



![](imgs/bricks-1.4-disable-google-fonts-setting-1024x944-5d9bd72ef5.png)

<figcaption>

Bricks > Settings > Performance: Disable Google Fonts

</figcaption>



With the filter `bricks/assets/load_webfonts` you'll be able to prevent Google Fonts to load in the frontend by returning `false`:

```php
// Prevent Google Fonts loading
add_filter( 'bricks/assets/load_webfonts', '__return_false' );
```

If you use this filter to remove the embed of Google Fonts but you still like to use Google Fonts, just head to the [Google Fonts website](https://fonts.google.com/) and download the fonts you need. Then, add them manually to your website, using the [Custom Fonts](/builder/styling/custom-fonts/) screen.

---


## Filter: bricks/auth/custom_login_redirect

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-auth-custom_login_redirect/*

This filter allows customization of the redirect page ID for the login page.

## Example Usage:

```php
add_filter( 'bricks/auth/custom_login_redirect', function( $selected_login_page_id ) {
    return /* New login page ID */;
});
```

**Parameters:**

- `$selected_login_page_id` (int|false): The ID of the custom login page if set; otherwise, `false`.

**Return:**

- (int|false): The custom page ID for login redirection, or `false` if no custom page is designated.

---


## Filter: bricks/auth/custom_lost_password_redirect

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-auth-custom_lost_password_redirect/*

This filter enables the modification of the redirect page ID for the lost password page.

## Example Usage:

```php
add_filter( 'bricks/auth/custom_lost_password_redirect', function( $selected_lost_password_page_id ) {
    return /* New lost password page ID */;
});
```

**Parameters:**

- `$selected_lost_password_page_id` (int|false): The ID of the custom lost password page if set, otherwise `false`.

**Return:**

- (int|false): The new custom lost password page ID or `false` to indicate no custom page is set.

---


## Filter: bricks/auth/custom_redirect_url

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-auth-custom_redirect_url/*

This filter is distinct from other authentication-related filters in that it provides a broad scope for customizing redirections during authentication processes. Unlike specific filters for [login](/developer/hooks/filters/filter-bricks-auth-custom_login_redirect/), [registration](/developer/hooks/filters/filter-bricks-auth-custom_registration_redirect/), [lost password](/developer/hooks/filters/filter-bricks-auth-custom_lost_password_redirect/), or [reset password pages](/developer/hooks/filters/filter-bricks-auth-custom_reset_password_redirect/), this filter applies to any authentication-related URL.

**Functionality:**

This filter allows overriding the default redirect URL based on custom conditions across various authentication scenarios. It offers flexibility to redirect users to different pages depending on the context or specific requirements of the authentication process.

## Example Usage:

```php
add_filter( 'bricks/auth/custom_redirect_url', function( $custom_redirect_url, $current_url_path ) {
    if ( /* custom condition based on $current_url_path */ ) {
        return 'https://example.com/custom-redirect';
    }
    return $custom_redirect_url;
}, 10, 2 );
```

In this example, the redirection URL changes based on the current URL path, allowing for a dynamic and contextual redirection strategy.

**Parameters:**

- `$custom_redirect_url` (string|null): The initial redirect URL.
- `$current_url_path` (string): The current URL path being accessed.

**Return:**

- (string|null): The URL to redirect to, or null to follow default logic.

---


## Filter: bricks/auth/custom_registration_redirect

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-auth-custom_registration_redirect/*

This filter allows for the customization of the redirect page ID for the registration page.

## Example Usage:

```php
add_filter( 'bricks/auth/custom_registration_redirect', function( $selected_registration_page_id ) {
    return /* New registration page ID */;
});
```

**Parameters:**

- `$selected_registration_page_id` (int|false): The ID of the custom registration page if set; otherwise, `false`.

**Return:**

- (int|false): The custom page ID for registration redirection, or `false` if no custom page is set.

---


## Filter: bricks/auth/custom_reset_password_redirect

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-auth-custom_reset_password_redirect/*

This filter provides a way to change the redirect page ID for the reset password page.

## Example Usage:

```php
add_filter( 'bricks/auth/custom_reset_password_redirect', function( $selected_reset_password_page_id ) {
    return /* New reset password page ID */;
});
```

**Parameters:**

- `$selected_reset_password_page_id` (int|false): The ID of the custom reset password page if set; otherwise, `false`.

**Return:**

- (int|false): The custom page ID for reset password redirection, or `false` if no custom page is specified.

---


## Filter: bricks/body/attributes

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-body-attributes/*

Filter to add HTML attributes to the `body` tag (@since 1.5).

```php
add_filter( 'bricks/body/attributes', function( $attributes ) {
  // Add 'data-is-body' HTML attribute to footer with value 'y'
  $attributes['data-is-body'] = 'y';

  return $attributes;
} );
```

---


## Filter: bricks/builder/codemirror_config

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-builder-codemirror_config/*

Use this filter to customize the configuration of CodeMirror 5, the code editor used within the builder. CodeMirror 5 is used in areas such as the **Custom CSS** setting for elements and the **Code element** settings, where it provides an interface for editing HTML, CSS, JavaScript, PHP, and more.

You can refer to the [CodeMirror 5 configuration documentation](https://codemirror.net/5/doc/manual.html#config) for more details on available options.

## Example Usage:

```php
add_filter( 'bricks/builder/codemirror_config', function( $config ) {
    // Disable auto-close brackets
    $config['autoCloseBrackets'] = false;

    // Disable line numbers
    $config['lineNumbers'] = false;

    // Override default tab size
    $config['tabSize'] = 4;

    return $config;
});
```

In this example, the filter modifies the default CodeMirror configuration to:

- Disable **auto-close brackets**.
- Disable **line numbers**.
- Set the **tab size** to 4 spaces.

**Parameters:**

- `$config` *(array)*: An empty array by default. Define only the specific configurations you need, which will override the builder's default settings.

**Return:**

- *(array)*: The custom configuration array, applied alongside or in place of Bricks' defaults.

---


## Filter: bricks/builder/elements

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-builder-elements/*

Determine which elements to use in Bricks by out-commenting the ones you don't want to use. There is a full example and list of all elements in the Bricks child theme that you can customize to your requirements.

```php
add_filter( 'bricks/builder/elements', function( $elements ) {
  // See Bricks child theme for a full list of all available elements
  // var_dump( $elements ); // To see all available elements

  return $elements;
} );
```

---


## Filter: bricks/builder/image_size_options

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-builder-image_size_options/*

The `bricks/builder/image_sizes` hook gives developers the ability to customize image size options in the builder.

By default, when working within a query loop and using dynamic data for image sources, Bricks Builder displays all the registered WordPress image sizes.

This hook allows you to modify this list if you know that certain sizes are not being used, helping you streamline your image size options to fit your needs.

```php
/**
 * $image_sizes Multidimensional array (key: image size name)
 */
add_filter( 'bricks/builder/image_size_options', function( $image_sizes ) {
  // Unset thumbnail, 1536x1536, 2048x2048
  unset( $image_sizes['thumbnail'] );
  unset( $image_sizes['1536x1536'] );
  unset( $image_sizes['2048x2048'] );

  return $image_sizes;
});
```

---


## Filter: bricks/builder/map_styles

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-builder-mapstyles/*

This filter allows you to define your own custom map styles for the **Map** element.

The example below shows how we added a custom map style from
[https://snazzymaps.com/style/38/shades-of-grey](https://snazzymaps.com/style/38/shades-of-grey) to the builder.

The best resource for professional predefined map styles is available under
[https://snazzymaps.com/explore](https://snazzymaps.com/explore). Open any map style and copy&paste the code under "JAVASCRIPT STYLE ARRAY" as shown in the example below.

```php
add_filter( 'bricks/builder/map_styles', function( $map_styles ) {
  // Example: Custom map style from: https://snazzymaps.com/style/38/shades-of-grey
  $map_styles['shadesOfGrey'] = [
    'label' => esc_html__( 'Shades of grey', 'bricks' ),
    'style' => '[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "saturation": 36 }, { "color": "#000000" }, { "lightness": 40 } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "visibility": "on" }, { "color": "#000000" }, { "lightness": 16 } ] }, { "featureType": "all", "elementType": "labels.icon", "stylers": [ { "visibility": "off" } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" }, { "lightness": 20 } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 17 }, { "weight": 1.2 } ] }, { "featureType": "landscape", "elementType": "geometry", "stylers": [ { "color": "#000000" }, { "lightness": 20 } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#000000" }, { "lightness": 21 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" }, { "lightness": 17 } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 29 }, { "weight": 0.2 } ] }, { "featureType": "road.arterial", "elementType": "geometry", "stylers": [ { "color": "#000000" }, { "lightness": 18 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" }, { "lightness": 16 } ] }, { "featureType": "transit", "elementType": "geometry", "stylers": [ { "color": "#000000" }, { "lightness": 19 } ] }, { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#000000" }, { "lightness": 17 } ] } ]'
];

  return $map_styles;
} );
```

---


## Filter: bricks/code/allow_execution

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-code-allow_execution/*

An alternative to the **Disable code execution** setting under `Bricks > Settings > Builder Access`. You can use this PHP filter to disable/enable code execution programmatically.

![](imgs/disallow-code-execution-hook-7b8e256689.png)

```php
add_filter( 'bricks/code/allow_execution', function( $allow ) {
  // Only allows to return false to disable code execution programmatically
  return false;
} );
```

---


## Filter: bricks/code/disable_execution

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-code-disable_execution/*

This PHP filter allows you to disable code execution within the Bricks builder programmatically.

It takes precedence over the [`bricks/code/allow_execution`](/developer/hooks/filters/filter-bricks-code-allow_execution/) filter and any settings configured in `Bricks > Settings > Custom code > Code execution`.

```php
add_filter( 'bricks/code/disable_execution', function( $disable ) {
  // Returning true disables code execution programmatically
  return true;
} );
```

Use this filter to enforce stricter security by disabling code execution, regardless of other configurations on your site.

---


## Filter: bricks/code/disallow_keywords

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-code-disallow_keywords/*

This filter introduces another level of security when using the Code element to run code.

With the filter `bricks/code/disallow_keywords` you'll be able to prevent the code execution if specific keywords are found in the code, thus reducing the risk of using this element. To add keywords to this check, use the following example:

```php
add_filter( 'bricks/code/disallow_keywords', function( $keywords ) {
  $</meta>keywords[] = 'wpdb';

  return $</meta>keywords;
} );
```

---


## Filter: bricks/code/echo_function_names

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-code-echo_function_names/*

:::note
Starting at Bricks 1.9.7, you must explicitly allow any function names you want to call via Bricks' dynamic data echo tag using the new bricks/code/echo_function_names filter. You can add this to your Bricks child theme or the code snippet plugin of your choice.
:::

```php
add_filter( 'bricks/code/echo_function_names', function() {
  return [
    'my_custom_function',
    'another_custom_function',
  ];
} );
```

To use echo functions, you must first enable “Code execution” for the appropriate user role or user in your WordPress dashboard under “Bricks – Settings – Custom code” (see the screenshot below).



![](imgs/bricks-builder-code-execution-1024x803-04ea3793e3.png)

<figcaption>

Code Execution: Enabled for user role "Administrator"

</figcaption>



Make sure to only enable code execution for users & user roles you trust 100%.

You can get a list of all functions on your site called through the `echo` tag as part of the "Code review" results. Here's how:

1. Go to `Bricks > Settings > Custom code`
2. Click the "Start: Code review" button
3. Once finished, select "Echo tags" from the dropdown.
4. Copy the code snippet under "Echo: Function names" and paste it into the `functions.php` file of your Bricks child name. Make sure to remove any unknown or unwanted function names from the array.

![](imgs/bricks-code-review-echo-function-names-ad5c404f25.png)

## Using patterns (regex) to simplify echo function calls {#patterns}

Bricks 1.9.8 offers greater flexibility when it comes to echo function calls.

While you can still return an array with the exact function names, you can also return an array that contains specific regex checks. We identify those regex calls by the `@` prefix.

If your function name matches any of those regex checks, it can be called through the `echo` tag.

**Example: Allow calling any functions that start with `brx_`:**

```php
add_filter( 'bricks/code/echo_function_names', function($function_name) {
  return [
    '@^brx_', // Allow all functions that start with "brx_"
  ];
} );
```

## Check function names against your own custom logic

Instead of returning an array, you can also perform any custom check against the function name itself or any other logic you want to run. The filter receives the function name (`$function_name`) as an argument to assist in making more dynamic decisions. Returning a boolean (`true` or `false`)

**Example: Allow function execution based on function name prefix**

```php
add_filter('bricks/code/echo_function_names', function($function_name) {
  // Only allow functions that start with "custom_"
  return strpos($function_name, 'custom_') === 0;
});
```

This example uses a straightforward check to determine if the function starts with `custom_`. If so, it returns `true`, allowing the function to be executed; otherwise, it returns `false`.

**Example: Run any function when development mode is enabled**

```php
add_filter( 'bricks/code/echo_function_names', function($function_name) {
  return defined( 'WP_DEVELOPMENT_MODE' ) ? WP_DEVELOPMENT_MODE : false;
} );
```

The [`WP_DEVELOPMENT_MODE`](https://make.wordpress.org/core/2023/07/14/configuring-development-mode-in-6-3/) PHP constant has been available in WordPress core since version 6.3. We use it just as an example. You can use any custom PHP constant of your choice by defining it in your child theme's functions.php file.

**Example: Run function if the current user can edit posts**

```php
add_filter( 'bricks/code/echo_function_names', function($function_name) {
  return current_user_can( 'edit_posts' );
} );
```

---


## Filter: bricks/comments/timestamp

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-comments-timestamp/*

When using the Bricks Post Comments element, the comment default timestamp text will show the time difference since it was published in a human-readable format such as "1 hour ago" or "2 days ago".

Since Bricks 1.5.1, you'll be able to customize the comment timestamp text, like so:

```php
add_filter( 'bricks/comments/timestamp', function( $timestamp, $comment ) {
  // Return the WordPress default comment timestamp
  return sprintf( __( '%1$s at %2$s' ),
    get_comment_date( '', $comment ),
    get_comment_time()
  );
}, 10, 2 );
```

---


## Filter: bricks/content/attributes

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-content-attributes/*

Programmatically add HTML attributes to the `main` tag.

```php
add_filter( 'bricks/content/attributes', function( $attributes ) {
  // Add 'data-is-content' HTML attribute to main with value 'y'
  $attributes['data-is-content'] = 'y';
  return $attributes;
} );
```

- [/developer/hooks/filters/filter-bricks-header-attributes/](/developer/hooks/filters/filter-bricks-header-attributes/)
- [/developer/hooks/filters/filter-bricks-header-attributes/](/developer/hooks/filters/filter-bricks-header-attributes/)

---


## Filter: bricks/content/html_after_begin

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-content-html_after_begin/*

Available since version 1.6, this filter allows you to customize or insert HTML strings after `main` tag, before rendering bricks data.

```php
add_filter( 'bricks/content/html_after_begin', function( $html_after_begin, $bricks_data, $attributes, $tag ) {

    if ( $tag !== 'main' ) {
      return $html_after_begin;
    }

    // Insert custom div after the main tag
    $my_additional_html = '<div class="my_notification">This is my notification</div>';

    return $html_after_begin . $my_additional_html;
}, 10, 4 );
```

---


## Filter: bricks/content/html_before_end

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-content-html_before_end/*

Available since version 1.6, this filter allows you to customize or insert HTML strings before closing `main` tag.

```php
add_filter( 'bricks/content/html_before_end', function( $html_after_begin, $bricks_data, $attributes, $tag ) {

    if ( $tag !== 'main' ) {
      return $html_after_begin;
    }

    // Insert custom popup HTML
    $my_popup_html = '<div class="my_popup">This is my popup</div>';

    return $html_after_begin . $my_popup_html;
}, 10, 4 );
```

---


## Filter: bricks/content/tag

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-content-tag/*

The `bricks/content/tag` (@since 1.11.1) filter lets you set the HTML tag for the `#brx-content` node that your Bricks content data is wrapped in.

Make sure the HTML tag you return is an [allowed HTML tag](/developer/hooks/filters/filter-bricks-allowed_html_tags/).

## Example Usage:

```php
add_filter( 'bricks/content/tag', function( $tag ) {
    // Set #brx-content tag to 'div' (default: main)
    return 'div';
} );
```

**Parameters:**

- `$tag` (string): The default HTML tag, which is `main`.

**Return:**

- (string): The HTML tag you want to render instead of the default.

---


## Filter: bricks/default_page_title

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-default_page_title/*

Since 1.8, Bricks automatically adds default page titles to all non-Bricks pages. However, if you wish to customize or remove this default page title, you can utilize this filter.

Returning an empty string, disables the default page title.

```php
add_filter( 'bricks/default_page_title', function( $title, $post_id ) {
  // If slug of current page is 'my-page': Return empty page title
  if ( is_page( 'my-page' ) ) {
    $title = '';
  }

  return $title;
}, 10, 2 );
```

---


## Filter: bricks/dynamic_data/exclude_tags

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-dynamic_data-exclude_tags/*

Dynamic data tags are strings with a special syntax wrapped by curly brackets. Sometimes this syntax has conflicts with other plugins which cause a specific tag to be removed by the content.

Since Bricks 1.3.5 it is possible to exclude a list of tags from the Bricks dynamic data logic using the following PHP snippet in your `functions.php` file:

```php
add_filter( 'bricks/dynamic_data/exclude_tags', function( $tags ) {
    return [
        'my_specific_tag',
        'my_other_specific_tag'
    ];
});
```

Adding this code to your child theme will prevent Bricks from replacing these tags with an empty string.

---


## Filter: bricks/dynamic_data/post_terms_links

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-dynamic_data-post_terms_links/*

When rendering the terms assigned to a post using the dynamic data tag `{post_terms_my_taxonomy}`, Bricks wraps each term with a link to the term archive page. To disable this default behavior, you may hook into the `bricks/dynamic_data/post_terms_links` filter, like so:

```php
// Disable links for all the {post_terms_my_taxonomy} tags
add_filter( 'bricks/dynamic_data/post_terms_links', '__return_false' );
```

or, for a specific taxonomy:

```php
add_filter( 'bricks/dynamic_data/post_terms_links', function( $has_links, $post, $taxonomy) {
  // Disable links for my_custom_tax taxonomy
  return $taxonomy !== 'my_custom_tax';
}, 10, 3);
```

---


## Filter: bricks/dynamic_data/post_terms_separator

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-dynamic_data-post_terms_separator/*

Programmatically set the post term separator like so:

```php
add_filter( 'bricks/dynamic_data/post_terms_separator', function( $sep, $post, $taxonomy ) {
  return ' : ';
}, 10, 3 );
```

---


## Filter: bricks/dynamic_data/read_more

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-dynamic_data-read_more/*

If you use the dynamic data tag `{read_more}` you'll get an anchor tag (link) to the post with the label "Read more" by default. To change this label use the following code:

```php
add_filter( 'bricks/dynamic_data/read_more', function( $label, $post ) {
   return 'My New Label';
}, 10, 2 );
```

Read more about [Dynamic Data](/builder/dynamic-content/dynamic-data/) in the Bricks academy.

---


## Filter: bricks/dynamic_data/replace_nonexistent_tags

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-dynamic_data-replace_nonexistent_tags/*

Dynamic data tags are strings with a special syntax wrapped by curly brackets. Sometimes this syntax has conflicts with other plugins (e.g. Fluent Forms) or with the content itself (e.g. mathematical equations).

From Bricks 1.4 onwards, the default Bricks logic is to keep the nonexistent tags (they won't be replaced by an empty string anymore). It is possible to switch off the default Bricks behavior and tell Bricks to replace the nonexistent dynamic data tags with an empty string.

To replace nonexistent tags add the following PHP snippet to your `functions.php` file:

```php
add_filter( 'bricks/dynamic_data/replace_nonexistent_tags', '__return_true', 10, 1 );
```

:::note
Note: Bricks 1.3.5 introduced the possibility to toggle this behavior, but by default Bricks was replacing the tags. Bricks 1.4 changed the default action.
:::

---


## Filter: bricks/element/render

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-element-render/*

Bricks 1.5 introduces the new `bricks/element/render` filter. This filter enables you to implement your own conditional display logic programmatically.

This is ideal for restricting premium content to certain users, etc.

If the condition inside this filter is not met (i.e. it returns `false`), then the element won't be rendered on the frontend.

```php
add_filter( 'bricks/element/render', function( $render, $element ) {
  // Conditional display logic goes here:
  // $render = true to render the element
  // $render = false to skip the element render

  return $render;
}, 10, 2 );
```

:::note
Bricks introduced [Element Conditions](/builder/features/element-conditions/) in 1.5.4. Use this PHP filter for a more complicated scenario.
:::

## Example 1: Output a specific element if the visitor is logged-in {#example-1}



![](imgs/Screenshot-2022-07-01-at-15.28.15-ed38461753.png)

<figcaption>

The 6-character element ID is the last part of the default HTML ID (after the dash).

</figcaption>



In the following example, we check if the element has a specific element ID, and if so, we allow the element to be rendered based on the logged-in/out condition.

```php
add_filter( 'bricks/element/render', function( $render, $element ) {
  // Render element ID "mlttpx" if user is logged in
  if ( $element->id === 'mlttpx' ) {
    return is_user_logged_in();
  }

  return $render;
}, 10, 2 );
```

## Example 2: Don't output elements with a specific custom CSS class for users with a subscriber role {#example-2}

The following example will render an element if it contains the custom CSS class `hide-for-subscribers`, if the user is logged in and is not a subscriber.

You may select different [users' capabilities](https://wordpress.org/support/article/roles-and-capabilities/) according to your needs.

```php
add_filter( 'bricks/element/render', function( $render, $element ) {
  // Get the element CSS classes
  $classes = ! empty( $element->attributes['_root']['class'] ) ? $element->attributes['_root']['class'] : false;

  // Check if the element has the special class "hide-for-subscribers"
  if ( $classes && in_array( 'hide-for-subscribers', $classes ) ) {
    return current_user_can( 'edit_posts' );
  }

  return $render;
}, 10, 2 );
```

## Example 3: Output elements for a specific post category {#example-3}

The following example will render a specific element based on the HTML ID on a single post page with a specific category:

```php
add_filter( 'bricks/element/render', function( $render, $element ) {
  // Check if this is a single post page
  if ( ! is_single() ) {
    return $render;
  }

  // Get the element custom HTML ID
  $html_id = isset( $element->settings['_cssId'] ) ? $element->settings['_cssId'] : false;

  // Check if the element has the HTML ID "project-award"
  if ( $html_id && $html_id === 'project-award' ) {
    return has_category( 'projects' );
  }

  return $render;
}, 10, 2 );
```

## Example 4: Output elements having a class of "logged-in" to logged-in users and elements having a class of "logged-out" to non logged-in visitors

The following example renders elements that have a class of `logged-in` only to users that are logged in and elements that have a class of `logged-out` only to users that are logged out:

```php
add_filter( 'bricks/element/render', function( $render, $element ) {
  // Get the element CSS classes
  $classes = ! empty( $element->attributes['_root']['class'] ) ? $element->attributes['_root']['class'] : false;

  // Check if the element has the special class "logged-in"
  if ( $classes && in_array( 'logged-in', $classes ) ) {
  return is_user_logged_in();
  }

  // Check if the element has the special class "logged-out"
  if ( $classes && in_array( 'logged-out', $classes ) ) {
  return ! is_user_logged_in();
  }

  return $render;
}, 10, 2 );
```

## Example 5: Output an element having a specific HTML ID based on value of a custom field

The following example renders an element that has the specified HTML ID based on the value of a specific custom field of the current post when viewing a singular page:

```php
// Render an element with "project-award" HTML ID if the specified condition is true.
// Condition: The value of a custom field "dont_output_project_award" is false.
add_filter( 'bricks/element/render', function( $render, $element ) {
  // Check if this is a singular page
  if ( ! is_singular() ) {
    return $render;
  }

  // Get the element custom HTML ID
  $html_id = isset( $element->settings['_cssId'] ) ? $element->settings['_cssId'] : false;

  // Check if the element has the HTML ID "project-award"
  if ( $html_id && $html_id === 'project-award' ) {
    return ! get_post_meta( $element->post_id, 'dont_output_project_award', true );
  }

  return $render;
}, 10, 2 );
```

The examples above are really just to illustrate a few simple use cases. Anything that you can check with PHP is possible to include in your own conditional display logic using this new `bricks/element/render` filter.

## Example 6: Output an element in ACF Repeater if the sub field is not empty

Scenario:

ACF Repeater: FAQs

Sub fields: Question, Answer, Button Text and Button URL

Requirement: When Query Loop's query type is set to this ACF Repeater, output a Button (a child element of the repeating element) only in the rows that have a value set for the Button Text sub field.

```php
// Output one or more instances of the specified element (inside a query loop of ACF Repeater type) when the condition is true.
// Condition: The specified sub field inside the specified ACF Repeater field is not empty.
add_filter( 'bricks/element/render', function( $render, $element ) {
  if ( $element->id === 'huciku' && class_exists( 'ACF' ) ) {
    if ( have_rows( 'faqs' ) ) {
      // Loop through rows.
      while( have_rows( 'faqs' ) ) : the_row();
        return get_sub_field( 'button_text' );
      // End loop.
      endwhile;
    }
  }

  return $render;
}, 10, 2 );
```

where `huciku` is the element ID of the Button.

Note: This will be applied as `brxe-huciku` class in the output in this case, not a ID.

Also, replace `faqs` and `button_text` strings as applicable.

---


## Filter: bricks/element/render_attributes

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-element-render_attributes/*

Starting with Bricks 1.3.7 you may manipulate the HTML** **attributes of a given element using the following filter:

```php
add_filter( 'bricks/element/render_attributes', function( $attributes, $key, $element ) {
    if ( isset( $element->settings['my_setting'] )
       && $element->settings['my_setting'] == 'xpto' ) {
        $attributes[ $key ]['data-xpto'] = 'my data';
    }

    return $attributes;
}, 10, 3 );
```

The filter callback receives 3 arguments:

- `$attributes` - an associative array of the element attributes, grouped by the $key identifier
- `$key` - the HTML element identifier to render attributes for
- `$element` - the Bricks element object (since Bricks 1.5)

Since Bricks 1.4, if you need to get access to the `$is_frontend` value (whether the element is rendering in the frontend or in the builder), please use the global function `bricks_is_frontend()`.

Since Bricks 1.5, the `$settings` and `$name` arguments are deprecated. You may use the callback 3rd argument to get those: `$element->settings` and `$element->name`.

---


## Filter: bricks/element/settings

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-element-settings/*

Bricks 1.5 adds the possibility to change the element settings before it is rendered.

This allows you to change a text element content programmatically, or add styles based on a custom conditional logic, like so:

```php
add_filter( 'bricks/element/settings', function( $settings, $element ) {
    // Add "[online]" text to all the headings elements if the visitor is logged in
    if ( $element->name === 'heading' && is_user_logged_in() ) {
        $settings['text'] .= ' [online]';
    }

    return $settings;
}, 10, 2 );
```

In case you need to programmatically add an element conditional display logic, check the filter [`bricks/element/render`](/developer/hooks/filters/filter-bricks-element-render/).



##### Example: Dynamically set WooCommerce Product Filter (Price) max price from all products

![](imgs/bricks-products-filter-max-price-from-all-products-b96e42abb0.png)

```php
add_filter('bricks/element/settings', function( $settings, $element ) {
  // Change the zyjhwa to your element ID
  if( $element->id !== 'zyjhwa' || ! isset( $settings['filters'] ) ) {
    return $settings;
  }

  // Get all products
  $products = wc_get_products(array(
    'status' => 'publish',
    'limit' => -1, // Retrieve all products
  ));

  $highest_price = max(array_map(function ($product) {
    return $product->get_price();
  }, $products));

  foreach( $settings['filters'] as $key => $filter ) {
    if( ! isset( $filter['otherFilter'] ) || $filter['otherFilter'] !== 'price' ) {
      continue;
    }

    $settings['filters'][$key]['sliderMax'] = $highest_price;
  }

  return $settings;
}, 10, 2);
```

---


## Filter: bricks/elements/{element_name}/control_groups

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-elements-element_name-control_groups/*

Since Bricks 1.4 it is possible to add custom control groups to a specific element like so:

```php
add_filter( 'bricks/elements/heading/control_groups', function( $control_groups ) {
    $control_groups['custom_controls'] = [
        'tab'      => 'content', // or 'style'
        'title'    => esc_html__( 'Custom controls', 'my_plugin' ),
    ];

    return $control_groups;
} );
```

Note: the above example adds a new control group with the title "**Custom controls**" to the **heading** element, using the filter `bricks/elements/**heading**/control_groups`. To learn about other Bricks controls visit the [Topic: Controls](https://academy.bricksbuilder.io/topic/controls/).

---


## Filter: bricks/elements/&#123;element_name&#125;/controls

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-elements-element_name-controls/*

Since Bricks 1.3.2 it is possible to add custom controls to any element like so:

```php
add_filter( 'bricks/elements/posts/controls', function( $controls ) {
    $controls['ignoreStickyPosts'] = [
        'tab'      => 'content',
        'group'    => 'query',
        'label'    => esc_html__( 'Ignore Sticky Posts', 'my_plugin' ),
        'type'     => 'checkbox'
    ];

    return $controls;
} );
```

Note: the above example adds a new checkbox to the **posts** element, using the filter `bricks/elements/**posts**/controls`. To learn about other Bricks controls visit the [Topic: Controls](https://academy.bricksbuilder.io/topic/controls/).

You might also be interested in the filter [`bricks/posts/query_vars`](/developer/hooks/filters/filter-bricks-posts-query_vars/) to manipulate the posts element query.

---


## Filter: bricks/filter_element/populated_options

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-filter_element-populated_options/*

The` bricks/filter_element/populated_options` PHP filter allows you to modify the populated options of **Filter - Select**, **Filter - Radio**, and **Filter - Checkbox** elements **before** they are rendered into HTML. `(@since 2.0.2)`

This is useful if you want to:

- Add/remove certain options
- Reorder options (based on complicated custom requirement)
- Change display text or values

### Example:

The following example removes the "biography" option from a filter element with the ID `uzehuy`:

```php
/**
 * $options is an array of options that are populated by the element
 * 'value' is the value of the option
 * 'text' is the display text of the option
 * 'is_all' exists and is true if the option is the "All" option
 * 'is_placeholder' exist and is true if the option is a placeholder option
 */
add_filter( 'bricks/filter_element/populated_options', function( $options, $element ) {
  if ( $element->id === 'uzehuy' ) {
    // Remove the options that value is 'biography'
    $options = array_filter( $options, function( $option ) {
      return $option['value'] !== 'biography';
    } );
  }

  return $options;
}, 10, 2 );
```

---


## Filter: bricks/footer/attributes

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-footer-attributes/*

Programmatically add HTML attributes to the `footer` tag.

```php
add_filter( 'bricks/footer/attributes', function( $attributes ) {
  // Add 'data-is-footer' HTML attribute to footer with value 'y'
  $attributes['data-is-footer'] = 'y';

  return $attributes;
} );
```

- [/developer/hooks/filters/filter-bricks-header-attributes/](/developer/hooks/filters/filter-bricks-header-attributes/)
- [/developer/hooks/filters/filter-bricks-content-attributes/](/developer/hooks/filters/filter-bricks-content-attributes/)

---


## Filter: bricks/form/action/{form_action}

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-form-action-form_action/*

The `bricks/form/action/{form_action}` filter is triggered when a custom action (one that is not reserved by Bricks) is selected in a form. It allows developers to define custom logic for handling such actions dynamically.

Bricks provides several reserved actions out of the box, including:

- **email**
- **redirect**
- **mailchimp**
- **sendgrid**
- **login**
- **registration**
- **lost-password**
- **reset-password**
- **custom**

If the user's selected action is not in this list, the `bricks/form/action/{form_action}` filter is triggered.

## Example usage

Here’s how you can handle a custom action called `slack-notification`:

```php
// Handle the Slack notification action
add_action(
    'bricks/form/action/slack-notification',
    function ( $form ) {
        $settings = $form->get_settings();
        $fields   = $form->get_fields();

        // Implement Slack notification logic
    }
);
```

## Parameters:

- **`$form` (\Bricks\Integrations\Form\Init)**: The current form instance, providing access to settings and submitted fields.

---


## Filter: bricks/form/create_post/meta_value

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-form-create_post-meta_value/*

This filter is used within the [Create post](/builder/features/create-update-posts-on-the-frontend/) form action in Bricks.

It allows developers to alter the meta values of new posts created from form submissions before they are saved to the database.

**Functionality:**

This filter activates during the execution of the 'Create Post' action. It provides an opportunity to modify the meta values based on custom logic or specific project requirements. This can include data formatting, validation, files handling, or applying conditional transformations to the meta values.

**Example Usage:**

```php
add_filter(
	'bricks/form/create_post/meta_value',
	function( $meta_value, $meta_key, $form_settings, $form_fields ) {
		if ( $meta_key === 'my_meta_key' ) {
			// Custom logic for 'my_meta_key'
			$meta_value = transform_meta_value( $meta_value );
		}
		// Additional custom logic can be implemented here
		return $meta_value;
	},
	10,
	4
);
```

In this example, the filter modifies the value of the meta key 'my_meta_key' using a custom function `transform_meta_value`.

**Parameters:**

- `$meta_value` (mixed): The original value of the meta field.
- `$meta_key` (string): The key of the meta field being modified.
- `$form_settings` (array): The settings of the form from which the post is created.
- `$form_fields` (array): The form fields data.

**Return:**

- (mixed): The modified value of the meta field, which will be saved with the post.

---


## Filter: bricks/form/update_post/meta_value

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-form-update_post-meta_value/*

This filter is part of the [**Update post**](/builder/features/create-update-posts-on-the-frontend/) form action in Bricks.

It enables developers to customize the meta values of existing posts being updated through form submissions.

**Functionality:**

The `bricks/form/update_post/meta_value` filter is triggered within the 'Update post' action when a post is being updated from a form submission. It allows for altering the meta values based on custom logic or project-specific needs. This includes formatting data, validating content, handling file uploads, or applying conditional transformations to the meta values.

**Example Usage:**

```php
add_filter(
	'bricks/form/update_post/meta_value',
	function( $meta_value, $meta_key, $post_id, $form_fields ) {
		if ( $meta_key === 'specific_meta_key' ) {
			// Custom logic for 'specific_meta_key'
			$meta_value = modify_meta_value( $meta_value );
		}
		// Implement additional custom logic here
		return $meta_value;
	},
	10,
	4
);
```

In this example, the filter modifies the value of a specific meta key ('specific_meta_key') using a custom function `modify_meta_value`.

**Parameters:**

- `$meta_value` (mixed): The original value of the meta field.
- `$meta_key` (string): The key of the meta field being modified.
- `$post_id` (int): The ID of the post being updated.
- `$form_fields` (array): The form fields data.

**Return:**

- (mixed): The modified value of the meta field, which will be updated in the post's meta data.

---


## Filter: bricks/frontend/render_data

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-frontend-render_data/*

The filter allows you to modify the rendered content for different areas like header, content, and footer before it's displayed on the frontend.

```php
add_filter( 'bricks/frontend/render_data', function( $content, $post, $area ) {
  // Do something

  return $content;
}, 10, 3 );
```

The filter callback receives three parameters:

- `$content`: The HTML content that's about to be returned. It's a string type.
- `$post`: The post object for which the content is being generated. It's an instance of the WP_Post class.
- `$area`: A string defining the area of the page currently being rendered (e.g., 'header', 'content', 'footer'). Available since version 1.5.4.

## Example: Add a unique ID to each heading

The following example demonstrates how to add a unique ID attribute to each heading in the generated content.

```php
add_filter('bricks/frontend/render_data', function($content, $post, $area) {
  // Iterate over each heading tag
  $content = preg_replace_callback(
    '/(<h[1-6](.*?))>(.*?)(<\/h[1-6]>)/i',
    function($matches) {
      // Add 'id' attribute if it doesn't exist
      if (strpos($matches[2], 'id=') === false) {
        // Use heading's content as the ID
        $matches[0] = $matches[1] . ' id="' . sanitize_title($matches[3])
        . '">' . $matches[3] . $matches[4];
      }

      // Return the (potentially) modified heading tag
      return $matches[0];
    },
    $content // Content to modify
  );

  // Return modified content
  return $content;
}, 10, 3);
```

In this example, a callback function is defined within the add_filter function call targeting the `bricks/frontend/render_data` filter. This callback function modifies every heading tag present in the content to include a unique ID attribute. This can be useful for navigation purposes, such as creating a table of contents.

---


## Filter: bricks/frontend/render_element

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-frontend-render_element/*

The `bricks/frontend/render_element` filter allows you to modify the HTML output of any element in Bricks on the frontend. This powerful hook can be used for a variety of customization tasks, such as adding comments, modifying content, or dynamically adjusting HTML. (@since 2.0)

```php
add_filter( 'bricks/frontend/render_element', function( $html, $element ) {
    // Do not modify the HTML in the builder
    if (
        bricks_is_builder_main() ||
        bricks_is_builder_iframe() ||
        bricks_is_builder_call()
    ) {
        return $html;
    }

    // Add comments before and after an element with a specific ID
    if ( $element->id === 'regxve' ) {
        $html = '<!-- Start of the element -->' . $html . '<!-- End of the element -->';
    }

    // Modify the content of a Basic Text element
    if ( $element->id === 'wtktgp' ) {
        // Replace "|" with ">>" in the HTML
        $html = str_replace( '|', '>>', $html );
    }

    return $html;
}, 10, 2 );

```

---


## Filter: bricks/get_element_data/maybe_from_post_id

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-get_element_data-maybe_from_post_id/*

The `bricks/get_element_data/maybe_from_post_id` filter, available `@since 1.11`, allows you to specify an additional post ID from which to retrieve element data. This can be useful when dealing with custom elements that reference templates, posts, or external data sources, where the target element is not found within the standard element set. (Especially when dealing with Code element + Signed signature)

### When to Use

This filter is useful when working with custom elements that reference data from other templates or posts. For example, if you have a custom element that stores additional Bricks content in another post or template, and there is a code element with a signed signature located there, Bricks may not render the code element on the frontend because it doesn't know where to retrieve the signature. This filter allows you to specify the correct post or template to ensure that all elements are properly rendered.

```php
add_filter( 'bricks/get_element_data/maybe_from_post_id', function( $id, $element_data ) {
  // Check if the element is my custom element and has custom_template_id set on the control
  if ( isset( $element_data['name'] ) && $element_data['name'] === 'my-custom-element' && ! empty( $element_data['settings']['custom_template_id'] ) ) {
    $id = $element_data['settings']['custom_template_id'];
  }

  return $id;
}, 10, 2 );

```

---


## Filter: bricks/header/attributes

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-header-attributes/*

Programmatically add HTML attributes to the `header` tag.

```php
add_filter( 'bricks/header/attributes', function( $attributes ) {
  // Add custom class to header
  if ( isset( $attributes['class'] ) && is_array( $attributes['class'] ) ) {
    $attributes['class'][] = 'my-header-class';
  } else {
    $attributes['class'] = ['my-header-class'];
  }

  // Add 'data-is-header' HTML attribute to header with value 'y'
  $attributes['data-is-header'] = 'y';

  return $attributes;
} );
```

- [/developer/hooks/filters/filter-bricks-content-attributes/](/developer/hooks/filters/filter-bricks-content-attributes/)
- [/developer/hooks/filters/filter-bricks-footer-attributes/](/developer/hooks/filters/filter-bricks-footer-attributes/)

---


## Filter: bricks/builder/i18n

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-i18n/*

Place and customize the following filter to add translatable string to the builder.

```php
add_filter( 'bricks/builder/i18n', function( $i18n ) {
  // Example: Provide translatable string for element category 'custom'
  $i18n['custom'] = esc_html__( 'Custom', 'bricks' );

  return $i18n;
} );
```

---


## Filter: bricks/is_layout_element

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-is_layout_element/*

Allows to define your custom elements as a layout element, so they are recognised like the section, container, block, div elements and use the same controls like query loop, flex controls, shape divider, etc.

```php
add_filter( 'bricks/is_layout_element', function( $layout_element_names ) {
    // Mark your custom element "custom_box" as a layout element
    $layout_element_names[] = 'custom_box';

    return $layout_element_names;
} );
```

---


## Filter: bricks/link_css_selectors

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-link_css_selectors/*

Use this filter in your child theme to overwrite/extend the CSS selectors the "Theme Styles > Link" settings are applied to like this (since Bricks 1.10 also available in the builder):

```php
add_filter( 'bricks/link_css_selectors', function( $link_css_selectors ) {
    // Add CSS link styles to .my-custom-element a
    $link_css_selectors[] = '.my-custom-element a';

    // OR return new list of CSS link selectors
    // $link_css_selectors = ['.link-wrapper a', '.link-wrapper-2 a'];

    return $link_css_selectors; // Array of selectors link styles are applied to
} );
```

:::note
If the theme styles link styles do not apply to your custom selectors, force the regeneration of the theme styles by changing and saving the link color, the padding, or the text decoration, for example. Your new selectors will then be available.
:::

---


## Filter: bricks/maintenance/should_apply

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-maintenance-should_apply/*

Use this filter `(@since 2.0)` to override whether maintenance mode should be enforced for the current request.

By default, Bricks checks if the user is in the admin area or builder, if the current page is the login page, if the user can bypass maintenance, or if the current post is in the excluded list.

This filter runs *after* all of those checks have passed, giving you a final opportunity to apply custom logic before showing the maintenance or coming soon page.

## Parameters:

- `$apply_maintenance` (bool): Whether maintenance mode should apply. Defaults to `true` after all core checks pass.
- `$mode` (string): The current maintenance mode. Either `'maintenance'` or `'coming_soon'`.

## Return:

- `(bool)`: `true` to apply maintenance mode, `false` to bypass it.

## Example Usage:

In the following example, anyone with the correct `preview_key` in the URL (e.g. `https://domain.com?preview_key=letmein123`) will bypass maintenance mode. This is especially useful for sharing a live preview with clients or collaborators without requiring login access.

```php
add_filter( 'bricks/maintenance/should_apply', function( $apply_maintenance, $mode ) {
    $valid_key = 'letmein123';

    // Bypass maintenance mode if a valid preview key is present in the URL
    if ( isset( $_GET['preview_key'] ) && $_GET['preview_key'] === $valid_key ) {
        return false;
    }

    // Keep default behavior for all other cases
    return $apply_maintenance;
}, 10, 2 );
```

### Improved version with cookie persistence:

You can improve this behavior further by **persisting the preview access across page loads** using a cookie. Otherwise, the user would only bypass maintenance on the first page they visit (where the key is present in the URL), and get blocked again when navigating elsewhere.

```php
add_filter( 'bricks/maintenance/should_apply', function( $apply_maintenance, $mode ) {
    $valid_key   = 'letmein123';
    $cookie_name = 'bricks_preview_key';

    // Check preview key in URL
    if ( isset( $_GET['preview_key'] ) && $_GET['preview_key'] === $valid_key ) {
        // Set a cookie for 1 hour
        setcookie( $cookie_name, $valid_key, time() + HOUR_IN_SECONDS, COOKIEPATH, COOKIE_DOMAIN );
        return false;
    }

    // Check cookie on subsequent requests
    if ( isset( $_COOKIE[ $cookie_name ] ) && $_COOKIE[ $cookie_name ] === $valid_key ) {
        return false;
    }

    return $apply_maintenance;
}, 10, 2 );
```

---


## Filter: bricks/nav_menu/menu

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-nav_menu-menu/*

The `bricks/nav_menu/menu` filter allows you to modify the navigation menu dynamically in Bricks Builder based on your conditions.

In the following example, we'll demonstrate how to change the navigation menu if the user is logged in.

This can be useful for displaying different menus to guests and logged-in users without using multiple Nab Menu elements and Bricks conditions.

**Example: **Use "My Account Menu" on the "Nav Menu" element (id: `kybsde`) if the user is logged in.

![](imgs/nav_menu-filter-eea32a88fa.png)

You can retrieve the menu ID via the URL parameter after selecting it.

![](imgs/nav_menu-menu-id-c0beb3698e.png)

```php
add_filter( 'bricks/nav_menu/menu', function( $menu, $post_id, $element ) {
  // Only target this nav menu element
  if( $element['id'] !== 'kdkdge' ) {
    return $menu;
  }

  // If logged-in, use the menu ID 4
  if( is_user_logged_in() ) {
    $menu = 4;
  }

  return $menu;
}, 10, 3 );
```

---


## Filter: bricks/password_protection/cookie_expires

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-password_protection-cookie-expires/*

Adjust the expiration time for the password cookie used by [the password protection template](/builder/features/password-protection/). By default, when a password is set in the template settings, the cookie expires after **10 days**. This filter allows you to customize how long the cookie remains valid.

## Example Usage:

```php
add_filter( 'bricks/password_protection/cookie_expires', function( $expire ) {
    // Set cookie expiration to 1 hour (3600 seconds)
    return time() + 3600;
} );
```

In this example, the password cookie will expire after 1 hour, requiring users to re-enter the password if they revisit the page after that time.

**Parameters:**

- `$expire` (int): The default expiration timestamp for the password cookie, which is set to **10 days**.

**Return:**

- (int): The Unix timestamp for when the cookie should expire.

---


## Filter: bricks/password_protection/is_active

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-password_protection-is_active/*

Use this filter to add custom rules that determine whether a [password protection template](/builder/features/password-protection/) should be active. By default, the template’s visibility is controlled by settings such as logged-in status, valid password cookies, and scheduling through the password protection template settings in the builder. This filter allows you to extend those checks, adding more dynamic criteria once the default settings have been applied.

## Example Usage:

```php
add_filter( 'bricks/password_protection/is_active', function( $is_active, $template_id, $settings ) {
    // Bypass password protection for users with the 'manage_options' capability
    if ( current_user_can( 'manage_options' ) ) {
        return false;
    }

    // Maintain default logic for other cases
    return $is_active;
}, 10, 3 );
```

In this example, any user with the `manage_options` capability (typically administrators) will bypass the password protection, while other users will follow the default settings.

**Parameters:**

- `$is_active` (bool): The initial status of whether the password protection is active.
- `$template_id` (int): The ID of the password protection template.
- `$settings` (array): The template settings.

**Return:**

- (bool): `true` to keep the template active, `false` to disable it.

---


## Filter: bricks/placeholder_image

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-placeholder_image/*

The `bricks/placeholder_image` filter allows you to override the default placeholder image used in Bricks. This can be useful when you want to display a custom placeholder for elements when performing template import or pasting elements from another website. `(@since 2.0)`

## Parameters

- `$image` *(string)* – The default placeholder image path or URL.
- `$is_svg` *(bool)* – Whether the placeholder should be an SVG. Leave as is.
- `$format` *(string)* – Can be `'url'` or `'path'` depending on the context Bricks needs it for. Leave as is.

```php
add_filter( 'bricks/placeholder_image', function( $image, $is_svg, $format ) {
  // Custom placeholder images (SVG and non-SVG file required)
  // SVG file: /uploads/2025/04/my-placeholder.svg
  // Non-SVG file: /uploads/2025/04/my-placeholder-img.png
  $relative_path = $is_svg ? '2025/04/my-placeholder.svg' : '2025/04/my-placeholder-img.png';
  $upload_dir    = wp_get_upload_dir();

  if ( $format === 'path' ) {
    // Return absolute path to the image
    $image = $upload_dir['basedir'] . '/' . $relative_path;
  } else {
    // Return full URL to the image
    $image = $upload_dir['baseurl'] . '/' . $relative_path;
  }

  return $image;
}, 10, 3 );
```

---


## Filter: bricks/posts/merge_query

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-posts-merge_query/*

Since Bricks 1.3.7 you'll be able to decide if a certain element query should be merged with the WordPress main query, in the archive or search templates, using the following filter:

```php
add_filter( 'bricks/posts/merge_query', function( $merge, $element_id ) {
  if ( $element_id === 'wghgco' ) {
    return false;
  }

  return $merge;
}, 10, 2 );
```

The filter callback receives two arguments:

- `$merge` is a boolean variable indicating whether the query should be merged or not (default: true)
- `$element_id` is a string containing the element ID

This is triggered for all the Bricks elements containing one internal WP_Query query like the Posts and the Carousel element, or any other element where the Query Loop is enabled (Container, Slider, Accordion).



:::note
Starting from Bricks 1.7, you can achieve the same result by utilizing the "Disable Query Merge" option in the [Query Loop](/builder/dynamic-content/query-loop/#posts-query), without the need for a PHP filter. Use this filter for more advanced situations.
:::

## How to find the element ID? {#find-element-id}

Each element in Bricks has a unique ID. You may find the element ID when editing the element and looking into the Global CSS classes input. By default, it shows the element HTML ID (e.g. `#bricks-element-wghgco`). For the purpose of this filter, we only need the last portion of the string, the six-character long element ID (e.g. `wghgco`).

![](imgs/Screenshot-2021-12-29-at-09.19.37-e493dbe794.png)

---


## Filter: bricks/posts/query_vars

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-posts-query_vars/*

Since Bricks 1.3.2 you may manipulate the **posts**, **products,** or **Query Loop** elements query vars before the query is performed like so:

```php
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {
    // Use an ACF custom field to restrict the query to a set of posts
    if ( $element_id == 'fhmnfx' && function_exists('get_field') ) {
        $query_vars['post__in'] = get_field('my_posts_acf_field');
    }

    return $query_vars;
}, 10, 4 );
```

The filter callback receives three arguments:

- `$query_vars` an associative array used to feed the [WP_Query](https://developer.wordpress.org/reference/classes/wp_query/) class
- `$settings` an associative array containing the element settings set in the builder
- `$element_id` is a string containing the unique element ID (`@since 1.3.6`)
- `$element_name` is a string containing the element name (`@since 1.11.1`)



:::note
If you intend to modify the $query_vars for the WooCommerce product query in Bricks, consider increasing the priority argument to a higher value, such as 20 or 30. Failure to do so could result in your filter being potentially overridden by other code that hooks into this filter.
:::

#### Example: Loop images from Metabox.io Advanced Image Field of current post {#metabox-advanced-image-loop}

```php
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {

    // Only target yeamho element_id
    if ( $element_id !== 'yeamho') return $query_vars;

    // Get Metabox advanced images field values. 'mg_projet_galerie_images' is the field id
    $gallery_images = (array) rwmb_meta( 'mg_projet_galerie_images', ['size' => 'full'] );

    // Get the Images Ids only
    $gallery_images_ids = array_keys($gallery_images);

    // If no gallery images, set empty string array
    $gallery_images_ids = count( $gallery_images_ids ) > 0 ? $gallery_images_ids : [''];

    // Set the images ids as post__in parameters
    $query_vars['post__in'] = $gallery_images_ids;

    return $query_vars;
}, 10, 4 );
```



#### Example: Use current taxonomy's ACF gallery images IDs for a Media query loop (Nestable Slider) {#acf-term-gallery-field}

If you want to build a dynamic Slider in term archive template, you can set the query loop on the Slide like below image, and use the code snippet below to retrieve the images IDs from the gallery field for each term, then assign them to the `post__in` parameter.

![](imgs/media-query-loop-in-term-archive-01-dacb012c74.png)

```php
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {
  // Only target udcvuw element_id
  if ( $element_id == 'udcvuw' && function_exists('get_field') ) {
    // Set to 0, ensure no results by default
    $query_vars['post__in'] = [0];
    $current_term = get_queried_object();

    // Check if the current page is a term archive
    if( is_a( $current_term, 'WP_Term' ) ) {
      // Get the images associated with the current term, region_-_banniere is the field name
      $images = get_field('region_-_banniere', 'region_'. $current_term->term_id );

      // Check if images exist and if there's more than 0 images
      if( is_array( $images ) && count( $images ) > 0 ) {
        // Get the IDs of the images (if this field return format is array)
        $images_ids = wp_list_pluck( $images, 'ID' );
        // Set the query to include only posts with these image IDs
        $query_vars['post__in'] = $images_ids;
      }
    }
  }
  return $query_vars;
}, 10, 4 );

```



#### Example: Apply orderby argument with 2 different fields {#orderby-with-multiple-fields}

Imagine you got a Performance post type with a start date field and a start time field. As you will not create the Performance post by actual sequence, you wish to order the Performance posts by start date (ascending) and start time (descending).

Since 1.11.1, you can achieve this in Query Loop user interface. Check [this](/builder/dynamic-content/query-loop/#enhanced-ordering-options) out.

```php
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {

    // Only target 3b03dd element_id
    if( $element_id !== '3b03dd') return $query_vars;

    // Set meta_query
    $query_vars['meta_query'] = [
        'relation' => 'AND',
        'performance_start_date' => array(
            'key' => 'performance_start_date',
            'compare' => 'EXISTS',
        ),
        'performance_start_time' => array(
            'key' => 'performance_start_time',
            'compare' => 'EXISTS',
        ),
    ];

    // Set orderby
    $query_vars['orderby'] = [
        'performance_start_date' => 'ASC',
        'performance_start_time' => 'DESC'
    ];

    return $query_vars;
}, 10, 4 );
```



#### Example: Get WooCommerce Related Products {#woocommerce-related-products-query}

Create a query loop with the following settings

![](imgs/woo-related-products-query-1ea5fd1f79.png)

```php
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {
	if( $element_id !== 'azuxwi' ) return $query_vars;

	$product_id = get_the_ID();
	$product = wc_get_product( $product_id );

	if( ! is_a( $product, 'WC_Product' ) ) return $query_vars;
	// Exclude the upsell products
	$upsell_ids = $product->get_upsell_ids();

	if( count( $upsell_ids ) > 0 ) {
		if( isset( $query_vars['post__not_in'] ) ) {
			$query_vars['post__not_in'] = array_merge( $query_vars['post__not_in'], $upsell_ids );
		} else {
			$query_vars['post__not_in'] = $upsell_ids;
		}
	}

	return $query_vars;
}, 10, 4);
```



#### Example: Get WooCommerce Upsell Products {#woocommerce-upsell-products-query}

Create a query loop with the following settings:

![](imgs/query_var_product_upsell-fe34ef2d1c.png)

```php
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {
	// Change the Id
	if( $element_id !== 'shctqn') return $query_vars;

	$product_id = get_the_ID();
	$product = wc_get_product( $product_id );

	if( ! is_a( $product, 'WC_Product' ) ) return $query_vars;

	$upsell_ids = $product->get_upsell_ids();
	$query_vars['post__in'] =  ( count( $upsell_ids ) > 0 )? $upsell_ids : [0] ;
        // in case your have product variation set as upsell
        $query_vars['post_type'] = ['product', 'product_variation'];

	return $query_vars;
}, 10, 4 );
```



#### Different ways to target the query other than $element_id {#different-ways-to-target-bricks-query-in-php}

Sometimes you might want to target a group of queries instead of a specific element by using the `$element_id`



##### Use WordPress conditional tag function

```php
// Target any query in an archive page
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {

  if( ! is_archive() ) return $query_vars;

  // Perform your logic here

  return $query_vars;
}, 10, 4 );
```



##### Check if CSS class exists on the query element

```php

// Target any query if 'my-custom-class' set on the query element in STYLE > CSS > CSS Classes
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {

  $css_class = isset( $settings['_cssClasses'] ) ? $settings['_cssClasses'] : '';

  if( $css_class === '' || strpos( $css_class, 'my-custom-class' ) === false ) {
    return $query_vars;
  }

  // Perform your logic here

  return $query_vars;
}, 10, 4 );

// Target any query if 'my-custom-class' global class set on the query element
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {

  $global_css_classes = isset( $settings['_cssGlobalClasses'] ) ? \Bricks\Element::get_element_global_classes( $settings['_cssGlobalClasses'] ) : [];

  if( empty( $global_css_classes ) || ! in_array( 'my-custom-class', $global_css_classes ) ) {
    return $query_vars;
  }

  // Perform your logic here

  return $query_vars;
}, 10, 4 );
```

---


## Filter: bricks/query/force_run

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-query-force_run/*

Bricks has enhanced query performance in 1.9.1. Now, each unique query is executed only once per page load, and subsequently, the query results are reused on the same page. Consequently, certain queries-related PHP filters will no longer be triggered multiple times.

The following filters may be impacted:

- `bricks/posts/merge_query`
- `bricks/posts/query_vars`
- `bricks/terms/query_vars`
- `bricks/users/query_vars`
- `bricks/query/run`
- `bricks/query/result`
- `bricks/query/result_count`
- `bricks/query/result_max_num_pages`



Nevertheless, developers can utilize this filter to disable this setting for certain queries under specific circumstances.

```php
// Return boolean (default: false)
add_filter( 'bricks/query/force_run', function( $force_run, $query ) {
  // Get element ID
  $element_id  = $query::get_query_element_id();
  // Get element settings
  $settings = $query->settings;

  if ( isset( $settings['usingFacetWP'] ) ) {
    $force_run = true;
  }

  return $force_run;
}, 10, 2 );
```

Since 1.9.2, you can define `$query_vars['bricks_force_run'] = true` to achieve the same result as well. This will be handy if you are using the Bricks Query Editor or PHP filters like `bricks/posts/query_vars`  etc.

![](imgs/bricks-query-force-run-query-vars-e2c3d44550.png)

---


## Filter: bricks/query/init_loop_index

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-query-init_loop_index/*

The `bricks/query/init_loop_index` filter, available `@since 1.11`, allows you to modify the initial loop index when using various query types in Bricks Builder. This filter is especially useful in cases such as infinite scroll or paginated queries, where setting the correct loop index is crucial for displaying content seamlessly across multiple pages especially when using dynamic backgound images or colors. Without this hook, the generated dynamic CSS might be applied on the incorrect element when performing infinite scroll or paginate actions.

### When to Use

This filter is particularly useful when creating a custom query type using the [bricks/setup/control_options](/developer/hooks/filters/filter-bricks-nav_menu-menu/) hook. You can implement your own logic for handling pagination and adjust the initial loop index accordingly.

```php
add_filter( 'bricks/query/init_loop_index', function ( $initial_index, $object_type, $query ) {
  // Check if the object type is 'my_custom_query'
  if ( $object_type !== 'my_custom_query' ) {
    return $initial_index;
  }

  // Add your custom logic to modify the initial loop index
  // Example: Calculate based on custom logic
  // $initial_index = custom_logic_to_calculate_index();

  return $initial_index;
}, 10, 3 );

```

---


## Filter: bricks/query/loop_object

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-query-loop_object/*

The Bricks [Query Loop](/builder/dynamic-content/query-loop/) supports 3 types of queries by default (Posts, Terms, and Users). But it can be extended to support [any other query](/developer/hooks/filters/filter-bricks-query-run/). While iterating through the query results, the iteration object could be manipulated using the `bricks/query/loop_object` like so:

```php
add_filter( 'bricks/query/loop_object', function( $loop_object, $loop_key, $query_obj ) {
    if ( $query_obj->object_type !== 'my_query_type' ) {
	return $loop_object;
    }

    // Perform some logic, for example:
    // global $post;
    // $post = get_post( $loop_object );
    // setup_postdata( $post );

    return $loop_object;
}, 10, 3 );
```

The filter callback receives two arguments:

- `$loop_object` is the current loop iteration value (from the results array)
- `$loop_key` is the current loop iteration key (from the results array)
- `$query_obj` is an instance of the `\Bricks\Query` class object

Related hooks:

- To add a query type to the Query control use [`bricks/setup/control_options`](/developer/hooks/filters/filter-bricks-setup-control_options/)
- To perform the custom query type and output the results use [`bricks/query/run`](/developer/hooks/filters/filter-bricks-query-run/)

---


## Filter: bricks/query/loop_object_id

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-query-loop_object_id/*

Bricks will use `\Bricks\Query::get_loop_object_id()` to retrieve the looping iteration's object ID.

This static function is used in many places. Especially when trying to parse dynamic data.  By default, Bricks uses the looping ID if the looping object is a WP_Post, WP_Term, or WP_User object. This filter allows you to change the ID conditionally.

```php
// Change the object_id if the current looping query type is myCustomQueryType
add_filter( 'bricks/query/loop_object_id', function( $object_id, $object, $query_id ) {
    $query_object_type = \Bricks\Query::get_query_object_type( $query_id );
    if ( $query_object_type !== 'myCustomQueryType' ) {
	return $object_id;
    }

    // Set my loop_object_id
    $new_id = my_custom_function_to_transform_the_id( $object_id );
    return $new_id;
}, 10, 3 );
```

### Related hooks:

- [bricks/setup/control_options](/developer/hooks/filters/filter-bricks-setup-control_options/): To add a custom query type to the Query control
- [bricks/query/loop_object](/developer/hooks/filters/filter-bricks-query-loop_object/): To manage the object on every loop iteration

---


## Filter: bricks/query/loop_object_type

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-query-loop_object_type/*

Bricks will use `\Bricks\Query::get_loop_object_type()` to retrieve the looping iteration's object type. This static function is used in many places. It plays an important role in many conditions. The possible return object_type should be 'post', 'term', or 'user' only.

```php
// This is the example when Bricks set the object_type in woo cart query, so inside each iteration, it will be treat as a post/product object_type
add_filter( 'bricks/query/loop_object_type', function( $object_type, $object, $query_id ) {
    $query_object_type = \Bricks\Query::get_query_object_type( $query_id );

    if ( $query_object_type !== 'wooCart' ) {
	return $object_type;
    }

    return 'post';
}, 10, 3 );
```

---


## Filter: bricks/query/no_results_content

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-query-no_results_content/*

You can programmatically change the query loop "no results content" using this filter.

```php
add_filter( 'bricks/query/no_results_content', function( $content, $settings, $element_id ) {

  // Check if the query element id is the one you want
  if( $element_id !== 'srixvr' ) return $content;

  // Use a bricks section template as the no results content
  $content = do_shortcode('[bricks_template id="3981"]');

  return $content;
}, 10, 3 );
```

---


## Filter: bricks/query/result

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-query-result/*

Available since 1.8, this filter lets you customize the query results and implement additional logic. Like modifying the post, term, or user object type. Which was previously not editable through the [`bricks/query/run`](/article/filter-bricks-query-run/) filter.

```php
// Use this filter to rearrange it by post title (PHP way instead of query orderby)
add_filter( 'bricks/query/result', function( $result, $query_obj ){
  // Return: Element ID is not "djvsvi", nor is it a post query
  if ( $query_obj->element_id !== 'djvsvi' || $query_obj->object_type !== 'post' ) {
    return $result;
  }

  // Sort by post title (descending)
  // Result is WP_Query object with posts
  if ( $result->have_posts() ) {
    $posts = $result->posts;

    usort( $posts, function( $a, $b ) {
      return strcmp( $b->post_title, $a->post_title );
    });

    $result->posts = $posts;
  }

  return $result;
}, 10, 2 );
```

---


## Filter: bricks/query/result_count

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-query-result_count/*

This filter allows you to modify the query result count (@since 1.8).

```php
add_filter( 'bricks/query/result_count', function( $result_count, $query_obj ) {
  // Return: Element ID is not "lbsijo", nor is it a post query
  if( $query_obj->element_id !== 'lbsijo' || $query_obj->object_type !== 'post' ) {
    return $result_count;
  }

  // Perform your logic here
  // Use $query_obj->query_result to access the query result
  $new_count = 123;
  return $new_count;
}, 10, 2 );
```

---


## Filter: bricks/query/result_max_num_pages

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-query-result_max_num_pages/*

This filter allows you to modify the query result maximum number of pages (@since 1.9.1). This value is used for the Pagination element as well.

```php
add_filter( 'bricks/query/result_max_num_pages', function( $max_num_pages, $query_obj ) {
  // Return: Element ID is not "lbsijo", nor is it a post query
  if( $query_obj->element_id !== 'lbsijo' || $query_obj->object_type !== 'post' ) {
    return $max_num_pages;
  }

  // Perform your logic here
  // Use $query_obj->query_result to access the query result
  $max_num_pages = 3;
  return $max_num_pages;
}, 10, 2 );
```

---


## Filter: bricks/query/run

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-query-run/*

The Bricks [Query Loop](/builder/dynamic-content/query-loop/) supports 3 types of queries by default (Posts, Terms and Users). But it can be extended to support any other query. To return a custom query result, Bricks can be extended using the WP filter `bricks/query/run` like so:

```php
add_filter( 'bricks/query/run', function( $results, $query_obj ) {
    if ( $query_obj->object_type !== 'my_query_type' ) {
	return $results;
    }

    // Perform the query
    // Assign the results to $results (array)

    return $results;
}, 10, 2 );
```

The filter callback receives two arguments:

- `$results` is the results array (empty by default). The loop will iterate through this array.
- `$query_obj` is an instance of the `\Bricks\Query` class object

Note: This hook should be used to add different types of query results. If you want to alter the posts, terms, or users query, use the following hooks:

- **Posts**: [`bricks/posts/query_vars`](/developer/hooks/filters/filter-bricks-posts-query_vars/)
- **Terms**: [bricks/terms/query_vars](/developer/hooks/filters/filter-bricks-terms-query_vars/)
- **Users**: [bricks/users/query_vars](/developer/hooks/filters/filter-bricks-users-query_vars/)

Related hooks:

- To add a query type to the Query control use [`bricks/setup/control_options`](/developer/hooks/filters/filter-bricks-setup-control_options/)
- To manage the object on every loop iteration use [`bricks/query/loop_object`](/developer/hooks/filters/filter-bricks-query-loop_object/)

---


## Filter: bricks/registered_post_types_args

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-registered_post_types_args/*

Available since version 1.6, this filter allows you to customise the post type args that are used to query the post type as shown in the Bricks settings & the builder (e.g. Query control post types, etc.)

```php
add_filter( 'bricks/registered_post_types_args', function( $args ) {
  // Default: Return only public post types
  // $args['public'] = true;

  // Custom: Return all registered post types
  unset( $args['public'] );

  // Available arguments: https://developer.wordpress.org/reference/functions/get_post_types/#comment-2184
  return $args;
} );
```

---


## Filter: bricks/related_posts/query_vars

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-related_posts-query_vars/*

Since Bricks 1.3.5 you may manipulate the **related posts** element query vars before the query is performed like so:

```php
add_filter( 'bricks/related_posts/query_vars', function( $query_vars, $settings, $element_id ) {
    $query_vars['post_type'] = [ 'post', 'project' ];

    return $query_vars;
}, 10, 3 );
```

The filter callback receives two arguments:

- `$query_vars` is an associative array used to feed the [WP_Query](https://developer.wordpress.org/reference/classes/wp_query/) class
- `$settings` is an associative array containing the element settings set in the builder
- `$element_id` is a string containing the element ID

---


## Filter: bricks/render_query_loop_trail

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-render_query_loop_trail/*

The `bricks/render_query_loop_trail` (@since 1.11.1) filter controls the output of the query loop trail node in Bricks. This node is automatically added to each query loop and records the loop's settings, which are then accessed by frontend JavaScript to manage various query-related tasks. Once these settings are read by Bricks, the node is removed from the DOM.

For some third-party plugins, this node may not be needed—especially if they use custom AJAX endpoints to update query results independently of Bricks. Using this filter, you can control whether or not the query loop trail node is rendered.

```php
// Return true = render the query loop trail node
// Return false = skip the query loop trail node
add_filter( 'bricks/render_query_loop_trail', function( $render, $element, $query ) {
  // Do not render query loop trail node if my-custom-param parameter exists
  if ( isset( $_GET['my-custom-param'] ) ) {
    $render = false;
  }

  return $render;
}, 10, 3 );
```

In this example, if the `my-custom-param` parameter is detected in the URL, the query loop trail node will not be rendered. This can be useful for third-party plugins with custom AJAX endpoints that handle query configurations independently.

---


## Filter: bricks/screen_conditions/scores

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-screen_conditions-scores/*

Bricks selects the template & theme style for a specific page according to the conditions you've defined.

Internally this is done via a scoring system from 0 to 10. 0 is the least specific. 10 being the most specific (e.g. specific post ID).

For each template/theme style condition that could apply to a certain context, the template/theme style earns a specific score. After analyzing all templates/theme styles, Bricks chooses the one with the highest score.

If you need to add new template conditions using the filter [`builder/settings/template/controls_data`](/developer/hooks/filters/filter-builder-settings-type-controls_data/) or `bricks/theme_styles/controls` for theme styles, you then need to hook into the scoring logic to score the templates/theme styles based on the custom conditions.

This is where the `bricks/screen_conditions/scores` filter comes in handy, like so:

```php
add_filter( 'bricks/screen_conditions/scores', function( $scores, $condition, $post_id, $preview_type ) {
  // Run custom logic to score the template/theme style $condition
  // $scores[] = 5;

  return $scores;
}, 10, 4 );
```

**Example 1: Add the score for a specific author role in an author archive template**

After adding the control using the [`builder/settings/template/controls_data`](/developer/hooks/filters/filter-builder-settings-type-controls_data/) (check example 1), we now need to hook in `bricks/screen_conditions/scores` to score the template based on the condition, like so:

```php
add_filter( 'bricks/screen_conditions/scores', function( $scores, $condition, $post_id, $preview_type ) {
  if ( is_author() && $condition['main'] === 'archiveType' && isset( $condition['archiveType'] ) && in_array( 'author', $condition['archiveType'] ) && isset( $condition['archiveAuthorRoles'] ) ) {
    $user = get_queried_object();

    if ( ! empty( $user->roles ) && is_array( $user->roles ) ) {
      foreach ( $user->roles as $role_name ) {
        if ( in_array( $role_name, $condition['archiveAuthorRoles'] ) ) {
          $scores[] = 9;
        }
      }
    }
  }

  return $scores;
}, 10, 4 );
```

---


## Filter: bricks/search_form/home_url

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-search_form-home_url/*

The `bricks/search_form/home_url` filter allows developers to customize the action URL of the search form within the Bricks theme. This filter provides the flexibility to redirect search queries to a different URL than the default WordPress home URL.

By using this filter, developers can integrate custom search solutions or direct the search form submissions to a specific page, enhancing the search functionality tailored to specific needs.

### Example Usage:

```php
<code>add_filter( 'bricks/search_form/home_url', function( $home_url ) {</code><code>    // Custom logic to determine the action URL</code><code>    $custom_action_url = 'https://example.com/custom-search-page/'; </code>
<code>    return $custom_action_url;</code><code>});</code>
```

In this simple example, the search form action URL is changed to a custom page. This is particularly useful for websites with specialized search requirements or for integrating with external search platforms.

### Parameters:

- `$home_url` (string): The default URL to which the search form points, typically the home URL.

### Return:

- (string): The modified URL for the search form action.

---


## Filter: bricks/element/set_root_attributes

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-set_root_attributes/*

Bricks 1.4 with its improved & slimmer DOM structure now requires to add the element ID, root classes, and other element root HTML attributes directly inside the `render()` function. You can programmatically manipulate the returns element root attributes like so:

```php
add_filter( 'bricks/element/set_root_attributes', function( $attributes, $element ) {
    // Add CSS class 'heading-bg' to every heading element
    if ( $element->name === 'heading' ) {
        $attributes['class'][] = 'heading-bg';
    }

    return $attributes;
}, 10, 2 );
```

The filter callback receives 2 arguments:

- `$attributes` – an associative array of the element root attributes, grouped by the attribute name (e.g. "class", "data-animation", ...)
- `$element` - the Bricks element [object](/developer/elements/create-your-own-elements/)

**NOTE**: This filter doesn't work in builder & already possible with *[bricks/element/render_attributes](/developer/hooks/filters/filter-bricks-element-render_attributes/)*

---


## Filter: bricks/setup/control_options

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-setup-control_options/*

Bricks offers a WordPress filter to add or remove control options. The control options are used throughout Bricks and allow you to manage the options of the:

- Template Types (e.g. Header, Footer, Single, Section...)
- Background position, repeat, attachment or size
- Button sizes
- Button or Heading styles
- Border styles
- Font weight and style
- CSS position
- Query types (e.g. Posts, Terms, Users, ..)
- Query order by, compare, operator and value type
- Image Sizes
- Taxonomies
- User roles

To manage any of these options or add new ones, use the WP hook `bricks/setup/control_options` like so:

```php
add_filter( 'bricks/setup/control_options', function( $control_options ) {
    $control_options['templateTypes']['my_template_type'] = esc_html__( 'My Template Type', 'my-plugin' );

    return $control_options;
} );
```

Note: the above example adds a new template type. To learn about other Bricks controls visit the [Topic: Controls](https://academy.bricksbuilder.io/topic/controls/).

---


## Filter: bricks/terms/query_vars

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-terms-query_vars/*

Bricks terms query variables can be manipulated before the query runs like so:

```php
add_filter( 'bricks/terms/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {
    $query_vars['exclude'] = 23; // Exclude term id 23

    return $query_vars;
}, 10, 4 );
```

The filter callback receives three arguments:

- `$query_vars` an associative array used to feed the [WP_Term_Query](https://developer.wordpress.org/reference/classes/wp_term_query/) class
- `$settings` an associative array containing the element settings set in the builder
- `$element_id` is a string containing the unique element ID
- `$element_name` is a string containing the element name (`@since 1.11.1`)

## Example 1: Exclude the current term from the query {#exclude-current-term}

Inside a term archive page, to exclude the current term from the query:

```php
// Exclude current term from the terms query loop on term archive pages.
add_filter( 'bricks/terms/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {
    if ( $element_id !== 'uxtkgn' ) {
        return $query_vars;
    }

    $query_vars['exclude'] = get_queried_object_id();

    return $query_vars;
}, 10, 4 );
```

where `uxtkgn` is the Bricks ID of the element on which query loop is enabled.

## Example 2: Get terms assigned to a post {#get-terms-assigned-to-a-post}

In this example, we would like to get only the terms assigned to a specific post ID (the same as the WordPress function [`wp_get_object_terms()`](https://developer.wordpress.org/reference/functions/wp_get_object_terms/) output):

```php
add_filter( 'bricks/terms/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {
    if ( $element_id !== 'mjvhur' ) {
        return $query_vars;
    }

    $query_vars['object_ids'] = get_the_ID();

    return $query_vars;
}, 10, 4 );
```

---


## Filter: bricks/use_duplicate_content

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-use_duplicate_content/*

Duplicate content is available for all users with the `edit_post` capability. Use this feature to duplicate any post or page containing Bricks data to ensure Bricks IDs are not duplicated. The duplicate option is also available for posts without Bricks data, allowing you to duplicate standard posts without the need for a third-party plugin.

![](imgs/bricks-duplicate-content-setting-example-3393878fb5.png)

In **Bricks > Settings**, you can configure the duplicate content behavior:

![](imgs/bricks-duplicate-content-setting-f83d2718d8.png)

**Enable**: Duplicate content is available for all posts.
**Disable globally**: Duplicate content is disabled for all posts.
**Disable for WordPress Data**: Duplicate content is disabled for posts that do not use Bricks data.

This `bricks/use_duplicate_content` hook provides an additional layer of customization, enabling you to implement more complex logic based on your specific requirements. `(@since 1.12)`

## Parameters

**`$use`** *(bool)*

- The current decision on whether duplicate content is allowed. Default is based on settings and user capabilities.

**`$post_id`** *(int)*

- The ID of the post being checked.

**`$setting`** *(string)*

- The value in Bricks > Settings. Which can be `enable`, `disabled_all`, or `disable_wp`

## Return Value

This filter expects a boolean value:

- `true` to allow duplicate content for the particular post.
- `false` to disallow duplicate content for the particular post.

## Example Usage

Follow setting logic + ensure the user is admin

```php
add_filter( 'bricks/use_duplicate_content', function( $use, $post_id, $settings ) {
  // Only allow if current has user administrative privileges
  $has_admin_cap = current_user_can( 'manage_options' );

  // Fulfilled the condition
  return $use && $has_admin_cap;
}, 10, 3 );
```

Follow setting logic + exclude post type for ACF or MB

```php
add_filter( 'bricks/use_duplicate_content', function( $use, $post_id, $settings ) {
  // Check if the post type is 'acf-field-group' or 'mb-post-type
  $post_type = get_post_type( $post_id );
  $exclude_post_types = [ 'acf-field-group', 'mb-post-type' ];

  // Fulfilled the condition
  return $use && ! in_array( $post_type, $exclude_post_types, true );
}, 10, 3 );
```

---


## Filter: bricks/users/query_vars

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-bricks-users-query_vars/*

Bricks users query variables can be manipulated before the query runs like so:

```php
add_filter( 'bricks/users/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {
    $query_vars['exclude'] = [ 2, 5 ]; // Exclude users id 2 and 5

    return $query_vars;
}, 10, 4 );
```

The filter callback receives three arguments:

- `$query_vars` an associative array used to feed the [WP_User_Query](https://developer.wordpress.org/reference/classes/wp_user_query/) class
- `$settings` an associative array containing the element settings set in the builder
- `$element_id` is a string containing the unique element ID
- `$element_name` is a string containing the element name (`@since 1.11.1`)

---


## Filter: builder/settings/{type}/controls_data

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-builder-settings-type-controls_data/*

This filter allows you to add new controls to the Page Settings or Template Settings panels in the builder.

To manage the **Template Settings** controls use the `builder/settings/template/controls_data` hook like so:

```php
add_filter( 'builder/settings/template/controls_data', function( $data ) {
  // Do something

  return $data;
} );
```

To manage the **Page Settings** controls use the `builder/settings/page/controls_data` hook like so:

```php
add_filter( 'builder/settings/page/controls_data', function( $data ) {
  // Do something

  return $data;
} );
```

**Example: Add a control to select the user roles in the author archive template type template condition**

```php
add_filter( 'builder/settings/template/controls_data', function( $data ) {
  // Get all the site user roles
  $all_roles = wp_roles()->roles;

  $roles = [];

  foreach ( $all_roles as $role => $role_data ) {
    $roles[ $role ] = $role_data['name'];
  }

  // Add control to select the user roles for an author archive template type
  $data['controls']['templateConditions']['fields']['archiveAuthorRoles'] = [
    'type'        => 'select',
    'label'       => esc_html__( 'Author roles', 'bricks' ),
    'options'     => $roles,
    'multiple'    => true,
    'placeholder' => esc_html__( 'Select role', 'bricks' ),
    'description' => esc_html__( 'Leave empty to apply template to all roles.', 'bricks' ),
    'required'    => [ 'archiveType', '=', 'author' ],
  ];

  return $data;
} );
```

---


## Filter: bricks/builder/color_palette

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-color-palette/*

Place and customize the following filter to display a different default color palette for the color control.

```php
add_filter( 'bricks/builder/color_palette', function( $colors ) {
  // Option #1: Add an individual color
    $colors[] = [
      'hex' => '#3ce77b',
      'rgb' => 'rgba(60, 231, 123, 0.56)',
    ];

  // Option #2: Override entire color palette
  $colors = [
    ['hex' => '#3ce77b'],
    ['hex' => '#f1faee'],
    ['hex' => '#a8dadc'],
    ['hex' => '#457b9d'],
    ['hex' => '#1d3557'],
  ];

  return $colors;
} );
```

---


## Filter: bricks/builder/save_messages

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-save-messages/*

Place and customize the following filter to display different save message every time you manually save your progress when editing with Bricks.

```php
add_filter( 'bricks/builder/save_messages', function( $messages ) {
  // Option #1: Append individual save message to existing message collection
    $messages[] = 'Yasss';

  // Option #2: Replace all existing builder save messages
    $messages = [
      'Done',
      'Cool',
      'High five!',
    ];

  return $messages;
} );
```

---


## Filter: bricks/builder/standard_fonts

*來源網址：https://academy-preview.bricksbuilder.io/developer/hooks/filters/filter-standard-fonts/*

Place and customize the following filter to display a different set of web-safe fonts in the typography control.

```php
add_filter( 'bricks/builder/standard_fonts', function( $standard_fonts ) {
  // Option #1: Add individual standard font
  $standard_fonts[] = 'Verdana';

  // Option #2: Replace all standard fonts
  $standard_fonts = [
    'Georgia',
    'Times New Roman',
    'Verdana',
  ];

  return $standard_fonts;
} );
```

---
