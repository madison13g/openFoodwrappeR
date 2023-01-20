### This file interacts with the API to make calls and retrieve data. 
#test function
factorial <- function(n){
  if(n == 0){
    return(1)
  } else{
    return(n * factorial(n - 1))
  }
}

