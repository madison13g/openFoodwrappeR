#We should have a folder named R
# with all the R code, and one folder named tests/testthat
# where all the test scripts will live. 
# For each file with R scripts there should be another one with tests, 
# with the same name, but prefixed by test_

library('testthat')


test_that("learn how to use",{
    expect_identical(3,2) # would fail
})