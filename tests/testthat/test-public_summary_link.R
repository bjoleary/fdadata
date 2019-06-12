test_that("public summary links are correct", {
  # Read in known values from file
  links <- readr::read_delim("links.csv",
                    delim = ",",
                    col_types = readr::cols(
                      Submission_Number = readr::col_character(),
                      Database_Link_Verified = readr::col_skip(),
                      Summary_Link_Verified = readr::col_character()
                    )) %>%
    # Calculate expected values
    dplyr::mutate(Summary_Link = public_summary_link(Submission_Number))

  expect_equal(links$Summary_Link_Verified, links$Summary_Link)
})
