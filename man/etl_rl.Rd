% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/etl_rl.R
\name{etl_rl}
\alias{etl_rl}
\title{ETL Registration and Listing data from the FDA website.}
\source{
Data is downloaded from
\url{https://www.fda.gov/medical-devices/device-registration-and-listing/establishment-registration-and-medical-device-listing-files-download}.
}
\usage{
etl_rl(refresh_data = FALSE, download_directory = "data/")
}
\arguments{
\item{refresh_data}{Boolean. When \code{TRUE}, fresh data is downloaded from
fda.gov. When \code{FALSE}, data is read in from a text file on the disk.}

\item{download_directory}{Defaults to \code{data/}.}
}
\value{
Registration and Listing data as a tibble
}
\description{
ETL Registration and Listing data from the FDA website.
}
