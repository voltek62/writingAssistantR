#' Prepare Token for API calls
#'
#' @examples
#' \dontrun{
#' initAPI()
#' }
#' @return ok
#' @author Vincent Terrasi
#' @export
initAPI <- function() {

  path <- getwd()
  # if test
  path <- gsub("/tests/testthat","",path, fixed=TRUE)
  path <- paste0(path,"/ytg_configuration.txt")

  if(!file.exists(path)){

    print("Please, set your API Key in the file ytg_configuration.txt")

    fileConn<-file(path)
    writeLines(c("key = ","debug = FALSE"), fileConn)
    close(fileConn)

    return("error")
  }

  tab <- read.delim(path, header=FALSE, sep="=", stringsAsFactors = FALSE, strip.white=FALSE)

  if (!exists("tab")) {

    print("Please, set your API Key in the file ytg_configuration.txt")

    fileConn<-file(path)
    writeLines(c("key = ","debug = FALSE"), fileConn)
    close(fileConn)

    return("error")
  }

  token <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", tab[1,2])
  options(ytg_token = token)

  debug <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", tab[2,2])
  if ( debug=="TRUE" )
    options(ytg_debug = TRUE)
  else
    options(ytg_debug = FALSE)

  #token <- get('token', envir=api)
  token <- getOption('ytg_token')

  if(nchar(token)<=10) {
    print("Please, set your API Key in the file ytg_configuration.txt")
    return("error")
  }

  return("ok")
}
