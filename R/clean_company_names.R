#' Clean Company Names
#'
#' @param string A company name with unspecified case,
#' punctuation, and suffixes (e.g. "LLC", "Corp").
#'
#' @return An all-caps company name without extraneous characters,
#' punctuation, and terms removed.
#' @export
#'
clean_company_names <- function(string) {
  co <-
    c(
      "ab",
      "ag",
      "bhd",
      "bv",
      "co",
      "company",
      "corp",
      "corporation",
      "cv",
      "gmbh",
      "inc",
      "incorporated",
      "international",
      "intl",
      "kg",
      "kgaa",
      "limited",
      "llc",
      "ltd",
      "mfg",
      "nv",
      "s\\/a",
      "sa",
      "sae",
      "sdn",
      "se",
      "spa",
      "srl",
      "srl",
      "USA"
    ) %>%
    # Put a word boundary on each side of the term:
    paste0("\\b", ., "\\b") %>%
    # Separate with the pipe character for "or"
    paste(collapse = "|")

  string %>%
    # Remove commas and periods
    stringr::str_remove_all(., pattern = ",|\\.") %>%
    # Remove common company suffixes
    stringr::str_remove_all(
      string = .,
      pattern =
        stringr::regex(
          pattern = co,
          ignore_case = TRUE
        )
    ) %>%
    # Replace ampersands
    stringr::str_replace_all(
      string = .,
      pattern = stringr::fixed("&"),
      replacement = "AND"
    ) %>%
    # Remove white space
    stringr::str_squish(.) %>%
    # Capitalize
    stringr::str_to_upper(.) %>%
    # Remove trailing "AND" (from, e.g. "ACME LLC AND CO" where "LLC" and "CO"
    # have been removed above).
    stringr::str_remove(., pattern = "AND$")
}
