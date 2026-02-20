# Annenberg Institute Base Theme

A minimal, publication-quality ggplot2 theme following the Annenberg
Institute at Brown University visual identity. Uses brand fonts with
automatic Google Fonts fallback.

## Usage

``` r
theme_aib(
  base_size = 11,
  base_family = NULL,
  gridlines = c("none", "x", "y", "xy")
)
```

## Arguments

- base_size:

  Base font size in points. Default is 11.

- base_family:

  Override base font family. If `NULL`, uses the registered AIB body
  font.

- gridlines:

  Which major gridlines to display. One of `"none"` (default), `"x"`,
  `"y"`, or `"xy"`.

## Value

A
[`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)
object.

## Examples

``` r
library(ggplot2)
ggplot(mtcars, aes(mpg, wt)) +
  geom_point() +
  theme_aib()


# Add horizontal gridlines
ggplot(mtcars, aes(mpg, wt)) +
  geom_point() +
  theme_aib(gridlines = "y")

```
