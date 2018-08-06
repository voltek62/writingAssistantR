
context("cocon.se")

test_that("The Token is ok", {
  expect_equal(createToken(), "ok")
})

require(RCurl)
require(rjson)
require(XML)

test_that("The status is ok", {
  # must return ok
  expect_equal(checkStatus(), "ok")
})

