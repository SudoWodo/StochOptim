# adagio_simpleDE--------------------------------------------------



adagio_simpleDE_wrapper <- R6Class(

  classname = "adagio_simpleDE_wrapper",
  inherit = optimizer_wrapper,
  public = list(

    vcontrol = c(popsize = "N", "nmax", "r", "confined", trace = "log"),

    # set default control
    default_control = list(N        = 64,
                           nmax     = 256,
                           r        = 0.4,
                           confined = TRUE,
                           log      = FALSE),

    # call the optimizer
    calloptimizer = function() {
      self$ans <- adagio::simpleDE(fun      = self$fn,
                                   lower    = self$lower,
                                   upper    = self$upper,
                                   N        = self$control$N,
                                   nmax     = self$control$nmax,
                                   r        = self$control$r,
                                   confined = self$control$confined,
                                   log      = self$control$log)

      return(self$ans)
    },

    # for nicely printing out the answer
    printoutput = function() {
      output <- list(
        par     = self$ans$xmin,
        value   = self$ans$fmin,
        counts  = c(`function` = self$ans$nfeval)
      )

      print(output)
    }

  ) # end public list
) # end adagio_simpleDE_wrapper class
