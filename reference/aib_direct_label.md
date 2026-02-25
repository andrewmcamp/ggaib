# Direct Labels on a Secondary Y-Axis

Replaces the legend with group labels placed on a secondary y-axis,
aligned with each group's final value. Label colors match the group
colors for easy identification.

## Usage

``` r
aib_direct_label(
  data,
  x,
  y,
  group,
  colors = NULL,
  adjust = NULL,
  size = NULL,
  bold = FALSE,
  gap = NULL,
  ...
)
```

## Arguments

- data:

  Data frame used in the plot.

- x, y, group:

  String column names for the x-axis, y-axis, and grouping variable.

- colors:

  Optional named character vector mapping group names to colors (e.g.,
  `c("Group A" = "#1B3E6F")`). Defaults to
  [`aib_colors()`](https://andrewmcamp.github.io/ggaib/reference/aib_colors.md)
  in palette order, matching
  [`scale_color_aib()`](https://andrewmcamp.github.io/ggaib/reference/scale_color_aib.md).

- adjust:

  Optional named numeric vector of vertical adjustments to prevent label
  overlap (e.g., `c("Group A" = 0.5)`). Groups not listed receive no
  adjustment.

- size:

  Font size for the labels in points. Defaults to `NULL`, which uses the
  theme's default axis text size.

- bold:

  Logical; if `TRUE`, labels are rendered in bold. Defaults to `FALSE`.

- gap:

  Space between the right edge of the plot and the labels, in points.
  Smaller values pull the labels closer to the data. Defaults to `NULL`,
  which uses the ggplot2 default spacing.

- ...:

  Additional arguments passed to
  [`ggplot2::scale_y_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html)
  (e.g., `limits`, `breaks`, `labels`).

## Value

A list of ggplot2 components that can be added to a plot with `+`.
Because this includes a partial
[`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)
modification, add it **after** your base theme (e.g.,
[`theme_aib()`](https://andrewmcamp.github.io/ggaib/reference/theme_aib.md))
in the `+` chain.

## Details

Because this function sets
[`ggplot2::scale_y_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html)
with a secondary axis, it should be used instead of (not alongside) a
separate
[`scale_y_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html)
call.

## Examples

``` r
library(ggplot2)
df <- data.frame(
  year = rep(2020:2024, 2),
  value = c(1:5, 5:1),
  group = rep(c("A", "B"), each = 5)
)
ggplot(df, aes(year, value, color = group)) +
  geom_line() +
  scale_color_aib() +
  theme_aib() +
  aib_direct_label(df, "year", "value", "group")

```
