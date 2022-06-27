test_that("invalid method throws error", {
  expect_error(
    global_wrapper(fn = rastrigin,
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
    global_wrapper(fn = rastrigin,
                   lower = lb,
                   upper = ub,
                   method = NULL,
                   control = list()
    ),
    "method cannot be NULL !"
  )
})
