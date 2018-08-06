#' List the lexies and optimum occurence count for an expression of a metamot batch
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
#' status <- listSimulatedLexies(metamot_id,lexie_id)
#' }
#' @return a json with lexies occurences for several text sizes.
#' @author Vincent Terrasi
#' @export
listSimulatedLexies <- function(metamot_id,lexie_id) {
  curl <- getCurlHandle()

  # il faut passer Bearer
  hdr  <- c(Accept="application/json"
            ,Authorization=paste("Bearer",token)
  )

  apiURL <- paste0("https://self.cocon.se/API/metamot/",metamot_id,"/lexies/",lexie_id)

  reply <- getURL(apiURL,
                httpheader = hdr,
                curl = curl,
                verbose = TRUE)

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
