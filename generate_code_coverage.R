#run this file to generate code coverage
library('covr')

setwd('./unittesting')
report(file_coverage(c("../R/calls.R", "../R/rickys.R", "../R/madisonR.R"), c("./tests_jonah.R","./tests_ricky.R", "./tests_madison.R")), file="../code_coverage.html", browse=FALSE)
#report(file_coverage(c("./R/calls.R"), c("./unittesting/tests_jonah.R","./unittesting/tests_ricky.R", "./unittesting/tests_madison.R")), file="code_coverage.html", browse=FALSE)
