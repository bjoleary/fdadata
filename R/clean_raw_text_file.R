#' Reads in a file and remove headers, quotes, and null characters
#'
#' @param filepath The path of the file to clean
#' @return A clean string with no headers, quotes, or null characters
#' @export
#'
clean_raw_text_file <- function(filepath) {
  message("Cleaning string from ", filepath, sep = "")
  cleaner_string <- readLines(filepath, skipNul = TRUE, encoding = "Latin-1")
  cleaner_string <- stringi::stri_enc_toascii(cleaner_string)
  cleaner_string <- gsub("\"", "", cleaner_string[-1])
  # Remove null character
  cleaner_string <- gsub("\\0", "", cleaner_string)
  # Remove carriage return, keep line feed
  cleaner_string <-
    stringr::str_remove_all(
      string = cleaner_string,
      pattern =
        stringr::fixed(
          pattern = "^M",
          ignore_case = TRUE
        )
    )
}
