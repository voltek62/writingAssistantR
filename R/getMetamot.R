#' List a given metamot batch
#'
#' @details
#' List overview of the given metamot batch
#'
#' ResCode
#' 401 : Unauthorized : user or password does not match.
#' 406 : Request and response must be application/json
#'
#' @examples
#' \dontrun{
#' metamot <- getMetamot(1)
#' }
#' @return a json with metamot details
#' @author Vincent Terrasi
#' @export
getMetamot <- function(metamot_id) {

  token <- getOption('sme_token')
  debug <- getOption('sme_debug')

  curl <- getCurlHandle()

  # il faut passer Bearer
  hdr  <- c(Accept="application/json"
            ,Authorization=paste("Bearer",token)
  )

  apiURL <- paste0("https://self.cocon.se/API/metamot/",metamot_id)

  reply <- getURL(apiURL,
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
