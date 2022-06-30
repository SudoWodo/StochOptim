library(devtools)
load_all()
control <- list(popsize = 100, maxiter = 50,
  DEoptim = list(tol = 1e-10), GenSA = list(maxiter = 100))

control <- list(DEoptim = list(tol = 1e-10))
sopm(fn = fn,lower = lb, upper = ub, method =c("DEoptim","GenSA") ,control= control)

l <- list(aa = 10, b = 20, d = list(aa = 1, bb = 2), e = list(xx = 5, zz = 6))
c <- which(sapply(l, is.list) == TRUE)
items <- l[-c]

for( list in l[c]){
  if(item %in% list){
    pass
  } else {
    list$
  }
}


for(m in method){
  stopifnot(m %in% method_list)
}
