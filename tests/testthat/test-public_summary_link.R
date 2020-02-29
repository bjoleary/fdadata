test_that("public summary links are correct", {
  # Read in known values from file
  links <- readr::read_delim("links.csv",
                    delim = ",",
                    col_types = readr::cols(
                      submission_number = readr::col_character(),
                      database_link_verified = readr::col_skip(),
                      summary_link_verified = readr::col_character()
                    )) %>%
    # Calculate expected values
    dplyr::mutate(summary_link = public_summary_link(submission_number))

  expect_equal(links$summary_link_verified, links$summary_link)
})
