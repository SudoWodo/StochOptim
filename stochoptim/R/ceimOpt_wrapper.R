ceimOpt_wrapper <- R6Class(
  classname = "ceimOpt_wrapper",
  inherit = optimizer_wrapper,
  public = list(
    default_control = NULL,
    vcontrol = c("nParams",
                 "minimize" ,
                 "Ntot",
                 "N_elite",
                 "N_super",
                 "alpha",
                 "epsilon",
                 "q",
                 "maxIter",
                 "waitGen",
                 "boundaries",
                 "plotConvergence",
                 "chaosGen",
                 "handIterative",
                 "verbose",
                 "plotResultDistribution",
                 "parallelVersion"),


    setdefaultcontrol = function() {
      Ntot = 1000
      maxIter = 50
      boundaries = matrix(c(self$lower,self$upper),ncol = 2, byrow = FALSE)
      self$default_control = list(
        nParams = length(self$lower),
        minimize = TRUE,
        Ntot = Ntot,
        N_elite = floor(Ntot/4),
        N_super = 1,
        alpha = 1,
        epsilon = 0.1,
        q = 2,
        maxIter = maxIter,
        waitGen = maxIter,
        boundaries = boundaries,
        plotConvergence = FALSE,
        chaosGen = maxIter,
        handIterative = FALSE,
        verbose = FALSE,
        plotResultDistribution = FALSE,
        parallelVersion = FALSE
      )
    },

    calloptimizer = function() {
      cat("Running -> RCEIM::ceimOpt \n")
      startTime <- Sys.time()
      self$ans <- RCEIM::ceimOpt(
        OptimFunction = self$fn,
        nParams = self$control$nParams,
        minimize = self$control$minimize,
        Ntot = self$control$Ntot,
        N_elite = self$control$N_elite,
        N_super = self$control$N_super,
        alpha = self$control$alpha,
        epsilon = self$control$epsilon,
        q = self$control$q,
        maxIter = self$control$maxIter,
        waitGen = self$control$waitGen,
        boundaries = self$control$boundaries,
        plotConvergence = self$control$plotConvergence,
        chaosGen = self$control$chaosGen,
        handIterative = self$control$handIterative,
        verbose = self$control$verbose,
        plotResultDistribution = self$control$plotResultDistribution,
        parallelVersion = self$control$parallelVersion
      )
      endTime <- Sys.time()
      self$ans$time <- endTime - startTime
      return(self$ans)
    },

    printoutput = function(){
      len = length(self$lower)
      output <- list(
        par     = self$ans$BestMember[1:len],
        value   = self$ans$BestMember["S"],
        counts  = self$ans$Iterations,
        time    = self$ans$time
      )
      return(output)
    }

  ) # end public list
) # end ceimOpt_wrapper
