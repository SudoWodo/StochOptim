# DEoptim --------------------------------------------------------------------

local_wrapper_DEoptim <- function(fn, lower, upper, method, print = TRUE, control = list()){

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

  # translate control
  obj$translatecontrol()

  # check controls
  obj$checkcontrol()

  # trace control / translation
  obj$tracetranslation()

  # object calls the optimizer
  ans <- obj$calloptimizer()

  # printout the answer in std. format
  res <- obj$printoutput(print)

  if(print) {
      return (ans)
  } else{
      return(res)
  }

}

# pso ------------------------------------------------------------------------

local_wrapper_pso <- function(par, fn, lower, upper, method, print = TRUE, control = list()){

  obj<- pso_wrapper$new(
    par     = par,
    fn      = fn,
    lower   = lower,
    upper   = upper,
    method  = method,
    control = control
  )

  # package installation check
  obj$checkinstallation

  # translate control
  obj$translatecontrol()

  # check controls
  obj$checkcontrol()

  # object calls the optimizer
  ans <- obj$calloptimizer()

  # printout the answer in std. format
  res <- obj$printoutput(print)

  if(print) {
    return (ans)
  } else{
    return(res)
  }
}

# GenSA ---------------------------------------------------------------------

local_wrapper_GenSA <- function(par, fn, lower, upper, method, print = TRUE ,control = list()){

  obj<- GenSA_wrapper$new(
    fn      = fn,
    lower   = lower,
    upper   = upper,
    method  = method,
    control = control
  )

  # package installation check
  obj$checkinstallation()

  # translate control
  obj$translatecontrol()

  # check controls
  obj$checkcontrol()

  # object calls the optimizer
  ans <- obj$calloptimizer()

  # printout the answer in std. format
  res <- obj$printoutput(print)

  if(print) {
    return (ans)
  } else{
    return(res)
  }
}

# adagio_simpleDE -----------------------------------------------------------

local_wrapper_adagio_simpleDE <-
  function(fn, lower, upper, method, print = TRUE ,control = list()) {

    # this calls the constructor and new object is formed
    obj <- adagio_simpleDE_wrapper$new(
      fn      = fn,
      lower   = lower,
      upper   = upper,
      method  = method,
      control = control
    )


    # package installation check
    obj$checkinstallation()

    # translate control
    obj$translatecontrol()

    # check controls
    obj$checkcontrol()

    # change default control
    obj$changedefaultcontrol()

    # object calls the optimizer
    ans <- obj$calloptimizer()

    # printout the answer in std. format
    res <- obj$printoutput(print)

    if(print) {
      return (ans)
    } else{
      return(res)
    }
  }

# DEoptimR -------------------------------------------------------------------

local_wrapper_DEoptimR <- function(fn, lower, upper, method,print = TRUE ,control = list()) {

  obj <- DEoptimR_wrapper$new(
    fn      = fn,
    lower   = lower,
    upper   = upper,
    method  = method,
    control = control
  )


  # package installation check
  obj$checkinstallation()

  # translate control
  obj$translatecontrol()

  # check controls
  obj$checkcontrol()

  # set default control
  obj$setdefaultlcontrol()

  # change default control
  obj$changedefaultcontrol()

  # object calls the optimizer
  ans <- obj$calloptimizer()

  # printout the answer in std. format
  res <- obj$printoutput(print)

  if(print) {
    return (ans)
  } else{
    return(res)
  }
}

# ecr -------------------------------------------------------------------------

local_wrapper_ecr = function(fn, lower, upper, method, print = TRUE ,control = list()) {
  obj <- ecr_wrapper$new(
    fn      = fn,
    lower   = lower,
    upper   = upper,
    method  = method,
    control = control
  )

  # package installation check
  obj$checkinstallation()

  # translate control
  obj$translatecontrol()

  # check controls
  obj$checkcontrol()

  # set default control
  obj$setdefaultlcontrol()

  # change default control
  obj$changedefaultcontrol()

  # object calls the optimizer
  ans <- obj$calloptimizer()

  # printout the answer in std. format
  res <- obj$printoutput(print)

  if(print) {
    return (ans)
  } else{
    return(res)
  }
}
