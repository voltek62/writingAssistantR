
context("cocon.se")

test_that("The Key API is ok", {
  expect_equal(initAPI(), "ok")
})

require(RCurl)
require(rjson)
require(XML)

