control <- ctrl1 <- list(popsize = 10*length(lb),
              maxiter = 200*length(lb),
              tol  = 1e-10,
              trace   = FALSE)


vcontrol = c("VTR", "strategy", "bs", popsize = "NP", maxiter = "itermax",
             "CR", "F", trace = "trace", "initialpop", "storepopfrom",
             "storepopfreq", "p", "c", tol = "reltol", "steptol",
             "parallelType", "cluster", "packages", "parVar", "foreachArgs")

fn <- rastrigin <- function(x) {
  y <- ( 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x)))
  return(y)
}

D <- 10
lower <- lb <- rep(-5.2, D)
upper <- ub <- rep(5.2, D)


for( i in names(control)) {
  if( i %in% names(vcontrol)) {
    index <- which( i == names(vcontrol))
    name <- vcontrol[index]
    if( i != name) {
      control[name] = control[i]
      control[i] = NULL
    }
  }
}



final_ans <- global_wrapper(fn     = rastrigin,
                            lower   = lb,
                            upper   = ub,
                            method  = "DEoptim",
                            control = ctrl1)
summary(final_ans)





