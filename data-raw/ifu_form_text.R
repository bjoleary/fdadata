## code to prepare `ifu_form_text` dataset goes here
library(magrittr)
library(tidytext)
# See https://www.fda.gov/media/86323/download

date_accessed <- lubridate::ymd("2021-12-10")

# Create -----------------------------------------------------------------------

ifu_form_text <-
  c(
    "FORM FDA 3881 (6/20)",
    "PSC Publishing Services (301) 443-6740 ",
    "DEPARTMENT OF HEALTH AND HUMAN SERVICES Food and Drug Administration",
    "Indications for Use",
    "Form Approved: OMB No. 0910-0120",
    "Expiration Date: 06/30/2023",
    "See PRA Statement below.",
    "510(k) Number (if known)",
    "Device Name",
    "Indications for Use (Describe)",
    "Type of Use (Select one or both, as applicable)",
    "Prescription Use (Part 21 CFR 801 Subpart D)",
    "Over-The-Counter Use (21 CFR 801 Subpart C)",
    "CONTINUE ON A SEPARATE PAGE IF NEEDED.",
    "This section applies only to requirements of the Paperwork Reduction Act",
    "of 1995.",
    "*DO NOT SEND YOUR COMPLETED FORM TO THE PRA STAFF EMAIL ADDRESS BELOW.*",
    "The burden time for this collection of information is estimated to ",
    "average",
    "79 hours per response, including the time to review instructions, search ",
    "existing data sources, gather and maintain the data needed and complete",
    " and",
    "review the collection of information. Send comments regarding this burden",
    "estimate or any other aspect of this information collection, including",
    "suggestions for reducing this burden, to:",
    "Department of Health and Human Services",
    "Food and Drug Administration",
    "Office of Chief Information Officer",
    "Paperwork Reduction Act (PRA) Staff",
    "PRAStaff@fda.hhs.gov",
    "An agency may not conduct or sponsor, and a person is not required to ",
    "respond ",
    "to, a collection of information unless it displays a currently valid OMB ",
    "number."
  ) %>%
  tibble::enframe(
    name = NULL,
    value = "text"
  ) %>%
  tidytext::unnest_tokens(output = word, input = text) %>%
  dplyr::anti_join(
    y = tidytext::stop_words,
    by = c("word" = "word")
  ) %>%
  dplyr::count(.data$word, sort = TRUE)

usethis::use_data(ifu_form_text, overwrite = TRUE, compress = "xz")

# Document ---------------------------------------------------------------------

documentation_text <-
  c(
    "Indications For Use Form Text",
    "",
    "Words (and counts) used in FDA's indications for use form.",
    "Used by \\code{fdadata::get_indications()} to identify promising IFU ",
    "pages in summary documents.",
    "",
    paste0(
      "@format A tibble with ",
      nrow(ifu_form_text),
      " rows and ",
      length(ifu_form_text),
      " fields: "
    ),
    "",
    "\\describe{",
    dplyr::glimpse(ifu_form_text, width = 76) %>%
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
    "@source ",
    "[Indications for Use form](https://www.fda.gov/media/86323/download)",
    paste0("accessed ", date_accessed, ".")
  ) %>%
  paste0("#' ", .) %>%
  c(
    paste0(
      "# Do not hand edit this file. Edit data-raw/ifu_form_text.R ",
      "instead."
    ),
    .,
    "\"ifu_form_text\""
  ) %>%
  stringr::str_squish() %T>%
  readr::write_lines(
    x = .,
    file = "R/ifu_form_text.R",
    append = FALSE
  )
devtools::document()
