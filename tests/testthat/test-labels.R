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
