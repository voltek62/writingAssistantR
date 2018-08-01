#' Get a guide
#'
#' @param guideId Id of your guide
#'
#' @details
#'
#' ResCode
#' 401 : invalid key or ip
#' 429 : Too Many Requests
#' 500 : Internal error
#' 550 : Error while generating guide.
#' 250 : Guide generation on the way. Please wait a few minutes.
#'
#' @examples
#' \dontrun{
#' guide <- getGuide(0)
#' }
#' @return Json
#' @author Vincent Terrasi
#' @export
getGuide <- function(guideId) {

  token <- getOption('ytg_token')
  debug <- getOption('ytg_debug')

  curl <- getCurlHandle()

  hdr  <- c(Accept="application/json",KEY=token)

  guideAPI <- paste0("https://yourtext.guru/api/guide/",guideId)

  #if (debug) print(guideAPI)

  reply <- getURL(guideAPI,
                httpheader = hdr,
                curl = curl,
                verbose = debug)

  info <- getCurlInfo(curl)

  if (info$response.code==200) {
    # return ok if response.code==200
    res <- fromJSON(reply)
    print("ok")
  } else {
    # return error if response.code!=200
    print(reply)
    return("error")
  }

  return(res)
}
