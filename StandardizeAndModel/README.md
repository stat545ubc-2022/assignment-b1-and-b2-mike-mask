
<!-- README.md is generated from README.Rmd. Please edit that file -->

# StandardizeAndModel

<!-- badges: start -->
<!-- badges: end -->

The goal of StandardizeAndModel is to automatically standardize two
numeric vectors and input the two vectors into a linear model.
Particularly useful for obtaining the standardized regression
coefficient of the predictor.

## Installation

You can install the development version of StandardizeAndModel from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("stat545ubc-2022/assignment-b1-and-b2-mike-mask/StandardizeAndModel")
#> Skipping install of 'StandardizeAndModel' from a github remote, the SHA1 (a7862d9a) has not changed since last install.
#>   Use `force = TRUE` to force installation
```

## Example 1

The first example illustrates the use of the function by standardizing
the lifeExp variable as well as the gdpPercap variable from the
gapminder dataset. I’ve set the criterion equal to the lifeExp variable
and the predictor equal to the gdpPercap variable, which means that our
function will standardize both these variables for us and then input
them into a linear model with the predictor variable (gdpPercap)
predicting the criterion variable (lifeExp). The output of the function
is the summary of the linear model of this regression which handily
provides us with useful things to know, including (but not limited to)
the F-test of the overall model, the R-squared value for the model, as
well as the standardized regression coefficient of the predictor
variable and its associated t-test. For example, the standardized
regression coefficient for the predictor (gdpPercap) is 0.58.

``` r
standardize_and_model(criterion = gapminder$lifeExp, predictor = gapminder$gdpPercap) #using our new function, setting the criterion to lifeExp and predictor to gdpPercap to see if gdpPercap predicts lifeExp and obtain standardized regression coefficient etc
#> 
#> Call:
#> stats::lm(formula = a ~ b)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -6.4066 -0.6006  0.1685  0.6368  1.4265 
#> 
#> Coefficients:
#>              Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 1.096e-16  1.968e-02    0.00        1    
#> b           5.837e-01  1.968e-02   29.66   <2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.8122 on 1702 degrees of freedom
#> Multiple R-squared:  0.3407, Adjusted R-squared:  0.3403 
#> F-statistic: 879.6 on 1 and 1702 DF,  p-value: < 2.2e-16
```

## Example 2

The second example illustrates the use of the function by predicting the
body mass in grams (criterion) by the flipper length in mm (predictor)
from the penguins dataset. The function standardizes these variables for
us and inputs them into a linear model.The output of the function is the
summary of the linear model of this regression which handily provides us
with useful things to know, including (but not limited to) the F-test of
the overall model, the R-squared value for the model, as well as the
standardized regression coefficient of the predictor variable and its
associated t-test. For example, the standardized regression coefficient
for the predictor (flipper_length_mm) is 0.87.

``` r
standardize_and_model(criterion = penguins$body_mass_g, predictor = penguins$flipper_length_mm) #using our new function by setting criterion to body_mass_g and predictor to flipper_length_mm to see if flipper length predicts body mass and obtain standardized regression coefficient etc
#> 
#> Call:
#> stats::lm(formula = a ~ b)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -1.32027 -0.32330 -0.03352  0.30841  1.60693 
#> 
#> Coefficients:
#>              Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 1.017e-15  2.659e-02    0.00        1    
#> b           8.712e-01  2.662e-02   32.72   <2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.4916 on 340 degrees of freedom
#>   (2 observations deleted due to missingness)
#> Multiple R-squared:  0.759,  Adjusted R-squared:  0.7583 
#> F-statistic:  1071 on 1 and 340 DF,  p-value: < 2.2e-16
```

## Example 3

The third example illustrates the use of the function by setting the
criterion to miles per gallon and the predictor to number of cylinders
from the mtcars dataset. The function standardizes these variables for
us and inputs them into a linear model. The output of the function is
the summary of the linear model of this regression which handily
provides us with useful things to know, including (but not limited to)
the F-test of the overall model, the R-squared value for the model, as
well as the standardized regression coefficient of the predictor
variable and its associated t-test. For example, the standardized
regression coefficient for the predictor, number of cylinders, is -0.85.

``` r
standardize_and_model(criterion = mtcars$mpg, predictor = mtcars$cyl) #using our new function, setting criterion to mpg and predictor to cyl to see if number of cylinders predicts miles per gallon and obtain standardized regression coefficient etc
#> 
#> Call:
#> stats::lm(formula = a ~ b)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -0.82652 -0.35151  0.03679  0.17783  1.24749 
#> 
#> Coefficients:
#>               Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  8.533e-18  9.403e-02    0.00        1    
#> b           -8.522e-01  9.554e-02   -8.92 6.11e-10 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.5319 on 30 degrees of freedom
#> Multiple R-squared:  0.7262, Adjusted R-squared:  0.7171 
#> F-statistic: 79.56 on 1 and 30 DF,  p-value: 6.113e-10
```
