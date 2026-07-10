# Bricks Academy — Developer Controls & Guides

> 來源：Bricks Builder Academy 官方文件 | 共 46 篇

---



## Align Items Control (Flexbox)

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/align-items-control/*

Use the align-items control to allow users to set the `align-items` CSS property (alignment along the [cross-axis](https://developer.mozilla.org/en-US/docs/Web/CSS/align-items)) of your CSS flexbox layout.

There is also a [`justify-content`](/developer/controls/justify-content-control/) control to allow users to set the alignment along the main axis of your CSS flexbox layout:

```php
public function set_controls() {
  $this->controls['alignItems'] = [ // Setting key
    'tab'   => 'content',
    'label' => esc_html__( 'Align items', 'bricks' ),
    'type'  => 'align-items',
    'css'   => [
      [
        'property' => 'align-items',
        'selector' => '.flexbox-wrapper',
      ],
    ],
    // 'isHorizontal' => false,
    // 'exclude' => [
      // 'flex-start',
      // 'center',
      // 'flex-end',
      // 'space-between',
      // 'space-around',
      // 'space-evenly',
    // ],
  ];
}
```

---


## Apply Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/apply-control/*

The `apply` control saves your settings. You can set the `reload` control property to **true** in order to trigger a builder reload after the "Apply" button has been clicked. We use it in the builder for settings like the template "Populate Content" or the "SEO" page settings.

```php
$this->controls['apply'] = [
  'group' => 'template-preview',
  'type' => 'apply',
  'reload' => true,
  'label' => esc_html__( 'Apply preview', 'bricks' ),
];
```

---


## Audio Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/audio-control/*

The audio control lets you select an audio file from the media library. It also gives you various options to show/hide artist and title, choose between a light/dark theme, autoplay the audio file, etc. It has no custom control parameters.

```php
class Prefix_Element_Audio extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['file'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Audio file', 'bricks' ),
      'type' => 'audio',
    ];
  }

  // Render element HTML
  public function render() {
    $settings = $this->settings;

    if ( isset( $settings['file']['url'] ) ) {
      echo wp_audio_shortcode( [
        'src'      => $settings['file']['url'],
        'loop'     => isset( $settings['loop'] ) ? $settings['loop'] : false,
        'autoplay' => isset( $settings['autoplay'] ) ? $settings['autoplay'] : false,
        'preload'  => isset( $settings['preload'] ) ? $settings['preload'] : 'none',
      ] );
    }
  }
}
```

### Resources

[https://codex.wordpress.org/Function_Reference/wp_audio_shortcode](https://codex.wordpress.org/Function_Reference/wp_audio_shortcode)

---


## Background Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/background-control/*

The background control lets you set the following background properties:

- Background color
- Background image
- Background video (requires `bricksBackgroundVideoInit` script. See code example below)

There are various settings for the background image and video. You can exclude color/image/video settings via the `exclude` parameter.

As the background control serves most likely as a CSS setting the following example shows you how to set the `css` parameter to apply it to the elements' `.prefix-test-wrapper` HTML.

Adding a background video requires you to load the `bricksBackgroundVideoInit` script and use the `BricksFrontend::get_element_background_video_wrapper()` method to render it.

:::note
When you just want to set a background color better use the [color control](/developer/controls/color-control/). The background control is handier when using a background image or video on top of the color.
:::

```php
class Prefix_Element_Background extends \Bricks\Element {
  // Required for background video
  public $scripts = ['bricksBackgroundVideoInit'];

  // Set builder controls
  public function set_controls() {
    $this->controls['exampleBackground'] = [ // Setting key
      'tab' => 'content',
      'label' => esc_html__( 'Background', 'bricks' ),
      'type' => 'background',
      'css' => [
        [
          'property' => 'background',
          'selector' => '.prefix-background-wrapper',
        ],
      ],
      'exclude' => [
        // 'color',
        // 'image',
        // 'parallax',
        // 'attachment',
        // 'position',
        // 'positionX',
        // 'positionY',
        // 'repeat',
        // 'size',
        // 'custom',
        // 'videoUrl',
        // 'videoScale',
      ],
      'inline' => true,
      'small' => true,
      'default' => [
        'color' => [
          'rgb' => 'rgba(255, 255, 255, .5)',
          'hex' => '#ffffff',
        ],
      ],
    ];
  }

  // Render element HTML
  public function render() {
    echo '<div class="prefix-background-wrapper">';

    // Background video
    echo BricksFrontend::get_element_background_video_wrapper(
      ['settings' => $settings],
      'exampleBackground' // Setting key
    );

    echo get_bloginfo( 'name' );

    echo '</div>';
  }
}
```

---


## Border Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/border-control/*

The border control lets you set the following border properties:

- Border width (top/right/bottom/left)
- Background style (top/right/bottom/left)
- Background color (none/solid/double/dotted/dashed)
- Border radius (top/right/bottom/left)

The example below illustrates how to apply a border via the `css` parameter and how to set border defaults.

```php
class Builder_Element_Prefix_Test extends \Bricks\Element {
  public function set_controls() {
    $this->controls['titleBorder'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Title border', 'bricks' ),
      'type' => 'border',
      'css' => [
        [
          'property' => 'border',
          'selector' => '.prefix-test-title',
        ],
      ],
      'inline' => true,
      'small' => true,
      'default' => [
        'width' => [
          'top' => 1,
          'right' => 0,
          'bottom' => 0,
          'left' => 0,
        ],
        'style' => 'solid',
        'color' => [
          'hex' => '#ffff00',
        ],
        'radius' => [
          'top' => 1,
          'right' => 1,
          'bottom' => 1,
          'left' => 1,
        ],
      ],


    ];
  }
}
```

---


## Box Shadow Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/box-shadow-control/*

The box-shadow control is a CSS control and you can set the following properties:

- Offset X
- Offset Y
- Spread
- Blur
- Color
- Inset

```php
class Prefix_Element_Box_Shadow extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleBoxShadow'] = [
      'tab' => 'content',
      'label' => esc_html__( 'BoxShadow', 'bricks' ),
      'type' => 'box-shadow',
      'css' => [
        [
          'property' => 'box-shadow',
          'selector' => '.prefix-box-shadow-wrapper',
        ],
      ],
      'inline' => true,
      'small' => true,
      'default' => [
        'values' => [
          'offsetX' => 0,
          'offsetY' => 0,
          'blur' => 2,
          'spread' => 0,
        ],
        'color' => [
          'rgb' => 'rgba(0, 0, 0, .1)',
        ],
      ],
    ];
  }

  // Render element HTML
  public function render() {
    echo '<div class="prefix-box-shadow-wrapper">';
    echo get_bloginfo( 'name' );
    echo '</div>';
  }
}
```

### Resources

[https://developer.mozilla.org/en-US/docs/Web/CSS/box-shadow](https://developer.mozilla.org/en-US/docs/Web/CSS/box-shadow)

---


## Checkbox Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/checkbox-control/*

The checkbox control is a simple on/off switch. If enabled it outputs a boolean value of `true`. Disabled it returns `false`. You can use it to conditionally show/hide other content settings as we illustrate in the following code example:

```php
class Prefix_Element_Checkbox extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleCheckbox'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Show site title', 'bricks' ),
      'type' => 'checkbox',
      'inline' => true,
      'small' => true,
      'default' => true, // Default: false
    ];
  }

  // Render element HTML
  public function render() {
    // Show site title if setting checkbox 'exampleCheckbox' is checked
    if ( isset( $this->settings['exampleCheckbox'] ) ) {
      echo get_bloginfo( 'name' );
    }
  }
}
```

---


## Code Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/code-control/*

The code control embeds a code editor utilizing the amazing CodeMirror library. Users for which you've enabled "**Code Execution**" in the Bricks settings, will be able to execute PHP, HTML, CSS, and JavaScript.

```php
class Prefix_Element_Code extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleHtml'] = [
      'tab' => 'content',
      'label' => esc_html__( 'HTML', 'bricks' ),
      'type' => 'code',
      'mode' => 'php',
      'default' => '<h4>Example H4 HTML title</h4>',
    ];
  }

  // Render element HTML
  public function render() {
    echo isset( $this->settings['exampleHtml'] ) ? $this->settings['exampleHtml'] : esc_html__( 'No HTML provided.', 'bricks' );
  }
}
```

:::note
You don't need to define your own element CSS and JS controls. Those are already available when editing the element under the Style tab "CSS" control group.
:::

---


## Color Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/color-control/*

The color control is a custom-built color picker that you won't find anywhere else.

It lets you pick and adjust colors in `hex`, `rgba` and `hsl` format. It also includes a global color palette to save any color for later reuse anywhere else on your site.

Define your own default color palette with the `bricks/builder/color_palette` filter.

You can set the CSS `property` to `color` or `background-color` as illustrated in the example below.

```php
class Prefix_Element_Color extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    // Text color applied to '.prefix-element-test-title'
    $this->controls['exampleColor'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Title color', 'bricks' ),
      'type' => 'color',
      'inline' => true,
      'css' => [
        [
          'property' => 'color',
          'selector' => '.prefix-element-test-title',
        ]
      ],
      'default' => [
        'hex' => '#3ce77b',
        'rgb' => 'rgba(60, 231, 123, 0.9)',
      ],
    ];

    // Background color applied to '.prefix-element-test-content'
    $this->controls['exampleBackgroundColor'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Background color', 'bricks' ),
      'type' => 'color',
      'inline' => true,
      'css' => [
        [
          'property' => 'background-color',
          'selector' => '.prefix-element-test-content',
        ]
      ],
      'default' => [
        'hex' => '#1ebea5',
        'rgb' => 'rgba(30, 190, 165, 0.8)',
      ],
    ];
  }

  // Render element HTML
  public function render() {
    echo '<h5 class="prefix-element-test-title">' . get_bloginfo( 'name' ) . '</h5>';
    echo '<p class="prefix-element-test-content">Just some bogus text ..</p>';
  }
}

```

### Color palette filter

Add the following PHP code into the funcions.php file of your [chil](https://docs.bricksbuilder.io/article/71-child-theme)[d theme](/developer/guides/child-theme/) to add your own colors to the default color palette (option #1) or replace all default colors with your own choice of colors (option #2).

```php
// functions.php
add_filter( 'bricks/builder/color_palette', function( $colors ) {
  // Option #1: Add individual color
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

:::note
If you have saved any custom colors with the builder you need to reset your global settings in order for your new default colors to take effect.
:::

---


## Datepicker Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/datepicker-control/*

The datepicker control provides a great interface for selecting a specific date and time and outputting it in the [format of your choice](http://hilios.github.io/jQuery.countdown/documentation.html#directives).

The Datepicker control leverages the Flatpickr library to offer a robust date selection interface. Since Bricks 1.9.8 an `options` property has been added which allows for further customization.

## Properties:

### Property: options (since 1.9.8)

- **Type:** array (associative)
- **Description:** Enables customization of the datepicker by passing an associative array of options defined in the Flatpickr library.
- **Default values:**
  - **enableTime:** Defaults to `true` unless explicitly set through a passed property.
  - **altInput:** Defaults to `true` unless specified otherwise through a passed property.

**Example usage:**

```php
$this->controls['date'] = [
  'tab' => 'content',
  'label' => esc_html__('Date', 'bricks'),
  'type' => 'datepicker',
  'options' => [
    'enableTime' => true,  // Enables time selection.
    'time_24hr' => true,   // Displays time picker in 24-hour mode.
    'noCalendar' => true   // Hides the calendar day selection.
  ]
];
```

In this example, the `options` array is configured to create a time picker that operates in 24-hour format without showing a calendar for day selection. The `enableTime` option is set to true to ensure time can be selected, `time_24hr` is enabled for 24-hour time format, and `noCalendar` is set to true to hide the calendar component. Adjust the `options` array as needed to customize the datepicker to meet different requirements.

For a full list of customizable options available in Flatpickr, please refer to the [Flatpickr Options documentation](https://flatpickr.js.org/options/).

### Property: enableTime

- **Type:** boolean
- **Description:** Determines whether time selection is enabled. Overridden if any settings are passed in the `options` property.
- **Default:** true

### Property: altInput

- **Type:** boolean
- **Description:** Enables an alternative, more user-friendly input style. Overridden if any settings are passed in the `options` property.
- **Default:** true

## Example: Countdown element

```php
// Example: Countdown element
class Prefix_Element_Countdown extends \Bricks\Element {
  public $category = 'general';
  public $name     = 'countdown';
  public $icon     = 'ti-timer';
  public $scripts  = ['bricksCountdown'];

  public function get_label() {
    return esc_html__( 'Countdown', 'bricks' );
  }

  public function set_controls() {
    $this->controls['date'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Date', 'bricks' ),
      'type' => 'datepicker',
      'options' => ['enableTime' => true, 'altInput' => true],
      'default' => '2019-01-01 12:00',
    ];

    $this->controls['format'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Format', 'bricks' ),
      'type' => 'text',
      'default' => '%D days %H hours %M minutes %S seconds.',
      'description' => sprintf(
        '%s <a target="_blank" href="http://hilios.github.io/jQuery.countdown/documentation.html#directives">%s</a>.',
        esc_html__( 'For formatting options see', 'bricks' ),
        esc_html__( 'directives', 'bricks' )
      ),
    ];
  }

  public function render() {
    $this->set_attribute( 'wrapper', 'class', 'countdown-wrapper' );

    $countdown_options = [
      'date' => isset( $this->settings['date'] ) ? $this->settings['date'] : '',
      'format' => isset( $this->settings['format'] ) ? $this->settings['format'] : '',
    ];

    $this->set_attribute( 'wrapper', 'data-bricks-countdown-options', wp_json_encode( $countdown_options ) );

    // Render
    if ( ! isset( $this->settings['date'] ) || ! isset( $this->settings['format'] ) ) {
      return $this->render_element_placeholder( [
        'icon-class' => 'ti-timer',
        'text'       => esc_html__( 'No date/format set.', 'bricks' ),
      ] );
    } else {
      echo '<div ' . $this->render_attributes( 'wrapper' ) . '></div>';
    }
  }
}
```

---


## Dimensions Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/dimensions-control/*

The dimensions control is perfect for adding multi-directional CSS properties such as margin and padding (top/right/bottom/left). You can set the directions to anything you want via the `directions` property.

```php
class Prefix_Element_Dimensions extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleDimensions'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Title padding', 'bricks' ),
      'type' => 'dimensions',
      'css' => [
        [
          'property' => 'padding',
          'selector' => '.prefix-element-dimensions-title',
        ]
      ],
      'default' => [
        'top' => '30px',
        'right' => 0,
        'bottom' => '10em',
        'left' => 0,
      ],
      // 'unitless' => false, // false by default
      // Custom directions
      // 'directions' => [
        // 'offsetX' => esc_html__( 'Offset X', 'bricks' ),
        // 'offsetY' => esc_html__( 'Offset Y', 'bricks' ),
        // 'spread'  => esc_html__( 'Spread', 'bricks' ),
        // 'blur'    => esc_html__( 'Offset Y', 'bricks' ),
      // ],
    ];
  }

  // Render element HTML
  public function render() {
    echo '<h5 class="prefix-element-dimensions-title">' . get_bloginfo( 'name' ) . '</h5>';
  }
}
```

---


## Direction Control (Flexbox)

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/direction-control/*

Use the direction control to allow users to set the `flex-direction` CSS property of your CSS flexbox layout.

```php
public function set_controls() {
  $this->controls['direction'] = [ // Setting key
    'tab'   => 'content',
    'label' => esc_html__( 'Direction', 'bricks' ),
    'type'  => 'direction',
    'css'   => [
      [
        'property' => 'flex-direction',
        'selector' => '.flexbox-wrapper',
        // 'id'       => '', // Leave 'id' empty to apply to .flexbox-wrapper directly (@since 1.5.6)
      ],
    ],
  ];
}
```

---


## Editor Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/editor-control/*

The editor control provides the default WordPress editor. To directly edit content in the builder preview set the `inlineEditing` properties. See the code example below:

```php
class Prefix_Element_Editor extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleEditor'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Text editor', 'bricks' ),
      'type' => 'editor',
      'inlineEditing' => [
        'selector' => '.text-editor', // Mount inline editor to this CSS selector
        'toolbar' => true, // Enable/disable inline editing toolbar
      ],
      'default' => esc_html__( 'Here goes the content ..', 'bricks' ),
    ];
  }

  // Render element HTML
  public function render() {
    if ( isset( $this->settings['exampleEditor'] ) ) {
      echo '<div class="text-editor">' . $this->settings['exampleEditor'] . '</div>';
    }
  }
}
```

---


## Element Controls

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/element-controls/*

Element controls allow the user to change the content and appearance of an element. You can define the controls of an element with the set_controls() method in your [element PHP class](/developer/elements/create-your-own-elements/).

Example element class with control parameters for control `testColor`:

```php
class Prefix_Element_Test extends \Bricks\Element {
  public function set_controls() {
    $this->controls['testColor'] = [
      'tab' => 'content',
      'group' => 'settings',
      'label' => esc_html__( 'Text color', 'bricks' ),
      'type' => 'color',
      'inline' => true,
      'small' => true,
      'css' => [
        [
          'property' => 'color',
          'selector' => '.content',
          'important' => true, // Optional
        ],
      ],
      'default' => [
        'rgb' => 'rgba(158, 158, 158, .8)',
        'hex' => '#9e9e9e',
      ],
      'pasteStyles' => false,
      'description' => esc_html__( 'Define the content color.', 'bricks' ),
      'required' => ['showText', '!=', ''],
    ];
  }
}
```

The following control parameters are available for all control types. To dive deeper into the arguments of a specific control type select the control from the list at the bottom.

### Universal control arguments

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| tab | string | content | Tab under which to show the control. Accepts: `content` or `style`. |
| group | string |  | Group under which to show the control. By default a control shows ungrouped under the `content` tab. |
| label | string |  | Localized control label. E.g.: `esc_html__( 'Color', 'bricks' ),` |
| type | string |  | Set the control type (see the list below for a list of all available control types). |
| inline | bool | false | Set to true to show control label and input on the same line. |
| small | bool | false | Set to true to show a control input of 60px width. By default inline label and input have equal widths of 50%. |
| css | array |  | Array with CSS rule definitions. Each CSS rule is a separate array and requires a `property` and `selector` parameter. |
| default | string/array |  | Default control value. Either a string or an array (depending on the control type, see control list below for specific control default) |
| pasteStyles | bool | true | Set to true excludes setting from being pasted via the builders' custom right click "Paste Styles". Recommended for all controls that output HTML content instead of CSS. |
| description | string |  | Optional description for controls that need additional explanation or link to a resource. |
| required | array |  | Show control in relation to the setting of another control.

Parameter #1: control ID
Parameter #2: comparison operator:  `=`, `!=`, `>=`, `
Example: `'required' => ['layout', '=', ['list', 'grid']],`
Required condition: Show this control if setting value of control `layout` equals `=` either `list` or `grid`. |

### Controls Types

| Control Type | Output (Content/CSS) |
| --- | --- |
| [apply](/developer/controls/apply-control/) | None |
| [align-items](/developer/controls/align-items-control/) | CSS |
| [audio](/developer/controls/audio-control/) | Content |
| [background](/developer/controls/background-control/) | CSS |
| [border](/developer/controls/border-control/) | CSS |
| [box-shadow](/developer/controls/box-shadow-control/) | CSS |
| [checkbox](/developer/controls/checkbox-control/) | Conditional |
| [code](/developer/controls/code-control/) | Content |
| [color](/developer/controls/color-control/) | CSS |
| [datepicker](/developer/controls/datepicker-control/) | Content |
| [dimensions](/developer/controls/dimensions-control/) | CSS |
| [direction](/developer/controls/direction-control/) | CSS |
| [editor](/developer/controls/editor-control/) | Content |
| [filters](/developer/controls/filters-control/) | CSS |
| [gradient](/developer/controls/gradient-control/) | CSS |
| [icon](/developer/controls/icon-control/) | Content |
| [image](/developer/controls/image-control/) | Content/CSS |
| [image-gallery](/developer/controls/image-gallery-control/) | Content |
| [info](/developer/controls/info-control/) | Builder panel only |
| [justify-content](/developer/controls/justify-content-control/) | CSS |
| [link](/developer/controls/link-control/) | Content |
| [number](/developer/controls/number-control/) | Content/CSS |
| [posts](https://academy.bricksbuilder.io/article/posts-control/) | Content |
| [repeater](/developer/controls/repeater-control/) | Content |
| [select](/developer/controls/select-control/) | Content/CSS |
| [slider](/developer/controls/slider-control/) | Content |
| [svg](/developer/controls/svg-control/) | Content |
| [text](/developer/controls/text-control/) | Content |
| [textarea](/developer/controls/textarea-control/) | Content |
| [text-align](/developer/controls/text-align-control/) | CSS |
| [text-decoration](/developer/controls/text-decoration-control/) | CSS |
| [text-shadow](/developer/controls/text-shadow-control/) | CSS |
| [text-transform](/developer/controls/text-transform-control/) | CSS |
| [typography](/developer/controls/typography-control/) | CSS |

---


## Filters Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/filters-control/*

The filters control offers the following [CSS filters](https://developer.mozilla.org/en-US/docs/Web/CSS/filter): `blur`, `brightness`, `contrast`, `hue`, `invert`, `opacity`, `saturation`, `sepia`.

```php
class Prefix_Element_Filters extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleFilters'] = [
      'tab' => 'content',
      'label' => esc_html__( 'CSS filters', 'bricks' ),
      'type' => 'filters',
      'inline' => true,
      'css' => [
        [
          'property' => 'filter',
          'selector' => '.css-filter',
        ],
      ],
    ];
  }

  // Render element HTML
  public function render() {
    echo '<div class="css-filter">' . echo get_bloginfo( 'name' ); . '</div>';
  }
}
```

:::note
All sections, rows, columns, and elements already have a **CSS Filters** control under the Style tab CSS group.
:::

---


## Gradient Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/gradient-control/*

The gradient control lets you define an unlimited number of gradients that you can apply to text, background, and as an overlay.

You can set the CSS selector in the control, adjust the angle between 0 and 360°, and set a color stop for each color.

```php
class Prefix_Element_Gradient extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleGradient'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Gradient', 'bricks' ),
      'type' => 'gradient',
      'css' => [
        [
          'property' => 'background-image',
        ],
      ],
    ];
  }

  // Render element HTML
  public function render() {
    echo get_bloginfo( 'name' );
  }
}
```

:::note
All sections, rows, columns, and elements already have a **CSS Gradient** control under the Style tab Gradient / Overlay group.
:::

---


## Icon Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/icon-control/*

The icon control lets you select and output icons from the following icon font libraries:

- [Fontawesome 6](https://fontawesome.com/icons?d=gallery&m=free)
- [Ionicons 4](https://ionic.io/ionicons/v4/cheatsheet.html)
- [Themify](https://themify.me/themify-icons)

The user can also select individually uploaded SVG files if you've enabled "**SVG Uploads**" under `Bricks > Settings` in your WordPress dashboard, and custom icon sets since Bricks 2.0.

```php
class Prefix_Element_Icon extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleIcon'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Icon', 'bricks' ),
      'type' => 'icon',
      'default' => [
        'library' => 'themify', // fontawesome/ionicons/themify
        'icon' => 'ti-star',    // Example: Themify icon class
      ],
      'css' => [
        [
          'selector' => '.icon-svg', // Use to target SVG file
        ],
      ],
    ];
  }

  // Render element HTML
  public function render() {
    // Set icon 'class' attribute
    if ( isset( $this->settings['exampleIcon'] ) ) {
      Helpers::render_control_icon( $settings['exampleIcon'], ['test-class', 'test-class-2'] );
    }
  }
}
```

---


## Image Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/image-control/*

The image control lets you select a single image from your media library. Once an image has been selected you can choose the image size.

You can either use the returned image `id` and `size` to render an image on your page or as a `background-image` via the CSS control property. See the code example below.

:::note
**TIP:** Select the smallest possible image size in which the image still looks crisp. This helps to reduce the loading time of your website and is great for SEO, as loading times are an important ranking factor for search engines.
:::

```php
class Prefix_Element_Image extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleImage'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Image', 'bricks' ),
      'type' => 'image',
      // Use the selected image as a background image
      // 'css' => [
      //   [
      //     'property' => 'background-image',
      //     'selector' => '.bricks-video-overlay-image',
      //   ],
      // ],
    ];
  }

  // Render element HTML
  public function render() {
    // Dump 'exampleImage' settings on the screen
    // var_dump( $this->settings['exampleImage'] );

    if ( isset( $this->settings['exampleImage'] ) ) {
      // Render <img> tag by prodiving image 'id' and 'size'
      //
      echo wp_get_attachment_image(
        $this->settings['exampleImage']['id'],
        $this->settings['exampleImage']['size'],
        false,
        [] // Image attributes
      );
    } else {
      esc_html_e( 'No image selected.', 'bricks' );
    }
  }
}
```

---


## Image Gallery Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/image-gallery-control/*

The image gallery control lets you select multiple images from your media library. Once images have been selected you can choose the image size.

Your selected images are stored in an array, which you have to loop through (see code example below). Use the `id` and `size`  of each image to render it on your page.

:::note
**Tip #1:** Hold down the *SHIFT* key in order to select multiple image in your media library.
:::

:::note
**Tip #2:** Select the smallest possible image size in which the image still looks crisp. This helps to reduce the loading time of your website and is great for SEO, as loading times are an important ranking factor for search engines.
:::

```php
class Prefix_Element_Image extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleImageGallery'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Image gallery', 'bricks' ),
      'type' => 'image-gallery',
    ];
  }

  // Render element HTML
  public function render() {
    if ( isset( $this->settings['exampleImageGallery'] ) ) {
      foreach( $this->settings['exampleImageGallery'] as $index => $image ) {
        echo wp_get_attachment_image(
          $image['id'],
          $image['size'],
          false,
          ['class' => 'css-filter']
        );
      }
    } else {
      esc_html_e( 'No image(s) selected.', 'bricks' );
    }
  }
}
```

---


## Info Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/info-control/*

The info control does not affect the HTML or CSS on the frontend. It serves as a builder-only helper controls to provide additional information.

Example below: the **Alert** element displays an info control when the *Type* is set to *Custom*.

```php
class Prefix_Element_Info extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['type'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Type', 'bricks' ),
      'type' => 'select',
      'options' => [
        'info' => esc_html__( 'Info', 'bricks' ),
        'success' => esc_html__( 'Success', 'bricks' ),
        'warning' => esc_html__( 'Warning', 'bricks' ),
        'danger' => esc_html__( 'Danger', 'bricks' ),
        'muted' => esc_html__( 'Muted', 'bricks' ),
        'custom' => esc_html__( 'Custom', 'bricks' ),
      ],
      'inline' => true,
      'clearable' => false,
      'pasteStyles' => false,
      'default' => 'info',
    ];

    $this->controls['typeInfo'] = [
      'tab' => 'content',
      'content' => esc_html__( 'Customize alert in STYLE tab.', 'bricks' ),
      'type' => 'info',
      'required' => ['type', '=', 'custom'], // Show info control if 'type' = 'custom'
    ];
  }
}
```

---


## Justify Content Control (Flexbox)

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/justify-content-control/*

Use the justify-content control to allow users to set the `justify-content` CSS property (alignment along the [main-axis](https://developer.mozilla.org/en-US/docs/Web/CSS/justify-content)) of your CSS flexbox layout.

There is also a [`align-items`](/developer/controls/align-items-control/) control to allow users to set the alignment along the cross axis of your CSS flexbox layout:

```php
public function set_controls() {
  $this->controls['justifyContent'] = [
    'tab'   => 'content',
    'label' => esc_html__( 'Justify content', 'bricks' ),
    'type'  => 'justify-content',
    'css'   => [
      [
        'property' => 'justify-content',
        'selector' => '.flexbox-wrapper',
      ],
    ],
    // 'isHorizontal' => false,
    // 'exclude' => [
      // 'flex-start',
      // 'center',
      // 'flex-end',
      // 'space-between',
      // 'space-around',
      // 'space-evenly',
    // ],
  ];
}
```

---


## Link Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/link-control/*

The link control give you the choice of different link types:

- Internal post/page
- External URL
- Popup (image, video)

```php
class Prefix_Element_Link extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleLink'] = [
      'tab'         => 'content',
      'label'       => esc_html__( 'Link', 'bricks' ),
      'type'        => 'link',
      'pasteStyles' => false,
      'placeholder' => esc_html__( 'http://yoursite.com', 'bricks' ),
      // 'exclude'     => [
      //  'rel',
      //  'newTab',
      // ],
    ];
  }

  // Render element HTML
  public function render() {
    if ( isset( $this->settings['exampleLink'] ) ) {
      // Set link attributes by passing attribute key and link settings
      $this->set_link_attributes( 'a', $this->settings['exampleLink'] );

      echo '<a ' . $this->render_attributes( 'a' ) . '>' . get_bloginfo( 'name' ) . '</a>';
    } else {
      esc_html_e( 'No link provided.', 'bricks' );
    }
  }
}
```

---


## Number Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/number-control/*

The number control represents a simple number input field. It has the following custom properties:

- units (optional: boolean or array)
- unit (string: `px`, `em`, `rem` etc.)
- min (number)
- step (Default: 1) (Custom: '0.1' etc.)

Use it to render a number to the page or set the `css` control property to target a specific CSS style.

```php
class Prefix_Element_Number extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleNumber'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Number', 'bricks' ),
      'type' => 'number',
      'min' => 0,
      'step' => '0.1', // Default: 1
      'inline' => true,
      'default' => 123,
    ];

    $this->controls['examplePadding'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Padding in px', 'bricks' ),
      'type' => 'number',
      'unit' => 'px',
      'inline' => true,
      'css' => [
        [
          'property' => 'padding',
        ],
      ],
      'default' => 33,
    ];
  }

  // Render element HTML
  public function render() {
    if ( isset( $this->settings['exampleNumber'] ) ) {
      echo esc_html__( 'Number: ', 'bricks' ) . $this->settings['exampleNumber'];
    } else {
      esc_html_e( 'No number provided.', 'bricks' );
    }
  }
}
```

---


## Query Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/query-control/*

The query control lets you set query arguments to retrieve items of any post type. Use the returned value to set up a custom `WP_Query` to render the matching posts in any way you want.

```php
class Prefix_Element_Posts extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleQueryArgs'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Posts', 'bricks' ),
      'type' => 'query',
      // Default required for query to populate
      'default' => [
        'post_type' => 'post',
      ],
    ];
  }

  // Render element HTML
  public function render() {
    $query_args = $this->settings['exampleQueryArgs'];
    $posts_query = new WP_Query( $query_args );

    // Standard WordPress loop
    if ( $posts_query->have_posts() ) :
      while ( $posts_query->have_posts() ) : $posts_query->the_post();
        // Render post title and thumbnail
        the_title( '<h5>', '</h5>' );
        the_post_thumbnail( 'thumbnail' );
      endwhile;

      wp_reset_postdata();
    else :
     esc_html_e( 'No posts matched your criteria.', 'bricks' );
    endif;
  }
}
```

### Resources

- [https://codex.wordpress.org/Class_Reference/WP_Query#Parameters](https://codex.wordpress.org/Class_Reference/WP_Query#Parameters)

---


## Repeater Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/repeater-control/*

The repeater control lets you create repeatable fields. Fields can be cloned, deleted, and sorted via Drag & Drop. Use the `fields` argument to set up the field controls.

```php
class Prefix_Element_Posts extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleRepeater'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Repeater', 'bricks' ),
      'type' => 'repeater',
      'titleProperty' => 'title', // Default 'title'
      'default' => [
        [
          'title' => 'Design',
          'description' => 'Here goes the description for repeater item.',
        ],
        [
          'title' => 'Code',
          'description' => 'Here goes the description for repeater item.',
        ],
        [
          'title' => 'Launch',
          'description' => 'Here goes the description for repeater item.',
        ],
      ],
      'placeholder' => esc_html__( 'Title placeholder', 'bricks' ),
      'fields' => [
        'title' => [
          'label' => esc_html__( 'Title', 'bricks' ),
          'type' => 'text',
        ],
        'description' => [
          'label' => esc_html__( 'Description', 'bricks' ),
          'type' => 'textarea',
        ],
      ],
    ];
  }

  // Render element HTML
  public function render() {
    $items = $this->settings['exampleRepeater'];

    if ( count( $items ) ) {
      foreach ( $items as $item ) {
        echo '<h4>' . $item['title'] . '</h4>';
        echo '<p>' . $item['description'] . '</p>';
      }
    } else {
      esc_html_e( 'No items defined.', 'bricks' );
    }
  }
}
```

---


## Select Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/select-control/*

The select control lets you select an option from a dropdown. It can be used to render content or CSS styling. Use the options array to populate the dropdown with your own options. The option key should be all lowercase, with no spaces.

```php
class Prefix_Element_Posts extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    // Example content
    $this->controls['exampleSelectTitleTag'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Title tag', 'bricks' ),
      'type' => 'select',
      'options' => [
        'h1' => 'H1',
        'h2' => 'H2',
        'h3' => 'H3',
        'h4' => 'H4',
        'h5' => 'H5',
        'h6' => 'H6',
      ],
      'inline' => true,
      'placeholder' => esc_html__( 'Select tag', 'bricks' ),
      'multiple' => true,
      'searchable' => true,
      'clearable' => true,
      'default' => 'h3',
    ];

    // Example CSS
    $this->controls['exampleSelectTextAlign'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Text align', 'bricks' ),
      'type' => 'select',
      'options' => [
        'right' => esc_html__( 'Right', 'bricks' ),
        'center' => esc_html__( 'Center', 'bricks' ),
        'left' => esc_html__( 'Left', 'bricks' ),
      ],
      'inline' => true,
      'css' => [
        [
          'property' => 'text-align',
          'selector' => '.prefix-title',
        ],
      ],
      'placeholder' => esc_html__( 'Select', 'bricks' ),
      'default' => 'center', // Option key
    ];
  }

  // Render element HTML
  public function render() {
    $title_tag = isset( $this->settings['exampleSelectTitleTag'] ) ? $this->settings['exampleSelectTitleTag'] : 'h5';
    echo '<' . $title_tag . ' class="prefix-title">' . get_bloginfo( 'name' ) . '</' . $title_tag . '>';
  }
}
```

---


## Slider Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/slider-control/*

The slider control shows a draggable range input field. Default units are `px`, `em` and `rem`. You can set the following control parameters:

- units (array with custom units and `min`, `max`, `step` attributes)
- unitless (set to `false` for plain number)

```php
class Prefix_Element_Slider extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleSliderFontSize'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Font size', 'bricks' ),
      'type' => 'slider',
      'css' => [
        [
          'property' => 'font-size',
        ],
      ],
      'units' => [
        'px' => [
          'min' => 1,
          'max' => 50,
          'step' => 1,
        ],
        'em' => [
          'min' => 1,
          'max' => 20,
          'step' => 0.1,
        ],
      ],
      'default' => '30px',
      'description' => esc_html__( 'Slider adjusts font size via CSS.', 'bricks' ),
    ];
  }

  // Render element HTML
  public function render() {
    echo '<h3>' . get_bloginfo( 'name' ) . '</h3>';
  }
}
```

### Resources

- [https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/range](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/range)

---


## SVG Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/svg-control/*

The SVG control lets you select an SVG (Scalable Vector Graphic) file from the media library. The selected SVG returns an array with the following keys:

- `id` (media library item ID)
- `filename`
- `url`

We recommend rendering the SVG inline as shown in the code example below. This way you can easily customize it via CSS.

```php
class Prefix_Element_Svg extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleSvg'] = [
      'tab' => 'content',
      'type' => 'svg',
    ];
  }

  // Render element HTML
  public function render() {
    if ( isset( $this->settings['exampleSvg']['url'] ) ) {
      echo file_get_contents( esc_url( $this->settings['exampleSvg']['url'] ) );
    } else {
      esc_html_e( 'No SVG selected.', 'bricks' );
    }
  }
}
```

### Resources

- [https://developer.mozilla.org/en-US/docs/Web/SVG/Element/svg](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/svg)
- [https://css-tricks.com/using-svg/](https://css-tricks.com/using-svg/)

---


## Text Align Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/text-align-control/*

Use the **text-align** control to allow users to set the text-align CSS property like so:

```php
public function set_controls() {
  $this->controls['textAlign'] = [ // Setting key
    'tab' => 'content',
    'label' => esc_html__( 'Text align', 'bricks' ),
    'type' => 'text-align',
    'css' => [
      [
        'property' => 'text-align',
        'selector' => '.text-wrapper',
      ],
    ],
  ];
}
```

---


## Text Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/text-control/*

The text control displays a text input field. You can set the following parameters:

- `spellcheck`: true/false. (Default: false)
- `trigger`: 'keyup'/'enter'. (Default: keyup)
- `inlineEditing`: Set to true to enable

```php
class Prefix_Element_Text extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleText'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Text', 'bricks' ),
      'type' => 'text',
      'spellcheck' => true, // Default: false
      // 'trigger' => 'enter', // Default: 'enter'
      'inlineEditing' => true,
      'default' => 'Here goes your text ..',
    ];
  }

  // Render element HTML
  public function render() {
    if ( isset( $this->settings['exampleText'] ) ) {
      echo $this->settings['exampleText'];
    } else {
      esc_html_e( 'No text provided.', 'bricks' );
    }
  }
}
```

### Resources

- [https://developer.mozilla.org/en-US/docs/Web/SVG/Element/svg](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/svg)
- [https://css-tricks.com/using-svg/](https://css-tricks.com/using-svg/)

---


## Text Decoration Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/text-decoration-control/*

Use the **text-decoration** control to allow users to set the text-decoration CSS property like so:

```php
public function set_controls() {
  $this->controls['textDecoration'] = [ // Setting key
    'tab' => 'content',
    'label' => esc_html__( 'Text decoration', 'bricks' ),
    'type' => 'text-decoration',
    'css' => [
      [
        'property' => 'text-decoration',
        'selector' => '.text-wrapper',
      ],
    ],
  ];
}
```

---


## Text Shadow Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/text-shadow-control/*

The text-shadow control displays a popup that lets you set the CSS text-shadow of a specified HTML text element.

```php
class Prefix_Element_Textarea extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleTextShadow'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Text Shadow', 'bricks' ),
      'type' => 'text-shadow',
      'css' => [
        [
          'property' => 'text-shadow',
          'selector' => '.prefix-text',
        ],
      ],
      'inline' => true,
    ];
  }

  // Render element HTML
  public function render() {
    echo '<h3 class="prefix-text">' . get_bloginfo( 'name' ) . '</h3>';
  }
}
```

### Resources

[https://developer.mozilla.org/en-US/docs/Web/CSS/text-shadow](https://developer.mozilla.org/en-US/docs/Web/CSS/text-shadow)

---


## Text Transform Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/text-transform-control/*

Use the **text-transform** control to allow users to set the text-transform CSS property like so:

```php
public function set_controls() {
  $this->controls['textTransform'] = [ // Setting key
    'tab' => 'content',
    'label' => esc_html__( 'Text transform', 'bricks' ),
    'type' => 'text-transform',
    'css' => [
      [
        'property' => 'text-transform',
        'selector' => '.text-wrapper',
      ],
    ],
  ];
}
```

---


## Textarea Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/textarea-control/*

The textarea control displays a textarea input field. You can set the following parameters:

- `rows` (number. Default: 5)
- `readonly` (true/false. Default: false)
- `spellcheck` (true/false. Default: false)
- `inlineEditing` (true to enable)

```php
class Prefix_Element_Textarea extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleTextarea'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Textarea', 'bricks' ),
      'type' => 'textarea',
      // 'readonly' => true, // Default: false
      'rows' => 10, // Default: 5
      'spellcheck' => true, // Default: false
      'inlineEditing' => true,
      'default' => 'Here goes your content ..',
    ];
  }

  // Render element HTML
  public function render() {
    if ( isset( $this->settings['exampleTextarea'] ) ) {
      echo $this->settings['exampleTextarea'];
    } else {
      esc_html_e( 'No text provided.', 'bricks' );
    }
  }
}
```

---


## Typography Control

*來源網址：https://academy-preview.bricksbuilder.io/developer/controls/typography-control/*

The typography control provides the following CSS properties:

- color
- font-size
- text-align
- text-transform
- font-family
- font-weight
- font-style
- line-height
- letter-spacing
- text-shadow
- text-decoration

Use the `exclude` parameter to hide specific typography properties. Set `popup` to false to show control inline.

```php
class Prefix_Element_Typography extends \Bricks\Element {
  // Set builder controls
  public function set_controls() {
    $this->controls['exampleTypography'] = [
      'tab' => 'content',
      'label' => esc_html__( 'Typography', 'bricks' ),
      'type' => 'typography',
      'css' => [
        [
          'property' => 'typography',
          'selector' => '.prefix-typography',
        ],
      ],
      'inline' => true,
      // 'exclude' => [
      //   'font-family',
      //   'font-weight',
      //   'text-align',
      //   'text-transform',
      //   'font-size',
      //   'line-height',
      //   'letter-spacing',
      //   'color',
      //   'text-shadow',
      // ],
      // 'popup' => false, // Default: true
    ];
  }

  // Render element HTML
  public function render() {
    echo '<h3 class="prefix-typography">' . get_bloginfo( 'name' ) . '</h3>';
  }
}
```

---


## Create Your Own Dynamic Data Tag

*來源網址：https://academy-preview.bricksbuilder.io/developer/dynamic-data/create-your-own-dynamic-data-tag/*

This article is intended for developers who wish to create a custom dynamic data tag within the builder.

The desired outcome should resemble the following example:



![](imgs/bricks-custom-dynamic-tag-fc1c0b72fe.png)

<figcaption>

A custom dynamic tag labeled "My Dynamic Data"

</figcaption>



## Step 1: Register a tag through filter: bricks/dynamic_tags_list

Use the `bricks/dynamic_tags_list` filter to render your custom dynamic data tag in the builder.

```php
add_filter( 'bricks/dynamic_tags_list', 'add_my_tag_to_builder' );
function add_my_tag_to_builder( $tags ) {
  // Ensure your tag is unique (best to prefix it)
  $tags[] = [
    'name'  => '{my_dd_tag}',
    'label' => 'My Dynamic Data',
    'group' => 'My Dynamic Data Group',
  ];

  return $tags;
}
```

## Step 2: Hook on several filters

#### 1) bricks/dynamic_data/render_tag

This will be used when `\Bricks\Integrations\Dynamic_Data\Providers::render_tag()` is called to parse a specific tag.

```php
add_filter( 'bricks/dynamic_data/render_tag', 'get_my_tag_value', 20, 3 );
function get_my_tag_value( $tag, $post, $context = 'text' ) {
  if( ! is_string( $tag ) ) {
    return $tag;
  }
  // $tag is the tag name with the curly braces after priority 10
  // Replace all curly braces
  $clean_tag = str_replace( [ '{', '}' ], '', $tag );

  // Only look for dynamic tag my_dd_tag
  if ( $clean_tag !== 'my_dd_tag' ) {
    return $tag;
  }

  // Do your custom logic here, you should define run_my_dd_tag_logic() function
  $value = run_my_dd_tag_logic();

  return $value;
}

function run_my_dd_tag_logic() {
  // Do your custom logic here
  $my_value = 'My dynamic data value:';

  return $my_value;
}
```

If you intend to accept an argument such as "`my_dd_tag:arg1`", you may need to adjust the logic accordingly. Here is a basic example using PHP logic. For more complex scenarios, you can adapt the logic as needed:

```php
add_filter( 'bricks/dynamic_data/render_tag', 'get_my_tag_value', 20, 3 );
function get_my_tag_value( $tag, $post, $context = 'text' ) {
  if( ! is_string( $tag ) ) {
    return $tag;
  }

  // $tag is the tag name with the curly braces after priority 10
  // Replace all curly braces
  $clean_tag = str_replace( [ '{', '}' ], '', $tag );

  // Only look for dynamic tag starts with my_dd_tag:
  if ( strpos( $clean_tag, 'my_dd_tag:' ) === false ) {
    return $tag;
  }

  // Get argument
  $argument = str_replace( 'my_dd_tag:', '', $clean_tag );

  // Do your custom logic here, you should define run_my_dd_tag_logic() function
  $value = run_my_dd_tag_logic( $argument );

  return $value;
}

function run_my_dd_tag_logic($argument) {
  // Do your custom logic here
  $my_value = 'My dynamic data value: ' . $argument ;

  return $my_value;
}
```

#### 2) bricks/dynamic_data/render_content and bricks/frontend/render_data

These will be used when `\Bricks\Integrations\Dynamic_Data\Providers::render_content()` is invoked to parse strings that may contain various dynamic tags within the content. One of the functions that perform this action is `bricks_render_dynamic_data()`.

:::note
It is crucial to exercise extra caution while working on this aspect, as any mishandling may disrupt the dynamic tag functionality across the entire website.
:::

```php
add_filter( 'bricks/dynamic_data/render_content', 'render_my_tag', 20, 3 );
add_filter( 'bricks/frontend/render_data', 'render_my_tag', 20, 2 );
function render_my_tag( $content, $post, $context = 'text' ) {

  // $content might consists of HTML and other dynamic tags
  // Only look for dynamic tag {my_dd_tag}
  if ( strpos( $content, '{my_dd_tag}' ) === false ) {
    return $content;
  }

  // Do your custom logic here, you should define run_my_dd_tag_logic() function
  $my_value = run_my_dd_tag_logic();

  // Replace the tag with the value you want to display
  $content = str_replace( '{my_dd_tag}', $my_value, $content );

  return $content;
}


```

If your dynamic tag accepts an argument, consider the following example:

```php
add_filter( 'bricks/dynamic_data/render_content', 'render_my_tag', 20, 3 );
add_filter( 'bricks/frontend/render_data', 'render_my_tag', 20, 2 );
function render_my_tag( $content, $post, $context = 'text' ) {

  // $content is the content of the element, including other dynamic tags, HTML, etc.
  // Only look for content starts with {my_dd_tag:
  if ( strpos( $content, '{my_dd_tag:' ) === false ) {
    return $content;
  }

  // Regex to match my_dd_tag: tag
  preg_match_all( '/{(my_dd_tag:[^}]+)}/', $content, $matches );

  // Nothing grouped in the regex, return the original content
  if ( empty( $matches[0] ) ) {
    return $content;
  }

  foreach ( $matches[1] as $key => $match ) {
    $tag = $matches[0][ $key ];

    // Get the dynamic data value, $match is the tag name without the curly brackets
    // Can reuse the get_my_tag_value function created earlier
    $value   = get_my_tag_value( $match, $post, $context );

    // Replace the tag with the transformed value
    $content = str_replace( $tag, $value, $content );
  }

  return $content;
}
```



:::note
Note: Please ensure returning an array with image IDs if your dynamic tag is using on image element (image context). Please refer to the example in our forum threads: [Dynamic data not rendered correctly on image element](https://forum.bricksbuilder.io/t/dynamic-data-not-rendered-correctly-on-image-element/22641/2?u=itchycode)
:::

---


## Create Your Own Elements

*來源網址：https://academy-preview.bricksbuilder.io/developer/elements/create-your-own-elements/*

The Bricks [child theme](/developer/guides/child-theme/), which you can download from your [Bricks account](https://my.bricksbuilder.io/) includes a simple custom element for demonstration purposes. The article below explains in more detail how to create your own elements programmatically.

Creating your own elements with Bricks follows a pattern similar to how you create WordPress widgets. You start by extending the `Bricks\Element` class and populate the required properties and methods for your element.

First, create a new file `element-test.php` in the root folder of your Bricks child theme.

## Blank element class {#builder}

```php
<?php
// element-test.php
if ( ! defined( 'ABSPATH' ) ) exit; // Exit if accessed directly

class Prefix_Element_Test extends \Bricks\Element {
  // Element properties
  public $category     = '';
  public $name         = '';
  public $icon         = '';
  public $css_selector = '';
  public $scripts      = [];
  public $nestable     = false; // true || @since 1.5

  // Methods: Builder-specific
  public function get_label() {}
  public function get_keywords() {}
  public function set_control_groups() {}
  public function set_controls() {}

  // Methods: Frontend-specific
  public function enqueue_scripts() {}
  public function render() {}
}
```

Let's walk through the element builder properties and methods:

| **$category**required | Category name (all lowercase, no spaces). Use any of the predefined element categories (e.g. `general`, `media`, etc.) or assign your own category name.

When setting your own category make sure to provide a translatable category string for the builder using the filter: [bricks/builder/i18n](/developer/hooks/filters/filter-bricks-i18n/) |
| --- | --- |
| **$name**required | Unique element identifier (all lowercase, no spaces). To avoid any conflicts with other elements please prefix your element name, e.g.: `prefix-element-test`. |
| **$icon** | Icon font CSS class. Bricks includes the following icon fonts. Use any icon font CSS class to represent your element in the builder panel:  [Fontawesome 6](https://fontawesome.com/icons?d=gallery&m=free) (i.e. "fas fa-anchor") [Ionicons 4](https://ionicons.com/v4/cheatsheet.html) (i.e. "ion-md-alarm") [Themify Icons](https://themify.me/themify-icons) (i.e. "ti-bolt-alt") |
| **$css_selector** | By default all CSS control settings are applied to the element wrapper:  `.bricks-element-wrapper`. If you want the default CSS selector to target a child HTML element, set this selector here. |
| **$nestable** | Omit for plain elements. Set to `true` to create a [nestable element](/developer/elements/nestable-elements/). |
| **$scripts** | An array of JavaScript scripts that run when an element is rendered on the frontend or updated in the builder. The Counter element, for example, uses a script named "bricksCounter" (defined in *frontend.min.js*).
To load this script we use: `public $scripts = ['bricksCounter'];`
Please prefix all your scripts. E.g.: `prefixElementTest` |
| **get_label()**required | Return localised element label. |
| **get_keywords()** | Array of strings that when matched during the element search display the element in the search results. |
| **set_control_groups()** | By default, all element controls show ungrouped in the builder panel under the "Content" tab. Define custom control groups for your element controls by setting the following properties for each control group:  **title** - Localized control group title**tab** - Set to either "content" or "style" |
| **set_controls()**required | Define element controls. For an overview of all available controls and their settings visit: [Element Controls](/developer/controls/element-controls/) |
| **enqueue_scripts()** | Load element-specific scripts and styles. Those are loaded only on pages where this element is used. Results in better performance. Example: `wp_enqueue_script( 'prefix-element-test', get_template_directory_uri() . '/js/custom.js', ['jquery'], '1.0', true );` |
| **render()**required | Renders element HTML. Define HTML attributes via  `$this->set_attribute() `and output them via `$this->render_attribute()` |
| **set_attribute( **$key, $attribute, $value **)** | Helper function to set HTML attributes for any HTML tag. `$key` serves as the unique identifier for this HTML tag. `$attribute` is the HTML attribute name. `$value` is a string or array which holds the attribute value(s). |
| **render_attributes(** $key **)** | Helper function to render HTML attributes defined via `$this->set_attribute()`. $key serves as the unique identifier for this HTML tag. |
| **render_dynamic_data_tag(** $tag, $context, $args **)** | Helper function to render dynamic data tags inside the render function using `$this->render_dynamic_data_tag(...)`. An example of a `$tag` is the `{post_title}`. Using this helper function sets the correct post Id depending on the environment where the element is being rendered. |
| **render_dynamic_data(** $content **)** | Helper function to render content (string) that could contain dynamic data tags. Use this helper function inside the render function calling `$this->render_dynamic_data(...)`. Using this helper function sets the correct post Id depending on the environment where the element is being rendered. |

Let's populate our element properties and methods with some data:

```php
<?php
// element-test.php

if ( ! defined( 'ABSPATH' ) ) exit; // Exit if accessed directly

class Prefix_Element_Test extends \Bricks\Element {
  // Element properties
  public $category     = 'general'; // Use predefined element category 'general'
  public $name         = 'prefix-test'; // Make sure to prefix your elements
  public $icon         = 'ti-bolt-alt'; // Themify icon font class
  public $css_selector = '.prefix-test-wrapper'; // Default CSS selector
  public $scripts      = ['prefixElementTest']; // Script(s) run when element is rendered on frontend or updated in builder

  // Return localised element label
  public function get_label() {
    return esc_html__( 'Test element', 'bricks' );
  }

  // Set builder control groups
  public function set_control_groups() {
    $this->control_groups['text'] = [ // Unique group identifier (lowercase, no spaces)
      'title' => esc_html__( 'Text', 'bricks' ), // Localized control group title
      'tab' => 'content', // Set to either "content" or "style"
    ];

    $this->control_groups['settings'] = [
      'title' => esc_html__( 'Settings', 'bricks' ),
      'tab' => 'content',
    ];
  }

  // Set builder controls
  public function set_controls() {
    $this->controls['content'] = [ // Unique control identifier (lowercase, no spaces)
      'tab' => 'content', // Control tab: content/style
      'group' => 'text', // Show under control group
      'label' => esc_html__( 'Content', 'bricks' ), // Control label
      'type' => 'text', // Control type
      'default' => esc_html__( 'Content goes here ..', 'bricks' ), // Default setting
    ];

    $this->controls['type'] = [
      'tab' => 'content',
      'group' => 'settings',
      'label' => esc_html__( 'Type', 'bricks' ),
      'type' => 'select',
      'options' => [
        'info' => esc_html__( 'Info', 'bricks' ),
        'success' => esc_html__( 'Success', 'bricks' ),
        'warning' => esc_html__( 'Warning', 'bricks' ),
        'danger' => esc_html__( 'Danger', 'bricks' ),
        'muted' => esc_html__( 'Muted', 'bricks' ),
      ],
      'inline' => true,
      'clearable' => false,
      'pasteStyles' => false,
      'default' => 'info',
    ];
  }

  // Enqueue element styles and scripts
  public function enqueue_scripts() {
    wp_enqueue_script( 'prefix-test-script' );
  }

  // Render element HTML
  public function render() {
    // Set element attributes
    $root_classes[] = 'prefix-test-wrapper';

    if ( ! empty( $this->settings['type'] ) ) {
      $root_classes[] = "color-{$this->settings['type']}";
    }

    // Add 'class' attribute to element root tag
    $this->set_attribute( '_root', 'class', $root_classes );

    // Render element HTML
    // '_root' attribute is required (contains element ID, class, etc.)
    echo "<div {$this->render_attributes( '_root' )}>"; // Element root attributes
      if ( ! empty( $this->settings['content'] ) ) {
        echo "<div>{$this->settings['content']}</div>";
      }
    echo '</div>';
  }
}
```

You can view all element controls over at: [https://academy.bricksbuilder.io/topic/controls/](https://academy.bricksbuilder.io/topic/controls/)

:::note
All element settings are stored in `$this->settings`. To view of element settings you can print them on the screen like so: `var_dump( $this->settings );` in the `render()` function.
:::

## Load and register your element {#register}

After creating your custom element you need to load and register your element. Open up `functions.php` of your Bricks child theme and copy & paste the following code:

```php
/**
 * Register custom elements
 */
