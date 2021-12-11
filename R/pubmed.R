#' Extract MeSH Records
#'
#' Get terms associated with diseases and conditions from PubMed's medical
#' subject headings.
#'
#' @param text The contents of the disease file, such as
#'   \code{c2021_disease.bin}.
#'
#' @return A list of records, subject headings, and synonyms.
#'
extract_mesh_records <- function(text) {
  # First, we look for stuff that comes after a newrecord line. That stuff can
  # be pretty much anything: (.*\\n*) other than a newrecord line:
  # (?!\\*NEWRECORD). We want to stop capturing right before a newrecord line.
  stringr::str_extract_all(
    string = text,
    pattern =
      stringr::regex(
        "(?<=\\*NEWRECORD\\n)(.*\\n(?!\\*NEWRECORD))*(?=\\n\\*NEWRECORD)"
      )
  ) %>%
    unlist()
}

fix_names <- function(string) {
  dplyr::case_when(
    string == "RECTYPE" ~ "record_type",
    string == "NM" ~ "term",
    string == "RN" ~ "cas_registry",
    string == "SY" ~ "synonym",
    string == "HM" ~ "subject_heading",
    string == "NM_TH" ~ "thesaurus_id",
    string == "ST" ~ "semantic_type",
    string == "FR" ~ "FR", # Don't know this one
    string == "DA" ~ "date_entry",
    string == "MR" ~ "date_major_revision",
    string == "UI" ~ "unique_id",
    TRUE ~ string
  )
}

fix_synonym_colspec <- function(char) {
  dplyr::case_when(
    char == "a" ~ "term_synonym", # the term itself
    char == "b" ~ "semantic_type", # SEMANTIC TYPE*
    char == "c" ~ "lexical_type", # LEXICAL TYPE*
    char == "d" ~ "semantic_relation", # SEMANTIC RELATION*
    char == "e" ~ "thesaurus_id", # THESAURUS ID
    char == "f" ~ "date", # DATE
    char == "s" ~ "sort_version", # SORT VERSION
    char == "v" ~ "entry_version", # ENTRY VERSION
    TRUE ~ char
  )
}

construct_synonym_record <- function(text) {
  colnames <-
    stringr::str_extract(
      string = text,
      pattern =
        stringr::regex("(?<=\\|)\\w*$")
    ) %>%
    stringr::str_extract_all(
      pattern = "\\w"
    ) %>%
    unlist() %>%
    fix_synonym_colspec()

  suppressMessages({
      row <-
        readr::read_delim(
          file =
            text %>%
            stringr::str_remove(
              pattern =
                stringr::regex("\\|\\w*$")
            ) %>%
            paste0(., "\n"),
          col_names = colnames,
          col_types = readr::cols(readr::col_character()),
          delim = "|",
          name_repair = "universal"
        )
  })
  row <-
    row %>%
    dplyr::mutate(
      dplyr::across(
        .cols = dplyr::everything(),
        .fns = as.character
      )
    )
  if (!("semantic_type" %in% colnames(row))) {
    row <-
      row %>%
      dplyr::mutate(
        semantic_type = NA_character_
      )
  }
  if (!("thesaurus_id" %in% colnames(row))) {
    row <-
      row %>%
      dplyr::mutate(
        thesaurus_id = NA_character_
      )
  }
  row %>%
    tidyr::unite(
      col = "semantic_types",
      tidyselect::starts_with("semantic_type"),
      sep = "; ",
      remove = TRUE,
      na.rm = TRUE
    ) %>%
    tidyr::unite(
      col = "thesaurus_ids",
      tidyselect::starts_with("thesaurus_id"),
      sep = "; ",
      remove = TRUE,
      na.rm = TRUE
    )
}

construct_mesh_record <- function(text) {
  # Create a vector of the record, with one element per line
  vec <-
    stringr::str_split(
      string = text,
      pattern = "\\n"
    ) %>%
    unlist()
  # Name each element in the vector
  vec_names <-
    stringr::str_extract(
      string = vec,
      pattern = stringr::regex("^\\w*") # The first word
    ) %>%
    fix_names()
  vec <-
    stringr::str_extract(
      string = vec,
      pattern = stringr::regex("(?<=\\w\\s\\=\\s).*$") # Everything after the =
    )
  names(vec) <- vec_names
  # Turn it into a list so we can access elements by name
  vec <- as.list(vec)
  items_of_interest <-
    c("unique_id", "term", "record_type", "cas_registry", "thesaurus_id",
      "semantic_type", "date_entry", "date_major_revision")
  record <-
    tibble::enframe(vec) %>%
    dplyr::filter(.data$name %in% items_of_interest) %>%
    dplyr::mutate(
      name =
        .data$name %>%
        forcats::as_factor() %>%
        forcats::lvls_expand(
          f = .,
          new_levels =
            c(
             items_of_interest
            )
        )
    ) %>%
    dplyr::arrange(.data$name, .data$value) %>%
    dplyr::group_by(.data$name) %>%
    dplyr::summarise(value = paste(.data$value, collapse = "; ")) %>%
    tidyr::pivot_wider(
      names_from = "name",
      values_from = "value"
    ) %>%
    dplyr::mutate(
      dplyr::across(
        .cols = tidyselect::starts_with("date"),
        .fns = lubridate::ymd
      ),
      dplyr::across(
        .cols = tidyselect:::where(is.list),
        .fns = as.character
      )
    )
  subject_headings <-
    vec[names(vec) == "subject_heading"] %>%
    as.character() %>%
    tibble::enframe(name = NULL, value = "subject_heading") %>%
    dplyr::bind_cols(
      record %>%
        dplyr::select(.data$unique_id)
    ) %>%
    dplyr::select(
      term_unique_id = .data$unique_id,
      dplyr::everything()
    )

  synonyms <-
    purrr::map_dfr(
      .x = vec[names(vec) == "synonym"] %>% as.character(),
      .f = construct_synonym_record
    ) %>%
    dplyr::bind_cols(
      record %>%
        dplyr::select(.data$unique_id)
    ) %>%
    dplyr::select(
      term_unique_id = .data$unique_id,
      dplyr::everything()
    )

  list(
    record = record,
    subject_headings = subject_headings,
    synonyms = synonyms
  )
}
