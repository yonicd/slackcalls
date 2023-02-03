library(testthat)
library(slackcalls)

if (Sys.getenv('SLACK_API_TOKEN') == "") {
  stop("No SLACK_API_TOKEN detected")
}
test_check("slackcalls")
