# Run from the RStudio Console after opening the .Rproj.
source("R/load_data.R")
missing_files <- qsr_missing_files("data")
if (length(missing_files) > 0) {
  cat("Missing required inputs:\n")
  cat(paste0(" - ", missing_files, collapse = "\n"), "\n")
  cat("See data/README.md for where each original file belongs.\n")
} else {
  qsr_data <- load_qsr_data("data")
  print(qsr_data_inventory(qsr_data))
  cat("\nSelected restaurant:\n")
  print(dplyr::distinct(qsr_data$sales, restaurant_id))
  cat("\nDate coverage:\n")
  print(qsr_data$sales |> dplyr::summarise(first_date = min(date), last_date = max(date)))
}
