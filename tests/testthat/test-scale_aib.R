test_that("scale_color_aib() returns a ggplot scale", {
  sc <- scale_color_aib()
  expect_s3_class(sc, "ScaleDiscrete")
})

test_that("scale_fill_aib() returns a ggplot scale", {
  sc <- scale_fill_aib()
  expect_s3_class(sc, "ScaleDiscrete")
})

test_that("scale_color_aib() can be added to a ggplot", {
  p <- ggplot(mtcars, aes(mpg, wt, color = factor(cyl))) +
    geom_point() +
    scale_color_aib()
  expect_s3_class(p, "ggplot")
})

test_that("scale_fill_aib() can be added to a ggplot", {
  p <- ggplot(mtcars, aes(factor(cyl), fill = factor(cyl))) +
    geom_bar() +
    scale_fill_aib()
  expect_s3_class(p, "ggplot")
})