add_action( 'init', function() {
  $element_files = [
    __DIR__ . '/element-test.php',
  ];

  foreach ( $element_files as $file ) {
    \Bricks\Elements::register_element( $file );
  }
}, 11 );
```

The `register_element` method accepts 3 arguments:

- `$file` (required): The full path to the custom element PHP file in the server
- `$name` (optional): A string containing the name of the custom element (e.g.: `prefix-element-test`)
- `$element_class` (optional): A string containing the class name of the element (e.g.: `Prefix_Element_Test`) which should derive from the Bricks element class (`\Bricks\Element`)

:::note
**Note:** Using the `$name` and `$element_class` arguments will improve the loading performance.
:::

---


## Nestable Elements (API)

*來源網址：https://academy-preview.bricksbuilder.io/developer/elements/nestable-elements/*

Bricks 1.5 introduces **Nestable Elements**. Plus an API that allows you to programmatically define your own custom elements that can contain other elements. In exactly the structure you want.

Prior to Bricks 1.5 every element in Bricks was "flat". Meaning even though an element contained a deep HTML structure (like the Slider, etc.) you couldn't click on an inner part of this element to edit it directly (e.g. contents of slide 3), or change the inner structure of it to your liking via Drag & Drop, as you could do inside a layout element.

Making it often impossible to properly customise more complex elements like the Icon Box, Pricing Table, List, etc.

Complex elements such as the Accordion, Slider, and Tabs weren't properly customisable at all.

## Full Access & Control Over Individual Element Structure

Starting at version 1.5, Bricks provides three nestable elements:

- Accordion (Nestable)
- Slider (Nestable)
- Tabs (Nestable)

Those elements were notoriously hard to properly customise due to their complex structure, and the limits of their "flat" element structure.

Now that you can populate every slide with the elements you want, purpose-specific slider-like elements such as the "Carousel" & "Team Members" are not really needed.



![](imgs/bricks-1.5-nestable-accordion-1024x398-2a11a4c782.jpg)

<figcaption>

Accordion - Nestable

</figcaption>



:::note
Nestable elements are going to exist alongside their flat origin elements for the foreseeable future until we have collected enough feedback & fixed any major bugs in order to fully make the switch to nestable elements.
:::

:::note
Certain interactive nestable elements that are heavily JavaScript-driven (such as the Accordion, Slider, and Tabs) might prevent the Drag & drop from working 100% on the canvas. If you encounter this behavior you can always add & order elements by using the Structure panel too.
:::

:::note
**Nestable tabs**: If you need to change the `display` property of the tab "pane", please do so by adding another "Block" element inside the panel and setting the `display` setting there. The pane itself uses `display: none` in order to hide all non-active panes. If you change the display setting there, all tab panes will always be visible.
:::

So you can start playing around with those new nestable elements, and slowly transition away from the old plain elements.

Over time we'll convert more and more `flat` elements into nestable elements, so that you'll be able to properly customize most elements in Bricks once their nestable equivalent becomes available.

## Nestable Elements API {#api}

The rest of this article shows how to programmatically create your own nestable elements.

A good starting point to learn about the new nestable elements syntax is to inspect the Bricks source code of the following nestable element files:

- accordion-nested.php
- slider-nested.php
- tabs-nested.php

### Define Your Custom Element As "nestable"

First make sure to set the [`$nestable`](/developer/elements/create-your-own-elements/#builder) property of your custom element class to `true`.

This is required so Bricks knows to render this custom element using the nestable render function in the builder, and to enable drag & drop inside the builder for this custom element.

### Nestable Element Template

You can define the structure of your custom element via the `get_nestable_children` function. It expects to return an array of element definitions.

This is best illustrated by having a look at the Nestable Slider elements' `get_nestable_children` function:

```php
public function get_nestable_children() {
  return [
      [
        'name'     => 'block',
        'label'    => esc_html__( 'Slide', 'bricks' ) . ' {item_index}',
        'settings' => [
          '_hidden' => [
            '_cssClasses' => 'hidden-class', // CSS class not visible in builder UI
          ],
        ],
        'children' => [
            [
              'name'     => 'heading',
              'settings' => [
                'text' => esc_html__( 'Slide', 'bricks' ) . ' {item_index}',
              ],
            ],
            [
              'name'     => 'button',
              'settings' => [
                'text'  => esc_html__( 'I am a button', 'bricks' ),
                'size'  => 'lg',
                'style' => 'primary',
              ],
            ],
          ],
      ],
  ];
}
```

The code above adds a "Slide" block inside the nestable slider, which then contains a "Heading" & "Button" element.

The `children` property, if set, accepts an array of further nested elements. Specify the `settings` array to populate individual elements inside your nestable element as needed.

### Nestable Render Function (PHP) {#php}

The only new function you need to add to your PHP `render()` function is called `render_children` and it requires the element instance `$this` to be passed as the first parameter:

```php
public function render() {
  $output = "<div {$this->render_attributes( '_root' )}>";

  // Render children elements (= individual items)
  $output .= Frontend::render_children( $this );

  $output .= '</div>';

  echo $output;
}
```

### Nestable Render Function (Vue x-template) {#x-template}

To render elements inside your nestable element in your custom x-template, simply add the `` component plus `element` props as shown in the following code snippet:

```php
public function render_builder() {
  <script type="text/x-template" id="tmpl-bricks-element-custom-nestable">
    <component :is="tag">
      <h2>Title before nestable children</h2>
      <bricks-element-children :element="element"/>
      <p>Text node after nestable children</p>
    </component>
  </script>
}
```

### Nestable Element Items (in panel)

If your nestable element structure is based on items on the same level (such as our Accordion above), then you can add a Repeater (see builder panel in screenshot above) by adding a `repeater` control with the `items` property set to `children`:

```php
public function set_controls() {
  // Array of nestable element.children (@since 1.5)
  $this->controls['_children'] = [
    'type'          => 'repeater',
    'titleProperty' => 'label',
    'items'         => 'children',
  ];
];
```

:::note
If you are start using and/or experimenting with the new Nestable Elements API for your custom elements, [we'd love to hear your feedback](https://bricksbuilder.io/contact/). Does this API miss any features, did you encounter any bugs?
:::

---


## Function: bricks_render_dynamic_data

*來源網址：https://academy-preview.bricksbuilder.io/developer/functions/function-bricks_render_dynamic_data/*

This helper function will render the dynamic data tags inside of a content string (@since 1.5.5).

```php
echo bricks_render_dynamic_data( $content, $post_id, $context );
```

### Parameters:

- `$content` - a string containing dynamic data tags (required)
- `$post_id` - the post id if needed (default: current post id)
- `$context` - the context where the data is used after rendered: *text*, *link*, *image*, *media* (default: *text*)

### Return:

The string after replacing the dynamic data tags with their content.

Example:

```php
echo bricks_render_dynamic_data('My Post Title: {post_title}');
```

---


## Asset Loading Optimization

*來源網址：https://academy-preview.bricksbuilder.io/developer/guides/asset-loading/*

"Performance" being one of Bricks' three pillars, we have introduced a new asset loading solution in version 1.3.4 that offers you even more control and helps you to further enhance your page loading times and speed results.

https://www.youtube.com/watch?v=O_B19LBtnwM&t=45s

Bricks, by default, serves all styles (CSS) and scripts (JS) through two major files:

- frontend.min.css (293 kb)
- bricks.min.js (354 kb)

This approach ensures that all styles and scripts are always available on any page.

The downside is that those two files together were roughly 650 kb in size. Although, after caching and on subsequent page loads that's not really an issue. But it had a negative impact on the very first visit resulting in longer page loads and affecting visitors on slow/weak networks the most.

Bricks 1.3.4 introduces a new asset delivery solution.

Scripts are now only served as needed. **Reducing the bricks.min.js file size by 90%** (from 354 kb down to 37 kb).

Large styles such as animate.css, icon font libraries, etc. are now only loaded as needed. **Reducing the frontend.min.css file size by 60%** (from 293 kb down to 116 kb).

## How To Reduce Asset Loading Even Further through "External Files" {#external-files}

All default element styles are still loaded inside the frontend.min.css file. Other styles such as global custom CSS, theme styles, template styles, page element styles, color palettes, global element CSS, etc. are loaded via inline styles which adds a lot of repetitive and oftentimes non-cacheable data to every page request.

To further optimize & minimize the loaded styles you can set the "CSS Loading Method" under "Bricks - Settings - Performance" to "**External Files**".

To regenerate all CSS files in one go, please click the "Regenerate CSS files" button located under the "CSS loading method setting. This action is only available after the CSS loading method has been set to "External Files".

**Please click the "Regenerate CSS files" button once you've changed the CSS loading method to "External Files", so Bricks can create the required directory and CSS files.**

This will generate minified CSS files for your Bricks data within the `wp-content/uploads/bricks/css` directory (or whatever you've set as your WordPress "uploads" directory) and serves them as needed according to the requested page.

:::note
If the "External Files" CSS loading method does conflict for some reason with your server or plugin caching solution or outputs incorrect or missing styles, please revert to the default "**Inline Styles**" CSS loading method, and report the issue to us via [email](https://bricksbuilder.io/contact/), so we can address it. Thank you!
:::



![](imgs/bricks-builder-css-loading-method-external-files-1024x835-fdb1608799.png)

<figcaption>

CSS Loading Method: "External Files"

</figcaption>



## How To Enqueue Individual Styles & Scripts {#enqueue}

If you are working with a third-party Bricks plugin or if for some reason a certain style/script is not being loaded as needed, you can always load/enqueue those individually to your own needs by following the instructions below.

What follows is a list of Bricks style & script names which you can enqueue on any of your pages as needed through your child theme's functions.php by hooking into the `wp_enqueue_scripts` WordPress action or inside the `enqueue_scripts` function in case your [custom Bricks element](/developer/elements/create-your-own-elements/) depends on any of those styles and/or scripts.

```php
add_action( 'wp_enqueue_scripts', function() {
  // isotopeJS (e.g. metro & masony layouts)
  wp_enqueue_script( 'bricks-isotope' );
  wp_enqueue_style( 'bricks-isotope' );

  // Icon font files
  wp_enqueue_style( 'bricks-font-awesome-6' );
  wp_enqueue_style( 'bricks-font-awesome-6-brands' );
  wp_enqueue_style( 'bricks-ionicons' );
  wp_enqueue_style( 'bricks-themify-icons' );

  // Animations
  wp_enqueue_style( 'bricks-animate' );

  // Tooltips
  wp_enqueue_style( 'bricks-tooltips' );

  // Datepicker
  wp_enqueue_script( 'bricks-flatpickr' );
  wp_enqueue_style( 'bricks-flatpickr' );

  // swiperJS (e.g. slider, carousel)
  wp_enqueue_script( 'bricks-swiper' );
  wp_enqueue_style( 'bricks-swiper' );

  // Lightbox
  wp_enqueue_script( 'bricks-photoswipe' );
  wp_enqueue_style( 'bricks-photoswipe' );

  // Code prettifier
  wp_enqueue_script( 'bricks-prettify' );
  wp_enqueue_style( 'bricks-prettify' );
}, 11 );
```

---


## Best Practices

*來源網址：https://academy-preview.bricksbuilder.io/developer/guides/best-practices/*

Please keep the points below in mind when working with Bricks:

| **Permalink Settings** | Go to **Settings > Permalinks**, select **Post name,** and click **Save Changes.** |
| --- | --- |
| **Min. Image Dimensions** | Upload images with a minimum width of 600 pixels. Ideally 1600 pixels in width or more.

If you already have images in your media library and start working with Bricks make sure to [Regenerate Thumbnails](https://wordpress.org/plugins/regenerate-thumbnails/) so all Bricks-specific image sizes are generated properly. |
| **Never Edit Theme Code Directly** | **Do not edit any of the Bricks theme core files directly!**

As all your changes will be lost/overwritten when updating the theme. Use the [Bricks child theme](/developer/guides/child-theme/) or a code snippet plugin to extend Bricks with your custom code. |

---


## Bricks CLI

*來源網址：https://academy-preview.bricksbuilder.io/developer/guides/bricks-cli/*

Bricks 1.8.1+ integrates with the [WP-CLI](https://wp-cli.org/) (WordPress Command Line Interface). Allowing you to perform specific tasks from your server's command line interface instead of the GUI (Graphical User Interface).

### Regenerates CSS Files

Requires the Bricks "CSS loading method" to be set to "external files".

`wp bricks regenerate_assets`

---


## Bricks CSS: Compatibility guidelines

*來源網址：https://academy-preview.bricksbuilder.io/developer/guides/bricks-css-compatibility-guidelines/*

Bricks follows the [Baseline](https://developer.mozilla.org/en-US/docs/Glossary/Baseline/Compatibility) compatibility standard to determine which CSS features we natively support in the styles Bricks outputs.

## What is Baseline?

Baseline is a compatibility model that tracks when web platform features become widely interoperable across all major browsers. It defines two key stages:

- **Newly Available**: Feature works across all major browsers (desktop and mobile).
- **Widely Available**: Reached ~30 months after “Newly Available”; safe to use in production for most users globally (~95% support).

Baseline considers support in the following browsers:

- Apple Safari (iOS)
- Apple Safari (macOS)
- Google Chrome (Android)
- Google Chrome (desktop)
- Microsoft Edge (desktop)
- Mozilla Firefox (Android)
- Mozilla Firefox (desktop)

## Which CSS features does Bricks use?

Bricks only uses CSS features that have reached the **Widely Available** stage under Baseline. For example, the [`:where` pseudo-class](https://developer.mozilla.org/en-US/docs/Web/CSS/:where) and [@layer CSS at-rule](https://developer.mozilla.org/en-US/docs/Web/CSS/@layer) are already in that stage and are part of Bricks' output.

![](imgs/mdn-baseline-a649432c9b.png)

## What happens on much older or less common browsers?

We aim to strike the right balance: adopting modern standards when they’re stable and broadly supported, while avoiding unnecessary technical debt or regressions for the majority of users. Adding fallbacks for edge-case devices below the Baseline threshold would compromise code quality and performance for everyone else.

## Does this affect user-added CSS?

No. This only applies to the CSS generated by Bricks.

You can continue writing your own CSS however you like, including fallbacks or feature checks for legacy devices. Bricks just won't include those fallbacks automatically in its own output.

---


## Child Theme

*來源網址：https://academy-preview.bricksbuilder.io/developer/guides/child-theme/*

:::note
Please do not edit any of the Bricks theme core files directly, as updating the theme will cause all your changes to be lost.
:::

Instead, use the Bricks child theme to make modifications and overwrite files. You can download the Bricks child theme directly from your [Bricks account](https://my.bricksbuilder.io/).

Upload this child theme ZIP file (bricks-child.zip) like any other WordPress theme. Go to **Appearance → Themes** and activate **Bricks Child Theme**. You can add your own styles to **style.css**.

## How To Enqueue Scripts (JS) & Styles (CSS)

In order to load your files only on the front end & the canvas and not in the builder panel (as your custom CSS might affect the builder), you have to check against `bricks_is_builder_main()` like this:

```php
add_action( 'wp_enqueue_scripts', function() {
  // Code & check below enqueues your files on the canvas & frontend, not the builder panel. Otherwise custom CSS might affect builder)
  if ( ! bricks_is_builder_main() ) {
    wp_enqueue_style( 'bricks-child', get_stylesheet_uri(), ['bricks-frontend'], filemtime( get_stylesheet_directory() . '/style.css' ) );
  }
} );
```

You can learn more about how a Child Theme works by visiting the official WordPress Codex: [https://developer.wordpress.org/themes/advanced-topics/child-themes/](https://developer.wordpress.org/themes/advanced-topics/child-themes/)

The `functions.php` file of a child theme, unlike `style.css`, does not override the `functions.php` file of the parent theme. Instead, it is loaded in addition to the parent theme's `functions.php`, right before the parent file.

---


## Converter

*來源網址：https://academy-preview.bricksbuilder.io/developer/guides/converter/*

Bricks offers multiple so-called "Converter" options.

The Converter is a built-in tool that scans your database for outdated Bricks data and automatically updates it to the latest valid syntax of the installed version.

:::note
The converter performs changes to the Bricks data in your database. So please perform a full-site backup before running the converter.
:::

To run the Converter, go to "Bricks > Settings > General" and click the "Converter" button.

Depending on your server and the size of your Bricks data, this process can take a minute or two. Please do not close or refresh the page until you see the green "THE END" success message:



![](imgs/bricks-1.4-converter-results-1024x324-bd37047c79.png)

<figcaption>

Converter results: Updated Page Settings & Global Custom CSS

</figcaption>



## What is being converted?

With the improved DOM structure and element ID & class names, Bricks replaced the old `bricks-element-` ID & class name prefix with a more succinct `brx-` prefix.

Running the Converter goes over the following pieces of Bricks data and does an automated "Search & Replace" of those strings for you:

- Bricks global settings
- Bricks page settings
- Bricks page data
- Global elements
- Bricks templates

**You shouldn't have to run the Converter if you aren't using any custom CSS/JS.**

---


## Custom JavaScript events in Bricks

*來源網址：https://academy-preview.bricksbuilder.io/developer/guides/custom-javascript-events-in-bricks/*

Bricks offers a range of custom JavaScript events that you can leverage to enhance the functionality and interactivity of your website. These events allow you to respond to specific actions or changes within your Bricks-powered site. Let's explore the custom events available in Bricks:

## Form element events

- [bricks/form/submit](/builder/features/interactions/#trigger-form-submit) Emitted before an AJAX call for form submission is made.
- [bricks/form/success](/builder/features/interactions/#trigger-form-success) Emitted after a successful form submission AJAX call is returned.
- [bricks/form/error](/builder/features/interactions/#trigger-form-error) Emitted after an error in the form submission AJAX call is returned.

## Tabs / Tabs (Nestable) element events

- [bricks/tabs/changed](#bricks-tabs-changed-code): Emitted after click on a tab title (`@since 1.9.8`)

<span id="bricks-tabs-changed-code"></span>

```php
// Listen for the 'bricks/tabs/changed' event
document.addEventListener('bricks/tabs/changed', (event) => {
  // Extract information from the event detail
  const { elementId, activeIndex, activeTitle, activePane } = event.detail;

  // Only target elementID lwxvfh
  if( elementId !== 'lwxvfh' ) {
    return;
  }

  // Example: Log the details to the console
  console.log(`Tabs Changed - Element ID: ${elementId}, Active Index: ${activeIndex}, Active Title: ${activeTitle}, Active Pane: ${activePane}`);

  // Your custom logic here
  // For example, update the UI based on the tab change
});
```

## Accordion / Accordion (Nestable) element events

- [bricks/accordion/open](#bricks-accordion-open-code): Emitted after an accordion item is opened/expanded via click action (`@since 1.9.8`)
- [bricks/accordion/close](#bricks-accordion-close-code): Emitted after an accordion item is closed/collapsed via click action (`@since 1.9.8`)

<span id="bricks-accordion-open-code"></span>

```php
// Listen for the 'bricks/accordion/open' event
document.addEventListener('bricks/accordion/open', (event) => {
  // Extract information from the event detail
  const { elementId, openItem } = event.detail;

  // Only target elementID qwe3th
  if( elementId !== 'qwe3th' ) {
    return;
  }

  // Example: Log the details to the console
  console.log(`Accordion Opened - Element ID: ${elementId}, Open Item ID: ${openItem}`);

  // Your custom logic here
  // For example, update the UI based on the accordion item being opened
});

