fn <- function(x, a = 1) {return( x^2 + a)}

par = 1.5
lb <- -1
ub <- 1

DEoptim = list(
  popsize = 10*length(lb),
  maxiter = 20*length(lb),
  tol  = 1e-3,
  trace   = FALSE)

GenSA  = list(maxiter = 10)
pso    = list(abstol= 1e-3, hybrid = "improved")
DEoptimR = list(tol = 1e-3, trace = FALSE)
adagio_simpleDE = list(
  popsize  = 20,
  nmax     = 23,
  r        = 0.40,
  confined = TRUE,
  trace    = FALSE)

control <- list(DEoptim, GenSA, pso, DEoptimR, adagio_simpleDE)



test_that("sopm works", {
  expect_equal(
    typeof(
      sopm(par = par,
           fn = fn,
           lower = lb,
           upper = ub,
           method = c("DEoptim", "GenSA","pso","DEoptimR","adagio_simpleDE"),
           control= control
           )
    ), "list"
  )
})
