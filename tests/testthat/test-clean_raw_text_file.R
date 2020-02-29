library(testthat)
# Can't test for null character removal because R doesn't let us use those
# at all.
#
test_that("Quote characters and first line get removed", {
  clean_string <- "Ugly string with quotes in it."
  ugly_string <- "\nUgly string with quotes \"in\" it."
  writeLines(ugly_string, "ugly_string_test_file.txt")
  expect_equal(
    clean_raw_text_file("ugly_string_test_file.txt"),
    clean_string
  )
  file.remove("ugly_string_test_file.txt")
})
