NMOF_PSopt_wrapper <- R6Class(
  classname = "NMOF_PSopt_wrapper",
  inherit = optimizer_wrapper,
  public = list(
    default_control = NULL,
    vcontrol = c(popsize = "nP",
                 "nG",
                 "c1",
                 "c2",
                 "iner",
                 "initV",
                 "maxV", #
                 "pen",
                 "minmaxConstr",
                 "repair",
                 "changeV",
                 "initP",
                 "loopOF",
                 "loopPen",
                 "loopRepair",
                 "loopChangeV",
                 "printDetail",
                 "printBar",
                 "storeF",
                 "storeSolutions",
                 "classify",
                 "drop"),

    setdefaultcontrol = function(){
      self$default_control <- list(
        min = self$lower,
        max = self$upper,
        printBar = FALSE,
        printDetail = FALSE
      )
    },

    calloptimizer = function(...) {
      cat("Running -> NMOF::PSopt \n")
      #print(self$control)
      startTime <- Sys.time()
      self$ans <- NMOF::PSopt(OF = self$fn,
                              algo = self$control,
                              ...)
      endTime <- Sys.time()
      self$ans$time <- endTime - startTime
      return(self$ans)
    },

    printoutput = function() {
      output <- list(
        par     = self$ans$xbest,
        value   = self$ans$OFvalue
      )
      return(output)
    }
  )
)# end of NMOF_PSopt_wrapper
