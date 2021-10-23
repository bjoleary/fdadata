# Do not hand edit this file. Edit data-raw/reglist.R instead.
#' reglist
#'
#' FDA's Registration and Listing Database download files.
#'
#' Get the latest data using \code{fdadata::etl_reglist()}.
#'
#' @format A list of tibbles.
#'
#' \describe{
#' \item{contact_addresses}{A table of contact addresses.}
#' \item{estabtypes}{Mapping establishments to establishment types.}
#' \item{listing_estabtypes}{Mapping listing facilities to estabtypes.}
#' \item{listing_pcd}{Mapping listings to product codes.}
#' \item{listing_proprietary_name}{Mapping listings to device names.}
#' \item{man_id_by_imp}{Mapping manufacturers to importers.}
#' \item{official_correspondent}{Official Correspondent information.}
#' \item{owner_operator}{Owner operator information.}
#' \item{reg_imp_id_by_manu}{Mapping establishments to importers.}
#' \item{registration}{Registration information.}
#' \item{registration_listing}{Listing information.}
#' \item{us_agent}{US Agent information. }
#' }
#'
#' @source [FDA R&L Download Files]()
#' accessed 2021-10-23.
"reglist"
