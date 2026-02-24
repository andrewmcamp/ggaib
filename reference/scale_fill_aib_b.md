# Binned AIB Fill Scale

Creates a binned (stepped) fill gradient between two brand colors.

## Usage

``` r
scale_fill_aib_b(low = "#1B3E6F", high = "#55C8E8", n.breaks = 5, ...)
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
  [`ggplot2::scale_fill_steps()`](https://ggplot2.tidyverse.org/reference/scale_steps.html)
  (e.g., `breaks`, `labels`, `limits`).

## Value

A ggplot2 binned fill scale.
