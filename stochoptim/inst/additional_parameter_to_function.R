ackley<-function(x,a=20, b=0.2 , c =2*pi){
  d <- length(x)

  sum1 <- sum(x^2)
  sum2 <- sum(cos(2*pi*x))

  term1 <- -a * exp(-b*sqrt(sum1/d))
  term2 <- -exp(sum2/d)

  y <- term1 + term2 + a + exp(1)
  return(y)
}

D <- 10
lower <- lb <- rep(-5.2, D)
upper <- ub <- rep(5.2, D)

control <- ctrl1 <- list(NP = 10*length(lb),
                         itermax = 200*length(lb),
                         reltol  = 1e-10,
                         trace   = FALSE)

DEoptim(ackley, lb, ub, control = ctrl1, b = 0.3)

global_wrapper(fn = ackley, lower = lb, upper = ub, method = "DEoptim", a = 20, b= .21)
formals(ackley)
