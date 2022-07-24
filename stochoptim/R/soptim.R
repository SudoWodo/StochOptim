#' soptim
#'
#' @param par Vector. Initial values for the components to be optimized.
#' @param fn A function to be minimized, with first argument the vector of
#' parameters over which minimization is to take place
#' @param lower Vector with length of par. Lower bounds for components
#' @param upper Vector with length of par. Upper bounds for components
#' @param method The method to be used
#' @param control The argument is a list that can be used to control the
#' behavior of the algorithm
#' @param ... allows the user to pass additional arguments to the function fn
#'
#' @return A list containing : -
#'
#' par     = the parameter at which lowest value was achieved
#'
#' value   = the lowest value found by the optimizer
#'
#' counts  = number of function calls made
#'
#' time    = time taken to run the optimizer
#'
#' @examples
#'
#' # example using DEoptim
#' fn <- function(x) {x^2}
#' ctrl1 <- list(popsize = 40, maxiter = 10, tol= 1e-3, trace = FALSE)
#' soptim(fn = fn, lower = -1, upper = 1, method = "DEoptim", control = ctrl1)
#'
#' # NMOF_GAopt binary string matching y
#' OF <- function(x, y) sum(x != y)
#' y <- runif(10) > 0.5
#' soptim(10, OF, method = "NMOF_GAopt", y = y)
#' @export
#'
soptim <- function(par, fn, lower, upper, method, control = list(), ...){

  # Check if function is available
  if(!is.function(fn)){
    stop("passed object is not a valid function !")
  }

  # check if method is available
  method_list <- c("DEoptim", "pso", "GenSA", "DEoptimR", "adagio_simpleDE",
                   "adagio_pureCMAES", "NMOF_DEopt","NMOF_GAopt", "NMOF_PSopt")

  ans = NULL
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

        },

        # Case 6
        "adagio_pureCMAES" = {
          ans <- local_wrapper_adagio_pureCMAES (par    = par,
                                                fn      = fn,
                                                lower   = lower,
                                                upper   = upper,
                                                method  = "adagio", # NOTE method
                                                control = control,
                                                ...)
        },

        # Case 7
        "NMOF_DEopt" = {
          ans <- local_wrapper_NMOF_DEopt(fn      = fn,
                                          lower   = lower,
                                          upper   = upper,
                                          method  = "NMOF",
                                          control = control,
                                          ...)
        },

        #case 8
        "NMOF_GAopt" = {
          ans <- local_wrapper_NMOF_DEopt(par     = par,
                                          fn      = fn,
                                          method  = "NMOF",
                                          control = control,
                                          ...)
        },

        #case 9
        "NMOF_PSopt" = {
          ans <- local_wrapper_NMOF_PSopt(fn = fn,
                                          lower = lower,
                                          upper = upper,
                                          method = "NMOF",
                                          control = control,
                                          ...
                                          )
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
