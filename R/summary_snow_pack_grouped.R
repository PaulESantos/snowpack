#' Summarise snow pack grouped
#'
#' @param data
#' @param by
#' @param date
#'
#' @return
#' @export
#'
#' @examples
summary_snow_pack_grouped <- function(data, by = hobolocation, date = longdate) {
  data %>%
    dplyr::group_by({{ by }}) %>%
    dplyr::summarise(start_snow = min({{ date }}, na.rm = TRUE),
                     end_snow = max({{ date }}, na.rm = TRUE)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(n_snow_days = end_snow - start_snow)
}
