% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dexpectilizeMatR.R
\name{dexpectilizeMatR}
\alias{dexpectilizeMatR}
\title{Dexpectilize a matrix according the a single asymmetric point
\eqn{\tau \in (0, 1)}.}
\usage{
dexpectilizeMatR(ymat, aweight, panSizeVec)
}
\arguments{
\item{ymat}{Numeric matrix to de-expectilize column-wise.}

\item{aweight}{Numeric vector of individual asymmetric weight.}

\item{panSizeVec}{Numeric vector of individual panel size.}
}
\value{
Return a de-expectilized matrix of the matrix ymat.
}
\description{
This function is part of the erfe package. It de-expectilizes
a matrix of data vertor-wise, which means subtracting
the expectile of level \eqn{\tau \in (0, 1)} to every vector of
the matrix column-wise. When \eqn{\tau=0.5} then the process of
de-expectilizing corresponds to the process of deamining
the matrix column-wise. That is, subtracting the mean-column
from the column vector.
}
\examples{
set.seed(13)
temps_obs <- 5
n_subj <- 50
id <- rep(1:n_subj, each=temps_obs) 
asym <- 0.5
panSizeVec <- unname(unlist(lapply(split(id, id), function(x) length(x)))) 
ymat <- matrix(NA, nrow = n_subj * temps_obs, ncol = 5)
ymat <- matrix(mvtnorm::rmvnorm(n_subj * ncol(ymat),
sigma = diag(rep(1, temps_obs))), ncol = ncol(ymat))
aweight <- rep(asym, temps_obs * n_subj)
aweight[!(ymat[, 1] > mean(ymat[, 1]))] = 1 - asym
dexpectilizeMatR(ymat, aweight, panSizeVec)
}
\references{
Barry, Amadou, Oualkacha, Karim, and Charpentier
 Arthur. (2022). \emph{Weighted asymmetric least squares
  regression with fixed-effects}.
 arXiv preprint arXiv:2108.04737
}
\author{
Amadou Barry, \email{barryhafia@gmail.com}
}
