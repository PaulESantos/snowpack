#' Find start and end dates of HOBO data
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' @param df A data.frame formatted as the example dataset. Review
#'           hobo_rmbl_data to see details.
#' @param ... params could be `year`, `momth`, to have deatiled review
#'            of the dates.
#'
#' @return a summary tibble
#' @export
#'
#' @examples
#' data("hobo_rmbl_data")
#' road <- hobo_rmbl_data[[1]]
#' road %>%
#' start_end_dates()
#' road %>%
#' start_end_dates(year)
#' road %>%
#' start_end_dates(year, month)
#'
start_end_dates <- function(df, ...) {
  message(cat("HOBO data with: " %+% crayon::green(nrow(df)) %+% " rows."))
  df %>%
    dplyr::group_by(...) %>%
    dplyr::summarise(start = min(longdate),
              end = max(longdate),
              .groups = "drop")
}

