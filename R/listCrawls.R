#' list Crawls
#'
#' @details
#'
#' ResCode
#'
#'
#' @examples
#' \dontrun{
#' crawls <- listCrawl()
#' }
#' @return Json
#' @author Vincent Terrasi
#' @export
listCrawl <- function() {

  hdr  <- c(Accept="application/json"
          ,Authorization=paste("Bearer",token)
  )

  reply <- getURL("https://self.cocon.se/API/crawl",
              header= TRUE,
              headerfunction = h$update,
              httpheader = hdr,
              verbose = TRUE)

  info <- getCurlInfo(curl)

  print(reply)

}


