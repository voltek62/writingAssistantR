
context("api")

test_that("The Token is ok", {
  expect_equal(createToken(), "ok")
})

require(RCurl)
require(rjson)
require(XML)
require(stringr)

test_that("The token is created", {
  # must return ok
  expect_equal(createToken(), "ok")
})

test_that("The status is ok", {
  # must return ok
  expect_equal(checkStatus(), "ok")
})

metamots <- listMetamots()

test_that("The list of Metamots is available", {
  # must return ok
  expect_equal(metamots$status, "ok")
})

info <- metamots$data[[1]]
metamot_id <- info$mid

test_that("The list of Lexies is available, maybe you need to use the website to create your first metamot", {
  lexies <- listLexies(metamot_id)
  # must return ok
  expect_equal(lexies$status, "ok")
})

lexie_id <- lexies$name[1]

test_that("The score is available", {
   url <- "https://fr.wikipedia.org/wiki/Wikip%C3%A9dia:Accueil_principal"
   model <- listSimulatedLexies(metamot_id,lexie_id)
   scores <- scoreLexies(model, lexie_id, url)
   # must return ok
   expect_that( scores$soseo>=0 , is_true() )
})
