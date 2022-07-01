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

