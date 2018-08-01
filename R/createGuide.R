#' Create a guide
#'
#' @param query your query for generating the guide
#' @param lang TODO : fr_fr, en_us, en_gb, es_es, fr_ch, it_it,de_de
#' @param type premium or oneshot
#'
#' @details
#'
#'ResCode
#' 200 : ok
#' 401 : invalid key or ip
#' 429 : Too Many Requests
#' 500 : Erreur interne
#' 531 : no query
#' 532 : no type
#' 533 : no lang
#' 540 : bad fields definition
#' 550 : Not enough tokens on your account
#'
#' @examples
#' \dontrun{
#' guide <- createGuide("expert seo","fr_fr","premium")
#' }
#' @return Json
#' @author Vincent Terrasi
#' @export
createGuide <- function(query, lang, type) {

  #token <- get('token', envir=api)
  #debug <- get('debug', envir=api)
  token <- getOption('ytg_token')
  debug <- getOption('ytg_debug')

  curl <- getCurlHandle()

  apiGuideURL <- "https://yourtext.guru/api/guide/"

  curlSetOpt(curl = curl, cookiejar = 'cookies.txt',
             ssl.verifyhost = FALSE, ssl.verifypeer = FALSE,
             followlocation = TRUE, verbose = debug)

  hdr  <- c(accept="application/json",KEY=token)

  params <- list(query=query, lang=lang, type=type)

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
    print(paste0("guide_id : ",res$guide_id))
    print("ok")
  } else {
    # return error if response.code!=200
    print(reply)
    return("error")
  }

  return(res)
}
