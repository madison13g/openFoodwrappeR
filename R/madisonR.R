# Creating functions document



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
  tryCatch(
    expr = {
      # searches the json for allergen information
      allergens <- item[["product"]][["allergens"]]
      # unlists the list of different allergens and splits on the comma
      l <- unlist(strsplit(allergens, ","))
      # for loop to iterate through the list of allergens to remove the 'en:' part which indicates the language
      lt <- list()
      for (item in l) {
        item <- strsplit(item, ":")[[1]][2]
        # prints each allergen item in list in cleaned format
        lt <- append(lt, item)
    }
      return(lt)
      },
      error = function(e){
        stop('Invalid input: Ensure argument is a product stored value or uses the product function')
      },
      warning = function(w){
        stop('Invalid input: Ensure argument is a product stored value or uses the product function')
      },
      finally = {}
  )
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
  tryCatch(
    expr = {
      # searches the json for carbon footprint information
      cf <- item[["product"]][["carbon_footprint_from_known_ingredients_debug"]]
      # unlists and splits based on the equals column
      l <- unlist(strsplit(cf, "="))
      # creates a new empty list
      new_l <- list()
      # looping over the unlisted item to split on different characters
      for (item in l) {
        # split individual item on the dash to help with formatting, index element 1,1
        item <- strsplit(item, "-")[[1]][1]
        # split individual item again on 'g' to help with formatting, index element 1,1
        item <- strsplit(item, 'g')[[1]][1]
        # removing spaces and replacing with nothing
        item <- gsub(" ","",item)
        # appending the proper formatted carbon footprint value to the new list
        new_l <- append(new_l, item)
      }
      # unlisting the new list
      new_l <- unlist(new_l,recursive=FALSE)
      # removing the first element, formatting issue
      new_l <- new_l[-1]
      # converting the elements (carbon footprint values) to numeric
      new_l <- as.numeric(unlist(new_l))
      # summing all carbon footprint elements from the ingredients and returning it
      return(sum(new_l))
    },
    error = function(e){
      stop('Invalid input: Ensure argument is a product stored value or uses the product function')
    },
    warning = function(w){
      stop('Invalid input: Ensure argument is a product stored value or uses the product function')
    },
    finally = {}
  )
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
  tryCatch(
    expr = {
      # require ggplot2 package 
      require(ggplot2)
      # create a list of names by applying prod_name fn (above) to the list of items inputted
      name_list <- lapply(prod_list, prod_name)
      # create a list of carbon footprint value by applying carbon_footprint fn (above) to list of items inputted
      carbon_list <- lapply(prod_list, carbon_footprint)
      # creating a df of the two lists from above to graph later
      df <- data.frame(unlist(name_list), unlist(carbon_list))
      # adding titles to the df
      names(df) <- c("Product", "Carbon")
      # plotting a bar plot of the total carbon footprint of the products with labels and colours, reordered descending
      plot1 <- ggplot(df, aes(x = Carbon, y = reorder(Product, -Carbon))) + geom_col(fill = 'blue') +
        scale_y_discrete(labels = function(y) lapply(strwrap(y, 
                                                             width = 10, 
                                                             simplify = FALSE), 
                                                     paste, collapse="\n")) +
        labs(y = "Product Name", x = "Carbon (in g)")
      # returning the plot
      return(plot1)
    },
    
    error = function(e){
      stop('Invalid input: Ensure argument is a list of product stored values or uses the product function')
    },
    warning = function(w){
      stop('Invalid input: Ensure argument is a list of product stored values or uses the product function')
    },
    finally = {}
  )
}

