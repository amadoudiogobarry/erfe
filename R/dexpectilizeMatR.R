#' Dexpectilize a matrix according the a single asymmetric point 
#' \eqn{\tau \in (0, 1)}. 
#' 
#' This function is part of the erfe package. It de-expectilizes 
#' a matrix of data vertor-wise, which means subtracting 
#' the expectile of level \eqn{\tau \in (0, 1)} to every vector of
#' the matrix column-wise. When \eqn{\tau=0.5} then the process of
#' de-expectilizing corresponds to the process of deamining 
#' the matrix column-wise. That is, subtracting the mean-column
#' from the column vector.
#' 
#' @return Return a de-expectilized matrix of the matrix ymat.
#' 
#' @author Amadou Barry, \email{barryhafia@@gmail.com}
#' 
#' @references Barry, Amadou; Oualkacha, Karim and Charpentier, Arthur. (2022). 
#' \emph{Weighted asymmetric least squares regression with fixed-effects}.
#'  arXiv preprint arXiv:2108.04737
#' 
#' @param ymat Numeric matrix to de-expectilize column-wise.
#' @param aweight Numeric vector of individual asymmetric weight.
#' @param panSizeVec Numeric vector of individual panel size.
#' 
#' @examples
#' # set the seed
#' set.seed(13)
#' T_obs <- 5 # panel size
#' n_subj <- 50 # sample size
#' id <- rep(1:n_subj, each=T_obs) # subject id
#' asym <- 0.5 # asymmetric point
#' # panel length vector
#' panSizeVec <- unname(unlist(lapply(split(id, id), function(x) length(x)))) 
#' ymat <- matrix(NA, nrow = n_subj*T_obs, ncol = 5)
#' # matrix of data
#' ymat <- matrix(mvtnorm::rmvnorm(n_subj*ncol(ymat), 
#' sigma = diag(rep(1,T_obs))), ncol = ncol(ymat)) 
#' aweight <- rep(asym, T_obs*n_subj) # individual asymmetric weight
#' aweight[!(ymat[, 1] > mean(ymat[, 1]))] = 1 - asym 
#' dexpectilizeMatR(ymat, aweight, panSizeVec) 
#' 
#' @export
#' @importFrom mvtnorm rmvnorm
#' 
dexpectilizeMatR <- function(ymat, aweight, panSizeVec) {
  
  nsubj <- length(panSizeVec) 
  xnrow <- nrow(ymat)
  xncol <- ncol(ymat)
  
  ydexpectMat <- matrix(NA, nrow = xnrow, ncol =xncol)
  
  for(k in 1:xncol){
    
    a <- 1
    
    b <- panSizeVec[1]
    
    # yvec = ymat[, k] 
    # ydexpect = rep(NA, xnrow)
    
    for (i in 1:nsubj){
      
      irangepanel <- seq(a, b)
      
      mobs <- length(irangepanel)
      
      iypanel <- ymat[a:b, k]
      
      iaweight <- aweight[a:b]
      
      sum_iaweight <- sum(iaweight)
      
      iexpectile <- sum(iypanel*iaweight)/sum_iaweight;
      
      for(j in 1:mobs){
        
        l <- irangepanel[j]
        
        ydexpectMat[l, k] <- ymat[l, k]  - iexpectile;
      }
      
      a <- a + panSizeVec[i]
      b <- b + panSizeVec[i+1]
      
    }
    
    
  }
  
  ydexpectMat
  
}