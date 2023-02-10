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
  tryCatch(
    expr = {
      # if product_name json variable doesn't exist, then check for other known variable product_name_en, 
      # other wise prints 'missing english name'
      ifelse(is.null(item[["product"]][["product_name"]]),
             ifelse((is.null(item[["product"]][["product_name_en"]])|
                       is.na(strsplit(item[["product"]][["product_name_en"]], ":")[[1]][2])), 
                    return('Missing English Name'),
                    return(strsplit(item[["product"]][["product_name_en"]], ":")[[1]][2])),
             return(item[["product"]][["product_name"]]))
    },
    error = function(e){
      stop('Invalid Input: Ensure argument is result of valid product() call.')
    },
    warning = function(w){
      stop(w)
    },
    finally = {
    }
  ) 
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
  tryCatch(
    expr = {
      # check if value exists
      ifelse(is.null(item[["product"]][["nutriments"]][["sugars_100g"]]), 
             return(NA),
             return(item[["product"]][["nutriments"]][["sugars_100g"]]))
    },
    error = function(e){
      # only known error results from invalid input
      stop('Invalid Input: Ensure argument is result of valid product() call.')
    },
    warning = function(w){
      stop(w)
    },
    finally = {
    }
  )
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
  tryCatch(
    expr = {
      # checks if a group exists
      ifelse(is.null(item[["product"]][["food_groups"]]), 
             return('No Group'),
             return(strsplit(item[["product"]][["food_groups"]], ":")[[1]][2]))
    },
    error = function(e){
      # only known error results from invalid input
      stop('Invalid Input: Ensure argument is result of valid product() call.')
    },
    warning = function(w){
      stop(w)
    },
    finally = {
    }
  )
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
  tryCatch(
    expr = {
      require(ggplot2)
      # get required graph items using predefined functions
      name_list <- lapply(prod_list, prod_name) 
      sugar_list <- lapply(prod_list, sugar_per_100g) 
      group_list <- lapply(prod_list, food_group) 
      # build dataframe
      df <- data.frame(unlist(name_list), unlist(sugar_list), unlist(group_list))
      names(df) <- c("Product", "Sugar", "Group")
      # remove NAs and inform user
      if (nrow(df[!complete.cases(df), ])!=0){
        message('Items removed from plot due to missing values:')
        print(df[!complete.cases(df), ])
        df <- na.omit(df)
      }
      # build plot
      s.plot <- ggplot(df, aes(x = Sugar, y= reorder(Product, -Sugar), fill = Group)) + geom_col() +
        scale_y_discrete(labels = function(y) lapply(strwrap(y, 
                                                             width = 10, 
                                                             simplify = FALSE), 
                                                     paste, collapse="\n")) +
        labs(y = "Product Name", x = "Sugar (per 100 g)")
      return(s.plot)
    },
    error = function(e){
      # only known error results from invalid input
      stop('Invalid Input: Ensure argument is list of result(s) of valid product() call.')
    },
    warning = function(w){
      stop(w)
    },
    finally = {
    }
  )
}
