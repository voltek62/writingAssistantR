# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'
#   Generate Doc:              roxygen2::roxygenise()
#   Update Package :           update.packages(ask=FALSE)
library(writingAssistantR)
library(RCurl)
library(rjson)
library(XML)
library(stringr)

createToken()

checkStatus()

metamots <- listMetamots()

if (metamots$status=="ok") {

  #get first metamot
  info <- metamots$data[[2]]
  #print(metamot)
  metamot_id <- info$mid

  metamot <- getMetamot(metamot_id)
  expressions <- metamot$data$expressions

  lexies <- listLexies(metamot_id)

  url <- "http://www.wodnews.com"
  metamot_id <- 2
  lexie_id <- "crossfit france"
  model <- listSimulatedLexies(metamot_id,lexie_id)

  model2 <- scoreLexies(model, lexie_id, url)


  #TODO : compare with text
  #50% : present
  #25%
}



