# Discrete AIB Color Scale

Maps categorical variables to the Annenberg Institute brand palette.
Colors are ordered for maximum visual contrast.

## Usage

``` r
scale_color_aib(...)

scale_colour_aib(...)
```

## Arguments

- ...:

  Additional arguments passed to
  [`ggplot2::discrete_scale()`](https://ggplot2.tidyverse.org/reference/discrete_scale.html).

## Value

A ggplot2 discrete color scale.

## Examples

``` r
library(ggplot2)
ggplot(mtcars, aes(mpg, wt, color = factor(cyl))) +
  geom_point() +
  scale_color_aib()

```
