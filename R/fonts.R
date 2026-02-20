#' AIB Font Family Names
#'
#' Returns the registered font family name for a given role. The font system
#' prefers locally installed brand fonts and falls back to Google Fonts
#' alternatives via showtext.
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
#' Google Font fallbacks via sysfonts and enables showtext rendering.
#'
#' @keywords internal
register_aib_fonts <- function() {
  registered <- sysfonts::font_families()
  fonts <- list()

  for (role in names(.font_config)) {
    config <- .font_config[[role]]
    if (config$preferred %in% registered) {
      fonts[[role]] <- config$preferred
    } else {
      if (!(config$fallback %in% registered)) {
        sysfonts::font_add_google(config$fallback, config$fallback)
      }
      fonts[[role]] <- config$fallback
    }
  }

  .aib_env$fonts <- fonts
  showtext::showtext_auto()
}
