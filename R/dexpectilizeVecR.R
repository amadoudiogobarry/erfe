#' Dexpectilize a vector according the a single asymmetric 
#' point \eqn{\tau\in (0, 1)}. 
#' 
#'
#' This function is part of the erfe package. It de-expectilizes
#' a vector of data, which means subtracting the expectile 
#' of level \eqn{\tau\in (0, 1)} of the vector to the vector itself.
#' When \eqn{\tau=0.5} then the process of de-expectilizing 
#' corresponds to the process of deamining the vector. That is, 
#' subtracting the mean of the vector from the vector itself.
#' 
#' @return Return a de-expectilized vector of the vector yvec.
#' 
#' @author Amadou Barry, \email{barryhafia@@gmail.com}
#' 
#' @references Barry, Amadou; Oualkacha, Karim and Charpentier, Arthur. (2022). 
#' \emph{Weighted asymmetric least squares regression with fixed-effects}.
#' arXiv preprint arXiv:2108.04737.
#' 
#' @param yvec Numeric vector to de-expectilize.
#' @param aweight Numeric vector of individual asymmetric weight.
#' @param panSizeVec Numeric vector of individual panel size.
#' 
#' 
#' @examples
#' # set the seed
#' set.seed(13)
#' T_obs <- 5 # panel size
#' n_subj <- 50 # sample size
#' id <- rep(1:n_subj, each=T_obs) # subject id
#' asym <- 0.5 # asymmetric point
#' # panel length vector
#' panSizeVec <- unname(unlist(lapply(split(id, id), 
#' function(x) length(x)))) 
#' # vector of data
#' yvec <- c(mvtnorm::rmvnorm(n_subj, sigma = diag(rep(1,T_obs))))
#' # individual asymmetric weight
#' aweight <- rep(asym, T_obs*n_subj)
#' aweight[!(yvec > mean(yvec))] = 1 - asym 
#' # de-expectilize yvec
#' dexpectilizeVecR(yvec, aweight, panSizeVec) 
#' 
#' @export
#' @importFrom mvtnorm rmvnorm
#' 
dexpectilizeVecR <- function(yvec, aweight, panSizeVec){
  
  
  nsubj <- length(panSizeVec)
  a <- 1
  b <- panSizeVec[1] 
  ydexpect <- 0 * yvec 
  
  for (i in 1:nsubj){
    
    irangepanel <- seq(a, b)
    mobs <- length(irangepanel)
    
    iypanel <- yvec[a:b] 
    iaweight <- aweight[a:b]
    sum_iaweight <- sum(iaweight)
    iexpectile <- sum(iypanel*iaweight)/sum_iaweight
    
    for(j in 1:mobs){
      
      k <- irangepanel[j]
      
      ydexpect[k] <- yvec[k] - iexpectile
    }
    
    a <- a + panSizeVec[i]
    b <- b + panSizeVec[i+1]
    
  }
  
  ydexpect
  
  
}
