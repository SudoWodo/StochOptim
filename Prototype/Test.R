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

# - with invalid control

ctrl1 <- list(NP      = 10*length(lb),
              itermax = 200*length(lb),
              reltol  = 1e-10, 
              tracee   = FALSE) # trace misspelled

final_ans <- globalwrapper(fn      = rastrigin, 
                           lower   = lb,
                           upper   = ub, 
                           method  = "DEoptim", 
                           control = ctrl1)
