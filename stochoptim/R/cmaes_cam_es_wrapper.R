cmaes_cam_es_wrapper <- R6Class(
  classname = "cmaes_cam_es_wrapper",
  inherit = optimizer_wrapper,
  public = list(
    vcontrol = c("fnscale",
                 maxit = "maxit",
                 "stopfitness",
                 "keep.best",
                 "sigma",
                 popsize = "mu",
                 "lambda",
                 "weights",
                 "damps",
                 "cs",
                 "ccum",
                 "vectorized",
                 "ccov.1",
                 "ccov.mu",
                 "diag.sigma",
                 "diag.eigen",
                 "diag.pop",
                 "diag.value"),

    calloptimizer = function(...) {
      cat("Running -> cmaes::cma_es \n")
      startTime <- Sys.time()
      self$ans <- cmaes::cma_es(par    = self$par,
                               fn      = self$fn,
                               ...              ,
                               lower   = self$lower,
                               upper   = self$upper,
                               control = self$control)
      endTime <- Sys.time()
      self$ans$time <- endTime - startTime
      return(self$ans)
    },

    printoutput = function() {
      output <- list(
        par     = self$ans$par,
        value   = self$ans$Ovalue,
        counts = self$ans$counts['function'],
        convergence = self$ans$convergence,
        time    = self$ans$time
      )
      return(output)
    }
  ) # end public list
) # end cmaes_cam_es_wrapper
