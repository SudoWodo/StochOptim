# adagio_simpleDE--------------------------------------------------



adagio_simpleDE_wrapper <- R6Class(

  classname = "adagio_simpleDE_wrapper",
  inherit = optimizer_wrapper,
  public = list(

    vcontrol = c(popsize = "N", "nmax", "r", "confined", trace = "log"),
    printtrace = FALSE,

    # set default control
    default_control = list(N        = 64,
                           nmax     = 256,
                           r        = 0.4,
                           confined = TRUE,
                           log      = FALSE),

    tracetranslation = function() {
      if("trace" %in% names(self$control)) {
        if(self$control$trace == 0){
          self$control$trace = FALSE
          self$control$printtrace = FALSE
        } else if (self$control$trace == 1){
          self$control$trace = FALSE
          self$control$printtrace = TRUE
        } else {
          self$control$trace = TRUE
          self$control$printtrace = TRUE
        }
      }
    },

    # call the optimizer
    calloptimizer = function(...) {
      cat("Running -> adagio::simpleDE \n")
      startTime <- Sys.time()
      self$ans <- adagio::simpleDE(fun      = self$fn,
                                   lower    = self$lower,
                                   upper    = self$upper,
                                   N        = self$control$N,
                                   nmax     = self$control$nmax,
                                   r        = self$control$r,
                                   confined = self$control$confined,
                                   log      = self$control$log,
                                   ...
                                   )
      endTime <- Sys.time()
      self$ans$time <- endTime - startTime
      return(self$ans)
    },

    # for nicely printing out the answer
    printoutput = function() {
        output <- list(
          par     = self$ans$xmin,
          value   = self$ans$fmin,
          counts  = c(`function` = self$ans$nfeval),
          time    = self$ans$time
        )

        return(output)
    }

  ) # end public list
) # end adagio_simpleDE_wrapper class
