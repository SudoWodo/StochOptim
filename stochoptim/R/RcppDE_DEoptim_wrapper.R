RcppDE_DEoptim_wrapper <- R6Class(
  classname = "RcppDE_DEoptim_wrapper",
  inherit = optimizer_wrapper,
  public = list(
    default_control = NULL,
    control = list(),
    vcontrol = c(tol       = "reltol",
                 popsize   = "NP",
                 maxiter   = "itermax",
                 trace     = "trace",
                 "VTR",
                 "strategy",
                 "bs",
                 "CR",
                 "F",
                 "initialpop",
                 "storepopfrom",
                 "storepopfreq",
                 "p",
                 "c",
                 "reltol",
                 "steptol"),

    setdefaultcontrol = function(){
      self$default_control <- list(
        trace = FALSE
      )
    },

    calloptimizer = function(...) {
      cat("Running -> RcppDE::DEoptim \n")
      startTime <- Sys.time()
      self$ans <- RcppDE::DEoptim(
        fn      = self$fn,
        lower   = self$lower,
        upper   = self$upper,
        control = self$control,
        ...)
      endTime <- Sys.time()
      self$ans$time <- endTime - startTime
      return(self$ans)
    },

    printoutput = function() {
      output <- list(
        par     = self$ans$optim$bestmem,
        value   = self$ans$optim$bestval,
        counts  = c(`function` = self$ans$optim$nfeval),
        time    = self$ans$time)
      return(output)
    }
  ) # end public list
) # end class

