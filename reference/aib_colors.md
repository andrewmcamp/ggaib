# Annenberg Institute Brand Colors

Returns a named character vector of hex color codes from the Annenberg
Institute brand palette. Pass color names to select specific colors.

## Usage

``` r
aib_colors(...)
```

## Arguments

- ...:

  Color names to select. If empty, returns all colors.

## Value

A named character vector of hex color codes.

## Examples

``` r
aib_colors()
#>      navy       red   emerald    yellow       sky     taupe     brown      gray 
#> "#1B3E6F" "#C00404" "#00AF9A" "#EBA900" "#55C8E8" "#B6B09D" "#503629" "#97A3AE" 
aib_colors("navy", "red")
#>      navy       red 
#> "#1B3E6F" "#C00404" 
```
