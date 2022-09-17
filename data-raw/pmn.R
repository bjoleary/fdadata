## code to prepare `pmn` dataset goes here
library(magrittr)
devtools::load_all()

pmn <- etl_pmn(refresh_data = TRUE, download_directory = "data-raw/")

usethis::use_data(pmn, overwrite = TRUE, compress = "xz")

# Document the dataset ---------------------------------------------------------

documentation_text <-
  c(
    "PMN (510(k)s)",
    "",
    "FDA's 510(k) Database download files. ",
    "",
    "Get the latest data using \\code{fdadata::etl_pmn()}.",
    "",
    paste0(
      "@format A tibble with ",
      nrow(pmn),
      " rows and ",
      length(pmn),
      " fields: "
    ),
    "",
    "\\describe{",
    dplyr::glimpse(pmn, width = 76) %>%
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
    paste0(
      "@source [FDA 510(k) Download Files](",
      "https://www.fda.gov/medical-devices/510k-clearances/",
      "downloadable-510k-files",
      ")"
    ),
    paste0("accessed ", lubridate::today(), ".")
  ) %>%
  paste0("#' ", .) %>%
  c(
    paste0(
      "# Do not hand edit this file. Edit data-raw/pmn.R ",
      "instead."
    ),
    .,
    "\"pmn\""
  ) %>%
  stringr::str_squish() %T>%
  readr::write_lines(
    x = .,
    file = "R/pmn.R",
    append = FALSE
  )
