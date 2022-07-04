#GenSA ------------------------------------------------------------------
GenSA_wrapper <- R6::R6Class(
  classname = "GenSA_wrapper",
  inherit = optimizer_wrapper,

  public = list(

    vcontrol = c(maxiter = "maxit",
                 trace   = "trace.mat",

                 "threshold.stop" ,
                 "nb.stop.improvement",
                 "smooth",
                 "max.call",
                 "max.time",
                 "temperature",
                 "visiting.param",
                 "acceptance.param",
                 "verbose",
                 "simple.function",
                 "seed"),

    # call the optimizer
    calloptimizer = function(){
      startTime <- Sys.time()
      self$ans <- GenSA::GenSA(par     = self$par,
                               fn      = self$fn,
                               lower   = self$lower,
                               upper   = self$upper,
                               control = self$control
      )
      endTime <- Sys.time()
      self$ans$time <- endTime - startTime

      return(self$ans)
    },

    tracetranslation = function() {
      self$control$trace.mat = FALSE
      self$control$verbose   = TRUE
    },

    # for nicely printing out the answer
    printoutput = function(print){

        output <- list(
          par     = self$ans$par,
          value   = self$ans$value,
          counts  = c(`function` = self$ans$counts),
          time    = self$ans$time
        )

        if(print) {

          print(output)
        }

        return(output)
    }
  ) # end public list
) # end GenSA
