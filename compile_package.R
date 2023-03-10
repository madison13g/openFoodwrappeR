##when run, this file creates documentation and builds vignettes for the package

devtools::document()

devtools::build_vignettes(
  pkg = ".",
  dependencies = c("VignetteBuilder", "ggplot2"),
  clean = TRUE,
  upgrade = "never",
  quiet = FALSE,
  install = TRUE,
  keep_md = TRUE
)
