% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stremr-package.R
\docType{package}
\name{stremr-package}
\alias{stremr-package}
\title{Estimate the Survival of Intervention on Exposures and MONITORing Process for Right Censored Longitudinal Data.}
\description{
The \pkg{stremr} R package is a tool for estimation of causal survival curve under various user-specified interventions
(e.g., static, dynamic, deterministic, or stochastic).
In particular, the interventions may represent exposures to treatment regimens, the occurrence or non-occurrence of right-censoring
events, or of clinical monitoring events. \pkg{stremr} enables estimation of a selected set of the user-specified causal quantities of interest,
such as, treatment-specific survival curves and the average risk difference over time.
}
\section{Documentation}{

\itemize{
\item To see the package vignette use: \code{vignette("stremr_vignette", package="stremr")}
\item To see all available package documentation use: \code{help(package = 'stremr')}
}
}

\section{Routines}{

The following routines will be generally invoked by a user, in the same order as presented below.
\describe{
\item{\code{\link{stremr}}}{One function for performing estimation}
}
}

\section{Data structures}{

The following most common types of output are produced by the package:
\itemize{
\item \emph{observed data} - input data.frame in long format (repeated measures over time).
}
}

\section{Updates}{

Check for updates and report bugs at \url{http://github.com/osofr/stremr}.
}

