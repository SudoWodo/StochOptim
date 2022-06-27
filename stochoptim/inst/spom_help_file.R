library(devtools)
load_all()
control <- list(popsize = 100,
  DEoptim = list(tol = 1e-10), GenSA = list(maxiter = 100))

control <- list(DEoptim = list(tol = 1e-10))
sopm(fn = fn,lower = lb, upper = ub, control= control)
