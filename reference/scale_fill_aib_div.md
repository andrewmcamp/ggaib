# Diverging AIB Fill Scale

Creates a diverging fill gradient. Defaults to red-white-navy.

## Usage

``` r
scale_fill_aib_div(
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
  [`ggplot2::scale_fill_gradient2()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html).

## Value

A ggplot2 diverging fill scale.
