# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working
with code in this repository.

## Package Overview

ggaib is an R package providing ggplot2 themes and color scales for the
Annenberg Institute at Brown University. It has 20 exported functions
across four areas: themes (4 variants), color/fill scales (discrete,
continuous, diverging), a brand color palette, and font management with
Google Fonts fallback.

## Development Commands

``` r
devtools::load_all()        # Load package for interactive development
devtools::test()            # Run all tests
testthat::test_file("tests/testthat/test-theme_aib.R")  # Run a single test file
devtools::check()           # Full R CMD check
roxygen2::roxygenise()      # Regenerate documentation from roxygen comments
pkgdown::build_site()       # Build documentation website
```

## Architecture

**Theme composition pattern:**
[`theme_aib()`](https://andrewmcamp.github.io/ggaib/reference/theme_aib.md)
is the base. Variants (`theme_aib_grid`, `theme_aib_slide`,
`theme_aib_map`) layer additional `theme()` calls on top of it rather
than duplicating code.

**Font fallback system** (`R/fonts.R`): Uses a private environment
(`.aib_env`) to store registered fonts. On package load (`.onLoad` in
`R/zzz.R`),
[`register_aib_fonts()`](https://andrewmcamp.github.io/ggaib/reference/register_aib_fonts.md)
attempts local fonts first, then Google Fonts via sysfonts, then system
defaults. Three font roles: heading, body, serif.

**Scale wrappers** (`R/scale_aib.R`): Thin wrappers around
[`ggplot2::discrete_scale()`](https://ggplot2.tidyverse.org/reference/discrete_scale.html),
`scale_color_gradient()`, and `scale_color_gradient2()`. Both `color`
and `colour` spellings are exported to match ggplot2 convention.

**Brand colors** (`R/aib_palettes.R`): 8 named colors (navy, red,
emerald, yellow, sky, taupe, brown, gray).
[`aib_pal()`](https://andrewmcamp.github.io/ggaib/reference/aib_pal.md)
returns a function compatible with ggplot2’s scale system. Warns when n
\> 8.

## Testing

Uses testthat Edition 3. Tests validate theme element types (e.g.,
`element_blank` vs `element_line`), scale classes, color hex formats,
error handling for invalid inputs, and integration with ggplot objects.

## Documentation

- Roxygen2 with markdown mode generates `man/*.Rd` files and `NAMESPACE`
- README is generated from `README.Rmd` — edit the `.Rmd`, not `.md`
- Figures render at 600 DPI using ragg (`_pkgdown.yml` and `README.Rmd`)
- Examples use simulated education data relevant to Annenberg
  Institute’s mission
