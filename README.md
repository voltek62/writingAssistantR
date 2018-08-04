# writingAssistantR

`writingAssistantR` provides an R interface for creating easily your premium guides with R and yourtext.guru API

A Premium Guide is THE list of the most important words of your content targeting a specific query. No need to make extensive literature search, they reversed engineered search engines algorithms in order to speed up your writing process.

> See all documentation on [data-seo.com](https://data-seo.com/2018/08/03/how-to-use-yourtext-guru-r/) or [data-seo.fr](https://data-seo.fr/2018/08/02/utiliser-yourtext-guru-r/)

## Install

Github

```r
library(devtools)
install_github("voltek62/writingAssistantR")
```

CRAN version: Waiting...

## How To

1. Get your token
https://yourtext.guru/profil/api

This key must be copied to the root of your project in a txt file : ytg_configuration.txt

```r
token=YOURAPIKEY
debug=FALSE
```

2. Create your premium guide
```r
library(RCurl)
library(rjson)
library(XML)

initAPI()
status <- getStatus()

guide <- createGuide("crossfit","fr_fr","premium")
guide_id <- guide$guide_id

while(getGuide(guide_id)=="error") {
  print("Your guide is currently being created")
  Sys.sleep(40)
}

print("Your guide is ready")
guide.all <- getGuide(guide_id)
```


3. Get your scores for one URL
```r
url <- "http://www.wodnews.com"
scores <- checkGuide(guide_id, url)
```

## Thanks to

* yourText.guru Team and especially Guillaume Peyronnet : https://yourtext.guru

