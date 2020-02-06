# Environment Variable Must be Defined (Either by Local .Renviron or Environment variable on CI.)
token <- Sys.getenv('SLACK_API_TOKEN')

# This is 5_general_r_help on R4DS.
channel <- "C6VCZPGPR"

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
       "ok", "messages", "has_more", "is_limited", "pin_count",
       "channel_actions_ts", "channel_actions_count", "response_metadata"
     )
    )
 })

})

testthat::describe('limits',{

  test_result <- slackcalls::post_slack(
    slack_method = "conversations.history",
    token = token,
    channel = channel
  )

  it('more than 300',{
    testthat::expect_gte(length(test_result$messages),300L)
  })

  test_result_limit_100 <- slackcalls::post_slack(
    slack_method = "conversations.history",
    token = token,
    channel = channel,
    limit = 100L
  )

  it('limit attribute',{
    testthat::expect_equal(
      attr(test_result_limit_100, "body")$limit,
      100L
    )
  })

  it('limit messages',{
     testthat::expect_identical(
       test_result_limit_100$messages,
       test_result$messages
     )
  })

  it('names of results object',{
     testthat::expect_identical(
       names(test_result_limit_100),
       append(names(test_result), "response_metadata")
     )
  })

})


testthat::describe("maxes are respected", {

  test_result <- post_slack(
    slack_method = "conversations.history",
    token = token,
    max_results = 300,
    limit = 100,
    channel = channel
  )

 it('300 length',{
    expect_equal(length(test_result$messages),300L)
   })

  test_result <- post_slack(
    slack_method = "conversations.history",
    token = token,
    limit = 100,
    max_calls = 2,
    channel = channel
  )

 it('200 length',{
   expect_equal(length(test_result$messages),200L)
 })

})
