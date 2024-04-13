# To prevent using the scientific notation to display floating point numbers
options(scipen = 9999)

#' The \code{DEBUG} log level constant
#' @export
LOG_DEBUG = "DEBUG"

#' The \code{INFO} log level constant
#' @export
LOG_INFO  = "INFO"

#' The \code{WARN} log level constant
#' @export
LOG_WARN  = "WARN"

#' The \code{IOTC} EIO - TO BE REDEFINED
#' @export
LOG_ERROR = "ERROR"

LOG_LEVELS = data.frame(
  LEVEL = c(0, 1, 2, 3),
  LABEL = c(LOG_DEBUG, LOG_INFO, LOG_WARN, LOG_ERROR),
  stringsAsFactors = FALSE
)

LOG_ENV = new.env(hash = TRUE, parent = globalenv())
LOG_ENV$LOG_LEVEL = subset(LOG_LEVELS, LABEL == LOG_INFO)$LEVEL

#' Sets the current log level (increasing order of severity: \code{\link{LOG_DEBUG}}, \code{\link{LOG_INFO}}, \code{\link{LOG_WARN}}, \code{\link{LOG_ERROR}}).
#' @param log_level The log level to set
#' @export
set_log_level = function(log_level) {
  LEVEL_SET = subset(LOG_LEVELS, LABEL == log_level)$LEVEL

  if(is.na(LEVEL_SET)) stop(paste0("Wrong log level provided: ", log_level))

  cat(paste0("Log level: ", subset(LOG_LEVELS, LEVEL == LEVEL_SET)$LABEL))

  LOG_ENV$LOG_LEVEL = LEVEL_SET
}

#' Retrieved the current log level (increasing order of severity: \code{\link{LOG_DEBUG}}, \code{\link{LOG_INFO}}, \code{\link{LOG_WARN}}, \code{\link{LOG_ERROR}}).
#' @return the label for the current log level
#' @export
get_log_level = function() {
  return(
    subset(LOG_LEVELS, LEVEL == LOG_ENV$LOG_LEVEL)$LABEL
  )
}

log_ = function(severity = LOG_INFO, text = "Log message", prefix = NA) {
  severity_level = subset(LOG_LEVELS, LABEL == severity)$LEVEL

  if(LOG_ENV$LOG_LEVEL <= severity_level) {
    cat(paste0("[ ", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), " ] : [ ", severity, " ] : ", ifelse(is.na(prefix), "", paste0("{ ", prefix, " } : ")), text, "\n"), file = stderr())
  }

  return(invisible())
}

#' Logs a message with \code{\link{LOG_DEBUG}} severity.
#' @param text The message to log
#' @param prefix A message-specific prefix (defaults to \code{NA})
#' @export
log_debug = function(text = "DEBUG message", prefix = NA) {
  log_(LOG_DEBUG, text, prefix)

  return(invisible())
}

#' Logs a message with \code{\link{LOG_INFO}} severity.
#' @param text The message to log
#' @param prefix A message-specific prefix (defaults to \code{NA})
#' @export
log_info = function(text = "INFO message", prefix = NA) {
  log_(LOG_INFO, text, prefix)

  return(invisible())
}

#' Logs a message with \code{\link{LOG_WARN}} severity.
#' @param text The message to log
#' @param prefix A message-specific prefix (defaults to \code{NA})
#' @export
log_warn = function(text = "WARN message", prefix = NA) {
  log_(LOG_WARN, text, prefix)

  return(invisible())
}

#' Logs a message with \code{\link{LOG_ERROR}} severity.
#' @param text The message to log
#' @param prefix A message-specific prefix (defaults to \code{NA})
#' @export
log_error = function(text = "ERROR message", prefix = NA) {
  log_(LOG_ERROR, text, prefix)

  return(invisible())
}

#' @rdname log_debug
#' @export
DEBUG = log_debug

#' @rdname log_info
#' @export
INFO = log_info

#' @rdname log_warn
#' @export
WARN = log_warn

#' @rdname log_error
#' @export
ERROR = log_error
