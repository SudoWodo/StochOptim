NMOF_GAopt_wrapper <- R6Class(
  classname = "NMOF_GAopt_wrapper",
  inherit = optimizer_wrapper,
  public = list(

    initialize = function(par, fn, method, control) {
      self$par = par
      self$fn = fn
      self$control = control
      self$method = method
    },

    vcontrol = c(popsize = "nP",
                 "nB",
                 "nG",
                 "crossover",
                 "prob",
                 "pen",
                 "repair",
                 "initP",
                 "loopOF",
                 "loopPen",
                 "loopRepair",
                 "methodOF",
                 "cl",
                 "mc.control",
                 "printDetail",
                 "printBar",
                 "storeF",
                 "storeSolutions",
                 "classify"),

    default_control = NULL,

    setdefaultcontrol = function() {
      self$default_control <- list(
        printBar = FALSE,
        printDetail = FALSE,
        nB = length(self$par)
      )
    },

    calloptimizer = function(...) {
      cat("Running -> NMOF::GAopt \n")
      #print(self$control)
      startTime <- Sys.time()
      self$ans <- NMOF::GAopt(OF = self$fn,
                              algo = self$control,
                              ...
      )
      endTime <- Sys.time()
      self$ans$time <- endTime - startTime
      return(self$ans)
    },

    printoutput = function() {
      output <- list(
        par     = self$ans$xbest,
        value   = self$ans$OFvalue,
        time    = self$ans$time
      )
      return(output)
    }

  ) #end of public list
) #end of NMOF_DEopt_wrapper class
