
<!-- README.md is generated from README.Rmd. Please edit that file -->

# snowpack <a href='https://github.com/PaulESantos/snowpack'><img src='inst/img/gothic_snow.png' align="right" height="200" width="350" /></a>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/snowpack)](https://CRAN.R-project.org/package=snowpack)
[![](http://cranlogs.r-pkg.org/badges/grand-total/snowpack?color=green)](https://cran.r-project.org/package=snowpack)
[![](http://cranlogs.r-pkg.org/badges/snowpack?color=green)](https://cran.r-project.org/package=snowpack)
[![](http://cranlogs.r-pkg.org/badges/last-week/snowpack?color=green)](https://cran.r-project.org/package=snowpack)
<!-- badges: end -->

The goal of snowpack is to …

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
remotes::install_github("PaulESantos/snowpack")
```

## Example

data model:

``` r
library(snowpack)

data("hobo_rmbl_data")
pbm <- hobo_rmbl_data[[2]]
head(pbm)
#>   year month day   longdate       time temperature_f_1 temperature_c_1
#> 1 2010     8   8 2010-08-08 21:46:36.0           56.66            13.7
#> 2 2010     8   8 2010-08-08 22:46:36.0           56.66            13.7
#> 3 2010     8   8 2010-08-08 23:46:36.0           56.66            13.7
#> 4 2010     8   9 2010-08-09 00:46:36.0           56.66            13.7
#> 5 2010     8   9 2010-08-09 01:46:36.0           56.66            13.7
#> 6 2010     8   9 2010-08-09 02:46:36.0           56.66            13.7
#>   temperature_f_2 temperature_c_2 temperature_f_3 temperature_c_3
#> 1           60.80           16.00           553.3          289.61
#> 2           59.42           15.23           553.3          289.61
#> 3           58.04           14.47           553.3          289.61
#> 4           57.35           14.09           553.3          289.61
#> 5           55.97           13.32           553.3          289.61
#> 6           55.28           12.93           553.3          289.61
#>   temperature_f_4 temperature_c_4
#> 1           55.28           12.93
#> 2           54.58           12.55
#> 3           53.89           12.16
#> 4           53.89           12.16
#> 5           53.19           11.77
#> 6           52.49           11.38
```

-   File data review

-   `check_ymd()`:

``` r
pbm %>% 
  check_ymd(month)
#> HOBO data with: 8129 rows.
#> 
#> # A tibble: 12 x 4
#>     year month samples validation  
#>    <int> <int>   <int> <chr>       
#>  1  2010     8     555 missing_data
#>  2  2010     9     720 complete    
#>  3  2010    10     744 complete    
#>  4  2010    11     720 complete    
#>  5  2010    12     744 complete    
#>  6  2011     1     744 complete    
#>  7  2011     2     672 complete    
#>  8  2011     3     744 complete    
#>  9  2011     4     720 complete    
#> 10  2011     5     744 complete    
#> 11  2011     6     720 complete    
#> 12  2011     7     302 missing_data
```

-   `start_end_dates()`

``` r
pbm %>% 
  start_end_dates()
#> HOBO data with: 8129 rows.
#> 
#> # A tibble: 1 x 2
#>   start      end       
#>   <date>     <date>    
#> 1 2010-08-08 2011-07-13

pbm %>% 
  start_end_dates(month)
#> HOBO data with: 8129 rows.
#> 
#> # A tibble: 12 x 3
#>    month start      end       
#>    <int> <date>     <date>    
#>  1     1 2011-01-01 2011-01-31
#>  2     2 2011-02-01 2011-02-28
#>  3     3 2011-03-01 2011-03-31
#>  4     4 2011-04-01 2011-04-30
#>  5     5 2011-05-01 2011-05-31
#>  6     6 2011-06-01 2011-06-30
#>  7     7 2011-07-01 2011-07-13
#>  8     8 2010-08-08 2010-08-31
#>  9     9 2010-09-01 2010-09-30
#> 10    10 2010-10-01 2010-10-31
#> 11    11 2010-11-01 2010-11-30
#> 12    12 2010-12-01 2010-12-31
```

-   Bouild `HOBO snow` object:

-   `hobo_sumamry()`

``` r
pbm %>% 
  hobo_summary()
#> # A tibble: 1,360 x 9
#>     year month   day hobolocation  longdate   mean_temp min_temp max_temp  range
#>    <int> <int> <int> <chr>         <date>         <dbl>    <dbl>    <dbl>  <dbl>
#>  1  2010     8     8 temperature_~ 2010-08-08      13.7     13.7     13.7  0    
#>  2  2010     8     8 temperature_~ 2010-08-08      15.2     14.5     16    1.53 
#>  3  2010     8     8 temperature_~ 2010-08-08     290.     290.     290.   0    
#>  4  2010     8     8 temperature_~ 2010-08-08      12.5     12.2     12.9  0.770
#>  5  2010     8     9 temperature_~ 2010-08-09      14.5     13.3     16    2.68 
#>  6  2010     8     9 temperature_~ 2010-08-09      14.8     11.4     20.2  8.81 
#>  7  2010     8     9 temperature_~ 2010-08-09     290.     290.     290.   0    
#>  8  2010     8     9 temperature_~ 2010-08-09      12.0     10.6     14.5  3.87 
#>  9  2010     8    10 temperature_~ 2010-08-10      14.4     12.9     16    3.07 
#> 10  2010     8    10 temperature_~ 2010-08-10      14.7     10.6     21.0 10.4  
#> # ... with 1,350 more rows
```

\+`snow_pack()`

``` r
pbm %>% 
  hobo_summary() %>% 
  snow_pack("temperature_c_1", range, 5)
#> # A tibble: 213 x 9
#>     year month   day hobolocation   longdate   mean_temp min_temp max_temp range
#>    <int> <int> <int> <chr>          <date>         <dbl>    <dbl>    <dbl> <dbl>
#>  1  2010    10     4 temperature_c~ 2010-10-04      14.9     13.7     15.2 1.53 
#>  2  2010    10     5 temperature_c~ 2010-10-05      14.9     14.1     15.6 1.53 
#>  3  2010    10     6 temperature_c~ 2010-10-06      15.1     14.8     15.2 0.38 
#>  4  2010    10     7 temperature_c~ 2010-10-07      15.2     14.8     15.6 0.770
#>  5  2010    10    12 temperature_c~ 2010-10-12      16.0     15.6     16.4 0.760
#>  6  2010    10    13 temperature_c~ 2010-10-13      15.7     15.2     16.4 1.15 
#>  7  2010    10    14 temperature_c~ 2010-10-14      15.7     14.8     16.4 1.53 
#>  8  2010    10    15 temperature_c~ 2010-10-15      15.7     14.8     16.4 1.53 
#>  9  2010    10    22 temperature_c~ 2010-10-22      15.5     15.2     15.6 0.390
#> 10  2010    10    23 temperature_c~ 2010-10-23      15.6     15.6     15.6 0    
#> # ... with 203 more rows
```

-   `summary_snow_pack()`

``` r
pbm %>% 
   hobo_summary() %>% 
   snow_pack("temperature_c_1", range, 3) %>% 
   summary_snow_pack()
#> # A tibble: 1 x 4
#>   location        start_snow end_snow   n_days  
#>   <chr>           <date>     <date>     <drtn>  
#> 1 temperature_c_1 2010-10-06 2011-05-31 237 days
```
