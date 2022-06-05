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
    
    # package installation check
    checkinstallation = function(){
      if (!requireNamespace("DEoptim", quietly = TRUE)) {
        warning("Package 'DEoptim' not available. Please install it!",
                call. = FALSE)
      }
    },
    
    
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
  
  # Check if function is available
  if(!is.function(fn)){
    stop("passed object in not a valid function !")
  }
  
  # check if method is available
  method_list <- c("DEoptim")

  if(!is.null(method)){
    
    if(method %in% method_list){
      switch (
        method,
        
        # DEoptim case
        "DEoptim" = {
          ans <- localwrapperDeoptim(fn = fn, lb = lb, ub = ub, control = control)
        } 
        
      ) # end switch
      
    } else{
        stop("method not found !")
      }  # end if-else method_list check
    
  } else{
      stop("method cannot be NULL !")
    } # end if-else method null check

  return(ans)
}

# Local-wrapper for DEoptim

localwrapperDeoptim <- function(fn, lb, ub, control = list()){
  
  # this calls the constructor and new object is formed
  obj <- DEoptim_Wrapper$new(
    fn = fn, lb = lb, ub = ub, control = control
  )
  
  # package installation check
  obj$checkinstallation()
    
  # object calls the optimizer
  ans <- obj$callOptimizer()
  
  return(ans)
}


####### End user workflow #######

rastrigin <- function(x) {
  y <- 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x))
  return(y)
}

D <- 10
lb <- rep(-5.2,D)
ub <- rep(5.2,D)
ctrl <- list(trace = FALSE)

final_ans <- globalwrapper(fn = rastrigin, lower = lb, upper = ub, 
                           method = "DEoptim", control = ctrl)
summary(final_ans)

########### Tests ###########

  # - with invalid function
  final_ans <- globalwrapper(fn = D, lower = lb, upper = ub, 
                             method = "DEoptim", control = ctrl)

  final_ans <- globalwrapper(fn = NULL, lower = lb, upper = ub, 
                           method = "DEoptim", control = ctrl)
  
  # - with invalid method
  final_ans <- globalwrapper(fn = rastrigin, lower = lb, upper = ub, 
                             method = "Not a method", control = ctrl)
  
  final_ans <- globalwrapper(fn = rastrigin, lower = lb, upper = ub, 
                             method = NULL, control = ctrl)
  

########### Rough Work ###########


#ans1 <- DEoptim(fn = rastrigin, lower =lb, upper = ub , control = list(trace = FALSE))

#localwrapperDeoptim(fn = rastrigin, lb = lb, ub = ub, control = list(trace = FALSE))
