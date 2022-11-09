#' Standardize and model numeric vectors
#'
#' Standardizes two numeric vectors and inputs the two vectors into a linear model. Particularly useful for obtaining the standardized regression coefficient of the predictor.
#'
#' @param criterion the variable to be predicted; a numeric vector (note: I named this argument 'criterion' because it will be the criterion in the linear model that this function creates)
#' @param predictor the variable doing the predicting; a numeric vector (note: I named this argument 'predictor' because it will be the predictor in the linear model that this function creates)
#' @param remove_na this is a logical that evaluates to TRUE or FALSE which will indicate if you want NA values to be removed from the analysis (I used the name remove_na because when set to TRUE, NA values will be removed so the name of the argument is self-explanatory)
#' @param ... this enables additional arguments to be passed to other functions within the function (I used the name ... because that is standard practice for the ellipsis argument)
#'
#' @return this function outputs the summary of a linear model consisting of standardized criterion and predictor variables. Note that the criterion variable will appear as 'a' and the predictor variable will appear as 'b' in the summary output.
#' @export
#'
#' @examples
#' standardize_and_model(criterion = gapminder$lifeExp, predictor = gapminder$gdpPercap) #using our new function, setting the criterion to lifeExp and predictor to gdpPercap to see if gdpPercap predicts lifeExp and obtain standardized regression coefficient etc
#' standardize_and_model(criterion = penguins$body_mass_g, predictor = penguins$flipper_length_mm) #using our new function by setting criterion to body_mass_g and predictor to flipper_length_mm to see if flipper length predicts body mass and obtain standardized regression coefficient etc
#' standardize_and_model(criterion = mtcars$mpg, predictor = mtcars$cyl) #using our new function, setting criterion to mpg and predictor to cyl to see if number of cylinders predicts miles per gallon and obtain standardized regression coefficient etc
standardize_and_model <- function(criterion, predictor, remove_na = TRUE, ...) { #creates function
  #Ensures criterion is numeric
  if(!is.numeric(criterion)) {
    stop("Sorry bud, your criterion is not numeric, it's a ", class(criterion))
  }
  #Ensures predictor is numeric
  if(!is.numeric(predictor)) {
    stop("Easy there, your predictor is not numeric, it's a ", class(predictor))
  }
  #Standardizes criterion and stores it as 'a'
  a <- (criterion - mean(criterion, na.rm = remove_na, ...))/sd(criterion, na.rm = remove_na)
  #Standardizes predictor and stores it as 'b'
  b <- (predictor - mean(predictor, na.rm = remove_na, ...))/sd(predictor, na.rm = remove_na)

  #Takes standardized variables and inputs into model object called c in which standardized criterion is being predicted by standardized predictor

  c <- lm(a ~ b)

  #Returns a summary of the model object

  return(summary(c))
}
