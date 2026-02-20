# Annenberg Institute Color Palette Function

Returns a function that generates `n` colors from the AIB brand palette.
Intended for use inside ggplot2 scale functions.

## Usage

``` r
aib_pal()
```

## Value

A function that takes an integer `n` and returns `n` hex color codes.

## Examples

``` r
pal <- aib_pal()
pal(3)
#> [1] "#1B3E6F" "#C00404" "#00AF9A"
```
