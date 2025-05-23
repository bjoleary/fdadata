% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/indications.R
\name{get_indications}
\alias{get_indications}
\title{Get Indications}
\usage{
get_indications(submission_number)
}
\arguments{
\item{submission_number}{A submission number for an authorized device.}
}
\value{
The indications for use for that device.
}
\description{
Extract the indications for use for a submission from the summary document
on fda.gov. This works, perhaps 50\% of the time for recently cleared
510(k)s at the moment.
}
