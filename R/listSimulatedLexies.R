#' List the lexies and optimum occurence count for an expression of a metamot batch
#'
#' @param metamot_id The batch id
#' @param lexie_id The expression to simulate
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
#' lexies <- listSimulatedLexies(metamot_id,"test")
#' }
#' @return a json with lexies occurences for several text sizes.
#' @author Vincent Terrasi
#' @export
listSimulatedLexies <- function(metamot_id,lexie_id) {

  token <- getOption('sme_token')
  debug <- getOption('sme_debug')

  curl <- getCurlHandle()

  # il faut passer Bearer
  hdr  <- c(Accept="application/json"
            ,Authorization=paste("Bearer",token)
  )

  apiURL <- paste0("https://self.cocon.se/API/metamot/",metamot_id,"/lexies/",lexie_id)

  reply <- getURL(apiURL,
                httpheader = hdr,
                curl = curl,
                verbose = debug)

  info <- getCurlInfo(curl)

  print(info$response.code)

  if (info$response.code==200) {
    res <- fromJSON(reply)
    print("ok")
    return(res)
  } else {
    print("error")
  }
}
