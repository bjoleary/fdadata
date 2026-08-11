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
#' 34878 to 32551, a reduction of 2327 or approximately 7%.
#'
#' \code{company_group} has
#' 31497 unique company names -- 1054 less that \code{company_clean} (roughly a
#' 3% reduction) and 3381 less than \code{sponsor} -- for a total reduction of
#' about 10%.
#'
#' @format A tibble with 232776 rows and 30 fields:
#'
#' \describe{
#' \item{submission_number}{chr "K261609", "K261915", "N12159", "N61034",…}
#' \item{sponsor}{chr "Maxx Orthopedics, Inc.", "Boston Scienti…}
#' \item{company_clean}{chr "MAXX ORTHOPEDICS", "BOSTON SCIENTIFIC", …}
#' \item{company_group}{chr "MAXX ORTHOPEDICS", "BOSTON SCIENTIFIC", …}
#' \item{contact}{chr "Asawari Hare", "Uma Ramnanan", NA, NA,…}
#' \item{address_line_1}{chr "2460 General Armistead Ave. #100", "100 …}
#' \item{address_line_2}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{city}{chr "Norristown", "Marlborough", "Raritan", "…}
#' \item{state}{chr "PA", "MA", "NJ", "MI", "NY", "NY", "NY",…}
#' \item{country}{chr "US", "US", "USA", "USA", "USA", "USA", "…}
#' \item{zip_code}{chr "19403", "01752", "08869", "49001", "1001…}
#' \item{date_start}{date 2026-05-14, 2026-06-09, 1960-10-14, 1968…}
#' \item{date_decision}{date 20-08-04, 20-08-04, 1960-10-14, 1968-10-…}
#' \item{decision_code}{chr "SESE", "SESE", "APPR", "APRL", "APRL", "…}
#' \item{panel_code}{chr "OR", "GU", "SU", "MI", "MI", "MI", "MI",…}
#' \item{product_code}{chr "HSX", "FED", "LMG", "JTT", "JTT", "JTT",…}
#' \item{summary}{fct Summary, Summary, NA, NA, NA, NA, NA, NA,…}
#' \item{track}{fct Traditional, Traditional, NA, NA, NA, NA,…}
#' \item{third_party_review}{chr "N", "N", NA, NA, NA, NA, NA, NA, NA, NA,…}
#' \item{expedited}{fct NA, NA, Not Expedited, Not Expedited, Not…}
#' \item{device}{chr "Freedom Partial Knee System", "Navigator…}
#' \item{type}{chr "510(k)", "510(k)", "PMA", "PMA", "PMA", …}
#' \item{panel}{fct "Orthopedic", "Gastroenterology & Urology…}
#' \item{decision}{fct Substantially Equivalent, Substantially E…}
#' \item{decision_category}{fct Substantially Equivalent, Substantially E…}
#' \item{date_federal_register}{date NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …}
#' \item{generic_name}{chr NA, NA, "Agent, absorbable hemostatic, no…}
#' \item{reason}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{docket_number}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{approval_order_statement}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
#' N…}
#' }
#'
#' @source FDA's
#' [PMA database download file](https://www.fda.gov/medical-devices/device-approvals-denials-and-clearances/pma-approvals) and [510(k) database download files](https://www.fda.gov/medical-devices/510k-clearances/downloadable-510k-files)
#' accessed 2026-08-11.
"premarket"
