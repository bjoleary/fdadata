% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{path_clean}
\alias{path_clean}
\title{Path to Clean Text File}
\usage{
path_clean(filenames_root, download_directory = "data/")
}
\arguments{
\item{filenames_root}{A vector of filenames (without extensions) For
example, for 510(k)s:
\code{c("pmn7680", "pmn8185", "pmn8690", "pmn9195", "pmn96cur")}.}

\item{download_directory}{Defaults to \code{data/}.}
}
\value{
A clean text file path, such as \code{data/pmn7680_clean.txt}
}
\description{
Path to Clean Text File
}
