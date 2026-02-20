#' Discrete AIB Color Scale
#'
#' Maps categorical variables to the Annenberg Institute brand palette.
#' Colors are ordered for maximum visual contrast.
#'
#' @param ... Additional arguments passed to [ggplot2::discrete_scale()].
#'
#' @return A ggplot2 discrete color scale.
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg, wt, color = factor(cyl))) +
#'   geom_point() +
#'   scale_color_aib()
#'
#' @export
scale_color_aib <- function(...) {
  ggplot2::discrete_scale(
    aesthetics = "colour",
    palette = aib_pal(),
    ...
  )
}

#' @rdname scale_color_aib
#' @export
scale_colour_aib <- scale_color_aib

#' Discrete AIB Fill Scale
#'
#' Maps categorical variables to the Annenberg Institute brand palette
#' for fill aesthetics.
#'
#' @param ... Additional arguments passed to [ggplot2::discrete_scale()].
#'
#' @return A ggplot2 discrete fill scale.
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(factor(cyl), fill = factor(cyl))) +
#'   geom_bar() +
#'   scale_fill_aib()
#'
#' @export
scale_fill_aib <- function(...) {
  ggplot2::discrete_scale(
    aesthetics = "fill",
    palette = aib_pal(),
    ...
  )
}
