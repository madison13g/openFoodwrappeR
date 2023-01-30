source("R/jonahs.R")

# my default products, from jonah's function (below)
celebration <-product("celebration", country = "CA", num = 2)
chip_ahoy <- product("chip ahoy", num = 2)
banani <- product("banana", num = 1)

# my new functions

#' Report the product name
#' 
#' This function returns the product name of a json from product() function
#' 
#' @param item The output of a specific product() call 
#'
#' @return A string with the product name
#' @export
#' @examples
prod_name <- function(item){
  return(item[["product"]][["product_name"]])
}


sugar_per_100g <- function(item){
  return(item[["product"]][["nutriments"]][["sugars_100g"]])
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

