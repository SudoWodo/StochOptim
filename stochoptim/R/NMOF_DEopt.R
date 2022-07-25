NMOF_DEopt_wrapper <- R6Class(
  classname = "NMOF_DEopt_wrapper",
  inherit = optimizer_wrapper,
  public = list(
    vcontrol = c("CR",
                 "F",
                 popsize = "nP",
                 "nG",
                 "min",
                 "max",
                 "minmaxConstr",
                 "pen",
                 "initP",
                 "repair",
                 "loopOF",
                 "loopPen",
                 "loopRepair",
                 "printDetail",
                 "printBar",
                 "storeF",
                 "storeSolutions",
                 "classify",
                 "drop"),

    default_control = NULL,

    setdefaultcontrol = function() {
      self$default_control <- list(
        printBar = FALSE,
        printDetail = FALSE,
        max = self$upper,
        min = self$lower
      )
    },

    calloptimizer = function(...) {
      cat("Running -> NMOF::DEopt \n")
      #print(self$control)
      startTime <- Sys.time()
      self$ans <- NMOF::DEopt(OF = self$fn,
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
