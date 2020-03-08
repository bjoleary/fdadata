#' Download premarket from the FDA website and store in the local directory
#' as text files.
#'
#' @param filename_roots A vector of filenames (without extensions)
#' to download from the FDA website. For example, for 510(k)s:
#' c("pmn7680", "pmn8185", ' "pmn8690", "pmn9195", "pmn96cur").
#' @param filename_accessed_datetime The file path and name of the file where
#' you would like the function to write-out the date when the files were
#' downloaded.
#' @param download_directory Defaults to \code{data/}.
#' @return Boolean. TRUE if downloads are successful.
#' @export
download_generic <- function(filename_roots, filename_accessed_datetime,
                             download_directory = "data/") {
  # Prepare the download directory ---------------------------------------------
  # Check if the download directory exists
  if(!dir.exists(download_directory)) {
    # If not, create it
    dir.create(download_directory)
  }
  # Set some initial values ----------------------------------------------------
  filename_txt <- paste(download_directory, filename_roots, ".txt", sep = "")
  files_exist <- tibble::tibble(Name = filename_txt) %>%
    dplyr::mutate(Exists = file.exists(.data$Name)) %>%
    dplyr::filter(.data$Exists == TRUE) %>%
    dplyr::select(.data$Name)
  url_fda_data <- "http://www.accessdata.fda.gov/premarket/ftparea/"

  # Make sure the file doesn't exist already -----------------------------------
  if (length(files_exist$Name) > 0) {
    stop(paste("Download files already exist! Aborting download.",
      "Delete the following files and retry: ",
      paste(files_exist$Name, collapse = "\n"),
      sep = "\n"
    ))
  }

  # Download & unzip -----------------------------------------------------------
  lapply(filename_roots, function(roots) {
    zipname <- paste(download_directory, roots, ".zip", sep = "")
    message(paste("Downloading ", roots, ".zip", "...", sep = ""))
    url_full <- paste(url_fda_data, roots, ".zip", sep = "")
    curl::curl_download(url_full,
      zipname,
      quiet = FALSE
    )
    message(paste("Unzipping ", zipname, "...", sep = ""))
    utils::unzip(zipname, overwrite = TRUE,
                 exdir = download_directory)
    file_remove(zipname)
  })

  # Document date data was accessed --------------------------------------------
  # Delete previous versions of the file if they exist.
  file_remove(filename_accessed_datetime)
  write(paste(lubridate::now()), filename_accessed_datetime)

  # Check that we got everything -----------------------------------------------
  files_missing <- tibble::tibble(Name = filename_txt) %>%
    dplyr::mutate(Exists = file.exists(.data$Name)) %>%
    dplyr::filter(.data$Exists == FALSE) %>%
    dplyr::select(.data$Name)

  if (length(files_missing$Name) > 0) {
    stop(paste("Unable to download all data. Missing: ",
      paste(files_missing$Name, collapse = "\n"),
      sep = "\n"
    ))
  }
  # Declare success! -----------------------------------------------------------
  message("Download(s) successful!")
  TRUE
}
