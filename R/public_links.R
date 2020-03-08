#' Return a link to the summary
#'
#' @param submission_number The unique identifier of the submission
#' @return A url to the public summary of the submission
#'
public_link_summary <- function(submission_number) {
  year <- extract_submission_year(submission_number)
  url_base <- "https://www.accessdata.fda.gov/cdrh_docs/pdf"
  url_extension <- ".pdf"
  # Starting in 2002, FDA started filing submissions in folders corresponding
  # to the year in the submission number, like "/pdf2/" for 2002, "/pdf10/" for
  # 2010, etc. Let's get those numbers:
  year_characters <- dplyr::case_when(
    # For 2009 and below, grab last digit
    year <= 2009 ~ stringr::str_sub(as.character(year), 4, 4),
    # For 2010 and above, grab last two digits
    year >= 2010 ~ stringr::str_sub(as.character(year), 3, 4)
  )

  # Okay. Now we have all the pieces, and we can put them together:
  url_return <- dplyr::case_when(
    # Folders started in 2002, so nothing fancy needed before then:
    year <= 2001 ~ paste(url_base,
      "/",
      submission_number,
      url_extension,
      sep = ""
    ),
    # 2002 and up:
    year >= 2002 ~ paste(url_base,
      year_characters,
      "/",
      submission_number,
      url_extension,
      sep = ""
    )
  )
  url_return
}

#' Return a link to the FDA review
#'
#' @param submission_number The unique identifier of the submission
#' @return A url to the public FDA review of the submission
#'
public_link_review <- function(submission_number) {
  url_base <- "https://www.accessdata.fda.gov/cdrh_docs/reviews/"
  url_extension <- ".pdf"
  paste0(url_base, submission_number, url_extension)
}

#' Return a link to the FOIA-Redacted Submission
#'
#' @param submission_number The unique identifier of the submission
#' @return A url to the public FOIA-redacted submission
#'
public_link_submission <- function(submission_number) {
  if (stringr::str_detect(
    submission_number,
    stringr::fixed("K",
      ignore_case = TRUE
    )
  )) {
    url_submission <- paste0(
      "https://www.accessdata.fda.gov/CDRH510K/",
      submission_number,
      ".pdf"
    )
  }
  url_submission
}
#' Determine the calendar year the submission was numbered
#'
#' @param submission_number The unique identifier of the submission
#' @return The calendar year the submission was assigned a number. Note that the
#' start date may correspond to a different year, so this is calculated based
#' on the submission number since that is how FDA files the associated documents
#' on its website.
#'
extract_submission_year <- function(submission_number) {
  # Find the string of characters that includes the calendar year indicators in
  # the submission number. these are capital letters from A-Z, excluding S
  # (which is used for Supplements) and followed by two digits.
  #
  regular_expression <- "[A-RT-Z]\\d\\d"
  year_string <- stringr::str_extract(submission_number, regular_expression)
  # Now remove the letter
  year_string <- stringr::str_sub(year_string, 2, 3)
  # Convert to number to simplify logic below
  year <- as.numeric(year_string)
  year <- dplyr::case_when(
    year < 76 ~ 2000 + year,
    year >= 76 ~ 1900 + year
  )
}
