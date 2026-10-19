# Shared import and validation helpers for the QSR Daily Demand Stage 1 project.
# Source from the project root (the folder containing QSR_Stage1_Project.Rproj).

# The report uses eight source tables. restaurant_profile.csv is retained in the
# instructor-provided bundle but is not needed for the questions selected here.
qsr_input_files <- c(
  sales = "sales_R07.csv",
  restaurants = "restaurants.csv",
  menu_items = "menu_items.csv",
  calendar = "calendar.csv",
  weather = "weather.csv",
  events = "events.csv",
  menu_item_details = "menu_item_details.csv",
  marketing_spend = "marketing_spend.csv"
)

qsr_required_columns <- list(
  sales = c("date", "restaurant_id", "menu_item_id", "quantity", "is_promotion"),
  restaurants = c("restaurant_id", "restaurant_name", "city", "state"),
  menu_items = c("menu_item_id", "menu_item_name", "category", "unit_price"),
  calendar = c("date", "day_of_week", "day_of_week_num", "is_weekend", "month", "year", "is_holiday", "holiday_name"),
  weather = c("city", "date", "avg_temp_f", "precip_inches", "precip_type"),
  events = c("restaurant_id", "date", "is_special_event", "special_event_name"),
  menu_item_details = c("menu_item_id", "food_cost_per_unit", "prep_minutes", "calories", "is_seasonal"),
  marketing_spend = c("restaurant_id", "year", "month", "local_ad_spend_usd", "social_posts")
)

qsr_optional_files <- c(restaurant_profile = "restaurant_profile.csv")

qsr_missing_files <- function(data_dir = "data") {
  paths <- file.path(data_dir, unname(qsr_input_files))
  unname(qsr_input_files[!file.exists(paths)])
}

load_qsr_data <- function(data_dir = "data") {
  missing_files <- qsr_missing_files(data_dir)
  if (length(missing_files) > 0) {
    stop(
      paste0(
        "Required source files are missing from '", data_dir, "':\n- ",
        paste(missing_files, collapse = "\n- "),
        "\n\nCopy the eight Stage 1 input CSVs listed in data/README.md into the data folder.\n",
        "Do not replace them with sample or fabricated data."
      ),
      call. = FALSE
    )
  }

  out <- lapply(unname(qsr_input_files), function(file) {
    readr::read_csv(file.path(data_dir, file), show_col_types = FALSE,
                    na = c("", "NA"), name_repair = "unique")
  })
  names(out) <- names(qsr_input_files)
  validate_qsr_data(out)
  out
}

validate_qsr_data <- function(data) {
  missing_tables <- setdiff(names(qsr_required_columns), names(data))
  if (length(missing_tables) > 0) {
    stop("Data list is missing tables: ", paste(missing_tables, collapse = ", "), call. = FALSE)
  }

  problems <- character()
  for (table_name in names(qsr_required_columns)) {
    absent_cols <- setdiff(qsr_required_columns[[table_name]], names(data[[table_name]]))
    if (length(absent_cols) > 0) {
      problems <- c(problems, paste0(table_name, " is missing columns: ", paste(absent_cols, collapse = ", ")))
    }
  }
  if (length(problems) > 0) {
    stop(paste(problems, collapse = "\n"), call. = FALSE)
  }

  if (anyDuplicated(data$sales[c("date", "menu_item_id")]) > 0) {
    warning("Duplicate date/menu-item combinations were found in sales. Review them before summarizing.", call. = FALSE)
  }
  invisible(data)
}

qsr_data_inventory <- function(data) {
  tibble::tibble(
    table = names(data),
    rows = vapply(data, nrow, integer(1)),
    columns = vapply(data, ncol, integer(1)),
    missing_cells = vapply(data, function(x) sum(is.na(x)), integer(1))
  )
}
