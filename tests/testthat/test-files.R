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

test_that("files_slack can upload text", {
  expect_error(
    with_mock_api({
      test_result <- files_slack(
        slack_method = "files.upload",
        channel = slack_test_channel,
        content = "a sample payload"
      )
    }),
    NA
  )

  expect_true(test_result$ok)

  expect_identical(
    names(test_result),
    c("ok", "file")
  )

  expect_identical(
    file_last(),
    test_result$file$id
  )

  expect_identical(
    file_stack(),
    file_last()
  )
})

test_that("files_slack can list files", {
  expect_error(
    with_mock_api({
      test_list <- files_slack(slack_method = "files.list")
    }),
    NA
  )

  expect_true(test_list$ok)
})

test_that("files_slack can get info", {
  expect_error(
    with_mock_api({
      test_info <- files_slack(
        slack_method = "files.info",
        file = file_last()
      )
    }),
    NA
  )

  expect_true(test_info$ok)

  expect_equal(
    test_info$content,
    "a sample payload"
  )
})

test_that("files_slack can upload files", {
  # I can't get this to work with a recorded call, since the thing being
  # uploaded changes slightly; a temp file or something similar is created by
  # curl, so, even if I use a non-relative/non-random path, it fails. Therefore
  # let's only test this when we're really hitting the API.
  skip_if_not(
    slack_api_test_mode == "true",
    "Only test tempfile uploads against real API."
  )

  tf <- withr::local_tempfile(
    lines = "x <- 2",
    fileext = ".R"
  )

  expect_error(
    {
      test_result <- files_slack(
        slack_method = "files.upload",
        channel = slack_test_channel,
        file = tf
      )
    },
    NA
  )

  expect_true(test_result$ok)
  expect_equal(test_result$file$filetype, "r")
})

test_that("files_slack can clean up", {
  expect_error(
    with_mock_api({
      cleanup <- sapply(
        file_stack(),
        function(x) {
          files_slack(
            slack_method = 'files.delete',
            file = x
          )
        }
      )
    }),
    NA
  )
  expect_warning(
    file_last(),
    regexp = "No file in stack"
  )
})
