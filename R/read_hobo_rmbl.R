
#' Read HOBO data
#'
#' @param path_file 
#' @param write 
#' @param ... 
#'
#' @return
#' @export
#'
#' @examples
read_hobo_rmbl <- function(path_file, write = FALSE, ...) {
  
  #hobo_names <- c("Date Time", "Temperature (*F) (*1)", "Temperature (*C) (*1)",
  #                "Temperature (*F) (*2)", "Temperature (*C) (*2)", 
  #                "Temperature (*F) (*3)", "Temperature (*C) (*3)",
  #                "Temperature (*F) (*4)", "Temperature (*C) (*4)")
  
  corrected_names <- c("date_time", 
                       "temperature_f_1", "temperature_c_1",
                       "temperature_f_2", "temperature_c_2",
                       "temperature_f_3", "temperature_c_3",
                       "temperature_f_4", "temperature_c_4")
  
  #clean_name <- c("year", "month", "day", "longdate", "time", 
  #                "temperature_f_1", "temperature_c_1",
  #                "temperature_f_2", "temperature_c_2",
  #                "temperature_f_3", "temperature_c_3",
  #                "temperature_f_4", "temperature_c_4")
  
  # Read file
  
  if(grepl(".txt$|.TXT$", path_file) == TRUE){
    df <- data.table::fread(path_file)  
  }
  else if(grepl(".xlsx$", path_file) == TRUE){
    df <- readxl::read_excel(path_file, ...) 
  }
  else if(grepl(".csv$", path_file) == TRUE){
    df <- readr::read_csv(path_file, ...)
  }
  else{
    "The file extension is not accepted."
  }
  
  # Format    
  
  if(grepl(".txt$|.TXT$", path_file) == TRUE & length(names(df)) == 9){
    df1 <- df %>% 
      janitor::clean_names() %>% 
      #purrr::set_names(corrected_names) %>% 
      tidyr::separate(date_time, c("longdate", "time"), sep = " ") %>% 
      dplyr::mutate(longdate = lubridate::mdy(longdate),
                    year = lubridate::year(longdate),
                    month = lubridate::month(longdate),
                    day = lubridate::day(longdate)) %>% 
      dplyr::select(year, month, day, dplyr::everything())
    
  }
  else if(grepl(".xlsx$", path_file) == TRUE){
    df1 <- df %>% 
      janitor::clean_names() %>% 
      tidyr::separate(date_time, c("longdate", "time"), sep = " ") %>% 
      dplyr::mutate(longdate = lubridate::ymd(longdate),
                    year = lubridate::year(longdate),
                    month = lubridate::month(longdate),
                    day = lubridate::day(longdate)) %>% 
      dplyr::select(year, month, day, dplyr::everything()) %>% 
      data.table::as.data.table()
  }
  else if(grepl(".txt$", path_file) == TRUE & length(names(df)) == 13 ){
    return(df)
  }
  else if(grepl(".txt$|.TXT$", path_file) == TRUE){
    df1 <- df %>% 
      janitor::clean_names() %>% 
      tidyr::separate(date_time, c("longdate", "time"), sep = " ") %>% 
      dplyr::mutate(longdate = lubridate::mdy(longdate),
                    year = lubridate::year(longdate),
                    month = lubridate::month(longdate),
                    day = lubridate::day(longdate)) %>% 
      dplyr::select(year, month, day, dplyr::everything())
  }
  else{
    message("The file doesn't have the expected format.")
  }
  #' Write clean files
  if(write == TRUE){
    file <- gsub(".txt$|.TXT$|.xlsx$|.xls$", "_clean.txt", path_file)
    write.table(df1, file = file, row.names = FALSE)
  }  
  return(df1)
}
