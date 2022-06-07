optimizer_wrapper <- R6Class(
  classname = "optimizer_wrapper",
  
  public = list(
    par     = NULL,
    fn      = NULL,
    lower   = NULL,
    upper   = NULL,
    method  = NULL,
    control = list(),
    
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
    
    
    checkinstallation = function(){
      
      # method name == package name? (check this once!)
      if (!requireNamespace(self$method, quietly = TRUE)) {
        wmsg  <- paste("Package", method, "not available. Please install it!")
        warning(wmsg, call. = FALSE)
      }
    }
    
    # TODO control list check
    
    # TODO print the ans in nice format
    
    # TODO receive optimizer specific control parameter for sopm (which calls multiple optimizer)
  )
)


DEoptim_Wrapper <- R6Class(
  
  classname = "DEoptim_Wrapper",
  inherit = optimizer_wrapper,
  public = list(
    
    # call the optimizer 
    callOptimizer = function(){
      ans <- DEoptim::DEoptim( fn      = self$fn, 
                               lower   = self$lower, 
                               upper   = self$upper, 
                               control = self$control
      )
      
      return(ans)
    }
    
  ) # end public list
) # end DEoptim_Wrappe class


pso_Wrapper <- R6Class(
  classname = "pso_Wrapper",
  inherit = optimizer_wrapper,
  public = list(

    callOptimizer = function(){
      ans <- pso::psoptim(par     = self$par,
                          fn      = self$fn,
                          lower   = self$lower,
                          upper   = self$upper,
                          control = self$control
      )
      
      return(ans)
    }
  )
) # end pso_Wrapper class


GenSA_Wrapper <- R6Class(
  classname = "GenSA_wrapper",
  inherit = optimizer_wrapper,
  public = list(
    
    callOptimizer = function(){
      
      ans <- GenSA::GenSA(par     = self$par,
                          fn      = self$fn,
                          lower   = self$lower,
                          upper   = self$upper,
                          control = self$control
      )
      
      return(ans)
    }
  )
)
