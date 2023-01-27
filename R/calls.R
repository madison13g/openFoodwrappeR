### This file interacts with the API to make calls and retrieve data. 



#' Search Product by Name
#'
#' This function allows you to express your love of cats.
#' @param term The name of the product to search for.
#' @param country The country code. Searches only for products in the given country.  
#' @export
#' @examples
#' search_by_name()
search_by_name = function(term, country='world'){
  check_internet()
  if (!(is.character(term))){
    stop("\'term\' must be a string!")
  }
  require(httr); require(XML)
  term = gsub(' ', '+', term)
  req = httr::content(httr::GET(paste0('https://', country, '.openfoodfacts.org/cgi/search.pl?search_terms=', term, '&search_simple=1&action=process')), 'parse')
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




#' Check internet.
#'
#' This function verifies that you have an internet connection. For internal use only.
#' @export
#' @examples
#' check_internet()
check_internet = function(){
  if (!curl::has_internet()){
    stop("No internet connection!")
  }
}



####url....json?fields=<parameter>

#' Build URL
#'
#' This function builds the .json product URL.
#' @param prodnum The product number. Passed from product function.
#' @export
#' @examples
#' build_URL()
build_URL = function(prodnum, filters=''){
	return(paste0('https://world-en.openfoodfacts.org/api/v0/product/', prodnum, '.json'))
}




#' Product by Product Number
#'
#' If you already know the product number of the product you want, you can use this function to retrieve the .json.
#' @param prodnum The product number. Passed from product function. 
#' @export
#' @examples
#' product_by_prodnum()
product_by_prodnum = function(prodnum, filters=''){
  check_internet()
  if (!(is.character(prodnum))){
    stop("\'prodnum\' must be a string!")
  }
  url = build_URL(prodnum, filters)
  return(jsonlite::fromJSON(txt=url))
}



#' Get a product.
#'
#' This function retrieves a .json file for a product. 
#' @param term The name of the product to search for.
#' @param chars The number of characters from the product name to print.
#' @param num The product number (1:24) to retrieve. 
#' @param country The country code. Searches only for products in the given country.  
#' @export
#' @examples
#' product()
product = function(term, chars=30, num=NA, country='world'){
  lst = search_by_name(term, country)
  cat("Number", "\t | \t", "Name", "\n")
  cat("-------------------------", "\n")
  for (i in 1:nrow(lst)){
    cat(i, "\t | \t", substr(as.character(lst[i, 1]), 1, chars), " ... \n")
    Sys.sleep(0.1)
  }
  cat("Please select the \'Number\' of the product: \n")
  if(interactive()){
    while (!(num %in% c(1:24))){
      num = readline()
      if (!(num %in% c(1:24))){
        cat("Please enter a number between 1 and 24! \n")
      }
    }
  } else {
    num = 1
  }
  return(product_by_prodnum(as.character(lst[num, 2])))
}




#' Valid countries and their codes.
#'
#' A 2-variable dataframe. The variables are as follows:
#'
#' @format A data frame with 2 variables:
#' \itemize{
#'   \item names: full country name
#'   \item codes: 2-letter country code
#' }
#' @export
countries = data.frame(
  'names' = c("Eritrea", "Estonia", "Russia", "Iceland", "Sao Tomé and Príncipe", 
              "Palau", "Kuwait", "Iraq", "Belarus", "United Arab Emirates", 
              "French Guiana", "Tuvalu", "Luxembourg", "Montserrat", "Puerto Rico", 
              "Réunion", "Yugoslavia", "Benin", "Malawi", "United States", 
              "Åland Islands", "Cyprus", "Burundi", "Argentina", "Myanmar", 
              "Lebanon", "Iran", "Guinea", "Central African Republic", "Belize", 
              "Canada", "Togo", "Republic of the Congo", "Italy", "Croatia", 
              "British Indian Ocean Territory", "Ukraine", "Greece", "Austria", 
              "Cambodia", "South Georgia and the South Sandwich Islands", "Faroe Islands", 
              "Seychelles", "Antarctic", "Dominica", "Malta", "China", "Bhutan", 
              "Maldives", "Gibraltar", "French Polynesia", "Brunei", "Peru", 
              "Syria", "Tanzania", "Slovenia", "Bermuda", "Belgium", "Zimbabwe", 
              "Côte d'Ivoire", "San Marino", "Romania", "New Zealand", "The Bahamas", 
              "Tajikistan", "India", "Solomon Islands", "Laos", "Denmark", 
              "Bolivia", "Vietnam", "Armenia", "Somalia", "Saint Vincent and the Grenadines", 
              "Aruba", "Western Sahara", "Mali", "Isle of Man", "Uzbekistan", 
              "Switzerland", "Rwanda", "State of Palestine", "Serbia", "Cook Islands", 
              "Israel", "Niue", "Botswana", "Nepal", "Jordan", "Portugal", 
              "Djibouti", "Poland", "French Southern and Antarctic Lands", 
              "Cayman Islands", "Saint Helena", "Cuba", "Liechtenstein", "Ethiopia", 
              "Zambia", "Paraguay", "Sudan", "Oman", "Egypt", "Guernsey", "Macau", 
              "Honduras", "Marshall Islands", "Ghana", "Mongolia", "British Virgin Islands", 
              "Gambia", "Senegal", "Indonesia", "Nicaragua", "Saint Kitts and Nevis", 
              "Greenland", "Czech Republic", "Mexico", "Tonga", "Pitcairn", 
              "Norfolk Island", "Bahrain", "Qatar", "Jamaica", "Samoa", "Yemen", 
              "United States Minor Outlying Islands", "United Kingdom", "Uruguay", 
              "Kenya", "Vatican City", "Turks and Caicos Islands", "Turkey", 
              "Cape Verde", "Kosovo", "Tunisia", "Slovakia", "Saint-Barthélemy", 
              "Antigua and Barbuda", "Timor-Leste", "Bulgaria", "Papua New Guinea", 
              "Nauru", "South Korea", "Malaysia", "Hong Kong", "Albania", "France", 
              "Trinidad and Tobago", "Burkina Faso", "World", "Afghanistan", 
              "Anguilla", "Namibia", "Moldova", "Barbados", "Caribbean Netherlands", 
              "Kiribati", "Bangladesh", "Mozambique", "Jersey", "Mayotte", 
              "Wallis and Futuna", "Panama", "Equatorial Guinea", "Guyana", 
              "Guam", "Germany", "Dominican Republic", "Netherlands", "Colombia", 
              "Georgia", "Democratic Republic of the Congo", "Taiwan", "Sri Lanka", 
              "Cocos (Keeling) Islands", "Morocco", "Libya", "Falkland Islands", 
              "Vanuatu", "Saint Pierre and Miquelon", "Northern Mariana Islands", 
              "Sierra Leone", "Finland", "South Africa", "Federated States of Micronesia", 
              "Tokelau", "Thailand", "Norway", "Ireland", "Comoros", "South Sudan", 
              "Australia", "Fiji", "Spain", "Liberia", "Guadeloupe", "Japan", 
              "Guatemala", "Kyrgyzstan", "North Macedonia", "Bosnia and Herzegovina", 
              "El Salvador", "Guinea-Bissau", "Uganda", "Azerbaijan", "Pakistan", 
              "Saint Lucia", "Algeria", "Saudi Arabia", "Ecuador", "Cameroon", 
              "Christmas Island", "Haiti", "Saint Martin", "Lesotho", "Philippines", 
              "Curaçao", "Martinique", "North Korea", "Costa Rica", "Nigeria", 
              "Latvia", "Mauritius", "Lithuania", "Niger", "Bouvet Island", 
              "Sweden", "Turkmenistan", "Virgin Islands of the United States", 
              "Singapore", "Hungary", "Andorra", "Svalbard and Jan Mayen", 
              "New Caledonia", "Swaziland", "Angola", "Chile", "Gabon", "Brazil", 
              "Suriname", "Venezuela", "American Samoa", "Montenegro", "Kazakhstan", 
              "Monaco", "Mauritania", "Grenada", "Chad", "Sint Maarten", "Heard Island and McDonald Islands", 
              "Madagascar"),
  'codes' = c("er", "ee", "ru", "is", "st", "pw", "kw", "iq", "by", "ae", 
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
)


#' Print countries
#'
#' This function prints the available countries as well as their country codes.
#' @export
#' @examples
#' retrieve_countries()
retrieve_countries = function(){
  print(countries)
}




#' Update countries.
#'
#' This function updates the list of available countries using the API. Warning: resulting 'countries' variable is written to the global env.
#' @export
#' @examples
#' update_countries()
update_countries = function(){
  check_internet()
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
  
  if(!(interactive())){
    return(a)
  }
}
