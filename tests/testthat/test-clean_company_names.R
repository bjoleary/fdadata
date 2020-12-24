test_that("non-thorough company name cleaning", {
  expect_equal(
    clean_company_names(
      string =
        c(
          "acme",
          "MeDical Device Company & Sons, Inc.",
          "Animas LLC",
          "Roche Switzerland AG"
        ),
      thorough = FALSE
    ),
    c(
      "ACME",
      "MEDICAL DEVICE AND SONS",
      "ANIMAS",
      "ROCHE SWITZERLAND"
    )
  )
})

test_that("thorough company name cleaning", {
  expect_equal(
    clean_company_names(
      string =
        c(
          "acme",
          "MeDical Device Company & Sons, Inc.",
          "Animas LLC",
          "Roche Switzerland AG"
        ),
      thorough = TRUE
    ),
    c(
      "ACME",
      "MEDICAL DEVICE AND SONS",
      "JOHNSON AND JOHNSON",
      "ROCHE"
    )
  )
})

test_that("regex prep works", {
  expect_equal(
    prep_regex(
      vector =
        c(
          "first term",
          "SECOND TERM",
          "3rd term"
        )
      ),
    stringr::regex(
      pattern = "\\bfirst term\\b|\\bSECOND TERM\\b|\\b3rd term\\b",
      ignore_case = TRUE
    )
  )
})

