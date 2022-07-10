fn <- function(x, a = 1) {return( x^2 + a)}

par = 1.5
lb <- -1
ub <- 1

DEoptim_list = list(
  popsize = 10*length(lb),
  maxiter = 200*length(lb),
  tol  = 1e-10,
  trace   = 0)

adagio_simpleDE_list = list(
  popsize  = 70,
  nmax     = 230,
  r        = 0.41,
  confined = TRUE,
  trace    = FALSE)

GenSA_list  = list(maxiter = 100)
pso_list    = list(abstol= 1e-8, hybrid = "improved")
DEoptimR_list = list(tol = 1e-7, trace = FALSE)

control <- list(
  DEoptim = DEoptim_list,
  GenSA = GenSA_list,
  pso = pso_list,
  DEoptimR  = DEoptimR_list,
  adagio_simpleDE = adagio_simpleDE_list)

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
