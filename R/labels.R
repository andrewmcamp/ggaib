#' Axis Label Formatters
#'
#' Convenience wrapper that returns label functions for common axis formats.
#' The returned function can be passed directly to the `labels` argument of
#' any `scale_*_continuous()` call.
#'
#' @param type Label type. One of `"comma"`, `"dollar"`, `"percent"`, or
#'   `"pp"` (percentage points).
#'
#' @return A labeler function suitable for [ggplot2::scale_x_continuous()] or
#'   [ggplot2::scale_y_continuous()].
#'
#' @examples
#' library(ggplot2)
#' ggplot(data.frame(x = 1:5, y = seq(1000, 5000, 1000)), aes(x, y)) +
#'   geom_col() +
#'   scale_y_continuous(labels = aib_label("dollar")) +
#'   theme_aib()
#'
#' @export
aib_label <- function(type = c("comma", "dollar", "percent", "pp")) {
  type <- match.arg(type)
  switch(type,
    comma   = scales::label_comma(),
    dollar  = scales::label_dollar(),
    percent = scales::label_percent(),
    pp      = scales::label_comma(suffix = " pp")
  )
}
