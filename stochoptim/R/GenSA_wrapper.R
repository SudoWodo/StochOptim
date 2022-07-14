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

    printtrace = FALSE,

    # call the optimizer
    calloptimizer = function(...){
      startTime <- Sys.time()
      self$ans <- GenSA::GenSA(par     = self$par,
                               fn      = self$fn,
                               lower   = self$lower,
                               upper   = self$upper,
                               control = self$control,
                               ...
      )
      endTime <- Sys.time()
      self$ans$time <- endTime - startTime

      return(self$ans)
    },

    tracetranslation = function() {
      switch (as.character(self$control$trace),
              "0" = {self$control$trace.mat = FALSE},
              "1" = {self$printtrace = TRUE
              self$control$trace = FALSE
              },
              "2" = {
                if("itermax" %in% self$control$itermax) {
                  self$control$trace = self$control$itermax * 0.75
                } else {
                  default_itermax = 200
                  self$control$trace = default_itermax * 0.75
                }
              },
              "3" = {
                if("itermax" %in% self$control$itermax) {
                  self$control$trace = self$control$itermax * 0.50
                } else {
                  default_itermax = 200
                  self$control$trace = default_itermax * 0.50
                }
              },
              "4" = {
                if("itermax" %in% self$control$itermax) {
                  self$control$trace = self$control$itermax * 0.25
                } else {
                  default_itermax = 200
                  self$control$trace = default_itermax * 0.25
                }
              },
              "5" = {self$control$trace = TRUE}
      )
    },

    # for nicely printing out the answer
    printoutput = function(){

        output <- list(
          par     = self$ans$par,
          value   = self$ans$value,
          counts  = c(`function` = self$ans$counts),
          time    = self$ans$time
        )

        if(self$printtrace){
          print(output)
        }

        return(output)
    }
  ) # end public list
) # end GenSA
