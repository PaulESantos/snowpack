#' Snow pack
#'
#' @param df
#' @param location
#' @param variable
#' @param value
#'
#' @return
#' @export
#'
#' @examples
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

  # colname <- dplyr::enquo(variable)

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

