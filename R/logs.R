
session_get_log_types <- function(self, private) {

  response <- private$make_request(
    "GET LOG TYPES"
  )

  response$value
}

#' @importFrom utils tail

session_read_log <- function(self, private, type) {

  "!DEBUG session_read_log `type`"
  assert_string(type)

  response <- private$make_request(
    "READ LOG",
    list(type = unbox(type))
  )

  logs <- response$value

  ## Current (2.1.1) phantomjs/ghostdriver has a bug, and the log
  ## buffer is not cleared, and phantomjs always sends the full log
  ## of the session. We count the number of lines sent, and get rid of
  ## the ones that we have already seen

  if (identical(private$parameters$browserName, "phantomjs") &&
      !is.null(ver <- private$parameters$version) &&
      numeric_version(ver) <= numeric_version("2.1.1")) {
    if (private$num_log_lines_shown != 0) {
      logs <- tail(logs, - private$num_log_lines_shown)
    }
    private$num_log_lines_shown <- length(response$value)
  }

  make_logs(logs)
}

make_logs <- function(logs) {
  logs <- log_rows_to_df(logs)

  logs$timestamp <- as.POSIXct(
    logs$timestamp / 1000,
    origin = "1970-01-01"
  )

  class(logs) <- c("webdriver_logs", class(logs))

  logs
}

log_rows_to_df <- function(logs) {
  data.frame(
    stringsAsFactors = FALSE,
    timestamp = vapply(logs, "[[", 1, "timestamp"),
    level = vapply(logs, "[[", "", "level"),
    message = vapply(logs, "[[", "", "message")
  )
}

#' @export

print.webdriver_logs <- function(x, ...) {
  s <- paste(
    format(x$timestamp, "%H:%M:%S"),
    substr(x$level, 1, 1),
    x$message
  )
  cat(strwrap(s, exdent = 2), sep = "\n")

  invisible(x)
}
