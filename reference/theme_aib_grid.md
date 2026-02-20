# Annenberg Institute Grid Theme

Identical to
[`theme_aib()`](https://andrewmcamp.github.io/ggaib/reference/theme_aib.md)
but defaults to `gridlines = "xy"` for light gray major gridlines. Use
for data-dense plots where gridlines aid readability.

## Usage

``` r
theme_aib_grid(
  base_size = 11,
  base_family = NULL,
  gridlines = c("xy", "x", "y", "none")
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
  theme_aib_grid()

```
