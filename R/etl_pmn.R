#' ETL 510(k) data from the FDA website.
#'
#' @param refresh_data Boolean. When \code{TRUE}, fresh data is downloaded from
#' fda.gov. When \code{FALSE}, data is read in from a text file on the disk.
#' @return 510(k) data as a tibble
#' @source Data is downloaded from \url{https://go.usa.gov/xEKmh}.
#' @export
#' @importFrom magrittr "%>%"
etl_pmn <- function(refresh_data = FALSE){
  # Set some initial values ----------------------------------------------------
  filename_roots = c(
    "pmn7680",
    "pmn8185",
    "pmn8690",
    "pmn9195",
    "pmn96cur")

  filename_pmn_txt <- paste(filename_roots, ".txt", sep = "")
  filename_pmn_clean_txt <- "pmn_clean.txt"
  filename_accessed_datetime <- "pmn_accessed.txt"

  # Refresh the data if appropriate --------------------------------------------
  if(refresh_data == TRUE){
    message(paste("Deleting old download files..."))
    lapply(filename_pmn_txt, function(x){file_remove(x)})
    file_remove(filename_pmn_clean_txt)
    file_remove(filename_accessed_datetime)
    download_generic(filename_roots = filename_roots,
                     filename_accessed_datetime = filename_accessed_datetime)
    # Clean the data -----------------------------------------------------------
    # Before we read this in as a delim file, submission K010142 includes a
    # quote character in the record that messes things up. Let's remove those.

    # Get the header row from one of the input files
    header_string <- readr::read_lines(filename_pmn_txt[1], n_max = 1)

    # Put that header row into the clean output file
    write(header_string, file = filename_pmn_clean_txt, append = FALSE)
    remove(header_string)

    lapply(filename_pmn_txt, function(x){
      data_string <- clean_raw_text_file(x)
      write(data_string, file = filename_pmn_clean_txt, append = TRUE)
    })
  }

  # Check for the file we need -------------------------------------------------
  files <- c(filename_pmn_clean_txt, filename_accessed_datetime)
  errors <- lapply(files, function(x){
    if(!file.exists(x)){
      value <- paste("\n\tMissing file:", x)
    }
  }) %>%
    unlist()
  if(!is.null(errors)){
    stop(paste(errors, collapse = "\n"))
  }
  # Read the file --------------------------------------------------------------
  # Set the column types
  col_types <- readr::cols(
    KNUMBER = readr::col_character(),
    APPLICANT = readr::col_character(),
    CONTACT = readr::col_character(),
    STREET1 = readr::col_character(),
    STREET2 = readr::col_character(),
    CITY = readr::col_character(),
    STATE = readr::col_character(),
    COUNTRY_CODE = readr::col_factor(),
    ZIP = readr::col_character(),
    POSTAL_CODE = readr::col_skip(),
    DATERECEIVED = readr::col_date(format = "%m/%d/%Y"),
    DECISIONDATE = readr::col_date(format = "%m/%d/%Y"),
    DECISION = readr::col_character(),
    REVIEWADVISECOMM = readr::col_character(),
    PRODUCTCODE = readr::col_character(),
    STATEORSUMM = readr::col_factor(),
    CLASSADVISECOMM = readr::col_skip(),
    SSPINDICATOR = readr::col_skip(),
    TYPE = readr::col_character(),
    THIRDPARTY = readr::col_character(),
    EXPEDITEDREVIEW = readr::col_character(),
    DEVICENAME = readr::col_character()
  )

  # Read the file --------------------------------------------------------------
  message(paste("Reading in the cleaned data from ",
                filename_pmn_clean_txt, sep = ""))
  data <- readr::read_delim(
    file = filename_pmn_clean_txt,
    delim = "|",
    col_types = col_types
  )

  panels <- read_panels()
  decisions <- read_decisions()

  # Rename the fields ----------------------------------------------------------
  data <- data %>%
    dplyr::rename(
      Submission_Number = KNUMBER,
      Sponsor = APPLICANT,
      Contact = CONTACT,
      Address_Line_1 = STREET1,
      Address_Line_2 = STREET2,
      City = CITY,
      State = STATE,
      Zip_Code = ZIP,
      Country = COUNTRY_CODE,
      Date_Start = DATERECEIVED,
      Date_Decision = DECISIONDATE,
      Decision_Code = DECISION,
      Panel_Code = REVIEWADVISECOMM,
      Product_Code = PRODUCTCODE,
      Summary = STATEORSUMM,
      Track = TYPE,
      Third_Party_Review = THIRDPARTY,
      Expedited = EXPEDITEDREVIEW,
      Device = DEVICENAME
    )

  # Clean up the fields --------------------------------------------------------
  data <- data %>%
    # Identify submission type
    dplyr::mutate(Type = dplyr::case_when(
      stringr::str_detect(Submission_Number, "DEN") ~ "De Novo",
      stringr::str_detect(Submission_Number, "K") ~ "510(k)"
    )) %>%
    # Clean up expedited column
    dplyr::mutate(Expedited = as.factor(
      dplyr::case_when(
        Expedited == "Y" ~ "Expedited"
      )
    )) %>%
    # Replace panel codes with names
    dplyr::left_join(y = panels, by = c("Panel_Code" = "Panel_Code")) %>%
    dplyr::select(-Panel_Code) %>%
    dplyr::mutate(Panel = as.factor(Panel)) %>%
    # Add Third Party to the Track
    dplyr::mutate(Track = dplyr::case_when(
      Third_Party_Review == "Y" ~ paste("Third Party", Track, sep = " "),
      TRUE ~ Track
    )) %>%
    dplyr::mutate(Track = as.factor(Track)) %>%
    # Add Decisions
    dplyr::left_join(y = decisions,
                     by = c("Decision_Code" = "Decision_Code")) %>%
    dplyr::mutate(Decision_Code = as.factor(Decision_Code)) %>%
    dplyr::mutate(Decision_Category = as.factor(Decision_Category)) %>%
    dplyr::mutate(Decision = as.factor(Decision))
}

