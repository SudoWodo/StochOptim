#' @importFrom R6 R6Class
#'
#'

# optimizer_wrapper -----------------------------------------
optimizer_wrapper <- R6::R6Class(
  classname = "optimizer_wrapper",

  public = list(
    ans      = NULL,
    par      = NULL,
    fn       = NULL,
    lower    = NULL,
    upper    = NULL,
    method   = NULL,
    control  = list(),
    vcontrol = NULL,   # valid control

    # constructor
    initialize = function(par     = NULL,
                          fn      = NULL,
                          lower   = NULL,
                          upper   = NULL,
                          method  = NULL,
                          control = list()){

      self$par     = par
      self$fn      = fn
      self$lower   = lower
      self$upper   = upper
      self$method  = method
      self$control = control
    },

    # check package installation
    checkinstallation = function(){

      # method name == package name? (check this once!)
      if (!requireNamespace(self$method, quietly = TRUE)) {
        warnmsg  <- paste("Package", method, "not available. Please install it!")
        warning(warnmsg, call. = FALSE)
      }
    },

    # control list check
    checkcontrol = function(){
      ctrlcheck <- (names(self$control) %in% self$vcontrol)
      if(!all(ctrlcheck)){
        wrongctrl <- which(ctrlcheck == FALSE)
        stopmsg <- paste("Unknown names in control:",
                         names(self$control)[wrongctrl],"\n")
        stop(stopmsg, call. = FALSE)
      }

    }
  ) # end public list
) # end optimizer_wrapper class




#DEoptim -----------------------------------------------------------------

DEoptim_wrapper <- R6::R6Class(

  classname = "DEoptim_wrapper",
  inherit = optimizer_wrapper,
  public = list(

    vcontrol = c("VTR", "strategy", "bs", "NP", "itermax", "CR", "F", "trace",
                 "initialpop", "storepopfrom", "storepopfreq", "p", "c",
                 "reltol", "steptol", "parallelType", "cluster", "packages",
                 "parVar", "foreachArgs"),

    # call the optimizer
    calloptimizer = function(){
      self$ans <- DEoptim::DEoptim(fn      = self$fn,
                                   lower   = self$lower,
                                   upper   = self$upper,
                                   control = self$control
      )

      return(self$ans)
    },

    # for nicely printing out the answer
    printoutput = function(){
      output <- list(
        par     = self$ans$optim$bestmem,
        value   = self$ans$optim$bestval,
        counts  = c(`function` = self$ans$optim$nfeval)
      )

      print(output)
    }

  ) # end public list
) # end DEoptim_wrapper class



#pso ---------------------------------------------------------------------

pso_wrapper <- R6::R6Class(
  classname = "pso_wrapper",
  inherit = optimizer_wrapper,
  public = list(

    vcontrol = c("trace", "fnscale", "maxit", "maxf", "abstol", "reltol",
                 "REPORT", "trace.stats", "s", "k", "p", "w", "c.p", "c.g",
                 "d", "v.max", "rand.order", "max.restart", "maxit.stagnate",
                 "vectorize", "hybrid", "hybrid.control", "type"),

    calloptimizer = function(){
      self$ans <- pso::psoptim(par     = self$par,
                               fn      = self$fn,
                               lower   = self$lower,
                               upper   = self$upper,
                               control = self$control
      )

      return(self$ans)
    },

    printoutput = function(){
      output <- list(
        par       = self$ans$par,
        value     = self$ans$value,
        counts    = self$ans$counts,
        converged = self$ans$convergence,
        message   = self$ans$message
      )

      print(output)
    }
  ) # end public list
) # end pso__wrapper class


#GenSA ------------------------------------------------------------------
GenSA_wrapper <- R6::R6Class(
  classname = "GenSA_wrapper",
  inherit = optimizer_wrapper,

  public = list(

    vcontrol = c("maxit", "threshold.stop" , "nb.stop.improvement", "smooth",
                 "max.call", "max.time", "temperature", "visiting.param",
                 "acceptance.param", "verbose", "simple.function", "trace.mat",
                 "seed"),

    # call the optimizer
    calloptimizer = function(){
      self$ans <- GenSA::GenSA(par     = self$par,
                               fn      = self$fn,
                               lower   = self$lower,
                               upper   = self$upper,
                               control = self$control
      )

      return(self$ans)
    },

    # for nicely printing out the answer
    printoutput = function(){
      output <- list(
        par     = self$ans$par,
        value   = self$ans$value,
        counts  = c(`function` = self$ans$counts)
      )

      print(output)
    }
  ) # end public list
) # end GenSA



# adagio_simpleDE--------------------------------------------------



