# Do not hand edit this file. Edit data-raw/pma.R instead.
#' PMA
#'
#' FDA's PMA Database download file.
#'
#' Get the latest data using \code{fdadata::etl_pma()}.
#'
#' @format A tibble with 54452 rows and 25 fields:
#'
#' \describe{
#' \item{submission_number}{chr "N18143/S001", "N50009", "N50042", "N5016…}
#' \item{sponsor}{chr "ALCON LABORATORIES", "PFIZER, INC.", "PF…}
#' \item{address_line_1}{chr "6201 S FREEWAY", "235 E 42ND ST.", "235 …}
#' \item{address_line_2}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{city}{chr "FT WORTH", "NY", "NY", "KALAMAZOO", "KEO…}
#' \item{state}{chr "TX", "NY", "NY", "MI", "IA", "NJ", "TX",…}
#' \item{country}{chr "USA", "USA", "USA", "USA", "USA", "USA",…}
#' \item{zip_code}{chr "76134", "10017", "10017", "49001", "5263…}
#' \item{date_start}{date 1900-01-01, 1900-01-01, 1900-01-01, 1900…}
#' \item{date_decision}{date 1979-05-22, 1970-02-27, 1970-02-27, 1970…}
#' \item{date_federal_register}{date NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …}
#' \item{decision_code}{chr "APPR", "APRL", "APRL", "APRL", "APPR", "…}
#' \item{panel_code}{chr "OP", "MI", "MI", "MI", "HO", "SU", "OP",…}
#' \item{product_code}{chr "LPN", "JTT", "JTT", "JTT", "KGP", "LMG",…}
#' \item{generic_name}{chr "Accessories, soft lens products", "Susce…}
#' \item{track}{fct NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{reason}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{expedited}{fct Not Expedited, Not Expedited, Not Expedit…}
#' \item{device}{chr "PREFLEX AND FLEX CARE SOLUTIONS", "TERRA…}
#' \item{type}{chr "PMA", "PMA", "PMA", "PMA", "PMA", "PMA",…}
#' \item{panel}{fct "Ophthalmic", "Microbiology", "Microbiolo…}
#' \item{decision}{fct Approved, Approved - Reclassified, Approv…}
#' \item{decision_category}{fct Approved, Approved, Approved, Approved, A…}
#' \item{docket_number}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{approval_order_statement}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
#' N…}
#' }
#'
#' @source [FDA PMA Download File](https://www.fda.gov/medical-devices/device-approvals-denials-and-clearances/pma-approvals)
#' accessed 2025-07-09.
"pma"
