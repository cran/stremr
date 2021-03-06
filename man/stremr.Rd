% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stremr.R
\name{stremr}
\alias{stremr}
\title{Estimate Survival with Interventions on Exposure and MONITORing Process in Right Censored Longitudinal Data.}
\usage{
stremr(data, ID = "Subj_ID", t.name = "time_period", covars, CENS = "C",
  TRT = "A", MONITOR = "N", OUTCOME = "Y", gform_CENS, gform_TRT,
  gform_MONITOR, stratify_CENS = NULL, stratify_TRT = NULL,
  stratify_MONITOR = NULL, intervened_TRT = NULL,
  intervened_MONITOR = NULL, noCENScat = 0L,
  verbose = getOption("stremr.verbose"), optPars = list())
}
\arguments{
\item{data}{Input data in long format. Can be a \code{data.frame} or a \code{data.table} with named columns, containing the time-varying covariates (\code{covars}),
the right-censoring event indicator(s) (\code{CENS}), the exposure variable(s) (\code{TRT}), the monitoring process variable(s) (\code{MONITOR})
and the survival OUTCOME variable (\code{OUTCOME}).}

\item{ID}{Unique subject identifier column name in \code{data}.}

\item{t.name}{The name of the time/period variable in \code{data}.}

\item{covars}{Vector of names with time varying and baseline covariates in \code{data}. This argument does not need to be specified, by default all variables
that are not in \code{ID}, \code{t}, \code{CENS}, \code{TRT}, \code{MONITOR} and \code{OUTCOME} will be considered as covariates.}

\item{CENS}{Column name of the censoring variable(s) in \code{data}.
Each separate variable specified in \code{CENS} can be either binary (0/1 valued integer) or categorical (integer).
For binary indicators of CENSoring, the value of 1 indicates the CENSoring or end of follow-up event (this cannot be changed).
For categorical CENSoring variables, by default the value of 0 indicates no CENSoring / continuation of follow-up and other
values indicate different reasons for CENSoring.
Use the argument \code{noCENScat} to change the reference (continuation of follow-up) category from default 0 to any other value.
(NOTE: Changing \code{noCENScat} has zero effect on coding of the binary CENSoring variables, those have to always use 1 to code the CENSoring event).
Note that factors are not allowed in \code{CENS}.}

\item{TRT}{A column name in \code{data} for the exposure/treatment variable(s).}

\item{MONITOR}{A column name in \code{data} for the indicator(s) of monitoring events.}

\item{OUTCOME}{A column name in \code{data} for the survival OUTCOME variable name, code as 1 for the outcome event.}

\item{gform_CENS}{Regression formula(s) for estimating the propensity score for the censoring mechanism: P(C(t) | W). See Details.}

\item{gform_TRT}{Regression formula(s) for propensity score for the exposure/treatment(s): P(A(t) | W). See Details.}

\item{gform_MONITOR}{Regression formula(s) for estimating the propensity score for the MONITORing process: P(N(t) | W). See Details.
(the observed exposure mechanism), When omitted the regression is defined by \code{sA~sW}, where \code{sA}}

\item{stratify_CENS}{A named list with one item per variable in \code{CENS}.
Each list item is a character vector of stratification subsets for the corresponding variable in \code{CENS}.}

\item{stratify_TRT}{A named list with one item per variable in \code{TRT}.
Each list item is a character vector of stratification subsets for the corresponding variable in \code{TRT}.}

\item{stratify_MONITOR}{A named list with one item per variable in \code{MONITOR}.
Each list item is a character vector of stratification subsets for the corresponding variable in \code{MONITOR}.}

\item{intervened_TRT}{Column name in \code{data} containing the counterfactual probabilities of following a specific treatment regimen.}

\item{intervened_MONITOR}{Column name in \code{data} containing the counterfactual probabilities of following a specific monitoring regimen.}

\item{noCENScat}{The level (integer) that indicates CONTINUATION OF FOLLOW-UP for ALL censoring variables. Defaults is 0.
Use this to modify the default reference category (no CENSoring / continuation of follow-up)
for variables specifed in \code{CENS}.}

\item{verbose}{Set to \code{TRUE} to print messages on status and information to the console. Turn this on by default using \code{options(stremr.verbose=TRUE)}.}

\item{optPars}{A named list of additional optional parameters to be passed to \code{stremr}, such as
\code{alpha}, \code{lbound}, \code{family}, \code{YnodeDET},
\code{h_g0_GenericModel} and \code{h_gstar_GenericModel}. See Details below for the description of each parameter.}
}
\value{
...
}
\description{
Estimate the causal survival curve for a particular stochastic, dynamic or static intervention on the treatment/exposure and monitoring process.
 Implements the \strong{IPW} (Inverse Probability-Weighted or Horvitz-Thompson) estimator of the discrete survival hazard function which is mapped into survival function.
}
\section{Details}{


The regression formalas in \code{Qform}, \code{hform.g0} and \code{hform.gstar} can include any summary measures names defined in
 \code{sW} and \code{sA}, referenced by their individual variable names or by their aggregate summary measure names.
 For example, \code{hform.g0 = "netA ~ netW"} is equivalent to
 \code{hform.g0 = "A + A_netF1 + A_netF2 ~ W + W_netF1 + W_netF2"} for \code{sW,sA} summary measures defined by
 \code{def_sW(netW=W[[0:2]])} and \code{def_sA(netA=A[[0:2]])}.
}

