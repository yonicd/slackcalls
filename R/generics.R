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
                       token = Sys.getenv('SLACK_API_TOKEN'),
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

#' @title Interact with Chat API
#' @description Post/edit/delete messages or blocks to a channel
#' @param slack_method character, method to invoke, Default: 'chat.postMessage'
#' @param token Character. Your Slack API token.
#' @param ... arguments to pass to chat methods
#' @param action action to apply on.exit to call stack, Default: c("push", "pop")
#' @return httr response
#' @details
#'  chat methods available to post to
#'    - chat.postMessage
#'    - chat.delete
#'    - chat.update
#' For a full list of chat methods see [here](https://api.slack.com/methods)
#' @examples
#' \dontrun{
#' post_slack(
#'   text = 'my message',
#'   channel = "general",
#'   token = "my_api_token"
#' )
#' }
#' @rdname chat_slack
#' @export
chat_slack <- function(slack_method = 'chat.postMessage',token = Sys.getenv('SLACK_API_TOKEN'),
                       ..., action = c('push','pop')){

  body <- list(...)
  body$token <- token

  res <- call_slack(slack_method, body = body)

  action <- match.arg(action,c('push','pop'),several.ok = TRUE)

  if('pop'%in%action){
    post_pop()
  }

  if('push'%in%action)
    post_push(res)

  invisible(res)
}

#' @title Interact with File API
#' @description upload/info/list/delete files
#' @param slack_method character, method to invoke, Default: 'files.upload'
#' @param token Character. Your Slack API token.
#' @param ... arguments to pass to chat methods
#' @return httr response
#' @details
#'  chat methods available to post to
#'    - files.upload
#'    - files.delete
#'    - files.info
#'    - files.list
#' For a full list of chat methods see [here](https://api.slack.com/methods)
#' @examples
#' \dontrun{
#' files_slack(
#'   method = 'files.upload',
#'   channel = "general",
#'   token = Sys.getenv('SLACK_API_TOKEN'),
#'   content = 'wow'
#' )
#'
#' tf <- tempfile(fileext = '.r')
#' cat(
#'   utils::capture.output(utils::sessionInfo()),
#'   file = tf,
#'   sep = '\n'
#' )
#'
#' files_slack(
#'   method = 'files.upload',
#'   channel = "general",
#'   token = Sys.getenv('SLACK_API_TOKEN'),
#'   file = tf,
#'   filename = 'sessionInfo.R',
#'   filetype = 'r',
#'   initial_comment = 'here is my session info',
#'   title = 'R sessionInfo'
#' )
#'
#' unlink(tf)
#'
#' }
#' @rdname files_slack
#' @export
files_slack <- function(slack_method = 'files.upload',  ..., token = Sys.getenv('SLACK_API_TOKEN')){
    body <- list(...)
    body$token <- token
    res <- validate_upload(slack_method = slack_method, body = body)

    if(res$ok){

      if(slack_method=='files.upload'){
        file_push(res)
      }

      if(slack_method=='files.delete'){
        file_pop()
      }

    }

    return(invisible(res))
  }

#' @importFrom httr POST
call_slack <- function(slack_method, body) {

  res <- httr::POST(
    url = file.path("https://slack.com/api", slack_method),
    body = compact(body)
  )

  res <- validate_response(res)

  cursor <- NULL

  if ("response_metadata" %in% names(res)) {
    cursor <- res[["response_metadata"]][["next_cursor"]]
  }

  ret <- structure(
    res,
    class = c(slack_method, class(res)),
    slack_method = slack_method,
    cursor = cursor,
    body = body
  )

  invisible(ret)
}

#' @title Slack API Error
#' @description Returns error message from a Slack API response
#' @param obj httr response content
#' @return character
#' @rdname slack_err
#' @export
slack_err <- function(obj){
  ret <- paste(
    c(obj$error,
      obj$response_metadata$messages),
    collapse = '\n  ')

  message(ret)

  ret
}

#' @title Validate Slack API Response
#' @description Check Slack API Response for errors
#' @param res httr response
#' @return httr response content
#' @rdname validate_response
#' @export
#' @importFrom httr stop_for_status content
validate_response <- function(res) {

  httr::stop_for_status(res)

  res_content <- httr::content(res)

  if (!res_content$ok) {
    slack_err(res_content)
  }

  res_content
}

#' @importFrom httr stop_for_status content POST upload_file add_headers
validate_upload <- function(slack_method = 'files.upload', body) {

  # fix common typo that user might make
  if('channel'%in%names(body))
    names(body)[names(body)=='channel'] <- 'channels'

  if('file'%in%names(body)&slack_method=='files.upload'){

    body$file <- httr::upload_file(body$file)

    res <- httr::POST(
      url = file.path("https://slack.com/api", slack_method),
      httr::add_headers(`Content-Type`="multipart/form-data"),
      body = compact(body)
    )
  }else{
    res <- httr::POST(
      url = file.path("https://slack.com/api", slack_method),
      body = compact(body)
    )
  }

  ret <- validate_response(res)

  invisible(ret)

}


#' @title Parse Calls
#' @description Function used to translate R side functions to slack api methods
#'   to interact with slack.
#' @return api method to be used
#' @rdname parse_call
#' @export
parse_call <- function() {
  tb <- .traceback(1)
  idx <- which(sapply(tb, function(x) grepl(x[1], pattern = "post\\_slack"))) + 1
  call_str <- paste0(tb[[idx]],collapse = '')
  foo <- gsub("\\((.*?)$", "", call_str)
  no_get <- gsub("^(.*?)get_", "", foo)
  gsub("\\_", ".", no_get)
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

compact <- function(obj){

  obj[lengths(obj)>0]

}
