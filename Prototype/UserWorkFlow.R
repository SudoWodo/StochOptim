# load files -------------------------------------

# Set working directory to folder containing this file

# just for trying things out 
# package does not use library and source

library(R6)
source("GlobalWrapper.R")
source("localWrapper.R")
source("OptimizerWrapper.R")


# workflow ---------------------------------------


rastrigin <- function(x) {
  y <- ( 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x)))
  return(y)
}

D <- 10
lb <- rep(-5.2, D)
ub <- rep(5.2, D)

ctrl1 <- list(NP      = 10*length(lb),
              itermax = 200*length(lb),
              reltol  = 1e-10, 
              trace   = FALSE)

final_ans <- globalwrapper(fn      = rastrigin, 
                           lower   = lb,
                           upper   = ub, 
                           method  = "DEoptim", 
                           control = ctrl1)
summary(final_ans)

## pso ---------------------------------------

# PSO
## Rastrigin function - local refinement with L-BFGS-B on improvements

ctrl2 <- list(abstol= 1e-8, hybrid = "improved")

final_ans2 <- globalwrapper(par     = rep(1,D),
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
ctrl3 <- list(threshold.stop = global_min + tol)

final_ans3 <- globalwrapper(fn = rastrigin,
                            lower = lower,
                            upper = upper,
                            method = "GenSA",
                            control= ctrl3
                            )
summary(final_ans3)





# Rough work --------------------------------




# PSO
## Rastrigin function - local refinement with L-BFGS-B on improvements
# psoptim(rep(NA,2),rastrigin,
#         lower=-5,upper=5,control=list(abstol=1e-8,hybrid="improved"))
# 
# par <- rep(NA, D)
# fn <- rastrigin
# lower <- rep(-5,D)
# upper <- rep(5,D)
# control = ctrl3
# method = "pso"
# 
# localwrapperpso(par = par,
#                 fn = rastrigin, 
#                 lower = lb,
#                 upper = ub, 
#                 method = "pso",
#                 control = ctrl3)
# 
# pso::psoptim(par     = par,
#              fn      = rastrigin,
#              lower   = lower,
#              upper   = upper,
#              control = ctrl3
# )
# 
# psoptim(par = rep(NA,D),
#         fn = rastrigin, 
#         lower = lb,
#         upper = ub, 
#         control = ctrl3)
# 
# ##################################################
# 
# 
# out <- GenSA(lower = lower, upper = upper, fn = rastrigin,
#              control=list(max.time=2))
# out[c("value","par","counts")]

