
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Covrpage
Summary](https://img.shields.io/badge/covrpage-Last_Build_2020_01_26-brightgreen.svg)](http://tinyurl.com/ux5kpl9)
[![R-win build
status](https://github.com/yonicd/slackcalls/workflows/R-win/badge.svg)](https://github.com/yonicd/slackcalls)
[![R-mac build
status](https://github.com/yonicd/slackcalls/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackcalls)
[![R-linux build
status](https://github.com/yonicd/slackcalls/workflows/R-linux/badge.svg)](https://github.com/yonicd/slackcalls)
[![Codecov test
coverage](https://codecov.io/gh/yonicd/slackcalls/branch/master/graph/badge.svg)](https://codecov.io/gh/yonicd/slackcalls?branch=master)
<!-- badges: end -->

# slackcalls

Backend of slackverse to interact with Slack API methods

  - [Posting](#posting-to-slack)
  - [Querying](#querying-slack)
  - [Storage](#storage)

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
  - `post_stack`: list of posts that have been sent, contains
    information of ID, ts and where relevant thread\_ts.

The stacks are updated every time a new post/file is sent or deleted.

### Last Element

using `file_last` and `post_last` you can fetch the head of each stack.
