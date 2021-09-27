## code to prepare `premarket` dataset goes here
library(magrittr)
library(dplyr)
library(rlang)
devtools::load_all()

premarket <-
  dplyr::bind_rows(
    pmn,
    pma
  ) %>%
  dplyr::arrange(.data$date_decision, .data$date_start) %>%
  dplyr::mutate(
    company_clean = clean_company_names(.data$sponsor, thorough = FALSE),
    company_group = clean_company_names(.data$sponsor, thorough = TRUE)
  ) %>%
  dplyr::select(
    .data$submission_number,
    .data$sponsor,
    .data$company_clean,
    .data$company_group,
    dplyr::everything()
  )

usethis::use_data(premarket, overwrite = TRUE)
# Document the dataset ---------------------------------------------------------

documentation_text <-
  c(
    "Premarket",
    "",
    "FDA's Premarket Databases, assembled from \\code{fdadata::pmn} and ",
    "\\code{fdadata::pma}. ",
    "",
    "Some additional processing is done to attempt to ",
    "make more sense of the company names. ",
    "\\code{fdadata::clean_company_names}",
    "is used with \\code{thorough = FALSE} to generate ",
    "\\code{fdadata::premarket$company_clean}. It is used with ",
    "\\code{thorough = TRUE} to generate ",
    "\\code{fdadata::premarket$company_group}. This attempts to consolidate ",
    "submissions from some of the largest companies based on known ",
    "acquisitions. See \\code{?fdadata::company_clean()}. ",
    "",
    "Going from \\code{sponsor} to \\code{company_clean} reduces the number ",
    "of unique company names from ",
    paste0(
      premarket$sponsor %>% unique() %>% length(),
      " to ",
      premarket$company_clean %>% unique() %>% length(),
      ", a reduction of ",
      premarket$sponsor %>% unique() %>% length() -
        premarket$company_clean %>% unique() %>% length(),
      " or approximately ",
      (
        (premarket$sponsor %>% unique() %>% length() -
         premarket$company_clean %>% unique() %>% length()) /
        premarket$sponsor %>% unique() %>% length() * 100
      ) %>%
        round(digits = 0),
      "%. "
    ),
    "",
    "\\code{company_group} has ",
    paste0(
      premarket$company_group %>% unique() %>% length(),
      " unique company names -- ",
      premarket$company_clean %>% unique() %>% length() -
        premarket$company_group %>% unique() %>% length(),
      " less that \\code{company_clean} (roughly a ",
      (
        (premarket$company_clean %>% unique() %>% length() -
           premarket$company_group %>% unique() %>% length()) /
          premarket$company_clean %>% unique() %>% length() * 100
      ) %>%
        round(digits = 0),
      "% reduction) and ",
      premarket$sponsor %>% unique() %>% length() -
        premarket$company_group %>% unique() %>% length(),
      " less than \\code{sponsor} -- for a total reduction of about ",
      (
        (premarket$sponsor %>% unique() %>% length() -
           premarket$company_group %>% unique() %>% length()) /
          premarket$sponsor %>% unique() %>% length() * 100
      ) %>%
        round(digits = 0),
      "%. "
    ) %>%
      stringr::str_wrap(
        string = .,
        width = 76
      ) %>%
      stringr::str_split(pattern = "\\n") %>%
      unlist(),
    "",
    paste0(
      "@format A tibble with ",
      nrow(premarket),
      " rows and ",
      length(premarket),
      " fields: "
    ),
    "",
    "\\describe{",
    dplyr::glimpse(premarket, width = 76) %>%
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
      unlist(),
    "}",
    "",
    "@source FDA's ",
    "[PMA database download file](https://go.usa.gov/xMQET) and ",
    "[510(k) database download files](https://go.usa.gov/xEKmh)",
    paste0("accessed ", lubridate::today(), ".")
  ) %>%
  paste0("#' ", .) %>%
  c(
    paste0(
      "# Do not hand edit this file. Edit data-raw/premarket.R ",
      "instead."
    ),
    .,
    "\"premarket\""
  ) %>%
  stringr::str_squish() %T>%
  readr::write_lines(
    x = .,
    file = "R/premarket.R",
    append = FALSE
  )

devtools::document()
