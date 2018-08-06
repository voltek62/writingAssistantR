#' list Metamots
#'
#' @details
#' List all Metamot sets for the user
#'
#' ResCode
#' 401 : Unauthorized : user or password does not match.
#' 406 : Request and response must be application/json
#'
#' @examples
#' \dontrun{
#' metamots <- listMetamots()
#' }
#' @return a json with metamot batch Id, language, expressions and timestamp
#' @author Vincent Terrasi
#' @export
listMetamots <- function() {

  token <- getOption('sme_token')
  debug <- getOption('sme_debug')

  curl <- getCurlHandle()

  hdr  <- c(Accept="application/json"
            ,Authorization=paste("Bearer",token)
  )

  reply <- getURL("https://self.cocon.se/API/metamot",
                httpheader = hdr,
                curl = curl,
                verbose = debug)

  info <- getCurlInfo(curl)

  if (info$response.code==200) {
    res <- fromJSON(reply)
    print("ok")
    return(res)
  } else {
    print("error")
  }
}

