
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
#> 1 K881437           HICHEM D… HICHEM DIAGN… HICHEM DIAGN… WYNN  … 231 N. PUENTE…
#> 2 K050056           NONIN ME… NONIN MEDICAL NONIN MEDICAL LORI  … 13700 1ST AVE…
#> 3 P850079/S077      COOPERVI… COOPERVISION  COOPERVISION  <NA>    370  WOODCLIF…
#> 4 K874893           KEITHLEY… KEITHLEY INS… KEITHLEY INS… MITCHE… 2875 AURORA R…
#> 5 K895503           MEDICAL … MEDICAL DIAG… MEDICAL DIAG… BICK, … 6020 NICOLLE …
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
