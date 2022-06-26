# DEoptim

# DEoptim_wrapperinherits attributes from optimizer_wrapper
#

DEoptim_wrapper <- R6::R6Class(

  classname = "DEoptim_wrapper",
  inherit = optimizer_wrapper,
  public = list(

    vcontrol = c(tol       = "reltol",
                 popsize   = "NP",
                 maxiter   = "itermax",
                 trace     = "trace",

                 "VTR",
                 "strategy",
                 "bs",
                 "CR",
                 "F",
                 "initialpop",
                 "storepopfrom",
                 "storepopfreq",
                 "p",
                 "c",
                 "steptol",
                 "parallelType",
                 "cluster",
                 "packages",
                 "parVar",
                 "foreachArgs"),


    # call the optimizer
    calloptimizer = function() {
      self$ans <- DEoptim::DEoptim(fn      = self$fn,
                                   lower   = self$lower,
                                   upper   = self$upper,
                                   control = self$control
      )

      return(self$ans)
    },

    tracetranslation = function() {
      self$control$trace = FALSE
    },

    # for nicely printing out the answer
    printoutput = function(print) {

        output <- list(
          par     = self$ans$optim$bestmem,
          value   = self$ans$optim$bestval,
          counts  = c(`function` = self$ans$optim$nfeval)
        )

        if(print) {

          print(output)
        }

        return(output)
    }

  ) # end public list
) # end DEoptim_wrapper class
