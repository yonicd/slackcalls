rate_limit_set <- function(slack_method, rate_limit) {
  if (is.null(rate_limit)) {
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
  while (
    length(.slack$rate_limits[[slack_method]]$calls) >=
    .slack$rate_limits[[slack_method]]$rate_limit
  ) {
    # Wait until the first one was at least a minute ago.
    wait_seconds <- 60 - (
      as.integer(Sys.time()) - .slack$rate_limits[[slack_method]]$calls[[1]]
    )

    Sys.sleep(max(wait_seconds, 1))

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
