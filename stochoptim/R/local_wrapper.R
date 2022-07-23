# DEoptim --------------------------------------------------------------------

local_wrapper_DEoptim <- function(fn, lower, upper, method, control = list(), ...){

  # this calls the constructor and new object is formed

  # package installation check

    obj <- DEoptim_wrapper$new(
      fn      = fn,
      lower   = lower,
      upper   = upper,
      method  = method,
      control = control
    )

    if(obj$checkinstallation()) {
      output <- list(
        par     = "",
        value   = "",
        counts  = "",
        time    = ""
      )
      return(output)
    }

    # translate control
    obj$translatecontrol()

    # check controls
    obj$checkcontrol()

    # trace control / translation
    obj$tracetranslation()

    # object calls the optimizer
    ans <- obj$calloptimizer(...)

    # printout the answer in std. format
    res <- obj$printoutput()

    return(res)


}

# pso ------------------------------------------------------------------------

local_wrapper_pso <- function(par, fn, lower, upper, method, control = list(), ...){

  obj<- pso_wrapper$new(
    par     = par,
    fn      = fn,
    lower   = lower,
    upper   = upper,
    method  = method,
    control = control
  )

  # package installation check
  if(obj$checkinstallation()) {
    output <- list(
      par     = "",
      value   = "",
      counts  = "",
      time    = ""
    )
    return(output)
  }

  # translate control
  obj$translatecontrol()

  # check controls
  obj$checkcontrol()

  # trace control / translation
  obj$tracetranslation()

  # object calls the optimizer
  ans <- obj$calloptimizer(...)

  # printout the answer in std. format
  res <- obj$printoutput()

  return(res)
}

# GenSA ---------------------------------------------------------------------

local_wrapper_GenSA <- function(par, fn, lower, upper, method ,control = list(), ...){

  obj<- GenSA_wrapper$new(
    fn      = fn,
    lower   = lower,
    upper   = upper,
    method  = method,
    control = control
  )

  # package installation check
  if(obj$checkinstallation()) {
    output <- list(
      par     = "",
      value   = "",
      counts  = "",
      time    = ""
    )
    return(output)
  }

  # translate control
  obj$translatecontrol()

  obj$tracetranslation()

  # check controls
  obj$checkcontrol()

  # object calls the optimizer
  ans <- obj$calloptimizer(...)

  # printout the answer in std. format
  res <- obj$printoutput()

  return(res)

}

# adagio_simpleDE -----------------------------------------------------------

local_wrapper_adagio_simpleDE <-
  function(fn, lower, upper, method,control = list(), ...) {

    # this calls the constructor and new object is formed
    obj <- adagio_simpleDE_wrapper$new(
      fn      = fn,
      lower   = lower,
      upper   = upper,
      method  = method,
      control = control
    )


    # package installation check
    if(obj$checkinstallation()) {
      output <- list(
        par     = "",
        value   = "",
        counts  = "",
        time    = ""
      )
      return(output)
    }

    # translate control
    obj$translatecontrol()

    # check controls
    obj$checkcontrol()

    # change default control
    obj$changedefaultcontrol()

    obj$tracetranslation()

    # object calls the optimizer
    obj$calloptimizer(...)

    # printout the answer in std. format
    res <- obj$printoutput()


    return(res)

  }

# DEoptimR -------------------------------------------------------------------

local_wrapper_DEoptimR <- function(fn, lower, upper, method ,control = list(), ...) {

  obj <- DEoptimR_wrapper$new(
    fn      = fn,
    lower   = lower,
    upper   = upper,
    method  = method,
    control = control
  )


  # package installation check
  if(obj$checkinstallation()) {
    output <- list(
      par     = "",
      value   = "",
      counts  = "",
      time    = ""
    )
    return(output)
  }

  # translate control
  obj$translatecontrol()

  # check controls
  obj$checkcontrol()

  # set default control
  obj$setdefaultlcontrol()

  # change default control
  obj$changedefaultcontrol()

  # trace translation
  obj$tracetranslation()

  # object calls the optimizer
  obj$calloptimizer(...)

  # printout the answer in std. format
  res <- obj$printoutput()

  return(res)
}

# adagio_pureCMAES -------------------------------------------------------------
local_wrapper_adagio_pureCMAES <- function(par, fn, lower, upper, method ,control = list(), ...) {

  # this calls the constructor and new object is formed
  obj <- adagio_pureCMAES_wrapper$new(
    par     = par,
    fn      = fn,
    lower   = lower,
    upper   = upper,
    method  = method,
    control = control
  )

  # package installation check
  if(obj$checkinstallation()) {
    output <- list(
      par     = "",
      value   = "",
      counts  = "",
      time    = ""
    )
    return(output)
  }

  # translate control
  obj$translatecontrol()

  # check controls
  obj$checkcontrol()

  obj$setdefaultlcontrol()

  # change default control
  obj$changedefaultcontrol()

  # object calls the optimizer
  obj$calloptimizer(...)

  # printout the answer in std. format
  res <- obj$printoutput()

  return(res)
}

# NMOF_DEopt--------------------------------------------------------------------

local_wrapper_NMOF_DEopt <- function(fn, lower, upper, method ,control = list(), ...) {
  obj <- NMOF_DEopt_wrapper$new(
    fn      = fn,
    lower   = lower,
    upper   = upper,
    method  = method,
    control = control
  )

  if(obj$checkinstallation()) {
    output <- list(
      par     = "",
      value   = "",
      counts  = "",
      time    = ""
    )
    return(output)
  }

  obj$translatecontrol()
  obj$checkcontrol()
  obj$setdefaultcontrol()
  obj$changedefaultcontrol()
  #TODO trace translation
  obj$calloptimizer(...)
  res <- obj$printoutput()

  return(res)
}
