#' Snow pack
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#' This function takes a subset of observations  between a temperature interval
#'
#'
#' @param df `HOBO summary object`
#' @param location The options for this parameter are:
#'                 `temperature_c_1` `temperature_c_2`
#'                 `temperature_c_3` `temperature_c_4`
#'                 some files could have only two sensors for temperature.
#' @param variable The options for this parameter are:
#'                  `mean_temp` `min_temp` `max_temp` `range`
#' @param value this parameter defines the range of temperature variations
#'
#'
#' @return a tibble
#' @export
#'
#' @examples
#' data("hobo_rmbl_data")
#' pbm <- hobo_rmbl_data[[2]]
#'
#' pbm %>%
#' hobo_summary() %>%
#'   snow_pack("temperature_c_4", mean_temp, 5)
snow_pack <- function(df, location, variable, value) {

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

dff <- df %>%
    dplyr::filter(hobolocation == location,
                  {{variable}} >= value1 ,
                  {{variable}} <= value2) %>%
    dplyr::mutate(diff_time = as.numeric(longdate - dplyr::lag(longdate,
                                                               default = longdate[1]))) %>%
    dplyr::filter(diff_time == 1) %>%
    dplyr::mutate(diff_time = as.numeric(longdate - dplyr::lag(longdate,
                                                               default = longdate[1]))) %>%
    dplyr::filter(diff_time == 1) %>%
    dplyr::mutate(diff_time = as.numeric(longdate - dplyr::lag(longdate,
                                                               default = longdate[1]))) %>%
    dplyr::filter(diff_time == 1) %>%
    dplyr::select(-diff_time)

  snow_month <- c(1:5, 9:12)

  dff %>%
    dplyr::filter(month %in% snow_month)
  #message( "Month that out snow time interval ",
  #        paste("month", dplyr::setdiff(dff$month, snow_month)))

}