#' Read in a table of FDA panel codes and panels
#'
#' Can be used to convert two letter panel codes to human readable panel names.
#'
#' @return A table with two columns:
#' \describe{
#' \item{\code{Panel_Code}}{The two letter code stored in FDA's database}
#' \item{\code{Panel}}{The full, human-readable panel}
#' }
# Helper functions -------------------------------------------------------------
read_panels <- function() {
  file_path <- system.file("extdata",
                           "panels.csv",
                           package = "fdadata",
                           mustWork = TRUE)

  panels <- readr::read_delim(file = file_path,
                              delim = ";",
                              col_types = readr::cols(
                                Panel_Code = readr::col_character(),
                                Panel = readr::col_character()
                              )
  )
}

#' Read in a table of FDA decision codes, categories, and decisions
#'
#' Can be used to convert two- and four-letter decision codes to human readable
#' decisions and grouped decision categories (e.g. ``Substantially
#' Equivalent''.)
#'
#' @return A table with 3 columns:
#' \describe{
#' \item{\code{Decision_Code}}{The two or four letter code stored in FDA's
#' database}
#' \item{\code{Decision_Category}}{The broader category grouping of the
#' decision, such as ``Substantially Equivalent'' or ``De Novo Granted''}
#' \item{\code{Decision}}{The full, human-readable decision}
#' }
#' @importFrom readr "cols"
#' @importFrom readr "col_character"
read_decisions <- function(){
  file_path <- system.file("extdata",
                           "decisions.csv",
                           package = "fdadata",
                           mustWork = TRUE)

  decisions <- readr::read_delim(file = file_path,
                              delim = "|",
                              col_types = readr::cols(
                                Decision_Code = readr::col_character(),
                                Decision_Category = readr::col_character(),
                                Decision = readr::col_character()
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
file_remove <- function(filepath){
  if(file.exists(filepath)){
    file.remove(filepath)
  }
}
