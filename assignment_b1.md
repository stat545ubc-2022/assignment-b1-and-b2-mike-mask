assignment_b1
================
Mike Mask
2022-10-31

-   <a href="#introduction" id="toc-introduction">Introduction</a>
-   <a href="#exercises-1-and-2-function-and-documentation"
    id="toc-exercises-1-and-2-function-and-documentation">Exercises 1 and 2:
    Function and Documentation</a>
-   <a href="#exercise-3-examples" id="toc-exercise-3-examples">Exercise 3:
    Examples</a>
-   <a href="#exercise-4-testing-the-function"
    id="toc-exercise-4-testing-the-function">Exercise 4: Testing the
    Function</a>
-   <a href="#conlusion" id="toc-conlusion">Conlusion</a>

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
    ## ✔ ggplot2 3.3.6      ✔ purrr   0.3.4 
    ## ✔ tibble  3.1.8      ✔ dplyr   1.0.10
    ## ✔ tidyr   1.2.0      ✔ stringr 1.4.1 
    ## ✔ readr   2.1.3      ✔ forcats 0.5.2 
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(testthat)
```

    ## 
    ## Attaching package: 'testthat'
    ## 
    ## The following object is masked from 'package:dplyr':
    ## 
    ##     matches
    ## 
    ## The following object is masked from 'package:purrr':
    ## 
    ##     is_null
    ## 
    ## The following objects are masked from 'package:readr':
    ## 
    ##     edition_get, local_edition
    ## 
    ## The following object is masked from 'package:tidyr':
    ## 
    ##     matches

``` r
library(gapminder)
library(palmerpenguins)
library(ellipsis)
```

# Introduction

This file contains my work for assignment B1 of STAT 545B.

# Exercises 1 and 2: Function and Documentation

``` r
#' Standardize and model numeric vectors
#' 
#' Standardizes two numeric vectors and inputs the two vectors into a linear model. Particularly useful for obtaining the standardized regression coefficient  of the predictor.
#' 
#' @param criterion the variable to be predicted; a numeric vector (note: I named this argument 'criterion' because it will be the criterion in the linear model that this function creates)
#' 
#' @param predictor the variable doing the predicting; a numeric vector (note: I named this argument 'predictor' because it will be the predictor in the linear model that this function creates)
#' 
#' @return this function outputs the summary of a linear model consisting of standardized criterion and predictor variables. Note that the criterion variable will appear as 'a' and the predictor variable will appear as 'b' in the summary output. 



standardize_and_model <- function(criterion, predictor, remove_na = TRUE, ...) { #creates function
  #Ensures criterion is numeric
  if(!is.numeric(criterion)) {
    stop("Sorry bud, your criterion is not numeric, it's a ", class(criterion))
  }
  #Ensures predictor is numeric
  if(!is.numeric(predictor)) {
    stop("Easy there, your predictor is not numeric, it's a ", class(predictor))
  }
  #Standardizes criterion and stores it as a
  a <- (criterion - mean(criterion, na.rm = remove_na, ...))/sd(criterion, na.rm = remove_na)
  #Standardizes predictor and stores it as b
  b <- (predictor - mean(predictor, na.rm = remove_na, ...))/sd(predictor, na.rm = remove_na)
  
  #Takes standardized variables and inputs into model object called c in which standardized criterion is being predicted by standardized predictor
  
  c <- lm(a ~ b)
  
  #Returns a summary of the model object
  
  return(summary(c))
}
```

# Exercise 3: Examples

**Example 1**:

The first example illustrates the use of the function by standardizing
the lifeExp variable as well as the gdpPercap variable from the
`gapminder` dataset.I’ve set the criterion equal to the lifeExp variable
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
head(gapminder) #calling head on gapminder data just to familiarize with the variables and overall data structure
```

    ## # A tibble: 6 × 6
    ##   country     continent  year lifeExp      pop gdpPercap
    ##   <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
    ## 1 Afghanistan Asia       1952    28.8  8425333      779.
    ## 2 Afghanistan Asia       1957    30.3  9240934      821.
    ## 3 Afghanistan Asia       1962    32.0 10267083      853.
    ## 4 Afghanistan Asia       1967    34.0 11537966      836.
    ## 5 Afghanistan Asia       1972    36.1 13079460      740.
    ## 6 Afghanistan Asia       1977    38.4 14880372      786.

