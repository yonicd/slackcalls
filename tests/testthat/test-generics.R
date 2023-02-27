# *** With the current free-tier limits, posts disappear every 90 days. If tests
# *** fail, check that there are >= 15 posts in the channel.

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

# To test the rate limits (the rate limit tests take at least 5 seconds):

# Sys.setenv(SLACKVERSE_TEST_RATE = "true")

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
      "Unset SLACK_API_TEST_MODE to use mock.")
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

test_that("post_slack works", {
  expect_error(
    with_mock_api({
      test_result <- post_slack(
        slack_method = "conversations.history",
        channel = slack_test_channel,
        max_results = 1
      )
    }),
    NA
  )

  expect_true(test_result$ok)

  expect_identical(
    sort(names(test_result)),
    c(
      "channel_actions_count", "channel_actions_ts", "has_more", "is_limited",
      "messages", "ok", "pin_count", "response_metadata"
    )
  )
})

test_that("post_slack creates appropriate error objects", {
  expect_error(
    expect_message(
      with_mock_api({
        test_result <- post_slack(
          slack_method = "conversations.history",
          channels = slack_test_channel,
          max_results = 1
        )
      }),
      "invalid_arguments"
    ),
    NA
  )

  expect_false(test_result$ok)
  expect_equal(test_result$error, "invalid_arguments")
})

test_that("post_slack limits work", {
  expect_error(
    with_mock_api({
      test_result <- post_slack(
        slack_method = "conversations.history",
        channel = slack_test_channel
      )
    }),
    NA
  )

  expect_gte(length(test_result$messages), 5L)

  expect_error(
    with_mock_api({
      test_result_limit_3 <- post_slack(
        slack_method = "conversations.history",
        channel = slack_test_channel,
        limit = 3L
      )
    }),
    NA
  )

  expect_equal(
    attr(test_result_limit_3, "body")$limit,
    3L
  )

  # Some ids change, somewhat surprisingly, so clear out those things before
  # comparison.
  for (i in 1:12) {
    test_result$messages[[i]]$blocks[[1]]$block_id <- NULL
    test_result_limit_3$messages[[i]]$blocks[[1]]$block_id <- NULL
  }

  # The 1:12 is to avoid going back too far to where some things are weird.
  expect_identical(
    test_result_limit_3$messages[1:12],
    test_result$messages[1:12],
    list_as_map = TRUE # Sort names.
  )

  expect_identical(
    names(test_result_limit_3),
    append(names(test_result), "response_metadata"),
    list_as_map = TRUE
  )
})

test_that("post_slack respects max", {
  expect_error(
    with_mock_api({
      test_result <- post_slack(
        slack_method = "conversations.history",
        channel = slack_test_channel,
        max_results = 5,
        limit = 3
      )
    }),
    NA
  )
  expect_equal(length(test_result$messages), 6L)

  expect_error(
    with_mock_api({
      test_result <- post_slack(
        slack_method = "conversations.history",
        channel = slack_test_channel,
        max_calls = 3,
        limit = 5
      )
    }),
    NA
  )
  # This one is grabbing 5 things 3 times, so it should get up to 15 things. The
  # test seemed to work before because there weren't enough messages to get the
  # actual limit.
  expect_equal(length(test_result$messages), 15L)

})

test_that("rate limits work", {
  skip_if_not(
    Sys.getenv("SLACKVERSE_TEST_RATE") == "true",
    "Rate limit tests are slow, only test occasionally."
  )

  # Clean up when we're done.
  withr::defer(rate_limit_set("conversations.history", NULL))

  # Clear out any existing calls to conversations.history.
  rate_limit_reset_calls("conversations.history")


  # Set up a rate limit.
  rate_limit_set("conversations.history", 1)

  # Start the clock.
  start_ts <- as.integer(Sys.time())

  # Add a fake call almost a minute ago that we have to wait to clear out.
  rate_limit_append_ts("conversations.history", start_ts - 55L)

  expect_error(
    with_mock_api({
      test_result <- post_slack(
        slack_method = "conversations.history",
        channel = slack_test_channel,
        max_results = 1,
        limit = 1,
        rate_limit = 1
      )
    }),
    NA
  )

  end_ts <- as.integer(Sys.time())
  expect_gte(
    end_ts - start_ts,
    5
  )

  # Make sure a different method isn't impacted by that limit.
  start_ts <- as.integer(Sys.time())

  expect_error(
    with_mock_api({
      test_result <- post_slack(
        slack_method = "conversations.list",
        max_results = 3,
        limit = 1
      )
    }),
    NA
  )

  end_ts <- as.integer(Sys.time())
  expect_lte(
    end_ts - start_ts,
    5
  )
})
