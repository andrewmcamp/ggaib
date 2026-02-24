# Binned AIB Color Scale

Creates a binned (stepped) color gradient between two brand colors.
Defaults to a navy-to-sky gradient with 5 breaks. Supply a numeric
vector to `breaks` for custom bin boundaries.

## Usage

``` r
scale_color_aib_b(low = "#1B3E6F", high = "#55C8E8", n.breaks = 5, ...)

scale_colour_aib_b(low = "#1B3E6F", high = "#55C8E8", n.breaks = 5, ...)
```

## Arguments

- low:

  Color for the low end of the gradient. Default is AIB navy.

- high:

  Color for the high end of the gradient. Default is AIB sky.

- n.breaks:

  Number of breaks for automatic binning. Default is 5. Ignored when
  `breaks` is provided explicitly via `...`.

- ...:

  Additional arguments passed to
  [`ggplot2::scale_color_steps()`](https://ggplot2.tidyverse.org/reference/scale_steps.html)
  (e.g., `breaks`, `labels`, `limits`).

## Value

A ggplot2 binned color scale.

## Examples

``` r
library(ggplot2)
ggplot(mtcars, aes(mpg, wt, color = hp)) +
  geom_point() +
  scale_color_aib_b()

```
