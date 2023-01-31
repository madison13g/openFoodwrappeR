# Creating functions document

### My FN's

#cracker <- product('cracker')
#apple <- product('apple')
#cheese <- product('cheese')
#steak <- product('steak')


#' Convert product json into CSV / Excel
#' 
#' This function converts the product info from json to csv from product() function
#' 
#' @param item The output of a specific product() call 
#'
#' @return 
#' @export A csv with product info
#' @examples
#' to_csv(product("cracker"))
#' to_csv(cracker) # where cracker is saved variable from product() call
to_csv <- function(item){
  l <- item
  df <- as.data.frame(unlist(l), byrow=TRUE,stringsAsFactors=FALSE)
  print(head(df))
  # write.csv(df, "C:\\Users\\Product_Info.csv", row.names=FALSE) #create csv file in users
}




#' View allergens of a product
#' 
#' This function returns a list of allergens from product() function
#' 
#' @param item The output of a specific product() call 
#'
#' @return A list with the product allergens
#' @export
#' @examples
#' view_allergens(product("cracker"))
#' view_allergens(cracker) # where cracker is saved variable from product() call
view_allergens <- function(item){
  allergens <- item[["product"]][["allergens"]]
  l <- unlist(strsplit(allergens, ","))
  for (item in l) {
   item <- strsplit(item, ":")[[1]][2]
    print(item)
  }
}





#' Reports the carbon footprint from the known ingredients
#'
#' @param item The output of a specific product() call
#'
#' @return A 'double' with amount of carbon footprint, in g
#' @export
#' @examples
#' carbon_footprint(product("cracker"))
#' carbon_footprint(cracker) # where cracker is saved variable from product() call
carbon_footprint <- function(item){
  cf <- item[["product"]][["carbon_footprint_from_known_ingredients_debug"]]
  l <- unlist(strsplit(cf, "="))
  new_l <- list()
  for (item in l) {
    item <- strsplit(item, "-")[[1]][1]
    item <- strsplit(item, 'g')[[1]][1]
    item <- gsub(" ","",item)
    new_l <- append(new_l, item)
  }
  new_l <- unlist(new_l,recursive=FALSE)
  new_l <- new_l[-1]
  new_l <- as.numeric(unlist(new_l))
  return(sum(new_l))
}



#' Bar Plot comparing the carbon footprint (in g) of multiple products
#'
#' @param prod_list A list of pre-defined products
#'
#' @return The plot of product names vs carbon footprint
#' @export
#' @examples
#' plot_carbon(list(cracker, apple, cheese, countries)) # saved variables
#' plot_carbon(list(product("cracker"), product("apple")))
plot_carbon <- function(prod_list){
  require(ggplot2)
  name_list <- lapply(prod_list, prod_name)
  carbon_list <- lapply(prod_list, carbon_footprint)
  df <- data.frame(unlist(name_list), unlist(carbon_list))
  names(df) <- c("Product", "Carbon")
  plot1 <- ggplot(df, aes(x = Carbon, y = reorder(Product, -Carbon))) + geom_col(fill = 'blue') +
    scale_y_discrete(labels = function(y) lapply(strwrap(y, 
                                                         width = 10, 
                                                         simplify = FALSE), 
                                                 paste, collapse="\n")) +
    labs(y = "Product Name", x = "Carbon (in g)")
  return(plot1)
}

#l2 <- list(apple, cracker, steak)
#l3 <- list(cracker, apple)
