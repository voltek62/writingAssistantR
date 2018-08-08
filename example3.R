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

txt1 <- getText("http://www.ovh.com/", 10)
#txt4 <- getText("http://www.ovh.com/", 10, filter=TRUE)

library(ngram)
nb <- wordcount(txt1)
res <- string.summary(txt1, wordlen_max = 10, senlen_max = 10, syllen_max = 10)
ngram <- ngram(txt1, sep=" ")
#print(ngram, output="full")

library(stringr)
unAccent <- function(text) {
  encoding <- Encoding(text)
  text <- gsub("['`^~\"]", " ", text)
  if (!grepl("unknown",encoding)) {
    text <- iconv(text, from=encoding, to="ASCII//TRANSLIT//IGNORE")
  } else {
    text <- iconv(text, to="ASCII//TRANSLIT//IGNORE")
  }
  text <- gsub("['`^~\"]", "", text)
  return(text)
}

countExpression <- function(text, searchword){
  text <- str_to_lower(unAccent(text))
  searchword <- str_to_lower(unAccent(searchword))
  kw_in_text <- str_count(text, paste(searchword, collapse='|'))
  return(kw_in_text)
}

countExpression(txt1, "ovh")
countExpression(txt1, "dédié")
countExpression(txt1, "serveur dédié")




