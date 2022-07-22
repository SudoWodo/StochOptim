

adagio_pureCMAES_wrapper <- R6Class(

  classname = "adagio_pureCMAES_wrapper",
  inherit = optimizer_wrapper,
  public = list(

    default_control = NULL,
    vcontrol = c(maxiter = "stopeval", "sigma", "stopfitness"),

    # set default control
    setdefaultlcontrol = function() {
      d <- length(self$par)^2
      default_control = list(stopeval    = 1000*d,
                             sigma       = 0.5,
                             stopfitness = -Inf)
      self$control <- default_control
    },

    # call the optimizer
    calloptimizer = function(...) {
      cat("Running -> adagio::pureCMAES \n")
      startTime <- Sys.time()
      self$ans <- adagio::pureCMAES(par = self$par,
                                    fun      = self$fn,
                                    lower    = self$lower,
                                    upper    = self$upper,
                                    stopeval = self$control$stopeval,
                                    sigma    = self$control$sigma,
                                    stopfitness = self$control$stopfitness,
                                    ...)
      endTime <- Sys.time()
      self$ans$time <- endTime - startTime
      return(self$ans)
    },

    # for nicely printing out the answer
    printoutput = function() {
      output <- list(
        par     = self$ans$xmin,
        value   = self$ans$fmin,
        time    = self$ans$time
      )

      return(output)
    }

  ) # end public list
) # end adagio_pureCMAES_wrapper class
