# Colored Title or Subtitle

Creates a plot title or subtitle with specific words or phrases rendered
in color. Designed as a companion to
[`aib_direct_label()`](https://andrewmcamp.github.io/ggaib/reference/aib_direct_label.md)
so that group names in the title match their line colors, replacing the
need for a legend.

## Usage

``` r
aib_color_title(text, colors, element = c("title", "subtitle"))
```

## Arguments

- text:

  A single character string for the title or subtitle.

- colors:

  A named character vector mapping substrings to colors (e.g.,
  `c("Group A" = "#1B3E6F")`). Each name found in `text` is wrapped in a
  colored HTML span.

- element:

  Which text element to set: `"title"` or `"subtitle"`.

## Value

A list of ggplot2 components that can be added to a plot with `+`.
Because this includes a partial
[`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)
modification, add it **after** your base theme (e.g.,
[`theme_aib()`](https://andrewmcamp.github.io/ggaib/reference/theme_aib.md))
in the `+` chain.

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
  aib_color_title(
    "A outperformed B over time",
    colors = c("A" = "#1B3E6F", "B" = "#C00404")
  )

```
