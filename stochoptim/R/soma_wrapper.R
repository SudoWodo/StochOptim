soma_wrapper <- R6Class(
  classname = "soma_wrapper",
  inherit = optimizer_wrapper,
  public = list(
    bound = NULL,
    default_control = NULL,
    init = NULL,
    vcontrol = c("populationSize",
                 "nMigrations",
                 "pathLength",
                 "stepLength",
                 "perturbationChance",
                 "minAbsoluteSep",
                 "minRelativeSep",
                 "nSteps",
                 "migrantPoolSize",
                 "leaderPoolSize",
                 "nMigrants",
                 "perturbationFrequency",
                 "stepFrequency",
                 "init"),

    setdefaultcontrol = function(){
       self$init = self$control$init
       self$control$init = NULL
       print(typeof(self$control))
    },

    calloptimizer = function(...){
      cat("Running -> soma::soma \n")
      startTime <- Sys.time()
      self$ans <- soma::soma(
        costFunction = self$fn,
        bounds = soma::bounds(self$lower, self$upper),
        #options = list(),
        init = self$init,
        ...)
      endTime <- Sys.time()
      self$ans$time <- endTime - startTime
      return(self$ans)
    },

    printoutput = function(){
      best_member = self$ans$leader
      par = self$ans$population[,best_member]
      value = self$ans$cost[best_member]
      count = self$ans$evaluations[length(self$ans$evaluations)]
      output <- list(
        par     = par,
        value   = value,
        counts  = count,
        time    = self$ans$time
      )
      return(output)
    }
  ) # end public list
)# end class
