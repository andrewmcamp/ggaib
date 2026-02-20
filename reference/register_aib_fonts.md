# Register AIB fonts

Checks for locally installed preferred fonts. If not found, registers
Google Font fallbacks via sysfonts and enables showtext rendering. Falls
back to `"sans"` for all roles if font registration fails (e.g., when
required packages like jsonlite are unavailable).

## Usage

``` r
register_aib_fonts()
```
