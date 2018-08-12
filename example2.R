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

  url <- "https://fr.wikipedia.org/wiki/CrossFit"
  metamot_id <- 2
  lexie_id <- "crossfit france"
  model <- listSimulatedLexies(metamot_id,lexie_id)

  model2 <- scoreLexies(model, lexie_id, url)

  #TODO : compare with text
  #50% : present
  #25%
  nblexiesOK  <- sum(model2$foundLexies >0, na.rm=TRUE)
  nblexiesNOK <- sum(model2$foundLexies==0, na.rm=TRUE)

  nblexiesOKperfect <- sum(model2$foundLexies >0 & model2$foundLexies == model2$countPerfect, na.rm=TRUE)
  nblexiesOKtoomuch <- sum(model2$foundLexies >0 & model2$foundLexies >= model2$countPerfect, na.rm=TRUE)
  nblexiesOKtoofew  <- sum(model2$foundLexies >0 & model2$foundLexies <= model2$countPerfect, na.rm=TRUE)

}



