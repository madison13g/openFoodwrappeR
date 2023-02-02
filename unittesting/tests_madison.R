
#troubleshooting unit testing
library('testthat')

#importing function(s) to test

#test test

test_that("quick test check", {
		expect_equal(13.0, 13)
		expect_identical(13, 13)
		expect_equal(1+2,3)
	}
)