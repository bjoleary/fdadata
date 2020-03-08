test_that("database URL for 510(k)s", {
  expect_equal(
    submission_url("K760002"),
    paste0(
      "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfpmn/",
      "pmn.cfm?id=K760002"
    )
  )
})

test_that("database URL for De Novos", {
  expect_equal(
    submission_url("DEN180032"),
    paste0(
      "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfpmn/",
      "denovo.cfm?id=DEN180032"
    )
  )
})

test_that("database URL for PMA Supplements", {
  expect_equal(
    submission_url("P140003/S052"),
    paste0(
      "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfpma/",
      "pma.cfm?id=P140003S052"
    )
  )
})

test_that("database URL for N PMAs", {
  expect_equal(
    submission_url("N18033"),
    paste0(
      "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfpma/",
      "pma.cfm?id=N18033"
    )
  )
})

test_that("database URL for N PMA Supplements", {
  expect_equal(
    submission_url("N18033/S101"),
    paste0(
      "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfpma/",
      "pma.cfm?id=N18033S101"
    )
  )
})

test_that("database URL for HDE Supplements", {
  expect_equal(
    submission_url("H020007/S247"),
    paste0(
      "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfhde/",
      "hde.cfm?id=H020007S247"
    )
  )
})

test_that("database URL for HDEs", {
  expect_equal(
    submission_url("H180002"),
    paste0(
      "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfhde/",
      "hde.cfm?id=H180002"
    )
  )
})

test_that("database URL for CRs", {
  expect_equal(
    submission_url("CR140535"),
    paste0(
      "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfclia/",
      "Results.cfm?start_search=1&Document_Number=CR140535"
    )
  )
})

test_that("database URL for CRs", {
  expect_equal(
    submission_url("CW180011"),
    paste0(
      "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfclia/",
      "Results.cfm?start_search=1&Document_Number=CW180011"
    )
  )
})

test_that("database URL for Recalls", {
  expect_equal(
    submission_url("Z-1740-2019"),
    paste0(
      "https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfres/",
      "res.cfm?start_search=1&recallnumber=Z-1740-2019"
    )
  )
})

test_that("database URL for unrecognized string", {
  expect_equal(
    submission_url("S001"),
    "Unknown"
  )
})
