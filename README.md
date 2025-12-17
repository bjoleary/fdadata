
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fdadata

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/bjoleary/fdadata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/bjoleary/fdadata/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/bjoleary/fdadata/branch/main/graph/badge.svg)](https://app.codecov.io/gh/bjoleary/fdadata?branch=main)
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
#>   submission_number sponsor   company_clean company_group contact address_line_1
#>   <chr>             <chr>     <chr>         <chr>         <chr>   <chr>         
#> 1 K781952           Johnson … JOHNSON AND … JOHNSON AND … <NA>    325 Paramount…
#> 2 K011275           Psycheme… PSYCHEMEDICS  PSYCHEMEDICS  THOMAS… 5832 Uplander…
#> 3 K844350           Newport … NEWPORT MEDI… NEWPORT MEDI… DOUG  … P.O. Box 2600 
#> 4 K851726           Artiberia ARTIBERIA     ARTIBERIA     GIL M … 4518 Los Ranc…
#> 5 P140023/S027      Roche Mo… ROCHE MOLECU… ROCHE         <NA>    4300 Hacienda…
#> # ℹ 24 more variables: address_line_2 <chr>, city <chr>, state <chr>,
#> #   country <chr>, zip_code <chr>, date_start <date>, date_decision <date>,
#> #   decision_code <chr>, panel_code <chr>, product_code <chr>, summary <fct>,
#> #   track <fct>, third_party_review <chr>, expedited <fct>, device <chr>,
#> #   type <chr>, panel <fct>, decision <fct>, decision_category <fct>,
#> #   date_federal_register <date>, generic_name <chr>, reason <chr>,
#> #   docket_number <chr>, approval_order_statement <chr>
```

Additional datasets include `fdadata::pmn` (510(k)s and De Novos),
`fdadata::pma`, and `fdadata::product_codes`.
