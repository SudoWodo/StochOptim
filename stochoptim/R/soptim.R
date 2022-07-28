#' @title an R wrapper for stochastic and global optimization tools
#' @description A wrapper of multiple stochastic optimizer. soptim provides a
#' consistent way to call and control the behavior of all the optimizer it
#' includes.
#' @section Methods:
#' The intention is to include a link to the methods-list help(StochOptim-method-list) page
#' which for some reason I am not able to do (don't know why)
#' TODO resolve above problem
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
#' @details
#'
#' Control parameters vary widely from one method to another but some are almost
#' similar between all. Some common control parameters are listed below:-
#'
#' **trace**
#'
#' Non-negative integer. If positive, tracing information on the progress of the
#' optimization is produced. Higher values may produce more tracing information:
#' for method "DEoptim" there are six levels of tracing
#'
#' **maxiter**
#'
#' The maximum number of iterations. The default value differs from method to
#' method. The default value is set to whatever the method developer had intended.
#' See the exact package and method to identify the default value.
#'
#' **popsize**
#'
#' population size
#'
#' **tol**
#'
#' convergence tolerance, The algorithm stops if it is unable to reduce the
#' value by a certain factor. For more details refer to the method and it's
#' implementation in it's original package.
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
#' @export
#'
soptim <- function(par, fn, lower, upper, method, control = list(), ...){

  # Check if function is available
  if(!is.function(fn)){
    stop("passed object is not a valid function !")
  }

  # check if method is available
  method_list <- c("DEoptim", "pso", "GenSA", "DEoptimR", "adagio_simpleDE",
                   "adagio_pureCMAES", "NMOF_DEopt","NMOF_GAopt", "NMOF_PSopt",
                   "nloptr_isres", "nloptr_stogo", "cmaes_cam_es","soma",
                   "ceimOpt", "RcppDE_DEoptim")

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
          ans <- local_wrapper_NMOF_GAopt(par     = par,
                                          fn      = fn,
                                          method  = "NMOF",
                                          control = control,
                                          ...)
        },

        #case 9
        "NMOF_PSopt" = {
          ans <- local_wrapper_NMOF_PSopt(fn      = fn,
                                          lower   = lower,
                                          upper   = upper,
                                          method  = "NMOF",
                                          control = control,
                                          ...
                                          )
        },

        # case 10
        "nloptr_isres" = {
          ans <- local_wrapper_nloptr_isres(par     = par,
                                            fn      = fn,
                                            lower   = lower,
                                            upper   = upper,
                                            method  = "nloptr",
                                            control = control,
                                            ...)
        },

        # case 11
        "nloptr_stogo" = {
          ans <- local_wrapper_nloptr_isres(par     = par,
                                            fn      = fn,
                                            lower   = lower,
                                            upper   = upper,
                                            method  = "nloptr",
                                            control = control,
                                            ...)
        },

        #case 12
        "cmaes_cam_es" = {
          ans <- local_wrapper_cmaes_cam_es(par = par,
                                            fn = fn,
                                            lower = lower,
                                            upper = upper,
                                            method = "cmaes",
                                            control = control,
                                            ...)
        },

        #case 13
        "soma" = {
          ans <- local_wrapper_soma(fn = fn,
                                    lower = lower,
                                    upper = upper,
                                    method = "soma",
                                    control = control,
                                    ...)
        },

        #case 14
        "ceimOpt" = {
          ans <- local_wrapper_ceimOpt(fn = fn,
                                       lower = lower,
                                       upper = upper,
                                       method = "RCEIM",
                                       control = control)
        },

        # case 15
        "Rcpp_DEoptim" = {
          ans <- local_wrapper_RcppDE_DEoptim(fn = fn,
                                              lower = lower,
                                              upper = upper,
                                              method = "RcppDE",
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
