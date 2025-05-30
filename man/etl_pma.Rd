% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/etl_pma.R
\name{etl_pma}
\alias{etl_pma}
\title{ETL PMA data from the FDA website.}
\source{
Data is downloaded from
\url{https://www.fda.gov/medical-devices/device-approvals-denials-and-clearances/pma-approvals}.
}
\usage{
etl_pma(refresh_data = FALSE, download_directory = "data/")
}
\arguments{
\item{refresh_data}{Boolean. When \code{TRUE}, fresh data is downloaded from
fda.gov. When \code{FALSE}, data is read in from a text file on the disk.}

\item{download_directory}{Defaults to \code{data/}.}
}
\value{
PMA data as a tibble
}
\description{
ETL PMA data from the FDA website.
}
