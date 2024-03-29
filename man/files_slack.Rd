% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generics.R
\name{files_slack}
\alias{files_slack}
\title{Interact with File API}
\usage{
files_slack(
  slack_method = "files.upload",
  ...,
  token = Sys.getenv("SLACK_API_TOKEN"),
  rate_limit
)
}
\arguments{
\item{slack_method}{character, method to invoke, Default: 'files.upload'}

\item{...}{arguments to pass to chat methods}

\item{token}{Character. Your Slack API token.}

\item{rate_limit}{Integer. The maximum number of calls to make to this
function per minute. If NULL, calls will not be rate-limited. If unset,
calls will be limited per the rate limit guides in the \href{https://api.slack.com/methods}{Slack api method documentation}, if known. Note: If a limit
is set for this method in any call in this session, that rate limit will be
respected until rate_limit is set to NULL. Default: None.}
}
\value{
httr response
}
\description{
upload/info/list/delete files
}
\details{
files methods available to post to
\itemize{
\item files.upload
\item files.delete
\item files.info
\item files.list
}

For a full list of chat methods see \href{https://api.slack.com/methods}{here}
}
\examples{
\dontrun{
files_slack(
  method = 'files.upload',
  channel = "general",
  token = Sys.getenv('SLACK_API_TOKEN'),
  content = 'wow'
)

tf <- tempfile(fileext = '.r')
cat(
  utils::capture.output(utils::sessionInfo()),
  file = tf,
  sep = '\n'
)

files_slack(
  method = 'files.upload',
  channel = "general",
  token = Sys.getenv('SLACK_API_TOKEN'),
  file = tf,
  filename = 'sessionInfo.R',
  filetype = 'r',
  initial_comment = 'here is my session info',
  title = 'R sessionInfo'
)

unlink(tf)

}
}
