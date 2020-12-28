test_that("panel expansion works (expand_panels())", {
  result_table <-
  tibble::tribble(
    ~panel_code, ~panel_name,
    "OB", "Obstetrics/Gynecology",
    "CH", "Clinical Chemistry",
    "SU", "General & Plastic Surgery",
    "AN", "Anesthesiology",
    # A new panel, never before seen. Return NA.
    "XX", NA_character_
  ) %>%
    dplyr::mutate(
      panel_result = expand_panels(.data$panel_code) %>%
        as.character()
    )
  expect_equal(result_table$panel_name, result_table$panel_result)
})

test_that("decoding decisions works (decode_decision())", {
  result_table <-
    tibble::tribble(
      ~decision_code, ~decision_name,
      "SESE", "Substantially Equivalent",
      "SESP", "Substantially Equivalent - PostMarket Surveillance Required",
      "PT", "Substantially Equivalent - Subject to Tracking and Surveillance",
      "SESD", "Substantially Equivalent with Drug",
      "SESN", "Substantially Equivalent for Some Indications",
      "SEKD", "Substantially Equivalent - Kit with Drugs",
      "SESK", "Substantially Equivalent - Kit",
      "SESI", "Substantially Equivalent - Market after Inspection",
      "ST", "Substantially Equivalent - Subject to Tracking",
      "SESU", "Substantially Equivalent - With Limitations",
      "DENG", "De Novo Granted",
      "APPR", "Approved",
      "APCV", "Approved - Converted",
      "APWD", "Approved - Withdrawn",
      "APRL", "Approved - Reclassified",
      "OK30", "Accepted",
      "APCB", "Approved - Unknown",
      # A new decision, never before seen. Return the decision code.
      "XXXX", "XXXX"
    ) %>%
    dplyr::mutate(
      decision_result = decode_decision(.data$decision_code) %>%
        as.character()
    )
  expect_equal(result_table$decision_name, result_table$decision_result)
})

test_that("categorizing decisions works (categorize_decision())", {
result_table <-
  tibble::tribble(
    ~decision, ~decision_category,
    "SESE", "Substantially Equivalent",
    "Substantially Equivalent", "Substantially Equivalent",
    "SESP", "Substantially Equivalent",
    "Substantially Equivalent - PostMarket Surveillance Required",
      "Substantially Equivalent",
    "PT", "Substantially Equivalent",
    "Substantially Equivalent - Subject to Tracking and Surveillance",
      "Substantially Equivalent",
    "SESD", "Substantially Equivalent",
    "Substantially Equivalent with Drug", "Substantially Equivalent",
    "SESN", "Substantially Equivalent",
    "Substantially Equivalent for Some Indications", "Substantially Equivalent",
    "SEKD", "Substantially Equivalent",
    "Substantially Equivalent - Kit with Drugs", "Substantially Equivalent",
    "SESK", "Substantially Equivalent",
    "Substantially Equivalent - Kit", "Substantially Equivalent",
    "SESI", "Substantially Equivalent",
    "Substantially Equivalent - Market after Inspection",
      "Substantially Equivalent",
    "ST", "Substantially Equivalent",
    "Substantially Equivalent - Subject to Tracking",
      "Substantially Equivalent",
    "SESU", "Substantially Equivalent",
    "Substantially Equivalent - With Limitations", "Substantially Equivalent",
    "DENG", "Granted",
    "De Novo Granted", "Granted",
    "APPR", "Approved",
    "Approved", "Approved",
    "APCV", "Approved",
    "Approved - Converted", "Approved",
    "APWD", "Approved",
    "Approved - Withdrawn", "Approved",
    "APRL", "Approved",
    "Approved - Reclassified", "Approved",
    "OK30", "Accepted",
    "Accepted", "Accepted",
    "APCB", "Approved",
    "Approved - Unknown", "Approved",
    # A new decision code, never before seen. Return the decision code.
    "XXXX", "XXXX",
    # A new decision, never before seen. Return the decision.
    "I'm new here!", "I'm new here!"
  ) %>%
  dplyr::mutate(
    decision_result = categorize_decision(.data$decision) %>%
      as.character()
  )
  expect_equal(result_table$decision_category, result_table$decision_result)
})

test_that("removing empty files returns NULL (file_remove())", {
  expect_null(file_remove("this_file_does_not_exist.nonexistent"))
})

test_that("removing real files works", {
  expect_true(file.create("a_test_file_to_delete.deleteme"))
  expect_true(file.exists("a_test_file_to_delete.deleteme"))
  expect_true(file_remove("a_test_file_to_delete.deleteme"))
})
