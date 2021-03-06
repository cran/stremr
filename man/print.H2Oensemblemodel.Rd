% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summaryS3methods.R
\name{print.H2Oensemblemodel}
\alias{print.H2Oensemblemodel}
\title{S3 methods for printing model fit summary for H2Omodel class object}
\usage{
\method{print}{H2Oensemblemodel}(x, only.coefs = FALSE, ...)
}
\arguments{
\item{x}{The model fit object produced by any stremr S3 function starting with \code{stremr:::H2Omodel.}}

\item{only.coefs}{Skip all of the h2o-specific model stats, only print the coefficients table (when running \code{fit.algorithm = "GLM"}).}

\item{...}{Additional options passed on to \code{summary.H2Omodel}.}
}
\value{
The output is printed with \code{cat}. To capture the markdown-formated model summary use \code{summary.H2Omodel}.
}
\description{
Prints the modeling summary for the h2o model fit (see \code{h2o} R package).
}

