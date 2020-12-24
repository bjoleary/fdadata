#' ETL Product Code data from the FDA website.
#'
#' @param refresh_data Boolean. When \code{TRUE}, fresh data is downloaded from
#' fda.gov. When \code{FALSE}, data is read in from a text file on the disk.
#' @param download_directory Defaults to \code{data/}.
#' @return Medical Device product code data as a tibble
#' @source Data is downloaded from \url{https://go.usa.gov/xEKmh}.
#' @export
etl_procodes <- function(refresh_data = FALSE,
                         download_directory = "data/") {
  # Set some initial values ----------------------------------------------------
  filename_root <- "foiclass"

  filename_procode_txt <- paste0(download_directory, filename_root, ".txt")
  filename_procode_clean_txt <- paste0(download_directory, "procode_clean.txt")
  filename_accessed_datetime <-
    paste0(download_directory, "procode_accessed.txt")

  if (refresh_data == TRUE) {
    message(paste("Deleting old download files..."))
    file_remove(filename_procode_txt)
    file_remove(filename_procode_clean_txt)
    file_remove(filename_accessed_datetime)
    download_generic(
      filename_roots = c(filename_root),
      filename_accessed_datetime = filename_accessed_datetime,
      download_directory = "data/"
    )
    # Clean the data -----------------------------------------------------------
    # Before we read this in as a delim file, submission K010142 includes a
    # quote character in the record that messes things up. Let's remove those.

    # Get the header row from one of the input files
    header_string <- readr::read_lines(filename_procode_txt, n_max = 1)

    # Put that header row into the clean output file
    write(header_string, file = filename_procode_clean_txt, append = FALSE)
    remove(header_string)

    clean_raw_text_file(filename_procode_txt) %>%
      write(file = filename_procode_clean_txt, append = TRUE)
  }
  # Check for the file we need -------------------------------------------------
  files <- c(filename_procode_clean_txt, filename_accessed_datetime)
  errors <- lapply(files, function(x) {
    if (!file.exists(x)) {
      paste("\n\tMissing file:", x)
    }
  }) %>%
    unlist()
  if (!is.null(errors)) {
    stop(paste(errors, collapse = "\n"))
  }

  message("Reading in the cleaned data from ", filename_procode_clean_txt)
  data <- readr::read_delim(
    file = filename_procode_clean_txt,
    delim = "|",
    col_types =
      readr::cols(
        REVIEW_PANEL = readr::col_character(),
        MEDICALSPECIALTY = readr::col_character(),
        PRODUCTCODE = readr::col_character(),
        DEVICENAME = readr::col_character(),
        DEVICECLASS = readr::col_character(),
        UNCLASSIFIED_REASON = readr::col_double(),
        GMPEXEMPTFLAG = readr::col_character(),
        THIRDPARTYFLAG = readr::col_character(),
        REVIEWCODE = readr::col_logical(),
        REGULATIONNUMBER = readr::col_double(),
        SUBMISSION_TYPE_ID = readr::col_double(),
        DEFINITION = readr::col_character(),
        PHYSICALSTATE = readr::col_character(),
        TECHNICALMETHOD = readr::col_character(),
        TARGETAREA = readr::col_character(),
        Implant_Flag = readr::col_character(),
        Life_Sustain_support_flag = readr::col_character(),
        SummaryMalfunctionReporting = readr::col_character()
      )
  ) %>%
    dplyr::rename_with(
      .fn = snakecase::to_snake_case
    ) %>%
    dplyr::mutate_if(
      .predicate = is.character,
      .funs = stringr::str_squish
    )
}
