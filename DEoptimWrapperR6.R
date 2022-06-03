###### Library ######
# please install this library
library(R6)

####### Wrapper class #######

DEoptim_Wrapper <- R6Class(
  
  classname = "DEoptim_Wrapper",
  public = list(
    fn = NULL,
    lb = NULL,
    ub = NULL,
    control = NULL,
    
    # constructor
    initialize = function(fn = NULL, lb = NULL, ub = NULL, control = list()){
      
      self$fn = fn
      self$lb = lb
      self$ub = ub
      self$control = control
    },
    
    # TODO package installation check
    checkinstallation = function(){
      if (!require("DEoptim", quietly = TRUE)) {
        warning("Package 'DEoptim' not available. Please install it!",
                call. = FALSE)
      }
    },
    
    # TODO parameter check
    
    # TODO control list check
    
    # TODO print the ans in nice format
    
    # TODO ?? receive optimizer specific control parameter for sopm (which calls multiple optimizer)
    
    # call the optimizer 
    callOptimizer = function(){
      
      ans <- DEoptim::DEoptim( fn      = self$fn, 
                               lower   = self$lb, 
                               upper   = self$ub, 
                               control = self$control
      )
      
      return(ans)
    }
    
  ) # end public list
) # end class




####### Local and Global Wrapper #######

# Global-wrapper (are we calling this soptim ?)
globalwrapper <- function(par, fn, lower, upper, method, control = list(),...){
  
  # TODO parameter and bound check
  
  if (method == "DEoptim"){
    ans <- localwrapperDeoptim(fn = fn, lb = lb, ub = ub, control = control)
  }
  
  return(ans)
}

# Local-wrapper for DEoptim

localwrapperDeoptim <- function(fn, lb, ub, control = list()){
  
  # this calls the constructor and new object is formed
  obj <- DEoptim_Wrapper$new(
    fn = fn, lb = lb, ub = ub, control = control
  )
  
  # object calls the optimizer
  ans <- obj$callOptimizer()
  
  return(ans)
}


####### End user workflow #######

rastrigin <- function(x) {
  y <- 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x))
  return(y)
}

lb <- rep(0,5)
ub <- rep(10,5)
ctrl <- list(trace = FALSE)

final_ans <- globalwrapper(fn = rastrigin, lower = lb, upper = ub, 
                           method = "DEoptim", control = ctrl)
summary(final_ans)



########### Rough Work ###########


#ans1 <- DEoptim(fn = rastrigin, lower =lb, upper = ub , control = list(trace = FALSE))

#localwrapperDeoptim(fn = rastrigin, lb = lb, ub = ub, control = list(trace = FALSE))