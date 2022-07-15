#GenSA ------------------------------------------------------------------
GenSA_wrapper <- R6::R6Class(
  classname = "GenSA_wrapper",
  inherit = optimizer_wrapper,

  public = list(

    vcontrol = c(maxiter = "maxit",
                 "trace",
                 "trace.mat",
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
    trace_value = NULL,

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
      if("trace" %in% names(self$control)){
        switch (as.character(self$control$trace),
                "0" = {
                  self$control$verbose = FALSE
                  self$control$trace = NULL
                  },
                "1" = {
                  self$printtrace = TRUE
                  self$control$verbose = FALSE
                  self$control$trace = NULL
                },
                "2" = {
                  self$printtrace = TRUE
                  self$control$verbose = FALSE
                  self$control$trace.mat = TRUE
                  self$control$trace = NULL
                  self$trace_value = 1000
                },
                "3" = {
                  self$printtrace = TRUE
                  self$control$verbose = FALSE
                  self$control$trace.mat = TRUE
                  self$control$trace = NULL
                  self$trace_value = 500
                },
                "4" = {
                  self$printtrace = TRUE
                  self$control$verbose = FALSE
                  self$control$trace.mat = TRUE
                  self$control$trace = NULL
                  self$trace_value = 50
                },
                "5" = {
                  self$printtrace = TRUE
                  self$control$verbose = FALSE
                  self$control$trace.mat = TRUE
                  self$control$trace = NULL
                  self$trace_value = 1
                }
        )
      }
    },

    # for nicely printing out the answer
    printoutput = function(){

        output <- list(
          par     = self$ans$par,
          value   = self$ans$value,
          counts  = c(`function` = self$ans$counts),
          time    = self$ans$time
        )

        if(!is.null(self$trace_value)) {
          mat <- self$ans$trace.mat
          index <- seq(1,nrow(mat),self$trace_value)
          print(as.data.frame(mat)[index,])
        }

        if(self$printtrace){
          print(output)
        }

        return(output)
    }
  ) # end public list
) # end GenSA
