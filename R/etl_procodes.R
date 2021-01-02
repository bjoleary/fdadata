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

  # Refresh data if appropriate ------------------------------------------------
  if (refresh_data == TRUE) {
    refresh_files(
      filenames_root = c(filename_root),
      download_directory = download_directory
    )
  }
  message(
    "Reading in the cleaned data from ",
    path_clean(
      filenames_root = filename_root,
      download_directory = download_directory
    )
  )
  data <- readr::read_delim(
    file =
      path_clean(
        filenames_root = filename_root,
        download_directory = download_directory
      ),
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
        SUBMISSION_TYPE_ID = readr::col_integer(),
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
    ) %>%
    dplyr::select(
      .data$review_panel,
      medical_specialty = .data$medicalspecialty,
      product_code = .data$productcode,
      device_type_name = .data$devicename,
      device_class = .data$deviceclass,
      .data$unclassified_reason,
      gmp_exempt = .data$gmpexemptflag,
      third_party_eligible = .data$thirdpartyflag,
      # All rows are NA for reviewcode as of 2020-12-24.
      # review_code = .data$reviewcode,
      regulation = .data$regulationnumber,
      submission_type = .data$submission_type_id,
      .data$definition,
      physical_state = .data$physicalstate,
      technical_method = .data$technicalmethod,
      target_area = .data$targetarea,
      implant = .data$implant_flag,
      life_sustaining = .data$life_sustain_support_flag,
      .data$summary_malfunction_reporting
    ) %>%
    dplyr::mutate(
      review_panel = expand_panels(.data$review_panel),
      medical_specialty = expand_panels(.data$medical_specialty),
      unclassified_reason =
        dplyr::case_when(
          .data$unclassified_reason == "1" ~ "Pre-Amendment",
          .data$unclassified_reason == "2" ~ "IDE",
          .data$unclassified_reason == "3" ~ "For Export Only",
          .data$unclassified_reason == "4" ~ "Unknown",
          .data$unclassified_reason == "5" ~ "Guidance Under Development",
          .data$unclassified_reason == "6" ~ "Enforcement Discretion",
          .data$unclassified_reason == "7" ~ "Not FDA Regulated",
          TRUE ~ NA_character_
        ) %>%
        forcats::as_factor(),
      gmp_exempt =
        dplyr::case_when(
          .data$gmp_exempt == "Y" ~ "GMP Exempt",
          .data$gmp_exempt == "N" ~ "Subject to GMP",
          TRUE ~ .data$gmp_exempt
        ) %>%
        forcats::as_factor(),
      third_party_eligible =
        dplyr::case_when(
          .data$third_party_eligible == "Y" ~ "Eligible for 3rd Party Review",
          .data$third_party_eligible == "N" ~ "Ineligible for 3rd Party Review",
          TRUE ~ .data$third_party_eligible
        ) %>%
        forcats::as_factor(),
      submission_type =
        dplyr::case_when(
          .data$submission_type == 1 ~ "510(k)",
          .data$submission_type == 2 ~ "PMA",
          .data$submission_type == 3 ~ "Contact FDA",
          .data$submission_type == 4 ~ "510(k) Exempt",
          .data$submission_type == 6 ~ "HDE - Humanitarian Device Exemption",
          .data$submission_type == 7 ~ "Enforcement Discretion",
          .data$submission_type == 8 ~ "EUA - Emergency Use Authorization",
          TRUE ~ NA_character_
        ) %>%
        forcats::as_factor(),
      implant =
        dplyr::case_when(
          .data$implant == "Y" ~ "Implant",
          .data$implant == "N" ~ "Not an implant",
          TRUE ~ .data$implant
        ) %>%
        forcats::as_factor(),
      life_sustaining =
        dplyr::case_when(
          .data$life_sustaining == "Y" ~ "Life-sustaining or supporting",
          .data$life_sustaining == "N" ~ "Not life-sustaining or supporting",
          TRUE ~ .data$life_sustaining
        ) %>%
        forcats::as_factor(),
      summary_malfunction_reporting =
        dplyr::case_when(
          .data$summary_malfunction_reporting == "Eligible" ~
            "Eligible for summary malfunction reporting",
          .data$summary_malfunction_reporting == "Ineligible" ~
            "Ineligible for summary malfunction reporting",
          TRUE ~ .data$summary_malfunction_reporting
        ) %>%
        forcats::as_factor(),
    )
}
