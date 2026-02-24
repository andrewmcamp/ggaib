# Going Legend-less

``` r
library(ggaib)
#> Brand fonts not found. Using bundled alternatives (Albert Sans, Source Sans 3, Crimson Text).
library(ggplot2)
```

Legends force readers to look back and forth between the plot and a
color key. Two ggaib helpers let you drop the legend entirely:

- [`aib_direct_label()`](https://andrewmcamp.github.io/ggaib/reference/aib_direct_label.md)
  places colored group names on a secondary y-axis, aligned with each
  group’s final value.
- [`aib_color_title()`](https://andrewmcamp.github.io/ggaib/reference/aib_color_title.md)
  renders key words in the title or subtitle in matching colors, so the
  title itself acts as a legend.

Both should be added **after** your base theme in the `+` chain because
they include partial theme modifications.

## Sample data

The examples below use a small panel of enrollment trends across three
school sectors.

``` r
enrollment <- data.frame(
  year = rep(2018:2024, 3),
  students = c(
    seq(48.0, 47.1, length.out = 7),
    seq(3.4, 3.9, length.out = 7),
    seq(5.8, 5.5, length.out = 7)
  ) * 1e6,
  sector = rep(c("Traditional", "Charter", "Private"), each = 7)
)
```

## Direct labels with `aib_direct_label()`

[`aib_direct_label()`](https://andrewmcamp.github.io/ggaib/reference/aib_direct_label.md)
replaces the legend with colored text labels positioned at each group’s
final y-value. Because it sets
[`scale_y_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html)
with a secondary axis internally, use it **instead of** a separate
[`scale_y_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html)
call.

``` r
ggplot(enrollment, aes(year, students, color = sector)) +
  geom_line(linewidth = 1) +
  scale_color_aib() +
  scale_x_continuous(breaks = 2018:2024) +
  labs(
    title = "U.S. K-12 Enrollment by Sector",
    x = NULL, y = "Students"
  ) +
  theme_aib() +
  aib_direct_label(
    enrollment, "year", "students", "sector",
    labels = aib_label("comma")
  )
```

![](going-legend-less_files/figure-html/direct-label-1.png)

### Adjusting label positions

When groups have similar endpoint values, labels can overlap. Use the
`adjust` argument to nudge individual labels up or down.

``` r
ggplot(enrollment, aes(year, students, color = sector)) +
  geom_line(linewidth = 1) +
  scale_color_aib() +
  scale_x_continuous(breaks = 2018:2024) +
  labs(
    title = "U.S. K-12 Enrollment by Sector",
    x = NULL, y = "Students"
  ) +
  theme_aib() +
  aib_direct_label(
    enrollment, "year", "students", "sector",
    adjust = c("Charter" = 1e6, "Private" = -1e6),
    labels = aib_label("comma")
  )
```

![](going-legend-less_files/figure-html/adjust-1.png)

### Styling labels

Use `size` and `bold` to control the appearance of the direct labels.

``` r
ggplot(enrollment, aes(year, students, color = sector)) +
  geom_line(linewidth = 1) +
  scale_color_aib() +
  scale_x_continuous(breaks = 2018:2024) +
  labs(
    title = "U.S. K-12 Enrollment by Sector",
    x = NULL, y = "Students"
  ) +
  theme_aib() +
  aib_direct_label(
    enrollment, "year", "students", "sector",
    size = 11, bold = TRUE,
    labels = aib_label("comma")
  )
```

![](going-legend-less_files/figure-html/style-1.png)

## Colored titles with `aib_color_title()`

[`aib_color_title()`](https://andrewmcamp.github.io/ggaib/reference/aib_color_title.md)
renders specific words in the title or subtitle in color, so readers can
identify groups without any legend at all. Pass a named character vector
mapping substrings to colors.

``` r
sector_colors <- c(
  "Traditional" = aib_colors("navy"),
  "Charter"     = aib_colors("red"),
  "Private"     = aib_colors("emerald")
)

ggplot(enrollment, aes(year, students, color = sector)) +
  geom_line(linewidth = 1) +
  scale_color_aib() +
  scale_x_continuous(breaks = 2018:2024) +
  labs(x = NULL, y = "Students") +
  theme_aib() +
  aib_direct_label(
    enrollment, "year", "students", "sector",
    labels = aib_label("comma")
  ) +
  aib_color_title(
    "Traditional enrollment fell while Charter grew",
    colors = sector_colors
  )
```

![](going-legend-less_files/figure-html/color-title-1.png)

Use `element = "subtitle"` to color the subtitle instead.

``` r
ggplot(enrollment, aes(year, students, color = sector)) +
  geom_line(linewidth = 1) +
  scale_color_aib() +
  scale_x_continuous(breaks = 2018:2024) +
  labs(
    title = "U.S. K-12 Enrollment by Sector",
    x = NULL, y = "Students"
  ) +
  theme_aib() +
  aib_direct_label(
    enrollment, "year", "students", "sector",
    labels = aib_label("comma")
  ) +
  aib_color_title(
    "Traditional enrollment fell while Charter grew",
    colors = sector_colors,
    element = "subtitle"
  )
```

![](going-legend-less_files/figure-html/color-subtitle-1.png)

## Putting it all together

Combine both functions for a polished, legend-free chart.

``` r
ggplot(enrollment, aes(year, students, color = sector)) +
  geom_line(linewidth = 1) +
  scale_color_aib() +
  scale_x_continuous(breaks = 2018:2024) +
  labs(x = NULL, y = "Students") +
  theme_aib() +
  aib_direct_label(
    enrollment, "year", "students", "sector",
    adjust = c("Charter" = 1e6, "Private" = -1e6),
    size = 11, bold = TRUE,
    labels = aib_label("comma")
  ) +
  aib_color_title(
    "Traditional enrollment fell while Charter grew",
    colors = sector_colors
  )
```

![](going-legend-less_files/figure-html/combined-1.png)
