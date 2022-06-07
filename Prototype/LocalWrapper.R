localwrapperDEoptim <- function(fn, lower, upper, method, control = list()){
  
  # this calls the constructor and new object is formed
  obj <- DEoptim_Wrapper$new(
    fn      = fn, 
    lower   = lower, 
    upper   = upper,
    method  = method,
    control = control
  )
  
  # package installation check
  obj$checkinstallation()
  
  # object calls the optimizer
  ans <- obj$callOptimizer()
  
  return(ans)
}


localwrapperpso <- function(par, fn, lower, upper, method, control = list()){

  obj<- pso_Wrapper$new(
    par     = par, 
    fn      = fn, 
    lower   = lower, 
    upper   = upper,
    method  = method,
    control = control
  )
  
  # package installation check
  obj$checkinstallation()
  
  # object calls the optimizer
  ans <- obj$callOptimizer()
  
  return(ans)
}


localwrapperGenSA <- function(par, fn, lower, upper, method, control = list()){
  
  obj<- GenSA_Wrapper$new(
    fn      = fn, 
    lower   = lower, 
    upper   = upper,
    method  = method,
    control = control
  )
  
  # package installation check
  obj$checkinstallation()
  
  # object calls the optimizer
  ans <- obj$callOptimizer()
  
  return(ans)
}


# localwrapperGenSA(fn = fn ,lower = lower, upper = upper, method = "GenSA" )
# localwrapperDEoptim(fn = fn, lower = lower, upper = upper, method = "DEoptim")
