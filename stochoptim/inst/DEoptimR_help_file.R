fn <- rastrigin <- function(x) {
  y <- ( 10 * length(x) + sum(x^2 - 10 * cos(2 * pi * x)))
  return(y)
}

D <- 10
lower <- lb <- rep(-5.2, D)
upper <- ub <- rep(5.2, D)
par <- rep(3.3, D)

# DEoptimR::JDEoptim(lower = lb, upper = ub, fn = fn, trace = TRUE, triter = 10)
# ans <- global_wrapper(par, fn, lb, ub, "DEoptimR", control = list(trace = 0))



d = length(lower)
default_control = list(constr         = NULL,
                            meq             = 0,
                            eps             = 1e-05,
                            NP              = 10 * d,
                            Fl              = 0.1,
                            Fu              = 1,
                            tau_F           = 0.1,
                            tau_CR          = 0.1,
                            tau_pF          = 0.1,
                            jitter_factor   = 0.001,
                            tol             = 1e-15,
                            maxiter         = 200 * d,
                            fnscale         = 1,
                            compare_to      = c("median", "max"),
                            add_to_init_pop = NULL,
                            trace           = FALSE,
                            triter          = 1,
                            details         = FALSE)

control <- default_control
printtrace < - FALSE

if("trace" %in% names(control)) {
  switch (
    as.character(control$trace),

    '0' = {
      control$trace <- FALSE
      printtrace <- FALSE
    },
    '1' = {
      control$trace <- FALSE
      printtrace <- TRUE
    },
    '2' = {
      control$trace <- TRUE
      printtrace <- TRUE
      control$triter <- 100
    },
    '3' = {
      control$trace <- TRUE
      printtrace <- TRUE
      control$triter <- 50
    },
    '4' = {
      control$trace <- TRUE
      printtrace <- TRUE
      control$triter <- 10
    },
    '5' = {
      control$trace <- TRUE
      printtrace <- TRUE
      control$triter <- 1
    }
  )
}



ans <- DEoptimR::JDEoptim(
  lower           = lower,
  upper           = upper,
  fn              = fn,
  constr          = control$constr,
  meq             = control$meq,
  eps             = control$eps,
  NP              = control$NP,
  Fl              = control$Fl,
  Fu              = control$Fu,
  tau_F           = control$tau_F,
  tau_CR          = control$tau_CR,
  tau_pF          = control$tau_pF,
  jitter_factor   = control$jitter_factor,
  tol             = control$tol,
  maxiter         = control$maxiter,
  fnscale         = control$fnscale,
  compare_to      = control$compare_to,
  add_to_init_pop = control$add_to_init_pop,
  trace           = control$trace,
  triter          = control$triter,
  details         = control$details
)
