source("../R/jonahs.R")

#' Report the product name
#' 
#' This function returns the product name of a json from product() function
#' 
#' @param item The output of a specific product() call 
#'
#' @return A string with the product name
#' @export
#' @examples
#' prod_name(product("cookie"))
#' prod_name(cookie) # where cookie is saved variable from product() call
prod_name <- function(item){
  return(item[["product"]][["product_name"]])
}


#' Report the amount of sugar in product per 100g
#'
#' @param item The output of a specific product() call
#'
#' @return A 'double' with amount of sugar
#' @export
#' @examples
#' sugar_per_100g(product("cookie"))
#' sugar_per_100g(cookie) # where cookie is saved variable from product() call
sugar_per_100g <- function(item){
  return(item[["product"]][["nutriments"]][["sugars_100g"]])
}


#' Report the food group product is in
#'
#' @param item The output of a specific product() call
#'
#' @return A string with the group
#' @export
#' @examples
#' food_group(product("cookie"))
#' food_group(cookie) # where cookie is saved variable from product() call
food_group <- function(item){
  strsplit(item[["product"]][["food_groups"]], ":")[[1]][2]
}


#' Bar Plot of the amount of sugar in a list of products
#'
#' @param prod_list A list of pre-defined products
#'
#' @return The plot of product names vs amount of sugar
#' @export
#' @examples
#' plot_sugar(list(cookie, apple)) # where cookie and apple are saved variables from product() calls
#' plot_sugar(list(product("cookie"), product("apple")))
plot_sugar <- function(prod_list){
  require(ggplot2)
  name_list <- lapply(prod_list, prod_name)
  sugar_list <- lapply(prod_list, sugar_per_100g)
  group_list <- lapply(prod_list, food_group)
  df <- data.frame(unlist(name_list), unlist(sugar_list), unlist(group_list))
  names(df) <- c("Product", "Sugar", "Group")
  s.plot <- ggplot(df, aes(x = Sugar, y= reorder(Product, -Sugar), fill = Group)) + geom_col() +
    scale_y_discrete(labels = function(y) lapply(strwrap(y, 
                                                         width = 10, 
                                                         simplify = FALSE), 
                                                 paste, collapse="\n")) +
    labs(y = "Product Name", x = "Sugar (per 100 g)")
  return(s.plot)
}
