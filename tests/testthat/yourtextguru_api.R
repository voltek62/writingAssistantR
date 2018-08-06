
context("yourtext.guru")

test_that("The Key API is ok", {
  expect_equal(initAPI(), "ok")
})

require(RCurl)
require(rjson)
require(XML)

test_that("The status is ok", {
  # must return ok
  expect_equal(getStatus(), "ok")
})

test_that("The creation of guide is ok", {
  guide <- createGuide("example","en_us","premium")
  # must return 0
  expect_equal(guide$guide_id, 0)
})

test_that("The guide Example is available", {
  guide <- getGuide(0)
  # must return ok
  expect_equal(guide$msg, "ok")
})

test_that("The score is available with an URL", {
  scores <- checkGuide(0,"https://en.wikipedia.org/wiki/Example_(musician)")
  # must return a score
  expect_that( scores$score>=0 , is_true() )
})
