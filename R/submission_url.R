#' Return the URL of the submission in the fda database.
#' Currently handles 510(k)s, De Novos, PMAs, HDEs, CRs, CWs, and Recalls.
#'
#' @param Submission_Number The submission number
#' @return The URL of the submission in the database
#' @export
#'
submission_url <- function(Submission_Number) {
  # Remove slashes (really removes all but alpha-numeric)
  Submission_Number <- gsub("[^A-Za-z0-9-]", "", Submission_Number)

  url_return <- dplyr::case_when(
    stringr::str_to_upper(stringr::str_sub(Submission_Number,1,1)) == "K" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfPMN/pmn.cfm",
            "?id=", Submission_Number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(Submission_Number,1,1)) == "P" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfPMA/pma.cfm",
            "?id=", Submission_Number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(Submission_Number,1,3)) == "DEN" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfpmn/",
            "denovo.cfm?id=", Submission_Number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(Submission_Number,1,1)) == "H" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfhde/hde.cfm",
            "?id=", Submission_Number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(Submission_Number,1,1)) == "N" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfPMA/pma.cfm",
            "?id=", Submission_Number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(Submission_Number,1,2)) == "CR" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfClia/Results",
            ".cfm?start_search=1&Document_Number=",
            Submission_Number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(Submission_Number,1,2)) == "CW" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfClia/Results",
            ".cfm?start_search=1&Document_Number=",
            Submission_Number, sep = ""),
    stringr::str_to_upper(stringr::str_sub(Submission_Number,1,1)) == "Z" ~
      paste("https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfRES/res",
            ".cfm?start_search=1&recallnumber=", Submission_Number, sep = ""),
    TRUE ~ "UNKNOWN"
    )
  if(url_return == "UNKNOWN"){
    stop(paste("Unable to parse submission number: ", Submission_Number,
               sep = ""))
  }
  url_return
}
