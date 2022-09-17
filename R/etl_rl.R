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
    ) %>%
    dplyr::mutate_if(
      is.character,
      ~dplyr::na_if(., "--")
    )
}

#' ETL Registration and Listing data from the FDA website.
#'
#' @param refresh_data Boolean. When \code{TRUE}, fresh data is downloaded from
#' fda.gov. When \code{FALSE}, data is read in from a text file on the disk.
#' @param download_directory Defaults to \code{data/}.
#' @return Registration and Listing data as a tibble
#' @source Data is downloaded from
#' \url{https://www.fda.gov/medical-devices/device-registration-and-listing/establishment-registration-and-medical-device-listing-files-download}.
#' @export
etl_rl <- function(refresh_data = FALSE,
                    download_directory = "data/") {
  # Set some initial values ----------------------------------------------------
  filenames_root <-
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
      # Non_Reg_Imp_ID_by_Manu is, I think, the reverse of Reg_Imp_ID_by_Manu,
      # but I am not sure.
      "Manu_ID_by_Imp",
      "Reg_Imp_ID_by_Manu"
    )

  # Refresh data if appropriate ------------------------------------------------
  if (refresh_data == TRUE) {
    refresh_files(
      filenames_root = filenames_root,
      download_directory = download_directory
    )
    # Additional cleaning for some files ---------------------------------------
    # Contact addresses
    readr::read_lines(
      file = path_clean("contact_addresses", download_directory),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
      # Line 36617 has the same problematic Obour City address as registration
      # below
      stringr::str_replace(
        string = .,
        pattern =
          stringr::fixed(
            pattern =
              paste0(
                "80773566|69357559|First Industrial zone| Block 13023 | ",
                "Building 8 Obour city | Cairo - Egypt  ZIP code :   11828 | ",
                "P.O.Box : 29||Obour|EG-C|Al Qahirah|EG|11828"
              ),
            ignore_case = TRUE
          ),
        replacement =
          paste0(
            "80773566|69357559|First Industrial zone Block 13023|",
            "Building 8 P.O. Box: 29|Obour|EG-C|Al Qahirah|EG|11828"
          )
      ) %>%
      readr::write_lines(
        x = .,
        file = path_clean("contact_addresses", download_directory),
        append = FALSE
      )

    # Registration
    # Line 4477 has extra pipe characters as of 2020-12-19
    readr::read_lines(
      file = path_clean("Registration", download_directory),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
      stringr::str_replace(
        string = .,
        pattern =
          stringr::fixed(
            pattern = "Suite 100 | Houston, Texas 77040||Houston|TX|US|",
            ignore_case = TRUE
          ),
        replacement = "Suite 100 ||Houston|TX|US|"
      ) %>%
      # Line 44310 has extra pipe characters as of 2021-10-20
      stringr::str_replace(
        string = .,
        pattern =
          stringr::fixed(
            pattern =
              paste0(
                "282130|3017840042|3017840042|1|N|2021|F|TAISIER MED S.A.E|",
                "First Industrial zone| Block 13023 | Building 8 Obour city ",
                "| Cairo - Egypt  ZIP code :   11828 | P.O.Box : 29||",
                "Obour Al Qahirah||EG||11828"
              ),
            ignore_case = TRUE
          ),
        replacement =
          paste0(
            "282130|3017840042|3017840042|1|N|2021|F|TAISIER MED S.A.E|",
            "First Industrial zone Block 13023|",
            "Building 8 P.O.Box : 29|",
            "Obour Al Qahirah||EG||11828"
          )
      ) %>%
      # Line 41953 has extra pipe characters as of 2020-12-19
      stringr::str_replace(
        string = .,
        pattern =
          stringr::fixed(
            pattern = "| Milford, OH |||Day Heights|OH|",
            ignore_case = TRUE
          ),
        replacement = "||Day Heights|OH|"
      ) %>%
      readr::write_lines(
        x = .,
        file = path_clean("Registration", download_directory),
        append = FALSE
      )

    # us_agent
    readr::read_lines(
      file = path_clean("us_agent", download_directory),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
      # Line 4374 has an extra pipe
      stringr::str_replace(
        string = .,
        pattern =
          stringr::fixed(
            paste0(
              "291580|Jennifer Hughes|Altenloh. Brinck & Co. US Inc. | ",
              "Life Sciences & Medical|616|8135171||||",
              "jennifer.hughes@sabeu.com"
            )
          ),
        replacement =
          paste0(
            "291580|Jennifer Hughes|Altenloh. Brinck & Co. US Inc. ",
            "Life Sciences & Medical|616|8135171||||jennifer.hughes@sabeu.com"
          )
      ) %>%
      readr::write_lines(
        x = .,
        file = path_clean("us_agent", download_directory),
        append = FALSE
      )
  }

  # Read the files -------------------------------------------------------------
  estabtypes <-
    readr::read_delim(
      file = path_clean("estabtypes", download_directory),
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
        ),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
    rl_cleanup()

  contact_addresses <-
    readr::read_delim(
      file = path_clean("contact_addresses", download_directory),
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
        ),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
    rl_cleanup()

  listing_estabtypes <-
    readr::read_delim(
      file = path_clean("listing_estabtypes", download_directory),
      delim = "|",
      col_types =
        readr::cols(
          REG_KEY = readr::col_character(),
          REGISTRATION_LISTING_ID = readr::col_character(),
          ESTABLISHMENT_TYPE_ID  = readr::col_character()
        ),
      locale = readr::locale(encoding = "Latin1")
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
      file = path_clean("Listing_PCD", download_directory),
      delim = "|",
      col_types =
        readr::cols(
          key_val = readr::col_character(),
          PRODUCT_CODE = readr::col_character(),
          CREATED_DATE = readr::col_character(),
          OWNER_OPERATOR_NUMBER = readr::col_character(),
          EXEMPT = readr::col_character()
        ),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
    rl_cleanup() %>%
    dplyr::rename(
      product_code_created_date = .data$created_date
    ) %>%
    dplyr::mutate(
      product_code_created_date =
        lubridate::mdy(.data$product_code_created_date)
    )

  listing_proprietary_name <-
    readr::read_delim(
      file = path_clean("Listing_Proprietary_Name", download_directory),
      delim = "|",
      col_types =
        readr::cols(
          LISTING_PROP_NAME_ID = readr::col_character(),
          key_val = readr::col_character(),
          PROPRIETARY_NAME = readr::col_character()
        ),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
    rl_cleanup() %>%
    # Why on earth is there a trailing .0 on every key val?
    dplyr::mutate(
      key_val =
        stringr::str_remove(
          string = .data$key_val,
          pattern = stringr::regex("\\.0$")
        )
    )

  official_correspondent <-
    readr::read_delim(
      file = path_clean("Official_Correspondent", download_directory),
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
        ),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
    rl_cleanup()

  owner_operator <-
    readr::read_delim(
      file = path_clean("Owner_Operator", download_directory),
      delim = "|",
      col_types =
        readr::cols(
          REG_KEY = readr::col_character(),
          CONTACT_ID = readr::col_character(),
          FIRM_NAME = readr::col_character(),
          OWNER_OPERATOR_NUMBER = readr::col_character()
        ),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
    rl_cleanup()

  registration <-
    readr::read_delim(
      file = path_clean("Registration", download_directory),
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
        ),
      locale = readr::locale(encoding = "Latin1")
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
      file = path_clean("registration_listing", download_directory),
      delim = "|",
      col_types =
        readr::cols(
          REGISTRATION_LISTING_ID = readr::col_character(),
          REG_KEY = readr::col_character(),
          KEY_VAL = readr::col_character(),
          PREMARKET_SUBMISSION_NUMBER = readr::col_character()
        ),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
    rl_cleanup()

  us_agent <-
    readr::read_delim(
      file = path_clean("us_agent", download_directory),
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
        ),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
    rl_cleanup()

  manu_id_by_imp <-
    readr::read_delim(
      file = path_clean("Manu_ID_by_Imp", download_directory),
      delim = "|",
      col_types =
        readr::cols(
          IMP_MANU_ID = readr::col_character(),
          REG_KEY = readr::col_character(),
          MANUFACTURER_REG_KEY = readr::col_character(),
          KEY_VAL = readr::col_character()
        ),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
    rl_cleanup()

  reg_imp_id_by_manu <-
    readr::read_delim(
      file = path_clean("Reg_Imp_ID_by_Manu", download_directory),
      delim = "|",
      col_types =
        readr::cols(
          KEY_VAL = readr::col_character(),
          IMPORTER_REG_KEY = readr::col_character(),
          ESTABLISHMENT_REG_KEY = readr::col_character()
        ),
      locale = readr::locale(encoding = "Latin1")
    ) %>%
    rl_cleanup()

  list(
    "contact_addresses" = contact_addresses,
    "estabtypes" = estabtypes,
    "listing_estabtypes" = listing_estabtypes,
    "listing_pcd" = listing_pcd,
    "listing_proprietary_name" = listing_proprietary_name,
    "manu_id_by_imp" = manu_id_by_imp,
    "official_correspondent" = official_correspondent,
    "owner_operator" = owner_operator,
    "reg_imp_id_by_manu" = reg_imp_id_by_manu,
    "registration" = registration,
    "registration_listing" = registration_listing,
    "us_agent" = us_agent
  )
}

#' Join Registration and Listing
#'
#' @param rl_list The output of \code{etl_rl()}.
#'
#' @return A single, massive table joining all the subcomponents of the list
#'   output by \code{etl_rl()}.
#' @export
#'
join_rl <- function(rl_list) {
  dplyr::full_join(
    x = rl_list$registration,
    y = rl_list$registration_listing,
    by = c("reg_key" = "reg_key")
  ) %>%
    dplyr::full_join(
      x = .,
      y = rl_list$owner_operator,
      by = c("reg_key" = "reg_key")
    ) %>%
    dplyr::full_join(
      x = .,
      y = rl_list$official_correspondent,
      by =
        c(
          "reg_key" = "reg_key",
          "contact_id" = "contact_id"
        )
    ) %>%
    dplyr::full_join(
      x = .,
      y =
        rl_list$contact_addresses %>%
        dplyr::rename_all(.funs = ~ paste0("contact_", .x))
      ,
      by = c("contact_id" = "contact_contact_id")
    ) %>%
    dplyr::full_join(
      x = .,
      y =
        rl_list$us_agent %>%
        dplyr::rename_all(.funs = ~ paste0("us_agent_", .x))
      ,
      by = c("reg_key" = "us_agent_reg_key")
    ) %>%
    dplyr::full_join(
      x = .,
      y =
        rl_list$manu_id_by_imp %>%
        dplyr::rename(importer_reg_key = .data$reg_key),
      by =
        c(
          "reg_key" = "manufacturer_reg_key",
          "key_val" = "key_val"
        )
    ) %>%
    dplyr::full_join(
      x = .,
      y = rl_list$reg_imp_id_by_manu,
      by =
        c(
          "importer_reg_key" = "importer_reg_key",
          "key_val" = "key_val"
        )
    ) %>%
    dplyr::full_join(
      x = .,
      y = rl_list$listing_proprietary_name,
      by = c("key_val" = "key_val")
    ) %>%
    dplyr::full_join(
      x = .,
      y = rl_list$listing_pcd,
      by =
        c(
          "owner_operator_number" = "owner_operator_number",
          "key_val" = "key_val"
        )
    ) %>%
    dplyr::full_join(
      x = .,
      y = rl_list$listing_estabtypes,
      by =
        c(
          "reg_key" = "reg_key",
          "registration_listing_id" = "registration_listing_id"
        )
    )
}
