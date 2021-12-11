# Do not hand edit this file. Edit data-raw/ifu_form_text.R instead.
#' Indications For Use Form Text
#'
#' Words (and counts) used in FDA's indications for use form.
#' Used by \code{fdadata::get_indications()} to identify promising IFU
#' pages in summary documents.
#'
#' @format A tibble with 93 rows and 2 fields:
#'
#' \describe{
#' \item{word}{chr "information", "collection", "burden", "form", "pra",
#' "servic…}
#' \item{n}{int 5, 4, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2…}
#' }
#'
#' @source
#' [Indications for Use form](https://www.fda.gov/media/86323/download)
#' accessed 2021-12-10.
"ifu_form_text"
