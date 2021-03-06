% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/createGuide.R
\name{createGuide}
\alias{createGuide}
\title{Create a guide}
\usage{
createGuide(query, lang, type)
}
\arguments{
\item{query}{your query for generating the guide}

\item{lang}{TODO : fr_fr, en_us, en_gb, es_es, fr_ch, it_it,de_de}

\item{type}{premium or oneshot}
}
\value{
Json
}
\description{
Create a guide
}
\details{
ResCode
200 : ok
401 : invalid key or ip
429 : Too Many Requests
500 : Erreur interne
531 : no query
532 : no type
533 : no lang
540 : bad fields definition
550 : Not enough tokens on your account
}
\examples{
\dontrun{
guide <- createGuide("expert seo","fr_fr","premium")
}
}
\author{
Vincent Terrasi
}
