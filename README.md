# writingAssistantR

`writingAssistantR` provides an R interface for analysing your text with R, yourtext.guru API
and [cocon.se](http://cocon.se)/[sem-eye.com](http://sem-eye.com/) API

yourtext.guru : A Premium Guide is THE list of the most important words of your content targeting a specific query. No need to make extensive literature search, they reversed engineered search engines algorithms in order to speed up your writing process.

sem-eye.com : Metamots allow you to design an efficient internal netlinking and semantic cocoons. Furthermore, you can make it possible to know if the subject of a page is well formulated.

> See all documentation for YourText.guru on  [data-seo.com](https://data-seo.com/2018/08/03/how-to-use-yourtext-guru-r/) or [data-seo.fr](https://data-seo.fr/2018/08/02/utiliser-yourtext-guru-r/)

> See all documentation for Cocon.se on   
[data-seo.fr](https://data-seo.fr/)

## Install

Github

```r
library(devtools)
install_github("voltek62/writingAssistantR")
```

## How To use with YourText.guru

1. Get your token
https://yourtext.guru/profil/api

This key must be copied to the root of your project in a txt file : ytg_configuration.txt

```r
token=YOURAPIKEY
debug=FALSE
```

2. Create your premium guide
```r
library(writingAssistantR)
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
library(formattable)
percent(scores)
```

## How To use with Cocon.se or Sem-eye

1. Get your token
You need to contact the authors from Cocon.se for having an access.

This key must be copied to the root of your project in a txt file : sme_configuration.txt

```r
user = 
pass = 
debug = FALSE
```

2. Get your lexies
```r
library(writingAssistantR)
library(RCurl)
library(rjson)
library(XML)
library(stringr)

createToken()

checkStatus()

# Get your metamots. It is very important to create directly with the website
metamots <- listMetamots()

# Get your metamot Id
info <- metamots$data[[1]]
metamot_id <- info$mid

# Get all lexies metamot
lexies <- listLexies(metamot_id)
lexie_id <- lexies$name[1]
```


3. Get your scores for one URL
```r
url <- "https://www.lequipe.fr/Ilosport/Fitness/Actualites/Dossier-crossfit-1-2-definition-avantages-risques-et-limites-du-crossfit/778028"

model <- listSimulatedLexies(metamot_id,lexie_id)

scores <- scoreLexies(model, lexie_id, url)

library(formattable)
percent(scores)
```

## Thanks to

* yourText.guru Team and especially Guillaume Peyronnet : https://yourtext.guru
* cocon.se Team and especially Christian Meline & Sylvain Deauré : https://sem-eye.com

