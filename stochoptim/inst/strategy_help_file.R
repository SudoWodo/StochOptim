library(devtools)
load_all()

method <- c("DEoptim", "GenSA")
control <- list(popsize = 100, maxiter = 50,
                DEoptim = list(tol = 1e-10, strategy = c(2,3)), GenSA = list(maxiter = 1000))

res <- sopm(par, fn, lower, upper, method = method, control = control)
print(res)
method_list <- c("DEoptim", "GenSA","pso","DEoptimR","adagio_simpleDE")
allowed_common_control <- c("maxiter","popsize")
strategy <- FALSE
strategy_method <- c()
passed_common_control <- which(sapply(control, is.list) == FALSE)

## ask for mentor's comment (keeping it rigid for now)
# Common control check
common_control_check<- names(control[passed_common_control]) %in% allowed_common_control
if(!all(common_control_check)){
  stopmsg <- paste("passed control are not common between solvers !")
  stop(stopmsg)
}

# # Method check
# for(m in method){
#   if(m %in% method_list){
#   } else {
#     stopmsg <- paste("Method", m,"not found !")
#     stop(stopmsg, call. = FALSE)
#   }
# }

# adding common controls to each solvers
list <- which(sapply(control, is.list) == TRUE)
items <- control[-list] # items which are not list


# appending common controls to optimizer controls
for( l in list) {
  #l <- list[1]
  cat("l: ",l,"\n")
  for(n in names(items)){
    if(!(n %in% names(control[[l]]))){
      control[[l]][n] <- items[n]
    }
  }
  for (n in names(control[[l]])) {
    #n <- names(control[[l]])[2]
    cat("n: ",n, "\n")
    if(n == "strategy") {
      #strategy_method <- names(l)
      strategy_method <- append(strategy_method, names(control[l]))
      strategy = TRUE
    }
  }
}


if(strategy){
  #l <- list[1]
  for(strat in  strategy_method){
    #strat <- strategy_method[1]
    strat_name <- control[[strat]]$strategy
    new_names<- paste(strategy_method,"_strat_",strat_name , sep = "")
    method <- append(method, new_names)
    for(name in new_names){
      #name <- new_names[1]
      strat_no <- which(name == new_names)
      #cat("strat_no: ",strat_no,"\n")
      control[name] <- control[strat]
      #cat("control: ",control[[strat]]$strategy[strat_no],"\n")
      control[[name]]$strategy <- NULL
      control[[name]]$strategy <- control[[strat]]$strategy[strat_no]
    }
  }
}

gsub('_strat_[0-9]','',new_names)
gsub('_strat_[0-9]','',"DEoptim")


for( m in method) {
  meth <- gsub('_strat_[0-9]','',m)
  print(meth)
}