``` r
standardize_and_model(criterion = gapminder$lifeExp, predictor = gapminder$gdpPercap) #using our new function, setting the criterion to lifeExp and predictor to gdpPercap to see if gdpPercap predicts lifeExp and obtain standardized regression coefficient etc
```

    ## 
    ## Call:
    ## lm(formula = a ~ b)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -6.4066 -0.6006  0.1685  0.6368  1.4265 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 1.096e-16  1.968e-02    0.00        1    
    ## b           5.837e-01  1.968e-02   29.66   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.8122 on 1702 degrees of freedom
    ## Multiple R-squared:  0.3407, Adjusted R-squared:  0.3403 
    ## F-statistic: 879.6 on 1 and 1702 DF,  p-value: < 2.2e-16

**Example 2**:

The second example illustrates the use of the function by predicting the
body mass in grams (criterion) by the flipper length in mm (predictor)
from the `penguins` dataset. The function standardizes these variables
for us and inputs them into a linear model.The output of the function is
the summary of the linear model of this regression which handily
provides us with useful things to know, including (but not limited to)
the F-test of the overall model, the R-squared value for the model, as
well as the standardized regression coefficient of the predictor
variable and its associated t-test. For example, the standardized
regression coefficient for the predictor (flipper_length_mm) is 0.87.

``` r
head(penguins) #calling head on penguins data just to familiarize with the variables and overall data structure
```

    ## # A tibble: 6 × 8
    ##   species island    bill_length_mm bill_depth_mm flipper_l…¹ body_…² sex    year
    ##   <fct>   <fct>              <dbl>         <dbl>       <int>   <int> <fct> <int>
    ## 1 Adelie  Torgersen           39.1          18.7         181    3750 male   2007
    ## 2 Adelie  Torgersen           39.5          17.4         186    3800 fema…  2007
    ## 3 Adelie  Torgersen           40.3          18           195    3250 fema…  2007
    ## 4 Adelie  Torgersen           NA            NA            NA      NA <NA>   2007
    ## 5 Adelie  Torgersen           36.7          19.3         193    3450 fema…  2007
    ## 6 Adelie  Torgersen           39.3          20.6         190    3650 male   2007
    ## # … with abbreviated variable names ¹​flipper_length_mm, ²​body_mass_g

``` r
standardize_and_model(criterion = penguins$body_mass_g, predictor = penguins$flipper_length_mm) #using our new function by setting criterion to body_mass_g and predictor to flipper_length_mm to see if flipper length predicts body mass and obtain standardized regression coefficient etc
```

    ## 
    ## Call:
    ## lm(formula = a ~ b)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.32027 -0.32330 -0.03352  0.30841  1.60693 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 1.017e-15  2.659e-02    0.00        1    
    ## b           8.712e-01  2.662e-02   32.72   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4916 on 340 degrees of freedom
    ##   (2 observations deleted due to missingness)
    ## Multiple R-squared:  0.759,  Adjusted R-squared:  0.7583 
    ## F-statistic:  1071 on 1 and 340 DF,  p-value: < 2.2e-16

**Example 3**:

The third example illustrates the use of the function by setting the
criterion to miles per gallon and the predictor to number of cylinders
from the `mtcars` dataset. The function standardizes these variables for
us and inputs them into a linear model. The output of the function is
the summary of the linear model of this regression which handily
provides us with useful things to know, including (but not limited to)
the F-test of the overall model, the R-squared value for the model, as
well as the standardized regression coefficient of the predictor
variable and its associated t-test. For example, the standardized
regression coefficient for the predictor, number of cylinders, is -0.85.

``` r
head(mtcars) #calling head on mtcars data just to familiarize with the variables and overall data structure
```

    ##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

``` r
standardize_and_model(criterion = mtcars$mpg, predictor = mtcars$cyl) #using our new function, setting criterion to mpg and predictor to cyl to see if number of cylinders predicts miles per gallon and obtain standardized regression coefficient etc
```

    ## 
    ## Call:
    ## lm(formula = a ~ b)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.82652 -0.35151  0.03679  0.17783  1.24749 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  8.533e-18  9.403e-02    0.00        1    
    ## b           -8.522e-01  9.554e-02   -8.92 6.11e-10 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.5319 on 30 degrees of freedom
    ## Multiple R-squared:  0.7262, Adjusted R-squared:  0.7171 
    ## F-statistic: 79.56 on 1 and 30 DF,  p-value: 6.113e-10

