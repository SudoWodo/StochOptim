#' Calls multiple optimizers
#'
#' @param par Vector. Initial values for the components to be optimized.
#' @param fn A function to be minimized, with first argument the vector of parameters over which minimization is to take place
#' @param lower Vector with length of par. Lower bounds for components
#' @param upper Vector with length of par. Upper bounds for components
#' @param method The method to be used
#' @param control The argument is a list that can be used to control the behavior of the algorithm
#' @param ... allows the user to pass additional arguments to the function fn
#'
#' @return A dataframe containing values returned by optimizer.
#'
#' @export
#'

sopm <- function(par, fn, lower, upper, method, control = list(), ...) {

  method_list= c("DEoptim", "GenSA","pso","DEoptimR","adagio_simpleDE")
  allowed_common_control <- c("maxiter")
  passed_common_control <- which(sapply(control, is.list) == FALSE)

  ## ask for mentor's comment (keeping it rigid for now)
  # Common control check
  common_control_check<- names(control[passed_common_control]) %in% allowed_common_control
  if(!all(common_control_check)){
    stopmsg <- paste("passed control are not common between solvers !")
    stop(stopmsg)
  }

  # Method check
  for(m in method){
    if(m %in% method_list){
    } else {
      stopmsg <- paste("Method", m,"not found !")
      stop(stopmsg, call. = FALSE)
    }
  }

  # adding common controls to each solvers
  list <- which(sapply(control, is.list) == TRUE)
  items <- control[-list] # items which are not list

  # appending common controls to optimizer controls
  for( l in list) {
    for(n in names(items)){
      if(!(n %in% names(control[[l]]))){
        control[[l]][n] <- items[n]
      }
    }
  }

  # removing common controls from method
  control[-list] <- NULL

  # final data frame
  result <- data.frame(method = character(), value = numeric(), time = numeric())

  for( m in method) {

    ans <- global_wrapper(par     = par,
                          fn      = fn,
                          lower   = lower,
                          upper   = upper,
                          method  = m,
                          print   = FALSE,
                          control = control[[m]],
                          ...
                          )

    new <- c(method = m, value = ans$value, time = ans$time)
    result <- rbind(result,new)
    colnames(result) <- c("method", "value", "time")
    row.names(result) <- seq(1:nrow(result))
    result['value'] <- as.numeric(result$value)
    result['time'] <- as.numeric(result$time)

  }

  return(result)
}
