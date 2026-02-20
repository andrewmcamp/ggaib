test_that("aib_colors() returns all 8 colors as named vector", {
  colors <- aib_colors()
  expect_length(colors, 8)
  expect_named(colors)
  expect_equal(
    names(colors),
    c("navy", "red", "emerald", "yellow", "sky", "taupe", "brown", "gray")
  )
})

test_that("aib_colors() returns hex codes", {
  colors <- aib_colors()
  expect_true(all(grepl("^#[0-9A-Fa-f]{6}$", colors)))
})

test_that("aib_colors() subsets by name", {
  expect_equal(unname(aib_colors("navy")), "#1B3E6F")
  expect_equal(unname(aib_colors("red")), "#C00404")
  subset <- aib_colors("navy", "emerald")
  expect_length(subset, 2)
  expect_equal(names(subset), c("navy", "emerald"))
})

test_that("aib_colors() errors on invalid name", {
  expect_error(aib_colors("purple"), "not valid AIB colors")
})

test_that("aib_pal() returns a function", {
  pal <- aib_pal()
  expect_type(pal, "closure")
})

test_that("aib_pal() function returns n colors", {
  pal <- aib_pal()
  expect_length(pal(3), 3)
  expect_length(pal(8), 8)
})

test_that("aib_pal() respects contrast-first ordering", {
  pal <- aib_pal()
  colors <- pal(3)
  all_colors <- aib_colors()
  expect_equal(colors, unname(all_colors[1:3]))
})

test_that("aib_pal() warns when n > 8", {
  pal <- aib_pal()
  expect_warning(pal(9), "only 8 colors")
})
