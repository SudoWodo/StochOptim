library(devtools)
load_all()

fn = function(x) {
  sum(x^2)
}

lower = c(-5, -5); upper = c(5, 5)

ctrl6 <- list()

global_wrapper(fn = fn, lower = lower, upper = upper, method = "ecr")

# requireNamespace("ecr")
# ?ecr::setup()
# bf = ecr::setup(ecr::mutBitflip, p = 0.3)
# ecr::mutBitflip()
