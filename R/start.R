library(httr)
library(jsonlite)

call <- "https://world.openfoodfacts.org"
get_deets <- GET(url = call)

call <- "https://world.openfoodfacts.org/api/2"

call <- "https://world.openfoodfacts.org/data/taxonomies/allergens.json"

str(content(get_deets))
get_text <- content(get_deets, "text", encoding = "UTF-8")

get_json <- fromJSON(get_text, flatten = TRUE)

get_df <- as.data.frame(get_json)
get_json[[1]]

try <- fromJSON("https://world.openfoodfacts.org/data/taxonomies/allergens.json")
class(try)



