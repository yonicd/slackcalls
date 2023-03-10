rate_limit_set <- function(slack_method, rate_limit) {
  if (missing(rate_limit)) {
    if (
      is.null(.slack$rate_limits[[slack_method]]) &&
        slack_method %in% names(rate_limits_known)
    ) {
      rate_limit <- rate_limits_known[[slack_method]]
    } else {
      # Nothing to set.
      return(NULL)
    }
  }

  # At this point either they sent in rate_limit or we set it to something,
  # possibly a length-0 integer. Treat that the same as NULL.
  if (!length(rate_limit)) {
    .slack$rate_limits[[slack_method]] <- NULL
  } else {
    .slack$rate_limits[[slack_method]]$rate_limit <- rate_limit
    if (is.null(.slack$rate_limits[[slack_method]]$calls)) {
      .slack$rate_limits[[slack_method]]$calls <- integer()
    }
  }
}

rate_limit_check <- function(slack_method) {
  if (!is.null(.slack$rate_limits[[slack_method]])) {
    rate_limit_drop_old_calls(slack_method)
    rate_limit_wait(slack_method)
    rate_limit_append_now(slack_method)
  }
}

rate_limit_drop_old_calls <- function(slack_method) {
  now_ts <- as.integer(Sys.time())
  last_minute <- now_ts - 60L
  calls <- .slack$rate_limits[[slack_method]]$calls
  .slack$rate_limits[[slack_method]]$calls <- calls[calls >= last_minute]
}

rate_limit_wait <- function(slack_method) {
  # I did this as a while to avoid any weird race-time conditions where we end
  # up waiting a fraction of a second less than we should or something.
  while (length(.slack$rate_limits[[slack_method]]$calls) >=
    .slack$rate_limits[[slack_method]]$rate_limit) {
    # Wait until the first one was at least a minute ago.
    wait_seconds <- 60L - (
      as.integer(Sys.time()) - .slack$rate_limits[[slack_method]]$calls[[1]]
    ) + 1L
    wait_seconds <- max(wait_seconds, 1L)
    Sys.sleep(wait_seconds)

    # Drop any that are now older than the cutoff.
    rate_limit_drop_old_calls(slack_method)
  }
}

rate_limit_append_now <- function(slack_method) {
  rate_limit_append_ts(slack_method, as.integer(Sys.time()))
}

rate_limit_append_ts <- function(slack_method, ts) {
  # I pulled this out to make it easier to add fake calls for testing purposes.
  .slack$rate_limits[[slack_method]]$calls <- c(
    .slack$rate_limits[[slack_method]]$calls,
    ts
  )
}

rate_limit_reset_calls <- function(slack_method) {
  .slack$rate_limits[[slack_method]]$calls <- NULL
}

see_env <- function() {
  return(.slack$rate_limits)
}
