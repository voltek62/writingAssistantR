
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

test_that("The list of Metamots is available", {
  # must return ok
  expect_equal(metamots$status, "ok")
})

metamots <- listMetamots()
info <- metamots$data[[1]]
metamot_id <- info$mid

test_that("The list of Lexies is available", {
  lexies <- listLexies(metamot_id)
  # must return ok
  expect_equal(lexies$status, "ok")
})

# # simulatedLexies <- listSimulatedLexies(metamot_id,lexie_id)
# test_that("The list of Simulated Lexies is available", {
#   lexies <- listLexies(metamot_id)
#   # must return ok
#   expect_equal(lexies$status, "ok")
# })
