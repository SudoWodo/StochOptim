fn <- function(x) {
  x^2
}

test_that("trace works for DEoptim", {

  trace_test <- function(trace){
    ctrl1 <- list(popsize = 100,
                  maxiter = 100,
                  tol  = 1e-3,
                  trace   = trace)

    ans <- global_wrapper(
      fn     = fn,
      lower   = -1,
      upper   = 1,
      method  = "DEoptim",
      control = ctrl1
      )

    return(typeof(ans))
  }

  expect_equal(trace_test(trace = 0), "list")
  expect_equal(trace_test(trace = 1), "list")
  expect_equal(trace_test(trace = 2), "list")
  expect_equal(trace_test(trace = 3), "list")
  expect_equal(trace_test(trace = 4), "list")
  expect_equal(trace_test(trace = 5), "list")
})

test_that("trace works for GenSA", {

  trace_test <- function(trace){
    ctrl1 <- list(maxiter = 10,
                  trace   = trace)

    ans <- global_wrapper(
      fn     = fn,
      lower   = -1,
      upper   = 1,
      method  = "GenSA",
      control = ctrl1
    )

    return(typeof(ans))
  }

  expect_equal(trace_test(trace = 0), "list")
  expect_equal(trace_test(trace = 1), "list")
  expect_equal(trace_test(trace = 2), "list")
  expect_equal(trace_test(trace = 3), "list")
  expect_equal(trace_test(trace = 4), "list")
  expect_equal(trace_test(trace = 5), "list")
})

rastrigin <- function(x) {
  y <- ( 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x)))
  return(y)
}

D <- 10
lower <- lb <- rep(-5.2, D)
upper <- ub <- rep(5.2, D)
par <- rep(3.3, D)


test_that("trace works for pso", {

  trace_test <- function(trace){
    ctrl1 <- list(tol = 1e-8, hybrid = "improved", trace = trace)

    ans <- global_wrapper(
      par    = par,
      fn     = rastrigin ,
      lower   = lb,
      upper   = ub,
      method  = "pso",
      control = ctrl1
    )

    return(typeof(ans))
  }

  expect_equal(trace_test(trace = 0), "list")
  expect_equal(trace_test(trace = 1), "list")
  expect_equal(trace_test(trace = 2), "list")
  expect_equal(trace_test(trace = 3), "list")
  expect_equal(trace_test(trace = 4), "list")
  expect_equal(trace_test(trace = 5), "list")
})

# test_that("trace works for DEoptimR", {
#   rastrigin <- function(x) {
#     y <- ( 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x)))
#     return(y)
#   }
#
#   D <- 10
#   lower <- lb <- rep(-5.2, D)
#   upper <- ub <- rep(5.2, D)
#   par <- rep(3.3, D)
#
#   trace_test <- function(trace){
#     ans <- global_wrapper(fn = fn, lower = lb, upper = ub,method =  "DEoptimR", control = list(trace = 0))
#
#     return(typeof(ans))
#   }
#
#   expect_equal(trace_test(trace = 0), "list")
#   expect_equal(trace_test(trace = 1), "list")
#   expect_equal(trace_test(trace = 2), "list")
#   expect_equal(trace_test(trace = 3), "list")
#   expect_equal(trace_test(trace = 4), "list")
#   expect_equal(trace_test(trace = 5), "list")
# })


test_that("trace works for adagio_simpleDE", {

    rastrigin <- function(x) {
      y <- ( 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x)))
      return(y)
    }

    D <- 10
    lower <- lb <- rep(-5.2, D)
    upper <- ub <- rep(5.2, D)
    par <- rep(3.3, D)

  trace_test <- function(trace){
    ans <- global_wrapper(fn = rastrigin, lower = lb, upper =  ub, method = "adagio_simpleDE", control = list(trace = 0))

    return(typeof(ans))
  }

  expect_equal(trace_test(trace = 0), "list")
  expect_equal(trace_test(trace = 1), "list")
  expect_equal(trace_test(trace = 2), "list")
  expect_equal(trace_test(trace = 3), "list")
  expect_equal(trace_test(trace = 4), "list")
  expect_equal(trace_test(trace = 5), "list")
})
