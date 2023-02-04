
#troubleshooting unit testing
library('testthat')

#quick basic tests

test_that("quick test check", {
		expect_equal(13.0, 13)
		expect_identical(13, 13)
		expect_equal(1+2,3)
	}
)


#importing function(s) to test
try(source('../R/rickys.R'), silent=TRUE) # Ricky's fns
try(source('../R/calls.R'), silent=TRUE) # Jonah's fns
try(source('../R/madisonR.R'), silent=TRUE) # Madison's fns


#defining stored values for testing
cracker <- product('cracker', num = 2)
apple <- product('apple', num = 2)
cheese <- product('cheese', num = 2)
steak <- product('steak', num = 2)

#defining lists of stored values for testing
l2 <- list(apple, cracker, steak)
l3 <- list(cracker, apple)

# view_allergens function test
test_that("Testing view_allergens function", {
  expect_error(view_allergens(banana))
  expect_error(view_allergens("apple"))
  expect_type(view_allergens(apple), 'list')
}
)

# carbon_footprint function test
test_that("Testing carbon_footprint function", {
  expect_error(carbon_footprint(banana))
  expect_error(carbon_footprint("apple"))
  expect_type(carbon_footprint(cracker), 'double')
}
)

# plot_carbon function test
test_that("Testing plot_carbon function", {
  expect_error(plot_carbon(banana))
  expect_error(plot_carbon("apple"))
  expect_error(plot_carbon(apple))
  expect_type(plot_carbon(l2), 'list')
}
)
