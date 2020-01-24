# Right now I'm using slackteams to set my "SLACK_API_TOKEN". That makes this
# test a bit loop-y, since slackteams imports this package. We should probably
# pull out a piece to just load the token for r4ds from a file.

slackteams::load_teams()
slackteams::activate_team("r4ds")
token <- Sys.getenv("SLACK_API_TOKEN")

# This is 5_general_r_help on R4DS.
channel <- "C6VCZPGPR"

test_that("calls work", {
  test_result <- post_slack(
    slack_method = "conversations.history",
    token = token,
    channel = channel
  )
  expect_identical(
    names(test_result),
    c(
      "ok", "messages", "has_more", "is_limited", "pin_count",
      "channel_actions_ts", "channel_actions_count"
    )
  )
  # This is technically slightly fragile. If We have a ton of posts in channels
  # other than 5_general_r_questions on the r4ds slack, the number of posts in
  # general that are available could go down. It should always be more than 300,
  # though, probably. If it isn't, some of the tests below will fail (when we
  # test maxes).
  expect_gte(
    length(test_result$messages),
    300
  )

  test_result_limit_100 <- post_slack(
    slack_method = "conversations.history",
    token = token,
    channel = channel,
    limit = 100L
  )

  # Other than a few things in attributes and the "is_limited" flag, everything
  # should be identical.
  expect_equal(
    attr(test_result_limit_100, "body")$limit,
    100
  )
  expect_identical(
    test_result_limit_100$messages,
    test_result$messages
  )
  expect_identical(
    names(test_result_limit_100),
    append(names(test_result), "response_metadata")
  )
})

test_that("maxes are respected", {
  test_result <- post_slack(
    slack_method = "conversations.history",
    token = token,
    max_results = 300,
    limit = 100,
    channel = channel
  )
  expect_equal(
    length(test_result$messages),
    300
  )
  test_result <- post_slack(
    slack_method = "conversations.history",
    token = token,
    limit = 100,
    max_calls = 2,
    channel = channel
  )
  expect_equal(
    length(test_result$messages),
    200
  )
})