**Example 4**:

The fourth example demonstrates that when the criterion argument is not
numeric (in this case it’s a factor - the country) the function outputs
an informative error message telling us that the criterion is not
numeric, it’s a factor.

``` r
head(gapminder) #calling head on gapminder data just to familiarize with the variables and overall data structure
```

    ## # A tibble: 6 × 6
    ##   country     continent  year lifeExp      pop gdpPercap
    ##   <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
    ## 1 Afghanistan Asia       1952    28.8  8425333      779.
    ## 2 Afghanistan Asia       1957    30.3  9240934      821.
    ## 3 Afghanistan Asia       1962    32.0 10267083      853.
    ## 4 Afghanistan Asia       1967    34.0 11537966      836.
    ## 5 Afghanistan Asia       1972    36.1 13079460      740.
    ## 6 Afghanistan Asia       1977    38.4 14880372      786.

``` r
standardize_and_model(criterion = gapminder$country, predictor = gapminder$lifeExp) #using our new function setting criterion to country and predictor to lifeExp
```

    ## Error in standardize_and_model(criterion = gapminder$country, predictor = gapminder$lifeExp): Sorry bud, your criterion is not numeric, it's a factor

**Example 5**:

The fifth example demonstrates that when the predictor argument is not
numeric (in this case it’s a factor - the country) the function outputs
an informative error message telling us that the predictor is not
numeric, it’s a factor.

``` r
head(gapminder) #calling head on gapminder data just to familiarize with the variables and overall data structure
```

    ## # A tibble: 6 × 6
    ##   country     continent  year lifeExp      pop gdpPercap
    ##   <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
    ## 1 Afghanistan Asia       1952    28.8  8425333      779.
    ## 2 Afghanistan Asia       1957    30.3  9240934      821.
    ## 3 Afghanistan Asia       1962    32.0 10267083      853.
    ## 4 Afghanistan Asia       1967    34.0 11537966      836.
    ## 5 Afghanistan Asia       1972    36.1 13079460      740.
    ## 6 Afghanistan Asia       1977    38.4 14880372      786.

``` r
standardize_and_model(criterion = gapminder$lifeExp, predictor = gapminder$country) #using our new function to predict lifeExp from country
```

    ## Error in standardize_and_model(criterion = gapminder$lifeExp, predictor = gapminder$country): Easy there, your predictor is not numeric, it's a factor

# Exercise 4: Testing the Function

**Test 1**:

This useful test demonstrates that the output of our
standardize_and_model function is in fact a “summary.lm” object (i.e., a
summary of a linear model).

``` r
test_that("standardize_and_model_test_1", {
  expect_is(standardize_and_model(criterion = gapminder$lifeExp, predictor = gapminder$gdpPercap),
            "summary.lm") #tests that the output of our function is a "summary.lm"; tests that what is on the left equals what is on the right
})
```

    ## Test passed 🎊

**Test 2**:

This useful test demonstrates that when the predictor is a factor and
not a numeric vector, the function returns an informative error message
telling the user that their predictor is not numeric, it’s a factor.

``` r
test_that("standardize_and_model_test_2", {
expect_error(standardize_and_model(criterion = gapminder$lifeExp, predictor = gapminder$country), "Easy there, your predictor is not numeric, it's a factor") #tests that when predictor is a factor the function reports an informative error message telling the user that the predictor is not numeric but is a factor
})
```

    ## Test passed 🎊

**Test 3**:

This useful test demonstrates that if we go through the painstaking
process of standardizing our variables by hand and inputting them into a
linear model and calling summary on that model, the result is equal to
the result of our function, showing that the function is correctly
standardizing and inputting the variables into the linear model and
producing the summary in the right way.

``` r
a <- (gapminder$lifeExp - mean(gapminder$lifeExp))/sd(gapminder$lifeExp) #standardizes lifeExp by hand
b <- (gapminder$gdpPercap - mean(gapminder$gdpPercap))/sd(gapminder$gdpPercap) #standardizes gdpPercap by hand

test_that("standardize_and_model_test_3", {
  expect_equal(standardize_and_model(criterion = gapminder$lifeExp, predictor = gapminder$gdpPercap),
                   summary(lm(a ~ b))) #tests that our function output (left) is equal to the output of standardizing and modelling the variables by hand (right)
})
```

    ## Test passed 🎉

# Conlusion

Thanks for reading!

:octocat:
