#' Get Indications
#'
#' Extract the indications for use for a submission from the summary document
#' on fda.gov. This works, perhaps 50% of the time for recently cleared
#' 510(k)s at the moment.
#'
#' @param submission_number A submission number for an authorized device.
#'
#' @return The indications for use for that device.
#' @export
#'
get_indications <- function(submission_number) {
  progress_bar <-
    dplyr::progress_estimated(n = max(seq_along(submission_number)))
  purrr::map_chr(
    .x = submission_number,
    .f = function(x) {
      progress_bar$tick()$print()
      url <- public_link_summary(x)
      filepath <- tempfile(pattern = x, fileext = ".pdf")
      pdf_download <-
        httr::GET(
          url = url,
          httr::write_disk(filepath, overwrite = TRUE)
        )
      if (pdf_download$headers$`content-type` == "text/html") {
        NA_character_
      } else {
        pdf_content <-
          pdftools::pdf_text(filepath) %>%
          tibble::enframe(
            name = "page",
            value = "text"
          )
        # TODO: Check if any pages are missing text
        pdf_grams <-
          pdf_content %>%
          tidytext::unnest_tokens(
            output = "word",
            input = .data$text
          ) %>%
          dplyr::anti_join(
            y = tidytext::stop_words,
            by = c("word" = "word")
          ) %>%
          dplyr::group_by(.data$page) %>%
          dplyr::count(.data$word, sort = TRUE)

        ifu_page <-
          dplyr::inner_join(
            x = pdf_grams,
            y = ifu_form_text,
            by = c("word" = "word")
          ) %>%
          dplyr::group_by(.data$page) %>%
          dplyr::count() %>%
          dplyr::arrange(dplyr::desc(.data$n)) %>%
          head(1) %>%
          dplyr::pull(.data$page) %>%
          as.integer()

        ifu_page_content <- pdf_content$text[[ifu_page]]

        ifu <-
          stringr::str_replace_all(
            string = ifu_page_content,
            pattern = "\\n",
            replacement = " "
          ) %>%
          stringr::str_extract(
            # Grab everything after this:
            pattern =
              stringr::regex(
                "(?<=Indications for Use \\(Describe\\)).*"
              )
          ) %>%
          stringr::str_extract(
            # Grab everything before this:
            pattern =
              stringr::regex(
                ".*(?=Type of Use \\(Select one or both, as applicable\\))"
              )
          ) %>%
          stringr::str_squish()
      }
    }
  )
}
