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
