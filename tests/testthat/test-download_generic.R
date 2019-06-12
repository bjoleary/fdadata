library(testthat)
test_that("510(k) downloads work", {
  skip("Skipping check of 510(k) downloads...")
  # Set up filenames for 510(k)
  filename_roots = c(
    "pmn7680",
    "pmn8185",
    "pmn8690",
    "pmn9195",
    "pmn96cur")
  filename_pmn_txt <- paste(filename_roots, ".txt", sep = "")
  filename_accessed_datetime <- "pmn_accessed.txt"

  # Create the files if they don't exist
  lapply(c(filename_pmn_txt,
           filename_accessed_datetime),
         function(x){
           if(!file.exists(x)){
             writeLines("\nGeneric text\n\n", x)
           }
         })
  # Remove files if they are there now
  lapply(filename_pmn_txt, function(x){file.remove(x)})
  file.remove(filename_accessed_datetime)
  result <- download_generic(filename_roots = filename_roots,
                   filename_accessed_datetime = filename_accessed_datetime)
  # Get the new files.
  expect_equal(result, TRUE)
})
