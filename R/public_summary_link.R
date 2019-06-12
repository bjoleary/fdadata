#' Return a link to the summary
#'
#' @param Submission_Number The unique identifier of the submission
#' @return A url to the public summary of the submission
#'
public_summary_link <- function(Submission_Number){
  year <- extract_submission_year(Submission_Number)
  url_base <- "https://www.accessdata.fda.gov/cdrh_docs/pdf"
  url_extension <- ".pdf"
  # Starting in 2002, FDA started filing submissions in folders corresponding
  # to the year in the submission number, like "/pdf2/" for 2002, "/pdf10/" for
  # 2010, etc. Let's get those numbers:
  year_characters <- dplyr::case_when(
    # For 2009 and below, grab last digit
    year <= 2009 ~ stringr::str_sub(as.character(year), 4,4),
    # For 2010 and above, grab last two digits
    year >= 2010 ~ stringr::str_sub(as.character(year), 3, 4)
  )

  # Okay. Now we have all the pieces, and we can put them together:
  url_return <- dplyr::case_when(
    # Folders started in 2002, so nothing fancy needed before then:
    year <= 2001 ~ paste(url_base,
                         "/",
                         Submission_Number,
                         url_extension,
                         sep = ""),
    # 2002 and up:
    year >= 2002 ~ paste(url_base,
                         year_characters,
                         "/",
                         Submission_Number,
                         url_extension,
                         sep = "")
  )
  url_return
}


#' Determine the calendar year the submission was numbered
#'
#' @param Submission_Number The unique identifier of the submission
#' @return The calendar year the submission was assigned a number. Note that the
#' start date may correspond to a different year, so this is calculated based
#' on the submission number since that is how FDA files the associated documents
#' on its website.
#'
extract_submission_year <- function(Submission_Number){
  # Find the string of characters that includes the calendar year indicators in
  # the submission number. these are capital letters from A-Z, excluding S
  # (which is used for Supplements) and followed by two digits.
  #
  regular_expression <- "[A-RT-Z]\\d\\d"
  year_string <- stringr::str_extract(Submission_Number, regular_expression)
  # Now remove the letter
  year_string <- stringr::str_sub(year_string, 2, 3)
  # Convert to number to simplify logic below
  year <- as.numeric(year_string)
  year <- dplyr::case_when(
    year < 76 ~ 2000 + year,
    year >=76 ~ 1900 + year
  )
}
