# Environment Variable Must be Defined (Either by Local .Renviron or Environment variable on CI.)
token <- Sys.getenv('SLACK_API_TOKEN')

# This is #slack-r on slackr-test
channel <- "CNTFB9215"

# Uncomment this option if you'd like to test the rate limits. The rate limit
# tests take at least 1 full minute.

options(slackverse_test_rate = TRUE)

# With the current free-tier limits, posts disappear every 90 days. If tests
# fail, check that there are >= 15 posts in the channel.

testthat::describe("calls work", {
  # This one test does an actual call to the api, to make sure everything is working as expected.

  test_result <- slackcalls::post_slack(
    slack_method = "conversations.history",
    token = token,
    channel = channel,
    max_results = 1
  )

  it('ok result',{
    testthat::expect_true(test_result$ok)
  })

 it('names of return',{
   expect_identical(
     sort(names(test_result)),
     c(
       "channel_actions_count", "channel_actions_ts", "has_more",
       "is_limited", "messages", "ok",
       "pin_count", "response_metadata"
     )
    )
 })

})

testthat::describe('call error',{

  test_result <- slackcalls::post_slack(
    slack_method = "conversations.history",
    token = token,
    channels = channel,
    max_results = 1
  )

  it('ok FALSE',{
    testthat::expect_false(test_result$ok)
  })

  it('ok FALSE',{
    testthat::expect_equal(test_result$error,'invalid_arguments')
  })
})

testthat::describe('limits',{

  test_result <- slackcalls::post_slack(
    slack_method = "conversations.history",
    token = token,
    channel = channel
  )

  it('more than 5',{
    testthat::expect_gte(length(test_result$messages), 5L)
  })

  test_result_limit_3 <- slackcalls::post_slack(
    slack_method = "conversations.history",
    token = token,
    channel = channel,
    limit = 3L
  )

  it('limit attribute',{
    testthat::expect_equal(
      attr(test_result_limit_3, "body")$limit,
      3L
    )
  })

  # The 1:12 is to avoid going back too far to where some things are weird.
  it('limit messages',{
     testthat::expect_identical(
       test_result_limit_3$messages[1:12],
       test_result$messages[1:12]
     )
  })

  it('names of results object',{
     testthat::expect_identical(
       names(test_result_limit_3),
       append(names(test_result), "response_metadata")
     )
  })

})

testthat::describe("maxes are respected", {

  test_result <- post_slack(
    slack_method = "conversations.history",
    token = token,
    max_results = 5,
    limit = 3,
    channel = channel
  )

  it('6 length',{
    expect_equal(length(test_result$messages), 6L)
  })

  test_result <- post_slack(
    slack_method = "conversations.history",
    token = token,
    limit = 5,
    max_calls = 3,
    channel = channel
  )

  # This one is grabbing 5 things 3 times, so it should get up to 15 things. The
  # test seemed to work before because there weren't enough messages to get the
  # actual limit.
  it('15 length',{
    expect_lte(length(test_result$messages), 15L)
  })

})

testthat::describe("rate limits work", {
  if (getOption("slackverse_test_rate", FALSE)) {
    it("Pauses when rate_limit is full.", {
      start_ts <- as.integer(Sys.time())
      # Set up a rate limit.
      rate_limit_set("conversations.history", 1)
      # Add a fake call that we have to wait to clear out.
      rate_limit_append_ts("conversations.history", start_ts - 55L)

      test_result <- post_slack(
        slack_method = "conversations.history",
        token = token,
        channel = channel,
        max_results = 2,
        limit = 1,
        rate_limit = 1
      )
      end_ts <- as.integer(Sys.time())
      expect_gte(
        end_ts - start_ts,
        5
      )
    })

    it("A different method isn't impacted by that limit.", {
      start_ts <- as.integer(Sys.time())
      test_result <- post_slack(
        slack_method = "conversations.list",
        token = token,
        max_results = 3,
        limit = 1
      )
      end_ts <- as.integer(Sys.time())
      expect_lte(
        end_ts - start_ts,
        5
      )
    })

    # Clean up.
    rate_limit_set("conversations.history", NULL)
  } else {
    it("Not checking rates.")
  }
})
