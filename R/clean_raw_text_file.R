#' Reads in a file and remove headers, quotes, and null characters
#'
#' @param filepath The path of the file to clean
#' @return A clean string with no headers, quotes, or null characters
#' @export
#'
clean_raw_text_file <- function(filepath){
  message("Cleaning string from ", filepath, sep = "")
  dirty_string <- readr::readLines(filepath, skipNul = TRUE)
  dirty_string <- gsub("\"", "", readr::read_lines(dirty_string, skip = 1))
  clean_string <- dirty_string
}
