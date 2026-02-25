test_that("aib_label() returns a function for each type", {
  expect_type(aib_label("comma"), "closure")
  expect_type(aib_label("dollar"), "closure")
  expect_type(aib_label("percent"), "closure")
  expect_type(aib_label("pp"), "closure")
})

test_that("aib_label('comma') formats numbers with commas", {
  fmt <- aib_label("comma")
  expect_equal(fmt(1000), "1,000")
  expect_equal(fmt(1234567), "1,234,567")
})

test_that("aib_label('dollar') formats as currency", {
  fmt <- aib_label("dollar")
  expect_equal(fmt(1000), "$1,000")
  expect_equal(fmt(2000), "$2,000")
})

test_that("aib_label('percent') formats as percentage", {
  fmt <- aib_label("percent")
  expect_equal(fmt(0.5), "50%")
  expect_equal(fmt(1), "100%")
})

test_that("aib_label('pp') formats with pp suffix", {
  fmt <- aib_label("pp")
  expect_equal(fmt(5), "5 pp")
  expect_equal(fmt(1000), "1,000 pp")
})

test_that("aib_label() rejects invalid type", {
  expect_error(aib_label("invalid"))
})

# --- aib_direct_label() ---

test_that("aib_direct_label() returns a list of ggplot2 components", {
  df <- data.frame(
    year = rep(2020:2024, 2),
    value = c(1:5, 5:1),
    group = rep(c("A", "B"), each = 5)
  )
  result <- aib_direct_label(df, "year", "value", "group")
  expect_type(result, "list")
  expect_length(result, 2)
})

test_that("aib_direct_label() can be added to a ggplot", {
  df <- data.frame(
    year = rep(2020:2024, 2),
    value = c(1:5, 5:1),
    group = rep(c("A", "B"), each = 5)
  )
  p <- ggplot2::ggplot(df, ggplot2::aes(year, value, color = group)) +
    ggplot2::geom_line() +
    aib_direct_label(df, "year", "value", "group")
  expect_s3_class(p, "gg")
})

test_that("aib_direct_label() uses default aib palette colors", {
  df <- data.frame(
    year = rep(2020:2024, 2),
    value = c(1:5, 5:1),
    group = rep(c("A", "B"), each = 5)
  )
  result <- aib_direct_label(df, "year", "value", "group")
  theme_part <- result[[2]]
  pal <- unname(aib_colors())
  expect_equal(theme_part$axis.text.y.right$colour, pal[1:2])
})

test_that("aib_direct_label() respects custom colors", {
  df <- data.frame(
    year = rep(2020:2024, 2),
    value = c(1:5, 5:1),
    group = rep(c("A", "B"), each = 5)
  )
  custom <- c("A" = "#FF0000", "B" = "#0000FF")
  result <- aib_direct_label(df, "year", "value", "group", colors = custom)
  theme_part <- result[[2]]
  expect_equal(theme_part$axis.text.y.right$colour, unname(custom))
})

test_that("aib_direct_label() applies adjust offsets", {
  df <- data.frame(
    year = rep(2020:2024, 2),
    value = c(1:5, 5:1),
    group = rep(c("A", "B"), each = 5)
  )
  result_no_adj <- aib_direct_label(df, "year", "value", "group")
  result_adj <- aib_direct_label(df, "year", "value", "group",
                                  adjust = c("A" = 0.5))
  breaks_no_adj <- result_no_adj[[1]]$secondary.axis$breaks
  breaks_adj <- result_adj[[1]]$secondary.axis$breaks
  expect_equal(breaks_adj[1] - breaks_no_adj[1], 0.5)
  expect_equal(breaks_adj[2], breaks_no_adj[2])
})

test_that("aib_direct_label() removes the legend", {
  df <- data.frame(
    year = rep(2020:2024, 2),
    value = c(1:5, 5:1),
    group = rep(c("A", "B"), each = 5)
  )
  result <- aib_direct_label(df, "year", "value", "group")
  theme_part <- result[[2]]
  expect_equal(theme_part$legend.position, "none")
})

test_that("aib_direct_label() respects gap argument", {
  df <- data.frame(
    year = rep(2020:2024, 2),
    value = c(1:5, 5:1),
    group = rep(c("A", "B"), each = 5)
  )
  result <- aib_direct_label(df, "year", "value", "group", gap = 2)
  theme_part <- result[[2]]
  expect_equal(theme_part$axis.text.y.right$margin, ggplot2::margin(l = 2))
})

test_that("aib_direct_label() leaves margin NULL by default", {
  df <- data.frame(
    year = rep(2020:2024, 2),
    value = c(1:5, 5:1),
    group = rep(c("A", "B"), each = 5)
  )
  result <- aib_direct_label(df, "year", "value", "group")
  theme_part <- result[[2]]
  expect_null(theme_part$axis.text.y.right$margin)
})

# --- aib_color_title() ---

test_that("aib_color_title() returns a list of ggplot2 components", {
  result <- aib_color_title("A vs B", colors = c("A" = "#FF0000"))
  expect_type(result, "list")
  expect_length(result, 2)
})

test_that("aib_color_title() wraps matched words in colored spans", {
  result <- aib_color_title(
    "A outperformed B",
    colors = c("A" = "#FF0000", "B" = "#0000FF")
  )
  title_text <- result[[1]]$title
  expect_match(title_text, "<b><span style='color:#FF0000'>A</span></b>", fixed = TRUE)
  expect_match(title_text, "<b><span style='color:#0000FF'>B</span></b>", fixed = TRUE)
})

test_that("aib_color_title() sets element_markdown for title", {
  result <- aib_color_title("A vs B", colors = c("A" = "#FF0000"))
  theme_part <- result[[2]]
  expect_s3_class(theme_part$plot.title, "element_markdown")
})

test_that("aib_color_title() works with subtitle element", {
  result <- aib_color_title(
    "A vs B",
    colors = c("A" = "#FF0000"),
    element = "subtitle"
  )
  expect_true(!is.null(result[[1]]$subtitle))
  expect_s3_class(result[[2]]$plot.subtitle, "element_markdown")
})

test_that("aib_color_title() can be added to a ggplot", {
  df <- data.frame(x = 1:5, y = 1:5)
  p <- ggplot2::ggplot(df, ggplot2::aes(x, y)) +
    ggplot2::geom_point() +
    aib_color_title("Hello world", colors = c("world" = "#FF0000"))
  expect_s3_class(p, "gg")
})

test_that("aib_color_title() leaves unmatched text unchanged", {
  result <- aib_color_title(
    "A outperformed B",
    colors = c("A" = "#FF0000")
  )
  title_text <- result[[1]]$title
  expect_match(title_text, "outperformed B")
})
