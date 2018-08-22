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

  info <- metamots$data[[2]]
  metamot_id <- info$mid

  lexies <- listLexies(metamot_id)
  lexie_id <- lexies$name[2]

  model <- listSimulatedLexies(metamot_id,lexie_id)

  url <- "https://frenchthrowdown.com"
  scores <- scoreLexies(model, url)

  library(formattable)
  percent(scores)

}



