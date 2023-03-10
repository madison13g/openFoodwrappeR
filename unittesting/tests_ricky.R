library('testthat')

# importing functions
try(source('../R/rickys.R'), silent=TRUE)
try(source('../R/calls.R'), silent=TRUE)

#default test values
celebration <-product("celebration", country = "CA", num = 2)
chip_ahoy <- product("chip ahoy", num = 2)
banani <- product("banana", num = 1)
nogroup <- product("Glace Ferrero Rocher Dark", num = 1)

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

# food_group function test
test_that("Testing food_group function", {
  expect_error(food_group(strawberry))
  expect_error(food_group("celebration"))
  expect_type(food_group(celebration), 'character')
  expect_identical(food_group(nogroup), 'No Group')
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

