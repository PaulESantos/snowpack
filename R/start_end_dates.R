#' Find start and end dates of HOBO data
#'
#'
#' @param df
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
start_end_dates <- function(df, ...) {
  df %>%
    group_by(...) %>%
    summarise(start = min(longdate),
              end = max(longdate))
}

