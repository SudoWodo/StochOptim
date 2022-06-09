library(R6)
source("GlobalWrapper.R")
source("LocalWrapper.R")
source("OptimizerWrapper.R")


# workflow ---------------------------------------

rastrigin <- function(x) {
  y <- ( 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x)))
  return(y)
}

D <- 10
lb <- rep(-5.2, D)
ub <- rep(5.2, D)

# checks -----------------------------------------

# - with invalid function
final_ans <- GlobalWrapper(fn = D, lower = lb, upper = ub, 
                           method = "DEoptim", control = ctrl)

final_ans <- GlobalWrapper(fn = NULL, lower = lb, upper = ub, 
                           method = "DEoptim", control = ctrl)

# - with invalid method
final_ans <- GlobalWrapper(fn = rastrigin, lower = lb, upper = ub, 
                           method = "Not a method", control = ctrl)

final_ans <- GlobalWrapper(fn = rastrigin, lower = lb, upper = ub, 
                           method = NULL, control = ctrl)

# - with invalid control

ctrl1 <- list(NP      = 10*length(lb),
              itermax = 200*length(lb),
              reltol  = 1e-10, 
              tracee   = FALSE) # trace misspelled

final_ans <- GlobalWrapper(fn      = rastrigin, 
                           lower   = lb,
                           upper   = ub, 
                           method  = "DEoptim", 
                           control = ctrl1)
