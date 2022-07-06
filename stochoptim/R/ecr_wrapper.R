# ecr -------------------------------------------------------
#' @importFrom parallelMap parallelMap

ecr_wrapper <- R6Class(
  classname = "ecr_wrapper",
  inherit = optimizer_wrapper,

  public = list(

    default_control = NULL,

    # vcontrol
    vcontrol = c("minimize",
                 "n.objectives",
                 "n.dim",
                 "lower",
                 "upper",
                 "n.bits",
                 "representation",
                 popsize = "mu",
                 "lambda",
                 "perm",
                 "p.recomb",
                 "p.mut",
                 "survival.strategy",
                 "n.elite",
                 "custom.constants",
                 "log.stats",
                 "log.pop" ,
                 "monitor",
                 "initial.solutions",
                 "parent.selector",
                 "survival.selector",
                 "mutator",
                 "recombinator",
                 "terminators" ),

    ## setting up parameters required by ecr to execute
    # assignvalue = function() {
    #   self$control$n.dim <- length(self$lower)
    #   self$control$mu    <- 10*length(self$lower)
    #   self$control$lambda <- 10
    #
    # },

    # check package installation
    checkinstallation = function() {

      # method name == package name? (check this once!)
      if (!require("ecr", quietly = TRUE)) {
        warnmsg  <- paste("Package", method, "not available. Please install it!")
        warning(warnmsg, call. = FALSE)
      }

      # if (!require("parallelMap", quietly = TRUE)) {
      #   warnmsg  <- paste("Package", method, "not available. Please install it to use ecr!")
      #   warning(warnmsg, call. = FALSE)
      # }


    },

    ## NOTE n.bits is not written for now
    setdefaultlcontrol = function() {
      self$default_control = list(
        minimize          = TRUE,
        n.objectives      = 1L,                     # NOTE just wrote 1 for now
        n.dim             = length(self$lower),     # NOTE
        representation    = "float",                # NOTE float for now
        mu                = 10*length(self$lower),  # NOTE copied from GenSA
        lambda            = 10, # I don't know
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
        mutator           = ecr::setup(ecr::mutGauss, lower = self$lower, upper = self$upper),
        recombinator      = NULL,
        terminators       = list(ecr::stopOnIters(100L))
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
      startTime <- Sys.time()

      self$ans <- ecr::ecr(
        fitness.fun       = self$fn,
        minimize          = self$control$minimize,
        n.objectives      = self$control$n.objectives,
        n.dim             = self$control$n.dim,
        lower             = self$lower,
        upper             = self$upper,
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

      endTime <- Sys.time()
      self$ans$time <- endTime - startTime
    },

    printoutput = function(print) {
      output <- list(
        par = self$ans$best.x[[1]],
        value = self$ans$best.y,
        message = self$ans$message
      )
      if(print) {

        print(output)
      }

      return(output)
    }

  ) # end public list
) # end ecr_wrapper class
