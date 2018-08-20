#' Requests a token for API usage
#'
#' @details
#'
#' ResCode
#' 401 : Unauthorized : user or password does not match.
#' 406 : Request and response must be application/json
#'
#' @examples
#' \dontrun{
#' createToken()
#' }
#' @return "ok" or "error" your token is valid for 2 hours and stored in local
#' @author Vincent Terrasi
#' @export
createToken <- function() {

  path <- getwd()
  # if test
  path <- gsub("/tests/testthat","",path, fixed=TRUE)
  path <- paste0(path,"/sme_configuration.txt")

  if(!file.exists(path)){

    print("Please, set your API Key in the file sme_configuration.txt")

    fileConn<-file(path)
    writeLines(c("user = ","pass = ","debug = FALSE"), fileConn)
    close(fileConn)

    return("error")
  }

  tab <- read.delim(path, header=FALSE, sep="=", stringsAsFactors = FALSE, strip.white=FALSE)

  if (!exists("tab")) {

    print("Please, set your API Key in the file sme_configuration.txt")

    fileConn<-file(path)
    writeLines(c("user = ","pass = ","debug = FALSE"), fileConn)
    close(fileConn)

    return("error")
  }

  user <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", tab[1,2])
  pass <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", tab[2,2])

  debug <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", tab[3,2])
  if ( debug=="TRUE" )
    options(sme_debug = TRUE)
  else
    options(sme_debug = FALSE)

  curl <- getCurlHandle()
  bearer <- openssl::base64_encode(paste0(user,":",pass))
  rm(pass)

  curlSetOpt(curl = curl, cookiejar = 'cookies.txt',
           ssl.verifyhost = FALSE, ssl.verifypeer = FALSE,
           followlocation = TRUE, verbose = FALSE)

  hdr  <- c("Content-Type"="application/json"
          ,Authorization= paste("Basic",bearer)
  )

  tokenURL <- "https://self.cocon.se/API/token"
  params <- list(data='["cocon.all"]')

  reply <- postForm(tokenURL,
                  .opts=list(httpheader=hdr),
                  .params = params,
                  curl = curl,
                  style = "POST")

  info <- getCurlInfo(curl)

  if (info$response.code==201) {
    # return ok if response.code==201
    res <- fromJSON(reply[1])
    token <- res$token
    options(sme_token = token)
    return("ok")
  } else {
    # return error if response.code!=200
    print(reply)
    return("error")
  }

}
