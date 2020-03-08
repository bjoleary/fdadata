test_that("database links are correct", {
  # Read in known values from file
  links <- readr::read_delim("links.csv",
    delim = ",",
    col_types = readr::cols(
      submission_number = readr::col_character(),
      database_link_verified = readr::col_character(),
      summary_link_verified = readr::col_skip(),
      review_link_verified = readr::col_skip(),
      submission_link_verified = readr::col_skip(),
      nct = readr::col_skip()
    )
  ) %>%
    # Calculate expected values
    dplyr::mutate(database_link = submission_url(submission_number))

  expect_equal(links$database_link_verified, links$database_link)
})

test_that("summary links are correct", {
  # Read in known values from file
  links <- readr::read_delim("links.csv",
    delim = ",",
    col_types = readr::cols(
      submission_number = readr::col_character(),
      database_link_verified = readr::col_skip(),
      summary_link_verified = readr::col_character(),
      review_link_verified = readr::col_skip(),
      submission_link_verified = readr::col_skip(),
      nct = readr::col_skip()
    )
  ) %>%
    # Calculate expected values
    dplyr::mutate(summary_link = public_link_summary(submission_number))

  expect_equal(links$summary_link_verified, links$summary_link)
})

test_that("review links are correct", {
  # Read in known values from file
  links <- readr::read_delim("links.csv",
    delim = ",",
    col_types = readr::cols(
      submission_number = readr::col_character(),
      database_link_verified = readr::col_skip(),
      summary_link_verified = readr::col_skip(),
      review_link_verified = readr::col_character(),
      submission_link_verified = readr::col_skip(),
      nct = readr::col_skip()
    )
  ) %>%
    # Calculate expected values
    dplyr::mutate(review_link = public_link_review(submission_number))

  expect_equal(links$review_link_verified, links$review_link)
})

test_that("submission links are correct", {
  # TODO: testthat is throwing a warning that this test is returning more
  # than one value. Need to look into this.

  # Read in known values from file
  links <- readr::read_delim("links.csv",
    delim = ",",
    col_types = readr::cols(
      submission_number = readr::col_character(),
      database_link_verified = readr::col_skip(),
      summary_link_verified = readr::col_skip(),
      review_link_verified = readr::col_skip(),
      submission_link_verified = readr::col_character(),
      nct = readr::col_skip()
    )
  ) %>%
    # Calculate expected values
    dplyr::mutate(submission_link = public_link_submission(submission_number))

  expect_equal(links$submission_link_verified, links$submission_link)
})
