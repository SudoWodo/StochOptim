fn <- rastrigin <- function(x) {
  y <- ( 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x)))
  return(y)
}

D <- 10
lower <- lb <- rep(-5.2, D)
upper <- ub <- rep(5.2, D)
par <- rep(3.3, D)

test_that("invalid method throws error", {
  expect_error(
    soptim(fn = rastrigin,
                   lower = lb,
                   upper = ub,
                   method = "Not a method",
                   control = list()
    ),
    "method not found !"
  )
})


test_that("NULL method throws error", {
  expect_error(
    soptim(fn = rastrigin,
                   lower = lb,
                   upper = ub,
                   method = NULL,
                   control = list()
    ),
    "method cannot be NULL !"
  )
})
