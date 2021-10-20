## code to prepare `reglist` dataset goes here

library(magrittr)
library(dplyr)
devtools::load_all()

reglist <- etl_rl(refresh_data = TRUE, download_directory = "data-raw/")

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
    "@format A list of tibbles.",
    "",
    "\\describe{",
    dplyr::glimpse(reglist, width = 76) %>%
      utils::capture.output(type = c("output")) %>%
      magrittr::extract(-c(1)) %>%
      stringr::str_replace(
        string = .,
        pattern = "(^\\s{0,2}\\$\\s\\w*\\s*)", # the column name
        replacement =
          paste0(
            "  \\\\item{",
            stringr::str_extract(
              string = .,
              pattern = "(?<=^\\s{0,2}\\$\\s)\\b\\w*\\b"
            ),
            "}{"
          )
      ) %>%
      stringr::str_replace(
        string = .,
        pattern = "(^\\s{0,2}\\.{2}\\$\\s\\w*\\s*)", # the column name
        replacement =
          paste0(
            "  \\\\item{",
            stringr::str_extract(
              string = .,
              pattern = "(?<=^\\s{0,2}\\.{2}\\$\\s)\\b\\w*\\b"
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
    # TODO: Find go.usa.gov link for this page
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
