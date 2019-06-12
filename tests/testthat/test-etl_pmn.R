# Setup.
#

test_that("refreshing the data from file works", {
  testthat::skip("Skipping refresh of data")
  filename_roots = c(
    "pmn7680",
    "pmn8185",
    "pmn8690",
    "pmn9195",
    "pmn96cur")
  filename_pmn_txt <- paste(filename_roots, ".txt", sep = "")
  filename_accessed_datetime <- "pmn_accessed.txt"

  errors <- lapply(filename_pmn_txt, function(x){
    if(!file.exists(x)){
      value <- paste("\n\tMissing file:", x)
    }
  }) %>%
    unlist()
  if(!is.null(errors)){
    data <- etl_pmn(TRUE)
  }else if (is.null(errors)) {
    data <- etl_pmn(FALSE)
  }
  data <- etl_pmn(FALSE)
  expect_equal(data,TRUE)
})

test_that("able to read in the decisions csv", {
  decisions <- read_decisions()
  decisions <- decisions[1, ] %>% unlist()
  first_line <- c("Decision_Code" = "SESE",
                  "Decision_Category" = "Substantially Equivalent",
                  "Decision" = "Substantially Equivalent")
  expect_equal(first_line, decisions)
}
)
test_that("all the expected column names are present", {
  skip("Skipping check of column names...")
})

test_that("all panel names have been found", {
  skip("Skipping check of panel names...")
})

test_that("all decisions have been found", {
  skip("Skipping check of decisions...")
})
