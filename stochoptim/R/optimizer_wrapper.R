#' @importFrom R6 R6Class
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
                          control = list())
      {

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
        warnmsg  <- paste("Package", self$method, "not available. Please install it!")
        message(warnmsg)
        notFound = TRUE
        return(notFound)
      }
    },

    # translate control
    translatecontrol = function() {
      for( i in names(self$control)) {
        if( i %in% names(self$vcontrol)) {
          index <- which( i == names(self$vcontrol))
          name <- self$vcontrol[index][[1]]
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
        stopmsg <- paste("package",self$method,"->","Unknown names in control:",
                         names(self$control)[wrongctrl],"\n")
        print(self$control[wrongctrl])
        self$control[wrongctrl] <- NULL
        warning(stopmsg, call. = FALSE)
        warning("Proceeding by ignoring above controls", call. = FALSE)
      }

    }
  ) # end public list
) # end optimizer_wrapper class
