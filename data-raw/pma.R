## code to prepare `pma` dataset goes here

library(magrittr)
devtools::load_all()

pma <- etl_pma(refresh_data = TRUE, download_directory = "data-raw/")

usethis::use_data(pma, overwrite = TRUE, compress = "xz")

# Document the dataset ---------------------------------------------------------

documentation_text <-
  c(
    "PMA",
    "",
    "FDA's PMA Database download file. ",
    "",
    "Get the latest data using \\code{fdadata::etl_pma()}.",
    "",
    paste0(
      "@format A tibble with ",
      nrow(pma),
      " rows and ",
      length(pma),
      " fields: "
    ),
    "",
    "\\describe{",
    dplyr::glimpse(pma, width = 76) %>%
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
    "@source [FDA PMA Download File](https://go.usa.gov/xMQET)",
    paste0("accessed ", lubridate::today(), ".")
  ) %>%
  paste0("#' ", .) %>%
  c(
    paste0(
      "# Do not hand edit this file. Edit data-raw/pma.R ",
      "instead."
    ),
    .,
    "\"pma\""
  ) %>%
  stringr::str_squish() %T>%
  readr::write_lines(
    x = .,
    file = "R/pma.R",
    append = FALSE
  )

devtools::document()
