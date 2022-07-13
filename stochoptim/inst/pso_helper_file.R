vcontrol = list(trace = "trace", "fnscale", maxiter = "maxit", "maxf", tol = "abstol", "reltol",
                "REPORT", "trace.stats", popsize = "s", "k", "p", "w", "c.p", "c.g",
                "d", "v.max", "rand.order", "max.restart", "maxit.stagnate",
                "vectorize", "hybrid", "hybrid.control", "type")

control<- ctrl2 <- list(tol= 1e-8, hybrid = "improved")


  for( i in names(control)) {
    i <- names(control)[1]
    if( i %in% names(vcontrol)) {
      index <- which( i == names(vcontrol))
      name <- vcontrol[index][[1]]
      if( i != name) {
        control[unlist(name)] <- control[i]
        control[i] <- NULL
      }
    }
  }

ans <- psoptim(rep(NA,2),function(x) 20+sum(x^2-10*cos(2*pi*x)),
        lower=-5,upper=5,control=list(abstol=1e-8, trace = FALSE, REPORT = 10))


library(devtools)
load_all()

ctrl2 <- list(tol = 1e-8, hybrid = "improved", trace = 1)

final_ans2 <- global_wrapper(par     = rep(1,D),
                             fn      = rastrigin,
                             lower   = lb,
                             upper   = ub,
                             method  = "pso",
                             print = FALSE,
                             control = ctrl2)
