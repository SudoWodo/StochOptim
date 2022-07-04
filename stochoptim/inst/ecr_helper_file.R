fn = function(x) {
  sum(x^2)
}

lower = c(-5, -5); upper = c(5, 5)

ctrl6 <- list()

global_wrapper(fn = fn, lower = lower, upper = upper, method = "ecr")
