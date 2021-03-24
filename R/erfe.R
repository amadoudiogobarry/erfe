

erfe = function(predictors, response, nsample=5, asymp=c(0.25,0.5,0.75), id) {
  
  
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
  
  
  lengpan = unname(unlist(lapply(split(id, id), function(x) length(x))))
  
  if (length(asymvec)==1){
    
    estimateb = erfeRcppVec(predictors, response, lengpan, asymvec)
    
    out = c(estimateb)
    
  } else {
    
    estimateb = erfeRcppMat(predictors, response, lengpan, asymvec)
    
    out = estimateb
  }
  

  out
  
}
