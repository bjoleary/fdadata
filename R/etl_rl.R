#' Registration and Listing Cleanup
#'
#' Fix column names and clean strings
#'
#' @param df A dataframe from an R&L text file
#'
#' @return A dataframe with clean names and strings
#'
rl_cleanup <- function(df) {
  df %>%
    dplyr::rename_with(
      .fn = snakecase::to_snake_case
    ) %>%
    dplyr::mutate_if(
      .predicate = is.character,
      .funs = stringr::str_to_upper
    ) %>%
    dplyr::mutate_if(
      .predicate = is.character,
      .funs = stringr::str_squish
    ) %>%
    dplyr::mutate_if(
      is.character,
      ~dplyr::na_if(., "-")
    )
}

#' ETL Registration and Listing data from the FDA website.
#'
#' @param refresh_data Boolean. When \code{TRUE}, fresh data is downloaded from
#' fda.gov. When \code{FALSE}, data is read in from a text file on the disk.
#' @param download_directory Defaults to \code{data/}.
#' @return Registration and Listing data as a tibble
#' @source Data is downloaded from \url{https://go.usa.gov/xEKmh}.
#' @export
etl_rl <- function(refresh_data = FALSE,
                    download_directory = "data/") {
  # Set some initial values ----------------------------------------------------
  filename_roots <-
    c(
      "contact_addresses",
      "listing_estabtypes",
      "Listing_PCD",
      "Listing_Proprietary_Name",
      "Official_Correspondent",
      "Owner_Operator",
      "Registration",
      "registration_listing",
      "us_agent",
      "estabtypes",
      "Non_Reg_Imp_ID_by_Manu",
      "Manu_ID_by_Imp",
      "Reg_Imp_ID_by_Manu"
    )

  filename_rl_txt <- paste0(download_directory, filename_roots, ".txt")
  filename_rl_clean_txt <-
    paste0(download_directory, "clean_", filename_roots, ".txt")
  filename_accessed_datetime <- paste0(download_directory, "rl_accessed.txt")

  # Refresh the data if appropriate --------------------------------------------
  if (refresh_data == TRUE) {
    message(paste("Deleting old download files..."))
    lapply(c(filename_rl_txt, filename_rl_clean_txt), function(x) {
      file_remove(x)
    })
    file_remove(filename_accessed_datetime)
    download_generic(
      filename_roots = filename_roots,
      filename_accessed_datetime = filename_accessed_datetime,
      download_directory = "data/"
    )
    # Clean the data -----------------------------------------------------------
    for (i in seq_along(filename_rl_txt)) {
      header_string <- readr::read_lines(filename_rl_txt[i], n_max = 1)
      data_string <- clean_raw_text_file(filename_rl_txt[i])
      if (filename_roots[i] == "contact_addresses") {
        # Line 38470 has extra pipe characters as of 2020-12-19
        data_string <-
          stringr::str_replace(
            string = data_string,
            pattern =
              stringr::fixed(
                pattern = "Obour|EG-C|Al Qahirah",
                ignore_case = TRUE
              ),
            replacement = "Obour EG-C Al Qahirah"
          )
      } else if (filename_roots[i] == "Registration") {
        # Line 4477 has extra pipe characters as of 2020-12-19
        data_string <-
          stringr::str_replace(
            string = data_string,
            pattern =
              stringr::fixed(
                pattern = "Suite 100 | Houston, Texas 77040||Houston|TX|US|",
                ignore_case = TRUE
              ),
            replacement = "Suite 100 ||Houston|TX|US|"
          ) %>%
          # Line 17055 has extra pipe characters as of 2020-12-19
          stringr::str_replace(
            pattern =
              stringr::fixed(
                pattern =
                  paste0(
                    "| Block 13023 | Building 8 Obour city | ",
                    "Cairo - Egypt  ZIP code :   11828 | P.O.Box : 29|"
                  ),
                ignore_case = TRUE
              ),
            replacement = " Block 13023 Building 8 Obour city P.O.Box : 29|"
          ) %>%
          # Line 41953 has extra pipe characters as of 2020-12-19
          stringr::str_replace(
            pattern =
              stringr::fixed(
                pattern = "| Milford, OH |||Day Heights|OH|",
                ignore_case = TRUE
              ),
            replacement = "||Day Heights|OH|"
          )
      }  else if (filename_roots[i] == "Non_Reg_Imp_ID_by_Manu") {
        data_string <-
          # Line 6978 has extra pipe characters as of 2020-12-19
          stringr::str_replace(
            string = data_string,
            pattern =
              stringr::fixed(
                pattern = "| Tamarac, FL 33321||Fort Lauderdale |FL|33321|",
                ignore_case = TRUE
              ),
            replacement = "FL|33321|"
          )
      }
      readr::write_lines(
        x = c(header_string, data_string),
        file = filename_rl_clean_txt[i],
        append = FALSE
      )
    }
  }

  # Check for the file we need -------------------------------------------------
  files <- c(filename_rl_clean_txt, filename_accessed_datetime)
  errors <- lapply(files, function(x) {
    if (!file.exists(x)) {
      paste("\n\tMissing file:", x)
    }
  }) %>%
    unlist()
  if (!is.null(errors)) {
    stop(paste(errors, collapse = "\n"))
  }
  # Read the files -------------------------------------------------------------

  estabtypes <-
    readr::read_delim(
      file = paste0(download_directory, "clean_estabtypes.txt"),
      delim = "|",
      col_names =
        c(
          "establishment_type_id",
          "establishment_activity",
          "establishment_type"
        ),
      col_types =
        readr::cols(
          establishment_type_id = readr::col_character(),
          establishment_activity = readr::col_character(),
          establishment_type = readr::col_character()
        )
    ) %>%
    rl_cleanup()

  contact_addresses <-
    readr::read_delim(
      file = paste0(download_directory, "clean_contact_addresses.txt"),
      delim = "|",
      col_types =
        readr::cols(
          ADDRESS_ID = readr::col_character(),
          CONTACT_ID = readr::col_character(),
          ADDRESS_LINE1 = readr::col_character(),
          ADDRESS_LINE2 = readr::col_character(),
          CITY = readr::col_character(),
          STATE_CODE = readr::col_character(),
          STATE_PROVINCE = readr::col_character(),
          ISO_COUNTRY_CODE = readr::col_character(),
          POSTAL_CODE = readr::col_character()
        )
    ) %>%
    rl_cleanup()

  listing_estabtypes <-
    readr::read_delim(
      file = paste0(download_directory, "clean_listing_estabtypes.txt"),
      delim = "|",
      col_types =
        readr::cols(
          REG_KEY = readr::col_character(),
          REGISTRATION_LISTING_ID = readr::col_character(),
          ESTABLISHMENT_TYPE_ID  = readr::col_character()
        )
    ) %>%
    rl_cleanup() %>%
    dplyr::left_join(
      y = estabtypes,
      by = c(
        "establishment_type_id" = "establishment_type_id"
      )
    )

  listing_pcd <-
    readr::read_delim(
      file = paste0(download_directory, "clean_Listing_PCD.txt"),
      delim = "|",
      col_types =
        readr::cols(
          key_val = readr::col_character(),
          PRODUCT_CODE = readr::col_character(),
          CREATED_DATE = readr::col_character(),
          OWNER_OPERATOR_NUMBER = readr::col_character(),
          EXEMPT = readr::col_character()
        )
    ) %>%
    rl_cleanup()

  listing_proprietary_name <-
    readr::read_delim(
      file = paste0(download_directory, "clean_Listing_Proprietary_Name.txt"),
      delim = "|",
      col_types =
        readr::cols(
          LISTING_PROP_NAME_ID = readr::col_character(),
          key_val = readr::col_character(),
          PROPRIETARY_NAME = readr::col_character()
        )
    ) %>%
    rl_cleanup()

  official_correspondent <-
    readr::read_delim(
      file = paste0(download_directory, "clean_Official_Correspondent.txt"),
      delim = "|",
      col_types =
        readr::cols(
          REG_KEY = readr::col_character(),
          CONTACT_ID = readr::col_character(),
          FIRST_NAME = readr::col_character(),
          MIDDLE_INITIAL = readr::col_character(),
          LAST_NAME = readr::col_character(),
          SUBACCOUNT_COMPANY_NAME = readr::col_character(),
          PHONE_NUMBER = readr::col_character()
        )
    ) %>%
    rl_cleanup()

  owner_operator <-
    readr::read_delim(
      file = paste0(download_directory, "clean_Owner_Operator.txt"),
      delim = "|",
      col_types =
        readr::cols(
          REG_KEY = readr::col_character(),
          CONTACT_ID = readr::col_character(),
          FIRM_NAME = readr::col_character(),
          OWNER_OPERATOR_NUMBER = readr::col_character()
        )
    ) %>%
    rl_cleanup()

  registration <-
    readr::read_delim(
      file = paste0(download_directory, "clean_Registration.txt"),
      delim = "|",
      col_types =
        readr::cols(
          REG_KEY = readr::col_character(),
          REGISTRATION_NUMBER = readr::col_character(),
          FEI_NUMBER = readr::col_character(),
          REG_STATUS_ID = readr::col_character(),
          INITIAL_IMPORTER_FLAG = readr::col_character(),
          REG_EXPIRY_DATE_YEAR = readr::col_integer(),
          ADDRESS_TYPE_ID = readr::col_character(),
          NAME = readr::col_character(),
          ADDRESS_LINE_1 = readr::col_character(),
          ADDRESS_LINE_2 = readr::col_character(),
          CITY = readr::col_character(),
          STATE_ID = readr::col_character(),
          ISO_COUNTRY_CODE = readr::col_character(),
          ZIP_CODE = readr::col_character(),
          POSTAL_CODE = readr::col_character()
        )
    ) %>%
    rl_cleanup() %>%
    dplyr::mutate(
      reg_status =
        dplyr::case_when(
          .data$reg_status_id == "1" ~ "Active",
          .data$reg_status_id == "5" ~
            "Active; Awaiting assignment of registration number",
          TRUE ~ .data$reg_status_id
        ) %>%
        forcats::as_factor(),
      initial_importer_flag =
        dplyr::case_when(
          .data$initial_importer_flag == "Y" ~ "Yes",
          .data$initial_importer_flag == "N" ~ "No",
          TRUE ~ .data$initial_importer_flag
        ) %>%
        forcats::as_factor(),
      address_type =
        dplyr::case_when(
          .data$address_type_id == "U" ~ "US Agent",
          .data$address_type_id == "F" ~ "Facility",
          TRUE ~ .data$address_type_id
        ) %>%
        forcats::as_factor()
    )

  registration_listing <-
    readr::read_delim(
      file = paste0(download_directory, "clean_registration_listing.txt"),
      delim = "|",
      col_types =
        readr::cols(
          REGISTRATION_LISTING_ID = readr::col_character(),
          REG_KEY = readr::col_character(),
          KEY_VAL = readr::col_character(),
          PREMARKET_SUBMISSION_NUMBER = readr::col_character()
        )
    ) %>%
    rl_cleanup()

  us_agent <-
    readr::read_delim(
      file = paste0(download_directory, "clean_us_agent.txt"),
      delim = "|",
      col_types =
        readr::cols(
          REG_KEY = readr::col_character(),
          NAME = readr::col_character(),
          BUSINESS_NAME = readr::col_character(),
          BUS_PHONE_AREA_CODE = readr::col_character(),
          BUS_PHONE_NUM = readr::col_character(),
          BUS_PHONE_EXTN = readr::col_character(),
          FAX_AREA_CODE = readr::col_character(),
          FAX_NUM = readr::col_character(),
          EMAIL_ADDRESS = readr::col_character()
        )
    ) %>%
    rl_cleanup()

  # non_reg_imp_id_by_manu <-
  #   readr::read_delim(
  #     file = paste0(download_directory, "clean_Non_Reg_Imp_ID_by_Manu.txt"),
  #     delim = "|",
  #     col_types =
  #       readr::cols(
  #         ESTABLISHMENT_REG_KEY = readr::col_character(),
  #         KEY_VAL = readr::col_character(),
  #         IMPORTER_ADDRESS_ID = readr::col_character(),
  #         DUNS_NUM = readr::col_character(),
  #         BUSINESS_NAME = readr::col_character(),
  #         ADDRESS_LINE_1 = readr::col_character(),
  #         ADDRESS_LINE_2 = readr::col_character(),
  #         CITY = readr::col_character(),
  #         STATE_ID = readr::col_character(),
  #         ZIP_CODE = readr::col_character(),
  #         COUNTRY_NAME = readr::col_character(),
  #         EMAIL_ADDRESS = readr::col_character(),
  #         BUS_PHONE_AREA_CODE = readr::col_character(),
  #         BUS_PHONE_NUM = readr::col_character(),
  #         BUS_PHONE_EXTN = readr::col_character(),
  #         FAX_AREA_CODE = readr::col_character(),
  #         FAX_NUM = readr::col_character(),
  #         IMPORTER_TYPE = readr::col_character(),
  #         SUBDIVISION_CODE = readr::col_character(),
  #         POSTAL_CODE = readr::col_character(),
  #         BUS_PHONE_COUNTRY_CODE = readr::col_character(),
  #         FAX_COUNTRY_CODE = readr::col_character()
  #       )
  #   ) %>%
  # rl_cleanup()

  manu_id_by_imp <-
    readr::read_delim(
      file = paste0(download_directory, "clean_Manu_ID_by_Imp.txt"),
      delim = "|",
      col_types =
        readr::cols(
          IMP_MANU_ID = readr::col_character(),
          REG_KEY = readr::col_character(),
          MANUFACTURER_REG_KEY = readr::col_character(),
          KEY_VAL = readr::col_character()
        )
    ) %>%
    rl_cleanup()

  reg_imp_id_by_manu <-
    readr::read_delim(
      file = paste0(download_directory, "clean_Reg_Imp_ID_by_Manu.txt"),
      delim = "|",
      col_types =
        readr::cols(
          KEY_VAL = readr::col_character(),
          IMPORTER_REG_KEY = readr::col_character(),
          ESTABLISHMENT_REG_KEY = readr::col_character()
        )
    ) %>%
    rl_cleanup()

  list(
    "contact_addresses" = contact_addresses,
    "estabtypes" = estabtypes,
    "listing_estabtypes" = listing_estabtypes,
    "listing_pcd" = listing_pcd,
    "listing_proprietary_name" = listing_proprietary_name,
    "manu_id_by_imp" = manu_id_by_imp,
    # "non_reg_imp_id_by_manu" = non_reg_imp_id_by_manu,
    "official_correspondent" = official_correspondent,
    "owner_operator" = owner_operator,
    "reg_imp_id_by_manu" = reg_imp_id_by_manu,
    "registration" = registration,
    "registration_listing" = registration_listing,
    "us_agent" = us_agent
  )
}
