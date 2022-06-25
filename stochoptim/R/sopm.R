#' Title
#'
#' @param par Vector. Initial values for the components to be optimized.
#' @param fn A function to be minimized, with first argument the vector of parameters over which minimization is to take place
#' @param lower Vector with length of par. Lower bounds for components
#' @param upper Vector with length of par. Upper bounds for components
#' @param method The method to be used
#' @param control The argument is a list that can be used to control the behavior of the algorithm
#' @param ... allows the user to pass additional arguments to the function fn
#'
#' @return A tibble containing information
#'
#' @export
#'

sopm <- function(par, fn, lower, upper, method = c("DEoptim", "GenSA"), control = list(), ...) {

  for( m in names(control)) {


    # Method check
    if(!(m %in% method)){
      stopmsg <- paste("Method not found !")
      stop(stopmsg)
    }

    # Default trace
    trace <- 0


    ans <- global_wrapper(par    = par,
                          fn     = fn,
                          lower  = lower,
                          upper  = upper,
                          method = m,
                          control = control[[m]]
                          )

    return(ans)
  }
}
