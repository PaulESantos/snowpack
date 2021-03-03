#' Review dates
#'
#' @param df
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
check_ymd <- function(df, ...){
  message(paste0("HOBO data with ",  nrow(df), " rows"))
  df %>%
    count(..., name = "samples") %>%
    mutate(validation = if_else(samples %in% c(31*24, 30*24, 28*24, 29*24, 24),
                                "complete", "missing_data"))
}
