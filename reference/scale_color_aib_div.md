# Diverging AIB Color Scale

Creates a diverging color gradient. Defaults to red-white-navy.

## Usage

``` r
scale_color_aib_div(
  low = "#C00404",
  mid = "white",
  high = "#1B3E6F",
  midpoint = 0,
  ...
)

scale_colour_aib_div(
  low = "#C00404",
  mid = "white",
  high = "#1B3E6F",
  midpoint = 0,
  ...
)
```

## Arguments

- low:

  Color for the low end. Default is AIB red.

- mid:

  Color for the midpoint. Default is white.

- high:

  Color for the high end. Default is AIB navy.

- midpoint:

  The data value mapped to the midpoint color. Default is 0.

- ...:

  Additional arguments passed to
  [`ggplot2::scale_color_gradient2()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html).

## Value

A ggplot2 diverging color scale.

## Examples

``` r
library(ggplot2)
ggplot(mtcars, aes(mpg, wt, color = hp - mean(hp))) +
  geom_point() +
  scale_color_aib_div()

```
