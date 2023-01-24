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
