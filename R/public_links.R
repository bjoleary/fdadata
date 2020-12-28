#' Return a link to the summary
#'
#' @param submission_number The unique identifier of the submission
#' @return A url to the public summary of the submission
#'
#' @export
#'
public_link_summary <- function(submission_number) {
  url_return <-
    paste0(
      "https://www.accessdata.fda.gov/cdrh_docs/",
      year_folder(submission_number = submission_number),
      submission_number,
      ".pdf"
    )

  url_return <-
  dplyr::case_when(
    # For PMAs, put an "A" at the end.
    stringr::str_starts(
      string = submission_number,
      pattern = "P|p"
    ) ~
      stringr::str_replace(
        string = url_return,
        pattern = stringr::fixed(".pdf"),
        replacement = "A.pdf"
      ),
    TRUE ~ url_return
  )
}

#' Return a link to the FDA review
#'
#' Works for PMAs and 510(k)s
#'
#' @param submission_number The unique identifier of the submission
#' @return A url to the public FDA review of the submission
#'
#' @export
#'
public_link_review <- function(submission_number) {
  dplyr::case_when(
    stringr::str_starts(submission_number, "K|k") ~
      paste0(
        "https://www.accessdata.fda.gov/cdrh_docs/reviews/",
        submission_number,
        ".pdf"
      ),
    stringr::str_starts(submission_number, "P|p") ~
      paste0(
        "https://www.accessdata.fda.gov/cdrh_docs/pdf",
        substr(submission_number, 2, 3) %>%
          # Remove leading zeros
          stringr::str_remove(
            string = .,
            pattern = "\\b0"
          ),
        "/",
        submission_number,
        "B.pdf"
      ),
    TRUE ~ NA_character_
  )
}

#' Return a link to the FOIA-Redacted Submission
#'
#' Only works for 510(k)s
#'
#' @param submission_number The unique identifier of the submission
#' @return A url to the public FOIA-redacted submission
#'
public_link_submission <- function(submission_number) {
  dplyr::case_when(
    stringr::str_starts(submission_number, "K|k") ~
      paste0(
        "https://www.accessdata.fda.gov/CDRH510K/",
        submission_number,
        ".pdf"
      ),
    TRUE ~ NA_character_
  )
}

#' Return a link to the Device Labeling
#'
#' Only works for original PMAs
#'
#' @param submission_number The unique identifier of the submission
#' @return A url to the device labeling
#'
#' @export
#'
public_link_labeling <- function(submission_number) {
  dplyr::case_when(
    stringr::str_starts(submission_number, "P|p") ~
      paste0(
        "https://www.accessdata.fda.gov/cdrh_docs/",
        year_folder(submission_number = submission_number),
        submission_number,
        "C.pdf"
      ),
    TRUE ~ NA_character_
  )
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

#' Year folder in accessdata.fda.gov
#'
#' @param submission_number The unique identifier of the submission
#' @return The folder the submission is under at accessdata. For "K19", "pdf19".
#' For "K05", "pdf5".
#'
year_folder <- function(submission_number) {
  year <- extract_submission_year(submission_number)
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
  dplyr::case_when(
    # Folders started in 2002, so nothing fancy needed before then:
    year <= 2001 ~ "",
    # 2002 and up:
    year >= 2002 ~
      paste0(
        "pdf",
        year_characters,
        "/"
      ),
    TRUE ~ ""
  )
}
