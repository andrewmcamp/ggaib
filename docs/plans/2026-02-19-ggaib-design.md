# ggaib Package Design

## Overview

**ggaib** is an R package providing ggplot2 themes and color scales following the visual identity of the Annenberg Institute at Brown University. It targets publication-quality figures with a minimal, data-clarity-focused aesthetic.

- **License:** MIT
- **Dependencies:** `ggplot2` (>= 3.4.0), `showtext`, `sysfonts`
- **Suggests:** `knitr`, `rmarkdown`, `scales`

## Color Palette

Eight brand colors, ordered for maximum contrast when used in categorical plots:

| Order | Name    | Hex       |
|-------|---------|-----------|
| 1     | navy    | `#1B3E6F` |
| 2     | red     | `#C00404` |
| 3     | emerald | `#00AF9A` |
| 4     | yellow  | `#EBA900` |
| 5     | sky     | `#55C8E8` |
| 6     | taupe   | `#B6B09D` |
| 7     | brown   | `#503629` |
| 8     | gray    | `#97A3AE` |

Exposed via:
- `aib_colors(...)` — returns a named character vector of hex codes; pass color names to select specific colors
- `aib_pal()` — returns a palette function compatible with ggplot2 scale internals

## Font System

Three font roles with preferred fonts and Google Font fallbacks:

| Role     | Preferred Font   | Google Fallback | Usage                  |
|----------|-----------------|-----------------|------------------------|
| Headings | Area Normal     | Albert Sans     | Plot titles, subtitles |
| Body     | Source Sans Pro  | Source Sans 3   | Axis labels, legends   |
| Serif    | Minion Pro      | Crimson Text    | Annotations, captions  |

### Font Registration (`.onLoad()`)

1. Check if preferred fonts are available via `sysfonts::font_families()`
2. If not found, register Google Font fallback via `sysfonts::font_add_google()`
3. Call `showtext::showtext_auto()` to enable showtext rendering

Users can override by registering their own fonts before loading the package.

## Theme Functions

All themes build on `ggplot2::theme_minimal()`.

### `theme_aib(base_size = 11, base_family = NULL)`

The default publication theme:
- White background, no panel border
- No gridlines
- Thin, dark gray axis lines and ticks
- Title: Area Normal / Albert Sans, bold, left-aligned
- Subtitle: same family, regular weight, slightly smaller
- Axis text: Source Sans / Source Sans 3
- Caption: Minion / Crimson Text, italic
- Legend: bottom position, no title by default, horizontal layout

### `theme_aib_grid(base_size = 11, base_family = NULL)`

For data-dense plots:
- Same as `theme_aib()` but with light gray major gridlines
- No minor gridlines

### `theme_aib_slide(base_size = 16, base_family = NULL)`

For presentations:
- Same as `theme_aib()` but with larger base size (16pt)
- Bolder title weight
- More spacing between elements

### `theme_aib_map(base_size = 11, base_family = NULL)`

For spatial/map plots:
- No axis lines, ticks, or labels
- No gridlines
- Retains title/subtitle/caption styling

## Scale Functions

### Discrete

- `scale_color_aib(...)` — maps categorical variables to brand colors in contrast-first order
- `scale_fill_aib(...)` — same for fill aesthetic

Both accept a `palette` argument for sub-palettes; default uses the full 8-color palette.

### Continuous

- `scale_color_aib_c(low, high, ...)` — gradient between two brand colors; defaults navy to sky
- `scale_fill_aib_c(low, high, ...)` — same for fill

### Diverging

- `scale_color_aib_div(low, mid, high, ...)` — defaults red to white to navy
- `scale_fill_aib_div(low, mid, high, ...)` — same for fill

## Package File Structure

```
ggaib/
├── DESCRIPTION
├── NAMESPACE
├── LICENSE
├── LICENSE.md
├── R/
│   ├── aib_palettes.R      # color definitions, aib_colors(), aib_pal()
│   ├── fonts.R              # font detection + registration logic
│   ├── scale_aib.R          # all scale_color/fill_aib* functions
│   ├── theme_aib.R          # theme_aib(), theme_aib_grid(), theme_aib_slide(), theme_aib_map()
│   └── zzz.R                # .onLoad() hook
├── man/                     # roxygen2-generated docs
├── vignettes/
│   └── introduction.Rmd     # getting started + gallery of example plots
├── .Rbuildignore
├── .gitignore
└── ggaib.Rproj
```

Uses `roxygen2` for documentation and `devtools` workflow. No compiled code, no data files.
