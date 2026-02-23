#' Annenberg Institute Base Theme
#'
#' A minimal, publication-quality ggplot2 theme following the Annenberg
#' Institute at Brown University visual identity. Uses brand fonts with
#' automatic Google Fonts fallback.
#'
#' @param base_size Base font size in points. Default is 11.
#' @param base_family Override base font family. If `NULL`, uses the
#'   registered AIB body font.
#' @param gridlines Which major gridlines to display. One of `"none"`
#'   (default), `"x"`, `"y"`, or `"xy"`.
#'
#' @return A [ggplot2::theme()] object.
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg, wt)) +
#'   geom_point() +
#'   theme_aib()
#'
#' # Add horizontal gridlines
#' ggplot(mtcars, aes(mpg, wt)) +
#'   geom_point() +
#'   theme_aib(gridlines = "y")
#'
#' @export
theme_aib <- function(base_size = 11, base_family = NULL,
                      gridlines = c("none", "x", "y", "xy")) {
  gridlines <- match.arg(gridlines)
  fonts <- aib_font_families()
  if (is.null(base_family)) base_family <- fonts$body

  thm <- ggplot2::theme_minimal(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      # Text
      text = ggplot2::element_text(
        family = base_family,
        size = base_size,
        colour = "#333333"
      ),
      plot.title = ggplot2::element_text(
        family = fonts$heading,
        face = "bold",
        size = base_size * 1.3,
        hjust = 0,
        margin = ggplot2::margin(b = base_size * 0.5)
      ),
      plot.subtitle = ggplot2::element_text(
        family = fonts$heading,
        size = base_size * 1.05,
        hjust = 0,
        margin = ggplot2::margin(b = base_size * 0.7)
      ),
      plot.caption = ggplot2::element_text(
        family = fonts$serif,
        face = "italic",
        size = base_size * 0.8,
        hjust = 1,
        margin = ggplot2::margin(t = base_size * 0.5)
      ),

      # Axes
      axis.line = ggplot2::element_line(colour = "#555555", linewidth = 0.3),
      axis.ticks = ggplot2::element_line(colour = "#555555", linewidth = 0.3),
      axis.text = ggplot2::element_text(
        family = base_family,
        size = base_size * 0.85
      ),
      axis.title = ggplot2::element_text(
        family = base_family,
        size = base_size * 0.95,
        margin = ggplot2::margin(t = base_size * 0.3)
      ),

      # Grid
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),

      # Panel
      panel.background = ggplot2::element_rect(fill = "white", colour = NA),
      panel.border = ggplot2::element_blank(),

      # Plot
      plot.background = ggplot2::element_rect(fill = "white", colour = NA),
      plot.margin = ggplot2::margin(
        t = base_size, r = base_size, b = base_size, l = base_size
      ),

      # Legend
      legend.position = "bottom",
      legend.title = ggplot2::element_blank(),
      legend.key = ggplot2::element_rect(fill = "white", colour = NA),
      legend.background = ggplot2::element_rect(fill = "white", colour = NA),
      legend.direction = "horizontal",

      # Strip (facets)
      strip.background = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(
        family = fonts$heading,
        face = "bold",
        size = base_size * 0.9
      )
    )

  grid_line <- ggplot2::element_line(colour = "#E0E0E0", linewidth = 0.25)
  if (gridlines %in% c("x", "xy")) {
    thm <- thm + ggplot2::theme(panel.grid.major.x = grid_line)
  }
  if (gridlines %in% c("y", "xy")) {
    thm <- thm + ggplot2::theme(panel.grid.major.y = grid_line)
  }

  thm
}

#' Annenberg Institute Grid Theme
#'
#' Identical to [theme_aib()] but defaults to `gridlines = "xy"` for light
#' gray major gridlines. Use for data-dense plots where gridlines aid
#' readability.
#'
#' @inheritParams theme_aib
#'
#' @return A [ggplot2::theme()] object.
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg, wt)) +
#'   geom_point() +
#'   theme_aib_grid()
#'
#' @export
theme_aib_grid <- function(base_size = 11, base_family = NULL,
                           gridlines = c("xy", "x", "y", "none")) {
  gridlines <- match.arg(gridlines)
  theme_aib(base_size = base_size, base_family = base_family,
            gridlines = gridlines)
}
#' Annenberg Institute Map Theme
#'
#' A theme for spatial/map plots with no axes, ticks, or gridlines.
#' Retains title, subtitle, and caption styling.
#'
#' @inheritParams theme_aib
#'
#' @return A [ggplot2::theme()] object.
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg, wt)) +
#'   geom_point() +
#'   theme_aib_map()
#'
#' @export
theme_aib_map <- function(base_size = 11, base_family = NULL,
                          gridlines = c("none", "x", "y", "xy")) {
  gridlines <- match.arg(gridlines)
  theme_aib(base_size = base_size, base_family = base_family,
            gridlines = gridlines) +
    ggplot2::theme(
      axis.line = ggplot2::element_blank(),
      axis.text = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),
      axis.title = ggplot2::element_blank()
    )
}
