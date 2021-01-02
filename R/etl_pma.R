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
  filename_root <- "pma"

  # Refresh data if appropriate ------------------------------------------------
  if (refresh_data == TRUE) {
    refresh_files(
      filenames_root = c(filename_root),
      download_directory = download_directory
    )
  }
  # Read the file --------------------------------------------------------------
  message(
    "Reading in the cleaned data from ",
    path_clean(
      filenames_root = filename_root,
      download_directory = download_directory
    )
  )

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

  data <-
    readr::read_delim(
      file =
        path_clean(
          filenames_root = filename_root,
          download_directory = download_directory
        ),
      delim = "|",
      col_types = col_types
    ) %>%
    # Rename the fields
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
      panel = .data$ADVISORYCOMMITTEE,
      product_code = .data$PRODUCTCODE,
      track = .data$SUPPLEMENTTYPE,
      reason = .data$SUPPLEMENTREASON,
      device = .data$TRADENAME
    ) %>%
    # Clean up the fields
    dplyr::mutate(
      type = "PMA",
      track = forcats::as_factor(.data$track),
      panel = expand_panels(.data$panel),
      # Determine the decision
      decision = decode_decision(.data$decision_code),
      decision_category = categorize_decision(.data$decision_code)
    ) %>%
    dplyr::arrange(.data$date_start, .data$submission_number)
}
