fn <- rastrigin <- function(x) {
  y <- ( 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x)))
  return(y)
}

D <- 10
lower <- lb <- rep(-5.2, D)
upper <- ub <- rep(5.2, D)
par <- rep(3.3, D)

test_that("invalid function throws error", {
  expect_error(
    global_wrapper(fn     = D,
                   lower  = lb,
                   upper   = ub,
                   method  = "DEoptim",
                   control = list(popsize = 10*length(lb),
                                  maxiter = 200*length(lb),
                                  tol     = 1e-10,
                                  trace   = FALSE)),
    "passed object is not a valid function !"

  )
})

