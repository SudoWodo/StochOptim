Rastrigin <- function(x) {
  sum(x^2 - 10 * cos(2 * pi  * x)) + 10 * length(x)
}

set.seed(1234) # The user can use any seed.
dimension <- 30
global.min <- 0
tol <- 1e-13
lower <- rep(-5.12, dimension)
upper <- rep(5.12, dimension)
out <- GenSA(lower = lower, upper = upper, fn = Rastrigin,
             control=list(threshold.stop=global.min+tol,verbose=TRUE,trace.mat = TRUE, verbose = TRUE)
             )
out$trace.mat
out[c("value","par","counts")]

set.seed(123)
psoptim(rep(NA,2),function(x) 20+sum(x^2-10*cos(2*pi*x)),
lower=-5,upper=5,control=list(abstol=1e-8,trace = 1,trace.stats = TRUE))
