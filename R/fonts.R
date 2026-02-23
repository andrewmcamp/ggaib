#' AIB Font Family Names
#'
#' Returns the registered font family name for a given role. The font system
#' prefers locally installed brand fonts and falls back to bundled font files
#' shipped with the package.
#'
#' @param role One of `"heading"`, `"body"`, or `"serif"`.
#'
#' @return A character string with the font family name.
#'
#' @examples
#' aib_font("heading")
#' aib_font("body")
#'
#' @export
aib_font <- function(role = c("heading", "body", "serif")) {
  valid_roles <- c("heading", "body", "serif")
  if (length(role) > 1) {
    role <- role[1]
  }
  if (!(role %in% valid_roles)) {
    stop(
      paste0('"', role, '"'),
      " is not a valid font role. Choose from: ",
      paste(valid_roles, collapse = ", "),
      call. = FALSE
    )
  }
  families <- aib_font_families()
  families[[role]]
}

#' All AIB Font Families
#'
#' Returns a named list of font family names for all roles.
#'
#' @return A named list with elements `heading`, `body`, and `serif`.
#'
#' @export
aib_font_families <- function() {
  list(
    heading = .aib_env$fonts$heading,
    body    = .aib_env$fonts$body,
    serif   = .aib_env$fonts$serif
  )
}

# Internal environment to store registered font names
.aib_env <- new.env(parent = emptyenv())

# Font configuration: preferred -> fallback
.font_config <- list(
  heading = list(preferred = "Area Normal", fallback = "Albert Sans"),
  body    = list(preferred = "Source Sans Pro", fallback = "Source Sans 3"),
  serif   = list(preferred = "Minion Pro", fallback = "Crimson Text")
)

#' Register AIB fonts
#'
#' Checks for locally installed preferred fonts. If not found, registers
#' bundled fallback fonts from the package's `inst/fonts` directory via
#' systemfonts. Falls back to `"sans"` for all roles if font registration
#' fails.
#'
#' @keywords internal
register_aib_fonts <- function() {
  tryCatch(
    {
      sys_families <- unique(systemfonts::system_fonts()$family)
      reg_families <- unique(systemfonts::registry_fonts()$family)
      available <- unique(c(sys_families, reg_families))

      fonts <- list()
      font_dir <- system.file("fonts", package = "ggaib")

      # Bundled font files keyed by role
      font_files <- list(
        heading = list(
          plain      = "AlbertSans-Regular.ttf",
          italic     = "AlbertSans-Italic.ttf",
          bold       = "AlbertSans-Bold.ttf",
          bolditalic = "AlbertSans-BoldItalic.ttf"
        ),
        body = list(
          plain      = "SourceSans3-Regular.ttf",
          italic     = "SourceSans3-Italic.ttf",
          bold       = "SourceSans3-Bold.ttf",
          bolditalic = "SourceSans3-BoldItalic.ttf"
        ),
        serif = list(
          plain      = "CrimsonText-Regular.ttf",
          italic     = "CrimsonText-Italic.ttf",
          bold       = "CrimsonText-Bold.ttf",
          bolditalic = "CrimsonText-BoldItalic.ttf"
        )
      )

      for (role in names(.font_config)) {
        config <- .font_config[[role]]
        if (config$preferred %in% available) {
          fonts[[role]] <- config$preferred
        } else {
          if (!(config$fallback %in% available)) {
            files <- font_files[[role]]
            systemfonts::register_font(
              name       = config$fallback,
              plain      = file.path(font_dir, files$plain),
              italic     = file.path(font_dir, files$italic),
              bold       = file.path(font_dir, files$bold),
              bolditalic = file.path(font_dir, files$bolditalic)
            )
          }
          fonts[[role]] <- config$fallback
        }
      }

      .aib_env$fonts <- fonts
    },
    error = function(e) {
      .aib_env$fonts <- list(
        heading = "sans",
        body    = "sans",
        serif   = "serif"
      )
    }
  )
}
