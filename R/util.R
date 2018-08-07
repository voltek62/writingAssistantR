#' getText()
#'
#' @details
#'
#' @examples
#' \dontrun{
#' getText()
#' }
#' @return Main Text
#' @author Vincent Terrasi
#' @export
getText <- function(url, minchar, filter=FALSE) {

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
