# Files  ----
file_push <- function(res){

  .slack$stack$file <- c(.slack$stack$file,res$file$id)

  post_push_internal(
    list(
      list(ts = res$file$shares$private[[1]][[1]]$ts,
         channel = names(res$file$shares$private))
      )
  )

}

file_pop <- function(){
  .slack$stack$file <- .slack$stack$file[-length(.slack$stack$file)]
}

#' @title Manage Files
#' @description Query/Remove files created by slackreprex. Each file is logged
#'   for the id in an internal package environment. Which
#'   serves the purpose of querying or removing specific files.
#'   - file_stack: lists in decreasing order the files sent during the session.
#'   - last_file: retrieves the last file sent.
#'   - rm_last_file: deletes the last file from the specified channel.
#' @return NULL
#' @rdname file_manage
#' @export
file_last <- function(){
  if(length(.slack$stack$file)==0){
    warning('No file in stack')
    return(invisible(NULL))
  }

  .slack$stack$file[length(.slack$stack$file)]
}

#' @rdname file_manage
#' @export
file_stack <- function(){
  .slack$stack$file
}

# Posts ----

post_push <- function(res){

  post_push_internal(list(list(ts = res$ts,channel = res$channel, thread_ts = res$message$thread_ts)))

}

post_push_internal <- function(obj){
  .slack$stack$post <- append(.slack$stack$post,obj)

  .slack$stack$post <- lapply(.slack$stack$post,function(x) {structure(x,class = 'slackpost')})
}

post_pop <- function(){
  .slack$stack$post[length(.slack$stack$post)] <- NULL
}


#' @title Manage Posts
#' @description Query/Remove posts created by slackreprex. Each post is logged
#'   for channel and timestamp (ts) in an internal package environment. Which
#'   serves the purpose of querying or removing specific posts.
#'   - post_stack: lists in decreasing order the posts sent during the session.
#'   - last_post: retrieves the last post sent.
#' @return NULL
#' @rdname post_manage
#' @export
post_last <- function(){
  if(length(.slack$stack$post)==0){
    warning('No posts in stack')
    return(invisible(NULL))
  }

  .slack$stack$post[[length(.slack$stack$post)]]
}

#' @rdname post_manage
#' @export
post_stack <- function(){
  .slack$stack$post
}
