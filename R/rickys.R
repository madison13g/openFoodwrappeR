
# my default products, from jonah's function (below)
celebration <-product("celebration", country = "CA")
chip_ahoy <- product("chip ahoy")
banani <- product("banana")

# my new functions
prod_name <- function(item){
  item[["product"]][["product_name"]]
}

what_ingreds <- function(item){
  unique(item[["product"]][["ingredients"]][["text"]])
}

num_ingreds <- function(item){
  length(what_ingreds(item))
}

sugar_per_100g <- function(item){
  item[["product"]][["nutriments"]][["sugars_100g"]]
}

food_group <- function(item){
  strsplit(item[["product"]][["food_groups"]], ":")[[1]][2]
}

plot_sugar <- function(prod_list){
  require(ggplot2)
  name_list <- lapply(prod_list, prod_name)
  sugar_list <- lapply(prod_list, sugar_per_100g)
  group_list <- lapply(prod_list, food_group)
  df <- data.frame(unlist(name_list), unlist(sugar_list), unlist(group_list))
  names(df) <- c("Product", "Sugar", "Group")
  ggplot(df, aes(x = Sugar, y= reorder(Product, -Sugar), fill = Group)) + geom_col() +
    scale_y_discrete(labels = function(y) lapply(strwrap(y, 
                                                         width = 10, 
                                                         simplify = FALSE), 
                                                 paste, collapse="\n")) +
    labs(y = "Product Name", x = "Sugar (per 100 g)")
}

# testing functions
prod_name(celebration)
what_ingreds(celebration)
num_ingreds(celebration)
sugar_per_100g(chip_ahoy)
plot_sugar(list(banani, celebration, chip_ahoy))


# Jonah's functions
check_internet = function(){
  if (!curl::has_internet()){
    stop("No internet connection!")
  }
}

search_by_name = function(term, country='world'){
  check_internet()
  if (!(is.character(term))){
    stop("\'term\' must be a string!")
  }
  term <- gsub(" ", "+", term)
  require(httr); require(XML)
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

build_URL = function(prodnum, filters=''){
  return(paste0('https://world-en.openfoodfacts.org/api/v0/product/', prodnum, '.json'))
}

product_by_prodnum = function(prodnum, filters=''){
  check_internet()
  if (!(is.character(prodnum))){
    stop("\'prodnum\' must be a string!")
  }
  url = build_URL(prodnum, filters)
  return(jsonlite::fromJSON(txt=url))
}
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
