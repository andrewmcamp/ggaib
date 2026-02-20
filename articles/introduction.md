# Getting Started with ggaib

## Overview

The `ggaib` package provides ggplot2 themes and color scales for the
Annenberg Institute at Brown University. It includes four theme variants
and discrete, continuous, and diverging color scales using the
Institute’s brand palette.

``` r
library(ggaib)
library(ggplot2)
```

## Brand Colors

Access the full palette or select specific colors:

``` r
aib_colors()
#>      navy       red   emerald    yellow       sky     taupe     brown      gray 
#> "#1B3E6F" "#C00404" "#00AF9A" "#EBA900" "#55C8E8" "#B6B09D" "#503629" "#97A3AE"
aib_colors("navy", "red", "emerald")
#>      navy       red   emerald 
#> "#1B3E6F" "#C00404" "#00AF9A"
```

## Themes

### Publication (default)

``` r
ggplot(mtcars, aes(mpg, wt)) +
  geom_point(aes(color = factor(cyl)), size = 3) +
  scale_color_aib() +
  labs(
    title = "Vehicle Weight by Fuel Efficiency",
    subtitle = "Motor Trend Car Road Tests, 1974",
    caption = "Source: mtcars dataset"
  ) +
  theme_aib()
```

![](introduction_files/figure-html/theme-base-1.png)

### Grid

``` r
ggplot(economics, aes(date, unemploy / 1000)) +
  geom_line(color = aib_colors("navy"), linewidth = 0.7) +
  labs(
    title = "US Unemployment Over Time",
    subtitle = "In thousands",
    y = "Unemployed (thousands)",
    x = NULL
  ) +
  theme_aib_grid()
```

![](introduction_files/figure-html/theme-grid-1.png)

### Slide

``` r
ggplot(mtcars, aes(factor(cyl), fill = factor(cyl))) +
  geom_bar() +
  scale_fill_aib() +
  labs(title = "Cars by Cylinder Count") +
  theme_aib_slide()
```

![](introduction_files/figure-html/theme-slide-1.png)

### Map

``` r
ggplot(mtcars, aes(mpg, wt)) +
  geom_point(color = aib_colors("navy"), size = 3) +
  labs(title = "Vehicle Weight by Fuel Efficiency") +
  theme_aib_map()
```

![](introduction_files/figure-html/theme-map-1.png)

## Color Scales

### Continuous

``` r
ggplot(mtcars, aes(mpg, wt, color = hp)) +
  geom_point(size = 3) +
  scale_color_aib_c() +
  labs(title = "Horsepower Gradient", color = "HP") +
  theme_aib()
```

![](introduction_files/figure-html/scale-continuous-1.png)

### Diverging

``` r
mtcars$hp_centered <- mtcars$hp - mean(mtcars$hp)

ggplot(mtcars, aes(mpg, wt, color = hp_centered)) +
  geom_point(size = 3) +
  scale_color_aib_div() +
  labs(title = "Horsepower (Centered)", color = "HP - Mean") +
  theme_aib()
```

![](introduction_files/figure-html/scale-diverging-1.png)
