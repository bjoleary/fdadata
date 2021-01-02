#' Convert FDA panel codes to panels
#'
#' Can be used to convert two letter panel codes to human readable panel names.
#'
#' @param panel_code A two letter panel code
#'
#' @return The full, human-readable panel as a factor
#'
expand_panels <- function(panel_code) {
  dplyr::case_when(
    panel_code == "AN" ~ "Anesthesiology",
    panel_code == "CV" ~ "Cardiovascular",
    panel_code == "CH" ~ "Clinical Chemistry",
    panel_code == "DE" ~ "Dental",
    panel_code == "EN" ~ "Ear, Nose, & Throat",
    panel_code == "GU" ~ "Gastroenterology & ",
    panel_code == "HO" ~ "General Hospital",
    panel_code == "HE" ~ "Hematology",
    panel_code == "IM" ~ "Immunology",
    panel_code == "MI" ~ "Microbiology",
    panel_code == "NE" ~ "Neurology",
    panel_code == "OB" ~ "Obstetrics/Gynecology",
    panel_code == "OP" ~ "Ophthalmic",
    panel_code == "OR" ~ "Orthopedic",
    panel_code == "PA" ~ "Pathology",
    panel_code == "PM" ~ "Physical Medicine",
    panel_code == "RA" ~ "Radiology",
    panel_code == "SU" ~ "General & Plastic Surgery",
    panel_code == "TX" ~ "Clinical Toxicology",
    panel_code == "MG" ~ "Molecular Genetics",
    TRUE ~ NA_character_
  ) %>%
    forcats::as_factor() %>%
    forcats::fct_expand(
      f = .,
      c(
        "Anesthesiology",
        "Cardiovascular",
        "Clinical Chemistry",
        "Dental",
        "Ear, Nose, & Throat",
        "Gastroenterology & ",
        "General Hospital",
        "Hematology",
        "Immunology",
        "Microbiology",
        "Neurology",
        "Obstetrics/Gynecology",
        "Ophthalmic",
        "Orthopedic",
        "Pathology",
        "Physical Medicine",
        "Radiology",
        "General & Plastic Surgery",
        "Clinical Toxicology",
        "Molecular Genetics"
      )
    )
}

#' Decode Decision
#'
#' @param decision_code A decision code, such as "SESE"
#'
#' @return A spelled-out decision, such as "Substantially Equivalent".
#'
decode_decision <- function(decision_code) {
  dplyr::case_when(
    decision_code == "SESE" ~ "Substantially Equivalent",
    decision_code == "SESP" ~
      "Substantially Equivalent - PostMarket Surveillance Required",
    decision_code == "PT" ~
      "Substantially Equivalent - Subject to Tracking and Surveillance",
    decision_code == "SESD" ~ "Substantially Equivalent with Drug",
    decision_code == "SESN" ~ "Substantially Equivalent for Some Indications",
    decision_code == "SEKD" ~ "Substantially Equivalent - Kit with Drugs",
    decision_code == "SESK" ~ "Substantially Equivalent - Kit",
    decision_code == "SESI" ~
      "Substantially Equivalent - Market after Inspection",
    decision_code == "ST" ~ "Substantially Equivalent - Subject to Tracking",
    decision_code == "SESU" ~ "Substantially Equivalent - With Limitations",
    decision_code == "DENG" ~ "De Novo Granted",
    decision_code == "APPR" ~ "Approved",
    decision_code == "APCV" ~ "Approved - Converted",
    decision_code == "APWD" ~ "Approved - Withdrawn",
    decision_code == "APRL" ~ "Approved - Reclassified",
    decision_code == "OK30" ~ "Accepted",
    decision_code == "APCB" ~ "Approved - Unknown",
    TRUE ~ decision_code
  ) %>%
    forcats::as_factor() %>%
    forcats::fct_expand(
      f = .,
      c(
        "Substantially Equivalent",
        "Substantially Equivalent - PostMarket Surveillance Required",
        "Substantially Equivalent - Subject to Tracking and Surveillance",
        "Substantially Equivalent with Drug",
        "Substantially Equivalent for Some Indications",
        "Substantially Equivalent - Kit with Drugs",
        "Substantially Equivalent - Kit",
        "Substantially Equivalent - Market after Inspection",
        "Substantially Equivalent - Subject to Tracking",
        "Substantially Equivalent - With Limitations",
        "De Novo Granted",
        "Approved",
        "Approved - Converted",
        "Approved - Withdrawn",
        "Approved - Reclassified",
        "Accepted",
        "Approved - Unknown"
      )
    )
}

#' Categorize a Decision
#'
#' @param decision a decision code (e.g. "SESP") or decision (e.g.
#' "Substantially Equivalent - PostMarket Surveillance Required").
#'
#' @return A decision category, such as "Substantially Equivalent".
#'
categorize_decision <- function(decision) {
  dplyr::case_when(
    stringr::str_detect(
      string = decision,
      pattern =
        stringr::fixed(
          pattern = "substantially equivalent",
          ignore_case = TRUE
        )
    ) ~ "Substantially Equivalent",
    decision %in% c(
      "SESE",
      "SESP",
      "PT",
      "SESD",
      "SESN",
      "SEKD",
      "SESK",
      "SESI",
      "ST",
      "SESU",
      "Substantially Equivalent",
      "Substantially Equivalent - PostMarket Surveillance Required",
      "Substantially Equivalent - Subject to Tracking & PMS",
      "Substantially Equivalent with Drug",
      "Substantially Equivalent for Some Indications",
      "Substantially Equivalent - Kit with Drugs",
      "Substantially Equivalent - Kit",
      "Substantially Equivalent - Market after Inspection",
      "Substantially Equivalent - Subject to Tracking Reg.",
      "Substantially Equivalent - With Limitations"
    ) ~
      "Substantially Equivalent",
    decision %in% c("DENG", "De Novo Granted") ~ "Granted",
    stringr::str_detect(
      string = decision,
      pattern =
        stringr::regex(
          pattern = "\\bapproved\\b",
          ignore_case = TRUE
        )
    ) ~ "Approved",
    decision %in% c(
      "APPR",
      "APCV",
      "APWD",
      "APRL",
      "APCB",
      "Approved",
      "Approved - Converted",
      "Approved - Withdrawn",
      "Approved - Reclassified",
      "Approved - Unknown"
    ) ~
      "Approved",
    decision %in% c("OK30", "Accepted") ~ "Accepted",
    TRUE ~ decision
  ) %>%
    forcats::as_factor() %>%
    forcats::fct_expand(
      f = .,
      c(
        "Substantially Equivalent",
        "Granted",
        "Approved",
        "Accepted"
      )
    )
}

