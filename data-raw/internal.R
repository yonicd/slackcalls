rate_limit_tiers <- c(
  1L, 20L, 50L, 100L
)

rate_limits_known <- c(
  chat.delete = rate_limit_tiers[[3]],
  chat.update = rate_limit_tiers[[3]],
  chat.postMessage = 60L,
  conversations.history = rate_limit_tiers[[3]],
  conversations.info = rate_limit_tiers[[3]],
  conversations.list = rate_limit_tiers[[2]],
  conversations.members = rate_limit_tiers[[4]],
  conversations.replies = rate_limit_tiers[[3]],
  files.delete = rate_limit_tiers[[3]],
  files.info = rate_limit_tiers[[4]],
  files.list = rate_limit_tiers[[3]],
  files.upload = rate_limit_tiers[[2]],
  team.info = rate_limit_tiers[[3]],
  users.list = rate_limit_tiers[[2]],
  users.info = rate_limit_tiers[[4]]
)

usethis::use_data(rate_limits_known, internal = TRUE, overwrite = TRUE)

rm(rate_limits_known, rate_limit_tiers)