\section{Additional parameters}{


Some of the parameters that control the estimation in \code{stremr} can be set by calling the function \code{\link{set_all_stremr_options}}.

Additional parameters can be also specified as a named list \code{optPars} argument of the \code{stremr} function.
The items that can be specified in \code{optPars} are:
\itemize{

\item \code{alpha} - alpha-level for CI calculation (0.05 for 95% CIs);

\item \code{lbound} - One value for symmetrical bounds on P(sW | sW).

\item \code{family} - Family specification for regression models, defaults to binomial (CURRENTLY ONLY BINOMIAL
 FAMILY IS IMPLEMENTED).
}
}

\section{Specifying the counterfactual intervention function (\code{f_gstar1} and \code{optPars$f_gstar2})}{


The functions \code{f_gstar1} and \code{f_gstar2} can only depend on variables specified by the combined matrix
 of summary measures (\code{sW},\code{sA}), which is passed using the argument \code{data}. The functions should
 return a vector of length \code{nrow(data)} of counterfactual treatments for observations in the input data.
}

\section{IPTW estimator}{

**********************************************************************

\itemize{
\item As described in the following section, the first step is to construct an estimator \eqn{P_{g_N}(A(t) | L(t))}
   for the probability of exposure \eqn{P_{g_0}(A(t) | W(t))}.

\item Based on the user specified stochastic intervention, we can also obtain \eqn{P_{g^*_N}(A^*(t) | L(t) }

\item Combining the two probabilities forms the basis of the IPTW estimator,
   which is evaluated at the observed N data points \eqn{O_i=((L_i(t), A_i(t): t=0,...,K), Y_i), i=1,...,N} and is given by
   \deqn{\psi^{IPTW}_n = \sum_{i=1,...,N}{Y_i \frac{P_{g^*_N}(A^*(t)=A_i(t) | L(t)=L_i(t))}{P_{g_N}(A(t)=A_i(t) | L(t)=L_i(t))}}.}
}
}
\examples{
#-------------------------------------------------------------------
# EXAMPLE WITH CATEGORICAL CENSORING (3 levels)
#-------------------------------------------------------------------
require("data.table")
require("magrittr")
data(OdataCatCENS)
OdataDT <- as.data.table(OdataCatCENS, key=c(ID, t))
# Indicator that the person has never been treated in the past:
OdataDT[, "barTIm1eq0" := as.integer(c(0, cumsum(TI)[-.N]) \%in\% 0), by = ID]
# Define lagged N, first value is always 1 (always monitored at the first time point):
OdataDT[, ("N.tminus1") := shift(get("N"), n = 1L, type = "lag", fill = 1L), by = ID]

#-------------------------------------------------------------------
# Regressions for modeling the exposure (TRT)
#-------------------------------------------------------------------
gform_TRT <- "TI ~ CVD + highA1c + N.tminus1"
# Fit a separate model for TRT (stratify) for each of the following subsets:
stratify_TRT <- list(
  TI=c(
       # MODEL TI AT t=0
       "t == 0L",
       # MODEL TRT INITATION WHEN MONITORED
       "(t > 0L) & (N.tminus1 == 1L) & (barTIm1eq0 == 1L)",
       # MODEL TRT INITATION WHEN NOT MONITORED
       "(t > 0L) & (N.tminus1 == 0L) & (barTIm1eq0 == 1L)",
       # MODEL TRT CONTINUATION (BOTH MONITORED AND NOT MONITORED)
       "(t > 0L) & (barTIm1eq0 == 1L)"
      ))

#-------------------------------------------------------------------
# Regressions for modeling the categorical censoring (CENS)
#-------------------------------------------------------------------
gform_CENS <- c("CatC ~ highA1c")
# stratify by time-points (separate model for all t<16 and t=16)
stratify_CENS <- list(CatC=c("t < 16", "t == 16"))

#-------------------------------------------------------------------
# Regressions for modeling the monitoring regimen (MONITOR)
#-------------------------------------------------------------------
# Intercept only model, pooling across all time points t
gform_MONITOR <- "N ~ 1"

#-------------------------------------------------------------------
# Define the counterfactual monitoring regimen of interest
#-------------------------------------------------------------------
# probability of being monitored at each t is 0.1
OdataDT[, "gstar.N" := 0.1]

# Define two dynamic rules: dlow & dhigh
OdataDT <- defineIntervedTRT(OdataDT, theta = c(0,1), ID = "ID", t = "t", I = "highA1c",
                            CENS = "C", TRT = "TI", MONITOR = "N", tsinceNis1 = "lastNat1",
                            new.TRT.names = c("dlow", "dhigh"), return.allcolumns = TRUE)

# Estimate IPW-based hazard and survival (KM) for a rule "dhigh":
IPW_KM_res <- stremr(OdataDT, intervened_TRT = "dhigh", intervened_MONITOR = "gstar.N",
              ID = "ID", t = "t", covars = c("highA1c", "lastNat1"),
              CENS = "CatC", gform_CENS = gform_CENS, stratify_CENS = stratify_CENS,
              TRT = "TI", gform_TRT = gform_TRT, stratify_TRT = stratify_TRT,
              MONITOR = "N", gform_MONITOR = gform_MONITOR, OUTCOME = "Y.tplus1")

# Survival estimates by time:
IPW_KM_res$IPW_estimates
# Input data:
IPW_KM_res$dataDT
}
\seealso{
\code{\link{stremr-package}} for the general overview of the package,
}

