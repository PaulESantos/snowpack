#' Grouped snow pack
#'
#' @param df
#' @param variable
#' @param value
#'
#' @return
#' @export
#'
#' @examples
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

  colname <- dplyr::enquo(variable)

  dff <- df %>%
    dplyr::filter(!!colname >= value1 ,
                  !!colname <= value2) %>%
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
    dplyr::filter(month %in% snow_month)
  #message( "Month that out snow time interval ",
  #        paste("month", dplyr::setdiff(dff$month, snow_month)))

}
