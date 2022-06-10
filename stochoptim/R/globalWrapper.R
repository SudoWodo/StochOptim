# Global-wrapper (are we calling this soptim ?)

#' Title
#'
#' @param par Vector. Initial values for the components to be optimized.
#' @param fn A function to be minimized, with first argument the vector of parameters over which minimization is to take place
#' @param lower Vector with length of par. Lower bounds for components
#' @param upper Vector with length of par. Upper bounds for components
#' @param method The method to be used
#' @param control The argument is a list that can be used to control the behavior of the algorithm
#' @param ... Vector with length of par. Upper bounds for components
#'
#' @return ans The object returned by the optimizer
#'
#' @export
#'
#' @examples
globalWrapper <- function(par, fn, lower, upper, method, control = list(),...){

  # Check if function is available
  if(!is.function(fn)){
    stop("passed object is not a valid function !")
  }

  # check if method is available
  method_list <- c("DEoptim", "pso", "GenSA")


  if(!is.null(method)){

    if(method %in% method_list){
      switch (
        method,

        # Case 1 DEoptim
        "DEoptim" = {
          ans <- localWrapperDEoptim(fn      = fn,
                                     lower   = lower,
                                     upper   = upper,
                                     method  = method,
                                     control = control)
        },

        # Case 2 pso
        "pso" = {
          ans <- localWrapperpso(par     = par,
                                 fn      = fn,
                                 lower   = lower,
                                 upper   = upper,
                                 method  = method,
                                 control = control)
        },

        # Case 3 GenSA
        "GenSA" = {
          ans <- localWrapperGenSA(par     = par,
                                   fn      = fn,
                                   lower   = lower,
                                   upper   = upper,
                                   method  = method,
                                   control = control)
        }

      ) # end switch

    } else{
      stop("method not found !")
    }  # end if-else method_list check

  } else{
    stop("please choose a valid method !")
  } # end if-else method null check

  return(ans)
}
