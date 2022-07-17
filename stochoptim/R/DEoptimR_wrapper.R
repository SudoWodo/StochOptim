# DEoptimR--------------------------------------------------


DEoptimR_wrapper <- R6Class(
  classname = "DEoptimR_wrapper",
  inherit = optimizer_wrapper,
  public = list(
    d = NULL,
    default_control = NULL,
    printtrace = FALSE,

    vcontrol = c(popsize = "NP",
                 tol     = "tol",
                 maxiter = "maxiter",
                 trace   = "trace",

                 "constr",
                 "meq",
                 "eps",
                 "Fl",
                 "Fu",
                 "tau_F",
                 "tau_CR",
                 "tau_pF",
                 "jitter_factor",
                 "fnscale",
                 "compare_to",
                 "add_to_init_pop",
                 "triter",
                 "details"),

    tracetranslation = function() {
      if("trace" %in% names(self$control)) {
        switch (as.character(self$control$trace),
           '0' = {
             self$control$trace = FALSE
             self$printtrace = FALSE
           },
           '1' = {
             self$control$trace = FALSE
             self$printtrace = TRUE
           },
           '2' = {
             self$control$trace = TRUE
             self$printtrace = TRUE
             self$control$triter = 100
           },
           '3' = {
             self$control$trace = TRUE
             self$printtrace = TRUE
             self$control$triter = 50
           },
           '4' = {
             self$control$trace = TRUE
             self$printtrace = TRUE
             self$control$triter = 10
           },
           '5' = {
             self$control$trace = TRUE
             self$printtrace = TRUE
             self$control$triter = 1
           }
        )
      }
    },

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
    calloptimizer = function(...){
      cat("Running -> DEoptimR::JDEoptim \n")
      startTime <- Sys.time()
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
        details         = self$control$details,
        ...
      )

      endTime <- Sys.time()
      self$ans$time <- endTime - startTime
      return(self$ans)
    },

    # for nicely printing out the answer
    printoutput = function(){

      output <- list(
        par     = self$ans$par,
        value   = self$ans$value,
        counts  = c(`function` = self$ans$counts),
        convergence = self$ans$convergence,
        time    = self$ans$time
      )

      if(self$printtrace){
        print(output)
      }

      return(output)

    }

  ) # end public list
) # end DEoptimR_wrapper
