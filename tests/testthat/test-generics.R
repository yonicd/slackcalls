# Environment Variable Must be Defined (Either by Local .Renviron or Environment variable on CI.)
token <- Sys.getenv('SLACK_API_TOKEN')

# This is #slack-r on slackr-test
channel <- "CNTFB9215"

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
     names(test_result),
     c(
       "ok", "messages", "has_more", "pin_count",
       "channel_actions_ts", "channel_actions_count", "response_metadata"
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
    testthat::expect_gte(length(test_result$messages),5L)
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
    expect_equal(length(test_result$messages),6L)
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
    expect_lte(length(test_result$messages),15L)
  })

})
