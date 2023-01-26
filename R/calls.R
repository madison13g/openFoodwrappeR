### This file interacts with the API to make calls and retrieve data. 
#test function
factorial <- function(n){
  if(n == 0){
    return(1)
  } else{
    return(n * factorial(n - 1))
  }
}


#' Search Product by Name
#'
#' This function allows you to express your love of cats.
#' @param term The name of the product to search for.
#' @export
#' @examples
#' search_by_name()
search_by_name = function(term){
  require(httr); require(XML)
  req = httr::content(httr::GET(paste0('https://world.openfoodfacts.org/cgi/search.pl?search_terms=', term, '&search_simple=1&action=process')), 'parse')
  resXML = XML::htmlParse(req)
  lst = XML::getNodeSet(resXML, "//*[@class='products']/li")
  titles = c()
  prodnums = c()
  for (i in 1:length(lst)){
   titles = c(titles, gsub(".*<span>|</span>.*", "", XML::toString.XMLNode(lst[[i]])))
   prodnums = c(prodnums, gsub(".*href=\"/product/|/.*", "", XML::toString.XMLNode(lst[[i]])))
  }
  return(data.frame('titles'=as.character(titles), 'prodnums'=as.character(prodnums)))
}



####url....json?fields=<parameter>

#' Build URL
#'
#' This function builds the .json product URL.
#' @param prodnum The product number. Passed from product function. 
#' @export
#' @examples
#' build_URL()
build_URL = function(prodnum, country = 'world', filters=''){
	return(paste0('https://', country, '-en.openfoodfacts.org/api/v0/product/', prodnum, '.json'))
}



#' Get a product.
#'
#' This function retrieves a .json file for a product. 
#' @param term The name of the product to search for.
#' @export
#' @examples
#' product()
product = function(term, chars=30){
  lst = search_by_name(term)
  cat("Number", "\t | \t", "Name", "\n")
  cat("-------------------", "\n")
  for (i in 1:nrow(lst)){
    cat(i, "\t | \t", substr(as.character(lst[i, 1]), 1, chars), " ... \n")
    Sys.sleep(0.15)
  }
  cat("Please select the \'Number\' of the product: \n")
  num = readline()
  url = build_URL(lst[num, 2])
  return(jsonlite::fromJSON(txt=url))
}



countries = c("er", "ee", "ru", "is", "st", "pw", "kw", "iq", "by", "ae", 
              "gf", "tv", "lu", "ms", "pr", "re", "yu", "bj", "mw", "us", "ax", 
              "cy", "bi", "ar", "mm", "lb", "ir", "gn", "cf", "bz", "ca", "tg", 
              "cg", "it", "hr", "io", "ua", "gr", "at", "kh", "gs", "fo", "sc", 
              "aq", "dm", "mt", "cn", "bt", "mv", "gi", "pf", "bn", "pe", "sy", 
              "tz", "si", "bm", "be", "zw", "ci", "sm", "ro", "nz", "bs", "tj", 
              "in", "sb", "la", "dk", "bo", "vn", "am", "so", "vc", "aw", "eh", 
              "ml", "im", "uz", "ch", "rw", "ps", "rs", "ck", "il", "nu", "bw", 
              "np", "jo", "pt", "dj", "pl", "tf", "ky", "sh", "cu", "li", "et", 
              "zm", "py", "sd", "om", "eg", "gg", "mo", "hn", "mh", "gh", "mn", 
              "vg", "gm", "sn", "id", "ni", "kn", "gl", "cz", "mx", "to", "pn", 
              "nf", "bh", "qa", "jm", "ws", "ye", "um", "uk", "uy", "ke", "va", 
              "tc", "tr", "cv", "xk", "tn", "sk", "bl", "ag", "tl", "bg", "pg", 
              "nr", "kr", "my", "hk", "al", "fr", "tt", "bf", "world", "af", 
              "ai", "na", "md", "bb", "bq", "ki", "bd", "mz", "je", "yt", "wf", 
              "pa", "gq", "gy", "gu", "de", "do", "nl", "co", "ge", "cd", "tw", 
              "lk", "cc", "ma", "ly", "fk", "vu", "pm", "mp", "sl", "fi", "za", 
              "fm", "tk", "th", "no", "ie", "km", "ss", "au", "fj", "es", "lr", 
              "gp", "jp", "gt", "kg", "mk", "ba", "sv", "gw", "ug", "az", "pk", 
              "lc", "dz", "sa", "ec", "cm", "cx", "ht", "mf", "ls", "ph", "cw", 
              "mq", "kp", "cr", "ng", "lv", "mu", "lt", "ne", "bv", "se", "tm", 
              "vi", "sg", "hu", "ad", "sj", "nc", "sz", "ao", "cl", "ga", "br", 
              "sr", "ve", "as", "me", "kz", "mc", "mr", "gd", "td", "sx", "hm", 
              "mg")


retrieve_countries = function(){
  print(countries)
}


update_countries = function(){
  x = jsonlite::fromJSON(txt='https://static.openfoodfacts.org/data/taxonomies/countries.json')
  y = c()
  z = c()
  for (i in 1:length(x)){
    if ((!is.null(x[[i]]$country_code_2[[1]])) & (!is.null(x[[i]]$name$en))){
      y = c(y, tolower(x[[i]]$country_code_2[[1]])) 
      z = c(z, x[[i]]$name$en)
    }
  }
  a = data.frame(z, y)
  assign("countries", a, envir = .GlobalEnv)
}
