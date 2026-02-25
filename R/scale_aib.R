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

#' Continuous AIB Color Scale
#'
#' Creates a continuous color gradient between two brand colors.
#' Defaults to a navy-to-sky gradient.
#'
#' @param low Color for the low end of the gradient. Default is AIB navy.
#' @param high Color for the high end of the gradient. Default is AIB sky.
#' @param ... Additional arguments passed to [ggplot2::scale_color_gradient()].
#'
#' @return A ggplot2 continuous color scale.
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg, wt, color = hp)) +
#'   geom_point() +
#'   scale_color_aib_c()
#'
#' @export
scale_color_aib_c <- function(low = "#1B3E6F", high = "#55C8E8", ...) {
  ggplot2::scale_color_gradient(low = low, high = high, ...)
}

#' @rdname scale_color_aib_c
#' @export
scale_colour_aib_c <- scale_color_aib_c

#' Continuous AIB Fill Scale
#'
#' Creates a continuous fill gradient between two brand colors.
#'
#' @inheritParams scale_color_aib_c
#' @param ... Additional arguments passed to [ggplot2::scale_fill_gradient()].
#'
#' @return A ggplot2 continuous fill scale.
#'
#' @export
scale_fill_aib_c <- function(low = "#1B3E6F", high = "#55C8E8", ...) {
  ggplot2::scale_fill_gradient(low = low, high = high, ...)
}

#' Diverging AIB Color Scale
#'
#' Creates a diverging color gradient. Defaults to red-gray-navy.
#'
#' @param low Color for the low end. Default is AIB red.
#' @param mid Color for the midpoint. Default is light gray.
#' @param high Color for the high end. Default is AIB navy.
#' @param midpoint The data value mapped to the midpoint color. Default is 0.
#' @param ... Additional arguments passed to [ggplot2::scale_color_gradient2()].
#'
#' @return A ggplot2 diverging color scale.
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg, wt, color = hp - mean(hp))) +
#'   geom_point() +
#'   scale_color_aib_div()
#'
#' @export
scale_color_aib_div <- function(low = "#C00404", mid = "#D0D0D0",
                                 high = "#1B3E6F", midpoint = 0, ...) {
  ggplot2::scale_color_gradient2(
    low = low, mid = mid, high = high, midpoint = midpoint, ...
  )
}

#' @rdname scale_color_aib_div
#' @export
scale_colour_aib_div <- scale_color_aib_div

#' Diverging AIB Fill Scale
#'
#' Creates a diverging fill gradient. Defaults to red-gray-navy.
#'
#' @inheritParams scale_color_aib_div
#' @param ... Additional arguments passed to [ggplot2::scale_fill_gradient2()].
#'
#' @return A ggplot2 diverging fill scale.
#'
#' @export
scale_fill_aib_div <- function(low = "#C00404", mid = "#D0D0D0",
                                high = "#1B3E6F", midpoint = 0, ...) {
  ggplot2::scale_fill_gradient2(
    low = low, mid = mid, high = high, midpoint = midpoint, ...
  )
}

#' Binned AIB Color Scale
#'
#' Creates a binned (stepped) color gradient between two brand colors.
#' Defaults to a navy-to-sky gradient with 5 breaks. Supply a numeric
#' vector to `breaks` for custom bin boundaries.
#'
#' @param low Color for the low end of the gradient. Default is AIB navy.
#' @param high Color for the high end of the gradient. Default is AIB sky.
#' @param n.breaks Number of breaks for automatic binning. Default is 5.
#'   Ignored when `breaks` is provided explicitly via `...`.
#' @param ... Additional arguments passed to [ggplot2::scale_color_steps()]
#'   (e.g., `breaks`, `labels`, `limits`).
#'
#' @return A ggplot2 binned color scale.
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg, wt, color = hp)) +
#'   geom_point() +
#'   scale_color_aib_b()
#'
#' @export
scale_color_aib_b <- function(low = "#1B3E6F", high = "#55C8E8",
                               n.breaks = 5, ...) {
  ggplot2::scale_color_steps(
    low = low, high = high, n.breaks = n.breaks,
    guide = ggplot2::guide_legend(), ...
  )
}

#' @rdname scale_color_aib_b
#' @export
scale_colour_aib_b <- scale_color_aib_b

#' Binned AIB Fill Scale
#'
#' Creates a binned (stepped) fill gradient between two brand colors.
#'
#' @inheritParams scale_color_aib_b
#' @param ... Additional arguments passed to [ggplot2::scale_fill_steps()]
#'   (e.g., `breaks`, `labels`, `limits`).
#'
#' @return A ggplot2 binned fill scale.
#'
#' @export
scale_fill_aib_b <- function(low = "#1B3E6F", high = "#55C8E8",
                              n.breaks = 5, ...) {
  ggplot2::scale_fill_steps(
    low = low, high = high, n.breaks = n.breaks,
    guide = ggplot2::guide_legend(), ...
  )
}
