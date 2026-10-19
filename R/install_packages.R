# Run from the RStudio Console after opening the project.
# These packages match the data and visualization techniques covered in Weeks 1–5.
required_packages <- c("tidyverse", "scales", "ggrepel", "knitr")
not_installed <- setdiff(required_packages, rownames(installed.packages()))
if (length(not_installed) > 0) {
  install.packages(not_installed, repos = "https://cloud.r-project.org")
}
message("Package check complete.")
