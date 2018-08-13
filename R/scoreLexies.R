#' scoreLexies
#'
#' @details
#'
#' @examples
#' \dontrun{
#'
#' }
#' @return
#' @author Vincent Terrasi
#' @export
scoreLexies <- function(model, lexie_id, url) {

  txt <- extractText(url, 10, filter=TRUE)
  # remove extra white space between words inside a character vector
  txt <- gsub("\\s+"," ",txt)
  # remove special chars
  txt <- gsub("[][!#$%()*,.:;<=>@^_`|~.{}]", "", txt)

  # compute countPerfect
  nbchar <- nchar(txt)
  model$countPerfect <- round((model$count*nbchar)/3500)

  # search lexies in txt
  model$foundLexies<-0

  for(i in 1:nrow(model)) {
    search <- model[i,1]
    #print()
    model[i,]$foundLexies <- countExpression(txt, search)
  }

  nblexiesOK  <- sum(model$foundLexies >0, na.rm=TRUE)
  nblexiesNOK <- sum(model$foundLexies==0, na.rm=TRUE)

  # count where there are too many or too few lexies
  nblexiesOKtoomuch <- sum(model$foundLexies >0 & model$foundLexies >= model$countPerfect, na.rm=TRUE)
  nblexiesOKtoofew  <- sum(model$foundLexies >0 & model$foundLexies <= model$countPerfect, na.rm=TRUE)

  # get max lexies
  maxlexies <- length(model$lexies)

  # compute max score, we need all lexies
  scoremax <- nblexiesOK/maxlexies

  # compute soseo from scoremax, you lose some percentages if you have not all lexies
  soseo <- scoremax - ((scoremax/2)/maxlexies)*nblexiesOKtoofew

  # compute nseo, you win some percentages if you have got too many repetitions of lexies
  nseo <- nblexiesOKtoomuch/maxlexies

  scores <- data.frame(soseo=soseo, nseo=nseo)

  return(scores)
}