#' Check for and remove a file
#'
#' Used so that when \code{file.remove()} is run it is only run on files that
#' exist. This avoids warnings.
#'
#' @param filepath The expected path of the file you want to look for and
#' remove if present.
file_remove <- function(filepath) {
  if (file.exists(filepath)) {
    file.remove(filepath)
  }
}

#' Refresh Files
#'
#' @param filenames_root A vector of filenames (without extensions)
#' to download from the FDA website. For example, for 510(k)s:
#' c("pmn7680", "pmn8185", ' "pmn8690", "pmn9195", "pmn96cur").
#' @param download_directory Defaults to \code{data/}.
#'
#' @return \code{NULL}
#' @export
#'
refresh_files <- function(filenames_root, download_directory = "data/") {
  # Set up filenames -----------------------------------------------------------
  filepaths_zip <-
    path_zip(
      filenames_root = filenames_root,
      download_directory = download_directory
    )
  filepaths_txt <-
    path_raw(
      filenames_root = filenames_root,
      download_directory = download_directory
    )
  filepaths_clean <-
    path_clean(
      filenames_root = filenames_root,
      download_directory = download_directory
    )
  filepaths_accessed <-
    path_accessed(
      filenames_root = filenames_root,
      download_directory = download_directory
    )
  files <- c(filepaths_accessed, filepaths_clean)

  # Download new files and datetimes accessed ----------------------------------
  for (i in seq_along(filenames_root)) {
    # Delete existing files
    file_remove(filepaths_zip[i])
    file_remove(filepaths_txt[i])
    file_remove(filepaths_clean[i])
    file_remove(filepaths_accessed[i])
    # Download new files
    try(
      {
        download_generic(
          filename_roots = c(filenames_root[i]),
          filename_accessed_datetime = filepaths_accessed[i],
          download_directory = download_directory
        )
        header_string <- readr::read_lines(filepaths_txt[i], n_max = 1)
        write(header_string, file = filepaths_clean[i], append = FALSE)
        clean_string <- clean_raw_text_file(filepaths_txt[i])
        write(clean_string, file = filepaths_clean[i], append = TRUE)
      }
    )
  }
  errors <- lapply(files, function(x) {
    if (!file.exists(x)) {
      paste("\n\tMissing file:", x)
    }
  }) %>%
    unlist()
  if (!is.null(errors)) {
    stop(paste(errors, collapse = "\n"))
  }
}

#' Path to Clean Text File
#'
#' @param filenames_root A vector of filenames (without extensions) For
#' example, for 510(k)s:
#' \code{c("pmn7680", "pmn8185", "pmn8690", "pmn9195", "pmn96cur")}.
#' @param download_directory Defaults to \code{data/}.
#'
#' @return A clean text file path, such as \code{data/pmn7680_clean.txt}
#' @export
#'
path_clean <- function(filenames_root, download_directory = "data/") {
  paste0(
    download_directory, filenames_root, "_clean.txt"
  )
}

#' Path to Text File that documents Datetime Accessed
#'
#' @param filenames_root A vector of filenames (without extensions) For
#' example, for 510(k)s:
#' \code{c("pmn7680", "pmn8185", "pmn8690", "pmn9195", "pmn96cur")}.
#' @param download_directory Defaults to \code{data/}.
#'
#' @return A file path to when the data was downloaded, such as
#' \code{data/pmn7680_accessed.txt}
#' @export
#'
path_accessed <- function(filenames_root, download_directory = "data/") {
  paste0(
    download_directory, filenames_root, "_accessed.txt"
  )
}

#' Path to Zip File
#'
#' @param filenames_root A vector of filenames (without extensions) For
#' example, for 510(k)s:
#' \code{c("pmn7680", "pmn8185", "pmn8690", "pmn9195", "pmn96cur")}.
#' @param download_directory Defaults to \code{data/}.
#'
#' @return A zip file path, such as \code{data/pmn7680_clean.zip}
#' @export
#'
path_zip <- function(filenames_root, download_directory = "data/") {
  paste0(
    download_directory, filenames_root, ".zip"
  )
}

#' Path to Raw Text File
#'
#' @param filenames_root A vector of filenames (without extensions) For
#' example, for 510(k)s:
#' \code{c("pmn7680", "pmn8185", "pmn8690", "pmn9195", "pmn96cur")}.
#' @param download_directory Defaults to \code{data/}.
#'
#' @return A raw text file path, such as \code{data/pmn7680_raw.txt}
#' @export
#'
path_raw <- function(filenames_root, download_directory = "data/") {
  paste0(
    download_directory, filenames_root, ".txt"
  )
}
