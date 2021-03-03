#' HOBO summary
#'
#' @param df 
#' @param var 
#' @param ... 
#'
#' @return
#' @export
#'
#' @examples
summary_raw_hobo <- function(df, var, ...) {
  snow_months <- c(1:5, 9:12)
  
  var <- dplyr::enquo(var)
  
  df %>% 
    dplyr::group_by(...) %>% 
    dplyr::summarise(min = min(!!var),
                     max = max(!!var),
                     mean = mean(!!var)) %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(range = max - min, 
                  snow_prob = dplyr::if_else((month %in% snow_months) & min < 0,
                                             "could_be_snow", NA_character_))
}
