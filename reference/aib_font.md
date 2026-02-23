# AIB Font Family Names

Returns the registered font family name for a given role. The font
system prefers locally installed brand fonts and falls back to bundled
font files shipped with the package.

## Usage

``` r
aib_font(role = c("heading", "body", "serif"))
```

## Arguments

- role:

  One of `"heading"`, `"body"`, or `"serif"`.

## Value

A character string with the font family name.

## Examples

``` r
aib_font("heading")
#> [1] "Albert Sans"
aib_font("body")
#> [1] "Source Sans 3"
```
