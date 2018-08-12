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

  return(model)
}
