### This file interacts with the API to make calls and retrieve data. 
#test function
factorial <- function(n){
  if(n == 0){
    return(1)
  } else{
    return(n * factorial(n - 1))
  }
}


search = function(term){
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
  return(data.frame(titles, prodnums))
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


#url....json?fields=<parameter>
#build_URL = function(country = 'world', filters=''){
#	return(paste0('https://', country, '-en.openfoodfacts.org/api/v0/', '.json'))
#}
