#' Standardize and model numeric vectors
#'
#' Standardizes two numeric vectors and inputs the two vectors into a linear model. Particularly useful for obtaining the standardized regression coefficient of the predictor.
#'
#' @param criterion
#' @param predictor
#' @param remove_na
#' @param ...
#'
#' @return this function outputs the summary of a linear model consisting of standardized criterion and predictor variables. Note that the criterion variable will appear as 'a' and the predictor variable will appear as 'b' in the summary output.
#' @export
#'
#' @examples
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
