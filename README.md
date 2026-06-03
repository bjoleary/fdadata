
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
#> 1 P020026/S013      Cordis C… CORDIS        CARDINAL      <NA>    6500 Paseo Pa…
#> 2 K875052           I.E.C. C… IEC           IEC           EUGENE… 1450 E. 17th …
#> 3 P020055/S009      Ventana … VENTANA MEDI… VENTANA MEDI… <NA>    1910 E. Innov…
#> 4 K891329           Galaxy I… GALAXY        GALAXY        MING  … P.O. Box 1385 
#> 5 K112876           Cayenne … CAYENNE MEDI… CAYENNE MEDI… KERESH… 16597 N. 92nd…
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
