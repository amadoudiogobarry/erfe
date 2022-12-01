#' Dexpectilize a vector according the a single asymmetric point
#' 
#' This function is the main fucntion of the erfe package. 
#' It estimates the ERFE model for a panel dataset and for
#' a sequence of asymmetric point \eqn{\tau \in (0, 1)}. 
#' When \eqn{\tau=0.5} the function estimate the
#' classical within-transformation
#' estimator and its sandwich covariance matrix.
#' 
#' @return Returns a list of list according to the 
#' asymmetric points. Each list has objects related
#' to the erfe model such as the asymmetric point, 
#' the coefficient-estimate, the standard deviation,
#' the estimated covariance.
#' 
#' 
#' @author Amadou Barry, \email{barryhafia@@gmail.com}
#' 
#' @references Barry, Amadou; Oualkacha, Karim and Charpentier, Arthur. (2022). 
#' \emph{Weighted asymmetric least squares regression with fixed-effects}.
#'  arXiv preprint arXiv:2108.04737.
#' 
#' @param predictors Numeric matrix of covariates/regressors.
#' @param response Numeric vector of response variable.
#' @param asymp Sequence of asymmetric points.
#' @param id Ordered vector of subject ids.
#' 
#' @examples
#' set.seed(13)
#' T_obs <- 5 # panel size
#' n_subj <- 50 # sample size
#' sig <- diag(rep(1,T_obs))
#' id <- rep(1:n_subj, each=T_obs) # subject id
#' rvec <- c(mvtnorm::rmvnorm(n_subj, sigma = sig))
#' fvec <- (1 + rep(rnorm(n_subj) , each=T_obs))
#' predictors <- cbind(rt(n_subj*T_obs, df=2, ncp=1.3), 1.2*fvec +
#' rnorm(n_subj*T_obs, mean = 0.85, sd=1.5) )
#' response <- 0.6*predictors[, 1] + predictors[, 2] + fvec + rvec
#' asymp <- c(0.25,0.5,0.75)
#' erfe(predictors, response, asymp=c(0.25,0.5,0.75), id)
#' 
#' @export
#' @importFrom mvtnorm rmvnorm
#' 
erfe <- function(predictors, response, asymp=c(0.25,0.5,0.75), id) {
  
  
  if (!is.matrix(predictors)){
    warning("predictors has to be a matrix object")
  } else {
    x <- predictors
  }
  
  if (!is.vector(response)){
    warning("response has to be a vector object")
  } else {
    y <- response
  }
  
  if (any(is.na(asymp)) || !is.vector(asymp) || any(asymp > 1) || any(asymp < 0)) {
    asymvec <- c(0.25,0.5,0.75)
  } else {
    asymvec <- asymp
  }
  
  
  lengpan <- unname(unlist(lapply(split(id, id), function(x) length(x))))
  
  if (length(asymvec)==1){
    
    out_erfe_mod <- erfeVecR(predictors, response, lengpan, asymvec, id)
    
    outlist <- c(out_erfe_mod)
    
  } else {
    
    out_erfe_mod <- lapply(seq_along(asymvec), function(i) erfeVecR(predictors, response, lengpan, asymvec[i], id) ) 
    
    outlist <- out_erfe_mod
  }
  

  outlist
  
}
