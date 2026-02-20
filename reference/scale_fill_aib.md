# Discrete AIB Fill Scale

Maps categorical variables to the Annenberg Institute brand palette for
fill aesthetics.

## Usage

``` r
scale_fill_aib(...)
```

## Arguments

- ...:

  Additional arguments passed to
  [`ggplot2::discrete_scale()`](https://ggplot2.tidyverse.org/reference/discrete_scale.html).

## Value

A ggplot2 discrete fill scale.

## Examples

``` r
library(ggplot2)
ggplot(mtcars, aes(factor(cyl), fill = factor(cyl))) +
  geom_bar() +
  scale_fill_aib()

```
