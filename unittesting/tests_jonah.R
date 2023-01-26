#troubleshooting unit testing
library('testthat')


#importing function(s) to test
try(source('../R/calls.R'), silent=TRUE)
#try(source('./R/calls.R'), silent=TRUE)



#test test
test_that("Factorial of number $n", {
		expect_equal(factorial(5), 120)
		expect_identical(factorial(2), 2)
		expect_equal(factorial(8), 40320)
	}
)


#build_URL test
test_that("O.F.F. API URL for product number: $n", {
  expect_equal(build_URL('12345'), 'https://world-en.openfoodfacts.org/api/v0/product/12345.json')
}
)



#retrieve_countries test
test_that("Is printing of \'countries\' from retrieve_countries successful?", {
  expect_output(retrieve_countries())
}
)


#update_countries test
test_that("Is a dataframe returned from update_countries?", {
  expect_true(is.data.frame(update_countries()))
}
)


#product function test
test_that("Testing product function", {
  expect_error(product(4))
  expect_type(product('eggs'), 'list')
  expect_output(product('eggs'))
}
)



#search_by_name test
test_that("Testing search_by_name function", {
  expect_error(search_by_name(4))
  expect_s3_class(search_by_name('eggs'), 'data.frame')
}
)


#product_by_prodnum test
test_that("Testing product_by_prodnum function", {
  expect_error(product_by_prodnum(4))
  expect_type(product_by_prodnum('80310891'), 'list')
}
)



#check_internet test
test_that("Do we have an internet connection? Expect TRUE.", {
  expect_silent(check_internet())
}
)
