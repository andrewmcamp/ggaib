# Axis Label Formatters

Convenience wrapper that returns label functions for common axis
formats. The returned function can be passed directly to the `labels`
argument of any `scale_*_continuous()` call.

## Usage

``` r
aib_label(type = c("comma", "dollar", "percent", "pp"))
```

## Arguments

- type:

  Label type. One of `"comma"`, `"dollar"`, `"percent"`, or `"pp"`
  (percentage points).

## Value

A labeler function suitable for
[`ggplot2::scale_x_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html)
or
[`ggplot2::scale_y_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html).

## Examples

``` r
library(ggplot2)
ggplot(data.frame(x = 1:5, y = seq(1000, 5000, 1000)), aes(x, y)) +
  geom_col() +
  scale_y_continuous(labels = aib_label("dollar")) +
  theme_aib()

```
