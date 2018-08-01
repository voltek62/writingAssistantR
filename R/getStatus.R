#' Get account status (number of tokens spent, remaining tokens, current processing)
#'
#' @details
#'
#' ResCode
#' 200 : Ok
#' 401 : invalid key or ip
#' 429 : Too Many Requests
#' 500 : Internal error
#'
#' @examples
#' \dontrun{
#' status <- getStatus()
#' }
#' @return Json
#' @author Vincent Terrasi
#' @export
getStatus <- function() {

  #token <- get('token', envir=api)
  #debug <- get('debug', envir=api)
  token <- getOption('ytg_token')
  debug <- getOption('ytg_debug')

  curl <- getCurlHandle()

  hdr  <- c(Accept="application/json", KEY=token)

  reply <- getURL("https://yourtext.guru/api/status",
                  httpheader = hdr,
                  curl = curl,
                  verbose = debug)

  info <- getCurlInfo(curl)

  if (info$response.code==200) {
    # return ok if response.code==200
    res <- fromJSON(reply)
    print(paste0("available_tokens : ",res$available_tokens))
    print("ok")
    return("ok")
  } else {
    # return error if response.code!=200
    print(reply)
    return("error")
  }

}
