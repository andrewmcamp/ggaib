# Font System

The ggaib package manages fonts automatically so that plots render
consistently across machines. When you load the package, it selects the
best available font for each of three typographic roles — heading, body,
and serif — and tells you what it found.

## Font roles

Every
[`theme_aib()`](https://andrewmcamp.github.io/ggaib/reference/theme_aib.md)
variant assigns fonts to plot elements through three roles:

| Role      | Used for                           | Brand font      | Bundled alternative |
|:----------|:-----------------------------------|:----------------|:--------------------|
| `heading` | Plot title, subtitle, facet strips | Area Normal     | Albert Sans         |
| `body`    | Axis labels, axis titles, legend   | Source Sans Pro | Source Sans 3       |
| `serif`   | Plot caption                       | Minion Pro      | Crimson Text        |

Retrieve the active family name for any role with
[`aib_font()`](https://andrewmcamp.github.io/ggaib/reference/aib_font.md):

``` r
library(ggaib)
#> Brand fonts not found. Using bundled alternatives (Albert Sans, Source Sans 3, Crimson Text).

aib_font("heading")
#> [1] "Albert Sans"
aib_font("body")
#> [1] "Source Sans 3"
aib_font("serif")
#> [1] "Crimson Text"
```

Or retrieve all three at once:

``` r
str(aib_font_families())
#> List of 3
#>  $ heading: chr "Albert Sans"
#>  $ body   : chr "Source Sans 3"
#>  $ serif  : chr "Crimson Text"
```

## How fonts are selected

When the package loads it works through a three-tier priority list for
each role:

1.  **Brand font** — If the preferred font (e.g. Area Normal) is
    installed on the system, it is used directly.
2.  **Bundled alternative** — If the brand font is not found, ggaib
    registers an open-source substitute shipped in the package’s
    `inst/fonts` directory using
    [`systemfonts::register_font()`](https://systemfonts.r-lib.org/reference/register_font.html).
    Each alternative is bundled in four weights (regular, italic, bold,
    and bold italic).
3.  **System default** — If font registration fails entirely (for
    example, if systemfonts is unavailable), the package falls back to
    the generic `"sans"` and `"serif"` families.

Because the bundled fonts are included in the package itself, the
fallback works offline and does not require downloading anything at
runtime.

## Startup messages

When ggaib is attached it prints a single line indicating which tier is
active. The message corresponds to one of four scenarios:

    ## All brand fonts installed
    Using AIB brand fonts (Area Normal, Source Sans Pro, Minion Pro).

    ## No brand fonts; bundled alternatives registered
    Brand fonts not found. Using bundled alternatives (Albert Sans, Source Sans 3, Crimson Text).

    ## Font registration failed
    Font registration failed. Using system defaults (sans/serif).

    ## Mixed (some brand, some bundled)
    Fonts: Area Normal (brand), Source Sans 3 (bundled), Crimson Text (bundled).

If you see the “bundled alternatives” message, plots will still look
consistent — the open-source fonts were chosen to be close typographic
matches for the brand typefaces.

## Graphics device

The font system relies on the
[systemfonts](https://github.com/r-lib/systemfonts) package to register
bundled fonts. For these registered fonts to render correctly, use a
graphics device that supports systemfonts, such as the
[ragg](https://ragg.r-lib.org) package:

``` r
# In an R script
ragg::agg_png("plot.png", width = 7, height = 5, units = "in", res = 300)
print(p)
dev.off()
```

RStudio and Quarto use ragg by default when it is installed. In an
RMarkdown document, set the device in the chunk options:

    ```{r, dev = "ragg_png"}
    ```
