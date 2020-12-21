#' Prepare Regular Expression
#'
#' @param vector A vector of terms to search for
#'
#' @return A regular expression, including word boundary characters
#'
prep_regex <- function(vector) {
  vector %>%
    # Put a word boundary on each side of the term:
    paste0("\\b", ., "\\b") %>%
    # Separate with the pipe character for "or"
    paste(collapse = "|") %>%
    stringr::regex(
      pattern = .,
      ignore_case = TRUE
    )
}

#' Check Big Companies
#'
#' @param string A company name as a string
#'
#' @return A company name as a string, matched against a list of major
#' acquisitions in the medical device space.
#'
check_big_companies <- function(string) {
  # Big companies --------------------------------------------------------------
  big_companies <-
    list(
      "johnson and johnson" =
        c(
          "acclarent",
          "animas",
          "biosense",
          "codman",
          "depuy",
          "ethicon",
          "johnson &",
          "johnson and",
          "mentor",
          "synthes",
          "vistakon"
        ) %>%
        prep_regex(),
      "ge" =
        c(
          "ge",
          "general electric"
        ) %>%
        prep_regex(),
      "medtronic" =
        c(
          "covidien",
          "medtronic",
          "vitatron"
        ) %>%
        prep_regex(),
      "siemens" =
        c(
          "siemens"
        ) %>%
        prep_regex(),
      "baxter" =
        c(
          "baxter"
        ) %>%
        prep_regex(),
      "fresenius" =
        c(
          "app pharmaceuticals",
          "dabur pharma",
          "damp group",
          "fenwal",
          "fresenius",
          "helios kliniken",
          "humaine kliniken",
          "idc salud",
          "labesfal",
          "nxstage"
        ) %>%
        prep_regex(),
      "philips" =
        c(
          "biotelemetry",
          "blue willow systems",
          "koninkilijke",
          "medumo",
          "philips"
        ) %>%
        prep_regex(),
      "cardinal" =
        c(
          "allegiance healthcare",
          "bindley western",
          "cardinal",
          "cordis",
          "kinray",
          "medicine shoppe",
          "owen healthcare",
          "paramed",
          "red oak sourcing",
          "tradex"
        ) %>%
        prep_regex(),
      "novartis" =
        c(
          "advanced accelerator applications",
          "admune therapeutic",
          "alcon",
          "avexis",
          "biocine",
          "cellforcure",
          "cetus",
          "chiron",
          "ciba",
          "ciba-geigy",
          "costime",
          "delmark",
          "endocyte",
          "eon labs",
          "fougera",
          "geigy",
          "genoptix",
          "hexal",
          "matrix",
          "novartis",
          "pathogenesis",
          "powderject",
          "sandoz",
          "selexys",
          "spinfex",
          "wander",
          "wasabrod",
          "zhejiang tianyuan",
          "ziarco"
        ) %>%
        prep_regex(),
      "stryker" =
        c(
          "arthrogenix",
          "ascent healthcare",
          "berchtold",
          "concentric",
          "entellus",
          "etraumacom",
          "howmedica",
          "mako",
          "memometal",
          "novadaq",
          "orthovita",
          "osteonics",
          "patient safety technologies",
          "physio-control",
          "pivot medical",
          "plasmasol",
          "sage products",
          "sightline",
          "small bone innovations",
          "spikecore",
          "stanmore",
          "stryker",
          "surpass",
          "trauson"
        ) %>%
        prep_regex(),
      "bd" =
        c(
          "bd",
          "becton dickinson"
        ) %>%
        prep_regex(),
      "boston scientific" =
        c(
          "american medical systems",
          "apama",
          "atritech",
          "augmenix",
          "boston scientific",
          "bridgepoint",
          "btg",
          "cameron health",
          "claret",
          "cosman medical",
          "cryocor",
          "cryterion",
          "distal access",
          "endochoice",
          "intelect medical",
          "iogyn",
          "millipede",
          "nvision medical",
          "nxthera",
          "rhythmia",
          "sadra",
          "securus",
          "symetis",
          "veniti",
          "vertiflex",
          "vessix",
          "xlumena"
        ) %>%
        prep_regex(),
      "essilor" =
        c(
          "essilor"
        ) %>%
        prep_regex(),
      "allergan" =
        c(
          "allergan"
        ) %>%
        prep_regex(),
      "3m" =
        c(
          "3m"
        ) %>%
        prep_regex(),
      "abbott" =
        c(
          "abbott",
          "advanced medical optics",
          "advanced neuromodulation systems",
          "aga",
          "alere",
          "alkaloidal",
          "apica",
          "arriva",
          "beecham",
          "biocor",
          "cardiomems",
          "cfr pharmaceuticals",
          "daig",
          "endocardial solutions",
          "endosense",
          "epocal",
          "guidant",
          "heart valve",
          "idev",
          "intralase",
          "kalo",
          "knoll",
          "lab data management",
          "levitronix",
          "lightlab",
          "mediguide",
          "nanostim",
          "optimedica",
          "pacesetter",
          "ross laboratories",
          "smithcline",
          "solvay",
          "spinal modulation",
          "st jude",
          "starlims",
          "therasense",
          "thermo cardiosystems",
          "thoratec",
          "topera",
          "tyco",
          "ventritex",
          "veropharm"
        ) %>%
        prep_regex(),
      "zimmer" =
        c(
          "biomet",
          "zimmer"
        ) %>%
        prep_regex(),
      "terumo" =
        c(
          "terumo"
        ) %>%
        prep_regex(),
      "smith and nephew" =
        c(
          "smith and nephew"
        ) %>%
        prep_regex(),
      "getinge" =
        c(
          "getinge"
        ) %>%
        prep_regex(),
      "align technology" =
        c(
          "align technology"
        ) %>%
        prep_regex(),
      "olympus" =
        c(
          "olympus"
        ) %>%
        prep_regex(),
      "straumann" =
        c(
          "straumann"
        ) %>%
        prep_regex(),
      "intuitive surgical" =
        c(
          "intuitive surgical"
        ) %>%
        prep_regex(),
      "danaher" =
        c(
          "beckman",
          "cepheid",
          "coulter",
          "danaher",
          "implant direct",
          "integrated dna",
          "kavo",
          "leica biosystems",
          "molecular devices",
          "nobel biocare",
          "orascopic",
          "ormco",
          "pall",
          "radiometer"
        ) %>%
        prep_regex(),
      "abicomed" =
        c(
          "abicomed"
        ) %>%
        prep_regex(),
      "teleflex" =
        c(
          "teleflex"
        ) %>%
        prep_regex(),
      "edward lifesciences" =
        c(
          "edward lifesciences"
        ) %>%
        prep_regex(),
      "cooper companies" =
        c(
          "cooper companies"
        ) %>%
        prep_regex(),
      "hologic" =
        c(
          "hologic"
        ) %>%
        prep_regex(),
      "varian" =
        c(
          "varian"
        ) %>%
        prep_regex(),
      "steris" =
        c(
          "steris"
        ) %>%
        prep_regex(),
      "west pharmaceutical" =
        c(
          "west pharmaceutical"
        ) %>%
        prep_regex(),
      "hill-rom" =
        c(
          "hill-rom"
        ) %>%
        prep_regex(),
      "icu medical" =
        c(
          "icu medical"
        ) %>%
        prep_regex(),
      "integra life sciences" =
        c(
          "integra"
        ) %>%
        prep_regex(),
      "b braun melsungen" =
        c(
          "braun",
          "melsungen"
        ) %>%
        prep_regex(),
      "masimo" =
        c(
          "masimo"
        ) %>%
        prep_regex(),
      "haemonetics" =
        c(
          "haemonetics"
        ) %>%
        prep_regex(),
      "globus medical" =
        c(
          "globus"
        ) %>%
        prep_regex(),
      "insulet" =
        c(
          "insulet"
        ) %>%
        prep_regex(),
      "inogen" =
        c(
          "inogen"
        ) %>%
        prep_regex(),
      "merit medical" =
        c(
          "merit medical"
        ) %>%
        prep_regex(),
      "nuvasive" =
        c(
          "nuvasive"
        ) %>%
        prep_regex(),
      "halyard health" =
        c(
          "halyard"
        ) %>%
        prep_regex(),
      "conmed" =
        c(
          "conmed"
        ) %>%
        prep_regex(),
      "prestige brands" =
        c(
          "prestige brands"
        ) %>%
        prep_regex(),
      "nxstage" =
        c(
          "nxstage"
        ) %>%
        prep_regex(),
      "nevro" =
        c(
          "nevro"
        ) %>%
        prep_regex(),
      "luminex" =
        c(
          "luminex"
        ) %>%
        prep_regex(),
      "glaukos" =
        c(
          "glaukos"
        ) %>%
        prep_regex(),
      "atrion" =
        c(
          "atrion"
        ) %>%
        prep_regex(),
      "cardiovascular systems" =
        c(
          "cardiovascular systems",
          "cardiovascular sys"
        ) %>%
        prep_regex(),
      "orthofix" =
        c(
          "orthofix"
        ) %>%
        prep_regex(),
      "cryolife" =
        c(
          "cryolife"
        ) %>%
        prep_regex(),
      "natus medical" =
        c(
          "natus"
        ) %>%
        prep_regex(),
      "orasure technologies" =
        c(
          "orasure"
        ) %>%
        prep_regex(),
      "k2m group" =
        c(
          "k2m"
        ) %>%
        prep_regex(),
      "mesa laboratories" =
        c(
          "mesa"
        ) %>%
        prep_regex(),
      "cutera" =
        c(
          "cutera"
        ) %>%
        prep_regex(),
      "endologix" =
        c(
          "endologix"
        ) %>%
        prep_regex(),
      "utah medical products" =
        c(
          "utah medical products"
        ) %>%
        prep_regex(),
      "seaspine" =
        c(
          "seaspine"
        ) %>%
        prep_regex(),
      "consort" =
        c(
          "consort"
        ) %>%
        prep_regex(),
      "atricure" =
        c(
          "atricure"
        ) %>%
        prep_regex(),
      "angiodynamics" =
        c(
          "angiodynamics"
        ) %>%
        prep_regex(),
      "viewray" =
        c(
          "viewray"
        ) %>%
        prep_regex(),
      "lemaitre vascular" =
        c(
          "lemaitre"
        ) %>%
        prep_regex(),
      "genmark diagnostics" =
        c(
          "genmark"
        ) %>%
        prep_regex(),
      "intersect ent" =
        c(
          "intersect ent"
        ) %>%
        prep_regex(),
      "staar surgical" =
        c(
          "staar surgical"
        ) %>%
        prep_regex(),
      "tandem diabetes care" =
        c(
          "tandem"
        ) %>%
        prep_regex(),
      "nemaura medical" =
        c(
          "nemaura"
        ) %>%
        prep_regex(),
      "mimedx group" =
        c(
          "mimedx"
        ) %>%
        prep_regex(),
      "rti surgical" =
        c(
          "rti surgical"
        ) %>%
        prep_regex(),
      "biolife solutions" =
        c(
          "biolife"
        ) %>%
        prep_regex(),
      "iradimed" =
        c(
          "iradimed"
        ) %>%
        prep_regex(),
      "fonar" =
        c(
          "fonar"
        ) %>%
        prep_regex(),
      "harvard bioscience" =
        c(
          "harvard bioscience"
        ) %>%
        prep_regex(),
      "shandong weigao" =
        c(
          "shandong",
          "weigao"
        ) %>%
        prep_regex(),
      "microport scientific" =
        c(
          "microport"
        ) %>%
        prep_regex(),
      "china grand pharmaceutical and healthcare" =
        c(
          "china grand"
        ) %>%
        prep_regex(),
      "coloplast" =
        c(
          "coloplast"
        ) %>%
        prep_regex(),
      "bioquell" =
        c(
          "bioquell"
        ) %>%
        prep_regex(),
      "sartorius stedim" =
        c(
          "sartorius",
          "stedim"
        ) %>%
        prep_regex(),
      "tristel" =
        c(
          "tristel"
        ) %>%
        prep_regex(),
      "cochlear" =
        c(
          "cochlear"
        ) %>%
        prep_regex(),
      "advanced medical solutions" =
        c(
          "advanced medical solutions"
        ) %>%
        prep_regex(),
      "fisher and paykel" =
        c(
          "paykel"
        ) %>%
        prep_regex(),
      "biotage" =
        c(
          "biotage"
        ) %>%
        prep_regex(),
      "amplifon" =
        c(
          "amplifon"
        ) %>%
        prep_regex(),
      "gerresheimer" =
        c(
          "gerresheimer"
        ) %>%
        prep_regex(),
      "ypsomed" =
        c(
          "ypsomed"
        ) %>%
        prep_regex(),
      "transenterix" =
        c(
          "transenterix"
        ) %>%
        prep_regex(),
      "roche" =
        c(
          "roche"
        ) %>%
        prep_regex(),
      "apple" =
        c(
          "apple"
        ) %>%
        prep_regex(),
      "pear therapeutics" =
        c(
          "pear"
        ) %>%
        prep_regex(),
      "samsung" =
        c(
          "samsung"
        ) %>%
        prep_regex(),
      "phosphorus" =
        c(
          "phosphorus"
        ) %>%
        prep_regex(),
      "tidepool" =
        c(
          "tidepool"
        ) %>%
        prep_regex(),
      "verily" =
        c(
          "verily"
        ) %>%
        prep_regex(),
      "fitbit" =
        c(
          "fitbit"
        ) %>%
        prep_regex(),
      "maxq" =
        c(
          "maxq"
        ) %>%
        prep_regex(),
      "zebra" =
        c(
          "zebra"
        ) %>%
        prep_regex()
    )

  # This method: Benchmark on 1000 premarket documents: 3.6s
  big_companies_length <- length(big_companies) %>% as.numeric()
  sapply(string, function(x) { # TODO: Make this a vapply
    # Start a counter
    i <- 0
    match_found <- FALSE
    while (match_found == FALSE) {
      i <- i + 1
      if (i > big_companies_length) {
        # We've checked against all the big companies, and now it is time to
        # return the result we were provided
        match_found <- TRUE
        result <- x
      } else if (
        stringr::str_detect(
          string = x,
          pattern = big_companies[[i]]
        )
      ) {
        # We found a match among the big companies, and now it is time to
        # return the name of that company
        match_found <- TRUE
        result <- names(big_companies[i]) %>% stringr::str_to_upper(.)
      } else {
        # Try the next big company
        next
      }
    }
    result
  })

  # This method: Benchmark on 1000 premarket documents: 4.8s
  # sapply(string, function(x) { # TODO: Make this a vapply
  #   match_list <-
  #     lapply(seq_along(big_companies), function(i){
  #       if (stringr::str_detect(string = x, pattern = big_companies[[i]])) {
  #         # We found a match among the big companies, and now it is time to
  #         # return the name of that company
  #         names(big_companies[i]) %>% stringr::str_to_upper(.)
  #       } else {
  #         # Return NULL
  #         NULL
  #       }
  #     }) %>%
  #     Filter(Negate(is.null), .) %>%
  #     unlist()
  #   if (is.null(match_list)) {
  #     x
  #   } else {
  #     match_list[[1]]
  #   }
  # })
}

