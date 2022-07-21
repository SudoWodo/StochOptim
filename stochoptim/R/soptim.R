# Global-wrapper (are we calling this soptim ?)

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
#' @return ans The object returned by the optimizer
#'
#' @examples
#'
#' # example using DEoptim
#' fn <- function(x) {x^2}
#' ctrl1 <- list(popsize = 40, maxiter = 10, tol= 1e-3, trace = FALSE)
#' soptim(fn = fn, lower = -1, upper = 1, method = "DEoptim", control = ctrl1)
#'
#' @export
#'
soptim <- function(par, fn, lower, upper, method, control = list(), ...){

  # Check if function is available
  if(!is.function(fn)){
    stop("passed object is not a valid function !")
  }

  # check if method is available
  method_list <- c("DEoptim", "pso", "GenSA", "DEoptimR", "adagio_simpleDE")


  if(!is.null(method)){

    if(method %in% method_list){
      switch (
        method,

        # Case 1 DEoptim
        "DEoptim" = {
          ans <- local_wrapper_DEoptim(fn      = fn,
                                       lower   = lower,
                                       upper   = upper,
                                       method  = method,
                                       control = control,
                                       ...)
        },

        # Case 2 pso
        "pso" = {
          ans <- local_wrapper_pso(par     = par,
                                   fn      = fn,
                                   lower   = lower,
                                   upper   = upper,
                                   method  = method,
                                   control = control,
                                   ...)
        },

        # Case 3 GenSA
        "GenSA" = {
          ans <- local_wrapper_GenSA(par     = par,
                                     fn      = fn,
                                     lower   = lower,
                                     upper   = upper,
                                     method  = method,
                                     control = control,
                                     ...)
        },

        # Case 4 DEoptimR
        "DEoptimR" = {
          ans <- local_wrapper_DEoptimR(fn      = fn,
                                        lower   = lower,
                                        upper   = upper,
                                        method  = method,
                                        control = control,
                                        ...)
        },

        # Case 5
        "adagio_simpleDE" = {
          ans <- local_wrapper_adagio_simpleDE(fn      = fn,
                                               lower   = lower,
                                               upper   = upper,
                                               method  = "adagio", # NOTE method
                                               control = control,
                                               ...)

        }
      ) # end switch

    } else{
      stop("method not found !")
    }  # end if-else method_list check

  } else{
    stop("method cannot be NULL !")
  } # end if-else method null check

  return(ans)
}
