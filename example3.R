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

txt1 <- getText("http://www.ovh.com/", 25)

#txt2 <- getText("http://www.ovh.com/", 10)

#txt3 <- getText("http://www.ovh.com/", 25, filter=TRUE)

#txt4 <- getText("http://www.ovh.com/", 10, filter=TRUE)

library(ngram)

nb <- wordcount(txt1)

res <- string.summary(txt1, wordlen_max = 10, senlen_max = 10, syllen_max = 10)

ngram <- ngram(txt1, sep=" ")

#print(ngram, output="full")


