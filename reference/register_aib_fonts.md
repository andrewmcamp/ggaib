# Register AIB fonts

Checks for locally installed preferred fonts. If not found, registers
bundled fallback fonts from the package's `inst/fonts` directory via
systemfonts. Falls back to `"sans"` for all roles if font registration
fails.

## Usage

``` r
register_aib_fonts()
```
