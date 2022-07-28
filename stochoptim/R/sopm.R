#'
#' @title sopm
#' @description sopm function runs multiple stochastic optimizer with one call.
#' This is very similar to how optim::opm() works. Under the hood sopm calls
#' soptim() which does all the work. The function is helpful while
#' comparing the performance of multiple methods applied to a single objective
#' function.
#'
#' @param par Vector. Initial values for the components to be optimized.
#' @param fn A function to be minimized, with first argument the vector of
#' parameters over which minimization is to take place
#' @param lower Vector with length of par. Lower bounds for components
#' @param upper Vector with length of par. Upper bounds for components
#' @param method The method to be used
#' @param control The argument is a list that can be used to control the
#' behavior of the algorithm
#' @param excl removes method from ALL method
#' @param ... allows the user to pass additional arguments to the function "fn"
#'
#' @details Note that arguments after ... must be matched exactly to that of
#' objective function.
#'
#' sopm can control the behavior of multiple optimizers with control list.
#' The control list contains global controls which are understood by almost all
#' the methods and local control. The local control list is nested inside the
#' global control list. The name of local control list determines behavior of
#' which method is changed. see EXAMPLE B and F for more clarity.
#'
#' The global controls are popsize and maxiter. See example C
#'
#' The local control list must only contain the controls understood by the
#' method else it will be ignored with a message and default will be used.
#'
#' In case where same parameters is used in both local and global. The local
#' control will be given more priority.
#'
#' If no controls are passed the default controls are used. The default controls
#' are specifed in the package from where the method originates. In EXAMPLE A
#' methods run with default controls.
#'
#' Parameters which are common between all the optimizer can be passed in the
#' global control list. see EXAMPLE C
#'
#' sopm also supports running multiple strategies of single optimizer
#' see EXAMPLE D where DEoptim uses strategies c(2,3)
#'
#' To execute all the methods use method = "ALL". See EXAMPLE E
#'
#' @section Some common controls accepted by local controls lists
#'
#' NOTE : THERE ARE COMMON CONTROL PARAMETERS AND NOT GLOBAL
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
#' For complete list of parameters kindly refer to the optimizer's documentation.
#'
#' @returns par -  parameters for which the minimum values if obtained.
#' @returns value - the minimum value found
#' @returns counts - number function call
#' @returns message - message from the optimizer
#' @returns convergence -  usually a code describing the convergence
#' @examples
#' ###################################################
#' # EXAMPLE A
#' ###################################################
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
#' ###################################################
#' # EXAMPLE B
#' ###################################################
#'
#' # passing control parameters
#'
#' control <- list(DEoptim = list(tol = 1e-10, maxiter = 100),
#' GenSA = list(maxiter = 50, maxiter = 100))
#' sopm(par = par, fn = fn,lower = lb, upper = ub,
#' method = c("DEoptim","GenSA") ,control = control)
#'
#' ##################################################
#' # EXAMPLE C
#' ###################################################
#'
#' # passing control parameters which are common between methods.
#'
#' # here maxiter is common between solvers but since GenSA specifically
#' # defines maxiter for itself it takes precedence.
#' # Hence maxiter for DEoptim
#' # will be 100 but for GenSA it will be 50
#'
#' control <- list(maxiter = 100,
#' DEoptim = list(tol = 1e-10), GenSA = list(maxiter = 50))
#' sopm(par = par, fn = fn,lower = lb, upper = ub,
#' method = c("DEoptim","GenSA") ,control = control)
#'
#' ###################################################
#' # EXAMPLE D
#' ###################################################
#' # Running multiple strategy
#'
#' method <- c("DEoptim", "DEoptimR")
#' control <- list(popsize = 100, maxiter = 50,
#'                DEoptim = list(tol = 1e-10, strategy = c(2,3)),
#'                DEoptimR = list(maxiter = 1000))
#'
#' res <- sopm(par, fn, lb, ub, method = method, control = control)
#' print(res)
#' ###################################################
#' # EXAMPLE E
#' ##################################################
#' # how to exclude method from method = "ALL"
#' fn <- function(x, a = 10) return(sum(x^2) + a)
#' dim <- 10
#' par <- rnorm(dim)
#' lb <- rep(-20,dim)
#' ub <- rep(20, dim)
#' res <- sopm(par = par, fn = fn, lower = lb, upper = ub,
#' method = "ALL", excl = c("DEoptimR"))
#'
#' ###################################################
#' # EXAMPLE F
#' ###################################################
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

sopm <- function(par, fn, lower, upper, method, control = list(), excl = NULL ,...) {

  method_list <- c("DEoptim", "GenSA","pso","DEoptimR","adagio_simpleDE",
                   "adagio_pureCMAES", "NMOF_DEopt","NMOF_GAopt", "NMOF_PSopt",
                   "nloptr_isres", "nloptr_stogo", "cmaes_cam_es")

  allowed_common_control <- c("maxiter","popsize")
  strategy <- FALSE
  strategy_method <- c()
  passed_common_control <- which(sapply(control, is.list) == FALSE)

  if(length(method) == 1 && method == "ALL"){
    method = method_list
  }

  if(! is.null(excl)) {
    to_remove<- sapply(excl,function(x) {which(x == method)})
    method <- method[- to_remove]
  }

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
    #l <- list[1]
    #cat("l: ",l,"\n")
    for(n in names(items)){
      if(!(n %in% names(control[[l]]))){
        control[[l]][n] <- items[n]
      }
    }
    for (n in names(control[[l]])) {
      #n <- names(control[[l]])[2]
      #cat("n: ",n, "\n")
      if(n == "strategy") {
        #strategy_method <- names(l)
        strategy_method <- append(strategy_method, names(control[l]))
        strategy = TRUE
      }
    }
  }


  if(strategy){
    #l <- list[1]
    for(strat in  strategy_method){
      #strat <- strategy_method[1]
      strat_name <- control[[strat]]$strategy
      new_names<- paste(strategy_method,"_strat_",strat_name , sep = "")
      method <- append(method, new_names)
      for(name in new_names){
        #name <- new_names[1]
        strat_no <- which(name == new_names)
        #cat("strat_no: ",strat_no,"\n")
        control[name] <- control[strat]
        #cat("control: ",control[[strat]]$strategy[strat_no],"\n")
        control[[name]]$strategy <- NULL
        control[[name]]$strategy <- control[[strat]]$strategy[strat_no]
      }
      index <- which(strat == method)
      #cat("index: ",index, "\n")
      #cat("method: ",method[index],"\n")
      method <- method[-index]
    }
  }


  # removing common controls from method
  control[-list] <- NULL

  # final data frame
  result <- data.frame(method = character(), value = numeric(), time = numeric())

  for( m in method) {
    meth <- gsub('_strat_[0-9]','',m)
    #print(control[[m]])

    #cat("Running ", m, "\n")
    ans <- soptim(par     = par,
                          fn      = fn,
                          lower   = lower,
                          upper   = upper,
                          method  = meth,
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
