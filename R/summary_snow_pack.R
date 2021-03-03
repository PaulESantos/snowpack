#' Summarise snow pack
#'
#' @param df
#' @param location
#' @param date
#'
#' @return
#' @export
#'
#' @examples
summary_snow_pack <- function(df, location = hobolocation, date = longdate) {
  df %>%
    dplyr::summarise(location = unique({{location}}),
                     start_snow = min({{date}}),
                     end_snow = max({{date}})) %>%
    dplyr::mutate(n_days = (end_snow - start_snow))
}
