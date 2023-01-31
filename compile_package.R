##when run, this file creates documentation and builds vignettes for the package

devtools::document()

devtools::build_vignettes(
  pkg = ".",
  dependencies = "VignetteBuilder",
  clean = TRUE,
  upgrade = "never",
  quiet = FALSE,
  install = TRUE,
  keep_md = TRUE
)
