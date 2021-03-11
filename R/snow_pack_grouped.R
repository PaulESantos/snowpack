#' Grouped snow pack
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#' this function takes a subset of observations  between a temperature interval
#'
#' @param df `HOBO summary object`
#' @param variable The options for this parameter are:
#'                  `mean_temp` `min_temp` `max_temp` `range`
#' @param value this parameter defines the range of temperature variations
#'
#' @return a tibble
#' @export
#' @examples
#' data("hobo_rmbl_data")
#' road <- hobo_rmbl_data[[1]]
#' road %>%
#'  hobo_summary() %>%
#'  snow_pack_grouped(mean_temp, 2)
snow_pack_grouped <- function(df, variable, value) {

  if(value == 0){
    value1 <- value
  }
  else{
    value1 <- (-1 * value)
  }

  if(value == 0){
    value2 <- value
  }
  else{
    value2 <- value
  }

  #colname <- dplyr::enquo(variable)

  dff <- df %>%
    dplyr::filter({{variable}} >= value1 ,
                  {{variable}} <= value2) %>%
    dplyr::group_by(hobolocation) %>%
    dplyr::mutate(diff_time = as.numeric(longdate - dplyr::lag(longdate,
                                                               default = longdate[1]))) %>%
    dplyr::filter(diff_time == 1) %>%
    dplyr::mutate(diff_time = as.numeric(longdate - dplyr::lag(longdate,
                                                               default = longdate[1]))) %>%
    dplyr::filter(diff_time == 1) %>%
    #dplyr::ungroup() %>%
    dplyr::select(-diff_time)

  snow_month <- c(1:5, 9:12)

  dff %>%
    dplyr::filter(month %in% snow_month) %>%
    dplyr::ungroup()
  #message( "Month that out snow time interval ",
  #        paste("month", dplyr::setdiff(dff$month, snow_month)))

}
