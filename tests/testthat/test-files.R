# Environment Variable Must be Defined (Either by Local .Renviron or Environment variable on CI.)
token <- Sys.getenv('SLACK_API_TOKEN')

channel <- "DNRKMTFGD"

testthat::describe("content upload", {

  test_result <- files_slack(
    slack_method = 'files.upload',
       channel = channel,
       token = token,
       content = 'test'
  )

  it('ok result',{
    testthat::expect_true(test_result$ok)
  })

 it('names of return',{
   expect_identical(
     names(test_result),
     c('ok','file')
    )
 })

 it('file_last returns file id',{
   expect_identical(test_result$file$id,file_last())
 })

 it('file_stack equal to last_file',{
   expect_identical(file_stack(),file_last())
 })

})


testthat::describe("file list", {

  test_list <- files_slack(slack_method = 'files.list')

  it('ok result',{
    testthat::expect_true(test_list$ok)
  })

})

testthat::describe("file info", {

 test_info <- files_slack(slack_method = 'files.info',file = file_last())

 it('ok result',{
   testthat::expect_true(test_info$ok)
 })

 it('file info content',{
   testthat::expect_equal(test_info$content,'test')
 })

})

testthat::describe("file upload", {

  tf <- tempfile(fileext = '.R')
  cat('x <- 2',file = tf)

  test_result <- files_slack(
    method = 'files.upload',
    channel = channel,
    token = token,
    file = tf
  )

  it('ok result',{
    testthat::expect_true(test_result$ok)
  })

  it('ok result',{
    testthat::expect_equal(test_result$file$filetype,'r')
  })

  cleanup <- sapply(file_stack(), function(x){
    files_slack(slack_method = 'files.delete',file = x)
  })

  it('empty stack',{
    testthat::expect_warning(file_last(),regexp = 'No file in stack')
  })

})
