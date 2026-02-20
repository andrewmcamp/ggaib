test_that("theme_aib() returns a ggplot2 theme", {
  thm <- theme_aib()
  expect_s3_class(thm, "theme")
})

test_that("theme_aib() has no gridlines", {
  thm <- theme_aib()
  expect_equal(thm$panel.grid.major, element_blank())
  expect_equal(thm$panel.grid.minor, element_blank())
})

test_that("theme_aib() has axis lines", {
  thm <- theme_aib()
  expect_s3_class(thm$axis.line, "element_line")
})

test_that("theme_aib() has white background", {
  thm <- theme_aib()
  bg <- thm$plot.background
  expect_s3_class(bg, "element_rect")
  expect_equal(bg$fill, "white")
})

test_that("theme_aib() has legend at bottom", {
  thm <- theme_aib()
  expect_equal(thm$legend.position, "bottom")
})

test_that("theme_aib() has left-aligned title", {
  thm <- theme_aib()
  expect_equal(thm$plot.title$hjust, 0)
})

test_that("theme_aib() respects base_size", {
  thm_small <- theme_aib(base_size = 10)
  thm_large <- theme_aib(base_size = 16)
  expect_true(thm_large$text$size > thm_small$text$size)
})

test_that("theme_aib() can be added to a ggplot", {
  p <- ggplot(mtcars, aes(mpg, wt)) + geom_point() + theme_aib()
  expect_s3_class(p, "ggplot")
})
