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
#' @examples
#' ###################################################
#'
#' # simple demonstration without any controls
#' fn <- function(x, a = 10) return(sum(x^2) + a)
#' dim <- 10
#' par <- rnorm(dim)
#' lb <- rep(-20,dim)
#' ub <- rep(20, dim)
#' res <- sopm(par = par, fn = fn, lower = lb, upper = ub,
#'            method = c("DEoptim", "DEoptimR", "GenSA",
#'            "pso", "adagio_simpleDE"))
#' res
#' ##################################################
#'
#' # passing control parameters which are common between methods.
#'
#' # here maxiter is common between solvers but since GenSA specifically
#' # defines maxiter for itself it takes precedence. Hence maxiter for DEoptim
#' # will be 100 but for GenSA it will be 50
#'
#' control <- list(maxiter = 100,
#' DEoptim = list(tol = 1e-10), GenSA = list(maxiter = 50))
#' sopm(par = par, fn = fn,lower = lb, upper = ub,
#' method = c("DEoptim","GenSA") ,control = control)
#' ###################################################
#'
#' # Passing control parameter individually to each method
#'
#' fn <- rastrigin <- function(x) {
#' y <- ( 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x)))
#' return(y)
#' }
#'
#' D <- 10
#' lower <- lb <- rep(-5.2, D)
#' upper <- ub <- rep(5.2, D)
#' par <- rep(3.3, D)
#'
#'DEoptim_list = list(
#'popsize = 10*length(lb),
#'maxiter = 200*length(lb),
#'tol  = 1e-10,
#'trace   = 0)
#'
#'adagio_simpleDE_list = list(
#'  popsize  = 70,
#'  nmax     = 230,
#'  r        = 0.41,
#'  confined = TRUE,
#'  trace    = FALSE)
#'
#'GenSA_list  = list(maxiter = 100)
#'pso_list    = list(abstol= 1e-8, hybrid = "improved")
#' DEoptimR_list = list(tol = 1e-7, trace = FALSE)
#'
#'control <- list(
#'  DEoptim = DEoptim_list,
#'  GenSA = GenSA_list,
#'  pso = pso_list,
#'  DEoptimR  = DEoptimR_list,
#'  adagio_simpleDE = adagio_simpleDE_list)
#'
#'sopm(par = par,
#'     fn = fn,
#'     lower = lb,
#'     upper = ub,
#'     method = c("DEoptim", "GenSA","pso","DEoptimR","adagio_simpleDE"),
#'     control= control)
#' @export
#'

sopm <- function(par, fn, lower, upper, method, control = list(), ...) {

  method_list= c("DEoptim", "GenSA","pso","DEoptimR","adagio_simpleDE")
  allowed_common_control <- c("maxiter","popsize")
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

    #cat("Running ", m, "\n")
    ans <- global_wrapper(par     = par,
                          fn      = fn,
                          lower   = lower,
                          upper   = upper,
                          method  = m,
                          control = control[[m]],
                          ...
                          )

    new <- c(method = m, value = ans$value, time = ans$time)
    result <- rbind(result,new)
    colnames(result) <- c("method", "value", "time")
    row.names(result) <- seq(1:nrow(result))
    result['value'] <- as.numeric(result$value)
    result['time'] <- as.numeric(result$time)
    result <- result[order(result$value),]

  }

  return(result)
}
