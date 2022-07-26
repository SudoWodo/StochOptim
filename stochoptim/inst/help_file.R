rastrigin <- function(x) {
  y <- ( 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x)))
  return(y)
}

D <- 10
lb <- rep(-5.2, D)
ub <- rep(5.2, D)
par <- rnorm(D)

fn      = rastrigin
lower   = lb
upper   = ub
method  = "DEoptimR"
control = NULL

d = length(lb)
default_control = list(constr = NULL,
                    meq = 0,
                    eps = 1e-05,
                    NP = 10 * d,
                    Fl = 0.1,
                    Fu = 1,
                    tau_F = 0.1,
                    tau_CR = 0.1,
                    tau_pF = 0.1,
                    jitter_factor = 0.001,
                    tol = 1e-15,
                    maxiter = 200 * d,
                    fnscale = 1,
                    compare_to = c("median", "max"),
                    add_to_init_pop = NULL,
                    trace = FALSE,
                    triter = 1,
                    details = FALSE)

control <- list(Fu = 2,
             tau_F = 0.1,
             tau_CR = 0.1,
             tau_pF = 0.1)

changedefaultcontrol = function() {
  for (i in names(control)) {
    default_control[i] <- control[i]
  }
  control <- default_control
}


griewank <- function(x) {
  1 + crossprod(x)/4000 - prod( cos(x/sqrt(seq_along(x))) )
}


ans <- JDEoptim(rep(-600, 10), rep(600, 10), griewank,
         tol = 1e-7, trace = TRUE, triter = 50)


for(i in names(default_control)){
  cat(i," = ","self$","control$",i,"\n",sep = "")
}

for(i in vcontrol){
  cat(i," = ","self$","control$",i,",\n",sep = "")
}
