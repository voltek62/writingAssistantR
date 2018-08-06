#' List the lexies of all expressions of a metamot batch
#'
#' @details
#'
#' ResCode
#' 401 : Unauthorized : user or password does not match.
#' 404 : Unknown uid
#' 406 : Request and response must be application/json
#'
#' @examples
#' \dontrun{
#' status <- listLexies(metamot_id)
#' }
#' @return a json with metamot lexies
#' @author Vincent Terrasi
#' @export
listLexies <- function(metamot_id) {

  token <- getOption('sme_token')
  debug <- getOption('sme_debug')

  curl <- getCurlHandle()

  # il faut passer Bearer
  hdr  <- c(Accept="application/json"
            ,Authorization=paste("Bearer",token)
  )

  apiURL <- paste0("https://self.cocon.se/API/metamot/",metamot_id,"/lexies")

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
