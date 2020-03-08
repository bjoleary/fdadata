#' ETL PMA data from the FDA website.
#'
#' @param refresh_data Boolean. When \code{TRUE}, fresh data is downloaded from
#' fda.gov. When \code{FALSE}, data is read in from a text file on the disk.
#' @param download_directory Defaults to \code{data/}.
#' @return PMA data as a tibble
#' @source Data is downloaded from \url{https://go.usa.gov/xEKmh}.
#' @export
etl_pma <- function(refresh_data = FALSE,
                    download_directory = "data/") {
  # Set some initial values ----------------------------------------------------
  filename_roots <- c("pma")

  filename_pma_txt <- paste0(download_directory, filename_roots, ".txt")
  filename_pma_clean_txt <- paste0(download_directory, "pma_clean.txt")
  filename_accessed_datetime <- paste0(download_directory, "pma_accessed.txt")

  # Refresh the data if appropriate --------------------------------------------
  if (refresh_data == TRUE) {
    message(paste("Deleting old download files..."))
    lapply(filename_pma_txt, function(x) {
      file_remove(x)
    })
    file_remove(filename_pma_clean_txt)
    file_remove(filename_accessed_datetime)
    download_generic(
      filename_roots = filename_roots,
      filename_accessed_datetime = filename_accessed_datetime,
      download_directory = "data/"
    )
    # Clean the data -----------------------------------------------------------
    # Before we read this in as a delim file, submission K010142 includes a
    # quote character in the record that messes things up. Let's remove those.

    # Get the header row from one of the input files
    header_string <- readr::read_lines(filename_pma_txt[1], n_max = 1)

    # Put that header row into the clean output file
    write(header_string, file = filename_pma_clean_txt, append = FALSE)
    remove(header_string)

    lapply(filename_pma_txt, function(x) {
      data_string <- clean_raw_text_file(x)
      write(data_string, file = filename_pma_clean_txt, append = TRUE)
    })
  }

  # Check for the file we need -------------------------------------------------
  files <- c(filename_pma_clean_txt, filename_accessed_datetime)
  errors <- lapply(files, function(x) {
    if (!file.exists(x)) {
      paste("\n\tMissing file:", x)
    }
  }) %>%
    unlist()
  if (!is.null(errors)) {
    stop(paste(errors, collapse = "\n"))
  }
  # Read the file --------------------------------------------------------------
  # Set the column types
  col_types <- readr::cols(
    PMANUMBER = readr::col_character(),
    SUPPLEMENTNUMBER = readr::col_character(),
    APPLICANT = readr::col_character(),
    STREET_1 = readr::col_character(),
    STREET_2 = readr::col_character(),
    CITY = readr::col_character(),
    STATE = readr::col_character(),
    ZIP = readr::col_character(),
    ZIP_EXT = readr::col_skip(),
    GENERICNAME = readr::col_skip(),
    TRADENAME = readr::col_character(),
    PRODUCTCODE = readr::col_character(),
    ADVISORYCOMMITTEE = readr::col_character(),
    SUPPLEMENTTYPE = readr::col_character(),
    SUPPLEMENTREASON = readr::col_character(),
    REVIEWGRANTEDYN = readr::col_character(),
    DATERECEIVED = readr::col_date(format = "%m/%d/%Y"),
    DECISIONDATE = readr::col_date(format = "%m/%d/%Y"),
    DOCKETNUMBER = readr::col_character(),
    FEDREGNOTICEDATE = readr::col_date(format = "%m/%d/%Y"),
    DECISIONCODE = readr::col_character(),
    AOSTATEMENT = readr::col_character()
  )

  # Read the file --------------------------------------------------------------
  message(paste("Reading in the cleaned data from ",
    filename_pma_clean_txt,
    sep = ""
  ))
  data <- readr::read_delim(
    file = filename_pma_clean_txt,
    delim = "|",
    col_types = col_types
  )

  panels <- read_panels()
  decisions <- read_decisions()

  # Rename the fields ----------------------------------------------------------
  data <- data %>%
    dplyr::mutate(Submission_Number = dplyr::case_when(
      !is.na(.data$SUPPLEMENTNUMBER) ~
      paste(.data$PMANUMBER, .data$SUPPLEMENTNUMBER, sep = "/"),
      TRUE ~ .data$PMANUMBER
    )) %>%
    dplyr::select(
      submission_number = .data$Submission_Number,
      sponsor = .data$APPLICANT,
      address_line_1 = .data$STREET_1,
      address_line_2 = .data$STREET_2,
      city = .data$CITY,
      state = .data$STATE,
      zip_code = .data$ZIP,
      date_start = .data$DATERECEIVED,
      date_decision = .data$DECISIONDATE,
      decision_code = .data$DECISIONCODE,
      panel_code = .data$ADVISORYCOMMITTEE,
      product_code = .data$PRODUCTCODE,
      track = .data$SUPPLEMENTTYPE,
      reason = .data$SUPPLEMENTREASON,
      device = .data$TRADENAME
    )

  # Clean up the fields --------------------------------------------------------
  data <- data %>%
    # Replace panel codes with names
    dplyr::left_join(y = panels, by = c("panel_code" = "panel_code")) %>%
    dplyr::select(-.data$panel_code) %>%
    dplyr::mutate(panel = as.factor(.data$panel)) %>%
    dplyr::mutate(track = as.factor(.data$track)) %>%
    # Add Decisions
    dplyr::left_join(
      y = decisions,
      by = c("decision_code" = "decision_code")
    ) %>%
    dplyr::mutate(decision_code = as.factor(.data$decision_code)) %>%
    dplyr::mutate(decision_category = as.factor(.data$decision_category)) %>%
    dplyr::mutate(decision = as.factor(.data$decision))
}
