#' Check a guide
#'
#' @param guideId Id of your guide
#' @param url URL of your webpage
#'
#' @details
#'
#' Rescode
#' 401 : invalid key or ip
#' 429 : Too Many Requests
#'
#' @examples
#' \dontrun{
#' scores <- checkGuide(28183,"http://www.france24.fr")
#' }
#' @return
#' Json with
#'
#' orange, red, blue and green contain for each term to optimize two values: the field start value and the field end value.
#' scores contains the location of each term on the graph defined by the previous fields.
#'
#' score : 100% for a text-optimized to the maximum of the normal range
#' danger : SEO risk score
#'
#' @author Vincent Terrasi
#' @export
checkGuide <- function(guideId, url) {

  token <- getOption('ytg_token')
  debug <- getOption('ytg_debug')
  minword <- 10

  curl <- getCurlHandle()

  apiGuideURL <- paste0("https://yourtext.guru/api/check/",guideId)

  curlSetOpt(curl = curl, cookiejar = 'cookies.txt',
             ssl.verifyhost = FALSE, ssl.verifypeer = FALSE,
             followlocation = TRUE, verbose = debug)

  hdr  <- c(accept="application/json",KEY=token)

  # download html
  html <- getURL(url, followlocation = TRUE)

  # parse html
  doc = htmlParse(html, asText=TRUE)
  plain.text <- xpathSApply(doc, "//text()[not(ancestor::select)][not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)][string-length(.) > 10]", xmlValue)
  txt <- paste(plain.text, collapse = " ")

  txt_noaccent <- URLencode(txt)

  params <- list(content=txt_noaccent)

  # TODO : 5 call per minute
  reply <- postForm(apiGuideURL,
                    .opts=list(httpheader=hdr),
                    .params = params,
                    curl = curl,
                    style = "POST")

  info <- getCurlInfo(curl)

  if (info$response.code==200) {
    # return ok if response.code==200
    res <- fromJSON(reply)
    print(paste0("soseo : ",res$score,"%"))
    print(paste0("dseo : ",res$danger,"%"))
    # add txt
    res$txt <- txt
    print("ok")
  } else {
    # return error if response.code!=200
    print(reply)
    return("error")
  }

  return(res)
}
