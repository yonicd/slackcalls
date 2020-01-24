#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param slack_method PARAM_DESCRIPTION
#' @param max_results PARAM_DESCRIPTION, Default: Inf
#' @param max_calls PARAM_DESCRIPTION, Default: Inf
#' @param paginate PARAM_DESCRIPTION, Default: TRUE
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname post_slack
#' @export
post_slack <- function(slack_method, max_results = Inf, max_calls = Inf, paginate = TRUE, ...){

  body <- list(...)

  res <- call_slack(slack_method, body = body)

  if(paginate & max_calls > 1)
    res <- paginate_(res, max_results = max_results, max_calls = max_calls)

  res

}

#' @importFrom httr POST
call_slack <- function(slack_method, body) {

  res <- validate_response(res = httr::POST(file.path("https://slack.com/api", slack_method), body = body))

  cursor <- NULL

  if ("response_metadata" %in% names(res)) {
    cursor <- res[["response_metadata"]][["next_cursor"]]
  }

  structure(res, class = c(slack_method, class(res)), slack_method = slack_method, cursor = cursor, body = body)
}

#' @importFrom httr stop_for_status content
validate_response <- function(res) {
  httr::stop_for_status(res)

  res_content <- httr::content(res)

  if (!res_content$ok) {
    return(res_content$error)
  }

  res_content
}


paginate_ <- function(res, max_results = Inf, max_calls  = Inf) {

  res_body <- attr(res, "body")

  if(!is.null(res_body$limit))
    max_calls <- ceiling(max_results/res_body$limit)

  i <- 1
  cont <- TRUE
  output <- list()

  output[[i]] <- res
  if (is.null(attr(output[[i]], "cursor"))) {
    return(res)
  }

  while (cont && i < max_calls) {
    this_body <- attr(output[[i]], "body")
    this_body$cursor <- attr(output[[i]], "cursor")

    cont <- nzchar(this_body$cursor)

    if (cont) {
      this_res <- call_slack(attr(res, "call"), body = this_body)

      output <- append(output, list(this_res))

      i <- i + 1
    }
  }

  el <- setdiff(names(res), c("ok", "response_metadata"))

  el_list <- lapply(output, function(x, what) x[[what]], what = el)

  res[[el]] <- Reduce(f = append,  x = el_list)

  res
}
