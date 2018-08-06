getText <- function(url) {

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
  plain.text <- xpathSApply(doc, "//text()[not(ancestor::select)][not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)][string-length(.) > 10]", xmlValue)
  txt <- paste(plain.text, collapse = " ")

  return(txt)
}
