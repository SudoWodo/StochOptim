localWrapperDEoptim <- function(fn, lower, upper, method, control = list()){

  # this calls the constructor and new object is formed
  obj <- DEoptim_wrapper$new(
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
  ans <- obj$calloptimizer()

  # printout the answer in std. format
  obj$printoutput()

  return(ans)
}


localWrapperpso <- function(par, fn, lower, upper, method, control = list()){

  obj<- pso_wrapper$new(
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
  ans <- obj$calloptimizer()

  # printout the answer in std. format
  obj$printoutput()

  return(ans)
}


localWrapperGenSA <- function(par, fn, lower, upper, method, control = list()){

  obj<- GenSA_wrapper$new(
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
  ans <- obj$calloptimizer()

  # printout the answer in std. format
  obj$printoutput()

  return(ans)
}
