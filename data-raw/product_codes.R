## code to prepare `product_codes` dataset goes here
library(magrittr)
devtools::load_all()

product_codes <-
  etl_procodes(refresh_data = TRUE, download_directory = "data-raw/")

usethis::use_data(product_codes, overwrite = TRUE, compress = "xz")
# Document the dataset ---------------------------------------------------------

documentation_text <-
  c(
    "Product Codes",
    "",
    "FDA's Product Code Database download files. ",
    "",
    "Get the latest data using \\code{fdadata::etl_procodes()}.",
    "",
    paste0(
      "@format A tibble with ",
      nrow(product_codes),
      " rows and ",
      length(product_codes),
      " fields: "
    ),
    "",
    "\\describe{",
    dplyr::glimpse(product_codes, width = 76) %>%
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
    "@source [FDA Product Code Database]()",
    paste0("accessed ", lubridate::today(), ".")
  ) %>%
  paste0("#' ", .) %>%
  c(
    paste0(
      "# Do not hand edit this file. Edit data-raw/product_codes.R ",
      "instead."
    ),
    .,
    "\"product_codes\""
  ) %>%
  stringr::str_squish() %T>%
  readr::write_lines(
    x = .,
    file = "R/product_codes.R",
    append = FALSE
  )


