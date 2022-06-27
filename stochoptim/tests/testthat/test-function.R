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

