
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fdadata

<!-- badges: start -->

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
#>   submission_number sponsor  company_clean  company_group contact address_line_1
#>   <chr>             <chr>    <chr>          <chr>         <chr>   <chr>         
#> 1 P080025/S143      MEDTRON… MEDTRONIC NEU… MEDTRONIC     <NA>    7000 CENTRAL …
#> 2 N970003/S244      Boston … BOSTON SCIENT… BOSTON SCIEN… <NA>    4100 HAMLINE …
#> 3 K990399           ROCHE D… ROCHE DIAGNOS… ROCHE         JENNIF… 9115 HAGUE RD.
#> 4 K865003           A-BEC M… A-BEC MOBILITY A-BEC MOBILI… KEITH … 20460 GRAMERC…
#> 5 K951709           MARDX D… MARDX DIAGNOS… MARDX DIAGNO… ARTHUR… 5919 FARNSWOR…
#> # … with 24 more variables: address_line_2 <chr>, city <chr>, state <chr>,
#> #   country <chr>, zip_code <chr>, date_start <date>, date_decision <date>,
#> #   decision_code <chr>, panel_code <chr>, product_code <chr>, summary <fct>,
#> #   track <fct>, third_party_review <chr>, expedited <fct>, device <chr>,
#> #   type <chr>, panel <fct>, decision <fct>, decision_category <fct>,
#> #   date_federal_register <date>, generic_name <chr>, reason <chr>,
#> #   docket_number <chr>, approval_order_statement <chr>
```
