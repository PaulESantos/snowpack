#' Summarise snow pack
#'
#' @param df `snow_pack` function output
#' @param location sensor position
#' @param date date variable column
#'
#' @return A summary tibble with the start and end date of snow
#'          presence, and the number of days.
#' @export
#'
#' @examples
#' data("hobo_rmbl_data")
#' pbm <- hobo_rmbl_data[[2]]
#'
#' pbm %>%
#' hobo_summary() %>%
#' snow_pack("temperature_c_4", mean_temp, 2) %>%
#' summary_snow_pack()
#'
summary_snow_pack <- function(df, location = hobolocation, date = longdate) {
  df %>%
    dplyr::summarise(location = unique({{location}}),
                     start_snow = min({{date}}),
                     end_snow = max({{date}})) %>%
    dplyr::mutate(n_days = (end_snow - start_snow))
}
