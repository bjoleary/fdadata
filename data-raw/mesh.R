## code to prepare `mesh` dataset goes here
library(magrittr)
library(readr)
devtools::load_all()

filename <- "c2021_disease.bin"
directory <- "data-raw/"
filepath <- paste0(directory, filename)
url_root <-
  "https://nlmpubs.nlm.nih.gov/projects/mesh/MESH_FILES/asciimesh/"
if (!file.exists(filepath)) {
  download.file(
    url = paste0(url_root, filename),
    destfile = filepath
  )
}

text <-
  readr::read_file(
    file = filepath
  ) %>%
  extract_mesh_records()

mesh_records <-
  purrr::map(
    .x = text,
    .f = construct_mesh_record
  ) %>%
  purrr::simplify()

terms <-
  purrr::map_dfr(
    .x = mesh_records,
    .f = function(x) {dplyr::bind_rows(x[names(x) == "record"])}
  ) %>%
  dplyr::distinct()

synonyms <-
  purrr::map_dfr(
    .x = mesh_records,
    .f = function(x) {dplyr::bind_rows(x[names(x) == "synonyms"])}
  ) %>%
  dplyr::distinct()

subject_headings <-
  purrr::map_dfr(
    .x = mesh_records,
    .f = function(x) {dplyr::bind_rows(x[names(x) == "subject_headings"])}
  ) %>%
  dplyr::distinct()

mesh <-
  list(
    terms = terms,
    synonyms = synonyms,
    subject_headings = subject_headings
  )

usethis::use_data(mesh, overwrite = TRUE, compress = "xz")

# Document the dataset ---------------------------------------------------------

documentation_text <-
  c(
    "Medical Subject Headings (MeSH)",
    "",
    "@format A list of medical subject headings, including terms, ",
    " synonyms, and subject_headings. ",
    "",
    "\\describe{",
    "\\item{terms}{A table of terms.}",
    "\\item{synonyms}{A table of synonyms.}",
    "\\item{subject_headings}{A table of subject headings.}",
    "\\item{listing_pcd}{Mapping listings to product codes.}",
    "}",
    "",
    "@source NIH National Library of Medicine (NLM(R)) via",
    paste0("[nlmpubs](", url_root, ") "),
    paste0("accessed ", lubridate::today(), ".")
  ) %>%
  paste0("#' ", .) %>%
  c(
    paste0(
      "# Do not hand edit this file. Edit data-raw/mesh.R ",
      "instead."
    ),
    .,
    "\"mesh\""
  ) %>%
  stringr::str_squish() %T>%
  readr::write_lines(
    x = .,
    file = "R/mesh.R",
    append = FALSE
  )

devtools::document()
