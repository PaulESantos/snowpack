#' HOBO full range
#'
#' @param df 
#'
#' @return
#' @export
#'
#' @examples
hobo_full_range <- function(df) {
  df %>% 
    dplyr::select(-contains("f")) %>% 
    tidyr::pivot_longer(-c(longdate, month, year, day, time),
                        names_to = "hobolocation",
                        values_to = "temp_c") %>% 
    dplyr::group_by(year, month, day, hobolocation, longdate) %>%
    dplyr::summarise(mean_temp = mean(temp_c),
                     min_temp = min(temp_c),
                     max_temp = max(temp_c)) %>%
    dplyr::ungroup() %>% 
    dplyr::mutate(range = max_temp - min_temp,
                  longdate = lubridate::as_date(longdate))
}

