# theme_aib_grid
test_that("theme_aib_grid() has major gridlines by default", {
  thm <- theme_aib_grid()
  expect_s3_class(thm$panel.grid.major.x, "element_line")
  expect_s3_class(thm$panel.grid.major.y, "element_line")
})

test_that("theme_aib_grid() has no minor gridlines", {
  thm <- theme_aib_grid()
  expect_equal(thm$panel.grid.minor, element_blank())
})

test_that("theme_aib_grid() accepts gridlines override", {
  thm <- theme_aib_grid(gridlines = "y")
  expect_s3_class(thm$panel.grid.major.y, "element_line")
  expect_null(thm$panel.grid.major.x)
})

# theme_aib_slide
test_that("theme_aib_slide() has larger base size", {
  thm <- theme_aib_slide()
  expect_true(thm$text$size >= 16)
})

test_that("theme_aib_slide() can be added to ggplot", {
  p <- ggplot(mtcars, aes(mpg, wt)) + geom_point() + theme_aib_slide()
  expect_s3_class(p, "ggplot")
})

# theme_aib_map
test_that("theme_aib_map() has no axis elements", {
  thm <- theme_aib_map()
  expect_equal(thm$axis.line, element_blank())
  expect_equal(thm$axis.text, element_blank())
  expect_equal(thm$axis.ticks, element_blank())
  expect_equal(thm$axis.title, element_blank())
})

test_that("theme_aib_map() retains title styling", {
  thm <- theme_aib_map()
  expect_s3_class(thm$plot.title, "element_text")
  expect_equal(thm$plot.title$hjust, 0)
})
