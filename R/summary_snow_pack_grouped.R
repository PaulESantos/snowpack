#' Summarise snow pack grouped
#'
#' @param df `snow_pack_grouped` function output
#' @param by sensor position
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
#' snow_pack_grouped(mean_temp, 2) %>%
#' summary_snow_pack_grouped()
#'
summary_snow_pack_grouped <- function(df, by = hobolocation, date = longdate) {
  df %>%
    dplyr::group_by({{ by }}) %>%
    dplyr::summarise(start_snow = min({{ date }}, na.rm = TRUE),
                     end_snow = max({{ date }}, na.rm = TRUE)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(n_snow_days = end_snow - start_snow)
}
