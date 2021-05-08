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
      labeling_link_verified = readr::col_skip(),
      nct = readr::col_skip()
    )
  ) %>%
    # Calculate expected values
    dplyr::mutate(
      database_link = submission_url(.data$submission_number)
    )

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
      labeling_link_verified = readr::col_skip(),
      nct = readr::col_skip()
    )
  ) %>%
    # Calculate expected values
    dplyr::mutate(
      summary_link = public_link_summary(.data$submission_number)
    )

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
      labeling_link_verified = readr::col_skip(),
      nct = readr::col_skip()
    )
  ) %>%
    # Some of the earlier submission test cases are from before reviews were
    # posted online.
    dplyr::filter(
      !is.na(.data$review_link_verified)
    ) %>%
    # Calculate expected values
    dplyr::mutate(
      review_link = public_link_review(.data$submission_number)
    )

  expect_equal(links$review_link_verified, links$review_link)
})

test_that("submission links are correct", {
  # Read in known values from file
  links <- readr::read_delim("links.csv",
    delim = ",",
    col_types = readr::cols(
      submission_number = readr::col_character(),
      database_link_verified = readr::col_skip(),
      summary_link_verified = readr::col_skip(),
      review_link_verified = readr::col_skip(),
      submission_link_verified = readr::col_character(),
      labeling_link_verified = readr::col_skip(),
      nct = readr::col_skip()
    )
  ) %>%
    # Calculate expected values
    dplyr::mutate(
      submission_link = public_link_submission(.data$submission_number)
    )

  expect_equal(links$submission_link_verified, links$submission_link)
})

test_that("labeling links are correct", {
  # Read in known values from file
  links <-
    readr::read_delim(
      "links.csv",
      delim = ",",
      col_types = readr::cols(
        submission_number = readr::col_character(),
        database_link_verified = readr::col_skip(),
        summary_link_verified = readr::col_skip(),
        review_link_verified = readr::col_skip(),
        submission_link_verified = readr::col_skip(),
        labeling_link_verified = readr::col_character(),
        nct = readr::col_skip()
      )
    ) %>%
    # Calculate expected values
    dplyr::mutate(
      labeling_link = public_link_labeling(.data$submission_number)
    )

  expect_equal(links$labeling_link_verified, links$labeling_link)
})
