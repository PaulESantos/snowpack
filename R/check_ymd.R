#' Review the start and end date of `HOBO` data
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#'  Helper function to review if the file takes  the temperature
#'  measurement every hour.
#'
#' @param df A data.frame formatted as the example dataset. Review
#'           hobo_rmbl_data to see details.
#' @param ... Additional variable, month or day. If you like a
#'            detailed review, by default the function check
#'            measurement by year.
#'
#' @return A tibble
#' @importFrom crayon "%+%"
#' @export
#'
#' @examples
#' data("hobo_rmbl_data")
#' road <- hobo_rmbl_data[[1]]
#' road %>%
#' check_ymd()
#' road %>%
#' check_ymd(month)
#' road %>%
#' check_ymd(month, day)
check_ymd <- function(df, ...){
  message(cat("HOBO data with: " %+% crayon::green(nrow(df)) %+% " rows."))
  #message(paste0("HOBO data with ",  nrow(df), " rows"))
  df %>%
    dplyr::count(year, ..., name = "samples") %>%
    dplyr::mutate(validation = dplyr::if_else(samples %in% c(31*24,
                                                             30*24,
                                                             28*24,
                                                             29*24,
                                                             24,
                                                             366*24,
                                                             365*24),
                                "complete", "missing_data"))
}
