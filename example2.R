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

library(RCurl)
library(rjson)
library(XML)
library(stringr)

createToken()

checkStatus()

metamots <- listMetamots()

if (metamots$status=="ok") {

  #get first metamot
  info <- metamots$data[[1]]
  #print(metamot)
  metamot_id <- info$mid

  metamot <- getMetamot(metamot_id)
  expressions <- metamot$data$expressions

  lexies <- listLexies(metamot_id)

  lexie_id <- "serveur pas cher"
  model <- listSimulatedLexies(metamot_id,lexie_id)

  txt1 <- extractText("https://www.cdiscount.com/informatique/r-serveurs.html", 30, filter=TRUE)
  # remove extra white space between words inside a character vector
  txt2 <- gsub("\\s+"," ",txt1)

  # compute countPerfect
  nbchar <- nchar(txt1)
  model$countPerfect <- round((model$count*nbchar)/3500)

  # search lexies in txt
  model$foundLexies<-0

  for(i in 1:nrow(model)) {
    search <- model[i,1]
    #print()
    model[i,]$foundLexies <- countExpression(txt1, search)
  }

  #TODO : compare with text
  #50% : present
  #25%
}



