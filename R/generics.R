#' @title Call a Slack API Method
#' @description Safely call a Slack API method, with automatic pagination.
#' @param slack_method Character. The Slack API method to call, such as
#'   "conversations.history".
#' @param token Character. Your Slack API token.
#' @param max_results Integer. The maximum number of results to return (total).
#'   Note: The actual maximum will be \code{max_results} rounded up to a
#'   multiple of \code{limit}. Default: Inf
#' @param max_calls Integer. The maximum number of separate API calls to make
#'   while constructing the response. Default: Inf
#' @param limit Integer. The number of results to fetch per call. Default:
#'   1000L
#' @param ... Additional arguments to pass to the body of the method call. Note:
#'   if you pass an explicit \code{limit}, this may cause conflicts. We
#'   recommend using \code{max_results} and \code{max_calls}.
#' @return A list with an additional class corresponding to \code{slack_method}.
#' @examples
#' \dontrun{
#' post_slack(
#'   slack_method = "conversations.history",
#'   channel = "general",
#'   token = "my_api_token"
#' )
#' }
#' @rdname post_slack
#' @export
post_slack <- function(slack_method,
                       token,
                       max_results = Inf,
                       max_calls = Inf,
                       limit = 1000L,
                       ...){

  body <- list(...)
  body$token <- token

  # Deal with maxes and limits.
  body$limit <- min(limit, max_results)

  res <- call_slack(slack_method, body = body)

  if (max_calls > 1 & max_results > body$limit)
    res <- paginate_(res, max_results = max_results, max_calls = max_calls)

  res

}

call_slack <- function(slack_method, body) {
  res <- validate_response(slack_method, body)

  cursor <- NULL

  if ("response_metadata" %in% names(res)) {
    cursor <- res[["response_metadata"]][["next_cursor"]]
  }

  structure(
    res,
    class = c(slack_method, class(res)),
    slack_method = slack_method,
    cursor = cursor,
    body = body
  )
}

#' @importFrom httr stop_for_status content POST
validate_response <- function(slack_method, body) {
  res <- httr::POST(
    url = file.path("https://slack.com/api", slack_method),
    body = body
  )
  httr::stop_for_status(res)

  res_content <- httr::content(res)

  if (!res_content$ok) { # nocov start
    stop(res_content$error)
  } # nocov end

  res_content
}

paginate_ <- function(res, max_results = Inf, max_calls  = Inf) {

  if (is.null(attr(res, "cursor")) | max_calls == 1) { # nocov start
    return(res)
  } # nocov end

  res_body <- attr(res, "body")

  # Call until we either hit max_results or max_calls.
  max_calls <- min(
    ceiling(max_results/res_body$limit),
    max_calls
  )

  i <- 1L
  cont <- TRUE
  output <- list()
  output[[i]] <- res
  slack_method <- attr(res, "slack_method")

  while (cont && i < max_calls) {

    cont <- nzchar(attr(output[[i]], "cursor")) && !is.null(attr(output[[i]], "cursor"))

    if (cont) {
      this_body <- attr(output[[i]], "body")
      this_body$cursor <- attr(output[[i]], "cursor")
      this_res <- call_slack(slack_method, body = this_body)

      output <- append(output, list(this_res))

      i <- i + 1
    }
  }

  # Combine the results as if everything came back in a single call.
  el <- setdiff(
    names(res),
    c(
      "ok", "response_metadata", "has_more", "is_limited", "pin_count",
      "channel_actions_ts", "channel_actions_count","cache_ts","offset"
    )
  )

  el_list <- lapply(output, function(x, what) x[[what]], what = el)

  res[[el]] <- Reduce(f = append, x = el_list)

  res
}
