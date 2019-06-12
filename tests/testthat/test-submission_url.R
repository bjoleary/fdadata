test_that("public database links are correct", {
  # Read in known values from file
  links <- readr::read_delim("links.csv",
                             delim = ",",
                             col_types = readr::cols(
                               Submission_Number = readr::col_character(),
                               Database_Link_Verified = readr::col_character(),
                               Summary_Link_Verified = readr::col_skip()
                             )) %>%
    # Calculate expected values
    dplyr::mutate(Database_Link = submission_url(Submission_Number))

  expect_equal(links$Database_Link_Verified, links$Database_Link)
})

test_that("database URL for 510(k)s", {
  expect_equal(
    submission_url("K760002"),
    "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfPMN/pmn.cfm?id=K760002")
})

test_that("database URL for De Novos", {
  expect_equal(
    submission_url("DEN180032"),
    "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfpmn/denovo.cfm?id=DEN180032")
})

test_that("database URL for PMA Supplements", {
  expect_equal(
    submission_url("P140003/S052"),
    "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfPMA/pma.cfm?id=P140003S052")
})

test_that("database URL for N PMAs", {
  expect_equal(
    submission_url("N18033"),
    "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfPMA/pma.cfm?id=N18033")
})

test_that("database URL for N PMA Supplements", {
  expect_equal(
    submission_url("N18033/S101"),
    "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfPMA/pma.cfm?id=N18033S101")
})

test_that("database URL for HDE Supplements", {
  expect_equal(
    submission_url("H020007/S247"),
    "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfhde/hde.cfm?id=H020007S247")
})

test_that("database URL for HDEs", {
  expect_equal(
    submission_url("H180002"),
    "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfhde/hde.cfm?id=H180002")
})

test_that("database URL for CRs", {
  expect_equal(
    submission_url("CR140535"),
    "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfClia/Results.cfm?start_search=1&Document_Number=CR140535")
})

test_that("database URL for CRs", {
  expect_equal(
    submission_url("CW180011"),
    "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfClia/Results.cfm?start_search=1&Document_Number=CW180011")
})

test_that("database URL for Recalls", {
  expect_equal(
    submission_url("Z-1740-2019"),
    "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfRES/res.cfm?start_search=1&recallnumber=Z-1740-2019")
})

test_that("database URL for unrecognized string", {
  expect_equal(
    submission_url("S001"),
    "Unknown"
  )
})
