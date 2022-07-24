nloptr_stogo_wrapper <- R6Class(
  classname = "nloptr_stogo_wrapper",
  inherit = optimizer_wrapper,
  public = list(
    default_control = NULL,
    vcontrol = c(maxiter = "maxeval",
                 tol = "xtol_rel",
                 "nl.info",
                 "randomized"),

    setdefaultcontrol = function() {
      self$default_control = list(
        gr        = NULL,
        maxeval   = 10000,
        xtrol_rel = 1e-06,
        randomized = FALSE,
        nl.info   = FALSE
      )
    },

    calloptimizer = function(...) {
      cat("Running -> nloptr::stogo \n")
      startTime = Sys.time()
      self$ans = nloptr::stogo(
        x0       = self$par,
        fn       = self$fn,
        gr       = self$control$gr,
        lower    = self$lower,
        upper    = self$upper,
        maxeval  = self$control$maxeval,
        xtol_rel = self$control$xtol_rel,
        nl.info  = self$control$nl.inf,
        ...
      )
      endTime = Sys.time()
      self$ans$time = startTime - endTime
    },

    printoutput = function() {
      output <- list(
        par     = self$ans$par,
        value   = self$ans$value,
        counts  = self$ans$iter,
        convergence = self$ans$convergence,
        message = self$ans$message,
        time    = self$ans$time)
      return(output)
    }

  ) #end public list
) # end nloptr_stogo_wrapper
