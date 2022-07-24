nloptr_isres_wrapper <- R6Class(
  classname = "nloptr_isres_wrapper",
  inherit = optimizer_wrapper,
  public = list (
    default_control = NULL,
    vcontrol = c("hin",
                 "heq",
                 "maxeval",
                 "pop.size",
                 "xtol_rel",
                 "nl.info"),

    setdefaultcontrol = function() {
      self$default_control = list(
        hin       = NULL,
        heq       = NULL,
        maxeval   = 10000,
        pop.size  = 20* (length(self$par) + 1),
        xtrol_rel = 1e-06,
        nl.info   = FALSE
      )
    },

    calloptimizer = function() {
      cat("Running -> nloptr::isres \n")
      startTime = Sys.time()
      self$ans = nloptr::isres(
        x0       = self$par,
        fn       = self$fn,
        lower    = self$lower,
        upper    = self$upper,
        hin      = self$control$hin,
        heq      = self$control$heq,
        maxeval  = self$control$maxeval,
        pop.size = self$control$pop.size,
        xtol_rel = self$control$xtol_rel,
        nl.info  = self$control$nl.inf
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
  ) # end public list
) # end nloptr_isres_wrapper
