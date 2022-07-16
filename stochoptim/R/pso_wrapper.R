#pso ---------------------------------------------------------------------

pso_wrapper <- R6::R6Class(
  classname = "pso_wrapper",
  inherit = optimizer_wrapper,
  public = list(

    vcontrol = list(trace   = "trace",
                    maxiter = "maxit",
                    tol     = "abstol",
                    popsize = "s",

                    "fnscale",
                    "maxf",
                    "reltol",
                    "REPORT",
                    "trace.stats",
                    "k",
                    "p",
                    "w",
                    "c.p",
                    "c.g",
                    "d",
                    "v.max",
                    "rand.order",
                    "max.restart",
                    "maxit.stagnate",
                    "vectorize",
                    "hybrid",
                    "hybrid.control",
                    "type"),

    printtrace = FALSE,

    # trace
    tracetranslation = function() {
      if("trace" %in% names(self$control)){
        switch (
          as.character(self$control$trace),

          "0" = {self$control$trace = FALSE},

          "1" = {
            self$printtrace = TRUE
            self$control$trace = FALSE
            self$control$trace = FALSE
          },

          "2" = {
            self$control$trace = TRUE
            self$control$REPORT = 50
          },

          "3" = {
            self$control$trace = TRUE
            self$control$REPORT = 20
          },

          "4" = {
            self$control$trace = TRUE
            self$control$REPORT = 10
          },

          "5" = {
            self$control$trace = TRUE
            self$control$REPORT = 1}
        )

      } else {
        self$control$trace = FALSE
      }
    },

    calloptimizer = function(...) {
      cat("Running -> pso::psoptim \n")
      startTime <- Sys.time()
      self$ans <- pso::psoptim(par     = self$par,
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

    printoutput = function(){
        output <- list(
          par       = self$ans$par,
          value     = self$ans$value,
          counts    = self$ans$counts,
          converged = self$ans$convergence,
          message   = self$ans$message,
          time      = self$ans$time
        )

        if(self$printtrace) {
          print(output)
        }

        return(output)
    }
  ) # end public list
) # end pso__wrapper class
