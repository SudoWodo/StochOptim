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
    vcontrol = NULL,   # valid control
    trace    = NULL,
    control  = list(),

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
    checkinstallation = function() {

      # method name == package name? (check this once!)
      if (!requireNamespace(self$method, quietly = TRUE)) {
        warnmsg  <- paste("Package", method, "not available. Please install it!")
        warning(warnmsg, call. = FALSE)
      }
    },

    # translate control
    translatecontrol = function() {
      for( i in names(self$control)) {
        if( i %in% names(self$vcontrol)) {
          index <- which( i == names(self$vcontrol))
          name <- self$vcontrol[index]
          if( i != name) {
            self$control[name] <- self$control[i]
            self$control[i] <- NULL
          }
        }
      }
    },

    # change default_control with passed control
    changedefaultcontrol = function() {
      for ( i in names(self$control)) {
        self$default_control[i] <- self$control[i]
      }
      self$control <- self$default_control
    },

    # control list check
    checkcontrol = function() {

      # TODO implement checks for empty strings, NULL and NA in ctrl list

      ctrlcheck <- (names(self$control) %in% self$vcontrol  |
                      names(self$control) %in% names(self$vcontrol))

      if(!all(ctrlcheck)) {
        wrongctrl <- which(ctrlcheck == FALSE)
        stopmsg <- paste("Unknown names in control:",
                         names(self$control)[wrongctrl],"\n")
        stop(stopmsg, call. = FALSE)
      }

    }
  ) # end public list
) # end optimizer_wrapper class


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
