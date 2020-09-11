# Environment Variable Must be Defined (Either by Local .Renviron or Environment variable on CI.)
token <- Sys.getenv('SLACK_API_TOKEN')

channel <- "DNRKMTFGD"

testthat::describe("chat upload", {

  test_result <- chat_slack(
       channel = channel,
       token = token,
       text = 'test'
  )

  it('ok result',{
    testthat::expect_true(test_result$ok)
  })

 it('names of return',{
   expect_identical(
     names(test_result),
     c('ok','channel','ts','message')
    )
 })

 it('last_post returns attribs',{
   expect_identical(
     structure(list(
      ts  = test_result$ts,
      channel = test_result$channel,
      thread_ts = NULL
     ),class = 'slackpost'),
     post_last())
 })

 it('query stack',{
   expect_true(inherits(post_stack()[[1]],'slackpost'))
 })

 it('remove post',{

   lp <- post_last()

   test_remove <- chat_slack(
     slack_method = 'chat.delete',
     token = token,
     channel = lp$channel,
     ts = lp$ts,
     action = 'pop')

    testthat::expect_true(test_remove$ok)

 })

 it('empty stack',{

   testthat::expect_warning(post_last(),'No posts in stack')

 })
})
