
# COVID19top4                 <img src="https://spectrum.ieee.org/image/MzYwMTY5Mw.jpeg" width="150" height="150" align ="right">
<!-- badges: start -->
[![R build status](https://github.com/etc5523-2020/r-package-assessment-Varsha-Ujjinni-VijayKumar/workflows/R-CMD-check/badge.svg)](https://github.com/etc5523-2020/r-package-assessment-Varsha-Ujjinni-VijayKumar/actions)
<!-- badges: end -->

The goal of _COVID19top4_ is to launch a shiny application for the coronavirus dashboard which shows the visualizations and analysis for the top 4 COVID affected countries as of October 2020. It contains functions which help launch the application and some UI and server functions for the user to use. There are a couple of datasets for the user to use within the package which also was used for the analysis and visualizations of the shiny app.

## Installation

You can install the  _COVID19top4_ with:

``` r
devtools::install_github("https://github.com/etc5523-2020/r-package-assessment-Varsha-Ujjinni-VijayKumar")

```

## Example

This is a basic example which shows you how to solve a common problem:

```{r}
library(COVID19top4)
corona
```

