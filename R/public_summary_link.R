#' Return a link to the summary
#'
#' @param Submission_Number The unique identifier of the submission
#' @return A url to the public summary of the submission
#'
public_summary_link <- function(Submission_Number){
  # 510(k)s numbered in 1976 - 2001 inclusive ----------------------------------
  url_return <- paste("https://www.accessdata.fda.gov/cdrh_docs/pdf/",
                      Submission_Number,
                      ".pdf",
                      sep = "")

  # 510(k)s numbered 2002 - present, inclusive ---------------------------------



  # De Novos numbered 1976 - X, inclusive --------------------------------------




  # De Novos numbered X - present, inclusive -----------------------------------

  url_return
}
