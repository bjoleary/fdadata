
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fdadata

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/bjoleary/fdadata/workflows/R-CMD-check/badge.svg)](https://github.com/bjoleary/fdadata/actions?query=workflow%3AR-CMD-check)
[![codecov](https://codecov.io/gh/bjoleary/fdadata/branch/main/graph/badge.svg?token=1AZQLVTB0B)](https://codecov.io/gh/bjoleary/fdadata)
[![lint](https://github.com/bjoleary/fdadata/workflows/lint/badge.svg)](https://github.com/bjoleary/fdadata/actions?query=workflow%3Alint)
<!-- badges: end -->

The goal of fdadata is to access public information from the [FDA
website](https://www.fda.gov).

## Installation

<!-- You can install the released version of fdadata from [CRAN](https://CRAN.R-project.org) with: -->
<!-- ``` r -->
<!-- install.packages("fdadata") -->
<!-- ``` -->

Install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("bjoleary/fdadata")
```

## Example

Access FDA premarket data:

``` r
library(fdadata)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

fdadata::premarket %>% 
  dplyr::sample_n(5) %>% 
  print()
#> # A tibble: 5 × 30
#>   submissi…¹ sponsor compa…² compa…³ contact addre…⁴ addre…⁵ city  state country
#>   <chr>      <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr> <chr> <chr>  
#> 1 P820056/S… PARAGO… PARAGO… PARAGO… <NA>    947 EA… <NA>    MESA  AZ    USA    
#> 2 K210554    Limaco… LIMACO… LIMACO… Giusep… Via Na… <NA>    Udine <NA>  IT     
#> 3 K823667    WARM &… WARM A… WARM A… <NA>    4221 R… <NA>    Walk… MI    US     
#> 4 P930029/S… MEDTRO… MEDTRO… MEDTRO… <NA>    8200 C… MS MV … MOUN… MN    USA    
#> 5 K872586    INVACA… INVACA… INVACA… JAMES … 899 CL… P.O. B… ELYR… OH    US     
#> # … with 20 more variables: zip_code <chr>, date_start <date>,
#> #   date_decision <date>, decision_code <chr>, panel_code <chr>,
#> #   product_code <chr>, summary <fct>, track <fct>, third_party_review <chr>,
#> #   expedited <fct>, device <chr>, type <chr>, panel <fct>, decision <fct>,
#> #   decision_category <fct>, date_federal_register <date>, generic_name <chr>,
#> #   reason <chr>, docket_number <chr>, approval_order_statement <chr>, and
#> #   abbreviated variable names ¹​submission_number, ²​company_clean, …
```

Additional datasets include `fdadata::reglist`, `fdadata::pmn` (510(k)s
and De Novos), `fdadata::pma`, and `fdadata::product_codes`. The
registration and listing data can be joined into a single table using
`fdadata::join_rl(fdadata::reglist)`.

## Notes

This is a hobby project and is built on my own time. It is not from my
employer and it is definitely not endorsed by my employer. For that
matter, it’s not even endorsed by me. (Also, see the license for some
important disclaimers.) The government ethics experts I checked in with
told me that open sourcing a hobby project isn’t a problem though, so
here we go.

They also said it was important that it is not intended for therapeutic
use: So, don’t try to use this to make any health decisions or anything,
okay? I’m not sure how you could, but I’m pretty sure anything you could
come up with along those lines would be a pretty bad idea…
