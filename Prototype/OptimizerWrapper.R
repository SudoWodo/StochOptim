OptimizerWrapper <- R6Class(
  classname = "OptimizerWrapper",
  
  public = list(
    ans      = NULL,
    par      = NULL,
    fn       = NULL,
    lower    = NULL,
    upper    = NULL,
    method   = NULL,
    control  = list(),
    vcontrol = NULL,   # valid control
    
    # constructor
    initialize = function(par     = NULL, 
                          fn      = NULL, 
                          lower   = NULL, 
                          upper   = NULL,
                          method  = NULL, 
                          control = list()){
      
      self$par     = par
      self$fn      = fn
      self$lower   = lower
      self$upper   = upper
      self$method  = method
      self$control = control
    },
    
    # check package installation
    checkinstallation = function(){
      
      # method name == package name? (check this once!)
      if (!requireNamespace(self$method, quietly = TRUE)) {
        warnmsg  <- paste("Package", method, "not available. Please install it!")
        warning(warnmsg, call. = FALSE)
      }
    },
    
    # control list check
    checkcontrol = function(){
      ctrlcheck <- (names(self$control) %in% self$vcontrol)
      if(!all(ctrlcheck)){
        wrongctrl <- which(ctrlcheck == FALSE)
        stopmsg <- paste("Unknown names in control:", 
                         names(self$control)[wrongctrl],"\n")
        stop(stopmsg, call. = FALSE)
      }
      
    }
    
    # TODO receive optimizer specific control parameter for sopm (which calls multiple optimizer)
  )
)


DEoptimWrapper <- R6Class(
  
  classname = "DEoptimWrapper",
  inherit = OptimizerWrapper,
  public = list(
    
    vcontrol = c("VTR", "strategy", "bs", "NP", "itermax", "CR", "F", "trace",
                 "initialpop", "storepopfrom", "storepopfreq", "p", "c", 
                 "reltol", "steptol", "parallelType", "cluster", "packages", 
                 "parVar", "foreachArgs"),
     
    # call the optimizer 
    callOptimizer = function(){
      self$ans <- DEoptim::DEoptim(fn      = self$fn, 
                                   lower   = self$lower, 
                                   upper   = self$upper, 
                                   control = self$control
      )
      
      return(self$ans)
    },
    
    # for nicely printing out the answer
    printoutput = function(){
      output <- list(
        par     = self$ans$optim$bestmem,
        value   = self$ans$optim$bestval,
        counts  = c(`function` = self$ans$optim$nfeval)
      )
      
      print(output)
    }
    
  ) # end public list
) # end DEoptimWrapper class


psoWrapper <- R6Class(
  classname = "psoWrapper",
  inherit = OptimizerWrapper,
  public = list(
    
    vcontrol = c("trace", "fnscale", "maxit", "maxf", "abstol", "reltol",
                 "REPORT", "trace.stats", "s", "k", "p", "w", "c.p", "c.g",
                 "d", "v.max", "rand.order", "max.restart", "maxit.stagnate",
                 "vectorize", "hybrid", "hybrid.control", "type"),

    callOptimizer = function(){
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
) # end pso_Wrapper class


GenSAWrapper <- R6Class(
  classname = "GenSAWrapper",
  inherit = OptimizerWrapper,
  public = list(
    
    vcontrol = c("maxit", "threshold.stop" , "nb.stop.improvement", "smooth",
                 "max.call", "max.time", "temperature", "visiting.param", 
                 "acceptance.param", "verbose", "simple.function", "trace.mat",
                 "seed"),
    
    callOptimizer = function(){
      self$ans <- GenSA::GenSA(par     = self$par,
                               fn      = self$fn,
                               lower   = self$lower,
                               upper   = self$upper,
                               control = self$control
      )
      
      return(self$ans)
    },
    
    # for nicely printing out the answer
    printoutput = function(){
      output <- list(
        par     = self$ans$par,
        value   = self$ans$value,
        counts  = c(`function` = self$ans$counts)
      )
      
      print(output)
    }
  ) # end public list
) # end GenSA
