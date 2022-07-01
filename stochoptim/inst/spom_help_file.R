library(devtools)
load_all()
control <- list(popsize = 100, maxiter = 50,
  DEoptim = list(tol = 1e-10), GenSA = list(maxiter = 100))
par <- rep(3.3, D)
control <- list(DEoptim = list(tol = 1e-10))
sopm(par = par, fn = fn,lower = lb, upper = ub, method =c("DEoptim","GenSA") ,control= control)

l <- list(aa = 10, b = 20, d = list(aa = 1, bb = 2), e = list(xx = 5, zz = 6))
c <- which(sapply(l, is.list) == TRUE)
items <- l[-c]


for(m in method){
  stopifnot(m %in% method_list)
}


control <- list(popsize = 100, maxiter = 50,
                DEoptim = list(tol = 1e-10), GenSA = list(maxiter = 100))


# adding common controls to each solvers
list <- which(sapply(control, is.list) == TRUE)
items <- control[-list] # items which are not list

# removing common controls from method
# control[-list] <- NULL

# final data frame
result <- NULL

for( m in list) {
  for(i in names(items)){
    if(!(i %in% names(control[[m]]))){
      control[[m]][i] <- items[i]
    }
  }
}

items["popsize"]
list
control[[m]]["abc"] <- "123"
control

for ( i in names(items)){
  print(i)
}

for( m in names(control[list])) {
  print(m)
}
