fn <- function(x, extra = 1) {x^2 + extra}
ctrl1 <- list(popsize = 10, maxiter = 10, tol= 1e-1, trace = FALSE)

test_that("DEoptim works with extra parameter", {
  expect_equal(
    typeof(
      global_wrapper(
        fn = fn,
        lower = -1,
        upper = 1,
        print = FALSE,
        method = "DEoptim",
        control = ctrl1,
        extra = 10)
    ),"list")
})

test_that("DEoptimR works with extra parameter", {
  expect_equal(
    typeof(
      global_wrapper(
        fn = fn,
        lower = -1,
        upper = 1,
        print = FALSE,
        method = "DEoptimR",
        control = ctrl1,
        extra = 10)
    ),"list")
})

test_that("pso works with extra parameter", {
  expect_equal(
    typeof(
      global_wrapper(
        par = 1,
        fn = fn,
        lower = -1,
        upper = 1,
        print = FALSE,
        method = "pso",
        control = ctrl1,
        extra = 10)
    ),"list")
})

global_min <- 0
tol <- 1e-13
ctrl2 <- list(threshold.stop = global_min + tol, trace = FALSE)

test_that("GenSA works with extra parameter", {
  expect_equal(
    typeof(
      global_wrapper(
        par = 1,
        fn = fn,
        lower = -1,
        upper = 1,
        print = FALSE,
        method = "GenSA",
        control = ctrl2,
        extra = 10)
    ),"list")
})


#NOTE - adagioDE doesn't take extra parameters for objective function

# ctrl3 <- list(popsize  = 10,
#               nmax     = 10,
#               r        = 0.40,
#               confined = TRUE,
#               trace    = FALSE)

# test_that("adagio_simpleDE works with extra parameter", {
#   expect_equal(
#     typeof(
#       global_wrapper(
#         par = 1,
#         fn = fn,
#         lower = -1,
#         upper = 1,
#         print = FALSE,
#         method = "adagio_simpleDE",
#         control = ctrl3,
#         extra = 10)
#     ),"list")
# })

test_that("ecr works with extra parameter", {
  expect_equal(
    typeof(
      global_wrapper(
        par = 1,
        fn = fn,
        lower = -1,
        upper = 1,
        print = TRUE,
        method = "ecr",
        extra = 10)
    ),"list")
})
