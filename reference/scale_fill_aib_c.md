# Continuous AIB Fill Scale

Creates a continuous fill gradient between two brand colors.

## Usage

``` r
scale_fill_aib_c(low = "#1B3E6F", high = "#55C8E8", ...)
```

## Arguments

- low:

  Color for the low end of the gradient. Default is AIB navy.

- high:

  Color for the high end of the gradient. Default is AIB sky.

- ...:

  Additional arguments passed to
  [`ggplot2::scale_fill_gradient()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html).

## Value

A ggplot2 continuous fill scale.
