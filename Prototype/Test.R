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