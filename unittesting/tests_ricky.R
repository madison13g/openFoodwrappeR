#We should have a folder named R
# with all the R code, and one folder named tests/testthat
# where all the test scripts will live. 
# For each file with R scripts there should be another one with tests, 
# with the same name, but prefixed by test_

library('testthat')

# importing functions
try(source('./R/rickys.R'), silent=TRUE)
# b/c I called jonah's functions with values to make mine work
# this runs through it
# is that a fair way to test, I guess so
# maybe add in product function argument for number if know already
# defaults to none


# prod_name function test
test_that("Testing prod_name function", {
  expect_error(prod_name(strawberry))
  expect_error(prod_name("celebration"))
  expect_type(prod_name(celebration), 'character')
}
)

# sugar_per_100g function test
test_that("Testing sugar_per_100g function", {
  expect_error(sugar_per_100g(strawberry))
  expect_error(sugar_per_100g("celebration"))
  expect_type(sugar_per_100g(celebration), 'double')
}
)

# plot_sugar function test
test_that("Testing plot_sugar function", {
  expect_error(plot_sugar(strawberry))
  expect_error(plot_sugar("celebration"))
  expect_error(plot_sugar(celebration))
  expect_type(plot_sugar(list(banani, celebration, chip_ahoy)), 'list')
}
)