#' Clean Company Names
#'
#' @param string A company name with unspecified case,
#' punctuation, and suffixes (e.g. "LLC", "Corp").
#' @param thorough A boolean (defaults to \code{FALSE}) for deciding whether to
#' check the company names against a list of known large manufacturers,
#' including their acquisitions. Selecting \code{TRUE} slows down the operation
#' significantly, taking about 4.8 seconds per thousand company names.
#'
#' @return An all-caps company name without extraneous characters,
#' punctuation, and terms removed.
#' @export
#'
clean_company_names <- function(string, thorough = FALSE) {
  # Common company suffixes ----------------------------------------------------
  co <-
    c(
      "ab",
      "ag",
      "bhd",
      "bv",
      "co",
      "company",
      "corp",
      "corporation",
      "cv",
      "gmbh",
      "holdings",
      "inc",
      "incorporated",
      "international",
      "intl",
      "kg",
      "kgaa",
      "limited",
      "llc",
      "ltd",
      "mfg",
      "nv",
      "s\\/a",
      "sa",
      "sae",
      "sdn",
      "se",
      "spa",
      "srl",
      "srl",
      "USA"
    ) %>%
    prep_regex()

  # Put it together ------------------------------------------------------------
  result <-
    string %>%
    # Remove certain punctuation
    stringr::str_remove_all(., pattern = ",|\\.|\\[|\\]|\\(|\\)|\\;|\\:") %>%
    # Remove common company suffixes
    stringr::str_remove_all(
      string = .,
      pattern = co
    ) %>%
    # Replace ampersands
    stringr::str_replace_all(
      string = .,
      pattern = stringr::fixed("&"),
      replacement = "AND"
    ) %>%
    # Remove white space
    stringr::str_squish(.) %>%
    # Capitalize
    stringr::str_to_upper(.) %>%
    # Remove trailing "AND" (from, e.g. "ACME LLC AND CO" where "LLC" and "CO"
    # have been removed above).
    stringr::str_remove(., pattern = "AND$") %>%
    # If you do remove an "AND", you may be left with white space at the end of
    # the string. Let's remove that.
    stringr::str_squish(.)

  if (thorough == TRUE) {
    # Check the result against our list of big companies
    result %>%
      check_big_companies(.)
  } else {
    result
  }
}
