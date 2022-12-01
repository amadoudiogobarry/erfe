
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ERFE – Expectile Regression for Fixed Effects

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/erfe)](https://CRAN.R-project.org/package=erfe)
[![Codecov test
coverage](https://codecov.io/gh/amadoudiogobarry/erfe/branch/master/graph/badge.svg)](https://app.codecov.io/gh/amadoudiogobarry/erfe?branch=master)
<!-- badges: end -->

## What is ERFE

**ERFE** is a expectile-based method for panel data. The **ERFE** model
applies the within transformation strategy to solve the incidental
parameter problem and estimates the regressor effects on the expectiles
of the response distribution. The **ERFE** model captures the data
heteroscedasticity and eliminates any bias resulting from the
correlation between the regressors and the omitted factors. When
$\tau=0.5$ the ERFE model estimator corresponds to the fixed-effects
within estimator.

## How to use the ERFE package

The main function of the package is the <code> erfe </code> function and
consists of four arguments. The <code> predictors </code> argument which
corresponds to the design matrix or the matrix of regressors. Note that,
the design matrix should contain time varying regressors only, because
the **ERFE** model do not make inference for time-invariant regressors.
The <code> response </code> argument is the continuous response
variable, and the <code> asymp </code> argument corresponds to the
vector of asymmetric points with default values:
$(0.25, \ 0.5, \ 0.75).$ The <code> id </code> argument corresponds to
the subject ids and should be ordered according to the time or years
variable.

## Installation

You can install the development version of **ERFE** from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("amadoudiogobarry/erfe")
```

## Example

This is a basic example which shows you how to use the main function of
the package:

``` r
library(erfe)
data(sim_panel_data) # Toy dataset
head(sim_panel_data) 
#>   id      pred1     pred2      resp nobs year
#> 1  1  1.9367572  2.386914  4.943895   50    1
#> 2  1  0.1368550  3.731007  4.584137   50    2
#> 3  1  5.8850632  3.600262  8.405295   50    3
#> 4  1  2.5455661  3.416180  6.011400   50    4
#> 5  1 -0.3971390  5.367943  6.237594   50    5
#> 6  2 -0.2610938 -1.326893 -3.258152   50    1

asymp <- c(0.25,0.5,0.75) # sequence of asymmetric points
predictors <- cbind(sim_panel_data$pred1, sim_panel_data$pred2) # design matrix
response <- sim_panel_data$resp # response variable
id <- sim_panel_data$id # ordered subject ids variable
outlist <- erfe(predictors, response, asymp=c(0.25,0.5,0.75), id)
```

For each asymmetric point we have a list of results including the
asymmetric point itself, the estimator and the estimator of its
covariance matrix, and the residuals of the model. For example, the
results of the **ERFE** model for $\tau=0.75$ can be retrieved like
this:

``` r
outlist75 <- outlist[[3]]
# coef estimate
outlist75$coefEst
#>        X1        X2 
#> 0.5995653 0.9585377
# covariance estimate
outlist75$covMat
#> 2 x 2 Matrix of class "dgeMatrix"
#>            [,1]      [,2]
#> [1,] 0.04042441 0.1457498
#> [2,] 0.14574977 0.6555698
```

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>. -->