adagio_simpleDE_wrapper <- R6Class(

  classname = "adagio_simpleDE_wrapper",
  inherit = optimizer_wrapper,
  public = list(

    vcontrol = c("N", "nmax", "r", "confined", "log"),

    # set default control
    default_control = list(N        = 64,
                           nmax     = 256,
                           r        = 0.4,
                           confined = TRUE,
                           log      = FALSE),

    # change default_control with passed control
    changedefaultcontrol = function() {
      for (i in names(self$control)) {
        self$default_control[i] <- self$control[i]
      }
      self$control <- self$default_control
    },

    # call the optimizer
    calloptimizer = function() {
      self$ans <- adagio::simpleDE(fun      = self$fn,
                                   lower    = self$lower,
                                   upper    = self$upper,
                                   N        = self$control$N,
                                   nmax     = self$control$nmax,
                                   r        = self$control$r,
                                   confined = self$control$confined,
                                   log      = self$control$log)

      return(self$ans)
    },

    # for nicely printing out the answer
    printoutput = function() {
      output <- list(
        par     = self$ans$xmin,
        value   = self$ans$fmin,
        counts  = c(`function` = self$ans$nfeval)
      )

      print(output)
    }

  ) # end public list
) # end adagio_simpleDE_wrapper class


# DEoptimR--------------------------------------------------


DEoptimR_wrapper <- R6Class(
  classname = "DEoptimR_wrapper",
  inherit = optimizer_wrapper,
  public = list(
    d = NULL,
    default_control = NULL,

    vcontrol = c("constr","meq","eps","NP","Fl","Fu","tau_F","tau_CR","tau_pF",
                 "jitter_factor","tol","maxiter","fnscale","compare_to",
                 "add_to_init_pop","trace","triter","details"),

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

    # change default_control with passsed control
    changedefaultcontrol = function() {
      for (i in names(self$control)) {
        self$default_control[i] <- self$control[i]
      }
      self$control <- self$default_control
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



# ecr -------------------------------------------------------

ecr_wrapper <- R6Class(
  classname = "ecr_wrapper",
  inherit = optimizer_wrapper,

  public = list(

    default_control = NULL,

    # i know i have put comma in weirdest of places
    vcontrol = c("fitness.fun",       "minimize"         , "n.objectives"   ,
                 "n.dim"      ,       "lower"             ,"upper"          ,
                 "n.bits"     ,       "representation"  ,  "mu"             ,
                 "lambda"     ,       "perm"             , "p.recomb"       ,
                 "p.mut"      ,      "survival.strategy" ,"n.elite"         ,
                 "custom.constants"  ,"log.stats"         ,"log.pop"        ,
                 "monitor"    ,       "initial.solutions" ,"parent.selector",
                 "survival.selector" ,"mutator"           ,"recombinator"   ,
                 "terminators" ),

    ## NOTE n.bits is not written for now
    setdefaultlcontrol = function() {
      self$default_control = list(
        minimize          = TRUE,
        n.objectives      = 1L,                     # NOTE just wrote 1 for now
        n.dim             = length(self$lower),     # NOTE
        representation    = "float",                # NOTE float for now
        mu                = 10*length(self$lower),  # NOTE copied from GenSA
        lambda            = 10*length(self$lower)/2,# I don't know
        perm              = NULL,
        p.recomb          = 0.7,
        p.mut             = 0.3,                   # NOTE documentation and actual value differ
        survival.strategy = "plus",
        n.elite           = 0,
        custom.constants  = list(),
        log.stats         = list(fitness = list("min", "mean", "max")),
        log.pop           = FALSE,
        monitor           = NULL,
        initial.solutions = NULL,
        parent.selector   = NULL,
        survival.selector = NULL,
        mutator           = NULL,
        recombinator      = NULL,
        terminators       = list(stopOnIters(100L))
          )
    },


    # change default_control with passed control
    changedefaultcontrol = function() {
      for (i in names(self$control)) {
        self$default_control[i] <- self$control[i]
      }
      self$control <- self$default_control
    },

    ## NOTE n.bits is not written for now
    calloptimizer = function() {
      self$ans <- ecr::ecr(
        fitness.fun       = self$fn,
        minimize          = self$control$minimize,
        n.objectives      = self$control$n.objectives,
        n.dim             = self$control$n.dim,
        representation    = self$control$representation,
        mu                = self$control$mu,
        lambda            = self$control$lambda,
        perm              = self$control$perm,
        p.recomb          = self$control$p.recomb,
        p.mut             = self$control$p.mut,
        survival.strategy = self$control$survival.strategy,
        n.elite           = self$control$n.elite,
        custom.constants  = self$control$custom.constants,
        log.stats         = self$control$log.stats,
        log.pop           = self$control$log.pop,
        monitor           = self$control$monitor,
        initial.solutions = self$control$initial.solutions,
        parent.selector   = self$control$parent.selector,
        survival.selector = self$control$survival.selector,
        mutator           = self$control$mutator,
        recombinator      = self$control$recombinator,
        terminators       = self$control$terminators
      )
    },

    printoutput = function() {
      output <- list(
        par = self$ans$best.x,
        value = self$ans$best.y,
        message = self$ans$message
      )

      print(output)
    }

  ) # end public list
) # end ecr_wrapper class
