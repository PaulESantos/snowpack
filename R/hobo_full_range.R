#' HOBO summary
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' This function builds a summary of row values. By default
#' temperature measured in Fahrenheit degrees, it's omitted.
#'
#' @param df A data.frame formatted as the example dataset. Review
#'           hobo_rmbl_data to see details.
#'
#' @return a tibble `HOBO` summary object.
#' @export
#'
#' @examples
#' data("hobo_rmbl_data")
#' road <- hobo_rmbl_data[[1]]
#' road %>%
#' hobo_summary()
hobo_summary <- function(df) {
  df %>%
    dplyr::select(-dplyr::contains("f")) %>%
    tidyr::pivot_longer(-c(longdate, month, year, day, time),
                        names_to = "hobolocation",
                        values_to = "temp_c") %>%
    dplyr::group_by(year, month, day, hobolocation, longdate) %>%
    dplyr::summarise(mean_temp = mean(temp_c),
                     min_temp = min(temp_c),
                     max_temp = max(temp_c),
                     .groups = "drop") %>%
    dplyr::ungroup() %>%
    dplyr::mutate(range = max_temp - min_temp,
                  longdate = lubridate::as_date(longdate))
}

