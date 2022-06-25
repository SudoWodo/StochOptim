#pso ---------------------------------------------------------------------

pso_wrapper <- R6::R6Class(
  classname = "pso_wrapper",
  inherit = optimizer_wrapper,
  public = list(

    vcontrol = list(trace = "trace", "fnscale", maxiter = "maxit", "maxf", "abstol", "reltol",
                    "REPORT", "trace.stats",popsize = "s", "k", "p", "w", "c.p", "c.g",
                    "d", "v.max", "rand.order", "max.restart", "maxit.stagnate",
                    "vectorize", "hybrid", "hybrid.control", "type"),

    calloptimizer = function(){
      self$ans <- pso::psoptim(par     = self$par,
                               fn      = self$fn,
                               lower   = self$lower,
                               upper   = self$upper,
                               control = self$control
      )

      return(self$ans)
    },

    printoutput = function(){
      output <- list(
        par       = self$ans$par,
        value     = self$ans$value,
        counts    = self$ans$counts,
        converged = self$ans$convergence,
        message   = self$ans$message
      )

      print(output)
    }
  ) # end public list
) # end pso__wrapper class
