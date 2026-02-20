# Continuous AIB Color Scale

Creates a continuous color gradient between two brand colors. Defaults
to a navy-to-sky gradient.

## Usage

``` r
scale_color_aib_c(low = "#1B3E6F", high = "#55C8E8", ...)

scale_colour_aib_c(low = "#1B3E6F", high = "#55C8E8", ...)
```

## Arguments

- low:

  Color for the low end of the gradient. Default is AIB navy.

- high:

  Color for the high end of the gradient. Default is AIB sky.

- ...:

  Additional arguments passed to
  [`ggplot2::scale_color_gradient()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html).

## Value

A ggplot2 continuous color scale.

## Examples

``` r
library(ggplot2)
ggplot(mtcars, aes(mpg, wt, color = hp)) +
  geom_point() +
  scale_color_aib_c()

```