```

<span id="bricks-accordion-close-code"></span>

```php
// Listen for the 'bricks/accordion/close' event
document.addEventListener('bricks/accordion/close', (event) => {
  // Extract information from the event detail
  const { elementId, closeItem } = event.detail;

  // Only target elementID qwe3th
  if( elementId !== 'qwe3th' ) {
    return;
  }

  // Example: Log the details to the console
  console.log(`Accordion Closed - Element ID: ${elementId}, Closed Item ID: ${closeItem}`);

  // Your custom logic here
  // For example, update the UI based on the accordion item being closed
});
```

## Animation events

- [bricks/animation/end/\{animationId\}](/builder/features/interactions/#bricks-animation-end-code): Emitted when a specified animation (identified by `{animationId}`) completes its playback.

## Popup events

- [bricks/popup/open](/builder/features/popup-builder/#bricks-popup-open-close-code) Emitted after popup opened.
- [bricks/popup/close](/builder/features/popup-builder/#bricks-popup-open-close-code) Emitted after popup closed.
- [bricks/ajax/popup/start](/builder/features/popup-builder/#ajax-events) Emitted before making an AJAX popup call.
- [bricks/ajax/popup/end](/builder/features/popup-builder/#ajax-events) Emitted after completing an AJAX popup call.
- [bricks/ajax/popup/loaded](/builder/features/popup-builder/#ajax-events) Emitted after adding AJAX popup content to the DOM.

### AJAX popup open event sequence

1. bricks/ajax/popup/start
2. bricks/ajax/popup/end
3. bricks/ajax/popup/loaded
4. bricks/popup/open

## Bricks AJAX events

:::note
Bricks AJAX = Infinite Scroll, Load More, AJAX Pagination, or Query Filter.
:::

- [bricks/ajax/start](#bricks-ajax-start-code): Emitted before a Bricks AJAX call is made.
- [bricks/ajax/end](#bricks-ajax-end-code): Emitted after completing a Bricks AJAX call.
- [bricks/ajax/pagination/completed](#bricks-ajax-pagination-completed-code): Emitted after an AJAX pagination call is completed.
- [bricks/ajax/load_page/completed](#bricks-ajax-load_page-completed-code): Emitted after an Infinite scroll AJAX call is completed.
- [bricks/ajax/query_result/completed](#bricks-ajax-query_result-completed-code): Emitted after a Query filter AJAX call is completed.
- [bricks/ajax/query_result/displayed](#bricks-ajax-query_result-displayed-code): Emitted after adding all filtered results to the DOM.

### Infinite scroll event sequence

1. bricks/ajax/start
2. bricks/ajax/end
3. bricks/ajax/load_page/completed

### AJAX pagination event sequence

1. bricks/ajax/start
2. bricks/ajax/end
3. bricks/ajax/pagination/completed

### AJAX filter event sequence

1. bricks/ajax/start
2. bricks/ajax/end
3. bricks/ajax/query_result/completed
4. bricks/ajax/query_result/displayed



<span id="bricks-ajax-start-code"></span>

```php
document.addEventListener('bricks/ajax/start', (event) => {
  // Get the queryId from the event
  const queryId = event.detail.queryId || false;

  if (!queryId) {
    return;
  }

  // Your custom logic here
  // For example, initiate a loader or update UI to indicate AJAX request start
});
```



<span id="bricks-ajax-end-code"></span>

```php
document.addEventListener('bricks/ajax/end', (event) => {
  // Get the queryId from the event
  const queryId = event.detail.queryId || false;

  if (!queryId) {
    return;
  }

  // Your custom logic here
  // For example, initiate a loader or update UI to indicate AJAX request end
});
```



<span id="bricks-ajax-pagination-completed-code"></span>

```php
document.addEventListener('bricks/ajax/pagination/completed', (event) => {
  // Extract queryId from the event detail
  const queryId = event.detail.queryId;

  // Your custom logic here
  // For example, handle the completed pagination for the specific queryId
});
```



<span id="bricks-ajax-load_page-completed-code"></span>

```php
document.addEventListener('bricks/ajax/load_page/completed', (event) => {
  // Extract information from the event detail
  const { queryTrailElement, queryId } = event.detail;

  // Your custom logic here
  // For example, handle the completed AJAX page load for the specific queryId and queryTrailElement
});
```



<span id="bricks-ajax-query_result-completed-code"></span>

```php
document.addEventListener('bricks/ajax/query_result/completed', (event) => {
  // Extract information from the event detail
  const queryId = event.detail.queryId;

  // Your custom logic here
});
```



<span id="bricks-ajax-query_result-displayed-code"></span>

```php
document.addEventListener('bricks/ajax/query_result/displayed', (event) => {
  // Extract information from the event detail
  const queryId = event.detail.queryId;

  // Your custom logic here
});
```

---
