#pso ---------------------------------------------------------------------

pso_wrapper <- R6::R6Class(
  classname = "pso_wrapper",
  inherit = optimizer_wrapper,
  public = list(

    vcontrol = list(trace = "trace", "fnscale", maxiter = "maxit", "maxf", tol = "abstol", "reltol",
                    "REPORT", "trace.stats",popsize = "s", "k", "p", "w", "c.p", "c.g",
                    "d", "v.max", "rand.order", "max.restart", "maxit.stagnate",
                    "vectorize", "hybrid", "hybrid.control", "type"),

    calloptimizer = function(){
      startTime <- Sys.time()
      self$ans <- pso::psoptim(par     = self$par,
                               fn      = self$fn,
                               lower   = self$lower,
                               upper   = self$upper,
                               control = self$control
      )
      endTime <- Sys.time()
      self$ans$time <- endTime - startTime

      return(self$ans)
    },

    printoutput = function(print){


        output <- list(
          par       = self$ans$par,
          value     = self$ans$value,
          counts    = self$ans$counts,
          converged = self$ans$convergence,
          message   = self$ans$message,
          time      = self$ans$time
        )

        if(print) {

        print(output)
        }

        return(output)
    }
  ) # end public list
) # end pso__wrapper class
