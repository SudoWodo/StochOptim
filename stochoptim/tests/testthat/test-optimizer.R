# a simple set up to optimize
fn <- function(x) {
  x^2
}

lb<- -1
ub<- 1
par <- 1


# 1)  Testing if Deoptim works

ctrl1 <- list(popsize = 40,
              maxiter = 10,
              tol     = 1e-3,
              trace   = FALSE)

test_that("DEoptim works", {
  expect_equal(
    typeof(
      global_wrapper(
        fn = fn,
        lower = -1,
        upper = 1,
        print = FALSE,
        method = "DEoptim",
        control = ctrl1)
      ), "list"
    )

})

# 2) Test if pso works

ctrl2 <- list(s = 10, tol = 1e-3, hybrid = "improved")

test_that("pso works", {
  expect_equal(
    typeof(
      global_wrapper(
        par     = par,
        fn      = fn,
        lower   = lb,
        upper   = ub,
        print   = FALSE,
        method  = "pso",
        control = ctrl2)
    ), "list"
  )
})


# 3) Test if GenSA works
global_min <- 0
tol <- 1e-13
ctrl3 <- list(threshold.stop = global_min + tol, trace = FALSE, max.time = 0.0015)

test_that("GenSA works", {
  expect_equal(
    typeof(
      global_wrapper(
        par     = par,
        fn      = fn,
        lower   = lb,
        upper   = ub,
        print   = FALSE,
        method  = "GenSA",
        control = ctrl3)
    ), "list"
  )
})


# 4) test if DeoptimR works

ctrl4 <- list(NP = 10 ,tol = 1e-3, trace = FALSE)

test_that("DeoptimR works", {
  expect_equal(
    typeof(
      global_wrapper(
        par     = par,
        fn      = fn,
        lower   = lb,
        upper   = ub,
        print   = FALSE,
        method  = "DEoptimR",
        control = ctrl4)
    ), "list"
  )
})


# 5) test if adagio simpleDE works

ctrl5 <- list(popsize  = 10,
              nmax     = 20,
              r        = 0.41,
              confined = TRUE,
              trace    = FALSE)

test_that("adagio_simpleDE works", {
  expect_equal(
    typeof(
      global_wrapper(
        fn = fn,
        lower = lb,
        upper = ub,
        print = FALSE,
        method = "adagio_simpleDE",
        control = ctrl5)
    ), "list"
  )
})

test_that("ecr works", {
  expect_equal(
    typeof(
      global_wrapper(
        fn = fn,
        lower = -1,
        upper = 1,
        method = "ecr",
        print = FALSE)
    ), "list"
  )
})
