# Do not hand edit this file. Edit data-raw/premarket.R instead.
#' Premarket
#'
#' FDA's Premarket Databases, assembled from \code{fdadata::pmn} and
#' \code{fdadata::pma}.
#'
#' Some additional processing is done to attempt to
#' make more sense of the company names.
#' \code{fdadata::clean_company_names}
#' is used with \code{thorough = FALSE} to generate
#' \code{fdadata::premarket$company_clean}. It is used with
#' \code{thorough = TRUE} to generate
#' \code{fdadata::premarket$company_group}. This attempts to consolidate
#' submissions from some of the largest companies based on known
#' acquisitions. See \code{?fdadata::company_clean()}.
#'
#' Going from \code{sponsor} to \code{company_clean} reduces the number
#' of unique company names from
#' 39693 to 32375, a reduction of 7318 or approximately 18%.
#'
#' \code{company_group} has
#' 31314 unique company names -- 1061 less that \code{company_clean} (roughly a
#' 3% reduction) and 8379 less than \code{sponsor} -- for a total reduction of
#' about 21%.
#'
#' @format A tibble with 227647 rows and 30 fields:
#'
#' \describe{
#' \item{submission_number}{chr "N12159", "N61034", "N50100", "N50016", "…}
#' \item{sponsor}{chr "ETHICON, INC.", "THE UPJOHN CO.", "PFIZE…}
#' \item{company_clean}{chr "ETHICON", "THE UPJOHN", "PFIZER", "PFIZE…}
#' \item{company_group}{chr "JOHNSON AND JOHNSON", "THE UPJOHN", "PFI…}
#' \item{contact}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{address_line_1}{chr "1000 Route 202", "7000 PORTAGE ROAD", "2…}
#' \item{address_line_2}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{city}{chr "Raritan", "KALAMAZOO", "NY", "NY", "NY",…}
#' \item{state}{chr "NJ", "MI", "NY", "NY", "NY", "NY", "NY",…}
#' \item{country}{chr "USA", "USA", "USA", "USA", "USA", "USA",…}
#' \item{zip_code}{chr "08869", "49001", "10017", "10017", "1001…}
#' \item{date_start}{date 1960-10-14, 1968-10-09, 1969-09-04, 1969…}
#' \item{date_decision}{date 1960-10-14, 1968-10-09, 1969-09-04, 1969…}
#' \item{decision_code}{chr "APPR", "APRL", "APRL", "APRL", "APRL", "…}
#' \item{panel_code}{chr "SU", "MI", "MI", "MI", "MI", "MI", "MI",…}
#' \item{product_code}{chr "LMG", "JTT", "JTT", "JTT", "JTT", "LON",…}
#' \item{summary}{fct NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{track}{fct NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{third_party_review}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{expedited}{fct Not Expedited, Not Expedited, Not Expedit…}
#' \item{device}{chr "SURGICEL BRAND ABSORBABLE HEMOSTAT", "LI…}
#' \item{type}{chr "PMA", "PMA", "PMA", "PMA", "PMA", "PMA",…}
#' \item{panel}{fct "General & Plastic Surgery", "Microbiolog…}
#' \item{decision}{fct Approved, Approved - Reclassified, Approv…}
#' \item{decision_category}{fct Approved, Approved, Approved, Approved, A…}
#' \item{date_federal_register}{date NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …}
#' \item{generic_name}{chr "Agent, absorbable hemostatic, non-collag…}
#' \item{reason}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{docket_number}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{approval_order_statement}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
#' N…}
#' }
#'
#' @source FDA's
#' [PMA database download file](https://www.fda.gov/medical-devices/device-approvals-denials-and-clearances/pma-approvals) and [510(k) database download files](https://www.fda.gov/medical-devices/510k-clearances/downloadable-510k-files)
#' accessed 2025-09-09.
"premarket"
