#' ETL PMA data from the FDA website.
#'
#' @param refresh_data Boolean. When \code{TRUE}, fresh data is downloaded from
#' fda.gov. When \code{FALSE}, data is read in from a text file on the disk.
#' @param download_directory Defaults to \code{data/}.
#' @return PMA data as a tibble
#' @source Data is downloaded from \url{https://go.usa.gov/xMQET}.
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
    ZIP_EXT = readr::col_character(),
    GENERICNAME = readr::col_character(),
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
      col_types = col_types,
      locale = readr::locale(encoding = "Latin1")
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
      device = .data$TRADENAME,
      dplyr::everything()
    ) %>%
    # Clean up the fields
    dplyr::mutate(
      type = "PMA",
      track = forcats::as_factor(.data$track),
      panel_code = .data$panel,
      panel = expand_panels(.data$panel),
      zip_code =
        dplyr::case_when(
          is.na(.data$ZIP_EXT) ~ .data$zip_code,
          TRUE ~ paste(.data$zip_code, .data$ZIP_EXT, sep = "-")
        ),
      # Clean up expedited column
      expedited =
        dplyr::case_when(
          .data$REVIEWGRANTEDYN == "Y" ~ "Expedited",
          .data$REVIEWGRANTEDYN == "N" ~ "Not Expedited",
          TRUE ~ NA_character_
        ) %>%
        forcats::as_factor() %>%
        forcats::fct_expand(
          f = .,
          c(
            "Expedited",
            "Not Expedited"
          )
        ),
      # Determine the decision
      decision = decode_decision(.data$decision_code),
      decision_category = categorize_decision(.data$decision_code),
      country =
        dplyr::case_when(
          .data$state %in% us_states() ~ "USA",
          TRUE ~ NA_character_
        )
    ) %>%
    dplyr::arrange(.data$date_start, .data$submission_number) %>%
    dplyr::select(
      .data$submission_number,
      .data$sponsor,
      .data$address_line_1,
      .data$address_line_2,
      .data$city,
      .data$state,
      .data$country,
      .data$zip_code,
      .data$date_start,
      .data$date_decision,
      date_federal_register = .data$FEDREGNOTICEDATE,
      .data$decision_code,
      .data$panel_code,
      .data$product_code,
      generic_name = .data$GENERICNAME,
      .data$track,
      .data$reason,
      .data$expedited,
      .data$device,
      .data$type,
      .data$panel,
      .data$decision,
      .data$decision_category,
      docket_number = .data$DOCKETNUMBER,
      approval_order_statement = .data$AOSTATEMENT
    )
}
