# load files -------------------------------------

# Set working directory to folder containing this file

# The scheme for the proposed package has been laid out
# in a script like manner

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



## NOTE : Global wrapper returns the object which is provided by optimizer used.
## NOTE : Global wrapper just prints the output in fashion similar to optimx


# DEoptim --------------------------------------

ctrl1 <- list(NP      = 10*length(lb),
              itermax = 200*length(lb),
              reltol  = 1e-10, 
              trace   = FALSE)

set.seed(123)
final_ans <- GlobalWrapper(fn      = rastrigin, 
                           lower   = lb,
                           upper   = ub, 
                           method  = "DEoptim", 
                           control = ctrl1)
summary(final_ans)

## pso ---------------------------------------

# PSO
## Rastrigin function - local refinement with L-BFGS-B on improvements

ctrl2 <- list(abstol= 1e-8, hybrid = "improved")

final_ans2 <- GlobalWrapper(par     = rep(1,D),
                            fn      = rastrigin, 
                            lower   = lb,
                            upper   = ub, 
                            method  = "pso",
                            control = ctrl2)

summary(final_ans)

## GenSA ------------------------------------

# GenSA will stop after finding the targeted function value 0 with
# absolute tolerance 1e-13

global_min <- 0
tol <- 1e-13
ctrl3 <- list(threshold.stop = global_min + tol, trace.mat = FALSE)

final_ans3 <- GlobalWrapper(fn      = rastrigin,
                            lower   = lb,
                            upper   = ub,
                            method  = "GenSA",
                            control = ctrl3)

# note GenSA returns almost similar output as printed by GlobalWrapper
final_ans3
