#' ETL 510(k) and De Novo data from the FDA website.
#'
#' @param refresh_data Boolean. When \code{TRUE}, fresh data is downloaded from
#' fda.gov. When \code{FALSE}, data is read in from a text file on the disk.
#' @param download_directory Defaults to \code{data/}.
#' @return 510(k) and De Novo data as a tibble
#' @source Data is downloaded from
#' \url{https://www.fda.gov/medical-devices/510k-clearances/downloadable-510k-files}.
#' @export
#' @importFrom magrittr "%>%"
#' @importFrom rlang ".data"
etl_pmn <- function(refresh_data = FALSE,
                    download_directory = "data/") {
  # Set some initial values ----------------------------------------------------
  filenames_root <- c(
    "pmn7680",
    "pmn8185",
    "pmn8690",
    "pmn9195",
    "pmn96cur"
  )

  # Refresh the data if appropriate --------------------------------------------
  if (refresh_data == TRUE) {
    refresh_files(
      filenames_root = filenames_root,
      download_directory = download_directory
    )
  }

  # Read the files -------------------------------------------------------------
  # Set the column types
  col_types <- readr::cols(
    KNUMBER = readr::col_character(),
    APPLICANT = readr::col_character(),
    CONTACT = readr::col_character(),
    STREET1 = readr::col_character(),
    STREET2 = readr::col_character(),
    CITY = readr::col_character(),
    STATE = readr::col_character(),
    COUNTRY_CODE = readr::col_factor(),
    ZIP = readr::col_character(),
    POSTAL_CODE = readr::col_skip(),
    DATERECEIVED = readr::col_date(format = "%m/%d/%Y"),
    DECISIONDATE = readr::col_date(format = "%m/%d/%Y"),
    DECISION = readr::col_character(),
    REVIEWADVISECOMM = readr::col_character(),
    PRODUCTCODE = readr::col_character(),
    STATEORSUMM = readr::col_factor(),
    CLASSADVISECOMM = readr::col_skip(),
    SSPINDICATOR = readr::col_skip(),
    TYPE = readr::col_character(),
    THIRDPARTY = readr::col_character(),
    EXPEDITEDREVIEW = readr::col_character(),
    DEVICENAME = readr::col_character()
  )

  # Read the files -------------------------------------------------------------
  lapply(
    filenames_root,
    function(filename_root) {
      message(
        paste0(
          "Reading in the cleaned data from ",
          path_clean(filename_root, download_directory),
          "..."
        )
      )
      readr::read_delim(
        file = path_clean(filename_root, download_directory),
        delim = "|",
        col_types = col_types,
        locale = readr::locale(encoding = "Latin1")
      )
    }
  ) %>%
    dplyr::bind_rows() %>%
    # Rename the fields
    dplyr::rename(
      submission_number = .data$KNUMBER,
      sponsor = .data$APPLICANT,
      contact = .data$CONTACT,
      address_line_1 = .data$STREET1,
      address_line_2 = .data$STREET2,
      city = .data$CITY,
      state = .data$STATE,
      zip_code = .data$ZIP,
      country = .data$COUNTRY_CODE,
      date_start = .data$DATERECEIVED,
      date_decision = .data$DECISIONDATE,
      decision_code = .data$DECISION,
      panel_code = .data$REVIEWADVISECOMM,
      product_code = .data$PRODUCTCODE,
      summary = .data$STATEORSUMM,
      track = .data$TYPE,
      third_party_review = .data$THIRDPARTY,
      expedited = .data$EXPEDITEDREVIEW,
      device = .data$DEVICENAME
    ) %>%
    # Clean up the fields
    dplyr::mutate(
      # Identify submission type
      type =
        dplyr::case_when(
          stringr::str_detect(.data$submission_number, "DEN") ~ "De Novo",
          stringr::str_detect(.data$submission_number, "K") ~ "510(k)",
          TRUE ~ NA_character_
        ) %>%
        forcats::as_factor(),
      # Clean up expedited column
      expedited =
        dplyr::case_when(
          .data$expedited == "Y" ~ "Expedited",
          .data$expedited == "N" ~ "Not Expedited",
          !is.na(.data$expedited) ~ .data$expedited,
          is.na(.data$expedited) ~ "Not Expedited",
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
      # Replace panel codes with names
      panel = expand_panels(.data$panel_code),
      # Add Third Party to the Track
      track =
        dplyr::case_when(
          .data$third_party_review == "Y" ~
            paste("Third Party", .data$track, sep = " "),
          TRUE ~ .data$track
        ) %>%
        forcats::as_factor(),
      # Determine the decision
      decision = decode_decision(.data$decision_code),
      decision_category = categorize_decision(.data$decision_code)
    ) %>%
    dplyr::arrange(.data$date_start, .data$submission_number)
}
