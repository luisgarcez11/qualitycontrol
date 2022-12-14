% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/qc_function.R
\name{test_duplicated}
\alias{test_duplicated}
\title{Test if variable values are duplicated}
\usage{
test_duplicated(data, variable)
}
\arguments{
\item{data}{data to be tested.}

\item{variable}{The variable to be tested.}
}
\value{
A data frame containing all the findings regarding the applied test.
}
\description{
Test if variable values are duplicated
}
\examples{
test_duplicated(als_data, 'subjid')
}
