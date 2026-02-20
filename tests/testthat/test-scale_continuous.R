# Continuous
test_that("scale_color_aib_c() returns a continuous scale", {
  sc <- scale_color_aib_c()
  expect_s3_class(sc, "ScaleContinuous")
})

test_that("scale_fill_aib_c() returns a continuous scale", {
  sc <- scale_fill_aib_c()
  expect_s3_class(sc, "ScaleContinuous")
})

test_that("scale_color_aib_c() accepts custom low/high", {
  sc <- scale_color_aib_c(low = "#C00404", high = "#00AF9A")
  expect_s3_class(sc, "ScaleContinuous")
})

test_that("scale_color_aib_c() can be added to a ggplot", {
  p <- ggplot(mtcars, aes(mpg, wt, color = hp)) +
    geom_point() +
    scale_color_aib_c()
  expect_s3_class(p, "ggplot")
})

# Diverging
test_that("scale_color_aib_div() returns a continuous scale", {
  sc <- scale_color_aib_div()
  expect_s3_class(sc, "ScaleContinuous")
})

test_that("scale_fill_aib_div() returns a continuous scale", {
  sc <- scale_fill_aib_div()
  expect_s3_class(sc, "ScaleContinuous")
})

test_that("scale_color_aib_div() can be added to a ggplot", {
  p <- ggplot(mtcars, aes(mpg, wt, color = hp)) +
    geom_point() +
    scale_color_aib_div()
  expect_s3_class(p, "ggplot")
})
