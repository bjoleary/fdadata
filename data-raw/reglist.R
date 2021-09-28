## code to prepare `reglist` dataset goes here

library(magrittr)
devtools::load_all()

rl_list <- etl_rl(refresh_data = TRUE, download_directory = "data-raw/")

reglist <-
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

usethis::use_data(reglist, overwrite = TRUE, compress = "xz")

# Document the dataset ---------------------------------------------------------

documentation_text <-
  c(
    "reglist",
    "",
    "FDA's Registration and Listing Database download files. ",
    "",
    "Get the latest data using \\code{fdadata::etl_reglist()}.",
    "",
    paste0(
      "@format A tibble with ",
      nrow(reglist),
      " rows and ",
      length(reglist),
      " fields: "
    ),
    "",
    "\\describe{",
    dplyr::glimpse(reglist, width = 76) %>%
      utils::capture.output(type = c("output")) %>%
      magrittr::extract(-c(1:2)) %>%
      stringr::str_replace(
        string = .,
        pattern = "(^\\$\\s\\w*\\s*)", # the column name
        replacement =
          paste0(
            "  \\\\item{",
            stringr::str_extract(
              string = .,
              pattern = "(?<=^\\$\\s)\\b\\w*\\b"
            ),
            "}{"
          )
      ) %>%
      paste0(., "}") %>%
      # Square brackets are a link in Roxygen. Replace:
      stringr::str_remove_all(
        string = .,
        pattern = "\\[|\\]|\\<|\\>"
      ) %>%
      # Remove formatting strings
      stringr::str_remove_all(
        string = .,
        pattern = stringr::fixed("\0333m\03338;5;246m")
      ) %>%
      stringr::str_remove_all(
        string = .,
        pattern = stringr::fixed("\03339m\03323m")
      ) %>%
      stringr::str_wrap(
        string = .,
        width = 76
      ) %>%
      stringr::str_split(pattern = "\\n") %>%
      unlist() ,
    "}",
    "",
    # TODO: Get go.usa.gov link for this page
    "@source [FDA R&L Download Files]()",
    paste0("accessed ", lubridate::today(), ".")
  ) %>%
  paste0("#' ", .) %>%
  c(
    paste0(
      "# Do not hand edit this file. Edit data-raw/reglist.R ",
      "instead."
    ),
    .,
    "\"reglist\""
  ) %>%
  stringr::str_squish() %T>%
  readr::write_lines(
    x = .,
    file = "R/reglist.R",
    append = FALSE
  )

devtools::document()
