#run this file to generate code coverage
library('covr')

report(file_coverage(c("./R/calls.R"), c("./unittesting/tests_jonah.R","./unittesting/tests_ricky.R", "./unittesting/tests_madison.R")), file="code_coverage.html", browse=FALSE)
