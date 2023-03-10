
<!-- README.md is generated from README.Rmd. Please edit that file -->

# slackcalls

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Covrpage
Summary](https://img.shields.io/badge/covrpage-Last_Build_2023_02_27-brightgreen.svg)](http://tinyurl.com/ux5kpl9)
[![R-CMD-check](https://github.com/yonicd/slackcalls/actions/workflows/r-cmd-check.yml/badge.svg)](https://github.com/yonicd/slackcalls/actions/workflows/r-cmd-check.yml)
[![Codecov test
coverage](https://codecov.io/gh/yonicd/slackcalls/branch/master/graph/badge.svg)](https://app.codecov.io/gh/yonicd/slackcalls?branch=master)
<!-- badges: end -->

`slackcalls` is part of the `slackverse`

|                                                                                                                                                   |                                                                                                                                             |                                                                                                                                                |
|:-------------------------------------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------------------------------------:|
|                                                                                                                                                   | slackcalls<br>[![](https://github.com/yonicd/slackcalls/actions/workflows/r-cmd-check.yml/badge.svg)](https://github.com/yonicd/slackcalls) |                                                                                                                                                |
| slackthreads<br>[![](https://github.com/yonicd/slackthreads/actions/workflows/r-cmd-check.yml/badge.svg)](https://github.com/yonicd/slackthreads) | slackteams<br>[![](https://github.com/yonicd/slackteams/actions/workflows/r-cmd-check.yml/badge.svg)](https://github.com/yonicd/slackteams) |  slackposts<br>[![](https://github.com/yonicd/slackposts/actions/workflows/r-cmd-check.yml/badge.svg)](https://github.com/yonicd/slackposts)   |
|                                                                                                                                                   |                                                                                                                                             | slackblocks<br>[![](https://github.com/yonicd/slackblocks/actions/workflows/r-cmd-check.yml/badge.svg)](https://github.com/yonicd/slackblocks) |
|                                                                                                                                                   |                                                                                                                                             | slackreprex<br>[![](https://github.com/yonicd/slackreprex/actions/workflows/r-cmd-check.yml/badge.svg)](https://github.com/yonicd/slackreprex) |

`slackcalls` is the backend of the `slackverse`. It interacts with Slack
API methods.

- [Installation](#installation)
- [Posting](#posting-to-slack)
- [Querying](#querying-slack)
- [Storage](#storage)

## Installation

Install the released version of {slackcalls} from CRAN:

``` r
install.packages("slackcalls")
```

Or install the development version of {slackcalls} from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("yonicd/slackcalls")
```

## Posting to Slack

### Files

Using `files_slack` interact with

- [files.upload](https://api.slack.com/methods/files.upload)
- [files.delete](https://api.slack.com/methods/files.delete)
- [files.info](https://api.slack.com/methods/files.info)
- [files.list](https://api.slack.com/methods/files.list)

### Chats

Using `chat_slack` interact with

- [chat.postMessage](https://api.slack.com/methods/chat.postMessage)
- [chat.delete](https://api.slack.com/methods/chat.delete)
- [chat.update](https://api.slack.com/methods/chat.update)

## Querying Slack

Using `post_slack` you can query the API to get information such as the
following lists. The functions paginate by default.

### Team

- [team.info](https://api.slack.com/methods/team.info)

### Users

- [users.list](https://api.slack.com/methods/users.list)
- [users.info](https://api.slack.com/methods/users.info)

### Conversations

- [conversations.history](https://api.slack.com/methods/conversations.history)
- [conversations.list](https://api.slack.com/methods/conversations.list)
- [conversations.info](https://api.slack.com/methods/conversations.info)
- [conversations.members](https://api.slack.com/methods/conversations.members)
- [conversations.replies](https://api.slack.com/methods/conversations.replies)

## Storage

`slackcalls` also saves internally posts that you make during a session
in order to use the information for posting to a thread or deleting
posts. This mechanism is used in all the slackverse packages.

### Stacks

- `file_stack`: vector of file IDs that have been sent
- `post_stack`: list of posts that have been sent, contains information
  of ID, ts and where relevant thread_ts.

The stacks are updated every time a new post/file is sent or deleted.

### Last Element

using `file_last` and `post_last` you can fetch the head of each stack.
