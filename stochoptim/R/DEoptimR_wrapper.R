# DEoptimR--------------------------------------------------


DEoptimR_wrapper <- R6Class(
  classname = "DEoptimR_wrapper",
  inherit = optimizer_wrapper,
  public = list(
    d = NULL,
    default_control = NULL,

    vcontrol = c("constr","meq","eps",popsize = "NP","Fl","Fu","tau_F","tau_CR","tau_pF",
                 "jitter_factor",tol = "tol",maxiter = "maxiter","fnscale","compare_to",
                 "add_to_init_pop",trace = "trace","triter","details"),

    setdefaultlcontrol = function() {
      d = length(self$lower)
      self$default_control = list(constr         = NULL,
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
    },

    # call the optimizer
    calloptimizer = function(){
      self$ans <- DEoptimR::JDEoptim(
        lower           = self$lower,
        upper           = self$upper,
        fn              = self$fn,
        constr          = self$control$constr,
        meq             = self$control$meq,
        eps             = self$control$eps,
        NP              = self$control$NP,
        Fl              = self$control$Fl,
        Fu              = self$control$Fu,
        tau_F           = self$control$tau_F,
        tau_CR          = self$control$tau_CR,
        tau_pF          = self$control$tau_pF,
        jitter_factor   = self$control$jitter_factor,
        tol             = self$control$tol,
        maxiter         = self$control$maxiter,
        fnscale         = self$control$fnscale,
        compare_to      = self$control$compare_to,
        add_to_init_pop = self$control$add_to_init_pop,
        trace           = self$control$trace,
        triter          = self$control$triter,
        details         = self$control$details
      )

      return(self$ans)
    },

    # for nicely printing out the answer
    printoutput = function(){
      output <- list(
        par     = self$ans$par,
        value   = self$ans$value,
        counts  = c(`function` = self$ans$counts),
        convergence = self$ans$convergence
      )

      print(output)
    }

  ) # end public list
) # end DEoptimR_wrapper
