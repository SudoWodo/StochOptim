LocalWrapperDEoptim <- function(fn, lower, upper, method, control = list()){
  
  # this calls the constructor and new object is formed
  obj <- DEoptimWrapper$new(
    fn      = fn, 
    lower   = lower, 
    upper   = upper,
    method  = method,
    control = control
  )
  
  # package installation check
  obj$checkinstallation()
  
  # check controls
  obj$checkcontrol()
  
  # object calls the optimizer
  ans <- obj$callOptimizer()
  
  # printout the answer in std. format
  obj$printoutput()
  
  return(ans)
}


LocalWrapperpso <- function(par, fn, lower, upper, method, control = list()){

  obj<- psoWrapper$new(
    par     = par, 
    fn      = fn, 
    lower   = lower, 
    upper   = upper,
    method  = method,
    control = control
  )
  
  # package installation check
  obj$checkinstallation()
  
  # check controls
  obj$checkcontrol()
  
  # object calls the optimizer
  ans <- obj$callOptimizer()
  
  # printout the answer in std. format
  obj$printoutput()
  
  return(ans)
}


LocalWrapperGenSA <- function(par, fn, lower, upper, method, control = list()){
  
  obj<- GenSAWrapper$new(
    fn      = fn, 
    lower   = lower, 
    upper   = upper,
    method  = method,
    control = control
  )
  
  # package installation check
  obj$checkinstallation()
  
  # check controls
  obj$checkcontrol()
  
  # object calls the optimizer
  ans <- obj$callOptimizer()
  
  # printout the answer in std. format
  obj$printoutput()
  
  return(ans)
}
