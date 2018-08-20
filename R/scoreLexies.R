#' Compute a score from your lexies and a specific URL
#'
#' @param model Table with all lexies
#' @param lexie_id Name of your lexie
#' @param url URL of the analysed webpage
#'
#' @details
#'
#'
#' @examples
#' \dontrun{
#'
#' }
#' @return two scores
#' soseo : 100% for a text-optimized to the maximum of the normal range
#' nseo : SEO risk score
#'
#' @author Vincent Terrasi
#' @export
scoreLexies <- function(model, lexie_id, url) {

  txt <- extractText(url, 10, filter=TRUE)
  # remove extra white space between words inside a character vector
  txt <- gsub("\\s+"," ",txt)
  # remove special chars
  txt <- gsub("[][!#$%()*,.:;<=>@^_`|~.{}]", "", txt)
  txt <- gsub("-", " ", txt)

  # compute repartition and count number of words
  nbword <- stringr::str_count(txt)
  model$countPerfect <- round((model$count*nbword)/3500)

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
