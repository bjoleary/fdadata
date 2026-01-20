# Do not hand edit this file. Edit data-raw/pmn.R instead.
#' PMN (510(k)s)
#'
#' FDA's 510(k) Database download files.
#'
#' Get the latest data using \code{fdadata::etl_pmn()}.
#'
#' @format A tibble with 173963 rows and 23 fields:
#'
#' \describe{
#' \item{submission_number}{chr "K760001", "K760002", "K760003", "K760004",
#' "K7…}
#' \item{sponsor}{chr "Zimmer, Inc.", "Zimmer, Inc.", "Zimmer, Inc.",…}
#' \item{contact}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…}
#' \item{address_line_1}{chr "4221 Richmond Rd., NW", NA, "803 N. Front St. …}
#' \item{address_line_2}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…}
#' \item{city}{chr "Walker", "1831 Olive St. St. Louis", "Mchenry"…}
#' \item{state}{chr "MI", "MO", "IL", "IL", "IL", "MI", "IL", "IL",…}
#' \item{country}{fct US, US, US, US, US, US, US, US, US, US, US, US,…}
#' \item{zip_code}{chr "49534", NA, "60050", "60050", "60050", "49534"…}
#' \item{date_start}{date 1976-05-26, 1976-05-26, 1976-05-26, 1976-06-07…}
#' \item{date_decision}{date 1976-07-26, 1976-07-26, 1976-07-26, 1976-08-23…}
#' \item{decision_code}{chr "SESE", "SESE", "SESE", "SESE", "SESE", "SESE",…}
#' \item{panel_code}{chr "PM", "PM", "PM", "HO", "HO", "CH", "HE", "DE",…}
#' \item{product_code}{chr NA, "IQI", "ITG", "FMF", "FMF", NA, "GKJ", "DZE…}
#' \item{summary}{fct NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…}
#' \item{track}{fct Traditional, Traditional, Traditional, Traditio…}
#' \item{third_party_review}{chr "N", "N", "N", "N", "N", "N", "N", "N", "N",
#' "N…}
#' \item{expedited}{fct NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…}
#' \item{device}{chr "ARCH SUPPORT (ARCH AID)", "KNEE AID", "CAST MA…}
#' \item{type}{fct 510(k), 510(k), 510(k), 510(k), 510(k), 510(k),…}
#' \item{panel}{fct "Physical Medicine", "Physical Medicine", "Phys…}
#' \item{decision}{fct Substantially Equivalent, Substantially Equival…}
#' \item{decision_category}{fct Substantially Equivalent, Substantially
#' Equival…}
#' }
#'
#' @source [FDA 510(k) Download Files](https://www.fda.gov/medical-devices/510k-clearances/downloadable-510k-files)
#' accessed 2026-01-20.
"pmn"
