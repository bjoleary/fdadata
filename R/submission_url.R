#' Return the URL of the submission in the fda database.
#' Currently handles 510(k)s, De Novos, PMAs, HDEs, CRs, CWs, and Recalls.
#'
#' @param submission_number The submission number
#' @return The URL of the submission in the database
#' @export
#'
submission_url <- function(submission_number) {
  # Remove slashes (really removes all but alpha-numeric)
  submission_number <- gsub("[^A-Za-z0-9-]", "", submission_number)

  url_return <- dplyr::case_when(
    stringr::str_to_upper(stringr::str_sub(submission_number,1,1)) == "K" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfPMN/pmn.cfm",
            "?id=", submission_number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(submission_number,1,1)) == "P" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfPMA/pma.cfm",
            "?id=", submission_number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(submission_number,1,3)) == "DEN" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfpmn/",
            "denovo.cfm?id=", submission_number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(submission_number,1,1)) == "H" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfhde/hde.cfm",
            "?id=", submission_number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(submission_number,1,1)) == "N" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfPMA/pma.cfm",
            "?id=", submission_number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(submission_number,1,2)) == "CR" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfClia/Results",
            ".cfm?start_search=1&Document_Number=",
            submission_number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(submission_number,1,2)) == "CW" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfClia/Results",
            ".cfm?start_search=1&Document_Number=",
            submission_number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(submission_number,1,1)) == "Z" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfRES/res",
            ".cfm?start_search=1&recallnumber=", submission_number, sep = ""),
    TRUE ~ "Unknown"
    )
  url_return
}
