#' Sends back an empty ok json
#'
#' @details
#'
#' ResCode
#' 401 : Unauthorized : user or password does not match.
#' 406 : Request and response must be application/json
#'
#' @examples
#' \dontrun{
#' status <- checkStatus()
#' }
#' @return "ok" or "error"
#' @author Vincent Terrasi
#' @export
checkStatus <- function() {

  token <- getOption('sme_token')
  debug <- getOption('sme_debug')

  curl <- getCurlHandle()

  hdr  <- c(Accept="application/json"
          ,Authorization=paste("Bearer",token)
  )

  reply <- getURL("https://self.cocon.se/API/status",
              httpheader = hdr,
              curl=curl,
              verbose = debug)

  info <- getCurlInfo(curl)

  if (info$response.code==200) {
    # return ok if response.code==200
    return("ok")
  } else {
    # return error if response.code!=200
    print(reply)
    return("error")
  }

}
