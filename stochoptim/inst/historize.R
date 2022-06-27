historize <- function(fn) {
  local({
    H <- numeric()
    myFun <- function(x) {
      if(missing(x)) {
        return(H)
      } else {
        y <- fn(x)
        H <<- rbind(H, c(x, y))
        return(y)
      }
    }
    return(myFun)
  })
}

fun <- historize(adagio::fnHald)
lb <- rep(-1, 5); ub <- rep(1, 5)
sol <- DEoptim::DEoptim(fun, lb, ub)
## [...]

M <- fun()
m <- nrow(M); n <- ncol(M)
fvalues <- M[, n]

for (i in 1:m) fvalues[i] <- min(fvalues[1:i])
plot(fvalues, type = 'l', col = "navy")
grid()
fun()


rastrigin <- function(x) {
  y <- ( 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x)))
  return(y)
}

D <- 10
lb <- rep(-5.2, D)
ub <- rep(5.2, D)

res = ecr(rastrigin, n.dim = length(lb), n.objectives = 1L, lower = lb, upper = ub,
          representation = "float", mu = 20L, lambda = 10L,
          mutator = setup(mutGauss, lower = lb, upper = ub))
