#' Annenberg Institute Brand Colors
#'
#' Returns a named character vector of hex color codes from the Annenberg
#' Institute brand palette. Pass color names to select specific colors.
#'
#' @param ... Color names to select. If empty, returns all colors.
#'
#' @return A named character vector of hex color codes.
#'
#' @examples
#' aib_colors()
#' aib_colors("navy", "red")
#'
#' @export
aib_colors <- function(...) {
  aib_palette <- c(
    navy    = "#1B3E6F",
    red     = "#C00404",
    emerald = "#00AF9A",
    yellow  = "#EBA900",
    sky     = "#55C8E8",
    taupe   = "#B6B09D",
    brown   = "#503629",
    gray    = "#97A3AE"
  )

  cols <- c(...)

  if (is.null(cols)) {
    return(aib_palette)
  }

  invalid <- setdiff(cols, names(aib_palette))
  if (length(invalid) > 0) {
    stop(
      paste(invalid, collapse = ", "),
      " not valid AIB colors. Choose from: ",
      paste(names(aib_palette), collapse = ", "),
      call. = FALSE
    )
  }

  aib_palette[cols]
}

#' Annenberg Institute Color Palette Function
#'
#' Returns a function that generates `n` colors from the AIB brand palette.
#' Intended for use inside ggplot2 scale functions.
#'
#' @return A function that takes an integer `n` and returns `n` hex color codes.
#'
#' @examples
#' pal <- aib_pal()
#' pal(3)
#'
#' @export
aib_pal <- function() {
  colors <- unname(aib_colors())
  function(n) {
    if (n > length(colors)) {
      warning("AIB palette has only 8 colors, not ", n,
              call. = FALSE)
    }
    colors[seq_len(min(n, length(colors)))]
  }
}
