library(globalOptTests)
library(StochOptim)

# Test function properties
fn_name = "Modlangerman"
dimen  = getProblemDimen(fn_name)    # d = 10
bounds = getDefaultBounds(fn_name)   # lower = 0; upper = 10
gloptm = getGlobalOpt(fn_name)       # gloptm = -0.965

# Test function definition
fn = function(x) goTest(fnName = fn_name, par = x)
# Apply and compare stochastic optimizers
par = rnorm(length(bounds$lower))
res = sopm(par = par, fn = fn, lower = bounds$lower, upper = bounds$upper,
           method = c("DEoptim", "DEoptimR", "GenSA"
                      , "pso", "adagio_simpleDE"))
tibble::tibble(res)

system.time(sopm(par = par, fn = fn, lower = bounds$lower, upper = bounds$upper,method = c("DEoptim", "DEoptimR", "GenSA")))

sum(as.numeric(res$time))