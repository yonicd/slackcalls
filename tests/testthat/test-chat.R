# Set up tests. ---------------------------------------------------------------
# While this *could* go into a setup.R file, that makes interactive testing
# annoying. I compromised and put it in a collapsible block at the top of each
# test file.

# To test the API:

# Sys.setenv(SLACK_API_TEST_MODE = "true")

# To capture test data:

# Sys.setenv(SLACK_API_TEST_MODE = "capture")

# To go back to a "normal" mode:

# Sys.unsetenv("SLACK_API_TEST_MODE")

slack_api_test_mode <- Sys.getenv("SLACK_API_TEST_MODE")
withr::defer(rm(slack_api_test_mode))

library(httptest)

# All tests use #slack-r on slackr-test (or a mocked version of it).
slack_test_channel <- "CNTFB9215"
withr::defer(rm(slack_test_channel))

if (slack_api_test_mode == "true" || slack_api_test_mode == "capture") {
  # In these modes we need a real API token. If one isn't set, this should throw
  # an error right away.
  if (Sys.getenv("SLACK_API_TOKEN") == "") {
    stop(
      "No SLACK_API_TOKEN available, cannot test. \n",
      "Unset SLACK_API_TEST_MODE to use mock."
    )
  }

  if (slack_api_test_mode == "true") {
    # Override the main mock function from httptest, so we use the real API.
    with_mock_api <- force
  } else {
    # This tricks httptest into capturing results instead of actually testing.
    with_mock_api <- httptest::capture_requests
  }
  withr::defer(rm(with_mock_api))
}

# Tests. ----------------------------------------------------------------------

test_that("chat_slack (etc) works", {
  expect_error(
    with_mock_api({
      test_result <- chat_slack(
        channel = slack_test_channel,
        text = "test"
      )
    }),
    NA
  )

  expect_true(test_result$ok)

  expect_identical(
    names(test_result),
    c("ok", "channel", "ts", "message")
  )

  expect_identical(
    post_last(),
    structure(
      list(
        ts = test_result$ts,
        channel = test_result$channel,
        thread_ts = NULL
      ),
      class = "slackpost"
    )
  )

  expect_s3_class(post_stack()[[1]], "slackpost")
})

test_that("cleanup works", {
  lp <- post_last()

  expect_error(
    with_mock_api({
      test_remove <- chat_slack(
        slack_method = "chat.delete",
        channel = lp$channel,
        ts = lp$ts,
        action = "pop"
      )
    }),
    NA
  )

  expect_true(test_remove$ok)
})
