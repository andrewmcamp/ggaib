test_that("aib_font() returns a character string", {
  result <- aib_font("heading")
  expect_type(result, "character")
  expect_length(result, 1)
})

test_that("aib_font() returns valid role names", {
  expect_no_error(aib_font("heading"))
  expect_no_error(aib_font("body"))
  expect_no_error(aib_font("serif"))
})

test_that("aib_font() errors on invalid role", {
  expect_error(aib_font("monospace"), "not a valid font role")
})

test_that("aib_font_families() returns named list of all roles", {
  families <- aib_font_families()
  expect_type(families, "list")
  expect_named(families, c("heading", "body", "serif"))
})
