# Do not hand edit this file. Edit data-raw/product_codes.R instead.
#' Product Codes
#'
#' FDA's Product Code Database download files.
#'
#' Get the latest data using \code{fdadata::etl_procodes()}.
#'
#' @format A tibble with 6733 rows and 17 fields:
#'
#' \describe{
#' \item{review_panel}{fct "Anesthesiology", "Anesthesiology", …}
#' \item{medical_specialty}{fct "Anesthesiology", "Anesthesiology", …}
#' \item{product_code}{chr "BRW", "BRX", "BRY", "BSE", "BSF", "…}
#' \item{device_type_name}{chr "Protector, Dental", "Stool, Anesthe…}
#' \item{device_class}{chr "1", "1", "1", "2", "1", "2", "1", "…}
#' \item{unclassified_reason}{fct NA, NA, NA, NA, NA, NA, NA, NA, NA, …}
#' \item{gmp_exempt}{fct Subject to GMP, Subject to GMP, Subj…}
#' \item{third_party_eligible}{fct Ineligible for 3rd Party Review, Ine…}
#' \item{regulation}{dbl 868.5820, 868.6700, 868.6100, 868.16…}
#' \item{submission_type}{fct 510(k) Exempt, 510(k) Exempt, 510(k)…}
#' \item{definition}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, …}
#' \item{physical_state}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, …}
#' \item{technical_method}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, …}
#' \item{target_area}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, …}
#' \item{implant}{fct Not an implant, Not an implant, Not …}
#' \item{life_sustaining}{fct Not life-sustaining or supporting, N…}
#' \item{summary_malfunction_reporting}{fct Eligible for summary malfunction
#' rep…}
#' }
#'
#' @source [FDA Product Code Database]()
#' accessed 2021-12-11.
"product_codes"
