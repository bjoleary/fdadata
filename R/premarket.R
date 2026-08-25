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
#' 34910 to 32579, a reduction of 2331 or approximately 7%.
#'
#' \code{company_group} has
#' 31525 unique company names -- 1054 less that \code{company_clean} (roughly a
#' 3% reduction) and 3385 less than \code{sponsor} -- for a total reduction of
#' about 10%.
#'
#' @format A tibble with 232964 rows and 30 fields:
#'
#' \describe{
#' \item{submission_number}{chr "K261609", "N12159", "N61034", "N50100", …}
#' \item{sponsor}{chr "Maxx Orthopedics, Inc.", "ETHICON, Inc."…}
#' \item{company_clean}{chr "MAXX ORTHOPEDICS", "ETHICON", "THE UPJOH…}
#' \item{company_group}{chr "MAXX ORTHOPEDICS", "JOHNSON AND JOHNSON"…}
#' \item{contact}{chr "Asawari Hare", NA, NA, NA, NA, NA, NA, …}
#' \item{address_line_1}{chr "2460 General Armistead Ave. #100", "1000…}
#' \item{address_line_2}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{city}{chr "Norristown", "Raritan", "Kalamazoo", "Ny…}
#' \item{state}{chr "PA", "NJ", "MI", "NY", "NY", "NY", "NY",…}
#' \item{country}{chr "US", "USA", "USA", "USA", "USA", "USA", …}
#' \item{zip_code}{chr "19403", "08869", "49001", "10017", "1001…}
#' \item{date_start}{date 2026-05-14, 1960-10-14, 1968-10-09, 1969…}
#' \item{date_decision}{date 20-08-04, 1960-10-14, 1968-10-09, 1969-0…}
#' \item{decision_code}{chr "SESE", "APPR", "APRL", "APRL", "APRL", "…}
#' \item{panel_code}{chr "OR", "SU", "MI", "MI", "MI", "MI", "MI",…}
#' \item{product_code}{chr "HSX", "LMG", "JTT", "JTT", "JTT", "JTT",…}
#' \item{summary}{fct Summary, NA, NA, NA, NA, NA, NA, NA, NA, …}
#' \item{track}{fct Traditional, NA, NA, NA, NA, NA, NA, NA, …}
#' \item{third_party_review}{chr "N", NA, NA, NA, NA, NA, NA, NA, NA, NA, …}
#' \item{expedited}{fct NA, Not Expedited, Not Expedited, Not Exp…}
#' \item{device}{chr "Freedom Partial Knee System", "SURGICEL …}
#' \item{type}{chr "510(k)", "PMA", "PMA", "PMA", "PMA", "PM…}
#' \item{panel}{fct "Orthopedic", "General & Plastic Surgery"…}
#' \item{decision}{fct Substantially Equivalent, Approved, Appro…}
#' \item{decision_category}{fct Substantially Equivalent, Approved, Appro…}
#' \item{date_federal_register}{date NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …}
#' \item{generic_name}{chr NA, "Agent, absorbable hemostatic, non-co…}
#' \item{reason}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{docket_number}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{approval_order_statement}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
#' N…}
#' }
#'
#' @source FDA's
#' [PMA database download file](https://www.fda.gov/medical-devices/device-approvals-denials-and-clearances/pma-approvals) and [510(k) database download files](https://www.fda.gov/medical-devices/510k-clearances/downloadable-510k-files)
#' accessed 2026-08-25.
"premarket"
