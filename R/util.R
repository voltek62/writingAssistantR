#' extractText
#'
#' @details
#'
#' @examples
#' \dontrun{
#' extractText("https//www.wikipedia.com",2O,filter=FALSE)
#' extractText("https//www.wikipedia.com",2O,filter=TRUE)
#' }
#' @return A character with the main text
#' @author Vincent Terrasi
#' @export
extractText <- function(url, minchar, filter=FALSE) {

  # download html
  status <- tryCatch(
    html <- getURL(url, followlocation = TRUE, ssl.verifypeer=FALSE, useragent="R")
    ,error = function(e) e
  )
  if(inherits(status,  "error")) {
    print(paste0("error url ",url))
    return("error")
  }
  # parse html
  doc = htmlParse(html, asText=TRUE)

  if (filter==FALSE) {
    plain.text <- xpathSApply(doc, paste0("//body//text()[not(ancestor::select)][not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)][string-length(.) > ",minchar,"]"), xmlValue)
  } else {
    plain.text <- xpathSApply(doc, paste0("//body//text()[normalize-space()][not(ancestor::select)][not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)][not(ancestor::*[contains(@id,\"footer\")])][not(ancestor::*[contains(@id,\"sidebar\")])][not(ancestor::*[contains(@id,\"comment\")])][string-length(.) > ",minchar,"]"), xmlValue)
    #plain.text <- xpathSApply(doc, "//body//text()[normalize-space() and not(ancestor::noscript | ancestor::script | ancestor::style | ancestor::form | ancestor::*[contains(@id,\"footer\")] | ancestor::*[contains(@id,\"sidebar\")] | ancestor::*[contains(@id,\"comment\")][string-length(.) > 25]", xmlValue)
  }

  txt <- paste(plain.text, collapse = " ")

  return(txt)
}

#' unAccent()
#'
#' @details
#'
#' @examples
#' \dontrun{
#' unAccent(text)
#' }
#' @return a text without accents
#' @author Vincent Terrasi
#' @export
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

#' count each expression in a text
#'
#' @details
#'
#' @examples
#' \dontrun{
#' df <- countExpression(text,searchword)
#' }
#' @return Number of expression
#' @author Vincent Terrasi
#' @export
countExpression <- function(text, searchword){
  text <- str_to_lower(unAccent(text))
  searchword <- str_to_lower(unAccent(searchword))
  kw_in_text <- str_count(text, paste(searchword, collapse='|'))
  return(kw_in_text)
}
