# Global-wrapper (are we calling this soptim ?)
GlobalWrapper <- function(par, fn, lower, upper, method, control = list(),...){
  
  # Check if function is available
  if(!is.function(fn)){
    stop("passed object is not a valid function !")
  }
  
  # check if method is available
  method_list <- c("DEoptim", "pso", "GenSA")
  
   
  if(!is.null(method)){
    
    if(method %in% method_list){
      switch (
        method,
        
        # Case 1 DEoptim
        "DEoptim" = {
          ans <- LocalWrapperDEoptim(fn      = fn, 
                                     lower   = lower, 
                                     upper   = upper, 
                                     method  = method, 
                                     control = control)
        },
        
        # Case 2 pso
        "pso" = {
          ans <- LocalWrapperpso(par     = par,
                                 fn      = fn, 
                                 lower   = lower, 
                                 upper   = upper, 
                                 method  = method, 
                                 control = control)
        },
        
        # Case 3 GenSA
        "GenSA" = {
          ans <- LocalWrapperGenSA(par     = par,
                                   fn      = fn,
                                   lower   = lower,
                                   upper   = upper,
                                   method  = method,
                                   control = control)
        }
        
      ) # end switch
      
    } else{
      stop("method not found !")
    }  # end if-else method_list check
    
  } else{
    stop("please choose a valid method !")
  } # end if-else method null check
  
  return(ans)
}
