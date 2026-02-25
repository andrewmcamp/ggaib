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

#' Direct Labels on a Secondary Y-Axis
#'
#' Replaces the legend with group labels placed on a secondary y-axis,
#' aligned with each group's final value. Label colors match the group
#' colors for easy identification.
#'
#' Because this function sets [ggplot2::scale_y_continuous()] with a
#' secondary axis, it should be used instead of (not alongside) a
#' separate `scale_y_continuous()` call.
#'
#' @param data Data frame used in the plot.
#' @param x,y,group String column names for the x-axis, y-axis, and
#'   grouping variable.
#' @param colors Optional named character vector mapping group names to
#'   colors (e.g., `c("Group A" = "#1B3E6F")`). Defaults to
#'   [aib_colors()] in palette order, matching [scale_color_aib()].
#' @param adjust Optional named numeric vector of vertical adjustments
#'   to prevent label overlap (e.g., `c("Group A" = 0.5)`). Groups not
#'   listed receive no adjustment.
#' @param size Font size for the labels in points. Defaults to `NULL`,
#'   which uses the theme's default axis text size.
#' @param bold Logical; if `TRUE`, labels are rendered in bold.
#'   Defaults to `FALSE`.
#' @param gap Space between the right edge of the plot and the labels,
#'   in points. Smaller values pull the labels closer to the data.
#'   Defaults to `NULL`, which uses the ggplot2 default spacing.
#' @param ... Additional arguments passed to [ggplot2::scale_y_continuous()]
#'   (e.g., `limits`, `breaks`, `labels`).
#'
#' @return A list of ggplot2 components that can be added to a plot
#'   with `+`. Because this includes a partial [ggplot2::theme()]
#'   modification, add it **after** your base theme (e.g., `theme_aib()`)
#'   in the `+` chain.
#'
#' @examples
#' library(ggplot2)
#' df <- data.frame(
#'   year = rep(2020:2024, 2),
#'   value = c(1:5, 5:1),
#'   group = rep(c("A", "B"), each = 5)
#' )
#' ggplot(df, aes(year, value, color = group)) +
#'   geom_line() +
#'   scale_color_aib() +
#'   theme_aib() +
#'   aib_direct_label(df, "year", "value", "group")
#'
#' @export
aib_direct_label <- function(data, x, y, group, colors = NULL,
                             adjust = NULL, size = NULL, bold = FALSE,
                             gap = NULL, ...) {
  groups <- unique(data[[group]])

  # Find the y-value at the maximum x for each group
  endpoints <- vapply(groups, function(g) {
    sub <- data[data[[group]] == g, ]
    sub[[y]][which.max(sub[[x]])]
  }, numeric(1))
  names(endpoints) <- groups

  # Apply manual adjustments
  if (!is.null(adjust)) {
    matched <- intersect(names(adjust), names(endpoints))
    endpoints[matched] <- endpoints[matched] + adjust[matched]
  }

  # Resolve colors: default to aib palette order
  if (is.null(colors)) {
    pal <- unname(aib_colors())
    colors <- pal[seq_along(groups)]
    names(colors) <- groups
  }
  label_colors <- colors[names(endpoints)]

  label_theme <- suppressWarnings(
    ggplot2::theme(
      axis.text.y.right = ggplot2::element_text(
        colour = unname(label_colors),
        size = size,
        face = if (bold) "bold" else "plain",
        margin = if (!is.null(gap)) ggplot2::margin(l = gap) else NULL
      ),
      axis.line.y.right = ggplot2::element_blank(),
      axis.ticks.y.right = ggplot2::element_blank(),
      legend.position = "none"
    )
  )

  list(
    ggplot2::scale_y_continuous(
      ...,
      sec.axis = ggplot2::sec_axis(
        ~ .,
        breaks = unname(endpoints),
        labels = names(endpoints)
      )
    ),
    label_theme
  )
}

#' Colored Title or Subtitle
#'
#' Creates a plot title or subtitle with specific words or phrases rendered
#' in color. Designed as a companion to [aib_direct_label()] so that group
#' names in the title match their line colors, replacing the need for a
#' legend.
#'
#' @param text A single character string for the title or subtitle.
#' @param colors A named character vector mapping substrings to colors
#'   (e.g., `c("Group A" = "#1B3E6F")`). Each name found in `text` is
#'   wrapped in a colored HTML span.
#' @param element Which text element to set: `"title"` or `"subtitle"`.
#'
#' @return A list of ggplot2 components that can be added to a plot
#'   with `+`. Because this includes a partial [ggplot2::theme()]
#'   modification, add it **after** your base theme (e.g., `theme_aib()`)
#'   in the `+` chain.
#'
#' @examples
#' library(ggplot2)
#' df <- data.frame(
#'   year = rep(2020:2024, 2),
#'   value = c(1:5, 5:1),
#'   group = rep(c("A", "B"), each = 5)
#' )
#' ggplot(df, aes(year, value, color = group)) +
#'   geom_line() +
#'   scale_color_aib() +
#'   theme_aib() +
#'   aib_color_title(
#'     "A outperformed B over time",
#'     colors = c("A" = "#1B3E6F", "B" = "#C00404")
#'   )
#'
#' @export
aib_color_title <- function(text, colors,
                            element = c("title", "subtitle")) {
  element <- match.arg(element)

  # Wrap each matched substring in a colored span
  for (nm in names(colors)) {
    span <- paste0("<b><span style='color:", colors[[nm]], "'>", nm, "</span></b>")
    text <- gsub(nm, span, text, fixed = TRUE)
  }

  if (element == "title") {
    list(
      ggplot2::labs(title = text),
      ggplot2::theme(plot.title = ggtext::element_markdown())
    )
  } else {
    list(
      ggplot2::labs(subtitle = text),
      ggplot2::theme(plot.subtitle = ggtext::element_markdown())
    )
  }
}
