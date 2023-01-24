### This file interacts with the API to make calls and retrieve data. 
#test function
factorial <- function(n){
  if(n == 0){
    return(1)
  } else{
    return(n * factorial(n - 1))
  }
}


retrieve_countries = function(){
  x = jsonlite::fromJSON(txt='https://static.openfoodfacts.org/data/taxonomies/countries.json')
  y = c()
  for (i in 1:length(x)){
      y = c(y, tolower(x[[i]]$country_code_2$en)) 
  }
  return(y)
}


#build_URL = function(country = 'world'){
#	return(paste0('https://', country, '.openfoodfacts.org/api/v0/', '.json'))
#}
