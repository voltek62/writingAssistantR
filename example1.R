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

initAPI()

status <- getStatus()

guide <- createGuide("crossfit","fr_fr","premium")
guide_id <- guide$guide_id

while(getGuide(guide_id)=="error") {
  print("Your guide is currently being created.")
  Sys.sleep(40)
}

#guide_id <- 28134 # crossfit france
print("Your guide is ready")
guide.all <- getGuide(guide_id)

#TODO : check for one URL
#url <- "http://www.wodnews.com"
#scores <- checkGuide(guide_id, url)

#TODO : check for 100 URLs
library(rvest)
library(httr)
library(stringr)
library(dplyr)

query <- URLencode("crossfit france")

page <- paste("https://www.google.fr/search?num=100&espv=2&btnG=Rechercher&q=",query,"&start=0", sep = "")

webpage <- read_html(page)
googleTitle <- html_nodes(webpage, "h3 a")
googleTitleText <- html_text(googleTitle)
#Extract all links
hrefgoogleTitleLink <- html_attr(googleTitle, "href")
googleTitleLink <- str_replace_all(hrefgoogleTitleLink, "/url\\?q=|&sa=(.*)","")

library(dplyr)
DF <- data.frame(Title=googleTitleText, Link=googleTitleLink, score=0, danger = 0, stringsAsFactors = FALSE) %>%
        filter(grepl("http",Link))

for (i in 1:nrow(DF)) {
  link <- DF[i,]$Link

  scores <- checkGuide(guide_id,link)

  if (scores!="error") {
    DF[i,]$score  <- scores$score
    DF[i,]$danger <- scores$danger
  }

  finally = Sys.sleep(60)
}
